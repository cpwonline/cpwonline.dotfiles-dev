# .bashrc

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Pkgconfig env. variable
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

# User specific aliases and functions
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# See Git branch
function gitbranch() 
{
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Colors
PS1="\[\e[92m\]["
PS1=$PS1"\[\e[31m\]\u"
PS1=$PS1"\[\e[33m\]@"
PS1=$PS1"\[\e[32m\]\h:"
PS1=$PS1"\[\e[36m\]\W "
PS1=$PS1"\[\e[1m\]\$(gitbranch)"
PS1=$PS1"\[\e[92m\]]\$"
PS1=$PS1"\[\e[0;00m\] " 
