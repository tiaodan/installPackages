#!/bin/bash

source color.sh
source util.sh
source init.sh

source guideUser.sh

## 初始化
# 判断系统是否对
if [ "$realSystemVersion" != "$systemVersion" ];then
    echoE "配置的系统与实际不符，请进行引导！！！"
    exit
fi
crateProjectFolder

if [[ ! `getLocalServerAllAvailableIpList $systemVersion` =~ "$localIp" ]];then
    echoE "配置里的localIp($localIp) ping不通，这能行吗？ 退出脚本！！！"
    exit
fi

source business.sh
source menu.sh


