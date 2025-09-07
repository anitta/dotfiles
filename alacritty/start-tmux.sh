#!/bin/zsh

# tmuxセッションが存在するならアタッチ、なければ新規作成
tmux new-session -A -s dev
