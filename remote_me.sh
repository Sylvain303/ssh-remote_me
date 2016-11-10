#!/bin/bash
#
# Usage: ./remote_me.sh
#
# Install remote key for user before:
#  ssh-keygen -t rsa
#  ssh-copy-id -i ~/.ssh/id_rsa depanne@remotehost

cleanup() {
  rm -f $tmp $tmp.pub
  sed -e "/temp-key-remote_me/ d" -i ~/.ssh/authorized_keys
  return $?
}
 
control_c() {
  echo -en "\n*** FIN ***\n"
  cleanup
  exit $?
}
 
# trap keyboard interrupt (control-c)
trap control_c SIGINT


# 5 hours
sleep_time=$((5 * 3600))
# some free port which will be used on remote server
revers_port=19999
remotehost=geekmanager.ledragon.net
remote_user=depanne

#create a temp ssh-key
tmp=~/.ssh/remote_me_tmp$$
ssh-keygen -t rsa -P "" -C temp-key-remote_me -f $tmp
sed -e "/temp-key-remote_me/ d" -i ~/.ssh/authorized_keys
cat $tmp.pub >> ~/.ssh/authorized_keys
chmod go= ~/.ssh/authorized_keys

clear
cat $tmp | \
  ssh -R $revers_port:localhost:22 \
  $remote_user@$remotehost \
  "cat > ~/.ssh/id_rsa && chmod go= ~/.ssh/id_rsa &&
  echo 'ssh $USER@localhost -p $revers_port' > remote_me.sh;
  echo 'gardez cette fenetre ouverte ! CTRL+C pour quitter';
  sleep $sleep_time"
