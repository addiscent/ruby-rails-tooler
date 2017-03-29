# ruby-rails-tooler
This is a Bash script written for and tested on Ubuntu (16.04.x).

Because I spin up new VagrantBox and VirtualBox instances so often, I use this script to set a better hostname and prompt on them, while it's installing Ruby/Rails/Tools.

Usage :
  sudo  ./ruby-rails-tooler  username

The first thing this script does is set the hostname to "username-ruby-rails", then it sets a custom promt.  This is an example of the prompt, except the user name will of course be your user name instead of "rex" :

    2017.0329.0242.43
    rex@rex-ruby-rails:~
    $ 

After setting the new hostname and prompt, the script downloads and executes another of my GitHub project scripts named "ruby-rails-tools-install.sh", which does the actual Ruby/Rails/Tools installation.

If you don't need the hostname/prompt change feature of this script, you may wish to just go directly for the Ruby/Rails/Tools installation script at :
  https://github.com/addiscent/ruby-rails-tools-install

Note : The hostname change and prompt don't appear until the next time the user logs-in. If you don't like the prompt, remove the line this script adds to the end of .bashrc, the line beginning with "export PS1".  If you don't like the host name, run "sudo hostname thehostnameyouwant", and then edit your /etc/hostname file to say "thehostnameyouwant".
