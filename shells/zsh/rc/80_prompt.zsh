##=====================================================================
## rc/80_prompt.zsh -- Customize command line prompts
##=====================================================================
#
# Powerline like prompt
#
# powerline-rs is fast!
if (( ${+commands[powerline-rs]} )); then
    function powerline_precmd() {
        PS1="$(powerline-rs --shell zsh $?)"
    }

    function install_powerline_precmd() {
        for s in "${precmd_functions[@]}"; do
            if [ "$s" = "powerline_precmd" ]; then
                return
            fi
        done
        precmd_functions+=(powerline_precmd)
    }

    if [ "${TERM}" != "linux" ]; then
        install_powerline_precmd
    fi
fi

# ----- End of zshrc -----
# vim: foldmethod=marker
