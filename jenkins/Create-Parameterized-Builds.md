# Create Parameterized Builds
## Solution
### Step 1: Create Parameterized Build
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Click `New item` and in the following screen:
```
Name: parameterized-job (Keep 'Freestyle Project' as selected) and click Ok
```
* Under `General` click the option `This project is parameterized`
* This will reveal additional option `Add Parameter`
* Click `Add Parameter > String Parameter` and input the following values as per question:
```
Name: Stage
Default Value: Build
```
* Click `Add Parameter > Choice Parameter` and input the following values as per question:
```
Name: env
Choices:
Development
Staging
Production
```
* In the `Build` section below, choose `Add build step > Execute shell` and input the following values in the `command`:
```
echo $Stage $env
```
* Click save

### Step 2: Run Parameterized Build
The question expects you to run the parameterized build at least once with a particular value selected for `env` e.g. Development
* Click the newly created job, `parameterized-job` on the home page and in the following screen click `Build Now`
* You should see a new build starting up on the left lower screen

## Verification
* Click that build and click `Console Output` and verify that the `echo` command is printing the correct values for `env` and `Stage` parameter. You should see something like:
```
Running as SYSTEM
Building in workspace /var/jenkins_home/workspace/parameterized-job
[parameterized-job] $ /bin/sh -xe /tmp/jenkins6109190682713673426.sh
+ echo Build Development
Build Development
Finished: SUCCESS
```
---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)