
param pAppServicePlan string 
param pAppService string 
param pInstrumentationString string
param pLocation string = resourceGroup().location
param pEnv string
@description('''
Please provide valid SKU Name:
 - Free - F1
 - Basic - B1

''')
@allowed( ['F1','S1'])
param pSKUName string
@minValue(1)
@maxValue(3)
param pSKUCapacity int

resource rAppServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: pAppServicePlan
  location: pLocation
  sku: {
    name: pSKUName
    capacity: pSKUCapacity
  }
}

resource rWebAppSlots 'Microsoft.Web/sites/slots@2023-01-01' = if (pEnv == 'dev'){
  name: 'Staging'
  location: pLocation
  parent: rWebApplication
  properties: {
    serverFarmId:  rAppServicePlan.id
  }
}

resource rWebApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: pAppService
  location: pLocation
  properties: {
    serverFarmId: resourceId('Microsoft.Web/serverfarms','uk-dev-swecen-asp1')
  }
  dependsOn: [
    rAppServicePlan
  ]
}

resource rWebappsettings 'Microsoft.Web/sites/config@2023-01-01' = {
  name: 'web'
  parent:  rWebApplication
  properties:  {
    appSettings: [
      {
        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
        value: pInstrumentationString
      }
    ]
  }
  
}




