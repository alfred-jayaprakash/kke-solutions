# Create Users in Jenkins
## Introduction
This task involves created a new user and granting the user read-only access to Global objects as well as to the Job (that already exists) using a Project-based Matrix Authorization Strategy

## Solution
### Step 1: Create User
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Click `Jenkins > Manage Jenkins > Manage Users > Create User` and provide values as per the question. Below is a sample:
```
Username: mariyam
Password: x7yHGGx97
Confirm Password: x7yHGGx97
Fullname: Mariyam
```
### Step 2: Assign Project-based Matrix Authorization Strategy
* Click `Jenkins > Manage Jenkins > Configure Global Security` and under `Authorization` section, check if you see the `Project-based Matrix Authorization Strategy`
* In case you don't see this option
  * Click `Jenkins > Manage Jenkins > Manage Plugins` and click `Available` tab.
  * Search for `Matrix`. You will see multiple matches. Select `Matrix Authorization Strategy Plugin` plugin and click `Download now and install after restart`
  * Wait for sometime and refresh the browser
  * Again under `Authorization` section, check if you now see the `Project-based Matrix Authorization Strategy`
* Click the checkbox `Project-based Matrix Authorization Strategy`. This will reveal additional matrix UI. Setup as per question:
  * Click `Add user or group...` and add the newly created user `mariyam`
  * Against user `mariyam` click the checkbox for `Read` under `Overall`
  * Against user `mariyam` click the checkbox for `Read` under `Job`
* Press `Save` and then `log out`

## Verification
* Login using the newly created user and password given in the question. You should be able to successfully login
* You should be able to see the minimal dashboard
* You should also be able to see the Job that was already present in the question
* Click the Job and you should not see any configure option but only read-only access to the job
---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)

