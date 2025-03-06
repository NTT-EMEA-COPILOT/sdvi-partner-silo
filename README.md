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
- Two folders, for each user, are defined and mapped in Rally as different RSL:
  - {username}/incoming_media
  - {username}/processed_media
- Two SNS topics are created for each user:
  - {username}_topic_1
  - {username}_topic_2

## User setup
IAM role to assign to Rally resources is:
  - `arn:aws:iam::117342603894:role/sdvi-partner-silo-dev-role`
SNS topics are created for each user:
  - `arn:aws:sns:eu-south-1:117342603894:topic_1_{username}`
  - `arn:aws:sns:eu-south-1:117342603894:topic_2_{username}`
SNS topic to forward per user folder S3Notifications to SDVI
  - `arn:aws:sns:eu-south-1:117342603894:incoming_folders_notification_{username}`