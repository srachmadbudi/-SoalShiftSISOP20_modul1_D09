# SoalShiftSISOP20_modul1_D09
```
Rachmad Budi Santoso    05111840000122
Khofifah Nurlaela       05111840000025
```

## soal1
> Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”.
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :
>- a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit!
>- b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a!
>- c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian (state) hasil poin b!

> Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan
laporan tersebut. *Gunakan Awk dan Command pendukung

### 1.a
```
#!/bin/bash

#number1a
onea=$(awk -F "\t" '
{groupby[$13]+=$21}
END {
        for(reg in groupby) {
                print groupby[reg], reg
        }
}
' Sample-Superstore.tsv | sort -g | head -2 | tail -1)

region=$(cut -d ' ' -f2 <<<"$onea")
echo -e "1.a) Region dengan profit terkecil adalah $region\n"
```
Pada bagian 1.a ini kita sebagai yang sudah jago mengolah data membantu Whits untuk mentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit.
```
onea=$(awk -F "\t" '
```
Pada syntax tersebut kami menggunakan awk untuk membaca data dari file berdasarkan separator tab `\t` sebagai pemisahnya.

Selanjutnya, syntax `{groupby[$13]+=$21}` berfungsi untuk mengelompokkan dan menambahkan isi array berdasarkan profit pada kolom `$21` dari setiap region pada kolom `$13`.















```
#______________________________________________________________________
#number1b
oneb=$(awk -F "\t" -v reg="$region" '
$13 ~ reg {
        groupby[$11]+=$21
}
END {
        for( state in groupby ) {
                print groupby[state], state
        }
}
' Sample-Superstore.tsv | sort -g | head -2)

state1=$(cut -d $'\n' -f1 <<<"$oneb")
state1=$(cut -d ' ' -f2 <<<"$state1")
state2=$(cut -d $'\n' -f2 <<<"$oneb")
state2=$(cut -d ' ' -f2 <<<"$state2")
echo -e "1.b) State dengan profit terkecil adalah $state1 dan $state2\n"
```

```
<code>
#_______________________________________________________________________
#number1c
onec=$(awk -F "\t" -v st1="$state1" -v st2="$state2" '
$11 ~ st1 || $11 ~ st2 {
        groupby[$17]+=$21
}
END {
        for( product in groupby ) {
                print groupby[product], product
        }
}
' Sample-Superstore.tsv | sort -g | head -10)

p1=$(cut -d $'\n' -f1 <<<"$onec")
p1=$(cut --complement -d ' ' -f1 <<<"$p1")
p2=$(cut -d $'\n' -f2 <<<"$onec")
p2=$(cut --complement -d ' ' -f1 <<<"$p2")
p3=$(cut -d $'\n' -f3 <<<"$onec")
p3=$(cut --complement -d ' ' -f1 <<<"$p3")
p4=$(cut -d $'\n' -f4 <<<"$onec")
p4=$(cut --complement -d ' ' -f1 <<<"$p4")
p5=$(cut -d $'\n' -f5 <<<"$onec")
p5=$(cut --complement -d ' ' -f1 <<<"$p5")
p6=$(cut -d $'\n' -f6 <<<"$onec")
p6=$(cut --complement -d ' ' -f1 <<<"$p6")
p7=$(cut -d $'\n' -f7 <<<"$onec")
p7=$(cut --complement -d ' ' -f1 <<<"$p7")
p8=$(cut -d $'\n' -f8 <<<"$onec")
p8=$(cut --complement -d ' ' -f1 <<<"$p8")
p9=$(cut -d $'\n' -f9 <<<"$onec")
p9=$(cut --complement -d ' ' -f1 <<<"$p9")
p10=$(cut -d $'\n' -f10 <<<"$onec")
p10=$(cut --complement -d ' ' -f1 <<<"$p10")
echo -e  "1.c) Produk yang memiliki profit paling sedikit berdasarkan negara bagian
     $state1 dan $state2 adalah sebagai berikut:\n
 -$p1\n -$p2\n -$p3\n -$p4\n -$p5\n -$p6\n -$p7\n -$p8\n -$p9\n -$p10\n"
</code>
```
## soal2
> Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan data-data penting. 
Untuk mencegah kejadian yang sama terulang kembali mereka meminta bantuan kepada Whits karena dia adalah 
seorang yang punya banyak ide. Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan. Idenya adalah kalian 
>- (a) membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang 
terdapat huruf besar, huruf kecil, dan angka. 
>- (b) Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang 
diinputkan dan ​ HANYA ​ berupa alphabet​ .
>- (c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan dienkripsi dengan 
menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut 
dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi 
qbttxpse.txt dengan perintah ‘​ bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula seterusnya. Apabila melebihi ​ 
z ​ , akan kembali ke ​ a ​ , contoh: huruf ​ w dengan jam 5.28, maka akan menjadi huruf ​ b.​ ) 
>- (d) jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.

> HINT: enkripsi yang digunakan adalah caesar cipher.
> *Gunakan Bash Script

## 2(a)(b)
Untuk menyimpan password yang telah digenerate, user akan menginputkan nama file di mana password tersebut
akan disimpan.
Sebelumnya akan dicek dulu, apakah nama file yang diinputkan tersebut hanya mengandung alphabet?
Jika iya, maka program akan men-generate password kemudian akan disimpan ke dalam file yang sudah
diinputkan namanya.
Jika tidak, maka akan ditampilkan pesan error.

```
#!/bin/bash

var=$1

if [[ $var =~ ^[A-Za-z.]+$ ]]
        then cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 28 >> $var
        else echo "Nama file hanya menggunakan alphabet."
fi
```

Untuk menghasilkan password dengan ketentuan 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.

        
        cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 28	
        
## 2(c)
Sama seperti pada program untuk men-generate password.
Yang mana nama file yang akan dienkripsi akan dicek terlebih dahulu.
Apakah nama file yang diinputkan hanya mengandung alphabet?
Jika iya, maka nama file akan dienkripsi.
Jika tidak, akan ditampilkan pesan error.
```
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
```

```
cut -d '.' -f1 
```
Digunakan untuk memotong string setelah tanda '.' 
Sehingga didapat nama file tanpa ekstensi file yang kemudian nama file tersebut akan dienkripsi. 

```
stat -c %w $1 | date +"%k" -r $1
```
Digunakan untuk mendapatkan waktu dibuatnya file yang berisi password dalam satuan jam.
Yang kemudian digunakan untuk mengenkripsi nama file.

```
expr $geser + 97
expr $geser + 96
```
Waktu dalam satuan jam yang didapat tadi kemudian ditambah dengan 97,
karena nilai dari karakter a dalam ASCII adalah 97.
Diperlukan juga variabel lain yang ditambak dengan 96, untuk mengatasi error.
Karena setelah huruf z akan kembali ke huruf a.

```
chr() {
          printf "\\$(printf '%03o' "$1")"
 }
 ```       
 Digunakan untuk mengubah nilai ASCII menjadi karakter.
 
 ```
 tr [a-z] ["$char_awal"-za-"$char_akhir"] | 
 tr [A-Z] ["${char_awal^^}"ZA-"${char_akhir^^}"])"
 ```
 Digunakan untuk mengenkripsi, baik huruf kecil maupun huruf besar.
 
 ```
 mv $file.txt $enkrip.txt
 ```
 Digunakan untuk merename nama file.
 
 
