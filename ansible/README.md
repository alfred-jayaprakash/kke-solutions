# Ansible Tasks
## General Ansible Tips
  * Dry-run your code by running `ansible-playbook <filename> --check` e.g. `ansible-playbook foo.yml --check`
  * Always verify the successful completion of tasks using the following steps:
    * Run the actual code, login to the target hosts and verify whether the required changes are complete
    * An easier, time-saving way to run verification commands in multiple hosts is using the Ansible Ad-hoc command as below:
      * `ansible <hostname> -a "<command>" -i <inventory file>`
      * Examples:
        * `ansible stapp01 -a "ls -ltr /var/www/html" -i inventory`
        * `ansible all -a "cat /opt/data/blog.txt" -i inventory` ('all' is a special keyword - Runs the specified command in all managed hosts)
   
---
For general tips on getting better at KodeKloud Engineer tasks, [click here](../README.md)