#!/bin/bash

source color.sh

function menu() {
    flag=1
    while [[ $flag == "1" ]];do
#        echo "--------一键脚本（$systemVersion）$version---------------"
        eval echo $shellHeader
        sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/mainMenu/mainMenu.txt
        # echoN "显示隐藏项目。。。。。。。 $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/mainMenu/mainMenu.txt"
        if [[ -n "$ifShowHiddenFunction" && "$ifShowHiddenFunction" -eq 1 ]];then
            echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/mainMenu/mainMenu.txt`
        elif [[ -n "$ifShowHiddenFunction" && "$ifShowHiddenFunction" -eq 0 ]];then
            echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/mainMenu/mainMenu.txt |grep -v "#"`
        fi
        read -p "请输入对应命令编号：(Ctrl+C 取消)" menuNum
        echo ""

        case $menuNum in
        1)
            #检查服务
            checkService
            ;;
        2)
            #安装菜单
            installMenu
            ;;
        3)
            #启动菜单
            runMenu
            ;;
        4)
            #其它菜单
            otherMenu
            ;;
        5)
            # echo "5. 一键安装"
            autoInstall
            ;;
        6)
            # echo "5. 一键启动"
            autoStart
            ;;
        7)
            # echo "7. 一键升级"
            autoUpdateMenu
            ;;
        8)
            # echo "8. 定位问题"
            findReasonMenu
            ;;
        9)
            # echo "9. 一键卸载"
            autoRemove
            ;;
        10)
            # echo "10. 一键生成项目安装包(项目目录/package目录)"
            autoPackage
            ;;
        0)
            #退出
            flag=0
            exit
            ;;
        esac
    done
}


function installMenu(){
#	echo "--------一键脚本（$systemVersion）$version---------------"
	eval echo $shellHeader
    sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/installMenu/installMenu.txt
    if [ "$ifShowHiddenFunction" -eq 1 ];then
        echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/installMenu/installMenu.txt`
    elif [ "$ifShowHiddenFunction" -eq 0 ];then
        echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/installMenu/installMenu.txt | grep -v "#"`
    fi

	read -p "请输入对应命令编号：(Ctrl+C 取消)" menuNum
	echo ""
	case $menuNum in
	1)
		#安装nginx
		installNginx
		;;
	2)
		#安装emqx
		echoN "安装emqx"
		installEmqx
		;;
	3)
		#安装redis
		installRedis
		;;
	4)
		#安装map
		installGooglemap
		;;
	5)
        installMysql
		;;
	6)
		#安装oam
#		installOam
        installOamUpdateByCfg
		;;
	7)
		#安装hosts
		installHosts
		;;
	8)
		#安装调度台前端
#		installIcssFront
		installDispFrontUpdateByCfg
		;;
	9)
		#安装调度台后台
#		installIcssBack
		installDispBackUpdateByCfg
		;;
	10)
		#初始化数控
		initMysql
		;;
	11)
		#安装自启动
		installRclocal
		;;
	13)
		#安装网管前端
#		installNmsFront
		installNmsFrontUpdateByCfg
		;;
	14)
		#安装网管后台
#		installNmsBack
		installNmsBackUpdateByCfg
		;;
	15)
		#安装微服务
        installMicroUpdateByCfg
		;;
	16)
		#安装 网管gateway
#		installGateway
		installGatewayUpdateByCfg
		;;
	17)
		#安装 tcpdump
		installTcpdump
		;;
	20)
	    # 20 离线安装KMS
		offlineInstallKms
		;;
    21)
	    # 21. 离线安装curl(模拟消息)
        offlineInstallCurl
		;;
    22)
	    # 22. 离线安装jq(解析json)
		offlineInstallJq
		;;
    23)
	    # 23. 离线安装emqx 桥接
		installEmqxBridge
		;;
    24)
	    # 23. 离线安装核心网
		offlineInstallSwitch
		;;
    25)
	    # 23. 离线安装核心网 + 调度
		offlineInstallSwitchAndIcss
		;;
    26)
	    # 24. 离线安装OMC
		offlineInstallTomcat
		;;
    27)
        # 24. 安装区交基站网关
        installAreaSwitchGateway
        ;;
    28)
        # 24. 安装移交基站网关
        installMobileSwitchGateway
        ;;
    29)
        # 25. 安装common库
        offlineInstallSwitchCommonLib
        ;;
    30)
        # 30. 安装emqx 土狗
        offlineInstallEmqxWatchLog
        ;;
    31)
        # 30. 安装ftp
        offlineInstallFtp
        ;;
    32)
        # 30. 安装 java
        installJDK
        ;;
	esac

}


