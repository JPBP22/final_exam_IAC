@sys.description('The Web BE App name')
@minLength(3)
@maxLength(24)
param ServiceAppName string = 'JPBello-final-app'


@sys.description('The App Service Plan name')
@minLength(3)
@maxLength(24)
param appServicePlanName string = 'JPBello-final-asp'


@sys.description('The Storage Account name')
@minLength(3)
@maxLength(24)
param storageAccountName string = 'jpbellofinalexam1'


@sys.description('The Storage Account name')
@minLength(3)
@maxLength(24)
param storageAccountName2 string = 'jpbellofinalexam2'
@allowed([
  'nonprod'
  'prod'
])
param enviormentType string = 'nonprod'
param location string = resourceGroup().location

var storageAccountSkuName = (enviormentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSkuName = (enviormentType == 'nonprod') ? 'P2V3' : 'F1'


resource storageAccount'Microsoft.Storage/storageAccounts@2022-05-01' = {
    name: storageAccountName
    location: location
    sku: {
      name: storageAccountSkuName
    }
    kind: 'StorageV2'
    properties : {
      accessTier: 'Hot'
  }
}

resource storageAccount2'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName2
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties : {
    accessTier: 'Hot'
}
}

module appService 'modules/appstuff.bicep' = {
  name: 'appService'
  params:{
    location: location
    ServiceAppName:ServiceAppName
    enviormentType:enviormentType

  }
}

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
}
}


output appServiceAppHostName string = appService.outputs.appServiceAppHostName
