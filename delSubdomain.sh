#!/bin/bash
  echo "Enter the username that owns this subdomain"
  read username
  echo "What domain is this a subdomain of?"
  read domain
  echo "Enter the subdomain"
  read subdomain

  rm -rf /home/${username}/${subdomain}.${domain}
  rm -rf /var/www/${domain}/${subdomain}.${domain}
  rm -rf /etc/apache2/sites-available/${subdomain}.${domain}
  rm -rf /etc/apache2/sites-enabled/${subdomain}.${domain}

  service apache2 restart
  service apache2 reload
