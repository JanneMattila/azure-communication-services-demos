# All the variables for the deployment
$subscription_name = "AzureDev"

$acs_name = "myacs"

$resource_group_name = "rg-acs-demo"
$location = "westeurope"

# Login and set correct context
az login -o none
az account set --subscription $subscription_name -o table

# Create resource group
az group create -l $location -n $resource_group_name -o table

az communication create --help
$acs = (az communication create --name $acs_name --location "Global" --data-location "Europe" --resource-group $resource_group_name -o json | ConvertFrom-Json)
$acs
$acs.hostName

$acs_keys = (az communication list-key --name $acs_name --resource-group $resource_group_name -o json | ConvertFrom-Json)
$acs_keys
$acs_keys.primaryConnectionString
$acs_keys.primaryKey

# Wipe out the resources
az group delete --name $resource_group_name -y
