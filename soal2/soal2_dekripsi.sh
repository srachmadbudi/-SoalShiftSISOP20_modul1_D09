#!/bin/bash

if [[ $1 =~ ^[A-Za-z.]+$ ]]
then 
        file=$(echo $1 | cut -d '.' -f1)
        geser=$(stat -c %w $1 | date +"%k" -r $1)

        int_awal=`expr $geser + 97`
        int_akhir=`expr $geser + 96`

        chr() {
           printf "\\$(printf '%03o' "$1")"
        }

        char_awal=`chr $int_awal`
        char_akhir=`chr $int_akhir`

        dekrip="$(echo "$file" | tr ["$char_awal"-za-"$char_akhir"] [a-z] | tr$

        cp $1 $dekrip.txt
        echo "Nama file berhasil didekripsi menjadi $dekrip.txt"

else "Nama file hanya menggunakan alphabet."
fi
