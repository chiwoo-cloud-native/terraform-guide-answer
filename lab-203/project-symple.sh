#!/bin/bash
mkdir symple
cd symple

mkdir -p ./resources/vpc
cd resources/vpc
terraform workspace new dev
terraform workspace new stg
terraform workspace new prd
touch data.tf
touch main.tf
touch providers.tf

cat > variables.tf << EOF
variable "env" {
  type = string
}
EOF

cat > outputs.tf << EOF
output "env" {
  value = var.env
}

EOF

#
echo "env = \"Development\"" > dev.tfvars
echo "env = \"Staging\"" > stg.tfvars
echo "env = \"Production\"" > prd.tfvars

terraform init
terraform workspace select stg
terraform plan -var-file=stg.tfvars

# terraform workspace list

