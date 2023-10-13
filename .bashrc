alias ll="ls -la"
alias dps="docker ps --format \"table {{.Names}}\t{{.Status}}\""
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias gp="git push"
alias gpo="git push --set-upstream origin $(git branch --show-current)"
alias gl="git pull"
alias glo="git pull origin main"
alias glog="git log --oneline --decorate --graph"
alias glogg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
# Open new pull request to Azure DevOps
alias azpr="az repos pr create --squash true --open --delete-source-branch true --auto-complete --output table"
# Undo latest local commit
alias gundo="git reset --soft HEAD~1"
# Show current public IP
alias myip="curl -s http://ipinfo.io/json | jq '.ip' | sed -e 's/^\"//' -e 's/\"$//'"

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}] "
	else
		echo "[no git]"
	fi
}

# get current status of git repo
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

#export PS1="\[\e[36;44m\]\u\[\e[m\]\[\e[44m\]@\[\e[m\]\[\e[36;44m\]\h\[\e[m\] \[\e[33m\]\W\[\e[m\] \[\e[35m\]\`parse_git_branch\`\[\e[m\]  "

function print_emoji {
	emojis=(🍺 🍻 🍔 🍩 🍕)
	selected_emoji=${emojis[$RANDOM % ${#emojis[@]}]};
	echo $selected_emoji;
}

function success_indicator() {
    if [ $? -eq 0 ] ; then
        echo "$(print_emoji)";
    else
        echo "💩";
    fi
}

git_branch='`git rev-parse --abbrev-ref HEAD 2> /dev/null | sed s/^/\\/`'
kube_context='`kubectl config current-context `'

PS1="\r\n\[\e[32m\]\A\[\e[m\] • \[\e[31m\]\w\[\e[m\] •\[\e[33m\] \`parse_git_branch\`\[\e[m\] \`success_indicator\`\r\n$ "
