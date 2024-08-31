# ~/.zsh/kubectl.zsh

# kubectl
export KUBECTL_EXTERNAL_DIFF="colordiff -u"
source <(kubectl completion zsh)

# kustomize alias
alias kube-build="KUSTOMIZE_PLUGIN_HOME=$(pwd)/plugins kustomize build --enable-alpha-plugins --enable-exec "

# krew
export PATH="${PATH}:${HOME}/.krew/bin"

