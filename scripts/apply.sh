#!/bin/bash
cd ../terraform
export AWS_PROFILE=youcorn
export AWS_REGION=eu-south-1
export AWS_CA_BUNDLE=../terraform/cert/ZscalerRootCertificate-2048-SHA256.crt
export SSL_CERT_FILE=../terraform/cert/ZscalerRootCertificate-2048-SHA256.crt
if [ -e ./terraform.tfstate ]; then
    echo "Terraform already initialized."
else
    terraform init
fi
terraform apply -var-file=./vars/ntt.tfvars -auto-approve -parallelism=20
cd -
