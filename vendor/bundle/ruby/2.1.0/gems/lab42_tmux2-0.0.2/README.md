
# Lab42, Programmers' Best Friend In Ruby 2

## Tmux2

**N.B.** This is a complete rewrite of tmux and it is **not** compatible, IOW do not
install both gems.

These are the differences

* Everything has changed.

* Furthermore, nothing has remained the same

* There are no predefined scripts, but have a look at the examples.

## Purpose

A simple API for launching tmux sessions from Ruby scripts

### A simple example

```ruby
    require 'lab42/tmux/autoimport'

    session "vi_session" do
      new_window 'vi' do
        send_keys 'vi .'
        wait_for '.. (up a dir)'       # NERDTree pane has loaded (not yet implemented)
        send_keys_raw 'C-w', 'l'
      end
      new_window 'pry' do
        send_keys 'pry -Ilib'
        send_keys 'require "lab42/tmux"'
      end
    end
```

### Configuration

```ruby
    require 'lab42/tmux/autoimport'

    config do
      window_automatic_rename true    # now there will be no `set-window-option -g automatic-rename off`
    end

    session "sh-session" do
      new_window 'console'            # opens a second window
    end

```

### Hooks

Add a `after_new_window` hook for tmux commands to be executed after the creation of a new
window.

```ruby
    session 'my rails' do
      after_new_window do
        send_keys "rvm use default@my-rails"
      end
      # ...
    end
```

### Window Events

The real use case for which Ruby was much better than shell scripts was the `wait_for` method
as it allows us to wait for some text in a pane to be shown before doing some action.

This is a real use case which will open vi with _NERDTree_, wait for NERDTree to split panes
and only then switch to the right hand side split pane (of vi, not tmux).

```ruby

    config
      # options for wait_for
      pre_wait_interval 0.1  # Before checking for text
      post_wait_interval 0.1 # After text has shown up in pane
      wait_timeout 4         # Do not wait longer than that

      verbose true           # Talk to stdout for post mortem analyse
    end

    new_session 'lab42_core' do
      new_window 'vi' do
        send_keys 'vi .'
        wait_for "up a dir" do     # Block will be executed iff text appears 
                                   # before timeout only
          send_keys_raw 'C-w', 'l'
          send_keys ':e README.md'
          send_keys ':so local.vim'
          send_keys_raw 'ziG'
        end
        # Script continues after timeout or appearance of text
        # ...
      end
end
```

### Plugins

Plugins are easy to write, just MP the `Lab42::Tmux::Session` class. However precise guidelines
how to do this will be available soon, also you might want to create some configuration.

The plugin guidelines and some plugins (vi, ruby, rvm, python's virtualenv) are planned for
the near future.

## Dev Notes

### Acceptance Tests

For each example script there is a corresponding expecatation output in the
`expectations` directory. Use the acceptance_tests script to run the examples
and compare the output with the expectations.


The expectation files are primitive and need some simple adaptations to your environment, hopefully
that will change.
