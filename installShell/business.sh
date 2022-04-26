#!/bin/bash

# --------------------------------------------------------------------------- #
# 卸载java --> centos7
# --------------------------------------------------------------------------- #
function removeInstalledJDK(){
	echo "已安装的jdk列表如下：__________"
	for installedJDK in `rpm -qa|grep jdk`
	do
		echo $installedJDK
		rpm -e --nodeps $installedJDK
	done
	echo "________________________________"
}


# --------------------------------------------------------------------------- #
# 检查是否卸载成功自带java  --> centos7
# --------------------------------------------------------------------------- #
function checkIsRemoveInstalledJDK(){
	if [ `rpm -qa|grep jdk | wc -l` -eq 0 ];then
		echo "jdk成功卸载"
	fi
}


# --------------------------------------------------------------------------- #
# 安装jdk
# --------------------------------------------------------------------------- #
function installJDK(){
    if [[ "$systemVersion" == 'centos7' || "$systemVersion" == 'centos8' || "$systemVersion" == 'kylin-x86' ]];then
        if [[ `rpm -qa|grep jdk | wc -l ` -eq 0 ]];then
            echo "java 未安装，安装jdk。。。。"
            echoN "jdk 目录 $jdkOfflinePackagePath"
            echoN "project 目录 $projectPath"
            rpm -ivh $jdkOfflinePackagePath
        fi
    fi
}

