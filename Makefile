all:
	stow --verbose --target=$$HOME --restow .

clean:
	stow --verbose --delete --target=$$HOME --delete .