function runMenu(){
#	echo "--------一键脚本（$systemVersion）$version---------------"
	eval echo $shellHeader
    sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/runMenu/runMenu.txt
    if [ "$ifShowHiddenFunction" -eq 1 ];then
        echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/runMenu/runMenu.txt`
    elif [ "$ifShowHiddenFunction" -eq 0 ];then
        echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/runMenu/runMenu.txt | grep -v "#"`
    fi

	read -p "请输入对应命令编号：(Ctrl+C 取消)" menuNum
	echo ""
	case $menuNum in
	1)
		#停止nginx
		stopNginx
		;;
	2)
		#重启nginx
		restartNginx
		;;
	3)
		#停止redis
		stopRedis
		;;
	4)
		#重启redis
		restartRedis
		;;
	5)
		#停止mysql
		stopMysql
		;;
	6)
		#重启mysql
		restartMysql
		;;
    7)
		#停止emqx
		stopEmqx
		;;
	8)
		#重启emqx
		restartEmqx
		;;
	9)
		#停止微服务
		stopMicro
		;;
	10)
		#重启微服务
		restartMicro
		;;
	11)
		#停止网管
		stopNms
		;;
	12)
		#重启网管
		restartNms
		;;
	13)
		#停止网管gateway
		stopGateway
		;;
	14)
		#重启网管gateway
		restartGateway
		;;
    15)
		#停止调度软件
		stopIcssSoftware
		;;
	16)
		#重启调度软件
		restartIcssSoftware
		;;
	17)
		#停止 KMS
		stopKms
		;;
	18)
		#重启 KMS
		restartKms
		;;
    19)
		#停止 recording
		stopRecording
		;;
    20)
		#重启 recording
		restartRecording
		;;
    21)
        # echo "21. 停止 emqx 桥接"
		stopEmqxBridge
		;;
    22)
        # echo "22. 重启 emqx 桥接"
		restartEmqxBridge
		;;
    23)
        # echo "22. 重启 tomcat"
		restartTomcat
		;;
	esac

}


