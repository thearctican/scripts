#!/bin/bash

#This script is intended to bootstrap kubectl and allow for selection of target pods in a sane way. 
echo "By default, this utility will use the kubeconfig at in your account's default location. You can specify an alternative configuration by passing the file path as an argument for this script."
sleep 3
echo "Using kubeconfig:"

#Default to standard kubeconfig path if no config file is specified at runtime
echo $HOME
kubeconfigpath="${1:-$HOME/.kube/config}"

#Confirm that the path read from 'read' is correct
echo $kubeconfigpath

#call the specified path to the config to get pods and filter for polaris pods.
podlist=`kubectl --kubeconfig "$kubeconfigpath" get pods --field-selector status.phase=Running -o custom-columns=":metadata.name"`


#Select target pod and initiate a shell prompt
if [ `grep -q namespace $kubeconfigpath; echo $?` = 0 ]; then	
	select pod in $podlist
		do
    		echo You have selected $pod
			kubectl --kubeconfig $kubeconfigpath exec -it $pod -- /bin/bash ; exit
		done
	else
		nslist=`kubectl --kubeconfig "$kubeconfigpath" get namespaces -o custom-columns=":metadata.name"`
		select namespace in $nslist
				do
					echo "You have selected $namespace. Please select your pod:"
					nspod=`kubectl --kubeconfig "$kubeconfigpath" --namespace $namespace get pods --field-selector status.phase=Running -o custom-columns=":metadata.name"`
					select pod in $nspod
						do
							echo You have selected $pod in $namespace
							kubectl --kubeconfig "$kubeconfigpath" --namespace $namespace exec -it $pod -- /bin/bash ; exit
						done
				done
fi
exit
