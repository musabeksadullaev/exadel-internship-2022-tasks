# Task 3 (IaC / Terraform)

## Task 1 (Mandatory)
### Result page
:globe_with_meridians: http://34.201.230.171/info.html


### Task details

:memo: Files created when completing task:
- `./main.tf` - Entrypoint of terraform
- `./variables.tf` - Variables that can be used in `main.tf` file
- `./terraform-plan-output.txt` - Output of `terraform plan`

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
