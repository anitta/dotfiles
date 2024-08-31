# ~/.zsh/ps1.zsh

# kube-ps1
source "$(brew --prefix)/Cellar/kube-ps1/0.9.0/share/kube-ps1.sh"

# PS1
NEWLINE=$'\n'
PS1='$(kube_ps1)'${NEWLINE}'%n@%m %1~ %# '

