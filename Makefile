all:
	stow --verbose --target=$$HOME --restow .
	gpg-connect-agent reloadagent /bye

clean:
	stow --verbose --delete --target=$$HOME --delete .
	gpg-connect-agent reloadagent /bye
