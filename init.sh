log_file=~/install_progress_log.txt

sudo apt -y install zsh
if type -p zsh >/dev/null; then
	echo "zsh Installed" >>$log_file
else
	echo "zsh FAILED TO INSTALL!!!" >>$log_file
fi

sudo apt -y install stow
if type -p stow >/dev/null; then
	echo "stow Installed" >>$log_file
else
	echo "stow FAILED TO INSTALL!!!" >>$log_file
fi

# JetBrains Mono font
sh -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

# ohmyzsh:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# stow dotfiles
stow zsh
stow nvim
stow rio
stow prettier

# install nvm
sh -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh)"
nvm install stable
nvm use stable
