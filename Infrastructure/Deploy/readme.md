# Deployment Template Notes:

## 1. Template Definitions

Typically, you would want to set up either Option (a), or Option (b) AND Option (c), but not all three jobs.

- **infra-and-code-pipeline.yml:** Deploys the main.bicep template, builds the function app, then deploys the function app to the Azure Function
- **infra-only-pipeline.yml:** Deploys the main.bicep template and does nothing else
- **app-only-pipeline.yml:** Builds the function app and then deploys the function app to the Azure Function
- **test-harness-build-pipeline.yml:** Builds the console utility that can be used to test the app and then copies the EXE file to a storage account for easy access.

---

## 2. Deploy Environments

These YML files were designed to run as multi-stage environment deploys (i.e. DEV/QA/PROD). Each Azure DevOps environments can have permissions and approvals defined. For example, DEV can be published upon change, and QA/PROD environments can require an approval before any changes are made.

---

## 3. These pipelines needs a variable group named "BlazorServerDemo"

To create these variable groups, customize and run this command in the Azure Cloud Shell, once for each environment:

``` bash
   az login

   az pipelines variable-group create 
     --organization=https://dev.azure.com/<yourAzDOOrg>/ 
     --project='<yourAzDOProject>' 
     --name BlazorServerDemo 
     --variables 
         orgPrefix='<yourInitials>' 
         appPrefix='BlazorServerDemo' 
         appSuffix=''
         environmentCode='dev' 
         serviceConnectionName='<yourServiceConnection>' 
         azureSubscription='<yourAzureSubscriptionName>' 
         subscriptionId='<yourSubscriptionId>' 
         location='eastus' 
         bicepDirectory='Infrastructure/Bicep/' 
         bicepFileName='main.bicep'
         keyVaultOwnerUserId1='owner1SID'
```
