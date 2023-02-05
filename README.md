# dotfiles
A repository to hold my configuration files.
See this [link](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)

# Quick Start
  - Clone this repository.
    ```shell
    git clone --recurse-submodules https://github.com/sethchart/dotfiles.git ~/dotfiles
    ```
  - For the desired configurations use stow to create symbolic links.
    For example, to apply the vim configuration from this repo.
    ```shell
    cd ~/dotfiles
    stow vim
    ```
## Vim

### Plugins
This [video](https://www.youtube.com/watch?v=X2_R3uxDN6g) describes vim plugin management.

#### Adding Plugins from GitHub
To add a new plugin:
  1. Add the plugin repo to dotfiles as a submodule:
     ```shell
     cd ~/dotfiles
     git submodule add \
     --name <plugin-name> \
     <plugin-url> \
     vim/.vim/pack/plugin/opt/<plugin-name>
     ```
  2. Activate the plugin in `.vimrc`:
     ```vim
     packadd! <plugin-name>
     ```

#### Installed Plugins
  - [black](https://github.com/psf/black)
  - [jedi-vim](https://github.com/davidhalter/jedi-vim)
  - [vim-test](https://github.com/vim-test/vim-test)
  - [vim-pydocstring](https://github.com/heavenshell/vim-pydocstring)
    ```shell
    cd ~/dotfiles/vim/.vim/pack/plugin/opt/vim-pydocstring
    make install
    ```
  - [fzf](https://github.com/junegunn/fzf/blob/master/README-VIM.md)

## Bash

## Zsh
