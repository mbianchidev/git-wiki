alias = ! git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /
unstage = reset HEAD --
pr = pull --rebase
delet = checkout *.project *.component
localdelete = branch -D
remotedelete = push origin --delete
cancelalias = config --global --unset
undolast = reset HEAD~
addncommit = commit -asm
push = p
newremote = push --set-upstream
addall = add .
newlocal = checkout -b
switch = checkout
casul = clean -nfd
gud = clean -fd
superclean = gud && git delet
