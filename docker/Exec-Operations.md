# Docker Exec Operations
## Solution
* First SSH to the required server as per the question
* Next, open a shell to Docker container using the exec command:
`sudo docker exec -it kkloud /bin/bash`
* In the resulting shell prompt, first install apache2:
`apt-get install apache2`
* Change the default Apache http port to the port mentioned in the question e.g.3001:
`sed -i 's/80/3001/g' /etc/apache2/ports.conf`
* Verify the changes by performing: `cat /etc/apache2/ports.conf`
* Finally, start Apache2 by running `apachectl -k start`
## Verification
* Find out the IP Address of the container by checking `/etc/hosts`. This is present in the last line of the `/etc/hosts` file. Alternatively, you can use the command `awk 'END{print $1}' /etc/hosts` to print out the IP address.
* Run curl to verify that you are getting back a valid HTML. Try localhost, 127.0.0.1 and also the container IP address e.g. 172.17.0.2:
`curl http://localhost:3001/`
`curl http://127.0.0.1:3001/`
`curl http://172.17.0.2:3001/`
* Exit the container shell by typing `exit`
---
For tips on getting better at KodeKloud Engineer Docker tasks, [click here](./README.md)
