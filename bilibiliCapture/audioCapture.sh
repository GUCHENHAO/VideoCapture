#!/bin/bash

cd ..
git pull
cd - > /dev/null

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

echo -e "file list: \n\r" > $dir/file_list.txt

url_pnt=0
while [ $url_pnt -lt $url_lst_len ]
do

  URL=${URL_LST[ $((url_pnt + 0)) ]}

  echo -n " audio$url_pnt :" >> $dir/file_list.txt

  annie.exe -i -o $dir -O audio$url_pnt $URL | grep "Title" | sed 's/Title://g' >> $dir/file_list.txt

  echo -e "\n\r" >> $dir/file_list.txt

  url_pnt=$((url_pnt + 1))

done

url_pnt=0
while [ $url_pnt -lt $url_lst_len ]
do

  echo -e "\n\r正在下载第$((url_pnt+1))个视频, 总共$url_lst_len个视频\n\r"

  URL=${URL_LST[ $((url_pnt + 0)) ]}

  annie.exe -o $dir -O audio$url_pnt $URL

  ffmpeg.exe -i $dir/audio$url_pnt.flv $dir/audio$url_pnt.mp3

  url_pnt=$((url_pnt + 1))

done
