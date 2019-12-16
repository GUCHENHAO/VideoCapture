#!/bin/bash

cd ..
git pull
cd -

i=0
while read line
do
  if [[ $line == https* || $line == http* || $line == www* ]]
  then
    URL_LST[$i]=$line
    i=$((i+1))
  fi
done < url.txt

dir=$(date +%Y_%m%d_%H%M_%S)

mkdir $dir

cp url.txt $dir/url.txt

url_lst_len=${#URL_LST[*]}

echo "Total Video Num: $url_lst_len"

echo -e "file list: \n\r" > $dir/file_list.txt

url_pnt=0
while [ $url_pnt -lt $url_lst_len ]
do

  URL=${URL_LST[ $((url_pnt + 0)) ]}

  echo -n " audio$url_pnt :" >> $dir/file_list.txt

  annie.exe -c ./Cookies.txt -i -o $dir -O audio$url_pnt $URL | grep "Title" | sed 's/Title://g' >> $dir/file_list.txt

  echo -e "\n\r" >> $dir/file_list.txt

  url_pnt=$((url_pnt + 1))

done

url_pnt=0
while [ $url_pnt -lt $url_lst_len ]
do

  URL=${URL_LST[ $((url_pnt + 0)) ]}

  annie.exe -c ./Cookies.txt -o $dir -O audio$url_pnt $URL
  
  ffmpeg.exe -i $dir/audio$url_pnt.mp4 $dir/audio$url_pnt.mp3

  url_pnt=$((url_pnt + 1))

done

