##======================================================================
## Function definitions
##======================================================================
##
## --- Zsh utility functions
##
# {{{
# Compile a given zsh script if modified.
function zcompare() {
    if [[ -s "${1}" && ( ! -s "${1}.zwc" || "${1}" -nt "${1}.zwc") ]]; then
        zcompile "${1}"
    fi
}

# Load file if exists. Compile the file before source it if necessary.
function loadlib() {
    local f="${1:?'too few argument: you have to specify a file to source'}"
    if [[ -s "$f" ]]; then
        zcompare "$f"
        source "$f"
    fi
}

# Show options set on current Zsh session
function showoptions() {
    set -o | sed -e 's/^no\(.*\)on$/\1  off/' -e 's/^no\(.*\)off$/\1  on/'
}

# Backup files and directories
function bak() {
    for i in $@ ; do
        if [[ -e $i.bak ]] || [[ -d $i.bak ]]; then
            echo "$i.bak already exist"
        else
            command cp -ir $i $i.bak
        fi
    done
}

#}}}

# ----- End of file -----
# vim: foldmethod=marker
