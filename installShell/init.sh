#!/bin/bash


function addShellPrivileges(){
    chmod 777 *
    chmod 777 conf_template/*
}

function setDefaultVar(){  # 参考onekey.cfg
    # [部署相关]
    if [ "$systemVersion" == "" ];then
        echoE "读不到 systemVersion"
        systemVersion="centos7"
    fi
    if [ "$ifGuideUser" == "" ];then
        ifGuideUser="1"
    fi
    if [ "$deviceType" == "" ];then
        deviceType="2"
    fi
    if [ "$cardType" == "" ];then
        cardType="1"
    fi
    if [ "$ifDistributed" == "" ];then
        ifDistributed="0"
    fi
    if [ "$preInstallService" == "" ];then
        preInstallService="1"
    fi
    if [ "$isNetworking" == "" ];then
        isNetworking="1"
    fi
    if [ "$networkElementInstallType" == "" ];then
        networkElementInstallType="1"
    fi

    # [检测服务相关]
    if [ "$baseService" == "" ];then
        echoE "读不到 baseService"
        baseService=(mysql nginx redis redis emqx oam kurento-media-server)
    fi
    if [ "$baseServicePort" == "" ];then
        baseServicePort=(3306 80 6379 6380 1883 6124 8888)
    fi
    if [ "$microService" == "" ];then
        microService=(sun-nms-config register register)
    fi
    if [ "$microServicePort" == "" ];then
        microServicePort=(7010 7000 7001)
    fi
    if [ "$icssService" == "" ];then
        icssService=(webrtc recording group imserver presence dcsg dds agw dispatcher)
    fi
    if [ "$icssServicePort" == "" ];then
        icssServicePort=(8090 8021 1000 5090 5065 5085 7090 5070 8090)
    fi
    if [ "$nmsService" == "" ];then
        nmsService=(nms-resource-alarm-service  nms-user-hss-organization-service alarm nms-hss-proxy organization nms-user security devconfig  resource statistic oam-nms-gw)
    fi
    if [ "$nmsServicePort" == "" ];then
        nmsServicePort=(6789 7335 7110 9523 7125 7330 7100 11000 7105 7120 8324)
    fi
    if [ "$switchService" == "" ];then
        switchService=(agw pdt mgc mp pcscf scscf vcs sipgw ss7g recording recoding isup smsSecGW scgw e1hdlc ggsn smsc vdcsg cc cdgw lz psip)
    fi
    if [ "$switchServicePort" == "" ];then
        switchServicePort=(7101 3401 8882 20000 4060 6060 7800 5060 5060 8021 8021 7892 13579 8000 12345 7801 7900 9121 6003 5066 9654 5066)
    fi

    # [ip相关]
    if [ "$localIp" == "" ];then
        echoE "读不到 localIp"
        localIp="127.0.0.1"
    fi
    if [ "$mysqlIp" == "" ];then
        mysqlIp="127.0.0.1"
    fi
    if [ "$microIp" == "" ];then
        microIp="127.0.0.1"
    fi
    if [ "$emqIp" == "" ];then
        emqIp="127.0.0.1"
    fi
    if [ "$redisIp" == "" ];then
        redisIp="127.0.0.1"
    fi
    if [ "$northEmqxIp" == "" ];then
        northEmqxIp="127.0.0.1"
    fi
    if [ "$icssIp" == "" ];then
        icssIp="127.0.0.1"
    fi
    if [ "$northIcssIp" == "" ];then
        northIcssIp="127.0.0.1"
    fi
    if [ "$unitFirstLevelIp" == "" ];then
        unitFirstLevelIp="127.0.0.1"
    fi
    if [ "$unitSecondLevelIp" == "" ];then
        unitSecondLevelIp="127.0.0.1"
    fi
    if [ "$unitThirdLevelIp" == "" ];then
        unitThirdLevelIp="127.0.0.1"
    fi
    if [ "$unitFourthLevelIp" == "" ];then
        unitFourthLevelIp="127.0.0.1"
    fi
    if [ "$unitFifthLevelIp" == "" ];then
        unitFifthLevelIp="127.0.0.1"
    fi
    if [ "$nmsIp" == "" ];then
        nmsIp="127.0.0.1"
    fi
    if [ "$upLevelNmsIp" == "" ];then
        upLevelNmsIp="127.0.0.1"
    fi
    if [ "$switchIp" == "" ];then
        switchIp="127.0.0.1"
    fi
    if [ "$redisPort" == "" ];then
        redisPort="6380"
    fi
    if [ "$hssProxyPort" == "" ];then
        hssProxyPort="6380"
    fi

    # [调度+网管目录相关]
    if [ "$projectPath" == "" ];then
        echoE "读不到 projectPath"
        projectPath="/home/2011"
    fi
    if [ "$nmsFrontPath" == "" ];then
        nmsFrontPath="$projectPath/nms/front/dist"
    fi
    if [ "$icssFrontPath" == "" ];then
        icssFrontPath="$projectPath/disp/dist"
    fi

    # [日志相关]
    if [ "$logfile" == "" ];then
        echoE "读不到 logfile"
        logfile="$projectPath/basesoftware/installShell/shell.log"
    fi

    # [安装文件相关]
    if [ "$nginxOfflinePakagePath" == "" ];then
        echoE "读不到 nginxOfflinePakagePath"
        nginxOfflinePakagePath="$projectPath/basesoftware/nginx/nginx.tar.gz"
    fi
    if [[ -z "$nginxInstallPath" || "$nginxInstallPath" == " " ]];then
        nginxInstallPath="/usr/local"
    fi
    if [ "$redisOfflinePakagePath" == "" ];then
        redisOfflinePakagePath="$projectPath/basesoftware/redis/redis-5.0.3.tar.gz"
    fi
    if [ "$redisInstallPath" == "" ];then
        redisInstallPath="/usr/local"
    fi
    if [ "$emqxOfflinePakagePath" == "" ];then
        emqxOfflinePakagePath="$projectPath/basesoftware/emqx/emqx-ubuntu16.04-4.2.7-aarch64.deb"
    fi
    if [ "$mapOfflinePakagePath" == "" ];then
        mapOfflinePakagePath="$projectPath/basesoftware/map/roadmap.tar.gz"
    fi
    if [ "$mapInstallPath" == "" ];then
        mapInstallPath="$projectPath/googlemaps"
    fi
    if [ "$mysqlOfflinePakagePath" == "" ];then
        mysqlOfflinePakagePath="$projectPath/basesoftware/mysql/deb-mysqlserver"
    fi
    if [ "$oamOfflinePakagePath" == "" ];then
        oamOfflinePakagePath="$projectPath/basesoftware/oam/OAM.tar.gz"
    fi
    if [ "$rcLocalOfflinePakagePath" == "" ];then
        rcLocalOfflinePakagePath="$projectPath/basesoftware/conf/rc.local"
    fi
    if [ "$hostsOfflinePakagePath" == "" ];then
        hostsOfflinePakagePath="$projectPath/basesoftware/conf/hosts"
    fi
    if [ "$icssFrontOfflinePakagePath" == "" ];then
        icssFrontOfflinePakagePath="$projectPath/basesoftware/icss/front/dist.zip"
    fi
    if [ "$icssFrontInstallPath" == "" ];then
        icssFrontInstallPath="$projectPath/disp"
    fi
    if [ "$icssBackOfflinePakagePath" == "" ];then
        icssBackOfflinePakagePath="$projectPath/basesoftware/icss/back/NE-merge.tar.gz"
    fi
    if [ "$nmsFrontOfflinePakagePath" == "" ];then
        nmsFrontOfflinePakagePath="$projectPath/basesoftware/nms/front/dist.zip"
    fi
    if [ "$nmsFrontInstallPath" == "" ];then
        nmsFrontInstallPath="$projectPath/nms/front"
    fi
    if [ "$nmsBackOfflinePakagePath" == "" ];then
        nmsBackOfflinePakagePath="$projectPath/basesoftware/nms/back/backend-no-merge.tar.gz"
    fi
    if [ "$nmsBackInstallPath" == "" ];then
        nmsBackInstallPath="$projectPath/nms"
    fi
    if [ "$microOfflinePakagePath" == "" ];then
        microOfflinePakagePath="$projectPath/basesoftware/micro/micro.tar.gz"
    fi
    if [ "$microCfgPath" == "" ];then
        microCfgPath="$projectPath/basesoftware/micro/application.yml"
    fi
    if [ "$nmsCfgFolderPath" == "" ];then
        nmsCfgFolderPath="$projectPath/micro/sun-nms-config-server/config"
    fi
    if [ "$gatewayOfflinePakagePath" == "" ];then
        gatewayOfflinePakagePath="$projectPath/basesoftware/gateway/gateway.tar.gz"
    fi
    if [ "$kmsOfflinePakagePathSP3" == "" ];then
        kmsOfflinePakagePathSP3="$projectPath/basesoftware/kms/SK_KMS_run_SP3_2019.tar.gz"
    fi
    if [ "$kmsOfflineInstallPathSP3" == "" ];then
        kmsOfflineInstallPathSP3="/home"
    fi
    if [ "$kmsOfflinePakagePathSP4" == "" ];then
        kmsOfflinePakagePathSP4="$projectPath/basesoftware/kms/SK_KMS_run_SP4.tar.gz"
    fi
    if [ "$kmsOfflineInstallPathSP4" == "" ];then
        kmsOfflineInstallPathSP4="/home"
    fi

    # [recording配置文件]
    if [ "$recordingOfflineCfgPath" == "" ];then
        echoE "读不到 recordingOfflineCfgPath"
        recordingOfflineCfgPath="$projectPath/basesoftware/curl/back/recording/application.properties"
    fi
    if [ "$recordingName" == "" ];then
        recordingName="17-1"
    fi
    if [ "$lzName" == "" ];then
        lzName="8-1"
    fi

    # [第三方软件]
    if [ "$curlOfflinePakagePath" == "" ];then
        echoE "读不到 curlOfflinePakagePath"
        curlOfflinePakagePath="$projectPath/basesoftware/curl/curl-7.47.0-offline.tar.gz"
    fi
    if [ "$jqOfflinePakagePath" == "" ];then
        jqOfflinePakagePath="$projectPath/basesoftware/jq/jq-1.5-offline.tar.gz"
    fi

    # [核心网]
    if [ "$switchCommonLib" == "" ];then
        echoE "读不到 switchCommonLib"
        switchCommonLib="$projectPath/basesoftware/centos7/switch/lib64/common.tar.gz"
    fi
    if [ "$switchNE" == "" ];then
        switchNE="$projectPath/basesoftware/centos7/switch/NE.tar.gz"
    fi
    if [ "$switchResource" == "" ];then
        switchResource="$projectPath/basesoftware/centos7/switch/resource.tar.gz"
    fi

    # [tomcat]
    if [ "$tomcatOfflinePakagePath" == "" ];then
        echoE "读不到 tomcatOfflinePakagePath"
        tomcatOfflinePakagePath="$projectPath/basesoftware/tomcat/tomcat-kylin.zip"
    fi
    if [ "$tomcatInstallPath" == "" ];then
        tomcatInstallPath="/usr/share"
    fi

    # [数据库相关]
    if [ "$softwareDbUsername" == "" ];then
        echoE "读不到 softwareDbUsername"
        softwareDbUsername="root"
    fi
    if [ "$softwareDbpassword" == "" ];then
        softwareDbpassword="sunkaisens"
    fi
    if [ "$switchDbUsername" == "" ];then
        switchDbUsername="provision"
    fi
    if [ "$switchDbPassword" == "" ];then
        switchDbPassword="smg123"
    fi

    # [调度台其它]
    if [ "$icssViturlNumber" == "" ];then
        icssViturlNumber="18980090004"
    fi
    if [ "$icssDefaultNumber" == "" ];then
        icssDefaultNumber="18866668888"
    fi
    if [ "$grouCallpPrefix" == "" ];then
        grouCallpPrefix="189"
    fi

    # [网管分级相关]
    if [ "$nmsLevel" == "" ];then
        nmsLevel="1"
    fi
    if [ "$nmsUnitid" == "" ];then
        nmsUnitid="1"
    fi
    if [ "$upLevelNmsUnitid" == "" ];then
        upLevelNmsUnitid="0"
    fi
    if [ "$upLevelNmsName" == "" ];then
        upLevelNmsName="武警"
    fi
    if [ "$downLevelNmsUnitid" == "" ];then
        downLevelNmsUnitid=(2 3 4)
    fi
    if [ "$downLevelNmsName" == "" ];then
        downLevelNmsName=(武警2分队uid2 武警2分队uid3 武警2分队uid4)
    fi

    # [网管微服务相关]
    if [ "$eurekaGroupServiceName" == "" ];then
        eurekaGroupServiceName="appserver-group-2"
    fi
    if [ "$eurekaAlarmServiceName" == "" ];then
        eurekaAlarmServiceName="nms-alarm-service"
    fi
    if [ "$eurekaEquipmentServiceName" == "" ];then
        eurekaEquipmentServiceName="nms-resource-service"
    fi
    if [ "$eurekaOrganizationServiceName" == "" ];then
        eurekaOrganizationServiceName="nms-organization-service"
    fi
    if [ "$eurekaStatisticServiceName" == "" ];then
        eurekaStatisticServiceName="nms-statistic-service"
    fi
    if [ "$eurekaTopologyServiceName" == "" ];then
        eurekaTopologyServiceName="nms-topology-service"
    fi
    if [ "$eurekaDevConfigServiceName" == "" ];then
        eurekaDevConfigServiceName="nms-devconfig-service"
    fi
    if [ "$eurekaUserServiceName" == "" ];then
        eurekaUserServiceName="nms-user-service"
    fi
    if [ "$eurekaUserCenterServiceName" == "" ];then
        eurekaUserCenterServiceName="nms-user-service"
    fi
    if [ "$eurekaSecurityName" == "" ];then
        eurekaSecurityServiceName="nms-security-service"
    fi
    if [ "$eurekaDevconfigName" == "" ];then
        eurekaDevconfigServiceName="nms-devconfig-service"
    fi

    if [[ $eurekaMonitorName && -z $eurekaMonitorName || $eurekaMonitorName == " " ]];then
        eurekaMonitorServiceName="nms-monitor-service"
    fi

    if [[ $eurekaNeName && -z $eurekaNeName || $eurekaNeName == " " ]];then
        eurekaNeServiceName="nms-ne-service"
    fi

    if [[ $eurekaNorthName && -z $eurekaNorthName || $eurekaNorthName == " " ]];then
        eurekaNorthServiceName="nms-north-service"
    fi

    if [[ $north2OtherNmsIp && -z $north2OtherNmsIp || $north2OtherNmsIp == " " ]];then
        north2OtherNmsIp=$nmsIp
    fi

    # [oam-调度软件-网元启动配置]
    if [ "$oamRunServerNames" == "" ];then
        oamRunServerNames=(233-1 237-1 256-1 257-1)
    fi

    # [oam-核心网软件-网元启动配置]
    if [ "$switchRunServerNames" == "" ];then
        switchRunServerNames=(3-1 4-1 5-1 6-1 7-1 9-1 10-1 11-1 12-1 13-1 20-1 23-1 24-1 5-2 6-2 26-1)
    fi

    # [调度网元打包配置，填写manifest用]
    if [ "$manifestGroupName" == "" ];then
        manifestGroupName="233-1"
    fi
    if [ "$manifestGroupConfig" == "" ];then
        manifestGroupConfig="application.properties,conf/deviceType.propertie"
    fi
    if [ "$manifestGroupExe" == "" ];then
        manifestGroupExe="./group start"
    fi
    if [ "$manifestGroupVersion" == "" ];then
        manifestGroupVersion="1.1.0"
    fi
    if [ "$manifestGroupLog" == "" ];then
        manifestGroupLog="logs"
    fi
    if [ "$manifestGroupDescription" == "" ];then
        manifestGroupDescription="群组"
    fi
    if [ "$manifestGroupRequired" == "" ];then
        manifestGroupRequired="conf,lib,logs,mapping,pid,sql,application.properties,appserver-springboot-group-2.0.1.jar,git.properties,group,log4j2-spring.xml,manifest.mf"
    fi

    if [ "$manifestDdsName" == "" ];then
        manifestDdsName="237-1"
    fi
    if [ "$manifestDdsConfig" == "" ];then
        manifestDdsConfig="application.yml,conf/datadispatcher.properties,conf/ddsCluster.conf"
    fi
    if [ "$manifestDdsExe" == "" ];then
        manifestDdsExe="./dds start"
    fi
    if [ "$manifestDdsVersion" == "" ];then
        manifestDdsVersion="1.1.0"
    fi
    if [ "$manifestDdsLog" == "" ];then
        manifestDdsLog="logs"
    fi
    if [ "$manifestDdsDescription" == "" ];then
        manifestDdsDescription="dds"
    fi
    if [ "$manifestDdsRequired" == "" ];then
        manifestDdsRequired="application.yml,conf,lib,logs,dds,appserver-dds-3.0.0.jar,pid,package.xml,station.xml,manifest.mf"
    fi

    if [ "$manifestDispatcherName" == "" ];then
        manifestDispatcherName="257-1"
    fi
    if [ "$manifestDispatcherConfig" == "" ];then
        manifestDispatcherConfig="application.properties,conf/agw.properties"
    fi
    if [ "$manifestDispatcherExe" == "" ];then
        manifestDispatcherExe="./dispatcher start"
    fi
    if [ "$manifestDispatcherVersion" == "" ];then
        manifestDispatcherVersion="1.1.0"
    fi
    if [ "$manifestDispatcherLog" == "" ];then
        manifestDispatcherLog="logs"
    fi
    if [ "$manifestDispatcherDescription" == "" ];then
        manifestDispatcherDescription="dispatcher"
    fi
    if [ "$manifestDispatcherRequired" == "" ];then
        manifestDispatcherRequired="conf,gitVersion,i18n,lib,logs,mapping,pid,sql,static,templates,application.properties,dispatcher,dispatcher-server-1.0-SNAPSHOT.jar,functions.json,git.properties,log4j2-spring.xml,server.keystore,statusMsg.properties,manifest.mf"
    fi

    if [ "$manifestBillName" == "" ];then
        manifestBillName="256-1"
    fi
    if [ "$manifestBillConfig" == "" ];then
        manifestBillConfig="bill.config"
    fi
    if [ "$manifestBillExe" == "" ];then
        manifestBillExe="./m_bill.multi_hss_db.CentOS7.6_20200930 -x"
    fi
    if [ "$manifestBillVersion" == "" ];then
        manifestBillVersion="1.1.0"
    fi
    if [ "$manifestBillLog" == "" ];then
        manifestBillLog="logs"
    fi
    if [ "$manifestBillDescription" == "" ];then
        manifestBillDescription="计费模块"
    fi
    if [ "$manifestBillRequired" == "" ];then
        manifestBillRequired="lib,Log,.groupCall.bid,.smsRecord.bid,.vcRecord.bid,bill.config,m_bill.multi_hss_db.CentOS7.6_20200930,ocr.sql,manifest.mf"
    fi

    # [版本号]
    # 读取版本号 配置文件
    if [[ -z $version || $version == " " ]];then
        if [ -f "$versionFile" ];then
            version=`cat $versionFile`
        else
            version='0.0.0'
        fi
    fi

    if [ ! "$installServiceVersion" ];then
        installServiceVersion="v0.0.1"
    fi

#    echoN "获取网卡名字"
    running_localIp_card_name="enp11s0f1"
    realSystemVersion=`getRealSystemVersion`
    echoN "系统类型为 $realSystemVersion"
    allCardNames=`getLocalServerAllAvailableNetworkCardList $realSystemVersion`
    for cardName in ${allCardNames[*]}
    do
        if [[ `ifconfig $cardName` =~ "$localIp" ]];then
            running_localIp_card_name=$cardName
#            echo "最终结果======== $running_localIp_card_name"
            break
        fi
    done

    if [ "$projectName" == "2011" ];then
        # projectPath="/home/2011"
        echo ""
    elif [ "$projectName" == "aj" ];then
        projectPath="/home/aj"
    fi

}


function crateProjectFolder(){

    if [ "$projectName" == "2011" ];then
        sed -i 's/\r//' $createFolderCfgPath

        # 脚本将开关置为true
#        sed -i "s/^isCreateBaseFolder.*/isCreateBaseFolder=true/g" $createFolderCfgPath
#        sed -i "s/^isCreateMicroFolder.*/isCreateMicroFolder=true/g" $createFolderCfgPath
#        sed -i "s/^isCreateNmsFolder.*/isCreateNmsFolder=true/g" $createFolderCfgPath
#        sed -i "s/^isCreateDispFolder.*/isCreateDispFolder=true/g" $createFolderCfgPath
#        sed -i "s/^isCreateMapFolder.*/isCreateMapFolder=true/g" $createFolderCfgPath
#        sed -i "s/^isCreateLibCommonFolder.*/isCreateLibCommonFolder=true/g" $createFolderCfgPath

        local isCreateBaseFolder=`cat $createFolderCfgPath | grep isCreateBaseFolder | awk -F '=' '{print $2}'`
        local isCreateMicroFolder=`cat $createFolderCfgPath | grep isCreateMicroFolder | awk -F '=' '{print $2}'`
        local isCreateNmsFolder=`cat $createFolderCfgPath | grep isCreateNmsFolder | awk -F '=' '{print $2}'`
        local isCreateDispFolder=`cat $createFolderCfgPath | grep isCreateDispFolder | awk -F '=' '{print $2}'`
        local isCreateMapFolder=`cat $createFolderCfgPath | grep isCreateMapFolder | awk -F '=' '{print $2}'`
        local isCreateLibCommonFolder=`cat $createFolderCfgPath | grep isCreateLibCommonFolder | awk -F '=' '{print $2}'`
        while read line || [[ -n ${line} ]]
        do
            if [[ $line =~ ^#.* ]];then
    #            echoE "line= $line"
    #            echoE "此行注释开头，不读取此行"
                continue
            fi

            k=${line%=*}  # =前
            v=${line#*=}  # =后
            v=`eval echo ${v%#*}`  # 去掉空格
    #        v=`echo $line | grep -Eo "={.*}#"`  # =后 # 之前, 不好用，仍然会前后字符串
    #        echoE "k+v===== $k: $v"

            if [[ -z "$k" || "$k" == "" ]];then
                continue
            fi

            if [[ $k =~ 'createBaseFolder' && $k != 'isCreateBaseFolder' && ! -d "$v" ]];then
                echoN "创建 项目基础 文件夹 $v"
                mkdir -vp $v
            fi

            if [[ "$isCreateMicroFolder" == "true" && $k =~ 'createMicroFolder' && $k != 'isCreateMicroFolder' && ! -d "$v" ]];then
                echoN "创建 微服务 文件夹 $v"
                mkdir -vp $v
            fi

            if [[ "$isCreateNmsFolder" == "true" && $k =~ 'createNmsFolder' && $k != 'isCreateNmsFolder' && ! -d "$v" ]];then
                echoN "创建 网管 文件夹 $v"
                mkdir -vp $v
            fi

            if [[ "$isCreateDispFolder" == "true" && $k =~ 'createDispFolder' && $k != 'isCreateDispFolder' && ! -d "$v" ]];then
                echoN "创建 调度 文件夹 $v"
                mkdir -vp $v
            fi

            if [[ "$isCreateMapFolder" == "true" && $k =~ 'createMapFolder' && $k != 'isCreateMapFolder' && ! -d "$v" ]];then
                echoN "创建 地图 文件夹 $v"
                mkdir -vp $v
            fi

            if [[ "$isCreateLibCommonFolder" == "true" && $k =~ 'createLibCommonFolder' && $k != 'isCreateLibCommonFolder' && ! -d "$v" ]];then
                echoN "创建 lib common库 文件夹 $v"
                mkdir -vp $v
            fi
        done < $createFolderCfgPath
    fi

    if [ "$projectName" == "aj" ];then
        # echoR "创建aj文件夹"
        sed -i 's/\r//' $createFolderCfgPath
        # 脚本将开关置为true
#        sed -i "s/^isCreateBaseFolder.*/isCreateBaseFolder=true/g" $createFolderCfgPath
#        sed -i "s/^isCreateMicroFolder.*/isCreateMicroFolder=true/g" $createFolderCfgPath
#        sed -i "s/^isCreateNmsFolder.*/isCreateNmsFolder=true/g" $createFolderCfgPath
#        sed -i "s/^isCreateDispFolder.*/isCreateDispFolder=true/g" $createFolderCfgPath
#        sed -i "s/^isCreateMapFolder.*/isCreateMapFolder=true/g" $createFolderCfgPath
#        sed -i "s/^isCreateLibCommonFolder.*/isCreateLibCommonFolder=true/g" $createFolderCfgPath

        local isCreateBaseFolder=`cat $createFolderCfgPath | grep isCreateBaseFolder | awk -F '=' '{print $2}'`
        local isCreateMicroFolder=`cat $createFolderCfgPath | grep isCreateMicroFolder | awk -F '=' '{print $2}'`
        local isCreateNmsFolder=`cat $createFolderCfgPath | grep isCreateNmsFolder | awk -F '=' '{print $2}'`
        local isCreateDispFolder=`cat $createFolderCfgPath | grep isCreateDispFolder | awk -F '=' '{print $2}'`
        local isCreateMapFolder=`cat $createFolderCfgPath | grep isCreateMapFolder | awk -F '=' '{print $2}'`
        local isCreateLibCommonFolder=`cat $createFolderCfgPath | grep isCreateLibCommonFolder | awk -F '=' '{print $2}'`


        while read line || [[ -n ${line} ]]
        do
            if [[ $line =~ ^#.* ]];then
    #            echoE "line= $line"
    #            echoE "此行注释开头，不读取此行"
                continue
            fi

            k=${line%=*}  # =前
            v=${line#*=}  # =后
            v=`eval echo ${v%#*}`  # 去掉空格
    #        v=`echo $line | grep -Eo "={.*}#"`  # =后 # 之前, 不好用，仍然会前后字符串
    #        echoE "k+v===== $k: $v"
            if [[ -z "$k" || "$k" == "" ]];then
                continue
            fi

            if [[ $k =~ 'createBaseFolder' && $k != 'isCreateBaseFolder' && ! -d "$v" ]];then
                echoN "创建 项目基础 文件夹 $v"
                mkdir -vp $v
            fi

            if [[ "$isCreateMicroFolder" == "true" && $k =~ 'createMicroFolder' && $k != 'isCreateMicroFolder' && ! -d "$v" ]];then
                echoN "创建 微服务 文件夹 $v"
                mkdir -vp $v
            fi

            if [[ "$isCreateNmsFolder" == "true" && $k =~ 'createNmsFolder' && $k != 'isCreateNmsFolder' && ! -d "$v" ]];then
                echoN "创建 网管 文件夹 $v"
                mkdir -vp $v
            fi

            if [[ "$isCreateDispFolder" == "true" && $k =~ 'createDispFolder' && $k != 'isCreateDispFolder' && ! -d "$v" ]];then
                echoN "创建 调度 文件夹 $v"
                mkdir -vp $v
            fi

            if [[ "$isCreateMapFolder" == "true" && $k =~ 'createMapFolder' && $k != 'isCreateMapFolder' && ! -d "$v" ]];then
                echoN "创建 地图 文件夹 $v"
                mkdir -vp $v
            fi

            if [[ "$isCreateLibCommonFolder" == "true" && $k =~ 'createLibCommonFolder' && $k != 'isCreateLibCommonFolder' && ! -d "$v" ]];then
                echoN "创建 lib common库 文件夹 $v"
                mkdir -vp $v
            fi
        done < $createFolderCfgPath
    fi
}

# 选项目 - 暂时不用
function chooseProject(){
        echoN `cat $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseProject.txt | grep -v "#"`
        read -p "请选择序号(系统类型):"  userChooseProjectIndex
        case $userChooseProjectIndex in
            1)
                # 2011
                userChooseProject='2011'
                projectPath="/home/2011"
                sed -i "s/^projectName.*/projectName=$userChooseProject/g" $projectPath/installPackages/installShell/onekey.cfg
                sed -i "s#^projectPath.*#projectPath=$projectPath#g" $projectPath/installPackages/installShell/onekey.cfg
                ;;
            2)
                # aj
                userChooseProject='aj'
                projectPath="/home/aj"
                sed -i "s/^projectName.*/projectName=$userChooseProject/g" $projectPath/installPackages/installShell/onekey.cfg
                sed -i "s#^projectPath.*#projectPath=$projectPath#g" $projectPath/installPackages/installShell/onekey.cfg
                ;;
        esac

}
################ 执行程序--------------------------------------------------------------------------- #
source util.sh
addShellPrivileges

#if [ -f "$projectPath/installPackages/installShellonekey.cfg" ];then
if [ -f "onekey.cfg" ];then
    # echoN "加载配置文件"
    getCfg "onekey.cfg"
else
    echoE "没有配置文件 onekey.cfg，退出！！！"
    exit
fi


<<COMMENT

    if [ -f "$projectPath/installPackages/commonConf/version.cfg" ];then
        sed -i 's/\r//' "$projectPath/installPackages/commonConf/version.cfg"
        getCfg "$projectPath/installPackages/commonConf/version.cfg"
    else
        echoE "没有配置文件 $projectPath/installPackages/commonConf/version.cfg ，退出！！！"
        exit
    fi

    if [ -f "$projectPath/installPackages/commonConf/$versionCfgFolderName/version.cfg" ];then
        # unix 格式转换
        sed -i 's/\r//' "$projectPath/installPackages/commonConf/$versionCfgFolderName/version.cfg"
        getCfg "$projectPath/installPackages/commonConf/$versionCfgFolderName/version.cfg"
    else
        echoE "没有配置文件 $projectPath/installPackages/commonConf/$versionCfgFolderName/version.cfg ，退出！！！"
        exit
    fi
COMMENT

setDefaultVar

