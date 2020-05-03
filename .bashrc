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

PS1="\[\e[32m\]\A\[\e[m\] • \[\e[31m\]\w\[\e[m\] •\[\e[33m\] \`parse_git_branch\`\[\e[m\]\n\`success_indicator\` $ "