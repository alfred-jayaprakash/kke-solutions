# Install Packages Using a Jenkins Job
## Solution
### Step 1: Enable password-less sudo in all appservers
* SSH to each of the appserver and run `sudo visudo`
* In the resulting file, at the end of the file add password-less sudo for respective sudo user:
stapp01:
```
tony ALL=(ALL) NOPASSWD: ALL
```
stapp02:
```
steve ALL=(ALL) NOPASSWD: ALL
```
stapp03:
```
banner ALL=(ALL) NOPASSWD: ALL
```
### Step 2: Install SSH Plugin in Jenkins
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Under  `Jenkins > Manage Jenkins >  Manage Plugins` click `Available` and search for `SSH` plugin.
* Select the plugin and click `Download now and install after restart`
* In the following screen, click checkbox `Restart Jenkins when installation is complete and no jobs running`. Wait for the screen to become standstil

### Step 3: Add sudo users and their SSH credentials in Jenkins:
* You can try to refresh your browser after a few secs.
* Under `Jenkins > Manage Jenkins > Manage Credentials`, click `Global` under `Stores scoped to Jenkins` and `Add Credentials`
* Leave kind as `Username with Password` and Scope as `Global (..)`
* Setup credentials for tony@stapp01:
```
Username: tony
Password: Ir0nM@n
ID: stapp01
```
* Repeat the steps above to add steve and banner for stapp02 and stapp03 respectively

### Step 4: Add SSH Hosts in Jenkins
* Click `Jenkins > Manage Jenkins > Configure System`
* Under `SSH Remote Hosts` click `Add Host` and provide the following values:
```
Hostname: stapp01
Port: 22
Credentials: Choose 'tony' from the list
Pty: Select checkbox
```
* Click `Check Connection` to make sure connection is successful
* Repeat steps to add stapp02 and stapp03 hosts.

### Step 5: Create the Build Job
* Click `New item` and in the following screen:
```
Name: httpd-php (Keep 'Freestyle Project' as selected) and click Ok
```
* Under `Build` add a `Build Step` with `Execute shell script on remote host using SSH`
and under `SSH Site` select `tony@stapp01:22`
* In the command text area, provide the following. Make sure to update the HTTP Port (the line that has `sed`) and PHP version values (i.e. For installing PHP 7.4 then change the line `sudo yum-config-manager --enable remi-php70` to `sudo yum-config-manager --enable remi-php74`) as per the question.
```
sudo yum -y install epel-release
sudo yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum install -y yum-utils
sudo yum-config-manager --enable remi-php70
sudo yum install -y php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd httpd
sudo sed -i 's/^Listen 80$/Listen 8082/g' /etc/httpd/conf/httpd.conf
sudo systemctl restart httpd
sudo systemctl status httpd
```
* Repeat the above steps to add host and commands `steve@stapp02:22` and `banner@stapp03:22` as well
* Finally click `Save` 

### Step 6:Run the build
* Click the newly created job, `httpd-php` on the home page and in the following screen click `Build Now`
* You should see a new build starting up on the left lower screen
* Click that build and click `Console Output` and search the log for any errors 
* Wait until the build is completed successfully and run the 'Verification' steps below
* Click the 'Build Now' again and monitor console output for any errors. Task expects that you should be able to click 'Build' any number of times and there are no errors.
* Perform verification steps below again

## Verification
* On Jump host, run 'curl' against each host: `curl http://stapp01:5003/index.php`
  * Should return valid HTML content that returns lots of information about the PHP server
  * Repeat 'curl' test for other hosts as well
* `Select port to view on Host 1` and connect to port `80`
  * On the resulting browser page add `/index.php` in the address bar
  * You should see PHP info page. Make sure the PHP version shown is same as the question
  * With each reload of page, the `System` should change between stapp01, stapp02 and stapp03

---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)
