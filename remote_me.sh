#!/bin/bash
#
# Usage: ./remote_me.sh
#
# Install:
#
# Befor you can use remote_me you need to create a ssh-key pair for the user:
#  ssh-keygen -t rsa
#  ssh-copy-id -i ~/.ssh/id_rsa depanne@remotehost
#
# Requierement:
#  A remote ssh server where you have an account to login.
#

cleanup() {
  rm -f $tmp $tmp.pub
  sed -e "/temp-key-remote_me/ d" -i ~/.ssh/authorized_keys
  return $?
}
 
control_c() {
  echo -en "\n*** FIN ***\n"
  cleanup
  r=$?
  echo "OK fini."
  exit $r
}
 
# trap keyboard interrupt (control-c)
trap control_c SIGINT


# 5 hours
sleep_time=$((5 * 3600))

# some free port which will be used on remote server
revers_port=19999

# edit remote config here:
remotehost=myserver.remote-name.net
remote_user=sylvain

#create a temp ssh-key
tmp=~/.ssh/remote_me_tmp$$
ssh-keygen -t rsa -P "" -C temp-key-remote_me -f $tmp
sed -e "/temp-key-remote_me/ d" -i ~/.ssh/authorized_keys
cat $tmp.pub >> ~/.ssh/authorized_keys
chmod go= ~/.ssh/authorized_keys

clear
# start the remote connection with the revert tunnel
cat $tmp | \
  ssh -i ~/.ssh/id_rsa -R $revers_port:localhost:22 \
  $remote_user@$remotehost \
  "cat > ~/.ssh/id_rsa && chmod go= ~/.ssh/id_rsa &&
  echo 'ssh $USER@localhost -p $revers_port' > remote_me.sh;
  echo 'gardez cette fenetre ouverte ! CTRL+C pour quitter';
  sleep $sleep_time"
