# Azure Storage File Sample - Demonstrates how to use the File Storage service.
# For more documentation, refer to http://go.microsoft.com/fwlink/?LinkId=785077
# For Cmdlet reference, refer to http://go.microsoft.com/fwlink/?LinkId=785079

# Set the name of selected subscription.
# To Retrieve the name of your subscription, run the following on Azure PowerShell:
	# Add-AzureAccount
	# Get-AzureSubscription | Format-Table SubscriptionName, IsDefault, IsCurrent, CurrentStorageAccountName
$SubscriptionName="<Subscription Name>"

# Enter the name of your storage account. It must be all be lowercase.
$StorageAccountName="<Storage Account Name>"

# Provide a name for your new Azure Files share.
$ShareName = "<Share Name>"

# Provide a name for your new directory.
$DirectoryName = "<Directory Name>"

# Set the full path to file you want to upload to new Azure Files share.
$FileToUpload = "AzureFiles.ps1"

# Set the full path to download file destination.
$DestinationPath = "DownloadedFile.ps1"

# Add your Azure account to the local PowerShell environment.
Add-AzureAccount

# Set a default Azure subscription.
Select-AzureSubscription -SubscriptionName $SubscriptionName

# Set a default storage account.
Set-AzureSubscription -CurrentStorageAccountName $StorageAccountName -SubscriptionName $SubscriptionName

# 1. Create a new file share.
New-AzureStorageShare -Name $ShareName

# 2. Create a directory.
New-AzureStorageDirectory -ShareName $ShareName -Path $DirectoryName

# 3. Upload a file.
Set-AzureStorageFileContent -ShareName $ShareName -Source $FileToUpload -Path $DirectoryName

# 4. List directories and files
Get-AzureStorageFile -ShareName $ShareName
Get-AzureStorageFile -ShareName $ShareName -Path $DirectoryName

# 5. Download a file
$SourcePath = $DirectoryName+"/"+$FileToUpload
Get-AzureStorageFileContent -ShareName $ShareName -Path $SourcePath -Destination $DestinationPath

# 6. Delete file share.
# User will be prompted to confim the deletion.
Remove-AzureStorageShare -Name $ShareName

# 7. Delete the downloaded file.
Remove-Item $DestinationPath
