# Install and configure DB Server
## Solution
### Step 1 - MariaDB installation and configuration
* Login to Database host (stdb01)
* Install and enable MariaDB server
```UNIX
sudo yum install httpd mariadb mariadb-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo systemctl status mariadb
```
* Setup MariaDB using the built-in secure installation script (Default Root password is blank. So just press ENTER)
```UNIX
sudo mysql_secure_installation
```
* When prompted, provide the following values
```
Set root password? [Y/n] n
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
```
* Login to database using the root user (default password is blank. So just press ENTER)
```UNIX
mysql -u root -p
```
Once you have logged in, then run the below SQL commands:
```SQL
MariaDB [(none)]>CREATE DATABASE kodekloud_db5;
MariaDB [(none)]>GRANT ALL PRIVILEGES on kodekloud_db5.* to 'kodekloud_roy'@'%' identified by 'kodekloud';
MariaDB [(none)]>FLUSH PRIVILEGES;
MariaDB [(none)]>exit
```
* Now to go Jump Host and copy the Database script to /tmp directory on stdb01
```UNIX
scp /home/thor/db.sql peter@stdb01:/tmp
```
* Now login back to database host and load the database script as below
```UNIX
mysql -u kodekloud_roy -p kodekloud_db5 < /tmp/db.sql
```
#### Verify MariaDB setup
* Use mysqlshow to verify that the account you created works as expected, especially with host as stdb01. You should see all the WordPress tables listed i.e. wp...
```UNIX
mysqlshow -u kodekloud_roy -h stdb01 kodekloud_db5
```
In case the above doesn't work, try as `mysqlshow -u kodekloud_roy -h stdb01 -p kodekloud_db5`

### Step 2 - WordPress configuration
* Login to storage server (ststor01)
* Edit `wp_config.php` from the location specified in the question and set the DB details
```
define('DB_NAME', 'kodekloud_db5');
define('DB_HOST', 'stdb01');
define('DB_USER', 'kodekloud_roy');
define('DB_PASSWORD', 'kodekloud');
```
#### Verify WordPress setup
* Click tab `Select port to view on Host 1`, and after adding port 80 click on Display Port
* You should see a sample Blog WordPress site loaded

---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)