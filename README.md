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
END {
        for(reg in groupby) {
                print groupby[reg], reg
        }
}
```
Pada bagian END, kami melakukan looping untuk menampilkan seluruh profit `groupby[reg]` dari setiap region `reg`.

`sort -g` Mengurutkan data secara general, termasuk positif dan negatif.
`head -2` Menampilkan 2 data teratas dengan profit terkecil.
`tail -1` Menampilkan 1 data dari bawah.

Hal ini dilakukan karena kami melakukan perhitungan sejak kolom pertama, dimana pada kolom `$13` dimulai dengan title `region` yang berisi profit terkecil karena tidak memiliki data atau dengan kata lain berisi string huruf bukan angka sehingga menjadi yang terkecil. Untuk mengabaikan judul kolom tersebut maka digunakanlah cara diatas.

```
region=$(cut -d ' ' -f2 <<<"$onea")
echo -e "1.a) Region dengan profit terkecil adalah $region\n"
```
Syntax diatas berfungsi untuk memisahkan komponen dari hasil pencarian yang dilakukan (Jumlah profit[spasi]Region).
`cut -d ''` Memisahkan komonen berdasarkan spasi, `-f2` menampilkan field kedua dari komponen tersebut (hanya nama regionnya saja yang ditampilkan).


### 1.b
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
Pada bagian 1.b ini kita sebagai yang sudah jago mengolah data membantu Whits untuk mentukan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a.

```
oneb=$(awk -F "\t" -v reg="$region" '
```
Pada syntax tersebut kami menggunakan awk untuk membaca data dari file berdasarkan separator tab `\t` sebagai pemisahnya dan menggunakan data `$region` yang sudah diperoleh pada bagian a.

```
$13 ~ reg {
        groupby[$11]+=$21
}
```
Selanjutnya, syntax `{groupby[$13]+=$21}` berfungsi untuk mengelompokkan dan menambahkan isi array berdasarkan profit pada kolom `$21` dari setiap state pada kolom `$11` yang sebelumnya sudah difilter menggunakan data region(regex `~` mencari komponen yang mengandung `reg`).

```
END {
        for( state in groupby ) {
                print groupby[state], state
        }
}
```
Pada bagian END, kami melakukan looping untuk menampilkan seluruh profit `groupby[state]` dari setiap negara bagian `state`.
`sort -g` Mengurutkan data secara general, termasuk positif dan negatif.
`head -2` Menampilkan 2 data teratas dengan profit terkecil. 

```
state1=$(cut -d $'\n' -f1 <<<"$oneb")
state1=$(cut -d ' ' -f2 <<<"$state1")
state2=$(cut -d $'\n' -f2 <<<"$oneb")
state2=$(cut -d ' ' -f2 <<<"$state2")
echo -e "1.b) State dengan profit terkecil adalah $state1 dan $state2\n"
```
Syntax diatas berfungsi untuk memisahkan komponen dari hasil pencarian yang dilakukan (Jumlah profit[spasi]State).
`cut -d $'\n'` Memisahkan komonen berdasarkan enter, `-f1` menampilkan field pertama dari komponen tersebut  `cut -d ' '` Memisahkan komonen berdasarkan spasi, `-f2` menampilkan field kedua dari komponen tersebut (hanya nama regionnya saja yang ditampilkan).


### 1.c
```
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
```
Penjelasannya sama seperti bagian a dan b, yang berbeda adalah pada bagian 1.c ini kita sebagai yang sudah jago mengolah data membantu Whits untuk menampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b.



## soal2
Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan data-data penting. 
Untuk mencegah kejadian yang sama terulang kembali mereka meminta bantuan kepada Whits karena dia adalah 
seorang yang punya banyak ide. Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan. Idenya adalah kalian 
(a) membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, 
dan angka.
(b) Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang 
diinputkan dan ​ HANYA ​ berupa alphabet​ .
(c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan dienkripsi dengan 
menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut 
dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi 
qbttxpse.txt dengan perintah ‘​ bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula seterusnya. Apabila melebihi ​ 
z ​ , akan kembali ke ​ a ​ , contoh: huruf ​ w dengan jam 5.28, maka akan menjadi huruf ​ b.​ ) 
(d) jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.

HINT: enkripsi yang digunakan adalah caesar cipher.
*Gunakan Bash Script

## Jawaban
## 2(a)(b)
Jawaban soal (a) dan (b) dijalankan pada satu program.
Untuk menyimpan password yang telah digenerate, user akan menginputkan nama file di mana password tersebut akan disimpan.
Sebelumnya akan dicek dulu, apakah nama file yang diinputkan tersebut hanya mengandung alphabet atau tidak.
Jika iya, maka program akan men-generate password kemudian akan disimpan ke dalam file yang sudah diinputkan namanya.
Jika tidak, maka akan ditampilkan pesan error.


```
cat /dev/urandom | tr -dc 'a-z' | head -c 10 >> $var
cat /dev/urandom | tr -dc 'A-Z' | head -c 9 >> $var
cat /dev/urandom | tr -dc '0-9' | head -c 9 >> $var
```     
Untuk memastikan password yang dibuat dengan ketentuan 28 karakter dan minimal terdapat satu huruf kecil, satu huruf kapital, dan satu 
angka.

`cat` digunakan untuk menampilkan isi dari file yang mengikutinya.
`/dev/urandom/` digunakan untuk menghasilkan bit acak.
`tr -dc 'a-z'` digunakan untuk mendelete karakter dan hanya menampilkan karakter huruf kecil.
`tr -dc 'A-Z'` digunakan untuk mendelete karakter dan hanya menampilkan karakter huruf besar.
`tr -dc '0-9'` digunakan untuk mendelete karakter dan hanya menampilkan karakter huruf angka.
`head -c ` digunakan untuk menampilkan karakter sebanyak yang diinginkan.
        
## 2(c)
Sama seperti pada program untuk men-generate password. Yang mana nama file yang akan dienkripsi akan dicek terlebih dahulu.
Apakah nama file yang diinputkan hanya mengandung alphabet? Jika iya, maka nama file akan dienkripsi.
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
Variabel file akan menyimpan nama file tanpa ekstensinya.Kemudian command `cut` digunakan untuk memotong string setelah tanda '.' 
Sehingga didapat nama file tanpa ekstensi file yang kemudian nama file tersebut akan dienkripsi. 


```
stat -c %w $1 | date +"%k" -r $1
```
Digunakan untuk mendapatkan waktu dibuatnya file yang berisi password dalam satuan jam. Kemudian disimpan dalam variabel geser.


```
int_awal=`expr $geser + 97`
int_akhir=`expr $geser + 96`
```
Variable `int_awal` digunakan untuk mengenkripsi alphabet, yaitu dengan menambahkan nilai ASCII karakter a-z dengan nilai variabel 
geser.
Agar setelah karakter z enkripsi dapat kembali ke karakter a, digunakan variable bantuan `int_akhir`.


```
chr() {
          printf "\\$(printf '%03o' "$1")"
 }
 ```       
 Merupakan fungsi untuk mengubah nilai ASCII menjadi karakter ASCII.


 ```
 tr [a-z] ["$char_awal"-za-"$char_akhir"] | 
 tr [A-Z] ["${char_awal^^}"ZA-"${char_akhir^^}"])"
 ```
 Untuk mengenkripsi digunakan command `tr`, menerjemahkan karakter `a-z` menjadi karakter yang telah berhasil digeser berdasarkan waktu 
 file tersebut dibuat.
 Selain dapat mengenkripsi karakter huruf kecil, program juga dapat mengenkripsi karakter huruf besar.
 
 ```
 mv $file.txt $enkrip.txt
 ```
 Digunakan untuk merename nama file yang belum dienkripsi menjadi nama file yang sudah dienkripsi.
 
 ## 2(d)
 Menggunakan algoritma yang sama dengan jawaban nomor 2(d). 
 Perbedaannya ada pada proses dekripsinya.
 
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

        dekrip="$(echo "$file" | tr ["$char_awal"-za-"$char_akhir"] [a-z] | tr ["${char_awal^^}"-ZA-"${char_akhir^^}"] [A-Z])"

        mv $1 $dekrip.txt
        echo "Nama file berhasil didekripsi menjadi $dekrip.txt"

else "Nama file hanya menggunakan alphabet."
fi
```
Untuk mengdekripsi digunakan command `tr`, menerjemahkan karakter karakter yang telah berhasil digeser berdasarkan waktu file tersebut 
dibuat kembali menjadi karakter `a-z`.

