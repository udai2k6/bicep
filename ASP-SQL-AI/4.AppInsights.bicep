param pLocation string  = resourceGroup().location

resource rappInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: 'AppServiceInsight'
  location: pLocation
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}
output oInstrumentationkey string = rappInsightsComponents.properties.InstrumentationKey
