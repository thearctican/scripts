#!/bin/bash

#This script is intended to bootstrap kubectl and allow for selection of target pods in a sane way. 
echo "By default, this utility will use the kubeconfig at the location '~/.kube/config'. You can specify an alternative configuration by passing it as an argument for this script."
echo "Using kubeconfig:"

#Default to standard kubeconfig path if no config file is specified at runtime
kubeconfigpath="${1:-~/.kube/config}"

#Confirm that the path read from 'read' is correct
echo $kubeconfigpath

#call the specified path to the config to get running pods.
podlist=`kubectl --kubeconfig "$kubeconfigpath" get pods --field-selector status.phase=Running -o custom-columns=":metadata.name"`
echo $podlist

#Select target pod and initiate a shell prompt
select pod in $podlist
    do  echo You have selected $pod;kubectl --kubeconfig $kubeconfigpath exec -it $pod /bin/bash
done 
