if status is-interactive
# Commands to run in interactive sessions can go here
end

set fish_greeting

function starship_transient_prompt_func
	echo
	starship module character
end

starship init fish | source
enable_transience

zoxide init fish | source

fish_vi_key_bindings
fish_add_path ~/.local/bin

set -Ux XDG_CONFIG_HOME "/home/ajche/.config"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c=clear
alias vim=nvim
