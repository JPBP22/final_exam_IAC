param location string = resourceGroup().location
param ServiceAppName string = 'JPBello-final-app'
param appServicePlanName string = 'JPBello-final-asp'
@allowed([
  'nonprod'
  'prod'
])
param enviormentType string = 'nonprod'
var appServicePlanSkuName = (enviormentType == 'nonprod') ? 'P2V3' : 'F1'



resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
}
}

resource ServiceApp 'Microsoft.Web/sites@2022-03-01' = {
name: ServiceAppName
location: location
properties: {
  serverFarmId: appServicePlan.id
  httpsOnly: true
  }
}

output appServiceAppHostName string = ServiceApp.properties.defaultHostName
output ServiceAppName string = ServiceApp.properties.defaultHostName
