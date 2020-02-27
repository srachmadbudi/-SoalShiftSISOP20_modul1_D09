
#!/bin/bash

var=$1

if [[ $var =~ ^[A-Za-z.]+$ ]]
        then 
        cat /dev/urandom | tr -dc 'a-z' | head -c 10 >> $var
        cat /dev/urandom | tr -dc 'A-Z' | head -c 9 >> $var
        cat /dev/urandom | tr -dc '0-9' | head -c 9 >> $var

        else echo "Nama file hanya menggunakan alphabet."
fi

