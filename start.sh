#!/bin/bash

vm="vm3"
rg="rg-demo2"
img="Ubuntu2204"
size="Standard_B1s"
admin="azureuser"

az vm create -n $vm -g $rg --image $img --size $size --admin-username $admin --generate-ssh-keys 

az vm open-port --port 80 -n $vm -g $rg

az vm run-command invoke -g $rg -n $vm --command-id RunShellScript --scripts "sudo apt update && sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql"

ssh $admin@$(az vm show -g $rg -n $vm --show-details --query "publicIps" --output tsv) 

