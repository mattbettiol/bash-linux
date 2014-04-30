#!/bin/bash
  echo "What usename will own this subdomain?"
  read username
  echo "What domain will this be a subdomain of?"
  read domain
  echo "Enter the subdomain"
  read subdomain

  mkdir -p /home/${username}/${subdomain}.${domain}
  chmod 755 /home/${username}/${subdomain}.${domain}
  chown -R ${username}:${username} /home/${username}/${subdomain}.${domain}

  ln -s /home/${username}/${subdomain}.${domain} /var/www/${domain}/${subdomain}.${domain}

  cp /etc/apache2/sites-available/forCreate /etc/apache2/sites-available/${subdomain}.${domain}

  perl -pi -e "s/ServerName domain.com/ServerName ${subdomain}.${domain}/g" /etc/apache2/sites-available/${subdomain}.${domain}
  perl -pi -e "s/ServerAlias www.domain.com//g" /etc/apache2/sites-available/${subdomain}.${domain}
  perl -pi -e "s/DocumentRoot \\/var\\/www\\/domain.com\\/public_html/DocumentRoot \\/var\\/www\\/${domain}\\/${subdomain}.${domain}\\//g" /etc/apache2/sites-available/${subdomain}.${domain}
  
  a2ensite ${subdomain}.${domain}
  service apache2 restart
  service apache2 reload
