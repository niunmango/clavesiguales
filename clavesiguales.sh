#!/bin/bash
# clavesiguales.sh
for user in $(cut -d: -f1 /etc/passwd)
do
  ./verifuser.sh $user $user;
  if [ $? == 0 ]
  then
    echo -e "\033[0;31mEl usuario $user tiene su usuario como clave\033[0m";
  fi
done
