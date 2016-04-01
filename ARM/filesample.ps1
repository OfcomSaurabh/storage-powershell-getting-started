# Azure Storage File Sample - Demonstrates how to use the File Storage service.
# For documentation, refer to "http://go.microsoft.com/fwlink/?LinkId=785077"
# For API reference, refer to "http://go.microsoft.com/fwlink/?LinkId=785079"

# Set the name of selected subscription.
# To Retrieve the name of your subscription, run the following on Azure PowerShell:
	# Add-AzureRMAccount
	# Get-AzureRMSubscription | Format-Table SubscriptionName, IsDefault, IsCurrent, CurrentStorageAccountName
$SubscriptionName="Subscription Name"

# Provide the name of your resource group
$ResourceGroupName="Resource Group Name"

# Enter the name of your storage account. It must be all be lowercase.
$StorageAccountName="Storage Account Name"

# Provide a name for your new Azure Files share.
$ShareName = "demoshare"

# Provide a name for your new directory.
$DirectoryName = "demodirectory"

# Provide the full path to file you want to upload to new Azure Files share.
$FullPathToFile = "C:\full\path\to\file.jpg"

# Provide the name of the file. This should be an exact match to the file name in $FullPathToFile
$FileName = "file.jpg"

# Provide the full path for a new local directory.
$DestinationPath = "C:\DownloadedFiles"

# Create a new local directory
New-Item $DestinationPath -type directory

# Add your Azure account to the local PowerShell environment.
Add-AzureRMAccount

# Set default Azure subscription.
Get-AzureRmSubscription -SubscriptionName $SubscriptionName | Select-AzureRmSubscription

# Set default Storage account.
Set-AzureRmCurrentStorageAccount -ResourceGroupName $ResourceGroupName -StorageAccountName $StorageAccountName

# 1. Create a new file share.
New-AzureStorageShare -Name $ShareName

# 2. Create a directory.
New-AzureStorageDirectory -ShareName $ShareName -Path $DirectoryName

# 3. Upload a file.
Set-AzureStorageFileContent -ShareName $ShareName -Source $FullPathToFile -Path $DirectoryName

# 4. List directories and files
Get-AzureStorageFile -ShareName $ShareName
Get-AzureStorageFile -ShareName $ShareName -Path $DirectoryName

# 5. Download a file
$SourcePath = $DirectoryName+"/"+$FileName
Get-AzureStorageFileContent -ShareName $ShareName -Path $SourcePath -Destination $DestinationPath

# 6. Delete file share.
# User will be prompted to confim the deletion.
Remove-AzureStorageShare -Name $ShareName

# 7. Delete the local directory.
Remove-Item $DestinationPath
