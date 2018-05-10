apt-get update
apt-get upgrade -y
apt-get install -y sudo htop vim screen sharutils zsh cifs-utils python-pip curl git

newuser="pimouss"
useradd ${newuser} --create-home
mkdir /home/${newuser}/.ssh
chmod 700 /home/${newuser}/.ssh
cp .ssh/authorized_keys* /home/${newuser}/.ssh/
chown -R ${newuser}.${newuser} /home/${newuser}/.ssh

################################################################################
# enpower newuser user as nopasswd sudoers
# only interactive step needed to enter sudoer password
################################################################################

if [ -f "/tmp/sudoers.tmp" ]; then
    exit 1
fi
touch /tmp/sudoers.tmp
cp /etc/sudoers /tmp/sudoers.new
cat >> /tmp/sudoers.new << EOF
${newuser} ALL=NOPASSWD: ALL
EOF
visudo -c -f /tmp/sudoers.new
if [ "$?" -eq "0" ]; then
    cp /tmp/sudoers.new /etc/sudoers
fi
rm /tmp/sudoers.tmp

# install Oh-my-zsh
usermod -s /usr/bin/zsh ${newuser} 

wget -O /tmp/installOhMyZsh.sh https://raw.githubusercontent.com/paulhbenoit/config/master/installOhMyZsh.sh

sudo -H -u ${newuser} sh /tmp/installOhMyZsh.sh

sudo -H -u ${newuser} sed -e '/ZSH_THEME="robbyrussell"/ s/^#*/# /' -i /home/${newuser}/.zshrc

sudo -H -u ${newuser} sed '/# ZSH_THEME="robbyrussell"/a\ZSH_THEME="bira"' -i /home/${newuser}/.zshrc

# TODO: 
# sudo -H -u ${newuser} cat >> /home/${newuser}/.bashrc << EOF
# exec zsh
# EOF

sudo -H -u ${newuser} cat >> /home/${newuser}/.zshrc << EOF
###############################################################################
# EXTRA
###############################################################################
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

#Page up/page down
bindkey "\e[5~" history-beginning-search-backward
bindkey "\e[6~" history-beginning-search-forward
EOF




