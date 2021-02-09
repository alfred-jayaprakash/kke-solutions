# Docker Copy Operations
## Solution
* First SSH to the required server as per the question
* Next perform a docker copy of the file on the host to the container specified. In the below example, a local file called `nautilus.txt.gpg` was asked to be copied to `/home` location in the container `ubuntu_latest`:
`sudo docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/home`
* Verify that the file has been copied successfully using the following command:
`sudo docker exec ubuntu_latest ls -ltr /home`
---
For tips on getting better at KodeKloud Engineer Docker tasks, [click here](./README.md)
