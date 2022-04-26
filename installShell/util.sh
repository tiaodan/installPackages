#!/bin/bash
source color.sh

function getCfg(){
    local cfgPath="$1"
    source $cfgPath
	#source onekey.cfg

	#OLD_IFS=$IFS  # 备份IFS
	#IFS="|"
	#IFS=$OLD_IFS  # 恢复IFS默认
	#echoN '配置文件打印，之后删除'
	#colorEcho '配置文件 projectPath=' $nomal_info $projectPath
	#colorEcho '配置文件 baseService=' $nomal_info ${baseService[@]}
	#colorEcho '配置文件 baseServicePort=' $nomal_info ${baseServicePort[@]}
	#colorEcho '配置文件 icssService=' $nomal_info ${icssService[@]}
	#colorEcho '配置文件 icssServicePort=' $nomal_info ${icssServicePort[@]}
	#colorEcho '配置文件 microService=' $nomal_info ${microService[@]}
	#colorEcho '配置文件 microServicePort=' $nomal_info ${microServicePort[@]}
	#colorEcho '配置文件 nmsService=' $nomal_info ${nmsService[@]}
	#colorEcho '配置文件 nmsServicePort=' $nomal_info ${nmsServicePort[@]}
	#echo ''
}

function getFileSuffix() {
    local filename="$1"
    if [ -n "$filename" ]; then
        echo "${filename##*.}"
    fi
}

function IsSuffix() {
    local filename="$1"
    local suffix="$2"
    if [[ "$(getFileSuffix ${filename})" = "$suffix" ]]; then
		echo 1  # 借助echo 1和0，来返回内容
        #return 1
    else
		echo 0 
        #return 0
    fi
}

function getFullnameByPath() {
	local filename="$1"
	if [[ -n "$filename" ]]; then
        echo $filename | awk -F "/" '{print $NF}'
    fi
}


function getFilePrefix() {
    local filename="$1"
    if [[ -n "$filename" ]]; then
        withTar=`echo "${filename%.*}" | awk -F "/" '{print $NF}'`
		# 判断tar.gz这种，取前缀后还剩 *.tar情况
		echo "${withTar%.*}"
    fi
}

function getTimeSup() {
    startTime=$(date +%s)
    sleep 2
    endTime=$(date +%s)
    timeSup=`expr $endTime - $startTime`
	echo "时间差：$timeSup 秒"
}

function getAllIpLocalServerFromKylinReturnStr(){
	allIp=`/sbin/ifconfig -a|grep inet|grep -v inet6|awk '{print $2}'|tr -d "地址:"`
	echo $allIp
}

function getAllIpLocalServerFromKylinReturnStrList(){
	allIp=`/sbin/ifconfig -a|grep inet|grep -v inet6|awk '{print $2}'|tr -d "地址:"`

	#查看本级所有IP
    #allIpArr=($allIp)  # 转成数组
    echo ${allIp[@]}  # 数组处理
}

