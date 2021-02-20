# Write Docker file
## Solution
* First SSH to the required server as per the question
* Next edit the Dockerfile in the given location
* Make sure the port 5003 is replaced as per the question
```Dockerfile
FROM ubuntu
RUN apt-get update
RUN apt-get install apache2 -y
RUN sed -i "s/80/5003/g" /etc/apache2/ports.conf
EXPOSE 5003
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND", "-k", "start"]
```
## Verification
* First try to build an image using this Dockerfile using `sudo docker build -t my_image .`
* You should see that the image gets built successfully with any errors
* Next is try to run the image as `sudo docker run --name my_srv -p 5003:5003 -d my_image` (Change 5003 to the port asked in the question). It should run without any errors.
* Lastly test using curl as `curl http://localhost:5003`. You should a HTML content returned from the container.

---
For tips on getting better at KodeKloud Engineer Docker tasks, [click here](./README.md)
