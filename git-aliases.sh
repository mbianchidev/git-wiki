#!/bin/bash

# Git Aliases

git config --global alias.alias '! git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /'
git config --global alias.cancelalias 'config --global --unset'
git config --global alias.unstage 'reset HEAD --'
git config --global alias.pr 'pull --rebase'
git config --global alias.localdelete 'branch -D'
git config --global alias.remotedelete 'push origin --delete'
git config --global alias.undolast 'reset HEAD~'
git config --global alias.addncommit 'commit -asm'
git config --global alias.push 'p'
git config --global alias.newremote 'push --set-upstream'
git config --global alias.addall 'add -A'
git config --global alias.newlocal 'checkout -b'
git config --global alias.newremote 'push --set-upstream'

git alias

exit 0
