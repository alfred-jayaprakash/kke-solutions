# Ansible Ping Module
## Solution
* First generate a SSH key by running `ssh-keygen` on Jump Host as:
`ssh-keygen -t rsa -b 2048`
* Next, use `ssh-copy-id` to setup password-less authentication to the host specification in the question. 
`ssh-copy-id tony@stapp01` (In this example, question asks for stapp01)
* Make sure you able to SSH to the host and with the sudo user without being prompted for password:
`ssh tony@stapp01` (No password prompt is seen)
* Finally, change to the `/home/thor/ansible` directory and test using Ansible adhoc ping command as:
`ansible stapp01 -m ping -i inventory -v`
You should see the message 'SUCCESS' in the output

---
For tips on getting better at KodeKloud Engineer Ansible tasks, [click here](./README.md)