# Fruit Price API Infrastructure

This directory contains Terraform infrastructure as code (IaC) for deploying the Fruit Price API to Azure.

## Architecture Overview

The infrastructure uses a simplified architecture suitable for development environments:

- **Azure Container Registry (ACR)**: Private registry for container images
- **Azure Container Instances (ACI)**: Serverless container hosting
- **Application Insights**: Application monitoring and telemetry
- **Virtual Network**: Network isolation with subnet delegation for ACI
- **Resource Group**: Logical grouping of all Azure resources

For detailed architecture decisions, see [ADR-001](../docs/adr/adr-001-azure-container-instances-dev-environment.md).

## Prerequisites

Before deploying the infrastructure, ensure you have the following tools installed:

### Required Tools

1. **Azure CLI** (version 2.30.0 or higher)
   ```bash
   az --version
   ```
   Install: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

2. **Terraform** (version 1.0 or higher)
   ```bash
   terraform --version
   ```
   Install: https://learn.hashicorp.com/tutorials/terraform/install-cli

3. **Docker** (version 20.10 or higher)
   ```bash
   docker --version
   ```
   Install: https://docs.docker.com/get-docker/

### Azure Subscription

- Active Azure subscription with appropriate permissions
- Contributor or Owner role on the subscription or resource group
- Sufficient quota for the resources being created

## Directory Structure

```
infra/
└── terraform/
    ├── modules/
    │   ├── container/          # Azure Container Registry & Instances
    │   │   ├── main.tf
    │   │   ├── variables.tf
    │   │   └── outputs.tf
    │   └── monitoring/         # Application Insights & Log Analytics
    │       ├── main.tf
    │       ├── variables.tf
    │       └── outputs.tf
    └── environments/
        └── dev/                # Development environment
            ├── main.tf
            ├── variables.tf
            ├── outputs.tf
            └── dev.tfvars
```

## Deployment Instructions

### Step 1: Authenticate with Azure

```bash
# Login to Azure
az login

# Set the subscription (if you have multiple)
az account set --subscription "<subscription-id>"

# Verify the current subscription
az account show
```

### Step 2: Build the Container Image

From the `fruit_price_api` directory:

```bash
# Build the Docker image
docker build -t fruit-price-api:latest .

# Test the image locally (optional)
docker run -p 5000:5000 fruit-price-api:latest
```

### Step 3: Initialize Terraform

Navigate to the dev environment directory:

```bash
cd infra/terraform/environments/dev

# Initialize Terraform (downloads providers and modules)
terraform init
```

### Step 4: Review the Deployment Plan

```bash
# Preview the changes Terraform will make
terraform plan -var-file=dev.tfvars

# Review the output carefully to ensure all resources are correct
```

### Step 5: Deploy the Infrastructure

```bash
# Apply the Terraform configuration
terraform apply -var-file=dev.tfvars

# Type 'yes' when prompted to confirm deployment
```

The deployment typically takes 5-10 minutes.

### Step 6: Push Container Image to ACR

After infrastructure deployment, retrieve ACR credentials and push the image:

```bash
# Get ACR login server (from Terraform outputs)
ACR_LOGIN_SERVER=$(terraform output -raw acr_login_server)

# Login to ACR
az acr login --name $(echo $ACR_LOGIN_SERVER | cut -d'.' -f1)

# Tag the image for ACR
docker tag fruit-price-api:latest $ACR_LOGIN_SERVER/fruit-price-api:latest

# Push the image to ACR
docker push $ACR_LOGIN_SERVER/fruit-price-api:latest
```

### Step 7: Restart Container Instance (if needed)

After pushing a new image, restart the container to use the updated version:

```bash
# Get resource group name
RESOURCE_GROUP=$(terraform output -raw resource_group_name)

# Restart the container group
az container restart --resource-group $RESOURCE_GROUP --name fruit-price-api-dev-aci
```

### Step 8: Verify Deployment

```bash
# Get the API URL
API_URL=$(terraform output -raw api_url)

# Test the API
curl $API_URL/health  # If you have a health endpoint
curl $API_URL/api/fruits
```

## Configuration

### Environment-Specific Variables

Edit `dev.tfvars` to customize the deployment:

```hcl
location         = "East US"        # Azure region
environment      = "dev"            # Environment name
app_name         = "fruit-price-api" # Application name
container_port   = 5000             # Container port
cpu_cores        = 1                # CPU allocation
memory_gb        = 1.5              # Memory allocation
log_retention_days = 30             # Log retention period
```

### Resource Naming Convention

Resources are named using the pattern: `{app_name}-{environment}-{resource_type}`

Example: `fruit-price-api-dev-rg`, `fruit-price-api-dev-aci`

## Outputs

After successful deployment, Terraform outputs include:

- `resource_group_name`: Name of the Azure resource group
- `acr_login_server`: Azure Container Registry URL
- `container_ip_address`: IP address of the container
- `api_url`: Full URL to access the API
- `application_insights_connection_string`: Application Insights connection string (sensitive)

