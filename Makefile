install:
	@stow -vt ${HOME} */

uninstall:
	@stow -vDt ${HOME} */

brew-list:
	@rm -rf ./Brewfile && brew bundle dump --describe --file=./Brewfile

brew-install:
	@brew bundle --file=./Brewfile
