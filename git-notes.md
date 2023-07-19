# Official documentation here: https://git-scm.com/docs/git

-- CLONE --

git clone https://user:pass@[git-provider]/group/repo.git [directory] 		-> clone the repository to the chosen destination folder
git clone ssh://[git-provider]/user/repo.git
git clone --recurse-submodules https://user:pass@[git-provider]/group/repo.git [directory] 	-> clone the repository to the chosen destination folder, including all submodules

-- PULL --

cd [project location]
git pull 									-> fetch remote changes

-- ADD --

git add .									-> stage modified files, ignore files specified in .gitignore
git add * 									-> stage modified files, ignore files starting with '.'

-- COMMIT -- 

git commit -m "[msg]"						-> commit local changes to the repository
git commit -m "[header]" -m "[msg]"			-> commit with message split into title and body

-- RESET --
git reset . 								-> unstage all files
git reset HEAD -- [path/to/file/to/revert] 	-> unstage a specific file and revert it to the HEAD revision
git reset --hard HEAD 						-> unstage all files and discard changes, reverting them to the HEAD revision (latest commit)

e.g., git reset HEAD -- src/main/webapp/app/app.constants.ts

-- REVERT LAST COMMIT WITHOUT LOSING IT

git reset HEAD~								-> undo last commit
git reset HEAD~1 --soft                     -> perform a commit without pushing but forgot something, use this command to go back to the state after git add (files staged but not committed)
	git reset HEAD~[commit number] --soft		-> perform N commits without pushing but forgot something and/or there is a merge commit
git pull									-> pull to avoid merge conflicts
git reset HEAD -- [file]					-> unstage the specified file

-- REBASE MANUALLY --
git checkout <target branch - usually develop> -> checkout the branch you want to base your feature on (usually develop)
git pull --rebase							   -> pull and update develop to the latest version
git checkout <branch which i want to rebase>   -> checkout the feature branch
git rebase develop							   -> rebase the branch based on develop after updating it
git rebase --continue | --skip				   -> continue the rebase
git status									   -> is your branch different from origin? It's okay, it should be. Force push
git push -f									   -> force push ONLY to your branch

-- REVERT FILE --
git checkout [path/to/file/to/revert] 									 	-> reset the file to the HEAD (if not yet committed)
git checkout {remote-name usually "origin"}/{branch} -- {file/path.java} 	-> reset the file to the target branch (if already committed)
git checkout -- .															-> reset all files to the HEAD (if not yet committed)

-- CLEAN --

git clean -n 								-> show what would be removed with clean
git clean -f								-> remove all untracked files
git clean -d                                -> remove all untracked directories
git clean -(n)df							-> remove untracked files and directories

-- PUSH --
git push 									-> push changes to the branch only if there is an upstream set

-- REBASE --

https://git-scm.com/docs/git-rebase 
https://medium.freecodecamp.org/git-rebase-and-the-golden-rule-explained-70715eccc372 

git add 
git rebase --continue  						-> if you believe you have resolved conflicts optimally
git rebase --abort  						-> abort the rebase if you believe you made mistakes in resolving conflicts 


-- STASH -- 

git stash 									-> temporarily stash changes
git pull 									-> fetch from the HEAD
git stash pop 								-> apply the stashed changes
git stash drop 								-> drop the stashed changes

-- MERGE --

git merge [target branch] 					-> merge the current branch with the target branch
git merge --abort 							-> abort the merge if you believe you made mistakes in resolving conflicts 

-- REMOTE --

git remote -v 								-> show all remote names

-- BRANCH -- 

git checkout [branch name] 					-> switch branches
git checkout -b [name_of_your_new_branch]   -> create a new branch
git push [remote name] [branch name] -> create a branch (previously created locally) on the remote [usually origin]
git remote add [remote name] [branch name]  -> add a remote to the branch [usually origin]
git push origin --delete [branch name] 		-> delete the remote branch
git branch -D [branch name] 				-> delete the local branch
git branch -r 								-> show all remote branches
git branch 									-> show all local branches

-- BRANCH RENAME --

git checkout <old_name>						-> switch branches
git branch -m <new_name> 					-> rename the local branch
git push origin -u <new_name>				-> push the new branch to the remote
git push origin --delete <old_name> 		-> when you're sure, delete the old branch from the remote

-- FEATURE (GitFlow) --

git checkout [start branch] 				         -> switch branches
git checkout -b feature/[XXXX_feature_name]          -> create a feature branch
git add .											 -> see git add
git commit -m "message"                              -> see git commit
git push --set-upstream origin [featurebranch name]  -> create a branch (previously created locally) on the remote [usually origin]

-- REWRITE HISTORY

git revert <oldest_commit_hash>..<latest_commit_hash> -> revert a range of commits

-- Amend author in the whole repo --

git filter-branch --env-filter '
WRONG_EMAIL="yyy@ddd.dev"
NEW_NAME="John Doe"
NEW_EMAIL="xxx@gmail.com"

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
' --tag-name-filter cat -- --branches --tags		-> this amends author in the whole repo


-- ALIASES --

git config --global alias.<alias name> '<command>'   -> create an alias for the defined command

-- show aliases
git config --global alias.alias "! git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /"
git config --global alias.unstage 'reset HEAD --'
git config --global alias.pr 'pull --rebase'
git config --global alias.delet 'checkout *.project *.component'
git config --global alias.localdelete 'branch -D'
git config --global alias.remotedelete 'push origin --delete'
git config --global alias.cancelalias 'config --global --unset'
git config --global alias.undolast 'reset HEAD~'
git config --global alias.addncommit '

commit -am'
git config --global alias.newremote 'push --set-upstream'
git config --global alias.addall 'add .'
git config --global alias.newlocal 'checkout -b'
git config --global alias.switch 'checkout'
git config --global alias.casul 'clean -nfd'
git config --global alias.gud 'clean -fd'
git config --global alias.superclean 'gud && git delet'

git config --global alias.lg1 'log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
git config --global alias.lg2 'log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n'' %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all'

-- CHERRY PICK --

git checkout [target branch]
-> git cherry-pick [commit id] 				-> cherry-pick the selected commit to the target branch

-- TAG --

git tag 									    -> show tags
git log --pretty=oneline 					    -> show log on a single line per commit
git tag [tag name e.g., 2.17.3] [commit name]   -> tag a commit
git push origin [tag name] 					    -> push a tag
git push origin --tags 						    -> push all tags


-- HISTORY -- 
git log				-> commit history
git log -p 			-> history with changes
git log -1			-> show the latest commit

-- magicLOG -- 

git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n'' %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all


-- Find BUG via GIT --

https://git-scm.com/docs/git-bisect