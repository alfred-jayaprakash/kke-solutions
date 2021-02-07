# Create Docker Network
## Solution
* First SSH to the required server as per the question
* Next [create a docker network](https://docs.docker.com/engine/reference/commandline/network_create/) based on the values provided in the question. In this example, Docker network named `blog` was asked to be created as `macvlan` type with subnet as `192.168.0.0/24` and iprange as `192.168.0.3/24`:
```
sudo docker network create -d macvlan --subnet=192.168.0.0/24 --ip-range=192.168.0.3/24 blog
```
* Verify that the network has been created successfully using the following commands:
```
sudo docker network ls
sudo docker network inspect blog
```