#!/usr/bin/env bash

# for debug
#set -x

TMUX_ALIAS_CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"
TMUX_ALIAS_ORG_INDEX="$(tmux show-environment -g TMUX_ALIAS_ORG_INDEX 2>/dev/null)"

get_index() {
    tmux show-options -q command-alias |\
        awk 'END {gsub(/[[:alpha:][:punct:]]/, "", $1); print $1 + 1}'
}

first_init() {
    tmux set-environment -g TMUX_ALIAS_ORG_INDEX "$(get_index)"
    tmux set-option -qg command-alias["$(get_index)"] \
        alias="set-option -g command-alias[\"#($TMUX_ALIAS_CURRENT_DIR/bin/get-index.sh)\"]"
}

reset_idx() {
    local top="$(get_index)"
    local bot="$((TMUX_ALIAS_ORG_INDEX + 1))"

    for i in $(eval echo {$bot..$top}); do
        tmux set-option -ug command-alias[$i]
    done
}

# Get the absolute path to the users configuration file of TMux.
# This includes a prioritized search on different locations.
#
get_user_tmux_conf() {
    # Define the different possible locations.
    xdg_location="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
    default_location="$HOME/.tmux.conf"

    # Search for the correct configuration file by priority.
    if [ -f "$xdg_location"  ]; then
        echo "$xdg_location"
    else
        echo "$default_location"
    fi
}

tmux_conf_contents() {
    user_config=$(get_user_tmux_conf)
    cat /etc/tmux.conf "$user_config" 2>/dev/null
}

alias_list() {
    tmux_conf_contents |\
        awk -F@ '/^[ \t ]*set(-option)? +-g +@alias/ {dump = $1 "@alias"; gsub(dump, ""); print $0}'
}

setup_alias() {
    if [[ $TMUX_ALIAS_ORG_INDEX == '' ]]; then
        first_init
    else
        reset_idx
    fi

    alias_list | while read -r line; do
        eval tmux set-option -g command-alias["$(get_index)"] "$line"
    done
}

setup_alias
