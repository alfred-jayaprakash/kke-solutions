# Ansible Inventory Update
## Solution
* First edit the file `/home/thor/playbook/inventory` to include the required host e.g. stapp02
```
stapp02  ansible_host=172.16.238.11   ansible_connection=ssh   ansible_user=steve ansible_ssh_pass=Am3ric@
```
If other hosts are asked, refer to the full inventory here: [Full Inventory](./inventory)

## Verification
* Run the playbook without making any changes: `ansible-playbook -i inventory playbook.yml`
* Verify that the playbook changes are done on the required host by running `ansible` command on the Jump Host itself. Modify the command portion in double quotes as per the `playbook.yml` e.g. Check httpd is installed and started by running `systemctl status httpd`
```
ansible all -i inventory -a "systemctl status httpd"
```
You should see the required output. e.g. Systemctl service status

---
For tips on getting better at KodeKloud Engineer Ansible tasks, [click here](./README.md)