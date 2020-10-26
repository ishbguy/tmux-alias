#!/usr/bin/env bash

tmux show-options -q command-alias |\
    awk 'END {gsub(/[[:alpha:][:punct:]]/, "", $1); print $1 + 1}'
