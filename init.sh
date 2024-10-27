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
# how this works
# stow creates symplinks from current directory to home with keeping directories structure
# for example `stow rio` will create symplics for all files in directory ./rio with same structrure
# rio/.config/rio/config.toml => ~./config/rio/config.toml
# zsh/.zshrc => ~/.zshrc
stow zsh
stow rio
stow prettier
stow zed

# install nvm
sh -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh)"
nvm install stable
nvm use stable
