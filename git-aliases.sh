alias = ! git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /
unstage = reset HEAD --
pr = pull --rebase
localdelete = branch -D
remotedelete = push origin --delete
cancelalias = config --global --unset
undolast = reset HEAD~
addncommit = commit -asm
push = p
newremote = push --set-upstream
addall = add -A
newlocal = checkout -b
