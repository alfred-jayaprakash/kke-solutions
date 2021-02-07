
# Docker Volumes Mapping
## Solution
* First, SSH to the required host indicated in the question
* Pull the image specified in the question as below: `sudo docker pull ubuntu:latest` (In this example, `ubuntu:latest` was the image mentioned in the question)
* Run a docker container with the name specified in the question using the image you just pulled. Since, you need to keep the container running, you need to use the option `-it`. Also make sure you are mapping the correct local directory to the directory path in the container (In this example, `/opt/sysops` is mapped to `/usr/src` on the container):
`sudo docker run --name apps -v /opt/sysops:/usr/src -d -it ubuntu:latest`
* Make sure container is running: `sudo docker ps`
* Finally, copy the file mentioned in the question to the local directory you mapped to the container: `cp /tmp/sample.txt /opt/sysops/`

## Verification
* Check that the file you copied in the last step can be seen in the container: `sudo docker -it apps ls /usr/src`

---
For tips on getting better at KodeKloud Engineer Docker tasks, [click here](./README.md)
