# To deploy this main.bicep manually:
# az login
# az account set --subscription <subscriptionId>
az deployment group create -n main-deploy-20221104T115300Z --resource-group rg_blazorserver_dev --template-file 'main.bicep' --parameters orgPrefix=lll appPrefix=blazorserver environmentCode=dev keyVaultOwnerUserId1=af35198e-8dc7-4a2e-a41e-b2ba79bebd51