View all outputs:
```bash
terraform output
```

View a specific output:
```bash
terraform output api_url
```

## Monitoring and Logs

### Application Insights

Application Insights is automatically configured for monitoring:

```bash
# Get Application Insights connection string
terraform output -raw application_insights_connection_string
```

View metrics and logs in the Azure Portal:
1. Navigate to the resource group
2. Open the Application Insights resource
3. View metrics, logs, and application map

### Container Logs

View container logs using Azure CLI:

```bash
RESOURCE_GROUP=$(terraform output -raw resource_group_name)

az container logs --resource-group $RESOURCE_GROUP --name fruit-price-api-dev-aci
```

## Updating the Infrastructure

### Modify Configuration

1. Edit the `.tfvars` file or Terraform files
2. Run `terraform plan -var-file=dev.tfvars` to review changes
3. Run `terraform apply -var-file=dev.tfvars` to apply changes

### Update Container Image

1. Build the new image
2. Push to ACR (Step 6 above)
3. Restart the container instance (Step 7 above)

## Destroying the Infrastructure

To tear down all resources:

```bash
cd infra/terraform/environments/dev

# Preview what will be destroyed
terraform plan -destroy -var-file=dev.tfvars

# Destroy all resources
terraform destroy -var-file=dev.tfvars

# Type 'yes' when prompted to confirm
```

**Warning**: This will permanently delete all resources including container images in ACR.

## Troubleshooting

### Common Issues

#### 1. Terraform Init Fails

**Problem**: Provider download errors
```bash
Error: Failed to install provider
```

**Solution**: 
- Check internet connectivity
- Verify Terraform version compatibility
- Clear Terraform cache: `rm -rf .terraform`

#### 2. Authentication Errors

**Problem**: Azure authentication fails
```bash
Error: Unable to authenticate with Azure
```

**Solution**:
```bash
# Re-authenticate
az logout
az login
az account set --subscription "<subscription-id>"
```

#### 3. Resource Already Exists

**Problem**: Resource name conflicts
```bash
Error: A resource with the ID already exists
```

**Solution**:
- Check if resources exist from previous deployments
- Use different `app_name` in `dev.tfvars`
- Clean up existing resources manually or with `terraform destroy`

#### 4. Container Image Not Found

**Problem**: ACI cannot pull image from ACR
```bash
Error: Failed to pull image
```

**Solution**:
- Verify image was pushed to ACR: `az acr repository list --name <acr-name>`
- Check image tag matches Terraform configuration
- Ensure ACR credentials are correct

#### 5. Container Won't Start

**Problem**: Container instance creation fails
```bash
Error: Container group provisioning failed
```

**Solution**:
- Check container logs: `az container logs --resource-group <rg> --name <container-name>`
- Verify environment variables in `modules/container/main.tf`
- Ensure port configuration matches application

#### 6. Network Connectivity Issues

**Problem**: Cannot access API endpoint
```bash
Error: Connection refused
```

**Solution**:
- Verify container is running: `az container show --resource-group <rg> --name <container-name>`
- Check security group rules (if using private networking)
- Confirm correct port in URL
- Wait for DNS propagation (for FQDN)

### Getting Help

- Check container status: `az container show --resource-group <rg> --name <container-name>`
- View detailed logs: `az container logs --resource-group <rg> --name <container-name> --follow`
- Review Application Insights for runtime errors
- Check Terraform state: `terraform show`

## Security Considerations

### Sensitive Data

- **Never commit** `terraform.tfstate` files to version control
- **Never commit** files containing credentials or secrets
- Use Azure Key Vault for production secrets
- ACR admin credentials are for dev only; use managed identities in production

### Network Security

- Current setup uses private networking with VNet integration
- For production, implement:
  - Network Security Groups (NSGs)
  - Private endpoints for ACR
  - API Gateway or Application Gateway
  - DDoS protection

## Cost Optimization

Development environment costs are minimal:

- **ACI**: Pay-per-second billing (~$1-5/month for dev usage)
- **ACR Basic**: ~$5/month
- **Application Insights**: First 5GB free, then pay-per-GB
- **VNet**: No cost for basic VNet

**Tips**:
- Stop containers when not in use: `az container stop`
- Delete resources when not needed: `terraform destroy`
- Use lower CPU/memory allocations for dev

## Next Steps

- Add CI/CD pipeline for automated deployments
- Implement database for persistent storage
- Set up staging and production environments
- Configure custom domain and SSL/TLS
- Implement advanced monitoring and alerting
- Add automated testing in infrastructure deployment

## Additional Resources

- [Azure Container Instances Documentation](https://docs.microsoft.com/en-us/azure/container-instances/)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Application Insights Documentation](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview)
- [ADR-001: Architecture Decisions](../docs/adr/adr-001-azure-container-instances-dev-environment.md)
