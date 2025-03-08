# SDVI Partner Silo setup
This document describes the steps to setup a partner silo in SDVI Rally.

## Prerequisites
- Access to SDVI Rally
- Terraform installed on your machine
- AWS CLI installed on your machine
- AWS credentials configured on your machine
- scripts/init_backend.sh script run to initialize the backend

## Caveats
- terraform state file is kept within `sdvi-partner-silo-terraform-state` bucket in the `eu-west-1` region
- All the commands should be run from the `terraform` directory
- Infrastructure is created in the `eu-west-1` region
- Incomplete multipart uploads are deleted after 10 days
- Files in the bucket are deleted after 30 days to avoid incurring costs
- The bucket `sdvi-partner-silo-storage` is not publicly accessible
- Three folders, for each user, are defined and mapped in Rally as different RSL:
  - {username}/incoming, for incoming files every user uploads triggers a notification to Rally RSL
  - {username}/processed, for processed files
  - {username}/package, for package files to be referred by preset as Eval2Package config field
- Two SNS topics are created for each user:
  - {username}_topic_1
  - {username}_topic_2

## User setup
IAM role to assign to Rally resources is:
  - `arn:aws:iam::117342603894:role/sdvi-partner-silo-dev-role`
SNS topics are created for each user:
  - `arn:aws:sns:eu-west-1:117342603894:topic_1_{username}`
  - `arn:aws:sns:eu-west-1:117342603894:topic_2_{username}`
SNS topic to forward S3Notifications to SDVI, per user filtering is performed by Rally at RSL level:
  - `arn:aws:sns:eu-west-1:117342603894:sdvi-notify-sdvi-partner-silo-storage`
