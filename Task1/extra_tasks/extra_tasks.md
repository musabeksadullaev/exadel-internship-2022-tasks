# Answers for extra tasks of first task

> Sub-task 1. Read about GitHub Actions. What environment variables can be created?

There's two types of variables:
1. Environment variables (Global system environment variables)
2. Shell (aka session or terminal) variables (Variables that exists only in running shell instance)

And variable names should meet requirements:
- Should start with Latin letters: `a-z` or `A-Z`
- Can contain numbers: `0-9`
- Can start with or contain underscore symbol: `_`


## Examples of valid and invalid variable names
|🟢Valid syntax🟢|🔴Invalid syntax🔴|
|----------|----------|
|AT|1ST_CHARACTER_IS_NUMBER|
|TIME|SEPARATED-WITH-DASH-SYMBOL|
|GLOBAL_ENVIRONMENT_VARIABLE|ТЕКСТ_НА_КИРИЛЛИЦЕ|
|LOCAL_ENVIRONMENT_VARIABLE|MIX_OF_КИРИЛЛИЦА_AND-LATIN-SYMBOLS|

----

> Sub-task 2. Create your workflow, what consists of two jobs and contain requirements according the scheme below


Secrets in GitHub can be created in:
```
Project home page > Settings > Secrets > Actions > New repository secret
```




Resulting CI/CD file:
``` md
# Name of pipeline
name: "Extra task 1 - demo"

# Define when to run this pipeline
on: [push]

# Environment variables (Global)
env:
  # One variable's value can be assigned to another variable's value
  DEPLOY_VER: ${{ github.sha }}

  # Static variable
  YEAR: 2018


# Jobs to run when pipeline started
jobs:

  # Single job can contain single or multiple steps. Each step will do some operation or run command in target system
  job_1:

    # Target system where job will be runned
    runs-on: ubuntu-latest

    # List of steps/actions
    steps:

      # Checkout to master branch
      - uses: actions/checkout@master  # Actions are predefined commands that make easier to work with pipelines
        with:  # Arguments for actions
          ref: master
  
      # Print contents of current directory (and repository)
      - run: ls -laXh .
  
      # Print contents of log.txt in current directory
      - run: cat ./log.txt
  
      # Print hash of commit
      - run: echo "Hello from $DEPLOY_VER commit"


  job_2:

    runs-on: ubuntu-latest

    # One job can wait another for successful exit
    needs: job_1

    # Environment variables (Job only)
    env:
      MONTH: 9
      DAY__OF_THE_MONTH: 8
      FAVORITE_DAY_OF_WEEK: ${{ secrets.FAVORITE_DAY_OF_WEEK }}  # Secrets can be added/modified/deleted in project settings page

    steps:

      # Checkout to master branch
      - uses: actions/checkout@master
        with:
          ref: master
  
      - run: date  # Display date
  
      - run: echo Day - $DAY__OF_THE_MONTH  # Display DAY__OF_THE_MONTH variable value
      - run: echo Month - $MONTH  # Display MONTH variable value
      - run: echo Year - $YEAR  # Display YEAR variable value
  
      - run: echo Favorite day of week - ${{ env.FAVORITE_DAY_OF_WEEK }}  # Secrets will not be displayed (Because they're secret)


```
