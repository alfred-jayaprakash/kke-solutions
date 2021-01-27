# Kubernetes Tasks
## General Kubernetes Tips
* Navigate to `/tmp` directory and create your Kubernetes configuration file. Then you can simply run `kubectl create -f yourfile.yaml`
* Verify the successful completion of the tasks using one of the following steps:
    * Use browser by clicking `Open Port on Host 1` tab especially for tasks that ask you to configure a NodePort. 
      * Click `Open Port on Host 1` tab and specify the NodePort and click `Connect`
      * Check that the URL loads.
    * Exec command - Especially useful to verify tasks that involve running a server listening to a port e.g. Nginx, Wordpress, Nagios (or) Verify volume mounts
      * `kubectl exec <podname> --namespace <namespace> -- <command>`
      * Examples:
        * `kubectl exec nginx-nautilus -- curl http://localhost:8080/`
        * `kubectl exec nginx-nautilus --namespace xfusion -- ls /opt/data`
    * Shell - You can also get a shell to Kubernetes Pod like this. This is useful when you need to run multiple verification commands:
      * `kubectl exec --stdin --tty nginx-nautilus -- /bin/bash`
    * Logs - Useful for tasks that require you to print an output e.g. echo:
      * `kubectl logs <podname>`. For example, `kubectl logs my-pod` 
      * `docker logs -f <container_id_or_name>`. For example, `docker logs -f nginx_ubuntu`

## Common mistakes
* Not waiting until the Pods are in `Running` state. Check the pods are in `Running` before you press that `Finish` button.
* Not paying attention to namespaces. Make sure all the required resources are in the correct namespace.
* Not reading the question properly. Especially, when you redo the same question, all the names and port values would've changed in the new question. So pay attention to that. 

