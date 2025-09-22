# This is for nvim on Windows so that it would look for init.lua from ~/.config/nvim/init.lua
export XDG_CONFIG_HOME="$HOME/.config"

alias ll="ls -la"
alias dps="docker ps --format \"table {{.Names}}\t{{.Status}}\""
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
# List 10 latest git branches
alias gb="git for-each-ref --sort='-committerdate' --format=\"%(refname:short)\" refs/heads/ | head -n 10"
alias gp="git push"
alias gpo="git push --set-upstream origin $(git branch --show-current)"
alias gl="git pull"
alias glo="git pull origin main"
alias glog="git log --oneline --decorate --graph"
alias glogg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
# Undo latest local commit
alias gundo="git reset --soft HEAD~1"
# Show current public IP
alias myip="curl -s http://ipinfo.io/json | jq '.ip' | sed -e 's/^\"//' -e 's/\"$//'"
# == Azure DevOps ==
# Open new pull request to Azure DevOps
alias azpr="az repos pr create --squash true --open --delete-source-branch true --auto-complete --output table"
alias azpropen="az repos pr show --open --id $1"
alias azmy="az boards query --wiql 'SELECT [System.Id],[System.Title],[System.State] FROM workitems WHERE [Assigned to] = @Me AND [State] = \"Active\"' -o table"
alias azopen="az boards work-item show --open --output table --id $1"
alias notes="nvim ~/notes.md"

eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/ohmy.json)"