function checkLocalIpIfOne(){
    allIp=`/sbin/ifconfig -a|grep inet|grep -v inet6|awk '{print $2}'|tr -d "地址:"`
    allIpLen=${#allIp[*]}
    if [[ allIpLen == 1 ]];then
        echo ${allIp[0]}
    else
        echo 0
    fi

}


function getSameNetAllAvailableIpReturnStrList(){
    ip=$1

    if [[ -f "ipyes.txt" ]];then  # 删除可用ip txt文件
        rm -rf ipyes.txt
        rm -rf ipno.txt
    fi

    ## 1. 判断是不是ip
    isIp=`isValidIp $ip`
    if [[ "$isIp" == "0" ]];then
        echoE "非法ip，退出"
        return 0
    fi

    ## 1. 截取ip网段
    networkSegment=`getNetworkSegmentByIp $ip`

    for((i=1;i<255;i++));
    do
        {
            ping "$networkSegment.$i" -c 2 | grep -q "ttl=" && echo "$networkSegment.$i" >> ipyes.txt || echo "$networkSegment.$i" >> ipno.txt
        }&
    done
    wait

    ## 2. 返回str 数组形式的列表
    if [[ -f "ipyes.txt" ]];then
#        echo `cat ipyes.txt`
        # 返回排序后的ip
        echo `sort -t '.' -k1,1n -k2,2n -k3,3n -k4,4n ipyes.txt`
    else
        echo "0"
    fi
}


function getNetworkSegmentByIp() {
    local ip="$1"
    if [[ -n "$ip" ]]; then
        networkSegment=`echo "${ip%.*}" | awk -F "/" '{print $NF}'`
		echo "$networkSegment"
    fi
}

function isValidIp() {
  local ip=$1

  if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    ip=(${ip//\./ }) # 按.分割，转成数组，方便下面的判断
    if [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]];then
        echo "1"
    else
        echo "0"
    fi
  else
    echo "0"
  fi
}


function findBigFile(){
	read -p "请输入文件大小(正整数, 单位：M)：(Ctrl+C 取消) " fileSize
	echoN '查找大文件,大文件列表如下：'
	find / -type f -size +${fileSize}M
	
}

function checkPortIsStart(){
    port=$1
    if [[ `netstat -anp | grep -v grep | grep $port`  ]];then
        echo 1
    else
        echo 0
    fi
}

function checkIpIsConnect(){
    ip=$?
#    ping 3次，不通就不执行！！
    pingResult=`ping -c 3 $ip`

    ####### 用是否是0的方式检测
#    if [[ $? -eq 0 ]];then  # 0是能ping通
#        echo "1"
#    else
#        echo "0"
#    fi

    ##### 用检测ttl方式
    if [[ $pingResult =~ "ttl=" ]];then  # 0是能ping通
        echo 1
    else
        echo 0
    fi
}

function getIpFromDns(){
    dns=$?
    ipFromDns=`ping -c 1 $dns | sed '1{s/[^(]*(//;s/).*//;q}'`

    echo $ipFromDns
}

function checkDbCanConnect(){
    dbIp=$1
    dbUsername=$2
    dbPassword=$3

    if [[ `mysqladmin -h$dbIp -u$dbUsername -p$dbPassword  ping` =~ "mysqld is alive" ]];then
        return 1
    else
        return 0
    fi
}


function getDbAllDatabases(){
    dbIp=$1
    dbUsername=$2
    dbPassword=$3

    echo `mysqlshow -h$dbIp -u$dbUsername -p$dbPassword`
}


function check_digits()
{
    local count=${#1}
    if [[ "$1" =~ [0-9]{$count} ]]; then
        #echo "All digits."
#		return 1
		echo 1
    else
        #echo "Not all digits."
#		return 0
		echo 0
    fi
}

function pkillJava(){
    pkill java
}


function unzipFile(){
    local filePath="$1"
    local unzipPath="$2"
    if [[ `getFileSuffix $filePath` == "gz" ]];then
        echoN 'tar.gz安装包'
        tar -zxvf $filePath -C $unzipPath > /dev/null  # 强制覆盖
    elif [[ `getFileSuffix $filePath` == "tar" ]];then
        echoN 'tar安装包'
        tar -xvf $filePath -C $unzipPath > /dev/null
    elif [[ `getFileSuffix $filePath` == "tgz" ]];then
        echoN 'tgz安装包'
        tar -zxvf $filePath -C $unzipPath > /dev/null
    elif [[ `getFileSuffix $filePath` == "zip" ]];then
        unzip -d $unzipPath -o $filePath > /dev/null  # 强制替换
        echoN 'zip安装包'
    elif [[ `getFileSuffix $filePath` == "rpm" ]];then
        echoN 'rpm安装包'
        rpm -ivh  $filePath
    elif [[ `getFileSuffix $filePath` == "deb" ]];then
        echoN 'deb安装包'
        dpkg -i  $filePath
    else
        echoE '安装包类型不支持，仅支持tar.gz、tar、zip、rpm、deb'
        return 0
    fi
}


function setLocalServerDate(){
#    echoN "时间格式yyyymmdd hh:mm:ss  例: 20210926 18:30:00"
    echoN "输入日期yyyymmdd 例: 20210926"
    read -p "请输入时间(格式yyyymmdd):"  userInputDate
    date -s $userInputDate
    echoN "输入时间hh:mm:ss 例: 21:10:10"
    read -p "请输入时间(格式hh:mm:ss):"  userInputTime
    date -s $userInputTime

    hwclock --systohc # 根据系统时间同步硬件时间

}


function setDatetimeSync(){
    # 1. 判断本机是否是授时服务器
    echoN "本机是否是授时服务器？"
    echoN "1. 是"
    echoN "2. 否"
    read -p "请选择序号:"  userChooseIsNtpServerIndex
    if [[ $userChooseIsNtpServerIndex == "1" ]];then
        userChooseIsNtpServer=1
    else
        userChooseIsNtpServer=0
    fi

    if [[ $systemVersion == "centos7" ]];then
        # 3. 根据是否是授时服务器，先查询服务是否能用，再关闭服务，手动同步下时间，修改配置
        # 本机是授时服务器
        if [[ $userChooseIsNtpServer -eq 1 ]];then
            echoN "本机》》授时服务器"
            # 3.1 查看是否安装ntp
            systemctl restart ntpd
            if [[ `rpm -qa|grep ntp| grep -v ntpdate |wc -l` -ge 1 && `systemctl status ntpd` =~ 'running' ]];then
                echoN "安装了ntp,且可用"
                \cp $projectPath/installPackages/centos7/conf/ntp.conf /etc
                sed -i 's/^[^#].*\prefer/#&/g' /etc/ntp.conf # 注释 prefer
                systemctl restart ntpd  # 重启服务
#                systemctl status ntpd
            else
                echoE "ntp不可用"
                # 使用ntpdate + 定时任务 crontab
    #            sed -i '$a\0 12 * * * \/usr\/sbin\/ntpdate '"$ntpServerIp"'' /etc/crontab
                \cp $projectPath/installPackages/conf/.syncDatetimeCrontab /root
                chmod +x /root/.syncDatetimeCrontab
                chmod 777 /root/.syncDatetimeCrontab
                sed -i "s/ntpServerIp/$ntpServerIp/g" /root/.syncDatetimeCrontab

                sed -i "/syncDatetimeCrontab/"d /etc/crontab
                sed -i '$a\*\/10 * * * * \/root\/.syncDatetimeCrontab' /etc/crontab
            fi
        fi

        # ntp客户端
        if [[ $userChooseIsNtpServer -eq 0 ]];then
            echoN "本机》》ntp 客户端"

            # 2. 选择授时服务器ip,给出本网段所有ip
            echoN "查询授时服务器IP..."
            sameNetAllAvailableIp=(`getSameNetAllAvailableIpReturnStrList $localIp`)
            if [[ "$sameNetAllAvailableIp" == "0" ]];then
                echoE "同网段无可用ip"
            else
                echo "同网段有可用ip，ip=  $sameNetAllAvailableIp 等。"
            fi

            sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
            # 打印同网段所有ip
            for((i=0;i<sameNetAllAvailableIpLen;i++));
            do
                echoN "$i. ${sameNetAllAvailableIp[$i]}"
            done

            echoN "998. 不知道"
            echoN "999. 自己输入IP"
            read -p "以上是同网段所有IP,请选择授时服务器IP(选IP前的序号):" ntpServerIpIndex
            if [[ $ntpServerIpIndex -lt 998 ]];then
        #                echo "用户输入 < 998"
                ntpServerIp=${sameNetAllAvailableIp[$ntpServerIpIndex]}
                echo "用户输入的序号和ip= $ntpServerIpIndex $ntpServerIp"
            elif [[ $ntpServerIpIndex == "998" ]];then
                echo "用户输入 998"
                ntpServerIp=$localIp
            elif [[ $ntpServerIpIndex == "999" ]];then
                echo "用户输入 999"
                read -p "请输入IP： " userInputNtpServerIp
                if [[ `isValidIp $userInputNtpServerIp` == "0"  ]];then
                    echoE "IP格式错误"
                    return 0
                fi
                ntpServerIp=$userInputNtpServerIp
            else
                echoE "序号不支持"
            fi

            # 3.1 查看是否安装ntp
            systemctl restart ntpd
            if [[ `rpm -qa|grep ntp| grep -v ntpdate |wc -l` -ge 1 && `systemctl status ntpd` =~ 'running' ]];then
                echoN "安装了ntp,且可用"
                ## 手动同步时间后，使用ntp同步
                echoN "手动同步时间后，使用ntp同步"
                systemctl stop ntpd
#                systemctl status ntpd
                if [[ `ntpdate $ntpServerIp` =~ 'no server suitable for synchronization found' ]];then
                    hwclock -w
                    echoE "授时服务器未开启服务，无法手动同步，先配置。。"
                fi

                \cp $projectPath/installPackages/centos7/conf/ntp.conf /etc
                \cp $projectPath/installPackages/conf/.syncDatetimeCrontab /root
                sed -i 's/^[^#].*\prefer/#&/g' /etc/ntp.conf  # 加注释
                sed -i 's/^[^#].*127.127.1.0/#&/g' /etc/ntp.conf  # 加注释
                sed -i "s/restrict default.*$/restrict default/g" /etc/ntp.conf
                sed -i "s/ntpServerIp/$ntpServerIp/g" /etc/ntp.conf
                sed -i "s/ntpServerIp/$ntpServerIp/g" /root/.syncDatetimeCrontab

                systemctl restart ntpd  # 重启服务
#                systemctl status ntpd
            else
                echoE "ntp不可用"
                # 使用ntpdate + 定时任务 crontab
    #            sed -i '$a\0 12 * * * \/usr\/sbin\/ntpdate '"$ntpServerIp"'' /etc/crontab
                \cp $projectPath/installPackages/conf/.syncDatetimeCrontab /root
                chmod +x /root/.syncDatetimeCrontab
                chmod 777 /root/.syncDatetimeCrontab
                sed -i "s/ntpServerIp/$ntpServerIp/g" /root/.syncDatetimeCrontab

                sed -i "/syncDatetimeCrontab/"d /etc/crontab
                sed -i '$a\*\/10 * * * * \/root\/.syncDatetimeCrontab' /etc/crontab
            fi
        fi

        # 4. 重启服务器
        # 5. 验证服务是否启动成功
    elif [[ $systemVersion == "kylin" ]];then
        # 3. 根据是否是授时服务器，先查询服务是否能用，再关闭服务，手动同步下时间，修改配置
        # 本机是授时服务器
        if [[ $userChooseIsNtpServer -eq 1 ]];then
            # 3.1 查看是否安装ntp
            /etc/init.d/ntpd stop
            /etc/init.d/ntpd start
            if [[ `dpkg --get-selections | grep ntp | grep -v ntpdate | wc -l` -ge 1 && `/etc/init.d/ntpd status` =~ 'running' ]];then
                echoN "安装了ntp,且可用"
                ## 手动同步时间后，使用ntp同步
                echoN "手动同步时间后，使用ntp同步"
                /etc/init.d/ntpd stop
                /etc/init.d/ntpd status
                if [[ `ntpdate $ntpServerIp` =~ 'no server suitable for synchronization found' ]];then
                    hwclock -w
                    echoE "授时服务器未开启服务，无法手动同步，先配置。。"
                fi

                \cp $projectPath/installPackages/centos7/conf/ntp.conf /etc
                sed -i 's/^[^#].*\prefer/#&/g' /etc/ntp.conf # 注释 prefer
                /etc/init.d/ntpd stop  # 重启服务
                /etc/init.d/ntpd start
                /etc/init.d/ntpd status
            else
                echoE "ntp不可用"
                # 使用ntpdate + 定时任务 crontab
    #            sed -i '$a\0 12 * * * \/usr\/sbin\/ntpdate '"$ntpServerIp"'' /etc/crontab
                \cp $projectPath/installPackages/conf/.syncDatetimeCrontab /root
                sed -i "s/ntpServerIp/$ntpServerIp/g" /root/.syncDatetimeCrontab

                sed -i "/syncDatetimeCrontab/"d /etc/crontab
                sed -i '$a\*\/10 * * * * \/root\/.syncDatetimeCrontab' /etc/crontab
            fi
        fi

        # ntp客户端
        if [[ $userChooseIsNtpServer -eq 0 ]];then
            # 2. 选择授时服务器ip,给出本网段所有ip
            echoN "查询授时服务器IP..."
            sameNetAllAvailableIp=(`getSameNetAllAvailableIpReturnStrList $localIp`)
            if [[ "$sameNetAllAvailableIp" == "0" ]];then
                echoE "同网段无可用ip"
            else
                echo "同网段有可用ip，ip=  $sameNetAllAvailableIp 等。"
            fi

            sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
            # 打印同网段所有ip
            for((i=0;i<sameNetAllAvailableIpLen;i++));
            do
                echoN "$i. ${sameNetAllAvailableIp[$i]}"
            done

            echoN "998. 不知道"
            echoN "999. 自己输入IP"
            read -p "以上是同网段所有IP,请选择授时服务器IP(选IP前的序号):" ntpServerIpIndex
            if [[ $ntpServerIpIndex -lt 998 ]];then
        #                echo "用户输入 < 998"
                ntpServerIp=${sameNetAllAvailableIp[$ntpServerIpIndex]}
                echo "用户输入的序号和ip= $ntpServerIpIndex $ntpServerIp"
            elif [[ $ntpServerIpIndex == "998" ]];then
                echo "用户输入 998"
                ntpServerIp=$localIp
            elif [[ $ntpServerIpIndex == "999" ]];then
                echo "用户输入 999"
                read -p "请输入IP： " userInputNtpServerIp
                if [[ `isValidIp $userInputNtpServerIp` == "0"  ]];then
                    echoE "IP格式错误"
                    return 0
                fi
                ntpServerIp=$userInputNtpServerIp
            else
                echoE "序号不支持"
            fi

            # 3.1 查看是否安装ntp
            /etc/init.d/ntpd stop
            /etc/init.d/ntpd start
            if [[ `rpm -qa|grep ntp| grep -v ntpdate |wc -l` -ge 1 && `systemctl status ntpd` =~ 'running' ]];then
                echoN "安装了ntp,且可用"
                \cp $projectPath/installPackages/centos7/conf/ntp.conf /etc
                \cp $projectPath/installPackages/conf/.syncDatetimeCrontab /root
                sed -i 's/^[^#].*\prefer/#&/g' /etc/ntp.conf  # 加注释
                sed -i 's/^[^#].*127.127.1.0/#&/g' /etc/ntp.conf  # 加注释
                sed -i "s/restrict default.*$/restrict default/g" /etc/ntp.conf
                sed -i "s/ntpServerIp/$ntpServerIp/g" /etc/ntp.conf
                sed -i "s/ntpServerIp/$ntpServerIp/g" /root/.syncDatetimeCrontab

                /etc/init.d/ntpd stop  # 重启服务
                /etc/init.d/ntpd start
                /etc/init.d/ntpd status
            else
                echoE "ntp不可用"
                # 使用ntpdate + 定时任务 crontab
    #            sed -i '$a\0 12 * * * \/usr\/sbin\/ntpdate '"$ntpServerIp"'' /etc/crontab
                \cp $projectPath/installPackages/conf/.syncDatetimeCrontab /root
                sed -i "s/ntpServerIp/$ntpServerIp/g" /root/.syncDatetimeCrontab

                sed -i "/syncDatetimeCrontab/"d /etc/crontab
                sed -i '$a\*\/10 * * * * \/root\/.syncDatetimeCrontab' /etc/crontab
            fi
        fi
    elif [[ $systemVersion == "kylin-x86" ]];then
        # 3. 根据是否是授时服务器，先查询服务是否能用，再关闭服务，手动同步下时间，修改配置
        # 本机是授时服务器
        if [[ $userChooseIsNtpServer -eq 1 ]];then
            echoN "本机》》授时服务器"
            # 3.1 查看是否安装ntp
            systemctl restart ntpd
            if [[ `rpm -qa|grep ntp| grep -v ntpdate |wc -l` -ge 1 && `systemctl status ntpd` =~ 'running' ]];then
                echoN "安装了ntp,且可用"
                \cp $projectPath/installPackages/centos7/conf/ntp.conf /etc
                sed -i 's/^[^#].*\prefer/#&/g' /etc/ntp.conf # 注释 prefer
                systemctl restart ntpd  # 重启服务
#                systemctl status ntpd
            else
                echoE "ntp不可用"
                # 使用ntpdate + 定时任务 crontab
    #            sed -i '$a\0 12 * * * \/usr\/sbin\/ntpdate '"$ntpServerIp"'' /etc/crontab
                \cp $projectPath/installPackages/conf/.syncDatetimeCrontab /root
                chmod +x /root/.syncDatetimeCrontab
                chmod 777 /root/.syncDatetimeCrontab
                sed -i "s/ntpServerIp/$ntpServerIp/g" /root/.syncDatetimeCrontab

                sed -i "/syncDatetimeCrontab/"d /etc/crontab
                sed -i '$a\*\/10 * * * * \/root\/.syncDatetimeCrontab' /etc/crontab
            fi
        fi

        # ntp客户端
        if [[ $userChooseIsNtpServer -eq 0 ]];then
            echoN "本机》》ntp 客户端"

            # 2. 选择授时服务器ip,给出本网段所有ip
            echoN "查询授时服务器IP..."
            sameNetAllAvailableIp=(`getSameNetAllAvailableIpReturnStrList $localIp`)
            if [[ "$sameNetAllAvailableIp" == "0" ]];then
                echoE "同网段无可用ip"
            else
                echo "同网段有可用ip，ip=  $sameNetAllAvailableIp 等。"
            fi

            sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
            # 打印同网段所有ip
            for((i=0;i<sameNetAllAvailableIpLen;i++));
            do
                echoN "$i. ${sameNetAllAvailableIp[$i]}"
            done

            echoN "998. 不知道"
            echoN "999. 自己输入IP"
            read -p "以上是同网段所有IP,请选择授时服务器IP(选IP前的序号):" ntpServerIpIndex
            if [[ $ntpServerIpIndex -lt 998 ]];then
        #                echo "用户输入 < 998"
                ntpServerIp=${sameNetAllAvailableIp[$ntpServerIpIndex]}
                echo "用户输入的序号和ip= $ntpServerIpIndex $ntpServerIp"
            elif [[ $ntpServerIpIndex == "998" ]];then
                echo "用户输入 998"
                ntpServerIp=$localIp
            elif [[ $ntpServerIpIndex == "999" ]];then
                echo "用户输入 999"
                read -p "请输入IP： " userInputNtpServerIp
                if [[ `isValidIp $userInputNtpServerIp` == "0"  ]];then
                    echoE "IP格式错误"
                    return 0
                fi
                ntpServerIp=$userInputNtpServerIp
            else
                echoE "序号不支持"
            fi

            # 3.1 查看是否安装ntp
            systemctl restart ntpd
            if [[ `rpm -qa|grep ntp| grep -v ntpdate |wc -l` -ge 1 && `systemctl status ntpd` =~ 'running' ]];then
                echoN "安装了ntp,且可用"
                ## 手动同步时间后，使用ntp同步
                echoN "手动同步时间后，使用ntp同步"
                systemctl stop ntpd
#                systemctl status ntpd
                if [[ `ntpdate $ntpServerIp` =~ 'no server suitable for synchronization found' ]];then
                    hwclock -w
                    echoE "授时服务器未开启服务，无法手动同步，先配置。。"
                fi

                \cp $projectPath/installPackages/centos7/conf/ntp.conf /etc
                \cp $projectPath/installPackages/conf/.syncDatetimeCrontab /root
                sed -i 's/^[^#].*\prefer/#&/g' /etc/ntp.conf  # 加注释
                sed -i 's/^[^#].*127.127.1.0/#&/g' /etc/ntp.conf  # 加注释
                sed -i "s/restrict default.*$/restrict default/g" /etc/ntp.conf
                sed -i "s/ntpServerIp/$ntpServerIp/g" /etc/ntp.conf
                sed -i "s/ntpServerIp/$ntpServerIp/g" /root/.syncDatetimeCrontab

                systemctl restart ntpd  # 重启服务
#                systemctl status ntpd
            else
                echoE "ntp不可用"
                # 使用ntpdate + 定时任务 crontab
    #            sed -i '$a\0 12 * * * \/usr\/sbin\/ntpdate '"$ntpServerIp"'' /etc/crontab
                \cp $projectPath/installPackages/conf/.syncDatetimeCrontab /root
                chmod +x /root/.syncDatetimeCrontab
                chmod 777 /root/.syncDatetimeCrontab
                sed -i "s/ntpServerIp/$ntpServerIp/g" /root/.syncDatetimeCrontab

                sed -i "/syncDatetimeCrontab/"d /etc/crontab
                sed -i '$a\*\/10 * * * * \/root\/.syncDatetimeCrontab' /etc/crontab
            fi
        fi

        # 4. 重启服务器
        # 5. 验证服务是否启动成功
    fi
}


function testUtilEcho(){
    echo "测试util 方法打印"
}


function getFileListFromPath(){
    local path=$1
    local fileList=`ls $path`
    if [ ! -d "$path" ];then
        mkdir -vp $path  # 文件夹不存在，自动创建
    fi
    if [ -n "$fileList" ];then # 非空
        echo $fileList
    else  # 空
        echo 0
    fi
}


function getLocalServerAllAvailableIpList(){
    local systemVersion=$1
    case $systemVersion in
    'centos7')
        local allIp=`ifconfig -a|grep inet|grep -v inet6|awk '{print $2}'|tr -d "地址:"`
        # ping 下，看通不通
        rm -rf ipyes.txt
        rm -rf ipno.txt
        for i in $allIp
        do
            {
                ping "$i" -c 2 | grep -q "ttl=" && echo "$i" >> ipyes.txt || echo "$i" >> ipno.txt
            }&
        done
        wait

        if [  -s ipyes.txt ];then  # -s 判断是否不为0
            # 返回排序后的ip
            echo `sort -t '.' -k1,1n -k2,2n -k3,3n -k4,4n ipyes.txt`
        else
            echo 0
        fi
        ;;
    'kylin')
        local allIp=`ifconfig -a|grep inet|grep -v inet6|awk '{print $2}'|tr -d "地址:"`
        # ping 下，看通不通
        rm -rf ipyes.txt
        rm -rf ipno.txt
        for i in $allIp
        do
            echo "ip == $i"
            {
                ping "$i" -c 2 | grep -q "ttl=" && echo "$i" >> ipyes.txt || echo "$i" >> ipno.txt
            }&
        done
        wait

        if [ -s ipyes.txt ];then  # -s 判断是否不为0
            # 返回排序后的ip
            echo `sort -t '.' -k1,1n -k2,2n -k3,3n -k4,4n ipyes.txt`
        else
            echo 0
        fi
        ;;
    'kylin-x86')
        local allIp=`ifconfig -a|grep inet|grep -v inet6|awk '{print $2}'|tr -d "地址:"`
        # ping 下，看通不通
        rm -rf ipyes.txt
        rm -rf ipno.txt
        for i in $allIp
        do
            {
                ping "$i" -c 2 | grep -q "ttl=" && echo "$i" >> ipyes.txt || echo "$i" >> ipno.txt
            }&
        done
        wait

        if [  -s ipyes.txt ];then  # -s 判断是否不为0
            # 返回排序后的ip
            echo `sort -t '.' -k1,1n -k2,2n -k3,3n -k4,4n ipyes.txt`
        else
            echo 0
        fi
        ;;
    'centos8')
        local allIp=`ifconfig -a|grep inet|grep -v inet6|awk '{print $2}'|tr -d "地址:"`
        # ping 下，看通不通
        rm -rf ipyes.txt
        rm -rf ipno.txt
        for i in $allIp
        do
            {
                ping "$i" -c 2 | grep -q "ttl=" && echo "$i" >> ipyes.txt || echo "$i" >> ipno.txt
            }&
        done
        wait

        if [  -s ipyes.txt ];then  # -s 判断是否不为0
            # 返回排序后的ip
            echo `sort -t '.' -k1,1n -k2,2n -k3,3n -k4,4n ipyes.txt`
        else
            echo 0
        fi
        ;;
    esac
}


