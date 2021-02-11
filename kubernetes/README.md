# Kubernetes Tasks
## General Kubernetes Tips
* Always create your Kubernetes YAML configurations offline as you would do in real-life. I use 'Visual Studio Code' to create my YAML file as per the question and then apply it in the KKE environment.
* Navigate to `/tmp` directory and create your Kubernetes configuration file. Then you can simply run `kubectl create -f yourfile.yaml`. You don't need to use sudo privileges.
* Another important tip is to make use of the free [Katakoda Kubernetes Playground](https://www.katacoda.com/courses/kubernetes/playground) to test your changes.
As this is a Katakoda environment, it works in the same way as Kodekloud Engineer. Good thing is that
there is no time limit. Also you can easily close browser and open another environment quickly. So, the
advice here is to:
  * Open the task in Kodekloud Engineer, note down the question and press `Try Later`
  * Then take your time to create the required Kubernetes configurations offline in your favorite IDE
  * Open KataKoda Playground, apply and test your changes until you are satisified
  * Reopen question in Kodekloud Engineer, apply your changes and verify. Bam! You finished your task in time for bonus points.
* Verify the successful completion of the tasks using one of the following steps:
    * Use browser by clicking `Select port to view on Host 1` tab especially for tasks that ask you to configure a NodePort. 
      * Click `Open Port on Host 1` tab and specify the NodePort and click `Connect`
      * Check that the URL loads.
    * Exec command - Especially useful to verify tasks that involve running a server listening to a port e.g. Nginx, Wordpress, Nagios (or) Verify volume mounts
      * `kubectl exec <podname> --namespace <namespace> -- <command>`
      * Examples:
        * `kubectl exec nginx-nautilus -- curl http://localhost:8080/`
        * `kubectl exec nginx-nautilus --namespace xfusion -- ls /opt/data`
    * Shell - You can also get a shell to Kubernetes Pod like this. This is useful when you need to run multiple verification commands:
      * `kubectl exec -it nginx-nautilus -- /bin/bash`
      * You can print all environment variables by running command `printenv` in the pod command shell
    * Logs - Useful for tasks that require you to print an output e.g. echo:
      * `kubectl logs <podname>`. For example, `kubectl logs my-pod` 
      
## Common mistakes
* Not reading the question properly. Especially, when you redo the same question, all the names and port values would've changed in the new question. So pay attention to that. 
* Not waiting until the Pods are in `Running` state. Check the pods are in `Running` before you press that `Finish` button.
* Not paying attention to namespaces. Make sure all the required resources are in the correct namespace.
* Selector labels are often misunderstood, especially in tasks that require defining a service and a deployment. Note that when a service and a deployment are involved, there are totally 5 places where labels will be used.
The below is a simplistic example where a label is shown in each of the 5 places. Now:
  * 'LABEL A' and 'LABEL C' are resource-level labels. They are just used for identification purposes. They can be set to any values or as per question.
  * Service selector 'LABEL B' is important and should match pod label 'LABEL E'. Selector labels are like 'search criteria' and are used to identify the pods that need to be exposed.
  * Deployment selector 'LABEL D' should also match pod label 'LABEL E'. This is to tell Kubernetes which Pod the Deployment should manage.
  * Due to lack of understanding, people configure all the labels with same values. But this will work fine as (LABEL B == LABEL E) and (LABEL D == LABEL E)
```yaml
apiVersion: ....
kind: Service
metadata:
  labels:
     [LABEL A]
spec:
  selector:
     matchLabels:
       [LABEL B]
---
apiVersion: ....
kind: Deployment
metadata:
  labels:
     [LABEL C]
spec:
  selector:
     matchLabels:
       [LABEL D]
  template: 
    metadata:
      labels:
        [LABEL E]   
```
In case of a Service and Pod, there are only 3 labels (See below). Labels B and C should match:
```yaml
apiVersion: ....
kind: Service
metadata:
  labels:
     [LABEL A]
spec:
  selector:
     matchLabels:
       [LABEL B]
---
apiVersion: ....
kind: Pod
metadata:
  labels:
     [LABEL C] 
```
---
For general tips on getting better at KodeKloud Engineer tasks, [click here](../README.md)

