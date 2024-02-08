
param pStorageAccountName string
param pLocation string = resourceGroup().location
param pAppServicePlan string 
param pSKUName string = 'F1'
param pSKUCapacity int = 1

param pFunctionApp string
param pServerFarmID string
param pFunctionAppName string


module ModStorageAccount '5.StorageAccount.bicep' = {
  name: 'StorageAccountModule'
  params: {
    pLocation: pLocation
    pStorageAccountName: pStorageAccountName
  }
}

module ModAppServicePlan 'AppServicePlan-Linux.bicep' = {
  name: 'ModAppservicePlan'
  params: {
    pAppServicePlan: pAppServicePlan
    pSKUCapacity: pSKUCapacity
    pSKUName: pSKUName
    pLocation: pLocation
  }
}

module modFunctionApp 'FunctionApp.bicep' = {
  name: 'ModFunctionApp'
  dependsOn: [
    ModAppServicePlan
  ]
  params: {
    pFunctionApp: pFunctionApp
    pFunctionAppName: pFunctionAppName
    pServerFarmID: ModAppServicePlan.outputs.oAppServicePlanid
    pLocation: pLocation
  }
}
