# Fruit Price API - Infrastructure Architecture

This diagram shows the complete Azure infrastructure for the Fruit Price API, including networking, compute, database, and monitoring components.

```mermaid
---
config:
  layout: elk
---
graph TD
    subgraph "Azure Subscription"
        subgraph "Resource Group: fruitpriceapi-rg-environment"
            subgraph "Virtual Network: fruitpriceapi-vnet-environment"
                subgraph "App Subnet: 10.0.1.0/24"
                    APP[App Service<br/>Linux Python 3.11<br/>VNet Integrated<br/>System Managed Identity]
                end

                subgraph "Database Subnet: 10.0.2.0/24"
                    PSQL[PostgreSQL Flexible Server<br/>Version 14<br/>Private DNS Zone<br/>Database: fruitprices]
                end

                subgraph "Gateway Subnet: 10.0.3.0/24"
                    AGW[Application Gateway<br/>Standard v2<br/>HTTP Listener Port 80<br/>Health Probe]
                end
            end

            ASP[App Service Plan<br/>Linux OS<br/>Configurable SKU<br/>Auto-scaling Enabled]
            
            LAW[Log Analytics Workspace<br/>30-day Retention<br/>PerGB2018 SKU]
            
            SA[Storage Account<br/>StorageV2 LRS<br/>Versioning Enabled<br/>Lifecycle Policies]
            
            subgraph "Storage Containers"
                LOGS[application-logs<br/>Private Access]
                BACKUPS[database-backups<br/>Private Access<br/>Cool/Archive Tiers]
            end

            subgraph "Network Security Groups"
                APP_NSG[App NSG<br/>Allow HTTP/HTTPS]
                DB_NSG[Database NSG<br/>Allow PostgreSQL 5432<br/>From App Subnet Only]
                GW_NSG[Gateway NSG<br/>Allow HTTP/HTTPS<br/>Gateway Manager]
            end

            AUTO[Auto-scale Setting<br/>CPU-based Scaling<br/>Scale Up: CPU greater than 70%<br/>Scale Down: CPU less than 30%]

            subgraph "Monitoring Alerts"
                ALERT_CPU[CPU Alert<br/>Threshold: 80%]
                ALERT_RT[Response Time Alert<br/>Threshold: 5s]
                ALERT_HTTP[HTTP 5xx Alert<br/>Threshold: 10 errors]
            end
        end

        subgraph "External/Client"
            CLIENT[API Clients<br/>HTTPS Requests]
        end
    end

    %% Connections
    CLIENT -->|HTTPS| AGW
    AGW -->|Backend Pool| APP
    APP -->|VNet Swift Connection| ASP
    APP -->|PostgreSQL 5432| PSQL
    APP -->|Environment Variables| PSQL
    
    APP_NSG -.->|Protects| APP
    DB_NSG -.->|Protects| PSQL
    GW_NSG -.->|Protects| AGW
    
    AUTO -->|Scales| ASP
    
    APP -->|Diagnostics| LAW
    PSQL -->|Diagnostics| LAW
    AGW -->|Diagnostics| LAW
    
    APP -->|Logs| LOGS
    PSQL -->|Backups| BACKUPS
    
    LOGS -.->|Stored In| SA
    BACKUPS -.->|Stored In| SA
    
    ALERT_CPU -.->|Monitors| APP
    ALERT_RT -.->|Monitors| APP
    ALERT_HTTP -.->|Monitors| APP

    %% Styling
    classDef compute fill:#0078d4,stroke:#ffffff,stroke-width:2px,color:#ffffff
    classDef database fill:#7fba00,stroke:#ffffff,stroke-width:2px,color:#ffffff
    classDef networking fill:#00bcf2,stroke:#ffffff,stroke-width:2px,color:#ffffff
    classDef storage fill:#fcd116,stroke:#333333,stroke-width:2px,color:#333333
    classDef monitoring fill:#ff8c00,stroke:#ffffff,stroke-width:2px,color:#ffffff
    classDef security fill:#ff6b35,stroke:#ffffff,stroke-width:2px,color:#ffffff
    classDef external fill:#68217a,stroke:#ffffff,stroke-width:2px,color:#ffffff

    class APP,ASP compute
    class PSQL database
    class AGW networking
    class SA,LOGS,BACKUPS storage
    class LAW,AUTO,ALERT_CPU,ALERT_RT,ALERT_HTTP monitoring
    class APP_NSG,DB_NSG,GW_NSG security
    class CLIENT external
```

## Architecture Components

### Networking Layer
- **Virtual Network**: Isolated network with configurable address space (default: 10.0.0.0/16)
- **Subnets**: 
  - App Subnet with delegation to Microsoft.Web/serverFarms
  - Database Subnet with delegation to Microsoft.DBforPostgreSQL/flexibleServers
  - Gateway Subnet for Application Gateway
- **Network Security Groups**: Fine-grained security rules for each subnet
- **Service Endpoints**: Microsoft.Sql and Microsoft.Storage for secure access

### Compute Layer
- **App Service Plan**: Linux-based plan with configurable SKU (B1/S1/P1v3)
- **Linux Web App**: Python 3.11 runtime with Flask application
  - VNet integration for private communication
  - System-assigned managed identity
  - Health check endpoint: `/api/fruits/prices`
  - Auto-scaling based on CPU metrics
- **Application Gateway**: Standard_v2 tier with HTTP listener and health probes

### Database Layer
- **PostgreSQL Flexible Server**: Version 14 with VNet integration
  - Private DNS zone for secure connectivity
  - Configurable SKU (B_Standard_B1ms to GP_Standard_D4s_v3)
  - Automated backups with configurable retention (7-30 days)
  - Optional geo-redundant backups for production
- **Database Configuration**: Connection throttling and logging enabled

### Monitoring and Storage Layer
- **Log Analytics Workspace**: Centralized logging with 30-day retention
- **Storage Account**: StorageV2 with LRS replication
  - Application logs container with 7-day retention
  - Database backups container with lifecycle policies (Cool after 30 days, Archive after 90 days, Delete after 365 days)
- **Metric Alerts**: CPU, response time, HTTP errors monitoring

### Security
- **Network Security Groups**: Least-privilege access control
- **Private Endpoints**: Database accessible only from app subnet
- **HTTPS Only**: Enforced for all web traffic
- **Managed Identity**: System-assigned identity for secure Azure service access

## Environment Configuration

The infrastructure supports three environments with different resource sizes:

- **Development**: B1 App Service, B1ms PostgreSQL, 1-2 instances, 7-day backups
- **Staging**: S1 App Service, D2s_v3 PostgreSQL, 2-4 instances, 14-day backups
- **Production**: P1v3 App Service, D4s_v3 PostgreSQL, 3-10 instances, 30-day geo-redundant backups

## Deployment

Deploy the infrastructure using:

```bash
cd fruit_price_api/infra/terraform
terraform init
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
```
