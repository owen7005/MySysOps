#!/bin/bash
#########################################################################
# File Name: ff.sh
# Author: mark
# Email: usertzc@gmail.com
# Version: 
# Created Time: 2016年12月27日 星期二 19时20分10秒
#########################################################################
wwwgit=/var/lib/jenkins/jenkins/
wwwroot=/data/wwwroot
if [ $# == 1 ];then
    banbenhao=`echo $1`
    cd $wwwgit
    if [ $banbenhao == 'latest' ];then
        git reset --hard HEAD^
    else
        git reset --hard $banbenhao
    fi
    ansible php -m synchronize -a "src=${wwwgit} dest=${wwwroot} rsync_opts=--delete"
    ansible php -a "chown -R www.www ${wwwroot}"
else
    cd ${wwwgit} && git pull 
    ansible php -m synchronize -a "src=${wwwgit} dest=${wwwroot} rsync_opts=--delete"
    ansible php -a "chown -R www.www ${wwwroot}"
fi
