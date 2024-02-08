
param psqlServer string 
param psqlServerFWR string 
param psqlServerDatabase string 
param psqllogin string
@secure()
param psqlpasswd string

resource sqlServer 'Microsoft.Sql/servers@2014-04-01' ={
  name: psqlServer
  location: resourceGroup().location
  properties: {
    administratorLogin:psqllogin
    administratorLoginPassword:psqlpasswd
    //administratorLoginPassword:rKeyVault.getSecret('sqladminpasswd')
  }
}
resource sqlServerFirewallRules 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  parent: sqlServer
  name: psqlServerFWR
  properties: {
    startIpAddress: '81.175.210.180'
    endIpAddress: '81.175.210.180'
  }
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2014-04-01' = {
  parent: sqlServer
  name: psqlServerDatabase
  location: resourceGroup().location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    edition: 'Basic'
    maxSizeBytes: '2147483648'
    requestedServiceObjectiveName: 'Basic'
  }
}
