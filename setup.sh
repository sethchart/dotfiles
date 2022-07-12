cd ~
git clone https://github.com/sethchart/dotfiles.git
git clone https://github.com/VundleVim/Vundle.vim.git ~/dotfiles/vim/.vim/bundle/Vundle.vim
sudo apt install stow
cd dotfiles
stow vim
git config --global credential.helper store
sudo apt update
sudo apt install python3-venv python3-pip
sudo apt-get install python-is-python3 -y
python3 -m pip install --user pipx
python3 -m pipx ensurepath
python3 -m pipx completions
exit
pipx install black
pipx install virtualenv
