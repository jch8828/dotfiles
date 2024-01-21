install:
	@stow -vt ${HOME} */

uninstall:
	@stow -vDt ${HOME} */

brew-list:
	brew bundle dump --file=$(pwd)/Brewfile

brew-install:
	brew bundle --file=$(pwd)/Brewfile
