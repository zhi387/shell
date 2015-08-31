#!/bin/bash
#
#定义备份源，目标，时间命名备份文件
#
sourcePath="/var/git"
dateDir=`date +%Y%m`
targetPath="$HOME/$dateDir"
backupName=`date +%Y%m%d`
#
#创建目录,~/date
if [ ! -e $targetPath ]
then
	mkdir $targetPath 
fi
#
#备份文件并压缩,~/date/git_date.tar.gz
cd $sourcePath && tar -zcvf "$targetPath/git_$backupName.tar.gz" ./*
#
#记录备份文件列表,~/date/git_date.log
ls -Rl >> "$targetPath/git_$backupName.log" 
