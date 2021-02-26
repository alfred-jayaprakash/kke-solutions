# Jenkins Create Views
## Introduction
This task involves creating a simple job that runs every minute and then creating a Jenkins list view to include this and another job

## Solution
### Step 1: Create a Scheduled Job
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Click `New item` and in the following screen:
```
Name: devops-pipeline-job (Keep 'Freestyle Project' as selected) and click Ok
```
* Under `Build Triggers` click `Build periodically`. This reveals a text area to input the `Schedule`. Give the schedule as per the question e.g. `* * * * *` (Ignore any warnings)
* In the `Build` section below, choose `Add build step > Execute shell` and input the command given in the question in the `command`:
```
echo hello world!!
```
* Click `Save`
* Run `Build Now` to check the job runs correctly. Check `Console Output` to check the echo output.

### Step 2: Create a View
* Go to `Jenkins > New View` and add a `List View` as per question e.g. `devops-crons`
* Under `Job Filters` select both the jobs as per the question e.g. `devops-cron-job` and `devops-pipeline-job`
* Click `Ok`

## Verification
* Click `Jenkins > My Views`. You should be able to see the view `devops-crons`.
* Click that and under that you should be able to see both the jobs listed
* Click the job that you created in Step 1
* You should see a few builds already as builds get triggered every minute automatically

---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)
