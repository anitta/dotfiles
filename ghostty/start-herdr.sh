#!/bin/zsh -l

# herdr のデフォルトセッションへアタッチする。
# サーバが未起動なら起動し、起動済みならそのままアタッチする。
# ログインシェル (-l) で起動して ~/.zprofile の brew shellenv を通し、
# Homebrew 配下の herdr に PATH を通す。
#
# Ghostty を herdr のペイン内から `open` で起動すると、HERDR_* 環境変数が
# Ghostty に引き継がれ、herdr が「nested herdr」と判定して即終了する。
# Ghostty のウィンドウは herdr の外側なので、ここで変数を落としておく。
unset HERDR_ENV HERDR_BIN_PATH HERDR_SOCKET_PATH HERDR_PANE_ID HERDR_TAB_ID HERDR_WORKSPACE_ID

exec herdr
