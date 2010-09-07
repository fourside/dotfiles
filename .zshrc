alias s='screen'
alias sr='screen -r'
alias -g G='|grep '
alias -g L='|less '
alias -g T='|tee tee.log |less'
alias -g W='|wc'
EDITOR='vim'
export EDITOR

autoload -U compinit
compinit

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no beep sound when complete list displayed
#
setopt nolistbeep


#autoload predict-on
#predict-on

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

## Default shell configuration
#
# set prompt
#
case ${UID} in
0)
#PROMPT="%B%{[31m%}%/#%{[m%}%b "
	PROMPT="%B%{[31m%}%/#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[31m%}%n%#%{[m%} "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac
RPROMPT="%{$fg_bold[white]%}[%{$reset_color%}%{$fg[red]%}%/%{$reset_color%}%{$fg_bold[white]%}]%{$reset_color%}"

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac 

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data 


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
#   to end of it)
#
bindkey -e
 
# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

#--prefix=の後のパス名を補完
#
setopt magic_equal_subst

#URLのコピペ時にエスケープする
#
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

setopt autopushd


#bindkey "^[^[[C" forward-word
#bindkey "^[^[[D" backward-word 



#pidを得る
# see http://memo.officebrook.net/20100123.html
zstyle ':completion:*:processes' command 'ps x -o pidsargs'

autoload -Uz colors
colors

