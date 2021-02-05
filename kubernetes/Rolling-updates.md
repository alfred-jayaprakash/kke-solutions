# Rolling updates in Kubernetes
## Solution
* First check the existing deployments: `kubectl get deployments`
* Check the image and container name currently used in the deployment by running `kubectl describe deployment nginx-deployment`
* Performing a rolling update by running: `kubectl set image deployment nginx-deployment nginx-container=nginx:1.19` e.g. Here nginx-deployment is the name of the deployment and nginx-container is the name of the container. Question asked to upgrade to version nginx:1.19.
* You can check the rollout deployment status by running `kubectl rollout status deployment nginx-deployment` as wait until you see 'successfully rolled out' message:
```
Waiting for rollout to finish: 2 out of 3 newreplicas have been updated...
deployment 'nginx-deployment' successfully rolled out
```
* Make sure the pods are in running state before pressing `Finish`

## Verification
* Run describe of the pods to verify that the image version has been updated e.g. `kubectl describe pod nginx-deployment-asfdsf`

---
For tips on getting better at KodeKloud Engineer Kubernetes tasks, [click here](./README.md)