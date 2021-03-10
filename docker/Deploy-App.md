# Deploy an App on Docker Containers
## Solution
* First SSH to the required server as per the question
* Create a `docker-compose.yml` in the location mentioned in the question e.g: `/opt/dba`
```yaml
version: "3.3"
services:
  web:
    container_name: php_host
    image: php:7.4.16-apache
    ports:
      - "8087:80"
    volumes:
      - /var/www/html:/var/www/html
    depends_on:
      - DB
  DB:
    container_name: mysql_host
    image: mariadb:latest
    ports:
      - "3306:3306"
    volumes:
      - /var/lib/mysql:/var/lib/mysql 
    environment:
      - MYSQL_DATABASE=database_host
      - MYSQL_ROOT_PASSWORD=kodekloud
      - MYSQL_USER=kkeuser
      - MYSQL_PASSWORD=kodekloud
```
* Run `sudo docker-compose up -d`. Make sure there are no errors.
* Run `sudo docker ps` to check whether there are 2 containers running

## Verification
* Run `curl http://localhost:8087/` and you should receive the content of `index.php` stored in `/var/www/html/` of the host. Something like this:
```HTML
<html>
    <head>
        <title>Welcome to xFusionCorp Industries!</title>
    </head>

    <body>
        Welcome to xFusionCorp Industries!    </body>
</html>
```

---
For tips on getting better at KodeKloud Engineer Docker tasks, [click here](./README.md)
