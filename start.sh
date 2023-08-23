#!/bin/bash

vm="vm3"
rg="rg-demo2"
img="Ubuntu2204"
size="Standard_B1s"
admin="azureuser"

#Check is resource group exists
if ! az group show -n $rg &>/dev/null; then
	#create resource group
	az group create -n $rg && echo "resource group $rg created"
else
        echo "Resource Group $rg already exists"
fi


#check if vm exists
if ! az vm show -n $vm -g $rg &>/dev/null; then

	az vm create -n $vm -g $rg --image $img --size $size --admin-username $admin --generate-ssh-keys && echo "virtual machine $vm sucessfully created"
else
	echo "Virtual Machine $vm already exists"
fi



publicIP=$(az vm show -g $rg -n $vm --show-details --query "publicIps" --output tsv)
echo $publicIP


# Check if the components are installed
if ! ssh $admin@$publicIP "which apache2 mysql php"; then
    # If any component is missing, run the installation command
    az vm run-command invoke -g $rg -n $vm --command-id RunShellScript --scripts "sudo apt update && sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql"
else
    echo "Apache, MySQL, and PHP are already installed."
fi


#check is port 80 is open
if ! curl -I http://$publicIP:80 &>/dev/null; then

	az vm open-port --port 80 -n $vm -g $rg && echo "Port 80 openned"
else
        echo "Port 80 already open"
fi
