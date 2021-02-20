# Docker Tasks
## General Docker Tips
* For tasks that require you to troubleshoot a Dockerfile or create a Dockerfile, make sure you test the file by running a docker build on the same directory as Dockerfile:
`docker build -t my_image .`
* Another important tip is to make use of the free [Katakoda Docker Playground](https://www.katacoda.com/courses/docker/playground) to test your Docker changes. So the recommendation is to:
  * Open the task in Kodekloud Engineer, note down the question and press `Try Later`
  * Open KataKoda Playground, prepare docker commands, execute and test your changes until you are satisified
  * Reopen question in Kodekloud Engineer, apply your changes and verify. Bam! You finished your task in time for bonus points.
* Always verify the successful completion of the task using one or more of the approaches below:
  * Use browser by clicking `Open Port on Host 1` tab especially for tasks that ask you to configure a Host Port (Docker). 
    * Click `Open Port on Host 1` tab and specify the port and click `Connect`
    * Check that the URL loads.
  * Exec command - Especially useful to verify tasks that involve running a server listening to a port e.g. Nginx, HTTPD (or) Verify volume mounts
    * `docker exec -it <container_id_or_name> <command>`
    * Examples:
      * `docker exec -it nginx_ubuntu ls /tmp/execWorks`
  * Shell - You can also get a shell to a Docker Container like this. This is useful when you need to run multiple verification commands:
    * `docker exec -it nginx_ubuntu /bin/bash` 
  * Logs - Useful for tasks that require you to print an output e.g. echo:
    * `docker logs -f <container_id_or_name>`. For example, `docker logs -f nginx_ubuntu`       

---
For general tips on getting better at KodeKloud Engineer tasks, [click here](../README.md)