function getLocalServerAllAvailableNetworkCardList(){
    local systemVersion=$1
    case $systemVersion in
    'centos7')
        echo `ifconfig | grep RUNNING | awk '{print $1}' | sed 's/.$//g'`
        ;;
    'kylin')
        # 1. 获取网卡名称
        # 2. 根据网卡名称，判断是否有ip可ping通
        # 3. 根据可ping通的ip,来输入list
        local allAvailableIps=()
        local allNetworkCards=`ifconfig | grep 'Link encap' | awk '{print $1}'`
        for i in $allNetworkCards
        do
            # 查找ip
#            echo "=========================当前i ===           $i"
#            echo "inet==" `ifconfig $i | grep 'inet'`
#            echo "running==" `ifconfig $i | grep 'RUNNING'`
            if [[ -n `ifconfig $i | grep 'inet'` && -n `ifconfig $i | grep 'RUNNING'` ]];then
                allAvailableIps+=($i)
            fi
        done
        if [ -n "${allAvailableIps[*]}" ];then
            echo ${allAvailableIps[*]}
        else
            echo 0
        fi
        ;;
    'kylin-x86')
        echo `ifconfig | grep RUNNING | awk '{print $1}' | sed 's/.$//g'`
        ;;
    'centos8')
        echo `ifconfig | grep RUNNING | awk '{print $1}' | sed 's/.$//g'`
        ;;
    esac
}


function getPidsByName(){
    local processName=$1
    local pids=`ps -ef|grep $processName | grep -v grep | awk '{print $2}'`  # 先查询pid
	if [ -z "$pids" ];then  # 串的长度为0时为真(空串)
#		echo 0
		echo ""
	else
		echo $pids
	fi

}

function getRealSystemVersion(){
    ## 判断真实系统
        if [[ `uname -r` =~ "kylin" ]];then
            echo 'kylin'
#            echoE "kylin - arm 系统 ！！！！！"
#            echoN "判断真实系统= $realSystemVersion"
        elif [[ `uname -r` =~ "el7" ]];then
            echo 'centos7'
        elif [[ `uname -r` =~ "el8"  ]];then
            echo 'centos8'
        else
#            echoE "本服务器为其它系统,暂不支持!!,尝试通过yum /dpkg 命令来判断!"
            if [[ `uname -r` =~ "ky" ]];then
                if [[ ! `yum --version` =~ 'General YUM options' ]];then
                     echo 'kylin-x86'
                fi
            else
#                echoE "通过uname 和yum命令无法查出本服务器类型,按centos7 系统来安装"
                echo 'centos7'
            fi
        fi
}


