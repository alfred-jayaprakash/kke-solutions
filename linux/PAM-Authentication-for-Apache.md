# PAM Authentication for Apache
## Solution
* Install pwauth in all the appserver hosts `sudo yum --enablerepo=epel -y install mod_authnz_external pwauth`
* Edit the file `/etc/httpd/conf.d/authnz_external.conf` and add the following at the end of the file. Make sure not to duplicate or overlap with existing entries in this file
```
<Directory /var/www/html/protected>
  AuthType Basic
  AuthName "PAM Authentication"
  AuthBasicProvider external
  AuthExternal pwauth
  require valid-user
</Directory>
 ```
* Create the protected directory under the document root, `/var/www/html`, if it does not already exist e.g. `mkdir -p /var/www/html/protected`
* Create an `index.html` under `/var/www/html/protected`, if it does not already exist, with any test content
* Restart httpd
```
sudo systemctl restart httpd
sudo systemctl status httpd
```

## Verification
* Execute curl command from a appserver host. You should see a 'Forbidden error'. i.e `curl http://localhost:8080/protected/`. More particularly, you can just print the HTTP header to see if you receive 'HTTP 403' by running curl with `-I` option i.e. `curl -I http://localhost:8080/protected/`
* From the same host re-run curl command but this time with the given user and password. You should see a valid content 
`curl -u jim:8FmzjvFU6S http://localhost:8080/protected/`
* Repeat the steps for other appserver hosts. Either you can SSH to individual host to run or test from Jump Host e.g. `curl -I http://stapp01:8080/protected/`
* Finally, test the loadbalancer URL in browser by accessing `Select Port to View on Host 1` and provide port `80`. You should see the browser prompting you for Id and Password. After giving the Id and Password from question, the page should load successfully.

---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)

