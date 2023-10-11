#!/bin/bash
# verifuser.sh $USERNAME $PASSWORD
# Verifica que username y password sean correctos. No correr como root porque puede hacer 'su'
if [ $(id -u) -eq 0 ]; then
        echo "No correr como root" 1>&2
        exit 1
fi

if [ ! $# -eq 2 ]; then
        echo "Necesito dos argumentos, recibi $#)" 1>&2
        exit 1
fi

USERNAME=$1
PASSWORD=$2

# idioma ingles para las claves
export LC_ALL=C

expect << EOF
spawn su $USERNAME -c "exit"
expect "Password:"
send "$PASSWORD\r"
# fin del expect

set wait_result  [wait]

# Si hay error de sistema operativo el index 2 es -1, 0 si fue respuesta del comando
if {[lindex \$wait_result 2] == 0} {
        exit [lindex \$wait_result 3]
}
else {
        exit 1
}
EOF
