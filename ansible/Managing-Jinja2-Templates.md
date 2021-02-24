# Managing Jinja2 Templates using Ansible
## Solution
* First edit the file `/home/thor/ansible/playbook.yml` to include the required host e.g. stapp03
```yaml
- hosts: stapp03
  become: yes
  roles:
    - role/httpd
```
* Create a Jinja2 template file `/home/thor/ansible/role/httpd/templates/index.html.j2` with the following content:
```jinja2
This file was created using Ansible on {{ ansible_hostname }}
```
* Edit the file `/home/thor/ansible/role/httpd/tasks/main.yml` to add a task to copy the template to `/var/www/html` on the required host
  * Before:
  ```yaml
  ---
  #task file for role/test
  - name: install the latest version of httpd
    yum:
      name: httpd
      state: latest
  - name: Start service httpd
    service:
      name: httpd
      state: started
  ```
  * After:
  ```yaml
  ---
  #task file for role/test
  - name: install the latest version of httpd
    yum:
      name: httpd
      state: latest
  - name: Start service httpd
    service:
      name: httpd
      state: started
  - name: Use Jinja2 template to generate index.html
    template:
      src: /home/thor/ansible/role/httpd/templates/index.html.j2
      dest: /var/www/html/index.html
      mode: "0655"
      owner: "{{ ansible_user }}"
      group: "{{ ansible_user }}"
  ```

## Verification
* Run `ansible-playbook -i inventory playbook.yml` on the `/home/thor/ansible` directory. The playbook should run without any errors
* Then check that `/var/www/html/index.html` has be written according to the template by running `ansible stapp03 -a "cat /var/www/html/index.html" -i inventory` (substitute `stapp03` with the corresponding host)
---
For tips on getting better at KodeKloud Engineer Ansible tasks, [click here](./README.md)