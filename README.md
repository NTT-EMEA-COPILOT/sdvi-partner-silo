# SDVI Partner Silo setup
This document describes the steps to setup a partner silo in SDVI Rally.

## Prerequisites
- Access to SDVI Rally
- Terraform installed on your machine
- AWS CLI installed on your machine
- AWS credentials configured on your machine
- scripts/init_backend.sh script run to initialize the backend

## Caveats
- terraform state file is kept within `sdvi-partner-silo-storage-terraform-state` bucket in the `eu-south-1` region
- All the commands should be run from the `terraform` directory
- Infrastructure is created in the `eu-south-1` region
- Incomplete multipart uploads are deleted after 15 days
- Files in the bucket are deleted after 60 days to avoid incurring costs
- The bucket is not publicly accessible
- Two folders are defined and mapped in Rally as different RSL:
  - incoming_media
  - processed_media