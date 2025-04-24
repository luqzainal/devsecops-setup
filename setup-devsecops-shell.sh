#!/bin/bash

echo "🔧 Updating system..."
sudo apt update && sudo apt install zsh git curl fonts-powerline -y

echo "🧙 Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "🎨 Installing Powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "⚙️ Installing Zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "🛠️ Updating .zshrc config..."
cat > ~/.zshrc << 'EOF'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git docker z sudo colored-man-pages zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Aliases
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias reload='source ~/.zshrc'
alias serve='npx serve'
alias myip='curl ifconfig.me'
alias ports='sudo lsof -i -P -n | grep LISTEN'
alias update='sudo apt update && sudo apt upgrade -y'

# Docker
alias d='docker'
alias dps='docker ps'
alias dcu='docker compose up -d'
alias dcd='docker compose down'

# Git
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'

# NPM/Yarn
alias nr='npm run'
alias ni='npm install'
alias nis='npm install -g'

# AI tools
alias ai="ollama run llama3"
EOF

echo "✅ Setting Zsh as default shell for user: $USER"
chsh -s $(which zsh)

echo ""
echo "🎉 DONE! Please restart your terminal or run: source ~/.zshrc"

