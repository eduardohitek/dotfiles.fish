#!/usr/bin/env fish
set -Ux EDITOR vim
set -Ux VISUAL $EDITOR
set -Ux WEDITOR code

set -Ux DOTFILES ~/.dotfiles
set -Ux PROJECTS ~/dev

fish_add_path $DOTFILES/bin $HOME/.bin

# the global default shadows the universal, so `set -Up` in a loop would keep
# only the last dir; set it once instead, dropping repo dirs from earlier runs
set -l default_function_path
for p in $fish_function_path
	string match -q "$DOTFILES/*" $p
		or set -a default_function_path $p
end
set -U fish_function_path $DOTFILES/*/functions $default_function_path

# abbreviations live in <topic>/conf.d since fish 3.6; drop the old universal ones
for v in (set -Un | string match '_fish_abbr_*')
	set -Ue $v
end

for f in $DOTFILES/*/conf.d/*.fish
	ln -sf $f ~/.config/fish/conf.d/(basename $f)
end

if test -f ~/.localrc.fish
	ln -sf ~/.localrc.fish ~/.config/fish/conf.d/localrc.fish
end
