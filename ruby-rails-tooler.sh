#!/bin/bash
# configure host and install recent versions of ruby and rails.
# rex 2017.0328.1930
#
# Usage :
#   sudo  ./ruby-rails-tooler.sh   username
#
# The first thing this script does is set a hostname to "username-ruby-rails",
# then it sets a custom promt.  After that, it downloads and executes another
# of my GitHub project scripts named "ruby-rails-tools-install.sh", which does
# the actual Ruby/Rails/Tools installation.
#
# If you don't need the hostname/prompt change feature of this script, you
# may wish to just go directly for the Ruby/Rails/Tools installation
# script at :
#  https://github.com/addiscent/ruby-rails-tools-install
#
# Note : The hostname change and prompt don't appear until the next time the
# user logs-in. If you don't like the prompt, remove the line this script adds
# to the end of .bashrc, the line beginning with "export PS1".  If you don't
# like the host name, run "sudo hostname thehostnameyouwant", and then edit
# your /etc/hostname file to say "thehostnameyouwant".
#

if [ $(whoami) != "root" ] ; then
  echo "Must be root to run $0"  # >> /tmp/arr-panic.log
  exit 1
fi

#################
# set user-name specified by command line argument
host_user="$1"
if [ "$#" -lt "1" ] ; then  # must specify a user-name
  printf "\
user-name argument is required.
  Usage :
    sudo  ./ruby-rails-tooler.sh   user-name
"
  exit 1
fi

#################
# let's go
echo "-->  BEGIN Host Config and Ruby-Rails-Tools Provision"

set -x

#################
# install unzip
apt-get -y install unzip

#################
# set the hostname
hostname ${host_user}-ruby-rails
echo "${host_user}-ruby-rails" > /etc/hostname
sed -i "s/localhost/localhost ${host_user}-ruby-rails/" /etc/hosts

#################
# set custom prompt and function in .bashrc for user and root

cat > /tmp/bashrc-mod.txt  << EOF

export PS1='\${debian_chroot:+(\$debian_chroot)}\n\D{%Y.%m%d.%H%M.%S}\n\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\\$ '

mls() {
  ls -lBh --group-directories-first \$1 \$2 \$3 \$4 \$5
}

EOF

echo "" >> /tmp/bashrc-mod.txt
cat /tmp/bashrc-mod.txt >> /home/${host_user}/.bashrc
cat /tmp/bashrc-mod.txt >> /root/.bashrc
rm /tmp/bashrc-mod.txt

#################
# install ruby/rails and related tools/software
set +x
echo "-->  download ruby-rails-tools installer"
set -x
wget -O ruby-rails-tools-install.zip https://github.com/addiscent/ruby-rails-tools-install/archive/master.zip
unzip -o ruby-rails-tools-install.zip  ruby-rails-tools-install-master/ruby-rails-tools-install.sh
chmod +x ruby-rails-tools-install-master/ruby-rails-tools-install.sh
cd ruby-rails-tools-install-master/
./ruby-rails-tools-install.sh
cd ..
rm -r ruby-rails-tools-install-master
rm ruby-rails-tools-install.zip

#################
# we're outta here
set +x
echo "-->  End Host Config and Ruby-Rails-Tools Provision"
