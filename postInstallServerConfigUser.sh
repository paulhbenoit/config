wget -O /tmp/installOhMyZsh.sh https://raw.githubusercontent.com/paulhbenoit/config/master/installOhMyZsh.sh

sh /tmp/installOhMyZsh.sh

sed -e '/ZSH_THEME="robbyrussell"/ s/^#*/# /' -i ~/.zshrc
sed '/# ZSH_THEME="robbyrussell"/a\ZSH_THEME="bira"' -i ~/.zshrc

cat >> ~/.zshrc << EOF
# EXTRA ########################################################################
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

#Page up/page down
bindkey "\e[5~" history-beginning-search-backward
bindkey "\e[6~" history-beginning-search-forward
EOF


# aliases
wget -O ~/.bash_generic_cli_aliases https://raw.githubusercontent.com/paulhbenoit/config/master/files/home/.bash_generic_cli_aliases

cat > ~/.bash_aliases << EOF
. ~/.bash_generic_cli_aliases  
EOF