function otherMenu() {
#	echo "--------一键脚本（$systemVersion）$version---------------"
	eval echo $shellHeader
    sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/otherMenu/otherMenu.txt
    if [ "$ifShowHiddenFunction" -eq 1 ];then
        echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/otherMenu/otherMenu.txt`
    elif [ "$ifShowHiddenFunction" -eq 0 ];then
        echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/otherMenu/otherMenu.txt | grep -v "#"`
    fi

	read -p "请输入对应命令编号：(Ctrl+C 取消)" menuNum
	echo ""

	case $menuNum in
	1)
		#查看本级所有IP
		allLocalIp=(`getAllIpLocalServerFromKylinReturnStrList`)
		allLocalIpLen=${#allLocalIp[*]}
		for((i=0;i<allLocalIpLen;i++));
		do
            echoN "$i. ${allLocalIp[$i]}"
		done
		;;
	2)
        starTime=`date +%s`
		#查看同网段所有可ping通IP
		sameNetAllAvailableIp=`getSameNetAllAvailableIpReturnStrList $localIp`
		if [[ "$sameNetAllAvailableIp" == "0" ]];then
		    echoE "同网段无可用ip"
		else
		    echo "同网段可用ip=  $sameNetAllAvailableIp"
		fi
		sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
        for((i=0;i<sameNetAllAvailableIpLen;i++));
        do
            echoN "$i. ${sameNetAllAvailableIp[$i]}"
        done

        endTime=`date +%s`
        echoN "用时：`expr $endTime - $starTime` 秒"
		;;
	3)
	    echo "3. 引导用户"
	    guideUserNew
	    ;;
	4)
	    echo "3. 批量装基础软件"
        echoN '>>>>>>>>>>>>批量装基础软件'
        startTimeBase=$(date +"%Y-%m-%d %H:%M:%S")
        sys_startTimeBase=$(date -d "$startTimeBase" +%s)
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

        installNginx
        installEmqx
        installRedis
        installGooglemap
        installMysql
        initMysql
        installOam
        installHosts
        installRclocal
        installTcpdump
        offlineInstallKms
        installMicro

        #打印时间
        endTimeBase=$(date +"%Y-%m-%d %H:%M:%S")
        sys_endTimeBase=$(date -d "$endTimeBase" +%s)
        timeSupBase=`expr $sys_endTimeBase - $sys_startTimeBase`
        colorEcho "用时:" $nomal_info $timeSupBase "秒"
	    ;;
	5)
	    echo "5. 批量装调度"
	    echoN '>>>>>>>>>>>>批量装调度'
        startTimeIcss=$(date +"%Y-%m-%d %H:%M:%S")
        sys_startTimeIcss=$(date -d "$startTimeIcss" +%s)

        # 给项目自动创建文件夹
        crateProjectFolder
        installIcssFront
        installIcssBack_mergeVersion

        #打印时间
        endTimeIcss=$(date +"%Y-%m-%d %H:%M:%S")
        sys_endTimeIcss=$(date -d "$endTimeIcss" +%s)
        timeSupIcss=`expr $sys_endTimeIcss - $sys_startTimeIcss`
        colorEcho "用时:" $nomal_info $timeSupIcss "秒"
	    ;;
	6)
	    echo "6. 批量装网管"
	    echoN '>>>>>>>>>>>>批量装调度'
        startTimeNms=$(date +"%Y-%m-%d %H:%M:%S")
        sys_startTimeNms=$(date -d "$startTimeNms" +%s)

        # 给项目自动创建文件夹
        crateProjectFolder
        installGatewayUpdateByCfg
        installNmsFront
        installNmsBack

        #打印时间
        endTimeNms=$(date +"%Y-%m-%d %H:%M:%S")
        sys_endTimeNms=$(date -d "$endTimeNms" +%s)
        timeSupNms=`expr $sys_endTimeNms - $sys_startTimeNms`
        colorEcho "用时:" $nomal_info $timeSupNms "秒"
	    ;;
	7)
	    echo "7. 删除调度数据"
	    deleteDataIcss
	    ;;
	8)
	    echo "8. 删除网管数据"
	    deleteDataNms
	    ;;
    9)
	    echo "9. 删除核心网数据"
	    deleteDataSwitch
	    ;;
    10)
        echo "10. 设置系统时间"
        setLocalServerDate
        ;;
    11)
        echo "11. 根据配置文件修改 - 合并版本网管配置"
        updateNmsCfg_mergeVersion
        ;;
    12)
	    echo "12. 根据配置文件修改 - 非合并版本网管配置(正样版本)"
        updateNmsCfg_notMergeVersion
        ;;
    13)
	    echo "13. 根据配置文件修改 - 合并版本调度配置(正样版本)"
        updateICssCfg_mergeVersion
        ;;
    14)
	    echo "14. 根据配置文件修改 - 非合并版本调度配置"
        updateICssCfg_notMergeVersion
        ;;
    15)
	    echo "15. 批量启动基础软件"
        #batchRestartBaseService
        restartNginx
        restartEmqx
        restartMysql
        restartKms
        restartRedis  # redis启动后会退出，所以放在最后！
        ;;
    16)
	    echo "16.  批量启动微服务"
        #batchRestartMicro
        restartMicro
        ;;
    17)
	    echo "17.  批量启动网管"
        #batchRestartNms
        restartGateway
        restartNms
        ;;
    18)
	    echo "18.  批量启动调度"
        #batchRestartIcss
        restartIcssSoftware
        ;;
    19)
	    echo "19.  卸载mysql"
        removeMysql
        ;;
    20)
        echo "20. 插入调度台虚拟号码"
        addIcssViturlNumber
        ;;
    21)
	    echo "21. 插入调度台默认号码(默认 18866668888)"
        addIcssdefaultNumber
        ;;
    22)
	    echo "22. 更新recording并重启"
        updateRecording
        ;;
    23)
	    echo "23. 查找大文件"
        findBigFile
        ;;
    24)
        echo "24. 移除kms"
        removeKms
        ;;
    25)
        echo "25. 安装自定义命令"
        installMyshell
        ;;
    26)
        echo "26. 关闭虚拟网卡"
        closeVirbr0
        ;;
    27)
        echo "27. 配置网卡ip"
        setIp
        ;;
    28)
        echo "28. 设置时间同步"
        setDatetimeSync
        ;;
	29)
        echo "29. 卸载mysql"
        removeMysql
        ;;
    30)
            echo "30. NE目录加权限"
        addPrivilegesNE
        ;;
    31)
        echo "31. 关闭selinux"
        closeSelinux
        ;;
	esac
}


function findReasonMenu(){
#    echo "--------一键脚本（$systemVersion）$version---------------"
    eval echo $shellHeader

    sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/findReasonMenu/findReasonMenu.txt
    if [ "$ifShowHiddenFunction" -eq 1 ];then
        echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/findReasonMenu/findReasonMenu.txt`
    elif [ "$ifShowHiddenFunction" -eq 0 ];then
        echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/findReasonMenu/findReasonMenu.txt | grep -v "#"`
    fi

    read -p "请输入对应命令编号：(Ctrl+C 取消)" menuNum
	case $menuNum in
	1)
