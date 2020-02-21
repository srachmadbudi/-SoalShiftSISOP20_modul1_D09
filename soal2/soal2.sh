
#!/bin/bash

var=$1

if [[ $var =~ ^[A-Za-z.]+$ ]]
        then cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 28 >> $var
        else echo "Nama file hanya menggunakan alphabet."
fi

