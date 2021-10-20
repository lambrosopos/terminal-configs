# This is a repo for my settings

## For .vimrc installation

1) Install Vim (>=0.8.0) or Install NeoVim (>=0.3.0)

2) Install Following Dependencies for Vundle, CoC

 - NVM
   - `$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash`
 - Node
   - `$ nvm install --lts`
 - Yarn
   - `$ npm install yarn --global`

3) Vundle install:

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

4) make directories
 - mkdir -p ~/.cache/vim/swap
 - mkdir -p ~/.cache/vim/undo

5) For NeoVim to use `~/.vimrc` settings

 - make directory for neovim settings
   - `$ mkdir -p ~/.config/nvim`
 - make new file
   - `$ touch ~/.config/nvim/init.vim`
 - add following lines
     ```sh
     set runtimepath^=~/.vim runtimepath+=~/.vim/after
     let &packpath=&runtimepath
     source ~/.vimrc
     ```
 
6) Open .vimrc file, run 

```
:PluginInstall
```

 - on CoC error, go to `~/.vim/bundle/coc.nvim` and run `$ yarn install`


## For tmux installation

1) Install tmux according to OS (go to [tmux repository](https://github.com/tmux/tmux))

2) Copy `.tmux.conf` file to `~/.tmux.conf`

```sh
$ cp ./.tmux.conf ~/.tmux.conf
```

3) Install tpm or tmux plugin manager (go to [tpm repository](https://github.com/tmux-plugins/tpm)

...or execute below code

```sh
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

4) Enter into tmux and install plugins or (prefix + I)