#	    echo "--------一键脚本（$systemVersion）$version---------------"
	    eval echo $shellHeader
        sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/findReasonMenu/serviceCantRunMenu.txt
        if [ "$ifShowHiddenFunction" -eq 1 ];then
            echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/findReasonMenu/serviceCantRunMenu.txt`
        elif [ "$ifShowHiddenFunction" -eq 0 ];then
            echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/findReasonMenu/serviceCantRunMenu.txt | grep -v "#"`
        fi

        read -p "请输入对应命令编号：(Ctrl+C 取消)" menuNum
        echo ""
        case $menuNum in
        1)
            echo "1. 所有都无法启动"
            # 0. 微服务能否ping通
            echoN "检测 微服务能否ping通"
            if [[ `checkIpIsConnect $microIp` == '0' ]];then
                echoE "原因：微服务ip ping不通！"
                return
            fi

            # 1. 软件安装包是否有
            echoN "检测 软件安装包是否有"
            if [[ ! -f "$microOfflinePakagePath" ]];then
                echoE "原因：微服务安装包没有！"
                return
            fi

            # 2. 软件文件夹是否有
            echoN "检测 微服务文件夹是否有"
            if [[ ! -d "$projectPath/micro" ]];then
                echoE "原因：微服务文件夹没有！"
                return
            fi

            # 3. 启动脚本大小是否有内容，是否0字节。
            echoN "检测 启动脚本大小是否有内容，是否0字节"
            if [[ ! -f "$projectPath/micro/runAll.sh" ]];then
                echoE "原因：没有启动脚本！"
                return
            fi

            if [[ `du -s $projectPath/micro/runAll.sh | awk '{print $1}'` == '0' ]];then
                echoE "原因：微服务启动脚本0字节！"
                return
            fi

            # 4. 启动脚本是否有权限
            echoN "检测 启动脚本是否有权限"
            if [[ -z `ls -l $projectPath/micro/runAll.sh | awk '{print $1}' | grep -Eo 'rwxr'` ]];then
                echoE "原因：微服务启动脚本无权限！"
                return
            fi

            # 5. 自启动脚本是否有权限
            echoN "检测 自启动脚本是否有权限"
            if [[ -z `ls -l /etc/rc.local | awk '{print $1}' | grep -Eo 'rwxr'` ]];then
                echoE "原因：自启动脚本无权限！"
                return
            fi

            # 6. 自启动脚本是否 启动微服务
            echoN "检测 自启动脚本是否 启动微服务"
            if [[ `cat /etc/rc.local | grep './.runMicro'` =~ '\#' ]];then
                echoE "原因：自启动脚本注释了 启动微服务！"
                return
            fi

            # 0. 网管能否ping通
            echoN "检测 网管能否ping通"
            if [[ `checkIpIsConnect $nmsIp` == '0' ]];then
                echoE "原因：网管ip ping不通！"
                return
            fi

            # 1. 软件安装包是否有
            echoN "检测 网管软件安装包是否有"
            if [[ ! -f "$nmsBackOfflinePakagePath" ]];then
                echoE "原因：网管服务安装包没有！"
                return
            fi

            # 2. 软件文件夹是否有
            echoN "检测 网管服务文件夹是否有"
            if [[ ! -d "$projectPath/nms/backend" ]];then
                echoE "原因：网管服务文件夹没有！"
                return
            fi

            # 3. 启动脚本大小是否有内容，是否0字节。
            echoN "检测 启动脚本大小是否有内容，是否0字节"
            if [[ ! -f "$projectPath/nms/backend/runAll.sh" ]];then
                echoE "原因：没有启动脚本！"
                return
            fi

            if [[ `du -s $projectPath/nms/backend/runAll.sh | awk '{print $1}'` == '0' ]];then
                echoE "原因：网管服务启动脚本0字节！"
                return
            fi

            # 4. 启动脚本是否有权限
            echoN "检测 启动脚本是否有权限"
            if [[ -z `ls -l $projectPath/nms/backend/runAll.sh | awk '{print $1}' | grep -Eo 'rwxr'` ]];then
                echoE "原因：网管服务启动脚本无权限！"
                return
            fi

            # 5. 自启动脚本是否有权限
            echoN "检测 自启动脚本是否有权限"
            if [[ -z `ls -l /etc/rc.local | awk '{print $1}' | grep -Eo 'rwxr'` ]];then
                echoE "原因：自启动脚本无权限！"
                return
            fi

            # 6. 自启动脚本是否 启动网管
            echoN "检测 自启动脚本是否 启动网管"
            if [[ `cat /etc/rc.local | grep './.runNms'` =~ '\#' ]];then
                echoE "原因：自启动脚本注释了 启动网管！"
                return
            fi

            # 0. 调度能否ping通
            echoN "检测 调度能否ping通"
            if [[ `checkIpIsConnect $icssIp` == '0' ]];then
                echoE "原因：调度ip ping不通！"
                return
            fi

            # 1. 软件安装包是否有
            echoN "检测 调度软件安装包是否有"
            if [[ ! -f "$icssBackOfflinePakagePath" ]];then
                echoE "原因：调度服务安装包没有！"
                return
            fi

            # 2. 软件文件夹是否有
            echoN "检测 调度服务文件夹是否有"
            if [[ ! -d "/root/.NE" ]];then
                echoE "原因：调度服务文件夹没有！"
                return
            fi

            # 3. 启动脚本大小是否有内容，是否0字节。
            echoN "检测 启动脚本大小是否有内容，是否0字节"

            if [[ `du -s /root/.NE/*/neStart.sh | awk '{print $1}'` == '0' ]];then
                echoE "原因：调度服务启动脚本0字节！"
                return
            fi

            # 4. 启动脚本是否有权限
            echoN "检测 启动脚本是否有权限"
            if [[ -z `ls -l /root/.NE/*/*.sh | awk '{print $1}' | grep -Eo 'rwxr'` ]];then
                echoE "原因：调度服务启动脚本无权限！"
                return
            fi

            # 5. 自启动脚本是否有权限
            echoN "检测 自启动脚本是否有权限"
            if [[ -z `ls -l /etc/rc.local | awk '{print $1}' | grep -Eo 'rwxr'` ]];then
                echoE "原因：自启动脚本无权限！"
                return
            fi

            # 6. 自启动脚本是否 启动调度
            echoN "检测 自启动脚本是否 启动调度"
            if [[ `cat /etc/rc.local | grep './.runIcss'` =~ '\#' ]];then
                echoE "原因：自启动脚本注释了 启动调度！"
                return
            fi

            echoR "结果：检测没问题"
            ;;
        2)
            echo "选择2. 微服务无法启动"
            # 0. 微服务能否ping通
            echoN "检测 微服务能否ping通"
            if [[ `checkIpIsConnect $microIp` == '0' ]];then
                echoE "原因：微服务ip ping不通！"
                return
            fi

            # 1. 软件安装包是否有
            echoN "检测 软件安装包是否有"
            if [[ ! -f "$microOfflinePakagePath" ]];then
                echoE "原因：微服务安装包没有！"
                return
            fi

            # 2. 软件文件夹是否有
            echoN "检测 微服务文件夹是否有"
            if [[ ! -d "$projectPath/micro" ]];then
                echoE "原因：微服务文件夹没有！"
                return
            fi

            # 3. 启动脚本大小是否有内容，是否0字节。
            echoN "检测 启动脚本大小是否有内容，是否0字节"
            if [[ ! -f "$projectPath/micro/runAll.sh" ]];then
                echoE "原因：没有启动脚本！"
                return
            fi

            if [[ `du -s $projectPath/micro/runAll.sh | awk '{print $1}'` == '0' ]];then
                echoE "原因：微服务启动脚本0字节！"
                return
            fi

            # 4. 启动脚本是否有权限
            echoN "检测 启动脚本是否有权限"
            if [[ -z `ls -l $projectPath/micro/runAll.sh | awk '{print $1}' | grep -Eo 'rwxr'` ]];then
                echoE "原因：微服务启动脚本无权限！"
                return
            fi

            # 5. 自启动脚本是否有权限
            echoN "检测 自启动脚本是否有权限"
            if [[ -z `ls -l /etc/rc.local | awk '{print $1}' | grep -Eo 'rwxr'` ]];then
                echoE "原因：自启动脚本无权限！"
                return
            fi

            # 6. 自启动脚本是否 启动微服务
            echoN "检测 自启动脚本是否 启动微服务"
            if [[ `cat /etc/rc.local | grep './.runMicro'` =~ '\#' ]];then
                echoE "原因：自启动脚本注释了 启动微服务！"
                return
            fi
            echoR "结果：检测没问题"
            ;;
        3)
            echo "3. 网管无法启动"
            # 0. 网管能否ping通
            echoN "检测 网管能否ping通"
            if [[ `checkIpIsConnect $nmsIp` == '0' ]];then
                echoE "原因：网管ip ping不通！"
                return
            fi

            # 1. 软件安装包是否有
            echoN "检测 网管软件安装包是否有"
            if [[ ! -f "$nmsBackOfflinePakagePath" ]];then
                echoE "原因：网管服务安装包没有！"
                return
            fi

            # 2. 软件文件夹是否有
            echoN "检测 网管服务文件夹是否有"
            if [[ ! -d "$projectPath/nms/backend" ]];then
                echoE "原因：网管服务文件夹没有！"
                return
            fi

            # 3. 启动脚本大小是否有内容，是否0字节。
            echoN "检测 启动脚本大小是否有内容，是否0字节"
            if [[ ! -f "$projectPath/nms/backend/runAll.sh" ]];then
                echoE "原因：没有启动脚本！"
                return
            fi

            if [[ `du -s $projectPath/nms/backend/runAll.sh | awk '{print $1}'` == '0' ]];then
                echoE "原因：网管服务启动脚本0字节！"
                return
            fi

            # 4. 启动脚本是否有权限
            echoN "检测 启动脚本是否有权限"
            if [[ -z `ls -l $projectPath/nms/backend/runAll.sh | awk '{print $1}' | grep -Eo 'rwxr'` ]];then
                echoE "原因：网管服务启动脚本无权限！"
                return
            fi

            # 5. 自启动脚本是否有权限
            echoN "检测 自启动脚本是否有权限"
            if [[ -z `ls -l /etc/rc.local | awk '{print $1}' | grep -Eo 'rwxr'` ]];then
                echoE "原因：自启动脚本无权限！"
                return
            fi

            # 6. 自启动脚本是否 启动网管
            echoN "检测 自启动脚本是否 启动网管"
            if [[ `cat /etc/rc.local | grep './.runNms'` =~ '\#' ]];then
                echoE "原因：自启动脚本注释了 启动网管！"
                return
            fi
            echoR "结果：检测没问题"
            ;;
        4)
            echo "4. 调度无法启动"
            # 0. 调度能否ping通
            echoN "检测 调度能否ping通"
            if [[ `checkIpIsConnect $icssIp` == '0' ]];then
                echoE "原因：调度ip ping不通！"
                return
            fi

            # 1. 软件安装包是否有
            echoN "检测 调度软件安装包是否有"
            if [[ ! -f "$icssBackOfflinePakagePath" ]];then
                echoE "原因：调度服务安装包没有！"
                return
            fi

            # 2. 软件文件夹是否有
            echoN "检测 调度服务文件夹是否有"
            if [[ ! -d "/root/.NE" ]];then
                echoE "原因：调度服务文件夹没有！"
                return
            fi

            # 3. 启动脚本大小是否有内容，是否0字节。
            echoN "检测 启动脚本大小是否有内容，是否0字节"

            if [[ `du -s /root/.NE/*/neStart.sh | awk '{print $1}'` == '0' ]];then
                echoE "原因：调度服务启动脚本0字节！"
                return
            fi

            # 4. 启动脚本是否有权限
            echoN "检测 启动脚本是否有权限"
            if [[ -z `ls -l /root/.NE/*/*.sh | awk '{print $1}' | grep -Eo 'rwxr'` ]];then
                echoE "原因：调度服务启动脚本无权限！"
                return
            fi

            # 5. 自启动脚本是否有权限
            echoN "检测 自启动脚本是否有权限"
            if [[ -z `ls -l /etc/rc.local | awk '{print $1}' | grep -Eo 'rwxr'` ]];then
                echoE "原因：自启动脚本无权限！"
                return
            fi

            # 6. 自启动脚本是否 启动调度
            echoN "检测 自启动脚本是否 启动调度"
            if [[ `cat /etc/rc.local | grep './.runIcss'` =~ '\#' ]];then
                echoE "原因：自启动脚本注释了 启动调度！"
                return
            fi
            echoR "结果：检测没问题"
            ;;
        5)
            ## 1. 检测redis 6380端口是否启动
            echoN "检测redis 6380端口是否启动"
            redisPortIsStart=`checkPortIsStart 6380`
            if [[ $redisPortIsStart == "0" ]];then
                echoE "原因：redis 端口没起"
                return
            fi

             ## 2. 检测网管ip是否可ping通
            echoN "检测网管ip是否可ping通"
            ipIsConnect=`checkIpIsConnect $nmsIp`
            if [[ $ipIsConnect == "0" ]];then
                echoE "原因：网管ip ping不通"
                return
            fi

            ## 3. 检测网管ip是否可ping通
            echoN "检测调度ip是否可ping通"
            ipIsConnect=`checkIpIsConnect $icssIp`
            if [[ $ipIsConnect == "0" ]];then
                echoE "原因：调度ip ping不通"
                return
            fi

            ## 4. 检测配置项目 gateway.com，查看ocr能否连
            echoN "检测配置项目 gateway.com，查看ocr能否连"
            ocrIp=`getIpFromDns "gateway.com"`
            if [[ $ocrIp == "127.0.0.1" ]];then
    # 	        echoN " gateway.com== 127.0.0.1"
                ocrIp=$localIp
            fi
            echoN "orcIP ==$ocrIp"

            # 检测ocr数据库是否可连接
            checkDbCanConnect $ocrIp $softwareDbUsername $softwareDbpassword
            if [[ $? == "0" ]];then
                echoE "原因：ocr 数据库连不上"
                return
            fi

            # 5. 检测配置项目 group.com，查看 presence 能否连
            echoN "检测配置项目 group.com，查看 presence 能否连"
            presenceIp=`getIpFromDns "group.com"`
            if [[ $presenceIp == "127.0.0.1" ]];then
    # 	        echoN " group.com== 127.0.0.1"
                presenceIp=$localIp
            fi
            echoN "presenceIp == $presenceIp"

            # 检测 presence 数据库是否可连接
            checkDbCanConnect $presenceIp $softwareDbUsername $softwareDbpassword
            if [[ $? == "0" ]];then
                echoE "原因：presence 数据库连不上"
                return
            fi

            # 6. 检测配置项目 group.com，查看 imserver 能否连
            echoN "检测配置项目 group.com，查看 imserver 能否连"
            imserverIp=`getIpFromDns "group.com"`
            if [[ $imserverIp == "127.0.0.1" ]];then
    # 	        echoN " group.com== 127.0.0.1"
                imserverIp=$localIp
            fi
            echoN "imserverIp == $imserverIp"

            # 检测ocr数据库是否可连接
            checkDbCanConnect $imserverIp $softwareDbUsername $softwareDbpassword
            if [[ $? == "0" ]];then
                echoE "原因：imserver 数据库连不上"
                return
            fi

            # 7. 检测配置项目 mysql.com，查看 2011_resource_service 能否连
            echoN "检测配置项目 mysql.com，查看 2011_resource_service 能否连"
            mysqlIp=`getIpFromDns "mysql.com"`
            if [[ $mysqlIp == "127.0.0.1" ]];then
    # 	        echoN " mysql.com== 127.0.0.1"
                mysqlIp=$localIp
            fi
    #        echoE "mysqlIp == $mysqlIp"

            # 检测 2011_resource_service 数据库是否可连接
            getDbAllDatabases $mysqlIp $softwareDbUsername $softwareDbpassword
            if [[ ! `getDbAllDatabases $mysqlIp $softwareDbUsername $softwareDbpassword` =~ "2011_resource_service" ]];then
                echoE "原因：2011_resource_service 数据库连不上"
                return
            fi

            # 8. 检测 2011_statistic_service 数据库是否可连接
            getDbAllDatabases $mysqlIp $softwareDbUsername $softwareDbpassword
            if [[ ! `getDbAllDatabases $mysqlIp $softwareDbUsername $softwareDbpassword` =~ "2011_statistic_service" ]];then
                echoE "原因：2011_statistic_service 数据库连不上"
                return
            fi

            echoR "结果：检测没问题"
            ;;
        esac
	    ;;
    2)
