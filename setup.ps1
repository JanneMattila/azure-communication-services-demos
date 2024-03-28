# All the variables for the deployment
$subscription_name = "development"

$acs_name = "acs000000010"

$resource_group_name = "rg-communication-services"
$location = "westeurope"

# Login and set correct context
az login -o none
az account set --subscription $subscription_name -o table

# Create resource group
az group create --resource-group $resource_group_name --location $location -o table

az communication create --help
$acs = (az communication create --name $acs_name --location "Global" --data-location "Europe" --resource-group $resource_group_name -o json | ConvertFrom-Json)
$acs
$acs.hostName

$acs_keys = (az communication list-key --name $acs_name --resource-group $resource_group_name -o json | ConvertFrom-Json)
$acs_keys
$acs_keys.primaryConnectionString
$acs_keys.primaryKey
$acs_keys.primaryConnectionString | clip

#
# Test example
# https://github.com/Azure-Samples/communication-services-web-calling-tutorial/
# ...
# Disable host check in "webpack.config.js":
#    devServer: {
#        open: true,
#        port: PORT,
#        disableHostCheck: true, // Add this!
# npm run start
#

# Use https://ngrok.com to proxy traffic to local demo
ngrok http 5000

# Wipe out the resources
az group delete --name $resource_group_name -y
