#!/bin/bash
if [ $(id -u) -eq 0 ]; then
  read -p "Enter a username: " username
  read -s -p "Enter a password: " password
  egrep "^$username" /etc/passwd >/dev/null
  echo ""
  pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
  useradd -m -p $pass $username
  chmod 711 /home/$username
  [ $? -eq 0 ] && echo "$username has been added to system!" || echo "Failed to add $username to the system!"
  echo "Enter the domain name:";
  read domain;
  echo ""
  cd /home/${username}
  mkdir public_html
  chown ${username}:${username} *
  mkdir /var/www/${domain}/
  ln -s /home/${username}/public_html /var/www/${domain}/public_html
  chown -R ${username}:${username} /var/www/${domain}/public_html
  chmod -R 755 /var/www
  cp /etc/apache2/sites-available/forCreate /etc/apache2/sites-available/${domain}
  perl -pi -e "s/ServerName domain.com/ServerName ${domain}/g" /etc/apache2/sites-available/${domain}
  perl -pi -e "s/ServerAlias www.domain.com/ServerAlias www.${domain}/g" /etc/apache2/sites-available/${domain}
  perl -pi -e "s/DocumentRoot \\/var\\/www\\/domain.com\\/public_html/DocumentRoot \\/var\\/www\\/${domain}\\/public_html/g" /etc/apache2/sites-available/${domain}
  a2ensite ${domain}
  service apache2 restart
  service apache2 reload
  #nano /etc/apache2/sites-available/${domain}
else
  echo "Only root is allowed to create a user & Virtual Host!"
  exit 2
fi
