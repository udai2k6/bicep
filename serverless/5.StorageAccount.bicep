
param pStorageAccountName string
param pLocation string = resourceGroup().location

resource rStorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: pStorageAccountName
  location: pLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

output oStorageAccountID string = rStorageAccount.id
