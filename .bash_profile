#Alias

# Maven
alias mci='mvn clean install'
alias mcv='mvn clean verify'
alias mv='mvn verify'
alias mcc='mvn clean compile'
alias mc='mvn compile'
alias mt='mvn test'
alias mst='mvn verify -DskipTests'
# Switch mvn configuration
alias fm='~/bin/.fix_mvn.sh'


# Git
alias gst='git status'
alias gbr='git branch'
alias gco='git commit -m'
alias gcb='git checkout -b'

alias ga='git add -p'
alias gp='git push -u origin HEAD'
alias glf='git fsck --lost-found'
alias glc='git log -1'
alias gmc='git merge --continue'
alias grc='git rm --cached '

# File system
alias wsp='cd ~/wsp'
alias tools='cd ~/dev_tools'

# NPM
alias ni='npm i'
alias nt='ng test'
alias serve='ng serve'

# Docker
alias ddc='docker rm $(docker ps -q -a)'
alias ddi='docker rmi $(docker images -q)'
alias drmiuntag='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'
alias da='docker ps -a'


# Java
alias java8='export JAVA_HOME=`/usr/libexec/java_home -v 1.8`'
alias java9='export JAVA_HOME=`/usr/libexec/java_home -v 9`'
alias java10='export JAVA_HOME=`/usr/libexec/java_home -v 10`'

# Python
export WORKON_HOME='~/Envs'
source /usr/local/bin/virtualenvwrapper.sh
export VIRTUALENVWRAPPER=/usr/local/bin/python3


#Esthetics of terminal
# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
        then
        STAT=`parse_git_dirty`
        echo "[${BRANCH}${STAT}]"
else
echo ""
fi
}

# get current status of git repo
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi


function parse_git_dirty {
status=`git status 2>&1 | tee`
dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
bits=''
if [ "${renamed}" == "0" ]; then
    bits=">${bits}"
    fi
if [ "${ahead}" == "0" ]; then
    bits="*${bits}"
    fi
if [ "${newfile}" == "0" ]; then
    bits="+${bits}"
fi
if [ "${untracked}" == "0" ]; then
    bits="?${bits}"
fi
if [ "${deleted}" == "0" ]; then
    bits="x${bits}"
fi
if [ "${dirty}" == "0" ]; then
    bits="!${bits}"
fi
if [ ! "${bits}" == "" ]; then
    echo " ${bits}"
else
echo ""
fi
}

export PS1="\[\e[35m\]\u\[\e[m\] @ \[\e[33m\]\W\[\e[m\] \[\e[32m\]\`parse_git_branch\`\[\e[m\] \n\[\e[33m\][\$(date +%H:%M:%S)]\[\e[m\] "
[[ -d "$HOME/.bash_profile.d" ]] && for i in `ls "$HOME/.bash_profile.d"`; do source $HOME/.bash_profile.d/$i; done
[[ -f "`brew --prefix`/etc/bash_completion" ]] && source "`brew --prefix`/etc/bash_completion"

export PATH="$HOME/.cargo/bin:$PATH"

