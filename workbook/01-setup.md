# Chapter-1: Setup

## Create RSL
Read the [Infrastructure in RFally](https://sdvi.my.site.com/support/s/article/Infrastructure-in-Rally) to understand what a Rally Storage Location (RSL) is.

The document also explain what _providers_ are.

Head to [Adding And Configuring External S3 Buckets To Work With SDVI Rally](https://sdvi.my.site.com/support/s/article/Adding-And-Configuring-External-S3-Buckets-To-Work-With-SDVI-Rally) and follow steps 6 and 7 of the guide.
Use the following values to create your RSLs:

### Incoming
- **Name**: `[username]-incoming` 
- **Buckedt**:`sdvi-partner-silo-storage`
- **Prefix**: `[username]/incoming/
- **AWS Region**: `eu-west-1`
- **Role ARN**: `arn:aws:iam::117342603894:role/sdvi-partner-silo-dev-role`

### Processed
- **Name**: `[username]-processed` 
- **Buckedt**:`sdvi-partner-silo-storage`
- **Prefix**: `[username]/processed/
- **AWS Region**: `eu-west-1`
- **Role ARN**: `arn:aws:iam::117342603894:role/sdvi-partner-silo-dev-role`

### Package
- **Name**: `[username]-package` 
- **Buckedt**:`sdvi-partner-silo-storage`
- **Prefix**: `[username]/package/
- **AWS Region**: `eu-west-1`
- **Role ARN**: `arn:aws:iam::117342603894:role/sdvi-partner-silo-dev-role`
