#!/usr/bin/env zsh

export home_dir=$(pwd)
export session_name=Lab42Core
export console_command=pry

export after_window_open='rvm use @Lab42Core --create'

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

        new_window console
        send_keys 'pry -I ./lib || irb -I ./lib'

}

source ~/bin/tmux/tmux-commands.zsh
