# kke-solutions
## Solutions for Kodekloud Engineer
### Introduction
This GIT project contains my own solutions to the tasks in Kodekloud Engineer. As a personal advise, please use the solutions only for your reference. It's best that you attempt the tasks yourself first by reading through the original documentation. This will immensely help you develop your skills. After all, that's the objective of Kodekloud Engineer isn't it?

### General Tips
* **Begin with verification in mind**
    * Always begin the task with an idea on how to verify the successful completion of the task. Verification usually is one or more of the below:
      * **For Linux tasks**
        * Use CURL command to the test the task
        * Use browser by clicking 'Open Port on Host 1' tab to open the site on specific port
      * **For Ansible tasks**
        * Dry-run your code by running `ansible-playbook <filename> --check` e.g. `ansible-playbook foo.yml --check`
        * Run the actual code, login to the target hosts and verify whether the required changes are complete
        * An easier, time-saving way to run verification commands in multiple hosts is using the Ansible Ad-hoc command as below:
          * `ansible <hostname> -a "<command>" -i <inventory file>`
          * Examples:
            * `ansible stapp01 -a "ls -ltr /var/www/html" -i inventory`
            * `ansible all -a "cat /opt/data/blog.txt" -i inventory` ('all' is a special keyword - Runs the specified command in all managed hosts)
      * **For Puppet tasks**
        * Validate the syntax by running `puppet parser validate <filename>` on the same directory e.g. `puppet parser validate demo.pp`
        * Login to target hosts and dry-run the code by running `sudo puppet agent -tv --noop`. Notice that the output will state if there are some changes to be made in the system
        * Finally, execute the task by e.g. Appservers and run `sudo puppet agent -tv` 
      * **For Docker and Kubernetes tasks**
        * Use browser by clicking `Open Port on Host 1` tab especially for tasks that ask you to configure a NodePort (Kubernetes) or Host Port (Docker). 
          * Click `Open Port on Host 1` tab and specify the NodePort/Host Port and click `Connect`
          * Check that the URL loads.
        * Exec command - Especially useful to verify tasks that involve running a server listening to a port e.g. Nginx, Wordpress, Nagios (or) Verify volume mounts
          * `kubectl exec <podname> --namespace <namespace> -- <command>` (or) `docker exec -it <container_id_or_name> <command>`
          * Examples:
            * `kubectl exec nginx-nautilus -- curl http://localhost:8080/`
            * `kubectl exec nginx-nautilus --namespace xfusion -- ls /opt/data`
            * `docker exec -d nginx_ubuntu ls /tmp/execWorks`
        * Shell - You can also get a shell to Kubernetes Pod or Docker Container like this. This is useful when you need to run multiple verification commands:
          * `kubectl exec --stdin --tty nginx-nautilus -- /bin/bash`
          * `docker exec -it nginx_ubuntu /bin/bash` 
        * Logs - Useful for tasks that require you to print an output e.g. echo:
          * `kubectl logs <podname>`. For example, `kubectl logs my-pod` 
          * `docker logs -f <container_id_or_name>`. For example, `docker logs -f nginx_ubuntu`
* **It's okay to "Try Later"**
  * If you think you took too much time or screwed up the environment, click `Try Later` and come back to the task again. Most importantly, read through the question again as the question values will change with each reload of the question.
* **Go for Bonus points**
  * If you complete the task within 15 minutes, you get half of the task points as bonus points. For example, if the task is 500 points worth, if you complete the task by 15 minutes, you will get 500 + 250 points. One tip is to take time to get the question right and save the answer in a Text Editor on your computer, click `Try Later` and redo the task again, but this time quicker to earn bonus points.
* **Make it easy for the Reviewers** 
  * If you are copy-pasting code in to vi editor, pause for 5-10 secs so that reviewers would be able to take one good look at the code during reviews
  * Use `more` command for files, so that reviwers can clearly see the content
  * Perform steps in the same tab, if possible, as only the main tab is recorded
  * Run verify steps e.g. `curl` and state output steps e.g. `kubectl get pods`/`systemctl status` so that reviewers can cross-check the outcome


