#!/bin/bash

read -p "请输入音/视频名称：" nm

rm -rf cut.${nm}

echo "请确认："
echo -n "待剪音/视频名称："
echo $nm
echo -n "剪出音/视频名称："
echo $nm.mp3

ffmpeg.exe -i $nm ${nm}.mp3
