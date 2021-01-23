# Kubernetes Tasks
## General Kubernetes Tips
* Navigate to `/tmp` directory and create your Kubernetes configuration file. Then you can simply run `kubectl create -f yourfile.yaml`
* Verify the successful completion of the tasks using one of the following steps:
    * Use browser by clicking 'Open Port on Host 1' tab and specify the NodePort (if provided). Check that the URL loads.
    * Exec command:
      * `kubectl exec <podname> --namespace <namespace> -- <command>`. For example, `kubectl exec nginx-nautilus -- curl http://localhost:8080/`
    * Logs (For some tasks only):
      * `kubectl logs <podname>`. For example, `kubectl logs my-pod` 


## Common mistakes
* Not waiting until the Pods are in Running state. Check the pods are in 'Running' before you press that Finish button
* Not paying attention to namespaces. Make sure all the required resources are in the same namespace
* Not reading question properly. Especially, when you redo the same question, all the names and port values would have changed in the new question. So pay attention to that. 

