# Run a Docker Container
## Solution
* First SSH to the required server as per the question
* Next, run the docker container with the respective name and image
`sudo docker run -d --name nginx_3 -p 8888:80 nginx:alpine`
* Verify that the container is running: `sudo docker ps`

## Verification
* Run curl to verify that you are getting back a valid HTML: `curl http://localhost:8888/`

---
For tips on getting better at KodeKloud Engineer Docker tasks, [click here](./README.md)