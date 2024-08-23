# mbianchidev's Git Wiki

You can find the official Git CLI doc here: https://git-scm.com/docs/git
This was a set of notes I took while learning Git some years ago. I hope it helps you too.
There might be some errors and it might get outdated in time, so please let me know if you find any mistake and I'll fix it. PRs are welcome too.

## Setting up aliases

Run the git-aliases.sh script (curl or wget required) example uses curl, wget runs with different parameters.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mbianchidev/git-aliases/main/git-aliases.sh)"
```

or

Download the gitconfig file and edit it to your needs, then copy it to your git config folder. 

Win usual location is `C:/Program Files/Git/etc/gitconfig`, while Linux/Mac usual location is `$HOME/.gitconfig`

```bash
/bin/bash -c "$(wget -O- https://raw.githubusercontent.com/mbianchidev/git-aliases/main/.gitconfig)" && vim .gitconfig
```

## Cloning a repository

```bash
# clone the repository to the chosen destination folder
git clone https://user:pass@[git-provider]/group/repo.git example/
git clone ssh://[git-provider]/user/repo.git
# including all submodules
git clone --recurse-submodules https://user:pass@[git-provider]/group/repo.git example/
```

## Pulling changes

```bash
# fetch remote changes and merge them into the current branch
git pull
# fetch remote changes and rebase the current branch on top of them
git pull --rebase
```

## Branching

```bash
# create a new "example" local branch
git branch example
# create a new "example" local branch and switch to it
git checkout -b example
# push local branch to remote
git push origin example
# Add remote branch to local
git remote add origin example
# delete the remote branch
git push origin --delete example
# delete the local branch
git branch -D example
# show all remote branches
git branch -r
# show all local branches
git branch

## Renaming

# switch branches
git checkout old
# rename the local branch			
git branch -m renamed
# push the renamed branch to the remote
git push origin -u renamed
# when you're sure, delete the old branch from the remote
git push origin --delete old 
```

## Adding changes

```bash
# stage all files
git add .
# stage files, excluding new files (and ofc .gitignore'd)
git add *
# stage files, including new files
git add -A 
```

## Commit changes

```bash
# commits all staged changes with the given message in the local branch
git commit -m "Example message"
# commit with header and body
git commit -m "Header" -m "Body"
```

## Signing commits with GPG
```bash
gpg --gen-key # needs gpg installed
gpg -K --keyid-format SHORT
git config --global user.signingKey <theID>
git config--global commit.gpgsign true
```

## Signing commits with SSH
```bash
git config --global user.signingKey $HOME/.ssh/id_3ru2r.pub
git config --global commit.gpgsign true
```

## Signing commits with a key
```bash
git config --global push.autoSetupRemote true

```

## Push changes
    
```bash
# If an upstream is set, push changes to remote branch
git push
# If an upstream is not set, push changes to remote branch and set upstream
git push --set-upstream origin example
```

## Syncing (a fork)

```bash
# fetch remote changes
git fetch
# fetch remote changes from upstream
git fetch upstream
# merge remote changes from upstream (fork)
git merge upstream/main 
```

## Reset or undo changes

```bash
# unstage all files
git reset . 				
# unstage a specific file and revert it to the HEAD revision (latest pushed commit)				
git reset HEAD -- path/to/file/to/revert.json
# unstage all files and discard changes, reverting them to the HEAD revision
git reset --hard HEAD 

# Reverting last commit without losing it

# undo last remote pushed commit
git reset HEAD~
# undo last local commit and keep changes
git reset HEAD~1 --soft
# same as above but with a specific commit
git reset HEAD~[commit number] --soft
# unstage the specified file
git reset HEAD -- app/reset.java

# reset the file to the HEAD (if not yet committed)
git checkout path/to/file/to/revert.ts
# reset the file to the target branch
git checkout origin/my_branch -- file/example.jsx
# reset all files to the HEAD (if not yet committed)
git checkout -- .

```

## Rebase
https://git-scm.com/docs/git-rebase 
https://medium.freecodecamp.org/git-rebase-and-the-golden-rule-explained-70715eccc372 

```bash
# checkout the branch you want to be in sync with (usually main)
git checkout main
# fetch changes from the remote
git pull --rebase
# checkout the branch you want to rebase (usually development or feature ones)
git checkout my_feature
# rebase the branch on top of the target branch
git rebase main
# if there are conflicts, resolve them and continue the rebase or skip a commit, abort if you want to stop
git rebase --continue | --skip | --abort
# check the status. Is your branch different from origin? It's okay, it should be.
git status
# force push ONLY to your branch
git push -f 
```

## Cleaning

```bash
# show what would be removed with clean
git clean -n
# remove all untracked files
git clean -f
# remove all untracked directories
git clean -d
# remove untracked files and directories
git clean -(n)df
```

## Stashing

```bash 
# temporarily stash changes
git stash 
# fetch new	
git pull
# apply the stashed changes again
git stash pop
# drop the stashed changes
git stash drop 
```

## Merge

```bash
# merge the main branch into the current branch
git merge main
# abort or keep the merge
git merge --abort | --continue 
```

## Cherry-picking

```bash
# cherry-pick a commit from another branch
git cherry-pick [commit hash]
```

## Remote

```bash
# show all remote names
git remote -v
```

# Rewriting history

```bash
# revert a range of commits (on the current branch, beware of conflicts)
git revert <old_commit_hash>..<latest_commit_hash> && git push -f
```

# Git magic squash when forking and working on a branch =/= main

```bash
git reset --soft "$(git merge-base main HEAD)" )" && git commit 'new message' && git push --force-with-lease
```

## Amend author in the whole repo
    
```bash

git filter-branch --env-filter '
WRONG_EMAIL="yyy@ddd.dev"
NEW_NAME="John Doe"
NEW_EMAIL="John.Doe@gmail.com"

if [ "$GIT_COMMITTER_EMAIL" = "$WRONG_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$NEW_NAME"
    export GIT_COMMITTER_EMAIL="$NEW_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$WRONG_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$NEW_NAME"
    export GIT_AUTHOR_EMAIL="$NEW_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
```

## Aliases
    
```bash
# create an alias for the defined command
git config --global alias.<alias name> '<command>' 


# Show aliases alias so you can run "git alias"
git config --global alias.alias "! git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /"
```

## Tagging

```bash
# show tags
git tag
# show log on a single line per commit									     
git log --pretty=oneline
# tag a commit
git tag [tag name e.g., 2.17.3] [commit name]
# push a tag
git push origin [tag name]
# push all tags     
git push origin --tags				     
```

## Check history

```bash 
# commit history
git log
# history with changes
git log -p
# show only the latest commit
git log -1 

## Magic log 

git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all

git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n'' %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
```

## Finding bugs via git?

See: https://git-scm.com/docs/git-bisect