## Nomor 3
1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. 
Tapi apa daya hati yang sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma, kalian mencoba menghibur Kusuma 
dengan mengirimkan gambar kucing. 
(a) Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari "​https://loremflickr.com/320/240/cat​" menggunakan 
command ​wget dan menyimpan file dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,      pdkt_kusuma_3) serta jangan 
lupa untuk menyimpan ​log messages ​wget kedalam sebuah file "wget.log"​. 
(b) Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download 
tersebut hanya berjalan setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu.
(c) Karena gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan gambar yang terdownload itu identik. Supaya 
gambar yang identik tidak dikira Kusuma sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar identik. Setelah 
memilah gambar yang identik, maka dihasilkan gambar yang berbeda antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian 
kirim ke Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan selalu menghibur Kusuma, jadi gambar yang 
telah terkirim tadi akan kalian simpan kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. Maka dari itu buatlah 
sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar 
yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate dengan format filename 
"duplicate_nomor" (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder 
./kenangan dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di​current 
directory ​ , maka lakukan backup seluruh log menjadi ekstensi ".log.bak"​. Hint : Gunakan wget.log untuk membuat location.log yang 
isinya merupakan hasil dari grep "Location".  
*Gunakan Bash, Awk dan Crontab 

## Jawaban
## 3(a)
Untuk mengunduh 28 gambar dari link yang ada digunakan perulangan dari 1 sampai 28.

```
for i in {1..28}
do
 wget -O pdkt_kusuma_$i loremflickr.com/320/240/cat -a wget.log
done
```

command `wget` digunakan untuk mengunduh file dari suatu link. (https://loremflickr.com/320/240/cat).
`-O pdkt_kusuma_$i` agar file yang diunduh dapat disimpan dengan nama pdkt_kusuma_NO.
`-a wget.log` digunakan untuk menyimpan semua log messages dari `wget` dan menyimpannya dalam file `wget.log`. `-a` adalah append to 
logfile, maknanya akan menambahkan dari yang sudah ada.
