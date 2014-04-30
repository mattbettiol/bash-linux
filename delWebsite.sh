#!/bin/bash
read -p "Enter a username to delete: " username
read -p "Enter that users domain: " domain

userdel -r ${username}
rm /etc/apache2/sites-available/${domain}
rm /etc/apache2/sites-enabled/${domain}
rm -rf /var/www/${domain}

service apache2 restart
service apache2 reload
