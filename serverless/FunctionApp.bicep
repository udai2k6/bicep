param pFunctionApp string
param pServerFarmID string
param pLocation string = resourceGroup().location
param pFunctionAppName string

resource razureFunction 'Microsoft.Web/sites@2020-12-01' = {
  name: pFunctionApp
  location: pLocation
  kind: 'functionapp'
  properties: {
    serverFarmId: pServerFarmID
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsDashboard'
          //value: 'DefaultEndpointsProtocol=https;AccountName=valasdeveastusstorage1;AccountKey=1l1rrNmIOifKs18lGuubHg/kWKQd0JhU20b/ZGZCmmW2m/EBkwOGj33I7QMusNGTfpUlf0AlM0AT+ASttOgJww==;EndpointSuffix=core.windows.net'
          value: 'DefaultEndpointsProtocol=https;AccountName=storageAccountName1;AccountKey=${listKeys('storageAccountID1', '2019-06-01').key1}'
        }
        {
          name: 'AzureWebJobsStorage'
          //value: 'DefaultEndpointsProtocol=https;AccountName=valasdeveastusstorage1;AccountKey=1l1rrNmIOifKs18lGuubHg/kWKQd0JhU20b/ZGZCmmW2m/EBkwOGj33I7QMusNGTfpUlf0AlM0AT+ASttOgJww==;EndpointSuffix=core.windows.net'
          value: 'DefaultEndpointsProtocol=https;AccountName=storageAccountName2;AccountKey=${listKeys('storageAccountID2', '2019-06-01').key1}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          //value: 'DefaultEndpointsProtocol=https;AccountName=valasdeveastusstorage1;AccountKey=1l1rrNmIOifKs18lGuubHg/kWKQd0JhU20b/ZGZCmmW2m/EBkwOGj33I7QMusNGTfpUlf0AlM0AT+ASttOgJww==;EndpointSuffix=core.windows.net'
          value: 'DefaultEndpointsProtocol=https;AccountName=storageAccountName3;AccountKey=${listKeys('storageAccountID3', '2019-06-01').key1}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(pFunctionAppName)
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          //value: '3bf73d3a-a94a-426f-9486-c38d4b168e56'
          value: reference('insightsComponents.id', '2015-05-01').InstrumentationKey
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
      ]
    }
  }
}
