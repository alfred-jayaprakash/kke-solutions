# Configure Nginx + PHP-FPM Using Unix Sock
## Solution
### Step 1 - Install and configure PHP FPM
* Login to each of the appservers and perform the following tasks
* Install PHP-FPM: `sudo yum install -y php-fpm`
* Make changes in `/etc/php-fpm.d/www.conf`. Comment/uncomment lines and update values accordingly.
```
;listen = 127.0.0.1:9000
listen = /var/run/php-fpm/default.sock

listen.allowed_clients = 127.0.0.1

listen.owner = apache
listen.group = apache
listen.mode = 0660

user = apache
group = apache
```
* Enable MPM Event module and comment MPM Prefork module: `vi /etc/httpd/conf.modules.d/00-mpm.conf`
```
# LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
LoadModule mpm_event_module modules/mod_mpm_event.so
```
* Enable PHP configurations in Apache: `vi /etc/httpd/conf.d/php.conf`
```
# Tell the PHP interpreter to handle files with a .php extension.

# Proxy declaration
<Proxy "unix:/var/run/php-fpm/default.sock|fcgi://php-fpm">
	# we must declare a parameter in here (doesn't matter which) or it'll not register the proxy ahead of time
    	ProxySet disablereuse=off
</Proxy>

# Redirect to the proxy
<FilesMatch \.php$>
	SetHandler proxy:fcgi://php-fpm
</FilesMatch>

#
# Allow php to handle Multiviews
#
AddType text/html .php

#
# Add index.php to the list of files that will be served as directory
# indexes.
#
DirectoryIndex index.php

#
# Uncomment the following lines to allow PHP to pretty-print .phps
# files as PHP source code:
#
#<FilesMatch \.phps$>
#	SetHandler application/x-httpd-php-source
#</FilesMatch>
```
* Start php-fpm and restart Apache:
```
systemctl start php-fpm
systemctl restart httpd
```
#### Verify PHP-FPM setup
* Create a sample PHP file`/var/www/html/index.php` to test your changes. The following should be the content:
```php
<?php
phpinfo();
?>
```
* Run `curl http://localhost:5002/` (5002 is Apache port). You should get back the HTML content for the PHP Info page.

### Step 2 - Install and configure MariaDB
* SSH to Database host (stdb01)
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
Once you have logged in, then run the below SQL commands to create database, create user, set the password and grant privileges (In this example `kodekloud` is the password set for the user). Make sure to change the below values as per the question:
```SQL
MariaDB [(none)]>CREATE DATABASE kodekloud_db5;
MariaDB [(none)]>GRANT ALL PRIVILEGES on kodekloud_db5.* to 'kodekloud_roy'@'%' identified by 'kodekloud';
MariaDB [(none)]>FLUSH PRIVILEGES;

```
* Now load the database script as below
```SQL
MariaDB [(none)]>source /tmp/db.sql
```
#### Verify MariaDB setup
* Use `mysqlshow` to verify that the account you created works as expected, especially with host as stdb01. You should see all the WordPress tables listed i.e. wp...
```UNIX
mysqlshow -u kodekloud_roy -h stdb01 kodekloud_db5
```
In case the above doesn't work, try as `mysqlshow -u kodekloud_roy -h stdb01 -p kodekloud_db5`

### Step 3 - Download and install WordPress
* SSH back to each of the appservers and perform the following tasks 
* Change to Apache Document root directory: `cd /var/www/html`
* Download the latest Wordpress: `wget https://wordpress.org/latest.tar.gz`
* Extract the Wordpress installation: `tar xvf latest.tar.gz`
* Change to WordPress directory and make a copy of `wp-config-sample.php` as `wp-config.php`: `cp wp-config-sample.php wp-config.php`
* Edit `wp_config.php` and set the DB details
```
define('DB_NAME', 'kodekloud_db5');
define('DB_HOST', 'stdb01');
define('DB_USER', 'kodekloud_roy');
define('DB_PASSWORD', 'kodekloud');
```
#### Verify WordPress setup
* Use Curl command to check whether a valid HTML is returned: `http://localhost:5002/wordpress/`

## Verification
* Click tab `Select port to view on Host 1`, and after adding port 80 click on Display Port. This should connect to LB URL.
* You should see a sample Blog WordPress site loaded