# kke-solutions
## Solutions for Kodekloud Engineer
### Introduction
This GIT project contains my own solutions to the tasks in Kodekloud Engineer. As a personal advise, please use the solutions only for your reference. It's best that you attempt the tasks yourself first by reading through the original documentation. This will immensely help you develop your skills. After all, that's the objective of Kodekloud Engineer isn't it?

### General Tips
* **Begin with verification in mind.**
    * Always begin the task with an idea on how to verify the successful completion of the task. Verification usually is one or more of the below:
      * **For Linux tasks**
        * Use CURL command to the test the task
        * Use browser by clicking 'Open Port on Host 1' tab to open the site on specific port
      * **For Ansible tasks**
        * Dry run the code by `ansible-playbook <filename> --check` e.g. `ansible-playbook foo.yml --check`
        * Run the actual code, login to the target hosts and verify whether the required changes are complete 
      * **For Puppet tasks**
        * Validate the syntax by running `puppet parser validate <filename>` e.g. `puppet parser validate demo.pp`
        * Login to target hosts and dry-run the code by running `sudo puppet agent -tv --noop`. Notice that the output will state if there are some changes to be made in the system
        * Finally, execute the task by e.g. Appservers and run `sudo puppet agent -tv` 
      * **For Docker and Kubernetes tasks**
        * Use browser by clicking 'Open Port on Host 1' tab and specify the NodePort (Kubernetes) or Host port (Docker)
        * Exec command:
          * `kubectl exec <podname> --namespace <namespace> -- <command>`. For example, `kubectl exec nginx-nautilus -- curl http://localhost:8080/`
          * `docker exec -it ubuntu_bash bash` or `docker exec -d ubuntu_bash touch /tmp/execWorks`
* **It's okay to "Try Later"**
  * If you think you took too much time or screwed up the environment, click `Try Later` and come back to the task again. Most importantly, read through the question again as the question values will change with each reload of the question.
* **Go for Bonus points**
  * If you complete the task within 15 minutes, you get half of the task points as bonus points. For example, if the task is 500 points worth, if you complete the task by 15 minutes, you will get 500 + 250 points. One tip is to take time to get the question right and save the answer in a Text Editor on your computer, click 'Try Later` and redo the task again, but this time quicker to earn bonus points.
* **Make it easy for the Reviewers** 
  * If you are copy-pasting code in to vi editor, pause for 5-10 secs so that reviewers would be able to take one good look at the code during reviews
  * Use `more` command for files, so that reviwers can clearly see the content
  * Perform steps in the same tab, if possible, as only the main tab is recorded
  * Run verify steps e.g. `curl` and state output steps e.g. `kubectl get pods` so that reviewers can see the outcome


