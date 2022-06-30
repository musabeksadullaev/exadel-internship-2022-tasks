# Task 3 (IaC / Terraform)

## Task 2 (Extra)
### Result page
:globe_with_meridians: http://34.201.178.204/info.html


### Task details

Step 1-7:
:memo: Files created when completing task:
- `./main.tf` - Entrypoint of terraform
- `./variables.tf` - Variables that can be used in `main.tf` file
- `./terraform-plan-output.txt` - Output of `terraform plan`

Step 8:
- Ubuntu server
  - Install [Squid proxy server](http://www.squid-cache.org/)
  - Allow Squid proxy server to receive any connections ([variables.tf:176](./variables.tf#L176))
  - Restart Squid proxy server to use new configuration
- CentOS server:
  - Disable IPv6 ([main.tf:263](./main.tf#L263))
  - Make yum package manager in CentOS server to use proxy ([main.tf:270](./main.tf#L270))
  - Update and upgrade packages
  - Install nginx package
  - Create file with "Hello world" text

### Commands

``` bash
# Export AWS credentials
export AWS_SECRET_ACCESS_KEY="..."
export AWS_ACCESS_KEY_ID="..."

# Download dependencies and install providers
terraform init

# Plan infrastructure changes
terraform plan

# Apply infrastructure changes
terraform apply

```
