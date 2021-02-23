# Configure Security Settings for a Project in Jenkins
## Introduction
This task involves configuring security settings for a project using 'Project-based security' options for a project given in the question e.g. Packages

## Solution
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Click `Jenkins > Click Project 'Packages' > Configure` and click `Enable project-based security` under `General` tab
* This will reveal additional matrix options.
* Make sure that the `Inheritence Strategy` is set to `Inherit permissions from parent ACL`
* Click `Add user or group...` to add the require users and grant them the privileges as per the question by ticking the appropriate checkboxes
* Click `Save`

## Verification
* Login using the users given in the question and click the project `Packages`
* You should see the `Configure` and `Build Now` accordingly as per the access you had given to the users
---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)
