// --------------------------------------------------------------------------------
// Main file that deploys all Azure Resources for one environment
// --------------------------------------------------------------------------------
// Note: To deploy this Bicep manually:
// 	 az login
//   az account set --subscription <subscriptionId>
//   az deployment group create -n main-deploy-20220823T110000Z --resource-group rg_blazor_dev --template-file 'main.bicep' --parameters orgPrefix=lll appPrefix=blazordemo environmentCode=dev keyVaultOwnerUserId1=xxxxxxxx-xxxx-xxxx
// --------------------------------------------------------------------------------
param environmentCode string = 'dev'
param location string = resourceGroup().location
param orgPrefix string = 'org'
param appPrefix string = 'app'
param appSuffix string = '' // '-1' 
param storageSku string = 'Standard_LRS'
param existingKeyVaultName string = ''
param runDateTime string = utcNow()
param webSiteSku string = 'B1'
param webAppName string = ''

// --------------------------------------------------------------------------------
var deploymentSuffix = '-${runDateTime}'
var insightKeyName = 'webSiteInsightsKey${webAppName}' 

module storageModule 'storageaccount.bicep' = {
  name: 'storage${deploymentSuffix}'
  params: {
    storageSku: storageSku

    templateFileName: 'storageaccount.bicep'
    orgPrefix: orgPrefix
    appPrefix: appPrefix
    environmentCode: environmentCode
    appSuffix: appSuffix
    location: location
    runDateTime: runDateTime
  }
}
module webSiteModule 'website.bicep' = {
  name: 'webSite${deploymentSuffix}'
  params: {
    appInsightsLocation: location
    sku: webSiteSku
    webAppName: webAppName
    templateFileName: 'website.bicep'
    orgPrefix: orgPrefix
    appPrefix: appPrefix
    environmentCode: environmentCode
    appSuffix: appSuffix
    location: location
    runDateTime: runDateTime
  }
}
module keyVaultSecret1 'keyvaultsecret.bicep' = {
  name: 'keyVaultSecret1${deploymentSuffix}'
  dependsOn: [ webSiteModule ]
  params: {
    keyVaultName: existingKeyVaultName
    secretName: insightKeyName
    secretValue: webSiteModule.outputs.webSiteAppInsightsKey
  }
}  

module webSiteAppSettingsModule 'websiteappsettings.bicep' = {
  name: 'webSiteAppSettings${deploymentSuffix}'
  dependsOn: [ keyVaultSecret1 ]
  params: {
    webAppName: webSiteModule.outputs.webSiteName
    customAppSettings: {
      EnvironmentName: environmentCode
      ApplicationInsightsKey: '@Microsoft.KeyVault(VaultName=${existingKeyVaultName};SecretName=${insightKeyName})'
      PublishFunctionAppKey: '@Microsoft.KeyVault(VaultName=${existingKeyVaultName};SecretName=PublishFunctionAppKey)'
    }
  }
}
