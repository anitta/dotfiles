# ~/.zsh/git.zsh

autoload -Uz compinit vcs_info
compinit
vcs_info
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
zstyle ':vcs_info:git:*' formats '%b'

