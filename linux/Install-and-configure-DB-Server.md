# Install and configure DB Server
## Solution
### Step 1 - MariaDB installation and configuration
* Login to Database host (stdb01)
* Install and enable MariaDB server
```
sudo yum install httpd mariadb mariadb-server 
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo systemctl status mariadb
```
* Setup MariaDB using the built-in secure installation script
```
sudo mysql_secure_installation
```
* When prompted, provide the following values
```
Set root password? [Y/n] n
Remove anonymous users? [Y/n] y
Disallow root login remotely? [Y/n] y
Remove test database and access to it? [Y/n] y
Reload privilege tables now? [Y/n] y
```
* Set the MariaDB Root password using below
```
mysql -u root -p
```
Once you've setup the root password create the database, the user and grant them privileges ('kodekloud' is set as the password here)
```
MariaDB [(none)]>CREATE DATABASE kodekloud_db5;
MariaDB [(none)]>GRANT ALL PRIVILEGES on kodekloud_db5.* to 'kodekloud_roy'@'%' identified by 'kodekloud';
MariaDB [(none)]>FLUSH PRIVILEGES;
MariaDB [(none)]>exit
```
* Now to go Jump Host and copy the Database script to /tmp directory on stdb01
```
scp /home/thor/db.sql peter@stdb01:/tmp
```
* Now login back to database host and load the database script as below
```
mysql -u kodekloud_roy -p kodekloud_db5 < /tmp/db.sql
```
#### Verify MariaDB setup
* Use mysqlshow to verify that the account you created works as expected. You should see all the WordPress tables listed (wp...)
```
mysqlshow -u kodekloud_roy -h stdb01 kodekloud_db5
```

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