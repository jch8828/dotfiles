# dotfiles

## Install dotfiles
`stow -vt $HOME */`

## Uninstall dotfiles
`stow -vDt $HOME */` 

## Backup Brew bundle
`brew bundle dump --file=~/Projects/dotfiles/Brewfile`

## Install all the brew packages
`brew bundle --file=~/Projects/dotfiles/Brewfile`
