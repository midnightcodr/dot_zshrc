# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="gentoo"
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
c () {
	if [[ $# -lt 1 ]]; then
		echo "Usage: c host [user=root] [options]"
	else
		host=$1
		user=${2:-root}
		opts=$3
		ssh${opts} $user@$host
	fi
}

newc () {
	osascript <<EOD
tell application "iTerm"
  tell application "System Events" to keystroke "t" using command down
  tell current session of current terminal
    write text "c $1"
  end tell
end tell
EOD
}

neww () {
	osascript <<EOD
tell application "iTerm"
  tell application "System Events" to keystroke "n" using command down
  tell current session of current terminal
    write text "c $1 $2"
  end tell
end tell
EOD
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
source ~/.rvm/scripts/rvm
alias rake="noglob rake"
# disable auto correct because it drives me nuts from time to time
unsetopt correct_all

# enable vim key bindings
bindkey -v

# vim ^R shortcut fix
bindkey '^R' history-incremental-search-backward

# vim mode indicator
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
