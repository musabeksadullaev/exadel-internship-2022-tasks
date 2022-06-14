
### Clone remote repository
```sh
git clone https://github.com/foobar/baz
```


### Change working directory
``` shell
cd baz/
```

### Change user credentials (these values will be included in commit messages)
``` shell
git config user.email "foo@bar.baz"
git config user.name "Foo Bar"
```

### List directories (ll is alias of `ls` command)
``` shell
ll
```

### Get changes in repository
``` shell
git status
```

### Create Task1 directory
``` shell
mkdir Task1
```

### XXX
``` shell
echo "# README for **first** task" > Task1/README.md
```

### Add modifications to staging
``` shell
git add .
```

### Commit changes (staged changes will be available in this commit)
``` shell
git commit -m "Initial commit - Added README for first task"
```

### Push created commits (a.k.a changes) to remote repository (GitHub, GitLab, ...)
``` shell
git push origin master
```

### Create new 'dev' branch (not branched from any other existing branch)
``` shell
git checkout -b dev
```

### Delete existing branch
``` shell
git checkout -d dev
```

### (Force) Delete existing branch (existing not committed changes will be removed)
``` shell
git checkout -D dev
```

### Create new 'dev' branch (branched from existing 'master' branch)
``` shell
git checkout -b dev master
```

### Show commit history in current branch
``` shell
git log
```

### Show commit history in selected branch (master branch in this command)
``` shell
git log master
```

### Pull changes of current (dev) branch from 'origin' remote
``` shell
git pull origin
```

### Pull changes of master branch from 'origin' remote
``` shell
git pull origin master
```

### Pull changes of master and dev branch from 'origin' remote
``` shell
git pull origin master dev
```

### Create new commit that contains changes of previous commit
``` shell
git revert foobar-new_feature HEAD~1
```

### Abort reverting
``` shell
git revert --abort
```

### Revert current branch to one previous commit (Commit with current changes will be removed)
``` shell
git reset --hard HEAD^
```

### Revert current branch to three previous commit (Current and previous two commits will be removed)
``` shell
git reset --hard HEAD~3
```

### List of branches in local repository
``` shell
git branch
```

### List of branches in local and remote repository
``` shell
git branch --all
```

### Pull changes and remove non-existing (on remote) branches from local
``` shell
git fetch -p
```

### Remove non-existing (on remote) branches from local
``` shell
git remote prune
```

### Switch to master branch and merge dev branch to master
``` shell
git checkout master
git merge dev
```
