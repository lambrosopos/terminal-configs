# This is a repo for my settings

## For .vimrc installation

1) Install Vim (>=0.8.0)

2) Install NeoVim (>=0.3.0)

3) Vundle install:

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

4) mkdir -p ~/.cache/vim/swap
5) mkdir -p ~/.cache/vim/undo

6) Open .vimrc file, run 

```
:PluginInstall
```

7) For proper CoC plugin usage, need node and other essentials

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
