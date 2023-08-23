#!/bin/bash

vm="vm3"
rg="rg-demo2"


az vm stop -n $vm -g $rg --no-wait && az vm deallocate -n $vm -g $rg --no-wait && az vm delete -n $vm -g $rg --no-wait && az vm list -d
