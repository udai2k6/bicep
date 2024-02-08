param pAppServicePlan string 
param pLocation string = resourceGroup().location
@description('''
Please provide valid SKU Name: F1 or S1
''')
@allowed( ['F1','S1'])
param pSKUName string
@minValue(1)
@maxValue(3)
param pSKUCapacity int

resource rAppServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: pAppServicePlan
  location: pLocation
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
    name: pSKUName
    capacity: pSKUCapacity
  }
}

output oAppServicePlanid string = rAppServicePlan.id 
