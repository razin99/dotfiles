################   USER CONFIGS   #################
export EDITOR='lvim'
export PATH=$PATH:/usr/local/go/bin:$HOME/.cargo/bin:$HOME/.local/bin

################ ssh-agent autorun #################
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
ssh_key=~/.ssh/cse-machine # change to the appropriate key
if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add $ssh_key
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add $ssh_key
fi
unset ssh_key
unset env
