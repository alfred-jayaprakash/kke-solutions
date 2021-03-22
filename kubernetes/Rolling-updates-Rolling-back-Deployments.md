# Rolling updates and Rolling back deployments in Kubernetes
## Solution
* First create the new namespace: `kubectl create ns xfusion`
* Next under `/tmp` directory create a `dep.yaml` file with the following contents. Make sure to change the names, image, replicas and rollingUpdate values as per question:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpd-deploy
  namespace: xfusion
spec:
  replicas: 5
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 2
  selector:
    matchLabels:
      app: httpd
  template:
    metadata:
      labels:
        app: httpd
    spec:
      containers:
        - name: httpd
          image: httpd:2.4.28
```
* Perform a rolling update by running: 
`kubectl set image deployment httpd-deploy --namespace xfusion  httpd=httpd:2.4.43 --record=true` 
e.g. Here 'httpd-deploy' is the name of the deployment and 'httpd' is the name of the container. Question asked to upgrade to version httpd:2.4.43.
* You can check the rollout deployment status by running 
`kubectl rollout status deployment httpd-deploy --namespace xfusion`
* Wait until you see 'successfully rolled out' message something like below:
```
Waiting for rollout to finish: 4 out of 5 new replicas have been updated...
deployment "httpd-deploy" successfully rolled out
```
* Now rollback the deployment as per question:
`kubectl rollout undo deployment httpd-deploy --namespace xfusion`
* Wait until you see `deployment 'httpd-deploy' rolled back` message
* Make sure all the pods are in the running `kubectl get deployments httpd-deploy --namespace xfusion`

## Verification
* Run describe to verify that the image version has been rolled back e.g. `kubectl describe deployments httpd-deploy --namespace xfusion`

---
For tips on getting better at KodeKloud Engineer Kubernetes tasks, [click here](./README.md)