#	    echo "--------一键脚本（$systemVersion）$version---------------"
	    eval echo $shellHeader
        sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/findReasonMenu/cantLoginMenu.txt
        if [ "$ifShowHiddenFunction" -eq 1 ];then
            echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/findReasonMenu/cantLoginMenu.txt`
        elif [ "$ifShowHiddenFunction" -eq 0 ];then
            echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/findReasonMenu/cantLoginMenu.txt | grep -v "#"`
        fi

        read -p "请输入对应命令编号：(Ctrl+C 取消)" menuNum
        echo ""
        case $menuNum in
        1)
            echoR "查看网管服务启动没？"
            checkPortIsStart 7000
            if [[ $? == '0' ]];then
                echoE "注册中心7000端口未启动"
                return
            fi

            checkPortIsStart 7001
            if [[ $? == '0' ]];then
                echoE "注册中心7001端口未启动"
                return
            fi

            checkPortIsStart 7010
            if [[ $? == '0' ]];then
                echoE "配置中心7010端口未启动"
                return
            fi

            checkPortIsStart 7100
            if [[ $? == '0' ]];then
                echoE "安全管理服务7100端口未启动"
                return
            fi
            echoR "检测没问题"
            ;;
        2)
            echoR "查看调度服务启动没？"
            checkPortIsStart 1000
            if [[ $? == '0' ]];then
                echoE "group 1000端口未启动"
                return
            fi

            checkPortIsStart 7090
            if [[ $? == '0' ]];then
                echoE "dds 7090端口未启动"
                return
            fi

            checkPortIsStart 8090
            if [[ $? == '0' ]];then
                echoE "dispatcher 8090端口未启动"
                return
            fi
            echoR "检测没问题"
            ;;
        esac
	    ;;
    3)
