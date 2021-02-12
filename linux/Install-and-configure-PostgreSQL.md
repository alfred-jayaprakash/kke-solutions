# Install and configure PostgreSQL
## Solution
* Login to Database host (stdb01)
* Install and enable PostgreSQL server
```
sudo yum -y install postgresql-server postgresql-contrib 
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo systemctl status postgresql
```
* Perform initial setup of PostgreSQL DB using the built-in command
```
sudo postgresql-setup initdb
```
* Now create the database, the user and grant them privileges. Make sure you simply copy paste the password from the question to the below query.
```sql
sudo -u postgres psql
.
.
CREATE USER kodekloud_aim WITH PASSWORD 'ksH85UJjhb';
CREATE DATABASE kodekloud_db1;
GRANT ALL PRIVILEGES ON DATABASE "kodekloud_db1" to kodekloud_aim;
```
Exit from the psql by typing `\q`
* Now edit `/var/lib/pgsql/data/postgresql.conf` so that the below line is uncommented
```conf
listen_addresses = 'localhost'
```
* Now edit `/var/lib/pgsql/data/pg_hba.conf` and update the below lines to md5 (Make sure you don't duplicate any entry)
```conf
# "local" is for Unix domain socket connections only
local   all             all                                     md5
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
```
* Restart the services
```
sudo systemctl restart postgresql
sudo systemctl status postgresql
```
## Verification
* Connect to the database to test with host as localhost. Use the password specified in the question to login. You should login successfully.
```
sudo psql -U kodekloud_aim -d kodekloud_db1 -h localhost -W
```
* If you see an error like `psql: FATAL:  Ident authentication failed` then it means you have not edited `pg_hba.conf` properly.
---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)