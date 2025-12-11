# ADR-001 Azure Container Instances for Dev Environment

**Date**: 2025-12-11 | **Status**: Accepted | **PBI**: PBI-002

## Context

We need to deploy the Fruit Prices API to Azure for development and testing purposes. The API is a lightweight Flask application that serves fruit price data through REST endpoints. We need infrastructure that:

- Is simple to deploy and manage for development purposes
- Minimizes operational complexity and cost
- Supports containerized deployments
- Provides basic monitoring capabilities
- Can be easily provisioned via Infrastructure as Code (Terraform)

## Decision

We will use **Azure Container Instances (ACI)** for the dev environment deployment instead of more complex options like Azure Kubernetes Service (AKS) or Azure App Service.

### Key decisions:

1. **Compute**: Azure Container Instances (ACI)
   - Simplest container deployment option in Azure
   - No cluster management overhead
   - Pay-per-second pricing ideal for dev/test
   - Fast deployment and startup times

2. **Container Registry**: Azure Container Registry (ACR)
   - Native Azure integration with ACI
   - Secure private registry for our images
   - Simple authentication with Azure AD

3. **Networking**: Basic VNet integration
   - Minimal network setup (VNet + subnet)
   - Sufficient for dev environment isolation
   - No complex network policies required

4. **Monitoring**: Application Insights
   - Integrated Azure monitoring solution
   - Provides basic telemetry and logs
   - Easy integration with Flask applications

5. **State Management**: Local Terraform state
   - Appropriate for single-developer dev environment
   - Simpler than remote state backend for initial development
   - Will migrate to remote state for staging/production

6. **Database**: In-memory sample data (for now)
   - Postponing database implementation to future iteration
   - Reduces initial complexity
   - Allows focus on core deployment pipeline

## Alternatives Considered

### Azure Kubernetes Service (AKS)
- **Pros**: Production-grade, scalable, industry standard
- **Cons**: Too complex for simple dev environment, higher cost, longer setup time
- **Decision**: Rejected for dev; may consider for production

### Azure App Service
- **Pros**: Managed platform, built-in features, easy deployment
- **Cons**: Less control over container runtime, higher cost than ACI, platform lock-in
- **Decision**: Rejected; ACI provides more flexibility

### Azure Container Apps
- **Pros**: Serverless containers, auto-scaling, modern
- **Cons**: More complex than needed for dev, newer service with less documentation
- **Decision**: Rejected; ACI is simpler for our needs

## Consequences

### Positive
- **Simplicity**: Minimal infrastructure components to manage
- **Cost-effective**: Pay only for actual usage in dev environment
- **Fast iteration**: Quick deployment and teardown cycles
- **Learning curve**: Easy for developers unfamiliar with Azure
- **IaC-friendly**: Straightforward Terraform modules

### Negative
- **Limited scalability**: ACI not suitable for production workloads
- **Feature gaps**: Missing advanced features like auto-scaling, load balancing
- **Migration needed**: Will need to redesign infrastructure for production
- **Stateless**: No persistent storage configured yet

### Mitigation
- Document the dev-only nature of this setup clearly
- Plan for production architecture in future ADR
- Use modular Terraform to allow component replacement
- Implement proper environment separation (dev → staging → prod)

## Notes
- This ADR applies **only to the development environment**
- Production architecture will be addressed in a separate ADR
- Database integration planned for future iteration
- Remote state backend will be required before production deployment