#	    echo "--------一键脚本（$systemVersion）$version---------------"
	    eval echo $shellHeader

	    sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/findReasonMenu/dispNoVedioMenu.txt
        if [ "$ifShowHiddenFunction" -eq 1 ];then
            echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/findReasonMenu/dispNoVedioMenu.txt`
        elif [ "$ifShowHiddenFunction" -eq 0 ];then
            echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/findReasonMenu/dispNoVedioMenu.txt | grep -v "#"`
        fi

        read -p "请输入对应命令编号：(Ctrl+C 取消)" menuNum
        echo ""
        case $menuNum in
        1)
            echo "选择1. 调度台通话没音"
            echoE "使用的电脑关闭防火墙！"
            echoE "抓个包！"
            ;;
        esac
	    ;;
    *)
        echo "序号不支持。。。。。"
        ;;
    esac

}


function autoUpdateMenu(){
#    echo "--------一键脚本（$systemVersion）$version---------------"
    eval echo $shellHeader
    sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/autoUpdateMenu/autoUpdateMenu.txt
    if [ "$ifShowHiddenFunction" -eq 1 ];then
        echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/autoUpdateMenu/autoUpdateMenu.txt`
    elif [ "$ifShowHiddenFunction" -eq 0 ];then
        echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/autoUpdateMenu/autoUpdateMenu.txt | grep -v "#"`
    fi

    read -p "请输入对应命令编号：(Ctrl+C 取消)" updateMenuNum
    case $updateMenuNum in
	1)
	    echo "没做"
	    ;;
    2)
	    echo "2. 更新调度 dispatcher"
	    local list=(`getFileListFromPath $updatePackagesPath`)  # 转数组
	    local listLen=${#list[@]}
	    # 1. 打印所有list
	    echoN "更新包如下："
        for((i=0;i<listLen;i++))
        do
            echoN "$i. ${list[$i]}"
        done
        read -p "请选择更新包(选序号):" updatePackageIndex

        # 2. 判断用户选的对不对
        if [ `check_digits $updatePackageIndex` -eq 1 ];then
            echoN "用户输入正确，继续"
            echoN "用户输入更新包，${list[$updatePackageIndex]}"

            # 3. 判断该程序是否存在，停掉服务
            # 切换目录，oamls 查不到，让用户自己输入目录
            if [[ "$updatePackageIndex" =~ ^[0-9]|[1][0-9]|[20]$ ]];then  # 1-20 调度预留
                echoN "用户选择1-20，调度预留"
                local softwareFullname=`oamls dispatcher`  # 257-1(dispatcher|0.0.1)
                local softwareNEName=${softwareFullname%'('*}   # 257-1
                local softwareNEName=257-1   # 257-1
                echoN "NE name== $softwareNEName"
                cd /root/.NE/$softwareNEName
                #### 如果ne不存在，让用户自己输入

                # 4. 停掉服务， 自动寻找启动服务程序，没有自行pkill
                local grepNEShellFullname=`grep -d skip '#!/bin/' * | grep -v 'neStart.sh'`  # 查看是否有启动脚本 dispatcher:#!/bin/sh
                local neShellName=${grepNEShellFullname%:*}
                echoN "脚本名称 $neShellName"
                ./$neShellName stop

                # 5. 判断选择的压缩包对不对，不对提示用户
                # 6. 在文件目录自动创建backup文件夹，判断有没有jar包，如果有，将jar包移动进去
                mkdir -vp backup
                local jarName=`ls | grep jar`
                echoN "jarfile=== $jarName"
                if [ -n "$jarName" ];then
                    mv $jarName backup/
                fi

                # 7. 解压压缩包，有什么文件替换什么文件
                unzipFile $projectPath/installPackages/updatePackages/${list[$updatePackageIndex]} /root/.NE/$softwareNEName

                # 将更新文件转成unix格式
                sed -i 's/\r//' update.txt

                if [ -f 'update.txt' ];then
#
                    local grepUpdateFileName=`grep 'file1' update.txt`
                    echo "grepUpdateFileName ========= $grepUpdateFileName"
                    updateFileName="${grepUpdateFileName#*=}"  # 要修改的配置文件名称  file1=aa.txt 截取右半边
                    while read line
                    do
                        echoN "进入循环"
                        echo "line== $line"
                        k=${line%=*}
                        v=${line#*=}
                        echo "$k :  $v"
                        echoN "进行替换"
                        cd /root/.NE/$softwareNEName
                        sed -i "s#$k.*#$k=$v#g" $updateFileName

                    done  < update.txt
                fi

                # 9. 重启服务器
            fi
        else
            echoE "用户输入非数字，退出"
            return 0
        fi
	    ;;
    *)
        echo "序号不支持。。。。。"
        ;;
    esac
}


################ 执行程序--------------------------------------------------------------------------- #
menu  # 主菜单
