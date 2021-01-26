# Scripts and things
#
### podconnect.sh
This script enables easy bootstrapping into a bash shell on a running pod. You are presented a list of RUNNING pods and can select the desired pod on which to enter a shell.
Exiting the shell via ctrl+c or 'exit' will return you to the selection menu. By default, the kubeconfig used is ~/.kube/config
#### Usage:
> `$ ./podconnect.sh /path/to/kube.config`
#
