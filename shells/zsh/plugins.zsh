##======================================================================
## Setup Zinit plugin manager
##======================================================================
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zinit"

if [[ ! -s "${ZINIT_HOME}/bin/zinit.zsh" ]]; then
    git clone https://github.com/zdharma/zinit.git ${ZINIT_HOME}/bin
fi

typeset -gAH ZINIT
ZINIT[HOME_DIR]="${ZINIT_HOME}"
source "${ZINIT_HOME}/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

##======================================================================
## Plugins
##======================================================================

##
## Completion
##
zinit wait lucid light-mode for \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
    OMZP::colored-man-pages

##
## History
##
zinit lucid light-mode for \
    zsh-users/zsh-history-substring-search

##
## Theme
##
zinit lucid depth=1 light-mode for \
    atload"source ${ZDOTDIR:-$HOME/.config/zsh}/.p10k.zsh" \
    romkatv/powerlevel10k

##
## Commands
##
#zinit wait'[[ -n ${ZLAST_COMMANDS[xpanes*]} ]]' lucid light-mode for \
zinit wait'1' lucid light-mode for \
    as"program" pick"bin/*" greymd/tmux-xpanes

