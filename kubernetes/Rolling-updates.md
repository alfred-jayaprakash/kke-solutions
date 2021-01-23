# Rolling updates in Kubernetes
## Solution
* First check the existing deployments: `kubectl get deployments`
* Check the image and container name currently used in the deployment by running `kubectl describe deployment nginx-deployment`
* Performing a rolling update by running: `kubectl set image deployment nginx-deployment nginx-container=nginx:1.19` e.g. Here nginx-deployment is the name of the deployment and nginx-container is the name of the container. Question asked to update to version nginx:1.19.
* Make sure the pods are in running state before pressing `Finish`

## Verification
* Run describe of the pods to verify that the image version has been updated e.g. `kubectl describe pod nginx-deployment-asfdsf`