function checkService(){
	local startTime=$(date +%s)

	baseServiceLen=${#baseService[*]}
	baseServicePortLen=${#baseServicePort[*]}
	microServiceLen=${#microService[*]}
	microServicePortLen=${#microServicePort[*]}
	icssServiceLen=${#icssService[*]}
	icssServicePortLen=${#icssServicePort[*]}
	nmsServiceLen=${#nmsService[*]}
	nmsServicePortLen=${#nmsServicePort[*]}
	switchServiceLen=${#switchService[*]}
	switchServicePortLen=${#switchServicePort[*]}

	#预制条件
	checkNameArr=(基础 微服务 调度 网管 核心网)
	serviceCfgName=(baseService microService icssService nmsService switchService)  # 配置文件里键值对，键的名称，用户信息提示！

	##5. 检测所有服务运行
	for((a=0;a<5;i++));
	do
		if [[ $a -eq 0 ]];then  # 基础服务
			Service=(${baseService[@]})  # 转成数组，否则查询程序时候会有问题，${baseService[@]}是字符串
			ServicePort=(${baseServicePort[@]})
			ServiceLen=$baseServiceLen
			ServicePortLen=$baseServicePortLen
			if [[ $isCheckBaseService == "0" || ${isCheckBaseService,,} == "false" || ${isCheckBaseService^^} == "FALSE" ]];then
                ServiceLen=0
			    ServicePortLen=0
			fi
		fi

		if [[ $a -eq 1 ]];then  # 微服务
			Service=(${microService[@]})  # 转成数组，否则查询程序时候会有问题，${baseService[@]}是字符串
			ServicePort=(${microServicePort[@]})
			ServiceLen=$microServiceLen
			ServicePortLen=$microServicePortLen
			if [[ $isCheckMicroService == "0" || ${isCheckMicroService,,} == "false" || ${isCheckMicroService^^} == "FALSE" ]];then
                ServiceLen=0
			    ServicePortLen=0
			fi
		fi

		if [[ $a -eq 2 ]];then  # 调度
			Service=(${icssService[@]})  # 转成数组，否则查询程序时候会有问题，${baseService[@]}是字符串
			ServicePort=(${icssServicePort[@]})
			ServiceLen=$icssServiceLen
			ServicePortLen=$icssServicePortLen
			if [[ $isCheckDispService == "0" || ${isCheckDispService,,} == "false" || ${isCheckDispService^^} == "FALSE" ]];then
                ServiceLen=0
			    ServicePortLen=0
			fi
		fi

		if [[ $a -eq 3 ]];then  # 网管
			Service=(${nmsService[@]})  # 转成数组，否则查询程序时候会有问题，${baseService[@]}是字符串
			ServicePort=(${nmsServicePort[@]})
			ServiceLen=$nmsServiceLen
			ServicePortLen=$nmsServicePortLen
			if [[ $isCheckNmsService == "0" || ${isCheckNmsService,,} == "false" || ${isCheckNmsService^^} == "FALSE" ]];then
                ServiceLen=0
			    ServicePortLen=0
			fi
		fi

		if [[ $a -eq 4 ]];then  # 核心网
			Service=(${switchService[@]})  # 转成数组，否则查询程序时候会有问题，${baseService[@]}是字符串
			ServicePort=(${switchServicePort[@]})
			ServiceLen=$switchServiceLen
			ServicePortLen=$switchServicePortLen
			if [[ $isCheckSwitchService == "0" || ${isCheckSwitchService,,} == "false" || ${isCheckSwitchService^^} == "FALSE" ]];then
                ServiceLen=0
			    ServicePortLen=0
			fi
		fi
		# 打印
		if [[ $ServiceLen -gt 0 ]];then
		    colorEcho "========$nomal_info ${checkNameArr[$a]} $nostyle 服务软件(后台启动情况" $nomal_info $ServiceLen $nostyle "个)========="
			for((i=0;i<$ServiceLen;i++));
			do
				# 只根据名字查询
				searchServiceResult=`ps -ef | grep ${Service[$i]} |grep -v "grep" | wc -l`
				if [[ ${ServicePort[$i]} = "null" || ${ServicePort[$i]} = "" ]];then
					if [[ $searchServiceResult -gt 0 ]];then
						colorEcho  $[i+1] ${Service[$i]} '端口:' ${ServicePort[$i]} $right_info '已启动'
					else
						colorEcho  $[i+1] ${Service[$i]} '端口:' ${ServicePort[$i]} $error_info '未启动'
					fi
				fi

				# 根据名字 和端口查询
				if [[ ${ServicePort[$i]} != "null" && ${ServicePort[$i]} != "" ]];then
					searchServicePortResult=`netstat -antup |grep ${ServicePort[$i]} | wc -l`
					if [[ $searchServiceResult -gt 0 && $searchServicePortResult -gt 0 ]];then
						colorEcho  $[i+1] ${Service[$i]} '端口:' ${ServicePort[$i]} $right_info '已启动'
					else
						colorEcho  $[i+1] ${Service[$i]} '端口:' ${ServicePort[$i]} $error_info '未启动'
					fi
				fi

			done
		echo ""
		else
#			echoE '配置文件' ${serviceCfgName[$i]} '行无内容，请检查！'
            echo ""
		fi

		a=$[$a+1]  # 累加
	done

	local endTime=$(date +%s)
	local timeSup=`expr $endTime - $startTime`
	colorEcho "用时:" $nomal_info $timeSup "秒"
}


function pkillJava_disp(){
	echo '执行命令：pkillJava——disp'
	oamStop -a
}


function pkillJava_nms(){
	echo '执行命令：pkillJava——nms'
	cd $projectPath/nms/backend
	if [ -f "runAll.sh" ];then
	    ./runAll.sh stop
	fi
	sleep 2

	cd $projectPath/micro
	if [ -f "runAll.sh" ];then
	    ./runAll.sh stop
	fi
	sleep 2

	cd $projectPath/gateway/sun-nms-devconfig-service-0.0.1-SNAPSHOT
	./run.sh stop
	sleep 1

	cd $projectPath/gateway/user-omc-service-0.0.1-SNAPSHOT
	./run.sh stop
	sleep 1

	pids=`ps -ef|grep nms | grep -v grep | awk '{print $2}'`  # 先查询pid
	kill -9 $pids  # 杀掉进程

}


function removeExistedProject(){
	echo '删除已有程序'
	cd $projectPath  # 以防把根目录删了
	rm -rf gateway  # 删除gateway
	rm -rf micro  # 删除micro
	rm -rf nms  # 删除 nms
	rm -rf disp  # 删除disp
	rm -rf installPackages/conf  # 删除配置文件
	rm -rf googlemaps  # 删除地图
	cd /root # 避免把root目录也删了
	rm -rf .NE  # 删除NE,

	sleep 3

	if [[ ! -d "$projectPath/gateway" ]];then
		echo "删除gateway目录成功"
		echo "删除gateway目录成功" >> $logfile
	else
		echo "删除gateway目录失败"
		echo "删除gateway目录失败" >> $logfile
	fi

	if [[ ! -d "$projectPa用户本地IPth/micro" ]];then
		echo "删除micro目录成功"
		echo "删除micro目录成功" >> $logfile
	else
		echo "删除micro目录失败"
		echo "删除micro目录失败" >> $logfile
	fi

	if [[ ! -d "$projectPath/nms" ]];then
		echo "删除nms目录成功"
		echo "删除nms目录成功" >> $logfile
	else
		echo "删除nms目录失败"
		echo "删除nms目录失败" >> $logfile
	fi

	if [[ ! -d "$projectPath/disp" ]];then
		echo "删除disp目录成功"
		echo "删除disp目录成功" >> $logfile
	else
		echo "删除disp目录失败"
		echo "删除disp目录失败" >> $logfile
	fi

	if [[ ! -d "/root/.NE" ]];then
		echo "删除NE目录成功"
		echo "删除NE目录成功" >> $logfile
	else
		echo "删除NE目录失败"
		echo "删除NE目录失败" >> $logfile
	fi

	if [[ ! -d "$projectPath/installPackages/conf" ]];then
		echo "删除配置文件目录成功"
		echo "删除配置文件目录成功" >> $logfile
	else
		echo "删除配置文件目录失败"
		echo "删除配置文件目录失败" >> $logfile
	fi

	if [[ ! -d "$projectPath/googlemaps" ]];then
		echo "删除 地图 目录成功"
		echo "删除 地图 目录成功" >> $logfile
	else
		echo "删除 地图 目录失败"
		echo "删除 地图 目录失败" >> $logfile
	fi
}


function removeExistedProject_disp(){
	echo '删除已有程序'

	cd $projectPath  # 以防把根目录删了
	rm -rf disp  # 删除disp
	rm -rf /root/.NE  # 删除NE
	rm -rf installPackages/conf  # 删除配置文件

	sleep 3

	if [[ ! -d "$projectPath/disp" ]];then
		echo "删除disp目录成功"
		echo "删除disp目录成功" >> $logfile
	else
		echo "删除disp目录失败"
		echo "删除disp目录失败" >> $logfile
	fi

	if [[ ! -d "/root/.NE" ]];then
		echo "删除NE目录成功"
		echo "删除NE目录成功" >> $logfile
	else
		echo "删除NE目录失败"
		echo "删除NE目录失败" >> $logfile
	fi

	if [[ ! -d "$projectPath/installPackages/conf" ]];then
		echo "删除配置文件目录成功"
		echo "删除配置文件目录成功" >> $logfile
	else
		echo "删除配置文件目录失败"
		echo "删除配置文件目录失败" >> $logfile
	fi
}


# --------------------------------------------------------------------------- #
# 删除已有程序  -- 仅网管
# --------------------------------------------------------------------------- #
function removeExistedProject_nms(){
	echo '删除已有程序'
	cd $projectPath
	rm -rf gateway  # 删除gateway
	rm -rf micro  # 删除micro
	rm -rf nms  # 删除 nms
	rm -rf googlemaps # 删除地图
	rm -rf installPackages/conf  # 删除配置文件

	sleep 3

	if [[ ! -d "$projectPath/gateway" ]];then
		echo "删除gateway目录成功"
		echo "删除gateway目录成功" >> $logfile
	else
		echo "删除gateway目录失败"
		echo "删除gateway目录失败" >> $logfile
	fi

	if [[ ! -d "$projectPath/micro" ]];then
		echo "删除micro目录成功"
		echo "删除micro目录成功" >> $logfile
	else
		echo "删除micro目录失败"
		echo "删除micro目录失败" >> $logfile
	fi

	if [[ ! -d "$projectPath/nms" ]];then
		echo "删除nms目录成功"
		echo "删除nms目录成功" >> $logfile
	else
		echo "删除nms目录失败"
		echo "删除nms目录失败" >> $logfile
	fi


	if [[ ! -d "$projectPath/installPackages/conf" ]];then
		echo "删除配置文件目录成功"
		echo "删除配置文件目录成功" >> $logfile
	else
		echo "删除配置文件目录失败"
		echo "删除配置文件目录失败" >> $logfile
	fi

	if [[ ! -d "$projectPath/googlemaps" ]];then
		echo "删除 地图 目录成功"
		echo "删除 地图 目录成功" >> $logfile
	else
		echo "删除 地图 目录失败"
		echo "删除 地图 目录失败" >> $logfile
	fi
}


# --------------------------------------------------------------------------- #
# 安装nginx
# --------------------------------------------------------------------------- #
function installNginx() {
    # 思路：
    # 0. 计时start
    # 1. 读取配置，安装源+安装目的地
    # 2. 判断配置是否正确，安装源+安装目的地是否正确？目录是否自动创建？
    # 3. 根据系统，停掉服务
    # 4. 根据系统，删除已安装的程序包
    # 5. 根据系统，判断安装包类型，解压到目的地
    # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
    # 7. 加权限
    # 8. 根据系统，制作自启动/添加自启动
    # 9. 根据系统，检测是否安装成功
    # 10. 根据实际情况，安装完之后是否要启动？-不启动，如果有已经启动的nginx,还要测试安装nginx情况
    # 11. 计时end

    # 0. 计时start
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>>安装 nginx'

    # 2. 判断配置是否正确，安装源+安装目的地是否正确？目录是否自动创建？
    # 自动创建文件夹
    if [ ! -d "$nginxInstallPath" ];then
        echoN "nginx 安装文件夹 $nginxInstallPath 不存在，创建~"
        echo "`(date +"%Y-%m-%d %H:%M:%S")` nginx 安装文件夹 $nginxInstallPath 不存在，创建"  >> "$logfile/install-`(date +%Y%m%d)`.log"
        mkdir -vp $nginxInstallPath
    fi

	# 判断安装文件路径是否存在
	if [[ -f "$nginxOfflinePakagePath" ]];then
		echoN "nginx 安装文件 $nginxOfflinePakagePath 存在"
	else
		echoE "nginx 安装文件 $nginxOfflinePakagePath 不存在，请查看配置 nginxOfflinePakagePath"
        echo "`(date +"%Y-%m-%d %H:%M:%S")` nginx 安装文件 $nginxOfflinePakagePath 不存在，请查看配置 nginxOfflinePakagePath"  >> "$logfile/install-`(date +%Y%m%d)`.log"
		return 0
	fi

	# 判断安装目录是否存在
	if [[ -d "$nginxInstallPath" ]];then
		echoN "nginx 安装目录 $nginxInstallPath 存在"
	else
		echoE "nginx 安装目录 $nginxInstallPath 不存在，请查看配置 nginxInstallPath"
        echo "`(date +"%Y-%m-%d %H:%M:%S")` nginx 安装目录 $nginxInstallPath 不存在，请查看配置 nginxOfflinePakagePath"  >> "$logfile/install-`(date +%Y%m%d)`.log"
		return 0
	fi

	# 3. 根据系统，停掉服务
	stopNginx

	# 4. 根据系统，删除已安装的程序包
	cd $nginxInstallPath  # 以防把根目录删了
	rm -rf nginx  #这个nginx解压版本如果换了，还得改

	# 5. 根据系统，判断安装包类型，解压到目的地
	unzipFile $nginxOfflinePakagePath $nginxInstallPath

	# 6. 根据系统，查找自定义的配置，修改软件实际配置文件
	if [ "$systemVersion" == 'centos7' ];then
	    echoR "installNginx --> centos7 流程"
	    # 替换这个版本配置文件
	    \cp $projectPath/installPackages/commonConf/nginx/centos7/nginx.conf $nginxInstallPath/nginx/conf
	    # 转成unix文件
	    sed -i 's/\r//' $projectPath/installPackages/commonConf/nginx/centos7/update/update.txt
        # 根据自定义文件，更新配置
        # read line
        while read line || [[ -n ${line} ]]
        do
            if [[ $line =~ ^#.* || -z $line || $line == ' ' ]];then
                continue
            fi

            k=${line%=*}  # =前
            v=${line#*=}  # =后
            v=`eval echo ${v%#*}`  # 去掉空格, #号之前内容
            sed -i "s#$k#$v#g" $nginxInstallPath/nginx/conf/nginx.conf  # 本地ip
        done < $projectPath/installPackages/commonConf/nginx/centos7/update/update.txt

        # 7. 加权限
        chmod 777 $nginxInstallPath/nginx/*
        chmod 777 $nginxInstallPath/nginx/sbin/*
        chmod 777 $nginxInstallPath/nginx/conf/*
        chmod 777 /etc/rc.local
        chmod 777 /etc/rc.d/rc.local

        # 8. 根据系统，制作自启动/添加自启动
        # 拷贝启动文件
        \cp -f $projectPath/installPackages/commonConf/nginx/centos7/service/nginx.service /etc/systemd/system
        # 添加权限
        chmod 777 /etc/systemd/system/nginx.service
        systemctl daemon-reload  # 更新自启动
        systemctl enable nginx  # 设置自启动
    elif [ "$systemVersion" == 'kylin' ];then
        echoR "installNginx --> kylin 流程"
        # 替换这个版本配置文件
	    \cp $projectPath/installPackages/commonConf/nginx/kylin/nginx.conf $nginxInstallPath/nginx/conf

	    # 转成unix文件
	    sed -i 's/\r//' $projectPath/installPackages/commonConf/nginx/kylin/update/update.txt
        # 根据自定义文件，更新配置
        # read line
        while read line || [[ -n ${line} ]]
        do
            if [[ $line =~ ^#.* || -z $line || $line == ' ' ]];then
                continue
            fi

            k=${line%=*}  # =前
            v=${line#*=}  # =后
            v=`eval echo ${v%#*}`  # 去掉空格, #号之前内容
#            echo "k+v= $k : $v"
            sed -i "s#$k#$v#g" $nginxInstallPath/nginx/conf/nginx.conf  # 本地ip
        done < $projectPath/installPackages/commonConf/nginx/kylin/update/update.txt

        # 7. 加权限
        chmod 777 $nginxInstallPath/nginx/*
        chmod 777 $nginxInstallPath/nginx/sbin/*
        chmod 777 $nginxInstallPath/nginx/conf/*
        chmod 777 /etc/rc.local
        chmod 777 /etc/rc.d/rc.local

        # 8. 根据系统，制作自启动/添加自启动 -- delete
    elif [ "$systemVersion" == 'kylin-x86' ];then
	    echoR "installNginx --> kylin-x86 流程"
	    # 替换这个版本配置文件
	    \cp $projectPath/installPackages/commonConf/nginx/kylin-x86/nginx.conf $nginxInstallPath/nginx/
        \cp /usr/sbin/nginx /usr/sbin/

	    # 转成unix文件
	    sed -i 's/\r//' $projectPath/installPackages/commonConf/nginx/kylin-x86/update/update.txt
        # 根据自定义文件，更新配置
        # read line
        while read line || [[ -n ${line} ]]
        do
            if [[ $line =~ ^#.* || -z $line || $line == ' ' ]];then
                continue
            fi

            k=${line%=*}  # =前
            v=${line#*=}  # =后
            v=`eval echo ${v%#*}`  # 去掉空格, #号之前内容
            sed -i "s#$k#$v#g" $nginxInstallPath/nginx/nginx.conf  # 本地ip
        done < $projectPath/installPackages/commonConf/nginx/kylin-x86/update/update.txt

        # 7. 加权限
        chmod 777 $nginxInstallPath/nginx/*
        chmod 777 /etc/rc.local
        chmod 777 /etc/rc.d/rc.local

		# 拷贝 ssl文件夹
		\cp -rf $projectPath/installPackages/commonConf/nginx/kylin-x86/ssl $nginxInstallPath/nginx

        # 8. 根据系统，制作自启动/添加自启动
        # 拷贝启动文件
        \cp -rf $projectPath/installPackages/commonConf/nginx/kylin-x86/service/nginx.service /etc/systemd/system
        # 添加权限
        chmod 777 /etc/systemd/system/nginx.service
        systemctl daemon-reload  # 更新自启动
        systemctl enable nginx  # 设置自启动
    elif [ "$systemVersion" == 'centos8' ];then
	    echoR "installNginx --> centos8 流程"
	    # 替换这个版本配置文件
	    \cp $projectPath/installPackages/commonConf/nginx/centos8/nginx.conf $nginxInstallPath/nginx/conf
	    # 转成unix文件
	    sed -i 's/\r//' $projectPath/installPackages/commonConf/nginx/centos8/update/update.txt
        # 根据自定义文件，更新配置
        # read line
        while read line || [[ -n ${line} ]]
        do
            if [[ $line =~ ^#.* || -z $line || $line == ' ' ]];then
                continue
            fi

            k=${line%=*}  # =前
            v=${line#*=}  # =后
            v=`eval echo ${v%#*}`  # 去掉空格, #号之前内容
            sed -i "s#$k#$v#g" $nginxInstallPath/nginx/conf/nginx.conf  # 本地ip
        done < $projectPath/installPackages/commonConf/nginx/centos8/update/update.txt

        # 7. 加权限
        chmod 777 $nginxInstallPath/nginx/*
        chmod 777 $nginxInstallPath/nginx/sbin/*
        chmod 777 $nginxInstallPath/nginx/conf/*
        chmod 777 /etc/rc.local
        chmod 777 /etc/rc.d/rc.local

        # 8. 根据系统，制作自启动/添加自启动
        # 拷贝启动文件
        \cp -f $projectPath/installPackages/commonConf/nginx/centos8/service/nginx.service /etc/systemd/system

        offlineInstallSwitchCommonLib # 安装common库
        # 拷贝libssl + libcrypto
        \cp  $projectPath/installPackages/commonConf/nginx/centos8/lib64/libcrypto.so.10 /home/common
        \cp  $projectPath/installPackages/commonConf/nginx/centos8/lib64/libssl.so.10 /home/common
        ldconfig

        # 添加权限
        chmod 777 /etc/systemd/system/nginx.service
        systemctl daemon-reload  # 更新自启动
        systemctl enable nginx  # 设置自启动
    fi

	# 9. 根据系统，检测是否安装成功
	nginxInstallPackageName=`getFilePrefix $nginxOfflinePakagePath`  # 不带后缀
#	if [[ -d "$nginxInstallPath/$nginxInstallPackageName" ]];then
	if [[ -d "$nginxInstallPath/nginx" ]];then
		echoR 'nginx 安装后的文件夹已存在，安装成功！'
	else
		echoE 'nginx 安装后的文件夹不存在，安装失败！'
        echo "`(date +"%Y-%m-%d %H:%M:%S")` nginx 安装后的文件夹不存在，安装失败"  >> "$logfile/install-`(date +%Y%m%d)`.log"
	fi
	
	# 自启动
	restartNginx

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function stopNginx(){
    # 思路：3种方式确保程序停掉了 (kill -9 + pkill + systemctl stop )
    # 1. kill -9
    # 2. pkil
    # 3. systemctl stop
    echoN "停止 nginx"

    if [ "$systemVersion" == 'centos7' ];then
        systemctl stop nginx
    elif [ "$systemVersion" == 'kylin' ];then
        pkill nginx
    elif [ "$systemVersion" == 'kylin-x86' ];then
        systemctl stop nginx
    elif [ "$systemVersion" == 'centos8' ];then
        systemctl stop nginx
    fi
    local pids=`getPidsByName nginx`
    echoR "启动的nginx pdis= $pids"
    if [ -n "$pids" ];then
        kill -9 $pids
    fi
    pkill nginx
}


function restartNginx(){
    # 思路：
    # 1. 杀掉进程 (kill -9 + pkill )
    # 2. 判断系统，进行重启命令
    stopNginx

	# 重启nginx
	echoN "nginx 重启中。。！"

	## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then
        systemctl stop nginx
        systemctl restart nginx
    elif [[ $systemVersion == 'kylin' ]];then
	    $nginxInstallPath/nginx/sbin/nginx -c $nginxInstallPath/nginx/conf/nginx.conf
    elif [[ $systemVersion == 'kylin-x86' ]];then
	    systemctl stop nginx
        systemctl restart nginx
    elif [[ $systemVersion == 'centos8' ]];then
        systemctl stop nginx
        systemctl restart nginx
	fi

	echo "重启nginx完成" >> "$logfile/run-`(date +%Y%m%d)`.log"
	echoN "nginx 重启完成"
}

function startNginx(){
    # 思路：
    # 2. 判断系统，进行重启命令
    stopNginx

	# 重启nginx
	echoN "nginx 重启中。。！"

	## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then
        systemctl start nginx
    elif [[ $systemVersion == 'kylin' ]];then
	    $nginxInstallPath/nginx/sbin/nginx -c $nginxInstallPath/nginx/conf/nginx.conf
    elif [[ $systemVersion == 'kylin-x86' ]];then
        systemctl start nginx
    elif [[ $systemVersion == 'centos8' ]];then
        systemctl stop nginx
        systemctl start nginx
	fi

	echo "重启nginx完成" >> "$logfile/run-`(date +%Y%m%d)`.log"
	echoN "nginx 重启完成"
}


function installRedis(){

	echoN '>>>>>>>>>>>>安装 redis'
    local startTime=$(date +%s)

    if [[ ! -d "$redisInstallPath" ]];then
        echoN "redis 安装文件夹 $redisInstallPath 不存在，创建~"
        echo "`(date +"%Y-%m-%d %H:%M:%S")` redis 安装文件夹 $redisInstallPath 不存在，创建"  >> "$logfile/install-`(date +%Y%m%d)`.log"
        mkdir -vp $redisInstallPath
    fi

	if [[ -f "$redisOfflinePakagePath" ]];then
		echoN "redis 安装文件 $redisOfflinePakagePath 存在"
	else
		echoE "redis安装文件 $redisOfflinePakagePath 不存在，请查看配置 redisOfflinePakagePath"
		echo "`(date +"%Y-%m-%d %H:%M:%S")` redis安装文件 $redisOfflinePakagePath 不存在，请查看配置 redisOfflinePakagePath"  >> "$logfile/install-`(date +%Y%m%d)`.log"
		return 0
	fi

	if [[ -d "$redisInstallPath" ]];then
		echoN "redis 安装目录 $redisInstallPath 存在"
	else
		echoE "redis 安装目录 $redisInstallPath 不存在，请查看配置 redisInstallPath"
		echo "`(date +"%Y-%m-%d %H:%M:%S")` redis安装文件 $redisInstallPath 不存在，请查看配置 redisOfflinePakagePath"  >> "$logfile/install-`(date +%Y%m%d)`.log"
		mkdir -vp $redisInstallPath
	fi

    stopRedis

	redisInstallPakaageName=`getFilePrefix $redisOfflinePakagePath`   # redis安装包名称，不带后缀
	cd $redisInstallPath  # 以防把/usr/local目录删了
	rm -rf $redisInstallPakaageName  # 删除redsxxxx类型
	rm -rf redis* # 删除 文件名=redis
	rm -rf redis # 删除 文件名=redis

	unzipFile  $redisOfflinePakagePath $redisInstallPath

    echoN "安装redis $systemVersion 系统"
    if [ "$systemVersion" == 'centos7' ];then
        # 拷贝自己写的默认的reids配置文件
        echoR "安装redis ------------------进入  centos7 系统"
    #	\cp $projectPath/installPackages/redis/redis.conf /$redisInstallPath/$redisInstallPakaageName
        \cp $projectPath/installPackages/commonConf/redis/centos7/redis.conf /$redisInstallPath/redis
        \cp $projectPath/installPackages/commonConf/redis/centos7/redis_6380.conf /$redisInstallPath/redis

        #创建log文件，否则启动6380配置时启动不起来
        if [[ ! -d "/var/log/redis" ]];then
            mkdir -vp /var/log/redis
            chmod 777  /var/log/redis
        fi
        if [[ ! -f "/var/log/redis/redis_6380.log" ]];then
            touch /var/log/redis/redis_6380.log
            chmod 777  /var/log/redis/redis_6380.log
        fi
        if [[ ! -f "/usr/local/redis/redis_6380.conf" ]];then
            \cp $projectPath/installPackages/commonConf/redis/centos7/redis_6380.conf /$redisInstallPath/redis
        fi

        if [[ ! -f "/usr/local/redis-5.0.3/redis_6380.conf" ]];then
            \cp $projectPath/installPackages/commonConf/redis/centos7/redis_6380.conf /$redisInstallPath/redis-5.0.3
        fi

        #拷贝redis命令文件到usr/local/bin, 如果是c7系统
        echo "centos7 拷贝redis 命令。。。。 --》 /usr/local/bin"
        \cp $projectPath/installPackages/commonConf/redis/centos7/bin/* /usr/local/bin

        # 7. 加权限
        chmod 777 /usr/local/redis/*
        chmod 777 /usr/local/bin/*

        # 8. 根据系统，制作自启动/添加自启动
        # 拷贝启动文件
        \cp -f $projectPath/installPackages/commonConf/redis/centos7/service/redis.service /etc/systemd/system
        # 添加权限
        chmod +x /etc/systemd/system/redis.service
        systemctl daemon-reload  # 更新自启动
        #设置mysql自启动
	    systemctl enable redis
	elif [ "$systemVersion" == 'kylin' ];then
	    echoR "安装redis ------------------进入  kylin 系统"
	    # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
        # 拷贝自己写的默认的reids配置文件
    #	\cp $projectPath/installPackages/redis/redis.conf /$redisInstallPath/$redisInstallPakaageName
        \cp $projectPath/installPackages/commonConf/redis/kylin/redis.conf /$redisInstallPath/redis
        \cp $projectPath/installPackages/commonConf/redis/kylin/redis_6380.conf /$redisInstallPath/redis

        #创建log文件，否则启动6380配置时启动不起来
        if [[ ! -d "/var/log/redis" ]];then
            mkdir -vp /var/log/redis
            chmod 777  /var/log/redis
        fi
        if [[ ! -f "/var/log/redis/redis_6380.log" ]];then
            touch /var/log/redis/redis_6380.log
            chmod 777  /var/log/redis/redis_6380.log
        fi
        if [[ ! -f "/usr/local/redis/redis_6380.conf" ]];then
            \cp $projectPath/installPackages/commonConf/redis/kylin/redis_6380.conf /$redisInstallPath/redis
        fi

        if [[ ! -f "/usr/local/redis-5.0.3/redis_6380.conf" ]];then
            \cp $projectPath/installPackages/commonConf/redis/kylin/redis_6380.conf /$redisInstallPath/redis-5.0.3
        fi

        #拷贝redis命令文件到usr/local/bin,
        echo "kylin 拷贝redis 命令。。。。 --》 /usr/local/bin"
        \cp $projectPath/installPackages/commonConf/redis/kylin/bin/* /usr/local/bin

        # 7. 加权限
        chmod 777 /usr/local/redis-5.0.3/*
        chmod 777 /usr/local/bin/*

        # 8. 根据系统，制作自启动/添加自启动
#        \cp $projectPath/installPackages/commonConf/redis/kylin/service/redis /etc/init.d/
#        sed -i "s#redisInstallPath#$redisInstallPath#g" /etc/init.d/redis
#        cd /etc/init.d
#        chkconfig --del redis
#        chkconfig --add redis
#        #chkconfig强制重新加载
#        systemctl daemon-reload
#        /sbin/chkconfig redis on

        \cp -f $projectPath/installPackages/commonConf/redis/kylin/service/redis.service /etc/systemd/system
        # 添加权限
        chmod 777 /etc/systemd/system/redis.service
        systemctl daemon-reload  # 更新自启动
        systemctl enable redis  # 设置自启动

        # 8. 根据系统，制作自启动/添加自启动
    elif [ "$systemVersion" == 'kylin-x86' ];then
        # 拷贝自己写的默认的reids配置文件
        echoR "安装redis ------------------进入  kylin-x86 系统"
    #	\cp $projectPath/installPackages/redis/redis.conf /$redisInstallPath/$redisInstallPakaageName
        \cp $projectPath/installPackages/commonConf/redis/centos7/redis.conf /$redisInstallPath/redis
        \cp $projectPath/installPackages/commonConf/redis/centos7/redis_6380.conf /$redisInstallPath/redis

        #创建log文件，否则启动6380配置时启动不起来
        if [[ ! -d "/var/log/redis" ]];then
            mkdir -vp /var/log/redis
            chmod 777  /var/log/redis
        fi
        if [[ ! -f "/var/log/redis/redis_6380.log" ]];then
            touch /var/log/redis/redis_6380.log
            chmod 777  /var/log/redis/redis_6380.log
        fi
        if [[ ! -f "/usr/local/redis/redis_6380.conf" ]];then
            \cp $projectPath/installPackages/commonConf/redis/centos7/redis_6380.conf /$redisInstallPath/redis
        fi

        if [[ ! -f "/usr/local/redis-5.0.3/redis_6380.conf" ]];then
            \cp $projectPath/installPackages/commonConf/redis/centos7/redis_6380.conf /$redisInstallPath/redis-5.0.3
        fi

        #拷贝redis命令文件到usr/local/bin, 如果是c7系统
        echo "centos7 拷贝redis 命令。。。。 --》 /usr/local/bin"
        \cp $projectPath/installPackages/commonConf/redis/centos7/bin/* /usr/local/bin

        # 7. 加权限
        chmod 777 /usr/local/redis/*
        chmod 777 /usr/local/bin/*

        # 8. 根据系统，制作自启动/添加自启动
        # 拷贝启动文件
        \cp -f $projectPath/installPackages/commonConf/redis/centos7/service/redis.service /etc/systemd/system
        # 添加权限
        chmod +x /etc/systemd/system/redis.service
        systemctl daemon-reload  # 更新自启动
        #设置mysql自启动
	    systemctl enable redis
    elif [ "$systemVersion" == 'centos8' ];then
        # 拷贝自己写的默认的reids配置文件
        echoR "安装redis ------------------进入  centos8 系统"
    #	\cp $projectPath/installPackages/redis/redis.conf /$redisInstallPath/$redisInstallPakaageName
        \cp $projectPath/installPackages/commonConf/redis/centos8/redis.conf /$redisInstallPath/redis
        \cp $projectPath/installPackages/commonConf/redis/centos8/redis_6380.conf /$redisInstallPath/redis

        #创建log文件，否则启动6380配置时启动不起来
        if [[ ! -d "/var/log/redis" ]];then
            mkdir -vp /var/log/redis
            chmod 777  /var/log/redis
        fi
        if [[ ! -f "/var/log/redis/redis_6380.log" ]];then
            touch /var/log/redis/redis_6380.log
            chmod 777  /var/log/redis/redis_6380.log
        fi
        if [[ ! -f "/usr/local/redis/redis_6380.conf" ]];then
            \cp $projectPath/installPackages/commonConf/redis/centos8/redis_6380.conf /$redisInstallPath/redis
        fi

        if [[ ! -f "/usr/local/redis-5.0.3/redis_6380.conf" ]];then
            \cp $projectPath/installPackages/commonConf/redis/centos8/redis_6380.conf /$redisInstallPath/redis-5.0.3
        fi

        #拷贝redis命令文件到usr/local/bin, 如果是c7系统
        echo "centos7 拷贝redis 命令。。。。 --》 /usr/local/bin"
        \cp $projectPath/installPackages/commonConf/redis/centos7/bin/* /usr/local/bin

        # 7. 加权限
        chmod 777 /usr/local/redis/*
        chmod 777 /usr/local/bin/*

        # 8. 根据系统，制作自启动/添加自启动
        # 拷贝启动文件
        \cp -f $projectPath/installPackages/commonConf/redis/centos8/service/redis.service /etc/systemd/system
        # 添加权限
        chmod +x /etc/systemd/system/redis.service
        systemctl daemon-reload  # 更新自启动
        #设置mysql自启动
	    systemctl enable redis
	fi

	# 9. 根据系统，检测是否安装成功
#	if [[ -d "$redisInstallPath/$redisInstallPakaageName" ]];then
	if [[ -d "$redisInstallPath/redis" || -d "$redisInstallPath/redis-5.0.3" ]];then
		echoR 'redis安装后的文件夹已存在，安装成功！'
	else
		echoE 'redis安装后的文件夹不存在，安装失败！'
		echo "`(date +"%Y-%m-%d %H:%M:%S")` redis安装后的文件夹不存在，安装失败！"  >> "$logfile/install-`(date +%Y%m%d)`.log"
	fi
    # 10. 根据实际情况，安装完之后是否要启动？-不启动
    restartRedis

    # 11. 计时end
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function stopRedis(){
    if [ "$systemVersion" == 'centos7' ];then
        systemctl stop redis
#        systemctl status redis
	elif [ "$systemVersion" == 'kylin' ];then
        echo ""
    elif [ "$systemVersion" == 'kylin-x86' ];then
        systemctl stop redis
#        systemctl status redis
    elif [ "$systemVersion" == 'centos8' ];then
        systemctl stop redis
	fi

	local pids=`getPidsByName redis`
	echoN "运行的redis pids= $pids"
	if [ -n "$pids" ];then
	    kill -9 $pids
	fi
    pkill redis
}


function restartRedis(){
	stopRedis

	# 重启 redis
	echoN "redis 重启中。。！"
	if [[ $systemVersion == 'centos7' ]];then
        # 拷贝启动文件
        systemctl stop redis
        systemctl restart redis
#        systemctl status redis
    elif [[ $systemVersion == 'kylin' ]];then
#	    redisInstallPakaageName=`getFilePrefix $redisOfflinePakagePath`
	    #$redisInstallPath/bin/redis-server $redisInstallPath/redis-5.0.3/redis_6380.conf &
	    systemctl start redis
    elif [[ $systemVersion == 'kylin-x86' ]];then
        systemctl stop redis
        systemctl restart redis
#        systemctl status redis
    elif [[ $systemVersion == 'centos8' ]];then
        systemctl stop redis
        systemctl restart redis
	fi

	echoN "redis 重启完成"
}


function startRedis(){
	# 重启 redis
	echoN "redis 重启中。。！"
	if [[ $systemVersion == 'centos7' ]];then
        # 拷贝启动文件
        systemctl start redis
    elif [[ $systemVersion == 'kylin' ]];then
	    systemctl start redis
    elif [[ $systemVersion == 'kylin-x86' ]];then
        systemctl start redis
    elif [[ $systemVersion == 'centos8' ]];then
        systemctl start redis
	fi

	echoN "redis 启动完成"
}


function installEmqx(){

    # 0. 计时start
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>>安装 emqx'

    # 1. 读取配置，安装源+安装目的地
    # 2. 判断配置是否正确，安装源+安装目的地是否正确？目录是否自动创建？
	if [ ! -f "$emqxOfflinePakagePath" ];then
		echoE "emqx 安装文件 $emqxOfflinePakagePath 不存在, 请检查配置emqxOfflinePakagePath"
		echo "`(date +"%Y-%m-%d %H:%M:%S")` emqx 安装文件 $emqxOfflinePakagePath 不存在，安装失败！"  >> "$logfile/install-`(date +%Y%m%d)`.log"
		return 0
	fi

	if [ "$systemVersion" == "centos7" ];then
	    # 3. 根据系统，停掉服务
	    stopEmqx
	    # 4. 根据系统，删除已安装的程序包
	    rpm -e emqx
        cd /usr/lib
        rm -rf emqx

        cd /usr/bin
        rm -rf emqx
        rm -rf emqx_ctl

        cd $emqxInstallPath
        rm -rf emqx*

        cd /etc/rc.d/init.d
        rm -rf emqx

	    # 5. 根据系统，判断安装包类型，解压到目的地
        unzipFile $emqxOfflinePakagePath $emqxInstallPath
        # 拷贝命令到/bin
        \cp $emqxInstallPath/emqx/bin/emq* /bin
        \cp $emqxInstallPath/emqx/bin/emq* /usr/lib/emqx/bin
        \cp $emqxInstallPath/emqx/bin/emq* /usr/bin

        # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
        # 7. 加权限
        chmod 777 /etc/init.d/*
        chmod +x /etc/rc.d/init.d/*

        # 8. 根据系统，制作自启动/添加自启动
        \cp $projectPath/installPackages/commonConf/emqx/centos7/service/emqx /etc/init.d/
        sed -i "s#emqxInstallPath#$emqxInstallPath#g" /etc/init.d/emqx
        cd /etc/init.d
        chkconfig --del emqx
        chkconfig --add emqx
        #chkconfig强制重新加载
        systemctl daemon-reload
        /sbin/chkconfig emqx on
        # 9. 根据系统，检测是否安装成功
        local ifEmqxInstalOk=`rpm -qa | grep emqx | wc -l`
        if [[ $ifEmqxInstalOk -gt 0 ]];then
            echoR 'emqx安装成功！'
        else
            echoE 'emqx安装失败！'
            echo "`(date +"%Y-%m-%d %H:%M:%S")` emqx安装失败"  >> "$logfile/install-`(date +%Y%m%d)`.log"
        fi
        # 10. 根据实际情况，安装完之后是否要启动？-不启动

    elif [ "$systemVersion" == 'kylin' ];then
        # 3. 根据系统，停掉服务
	    stopEmqx

	    cd /var/lib/dpkg/info/
	    rm emqx*

        # 卸载
        dpkg --purge emqx
        if [[ `dpkg --get-selections | grep emqx | wc -l` -gt 0 ]];then
            dpkg --purge emqx
        fi
	    # 4. 根据系统，删除已安装的程序包
	    cd /var/log
	    rm emqx*

        cd /usr/lib
        rm -rf emqx

        cd /usr/bin
        rm -rf emqx*
        rm -rf emqx_ctl*

        cd $emqxInstallPath
        rm -rf emqx*

        cd /etc/init.d
        rm -rf emqx*

        cd /etc/
        rm -rf emqx

	    # 5. 根据系统，判断安装包类型，解压到目的地
	    sleep 1
	    rpm -ivh $projectPath/installPackages/centos8/emqx/libatomic-8.5.0-4.el8_5.x86_64.rpm
        unzipFile $emqxOfflinePakagePath $emqxInstallPath
        # 拷贝命令到/bin
        #\cp $emqxInstallPath/emqx/bin/emq* /bin
        #\cp $emqxInstallPath/emqx/bin/emq* /usr/bin

        # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
        # 7. 加权限
        chmod 777 /etc/init.d/emqx*

        # 8. 根据系统，制作自启动/添加自启动
        # 9. 根据系统，检测是否安装成功
        local ifEmqxInstalOk=`dpkg --get-selections | grep emqx | wc -l`
        if [[ $ifEmqxInstalOk -gt 0 ]];then
            echoR 'emqx安装成功！'
        else
            echoE 'emqx安装失败！'
            echo "`(date +"%Y-%m-%d %H:%M:%S")` emqx安装失败"  >> "$logfile/install-`(date +%Y%m%d)`.log"
        fi
        # 10. 根据实际情况，安装完之后是否要启动？-不启动
    elif [ "$systemVersion" == "kylin-x86" ];then
	    # 3. 根据系统，停掉服务
	    stopEmqx
	    # 4. 根据系统，删除已安装的程序包
        cd /usr/lib
        rm -rf emqx

        cd /usr/bin
        rm -rf emqx
        rm -rf emqx_ctl

        cd $emqxInstallPath
        rm -rf emqx*

        cd /etc/rc.d/init.d
        rm -rf emqx

	    # 5. 根据系统，判断安装包类型，解压到目的地
        unzipFile $emqxOfflinePakagePath $emqxInstallPath
        # 拷贝命令到/bin
        chmod 777 $emqxInstallPath/emqx/*
        \cp $emqxInstallPath/emqx/bin/emq* /bin
        \cp $emqxInstallPath/emqx/bin/emq* /usr/bin

        # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
        # 7. 加权限
        chmod 777 /etc/init.d/*
        chmod +x /etc/rc.d/init.d/*

        # 8. 根据系统，制作自启动/添加自启动
        \cp $projectPath/installPackages/commonConf/emqx/kylin-x86/service/emqx /etc/init.d/
        sed -i "s#emqxInstallPath#$emqxInstallPath#g" /etc/init.d/emqx
        cd /etc/init.d
        chkconfig --del emqx
        chkconfig --add emqx
        #chkconfig强制重新加载
        systemctl daemon-reload
        /sbin/chkconfig emqx on

        # 7. 加权限
        chmod 777 /etc/init.d/emqx*

        # 9. 根据系统，检测是否安装成功
        if [ -d "$emqxInstallPath/emqx" ];then
            echoR 'emqx安装成功！'
        else
            echoE 'emqx安装失败！'
            echo "`(date +"%Y-%m-%d %H:%M:%S")` emqx安装失败"  >> "$logfile/install-`(date +%Y%m%d)`.log"
        fi
        # 10. 根据实际情况，安装完之后是否要启动？-不启动
    elif [ "$systemVersion" == "centos8" ];then
	    # 3. 根据系统，停掉服务
	    stopEmqx
	    # 4. 根据系统，删除已安装的程序包
	    rpm -e emqx
        cd /usr/lib
        rm -rf emqx

        cd /usr/bin
        rm -rf emqx
        rm -rf emqx_ctl

        cd $emqxInstallPath
        rm -rf emqx*

        cd /etc/rc.d/init.d
        rm -rf emqx

	    # 5. 根据系统，判断安装包类型，解压到目的地
        rpm -ivh $projectPath/installPackages/centos8/emqx/libatomic-8.5.0-4.el8_5.x86_64.rpm
        unzipFile $emqxOfflinePakagePath $emqxInstallPath
        # 拷贝命令到/bin
        \cp $emqxInstallPath/emqx/bin/emq* /bin
        \cp $emqxInstallPath/emqx/bin/emq* /usr/lib/emqx/bin
        \cp $emqxInstallPath/emqx/bin/emq* /usr/bin

        # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
        # 7. 加权限
        chmod 777 /etc/init.d/*
        chmod +x /etc/rc.d/init.d/*

        # 8. 根据系统，制作自启动/添加自启动
        \cp $projectPath/installPackages/commonConf/emqx/centos8/service/emqx /etc/init.d/
        sed -i "s#emqxInstallPath#$emqxInstallPath#g" /etc/init.d/emqx
        cd /etc/init.d
        chkconfig --del emqx
        chkconfig --add emqx
        #chkconfig强制重新加载
        systemctl daemon-reload
        /sbin/chkconfig emqx on
        # 9. 根据系统，检测是否安装成功
        local ifEmqxInstalOk=`rpm -qa | grep emqx | wc -l`
        if [[ $ifEmqxInstalOk -gt 0 ]];then
            echoR 'emqx安装成功！'
        else
            echoE 'emqx安装失败！'
            echo "`(date +"%Y-%m-%d %H:%M:%S")` emqx安装失败"  >> "$logfile/install-`(date +%Y%m%d)`.log"
        fi
	fi
	startEmqx

    # 11. 计时end
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function stopEmqx() {
	echoN "停止emqx"
	if [[ $systemVersion == 'centos7' ]];then
	    systemctl stop emqx
    elif [ "$systemVersion" == "kylin" ];then
        emqx stop
    elif [ "$systemVersion" == "kylin-x86" ];then
        chmod 777 /etc/init.d/emqx*
        /etc/init.d/emqx stop
    elif [[ $systemVersion == 'centos7' ]];then
	    systemctl stop emqx
	fi
    # pkill emqx
	local pids=`getPidsByName emqx`
    if [ -n "$pids" ];then
	    kill -9 $pids
    fi
}


function restartEmqx(){
    echoN "重启emqx中。。。"
    stopEmqx
    sleep 1
    if [ "$systemVersion" == 'centos7' ];then
        systemctl restart emqx
        /usr/lib/emqx/bin/emqx start
    elif [ "$systemVersion" == 'kylin' ];then
        emqx stop
        emqx start
#        /usr/bin/emqx/emqx start
    elif [ "$systemVersion" == 'kylin-x86' ];then
        chmod 777 /etc/init.d/emqx*
#        /usr/local/emqx/bin/emqx start
        /etc/init.d/emqx stop
        /etc/init.d/emqx start
    elif [ "$systemVersion" == 'centos8' ];then
        systemctl restart emqx
        /usr/lib/emqx/bin/emqx start
    fi
}


function startEmqx(){
    if [ "$systemVersion" == 'centos7' ];then
        /usr/lib/emqx/bin/emqx start
    elif [ "$systemVersion" == 'kylin' ];then
        emqx start
#        /usr/bin/emqx/emqx start
    elif [ "$systemVersion" == 'kylin-x86' ];then
#        /usr/local/emqx/bin/emqx start
        /etc/init.d/emqx start
    elif [ "$systemVersion" == 'centos8' ];then
        /usr/lib/emqx/bin/emqx start
    fi
}


# --------------------------------------------------------------------------- #
# 安装mariadb_centos8
# --------------------------------------------------------------------------- #
function installMariadb_centos8(){
    local startTime=$(date +%s)
    ## 启动 mariadb ,看能否启动成功
    echoN "查看 mariadb 是否安装。。"
    systemctl restart mariadb
    if [[ `systemctl status mariadb` =~ 'running' ]];then
        echoR "mariadb 能启动成功,本来不用安装!!，但是也要卸了重装"
    fi
	echo "安装 mariadb....."
	rpm -ivh $projectPath/installPackages/centos8/mysql/rpm/* --nodeps
	sleep 1
	rpm -ivh $projectPath/installPackages/centos8/mysql/rpm/mariadb* --nodeps

	#启动 mariadb, 用restart保证一定能启动
	echo "启动 mariadb 服务。。。。"
	systemctl restart mariadb
	sleep 4
	#设置 mariadb 自启动
	systemctl enable mariadb

	#将修改配置文件， #替换/etc/my.cnf, 使用\cp为了：cp 默认命令是cp -l;会提示是否覆盖，使用\cp解决
	echo "修改 mariadb 配置文件，/etc/my.cnf.d/mariadb-server.cnf"
	\cp $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/mariadb-server.cnf  /etc/my.cnf.d/mariadb-server.cnf  # 不好用，服务无法启动

	#再次重启mysql
	restartMysql
	sleep 1

    mysql --force -uroot < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/3_add_privileges.sql
	#修改mysql登录密码
	mysqladmin --force -uroot password sunkaisens
	restartMysql
	sleep 1

	#增加权限
    cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
    mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/3_add_privileges.sql

    ## 拷贝最新的数据库配置,重启数据库
#    \cp -f $installPackages/commonConf/$versionCfgFolderName/mysql/mariadb-server.cnf  /etc/my.cnf.d/mariadb-server.cnf.bak  # 不好用，服务无法启动
#    cd /etc/my.cnf.d
#    mv mariadb-server.cnf.bak mariadb-server.cnf
#    echoN "查看/etc/my.cnf.d/mariadb-server.cnf"
#    systemctl restart mariadb
#    echoN "查看 mariadb 状态"
#    systemctl status mariadb

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function installMysql(){
    local startTime=$(date +%s)
	echoN ">>>>>>>>>>>>安装 mysql, 系统=$systemVersion"

	## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then
        ## 1. 判断配置文件是否正确
        # 判断安装文件路径是否存在
        if [[ -d "$mysqlOfflinePakagePath" ]];then
            echoN "mysql 安装文件 $mysqlOfflinePakagePath 存在"
        else
            echoE "mysql 安装文件 $mysqlOfflinePakagePath 不存在，请查看配置 mysqlOfflinePakagePath"
            return 0
        fi

        #1.1 停掉服务
        stopMysql

        disableFirewalld  # 关闭防火墙

        # 卸载mysql
		echo "卸载mysql"
        removeMysql
		sleep 4
        # 安装
        installMysql1808


    elif [[ $systemVersion == 'kylin' ]];then
        echoN '系统== $systemVersion'

        ## 1. 判断配置文件是否正确
        # 判断安装文件路径是否存在
        if [[ -d "$mysqlOfflinePakagePath" ]];then
            echoN 'mysql 安装文件存在'
        else
            echoE 'mysql 安装文件不存在，请查看配置 mysqlOfflinePakagePath'
            return 0
        fi

        #1.1 停掉服务
        stopMysql

        ## 2. 看是否已经安装数据库（mysql/mariadb）
        ifHasInstalledMysql=`dpkg --get-selections | grep mysql | wc -l`
        if [[ ifHasInstalledMysql -gt 2 ]];then
            # 之前停掉服务了，再给用户启动起来
            /etc/init.d/mysql restart
            /etc/init.d/mysql status
            echoE 'mysql已经装了!!!'

#            return 0
        else
            echoN 'mysql 没装，继续。。。。'
        fi

        ifHasInstalledMariadb=`dpkg --get-selections | grep mariadb | wc -l`
        if [[ ifHasInstalledMariadb -gt 0 ]];then
            echoE 'mariadb 已经装了，请卸载mariadb之后安装mysql !!!'
#            return 0
        else
            echoN 'mariadb 没装，继续。。。。'
        fi

        echoN 'mysql 不管装没装，全都卸载重装'
        removeMysql

        ## 3. 看是否已经启动数据库，启动了先停止mysql再说
        ifMysqlHasRunned=`netstat -anp|grep 3306 | wc -l`
        if [[ ifMysqlHasRunned -gt 0 ]];then
            echoE 'mysql 已经启动了，关闭中。。'
            /etc/init.d/mysql stop
            /etc/init.d/mysql status
        else
            echoN 'mysql 未启动，继续安装。。。。'
        fi

        ## 4.安装
        cd $projectPath/installPackages/kylin/mysql/deb-mysqlserver
        if [[ ifHasInstalledMysql -gt 2 ]];then
            echoE 'mysql已经装,不再重新安装!!!'
        else
            # 自动键入mysql 密码
            debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password password sunkaisens'
            debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password_again password sunkaisens'

            dpkg -i perl-base_5.22.1-9kord0.6_arm64.deb
            dpkg -i apparmor_2.10.95-0kord2.10_arm64.deb
            dpkg -i libaio1_0.3.110-2kord_arm64.deb

            dpkg -i libapparmor-perl_2.10.95-0kord2.10_arm64.deb
            dpkg -i libevent-core-2.0-5_2.0.21-stable-2kord0.16.04.1_arm64.deb
            dpkg -i mysql-client-core-5.7_5.7.26-0kord0.16.04.1k1_arm64.deb
            dpkg -i mysql-common_5.7.26-0kord0.16.04.1k1_all.deb
            dpkg -i mysql-server-core-5.7_5.7.26-0kord0.16.04.1k1_arm64.deb

            dpkg -i mysql-server-5.7_5.7.26-0kord0.16.04.1k1_arm64.deb
            dpkg -i mysql-client-5.7_5.7.26-0kord0.16.04.1k1_arm64.deb

            sleep 5
            dpkg -i *
        fi

        ## 3. 配置开机自启
        update-rc.d -f mysql.server defaults
    elif [[ $systemVersion == 'kylin-x86' ]];then
        ## 1. 判断配置文件是否正确
        # 判断安装文件路径是否存在
        if [[ -d "$mysqlOfflinePakagePath" ]];then
            echoN "mysql 安装文件 $mysqlOfflinePakagePath 存在"
        else
            echoE "mysql 安装文件 $mysqlOfflinePakagePath 不存在，请查看配置 mysqlOfflinePakagePath"
            return 0
        fi

        #1.1 停掉服务
        stopMysql

        disableFirewalld  # 关闭防火墙

        # 卸载mysql
		echo "卸载mysql"
        removeMysql
		sleep 4
        # 安装
        installMysql1808_kylin-x86
    elif [[ $systemVersion == 'centos8' ]];then
        ## 1. 判断配置文件是否正确
        # 判断安装文件路径是否存在
        if [[ -d "$mysqlOfflinePakagePath" ]];then
            echoN "mysql 安装文件 $mysqlOfflinePakagePath 存在"
        else
            echoE "mysql 安装文件 $mysqlOfflinePakagePath 不存在，请查看配置 mysqlOfflinePakagePath"
            return 0
        fi

        #1.1 停掉服务
#        stopMysql
        ehcoN "不自动装数据库"
        disableFirewalld  # 关闭防火墙

        # 卸载mysql
		echo "卸载mysql"
        removeMysql
		sleep 4
         安装
        installMariadb_centos8
    fi

	echoR "安装完成"
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


# --------------------------------------------------------------------------- #
# 安装mysql_1808
# --------------------------------------------------------------------------- #
function installMysql1808(){
    local startTime=$(date +%s)
    ## 启动mysql,看能否启动成功
    echoN "查看mysql是否安装。。"
    systemctl restart mysqld
    if [[ `systemctl status mysqld` =~ 'running' ]];then
        echoR "mysql 能启动成功,本来不用安装!!，但是也要卸了重装"
#        return 0
    fi
	echo "安装mysql....."
	rpm -ivh $projectPath/installPackages/centos7/mysql/rpm/*
	sleep 1

	#启动mysql, 用restart保证一定能启动
	echo "启动mysql服务。。。。"
	systemctl restart mysqld
	sleep 4
	#设置mysql自启动
	systemctl enable mysqld

	#清除mysql 配置文件中的数据
	echo "清除mysql 配置文件中旧的配置"
	sed -i '/跳过密码/'d /etc/my.cnf
	sed -i '/validate_password/'d /etc/my.cnf
	sed -i '/取消域名解析/'d /etc/my.cnf
	sed -i '/skip-name-resolve/'d /etc/my.cnf
	sed -i '/解决不能group by问题/'d /etc/my.cnf
	sed -i '/sql_mode/'d /etc/my.cnf
	sed -i '/网管同步数据配置/'d /etc/my.cnf
	sed -i '/log-bin/'d /etc/my.cnf
	sed -i '/binlog-format/'d /etc/my.cnf
	sed -i '/server_id/'d /etc/my.cnf


	#将修改配置文件， #替换/etc/my.cnf, 使用\cp为了：cp 默认命令是cp -l;会提示是否覆盖，使用\cp解决
	echo "修改mysql配置文件，/etc/my.cnf"
	#\cp -f installPackages/mysql5.7/conf/my.cnf /etc/my.cnf 不好用，服务无法启动
	#不修改配置文件启动服务，然后修改了配置文件再重启mysql，保证mysql可用一定启动起来
	sed -i '/mysql.sock/a\\n#跳过密码安全校验\nvalidate_password=off\n##取消域名解析，加快外部访问速度\nskip-name-resolve' /etc/my.cnf
	sed -i '/skip-name-resolve/a\\n#解决不能group by问题\nsql_mode = STRICT_TRANS_TABLES,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' /etc/my.cnf
#	sed -i '/skip-name-resolve/a\\n#解决不能group by问题\nsql_mode = STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' /etc/my.cnf
	sed -i '/NO_ENGINE_SUBSTITUTION/a\\n#网管同步数据配置\nlog-bin=mysql_bin\nbinlog-format=ROW\n server_id=6#配置mysql replaction需要定义，不能和canal的slaveId重复' /etc/my.cnf

	#再次重启mysql
	systemctl restart mysqld
	sleep 1

	#获取初始登录密码
	#passwordGrep=`grep temporary password /var/log/mysqld.log`
	#echo "查询出的日志密码"$passwordGrep
	#password=${passwordGrep#*localhost:}
	#echo "mysql密码"$password
	defaultmysqlpwd=`grep 'A temporary password' /var/log/mysqld.log | awk -F"root@localhost: " '{ print $2}' `
	echo "mysql默认密码：" $defaultmysqlpwd
	#修改mysql登录密码
	mysqladmin --force -uroot -p"$defaultmysqlpwd" password sunkaisens

	#增加权限
    cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
    mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/3_add_privileges.sql

	#查询所有用户
	#SELECT DISTINCT CONCAT('User: ''',user,'''@''',host,''';') AS query FROM mysql.user

	#导入mysql数据库
	  #导入调度台后台所用数据库（groupserver-群组用、imserver-短信用、data_dispatch-dds用、history-调度台查询监听历史记录用）
	  #如果数据库存在，先卸载
#	mysql --force -uroot -psunkaisens < installPackages/centos7/mysql5.7/sql/source_sql.sql

    ## 拷贝最新的数据库配置,重启数据库
    \cp  $projectPath/installPackages/commonConf/mysql/centos7/my.cnf /etc/my.cnf.bak  #不好用，服务无法启动
    cd /etc
    mv my.cnf.bak my.cnf
    echoN "查看/etc/my.cnf"
#    cat /etc/my.cnf
    systemctl restart mysqld
    echoN "查看mysql状态"
#    systemctl status mysqld

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}

# --------------------------------------------------------------------------- #
# 安装mysql_1808- kylin-x86
# --------------------------------------------------------------------------- #
function installMysql1808_kylin-x86(){
    local startTime=$(date +%s)
    ## 启动 mariadb ,看能否启动成功
    echoN "查看 mariadb 是否安装。。"
    systemctl restart mariadb
    if [[ `systemctl status mariadb` =~ 'running' ]];then
        echoR "mariadb 能启动成功,本来不用安装!!，但是也要卸了重装"
    fi
	echo "安装 mariadb....."
	rpm -ivh $projectPath/installPackages/kylin-x86/mysql/rpm/*
	rpm -ivh $projectPath/installPackages/kylin-x86/mysql/rpm/mariadb*
	sleep 1

	#启动 mariadb, 用restart保证一定能启动
	echo "启动 mariadb 服务。。。。"
	systemctl restart mariadb
	sleep 4
	#设置 mariadb 自启动
	systemctl enable mariadb

	#将修改配置文件， #替换/etc/my.cnf, 使用\cp为了：cp 默认命令是cp -l;会提示是否覆盖，使用\cp解决
	echo "修改 mariadb 配置文件，/etc/my.cnf.d/mariadb-server.cnf"
	\cp $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/mariadb-server.cnf  /etc/my.cnf.d/mariadb-server.cnf  # 不好用，服务无法启动

	#再次重启mysql
	restartMysql
	sleep 1

    mysql --force -uroot < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/3_add_privileges.sql
	#修改mysql登录密码
	mysqladmin --force -uroot password sunkaisens

	#增加权限
    cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
    mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/3_add_privileges.sql

    ## 拷贝最新的数据库配置,重启数据库
#    \cp -f $installPackages/commonConf/$versionCfgFolderName/mysql/mariadb-server.cnf  /etc/my.cnf.d/mariadb-server.cnf.bak  # 不好用，服务无法启动
#    cd /etc/my.cnf.d
#    mv mariadb-server.cnf.bak mariadb-server.cnf
    echoN "查看/etc/my.cnf.d/mariadb-server.cnf"
#    systemctl restart mariadb
    echoN "查看 mariadb 状态"
#    systemctl status mariadb

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function initMysql(){
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>>初始化 mysql,默认导入调度数据库'
	echoN '>>>>>>>>>>>>初始化 mysql'
	echo "`(date +"%Y-%m-%d %H:%M:%S")` 安装脚本，导入数据库操作《《《《《"  >> "$logfile/run-`(date +%Y%m%d)`.log"
	startTime=$(date +"%Y-%m-%d %H:%M:%S")
	sys_startTime=$(date -d "$startTime" +%s)

	# 1.修改配置文件，并重启数据库

	## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then
        echoN 'centos7系统'
        echo "`(date +"%Y-%m-%d %H:%M:%S")` 安装脚本，导入数据库操作，检测system=centos7《《《《《"  >> "$logfile/run-`(date +%Y%m%d)`.log"

    elif [[ $systemVersion == 'kylin' ]];then
	    \cp $projectPath/installPackages/commonConf/mysql/kylin/mysqld.cnf /etc/mysql/mysql.conf.d
	fi

    disableFirewalld  # 关闭防火墙
	# restartMysql
	startMysql


    echoR "导入 $versionCfgFolderName 内的数据库"
    if [ "$systemVersion" == 'centos7' ];then
        # 增加权限
        echoN "<<<<<<< 添加权限"
        #增加权限
        cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
        mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/3_add_privileges.sql

        case $preInstallService in
        1)
            # >>>所有
            # 新建数据库
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库"
            echoN "安装所有导入数据库  $versionCfgFolderName"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr.sql
            echoN "<<<<<<< 插入ocr数据"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql
            ;;
        2)
            # >>>微服务
            echoN "<<<<<<< 微服务不用 创建数据库"
            ;;
        3)
            # >>>网管
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-nms.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-nms.sql
            echoN "<<<<<<< 插入ocr数据-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql

            echoN "<<<<<<< 删除网管数据"
            deleteDataNms
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        4)
            # >>>调度
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-icss.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-icss.sql

            echoN "<<<<<< 导入group新数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/5_source_new_group.sql
            ;;
        5)
            # >>>微服务 + 网管
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-nms.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-nms.sql
            echoN "<<<<<<< 插入ocr数据-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql

            echoN "<<<<<<< 删除网管数据"
            deleteDataNms
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        6)
            # >>>核心网
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-核心网"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-switch.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-核心网"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-switch.sql

            echoN "<<<<<<< 删除网管数据"
            deleteDataNms
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        7)
            # >>>核心网+调度
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-核心网+调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-icss.sql
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-switch.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-icss.sql
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-switch.sql

            echoN "<<<<<< 导入group新数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/5_source_new_group.sql
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        8)
            # >>>核心网+调度+微服务+网管
            # 新建数据库
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database.sql
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-switch.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr.sql
            echoN "<<<<<<< 插入ocr数据"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-switch.sql
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        9)
            # 区交网关
            echoN "<<<<<<< 插入区交网关 数据库，暂时没有"
            ;;
        10)
            # 移交网关
            echoN "<<<<<<< 插入移交网关 数据库，暂时没有"
            ;;

        *)
            echoE '配置不支持,请检查配置项 preInstallService'
            ;;
        esac
	elif [ "$systemVersion" == 'kylin' ];then
        # 增加权限
        echoN "<<<<<<< 添加权限"
        #增加权限
        cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
        mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/3_add_privileges.sql

        case $preInstallService in
        1)
            # >>>所有
            # 新建数据库
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr.sql
            echoN "<<<<<<< 插入ocr数据"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql
            ;;
        2)
            # >>>微服务
            echoN "<<<<<<< 微服务不用 创建数据库"
            ;;
        3)
            # >>>网管
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-nms.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-nms.sql
            echoN "<<<<<<< 插入ocr数据-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql

            echoN "<<<<<<< 删除网管数据"
            deleteDataNms
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        4)
            # >>>调度
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-icss.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-icss.sql

            echoN "<<<<<< 导入group新数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/5_source_new_group.sql
            ;;
        5)
            # >>>微服务 + 网管
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-nms.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-nms.sql
            echoN "<<<<<<< 插入ocr数据-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql

            echoN "<<<<<<< 删除网管数据"
            deleteDataNms
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        6)
            # >>>核心网
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-核心网"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-switch.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-核心网"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-switch.sql

            echoN "<<<<<<< 删除网管数据"
            deleteDataNms
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        7)
            # >>>核心网+调度
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-核心网+调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-icss.sql
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-switch.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-icss.sql
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-switch.sql

            echoN "<<<<<< 导入group新数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/5_source_new_group.sql
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        8)
            # >>>核心网+调度+微服务+网管
            # 新建数据库
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database.sql
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-switch.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr.sql
            echoN "<<<<<<< 插入ocr数据"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-switch.sql
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        9)
            # 区交网关
            echoN "<<<<<<< 插入区交网关 数据库，暂时没有"
            ;;
        10)
            # 移交网关
            echoN "<<<<<<< 插入移交网关 数据库，暂时没有"
            ;;

        *)
            echoE '配置不支持,请检查配置项 preInstallService'
            ;;
        esac
    elif [ "$systemVersion" == 'kylin-x86' ];then
        # 增加权限
        echoN "<<<<<<< 添加权限"
        #增加权限
        cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
        mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/3_add_privileges.sql

        case $preInstallService in
        1)
            # >>>所有
            # 新建数据库
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库"
            echoN "安装所有导入数据库  $versionCfgFolderName"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr.sql
            echoN "<<<<<<< 插入ocr数据"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql
            ;;
        2)
            # >>>微服务
            echoN "<<<<<<< 微服务不用 创建数据库"
            ;;
        3)
            # >>>网管
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-nms.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-nms.sql
            echoN "<<<<<<< 插入ocr数据-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql

            echoN "<<<<<<< 删除网管数据"
            deleteDataNms
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        4)
            # >>>调度
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-icss.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-icss.sql

            echoN "<<<<<< 导入group新数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/5_source_new_group.sql
            ;;
        5)
            # >>>微服务 + 网管
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-nms.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-nms.sql
            echoN "<<<<<<< 插入ocr数据-网管"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql

            echoN "<<<<<<< 删除网管数据"
            deleteDataNms
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        6)
            # >>>核心网
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-核心网"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-switch.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-核心网"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-switch.sql

            echoN "<<<<<<< 删除网管数据"
            deleteDataNms
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        7)
            # >>>核心网+调度
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库-核心网+调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-icss.sql
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-switch.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-icss.sql
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-switch.sql

            echoN "<<<<<< 导入group新数据库-调度"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/5_source_new_group.sql
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        8)
            # >>>核心网+调度+微服务+网管
            # 新建数据库
            cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
            echoN "<<<<<<< 创建数据库"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database.sql
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database-switch.sql

            # 导入数据库
            echoN "<<<<<<< 插入数据库"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr.sql
            echoN "<<<<<<< 插入ocr数据"
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql
            mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr-switch.sql
            echoN "<<<<<<< 删除核心网数据"
            deleteDataSwitch
            ;;
        9)
            # 区交网关
            echoN "<<<<<<< 插入区交网关 数据库，暂时没有"
            ;;
        10)
            # 移交网关
            echoN "<<<<<<< 插入移交网关 数据库，暂时没有"
            ;;

        *)
            echoE '配置不支持,请检查配置项 preInstallService'
            ;;
        esac
	fi

	case "$systemVersion" in
    'centos8')
        case "$projectName" in
           'aj')
                # aj -nms
                if [ "$preInstallService" -eq 1 ];then
                    # >>>aj-nms
                    # 新建数据库
                    cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
                    echoN "<<<<<<< 创建数据库"
                    echoN "安装所有导入数据库  $versionCfgFolderName"
                    mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database.sql

                    # 导入数据库
                    echoN "<<<<<<< 插入数据库"
                    mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr.sql
                    echoN "<<<<<<< 插入ocr数据"
                    mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql
                fi

                # jds
                if [ "$preInstallService" -eq 2 ];then
                    # >>>jds
                    # 新建数据库
                    cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
                    echoN "<<<<<<< 创建数据库"
                    echoN "安装所有导入数据库  $versionCfgFolderName"
                    mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/1_create_database_jds.sql

                    # 导入数据库
                    echoN "<<<<<<< 插入数据库"
                    mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_no_ocr_jds.sql
                    echoN "<<<<<<< 插入ocr数据"
                    mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/2_insert_database_ocr.sql
                fi
                ;;
        esac
        ;;
	esac


    # 情况多余数据
    cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
    mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/4_delete_alldata.sql
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function stopMysql(){
	## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then
        systemctl stop mysqld
    elif [[ $systemVersion == 'kylin' ]];then
        /etc/init.d/mysql stop
        /etc/init.d/mysql status
    elif [[ $systemVersion == 'kylin-x86' ]];then
        systemctl stop mariadb
    elif [[ $systemVersion == 'centos8' ]];then
        systemctl stop mariadb
	fi
}


function restartMysql(){
	echoN "重启动mysql"
	## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then
        systemctl stop mysqld
        systemctl restart mysqld
#        systemctl status mysqld
    elif [[ $systemVersion == 'kylin' ]];then
        /etc/init.d/mysql stop
        /etc/init.d/mysql start
        /etc/init.d/mysql status
    elif [[ $systemVersion == 'kylin-x86' ]];then
        systemctl stop mariadb
        systemctl restart mariadb
    elif [[ $systemVersion == 'centos8' ]];then
        systemctl stop mariadb
        systemctl restart mariadb
	fi
}

function startMysql(){
	echoN "启动mysql $systemVersion"
	## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then
        systemctl start mysqld
#        systemctl status mysqld
    elif [[ $systemVersion == 'kylin' ]];then
        /etc/init.d/mysql start
        /etc/init.d/mysql status
    elif [[ $systemVersion == 'kylin-x86' ]];then
        systemctl start mariadb
    elif [[ $systemVersion == 'centos8' ]];then
        systemctl start mariadb
	fi
}


function installGooglemap(){

    # 0. 计时start
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>>安装 map'

    # 1. 读取配置，安装源+安装目的地
    # 2. 判断配置是否正确，安装源+安装目的地是否正确？目录是否自动创建？
    # 自动创建文件夹
    if [ ! -d "$mapInstallPath" ];then
        echoE "map 安装文件夹 $mapInstallPath 不存在，创建~"
        echo "`(date +"%Y-%m-%d %H:%M:%S")` map 安装文件夹 $mapInstallPath 不存在，创建"  >> "$logfile/install-`(date +%Y%m%d)`.log"
        mkdir -vp $mapInstallPath
    fi

	# 判断配置文件是否正确
	if [ -f "$mapOfflinePakagePath" ];then
		echoN "map 安装文件 $mapOfflinePakagePath 存在"
	else
		echoE "map 安装文件 $mapOfflinePakagePath 不存在，请查看配置 mapOfflinePakagePath"
		echo "`(date +"%Y-%m-%d %H:%M:%S")` map 安装文件 $mapOfflinePakagePath 不存在，请查看配置 mapOfflinePakagePath"  >> "$logfile/install-`(date +%Y%m%d)`.log"
		return 0
	fi

    # 3. 根据系统，停掉服务
	# 4. 根据系统，删除已安装的程序包
	cd $mapInstallPath
	rm -rf roadmap

    # 5. 根据系统，判断安装包类型，解压到目的地
    unzipFile $mapOfflinePakagePath $mapInstallPath
	if [ -d "$mapInstallPath/roadmap" ];then
		echoR "map 安装后的文件夹 $mapInstallPath/roadmap 已存在，安装成功！"
	else
		echoE "map 安装后的文件夹 $mapInstallPath/roadmap 不存在，安装失败！"
		echo "`(date +"%Y-%m-%d %H:%M:%S")` map 安装后的文件夹 $mapInstallPath/roadmap 不存在，安装失败"  >> "$logfile/install-`(date +%Y%m%d)`.log"
	fi
    # 10. 根据实际情况，安装完之后是否要启动？-不启动

    # 11. 计时end
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function installOam() {

    # 0. 计时start
    local startTime=$(date +%s)
	echoN ">>>>>>>>>>>>安装 oam"

    # 1. 读取配置，安装源+安装目的地
    # 2. 判断配置是否正确，安装源+安装目的地是否正确？目录是否自动创建？
    # 自动创建文件夹
    if [[ ! -d "$oamInstallPath" ]];then
        echoE "OAM 安装文件夹 $oamInstallPath 不存在，创建~"
        mkdir -vp /root
    fi

	if [[ -f "$oamOfflinePakagePath" ]];then
		echoN "oam 安装文件 $oamOfflinePakagePath 存在"
	else
		echoE "oam 安装文件 $oamOfflinePakagePath 不存在，请查看配置 oamOfflinePakagePath"
		return 0
	fi

	# 3. 根据系统，停掉服务
	stopOam
    # 4. 根据系统，删除已安装的程序包
    cd $oamInstallPath  # 以防把/root目录删了
	rm -rf OAM
	rm -rf oam
    # 5. 根据系统，判断安装包类型，解压到目的地
	unzipFile $oamOfflinePakagePath $oamInstallPath

	if [[ $systemVersion == 'centos7' ]];then
	    # 7. 加权限
        chmod 777 $oamInstallPath/oam/*
        chmod +x /etc/rc.local

        # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
	    #拷贝自己写的默认文件
	    \cp $projectPath/installPackages/oam/oam.cfg /root/oam
	    #根据用户配置的ip,修改配置文件,sed 用$时用双引号
        sed -i "s/localIp/$localIp/g" $oamInstallPath/oam/oam.cfg # 本地ip
        sed -i "s/nmsIp/$nmsIp/g" $oamInstallPath/oam/oam.cfg # 网管Ip
        sed -i "s/softwareDbUsername/$softwareDbUsername/g" $oamInstallPath/oam/oam.cfg # 业务db用户名
        sed -i "s/softwareDbpassword/$softwareDbpassword/g" $oamInstallPath/oam/oam.cfg # 业务db pwd
        #拷贝oam的lib库到/lib
	    \cp $projectPath/installPackages/centos7/oam/lib64/* /lib64
	    \cp $projectPath/installPackages/centos7/oam/lib64/* /usr/lib64

	    #安装vsftpd
	    rpm -ivh $projectPath/installPackages/centos7/oam/rpm/ftp-0.17-67.el7.x86_64.rpm
	    rpm -ivh $projectPath/installPackages/centos7/oam/rpm/vsftpd-3.0.2-9.el7.x86_64.rpm

	    #替换oam的启动文件
        if [ "$oamRunServerNames" != '' ];then
            cat /dev/null > /root/oam/oam.MANIFEST
            cat /dev/null > /root/oam/oam.launch
            for i in ${oamRunServerNames[@]};
            do
                echo "$i@0" >> /root/oam/oam.MANIFEST
                echo "$i" >> /root/oam/oam.launch
            done
        fi

        # 更换oam.cfg 的id
        cardId=0  # 默认主板
        if [ "$cardType" -eq 1 ];then
            cardId=0
            isMaster="true"
        elif [ "$cardType" -eq 2 ];then
            cardId=1
            isMaster="false"
        fi
        if [ -d "/root/oam" ];then
            sed -i "s/suboam.id.*/suboam.id=$cardId/g" /root/oam/oam.cfg
            sed -i "s/oam.id.*/oam.id=$cardId/g" /root/oam/oam.cfg
            sed -i "s/master=.*/master=$isMaster/g" /root/oam/oam.cfg
        fi
        if [ -d "/root/OAM" ];then
            sed -i "s/suboam.id.*/suboam.id=$cardId/g" /root/OAM/oam.cfg
            sed -i "s/oam.id.*/oam.id=$cardId/g" /root/OAM/oam.cfg
            sed -i "s/master=.*/master=$isMaster/g" /root/oam/oam.cfg
        fi

        # source oam.init 初始化oam命令
        cd /root/oam
        source oam.init
        # 8. 根据系统，制作自启动/添加自启动
        if [[ -d "$oamInstallPath/oam" ]];then
            echoR "oam 安装后的文件夹 $oamInstallPath/oam 已存在，安装成功！"
        else
            echoE "oam 安装后的文件夹 $oamInstallPath/oam 不存在，安装失败！"
        fi
        # 9. 根据系统，检测是否安装成功
        # 10. 根据实际情况，安装完之后是否要启动？-不启动，如果有已经启动的nginx,还要测试安装nginx情况
    elif [[ $systemVersion == 'kylin' ]];then
        # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
	    #拷贝自己写的默认文件
	    \cp $projectPath/installPackages/kylin/oam/oam.cfg /root/OAM
	    #根据用户配置的ip,修改配置文件,sed 用$时用双引号
        sed -i "s/localIp/$localIp/g" $oamInstallPath/OAM/oam.cfg # 本地ip
        sed -i "s/nmsIp/$nmsIp/g" $oamInstallPath/OAM/oam.cfg # 网管Ip
        sed -i "s/softwareDbUsername/$softwareDbUsername/g" $oamInstallPath/OAM/oam.cfg # 业务db用户名
        sed -i "s/softwareDbpassword/$softwareDbpassword/g" $oamInstallPath/OAM/oam.cfg # 业务db pwd

        # 加权限，oam & 系统自启动文件,多加权限-保证至少安装无问题！
        chmod +x $oamInstallPath/OAM/*
        chmod 777 $oamInstallPath/OAM/*
        chmod +x /etc/rc.local

	    # 5.1 source oam.init 初始化oam命令
        cd /root/OAM
        source oam.init
        sleep 2

	    # 替换oam的启动文件
        if [[ $oamRunServerNames != '' ]];then
            cat /dev/null > /root/OAM/oam.MANIFEST
            cat /dev/null > /root/OAM/oam.launch
            for i in ${oamRunServerNames[@]};
            do
                echo "$i@0" >> /root/OAM/oam.MANIFEST
                echo "$i" >> /root/OAM/oam.launch
            done
        fi

        # 更换oam.cfg 的id
        cardId=0  # 默认主板
        if [ "$cardType" -eq 1 ];then
            cardId=0
        elif [ "$cardType" -eq 2 ];then
            cardId=1
        fi
        if [ -d "/root/oam" ];then
            sed -i "s/suboam.id.*/suboam.id=$cardId/g" /root/oam/oam.cfg
            sed -i "s/oam.id.*/oam.id=$cardId/g" /root/oam/oam.cfg
        fi
        if [ -d "/root/OAM" ];then
            sed -i "s/suboam.id.*/suboam.id=$cardId/g" /root/OAM/oam.cfg
            sed -i "s/oam.id.*/oam.id=$cardId/g" /root/OAM/oam.cfg
        fi

        #source oam.init 初始化oam命令
        cd /root/OAM
        source oam.init
        sleep 2

        # 检测是否安装成功(检查目录)
        if [ -d "$oamInstallPath/OAM" ];then
            echoR "oam 安装后的文件夹 $oamInstallPath/oam 已存在，安装成功！"
        else
            echoE "oam 安装后的文件夹 $oamInstallPath/oam 不存在，安装失败！"
        fi
    elif [[ $systemVersion == 'kylin-x86' ]];then
	    # 7. 加权限
        chmod 777 $oamInstallPath/oam/*
        chmod +x /etc/rc.local

        # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
	    #拷贝自己写的默认文件
	    \cp $projectPath/installPackages/oam/oam.cfg /root/oam
	    #根据用户配置的ip,修改配置文件,sed 用$时用双引号
        sed -i "s/localIp/$localIp/g" $oamInstallPath/oam/oam.cfg # 本地ip
        sed -i "s/nmsIp/$nmsIp/g" $oamInstallPath/oam/oam.cfg # 网管Ip
        sed -i "s/softwareDbUsername/$softwareDbUsername/g" $oamInstallPath/oam/oam.cfg # 业务db用户名
        sed -i "s/softwareDbpassword/$softwareDbpassword/g" $oamInstallPath/oam/oam.cfg # 业务db pwd
        #拷贝oam的lib库到/home/common
        mkdir -vp /home/common
	    \cp $projectPath/installPackages/centos7/oam/lib64/* /home/common
	    ldconfig

	    #安装vsftpd
	    #rpm -ivh $projectPath/installPackages/centos7/oam/rpm/ftp-0.17-67.el7.x86_64.rpm
	    #rpm -ivh $projectPath/installPackages/centos7/oam/rpm/vsftpd-3.0.2-9.el7.x86_64.rpm

	    #替换oam的启动文件
        if [ "$oamRunServerNames" != '' ];then
            cat /dev/null > /root/oam/oam.MANIFEST
            cat /dev/null > /root/oam/oam.launch
            for i in ${oamRunServerNames[@]};
            do
                echo "$i@0" >> /root/oam/oam.MANIFEST
                echo "$i" >> /root/oam/oam.launch
            done
        fi

        # 更换oam.cfg 的id
        cardId=0  # 默认主板
        if [ "$cardType" -eq 1 ];then
            cardId=0
            isMaster="true"
        elif [ "$cardType" -eq 2 ];then
            cardId=1
            isMaster="false"
        fi
        if [ -d "/root/oam" ];then
            sed -i "s/suboam.id.*/suboam.id=$cardId/g" /root/oam/oam.cfg
            sed -i "s/oam.id.*/oam.id=$cardId/g" /root/oam/oam.cfg
            sed -i "s/master=.*/master=$isMaster/g" /root/oam/oam.cfg
        fi
        if [ -d "/root/OAM" ];then
            sed -i "s/suboam.id.*/suboam.id=$cardId/g" /root/OAM/oam.cfg
            sed -i "s/oam.id.*/oam.id=$cardId/g" /root/OAM/oam.cfg
            sed -i "s/master=.*/master=$isMaster/g" /root/oam/oam.cfg
        fi

        # source oam.init 初始化oam命令
        cd /root/oam
        source oam.init
        # 8. 根据系统，制作自启动/添加自启动
        if [[ -d "$oamInstallPath/oam" ]];then
            echoR "oam 安装后的文件夹 $oamInstallPath/oam 已存在，安装成功！"
        else
            echoE "oam 安装后的文件夹 $oamInstallPath/oam 不存在，安装失败！"
        fi
        # 9. 根据系统，检测是否安装成功
        # 10. 根据实际情况，安装完之后是否要启动？-不启动，如果有已经启动的nginx,还要测试安装nginx情况
    fi

    # 11. 计时end
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function installOamUpdateByCfg() {

    # 0. 计时start
    local startTime=$(date +%s)
	echoN ">>>>>>>>>>>>安装 oam"

    # 1. 读取配置，安装源+安装目的地
    # 2. 判断配置是否正确，安装源+安装目的地是否正确？目录是否自动创建？
    # 自动创建文件夹
    if [[ ! -d "$oamInstallPath" ]];then
        echoE "OAM 安装文件夹 $oamInstallPath 不存在，创建~"
        mkdir -vp /root
    fi

	if [[ -f "$oamOfflinePakagePath" ]];then
		echoN "oam 安装文件 $oamOfflinePakagePath 存在"
	else
		echoE "oam 安装文件 $oamOfflinePakagePath 不存在，请查看配置 oamOfflinePakagePath"
		return 0
	fi

	# 3. 根据系统，停掉服务
	stopOam
    # 4. 根据系统，删除已安装的程序包
    cd $oamInstallPath  # 以防把/root目录删了
	rm -rf oam
    # 5. 根据系统，判断安装包类型，解压到目的地
	unzipFile $oamOfflinePakagePath $oamInstallPath

    # 7. 加权限
    if [ -d "/root/oam" ];then
        cd /root/oam
        source oam.init
    fi
    if [ -d "/root/OAM" ];then
        cd /root/OAM
        source oam.init
        chmod 777 $oamInstallPath/OAM/*
        chmod 777 $oamInstallPath/OAM/oam.script/*
    fi

    chmod 777 $oamInstallPath/oam/*
    chmod 777 $oamInstallPath/oam/oam.script/*
    chmod +x /etc/rc.local

    # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
    echoN "版本文件目录 ===== $versionCfgFolderName"
    if [ "$updateSoftwareByCfgType" -eq 1 ];then # 通过多个文件改所有配置-改对应的软件
        local customSoftwareCfgFolderName="updateType1_OneByOne_CustomCfgs"  # 自定义txt 文件夹名称
        echoN "文件目录 $customSoftwareCfgFolderName"
	    echoR "所有文件 $allFiles"
        local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/oam/updateCfgs/updateType1_OneByOne_CustomCfgs | grep ^- | awk '{print $9}'`
    elif [ "$updateSoftwareByCfgType" -eq 2 ];then #  # 通过1个文件改所有配置
        local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/oam/updateCfgs | grep ^- | awk '{print $9}'`  # 通过1个文件改所有配置
	    echoR "所有文件 $allFiles"
        local customSoftwareCfgFolderName=""  # 自定义txt 文件夹名称
        echoN "文件目录 $customSoftwareCfgFolderName"
    fi

	for file in $allFiles
	do
        echoN "要导入的文件= $projectPath/installPackages/commonConf/$versionCfgFolderName/oam/updateCfgs/$customSoftwareCfgFolderName/$file"
	    echoN "file= $file"
	    echoN "拷贝自定义配置文件。。"
	    cpFilesLen=`grep "customSoftwareCfgAbsPath" $projectPath/installPackages/commonConf/$versionCfgFolderName/oam/updateCfgs/update.txt  | wc -l`
	    echoN "要拷贝的文件数量= $cpFilesLen"
	    for((i=1;i<=$cpFilesLen;i++));
	    do
            if [ "$updateSoftwareByCfgType" -eq 1 ];then  # 多个配置文件改对应的
                # 非unix 文件才转换，否则报错
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/oam/updateCfgs/updateType1_OneByOne_CustomCfgs/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/oam/updateCfgs/updateType1_OneByOne_CustomCfgs/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/oam/updateCfgs/updateType1_OneByOne_CustomCfgs/$file" | awk -F '=' '{print $2}'`
            elif [ "$updateSoftwareByCfgType" -eq 2 ];then # 通过1个文件改所有配置，默认
                # 非unix 文件才转换，否则报错
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/oam/updateCfgs/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/oam/updateCfgs/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/oam/updateCfgs/$file" | awk -F '=' '{print $2}'`
            fi
            echoR "脚本配置文件 $customSoftwareCfgAbsPath"
            echoR "配置镜像文件 $dstFileAbsPath"
            \cp `eval echo $customSoftwareCfgAbsPath` `eval echo $dstFileAbsPath`
	    done

        echoN "替换配置"
        while read line || [[ -n ${line} ]]
        do
            if [[ $line =~ ^#.* || -z $line || $line == ' ' ]];then
                #echoE "此行注释开头或者为空行，不读取此行"
                continue
            fi

            k=${line%=*}  # =前
            v=${line#*=}  # =后
            v=`echo $v | awk -F '#' '{print $1}' | awk -F ' ' '{print $1}'`  # 去掉#和之前的空格
            if [[ $k =~ 'customSoftwareCfgAbsPath' || $k =~ 'dstFileAbsPath' || $k =~ 'customShellCfgAbsPath' ]];then
                #echoN "此行是文件路径，不读取"
                continue
            fi
            # 进行替换
#            echoN "$k:$v"
#            sed -i "s#$k#`eval echo $v`#g" `ls -dl /root/.NE/*/* | grep -Ev "jar|bak$|sh$" |grep ^- |awk '{print $9}'`  # 排除方式
            sed -i "s#$k#`eval echo $v`#g" /root/oam/oam.cfg  # 查找指定类型方式
        done < $projectPath/installPackages/commonConf/$versionCfgFolderName/oam/updateCfgs/$customSoftwareCfgFolderName/$file
    done

    #拷贝oam的lib库到/lib
    if [ ! -d "/home/common" ];then
        echoE "/home/common 不存在，创建！！！"
        mkdir -vp /home/common
    fi
    \cp $projectPath/installPackages/$systemVersion/oam/lib64/* /home/common
    ldconfig  # 调用common install

    #安装vsftpd
    if [ "$systemVersion" == 'centos7' ];then
        rpm -ivh $projectPath/installPackages/$systemVersion/oam/rpm/ftp-0.17-67.el7.x86_64.rpm
        rpm -ivh $projectPath/installPackages/$systemVersion/oam/rpm/vsftpd-3.0.2-9.el7.x86_64.rpm
    elif [ "$systemVersion" == 'kylin-x86' ];then
        echo ""
        #rpm -ivh $projectPath/installPackages/$systemVersion/oam/rpm/ftp-0.17-67.el7.x86_64.rpm
        #rpm -ivh $projectPath/installPackages/$systemVersion/oam/rpm/vsftpd-3.0.2-9.el7.x86_64.rpm
    elif [ "$systemVersion" == 'centos8' ];then
        echo ""
        #rpm -ivh $projectPath/installPackages/$systemVersion/oam/rpm/ftp-0.17-67.el7.x86_64.rpm
        #rpm -ivh $projectPath/installPackages/$systemVersion/oam/rpm/vsftpd-3.0.2-9.el7.x86_64.rpm
    fi

    #替换oam的启动文件
    if [ "$oamRunServerNames" != '' ];then
        cat /dev/null > /root/oam/oam.MANIFEST
        cat /dev/null > /root/oam/oam.launch
        for i in ${oamRunServerNames[@]};
        do
            echo "$i@0" >> /root/oam/oam.MANIFEST
            echo "$i" >> /root/oam/oam.launch
        done
    fi

    # 更换oam.cfg 的id
    cardId=0  # 默认主板
    if [ "$cardType" -eq 1 ];then
        cardId=0
        isMaster="true"
    elif [ "$cardType" -eq 2 ];then
        cardId=1
        isMaster="false"
    fi
    if [ -d "/root/oam" ];then
        sed -i "s/suboam.id.*/suboam.id=$cardId/g" /root/oam/oam.cfg
        sed -i "s/oam.id.*/oam.id=$cardId/g" /root/oam/oam.cfg
        sed -i "s/master=.*/master=$isMaster/g" /root/oam/oam.cfg
    fi
    if [ -d "/root/OAM" ];then
        sed -i "s/suboam.id.*/suboam.id=$cardId/g" /root/OAM/oam.cfg
        sed -i "s/oam.id.*/oam.id=$cardId/g" /root/OAM/oam.cfg
        sed -i "s/master=.*/master=$isMaster/g" /root/oam/oam.cfg
    fi

    # source oam.init 初始化oam命令
    cd /root/oam
    source oam.init
    # 8. 根据系统，制作自启动/添加自启动
    if [[ -d "$oamInstallPath/oam" ]];then
        echoR "oam 安装后的文件夹 $oamInstallPath/oam 已存在，安装成功！"
    else
        echoE "oam 安装后的文件夹 $oamInstallPath/oam 不存在，安装失败！"
    fi
    # 9. 根据系统，检测是否安装成功
    # 10. 根据实际情况，安装完之后是否要启动？-不启动，如果有已经启动的nginx,还要测试安装nginx情况

    # 11. 计时end
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}

function stopOam(){
    # 思路：
    # 1. 杀掉进程 (kill -9 + pkill )
    # 2. 判断系统，进行重启命令
    oamStop -a
    local pids=`getPidsByName oam`
    if [ -n "$pids" ];then
	    kill -9 $pids
    fi
    pkill oam
}


function restartOam(){
    stopOam
    oamBoot &
}


function installHosts(){
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>>安装 hosts'

	## 1. 判断配置文件是否正确
	# 判断安装文件路径是否存在
	if [[ -f "$hostsOfflinePakagePath" ]];then
		echoN 'hosts 安装文件存在'
	else
		echoE 'hosts 安装文件不存在，请查看配置 hostsOfflinePakagePath'
		return 0
	fi

	## 2. 替换hosts 到/etc/hosts
	echoN "host文件src $hostsOfflinePakagePath"
	\cp $hostsOfflinePakagePath /etc/hosts

	## 3. 根据用户配置的ip,修改配置文件,sed 用$时用双引号
	sed -i "s/localIp/$localIp/g" /etc/hosts # 本地ip
	sed -i "s/microIp/$microIp/g" /etc/hosts # 微服务ip
	sed -i "s/icssIp/$icssIp/g" /etc/hosts # 调度台ip
	sed -i "s/nmsIp/$nmsIp/g" /etc/hosts # 网管Ip
	sed -i "s/emqIp/$emqIp/g" /etc/hosts # emq Ip
	sed -i "s/mysqlIp/$mysqlIp/g" /etc/hosts # mysqlIp
	sed -i "s/redisIp/$redisIp/g" /etc/hosts # redisIp
	sed -i "s/upLevelNmsIp/$upLevelNmsIp/g" /etc/hosts # # 相对于本级网管，上级网管的ip
	sed -i "s/switchIp/$switchIp/g" /etc/hosts # 交换ip
	sed -i "s/dispIp/$icssIp/g" /etc/hosts # 调度ip
	sed -i "s/northEmqxIp/$northEmqxIp/g" /etc/hosts # 上级mqtt ip
	sed -i "s/superiorMicroIp/$northEmqxIp/g" /etc/hosts # 上级 微服务 ip

	echoR 'hosts 安装成功！'
	# 打印时间
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function installDispFrontUpdateByCfg() {

    # 0. 计时start
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>>安装 调度台前端'

    # 1. 读取配置，安装源+安装目的地
    # 2. 判断配置是否正确，安装源+安装目的地是否正确？目录是否自动创建？
	# 判断安装文件路径是否存在
	if [[ -f "$icssFrontOfflinePakagePath" ]];then
		echoN "调度台前端 安装文件 $icssFrontOfflinePakagePath 存在"
	else
		echoE "调度台前端 安装文件 $icssFrontOfflinePakagePath 不存在，请查看配置 icssFrontOfflinePakagePath"
		return 0
	fi

	# 判断安装目录是否存在
	if [[ -d "$icssFrontInstallPath" ]];then
		echoN "调度台前端 安装目录 $icssFrontInstallPath 存在"
	else
		echoE "调度台前端 安装目录 $icssFrontInstallPath 不存在，请查看配置 icssFrontInstallPath"
		mkdir -vp $icssFrontInstallPath
	fi

    # 3. 根据系统，停掉服务
    # 4. 根据系统，删除已安装的程序包
	cd $icssFrontInstallPath
	rm -rf dist
    # 5. 根据系统，判断安装包类型，解压到目的地
	unzipFile $icssFrontOfflinePakagePath $icssFrontInstallPath
    # 7. 加权限
    chmod 777 $icssFrontInstallPath/dist/static/*

    # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
	# read line 读取配置文件
	# 过滤几个变量
	# 读取 micro/updateCfgs 下的所有文件
	echoR "版本文件目录 ===== $versionCfgFolderName"
	echoR "版本更新方式 ===== $updateSoftwareByCfgType"
	echoR "==================================================================="
    if [ "$updateSoftwareByCfgType" -eq 1 ];then # 通过多个文件改所有配置-改对应的软件
        local customSoftwareCfgFolderName="updateType1_OneByOne_CustomCfgs"  # 自定义txt 文件夹名称
        local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/disp-front/updateCfgs/updateType1_OneByOne_CustomCfgs | grep ^- | awk '{print $9}'`
        echoN "文件目录 $customSoftwareCfgFolderName"
	    echoR "所有文件 $allFiles"
    elif [ "$updateSoftwareByCfgType" -eq 2 ];then #  # 通过1个文件改所有配置
        local customSoftwareCfgFolderName=""  # 自定义txt 文件夹名称
        local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/disp-front/updateCfgs | grep ^- | awk '{print $9}'`  # 通过1个文件改所有配置
        echoN "文件目录 $customSoftwareCfgFolderName"
	    echoR "所有文件 $allFiles"
    fi

	for file in $allFiles
	do
        echoN "要导入的文件= $projectPath/installPackages/commonConf/$versionCfgFolderName/disp-front/updateCfgs/$customSoftwareCfgFolderName/$file"
	    echoN "file= $file"
	    echoN "拷贝自定义配置文件。。"
	    cpFilesLen=`grep "customSoftwareCfgAbsPath" $projectPath/installPackages/commonConf/$versionCfgFolderName/disp-front/updateCfgs/update.txt  | wc -l`
	    echoN "要拷贝的文件数量= $cpFilesLen"
	    for((i=1;i<=$cpFilesLen;i++));
	    do
            if [ "$updateSoftwareByCfgType" -eq 1 ];then  # 多个配置文件改对应的
                # 非unix 文件才转换，否则报错
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/disp-front/updateCfgs/updateType1_OneByOne_CustomCfgs/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/disp-front/updateCfgs/updateType1_OneByOne_CustomCfgs/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/disp-front/updateCfgs/updateType1_OneByOne_CustomCfgs/$file" | awk -F '=' '{print $2}'`

                echoR "脚本配置文件= $customSoftwareCfgAbsPath"
                echoR "配置镜像文件= $dstFileAbsPath"
                \cp `eval echo $customSoftwareCfgAbsPath` `eval echo $dstFileAbsPath`
            elif [ "$updateSoftwareByCfgType" -eq 2 ];then # 通过1个文件改所有配置，默认
                # 非unix 文件才转换，否则报错
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/disp-front/updateCfgs/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/disp-front/updateCfgs/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/disp-front/updateCfgs/$file" | awk -F '=' '{print $2}'`

                echoR "脚本配置文件= $customSoftwareCfgAbsPath"
                echoR "配置镜像文件= $dstFileAbsPath"
                \cp `eval echo $customSoftwareCfgAbsPath` `eval echo $dstFileAbsPath`
            fi

            echoN "替换配置"
            while read line || [[ -n ${line} ]]
            do
                if [[ $line =~ ^#.* || -z $line || $line == ' ' ]];then
                    #echoE "此行注释开头或者为空行，不读取此行"
                    continue
                fi

                k=${line%=*}  # =前
                v=${line#*=}  # =后
                v=`echo $v | awk -F '#' '{print $1}' | awk -F ' ' '{print $1}'`  # 去掉#和之前的空格
                if [[ $k =~ 'customSoftwareCfgAbsPath' || $k =~ 'dstFileAbsPath' || $k =~ 'customShellCfgAbsPath' ]];then
                    #echoN "此行是文件路径，不读取"
                    continue
                fi
                # 进行替换
                if [[ "$customSoftwareCfgAbsPath" =~ '*' ]];then  # 要拷贝到文件夹里
                    sed -i "s#$k#`eval echo $v`#g" `eval echo $dstFileAbsPath/*`
                else
                    sed -i "s#$k#`eval echo $v`#g" `eval echo $dstFileAbsPath`
                fi
            done < $projectPath/installPackages/commonConf/$versionCfgFolderName/disp-front/updateCfgs/$customSoftwareCfgFolderName/$file
	    done

    done


	if [[ -d "$icssFrontInstallPath/dist" ]];then
		echoR '调度台前端 安装后的文件夹已存在，安装成功！'
	else
		echoE '调度台前端 安装后的文件夹不存在，安装失败！'
	fi
	# 11. 计时end
	#打印时间
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}



function installDispBackUpdateByCfg(){

    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>>安装 调度台后台'

    if [[ ! -d "/root" ]];then
        echoE "调度台后台 安装文件夹/root 不存在，创建~"
        mkdir -vp /root
    fi

	if [[ -f "$icssBackOfflinePakagePath" ]];then
		echoN "调度台后台 安装文件 $icssBackOfflinePakagePath 存在"
	else
		echoE "调度台后台 安装文件 $icssBackOfflinePakagePath 不存在，请查看配置 icssBackOfflinePakagePath"
		return 0
	fi

    stopIcssSoftware
	cd /root
	rm -rf .NE
	unzipFile $icssBackOfflinePakagePath /root
	# 删除所有pid 文件 - 不用这一步
#	cd /root/.NE
#	rm -rf */pid
    # 7. 加权限
    chmod -R 777 /root/.NE/*/*
    echoN "替换neStart.sh"
    sed -i '/^#.*source/s/^#//g' /root/.NE/*/neStart.sh  # 去注释

    # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
    # 判断是否是最高级，改disp配置
    isUnitidHighest=true   # 供 自定义的配置文件用
    if [[ $nmsUnitid -eq 1 ]];then
        isUnitidHighest=true  # 最高级
    else
        isUnitidHighest=false
    fi
    # 修改软件 yml
	# read line 读取配置文件
	# 过滤几个变量
	# 读取 micro/updateCfgs 下的所有文件
	echoN "版本文件目录 ===== $versionCfgFolderName"
    if [ "$updateSoftwareByCfgType" -eq 1 ];then # 通过多个文件改所有配置-改对应的软件
        local customSoftwareCfgFolderName="updateType1_OneByOne_CustomCfgs"  # 自定义txt 文件夹名称
        echoN "文件目录 $customSoftwareCfgFolderName"
	    echoR "所有文件 $allFiles"
        local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/disp/updateCfgs/updateType1_OneByOne_CustomCfgs | grep ^- | awk '{print $9}'`
    elif [ "$updateSoftwareByCfgType" -eq 2 ];then #  # 通过1个文件改所有配置
        local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/disp/updateCfgs | grep ^- | awk '{print $9}'`  # 通过1个文件改所有配置
	    echoR "所有文件 $allFiles"
        local customSoftwareCfgFolderName=""  # 自定义txt 文件夹名称
        echoN "文件目录 $customSoftwareCfgFolderName"
    fi

	for file in $allFiles
	do
        echoN "要导入的文件= $projectPath/installPackages/commonConf/$versionCfgFolderName/disp/updateCfgs/$customSoftwareCfgFolderName/$file"
	    echoN "file= $file"
	    echoN "拷贝自定义配置文件。。"
	    cpFilesLen=`grep "customSoftwareCfgAbsPath" $projectPath/installPackages/commonConf/$versionCfgFolderName/disp/updateCfgs/update.txt  | wc -l`
	    echoN "要拷贝的文件数量= $cpFilesLen"
	    for((i=1;i<=$cpFilesLen;i++));
	    do
            if [ "$updateSoftwareByCfgType" -eq 1 ];then  # 多个配置文件改对应的
                # 非unix 文件才转换，否则报错
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/disp/updateCfgs/updateType1_OneByOne_CustomCfgs/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/disp/updateCfgs/updateType1_OneByOne_CustomCfgs/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/disp/updateCfgs/updateType1_OneByOne_CustomCfgs/$file" | awk -F '=' '{print $2}'`
            elif [ "$updateSoftwareByCfgType" -eq 2 ];then # 通过1个文件改所有配置，默认
                # 非unix 文件才转换，否则报错
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/disp/updateCfgs/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/disp/updateCfgs/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/disp/updateCfgs/$file" | awk -F '=' '{print $2}'`
            fi
            echoR "脚本配置文件 $customSoftwareCfgAbsPath"
            echoR "配置镜像文件 $dstFileAbsPath"
            \cp `eval echo $customSoftwareCfgAbsPath` `eval echo $dstFileAbsPath`
	    done

        echoN "替换配置"
        while read line || [[ -n ${line} ]]
        do
            if [[ $line =~ ^#.* || -z $line || $line == ' ' ]];then
                #echoE "此行注释开头或者为空行，不读取此行"
                continue
            fi

            k=${line%=*}  # =前
            v=${line#*=}  # =后
            v=`echo $v | awk -F '#' '{print $1}' | awk -F ' ' '{print $1}'`  # 去掉#和之前的空格
            if [[ $k =~ 'customSoftwareCfgAbsPath' || $k =~ 'dstFileAbsPath' || $k =~ 'customShellCfgAbsPath' ]];then
                #echoN "此行是文件路径，不读取"
                continue
            fi
            # 进行替换
#            echoN "$k:$v"
            sed -i "s#$k#`eval echo $v`#g" `ls -dl /root/.NE/*/* | grep -E "properties$|config$|yml$|xml$" |grep ^- |awk '{print $9}'`  # 查找指定类型方式
            sed -i "s#$k#`eval echo $v`#g" `ls -l /root/.NE/*/conf/* | grep ^- | grep -Ev "jar|so" |awk '{print $9}'`
        done < $projectPath/installPackages/commonConf/$versionCfgFolderName/disp/updateCfgs/$customSoftwareCfgFolderName/$file
    done
    # 8. 根据系统，制作自启动/添加自启动
    # 9. 根据系统，检测是否安装成功
    # 10. 根据实际情况，安装完之后是否要启动？-不启动，如果有已经启动的nginx,还要测试安装nginx情况

    chmod -R 777 /root/.NE/*/*

    
	## 8. 检测是否安装成功(检查目录)
	if [[ -d "/root/.NE" ]];then
		echoR '调度台后台 安装后的文件夹已存在，安装成功！'
	else
		echoE '调度台后台 安装后的文件夹不存在，安装失败！'
	fi

	# 11. 计时end
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function stopIcssSoftware(){
	oamStop -a
}


function restartIcssSoftware(){
	oamStop -a
	sleep 10
	cd /home  # 防止退出xshell ，oam不好用
	oamBoot &
	cd /root  # 防止退出xshell ，oam不好用
}


function installRclocal() {
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>>安装 rc.local'

	# 判断自启动文件是否存在
	if [[ ! -f "$projectPath/installPackages/commonConf/rc.local" ]];then
        echoE "自启动文件不存在，退出！"
#        exit
    return 0
	fi


    # 根据配置-进行自启动设置
    ## 如果是c7系统,
    if [ "$projectName" == "2011" ];then
        # 1. cp
        \cp $projectPath/installPackages/commonConf/rc.local /etc
        \cp $projectPath/installPackages/commonConf/.runBaseService /root
        \cp $projectPath/installPackages/commonConf/.runIcss /root
        \cp $projectPath/installPackages/commonConf/.runMicro /root
        \cp $projectPath/installPackages/commonConf/.runNms /root
        \cp $projectPath/installPackages/commonConf/.runKms /root
        \cp $projectPath/installPackages/commonConf/.runSwitch /root
        \cp $projectPath/installPackages/commonConf/.runTomcat /root  # tomcat

        if [[ $systemVersion == 'centos7' ]];then
            \cp $projectPath/installPackages/commonConf/.runIcss_centos7 /root/.runIcss
            \cp $projectPath/installPackages/commonConf/.runNms_centos7 /root/.runNms
        elif [[ $systemVersion == 'kylin' ]];then
            \cp $projectPath/installPackages/commonConf/.runIcss_kylin /root/.runIcss
            \cp $projectPath/installPackages/commonConf/.runNms_kylin /root/.runNms
        elif [[ $systemVersion == 'kylin-x86' ]];then
            \cp $projectPath/installPackages/commonConf/.runIcss_kylin-x86 /root/.runIcss
            \cp $projectPath/installPackages/commonConf/.runNms_kylin-x86 /root/.runNms
        elif [[ $systemVersion == 'centos8' ]];then
            \cp $projectPath/installPackages/commonConf/.runIcss_centos8 /root/.runIcss
            \cp $projectPath/installPackages/commonConf/.runIcss_centos8 /root/.runNms
        fi
        cd /root
        chmod 777 .runBaseService
        chmod 777 .runIcss
        chmod 777 .runMicro
        chmod 777 .runNms
        chmod 777 .runKms

        if [[ -f "/etc/rc.local" ]];then
            echoR '自启动文件 已存在，安装成功！'
        else
            echoE '自启动文件 不存在，安装失败！'
        fi

        if [[ $systemVersion == 'kylin' ]];then
            case $preInstallService in
                1)
                    #所有
                    echoN '>>>>>>>>>>>>用户配置本机装所有'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
        #            sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
        #            sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
        #            sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
        #            sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
        #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                2)
                    #微服务
                    echoN '>>>>>>>>>>>>用户配置本机装微服务'
                    # tomcat
                    sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
        #            sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
        #            sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                3)
                    #网管
                    echoN '>>>>>>>>>>>>用户配置本机装网管'
                    # tomcat
                    sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
        #            sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                4)
                    #调度
                    echoN '>>>>>>>>>>>>用户配置本机装调度'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
        #            sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
        #            sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
        #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                5)
                    #微服务 + 网管
                    echoN '>>>>>>>>>>>>用户配置本机装调度'
                    # tomcat
                    sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
    #                sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
    #                sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                6)
                    #核心网
                    echoN '>>>>>>>>>>>>用户配置本机装核心网'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
    #                sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
    #                sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
    #                sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                7)
                    #核心网+调度
                    echoN '>>>>>>>>>>>>用户配置本机装核心网+调度'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
        #            sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
        #            sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
        #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                8)
                    #核心网+调度+微服务+网管
                    echoN '>>>>>>>>>>>>用户配置本机装核心网+调度+微服务+网管'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
        #            sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
        #            sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
        #            sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
        #            sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
        #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                9)
                    # 区交基站网关
                    echoN '>>>>>>>>>>>>用户配置本机装 区交基站网关'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
    #                sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                10)
                    # 移交基站网关
                    echoN '>>>>>>>>>>>>用户配置本机装 移交基站网关'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
    #                sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                *)
                    echoN '>>>>>>>>>>>>用户配置项不支持,请检查配置文件 preInstallService'
                    ;;
            esac
        fi

        if [[ $systemVersion == 'centos7' ]];then
            case $preInstallService in
                1)
                    #所有
                    echoN '>>>>>>>>>>>>用户配置本机装所有'
                    # 配置自启动systemctl
    #                chkconfig --del emqx
    #                chkconfig --add emqx
    #                #chkconfig强制重新加载
    #                systemctl daemon-reload
    #                /sbin/chkconfig emqx on

                    systemctl enable nginx
                    systemctl enable emqx
                    systemctl enable redis
                    systemctl enable mysql
                    systemctl enable docker
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
        #            sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
        #            sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
        #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                2)
                    #微服务
                    echoN '>>>>>>>>>>>>用户配置本机装微服务'
                    systemctl enable nginx
                    systemctl enable emqx
                    systemctl enable redis
                    systemctl disable mysql
                    systemctl disable docker

                    # tomcat
                    sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
        #            sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                3)
                    #网管
                    echoN '>>>>>>>>>>>>用户配置本机装网管'
                    systemctl disable nginx
                    systemctl disable emqx
                    systemctl disable redis
                    systemctl enable mysql
                    systemctl disable docker
                    # tomcat
                    sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
        #            sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                4)
                    #调度
                    echoN '>>>>>>>>>>>>用户配置本机装调度'
                    systemctl enable nginx
                    systemctl disable emqx
                    systemctl disable redis
                    systemctl enable mysql
                    systemctl enable docker

                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
        #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                5)
                    #微服务 + 网管
                    echoN '>>>>>>>>>>>>用户配置本机装调度'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
    #                sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
    #                sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                6)
                    #核心网
                    echoN '>>>>>>>>>>>>用户配置本机装核心网'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
    #                sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
    #                sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
    #                sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                7)
                    #核心网+调度
                    echoN '>>>>>>>>>>>>用户配置本机装核心网+调度'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
        #            sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
        #            sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
        #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                8)
                    #核心网+调度+微服务+网管
                    echoN '>>>>>>>>>>>>用户配置本机装核心网+调度+微服务+网管'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
        #            sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
        #            sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
        #            sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
        #            sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
        #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                9)
                    # 区交基站网关
                    echoN '>>>>>>>>>>>>用户配置本机装 区交基站网关'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
    #                sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                10)
                    # 移交基站网关
                    echoN '>>>>>>>>>>>>用户配置本机装 移交基站网关'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
    #                sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                *)
                    echoN '>>>>>>>>>>>>用户配置项不支持,请检查配置文件 preInstallService'
                    ;;
            esac
        fi

        if [[ $systemVersion == 'kylin-x86' ]];then
            case $preInstallService in
                1)
                    #所有
                    echoN '>>>>>>>>>>>>用户配置本机装所有'
                    # 配置自启动systemctl
    #                chkconfig --del emqx
    #                chkconfig --add emqx
    #                #chkconfig强制重新加载
    #                systemctl daemon-reload
    #                /sbin/chkconfig emqx on

                    systemctl enable nginx
                    systemctl enable emqx
                    systemctl enable redis
                    systemctl enable mysql
                    systemctl enable docker
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
        #            sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
        #            sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
        #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                2)
                    #微服务
                    echoN '>>>>>>>>>>>>用户配置本机装微服务'
                    systemctl enable nginx
                    systemctl enable emqx
                    systemctl enable redis
                    systemctl disable mysql
                    systemctl disable docker

                    # tomcat
                    sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
        #            sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                3)
                    #网管
                    echoN '>>>>>>>>>>>>用户配置本机装网管'
                    systemctl disable nginx
                    systemctl disable emqx
                    systemctl disable redis
                    systemctl enable mysql
                    systemctl disable docker
                    # tomcat
                    sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
        #            sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                4)
                    #调度
                    echoN '>>>>>>>>>>>>用户配置本机装调度'
                    systemctl enable nginx
                    systemctl disable emqx
                    systemctl disable redis
                    systemctl enable mysql
                    systemctl enable docker

                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
        #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                5)
                    #微服务 + 网管
                    echoN '>>>>>>>>>>>>用户配置本机装调度'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
    #                sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
    #                sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                6)
                    #核心网
                    echoN '>>>>>>>>>>>>用户配置本机装核心网'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
    #                sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
    #                sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
    #                sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                7)
                    #核心网+调度
                    echoN '>>>>>>>>>>>>用户配置本机装核心网+调度'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
        #            sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
        #            sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
        #            sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
        #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                8)
                    #核心网+调度+微服务+网管
                    echoN '>>>>>>>>>>>>用户配置本机装核心网+调度+微服务+网管'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
        #            sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
        #            sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
        #            sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
        #            sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
        #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
                    sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                9)
                    # 区交基站网关
                    echoN '>>>>>>>>>>>>用户配置本机装 区交基站网关'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
    #                sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                10)
                    # 移交基站网关
                    echoN '>>>>>>>>>>>>用户配置本机装 移交基站网关'
                    # tomcat
    #                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # kms
                    sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 基础服务
                    sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 微服务
                    sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 网管
                    sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 调度
                    sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local  # 加注释
    #                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                    # 核心网
    #                sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local  # 加注释
                    sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                    ;;
                *)
                    echoN '>>>>>>>>>>>>用户配置项不支持,请检查配置文件 preInstallService'
                    ;;
            esac
        fi
    fi

    if [ "$projectName" == "aj" ];then
        # 1. cp
        echoN "aj项目 "
        \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/rc.local /etc
        \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runBaseService /root
        \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runIcss /root
        \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runMicro /root
        \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runNms /root
        \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runKms /root
        \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runSwitch /root
        \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runTomcat /root  # tomcat

        if [[ $systemVersion == 'centos7' ]];then
            \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runIcss_centos7 /root/.runIcss
            \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runNms_centos7 /root/.runNms
        elif [[ $systemVersion == 'kylin' ]];then
            \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runIcss_kylin /root/.runIcss
            \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runNms_kylin /root/.runNms
        elif [[ $systemVersion == 'kylin-x86' ]];then
            \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runIcss_kylin-x86 /root/.runIcss
            \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runNms_kylin-x86 /root/.runNms
        elif [[ $systemVersion == 'centos8' ]];then
            \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runIcss_centos8 /root/.runIcss
            \cp $projectPath/installPackages/commonConf/$versionCfgFolderName/.runNms_centos8 /root/.runNms
        fi
        cd /root
        chmod 777 .runBaseService
        chmod 777 .runIcss
        chmod 777 .runMicro
        chmod 777 .runNms
        chmod 777 .runKms

        if [[ -f "/etc/rc.local" ]];then
            echoR '自启动文件 已存在，安装成功！'
        else
            echoE '自启动文件 不存在，安装失败！'
        fi

        case $preInstallService in
            1)
                # aj-nms
                echoN '>>>>>>>>>>>>用户配置本机装所有'

                systemctl enable nginx
                systemctl enable emqx
                systemctl enable redis
                systemctl enable mysql
#                systemctl enable docker
                # tomcat
                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local
#                sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                # kms
                sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local
#                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                # 基础服务
                sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local
#                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                # 微服务
    #            sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local
                sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                # 网管
    #            sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local
                sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                # 调度
    #            sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local
                sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                # 核心网
                sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local
#                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                ;;
            2)
                # jds
                echoN '>>>>>>>>>>>>用户配置本机装微服务'
                systemctl enable nginx
                systemctl enable emqx
                systemctl enable redis
                systemctl disable mysql
                systemctl disable docker

                # tomcat
                sed -i 's/^[^#].*\/.runTomcat/#&/g' /etc/rc.local
#                sed -i '/^#.*\/.runTomcat/s/^#//g' /etc/rc.local  # 去注释(自启)

                # kms
                sed -i 's/^[^#].*\/.runKms/#&/g' /etc/rc.local
#                sed -i '/^#.*\/.runKms/s/^#//g' /etc/rc.local  # 去注释(自启)

                # 基础服务
                sed -i 's/^[^#].*\/.runBaseService/#&/g' /etc/rc.local
#                sed -i '/^#.*\/.runBaseService/s/^#//g' /etc/rc.local  # 去注释(自启)

                # 微服务
                sed -i 's/^[^#].*\/.runMicro/#&/g' /etc/rc.local
#                sed -i '/^#.*\/.runMicro/s/^#//g' /etc/rc.local  # 去注释(自启)

                # 网管
#                sed -i 's/^[^#].*\/.runNms/#&/g' /etc/rc.local
                sed -i '/^#.*\/.runNms/s/^#//g' /etc/rc.local  # 去注释(自启)

                # 调度
                sed -i 's/^[^#].*\/.runIcss/#&/g' /etc/rc.local
    #            sed -i '/^#.*\/.runIcss/s/^#//g' /etc/rc.local  # 去注释(自启)

                # 核心网
                sed -i 's/^[^#].*\/.runSwitch/#&/g' /etc/rc.local
#                sed -i '/^#.*\/.runSwitch/s/^#//g' /etc/rc.local  # 去注释(自启)
                ;;
            *)
                echoN '>>>>>>>>>>>>用户配置项不支持,请检查配置文件 preInstallService'
                ;;
        esac
    fi

    ## 拷贝rc.local --> /etc/rc.d/rc.local,以防有些系统启动的是/etc/rc.d/rc.local 这个文件
    \cp /etc/rc.local /etc/rc.d/

	# 打印时间
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function installTcpdump() {
    echoN '>>>>>>>>>>>>安装 tcpdump'
	startTime=$(date +"%Y-%m-%d %H:%M:%S")
	sys_startTime=$(date -d "$startTime" +%s)

	# 1. 判断自启动文件是否存在
	if [[ ! -f "$projectPath/installPackages/kylin/tcpdump/tcpdump" ]];then
        echoE "抓包软件不存在，退出！"
	fi

	## 2. 安装
	\cp $projectPath/installPackages/kylin/tcpdump/tcpdump /bin
	chmod +x /bin/tcpdump
	chmod 777 /bin/tcpdump

	# 打印时间
	endTime=$(date +"%Y-%m-%d %H:%M:%S")
	sys_endTime=$(date -d "$endTime" +%s)
	timeSup=`expr $sys_endTime - $sys_startTime`
	colorEcho "用时:" $nomal_info $timeSup "秒"
}


function onlineInstallKms(){
    local startTime=$(date +%s)
	cd /home/SK_KMS/kms_source/build/kms/assistant
	if [[ -d "/home/SK_KMS/kms_source/build/kms/assistant" ]];then
	    cd /home/SK_KMS/kms_source/build/kms/assistant
	    rm -rf *.assis
	fi
	apt-get update
	apt-get -y install git cmake autoconf autopoint automake libtool bison
	apt-get -y install libboost-all-dev glibmm-2.4 libsoup2.4 uuid-dev
	apt-get -y install libsigc++-2.0-dev maven libopencv-dev

	#编解码器（可选）
	apt install libjpeg-dev -y
	apt install libspeex-dev -Y
	apt install libpulse-dev
	apt install libopus-dev
	apt install libvpx-dev
	apt install libx264-dev

	#执行编译脚本 sh kms_build.sh
	#可实现PCMU话音通话，PCMA异常，修改KMS配置SdpEndpoint.conf.json,其目录在build/kms/etc/kurento/modules/kurento/
	#添加如下两行。
	#{ "name": "PCMA/8000" },
	#      	{ "name": "G729/8000" }

	# vi /home/SK_KMS/build/kms/etc/kurento/modules/kurento/SdpEndpoint.conf.json

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}



function installNmsFrontUpdateByCfg() {
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>>安装 网管前端'

	if [[ -f "$nmsFrontOfflinePakagePath" ]];then
		echoN "网管前端 安装文件 $nmsFrontOfflinePakagePath 存在"
	else
		echoE "网管前端 安装文件 $nmsFrontOfflinePakagePath 不存在，请查看配置 nmsFrontOfflinePakagePath"
		return 0
	fi

	if [[ -d "$nmsFrontInstallPath" ]];then
		echoN "网管前端 安装目录 $nmsFrontInstallPath 存在"
	else
		echoE "网管前端 安装目录 $nmsFrontInstallPath 不存在，请查看配置 nmsFrontInstallPath"
		mkdir -vp $nmsFrontInstallPath
	fi

	cd $nmsFrontInstallPath
	rm -rf dist
	unzipFile $nmsFrontOfflinePakagePath $nmsFrontInstallPath
    chmod 777 $nmsFrontInstallPath/dist/static/*

	echoN "版本文件目录 ===== $versionCfgFolderName"
    if [ "$updateSoftwareByCfgType" -eq 1 ];then # 通过多个文件改所有配置-改对应的软件
        local customSoftwareCfgFolderName="updateType1_OneByOne_CustomCfgs"  # 自定义txt 文件夹名称
        local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/nms-front/updateCfgs/updateType1_OneByOne_CustomCfgs | grep ^- | awk '{print $9}'`
        echoN "文件目录 $customSoftwareCfgFolderName"
	    echoR "所有文件 $allFiles"
    elif [ "$updateSoftwareByCfgType" -eq 2 ];then #  # 通过1个文件改所有配置
        local customSoftwareCfgFolderName=""  # 自定义txt 文件夹名称
        local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/nms-front/updateCfgs | grep ^- | awk '{print $9}'`  # 通过1个文件改所有配置
        echoN "文件目录 $customSoftwareCfgFolderName"
	    echoR "所有文件 $allFiles"
    fi

	for file in $allFiles
	do
        echoN "要导入的文件= $projectPath/installPackages/commonConf/$versionCfgFolderName/nms-front/updateCfgs/$customSoftwareCfgFolderName/$file"
	    echoN "file= $file"
	    echoN "拷贝自定义配置文件。。"
	    cpFilesLen=`grep "customSoftwareCfgAbsPath" $projectPath/installPackages/commonConf/$versionCfgFolderName/nms-front/updateCfgs/update.txt  | wc -l`
	    echoN "要拷贝的文件数量= $cpFilesLen"
	    for((i=1;i<=$cpFilesLen;i++));
	    do
            if [ "$updateSoftwareByCfgType" -eq 1 ];then  # 多个配置文件改对应的
                # 非unix 文件才转换，否则报错
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/nms-front/updateCfgs/updateType1_OneByOne_CustomCfgs/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/nms-front/updateCfgs/updateType1_OneByOne_CustomCfgs/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/nms-front/updateCfgs/updateType1_OneByOne_CustomCfgs/$file" | awk -F '=' '{print $2}'`
            elif [ "$updateSoftwareByCfgType" -eq 2 ];then # 通过1个文件改所有配置，默认
                # 非unix 文件才转换，否则报错
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/nms-front/updateCfgs/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/nms-front/updateCfgs/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/nms-front/updateCfgs/$file" | awk -F '=' '{print $2}'`
            fi
            echoR "脚本配置文件= $customSoftwareCfgAbsPath"
            echoR "配置镜像文件= $dstFileAbsPath"
            \cp `eval echo $customSoftwareCfgAbsPath` `eval echo $dstFileAbsPath`

            echoN "替换配置"
            while read line || [[ -n ${line} ]]
            do
                if [[ $line =~ ^#.* || -z $line || $line == ' ' ]];then
                    #echoE "此行注释开头或者为空行，不读取此行"
                    continue
                fi

                k=${line%=*}  # =前
                v=${line#*=}  # =后
                v=`echo $v | awk -F '#' '{print $1}' | awk -F ' ' '{print $1}'`  # 去掉#和之前的空格
                if [[ $k =~ 'customSoftwareCfgAbsPath' || $k =~ 'dstFileAbsPath' || $k =~ 'customShellCfgAbsPath' ]];then
                    #echoN "此行是文件路径，不读取"
                    continue
                fi
                # 进行替换
                if [[ "$customSoftwareCfgAbsPath" =~ '*' ]];then  # 要拷贝到文件夹里
                    sed -i "s#$k#`eval echo $v`#g"  `eval echo $dstFileAbsPath/*`
                else
                    sed -i "s#$k#`eval echo $v`#g"  `eval echo "$dstFileAbsPath"`
                fi
            done < $projectPath/installPackages/commonConf/$versionCfgFolderName/nms-front/updateCfgs/$customSoftwareCfgFolderName/$file
	    done
    done


	if [[ -d "$nmsFrontInstallPath/dist" ]];then
		echoR "网管前端 安装后的文件夹已存在，安装成功！"
	else
		echoE "网管前端 安装后的文件夹不存在，安装失败！"
	fi
	# 11. 计时end
	#打印时间
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function installNmsBackUpdateByCfg(){
    # 0 计时
	echoN '>>>>>>>>>>>>安装 安装网管后台'
    local startTime=$(date +%s)

	if [ -f "$nmsBackOfflinePakagePath" ];then
		echoN "安装 网管后台 安装文件 $nmsBackOfflinePakagePath 存在"
	else
		echoE "安装 网管后台 安装文件 $nmsBackOfflinePakagePath 不存在，请查看配置 nmsBackOfflinePakagePath"
		return 0
	fi
	# 判断安装目录是否存在
	if [ -d "$nmsBackInstallPath" ];then
		echoN "安装 网管后台 安装目录 $nmsBackInstallPath 存在"
	else
		echoE "安装 网管后台 安装目录 $nmsBackInstallPath 不存在，自动创建安装目录 $nmsBackInstallPath"
	fi

    # 3. 根据系统，停掉服务
    stopNms

    # 4. 根据系统，删除已安装的程序包
    cd $nmsBackInstallPath
	rm -rf backend

    # 5. 根据系统，判断安装包类型，解压到目的地
    unzipFile $nmsBackOfflinePakagePath $nmsBackInstallPath

    # 7. 加权限
    chmod 777 $nmsBackInstallPath/backend/*
    chmod 777 $nmsBackInstallPath/backend/*/*

    if [ "$projectName" == "2011" ];then
        echoN "2011 项目，插入组织机构id"
        # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
        # 不管是不是分级部署，找出本级和下级的所有unitid
        # 找上级id
    #	upLevelNmsUnitid=`eval echo '$UpUnitidFromOrgUnitid'"$nmsUnitid"`  # eval 使用变量的变量
        echoR "上级unitid== $upLevelNmsUnitid"
        # 找下级unitid
        echoR "下级unitid== ${downLevelNmsUnitid[*]}"

        ## 6. 修改org数据库(全军的id==0, 插入默认组织机构)
        # 6.1 修改本级全军unitid
        mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use 2011_organization_service;update t_arms set arms_id = 0 where arms_name = '全军';SET foreign_key_checks=1;"
        # 6.2. 加本级unitid
        mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use 2011_organization_service;INSERT INTO t_unit VALUES ('$nmsUnitid', '网管uid$nmsUnitid', '$upLevelNmsUnitid', '1', '0', '', '200', now(), now(), '0', '0', '0') on duplicate key update unit_id='$nmsUnitid',unit_name='网管uid$nmsUnitid',parent_id=$upLevelNmsUnitid,theater_city_id=1,arms_id=0,auth='',group_max=200,create_time=now(),modify_time=now(),station=0,type=0,syn_data_center=0;SET foreign_key_checks=1;"
        # 6.3. 加下级unitid
        downLevelNmsUnitidLen=${#downLevelNmsUnitid[*]}
        for((i=0;i<downLevelNmsUnitidLen;i++));
        do
            echoN "循环加下级组织机构 ${downLevelNmsUnitid[$i]}"
            mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use 2011_organization_service;INSERT INTO t_unit VALUES ('${downLevelNmsUnitid[$i]}', '${downLevelNmsName[$i]}', '$nmsUnitid', '1', '0', '', '200', now(), now(), '0', '0', '0') on duplicate key update unit_id='${downLevelNmsUnitid[$i]}',unit_name='${downLevelNmsName[$i]}',parent_id=$nmsUnitid,theater_city_id=1,arms_id=0,auth='',group_max=200,create_time=now(),modify_time=now(),station=0,type=0,syn_data_center=0;SET foreign_key_checks=1;"
        done

        # 修改hss代理数据库
        echoN "<<<<<<< 更新hss代理数据配置"
        cd $projectPath/installPackages/commonConf/v0.0.2-V0.0.2-merge-all_linux_system/mysql/sql
        \cp 6_update_nms_user-bak.sql 6_update_nms_user.sql
        sed -i "s/nmsIp/$nmsIp/g" 6_update_nms_user.sql
        sed -i "s/hssProxyPort/$hssProxyPort/g" 6_update_nms_user.sql
        mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/v0.0.2-V0.0.2-merge-all_linux_system/mysql/sql/6_update_nms_user.sql
        cd $projectPath/installPackages/commonConf/v0.0.2-V0.0.2-merge-all_linux_system/mysql/sql
        \cp 6_update_nms_user-bak.sql 6_update_nms_user.sql
    elif [ "$projectName" == "aj" ];then
        echo "aj项目 - install nms"
    fi


	# read line 读取配置文件
	# 过滤几个变量
	# 读取 nms/updateBootstraps 下的所有文件
	local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps | grep ^- | awk '{print $9}'`
	for file in $allFiles
	do
        sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/$file
        local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath" "$projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/$file" | awk -F '=' '{print $2}'`
        local dstFileAbsPath=`grep "dstFileAbsPath" "$projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/$file" | awk -F '=' '{print $2}'`
        echoR "脚本配置文件 $customSoftwareCfgAbsPath"
        echoR "配置镜像文件 $dstFileAbsPath"
        \cp -f `eval echo $customSoftwareCfgAbsPath` `eval echo $dstFileAbsPath`
        while read line || [[ -n ${line} ]]
        do
            if [[ $line =~ ^#.* || -z $line || $line == ' ' ]];then
                #echoE "此行注释开头或者为空行，不读取此行"
                continue
            fi

            k=${line%=*}  # =前
            v=${line#*=}  # =后
            v=`echo $v | awk -F '#' '{print $1}' | awk -F ' ' '{print $1}'`  # 去掉#和之前的空格
            if [[ $k =~ 'customSoftwareCfgAbsPath' || $k =~ 'dstFileAbsPath' || $k =~ 'customShellCfgAbsPath' ]];then
                #echoN "此行是文件路径，不读取"
                continue
            fi
            # 进行替换
            sed -i "s#$k#`eval echo $v`#g" `eval echo $dstFileAbsPath`
        done < $projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/$file
    done
    # 8. 根据系统，制作自启动/添加自启动
    # 9. 根据系统，检测是否安装成功
    if [ -d "$nmsBackInstallPath/backend" ];then
		echoR "安装 网管后台 安装目录 $nmsBackInstallPath/backend 存在，安装成功"
	else
		echoE "安装 网管后台 安装目录 $nmsBackInstallPath/backend 不存在，安装失败"
	fi
    # 10. 根据实际情况，安装完之后是否要启动？-不启动
    # 11. 计时end
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}

function installNmsBackJdsUpdateByCfg(){
    # 0 计时
	echoN '>>>>>>>>>>>>安装 安装网管后台 机动式'
    local startTime=$(date +%s)

	if [ -f "$nmsBackOfflinePakagePath" ];then
		echoN "安装 网管后台 安装文件 $nmsBackOfflinePakagePath 存在"
	else
		echoE "安装 网管后台 安装文件 $nmsBackOfflinePakagePath 不存在，请查看配置 nmsBackOfflinePakagePath"
		return 0
	fi
	# 判断安装目录是否存在
	if [ -d "$nmsBackInstallPath" ];then
		echoN "安装 网管后台 安装目录 $nmsBackInstallPath 存在"
	else
		echoE "安装 网管后台 安装目录 $nmsBackInstallPath 不存在，自动创建安装目录 $nmsBackInstallPath"
	fi

    # 3. 根据系统，停掉服务
    stopNms

    # 4. 根据系统，删除已安装的程序包
    cd $nmsBackInstallPath
	rm -rf backend

    # 5. 根据系统，判断安装包类型，解压到目的地
    unzipFile $nmsBackOfflinePakagePath $nmsBackInstallPath

    # 7. 加权限
    chmod 777 $nmsBackInstallPath/backend/*
    chmod 777 $nmsBackInstallPath/backend/*/*

    echoN "版本文件目录 ===== $versionCfgFolderName"
    if [ "$updateSoftwareByCfgType" -eq 1 ];then # 通过多个文件改所有配置-改对应的软件
        local customSoftwareCfgFolderName="updateType1_OneByOne_CustomCfgs"  # 自定义txt 文件夹名称
        local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/updateType1_OneByOne_CustomCfgs | grep ^- | awk '{print $9}'`
        echoN "文件目录 $customSoftwareCfgFolderName"
	    echoR "所有文件 $allFiles"
    elif [ "$updateSoftwareByCfgType" -eq 2 ];then #  # 通过1个文件改所有配置
        local customSoftwareCfgFolderName=""  # 自定义txt 文件夹名称
        local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps | grep ^- | awk '{print $9}'`  # 通过1个文件改所有配置
        echoN "文件目录 $customSoftwareCfgFolderName"
	    echoR "所有文件 $allFiles"
    fi

	for file in $allFiles
	do
        echoN "要导入的文件= $projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/$file"
	    echoN "file= $file"
	    echoN "拷贝自定义配置文件。。"
	    cpFilesLen=`grep "customSoftwareCfgAbsPath" $projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/update.txt  | wc -l`
	    echoN "要拷贝的文件数量= $cpFilesLen"
	    for((i=1;i<=$cpFilesLen;i++));
	    do
            if [ "$updateSoftwareByCfgType" -eq 1 ];then  # 多个配置文件改对应的
                # 非unix 文件才转换，否则报错
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/$file" | awk -F '=' '{print $2}'`
            elif [ "$updateSoftwareByCfgType" -eq 2 ];then # 通过1个文件改所有配置，默认
                # 非unix 文件才转换，否则报错
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/$file" | awk -F '=' '{print $2}'`
            fi
            echoR "脚本配置文件= $customSoftwareCfgAbsPath"
            echoR "配置镜像文件= $dstFileAbsPath"
            \cp `eval echo $customSoftwareCfgAbsPath` `eval echo $dstFileAbsPath`

            echoN "替换配置"
            while read line || [[ -n ${line} ]]
            do
                if [[ $line =~ ^#.* || -z $line || $line == ' ' ]];then
                    #echoE "此行注释开头或者为空行，不读取此行"
                    continue
                fi

                k=${line%=*}  # =前
                v=${line#*=}  # =后
                v=`echo $v | awk -F '#' '{print $1}' | awk -F ' ' '{print $1}'`  # 去掉#和之前的空格
                if [[ $k =~ 'customSoftwareCfgAbsPath' || $k =~ 'dstFileAbsPath' || $k =~ 'customShellCfgAbsPath' ]];then
                    #echoN "此行是文件路径，不读取"
                    continue
                fi
                # 进行替换
                if [[ "$customSoftwareCfgAbsPath" =~ '*' ]];then  # 要拷贝到文件夹里
                    sed -i "s#$k#`eval echo $v`#g"  `eval echo $dstFileAbsPath/*`
                else
                    sed -i "s#$k#`eval echo $v`#g"  `eval echo "$dstFileAbsPath"`
                fi
            done < $projectPath/installPackages/commonConf/$versionCfgFolderName/nms/updateBootstraps/$file
	    done
    done

    chmod +x "$projectPath/nms/backend/sun-nms-north-service/location.sh"

    # 8. 根据系统，制作自启动/添加自启动
    # 9. 根据系统，检测是否安装成功
    if [ -d "$nmsBackInstallPath/backend" ];then
		echoR "安装 网管后台 安装目录 $nmsBackInstallPath/backend 存在，安装成功"
	else
		echoE "安装 网管后台 安装目录 $nmsBackInstallPath/backend 不存在，安装失败"
	fi
    # 10. 根据实际情况，安装完之后是否要启动？-不启动
    # 11. 计时end
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function installMicroUpdateByCfg() {
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>>安装 安装微服务'
	echoN "nmsUnitid================ $nmsUnitid"

	## 1. 判断配置文件是否正确
	# 判断安装文件路径是否存在
	if [[ -f "$microOfflinePakagePath" ]];then
		echoN "安装微服务 安装文件 $microOfflinePakagePath 存在'"
	else
		echoE "安装微服务 安装文件 $microOfflinePakagePath 不存在，请查看配置 microOfflinePakagePath'"
		return 0
	fi

	# 停止
	stopMicro

	## 2. 删除已安装的 微服务
	cd $projectPath
	rm -rf micro

	## 3. 判断安装包类型，解压到配置文件写的路径
	unzipFile $microOfflinePakagePath $projectPath

    # 加权限
    chmod 777 $projectPath/micro/*
    chmod 777 $projectPath/micro/*.sh  # 以防有带 --xxxx的文件，命令无法处理
    chmod 777 $projectPath/micro/*/*
    chmod 777 $projectPath/micro/*/*.sh  # 以防有带 --xxxx的文件，命令无法处理

	## 4.0 拷贝自己写的配置文件
	# 修改软件 yml
	# read line 读取配置文件
	# 过滤几个变量
	# 读取 micro/updateCfgs 下的所有文件
	echoR "安装大版本== $versionCfgFolderName"
	echoR "安装软件类型 type== $updateSoftwareByCfgType"
	echoR "================================="

    local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/micro/updateCfgs/updateType1_OneByOne_CustomCfgs | grep ^- | awk '{print $9}'`  # 通过1个文件改所有配置
	if [ "$updateSoftwareByCfgType" -eq 2 ];then  # 改一个软件配置，对应一个自定义配置文件
        local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/micro/updateCfgs/ | grep ^- | awk '{print $9}'`
	fi
	echoR "所有文件 $allFiles"
    if [ "$updateSoftwareByCfgType" -eq 1 ];then # 通过多个文件改所有配置-改对应的软件
        local customSoftwareCfgFolderName="updateType1_OneByOne_CustomCfgs"  # 自定义txt 文件夹名称
    elif [ "$updateSoftwareByCfgType" -eq 2 ];then #  # 通过1个文件改所有配置
        local customSoftwareCfgFolderName=""  # 自定义txt 文件夹名称
    fi

	for file in $allFiles
	do
	    local cpFilesLen=`grep "customSoftwareCfgAbsPath" $projectPath/installPackages/commonConf/$versionCfgFolderName/micro/updateCfgs/update.txt  | wc -l`
        echoN "要拷贝的文件数量= $cpFilesLen"
        for((i=1;i<=$cpFilesLen;i++));
	    do
            if [ "$updateSoftwareByCfgType" -eq 1 ];then  # 一个软件对应一个配置文件
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/micro/updateCfgs/updateType1_OneByOne_CustomCfgs/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/micro/updateCfgs/updateType1_OneByOne_CustomCfgs/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/micro/updateCfgs/updateType1_OneByOne_CustomCfgs/$file" | awk -F '=' '{print $2}'`
            elif [ "$updateSoftwareByCfgType" -eq 2 ];then  # 通过1个文件改所有配置
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/micro/updateCfgs/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/micro/updateCfgs/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/micro/updateCfgs/$file" | awk -F '=' '{print $2}'`
            fi
            echoR "脚本配置文件 $customSoftwareCfgAbsPath"
            echoR "配置镜像文件 $dstFileAbsPath"  # 这个 后缀不带* 号
            \cp `eval echo $customSoftwareCfgAbsPath` `eval echo $dstFileAbsPath`

            # 改配置
            while read line || [[ -n ${line} ]]
            do
                if [[ $line =~ ^#.* || -z $line || $line == ' ' ]];then
                    #echoE "此行注释开头或者为空行，不读取此行"
                    continue
                fi

                k=${line%=*}  # =前
                v=${line#*=}  # =后
                v=`echo $v | awk -F '#' '{print $1}' | awk -F ' ' '{print $1}'`  # 去掉#和之前的空格
#                echoN "要修改的行====== key =  $k"
                if [[ $k =~ 'customSoftwareCfgAbsPath' || $k =~ 'dstFileAbsPath' || $k =~ 'customShellCfgAbsPath' ]];then
                    #echoN "此行是文件路径，不读取"
                    continue
                fi
                # 进行替换
                if [[ "$customSoftwareCfgAbsPath" =~ '*' ]];then  # 要拷贝到文件夹里
#                    echoR "要修改的文件= $dstFileAbsPath/*"
                    sed -i "s#$k#`eval echo $v`#g" `eval echo $dstFileAbsPath/*`
                else
#                    echoR "要修改的文件= $dstFileAbsPath"
                    sed -i "s#$k#`eval echo $v`#g" `eval echo $dstFileAbsPath`
                fi
            done < $projectPath/installPackages/commonConf/$versionCfgFolderName/micro/updateCfgs/$customSoftwareCfgFolderName/$file

        done
    done

	## 5. 检测是否安装成功(检查目录)
	if [[ -d "$projectPath/micro" ]];then
		echoR '微服务 文件夹已存在，安装成功！'
	else
		echoE '微服务 文件夹不存在，安装失败！'
	fi

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function installGatewayUpdateByCfg() {
# 思路：
    # 0. 计时start
    # 1. 读取配置，安装源+安装目的地
    # 2. 判断配置是否正确，安装源+安装目的地是否正确？目录是否自动创建？
    # 3. 根据系统，停掉服务
    # 4. 根据系统，删除已安装的程序包
    # 5. 根据系统，判断安装包类型，解压到目的地
    # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
    # 7. 加权限
    # 8. 根据系统，制作自启动/添加自启动
    # 9. 根据系统，检测是否安装成功
    # 10. 根据实际情况，安装完之后是否要启动？-不启动，如果有已经启动的nginx,还要测试安装nginx情况
    # 11. 计时end

    # 0. 计时start
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>>安装网管gateway'

    # 1. 读取配置，安装源+安装目的地
    # 2. 判断配置是否正确，安装源+安装目的地是否正确？目录是否自动创建？
    # 3. 根据系统，停掉服务
	# 判断安装文件路径是否存在
	if [[ -f "$gatewayOfflinePakagePath" ]];then
		echoN "网管gateway 安装文件 $gatewayOfflinePakagePath 存在"
	else
		echoE "网管gateway 安装文件 $gatewayOfflinePakagePath 不存在，请查看配置 gatewayOfflinePakagePath"
		return 0
	fi

    # 停止
	stopGateway

	# 4. 根据系统，删除已安装的程序包
	cd $projectPath
	rm -rf gateway

    # 5. 根据系统，判断安装包类型，解压到目的地
	unzipFile $gatewayOfflinePakagePath $projectPath
    # 7. 加权限
    chmod 777 $projectPath/gateway/*
    chmod 777 $projectPath/gateway/*/*
    # 6. 根据系统，查找自定义的配置，修改软件实际配置文件
	# read line 读取配置文件
	# 读取 gateway/updateCfgs 下的所有文件
	echoR "安装大版本== $versionCfgFolderName"
	echoR "安装软件类型 type== $updateSoftwareByCfgType"
	echoR "================================="

    local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/gateway/updateCfgs/updateType1_OneByOne_CustomCfgs | grep ^- | awk '{print $9}'`  # 通过1个文件改所有配置
	if [ "$updateSoftwareByCfgType" -eq 2 ];then  # 改一个软件配置，对应一个自定义配置文件
        local allFiles=`ls -l $projectPath/installPackages/commonConf/$versionCfgFolderName/gateway/updateCfgs/ | grep ^- | awk '{print $9}'`
	fi
	echoR "所有文件 $allFiles"
    if [ "$updateSoftwareByCfgType" -eq 1 ];then # 通过多个文件改所有配置-改对应的软件
        local customSoftwareCfgFolderName="updateType1_OneByOne_CustomCfgs"  # 自定义txt 文件夹名称
    elif [ "$updateSoftwareByCfgType" -eq 2 ];then #  # 通过1个文件改所有配置
        local customSoftwareCfgFolderName=""  # 自定义txt 文件夹名称
    fi

	for file in $allFiles
	do
	    local cpFilesLen=`grep "customSoftwareCfgAbsPath" $projectPath/installPackages/commonConf/$versionCfgFolderName/gateway/updateCfgs/update.txt  | wc -l`
        echoN "要拷贝的文件数量= $cpFilesLen"
        for((i=1;i<=$cpFilesLen;i++));
	    do
            if [ "$updateSoftwareByCfgType" -eq 1 ];then  # 一个软件对应一个配置文件
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/gateway/updateCfgs/updateType1_OneByOne_CustomCfgs/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/gateway/updateCfgs/updateType1_OneByOne_CustomCfgs/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/gateway/updateCfgs/updateType1_OneByOne_CustomCfgs/$file" | awk -F '=' '{print $2}'`
            elif [ "$updateSoftwareByCfgType" -eq 2 ];then  # 通过1个文件改所有配置
                sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/gateway/updateCfgs/$file
                local customSoftwareCfgAbsPath=`grep "customSoftwareCfgAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/gateway/updateCfgs/$file" | awk -F '=' '{print $2}'`
                local dstFileAbsPath=`grep "dstFileAbsPath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/gateway/updateCfgs/$file" | awk -F '=' '{print $2}'`
            fi
            echoR "脚本配置文件 $customSoftwareCfgAbsPath"
            echoR "配置镜像文件 $dstFileAbsPath"  # 这个 后缀不带* 号
            \cp `eval echo $customSoftwareCfgAbsPath` `eval echo $dstFileAbsPath`

            # 改配置
            while read line || [[ -n ${line} ]]
            do
                if [[ $line =~ ^#.* || -z $line || $line == ' ' ]];then
                    #echoE "此行注释开头或者为空行，不读取此行"
                    continue
                fi

                k=${line%=*}  # =前
                v=${line#*=}  # =后
                v=`echo $v | awk -F '#' '{print $1}' | awk -F ' ' '{print $1}'`  # 去掉#和之前的空格
                if [[ $k =~ 'customSoftwareCfgAbsPath' || $k =~ 'dstFileAbsPath' || $k =~ 'customShellCfgAbsPath' ]];then
                    #echoN "此行是文件路径，不读取"
                    continue
                fi
                # 进行替换
                if [[ "$customSoftwareCfgAbsPath" =~ '*' ]];then  # 要拷贝到文件夹里
#                    echoR "要修改的文件= $dstFileAbsPath/*"
                    sed -i "s#$k#`eval echo $v`#g" `eval echo $dstFileAbsPath/*`
                else
#                    echoR "要修改的文件= $dstFileAbsPath"
                    sed -i "s#$k#`eval echo $v`#g" `eval echo $dstFileAbsPath`
                fi
            done < $projectPath/installPackages/commonConf/$versionCfgFolderName/gateway/updateCfgs/$customSoftwareCfgFolderName/$file

        done
    done

    # 8. 根据系统，制作自启动/添加自启动
    # 9. 根据系统，检测是否安装成功
    # 10. 根据实际情况，安装完之后是否要启动？-不启动，如果有已经启动的nginx,还要测试安装nginx情况
	if [[ -d "$projectPath/gateway" ]];then
		echoR "网管gateway 文件夹 $projectPathe/gateway 已存在，安装成功！"
	else
		echoE "网管gateway 文件夹 $projectPathe/gateway 不存在，安装失败！"
	fi

    # 11. 计时end
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function stopGateway() {
    if [[ -d "$projectPath/gateway/oam-nms-gw-0.0.1-SNAPSHOT" ]];then
        cd $projectPath/gateway/oam-nms-gw-0.0.1-SNAPSHOT
        chmod +x *
        chmod 777 *
        ./run.sh stop

        pids=`ps -ef|grep oam-nms-gw | grep -v grep | awk '{print $2}'`  # 先查询pid
        if [[ $pids != "" ]];then
            kill -9 $pids  # 杀掉进程
        fi
	fi

	if [[ -d "$projectPath/gateway/sun-nms-devconfig-service-0.0.1-SNAPSHOT" ]];then
        cd $projectPath/gateway/sun-nms-devconfig-service-0.0.1-SNAPSHOT
        chmod +x *
        chmod 777 *
        ./run.sh stop
        pids=`ps -ef|grep sun-nms-devconfig | grep -v grep | awk '{print $2}'`  # 先查询pid
        if [[ $pids != "" ]];then
	        kill -9 $pids  # 杀掉进程
	    fi
	fi
	echoN "停止网管gateway 完毕，回车继续"
}


function restartGateway() {
	stopGateway
	sleep 1

	echoN "重启网管gateway中。。。"
	cd $projectPath/gateway/oam-nms-gw-0.0.1-SNAPSHOT
	chmod +x *
	chmod 777 *
	./run.sh restart

	cd $projectPath/gateway/sun-nms-devconfig-service-0.0.1-SNAPSHOT
	chmod +x *
	chmod 777 *
	./run.sh restart
	echoN "重启网管gateway完毕，回车继续"
}


function stopMicro() {
	cd $projectPath/micro
	chmod +x *
	chmod 777 *
	if [ -f "runAll.sh" ];then
	    ./runAll.sh stop
	fi
	echoN "停止完毕，回车继续"
}


function restartMicro(){
	stopMicro
	echoN "重启微服务。。。"

	cd $projectPath/micro
	chmod +x *
	chmod 777 *
	if [ -f "runAll.sh" ];then
	    ./runAll.sh start
	fi
	echoN "重启微服务完毕，回车继续"
}


function stopNms() {
	cd $projectPath/nms/backend
	chmod 777 *
	if [ -f "runAll.sh" ];then
	    ./runAll.sh stop
	fi
	echoN "停止网管完毕，回车继续"
}


function restartNms() {
	stopNms
	sleep 1

	echoN "重启网管中。。。"
	cd $projectPath/nms/backend
	chmod +x *
	chmod 777 *
	sleep 1
	if [ -f "runAll.sh" ];then
	    ./runAll.sh start
	fi

#    if [[ -d "$projectPath/nms/backend/sun-nms-user-service" ]];then
#        echoN "准备重启 nms-user ......"
#        sleep 5
#        echoN "等待 ......"
#        sleep 60
#        echoN "等待 ......"
#        sleep 60
#        echoN "等待 ......"
#        sleep 60
#        echoN "等待 ......"
#        sleep 60
#        echoN "等待 ......"
#        sleep 60
#        echoN "等待 ......"
#
#        cd $projectPath/nms/backend/sun-nms-user-service
#        sleep 5
#        echoN "进入路径，等待重启 ......"
#        ./run.sh restart
#    fi
	echoN "重启网管完毕，回车继续"
#	exit
}


function deleteDataIcss(){
    local startTime=$(date +%s)
    # 0. 判断文件夹是否存在
    if [[ ! -f "$projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/4_delete_data_icss.sql" ]];then
        echoE "数据库文件不存在，退出"
#        exit
    fi

    cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
	# 增加权限
	mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/4_delete_data_icss.sql >> /dev/null

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function deleteDataNms(){
    local startTime=$(date +%s)
    # 0. 判断文件夹是否存在
    if [[ ! -f "$projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/4_delete_data_nms.sql" ]];then
        echoE "数据库文件不存在，退出"
#        exit
    fi

    cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
    # 更改sql脚本unitid
    \cp 4_delete_data_nms-bak.sql 4_delete_data_nms.sql
    sed -i "s/unitid/$nmsUnitid/g" 4_delete_data_nms.sql

	# 导入sql，删除数据
	echoN "删除网管数据中。。。"
	mysql --force -uroot -psunkaisens < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/4_delete_data_nms.sql

	## 2. 替换sql脚本内容为unitid
	cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
	\cp 4_delete_data_nms-bak.sql 4_delete_data_nms.sql
	echoR "删除网管数据完毕！"

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function deleteDataSwitch(){
    local startTime=$(date +%s)
    # 远程执行sql
    # 0. 判断文件夹是否存在
    if [[ ! -f "$projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/4_delete_data_switch.sql" ]];then
        echoE "数据库文件不存在，退出"
#        exit
    fi

    # 判断是否能ping通，ping 3次，不通就不执行！！
    echoN "查看核心网是否启动?"
    ping -c 3 $switchIp
    if [[ $? != 0 ]];then
        echoE "核心网ping不通!!!"
    else
        echoN "核心网ping通,执行脚本"
        # 删除
        cd $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql
        mysql -h$switchIp -u$switchDbUsername -p$switchDbPassword < $projectPath/installPackages/commonConf/$versionCfgFolderName/mysql/sql/4_delete_data_switch.sql
    fi

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function checkIsDockerInstallRight(){
	echo " 检查docker是否安装正确............."
#	if [ `ps -ef|grep docker | grep -v "grep" | wc -l` -gt 0 ];then
##		echo -e "\033[40;32m docker启动成功 \033[0m" #黑底绿字
#		#0代表正常
#		return 0
#	else
#		#echo -e "\033[47;31m docker启动失败 \033[0m" #白底红字
#		return 1
#	fi
#    if [[ `docker -v` =~ "version" ]];then
    if [[ -f "/usr/local/docker/docker" ]];then
#        echoN "docker 已安装"
        return 1
    else
#        echoE "docker 未安装"
        return 0
    fi
}


function installDocker(){
    local startTime=$(date +%s)
    # 先删除docker
    cd /usr/local/
    rm -rf docker

	cd $projectPath
	#解压到/usr/bin目录
	echo "项目当前路径" $projectPath
	rm -rf /usr/bin/docker*

	# 1. 解压压缩包
    ## 3. 判断安装包类型，解压到配置文件写的路径
    unzipFile $dockerOfflinePakagePath $dockerOfflineInstallPath

    # 拷贝docker 命令文件
    \cp -rf $dockerOfflineInstallPath/docker/* /usr/bin

    # 加权限
    cd /usr/bin
    chmod +x *
    chmod 777 *

	#拷贝自启动文件 &自启动
	\cp -rf $projectPath/installPackages/centos7/docker/service/docker.service /etc/systemd/system/
	chmod +x /etc/systemd/system/docker.service
	systemctl daemon-reload
	systemctl enable docker
	#启动docker
	systemctl start docker
#    checkIsDockerInstallRight

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function removeDocker(){
	echo "移除docker"

	#先关闭已启动容器
	echo "先关闭已启动容器"
		startedDockerContaintId=`docker ps -a -q`
		docker stop $startedDockerContaintId
		docker rm $startedDockerContaintId

	#先移除已安装镜像
	echo "先移除已安装镜像"
		installedDockerImages=`docker images -a -q`
		echo "已安装镜像：" $installedDockerImages
		docker rmi $installedDockerImages

	#关闭docker服务
	systemctl disable docker
	systemctl stop docker
	rm -f /etc/systemd/system/docker


	rm -rf /usr//bin/docker*
	if [ ! -f /usr/bin/docker ];then
		echo -e "\033[40;32m docker删除成功 \033[0m" #黑底绿字
	else
		echo -e "\033[47;31m docker删除失败 \033[0m" #白底红字
	fi
}


function removeKms(){
    if [[ $systemVersion == 'centos7' ]];then
        removeDocker
    elif [[ $systemVersion == 'kylin' ]];then
        pkill kurento
	    rm -rf /home/SK_KMS
    elif [[ $systemVersion == 'kylin-x86' ]];then
        removeDocker
	fi
    echoN "移除kms完成"
}


function closeSelinux(){
	#先临时关闭selinux 保证kms能启动，之后设置永久关闭，等oam重启的时候自动生效
	echo "先临时关闭selinux 保证kms能启动，之后设置永久关闭，等oam重启的时候自动生效"
	echo "临时关闭selinux"
	setenforce 0
	echo "永久关闭selinux"
	sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
}


function installKmsC7(){
    local startTime=$(date +%s)
	#检查docker是否安装
	dockerFlag=`checkIsDockerInstallRight`  # 返回值
	if [[ $? -eq 1 ]];then
#	if [[ $dockerFlag -eq 1 ]];then
		echo "docker 已经安装"
		#先关闭selinux保证kms能启动
		closeSelinux

        #先关闭已启动容器
        systemctl restart docker
        echoN "先关闭已启动容器"
		startedDockerContaintId=`docker ps -a -q`
		echoN "startedDockerContaintId == $startedDockerContaintId"
		if [[ -n $startedDockerContaintId ]];then
            echoN "docker容器非空."
		    docker stop $startedDockerContaintId
		    docker rm $startedDockerContaintId
		fi

		#先移除已安装镜像
		echoN "先移除已安装镜像"
		installedDockerImages=`docker images -a -q`
		echoN "installedDockerImages == $installedDockerImages"
		if [[ -n $startedDockerContaintId ]];then
		    echoN "docker容器非空."
            echo "已安装镜像：" $installedDockerImages
            docker rmi $installedDockerImages
		fi

		#安装kms
		echoN "安装kms"
		cd $projectPath/installPackages/centos7/kms
		docker load -i kms-centos7.tar

		#给镜像打tag
		echo "给镜像打tag"
		echoN "给镜像打tag"
		kmsImageId=`docker images -a -q`
		docker tag $kmsImageId sunkaisens/kurento-media-server:v1
		#运行daocker容器
		echo "运行daocker容器"
		echoN "运行daocker容器"
		docker run --name kms -d --network host sunkaisens/kurento-media-server:v1

		#启动容器
		echoN "启动容器"
		kmsContainerId=`docker ps -a -q`

		docker start $kmsContainerId
		#设置kms自启动
		echoN "设置kms自启动"
		echo "设置kms自启动"
		docker update --restart=always $kmsContainerId
	else
		echo -e "\033[47;31m 请先安装docker,再安装kms \033[0m" #白底红字
	fi

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "安装KmsC7, 用时:" $nomal_info $timeSup "秒"
}


function removeInstalledJDK(){
	echo "已安装的jdk列表如下：__________"
	for installedJDK in `rpm -qa|grep jdk`
	do
		echo $installedJDK
		rpm -e --nodeps $installedJDK
	done
	echo "________________________________"
}


function checkIsRemoveInstalledJDK(){
	if [ `rpm -qa|grep jdk | wc -l` -eq 0 ];then
		echo "jdk成功卸载"
	fi
}


function offlineInstallKms(){
    local startTime=$(date +%s)

    echoN '>>>>>>>>>>>>离线安装 KMS'

    ## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then
        # 安装docker
        # 安装kms
        echoN '>>>>>>>>>>>>安装docker'
        echoN '>>>>>>>>>>>>安装kms'
        if [[ -f "/usr/local/docker/docker" ]];then
            echoN "docker 已安装,仍要继续安装"
            installDocker
        else
            echoE "docker 未安装"
            installDocker
        fi

        systemctl start docker

        if [[ `docker ps -a` =~ 'sunkaisens/kurento-media-server' ]];then
            echoN "kms 已安装 退出安装"
#            return 0
        else
            echoN "kms 未安装,安装中...."
        fi

        if [[ `systemctl status docker` =~ ''running ]];then
            echoR "docker 正常启动，安装kms"
            installKmsC7
        fi

        echoR "KMS 安装完成"
    elif [[ $systemVersion == 'kylin' ]];then

            ## 1. 判断配置文件是否正确
            # 判断安装文件路径是否存在
            if [[ -f "$kmsOfflinePakagePathSP3" ]];then
                echoN 'KMS_SP3 安装文件存在'
            else
                echoE 'KMS_SP3 安装文件不存在，请查看配置 kmsOfflinePakagePathSP3'
                return 0
            fi

            # 判断安装目录是否存在
            if [[ -d "$kmsOfflineInstallPathSP3" ]];then
                echoN 'KMS_SP3 安装目录存在'
            else
                echoE 'KMS_SP3 安装目录不存在，请查看配置 kmsOfflineInstallPathSP3'
                return 0
            fi

            if [[ -f "$kmsOfflinePakagePathSP4" ]];then
                echoN 'KMS_SP4 安装文件存在'
            else
                echoE 'KMS_SP4 安装文件不存在，请查看配置 kmsOfflinePakagePathSP4'
                return 0
            fi

            # 判断安装目录是否存在
            if [[ -d "$kmsOfflineInstallPathSP4" ]];then
                echoN 'KMS_SP4 安装目录存在'
            else
                echoE 'KMS_SP4 安装目录不存在，请查看配置 kmsOfflineInstallPathSP4'
                return 0
            fi

            # 1.1 停掉 KMS
            stopKms
            sleep 1

            ## 2. 删除已安装的 KMS
            cd /home  # 以防把根目录删了
            rm -rf SK_KMS  #这个 KMS 解压版本如果换了，还得改

            linuxVersiion=`uname -r`
            if [[ $linuxVersiion =~ "2019"  ]];then  # 长字符 =~ 短字符  SP3
                echoN "SP3版本，安装KMS"
                # 1. 解压压缩包
                ## 3. 判断安装包类型，解压到配置文件写的路径
                unzipFile $kmsOfflinePakagePathSP3 $kmsOfflineInstallPathSP3

                # 安装*.deb文件,查询kurento，没有，就循环装
                installKmsFlag=1
                while [[ $installKmsFlag == "1" ]];do
                    # 启动 kms
                    cd /home/SK_KMS
                    ./kms_start.sh &
                    sleep 5

                    echoN "后台启动kms,检测服务是否启动？8888端口是否启动，启动成功后，退出安装deb包循环"
                    grepKurentoResult=`ps -ef|grep "kurento-media-server" | grep -v "grep" | wc -l`
                    grepKurentoPortResult=`netstat -anp|grep 8888 | grep -v "grep" | wc -l`
                    if [[ grepKurentoResult -eq 0 || grepKurentoPortResult -eq 0 ]];then
                        echoE "检测kms无法启动，基础包未安装完成，继续安装。。。。"
                        ## 判断dpkg是否被占用，否则会报错：pdkg 错误：另外一个进程已经为dpkg 状态数据库 加锁
                        echoN "检测dpkg 是否加锁？"

                        dpkgPids=`ps -aux | grep dpkg | grep -v grep | awk '{print $2}'`  # 先查询pid
                        echoN "检测 dpkgPids== $dpkgPids "
                        echoN "检测 dpkgPids== $dpkgPids "
                        echoN "检测 dpkgPids== $dpkgPids "

                        if [[ -n $dpkgPids ]];then  # -n 不为空
                            echoN "尝试60秒后杀掉进程。。。。"
                            sleep 60
                            kill -9 $dpkgPids  # 杀掉进程
                        else
                            echoN "dpkg未被占用，安装kms基础包。。。。"
                        fi

                        echoN "安装kms基础包。。。。"
                        cd /home/SK_KMS/archives_deb_desktop_ps3
                        dpkg -i *.deb
                        sleep 5

                    else
                        installKmsFlag=0
                    fi
                done
            fi

            if [[ $linuxVersiion =~ "2020"  ]];then  # 长字符 =~ 短字符  SP4
                echoN "SP4版本，安装KMS"
                # 1. 解压压缩包
                ## 3. 判断安装包类型，解压到配置文件写的路径
                unzipFile $kmsOfflinePakagePathSP4 $kmsOfflineInstallPathSP4
                # 安装*.deb文件,查询kurento，没有，就循环装
                installKmsFlag=1
                while [[ $installKmsFlag == "1" ]];do
                    # 启动 kms
                    cd /home/SK_KMS
                    ./kms_start.sh &
                    sleep 5

                    echoN "后台启动kms,检测服务是否启动？8888端口是否启动，启动成功后，退出安装deb包循环"
                    grepKurentoResult=`ps -ef|grep "kurento-media-server" | grep -v "grep" | wc -l`
                    grepKurentoPortResult=`netstat -anp|grep 8888 | grep -v "grep" | wc -l`
                    if [[ grepKurentoResult -eq 0 || grepKurentoPortResult -eq 0 ]];then
                        echoE "检测kms无法启动，基础包未安装完成，继续安装。。。。"
                        ## 判断dpkg是否被占用，否则会报错：pdkg 错误：另外一个进程已经为dpkg 状态数据库 加锁
                        echoN "检测dpkg 是否加锁？"

                        dpkgPids=`ps -aux | grep dpkg | grep -v grep | awk '{print $2}'`  # 先查询pid
                        echoN "检测 dpkgPids== $dpkgPids "
                        echoN "检测 dpkgPids== $dpkgPids "
                        echoN "检测 dpkgPids== $dpkgPids "

                        if [[ -n $dpkgPids ]];then  # -n 不为空
                            echoN "尝试60秒后杀掉进程。。。。"
                            sleep 60
                            kill -9 $dpkgPids  # 杀掉进程
                        else
                            echoN "dpkg未被占用，安装kms基础包。。。。"
                        fi

                        echoN "安装kms基础包。。。。"
                        cd /home/SK_KMS/archives_deb_desktop_ps3
                        dpkg -i *.deb

                    else
                        installKmsFlag=0
                    fi
                done
            fi
    elif [[ $systemVersion == 'kylin-x86' ]];then
        # 安装docker
        # 安装kms
        echoN '>>>>>>>>>>>>安装docker'
        echoN '>>>>>>>>>>>>安装kms'
        if [[ -f "/usr/local/docker/docker" ]];then
            echoN "docker 已安装,仍要继续安装"
            installDocker
        else
            echoE "docker 未安装"
            installDocker
        fi

        systemctl start docker

        if [[ `docker ps -a` =~ 'sunkaisens/kurento-media-server' ]];then
            echoN "kms 已安装 退出安装"
#            return 0
        else
            echoN "kms 未安装,安装中...."
        fi

        if [[ `systemctl status docker` =~ ''running ]];then
            echoR "docker 正常启动，安装kms"
            installKmsC7
        fi

        echoR "KMS 安装完成"
	fi

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "离线安装 KMS, 用时:" $nomal_info $timeSup "秒"
}


function stopKms(){
    echoN '>>>>>>>>>>>> 停止kms'
    if [ "$systemVersion" == 'centos7' ];then
        systemctl stop docker
#        systemctl status docker
    fi
    pkill kurento
    pids=`ps -ef|grep kurento | grep -v grep | awk '{print $2}'`
    if [[ $pids != "" ]];then
        kill -9 $pids
    fi
	sleep 1
	echoN '>>>>>>>>>>>> 停止kms完成'
}


function restartKms(){
    echoN '>>>>>>>>>>>> 停止kms'
    stopKms
    if [ "$systemVersion" == 'centos7' ];then
        systemctl restart docker
    elif [ "$systemVersion" == 'kylin' ];then
        cd /home/SK_KMS/
        ./kms_start.sh &
    elif [ "$systemVersion" == 'kylin-x86' ];then
        systemctl restart docker
    fi
	sleep 1
	echoN '>>>>>>>>>>>> 重启kms完成'
}


function removeMysql(){
    local startTime=$(date +%s)
    echoN '>>>>>>>>>>>> 卸载mysql。。。'
    stopMysql

    ## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then

	    echoN '>>>>>>>>>>>> 卸载 mariadb。。。'
	    systemctl stop mariadb
        echo "已安装的mariadb列表如下：__________"
        for installedMariadb in `rpm -qa|grep mariadb`
        do
            echo $installedMariadb
            rpm -e --nodeps $installedMariadb
        done
        echo "________________________________"
		sleep 2

	    echoN '>>>>>>>>>>>> 卸载mysql。。。'
        echo "已安装的mysql列表如下：__________"
        for installedMysql in `rpm -qa|grep mysql`
        do
            echo $installedMysql
            rpm -e --nodeps $installedMysql
        done
        echo "________________________________"

        # 清除残留数据
        cd /var/log
#        rm -rf mysqld.log  # 删除了log会找不到初始密码
        cd /etc
#        rm -rf my.cnf*
        cd /var/lib
        rm -rf mysql*
        cd /usr/share
        rm -rf mysql*
        cd /var/log
        rm -rf mysql*
    elif [[ $systemVersion == 'kylin' ]];then
        # 卸载mysql
        apt-get -f autoremove --purge mysql* -y ## 第一种方式卸载mysql --> sp3可用

        # 第二种方式卸载mysql --> sp4可用
        dpkg --force-depends --purge mysql-server-core-5.7
        dpkg --force-depends --purge mysql-common
        dpkg --force-depends --purge mysql-client-5.7
        dpkg --force-depends --purge mysql-client-core-5.7
        dpkg --force-depends --purge mysql-server-5.7
        echoN '查看已安装mysql包'
        dpkg --list|grep mysql

        # 清除残留数据
        dpkg -l | grep ^rc | awk '{print $2}' | xargs dpkg -P

        # 删除mysql 日志，配置文件等
        rm -rf /etc/mysql  # mysql配置文件
        rm -rf /var/lib/mysql  # mysql 文件
        rm -rf /var/log/mysql  # mysql 日志文件
    elif [[ $systemVersion == 'kylin-x86' ]];then

	    echoN '>>>>>>>>>>>> 卸载 mariadb。。。'
	    systemctl stop mariadb
        echo "已安装的mariadb列表如下：__________"
        for installedMariadb in `rpm -qa|grep mariadb`
        do
            echo $installedMariadb
            rpm -e --nodeps $installedMariadb
        done
        echo "________________________________"
		sleep 2

	    echoN '>>>>>>>>>>>> 卸载mysql。。。'
        echo "已安装的mysql列表如下：__________"
        for installedMysql in `rpm -qa|grep mysql`
        do
            echo $installedMysql
            rpm -e --nodeps $installedMysql
        done
        echo "________________________________"

        # 清除残留数据
        cd /var/log
#        rm -rf mysqld.log  # 删除了log会找不到初始密码
        cd /etc
#        rm -rf my.cnf*
        cd /var/lib
        rm -rf mysql*
        cd /usr/share
        rm -rf mysql*
        cd /var/log
        rm -rf mysql*

        # 删除mariadb
        cd /usr/share
        rm -rf mariadb
        cd /etc
        rm -rf my.cnf.rpmnew
        rm -rf my.cnf.rpmsave
    elif [[ $systemVersion == 'centos8' ]];then

	    echoN '>>>>>>>>>>>> 卸载 mariadb。。。'
	    systemctl stop mariadb
        echo "已安装的mariadb列表如下：__________"
        for installedMariadb in `rpm -qa|grep mariadb`
        do
            echo $installedMariadb
            rpm -e --nodeps $installedMariadb
        done
        echo "________________________________"
		sleep 2

	    echoN '>>>>>>>>>>>> 卸载mysql。。。'
        echo "已安装的mysql列表如下：__________"
        for installedMysql in `rpm -qa|grep mysql`
        do
            echo $installedMysql
            rpm -e --nodeps $installedMysql
        done
        echo "________________________________"

        # 清除残留数据
        cd /var/log
#        rm -rf mysqld.log  # 删除了log会找不到初始密码
        cd /etc
#        rm -rf my.cnf*
        cd /var/lib
        rm -rf mysql*
        cd /usr/share
        rm -rf mysql*
        cd /var/log
        rm -rf mysql*

        # 删除mariadb
        cd /usr/share
        rm -rf mariadb
        cd /etc
        rm -rf my.cnf.rpmnew
        rm -rf my.cnf.rpmsave
	fi

	echoN '>>>>>>>>>>>> 卸载mysql 完成'

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function addIcssViturlNumber(){
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>> 插入调度台虚拟号码'
		# 初始化
	icssViturlNumberDisplayName=${icssViturlNumber:3}  # 调度台默认号码，显示名称，截取后8位

    # 0. 获取token
    #loginToken=`curl -H "Content-Type:application/json;charset=UTF-8" -X POST http://120.0.0.53:7100/login?username=admin\&password=admin --compressed --insecure | jq '.data' | jq '.token'`
    #loginToken="18cb5343d0e75887793d5db2bd19729e649d19bf0c3c5d16e012d526644615a071255ba1505644d3aba1e3eb65ba6b1463ecae2cd86d5406ca181d5b8b66ac2af20f6b520683466b9a9ccb37c15b4e7a2938b9b8f935058c0fc1a9534ca8275104c0b1ec1ea9d91558ac6e6fa8fc70216c34e14b3cb7284a4bfbcf57720c4021685fbe2ee4fa51d80ae45c70efde0103f03cf3fd8d4b8d97dfd3cf62ca1960f9de9cd8d2ac9e613ff88bd5edb0435b712657bf3348e75c29"
    responseJson=`curl -H "Content-Type:application/json;charset=UTF-8" -X POST http://$nmsIp:7100/login?username=admin\&password=admin`  # 请求返回值
    echo "responseJson === $responseJson"
    loginToken=`echo $responseJson | jq '.data | .token' | grep -Eo "[0-9a-Z]*"`
    echo "登录token==== $loginToken"

	# 1. 删除虚拟号码
	curl -w %{http_code} -H "Content-Type:application/json;charset=UTF-8" -H "Authentication:$loginToken" -X DELETE http://$nmsIp:7100/v1/nms-user-service/hss/4600$icssViturlNumber

	# 2. 添加虚拟号码
    numberData='{
          "groupNum": null,
          "mdn": "'$icssViturlNumber'",
          "imsi": "4600'$icssViturlNumber'",
          "unitId": "'$nmsUnitid'",
          "deviceType": 8,
          "msvocodec": 8,
          "data": 1,
          "groupCall": 1,
          "shortMsg": 1,
          "internationality": 0,
          "callWaitting": 1,
          "threeWay": 1,
          "callInLimit": 0,
          "callOutLimit": 0,
          "pairNet": 0,
          "secrecy": 1,
          "callerAllow": 1,
          "callerHide": 0,
          "duplexSingleCall": 1,
          "halfDuplexSingleCall": 1,
          "circuitData": 1,
          "domain": "test.com",
          "uePassword": "123456",
          "monitorSwitch": 0,
          "monitorIP": "",
          "monitorPort": 9654,
          "region": 1,
          "voiceMailSwitch": "0",
          "ospfMulticast": 1,
          "ospfBroadcast": 1,
          "voiceMailNum": "",
          "fwdNoAnswer": 0,
          "fwdNoAnswerNum": "",
          "directFwd": 0,
          "directFwdNum": "",
          "fwdOnBusy": 0,
          "fwdOnBusyNum": "",
          "fwdNA": 0,
          "fwdNANum": "",
          "priority": 5,
          "amf1": "72",
          "amf2": "4C",
          "sqn1": "00",
          "sqn2": "00",
          "sqn3": "00",
          "sqn4": "00",
          "sqn5": "00",
          "sqn6": "00",
          "k1": "FF",
          "k2": "FF",
          "k3": "FF",
          "k4": "FF",
          "k5": "FF",
          "k6": "FF",
          "k7": "FF",
          "k8": "FF",
          "k9": "FF",
          "k10": "FF",
          "k11": "FF",
          "k12": "FF",
          "k13": "FF",
          "k14": "FF",
          "k15": "FF",
          "k16": "FF",
          "op1": "FF",
          "op2": "FF",
          "op3": "FF",
          "op4": "FF",
          "op5": "FF",
          "op6": "FF",
          "op7": "FF",
          "op8": "FF",
          "op9": "FF",
          "op10": "FF",
          "op11": "FF",
          "op12": "FF",
          "op13": "FF",
          "op14": "FF",
          "op15": "FF",
          "op16": "FF",
          "opc1": "FF",
          "opc2": "FF",
          "opc3": "FF",
          "opc4": "FF",
          "opc5": "FF",
          "opc6": "FF",
          "opc7": "FF",
          "opc8": "FF",
          "opc9": "FF",
          "opc10": "FF",
          "opc11": "FF",
          "opc12": "FF",
          "opc13": "FF",
          "opc14": "FF",
          "opc15": "FF",
          "opc16": "FF",
          "start": "00:00:00",
          "stop": "23:59:59",
          "domainId": "'$nmsUnitid'",
          "displayName": "'$icssViturlNumberDisplayName'",
          "amf": "72 4C",
          "sqn": "00 00 00 00 00 00",
          "k": "FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF",
          "op": "FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF",
          "opc": "FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF"
        }'

#    echoN "json == $numberData"
	curl -w %{http_code} -H "Content-Type:application/json;charset=UTF-8" -H "Authentication:$loginToken" -X POST http://$nmsIp:7100/v1/nms-user-service/hss -d "$numberData"

	# 3. 查询一下号码
#	curl -w %{http_code} -H "Content-Type:application/json;charset=UTF-8" -H "Authentication:$loginToken" http://120.2.0.11:7100/v1/nms-user-service/hss?deviceType=\&msvocodec=\&unitName=\&status=\&mdn=\&imsi=\&pageNum=1\&pageSize=20
    echo ""

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function addIcssdefaultNumber(){
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>> 插入调度台默认号码'
	# 初始化
	icssDefaultNumberDisplayName=${icssDefaultNumber:3}  # 调度台默认号码，显示名称，截取后8位

    # 0. 获取token
    #loginToken=`curl -H "Content-Type:application/json;charset=UTF-8" -X POST http://120.0.0.53:7100/login?username=admin\&password=admin --compressed --insecure | jq '.data' | jq '.token'`
    #loginToken="18cb5343d0e75887793d5db2bd19729e649d19bf0c3c5d16e012d526644615a071255ba1505644d3aba1e3eb65ba6b1463ecae2cd86d5406ca181d5b8b66ac2af20f6b520683466b9a9ccb37c15b4e7a2938b9b8f935058c0fc1a9534ca8275104c0b1ec1ea9d91558ac6e6fa8fc70216c34e14b3cb7284a4bfbcf57720c4021685fbe2ee4fa51d80ae45c70efde0103f03cf3fd8d4b8d97dfd3cf62ca1960f9de9cd8d2ac9e613ff88bd5edb0435b712657bf3348e75c29"
    responseJson=`curl -H "Content-Type:application/json;charset=UTF-8" -X POST http://$nmsIp:7100/login?username=admin\&password=admin`  # 请求返回值
    echo "responseJson === $responseJson"
    loginToken=`echo $responseJson | jq '.data | .token' | grep -Eo "[0-9a-Z]*"` # token里带前后双引号,去掉
    echo "登录token==== $loginToken"

	# 1. 删除虚拟号码
	curl -w %{http_code} -H "Content-Type:application/json;charset=UTF-8" -H "Authentication:$loginToken" -X DELETE http://$nmsIp:7100/v1/nms-user-service/hss/4600$icssDefaultNumber

	# 2. 添加虚拟号码
	numberData='{
          "groupNum": null,
          "mdn": "'$icssDefaultNumber'",
          "imsi": "4600'$icssDefaultNumber'",
          "unitId": "'$nmsUnitid'",
          "deviceType": 8,
          "msvocodec": 8,
          "data": 1,
          "groupCall": 1,
          "shortMsg": 1,
          "internationality": 0,
          "callWaitting": 1,
          "threeWay": 1,
          "callInLimit": 0,
          "callOutLimit": 0,
          "pairNet": 0,
          "secrecy": 1,
          "callerAllow": 1,
          "callerHide": 0,
          "duplexSingleCall": 1,
          "halfDuplexSingleCall": 1,
          "circuitData": 1,
          "domain": "test.com",
          "uePassword": "123456",
          "monitorSwitch": 0,
          "monitorIP": "",
          "monitorPort": 9654,
          "region": 1,
          "voiceMailSwitch": "0",
          "ospfMulticast": 1,
          "ospfBroadcast": 1,
          "voiceMailNum": "",
          "fwdNoAnswer": 0,
          "fwdNoAnswerNum": "",
          "directFwd": 0,
          "directFwdNum": "",
          "fwdOnBusy": 0,
          "fwdOnBusyNum": "",
          "fwdNA": 0,
          "fwdNANum": "",
          "priority": 5,
          "amf1": "72",
          "amf2": "4C",
          "sqn1": "00",
          "sqn2": "00",
          "sqn3": "00",
          "sqn4": "00",
          "sqn5": "00",
          "sqn6": "00",
          "k1": "FF",
          "k2": "FF",
          "k3": "FF",
          "k4": "FF",
          "k5": "FF",
          "k6": "FF",
          "k7": "FF",
          "k8": "FF",
          "k9": "FF",
          "k10": "FF",
          "k11": "FF",
          "k12": "FF",
          "k13": "FF",
          "k14": "FF",
          "k15": "FF",
          "k16": "FF",
          "op1": "FF",
          "op2": "FF",
          "op3": "FF",
          "op4": "FF",
          "op5": "FF",
          "op6": "FF",
          "op7": "FF",
          "op8": "FF",
          "op9": "FF",
          "op10": "FF",
          "op11": "FF",
          "op12": "FF",
          "op13": "FF",
          "op14": "FF",
          "op15": "FF",
          "op16": "FF",
          "opc1": "FF",
          "opc2": "FF",
          "opc3": "FF",
          "opc4": "FF",
          "opc5": "FF",
          "opc6": "FF",
          "opc7": "FF",
          "opc8": "FF",
          "opc9": "FF",
          "opc10": "FF",
          "opc11": "FF",
          "opc12": "FF",
          "opc13": "FF",
          "opc14": "FF",
          "opc15": "FF",
          "opc16": "FF",
          "start": "00:00:00",
          "stop": "23:59:59",
          "domainId": "'$nmsUnitid'",
          "displayName": "'$icssDefaultNumberDisplayName'",
          "amf": "72 4C",
          "sqn": "00 00 00 00 00 00",
          "k": "FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF",
          "op": "FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF",
          "opc": "FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF"
        }'

    # 处理json数据
#   numberData=`echo $numberDataJson | jq 'to_entries |
#   map(if .key == "mdn"
#      then . + {"value": "'$icssDefaultNumber'"}
#      elif .key == "imsi"
#      then . + {"value":"4600'$icssDefaultNumber'"}
#      elif .key == "displayName"
#      then . + {"value": "'$icssDefaultNumberDisplayName'"}
#      else .
#      end
#     ) |
#      from_entries'`

#    echoN "json == $numberData"
	curl -w %{http_code} -H "Content-Type:application/json;charset=UTF-8" -H "Authentication:$loginToken" -X POST http://$nmsIp:7100/v1/nms-user-service/hss -d "$numberData"

	# 3. 查询一下号码
#	curl -w %{http_code} -H "Content-Type:application/json;charset=UTF-8" -H "Authentication:$loginToken" http://120.2.0.11:7100/v1/nms-user-service/hss?deviceType=\&msvocodec=\&unitName=\&status=\&mdn=\&imsi=\&pageNum=1\&pageSize=20
    echo ""

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function disableFirewalld(){
    echoN "永久关闭防火墙"
    if [[ $systemVersion == 'centos7' ]];then
        systemctl stop firewalld
        systemctl disable firewalld
    elif [[ $systemVersion == 'kylin' ]];then
	    echoN ""
    elif [[ $systemVersion == 'kylin-x86' ]];then
	    systemctl stop firewalld
        systemctl disable firewalld
    elif [[ $systemVersion == 'centos8' ]];then
	    systemctl stop firewalld
        systemctl disable firewalld
	fi
}


function stopRecording(){
    echoN "停止recording>>>>>>>>>>"
    ## 0. 查recording网元名称
    searchRecordingName=`oamls | grep  recoding | grep -Eo  '[1-9][0-9]*-[0-9]'`  # 第一种查网元名称x-x
    if [[ $searchRecordingName == '' ]];then
        searchRecordingName=`oamls | grep  recoding | grep -Eo  '[1-9][0-9]*-[0-9]'` # 第二种查网元名称x-x
    fi

	if [[ $searchRecordingName == "" ]];then
        echoE "未找到recording安装路径"
    else
        ## 更新onekey.cfg 配置文件，以便下次脚本不用判断
        if [[ $searchRecordingName != $recordingName ]];then
            sed -i "s/recordingName.*/recordingName=$searchRecordingName/g" onekey.cfg
        fi

        cd /root/.NE/$searchRecordingName
        chmod +x *
        if [[ -f recording ]];then  # 可能核心网下发网元名字错误,没有recording启动文件的话
            ./recording stop
            ./recording status
        else
            ./recoding stop
            ./recoding status
        fi
	fi

}


function restartRecording(){
    echoN "重启recording>>>>>>>>>>"
    ## 0. 查recording网元名称
    searchRecordingName=`oamls | grep  recoding | grep -Eo  '[1-9][0-9]*-[0-9]'`  # 第一种查网元名称x-x
    if [[ $searchRecordingName == '' ]];then
        searchRecordingName=`oamls | grep  recoding | grep -Eo  '[1-9][0-9]*-[0-9]'` # 第二种查网元名称x-x
    fi

	if [[ $searchRecordingName == "" ]];then
        echoE "未找到recording安装路径"
    else
        ## 更新onekey.cfg 配置文件，以便下次脚本不用判断
        if [[ $searchRecordingName != $recordingName ]];then
            sed -i "s/recordingName.*/recordingName=$searchRecordingName/g" onekey.cfg
        fi

        cd /root/.NE/$searchRecordingName
        chmod +x *
        chmod +x *
        if [[ -f recording ]];then  # 可能核心网下发网元名字错误,没有recording启动文件的话
            ./recording restart
            ./recording status
        else
            ./recoding restart
            ./recoding status
        fi
	fi
	echoR "recording重启完成>>>>>>>>>>"
}


function updateRecording(){

    local startTime=$(date +%s)
	# 判断安装目录是否存在
	echoN "更新recording>>>>>"
#	1. oamcd recording 找，找不到，--》2  oamcd recording | grep -v "None matched" | wc -l
#	2. oamcd recoding 找，找不到--》3  oamcd recoding | grep -v "None matched" | wc -l
#	3. oamcd 17-1 找，找不到-->  oamcd 17-1 | grep -v "None matched" | wc -l
#	4. find /root/.NE -name recording* --> 找.NE目录, 截取/root/.NE/xx-x部分
#	recordingInstallPathSearchCommand1=`oamcd recording | grep -v "None matched" | wc -l`  # 这种方法不能100%查到
#	recordingInstallPathSearchCommand2=`oamcd recoding | grep -v "None matched" | wc -l`  # 这种方法不能100%查到
#	recordingInstallPathSearchCommand3=`oamcd $recordingName | grep -v "None matched" | wc -l` # oamcd 17-1不打印东西，直接检查目录

    ## 1. 替换默认配置文件，默认用oamcd,oamcd找不到，找配置文件recordingName=17-1 来找，确认能找的到
    # 判断是否存在
    if [[ -f "$recordingOfflineCfgPath" ]];then
		echoN 'recording 配置文件文件存在'
	else
		echoE 'recording 配置文件文件不存在，尝试自动检索配置文件。。。。。'
		# 给用户自动配置配置文件
		# 查看当前目录是否有配置文件
        if [[ -f "../icss/back/recording/application.properties" ]];then  # 存在配置文件
            echoN '检测到当前目录存在recording配置文件，是否更换？回车默认是什么不知道？'
            echoN '1. 是'
            echoN '2. 否'
            read -p "请输入序号： " userInputIfUpdateRecordingPath
            if [[ $userInputIfUpdateRecordingPath == "1" ]];then
                newRecordingPath=`pwd`/../icss/back/recording/application.properties
                echoN "recording新的配置文件路径== $newRecordingPath"
                echoN '当前路径==' `pwd`
                sed -i "s#recordingOfflineCfgPath.*#recordingOfflineCfgPath=$newRecordingPath#g" onekey.cfg
#                echoR '替换 recording新的配置文件路径完毕，需退出重新运行脚本！！'
#                exit
                recordingOfflineCfgPath=$newRecordingPath
                echoR '替换 recording新的配置文件路径完毕！！'
            fi
        else
		    echoE '未检测到存在配置文件，请修改配置recordingOfflineCfgPath'
            return 0
        fi
	fi

    ## 0. 查recording网元名称
    searchRecordingName=`oamls | grep  recoding | grep -Eo  '[1-9][0-9]*-[0-9]'`  # 第一种查网元名称x-x
    if [[ $searchRecordingName == '' ]];then
        searchRecordingName=`oamls | grep  recoding | grep -Eo  '[1-9][0-9]*-[0-9]'` # 第二种查网元名称x-x
    fi

    echoN "recording网元名称===== $searchRecordingName"
	if [[  $searchRecordingName == '' ]];then
		echoE 'recording 安装目录不存在，请查看是否安装'
		return 0
	else
		echoN 'recording 安装目录存在'
	fi

    ## 更新onekey.cfg 配置文件，以便下次脚本不用判断
    if [[ $searchRecordingName != $recordingName ]];then
        sed -i "s/recordingName.*/recordingName=$searchRecordingName/g" onekey.cfg
    fi
	## 2. 停掉服务
	stopRecording

    ## 3 拷贝自己写的默认文件，命令有可能不成功，使用完全可成功的命令
    cd /root/.NE/$searchRecordingName
    \cp $recordingOfflineCfgPath .

    ## 4. 修改配置文件
    echoN "替换内容 lzName>>>>>$lzName"
    echoN "替换内容 switchIp>>>>>$switchIp"
    echoN "替换内容 switchDbUsername>>>>>$switchDbUsername"
    echoN "替换内容 switchDbPassword>>>>>$switchDbPassword"
    echoN "替换内容 unitFirstLevelIp>>>>>$unitFirstLevelIp"
    echoN "替换内容 unitSecondLevelIp>>>>>$unitSecondLevelIp"
    echoN "替换内容 unitThirdLevelIp>>>>>$unitThirdLevelIp"
    echoN "替换内容 unitFourthLevelIp>>>>>$unitFourthLevelIp"
    echoN "替换内容 unitFifthLevelIp>>>>>$unitFifthLevelIp"
    echoN "替换内容 microIp>>>>>$microIp"
    echoN "替换内容 icssIp>>>>>$icssIp"
    echoN "替换内容 eurekaGroupServiceName>>>>>$eurekaGroupServiceName"
    echoN "替换内容 eurekaUserServiceName>>>>>$eurekaUserServiceName"
    echoN "替换内容 eurekaOrganizationServiceName>>>>>$eurekaOrganizationServiceName"

    sed -i "s/lzName/$lzName/g" application.properties
    sed -i "s/switchIp/$switchIp/g" application.properties
    sed -i "s/switchDbUsername/$switchDbUsername/g" application.properties
    sed -i "s/switchDbPassword/$switchDbPassword/g" application.properties
    sed -i "s/unitFirstLevelIp/$unitFirstLevelIp/g" application.properties
    sed -i "s/unitSecondLevelIp/$unitSecondLevelIp/g" application.properties
    sed -i "s/unitThirdLevelIp/$unitThirdLevelIp/g" application.properties
    sed -i "s/unitFourthLevelIp/$unitFourthLevelIp/g" application.properties
    sed -i "s/unitFifthLevelIp/$unitFifthLevelIp/g" application.properties

    sed -i "s/microIp/$microIp/g" application.properties
    sed -i "s/icssIp/$icssIp/g" application.properties
    sed -i "s/eurekaGroupServiceName/$eurekaGroupServiceName/g" application.properties
    sed -i "s/eurekaUserServiceName/$eurekaUserServiceName/g" application.properties
    sed -i "s/eurekaOrganizationServiceName/$eurekaOrganizationServiceName/g" application.properties

    ## 3. 重启
    restartRecording

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function offlineInstallCurl(){
    local startTime=$(date +%s)

    echoN '>>>>>>>>>>>>安装 curl'

	## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then
        # 拷贝libnss3.so ，libnssutil3.so 2个库，以防系统自身的命令 --》 rpm等也运行不了
        echoN "curl 安装，拷贝lib库。。。"
        #\cp $projectPath/installPackages/centos7/lib/lib64/* /lib64  # 这有问题，可能会导致系统库有什么问题，别轻易动系统lib库

        ## 0.配置如果没写，就走默认
        if [[ $curlOfflinePakagePath == "" || $curlOfflinePakagePath == " " ]];then
            echoN "curl 安装包 未配置~"
            echo "`(date +"%Y-%m-%d %H:%M:%S")` curl 安装包 未配置"  >> "$logfile/install-`(date +%Y%m%d)`.log"
            curlOfflinePakagePath="/home/2011/installPackages/centos7/curl/curl-7.47.0-offline.tar.gz"  # 默认
        fi
    elif [[ $systemVersion == 'kylin' ]];then
        ## 0.配置如果没写，就走默认
        if [[ $curlOfflinePakagePath == "" || $curlOfflinePakagePath == " " ]];then
            echoN "curl 安装包 未配置~"
            echo "`(date +"%Y-%m-%d %H:%M:%S")` curl 安装包 未配置"  >> "$logfile/install-`(date +%Y%m%d)`.log"
            curlOfflinePakagePath="/home/2011/installPackages/kylin/curl/curl-7.47.0-offline.tar.gz"  # 默认
        fi
    elif [[ $systemVersion == 'kylin-x86' ]];then
       # 拷贝libnss3.so ，libnssutil3.so 2个库，以防系统自身的命令 --》 rpm等也运行不了
        echoN "curl 安装，拷贝lib库。。。"
        #\cp $projectPath/installPackages/centos7/lib/lib64/* /lib64  # 这有问题，可能会导致系统库有什么问题，别轻易动系统lib库

        ## 0.配置如果没写，就走默认
        if [[ $curlOfflinePakagePath == "" || $curlOfflinePakagePath == " " ]];then
            echoN "curl 安装包 未配置~"
            echo "`(date +"%Y-%m-%d %H:%M:%S")` curl 安装包 未配置"  >> "$logfile/install-`(date +%Y%m%d)`.log"
            curlOfflinePakagePath="/home/2011/installPackages/centos7/curl/curl-7.47.0-offline.tar.gz"  # 默认
        fi
	fi

	## 1. 判断配置文件是否正确
	# 判断安装文件路径是否存在
	if [[ -f "$curlOfflinePakagePath" ]];then
		echoN 'curl 安装文件文件存在'
	else
		echoE 'curl 安装文件不存在，请查看配置 curlOfflinePakagePath'
		echo "`(date +"%Y-%m-%d %H:%M:%S")` curl 安装文件不存在，请查看配置 curlOfflinePakagePath"  >> "$logfile/install-`(date +%Y%m%d)`.log"
		return 0
	fi

	## 2. 删除已有安装包,默认/usr/local
	cd /usr/local
	rm -rf curl-7.47.0

	## 3. 判断安装包类型，解压到配置文件写的路径,默认装到/usr/local目录
	unzipFile $curlOfflinePakagePath /usr/local

	## 3.1 拷贝 启动命令
	if [[ $systemVersion == 'centos7' ]];then
	    \cp $projectPath/installPackages/centos7/curl/bin/* /usr/local/bin/
	    \cp $projectPath/installPackages/centos7/curl/bin/* /usr/bin/
        echo "centos7系统"
	elif [[ $systemVersion == 'kylin' ]];then
	    echo "kylin系统"
	    \cp $projectPath/installPackages/kylin/curl/bin/* /usr/local/bin/
    elif [[ $systemVersion == 'kylin-x86' ]];then
	    \cp $projectPath/installPackages/kylin-x86/curl/bin/* /usr/local/bin/
	    \cp $projectPath/installPackages/kylin-x86/curl/bin/* /usr/bin/
	fi

	## 5. 加权限，nginx & 系统自启动文件,多加权限-保证至少安装无问题！
	chmod +x /usr/local/bin/curl*
	chmod 777 /usr/local/bin/curl*

	## 8. 检测是否安装成功(检查目录)
	if [[ -d "/usr/local/curl-7.47.0" ]];then
		echoR 'curl 安装后的文件夹已存在，安装成功！'
	else
		echoE 'curl 安装后的文件夹不存在，安装失败！'
		echo "`(date +"%Y-%m-%d %H:%M:%S")` curl 安装后的文件夹不存在，安装失败！"  >> "$logfile/install-`(date +%Y%m%d)`.log"
	fi

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function closeVirbr0(){

    local startTime=$(date +%s)
    ## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then
        #把virbr0 开机自动关闭，否则影响kms与核心网ip建立连接
        echoN "centos7 关闭 虚拟网卡"
        ifconfig virbr0 down
            #删除网卡,需要先down
        brctl delbr virbr0
            #关闭服务
        systemctl disable libvirtd.service
    elif [[ $systemVersion == 'kylin' ]];then
	    echoN "kylin暂时先不关闭 虚拟网卡"
    elif [[ $systemVersion == 'kylin-x86' ]];then
	    #把virbr0 开机自动关闭，否则影响kms与核心网ip建立连接
        echoN "centos7 关闭 虚拟网卡"
        ifconfig virbr0 down
            #删除网卡,需要先down
        brctl delbr virbr0
            #关闭服务
        systemctl disable libvirtd.service
    elif [[ $systemVersion == 'centos8' ]];then
	    #把virbr0 开机自动关闭，否则影响kms与核心网ip建立连接
        echoN "centos8 关闭 虚拟网卡"
        ifconfig virbr0 down
        #删除网卡,需要先down
        # brctl delbr virbr0 报错
        #关闭服务
        systemctl stop libvirtd.service
        systemctl disable libvirtd.service
	fi
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function installMyshell(){
    local startTime=$(date +%s)
    ## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then
        echoN "centos7 安装自定义命令"
        #在 ~/.bashrc 里添如下内容
        #if [ -f /opt/preject/installPackages/shell/myshell ]; then
        #            chmod +x /opt/preject/installPackages/shell/myshell
        #            . /opt/preject/installPackages/shell/myshell
        #fi #myshell
        \cp $projectPath/installPackages/myshell/.myshell /root
        echo "删除旧的数据，保证配置不重复"
        sed -i "/.myshell/"d ~/.bashrc
        sed -i "/myshell/"d ~/.bashrc

        echo "修改 /root/.bashrc 配置"
        #在文件末尾写入
        sed -i '$a\if [ -f /root/.myshell ]; then' ~/.bashrc
        sed -i '$a\chmod +x /root/.myshell' ~/.bashrc
        sed -i '$a\ . /root/.myshell' ~/.bashrc
        sed -i '$a\fi #myshell' ~/.bashrc
        sleep 2
        chmod +x ~/.bashrc
        source ~/.bashrc

    elif [[ $systemVersion == 'kylin' ]];then
	    echoN "kylin 安装自定义命令"
	    \cp $projectPath/installPackages/myshell/.myshell /root
        echo "删除旧的数据，保证配置不重复"
        sed -i "/.myshell/"d ~/.bashrc
        sed -i "/myshell/"d ~/.bashrc

        echo "修改 /root/.bashrc 配置"
        #在文件默认写入
        sed -i '$a\if [ -f /root/.myshell ]; then' ~/.bashrc
        sed -i '$a\chmod +x /root/.myshell' ~/.bashrc
        sed -i '$a\ . /root/.myshell' ~/.bashrc
        sed -i '$a\fi #myshell' ~/.bashrc

        sleep 2
        chmod +x ~/.bashrc
        source ~/.bashrc
    elif [[ $systemVersion == 'kylin-x86' ]];then
        echoN "centos7 安装自定义命令"
        #在 ~/.bashrc 里添如下内容
        #if [ -f /opt/preject/installPackages/shell/myshell ]; then
        #            chmod +x /opt/preject/installPackages/shell/myshell
        #            . /opt/preject/installPackages/shell/myshell
        #fi #myshell
        \cp $projectPath/installPackages/myshell/.myshell /root
        echo "删除旧的数据，保证配置不重复"
        sed -i "/.myshell/"d ~/.bashrc
        sed -i "/myshell/"d ~/.bashrc

        echo "修改 /root/.bashrc 配置"
        #在文件末尾写入
        sed -i '$a\if [ -f /root/.myshell ]; then' ~/.bashrc
        sed -i '$a\chmod +x /root/.myshell' ~/.bashrc
        sed -i '$a\ . /root/.myshell' ~/.bashrc
        sed -i '$a\fi #myshell' ~/.bashrc
        sleep 2
        chmod +x ~/.bashrc
        source ~/.bashrc
    elif [[ $systemVersion == 'centos8' ]];then
        echoN "centos8 安装自定义命令"
        #在 ~/.bashrc 里添如下内容
        #if [ -f /opt/preject/installPackages/shell/myshell ]; then
        #            chmod +x /opt/preject/installPackages/shell/myshell
        #            . /opt/preject/installPackages/shell/myshell
        #fi #myshell
        \cp $projectPath/installPackages/myshell/.myshell /root
        echo "删除旧的数据，保证配置不重复"
        sed -i "/.myshell/"d ~/.bashrc
        sed -i "/myshell/"d ~/.bashrc

        echo "修改 /root/.bashrc 配置"
        #在文件末尾写入
        sed -i '$a\if [ -f /root/.myshell ]; then' ~/.bashrc
        sed -i '$a\chmod +x /root/.myshell' ~/.bashrc
        sed -i '$a\ . /root/.myshell' ~/.bashrc
        sed -i '$a\fi #myshell' ~/.bashrc
        sleep 2
        chmod +x ~/.bashrc
        source ~/.bashrc
	fi

    echoN "完毕！"
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function offlineInstallJq(){
    local startTime=$(date +%s)

    echoN '>>>>>>>>>>>>安装 jq'

	## 1. 判断配置文件是否正确
	# 判断安装文件路径是否存在
	if [[ -f "$jqOfflinePakagePath" ]];then
		echoN 'jq 安装文件文件存在'
	else
		echoE 'jq 安装文件不存在，请查看配置 jqOfflinePakagePath'
		echo "`(date +"%Y-%m-%d %H:%M:%S")` jq 安装文件不存在，请查看配置 jqOfflinePakagePath"  >> "$logfile/install-`(date +%Y%m%d)`.log"
		return 0
	fi

	## 2. 删除已有安装包,默认/usr/local
	cd /usr/local
	rm -rf jq-1.5

	## 3. 判断安装包类型，解压到配置文件写的路径,默认装到/usr/local目录
	unzipFile $jqOfflinePakagePath /usr/local

	## 如果是c7系统,
	if [[ $systemVersion == 'centos7' ]];then
        ## 3.1 拷贝 启动命令
	    \cp $projectPath/installPackages/centos7/jq/bin/* /usr/local/bin/
    elif [[ $systemVersion == 'kylin' ]];then
        ## 3.1 拷贝 启动命令
	    \cp $projectPath/installPackages/kylin/jq/bin/* /usr/local/bin/
    elif [[ $systemVersion == 'kylin-x86' ]];then
        ## 3.1 拷贝 启动命令
	    \cp $projectPath/installPackages/kylin-x86/jq/bin/* /usr/local/bin/
	fi

	## 5. 加权限，nginx & 系统自启动文件,多加权限-保证至少安装无问题！
	chmod +x /usr/local/bin/jq*
	chmod 777 /usr/local/bin/jq*

	## 8. 检测是否安装成功(检查目录)
	if [[ -d "/usr/local/jq-1.5" ]];then
		echoR 'jq 安装后的文件夹已存在，安装成功！'
	else
		echoE 'jq 安装后的文件夹不存在，安装失败！'
		echo "`(date +"%Y-%m-%d %H:%M:%S")` jq 安装后的文件夹不存在，安装失败！"  >> "$logfile/install-`(date +%Y%m%d)`.log"
	fi

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function autoInstall(){
    autoInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
    sys_autoInstallStartTime=$(date -d "$autoInstallStartTime" +%s)

    echo "`(date +"%Y-%m-%d %H:%M:%S")` 自动安装 》》》》》》》》》》》》》》 start"  >> "$logfile/install-`(date +%Y%m%d)`.log"

    echoN "一键安装 》》》》》》"
    echoN "用户配置本机安装 == $preInstallService"
    echoN "检查本机是否有赋予空间.........."
    lastMem=`df -h /home | awk '{print $4}' | grep G | grep -Eo "[0-9]*"`
    echoN "/home剩余空间= ${lastMem}G"

    if [[ "$lastMem" -lt 7 ]];then
        echoE "/home剩余空间不足7G，请删除多余文件后，继续运行脚本！！ 后续会优化"
    fi

    closeSelinux  # 自动关闭selinux
    installJDK # 自动安装java

    if [ "$projectName" == "2011" ];then
        case $preInstallService in
        1)
            echoN "用户配置本机安装 == 所有（不带核心网）"
            echoN '>>>>>>>>>>>>装基础软件'
            onekeyInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
            # 给项目自动创建文件夹
            crateProjectFolder
    #        1. 安装nginx
    #        2. 安装emqx
    #        3. 安装redis
    #        4. 安装地图
    #        5. 安装mysql
    #        6. 安装oam
    #        7. 配置hosts
    #        8. 安装调度台前端
    #        9. 安装调度台后台
    #        10. 初始化mysql
    #        11. 安装自启动
    #        12. 编译KMS
    #        13. 安装网管前端
    #        14. 安装网管后台
    #        15. 安装微服务
    #        16. 安装网管gateway
    #        17. 安装 tcpdump
    #        20. 离线安装KMS
    #        21. 离线安装curl(模拟消息)
    #        22. 离线安装jq(解析json)
            offlineInstallSwitchCommonLib
            disableFirewalld
            closeVirbr0
            offlineInstallCurl
            offlineInstallJq
            offlineInstallFtp

            installNginx
            installEmqx
            installEmqxBridge
            installRedis
            installGooglemap
            installMysql
            initMysql
            installOamUpdateByCfg
            installHosts
            installRclocal
            installTcpdump
            offlineInstallKms
            installMicroUpdateByCfg

            # 装网管 给项目自动创建文件夹
            echoN '>>>>>>>>>>>>装网管软件'
            crateProjectFolder
            installGatewayUpdateByCfg
            installNmsFrontUpdateByCfg
            installNmsBackUpdateByCfg

            echoN '>>>>>>>>>>>>装调度软件'
            # 装网管，给项目自动创建文件夹
            crateProjectFolder
            installDispFrontUpdateByCfg
            installDispBackUpdateByCfg

            offlineInstallEmqxWatchLog

            #打印时间
            onekeyInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
            onekeyInstallTimeSup=`expr $onekeyInstallEndTime - $onekeyInstallStartTime`
            colorEcho "安装所有（不带核心网）,用时:" $nomal_info $onekeyInstallTimeSup "秒"

            ;;
        2)
            echoN "用户配置本机安装 == 微服务"
            echoN '>>>>>>>>>>>>装微服务软件'
            onekeyInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
            # 给项目自动创建文件夹
            offlineInstallSwitchCommonLib
            crateProjectFolder
    #        1. 安装nginx
    #        2. 安装emqx
    #        3. 安装redis
    #        4. 安装地图
    #        5. 安装mysql
    #        6. 安装oam
    #        7. 配置hosts
    #        8. 安装调度台前端
    #        9. 安装调度台后台
    #        10. 初始化mysql
    #        11. 安装自启动
    #        12. 编译KMS
    #        13. 安装网管前端
    #        14. 安装网管后台
    #        15. 安装微服务
    #        16. 安装网管gateway
    #        17. 安装 tcpdump
    #        20. 离线安装KMS
    #        21. 离线安装curl(模拟消息)
    #        22. 离线安装jq(解析json)
            disableFirewalld
            closeVirbr0
            offlineInstallCurl
            offlineInstallJq
            offlineInstallFtp

            installNginx
            installEmqx
            installEmqxBridge
            installRedis
            installGooglemap
    #        installMysql
    #        initMysql
            installOamUpdateByCfg
            installHosts
            installRclocal  # 应该可用自动配置哪些自启动
            installTcpdump
    #        offlineInstallKms
            installMicroUpdateByCfg

            echoN '>>>>>>>>>>>>装网管前端'
            # 装网管，给项目自动创建文件夹
            crateProjectFolder
            installNmsFrontUpdateByCfg

            offlineInstallEmqxWatchLog
            #打印时间
            onekeyInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
            onekeyInstallTimeSup=`expr $onekeyInstallEndTime - $onekeyInstallStartTime`
            colorEcho "用时:" $nomal_info $onekeyInstallTimeSup "秒"
            ;;
        3)
            echoN "用户配置本机安装 == 网管"
            echoN '>>>>>>>>>>>>装网管软件'
            onekeyInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
            offlineInstallSwitchCommonLib
            # 给项目自动创建文件夹
            crateProjectFolder
    #        1. 安装nginx
    #        2. 安装emqx
    #        3. 安装redis
    #        4. 安装地图
    #        5. 安装mysql
    #        6. 安装oam
    #        7. 配置hosts
    #        8. 安装调度台前端
    #        9. 安装调度台后台
    #        10. 初始化mysql
    #        11. 安装自启动
    #        12. 编译KMS
    #        13. 安装网管前端
    #        14. 安装网管后台
    #        15. 安装微服务
    #        16. 安装网管gateway
    #        17. 安装 tcpdump
    #        20. 离线安装KMS
    #        21. 离线安装curl(模拟消息)
    #        22. 离线安装jq(解析json)
            disableFirewalld
            closeVirbr0
            offlineInstallCurl
            offlineInstallJq
            offlineInstallFtp

    #        installNginx
    #        installEmqx
    #        installEmqxBridge
    #        installRedis
    #        installGooglemap
            installMysql
            initMysql
    #        installOamUpdateByCfg
            installHosts
            installRclocal  # 应该可用自动配置哪些自启动
            installTcpdump
    #        offlineInstallKms
    #        installMicroUpdateByCfg

            echoN '>>>>>>>>>>>>装网管软件'
            crateProjectFolder
            installGatewayUpdateByCfg
            installNmsFrontUpdateByCfg
            installNmsBackUpdateByCfg

            ## 自动清除网管和核心网数据库
            echoN '>>>>>>>>>>>>自动清除网管和核心网数据库'
            deleteDataNms
            deleteDataSwitch

            ## 自动更改网管默认数据库 arm 和omc代理数据库配置

            #打印时间
            onekeyInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
            onekeyInstallTimeSup=`expr $onekeyInstallEndTime - $onekeyInstallStartTime`
            colorEcho "用时:" $nomal_info $onekeyInstallTimeSup "秒"
            ;;
        4)
            echoN "用户配置本机安装 == 调度"
            echoN '>>>>>>>>>>>>装调度软件'
            onekeyInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
            offlineInstallSwitchCommonLib
            # 给项目自动创建文件夹
            crateProjectFolder
    #        1. 安装nginx
    #        2. 安装emqx
    #        3. 安装redis
    #        4. 安装地图
    #        5. 安装mysql
    #        6. 安装oam
    #        7. 配置hosts
    #        8. 安装调度台前端
    #        9. 安装调度台后台
    #        10. 初始化mysql
    #        11. 安装自启动
    #        12. 编译KMS
    #        13. 安装网管前端
    #        14. 安装网管后台
    #        15. 安装微服务
    #        16. 安装网管gateway
    #        17. 安装 tcpdump
    #        20. 离线安装KMS
    #        21. 离线安装curl(模拟消息)
    #        22. 离线安装jq(解析json)
            disableFirewalld
            closeVirbr0
            offlineInstallCurl
            offlineInstallJq
            offlineInstallFtp

            installNginx
    #        installEmqx
    #        installEmqxBridge
    #        installRedis
            installGooglemap
            installMysql
            initMysql
            installOamUpdateByCfg
            installHosts
            installRclocal
            installTcpdump
            offlineInstallKms
    #        installMicroUpdateByCfg
            closeVirbr0  # 关闭虚拟网卡，否则调度没声音

            # 装调度 给项目自动创建文件夹
            echoN '>>>>>>>>>>>>装调度软件'
            crateProjectFolder
            installDispFrontUpdateByCfg
            installDispBackUpdateByCfg

            #打印时间
            onekeyInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
            onekeyInstallTimeSup=`expr $onekeyInstallEndTime - $onekeyInstallStartTime`
            colorEcho "用时:" $nomal_info $onekeyInstallTimeSup "秒"
            ;;
        5)
            echoN "用户配置本机安装 == 微服务+网管"
            echoN '>>>>>>>>>>>>微服务+网管'
            onekeyInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
            offlineInstallSwitchCommonLib
            # 给项目自动创建文件夹
            crateProjectFolder
    #        1. 安装nginx
    #        2. 安装emqx
    #        3. 安装redis
    #        4. 安装地图
    #        5. 安装mysql
    #        6. 安装oam
    #        7. 配置hosts
    #        8. 安装调度台前端
    #        9. 安装调度台后台
    #        10. 初始化mysql
    #        11. 安装自启动
    #        12. 编译KMS
    #        13. 安装网管前端
    #        14. 安装网管后台
    #        15. 安装微服务
    #        16. 安装网管gateway
    #        17. 安装 tcpdump
    #        20. 离线安装KMS
    #        21. 离线安装curl(模拟消息)
    #        22. 离线安装jq(解析json)
            disableFirewalld
            closeVirbr0
            offlineInstallCurl
            offlineInstallJq
            offlineInstallFtp

            installNginx
            installEmqx
            installEmqxBridge
            installRedis
            installGooglemap
            installMysql
            initMysql
            installOamUpdateByCfg
            installHosts
            installRclocal
            installTcpdump
            offlineInstallKms
            echoN '>>>>>>>>>>>>装微服务'
            installMicroUpdateByCfg

            # 装网管 给项目自动创建文件夹
            echoN '>>>>>>>>>>>>装网管软件'
            crateProjectFolder
            installGatewayUpdateByCfg
            installNmsFrontUpdateByCfg
            installNmsBackUpdateByCfg

            offlineInstallEmqxWatchLog

            #打印时间
            onekeyInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
            onekeyInstallTimeSup=`expr $onekeyInstallEndTime - $onekeyInstallStartTime`
            colorEcho "用时:" $nomal_info $onekeyInstallTimeSup "秒"
            ;;
        6)
            echoN "用户配置本机安装 == 核心网"
            echoN '>>>>>>>>>>>>核心网'
            onekeyInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
            # 给项目自动创建文件夹
            offlineInstallSwitchCommonLib
            crateProjectFolder
    #        1. 安装nginx
    #        2. 安装emqx
    #        3. 安装redis
    #        4. 安装地图
    #        5. 安装mysql
    #        6. 安装oam
    #        7. 配置hosts
    #        8. 安装调度台前端
    #        9. 安装调度台后台
    #        10. 初始化mysql
    #        11. 安装自启动
    #        12. 编译KMS
    #        13. 安装网管前端
    #        14. 安装网管后台
    #        15. 安装微服务
    #        16. 安装网管gateway
    #        17. 安装 tcpdump
    #        20. 离线安装KMS
    #        21. 离线安装curl(模拟消息)
    #        22. 离线安装jq(解析json)
            disableFirewalld
            closeVirbr0
            offlineInstallCurl
            offlineInstallJq
            offlineInstallFtp

    #        installNginx
    #        installEmqx
    #        installRedis
    #        installEmqxBridge
    #        installGooglemap
            installMysql
            initMysql
            installOamUpdateByCfg
            installHosts
            installRclocal
            installTcpdump
    #        offlineInstallKms
    #        echoN '>>>>>>>>>>>>装微服务'
    #        installMicroUpdateByCfg

            # 装网管 给项目自动创建文件夹
    #        echoN '>>>>>>>>>>>>装网管软件'
            crateProjectFolder
    #        installGatewayUpdateByCfg
    #        installNmsFront
    #        installNmsBack
            echoN '>>>>>>>>>>>>装核心网'
            offlineInstallBind
            offlineInstallSwitch

            #打印时间
            onekeyInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
            onekeyInstallTimeSup=`expr $onekeyInstallEndTime - $onekeyInstallStartTime`
            colorEcho "用时:" $nomal_info $onekeyInstallTimeSup "秒"
            ;;
        7)
            echoN "用户配置本机安装 == 核心网+调度"
            echoN '>>>>>>>>>>>>装核心网+调度'
            onekeyInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
            offlineInstallSwitchCommonLib
            # 给项目自动创建文件夹
            crateProjectFolder
    #        1. 安装nginx
    #        2. 安装emqx
    #        3. 安装redis
    #        4. 安装地图
    #        5. 安装mysql
    #        6. 安装oam
    #        7. 配置hosts
    #        8. 安装调度台前端
    #        9. 安装调度台后台
    #        10. 初始化mysql
    #        11. 安装自启动
    #        12. 编译KMS
    #        13. 安装网管前端
    #        14. 安装网管后台
    #        15. 安装微服务
    #        16. 安装网管gateway
    #        17. 安装 tcpdump
    #        20. 离线安装KMS
    #        21. 离线安装curl(模拟消息)
    #        22. 离线安装jq(解析json)
            disableFirewalld
            closeVirbr0
            offlineInstallCurl
            offlineInstallJq
            offlineInstallFtp

            installNginx
    #        installEmqx
    #        installRedis
    #        installEmqxBridge
            installGooglemap
            installMysql
            initMysql
            installOamUpdateByCfg
            installHosts
            installRclocal
            installTcpdump
            offlineInstallKms
    #        installMicroUpdateByCfg
            closeVirbr0  # 关闭虚拟网卡，否则调度没声音

            # 装调度 给项目自动创建文件夹
            echoN '>>>>>>>>>>>>装调度软件'
            crateProjectFolder
            installDispFrontUpdateByCfg
            installDispBackUpdateByCfg

            echoN '>>>>>>>>>>>>装核心网'
            offlineInstallBind
            offlineInstallSwitch

            #打印时间
            onekeyInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
            onekeyInstallTimeSup=`expr $onekeyInstallEndTime - $onekeyInstallStartTime`
            colorEcho "用时:" $nomal_info $onekeyInstallTimeSup "秒"
            ;;
        8)
            echoN "用户配置本机安装 == 核心网+调度+微服务+网管"
            echoN '>>>>>>>>>>>>装基础软件'
            onekeyInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
            offlineInstallSwitchCommonLib
            # 给项目自动创建文件夹
            crateProjectFolder
    #        1. 安装nginx
    #        2. 安装emqx
    #        3. 安装redis
    #        4. 安装地图
    #        5. 安装mysql
    #        6. 安装oam
    #        7. 配置hosts
    #        8. 安装调度台前端
    #        9. 安装调度台后台
    #        10. 初始化mysql
    #        11. 安装自启动
    #        12. 编译KMS
    #        13. 安装网管前端
    #        14. 安装网管后台
    #        15. 安装微服务
    #        16. 安装网管gateway
    #        17. 安装 tcpdump
    #        20. 离线安装KMS
    #        21. 离线安装curl(模拟消息)
    #        22. 离线安装jq(解析json)
            disableFirewalld
            closeVirbr0
            offlineInstallCurl
            offlineInstallJq
            offlineInstallFtp

            installNginx
            installEmqx
            installEmqxBridge
            installRedis
            installGooglemap
            installMysql
            initMysql
            installOamUpdateByCfg
            installHosts
            installRclocal
            installTcpdump
            offlineInstallKms
            installMicroUpdateByCfg

            # 装网管 给项目自动创建文件夹
            echoN '>>>>>>>>>>>>装网管软件'
            crateProjectFolder
            installGatewayUpdateByCfg
            installNmsFrontUpdateByCfg
            installNmsBackUpdateByCfg

            echoN '>>>>>>>>>>>>装调度软件'
            # 装网管，给项目自动创建文件夹
            crateProjectFolder
            installDispFrontUpdateByCfg
            installDispBackUpdateByCfg


            echoN '>>>>>>>>>>>>装核心网'
            offlineInstallBind
            offlineInstallSwitch

            #打印时间
            onekeyInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
            onekeyInstallTimeSup=`expr $onekeyInstallEndTime - $onekeyInstallStartTime`
            colorEcho "用时:" $nomal_info $onekeyInstallTimeSup "秒"
            ;;
        9)
            echoN "用户配置本机安装 == 区交基站网关"
            echoN '>>>>>>>>>>>>装基础软件'
            onekeyInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
            offlineInstallSwitchCommonLib
            # 给项目自动创建文件夹
            crateProjectFolder
    #        1. 安装nginx
    #        2. 安装emqx
    #        3. 安装redis
    #        4. 安装地图
    #        5. 安装mysql
    #        6. 安装oam
    #        7. 配置hosts
    #        8. 安装调度台前端
    #        9. 安装调度台后台
    #        10. 初始化mysql
    #        11. 安装自启动
    #        12. 编译KMS
    #        13. 安装网管前端
    #        14. 安装网管后台
    #        15. 安装微服务
    #        16. 安装网管gateway
    #        17. 安装 tcpdump
    #        20. 离线安装KMS
    #        21. 离线安装curl(模拟消息)
    #        22. 离线安装jq(解析json)
            disableFirewalld
            closeVirbr0
            offlineInstallCurl
            offlineInstallJq
            offlineInstallFtp

    #        installNginx
    #        installEmqx
    #        installEmqxBridge
    #        installRedis
    #        installGooglemap
            installMysql
            initMysql
            installOamUpdateByCfg
            installHosts
            installRclocal
            installTcpdump
    #        offlineInstallKms
    #        installMicroUpdateByCfg
            offlineInstallTomcat

            echoN '>>>>>>>>>>>>装核心网相关软件'
            offlineInstallBind
            offlineInstallSwitchCommonLib

            # 安装区交基站网关
            installAreaSwitchGateway

            # ne目录加权限
            addPrivilegesNE

            #打印时间
            onekeyInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
            onekeyInstallTimeSup=`expr $onekeyInstallEndTime - $onekeyInstallStartTime`
            colorEcho "用时:" $nomal_info $onekeyInstallTimeSup "秒"
            ;;
        10)
            echoN "用户配置本机安装 == 移交基站网关"
            echoN '>>>>>>>>>>>>装基础软件'
            onekeyInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
            offlineInstallSwitchCommonLib
            # 给项目自动创建文件夹
            crateProjectFolder
    #        1. 安装nginx
    #        2. 安装emqx
    #        3. 安装redis
    #        4. 安装地图
    #        5. 安装mysql
    #        6. 安装oam
    #        7. 配置hosts
    #        8. 安装调度台前端
    #        9. 安装调度台后台
    #        10. 初始化mysql
    #        11. 安装自启动
    #        12. 编译KMS
    #        13. 安装网管前端
    #        14. 安装网管后台
    #        15. 安装微服务
    #        16. 安装网管gateway
    #        17. 安装 tcpdump
    #        20. 离线安装KMS
    #        21. 离线安装curl(模拟消息)
    #        22. 离线安装jq(解析json)
            disableFirewalld
            closeVirbr0
            offlineInstallCurl
            offlineInstallJq
            offlineInstallFtp

    #        installNginx
    #        installEmqx
    #        installEmqxBridge
    #        installRedis
    #        installGooglemap
            installMysql
            initMysql
            installOamUpdateByCfg
            installHosts
            installRclocal
            installTcpdump
    #        offlineInstallKms
    #        installMicroUpdateByCfg
            offlineInstallTomcat

            # ne目录加权限
            addPrivilegesNE

            echoN '>>>>>>>>>>>>装核心网相关软件'
            offlineInstallBind
            offlineInstallSwitchCommonLib

            # 安装移交基站网关
            installMobileSwitchGateway

            #打印时间
            onekeyInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
            onekeyInstallTimeSup=`expr $onekeyInstallEndTime - $onekeyInstallStartTime`
            colorEcho "用时:" $nomal_info $onekeyInstallTimeSup "秒"
            ;;
        esac
    fi

    if [ "$projectName" == "aj" ];then
        case $preInstallService in
        1)
            echoN "用户配置本机安装 == aj 网管"
            echoN '>>>>>>>>>>>>aj 网管'
            onekeyInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
            # 给项目自动创建文件夹
            crateProjectFolder
    #        1. 安装nginx
    #        2. 安装emqx
    #        3. 安装redis
    #        4. 安装地图
    #        5. 安装mysql
    #        6. 安装oam
    #        7. 配置hosts
    #        8. 安装调度台前端
    #        9. 安装调度台后台
    #        10. 初始化mysql
    #        11. 安装自启动
    #        12. 编译KMS
    #        13. 安装网管前端
    #        14. 安装网管后台
    #        15. 安装微服务
    #        16. 安装网管gateway
    #        17. 安装 tcpdump
    #        20. 离线安装KMS
    #        21. 离线安装curl(模拟消息)
    #        22. 离线安装jq(解析json)
            offlineInstallSwitchCommonLib
            disableFirewalld
            closeVirbr0
            offlineInstallCurl
            offlineInstallJq
#            offlineInstallFtp

            installNginx
            installEmqx
#            installEmqxBridge
            installRedis
            installGooglemap
            installMysql
            initMysql
            installOamUpdateByCfg
            installHosts
            installRclocal
#            installTcpdump
#            offlineInstallKms
            installMicroUpdateByCfg

            # 装网管 给项目自动创建文件夹
            echoN '>>>>>>>>>>>>装网管软件'
            installGatewayUpdateByCfg
            installNmsFrontUpdateByCfg
            installNmsBackUpdateByCfg

            echoN '>>>>>>>>>>>>装调度软件'
            # 装网管，给项目自动创建文件夹
            installDispBackUpdateByCfg

#            offlineInstallEmqxWatchLog

            #打印时间
            onekeyInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
            onekeyInstallTimeSup=`expr $onekeyInstallEndTime - $onekeyInstallStartTime`
            colorEcho "安装所有（不带核心网）,用时:" $nomal_info $onekeyInstallTimeSup "秒"
            ;;
        2)
            echoN "用户配置本机安装 机动式"
            echoN '>>>>>>>>>>>>装 机动式'
            onekeyInstallStartTime=$(date +"%Y-%m-%d %H:%M:%S")
            # 给项目自动创建文件夹
            crateProjectFolder
    #        1. 安装nginx
    #        2. 安装emqx
    #        3. 安装redis
    #        4. 安装地图
    #        5. 安装mysql
    #        6. 安装oam
    #        7. 配置hosts
    #        8. 安装调度台前端
    #        9. 安装调度台后台
    #        10. 初始化mysql
    #        11. 安装自启动
    #        12. 编译KMS
    #        13. 安装网管前端
    #        14. 安装网管后台
    #        15. 安装微服务
    #        16. 安装网管gateway
    #        17. 安装 tcpdump
    #        20. 离线安装KMS
    #        21. 离线安装curl(模拟消息)
    #        22. 离线安装jq(解析json)
#            offlineInstallSwitchCommonLib
            disableFirewalld
#            closeVirbr0
            offlineInstallCurl
            offlineInstallJq
#            offlineInstallFtp

#            installNginx
#            installEmqx
#            installEmqxBridge
            installRedis
#            installGooglemap
#            installMysql
#            initMysql
#            installOamUpdateByCfg
#            installHosts
#            installRclocal
#            installTcpdump
#            offlineInstallKms
#            installMicroUpdateByCfg

            # 装网管 给项目自动创建文件夹
            echoN '>>>>>>>>>>>>装网管软件'
#            installGatewayUpdateByCfg
#            installNmsFrontUpdateByCfg
            installNmsBackJdsUpdateByCfg
            jdsSetRedisLocation

            echoN '>>>>>>>>>>>>装调度软件'
            # 装网管，给项目自动创建文件夹
#            installDispBackUpdateByCfg

#            offlineInstallEmqxWatchLog

            #打印时间
            onekeyInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
            onekeyInstallTimeSup=`expr $onekeyInstallEndTime - $onekeyInstallStartTime`
            colorEcho "安装所有（不带核心网）,用时:" $nomal_info $onekeyInstallTimeSup "秒"
            ;;
        esac
    fi


    autoInstallEndTime=$(date +"%Y-%m-%d %H:%M:%S")
    sys_autoInstallEndTime=$(date -d "$autoInstallEndTime" +%s)
	autoInstallTimeSup=`expr $sys_autoInstallEndTime - $sys_autoInstallStartTime`
	colorEcho "自动安装总用时:" $nomal_info $autoInstallTimeSup "秒"

	echoR "一键安装完成，请重新运行脚本，执行 6. 一键启动命令"
}

function autoStart(){
    local startTime=$(date +%s)
    echoN "一键启动 》》》》》》"
    # 考虑其它服务启动情况
    if [ "$projectName" == "2011"  ];then
        if [[ $systemVersion == 'centos7' ]];then
        case $preInstallService in
        1) # 所有
                echoN "进入所有"
                systemctl restart nginx
#                systemctl restart emqx
                restartEmqx
                restartEmqxBridge
                systemctl restart redis
                systemctl stop mysql
                systemctl start mysql
                systemctl restart docker

                startEmqx # 启动emqx 保证能起来
            ;;
        2) # 微服务
                systemctl restart nginx
#                systemctl restart emqx
                restartEmqx
                restartEmqxBridge
                systemctl start redis
                systemctl stop mysql
                systemctl stop docker
                startEmqx # 启动emqx 保证能起来
            ;;
        3) # 网管
                #网管
                systemctl stop nginx
#                systemctl stop emqx
                restartEmqx
                restartEmqxBridge
                systemctl stop redis
                systemctl restart mysql
                systemctl stop docker
                startEmqx # 启动emqx 保证能起来
            ;;
        4) # 调度
                #调度 - 连微服务的redis
                systemctl restart nginx
#                systemctl stop emqx
                restartEmqx
                restartEmqxBridge
                systemctl stop redis
                systemctl restart mysql
                systemctl restart docker
                startEmqx # 启动emqx 保证能起来
            ;;
        5) # 微服务+网管isUnitidHighest
                #微服务+网管
                systemctl restart nginx
#                systemctl restart emqx
                restartEmqx
                restartEmqxBridge
                systemctl restart redis
                systemctl restart mysql
                systemctl restart docker
                startEmqx # 启动emqx 保证能起来
            ;;
        6) # 核心网 isUnitidHighest
                #核心网
#                systemctl restart nginx
#                systemctl restart emqx
#                restartEmqx
#                systemctl restart redis
                systemctl restart mysql
#                systemctl restart docker
#                startEmqx # 启动emqx 保证能起来
            ;;
        7) # 核心网+调度 isUnitidHighest
                #核心网+调度
                systemctl restart nginx
#                systemctl restart emqx
                restartEmqx
                restartEmqxBridge
                systemctl restart redis
                systemctl restart mysql
                systemctl restart docker
                startEmqx # 启动emqx 保证能起来
            ;;
        8) # 核心网+调度+微服务+网管 isUnitidHighest
                #核心网+调度+微服务+网管
                systemctl restart nginx
#                systemctl restart emqx
                restartEmqx
                restartEmqxBridge
                systemctl restart redis
                systemctl restart mysql
                systemctl restart docker
                startEmqx # 启动emqx 保证能起来
            ;;
        9) # 区交基站网关 isUnitidHighest
                #区交基站网关
#                systemctl restart nginx
#                systemctl restart emqx
#                restartEmqx
#                systemctl restart redis
                systemctl restart mysql
#                systemctl restart docker
#                startEmqx # 启动emqx 保证能起来
            ;;
        10) # 移交基站网关 isUnitidHighest
                #移交基站网关
#                systemctl restart nginx
#                systemctl restart emqx
#                restartEmqx
#                systemctl restart redis
                systemctl restart mysql
#                systemctl restart docker
#                startEmqx # 启动emqx 保证能起来
            ;;
        esac
        bash /etc/rc.local
    elif [[ $systemVersion == 'kylin' ]];then
        echo ""
        bash /etc/rc.local
    elif [[ $systemVersion == 'kylin-x86' ]];then
        case $preInstallService in
        1) # 所有
                echoN "进入所有"
                systemctl restart nginx
#                systemctl restart emqx
                restartEmqx
                restartEmqxBridge
                systemctl restart redis
                systemctl stop mysql
                systemctl start mysql
                systemctl restart docker

                startEmqx # 启动emqx 保证能起来
            ;;
        2) # 微服务
                systemctl restart nginx
#                systemctl restart emqx
                restartEmqx
                restartEmqxBridge
                systemctl start redis
                systemctl stop mysql
                systemctl stop docker
                startEmqx # 启动emqx 保证能起来
            ;;
        3) # 网管
                #网管
                systemctl stop nginx
#                systemctl stop emqx
                restartEmqx
                restartEmqxBridge
                systemctl stop redis
                systemctl restart mysql
                systemctl stop docker
                startEmqx # 启动emqx 保证能起来
            ;;
        4) # 调度
                #调度 - 连微服务的redis
                systemctl restart nginx
#                systemctl stop emqx
                restartEmqx
                restartEmqxBridge
                systemctl stop redis
                systemctl restart mysql
                systemctl restart docker
                startEmqx # 启动emqx 保证能起来
            ;;
        5) # 微服务+网管isUnitidHighest
                #微服务+网管
                systemctl restart nginx
#                systemctl restart emqx
                restartEmqx
                restartEmqxBridge
                systemctl restart redis
                systemctl restart mysql
                systemctl restart docker
                startEmqx # 启动emqx 保证能起来
            ;;
        6) # 核心网 isUnitidHighest
                #核心网
#                systemctl restart nginx
#                systemctl restart emqx
#                restartEmqx
#                systemctl restart redis
                systemctl restart mysql
#                systemctl restart docker
#                startEmqx # 启动emqx 保证能起来
            ;;
        7) # 核心网+调度 isUnitidHighest
                #核心网+调度
                systemctl restart nginx
#                systemctl restart emqx
                restartEmqx
                restartEmqxBridge
                systemctl restart redis
                systemctl restart mysql
                systemctl restart docker
                startEmqx # 启动emqx 保证能起来
            ;;
        8) # 核心网+调度+微服务+网管 isUnitidHighest
                #核心网+调度+微服务+网管
                systemctl restart nginx
#                systemctl restart emqx
                restartEmqx
                restartEmqxBridge
                systemctl restart redis
                systemctl restart mysql
                systemctl restart docker
                startEmqx # 启动emqx 保证能起来
            ;;
        9) # 区交基站网关 isUnitidHighest
                #区交基站网关
#                systemctl restart nginx
#                systemctl restart emqx
#                restartEmqx
#                systemctl restart redis
                systemctl restart mysql
#                systemctl restart docker
#                startEmqx # 启动emqx 保证能起来
            ;;
        10) # 移交基站网关 isUnitidHighest
                #移交基站网关
#                systemctl restart nginx
#                systemctl restart emqx
#                restartEmqx
#                systemctl restart redis
                systemctl restart mysql
#                systemctl restart docker
#                startEmqx # 启动emqx 保证能起来
            ;;
        esac
        bash /etc/rc.local
	fi
    fi

    if [ "$projectName" == "aj"  ];then
        case $preInstallService in
        1) # aj-nms
            echoN "进入 aj-nms"
            startNginx
            startEmqx
            startRedis
            startMysql
            ;;
        1) # aj-jds
            echoN "进入 aj-jds"
            startMysql
            ;;
        esac

        bash /etc/rc.local
    fi
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function setIp(){
    local startTime=$(date +%s)
    if [[ $systemVersion == "centos7" ]];then
            echoR "centos7 版本"

            # 0. 查找启动的网卡
            echoN "查找启动的网卡"
#            runningNetworkCardNames=`ifconfig | grep RUNNING | grep -v lo | awk '{print $1}' | sed 's/://g'`
            runningNetworkCardNames=`ifconfig | grep RUNNING | grep -v lo | awk '{print $1}' | sed 's/.$//g'`
            echoN "已启动的网卡为"
#            echoR "${runningNetworkCardNames[*]}"

            # 1. 用户选择配置哪个网卡，给出所有的网卡，如果网卡启动了，后面给出已启动字样
            AllNetworkCardNames=(`ifconfig | grep flags | awk '{print $1}' | sed 's/.$//g'`)
            AllNetworkCardNamesLen=`ifconfig | grep flags | awk '{print $1}' | wc -l `
            echoN "所有网卡len如下：$AllNetworkCardNamesLen"
            echoN "所有网卡如下："
#            echoN "${AllNetworkCardNames[*]}"

            # 打印：网卡 未启动 ip:127.0.0.1 netmask:255.255.255.0 gateway:xx.xx.xx.x
            for((i=0;i<$AllNetworkCardNamesLen;i++));
            do
                networkCardIp=`ifconfig ${AllNetworkCardNames[$i]} | grep netmask | awk '{print $2}'`
                networkCardNetmask=`ifconfig ${AllNetworkCardNames[$i]} | grep netmask | awk '{print $4}'`
                if [[ ${runningNetworkCardNames[*]} =~ ${AllNetworkCardNames[$i]} ]];then
                    colorEcho "$i 网卡: ${AllNetworkCardNames[$i]} $nostyle $right_info 已启动 $nostyle $nomal_info ip: $networkCardIp netmask: $networkCardNetmask"
                else
                    colorEcho "$i 网卡: ${AllNetworkCardNames[$i]} $nostyle $error_info 未启动 $nostyle $nomal_info ip: $networkCardIp netmask: $networkCardNetmask"
                fi
            done

            read -p "以上是所有网卡，请选择网卡前的序号:"  userChooseNetworkCardIndex
            echoN "用户选择的网卡 --> $userChooseNetworkCardIndex ${AllNetworkCardNames[$userChooseNetworkCardIndex]}"

            echo ''
            read -p "请输入ip(格式：xx.xx.xx.xx, Ctrl+Backspace键删除输入内容): "  userChooseNetworkCardIp
            echoN "用户输入ip --> $userChooseNetworkCardIp"
            echo ''

            netmasks=(255.255.255.0 255.255.0.0 255.0.0.0)
            netmasksLen=${#netmasks[*]}
            for((i=0;i<$netmasksLen;i++));
            do
                echoN "$i ${netmasks[$i]}"
            done
            read -p "以上是子网掩码，请选择序号:"  userChooseNetworkCardNetmaskIndex
            echoN "用户选择的网卡子网掩码 --> userChooseNetworkCardNetmaskIndex ${netmasks[$userChooseNetworkCardNetmaskIndex]}"

            # 2. 修改网卡内容
            # 修改 BOOTPROTO=static
            # 修改 ONBOOT=yes
            # 修改 IPADDR=192.168.8.179
            # 修改 NETMASK=255.255.255.0
            # 修改 GATEWAY=192.168.8.1
            # 修改 DNS1=192.168.8.1
            # 修改 DNS2=114.114.114.114
            echo "网卡路径= /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}"
            sed -i "s/BOOTPROTO.*$/BOOTPROTO=static/g" /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i "s/ONBOOT.*$/ONBOOT=yes/g" /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i "/IPADDR/"d /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i '$a\IPADDR='"$userChooseNetworkCardIp"'' /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i "/NETMASK/"d /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i '$a\NETMASK='"${netmasks[$userChooseNetworkCardNetmaskIndex]}"'' /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i "/GATEWAY/"d /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            userChooseNetworkCardGateway=`getNetworkSegmentByIp $userChooseNetworkCardIp`
            sed -i '$a\GATEWAY='"$userChooseNetworkCardGateway"'.1' /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i "/DNS1/"d /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i '$a\DNS1='"$userChooseNetworkCardGateway"'.1' /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i "/DNS2/"d /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i '$a\DNS2='"114.114.114.114"'' /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}

            # 3. 重启网卡生效
            echoN "修改完毕,重启网卡！"
            systemctl restart network
#            systemctl status network

            echoR "重启完毕，修改成功！！！"

    elif [[ $systemVersion == "kylin" ]];then
        echoR "kylin 版本"

            # 0. 查找启动的网卡
            echoN "查找启动的网卡"
            runningNetworkCardNames=`ifconfig | grep RUNNING | grep -v lo | awk '{print $1}' | sed 's/.$//g'`

            # 1. 用户选择配置哪个网卡，给出所有的网卡，如果网卡启动了，后面给出已启动字样
            AllNetworkCardNames=(`ifconfig | grep flags | awk '{print $1}' | sed 's/.$//g'`)
            AllNetworkCardNamesLen=`ifconfig | grep flags | awk '{print $1}' | wc -l `

            # 打印：网卡 未启动 ip:127.0.0.1 netmask:255.255.255.0 gateway:xx.xx.xx.x
            for((i=0;i<$AllNetworkCardNamesLen;i++));
            do
                networkCardIp=`ifconfig ${AllNetworkCardNames[$i]} | grep netmask | awk '{print $2}'`
                networkCardNetmask=`ifconfig ${AllNetworkCardNames[$i]} | grep netmask | awk '{print $4}'`
                if [[ ${runningNetworkCardNames[*]} =~ ${AllNetworkCardNames[$i]} ]];then
                    colorEcho "$i 网卡: ${AllNetworkCardNames[$i]} $nostyle $right_info 已启动 $nostyle $nomal_info ip: $networkCardIp netmask: $networkCardNetmask"
                else
                    colorEcho "$i 网卡: ${AllNetworkCardNames[$i]} $nostyle $error_info 未启动 $nostyle $nomal_info ip: $networkCardIp netmask: $networkCardNetmask"
                fi
            done

            read -p "以上是所有网卡，请选择网卡前的序号:"  userChooseNetworkCardIndex
            echoN "用户选择的网卡 --> $userChooseNetworkCardIndex ${AllNetworkCardNames[$userChooseNetworkCardIndex]}"

            echo ''
            read -p "请输入ip(格式：xx.xx.xx.xx, Ctrl+Backspace键删除输入内容): "  userChooseNetworkCardIp
            echoN "用户输入ip --> $userChooseNetworkCardIp"
            echo ''

            netmasks=(255.255.255.0 255.255.0.0 255.0.0.0)
            netmasksLen=${#netmasks[*]}
            for((i=0;i<$netmasksLen;i++));
            do
                echoN "$i ${netmasks[$i]}"
            done
            read -p "以上是子网掩码，请选择序号:"  userChooseNetworkCardNetmaskIndex
            echoN "用户选择的网卡子网掩码 --> userChooseNetworkCardNetmaskIndex ${netmasks[$userChooseNetworkCardNetmaskIndex]}"

            # 2. 修改网卡内容
            # 修改 BOOTPROTO=static
            # 修改 ONBOOT=yes
            # 修改 IPADDR=192.168.8.179
            # 修改 NETMASK=255.255.255.0
            # 修改 GATEWAY=192.168.8.1
            # 修改 DNS1=192.168.8.1
            # 修改 DNS2=114.114.114.114
            echo "网卡路径= /etc/networking/interface"
            sed -i "/${AllNetworkCardNames[$userChooseNetworkCardIndex]}/"d /etc/networking/interface  # 删除网卡配置
            sed -i '$a\auto '"${AllNetworkCardNames[$userChooseNetworkCardIndex]}"'' /etc/networking/interface
            sed -i '$a\iface '"${AllNetworkCardNames[$userChooseNetworkCardIndex]}"' inet static' /etc/networking/interface
            sed -i '$a\address '"$userChooseNetworkCardIp"' # '"${AllNetworkCardNames[$userChooseNetworkCardIndex]}"' ' /etc/networking/interface
            sed -i '$a\netmask '"${netmasks[$userChooseNetworkCardNetmaskIndex]}"' # '"${AllNetworkCardNames[$userChooseNetworkCardIndex]}"' ' /etc/networking/interface
            sed -i '$a\dns-nameserver '"$userChooseNetworkCardGateway"' # '"${AllNetworkCardNames[$userChooseNetworkCardIndex]}"' ' /etc/networking/interface

            # 3. 重启服务器生效
            echoR "修改完毕,重启服务器生效！"
    elif [[ $systemVersion == "kylin-x86" ]];then
            echoR "centos7 版本"

            # 0. 查找启动的网卡
            echoN "查找启动的网卡"
#            runningNetworkCardNames=`ifconfig | grep RUNNING | grep -v lo | awk '{print $1}' | sed 's/://g'`
            runningNetworkCardNames=`ifconfig | grep RUNNING | grep -v lo | awk '{print $1}' | sed 's/.$//g'`
            echoN "已启动的网卡为"
#            echoR "${runningNetworkCardNames[*]}"

            # 1. 用户选择配置哪个网卡，给出所有的网卡，如果网卡启动了，后面给出已启动字样
            AllNetworkCardNames=(`ifconfig | grep flags | awk '{print $1}' | sed 's/.$//g'`)
            AllNetworkCardNamesLen=`ifconfig | grep flags | awk '{print $1}' | wc -l `
            echoN "所有网卡len如下：$AllNetworkCardNamesLen"
            echoN "所有网卡如下："
#            echoN "${AllNetworkCardNames[*]}"

            # 打印：网卡 未启动 ip:127.0.0.1 netmask:255.255.255.0 gateway:xx.xx.xx.x
            for((i=0;i<$AllNetworkCardNamesLen;i++));
            do
                networkCardIp=`ifconfig ${AllNetworkCardNames[$i]} | grep netmask | awk '{print $2}'`
                networkCardNetmask=`ifconfig ${AllNetworkCardNames[$i]} | grep netmask | awk '{print $4}'`
                if [[ ${runningNetworkCardNames[*]} =~ ${AllNetworkCardNames[$i]} ]];then
                    colorEcho "$i 网卡: ${AllNetworkCardNames[$i]} $nostyle $right_info 已启动 $nostyle $nomal_info ip: $networkCardIp netmask: $networkCardNetmask"
                else
                    colorEcho "$i 网卡: ${AllNetworkCardNames[$i]} $nostyle $error_info 未启动 $nostyle $nomal_info ip: $networkCardIp netmask: $networkCardNetmask"
                fi
            done

            read -p "以上是所有网卡，请选择网卡前的序号:"  userChooseNetworkCardIndex
            echoN "用户选择的网卡 --> $userChooseNetworkCardIndex ${AllNetworkCardNames[$userChooseNetworkCardIndex]}"

            echo ''
            read -p "请输入ip(格式：xx.xx.xx.xx, Ctrl+Backspace键删除输入内容): "  userChooseNetworkCardIp
            echoN "用户输入ip --> $userChooseNetworkCardIp"
            echo ''

            netmasks=(255.255.255.0 255.255.0.0 255.0.0.0)
            netmasksLen=${#netmasks[*]}
            for((i=0;i<$netmasksLen;i++));
            do
                echoN "$i ${netmasks[$i]}"
            done
            read -p "以上是子网掩码，请选择序号:"  userChooseNetworkCardNetmaskIndex
            echoN "用户选择的网卡子网掩码 --> userChooseNetworkCardNetmaskIndex ${netmasks[$userChooseNetworkCardNetmaskIndex]}"

            # 2. 修改网卡内容
            # 修改 BOOTPROTO=static
            # 修改 ONBOOT=yes
            # 修改 IPADDR=192.168.8.179
            # 修改 NETMASK=255.255.255.0
            # 修改 GATEWAY=192.168.8.1
            # 修改 DNS1=192.168.8.1
            # 修改 DNS2=114.114.114.114
            echo "网卡路径= /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}"
            sed -i "s/BOOTPROTO.*$/BOOTPROTO=static/g" /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i "s/ONBOOT.*$/ONBOOT=yes/g" /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i "/IPADDR/"d /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i '$a\IPADDR='"$userChooseNetworkCardIp"'' /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i "/NETMASK/"d /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i '$a\NETMASK='"${netmasks[$userChooseNetworkCardNetmaskIndex]}"'' /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i "/GATEWAY/"d /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            userChooseNetworkCardGateway=`getNetworkSegmentByIp $userChooseNetworkCardIp`
            sed -i '$a\GATEWAY='"$userChooseNetworkCardGateway"'.1' /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i "/DNS1/"d /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i '$a\DNS1='"$userChooseNetworkCardGateway"'.1' /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i "/DNS2/"d /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}
            sed -i '$a\DNS2='"114.114.114.114"'' /etc/sysconfig/network-scripts/ifcfg-${AllNetworkCardNames[$userChooseNetworkCardIndex]}

            # 3. 重启网卡生效
            echoN "修改完毕,重启网卡！"
            systemctl restart network
#            systemctl status network

            echoR "重启完毕，修改成功！！！"
    fi
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function installEmqxBridge(){
    local startTime=$(date +%s)
    echoN "安装emqx 桥接》》》》》"
    ## 1. 关闭emqx
    echoN "关闭emqx"
    stopEmqx

    if [[ $systemVersion == "centos7" ]];then
         ## 3. 如果安装emqx ,拷贝桥接配置文件
        if [[ -d "/etc/emqx/plugins" ]];then
            \cp $projectPath/installPackages/commonConf/emqx/centos7/conf/emqx_bridge_mqtt.conf /etc/emqx/plugins
            ## 4. 替换桥接配置文件 localIp northEmqxIp
            sed -i "s/localIp/$localIp/g" /etc/emqx/plugins/emqx_bridge_mqtt.conf
            sed -i "s/northEmqxIp/$northEmqxIp/g" /etc/emqx/plugins/emqx_bridge_mqtt.conf
        fi

        echoN "重启emqx"
        ## 7. 重启emqx
        systemctl restart emqx
#        systemctl status emqx
    elif [[ $systemVersion == "kylin" ]];then
        ## 3. 如果安装emqx ,拷贝桥接配置文件
        if [[ -d "/etc/emqx/plugins" ]];then
            \cp $projectPath/installPackages/commonConf/emqx/kylin/conf/emqx_bridge_mqtt.conf /etc/emqx/plugins
            ## 4. 替换桥接配置文件 localIp northEmqxIp
            sed -i "s/localIp/$localIp/g" /etc/emqx/plugins/emqx_bridge_mqtt.conf
            sed -i "s/northEmqxIp/$northEmqxIp/g" /etc/emqx/plugins/emqx_bridge_mqtt.conf
        fi

        echoN "重启emqx"
        ## 7. 重启emqx
        /etc/init.d/emqx stop
        /etc/init.d/emqx start
        /etc/init.d/emqx status
    elif [[ $systemVersion == "kylin-x86" ]];then
         ## 3. 如果安装emqx ,拷贝桥接配置文件
        if [[ -d "/etc/emqx/plugins" ]];then
            \cp $projectPath/installPackages/commonConf/emqx/kylin-x86/conf/emqx_bridge_mqtt.conf $emqxInstallPath/emqx/etc/plugins
            ## 4. 替换桥接配置文件 localIp northEmqxIp
            sed -i "s/localIp/$localIp/g" /etc/emqx/plugins/emqx_bridge_mqtt.conf
            sed -i "s/northEmqxIp/$northEmqxIp/g" /etc/emqx/plugins/emqx_bridge_mqtt.conf
        fi

        echoN "重启emqx"
        ## 7. 重启emqx
        systemctl restart emqx
#        systemctl status emqx
    fi

    echoN "启动桥接"
    ## 5. 重载bridge
    /bin/emqx_ctl plugins reload emqx_bridge_mqtt
    ## 6. 启动bridge
    /bin/emqx_ctl bridges start aws
    /bin/emqx_ctl bridges list

    if [[ `/bin/emqx_ctl bridges list` =~ 'Running' ]];then
        echoR "启动桥接成功"
    else
        echoE "启动桥接失败，上级emqx 未启动！！"
        echoE "启动桥接失败，上级emqx 未启动！！" >> "$logfile/run-`(date +%Y%m%d)`.log"
    fi

    ## 8. 设置启动 bridge 定时任务
    echoN "设置启动 bridge 定时任务"
    \cp $projectPath/installPackages/commonConf/.checkEmqxBridge /root
    chmod +x /root/.checkEmqxBridge
    chmod 777 /root/.checkEmqxBridge

    sed -i "/checkEmqxBridge/"d /etc/crontab
    sed -i '$a\*\/5 * * * * \/root\/.checkEmqxBridge' /etc/crontab  # 5分钟检测一次

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function stopEmqxBridge(){
    echoN "停止emqx 桥接"
    /bin/emqx_ctl bridges stop aws
}


function restartEmqxBridge(){
    local startTime=$(date +%s)
    echoN "重启emqx 桥接"
    sleep 3
#    restartEmqx
    /bin/emqx_ctl plugins reload emqx_bridge_mqtt
    sleep 2
    /bin/emqx_ctl bridges stop aws
    /bin/emqx_ctl bridges start aws

    if [[ `/bin/emqx_ctl bridges list` =~ 'Running' ]];then
        echoR "启动桥接成功"
    else
        echoE "重启桥接失败，上级emqx 未启动！！"
        echoE "重启桥接失败，上级emqx 未启动！！" >> "$logfile/run-`(date +%Y%m%d)`.log"
    fi

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function offlineInstallSwitchCommonLib(){
    local startTime=$(date +%s)
    # 1. 移除已有库
    cd /home
    rm -rf common
    mkdir -vp /home/common
#    unzipFile $switchCommonLib /home

    # 2. 使lib生效
    cp $projectPath/installPackages/commonConf/common/conf/common.conf /etc/ld.so.conf.d/
    ldconfig

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function offlineInstallSwitch(){
    local startTime=$(date +%s)
    # 0. 调用安装核心网lib
    offlineInstallSwitchCommonLib

    # 1. 关闭oam程序+ oam看门狗
    oamStop -a

    # 0.1 判断预安装类型
    if [[ $preInstallService -eq 7 || $preInstallService -eq 8 ]];then
        echoN '直接解压到icss 的NE目录里'
    else
        # 2. 移除.NE 已有程序
        cd /root
        rm -rf .NE
        rm -rf .resource
    fi

    # 3. 解压核心网NE + resource
    unzipFile $switchNE /root
    unzipFile $switchResource /root

	# 4. 修改oam的自启动项目 centos7 是oam  kylin是OAM
    if [[ $systemVersion == 'centos7' ]];then
        if [[ $switchRunServerNames != '' ]];then
            for i in ${switchRunServerNames[@]};
            do
                echo "$i@0" >> /root/oam/oam.MANIFEST
                echo "$i" >> /root/oam/oam.launch
            done
        fi
    elif [[ $systemVersion == 'kylin' ]];then
        if [[ $switchRunServerNames != '' ]];then
            for i in ${switchRunServerNames[@]};
            do
                echo "$i@0" >> /root/OAM/oam.MANIFEST
                echo "$i" >> /root/OAM/oam.launch
            done
        fi
    fi

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function offlineInstallBind(){
    local startTime=$(date +%s)
    echoN "离线安装域名。。。"
    # 2. 设置自启动
    if [[ $systemVersion == "centos7" ]];then
        echoR "centos7 版本"
        # 0. 检测安装文件是否存在
        # 1. 安装rpm
        if [[ -d $projectPath/installPackages/centos7/bind/rpm/bind ]];then
            echoR 'bind安装包存在！！'
            rpm -ivh $projectPath/installPackages/centos7/bind/rpm/bind/*
        else
            echoE 'bind安装包不存在！！'
            return 0
        fi
        if [[ -d $projectPath/installPackages/centos7/bind/rpm/bind-utils ]];then
            echoR 'bind-sutil 安装包存在！！'
            rpm -ivh $projectPath/installPackages/centos7/bind/rpm/bind-utils/*
        else
            echoE 'bind-sutil 安装包不存在！！'
            return 0
        fi
        # 2. 拷贝配置文件
        cp $projectPath/installPackages/centos7/bind/conf/named.conf   /etc/
        cp $projectPath/installPackages/centos7/bind/confresolv.conf   /etc/
        cp $projectPath/installPackages/centos7/bind/conftest.com.zone /var/named/
        cp $projectPath/installPackages/centos7/bind/conf/1.168.192.in-addr.arpa /var/named/
        # 修改ip
        sed -i 's/icssIp/$icssIp/g' $projectPath/installPackages/centos7/bind/conftest.com.zone
        sed -i 's/switchIp/$switchIp/g' $projectPath/installPackages/centos7/bind/conftest.com.zone
        # 3. 设置自启动
        systemctl start named
        systemctl enable named
        chkconfig named on
    elif [[ $systemVersion == "kylin" ]];then
        echoE "kylin 版本 还没做，不知道怎么装。。。。。。。"
    fi

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


offlineInstallTomcat(){
    local startTime=$(date +%s)
    echoN '安装 tomcat'
    # 1. 关闭程序
    if [[ -f $tomcatInstallPath/tomcat/bin/shutdown.sh ]];then
        chmod +x $tomcatInstallPath/tomcat/bin/shutdown.sh
        $tomcatInstallPath/tomcat/bin/shutdown.sh
    fi
    tomcatpids=`ps -ef|grep tomcat | grep -v grep | awk '{print $2}'`  # 先查询pid
    if [ -z "$tomcatpids" ];then
	    kill -9 $tomcatpids  # 杀掉进程
    fi
    # 2. 删除已有的tomcat
    cd $tomcatInstallPath
    rm -rf tomcat

    # 3. 解压安装包,一般是到/usr/share
    unzipFile $tomcatOfflinePakagePath $tomcatInstallPath

    # 4. 修改配置文件
    sed -i "s/localIp/$localIp/g" $tomcatInstallPath/tomcat/webapps/myomc/WEB-INF/classes/db.properties
    sed -i "s/softwareDbUsername/$softwareDbUsername/g" $tomcatInstallPath/tomcat/webapps/myomc/WEB-INF/classes/db.properties
    sed -i "s/softwareDbpassword/$softwareDbpassword/g" $tomcatInstallPath/tomcat/webapps/myomc/WEB-INF/classes/db.properties

    sed -i "s/localIp/$localIp/g" $tomcatInstallPath/tomcat/webapps/myomc/WEB-INF/classes/omc.properties
    sed -i "s/icssIp/$icssIp/g" $tomcatInstallPath/tomcat/webapps/myomc/WEB-INF/classes/omc.properties
    sed -i "s/northIp/$northIp/g" $tomcatInstallPath/tomcat/webapps/myomc/WEB-INF/classes/omc.properties

    # 5. 删除myomc数据库
    mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;drop database myomc;SET foreign_key_checks=1;"
    # 5. 重启tomcat
    if [[ -f $tomcatInstallPath/tomcat/bin/startup.sh ]];then
        chmod +x $tomcatInstallPath/tomcat/bin/startup.sh
        cd $tomcatInstallPath/tomcat/bin
        echoN '重启 tomcat，让omc自动生成数据库'
        ./startup.sh
    fi
    sleep 5  # 加载完数据库
    # 6. 修改myomc数据库
    # 6.1. 默认插入card 主板
    mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use myomc;insert into card values(1, '主板', 0, 0, '$localIp') on duplicate key update id='1', name='主板', cardNum=0, slotId=1, ip='$localIp';SET foreign_key_checks=1;"

    # 7. 备份myomc数据库
    if [[ -d $projectPath/backup ]];then
        mysqldump -u$softwareDbUsername -p$softwareDbpassword -d myomc > $projectPath/backup/myomc-bak.sql
    fi

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}


function installMobileSwitchGateway(){
    local startTime=$(date +%s)
    # 0. oamStop -a
    if [[ -d "/root/oam" || -d "/root/OAM" ]];then
        oamStop -a
    fi
#     1. 启动tomcat
#     1. 初始化要插入的网元，检测端口是否被占用，占了就用10001 10011 10021 10031
#     2. 插入myomc 数据
#     3. 解压包到.NE目录
#     3.1 修改配置文件端口号
#     4. 修改oamq启动文件 + 主备板配置
# 1. 启动tomcat--if 写的有问题，有时tomcat启动没有创建myomc数据库
#   if [[ -d "$tomcatInstallPath/tomcat/bin" && `checkPortIsStart 8080` -eq 0 ]];then
#        restartTomcat
#    fi
    restartTomcat
    echoN "等待tomcat 创建数据库"
    sleep 10
    # 2. 初始化要插入的网元，检测端口是否被占用，占了就用 11001 11011 11021 11031 agw-mdt网关
    mdtLocalPort=11001
    mdtLocalGKPort=12001
    mdtLocalNMSPort=13001
    mdtLocalGGSNPort=14001
    mdtLocalGTPUPort=15001
    mdtBackupPort=16001

    pdtLocalPort=21001
    pdtLocalUCommPort=22001
    pdtLocalOAMPort=23001

    mdtLocalPortArr=[]
    mdtLocalGKPortArr=[]
    mdtLocalNMSPortArr=[]
    mdtLocalGGSNPortArr=[]
    mdtLocalGTPUPortArr=[]
    mdtBackupPortArr=[]
    pdtLocalPortArr=[]
    pdtLocalUCommPortArr=[]
    pdtLocalOAMPortArr=[]
    for ((i=0; i<32; i++))  # pdt
	do
	    # 检测 mdtLocalPort
	    tempPort=$((mdtLocalPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+100的端口"
            for ((j=1;j<=9;j++))
            do
                tempPort=$((mdtLocalPort+i+ j*100))
                # 再次检测端口是否被占用
                echoE "端口+100，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        mdtLocalPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 mdtLocalGKPort
	    tempPort=$((mdtLocalGKPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+100的端口"
            for ((j=1;j<=9;j++))
            do
                tempPort=$((mdtLocalPort+i+ j*100))
                # 再次检测端口是否被占用
                echoE "端口+100，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        mdtLocalGKPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 mdtLocalNMSPort
	    tempPort=$((mdtLocalNMSPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+100的端口"
            for ((j=1;j<=9;j++))
            do
                tempPort=$((agwLocalPort+i+ j*100))
                # 再次检测端口是否被占用
                echoE "端口+100，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        mdtLocalNMSPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 mdtLocalGGSNPort
	    tempPort=$((mdtLocalGGSNPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+100的端口"
            for ((j=1;j<=9;j++))
            do
                tempPort=$((mdtLocalPort+i+ j*100))
                # 再次检测端口是否被占用
                echoE "端口+100，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        mdtLocalGGSNPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 mdtLocalGTPUPort
	    tempPort=$((mdtLocalGTPUPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+100的端口"
            for ((j=1;j<=9;j++))
            do
                tempPort=$((mdtLocalPort+i+ j*100))
                # 再次检测端口是否被占用
                echoE "端口+100，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        mdtLocalGTPUPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 mdtBackupPort
	    tempPort=$((mdtBackupPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+100的端口"
            for ((j=1;j<=9;j++))
            do
                tempPort=$((mdtLocalPort+i+ j*100))
                # 再次检测端口是否被占用
                echoE "端口+100，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        mdtBackupPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 pdtLocalPort
	    tempPort=$((pdtLocalPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+100的端口"
            for ((j=1;j<=9;j++))
            do
                tempPort=$((pdtLocalPort+i+ j*100))
                # 再次检测端口是否被占用
                echoE "端口+100，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        pdtLocalPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 pdtLocalUCommPort
	    tempPort=$((pdtLocalUCommPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+100的端口"
            for ((j=1;j<=9;j++))
            do
                tempPort=$((pdtLocalUCommPort+i+ j*100))
                # 再次检测端口是否被占用
                echoE "端口+100，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        pdtLocalUCommPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 pdtLocalOAMPort
	    tempPort=$((pdtLocalOAMPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+100的端口"
            for ((j=1;j<=9;j++))
            do
                tempPort=$((pdtLocalOAMPort+i+ j*100))
                # 再次检测端口是否被占用
                echoE "端口+100，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        pdtLocalOAMPortArr[$i]=$tempPort  # 本地端口 arr赋值
	done
	echoN "所有pdt + agw可用端口如下："
	echoR "mdtLocalPortArr ${mdtLocalPortArr[*]} "
	echoR "mdtLocalGKPortArr ${mdtLocalGKPortArr[*]} "
	echoR "mdtLocalNMSPortArr ${mdtLocalNMSPortArr[*]} "
	echoR "mdtLocalGGSNPortArr ${mdtLocalGGSNPortArr[*]} "
	echoR "mdtLocalGTPUPortArr ${mdtLocalGTPUPortArr[*]} "
	echoR "mdtBackupPortArr ${mdtBackupPortArr[*]} "
	echoR "pdtLocalPortArr ${pdtLocalPortArr[*]} "
	echoR "pdtLocalUCommPortArr ${pdtLocalUCommPortArr[*]} "
	echoR "pdtLocalOAMPortArr ${pdtLocalOAMPortArr[*]} "
	    ## 测试数据，
#    mdtLocalPortArr=(11001 11002 11003 11004 11005 11006 11007 11008 11009 11010 11011 11012 11013 11014 11015 11016 11017 11018 11019 11020 11021 026 11027 11028 11029 11030 11031 11032)
#    mdtLocalGKPortArr=(12001 12002 12003 12004 12005 12006 12007 12008 12009 12010 12011 12012 12013 12014 12015 12016 12017 12018 12019 12020 12021 12026 12027 12028 12029 12030 12031 12032)
#    mdtLocalNMSPortArr=(13001 13002 13003 13004 13005 13006 13007 13008 13009 13010 13011 13012 13013 13014 13015 13016 13017 13018 13019 13020 13021 13026 13027 13028 13029 13030 13031 13032)
#    mdtLocalGGSNPortArr=(14001 14002 14003 14004 14005 14006 14007 14008 14009 14010 14011 14012 14013 14014 14015 14016 14017 14018 14019 14020 14021 5 14026 14027 14028 14029 14030 11131 14032)
#    mdtLocalGTPUPortArr=(15001 15002 15003 15004 15005 15006 15007 15008 15009 15010 15011 15012 15013 15014 15015 15016 15017 15018 15019 15020 15021 5 15026 15027 15028 15029 15030 15031 15032)
#    mdtBackupPortArr=(16001 16002 16003 16004 16005 16006 16007 16008 16009 16010 16011 16012 16013 16014 16015 16016 16017 16018 16019 16020 16021 6026 16027 16028 16029 16030 16031 16032)
#    pdtLocalPortArr=(21001 21002 21003 21004 21005 21006 21007 21008 21009 21010 21011 21012 21013 21014 21015 21016 21017 21018 21019 21020 21021 026 21027 21028 21029 21030 21031 21032)
#    pdtLocalUCommPortArr=(22001 22002 22003 22004 22005 22006 22007 22008 22009 22010 22011 22012 22013 22014 22015 22016 22017 22018 22019 22020 22021 25 22026 22027 22028 22029 22030 22031 22032)
#    pdtLocalOAMPortArr=(23001 23002 23003 23004 23005 23006 23007 23008 23009 23010 23011 23012 23013 23014 23015 23016 23017 23018 23019 23020 23021  23026 23027 23028 23029 23030 23031 23032)

	# 2. 插入myomc 数据
    # 主板板卡
    local cardId=0
    local masterSlaveName='主板'
    local cardNum=0
    local sllotId=0
    if [ "$cardType" -eq 1 ];then
        cardId=0
        masterSlaveName='主板'
        cardNum=0
        sllotId=0
    elif [ "$cardType" -eq 2 ];then
        cardId=1
        masterSlaveName='从板'
        cardNum=1
        sllotId=1
    fi

    echoN "插入myomc数据库数据 card、module、entity表"
    # card
    mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use myomc;insert into card values('$cardId', '$masterSlaveName', '$cardNum', '$sllotId', '$localIp') on duplicate key update id='$cardId', name='$masterSlaveName', cardNum='$cardNum', slotId='$sllotId', ip='$localIp';SET foreign_key_checks=1;" > /dev/null

    # module - > pdt 101-1
    mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use myomc;insert into module values(101, 'pdt', 0, '$manifestPdtDescription', '$manifestPdtVersion', '$manifestPdtExe', '$manifestPdtLog') on duplicate key update id=101, name='pdt', belong=0,description='$manifestPdtDescription', version='$manifestPdtVersion',exe='$manifestPdtExe',log='$manifestPdtLog';SET foreign_key_checks=1;" > /dev/null

    # module - > mdt 100-1
    mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use myomc;insert into module values(100, 'mdt', 0, '$manifestMdtDescription', '$manifestMdtVersion', '$manifestMdtExe', '$manifestMdtLog') on duplicate key update id=100, name='mdt', belong=0,description='$manifestMdtDescription', version='$manifestMdtVersion',exe='$manifestMdtExe',log='$manifestMdtLog';SET foreign_key_checks=1;" > /dev/null

    for ((i=1;i<=32;i++))
    do
        # entity - > pdt 101-1
        mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use myomc;insert into entity values(null, 'pdt', '$i', 0, 1, '$manifestPdtDescription', 101, '$cardId') on duplicate key update name='pdt', instId='$i', status=0, type=1, description='$manifestPdtDescription', moduleId=101, cardId='$cardId';SET foreign_key_checks=1;" > /dev/null
        # entity - > mdt 100-1
        mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use myomc;insert into entity values(null, 'mdt', '$i', 0, 1, '$manifestMdtDescription', 100, '$cardId') on duplicate key update name='mdt', instId='$i', status=0, type=1, description='$manifestMdtDescription', moduleId=100, cardId='$cardId';SET foreign_key_checks=1;" > /dev/null
    done

    # 3.0 清空oam启动文件
    if [ -d "/root/OAM" ];then
        cat /dev/null > /root/OAM/oam.MANIFEST
        cat /dev/null > /root/OAM/oam.launch
    fi
    if [ -d "/root/oam" ];then
        cat /dev/null > /root/oam/oam.MANIFEST
        cat /dev/null > /root/oam/oam.launch
    fi
    # 3. 解压包到.NE目录
    if [ -d "/root/.NE" ];then
        for((i=1;i<=32;i++));
        do
            # 创建文件夹
            if [ ! -d "/root/.NE/101-$i" ];then
                mkdir "/root/.NE/101-$i"  # pdt
            fi
            if [ ! -d "/root/.NE/100-$i" ];then
                mkdir "/root/.NE/100-$i"  # mdt
            fi
            # 解压
            echoN "解压文件"
            unzipFile $pdtOfflinePakagePath "/root/.NE/101-$i"
            unzipFile $mdtOfflinePakagePath "/root/.NE/100-$i"

            # 批量替换配置文件- pdt
            if [ -n "$pdtLocalPortArr[$i-1]" ]; then
#                sed -i "s/LocalPdtPort:.*/LocalPdtPort:1111/g" "/root/.NE/101-1/pdt.config"
#                sed -i "/^LocalPdtPort:/LocalPdtPort:${pdtLocalPortArr[$i-1]}" "/root/.NE/101-$i/pdt.config" # 错误 sed: -e expression #1, char 18: extra characters after command
                sed -i "s/LocalPdtPort:.*/LocalPdtPort:${pdtLocalPortArr[$i-1]}/g" "/root/.NE/101-$i/pdt.config"
            fi
            if [ -n "$pdtLocalUCommPortArr[$i-1]" ]; then
                sed -i "s/LocalUCommPort:.*/LocalUCommPort:${pdtLocalUCommPortArr[$i-1]}/g" "/root/.NE/101-$i/pdt.config"
            fi
            if [ -n "$pdtLocalOAMPortArr[$i-1]" ]; then
                sed -i "s/LocalOAMPort:.*/LocalOAMPort:${pdtLocalOAMPortArr[$i-1]}/g" "/root/.NE/101-$i/pdt.config"
            fi

            # 批量替换配置文件- mdt
            if [ -n "$mdtLocalPortArr[$i-1]" ]; then
                sed -i "s/LocalPort:.*/LocalPort:${mdtLocalPortArr[$i-1]}/g" "/root/.NE/100-$i/agw.config"
            fi
            if [ -n "$mdtLocalGKPortArr[$i-1]" ]; then
                sed -i "s/LocalGKPort:.*/LocalGKPort:${mdtLocalGKPortArr[$i-1]}/g" "/root/.NE/100-$i/agw.config"
            fi
            if [ -n "$mdtLocalNMSPortArr[$i-1]" ]; then
                sed -i "s/LocalNMSPort:.*/LocalNMSPort:${mdtLocalNMSPortArr[$i-1]}/g" "/root/.NE/100-$i/agw.config"
            fi
            if [ -n "$mdtLocalGGSNPortArr[$i-1]" ]; then
                sed -i "s/LocalGGSNPort:.*/LocalGGSNPort:${mdtLocalGGSNPortArr[$i-1]}/g" "/root/.NE/100-$i/agw.config"
            fi
            if [ -n "$mdtLocalGTPUPortArr[$i-1]" ]; then
                sed -i "s/LocalGTPUPort:.*/LocalGTPUPort:${mdtLocalGTPUPortArr[$i-1]}/g" "/root/.NE/100-$i/agw.config"
            fi
            if [ -n "$mdtBackupPortArr[$i-1]" ]; then
                sed -i "s/BackupPort:.*/BackupPort:${mdtBackupPortArr[$i-1]}/g" "/root/.NE/100-$i/agw_funcPara.config"
            fi

            # 替换ip--> 域名
            sed -i "s/LocalIP:.*/LocalIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/LocalGKIP:.*/LocalGKIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/LocalNMSIP:.*/LocalNMSIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/RemoteVCSIP:.*/RemoteVCSIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/RemoteSmscIP:.*/RemoteSmscIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/RemoteNMSIP:.*/RemoteNMSIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/RemoteGGSNIP:.*/RemoteGGSNIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/LocalGGSNIP:.*/LocalGGSNIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/LocalGTPUIP:.*/LocalGTPUIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/RemoteRCCAddr:.*/RemoteRCCAddr:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw

            sed -i "s/LocalPdtIP:.*/LocalPdtIP:hss.test.com/g" "/root/.NE/101-$i/pdt.config" #pdt
            sed -i "s/LocalUCommIP:.*/LocalUCommIP:hss.test.com/g" "/root/.NE/101-$i/pdt.config" #pdt
            sed -i "s/LocalOAMIP:.*/LocalOAMIP:hss.test.com/g" "/root/.NE/101-$i/pdt.config" #pdt
            sed -i "s/RemoteUCommIP:.*/RemoteUCommIP:hss.test.com/g" "/root/.NE/101-$i/pdt.config" #pdt
            sed -i "s/RemotePdtIP:.*/RemotePdtIP:hss.test.com/g" "/root/.NE/101-$i/pdt.config" #pdt
            sed -i "s/RemoteOAMIP:.*/RemoteOAMIP:hss.test.com/g" "/root/.NE/101-$i/pdt.config" #pdt

            # 修改 mdt--> agw-1 agw-32这样
            cd "/root/.NE/100-$i"
            mv m_agw "m_agw_$i"
            # 修改 pdt--> pdt-1 pdt-32这样
            cd "/root/.NE/101-$i"
            mv m_pdt_T_FT_C7_ff4749 "m_pdt_T_FT_C7_ff4749_$i"
            # 改nestart.sh 里内容
            sed -i "s/m_pdt_T_FT_C7_ff4749/m_pdt_T_FT_C7_ff4749_$i/g" "/root/.NE/101-$i/neStart.sh" #pdt
            sed -i "s/m_agw/m_agw_$i/g" "/root/.NE/100-$i/neStart.sh" #pdt

			# 替换oam
			if [ -d "/root/OAM" ];then  # pdt
                echo "101-$i@$cardId" >> /root/OAM/oam.MANIFEST
                echo "101-$i" >> /root/OAM/oam.launch
            fi
            if [ -d "/root/oam" ];then  # pdt
                echo "101-$i@$cardId" >> /root/oam/oam.MANIFEST
                echo "101-$i" >> /root/oam/oam.launch
            fi
            if [ -d "/root/OAM" ];then  # mdt
                echo "100-$i@$cardId" >> /root/OAM/oam.MANIFEST
                echo "100-$i" >> /root/OAM/oam.launch
            fi
            if [ -d "/root/oam" ];then  # mdt
                echo "100-$i@$cardId" >> /root/oam/oam.MANIFEST
                echo "100-$i" >> /root/oam/oam.launch
            fi
        done
    fi

    # 4. 打包pdt/mdt文件，让用户上传， 不判断是用户上传还是脚本自动安装网元
    #pdt <-- 101-1
    # 8.0 移除网元
    # 8.1 修改manifest
    # 8.2 如果是omc网元下发方式安装，打包zip包
    # 8.3 如果是omc网元下发方式安装，打包删除/root/.NE 和/root/.resource里所有的东西
    if [[ -f "$projectPath/backup/switch/pdt.zip" ]];then
        cd $projectPath/backup/switch
        rm -rf pdt.zip
    fi
    cd /root/.NE/$manifestPdtName
    if [[ ! -f manifest.mf ]];then
        touch manifest.mf
        echo '# manifest.mf' > manifest.mf
        sed -i '$a\config=' manifest.mf # 添加默认行 config=
        sed -i '$a\exe=' manifest.mf # 添加默认行 exe=
        sed -i '$a\version=' manifest.mf # 添加默认行 version=
        sed -i '$a\log=' manifest.mf # 添加默认行 log=
        sed -i '$a\description=' manifest.mf # 添加默认行 description=
        sed -i '$a\required=' manifest.mf # 添加默认行 required=
    fi
    sed -i "s#config.*#config=$manifestPdtConfig#g" manifest.mf
    sed -i "s#exe.*#exe=$manifestPdtExe#g" manifest.mf
    sed -i "s#version.*#version=$manifestPdtVersion#g" manifest.mf
    sed -i "s#log.*#log=$manifestPdtLog#g" manifest.mf
    sed -i "s#description.*#description=$manifestPdtDescription#g" manifest.mf
    sed -i "s#required.*#required=$manifestPdtRequired#g" manifest.mf

    # 部署方式：omc上传网元并下发
    zipfile=`echo $manifestPdtRequired | sed 's/,/ /g'`
    zip -r $projectPath/backup/switch/pdt.zip $zipfile > /dev/null
    echoN "去 $projectPath/backup/switch 目录下载 pdt.zip,通过omc安装，omc网站http://$localIp:8080/myomc"

    #mdt <-- 100-1
    # 8.0 移除网元
    # 8.1 修改manifest
    # 8.2 如果是omc网元下发方式安装，打包zip包
    # 8.3 如果是omc网元下发方式安装，打包删除/root/.NE 和/root/.resource里所有的东西
    if [[ -f "$projectPath/backup/switch/mdt.zip" ]];then
        cd $projectPath/backup/switch
        rm -rf mdt.zip
    fi
    cd /root/.NE/$manifestMdtName
    if [[ ! -f manifest.mf ]];then
        touch manifest.mf
        echo '# manifest.mf' > manifest.mf
        sed -i '$a\config=' manifest.mf # 添加默认行 config=
        sed -i '$a\exe=' manifest.mf # 添加默认行 exe=
        sed -i '$a\version=' manifest.mf # 添加默认行 version=
        sed -i '$a\log=' manifest.mf # 添加默认行 log=
        sed -i '$a\description=' manifest.mf # 添加默认行 description=
        sed -i '$a\required=' manifest.mf # 添加默认行 required=
    fi
    sed -i "s#config.*#config=$manifestMdtConfig#g" manifest.mf
    sed -i "s#exe.*#exe=$manifestMdtExe#g" manifest.mf
    sed -i "s#version.*#version=$manifestMdtVersion#g" manifest.mf
    sed -i "s#log.*#log=$manifestMdtLog#g" manifest.mf
    sed -i "s#description.*#description=$manifestMdtDescription#g" manifest.mf
    sed -i "s#required.*#required=$manifestMdtRequired#g" manifest.mf

    # oam网元加权限
    chmod 777 /root/.NE/*/*

    # 部署方式：omc上传网元并下发
    zipfile=`echo $manifestMdtRequired | sed 's/,/ /g'`
    if [ ! -d "$projectPath/backup/switch" ];then
        mkdir -vp "$projectPath/backup/switch"
    fi
    zip -r $projectPath/backup/switch/pdt.zip $zipfile > /dev/null
    echoN "去 $projectPath/backup/switch 目录下载 mdt.zip,通过omc安装，omc网站http://$localIp:8080/myomc"

    # ne目录加权限
    addPrivilegesNE
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}

function installAreaSwitchGateway(){
    local startTime=$(date +%s)
    # 0. oamStop -a
    if [[ -d "/root/oam" || -d "/root/OAM" ]];then
        oamStop -a
    fi
   #     1. 启动tomcat
#     1. 初始化要插入的网元，检测端口是否被占用，占了就用10001 10011 10021 10031
#     2. 插入myomc 数据
#     3. 解压包到.NE目录
#     3.1 修改配置文件端口号
#     4. 修改oamq启动文件 + 主备板配置
# 1. 启动tomcat--if 写的有问题，有时tomcat启动没有创建myomc数据库
#   if [[ -d "$tomcatInstallPath/tomcat/bin" && `checkPortIsStart 8080` -eq 0 ]];then
#        restartTomcat
#    fi
    restartTomcat
    echoN "等待tomcat 创建数据库"
    sleep 10
    # 2. 初始化要插入的网元，检测端口是否被占用，占了就用 11001 11011 11021 11031 agw-mdt网关
    mdtLocalPort=11001
    mdtLocalGKPort=12001
    mdtLocalNMSPort=13001
    mdtLocalGGSNPort=14001
    mdtLocalGTPUPort=15001
    mdtBackupPort=16001

    pdtLocalPort=21001
    pdtLocalUCommPort=22001
    pdtLocalOAMPort=23001

    mdtLocalPortArr=[]
    mdtLocalGKPortArr=[]
    mdtLocalNMSPortArr=[]
    mdtLocalGGSNPortArr=[]
    mdtLocalGTPUPortArr=[]
    mdtBackupPortArr=[]
    pdtLocalPortArr=[]
    pdtLocalUCommPortArr=[]
    pdtLocalOAMPortArr=[]
    for ((i=0; i<128; i++))  # pdt
	do
	    # 检测 mdtLocalPort
	    tempPort=$((mdtLocalPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+200的端口"
            for ((j=1;j<=4;j++))
            do
                tempPort=$((mdtLocalPort+i+ j*200))
                # 再次检测端口是否被占用
                echoE "端口+200，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        mdtLocalPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 mdtLocalGKPort
	    tempPort=$((mdtLocalGKPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+200的端口"
            for ((j=1;j<=4;j++))
            do
                tempPort=$((mdtLocalPort+i+ j*200))
                # 再次检测端口是否被占用
                echoE "端口+200，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        mdtLocalGKPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 mdtLocalNMSPort
	    tempPort=$((mdtLocalNMSPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+200的端口"
            for ((j=1;j<=4;j++))
            do
                tempPort=$((agwLocalPort+i+ j*200))
                # 再次检测端口是否被占用
                echoE "端口+200，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        mdtLocalNMSPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 mdtLocalGGSNPort
	    tempPort=$((mdtLocalGGSNPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+200的端口"
            for ((j=1;j<=4;j++))
            do
                tempPort=$((mdtLocalPort+i+ j*200))
                # 再次检测端口是否被占用
                echoE "端口+200，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        mdtLocalGGSNPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 mdtLocalGTPUPort
	    tempPort=$((mdtLocalGTPUPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+200的端口"
            for ((j=1;j<=4;j++))
            do
                tempPort=$((mdtLocalPort+i+ j*200))
                # 再次检测端口是否被占用
                echoE "端口+200，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        mdtLocalGTPUPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 mdtBackupPort
	    tempPort=$((mdtBackupPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+200的端口"
            for ((j=1;j<=4;j++))
            do
                tempPort=$((mdtLocalPort+i+ j*200))
                # 再次检测端口是否被占用
                echoE "端口+200，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        mdtBackupPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 pdtLocalPort
	    tempPort=$((pdtLocalPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+200的端口"
            for ((j=1;j<=4;j++))
            do
                tempPort=$((pdtLocalPort+i+ j*200))
                # 再次检测端口是否被占用
                echoE "端口+200，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        pdtLocalPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 pdtLocalUCommPort
	    tempPort=$((pdtLocalUCommPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+200的端口"
            for ((j=1;j<=4;j++))
            do
                tempPort=$((pdtLocalUCommPort+i+ j*200))
                # 再次检测端口是否被占用
                echoE "端口+200，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        pdtLocalUCommPortArr[$i]=$tempPort  # 本地端口 arr赋值

        # 检测 pdtLocalOAMPort
	    tempPort=$((pdtLocalOAMPort+i))
        checkPortResult=`checkPortIsStart $tempPort`
#        echo "端口= $tempPort"
        if [ "$checkPortResult" -eq 1 ];then
            echoE "port被占了,尝试+200的端口"
            for ((j=1;j<=4;j++))
            do
                tempPort=$((pdtLocalOAMPort+i+ j*200))
                # 再次检测端口是否被占用
                echoE "端口+200，再次检测端口是否被占用"
                if [ `checkPortIsStart $tempPort` -eq 0 ];then
                    echoR "最终端口号= $tempPort"
                    break
                fi
            done
        fi
        pdtLocalOAMPortArr[$i]=$tempPort  # 本地端口 arr赋值
	done
	echoN "所有pdt + agw可用端口如下："
	echoR "mdtLocalPortArr ${mdtLocalPortArr[*]} "
	echoR "mdtLocalGKPortArr ${mdtLocalGKPortArr[*]} "
	echoR "mdtLocalNMSPortArr ${mdtLocalNMSPortArr[*]} "
	echoR "mdtLocalGGSNPortArr ${mdtLocalGGSNPortArr[*]} "
	echoR "mdtLocalGTPUPortArr ${mdtLocalGTPUPortArr[*]} "
	echoR "mdtBackupPortArr ${mdtBackupPortArr[*]} "
	echoR "pdtLocalPortArr ${pdtLocalPortArr[*]} "
	echoR "pdtLocalUCommPortArr ${pdtLocalUCommPortArr[*]} "
	echoR "pdtLocalOAMPortArr ${pdtLocalOAMPortArr[*]} "

    ## 测试数据，
#    mdtLocalPortArr=(11001 11002 11003 11004 11005 11006 11007 11008 11009 11010 11011 11012 11013 11014 11015 11016 11017 11018 11019 11020 11021 026 11027 11028 11029 11030 11031 11032)
#    mdtLocalGKPortArr=(12001 12002 12003 12004 12005 12006 12007 12008 12009 12010 12011 12012 12013 12014 12015 12016 12017 12018 12019 12020 12021 12026 12027 12028 12029 12030 12031 12032)
#    mdtLocalNMSPortArr=(13001 13002 13003 13004 13005 13006 13007 13008 13009 13010 13011 13012 13013 13014 13015 13016 13017 13018 13019 13020 13021 13026 13027 13028 13029 13030 13031 13032)
#    mdtLocalGGSNPortArr=(14001 14002 14003 14004 14005 14006 14007 14008 14009 14010 14011 14012 14013 14014 14015 14016 14017 14018 14019 14020 14021 5 14026 14027 14028 14029 14030 11131 14032)
#    mdtLocalGTPUPortArr=(15001 15002 15003 15004 15005 15006 15007 15008 15009 15010 15011 15012 15013 15014 15015 15016 15017 15018 15019 15020 15021 5 15026 15027 15028 15029 15030 15031 15032)
#    mdtBackupPortArr=(16001 16002 16003 16004 16005 16006 16007 16008 16009 16010 16011 16012 16013 16014 16015 16016 16017 16018 16019 16020 16021 6026 16027 16028 16029 16030 16031 16032)
#    pdtLocalPortArr=(21001 21002 21003 21004 21005 21006 21007 21008 21009 21010 21011 21012 21013 21014 21015 21016 21017 21018 21019 21020 21021 026 21027 21028 21029 21030 21031 21032)
#    pdtLocalUCommPortArr=(22001 22002 22003 22004 22005 22006 22007 22008 22009 22010 22011 22012 22013 22014 22015 22016 22017 22018 22019 22020 22021 25 22026 22027 22028 22029 22030 22031 22032)
#    pdtLocalOAMPortArr=(23001 23002 23003 23004 23005 23006 23007 23008 23009 23010 23011 23012 23013 23014 23015 23016 23017 23018 23019 23020 23021  23026 23027 23028 23029 23030 23031 23032)

    # 2. 插入myomc 数据
    # 主板板卡
    local cardId=0
    local masterSlaveName='主板'
    local cardNum=0
    local sllotId=0
    if [ "$cardType" -eq 1 ];then
        cardId=0
        masterSlaveName='主板'
        cardNum=0
        sllotId=0
    elif [ "$cardType" -eq 2 ];then
        cardId=1
        masterSlaveName='从板'
        cardNum=1
        sllotId=1
    fi

    echoN "插入myomc数据库数据 card、module、entity表"
    # card
    mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use myomc;insert into card values('$cardId', '$masterSlaveName', '$cardNum', '$sllotId', '$localIp') on duplicate key update id='$cardId', name='$masterSlaveName', cardNum='$cardNum', slotId='$sllotId', ip='$localIp';SET foreign_key_checks=1;" > /dev/null

    # module - > pdt 101-1
    mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use myomc;insert into module values(101, 'pdt', 0, '$manifestPdtDescription', '$manifestPdtVersion', '$manifestPdtExe', '$manifestPdtLog') on duplicate key update id=101, name='pdt', belong=0,description='$manifestPdtDescription', version='$manifestPdtVersion',exe='$manifestPdtExe',log='$manifestPdtLog';SET foreign_key_checks=1;" > /dev/null

    # module - > mdt 100-1
    mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use myomc;insert into module values(100, 'mdt', 0, '$manifestMdtDescription', '$manifestMdtVersion', '$manifestMdtExe', '$manifestMdtLog') on duplicate key update id=100, name='mdt', belong=0,description='$manifestMdtDescription', version='$manifestMdtVersion',exe='$manifestMdtExe',log='$manifestMdtLog';SET foreign_key_checks=1;" > /dev/null

    for ((i=1;i<=128;i++))
    do
        # entity - > pdt 101-1
        mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use myomc;insert into entity values(null, 'pdt', '$i', 0, 1, '$manifestPdtDescription', 101, '$cardId') on duplicate key update name='pdt', instId='$i', status=0, type=1, description='$manifestPdtDescription', moduleId=101, cardId='$cardId';SET foreign_key_checks=1;" > /dev/null
        # entity - > mdt 100-1
        mysql -u$softwareDbUsername -p$softwareDbpassword -e "SET foreign_key_checks=0;use myomc;insert into entity values(null, 'mdt', '$i', 0, 1, '$manifestMdtDescription', 100, '$cardId') on duplicate key update name='mdt', instId='$i', status=0, type=1, description='$manifestMdtDescription', moduleId=100, cardId='$cardId';SET foreign_key_checks=1;" > /dev/null
    done

    # 3.0 清空oam启动文件
    if [ -d "/root/OAM" ];then
        cat /dev/null > /root/OAM/oam.MANIFEST
        cat /dev/null > /root/OAM/oam.launch
    fi
    if [ -d "/root/oam" ];then
        cat /dev/null > /root/oam/oam.MANIFEST
        cat /dev/null > /root/oam/oam.launch
    fi
    # 3. 解压包到.NE目录
    if [ -d "/root/.NE" ];then
        for((i=1;i<=128;i++));
        do
            # 创建文件夹
            if [ ! -d "/root/.NE/101-$i" ];then
                mkdir "/root/.NE/101-$i"  # pdt
            fi
            if [ ! -d "/root/.NE/100-$i" ];then
                mkdir "/root/.NE/100-$i"  # mdt
            fi
            # 解压
            echoN "解压文件"
            unzipFile $pdtOfflinePakagePath "/root/.NE/101-$i"
            unzipFile $mdtOfflinePakagePath "/root/.NE/100-$i"

             # 批量替换配置文件- pdt
            if [ -n "$pdtLocalPortArr[$i-1]" ]; then
#                sed -i "s/LocalPdtPort:.*/LocalPdtPort:1111/g" "/root/.NE/101-1/pdt.config"
#                sed -i "/^LocalPdtPort:/LocalPdtPort:${pdtLocalPortArr[$i-1]}" "/root/.NE/101-$i/pdt.config" # 错误 sed: -e expression #1, char 18: extra characters after command
                sed -i "s/LocalPdtPort:.*/LocalPdtPort:${pdtLocalPortArr[$i-1]}/g" "/root/.NE/101-$i/pdt.config"
            fi
            if [ -n "$pdtLocalUCommPortArr[$i-1]" ]; then
                sed -i "s/LocalUCommPort:.*/LocalUCommPort:${pdtLocalUCommPortArr[$i-1]}/g" "/root/.NE/101-$i/pdt.config"
            fi
            if [ -n "$pdtLocalOAMPortArr[$i-1]" ]; then
                sed -i "s/LocalOAMPort:.*/LocalOAMPort:${pdtLocalOAMPortArr[$i-1]}/g" "/root/.NE/101-$i/pdt.config"
            fi

            # 批量替换配置文件- mdt
            if [ -n "$mdtLocalPortArr[$i-1]" ]; then
                sed -i "s/LocalPort:.*/LocalPort:${mdtLocalPortArr[$i-1]}/g" "/root/.NE/100-$i/agw.config"
            fi
            if [ -n "$mdtLocalGKPortArr[$i-1]" ]; then
                sed -i "s/LocalGKPort:.*/LocalGKPort:${mdtLocalGKPortArr[$i-1]}/g" "/root/.NE/100-$i/agw.config"
            fi
            if [ -n "$mdtLocalNMSPortArr[$i-1]" ]; then
                sed -i "s/LocalNMSPort:.*/LocalNMSPort:${mdtLocalNMSPortArr[$i-1]}/g" "/root/.NE/100-$i/agw.config"
            fi
            if [ -n "$mdtLocalGGSNPortArr[$i-1]" ]; then
                sed -i "s/LocalGGSNPort:.*/LocalGGSNPort:${mdtLocalGGSNPortArr[$i-1]}/g" "/root/.NE/100-$i/agw.config"
            fi
            if [ -n "$mdtLocalGTPUPortArr[$i-1]" ]; then
                sed -i "s/LocalGTPUPort:.*/LocalGTPUPort:${mdtLocalGTPUPortArr[$i-1]}/g" "/root/.NE/100-$i/agw.config"
            fi
            if [ -n "$mdtBackupPortArr[$i-1]" ]; then
                sed -i "s/BackupPort:.*/BackupPort:${mdtBackupPortArr[$i-1]}/g" "/root/.NE/100-$i/agw_funcPara.config"
            fi
            # 替换ip--> 域名
            sed -i "s/LocalIP:.*/LocalIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/LocalGKIP:.*/LocalGKIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/LocalNMSIP:.*/LocalNMSIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/RemoteVCSIP:.*/RemoteVCSIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/RemoteSmscIP:.*/RemoteSmscIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/RemoteNMSIP:.*/RemoteNMSIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/RemoteGGSNIP:.*/RemoteGGSNIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/LocalGGSNIP:.*/LocalGGSNIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/LocalGTPUIP:.*/LocalGTPUIP:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw
            sed -i "s/RemoteRCCAddr:.*/RemoteRCCAddr:hss.test.com/g" "/root/.NE/100-$i/agw.config" # agw

            sed -i "s/LocalPdtIP:.*/LocalPdtIP:hss.test.com/g" "/root/.NE/101-$i/pdt.config" #pdt
            sed -i "s/LocalUCommIP:.*/LocalUCommIP:hss.test.com/g" "/root/.NE/101-$i/pdt.config" #pdt
            sed -i "s/LocalOAMIP:.*/LocalOAMIP:hss.test.com/g" "/root/.NE/101-$i/pdt.config" #pdt
            sed -i "s/RemoteUCommIP:.*/RemoteUCommIP:hss.test.com/g" "/root/.NE/101-$i/pdt.config" #pdt
            sed -i "s/RemotePdtIP:.*/RemotePdtIP:hss.test.com/g" "/root/.NE/101-$i/pdt.config" #pdt
            sed -i "s/RemoteOAMIP:.*/RemoteOAMIP:hss.test.com/g" "/root/.NE/101-$i/pdt.config" #pdt

            # 修改 mdt--> agw-1 agw-32这样
            cd "/root/.NE/100-$i"
            mv m_agw "m_agw_$i"
            # 修改 pdt--> pdt-1 pdt-32这样
            cd "/root/.NE/101-$i"
            mv m_pdt_T_FT_C7_ff4749 "m_pdt_T_FT_C7_ff4749_$i"
            # 改nestart.sh 里内容
            sed -i "s/m_pdt_T_FT_C7_ff4749/m_pdt_T_FT_C7_ff4749_$i/g" "/root/.NE/101-$i/neStart.sh" #pdt
            sed -i "s/m_agw/m_agw_$i/g" "/root/.NE/100-$i/neStart.sh" #pdt

			# 替换oam
			if [ -d "/root/OAM" ];then  # pdt
                echo "101-$i@$cardId" >> /root/OAM/oam.MANIFEST
                echo "101-$i" >> /root/OAM/oam.launch
            fi
            if [ -d "/root/oam" ];then  # pdt
                echo "101-$i@$cardId" >> /root/oam/oam.MANIFEST
                echo "101-$i" >> /root/oam/oam.launch
            fi
            if [ -d "/root/OAM" ];then  # mdt
                echo "100-$i@$cardId" >> /root/OAM/oam.MANIFEST
                echo "100-$i" >> /root/OAM/oam.launch
            fi
            if [ -d "/root/oam" ];then  # mdt
                echo "100-$i@$cardId" >> /root/oam/oam.MANIFEST
                echo "100-$i" >> /root/oam/oam.launch
            fi
        done
    fi

    # 4. 打包pdt/mdt文件，让用户上传， 不判断是用户上传还是脚本自动安装网元
    #pdt <-- 101-1
    # 8.0 移除网元
    # 8.1 修改manifest
    # 8.2 如果是omc网元下发方式安装，打包zip包
    # 8.3 如果是omc网元下发方式安装，打包删除/root/.NE 和/root/.resource里所有的东西
    if [[ -f "$projectPath/backup/switch/pdt.zip" ]];then
        cd $projectPath/backup/switch
        rm -rf pdt.zip
    fi
    cd /root/.NE/$manifestPdtName
    if [[ ! -f manifest.mf ]];then
        touch manifest.mf
        echo '# manifest.mf' > manifest.mf
        sed -i '$a\config=' manifest.mf # 添加默认行 config=
        sed -i '$a\exe=' manifest.mf # 添加默认行 exe=
        sed -i '$a\version=' manifest.mf # 添加默认行 version=
        sed -i '$a\log=' manifest.mf # 添加默认行 log=
        sed -i '$a\description=' manifest.mf # 添加默认行 description=
        sed -i '$a\required=' manifest.mf # 添加默认行 required=
    fi
    sed -i "s#config.*#config=$manifestPdtConfig#g" manifest.mf
    sed -i "s#exe.*#exe=$manifestPdtExe#g" manifest.mf
    sed -i "s#version.*#version=$manifestPdtVersion#g" manifest.mf
    sed -i "s#log.*#log=$manifestPdtLog#g" manifest.mf
    sed -i "s#description.*#description=$manifestPdtDescription#g" manifest.mf
    sed -i "s#required.*#required=$manifestPdtRequired#g" manifest.mf

    # 部署方式：omc上传网元并下发
    zipfile=`echo $manifestPdtRequired | sed 's/,/ /g'`
    zip -r $projectPath/backup/switch/pdt.zip $zipfile > /dev/null
    echoN "去 $projectPath/backup/switch 目录下载 pdt.zip,通过omc安装，omc网站http://$localIp:8080/myomc"

    #mdt <-- 100-1
    # 8.0 移除网元
    # 8.1 修改manifest
    # 8.2 如果是omc网元下发方式安装，打包zip包
    # 8.3 如果是omc网元下发方式安装，打包删除/root/.NE 和/root/.resource里所有的东西
    if [[ -f "$projectPath/backup/switch/mdt.zip" ]];then
        cd $projectPath/backup/switch
        rm -rf mdt.zip
    fi
    cd /root/.NE/$manifestMdtName
    if [[ ! -f manifest.mf ]];then
        touch manifest.mf
        echo '# manifest.mf' > manifest.mf
        sed -i '$a\config=' manifest.mf # 添加默认行 config=
        sed -i '$a\exe=' manifest.mf # 添加默认行 exe=
        sed -i '$a\version=' manifest.mf # 添加默认行 version=
        sed -i '$a\log=' manifest.mf # 添加默认行 log=
        sed -i '$a\description=' manifest.mf # 添加默认行 description=
        sed -i '$a\required=' manifest.mf # 添加默认行 required=
    fi
    sed -i "s#config.*#config=$manifestMdtConfig#g" manifest.mf
    sed -i "s#exe.*#exe=$manifestMdtExe#g" manifest.mf
    sed -i "s#version.*#version=$manifestMdtVersion#g" manifest.mf
    sed -i "s#log.*#log=$manifestMdtLog#g" manifest.mf
    sed -i "s#description.*#description=$manifestMdtDescription#g" manifest.mf
    sed -i "s#required.*#required=$manifestMdtRequired#g" manifest.mf

    # oam网元加权限
    chmod 777 /root/.NE/*/*  # 对执行文件无作用？

    # 部署方式：omc上传网元并下发
    zipfile=`echo $manifestMdtRequired | sed 's/,/ /g'`
    if [ ! -d "$projectPath/backup/switch" ];then
        mkdir -vp "$projectPath/backup/switch"
    fi
    zip -r $projectPath/backup/switch/pdt.zip $zipfile > /dev/null
    echoN "去 $projectPath/backup/switch 目录下载 mdt.zip,通过omc安装，omc网站http://$localIp:8080/myomc"

    # ne目录加权限
    addPrivilegesNE
    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}

function restartTomcat(){
    # 1. stop
    if [ -d "$tomcatInstallPath" ];then
        cd $tomcatInstallPath/tomcat/bin
        chmod +x *
        ./shutdown.sh
    else
        echoE "tomcat目录不存在！！"
    fi

    pids=`ps -ef|grep tomcat | grep -v grep | awk '{print $2}'`  # 先查询pid
	if [[ $pids -eq '' || $pids -eq ' ' ]];then
		echoE "tomcat 未启动！！！"
	else
		echoN "tomcat 查出来的pids==" $pids
		kill -9 $pids  # 杀掉进程
	fi

    # 2. start
    if [ -d "$tomcatInstallPath" ];then
        cd $tomcatInstallPath/tomcat/bin
        chmod +x *
        ./startup.sh
    else
        echoE "tomcat目录不存在！！"
    fi
}


function addPrivilegesNE(){
    chmod 777 /root/.NE/*/*
    chmod +x /root/.NE/*/*
    chmod 777 /root/.NE/*/m_agw  # 这条有效
    chmod 777 /root/.NE/*/m_agw*
    chmod 777 /root/.NE/*/m_pdt_T_FT_C7_ff4749  # 这条有效
    chmod 777 /root/.NE/*/m_pdt*  # 这条有效
}

function offlineInstallEmqxWatchLog(){
    chmod -R 777 $projectPath/installPackages/commonConf/emqx-dog/*
    cd $projectPath/installPackages/commonConf/emqx-dog

    pids=`ps -ef|grep ron_emqx_install. | grep -v grep | awk '{print $2}'`
    if [[ $pids != "" ]];then
        kill -9 $pids
    fi
    ./cron_emqx_install.sh &
}


function offlineInstallFtp(){
    ## 自动判断系统类型
    unzipFile   $ftpOfflinePackagePath/* /
    if [ "$systemVersion" == 'centos7' ];then
        \cp $projectPath/commonConf/ftp/vsftpd.conf /etc/vsftpd/vsftpd.conf
        systemctl start vsftpd
#        systemctl status vsftpd
        systemctl enable vsftpd
	elif [ "$systemVersion" == 'kylin' ];then
	    \cp $projectPath/commonConf/ftp/vsftpd.conf /etc/vsftpd.conf
	    /etc/init.d/vsftpd start
#	    /etc/init.d/vsftpd status
	    systemctl enable vsftpd
    elif [ "$systemVersion" == 'kylin-x86' ];then
	    \cp $projectPath/commonConf/ftp/vsftpd.conf /etc/vsftpd/vsftpd.conf
        systemctl start vsftpd
        systemctl enable vsftpd
	fi
	chmod -R 777 /var/ftp
	mkdir -vp /var/ftp/local/
	mkdir -vp /var/ftp/local/data
	mkdir -vp /var/ftp/local/groupcall
	mkdir -vp /var/ftp/local/register
	mkdir -vp /var/ftp/local/sms
	mkdir -vp /var/ftp/local/voice
    echoN "创建ftp用户"
    useradd -g root -d /var/ftp -s /sbin/nologin ftpuser
    echo "password" | sudo passwd ftpuser --stdin  &>/dev/null
#    echoE "ftp 配置未写,麒麟未测。。。。"
}

function autoRemove(){
    echoN "一键卸载 》》》》》》》"
    \cp $projectPath/installPackages/commonConf/hosts.bak /etc/hosts
    \cp $projectPath/installPackages/commonConf/rc.local.bak /etc/rc.local
    if [ "$projectName" == "2011" ];then
        echoN "2011 项目"
        pkill java
        stopNginx
        stopRedis
        stopEmqx
        stopEmqxBridge
        stopMysql
        stopOam
        stopKms

        stopMicro
        stopGateway
        stopNms
        stopIcssSoftware

        cd /usr/local
        rm -rf nginx*
        rm -rf redis*
        rm -rf emq*

        if [ "$systemVersion" == 'centos7' ];then
            removeDocker
        elif [ "$systemVersion" == 'kylin-x86' ];then
            removeDocker
        fi
        removeKms
        removeMysql
        cd /home
        rm -rf common
        sleep 1
        if [ -d "/home/2011" ];then
            cd /home/2011
            sleep 2
            # rm -rf !(installPackages)  # 报错，待定位
            rm -rf backup disp gateway googlemaps micro nms
        fi
        if [ -d "/root/.NE" ];then
            cd /root
            rm -rf .NE
        fi
        if [ -d "/usr/share/tomcat" ];then
            cd /usr/share
            rm -rf tomcat
        fi
    fi

    if [ "$projectName" == "aj" ];then
        case $preInstallService in
        1)
            echoN "aj-nms 项目"
            pkill java
            stopNginx
            stopRedis
            stopEmqx
            stopMysql
            stopOam

            stopMicro
            stopGateway
            stopNms
            stopIcssSoftware

            cd /usr/local
            rm -rf nginx*
            rm -rf redis*
            rm -rf emq*
            removeMysql

            cd /home
            rm -rf common
            sleep 1
            if [ -d "$projectName" ];then
                cd $projectName
                sleep 2
                # rm -rf !(installPackages)  # 报错，待定位
                rm -rf backup disp gateway googlemaps micro nms
            fi
            if [ -d "/root/.NE" ];then
                cd /root
                rm -rf .NE
            fi
            if [ -d "/usr/share/tomcat" ];then
                cd /usr/share
                rm -rf tomcat
            fi
            ;;
        2)
            echoN "aj-jds 项目"
            pkill java
            stopRedis
            stopMysql

            stopNms
            removeMysql

            if [ -d "$projectName" ];then
                cd $projectName
                sleep 2
                # rm -rf !(installPackages)  # 报错，待定位
                rm -rf backup disp gateway googlemaps micro nms
            fi
            ;;
        esac
    fi
}


function autoPackage(){
    # 生成到项目目录/packages/项目/installPackages
    local startTime=$(date +%s)
	echoN '>>>>>>>>>>>> 自动打包'

	## 1. 判断配置文件是否正确
	if [[ -f "$projectPath/installPackages/commonConf/$versionCfgFolderName/autoPackage.txt" ]];then
		echoN "自动打包配置文件 $projectPath/installPackages/commonConf/$versionCfgFolderName/autoPackage.txt 存在'"
	else
		echoE "自动打包配置文件 $projectPath/installPackages/commonConf/$versionCfgFolderName/autoPackage.txt 不存在"
		return 0
	fi


	## 4.0 拷贝自己写的配置文件
	sed -i 's/\r//' "$projectPath/installPackages/commonConf/$versionCfgFolderName/autoPackage.txt"
	local packageProjectName=` grep "projectName=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/autoPackage.txt"  | awk -F "=" '{print $2}' | awk -F '#' '{print $1}' | awk -F ' ' '{print $1}' `
    echo "要打包的项目名称= $packageProjectName"

    # 删除
    if [[ -d "$projectPath/package/$packageProjectName" ]];then
        cd $projectPath/package/
        rm -rf $packageProjectName
		echoR "删除 $projectPath/package/$packageProjectName"
	fi

	echoN "创建文件夹 $projectPath/package/$packageProjectName"
	mkdir -vp $projectPath/package/$packageProjectName
    local cpFilesLen=`grep "packageSrcFath" "$projectPath/installPackages/commonConf/$versionCfgFolderName/autoPackage.txt"  | wc -l`
    echoN "要拷贝的文件数量= $cpFilesLen"
    for((i=1;i<=$cpFilesLen;i++));
    do
        local packageSrcFath=`grep "packageSrcFath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/autoPackage.txt" | awk -F '=' '{print $2}'`
        local packageDstFath=`grep "packageDstFath$i=" "$projectPath/installPackages/commonConf/$versionCfgFolderName/autoPackage.txt" | awk -F '=' '{print $2}'`
        echoR "打包文件src " `eval echo $packageSrcFath`
        echoR "打包文件dst " `eval echo $packageDstFath`
        \cp -rf `eval echo $packageSrcFath` `eval echo $packageDstFath`
    done

	## 5. 检测是否安装成功(检查目录)
	if [[ -d "$projectPath/package/$packageProjectName" ]];then
		echoR "打包文件在 $projectPath/package/$packageProjectName"
	else
		echoE "$projectPath/package/$packageProjectName 文件夹不存在，打包失败！"
	fi

    local endTime=$(date +%s)
    local timeSup=`expr $endTime - $startTime`
    colorEcho "用时:" $nomal_info $timeSup "秒"
}

function jdsSetRedisLocation(){
    # set xian
    # redis 设置值
    if [ `ps -ef| grep redis | wc -l` -gt 0  ];then
        redis-cli -p 6380 set "com.sunkaisens.location.jds" "{longitude:108.95,latitude:34.27,high:-3.8,time:063755.00}"
        redis-cli -p 6379 set "com.sunkaisens.location.jds" "{longitude:108.95,latitude:34.27,high:-3.8,time:063755.00}"
    fi
}
