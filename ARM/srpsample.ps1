# Azure Storage Resource Provider Sample - Demonstrate how to create and manage storage accounts using Storage Resource Provider.

# Set the name of selected subscription.
# To retrieve the name of your subscription, run the following two commands:
	# Add-AzureRMAccount
	# Get-AzureRMSubscription | Format-Table SubscriptionName, IsDefault, IsCurrent, CurrentStorageAccountName
$SubscriptionName="<Subscription Name>"

# Provide the name of your resource group
$ResourceGroupName="<Resource Group Name>"

# Provide the name of the Storage account that will be created.
$StorageAccountName="<Storage Account Name>"

# Specify the type of Storage account to create and another type that will be used for updating the Storage account. Valid values are:
  # Standard_LRS (locally-redundant storage)
  # Standard_ZRS (zone-redundant storage)
  # Standard_GRS (geo-redundant storage)
  # Standard_RAGRS (read access geo-redundant storage)
  # Premium_LRS
$Type = "<Standard_GRS>"
$NewType = "<Standard_RAGRS>"

# Specify the location of the Storage account to create.
# To view available locations for Storage, run the following command:
  # ((Get-AzureRmResourceProvider -ProviderNamespace Microsoft.Storage).ResourceTypes | Where-Object ResourceTypeName -eq storageAccounts).Locations
$Location = "<West US>"

# Add your Azure account to the local PowerShell environment.
Add-AzureRMAccount

# Set default Azure subscription.
Get-AzureRmSubscription -SubscriptionName $SubscriptionName | Select-AzureRmSubscription

# Create new resource group
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location

# Get Storage resource usage of the current subscription.
Get-AzureRmStorageUsage

# List all Storage accounts in subscription
Get-AzureRmStorageAccount

# Check availability of a storage account name.
$StorageAccountNameExists = Get-AzureRmStorageAccountNameAvailability -Name $StorageAccountName

If (-Not $StorageAccountNameExists.NameAvailable) {
  Write-Host "Storage account name already taken."
} Else {
  #Create new Storage account.
  New-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -Type $Type -Location $Location

  # List all Storage accounts in resource group
  Get-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName

  # Get access keys for Azure Storage account.
  Get-AzureRmStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName

  # Update Storage account type
  Set-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $StorageAccountName -Type $NewType

  # Delete Storage account
  # Remove-AzureRmStorageAccount $StorageAccountName
}
