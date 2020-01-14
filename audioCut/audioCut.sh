#!/bin/bash

read -p "请输入音/视频名称：" nm

read -p "请输入起始时间(小时)：" st_h
read -p "请输入起始时间(分钟)：" st_m
read -p "请输入起始时间(秒钟)：" st_s
st=$((3600*st_h+60*st_m+st_s))

read -p "请输入结束时间(小时)：" ed_h
read -p "请输入结束时间(分钟)：" ed_m
read -p "请输入结束时间(秒钟)：" ed_s
ed=$((3600*ed_h+60*ed_m+ed_s))

tm=$((ed-st))
tm_h=$((tm/3600))
tm_m=$(((tm-tm_h*3600)/60))
tm_s=$((tm-tm_h*3600-tm_m*60))

# echo ${tm_h}:${tm_m}:${tm_s}

rm -rf cut.${nm}

echo "请确认："
echo -n "待剪音/视频名称："
echo $nm
echo -n "剪出音/视频名称："
echo cut.$nm
echo -n "剪辑时间："
echo ${st_h}:${st_m}:${st_s}-${ed_h}:${ed_m}:${ed_s}
read -p "按Enter开始：" er

ffmpeg.exe -ss ${st_h}:${st_m}:${st_s} -t ${tm_h}:${tm_m}:${tm_s} -i $nm cut.${nm}
