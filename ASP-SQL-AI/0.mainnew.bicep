param pAppServicePlan string 
param pAppService string 
param pEnv string = 'dev'
param psqlServer string 
param psqlServerFWR string 
param psqlServerDatabase string 
param psqllogin string
@secure()
param psqlpasswd string
param pInstrumentationString string
param pLocation string = 'eastus'
param pSKUName string = (pEnv == 'dev') ? 'S1' : 'F1'
param pSKUCapacity int = (pEnv == 'dev') ? 2 : 1

module mAppServicePlan '2.AppServicePlan.bicep' = {
  name: 'ModAppserviceplan'
params: {
  pAppService: pAppService
  pAppServicePlan: pAppServicePlan
  pInstrumentationString: mAppInsight.outputs.oInstrumentationkey
  pSKUName: pSKUName
 // pLocation: pLocation
  pEnv: pEnv
  pSKUCapacity: pSKUCapacity
}
}

resource rKeyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: 'valas-dev-sqlkv5'
}

module mSQLserver '3.SQLDB.bicep' = {
  name: 'ModSQLserver'
  params: {
    psqlServer: psqlServer
    psqlServerDatabase: psqlServerDatabase
    psqlServerFWR: psqlServerFWR
    psqllogin: psqllogin
    psqlpasswd: rKeyVault.getSecret('mysqlpasswd')
 //   pLocation: pLocation
  }
}

module mAppInsight '4.AppInsights.bicep' = {
  name: 'ModAppInsight'
  params: {
    pLocation: pLocation
  }
}
