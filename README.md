# FYI

Be informed about task execution.


## Synopsis

    fyi some_command
  

## Examples

    fyi ls -lt
    fyi "ls -lt | grep total"
    fyi "cd /var/www/apps/current && /opt/ree/bin/rake RAILS_ENV=production thinking_sphinx:index"


## Description

The `fyi` command executes `some_command` and tells you what
happened.  This is useful when `some_command` is executed
asynchronously, e.g. via cron, and you want to know how it
went without cluttering up your crontab with pipe redirections.

When `fyi` executes `some_command` it captures standard out, 
standard error, and whether `some_command` succeeded or failed.
These are then reported by any notifiers you have configured.
Success is defined by a 0 exit code and failure by a non-zero
exit code.


## Notifiers

The default notifier is the `Log` notifier.  This writes to
`fyi.log` in the process's home directory unless you configure
it otherwise (see below).

One other notifier is currently available: the `Email` notifier.
Simply configure it (see below) to use it.  You can switch
success notifications on and off and failure notifications
on and off independently.  By default this notifier will only
email you when `some_command` fails.

To provide additional notifiers, e.g. Campfire / HTTP / Jabber,
add a class in `lib/notifiers/` and configure it (see below).
`fyi` will automatically instantiate it, configure it and use
it.

A notifier must:

* subclass Fyi::Notifier
* accept an options hash at initialisation (populated from
  configuration).
* respond to `notify(command, result, output, error = '')`


## Installation

    sudo gem install fyi


## Configuration

Configure `fyi` with a YAML file at `<home>/.fyi`, where
`<home>` is the process's home directory.

Each top-level key should be the name of a notifier class.
The key-value pairs in each notifier section are passed in
a hash to the notifier class at instantiation.


## Problems 

Please use GitHub's [issue tracker](http://github.com/airblade/fyi/issues).


## Intellectual Property

Copyright (c) 2009 Andy Stewart (boss@airbladesoftware.com).
Released under the MIT licence.
