# GIT Setup from Scratch
## Introduction
The task involves the following steps:
* Create a bare GIT repo and setting up an update hook that prevents direct pushes to master
* Clone this repo and create a new branch
* Commit a file in to this branch and push to remote
* Lastly, attempt to push the master to remote repo

## Solution
* Switch to root user: `sudo su`
* Install GIT: `yum install -y git`
* Setup GIT user and email globally:
```unix
git config --global --add user.name natasha
git config --global --add user.email natasha@stratos.xfusioncorp.com
```unix
* Create a bare repository as per the question: `git init --bare /opt/apps.git`
* Change to the repo directory `/opt/apps.git` and copy the `/tmp/update` hook to `hooks` directory under `/opt/apps.git`
```unix
cd /opt/apps.git
cp /tmp/update hooks/
```
* Now navigate to the clone directory as per question e.g. `/usr/src/kodekloudrepos` and clone the repo:
```unix
cd /usr/src/kodekloudrepos
git clone /opt/apps.git
```
* You should see a `/usr/src/kodekloudrepos/apps` directory. Change to that directory: `cd apps`
* Now create a new branch as per question: `git checkout -b xfusioncorp_apps`
* Copy the `/tmp/readme.md` to the current directory: `cp /tmp/readme.md .`
* Now commit the file and push it to the origin:
```unix
git add readme.md
git commit -m "Readme file"
git push origin xfusioncorp_apps
```

## Verification
* Now switch to the new branch master and attempt a push to origin. Your push should fail:
```unix
git checkout -b master
git push origin master
remote: Manual pushing to this repo's master branch is restricted
remote: error: hook declined to update refs/heads/master
To /opt/apps.git
 ! [remote rejected] master -> master (hook declined)
error: failed to push some refs to '/opt/apps.git'
```

