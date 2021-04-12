# Rollback a deployment in Kubernetes
## Solution
* Run describe and note down the current image version that has been deployed e.g. `kubectl describe deployment httpd-deploy`
* Now rollback the deployment as per question:
`kubectl rollout undo deployment httpd-deploy`
* Wait until you see `deployment 'httpd-deploy' rolled back` message
* Make sure all the pods are in the running `kubectl get deployments httpd-deploy`

## Verification
* Run describe to verify that the image version has been rolled back e.g. `kubectl describe deployment httpd-deploy`

---
For tips on getting better at KodeKloud Engineer Kubernetes tasks, [click here](./README.md)