# ~/.zshrc

# Load aliases
for file in ~/.zsh/aliases*.zsh; do
  [ -r "$file" ] && source "$file"
done

# Load Git and vcs_info settings
for file in ~/.zsh/git*.zsh; do
  [ -r "$file" ] && source "$file"
done

# Load Go environment settings
source ~/.zsh/go.zsh
for file in ~/.zsh/go*.zsh; do
  [ -r "$file" ] && source "$file"
done

# Load Homebrew settings
for file in ~/.zsh/homebrew*.zsh; do
  [ -r "$file" ] && source "$file"
done

# Load all other .zsh files except those already loaded
for file in ~/.zsh/*.zsh; do
  # Check if the file has already been sourced
  case "$file" in
    ~/.zsh/aliases*.zsh|~/.zsh/git*.zsh|~/.zsh/go*.zsh|~/.zsh/homebrew*.zsh)
      continue ;;  # Skip these files
    *)
      [ -r "$file" ] && source "$file" ;;  # Source all other .zsh files
  esac
done

# Load Atuin settings
eval "$(atuin init zsh)"

# Load mise settings
eval "$(mise activate zsh)"

# その他の一般的な設定
setopt no_beep
