#!/bin/bash
export AWS_PROFILE=youcorn
export AWS_REGION=eu-south-1
export AWS_CA_BUNDLE=../terraform/cert/ZscalerRootCertificate-2048-SHA256.crt
export BUCKET_NAME=sdvi-partner-silo-storage-terraform-state

aws s3api create-bucket --bucket $BUCKET_NAME --region $AWS_REGION --create-bucket-configuration LocationConstraint=$AWS_REGION
aws s3api put-bucket-encryption --bucket $BUCKET_NAME --server-side-encryption-configuration={\"Rules\":[{\"ApplyServerSideEncryptionByDefault\":{\"SSEAlgorithm\":\"AES256\"}}]}
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Enabled

aws dynamodb create-table --table-name terraform-state-locks --billing-mode PAY_PER_REQUEST --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH

