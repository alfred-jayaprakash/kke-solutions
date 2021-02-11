# Yum Local Repos
## Solution
* Make sure the local RPM directory given in the question has correct permissions:
`sudo chmod -R 755 /packages/downloaded_rpms/`
* Create a repo using createrepo command: `sudo createrepo /packages/downloaded_rpms/`
* Now edit the `/etc/yum.repos.d/local.repo` file and configure the local repo with the name given as per the question (in this example, the local repo name is yum_local)
```UNIX
[yum_local]
name=yum_local
baseurl=file:///packages/downloaded_rpms/
enabled=1
gpgcheck=0
protect=1
```
* Now install the package asked in the question e.g. `yum install -y httpd`

## Verification
* Install yum-utils by running `sudo yum install -y yum-utils`
* Run repoquery to find out which repo the package was installed from e.g. `repoquery -i httpd`.
See the 'Repository' field below.
``` Java Properties
Name        : httpd
Version     : 2.4.6
Release     : 97.el7.centos
Architecture: x86_64
Size        : 9821064
Packager    : CentOS BuildSystem <http://bugs.centos.org>
Group       : System Environment/Daemons
URL         : http://httpd.apache.org/
Repository  : yum_local
Summary     : Apache HTTP Server
Source      : httpd-2.4.6-97.el7.centos.src.rpm
Description :
The Apache HTTP Server is a powerful, efficient, and extensible web server.
```

---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)