# Commands used when completing first task

> These commands used when completing first task.
> I will use this README when I forgot some commands

### Clone remote repository
``` bash
git clone https://github.com/foobar/baz
```


### Change working directory
``` bash
cd baz/
```

### Change user credentials (these values will be included in commit messages)
``` bash
git config user.email "foo@bar.baz"
git config user.name "Foo Bar"
```

### List directories (`ll` is alias of `ls` command)
``` bash
ll
```

### Get changes of local repository
``` bash
git status
```

### Create **Task1** directory
``` bash
mkdir Task1
```

### Create README.md in Task1 folder
``` bash
echo "# README for **first** task" > Task1/README.md
```

### Add modifications to staging
``` bash
git add .
```

### Commit changes (staged changes will be available in this commit)
``` bash
git commit -m "Initial commit - Added README for first task"
```

### Push created commits (a.k.a changes) to remote repository (GitHub, GitLab, ...)
``` bash
git push origin master
```

### Create new '**dev**' branch (not branched from any other existing branch)
``` bash
git checkout -b dev
```

### Delete existing branch
``` bash
git checkout -d dev
```

### (Force) Delete existing branch (existing not committed changes will be removed)
``` bash
git checkout -D dev
```

### Create new '**dev**' branch (branched from existing 'master' branch)
``` bash
git checkout -b dev master
```

### Show commit history of current branch
``` bash
git log
```

### Show commit history of selected (**master**) branch (master branch at this time)
``` bash
git log master
```

### Pull changes of current (**dev**) branch from '**origin**' remote
``` bash
git pull origin
```

### Pull changes of '**master**' branch from '**origin**' remote
``` bash
git pull origin master
```

### Pull changes of master and dev branch from 'origin' remote
``` bash
git pull origin master dev
```

### Create new commit that contains changes of previous commit
``` bash
git revert foobar-new_feature HEAD~1
```

### Abort reverting
``` bash
git revert --abort
```

### Revert current branch to one previous commit (Commit with current changes will be **removed**)
``` bash
git reset --hard HEAD^
```

### Revert current branch to three previous commit (Current and previous two commits will be **removed**)
``` bash
git reset --hard HEAD~3
```

### List of branches in local repository
``` bash
git branch
```

### List of branches in local and remote repository
``` bash
git branch --all
```

### Pull changes and remove non-existing (on remote) branches from local
``` bash
git fetch -p
```

### Remove non-existing (on remote) branches from local
``` bash
git remote prune
```

### Switch to master branch and merge dev branch to master
``` bash
git checkout master
git merge dev
```

