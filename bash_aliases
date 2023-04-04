export PS1='\e[1;30m\u\e[39m\[@\e[32m\]\W \e[39m$ '

### Apt
alias apt_update='apt-get update && apt-get upgrade'
alias apt_install='apt-get install'
alias apt_remove='apt-get remove'
alias apt_autoremove='apt-get autoremove'
alias apt_search='apt-cache search'

### Cmd
alias nano='nano -xc' 
alias wget='wget -c' 
alias du='du -ch' 
alias tailf='tail -f' 
alias kk='ls -lathr' 
alias ll='ls $LS_OPTIONS -lha' 
alias sl='ls $LS_OPTIONS -lha' 
alias mount_pretty="mount | column -t" 

### User
alias sudo_login='sudo -s'
alias cat_passwd="cat /etc/passwd | column -t -s:"
alias cat_group="cat /etc/group | column -t -s:"

### Common
alias show_date='date +%H%M%S-%d%m%Y'
# alias rm_history="history -d `history | tail -1 | awk {'print $1'}`"
alias copy='xclip -selection clipboard'
alias paste='xclip -selection clipboard -o'
alias random_number='shuf -i 100000-200000 -n 1'
alias generate_password='openssl rand -base64 16 | grep -v "="'
generate_ssh() {
  export SSH_NAME="$1"
  ssh-keygen -t rsa -b 4096 -N "" -f $SSH_NAME -C $SSH_NAME.pub > /dev/null
  mv $SSH_NAME $SSH_NAME.key
  cat $SSH_NAME.pub
}
rpl_env() { envsubst < $1 | $2 -; }

### Process
alias ps_grep='ps -aux |grep'
alias info_ram='free -m -l -t'
alias info_cpu='lscpu'
alias info_disk='df -h -x tmpfs -x devpts -x usbfs'
alias info_partition='lsblk -fm'
alias sys_restart='systemctl restart'
alias sys_start='systemctl start'
alias sys_stop='systemctl stop'
alias sys_status='systemctl status'

# Files
alias file_find_big="find . -type f -exec ls -s {} ; | sort -n -r | head -5"
alias file_find='find . | grep'
alias file_execute='chmod +x'
alias file_backup="cp $1 $1.-date +%H%M%S-%d%m%Y.bk"

# Docker
alias cont_tools="docker run -it -v ~/.bash_aliases/:/home/debian/bash_aliases -v $(pwd):/app --rm carlosgaro/tools:2.0"
alias cont_tools_random="docker run -it -v $(pwd):/app --rm carlosgaro/tools:2.0"
alias d_ps='docker ps -a'
alias d_stop_all='docker stop $(docker ps -aq)'
alias d_remove_all='docker rm $(docker ps -aq)'
alias d_it='docker exec -it '
d_log() { docker logs -t --tail 100 -f $1; }
d_exec() { docker exec -it $1 bash; }

### K8s
alias kc="kubectl"
alias kc_get_all="kubectl get deployment,svc,pods,pvc,pv,ing --all-namespaces -o wide"
alias kc_get_pods_all="kubectl get pods --all-namespaces -o wide"
alias kc_get_services_all="kubectl get services --all-namespaces -o wide"
alias kc_apply="kubectl apply -f"
alias kc_delete="kubectl delete -f"
alias kc_api="kubectl api-resources"

### Lxc
alias lxc_start='lxc-start -n '
alias lxc_stop='lxc-stop -n '
alias lxc_attach='lxc-attach -n '
alias lxc_ls_running='lxc-ls --running'
alias lxc_create_debian='lxc-create -t debian -n '

### Apache
alias a_restart='/etc/init.d/apache2 restart'
alias a_start='/etc/init.d/apache2 start'
alias a_stop='/etc/init.d/apache2 stop'
alias a_set_permissions='chown www-data:www-data . -R'

### Python
alias py_server_start='python manage.py runserver localhost:8000'
alias pip_upgrade='pip install --upgrade pip'
alias pip_requirements_freeze='pip freeze > requirements.txt'
alias pip_requirements_install='pip install -r requirements.txt'
py_env() {
  if [ $1 ] ; then
    NAME=$1
    if [ -d $HOME/.env/$NAME ] ; then
      mkdir -p $HOME/.py_env
      source $HOME/.py_env/$NAME/bin/activate
    else
      python -m venv $HOME/.py_env/$NAME && source $HOME/.py_env/$NAME/bin/activate
    fi
  else
    python -m venv /tmp/py-env-$(date +%H%M-%d%m%Y) && source /tmp/py-venv-$(date +%H%M-%d%m%Y)/bin/activate
  fi
}

### Ansible
alias an_hello='ansible all -a "/bin/echo hello"'
alias an_ping='ansible -m ping'
alias an_adhoc='ansible all -m shell -a'
alias ap='ansible-playbook'
alias ap_d='ansible-playbook --diff'
alias ap_dc='ansible-playbook --diff --check'
an_fact() { ansible $1 -m setup; }

### Networking
alias net_ip_private="ifconfig | grep inet | egrep -v 'inet6|127.0'"
alias net_ip_public='curl http://icanhazip.com/'
alias net_ip_tables_list="sudo /sbin/iptables -L -n -v --line-numbers"
alias net_ip_tables_input='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias net_ip_tables_output='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias net_ip_tables_forward='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias net_ports='netstat -tulanp'
alias net_restart='/etc/init.d/networking restart'
alias route_delete_docker='sudo route del -net 172.19.0.0 netmask 255.255.0.0 metric 0'
net_check_open_port () { nc -z -v -w1 $1 $2; }
net_ip_geolocation () { curl ipinfo.io/$1; }

### Git
alias git_save="git stash"
alias git_restore="git stash pop"
alias git_fast='git add . && git commit -m "up" && git push'
alias git_commits='git log --pretty=format:"%h - %an, %ar : %s"'
alias git_reset="git reset HEAD~1"
alias git_restore_last_commit="git reset --soft HEAD~1"
alias git_fast='git add . && git commit -m "up" && git push'
alias git_log="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -p"
git_show () { git show --stat --oneline $1; }
alias git_branch="git symbolic-ref --short HEAD"
alias git_branch_last_20="git --no-pager branch --sort=-committerdate  -a  | head -20"
git_tag() {
  git tag -d $1
  git push --delete origin $1
  git tag -a $1 -m "version $1"
  git push --follow-tags
}
git_merge() {
  current_branch=$(git symbolic-ref --short HEAD)
  git checkout master
  git pull -r
  git checkout $current_branch
  git merge master
}

### Jq
alias jq_save="jq . -M > output.json"

### Terraform
alias tf='terraform'
alias tf_init='terraform init'
alias tf_plan='terraform plan'
alias tf_apply_yes='terraform apply -auto-approve'
alias tf_destroy_yes='terraform destroy -auto-approve'
alias tf_apply='terraform apply'
alias tf_destroy='terraform destroy'
alias tf_output='terraform output'
alias tf_remove='rm -rf .terraform*'
alias tf_show='terraform show'
alias tf_fmt='terraform fmt'
alias tf_validate='terraform validate'
alias tf_version='tfswitch'
alias tf_workspace='terraform workspace'

