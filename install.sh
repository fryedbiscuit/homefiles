#!/bin/bash
HERE="$HOME/git/homefiles"
CONFDIR="$HOME/.config"
BINDIR="$HOME/.local/bin"

make_folders () {
	mkdir -p "$HOME/.local/bin"
	mkdir -p "$CONFDIR/nvim"
	mkdir -p "$CONFDIR/vifm"
}

link_dotfiles () {
	ln -sf "$HERE/dotfiles/bash/bashrc" "$HOME/.bashrc"
	ln -sf "$HERE/dotfiles/bash/bash_profile" "$HOME/.bash_profile"
	ln -sf "$HERE/dotfiles/sxhkd" "$CONFDIR/"
	ln -sf "$HERE/dotfiles/tmux" "$CONFDIR/"

	for file in $HERE/dotfiles/vifm/*
	do
		ln -sf "$file" "$CONFDIR/vifm/"
	done

	for file in $HERE/dotfiles/nvim/*
	do
		ln -sf "$file" "$CONFDIR/nvim/"
	done
}

link_scripts () {
    ln -sfT "$HERE/scripts/mine" "$BINDIR/scripts"
	for file in $HERE/scripts/not_mine/*
	do
		ln -sf "$file" "$BINDIR/"
	done
}

remove_conflicts () {
    rm -rf "$CONFDIR/vifm"
    rm -rf "$CONFDIR/nvim"
}

termux_stuff () {
    for file in $HERE/termux/scripts/*
    do
        ln -sf "$file" "$BINDIR/"
    done
}

main () {
        if [ "$1" == "-c" ]
        then
            remove_conflicts
        fi

        make_folders
        link_dotfiles
        link_scripts

        if [ ! -z "$TERMUX__HOME" ]
        then
            termux_stuff
        fi
}

main $*
