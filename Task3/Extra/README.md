# Task 3 (IaC / Terraform)

## Task 1 (Mandatory)
### Result page
:globe_with_meridians: http://52.204.31.76/info.html


### Task details

:memo: Files created when completing task:
- `./main.tf` - Entrypoint of terraform
- `./variables.tf` - Variables that can be used in `main.tf` file
- `./terraform-plan-output.txt` - Output of `terraform plan`

### Commands

``` bash
# TODO: Remove before
# Export AWS credentials
export AWS_SECRET_ACCESS_KEY="aA4Lg9ApTWGBTiYZaJtzPnaTHJIIY8z1L99Fwi2p"
export AWS_ACCESS_KEY_ID="AKIAW2UILN5N3D2RGKHO"

# AMI IDs for EC2 instance
export TF_VAR_VM_1_AMI_ID="ami-052efd3df9dad4825"
export TF_VAR_VM_2_AMI_ID="ami-00e87074e52e6c9f9"

# Download dependencies and install providers
terraform init

# Plan infrastructure changes
terraform plan

# Apply infrastructure changes
terraform apply

```
