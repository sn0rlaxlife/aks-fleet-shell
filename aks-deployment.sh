echo '------AKS Cluster Creation in progress--------'
starttime=$(date +%s)
. ./setenv.sh

az group create --name $RG_GROUP --location $MY_LOCATION

az group create --name $AKS_CLUSTER2 --location $LOCATION_2

AKS_K8S=$(az aks get-versions --location $MY_LOCATION --output table | awk '{print $1}' | grep $K8S_VERSION | head -1)

AKS_K8S2=$(az aks get-versions --location $LOCATION_2 --output table | awk '{print $1}' | grep $K8S_VERSION | head -1)

#https://learn.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-create
az aks create \
  --name $AKS_CLUSTER \
  --resource-group $RG_GROUP \
  --location $MY_LOCATION \
  --generate-ssh-keys \
  --kubernetes-version $AKS_K8S \
  --node-count 1 \
  --node-vm-size $VM_SIZE \
  --min-count 1 \
  --max-count 2  \
  --enable-defender \

az aks create \
  --name $AKS_CLUSTER2 \
  --resource-group $AKS_CLUSTER2 \
  --location $LOCATION_2 \
  --generate-ssh-keys \
  --kubernetes-version $AKS_K8S2 \
  --node-count 1 \
  --node-vm-size $VM_SIZE \
  --min-count 1 \
  --max-count 2  \
  --enable-defender \

az aks get-credential -g $RG_GROUP -n $(az aks list -o table | grep $AKS_CLUSTER | awk '{print $1}')

az aks get-credential -g $AKS_CLUSTER2 -n $(az aks list -o table | grep $AKS_CLUSTER2 | awk '{print $1}')

echo "-----Creation of AKS Kubernetes Fleet Manager-----" | awk '{print $1}'
./create-fleet.sh

echo "" | awk '{print $1}'
end=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "Appears the total time for this deployment is..... $(($duration / 60)) minutes...."
echo "Happy fleet manager usage and beyond......"
