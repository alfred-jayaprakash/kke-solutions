# Create Docker Image from Container
## Solution
* First SSH to the required server as per the question
* Make sure the container in question e.g. `ubuntu_latest` is running:
`sudo docker ps`
* Create an image with required name:tag (as per question) from the running container (as per question) using the below command:
`sudo docker commit ubuntu_latest beta:devops`

## Verification
* Check that the newly created image is present in the local registry:
`sudo image ls`
You should see the new `image:tag` listed

---
For tips on getting better at KodeKloud Engineer Docker tasks, [click here](./README.md)
