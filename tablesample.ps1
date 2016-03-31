# Azure Table Service Sample - Demonstrate how to perform common tasks using the Microsoft Azure Table storage
# including creating, listing, and deleting tables.

# Set the name of selected subscription.
$SubscriptionName="Subscription Name"

# Provide the name of your resource group
$ResourceGroupName="Resource Group Name"

# Provide the name of your Storage account.
$StorageAccountName="Storage Account Name"

# Provide a name for your new table.
$TableName = "Table Name"

# Add your Azure account to the local PowerShell environment.
Add-AzureRMAccount

# Set default Azure subscription.
Get-AzureRmSubscription -SubscriptionName $SubscriptionName | Select-AzureRmSubscription

# Set default Storage account.
Set-AzureRmCurrentStorageAccount -ResourceGroupName $ResourceGroupName -StorageAccountName $StorageAccountName

# 1. Create a new table.
New-AzureStorageTable -Name $TableName

# 2. List all tables.
Get-AzureStorageTable

# 3. Remove table
# Remove-AzureStorageTable $TableName
