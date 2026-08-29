#!/bin/zsh -l

# herdr のデフォルトセッションへアタッチする。
# サーバが未起動なら起動し、起動済みならそのままアタッチする。
# ログインシェル (-l) で起動して ~/.zprofile の brew shellenv を通し、
# Homebrew 配下の herdr に PATH を通す。
exec herdr
