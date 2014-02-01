#!/usr/bin/env zsh

export home_dir=$(pwd)
export session_name=Lab42Core

function main
{
        new_session
        new_window 'vi'
        open_vi


        new_window 'vi lib'
        open_vi lib

        new_window 'spec'

        new_window 'vi spec'
        open_vi spec ':colorscheme solarized'

}

source ~/bin/tmux/tmux-commands.zsh
