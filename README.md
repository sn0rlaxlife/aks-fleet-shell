# aks-fleet-shell
Deploying AKS Fleet Manager and AKS Clusters in Azure via Bash Script

<h1> Concept - Deploy AKS Clusters in two regions one us-west and another in us-east</h1>

To start this process run the following

<code> git clone https://github.com/sn0rlaxlife/aks-fleet-shell.git </code>
Second feel free to update the setenv.sh file to any desired values
<code>bash ./setenv.sh</code>

<code>./aks-deployment.sh</code>


This will run a script that provisions two AKS clusters running in two different regions and resource groups and kick off Azure Kubernetes Fleet Manager via the script in create-fleet.sh

