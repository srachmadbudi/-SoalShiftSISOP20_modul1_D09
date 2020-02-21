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

        enkrip="$(echo "$file" | tr [a-z] ["$char_awal"-za-"$char_akhir"] | tr$

        mv $file.txt $enkrip.txt
        echo "File berhasil dipindah ke $enkrip.txt"

else echo "Nama file hanya menggunakan alphabet."
fi
