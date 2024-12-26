log_file=~/install_progress_log.txt

sudo apt -y install stow
if type -p stow >/dev/null; then
	echo "stow Installed" >>$log_file
else
	echo "stow FAILED TO INSTALL!!!" >>$log_file
fi

# JetBrains Mono font
sh -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

# stow dotfiles
# how this works
# stow creates symplinks from current directory to home with keeping directories structure
# for example `stow rio` will create symplics for all files in directory ./rio with same structrure
# zsh/.zshrc => ~/.zshrc
stow zed
