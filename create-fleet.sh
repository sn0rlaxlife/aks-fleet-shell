##create the fleet now AKS is provisioned

az fleet create --name $FLEET_NAME --resource-group $RG_GROUP --location $MY_LOCATION --no-wait

