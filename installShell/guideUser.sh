#!/bin/bash


# 2011项目默认
function guideUser(){

    #  0.是否进行用户引导 √
    eval echo $shellHeader  # 不会打印 $version
#    echo "--------$projectName 一键脚本（$systemVersion）$version---------------"
    sed -i 's/\r//' ../commonConf/menu/guideUserMenu/isGuideUser.txt
    echoN `cat ../commonConf/menu/guideUserMenu/isGuideUser.txt | grep -v "#"`
    read -p "请选择序号(是否进行用户引导):"  userChooseIfGuide

    case $userChooseIfGuide in
	1)
		# 引导用户
		echoR "用户选择1. 是"
		#     1. 选择项目 ？1.2011 2.AJ  --》不选/回车默认按-默认来，目前默认==2011
        if [ "$ifShowHiddenFunction" -eq 1 ];then
            echoN `cat ../commonConf/menu/guideUserMenu/chooseProject.txt`
        elif [ "$ifShowHiddenFunction" -eq 0 ];then
            echoN `cat ../commonConf/menu/guideUserMenu/chooseProject.txt | grep -v "#"`
        fi
        read -p "请选择序号(系统类型):"  userChooseProjectIndex
        case $userChooseProjectIndex in
            1)
                # 2011
                userChooseProject='2011'
                \cp conf_template/onekey-merge-v0.0.2-V0.0.2-centos7.cfg onekey.cfg
                source onekey.cfg
#                setDefaultVar
                ;;
            2)
                # aj
                userChooseProject='aj'
                \cp conf_template/onekey-merge-v0.0.1-V0.0.1-centos8-aj.cfg onekey.cfg
                source onekey.cfg
#                setDefaultVar
                ;;
        esac

        if [ "$projectName" == "2011" ];then


            #     1. 选择系统类型？1.kylin 2.centos7  --》不选/回车默认按-默认来，目前默认==centos7
            sed -i 's/\r//' $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseSystem.txt
            echoN `cat $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseSystem.txt | grep -v "#"`
            read -p "请选择序号(系统类型):"  userChooseSystemVersionIndex
            case $userChooseSystemVersionIndex in
                1)
                    # kylin(麒麟
                    userChooseSystemVersion='kylin'
                    ;;
                2)
                    # centos7
                    userChooseSystemVersion='centos7'
                    ;;
                3)
                    # kylin-x86
                    userChooseSystemVersion='kylin-x86'
                    ;;
            esac

            ## 判断真实系统是否和配置一样
            if [[ `uname -r` =~ "kylin" ]];then
                realSystemVersion='kylin'
    #            echoE "kylin - arm 系统 ！！！！！"
                echoN "判断真实系统= $realSystemVersion"
            elif [[ `uname -r` =~ "el7" ]];then
                realSystemVersion='centos7'
            else
    #            echoE "本服务器为其它系统,暂不支持!!,尝试通过yum /dpkg 命令来判断!"
                echo "本服务器为其它系统,暂不支持!!,尝试通过yum /dpkg 命令来判断" >> "$logfile/install-`(date +%Y%m%d)`.log"
    #            exit
                if [[ `uname -r` =~ "ky" ]];then
                    if [[ ! `yum --version` =~ 'General YUM options' ]];then
                        # centos 改编 kylin
                         echoN "kylin - x86 系统 ！！！！！"
                         realSystemVersion='kylin-x86'
                    fi
                else
                    echoE "通过uname 和yum命令无法查出本服务器类型,按centos7 系统来安装"
                    realSystemVersion='centos7'
                fi
            fi

            echoN "配置的系统= $userChooseSystemVersion"
            echoN "真实的系统= $realSystemVersion"
            if [[ $realSystemVersion != $userChooseSystemVersion ]];then
                echoE "本系统与配置不符,请检查!!,本系统= $realSystemVersion"
                exit
            fi
            systemVersion=$userChooseSystemVersion
            echoR "用户配置系统版本== $systemVersion"

            #     1. 选择模板？1.默认 2.正样 --》不选/回车默认按-默认来，目前默认=正样 √
            sed -i 's/\r//' $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseConfTemplate.txt
            echoN `cat $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseConfTemplate.txt | grep -v "#"`
            read -p "请选择序号(配置模板):"  userChooseCfgTemplate
            case $userChooseCfgTemplate in
                1)
                    # 正样模板
                    echoN "用户选择正样模板"
                    if [ "$userChooseSystemVersionIndex" -eq 1 ];then  # kylin
                        echoR "使用配置模板 kylin -正样"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-zhengyang-kylin.cfg $projectPath/installPackages/installShell/onekey.cfg
                    elif [ "$userChooseSystemVersionIndex" -eq 2 ];then  # centos7
                        echoR "使用配置模板 centos7 -正样"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-zhengyang-centos7.cfg $projectPath/installPackages/installShell/onekey.cfg
                    elif [ "$userChooseSystemVersionIndex" -eq 3 ];then  # kylin-x86
                        echoR "使用配置模板 kylin-x86 -正样"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-zhengyang-kylin-x86.cfg $projectPath/installPackages/installShell/onekey.cfg
                    fi
                    sed -i "s/^installServiceVersion.*/installServiceVersion=v0.0.1/g" $projectPath/installPackages/installShell/onekey.cfg
                    installServiceVersion="v0.0.1"
                    ;;
                2)
                    # 网管+调度软件 多合一版本 模板
                    echoN "用户选择 网管+调度软件 多合一版本 模板"
                    if [ "$userChooseSystemVersionIndex" -eq 1 ];then  # kylin
                        echoR "使用配置模板 kylin -多合一版本"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-merge-v0.0.2-V0.0.2-kylin.cfg $projectPath/installPackages/installShell/onekey.cfg
                    elif [ "$userChooseSystemVersionIndex" -eq 2 ];then  # centos7
                        echoR "使用配置模板 centos7 -多合一版本"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-merge-v0.0.2-V0.0.2-centos7.cfg $projectPath/installPackages/installShell/onekey.cfg
                    elif [ "$userChooseSystemVersionIndex" -eq 3 ];then  # kylin-x86
                        echoR "使用配置模板 kylin-x86 -多合一版本"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-merge-v0.0.2-V0.0.2-kylin-x86.cfg $projectPath/installPackages/installShell/onekey.cfg
                    fi
                    sed -i "s/^installServiceVersion.*/installServiceVersion=v0.0.2/g" $projectPath/installPackages/installShell/onekey.cfg
                    installServiceVersion="v0.0.2"
                    ;;
                *)
                    # 正样模板
                    echoN "用户选择默认模板-正样"
                    if [ "$userChooseSystemVersionIndex" -eq 1 ];then  # kylin
                        echoR "使用默认配置模板 kylin -正样"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-zhengyang-kylin.cfg $projectPath/installPackages/installShell/onekey.cfg
                    elif [ "$userChooseSystemVersionIndex" -eq 2 ];then  # centos7
                        echoR "使用默认配置模板 centos7 -正样"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-zhengyang-centos7.cfg $projectPath/installPackages/installShell/onekey.cfg
                    elif [ "$userChooseSystemVersionIndex" -eq 3 ];then  # kylin-x86
                        echoR "使用默认配置模板 kylin-x86 -正样"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-zhengyang-kylin-x86.cfg $projectPath/installPackages/installShell/onekey.cfg
                    fi
                    sed -i "s/^installServiceVersion.*/installServiceVersion=v0.0.1/g" $projectPath/installPackages/installShell/onekey.cfg
                    installServiceVersion="v0.0.1"
                    ;;
            esac

            #     选择设备类型 1区域交换中心 2.移动交换中心,默认移交
            sed -i 's/\r//' $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseDeviceType.txt
            echoN `cat $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseDeviceType.txt | grep -v "#"`
            read -p "请选择序号(设备类型):"  userChooseDeviceType
            case $userChooseDeviceType in
                1)
                    # 区域交换中心
                    echoR "用户选择1. 区域交换中心"
                    sed -i "s/deviceType=.*$/deviceType=1/g" onekey.cfg
                    deviceType=1
                    ;;
                2)
                    # 移动交换中心
                    echoR "用户选择2. 移动交换中心"
                    sed -i "s/deviceType=.*$/deviceType=2/g" onekey.cfg
                    deviceType=2
                    ;;
            esac

            #     选择板卡类型 1.主板 2.从板,默认主板
            sed -i 's/\r//' $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseCardType.txt
            echoN `cat $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseCardType.txt | grep -v "#"`
            read -p "请选择序号(板卡类型):"  userChooseCardType
            case $userChooseCardType in
                1)
                    # 主板
                    echoR "用户选择1. 主板"
                    sed -i "s/cardType.*$/cardType=1/g" onekey.cfg
                    cardType=1
                    ;;
                2)
                    # 从板
                    echoR "用户选择2. 从板"
                    sed -i "s/cardType.*$/cardType=2/g" onekey.cfg
                    cardType=2
                    ;;
            esac

            #    2. 选择是否要分布式部署（网管和调度分别部署在不同的服务器）？ 1.是 2否
    #        sed -i 's/\r//' $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseDistributeType.txt
    #        echoN `cat $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseDistributeType.txt | grep -v "#"`
    #        read -p "请选择序号(是否分布式部署):"  userChooseInstallType
    #        case $userChooseInstallType in
    #            1)
    #                # 分布式部署
    #                echoR "用户选择1. 是"
    #                sed -i "s/ifDistributed.*$/ifDistributed=1/g" onekey.cfg
    #                ifDistributed=1
    #                ;;
    #            2)
    #                # 非分布式部署
    #                echoR "用户选择2. 否"
    #                ifDistributed=0
    #                ;;
    #        esac

            sed -i 's/\r//' $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseInstallService.txt
            echoN `cat $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseInstallService.txt | grep -v "#"`
            read -p "请选择序号(安装的服务):"  userChooseInstallService
            case $userChooseInstallService in
                1)
                    sed -i "s/preInstallService.*$/preInstallService=1/g" onekey.cfg
                    ifDistributed=0
                    ;;
                2)
                    sed -i "s/preInstallService.*$/preInstallService=2/g" onekey.cfg
                    sed -i "s/ifDistributed.*$/ifDistributed=1/g" onekey.cfg
                    ifDistributed=1  # 进入分布式选择框 - ok
                    ;;
                3)
                    sed -i "s/preInstallService.*$/preInstallService=3/g" onekey.cfg
                    sed -i "s/ifDistributed.*$/ifDistributed=1/g" onekey.cfg
                    ifDistributed=1  # 进入分布式选择框 - ok
                    ;;
                4)
                    sed -i "s/preInstallService.*$/preInstallService=4/g" onekey.cfg
                    sed -i "s/ifDistributed.*$/ifDistributed=1/g" onekey.cfg
                    ifDistributed=1  # 进入分布式选择框 - ok
                    ;;
                5)
                    sed -i "s/preInstallService.*$/preInstallService=5/g" onekey.cfg
                    sed -i "s/ifDistributed.*$/ifDistributed=1/g" onekey.cfg
                    ifDistributed=1  # 进入分布式选择框 - ok
                    ;;
                6)
                    sed -i "s/preInstallService.*$/preInstallService=6/g" onekey.cfg
                    ;;
                7)
                    sed -i "s/preInstallService.*$/preInstallService=7/g" onekey.cfg
                    ;;
                8)
                    sed -i "s/preInstallService.*$/preInstallService=8/g" onekey.cfg
                    ;;
                9)
                    sed -i "s/preInstallService.*$/preInstallService=9/g" onekey.cfg
                    ;;
                10)
                    sed -i "s/preInstallService.*$/preInstallService=10/g" onekey.cfg
                    ;;
            esac
            echoR "用户选择 $userChooseInstallService"

            if [[ $ifDistributed == "1" || ${ifDistributed,,} == "true" || ${ifDistributed^^} == "TRUE" ]];then
                # 分布式
                echoN "进入分布式选择框。。"
                echo ""

                ## 0。从本级所有IP中选择 业务ip
                allLocalIp=(`getAllIpLocalServerFromKylinReturnStrList`)
                allLocalIpLen=${#allLocalIp[*]}
                for((i=0;i<allLocalIpLen;i++));
                do
                    echoN "$i. ${allLocalIp[$i]}"
                done
                echoN "999. 自己输入IP"
                read -p "以上是本服务器所有IP,请选择一个IP前的序号(本机ip):" localIpIndex
                if [[ $localIpIndex -lt 998 ]];then
    #                echo "用户输入 < 998"

                    userChooseLocalIp=${allLocalIp[$localIpIndex]}
                    echoR "用户输入的序号和ip= $localIpIndex $userChooseLocalIp"
                elif [[ $localIpIndex == "998" ]];then
                    echo "用户输入 998"
                    userChooseLocalIp=$userChooseLocalIp
                elif [[ $localIpIndex == "999" ]];then
                    echo "用户输入 999"
                    read -p "请输入IP： " userInputLocalIp
                    if [[ `isValidIp $userInputLocalIp` == "0"  ]];then
                        echoE "IP格式错误"
                        return 0
                    fi
                    userChooseLocalIp=$userInputLocalIp
                else
                    echoE "序号不支持"
                fi

                ## 1. 修改配置文件localIp
                sed -i "s/localIp.*$/localIp=$userChooseLocalIp/g" onekey.cfg

                ## 2. 从同网段所有ip中找出核心网ip
                echo "查询核心网ip中，请等待。。。"
                echo "查询核心网ip中，请等待。。。"
                echo "查询核心网ip中，请等待。。。"
                sameNetAllAvailableIp=(`getSameNetAllAvailableIpReturnStrList $userChooseLocalIp`)
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
                read -p "以上是同网段所有IP,请选择核心网IP(选IP前的序号):" switchIpIndex
                if [[ $switchIpIndex -lt 998 ]];then
    #                echo "用户输入 < 998"
                    userChooseSwitchIp=${sameNetAllAvailableIp[$switchIpIndex]}
                    echoR "用户输入的序号和ip= $switchIpIndex $userChooseSwitchIp"
                elif [[ $switchIpIndex == "998" ]];then
                    echo "用户输入 998"
                    userChooseSwitchIp=$userChooseLocalIp
                elif [[ $switchIpIndex == "999" ]];then
                    echo "用户输入 999"
                    read -p "请输入IP： " userInputSwitchIp
                    if [[ `isValidIp $userInputSwitchIp` == "0"  ]];then
                        echoE "IP格式错误"
                        return 0
                    fi
                    userChooseSwitchIp=$userInputSwitchIp

                else
                    echoE "序号不支持"
                fi
                ## 2.1 修改配置文件 switchIp
                sed -i "s/switchIp.*$/switchIp=$userChooseSwitchIp/g" onekey.cfg

                ## 3. 修改微服务ip
                # 打印同网段所有ip
                for((i=0;i<sameNetAllAvailableIpLen;i++));
                do
                    echoN "$i. ${sameNetAllAvailableIp[$i]}"
                done

                echoN "998. 不知道"
                echoN "999. 自己输入IP"
                read -p "以上是同网段所有IP,请选择微服务IP(选IP前的序号):" microIpIndex
                if [[ $microIpIndex -lt 998 ]];then
    #                echo "用户输入 < 998"
                    userChooseMicroIp=${sameNetAllAvailableIp[$microIpIndex]}
                    echoR "用户输入的序号和ip= $microIpIndex $userChooseMicroIp"
                elif [[ $microIpIndex == "998" ]];then
                    echo "用户输入 998"
                    userChooseMicroIp=$userChooseLocalIp
                elif [[ $microIpIndex == "999" ]];then
                    echo "用户输入 999"
                    read -p "请输入IP： " userInputMicroIp
                    if [[ `isValidIp $userInputMicroIp` == "0"  ]];then
                        echoE "IP格式错误"
                        return 0
                    fi
                    userChooseMicroIp=$userInputMicroIp

                else
                    echoE "序号不支持"
                fi
                ## 3.1 修改配置文件 microIp
                sed -i "s/microIp.*$/microIp=$userChooseMicroIp/g" onekey.cfg

                ## 4. 修改网管ip
                # 打印同网段所有ip
                for((i=0;i<sameNetAllAvailableIpLen;i++));
                do
                    echoN "$i. ${sameNetAllAvailableIp[$i]}"
                done

                echoN "998. 不知道"
                echoN "999. 自己输入IP"
                read -p "以上是同网段所有IP,请选择网管IP(选IP前的序号):" nmsIpIndex
                if [[ $nmsIpIndex -lt 998 ]];then
    #                echo "用户输入 < 998"
                    userChooseNmsIp=${sameNetAllAvailableIp[$nmsIpIndex]}
                    echoR "用户输入的序号和ip= $nmsIpIndex $userChooseNmsIp"
                elif [[ $nmsIpIndex == "998" ]];then
                    echo "用户输入 998"
                    userChooseNmsIp=$userChooseLocalIp
                elif [[ $nmsIpIndex == "999" ]];then
                    echo "用户输入 999"
                    read -p "请输入IP： " userInputNmsIp
                    if [[ `isValidIp $userInputNmsIp` == "0"  ]];then
                        echoE "IP格式错误"
                        return 0
                    fi
                    userChooseNmsIp=$userInputNmsIp

                else
                    echoE "序号不支持"
                fi
                ## 4.1 修改配置文件 nmsIp
                sed -i "s/nmsIp.*$/nmsIp=$userChooseNmsIp/g" onekey.cfg

                ## 5. 修改调度ip
                # 打印同网段所有ip
                for((i=0;i<sameNetAllAvailableIpLen;i++));
                do
                    echoN "$i. ${sameNetAllAvailableIp[$i]}"
                done

                echoN "998. 不知道"
                echoN "999. 自己输入IP"
                read -p "以上是同网段所有IP,请选择调度IP(选IP前的序号):" icssIpIndex
                if [[ $icssIpIndex -lt 998 ]];then
    #                echo "用户输入 < 998"
                    userChooseIcssIp=${sameNetAllAvailableIp[$icssIpIndex]}
                    echoR "用户输入的序号和ip= $icssIpIndex $userChooseIcssIp"
                elif [[ $icssIpIndex == "998" ]];then
                    echo "用户输入 998"
                    userChooseIcssIp=$userChooseLocalIp
                elif [[ $icssIpIndex == "999" ]];then
                    echo "用户输入 999"
                    read -p "请输入IP： " userInputIcssIp
                    if [[ `isValidIp $userInputIcssIp` == "0"  ]];then
                        echoE "IP格式错误"
                        return 0
                    fi
                    userChooseIcssIp=$userInputIcssIp

                else
                    echoE "序号不支持"
                fi
                ## 4.1 修改配置文件 icssIp
                sed -i "s/icssIp.*$/icssIp=$userChooseIcssIp/g" onekey.cfg

                ## 6. 根据用户输入的ip,替换emqxIp nginxIp等
                sed -i "s/emqIp.*$/emqIp=$userChooseMicroIp/g" onekey.cfg # 微服务
                sed -i "s/northEmqxIp.*$/northEmqxIp=$userChooseMicroIp/g" onekey.cfg # 微服务
                sed -i "s/redisIp.*$/redisIp=$userChooseMicroIp/g" onekey.cfg # 微服务

                sed -i "s/northIcssIp.*$/northIcssIp=$userChooseIcssIp/g" onekey.cfg # 调度
                sed -i "s/unitFirstLevelIp.*$/unitFirstLevelIp=$userChooseIcssIp/g" onekey.cfg # 调度
                sed -i "s/unitSecondLevelIp.*$/unitSecondLevelIp=$userChooseIcssIp/g" onekey.cfg # 调度
                sed -i "s/unitThirdLevelIp.*$/unitThirdLevelIp=$userChooseIcssIp/g" onekey.cfg # 调度
                sed -i "s/unitFourthLevelIp.*$/unitFourthLevelIp=$userChooseIcssIp/g" onekey.cfg # 调度
                sed -i "s/unitFifthLevelIp.*$/unitFifthLevelIp=$userChooseIcssIp/g" onekey.cfg # 调度

                sed -i "s/upLevelNmsIp.*$/upLevelNmsIp=$userChooseNmsIp/g" onekey.cfg # 网管

                # 本机相关ip
                sed -i "s/mysqlIp.*$/mysqlIp=$userChooseLocalIp/g" onekey.cfg # 本机


            ############################
            else
                # 非分布式部署
                ## 0。从本级所有IP中选择 业务ip
                allLocalIp=(`getAllIpLocalServerFromKylinReturnStrList`)
                allLocalIpLen=${#allLocalIp[*]}
                for((i=0;i<allLocalIpLen;i++));
                do
                    echoN "$i. ${allLocalIp[$i]}"
                done
                read -p "以上是本服务器所有IP,请选择业务ip(输入ip前的序号:)" localIpIndex
                userChooseLocalIp=${allLocalIp[$localIpIndex]}
                echoR "用户输入的序号和ip= $localIpIndex $userChooseLocalIp"

                ## 1. 修改配置文件localIp
                sed -i "s/localIp.*$/localIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/microIp.*$/microIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/icssIp.*$/icssIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/nmsIp.*$/nmsIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/emqIp.*$/emqIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/northIcssIp.*$/northIcssIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/northEmqxIp.*$/northEmqxIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/mysqlIp.*$/mysqlIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/redisIp.*$/redisIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/upLevelNmsIp.*$/upLevelNmsIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/northIcssIp.*$/northIcssIp=$userChooseLocalIp/g" onekey.cfg

                sed -i "s/unitFirstLevelIp.*$/unitFirstLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitSecondLevelIp.*$/unitSecondLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitThirdLevelIp.*$/unitThirdLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitFourthLevelIp.*$/unitFourthLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitFifthLevelIp.*$/unitFifthLevelIp=$userChooseLocalIp/g" onekey.cfg

                ## 2. 从同网段所有ip中找出核心网ip
                echo "查询核心网ip中，请等待。。。"
                echo "查询核心网ip中，请等待。。。"
                echo "查询核心网ip中，请等待。。。"
                sameNetAllAvailableIp=(`getSameNetAllAvailableIpReturnStrList $userChooseLocalIp`)
                if [[ "$sameNetAllAvailableIp" == "0" ]];then
                    echoE "同网段无可用ip"
                else
                    echo ""
    #                echo "同网段可用ip=  $sameNetAllAvailableIp"
                fi

                sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
                for((i=0;i<sameNetAllAvailableIpLen;i++));
                do
                    echoN "$i. ${sameNetAllAvailableIp[$i]}"
                done

                echoN "998. 不知道"
                echoN "999. 自己输入IP"
                read -p "以上是同网段所有IP,请选择一个IP前的序号(此IP是核心网用的):" switchIpIndex
                if [[ $switchIpIndex -lt 998 ]];then
    #                echo "用户输入 < 998"
                    userChooseSwitchIp=${sameNetAllAvailableIp[$switchIpIndex]}
                    echoR "用户输入的序号和ip= $switchIpIndex $userChooseSwitchIp"
                elif [[ $switchIpIndex == "998" ]];then
                    echo "用户输入 998"
                    userChooseSwitchIp=$userChooseLocalIp
                elif [[ $switchIpIndex == "999" ]];then
                    echo "用户输入 999"
                    read -p "请输入IP： " userInputSwitchIp
                    if [[ `isValidIp $userInputSwitchIp` == "0"  ]];then
                        echoE "IP格式错误"
                        return 0
                    fi
                    userChooseSwitchIp=$userInputSwitchIp

                else
                    echoE "序号不支持"
                fi
                ## 2.1 修改配置文件 switchIp
                sed -i "s/switchIp.*$/switchIp=$userChooseSwitchIp/g" onekey.cfg
            fi

            if [[ $userChooseInstallService -eq 1 || $userChooseInstallService -eq 4 || $userChooseInstallService -eq 7 || $userChooseInstallService -eq 8 ]];then
                # 配置调度台虚拟号码
                read -p "请输入11位调度台虚拟号码(例：18866668888):"  userChooseDispVirtualNumber
                sed -i "s/icssViturlNumber.*$/icssViturlNumber=$userChooseDispVirtualNumber/g" onekey.cfg
                icssViturlNumber=$userChooseDispVirtualNumber

                read -p "请输入本级合法的终端号码段-1，回车跳过(例：19080000000-19080099999,默认00000000000-00000000000):"  userChooselocalUnitDispNumberRange1
                if [ -n "$userChooselocalUnitDispNumberRange1" ];then
                    sed -i "s/localUnitDispNumberRange1.*$/localUnitDispNumberRange1=$userChooselocalUnitDispNumberRange1/g" onekey.cfg
                    localUnitDispNumberRange1=$userChooselocalUnitDispNumberRange1
                fi

                read -p "请输入本级合法的终端号码段-2，回车跳过(例：19080000000-19080099999,默认00000000000-00000000000):"  userChooselocalUnitDispNumberRange2
                if [ -n "$userChooselocalUnitDispNumberRange2" ];then
                    sed -i "s/localUnitDispNumberRange2.*$/localUnitDispNumberRange2=$userChooselocalUnitDispNumberRange2/g" onekey.cfg
                    localUnitDispNumberRange2=$userChooselocalUnitDispNumberRange2
                fi

                read -p "请输入本级合法的终端号码段-3，回车跳过(例：19080000000-19080099999,默认00000000000-00000000000):"  userChooselocalUnitDispNumberRange3
                if [ -n "$userChooselocalUnitDispNumberRange3" ];then
                    sed -i "s/localUnitDispNumberRange3.*$/localUnitDispNumberRange3=$userChooselocalUnitDispNumberRange3/g" onekey.cfg
                    localUnitDispNumberRange3=$userChooselocalUnitDispNumberRange3
                fi

                read -p "请输入本级合法的终端号码段-4，回车跳过(例：19080000000-19080099999,默认00000000000-00000000000):"  userChooselocalUnitDispNumberRange4
                if [ -n "$userChooselocalUnitDispNumberRange4" ];then
                    sed -i "s/localUnitDispNumberRange4.*$/localUnitDispNumberRange4=$userChooselocalUnitDispNumberRange4/g" onekey.cfg
                    localUnitDispNumberRange4=$userChooselocalUnitDispNumberRange4
                fi

                read -p "请输入本级合法的终端号码段-5，回车跳过(例：19080000000-19080099999,默认00000000000-00000000000):"  userChooselocalUnitDispNumberRange5
                if [ -n "$userChooselocalUnitDispNumberRange5" ];then
                    sed -i "s/localUnitDispNumberRange5.*$/localUnitDispNumberRange5=$userChooselocalUnitDispNumberRange5/g" onekey.cfg
                    localUnitDispNumberRange5=$userChooselocalUnitDispNumberRange5
                fi

                read -p "请输入本级合法的终端号码段-6，回车跳过(例：19080000000-19080099999,默认00000000000-00000000000):"  userChooselocalUnitDispNumberRange6
                if [ -n "$userChooselocalUnitDispNumberRange6" ];then
                    sed -i "s/localUnitDispNumberRange6.*$/localUnitDispNumberRange6=$userChooselocalUnitDispNumberRange6/g" onekey.cfg
                    localUnitDispNumberRange6=$userChooselocalUnitDispNumberRange6
                fi

                read -p "请输入本级合法的终端号码段-7，回车跳过(例：19080000000-19080099999,默认00000000000-00000000000):"  userChooselocalUnitDispNumberRange7
                if [ -n "$userChooselocalUnitDispNumberRange7" ];then
                    sed -i "s/localUnitDispNumberRange7.*$/localUnitDispNumberRange7=$userChooselocalUnitDispNumberRange7/g" onekey.cfg
                    localUnitDispNumberRange7=$userChooselocalUnitDispNumberRange7
                fi
            fi

            ## 5. 配置上下级配置
    #        sed -i 's/\r//' $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseNetworing.txt
    #        echoN `cat $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseNetworing.txt | grep -v "#"`
    #        read -p "请选择序号(是否和其它服务器组网):"  userChooseIsNetworking
    #        case $userChooseIsNetworking in
    #        1)
    #            echoR "用户选择组网"
    #            sed -i "s/isNetworking.*$/isNetworking=1/g" onekey.cfg
    #            isNetworking=1
    #
    #            # 5.0 本级组织机构id
    #            echoN "本级组织机构id,如果没有，输入0，"
    #            read -p "输入本级组织机构id : "  userInputNmsUnitid
    #
    #            if [[ `check_digits $userInputNmsUnitid` -eq 1 ]];then
    #                echoN "输入本级组织机构id合法"
    #                sed -i "s/nmsUnitid.*$/nmsUnitid=$userInputNmsUnitid/g" onekey.cfg
    #                nmsUnitid=$userInputNmsUnitid  # 赋值
    #            else
    #                echoE "输入本级组织机构id非法"
    #                echo "引导用户，输入本级组织机构非法" >> "$logfile/install-`(date +%Y%m%d)`.log"
    #                sed -i "s/nmsUnitid.*$/nmsUnitid=1/g" onekey.cfg
    #                nmsUnitid=1  # 赋值
    #            fi
    #
    #            # 5.1 上级组织机构id
    #            echoN "上级组织机构id,如果没有，输入0，"
    #            read -p "输入上级组织机构id : "  userInputUpLevelNmsUnitid
    #
    #            if [[ `check_digits $userInputUpLevelNmsUnitid` -eq 1 ]];then
    #                echoN "输入上级组织机构id合法"
    #                sed -i "s/upLevelNmsUnitid.*$/upLevelNmsUnitid=$userInputUpLevelNmsUnitid/g" onekey.cfg
    #                upLevelNmsUnitid=$userInputUpLevelNmsUnitid  # 赋值
    #            else
    #                echoE "输入上级组织机构id非法"
    #                echo "引导用户，输入上级组织机构非法" >> "$logfile/install-`(date +%Y%m%d)`.log"
    #                sed -i "s/upLevelNmsUnitid.*$/upLevelNmsUnitid=0/g" onekey.cfg
    #                upLevelNmsUnitid=0  # 赋值
    #            fi
    #
    #            # 5.2 上级组织机构名称
    #            read -p "输入上级组织机构名称 : "  userInputUpLevelNmsName
    #            sed -i "s/upLevelNmsName.*$/upLevelNmsName=$userInputUpLevelNmsName/g" onekey.cfg
    #            upLevelNmsName=$userInputUpLevelNmsName
    #
    #            # 5.3 下级组织机构id
    #            echoN "输入下级组织机构id，用空格隔开（例子：1 2 3 ）"
    #            read -p "输入下级组织机构id : " userInputDownLevelNmsUnitid
    #            echoN "输入的下级组织机构id，====${userInputDownLevelNmsUnitid[*]}"
    #            userInputDownLevelNmsUnitidArr=($userInputDownLevelNmsUnitid)
    #            if [[ -n $userInputDownLevelNmsUnitidArr ]];then  # 用户输入的id不为空
    #    #            echoN "输入的下级组织机构idarr ，====${userInputDownLevelNmsUnitidArr[*]}"
    #                userInputDownLevelNmsUnitidArrLen=${#userInputDownLevelNmsUnitidArr[*]}
    #                for((i=0;i<$userInputDownLevelNmsUnitidArrLen;i++));
    #                do
    #    #                echoN "地$i 个数====${userInputDownLevelNmsUnitidArr[$i]}"
    #                    if [[ `check_digits ${userInputDownLevelNmsUnitidArr[$i]}` -eq 1 ]];then
    #                        echoN "输入下级组织机构id合法"
    #                    else
    #                        echoE "输入下级组织机构id非法"
    #                        echo "引导用户，输入下级组织机构非法" >> "$logfile/install-`(date +%Y%m%d)`.log"
    #                        sed -i "s/downLevelNmsUnitid.*$/downLevelNmsUnitid=\(\)/g" onekey.cfg
    #                        downLevelNmsUnitid=()  # 赋值
    #                        break
    #                    fi
    #                    if [[ $i -eq $userInputDownLevelNmsUnitidArrLen-1 ]];then
    #                        sed -i "s/downLevelNmsUnitid.*$/downLevelNmsUnitid=\($userInputDownLevelNmsUnitid\)/g" onekey.cfg
    #                        downLevelNmsUnitid=($userInputDownLevelNmsUnitid)  # 赋值
    #                    fi
    #                done
    #                echo ""
    #            else
    #                downLevelNmsUnitid=() # 用户输入的id为空
    #                sed -i "s/downLevelNmsUnitid.*$/downLevelNmsUnitid=\(\)/g" onekey.cfg
    #            fi
    #
    #            # 5.4 下级组织机构名称
    #            if [[ -n $downLevelNmsUnitid ]];then  # 不为空
    #                echoN "输入下级组织机构名称，用空格隔开（例子：下级1 下级2 下级3 ）"
    #                read -p "输入下级组织机构名称 : "  userInputDownLevelNmsName
    #                userInputDownLevelNmsNameArr=($userInputDownLevelNmsName)
    #                sed -i "s/downLevelNmsName.*$/downLevelNmsName=\(${userInputDownLevelNmsName[*]}\) /g" onekey.cfg
    #                downLevelNmsName=${userInputDownLevelNmsNameArr[*]}
    #
    #                ##
    #                # 判断组织机构名称和id 是否对应？ 个数是否相等？？
    #                downLevelNmsUnitidLen=${#downLevelNmsUnitid[*]}
    #                downLevelNmsNameLen=${#downLevelNmsName[*]}
    #                if [[ $downLevelNmsUnitidLen -eq $downLevelNmsNameLen ]];then
    #                    echoR "组织机构名称和id 对应!!"
    #                else
    #                    echoE "组织机构名称和id 不对应!!"
    #                    echo "下级组织机构名称和id 不对应!!" >> "$logfile/install-`(date +%Y%m%d)`.log"
    #                fi
    #            fi
    #
    #            ## 5.5 选择 上级emx  northEmqxIp
    #            echo "查询ip中，请等待。。。"
    #            echo "查询ip中，请等待。。。"
    #            echo "查询ip中，请等待。。。"
    #            sameNetAllAvailableIp=(`getSameNetAllAvailableIpReturnStrList $userChooseLocalIp`)
    #            if [[ "$sameNetAllAvailableIp" == "0" ]];then
    #                echoE "同网段无可用ip"
    #            else
    #                echo "同网段有可用ip，ip=  $sameNetAllAvailableIp 等。"
    #            fi
    #
    #            sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
    #            # 打印同网段所有ip
    #            for((i=0;i<sameNetAllAvailableIpLen;i++));
    #            do
    #                echoN "$i. ${sameNetAllAvailableIp[$i]}"
    #            done
    #            echoN "998. 不知道"
    #            echoN "999. 自己输入IP"
    #            read -p "以上是同网段所有IP,请选择上级emx(选IP前的序号):" northEmqxIpIndex
    #            if [[ $northEmqxIpIndex -lt 998 ]];then
    ##                echo "用户输入 < 998"
    #                northEmqxIp=${sameNetAllAvailableIp[$northEmqxIpIndex]}
    #                echoR "用户输入的序号和ip= $northEmqxIpIndex $northEmqxIp"
    #            elif [[ $northEmqxIpIndex == "998" ]];then
    #                echo "用户输入 998"
    #                northEmqxIp=$userChooseLocalIp
    #            elif [[ $northEmqxIpIndex == "999" ]];then
    #                echo "用户输入 999"
    #                read -p "请输入IP： " userInputNorthEmqxIp
    #                if [[ `isValidIp $userInputNorthEmqxIp` == "0"  ]];then
    #                    echoE "IP格式错误"
    #                    northEmqxIp=$userChooseLocalIp
    ##                    return 0
    #                fi
    #                northEmqxIp=userInputNorthEmqxIp
    #            else
    #                echoE "序号不支持"
    #            fi
    #            sed -i "s/northEmqxIp.*$/northEmqxIp=$northEmqxIp/g" onekey.cfg
    #
    #            ## 5.6 选择 上级调度  northIcssIp
    #            sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
    #            # 打印同网段所有ip
    #            for((i=0;i<sameNetAllAvailableIpLen;i++));
    #            do
    #                echoN "$i. ${sameNetAllAvailableIp[$i]}"
    #            done
    #            echoN "998. 不知道"
    #            echoN "999. 自己输入IP"
    #            read -p "以上是同网段所有IP,请选择上级调度(选IP前的序号):" northIcssIpIndex
    #            if [[ $northIcssIpIndex -lt 998 ]];then
    ##                echo "用户输入 < 998"
    #                northIcssIp=${sameNetAllAvailableIp[$northIcssIpIndex]}
    #                echoR "用户输入的序号和ip= $northIcssIpIndex $northEmqxIp"
    #            elif [[ $northIcssIpIndex == "998" ]];then
    #                echo "用户输入 998"
    #                northIcssIp=$userChooseLocalIp
    #            elif [[ $northIcssIpIndex == "999" ]];then
    #                echo "用户输入 999"
    #                read -p "请输入IP： " userInputNorthIcssIp
    #                if [[ `isValidIp $userInputNorthIcssIp` == "0"  ]];then
    #                    echoE "IP格式错误"
    #                    northIcssIp=$userChooseLocalIp
    ##                    return 0
    #                fi
    #                northIcssIpIndex=$userInputNorthIcssIp
    #            else
    #                echoE "序号不支持"
    #            fi
    #            sed -i "s/northIcssIp.*$/northIcssIp=$northIcssIp/g" onekey.cfg
    #
    #            ## 5.6 选择 上级网管  upLevelNmsIp
    #            sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
    #            # 打印同网段所有ip
    #            for((i=0;i<sameNetAllAvailableIpLen;i++));
    #            do
    #                echoN "$i. ${sameNetAllAvailableIp[$i]}"
    #            done
    #            echoN "998. 不知道"
    #            echoN "999. 自己输入IP"
    #            read -p "以上是同网段所有IP,请选择上级网管(选IP前的序号):" upLevelNmsIpIndex
    #            if [[ $upLevelNmsIpIndex -lt 998 ]];then
    ##                echo "用户输入 < 998"
    #                upLevelNmsIp=${sameNetAllAvailableIp[$upLevelNmsIpIndex]}
    #                echoR "用户输入的序号和ip= $northIcssIpIndex $northEmqxIp"
    #            elif [[ $upLevelNmsIpIndex == "998" ]];then
    #                echo "用户输入 998"
    #                upLevelNmsIp=$userChooseLocalIp
    #            elif [[ $upLevelNmsIpIndex == "999" ]];then
    #                echo "用户输入 999"
    #                read -p "请输入IP： " userInputUpLevelNmsIp
    #                if [[ `isValidIp $userInputUpLevelNmsIp` == "0"  ]];then
    #                    echoE "IP格式错误"
    #                    upLevelNmsIp=$userChooseLocalIp
    ##                    return 0
    #                fi
    #                upLevelNmsIp=$userInputUpLevelNmsIp
    #            else
    #                echoE "序号不支持"
    #            fi
    #            sed -i "s/upLevelNmsIp.*$/upLevelNmsIp=$upLevelNmsIp/g" onekey.cfg
    #
    #            ## 5.6 选择 1级别调度  unitFirstLevelIp
    #            sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
    #            # 打印同网段所有ip
    #            for((i=0;i<sameNetAllAvailableIpLen;i++));
    #            do
    #                echoN "$i. ${sameNetAllAvailableIp[$i]}"
    #            done
    #            echoN "998. 不知道"
    #            echoN "999. 自己输入IP"
    #            read -p "以上是同网段所有IP,请选择1级调度(选IP前的序号):" unitFirstLevelIpIndex
    #            if [[ $unitFirstLevelIpIndex -lt 998 ]];then
    ##                echo "用户输入 < 998"
    #                unitFirstLevelIp=${sameNetAllAvailableIp[$unitFirstLevelIpIndex]}
    #                echoR "用户输入的序号和ip= $northIcssIpIndex $northEmqxIp"
    #            elif [[ $unitFirstLevelIpIndex == "998" ]];then
    #                echo "用户输入 998"
    #                unitFirstLevelIp=$userChooseLocalIp
    #            elif [[ $unitFirstLevelIpIndex == "999" ]];then
    #                echo "用户输入 999"
    #                read -p "请输入IP： " userInputUnitFirstLevelIp
    #                if [[ `isValidIp $userInputUnitFirstLevelIp` == "0"  ]];then
    #                    echoE "IP格式错误"
    #                    unitFirstLevelIp=$userChooseLocalIp
    ##                    return 0
    #                fi
    #                unitFirstLevelIp=$userInputUnitFirstLevelIp
    #            else
    #                echoE "序号不支持"
    #            fi
    #            sed -i "s/unitFirstLevelIp.*$/unitFirstLevelIp=$unitFirstLevelIp/g" onekey.cfg
    #
    #            ## 5.6 选择 2级别调度  unitSecondLevelIp
    #            sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
    #            # 打印同网段所有ip
    #            for((i=0;i<sameNetAllAvailableIpLen;i++));
    #            do
    #                echoN "$i. ${sameNetAllAvailableIp[$i]}"
    #            done
    #            echoN "998. 不知道"
    #            echoN "999. 自己输入IP"
    #            read -p "以上是同网段所有IP,请选择2级调度(选IP前的序号):" unitSecondLevelIpIndex
    #            if [[ $unitSecondLevelIpIndex -lt 998 ]];then
    ##                echo "用户输入 < 998"
    #                unitSecondLevelIp=${sameNetAllAvailableIp[$unitSecondLevelIpIndex]}
    #                echoR "用户输入的序号和ip= $northIcssIpIndex $northEmqxIp"
    #            elif [[ $unitSecondLevelIpIndex == "998" ]];then
    #                echo "用户输入 998"
    #                unitSecondLevelIp=$userChooseLocalIp
    #            elif [[ $unitSecondLevelIpIndex == "999" ]];then
    #                echo "用户输入 999"
    #                read -p "请输入IP： " userInputUnitSecondLevelIp
    #                if [[ `isValidIp $userInputUnitSecondLevelIp` == "0"  ]];then
    #                    echoE "IP格式错误"
    #                    unitSecondLevelIp=$userChooseLocalIp
    ##                    return 0
    #                fi
    #                unitSecondLevelIp=$userInputUnitSecondLevelIp
    #            else
    #                echoE "序号不支持"
    #            fi
    #            sed -i "s/unitSecondLevelIp.*$/unitSecondLevelIp=$unitSecondLevelIp/g" onekey.cfg
    #
    #            ## 5.6 选择 3级别调度  unitThirdLevelIp
    #            sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
    #            # 打印同网段所有ip
    #            for((i=0;i<sameNetAllAvailableIpLen;i++));
    #            do
    #                echoN "$i. ${sameNetAllAvailableIp[$i]}"
    #            done
    #            echoN "998. 不知道"
    #            echoN "999. 自己输入IP"
    #            read -p "以上是同网段所有IP,请选择3级调度(选IP前的序号):" unitThirdLevelIpIndex
    #            if [[ $unitThirdLevelIpIndex -lt 998 ]];then
    ##                echo "用户输入 < 998"
    #                unitThirdLevelIp=${sameNetAllAvailableIp[$unitThirdLevelIpIndex]}
    #                echoR "用户输入的序号和ip= $northIcssIpIndex $northEmqxIp"
    #            elif [[ $unitThirdLevelIpIndex == "998" ]];then
    #                echo "用户输入 998"
    #                unitThirdLevelIp=$userChooseLocalIp
    #            elif [[ $unitThirdLevelIpIndex == "999" ]];then
    #                echo "用户输入 999"
    #                read -p "请输入IP： " userInputUnitThirdLevelIp
    #                if [[ `isValidIp $userInputUnitThirdLevelIp` == "0"  ]];then
    #                    echoE "IP格式错误"
    #                    unitThirdLevelIp=$userChooseLocalIp
    ##                    return 0
    #                fi
    #                unitThirdLevelIp=$userInputUnitThirdLevelIp
    #            else
    #                echoE "序号不支持"
    #            fi
    #            sed -i "s/unitThirdLevelIp.*$/unitThirdLevelIp=$unitThirdLevelIp/g" onekey.cfg
    #
    #            ## 5.6 选择 4级别调度  unitFourthLevelIp
    #            sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
    #            # 打印同网段所有ip
    #            for((i=0;i<sameNetAllAvailableIpLen;i++));
    #            do
    #                echoN "$i. ${sameNetAllAvailableIp[$i]}"
    #            done
    #            echoN "998. 不知道"
    #            echoN "999. 自己输入IP"
    #            read -p "以上是同网段所有IP,请选择4级调度(选IP前的序号):" unitFourthLevelIpIndex
    #            if [[ $unitFourthLevelIpIndex -lt 998 ]];then
    ##                echo "用户输入 < 998"
    #                unitFourthLevelIp=${sameNetAllAvailableIp[$unitFourthLevelIpIndex]}
    #                echoR "用户输入的序号和ip= $northIcssIpIndex $northEmqxIp"
    #            elif [[ $unitFourthLevelIpIndex == "998" ]];then
    #                echo "用户输入 998"
    #                unitFourthLevelIp=$userChooseLocalIp
    #            elif [[ $unitFourthLevelIpIndex == "999" ]];then
    #                echo "用户输入 999"
    #                read -p "请输入IP： " userInputUnitFourthLevelIp
    #                if [[ `isValidIp $userInputUnitFourthLevelIp` == "0"  ]];then
    #                    echoE "IP格式错误"
    #                    unitFourthLevelIp=$userChooseLocalIp
    ##                    return 0
    #                fi
    #                unitFourthLevelIp=$userInputUnitFourthLevelIp
    #            else
    #                echoE "序号不支持"
    #            fi
    #            sed -i "s/unitFourthLevelIp.*$/unitFourthLevelIp=$unitFourthLevelIp/g" onekey.cfg
    #
    #            ## 5.6 选择 5级别调度  unitFifthLevelIp
    #            sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
    #            # 打印同网段所有ip
    #            for((i=0;i<sameNetAllAvailableIpLen;i++));
    #            do
    #                echoN "$i. ${sameNetAllAvailableIp[$i]}"
    #            done
    #            echoN "998. 不知道"
    #            echoN "999. 自己输入IP"
    #            read -p "以上是同网段所有IP,请选择5级调度(选IP前的序号):" unitFifthLevelIpIndex
    #            if [[ $unitFifthLevelIpIndex -lt 998 ]];then
    ##                echo "用户输入 < 998"
    #                unitFifthLevelIp=${sameNetAllAvailableIp[$unitFourthLevelIpIndex]}
    #                echoR "用户输入的序号和ip= $northIcssIpIndex $northEmqxIp"
    #            elif [[ $unitFifthLevelIpIndex == "998" ]];then
    #                echo "用户输入 998"
    #                unitFifthLevelIp=$userChooseLocalIp
    #            elif [[ $unitFifthLevelIpIndex == "999" ]];then
    #                echo "用户输入 999"
    #                read -p "请输入IP： " userInputUnitFifthLevelIp
    #                if [[ `isValidIp $userInputUnitFifthLevelIp` == "0"  ]];then
    #                    echoE "IP格式错误"
    #                    unitFifthLevelIp=$userChooseLocalIp
    ##                    return 0
    #                fi
    #                unitFifthLevelIp=$userInputUnitFifthLevelIp
    #            else
    #                echoE "序号不支持"
    #            fi
    #            sed -i "s/unitFifthLevelIp.*$/unitFifthLevelIp=$unitFifthLevelIp/g" onekey.cfg
    #
    #            ;;
    #        2)
    #            echoR "用户选择非组网"
    #            sed -i "s/isNetworking.*$/isNetworking=0/g" onekey.cfg
    #            isNetworking=0
    #            ;;
    #        esac
    fi

        if [ "$projectName" == "aj" ];then

            #     1. 选择系统类型？  --》不选/回车默认按-默认来，目前默认==centos8
            sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseSystem.txt
            if [ "$ifShowHiddenFunction" -eq 1 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseSystem.txt`
            elif [ "$ifShowHiddenFunction" -eq 0 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseSystem.txt | grep -v "#"`
            fi
            read -p "请选择序号(系统类型):"  userChooseSystemVersionIndex
            case $userChooseSystemVersionIndex in
                1)
                    # c8
                    userChooseSystemVersion='centos8'
                    ;;
                *)
                    # c8
                    userChooseSystemVersion='centos8'
                    ;;
            esac

            ## 判断真实系统是否和配置一样
            realSystemVersion=`getRealSystemVersion`

            echoN "配置的系统= $userChooseSystemVersion"
            echoN "真实的系统= $realSystemVersion"
            if [[ $realSystemVersion != $userChooseSystemVersion ]];then
                echoE "本系统与配置不符,请检查!!,本系统= $realSystemVersion"
                exit
            fi
            systemVersion=$userChooseSystemVersion
            echoR "用户配置系统版本== $systemVersion"

            #     1. 选择模板？1.默认 2.正样 --》不选/回车默认按-默认来，目前默认=正样 √
            sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseConfTemplate.txt
            if [ "$ifShowHiddenFunction" -eq 1 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseConfTemplate.txt`
            elif [ "$ifShowHiddenFunction" -eq 0 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseConfTemplate.txt | grep -v "#"`
            fi
            read -p "请选择序号(配置模板):"  userChooseCfgTemplate
            case $userChooseCfgTemplate in
                1)
                    # 西安验收 模板
                    echoN "用户选择 西安验收 模板"
                    if [ "$userChooseSystemVersionIndex" -eq 1 ];then  # kylin
                        echoR "使用配置模板 西安验收"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-merge-v0.0.1-V0.0.1-centos8-aj.cfg $projectPath/installPackages/installShell/onekey.cfg
                    fi
                    sed -i "s/^installServiceVersion.*/installServiceVersion=v0.0.1/g" $projectPath/installPackages/installShell/onekey.cfg
                    installServiceVersion="v0.0.1"
                    ;;
                *)
                    # 西安验收 模板
                    echoN "用户选择 西安验收 模板"
                    if [ "$userChooseSystemVersionIndex" -eq 1 ];then  # kylin
                        echoR "使用配置模板 西安验收"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-merge-v0.0.1-V0.0.1-centos8-aj.cfg $projectPath/installPackages/installShell/onekey.cfg
                    fi
                    sed -i "s/^installServiceVersion.*/installServiceVersion=v0.0.1/g" $projectPath/installPackages/installShell/onekey.cfg
                    installServiceVersion="v0.0.1"
                    ;;
            esac

            #     选择板卡类型 1.主板 2.从板,默认主板
            sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseCardType.txt
            if [ "$ifShowHiddenFunction" -eq 1 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseCardType.txt`
            elif [ "$ifShowHiddenFunction" -eq 0 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseCardType.txt | grep -v "#"`
            fi
            read -p "请选择序号(板卡类型):"  userChooseCardType
            case $userChooseCardType in
                1)
                    # 主板
                    echoR "用户选择1. 主板"
                    sed -i "s/cardType.*$/cardType=1/g" onekey.cfg
                    cardType=1
                    ;;
                2)
                    # 从板
                    echoR "用户选择2. 从板"
                    sed -i "s/cardType.*$/cardType=2/g" onekey.cfg
                    cardType=2
                    ;;
                *)
                    # 主板
                    sed -i "s/cardType.*$/cardType=1/g" onekey.cfg
                    cardType=1
                    ;;
            esac

            #    2. 选择是否要分布式部署（网管和调度分别部署在不同的服务器）？ 1.是 2否
    #        sed -i 's/\r//' $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseDistributeType.txt
    #        echoN `cat $projectPath/installPackages/commonConf/menu/guideUserMenu/chooseDistributeType.txt | grep -v "#"`
    #        read -p "请选择序号(是否分布式部署):"  userChooseInstallType
    #        case $userChooseInstallType in
    #            1)
    #                # 分布式部署
    #                echoR "用户选择1. 是"
    #                sed -i "s/ifDistributed.*$/ifDistributed=1/g" onekey.cfg
    #                ifDistributed=1
    #                ;;
    #            2)
    #                # 非分布式部署
    #                echoR "用户选择2. 否"
    #                ifDistributed=0
    #                ;;
    #        esac

            sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseInstallService.txt
            if [ "$ifShowHiddenFunction" -eq 1 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseInstallService.txt`
            elif [ "$ifShowHiddenFunction" -eq 0 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseInstallService.txt | grep -v "#"`
            fi
            read -p "请选择序号(安装的服务):"  userChooseInstallService
            case $userChooseInstallService in
                1)
                    # aj nms
                    sed -i "s/preInstallService.*$/preInstallService=1/g" onekey.cfg
                    ifDistributed=0
                    ;;
                2)
                    # 机动式
                    \cp conf_template/onekey-merge-v0.0.1-V0.0.1-centos8-aj-jds.cfg onekey.cfg
                    sed -i "s/preInstallService.*$/preInstallService=2/g" onekey.cfg
                    source onekey.cfg
                    ifDistributed=0
                    ;;
                *)
                    # aj nms
                    sed -i "s/preInstallService.*$/preInstallService=1/g" onekey.cfg
                    ifDistributed=0
                    ;;
            esac
            echoR "用户选择 $userChooseInstallService"

            if [ "$preInstallService" -eq 1 ];then  # aj nms
                # 非分布式部署
                ## 0。从本级所有IP中选择 业务ip
                allLocalIp=(`getAllIpLocalServerFromKylinReturnStrList`)
                allLocalIpLen=${#allLocalIp[*]}
                for((i=0;i<allLocalIpLen;i++));
                do
                    echoN "$i. ${allLocalIp[$i]}"
                done
                read -p "以上是本服务器所有IP,请选择业务ip(输入ip前的序号:)" localIpIndex
                userChooseLocalIp=${allLocalIp[$localIpIndex]}
                echoR "用户输入的序号和ip= $localIpIndex $userChooseLocalIp"

                ## 1. 修改配置文件localIp
                sed -i "s/localIp.*$/localIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/microIp.*$/microIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/icssIp.*$/icssIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/nmsIp.*$/nmsIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/emqIp.*$/emqIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/northIcssIp.*$/northIcssIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/northEmqxIp.*$/northEmqxIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/mysqlIp.*$/mysqlIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/redisIp.*$/redisIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/upLevelNmsIp.*$/upLevelNmsIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/northIcssIp.*$/northIcssIp=$userChooseLocalIp/g" onekey.cfg

                sed -i "s/unitFirstLevelIp.*$/unitFirstLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitSecondLevelIp.*$/unitSecondLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitThirdLevelIp.*$/unitThirdLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitFourthLevelIp.*$/unitFourthLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitFifthLevelIp.*$/unitFifthLevelIp=$userChooseLocalIp/g" onekey.cfg

                ## 2. 从同网段所有ip中找出核心网ip
                echo "查询核心网ip中，请等待。。。"
                echo "查询核心网ip中，请等待。。。"
                echo "查询核心网ip中，请等待。。。"
                sameNetAllAvailableIp=(`getSameNetAllAvailableIpReturnStrList $userChooseLocalIp`)
                if [[ "$sameNetAllAvailableIp" == "0" ]];then
                    echoE "同网段无可用ip"
                else
                    echo ""
    #                echo "同网段可用ip=  $sameNetAllAvailableIp"
                fi

                sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
                for((i=0;i<sameNetAllAvailableIpLen;i++));
                do
                    echoN "$i. ${sameNetAllAvailableIp[$i]}"
                done

                echoN "998. 不知道"
                echoN "999. 自己输入IP"
                read -p "以上是同网段所有IP,请选择一个IP前的序号(此IP是核心网用的):" switchIpIndex
                if [[ $switchIpIndex -lt 998 ]];then
    #                echo "用户输入 < 998"
                    userChooseSwitchIp=${sameNetAllAvailableIp[$switchIpIndex]}
                    echoR "用户输入的序号和ip= $switchIpIndex $userChooseSwitchIp"
                elif [[ $switchIpIndex == "998" ]];then
                    echo "用户输入 998"
                    userChooseSwitchIp=$userChooseLocalIp
                elif [[ $switchIpIndex == "999" ]];then
                    echo "用户输入 999"
                    read -p "请输入IP： " userInputSwitchIp
                    if [[ `isValidIp $userInputSwitchIp` == "0"  ]];then
                        echoE "IP格式错误"
                        return 0
                    fi
                    userChooseSwitchIp=$userInputSwitchIp

                else
                    echoE "序号不支持"
                fi
                ## 2.1 修改配置文件 switchIp
                sed -i "s/switchIp.*$/switchIp=$userChooseSwitchIp/g" onekey.cfg
            fi

            if [ "$preInstallService" -eq 2 ];then  # 机动式
                # 非分布式部署
                ## 0。从本级所有IP中选择 业务ip
                allLocalIp=(`getAllIpLocalServerFromKylinReturnStrList`)
                allLocalIpLen=${#allLocalIp[*]}
                for((i=0;i<allLocalIpLen;i++));
                do
                    echoN "$i. ${allLocalIp[$i]}"
                done
                read -p "以上是本服务器所有IP,请选择业务ip(输入ip前的序号:)" localIpIndex
                userChooseLocalIp=${allLocalIp[$localIpIndex]}
                echoR "用户输入的序号和ip= $localIpIndex $userChooseLocalIp"

                ## 1. 修改配置文件localIp
                sed -i "s/localIp.*$/localIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/microIp.*$/microIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/icssIp.*$/icssIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/nmsIp.*$/nmsIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/emqIp.*$/emqIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/northIcssIp.*$/northIcssIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/northEmqxIp.*$/northEmqxIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/mysqlIp.*$/mysqlIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/redisIp.*$/redisIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/upLevelNmsIp.*$/upLevelNmsIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/northIcssIp.*$/northIcssIp=$userChooseLocalIp/g" onekey.cfg

                sed -i "s/unitFirstLevelIp.*$/unitFirstLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitSecondLevelIp.*$/unitSecondLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitThirdLevelIp.*$/unitThirdLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitFourthLevelIp.*$/unitFourthLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitFifthLevelIp.*$/unitFifthLevelIp=$userChooseLocalIp/g" onekey.cfg

                ## 2. 从同网段所有ip中找出核心网ip
                echo "查询核心网ip中，请等待。。。"
                echo "查询核心网ip中，请等待。。。"
                echo "查询核心网ip中，请等待。。。"
                sameNetAllAvailableIp=(`getSameNetAllAvailableIpReturnStrList $userChooseLocalIp`)
                if [[ "$sameNetAllAvailableIp" == "0" ]];then
                    echoE "同网段无可用ip"
                else
                    echo ""
    #                echo "同网段可用ip=  $sameNetAllAvailableIp"
                fi

                sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
                for((i=0;i<sameNetAllAvailableIpLen;i++));
                do
                    echoN "$i. ${sameNetAllAvailableIp[$i]}"
                done

                echoN "998. 不知道"
                echoN "999. 自己输入IP"
                read -p "以上是同网段所有IP,请选择一个IP前的序号(此IP是核心网用的):" switchIpIndex
                if [[ $switchIpIndex -lt 998 ]];then
    #                echo "用户输入 < 998"
                    userChooseSwitchIp=${sameNetAllAvailableIp[$switchIpIndex]}
                    echoR "用户输入的序号和ip= $switchIpIndex $userChooseSwitchIp"
                elif [[ $switchIpIndex == "998" ]];then
                    echo "用户输入 998"
                    userChooseSwitchIp=$userChooseLocalIp
                elif [[ $switchIpIndex == "999" ]];then
                    echo "用户输入 999"
                    read -p "请输入IP： " userInputSwitchIp
                    if [[ `isValidIp $userInputSwitchIp` == "0"  ]];then
                        echoE "IP格式错误"
                        return 0
                    fi
                    userChooseSwitchIp=$userInputSwitchIp

                else
                    echoE "序号不支持"
                fi
                ## 2.1 修改配置文件 switchIp
                sed -i "s/switchIp.*$/switchIp=$userChooseSwitchIp/g" onekey.cfg

                ### 北向网管ip
                sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
                for((i=0;i<sameNetAllAvailableIpLen;i++));
                do
                    echoN "$i. ${sameNetAllAvailableIp[$i]}"
                done

                echoN "998. 不知道"
                echoN "999. 自己输入IP"
                read -p "以上是同网段所有IP,请选择一个IP前的序号(查看性能统计数据网管ip):" nmsIpIndex
                if [[ $nmsIpIndex -lt 998 ]];then
    #                echo "用户输入 < 998"
                    userChooseNmsIp=${sameNetAllAvailableIp[$nmsIpIndex]}
                    echoR "用户输入的序号和ip= $nmsIpIndex $userChooseNmsIp"
                elif [[ $nmsIpIndex == "998" ]];then
                    echo "用户输入 998"
                    userChooseNmsIp=$userChooseLocalIp
                elif [[ $nmsIpIndex == "999" ]];then
                    echo "用户输入 999"
                    read -p "请输入IP： " userInputNmsIp
                    if [[ `isValidIp $userInputNmsIp` == "0"  ]];then
                        echoE "IP格式错误"
                        return 0
                    fi
                    userChooseNmsIp=$userInputNmsIp

                else
                    echoE "序号不支持"
                fi
                ## 2.1 修改配置文件 nmsIp
                sed -i "s/nmsIp.*$/nmsIp=$userChooseNmsIp/g" onekey.cfg
            fi
        fi

        if [ "$projectName" == "0203" ];then
            #     1. 选择系统类型？  --》不选/回车默认按-默认来，目前默认==ky10-x86
            sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseSystem.txt
            if [ "$ifShowHiddenFunction" -eq 1 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseSystem.txt`
            elif [ "$ifShowHiddenFunction" -eq 0 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseSystem.txt | grep -v "#"`
            fi
            read -p "请选择序号(系统类型):"  userChooseSystemVersionIndex
            case $userChooseSystemVersionIndex in
                1)
                    # c8
                    userChooseSystemVersion='centos8'
                    ;;
                *)
                    # c8
                    userChooseSystemVersion='centos8'
                    ;;
            esac

            ## 判断真实系统是否和配置一样
            realSystemVersion=`getRealSystemVersion`

            echoN "配置的系统= $userChooseSystemVersion"
            echoN "真实的系统= $realSystemVersion"
            if [[ $realSystemVersion != $userChooseSystemVersion ]];then
                echoE "本系统与配置不符,请检查!!,本系统= $realSystemVersion"
                exit
            fi
            systemVersion=$userChooseSystemVersion
            echoR "用户配置系统版本== $systemVersion"

            #     1. 选择模板？1.默认 2.正样 --》不选/回车默认按-默认来，目前默认=正样 √
            sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseConfTemplate.txt
            if [ "$ifShowHiddenFunction" -eq 1 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseConfTemplate.txt`
            elif [ "$ifShowHiddenFunction" -eq 0 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseConfTemplate.txt | grep -v "#"`
            fi
            read -p "请选择序号(配置模板):"  userChooseCfgTemplate
            case $userChooseCfgTemplate in
                1)
                    # 正样 模板
                    echoN "用户选择 正样 模板"
                    if [ "$userChooseSystemVersionIndex" -eq 1 ];then  # kylin
                        echoR "使用配置模板 正样"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-nomerge-v0.0.1-V0.0.1-kylin-x86-0203.cfg $projectPath/installPackages/installShell/onekey.cfg
                    fi
                    sed -i "s/^installServiceVersion.*/installServiceVersion=v0.0.1/g" $projectPath/installPackages/installShell/onekey.cfg
                    installServiceVersion="v0.0.1"
                    ;;
                *)
                    # 西安验收 模板
                    echoN "用户选择 正样 模板"
                    if [ "$userChooseSystemVersionIndex" -eq 1 ];then  # kylin
                        echoR "使用配置模板 正样"
                        \cp $projectPath/installPackages/installShell/conf_template/onekey-nomerge-v0.0.1-V0.0.1-kylin-x86-0203.cfg $projectPath/installPackages/installShell/onekey.cfg
                    fi
                    sed -i "s/^installServiceVersion.*/installServiceVersion=v0.0.1/g" $projectPath/installPackages/installShell/onekey.cfg
                    installServiceVersion="v0.0.1"
                    ;;
            esac

            #     选择板卡类型 1.主板 2.从板,默认主板
            sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseCardType.txt
            if [ "$ifShowHiddenFunction" -eq 1 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseCardType.txt`
            elif [ "$ifShowHiddenFunction" -eq 0 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseCardType.txt | grep -v "#"`
            fi
            read -p "请选择序号(板卡类型):"  userChooseCardType
            case $userChooseCardType in
                1)
                    # 主板
                    echoR "用户选择1. 主板"
                    sed -i "s/cardType.*$/cardType=1/g" onekey.cfg
                    cardType=1
                    ;;
                2)
                    # 从板
                    echoR "用户选择2. 从板"
                    sed -i "s/cardType.*$/cardType=2/g" onekey.cfg
                    cardType=2
                    ;;
                *)
                    # 主板
                    sed -i "s/cardType.*$/cardType=1/g" onekey.cfg
                    cardType=1
                    ;;
            esac

            sed -i 's/\r//' $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseInstallService.txt
            if [ "$ifShowHiddenFunction" -eq 1 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseInstallService.txt`
            elif [ "$ifShowHiddenFunction" -eq 0 ];then
                echoN `cat $projectPath/installPackages/commonConf/$versionCfgFolderName/menu/guideUserMenu/chooseInstallService.txt | grep -v "#"`
            fi
            read -p "请选择序号(安装的服务):"  userChooseInstallService
            case $userChooseInstallService in
                1)
                    # aj nms
                    sed -i "s/preInstallService.*$/preInstallService=1/g" onekey.cfg
                    ifDistributed=0
                    ;;
                *)
                    # aj nms
                    sed -i "s/preInstallService.*$/preInstallService=1/g" onekey.cfg
                    ifDistributed=0
                    ;;
            esac
            echoR "用户选择 $userChooseInstallService"

            if [ "$preInstallService" -eq 1 ];then  # aj nms
                # 非分布式部署
                ## 0。从本级所有IP中选择 业务ip
                allLocalIp=(`getAllIpLocalServerFromKylinReturnStrList`)
                allLocalIpLen=${#allLocalIp[*]}
                for((i=0;i<allLocalIpLen;i++));
                do
                    echoN "$i. ${allLocalIp[$i]}"
                done
                read -p "以上是本服务器所有IP,请选择业务ip(输入ip前的序号:)" localIpIndex
                userChooseLocalIp=${allLocalIp[$localIpIndex]}
                echoR "用户输入的序号和ip= $localIpIndex $userChooseLocalIp"

                ## 1. 修改配置文件localIp
                sed -i "s/localIp.*$/localIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/microIp.*$/microIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/icssIp.*$/icssIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/nmsIp.*$/nmsIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/emqIp.*$/emqIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/northIcssIp.*$/northIcssIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/northEmqxIp.*$/northEmqxIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/mysqlIp.*$/mysqlIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/redisIp.*$/redisIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/upLevelNmsIp.*$/upLevelNmsIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/northIcssIp.*$/northIcssIp=$userChooseLocalIp/g" onekey.cfg

                sed -i "s/unitFirstLevelIp.*$/unitFirstLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitSecondLevelIp.*$/unitSecondLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitThirdLevelIp.*$/unitThirdLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitFourthLevelIp.*$/unitFourthLevelIp=$userChooseLocalIp/g" onekey.cfg
                sed -i "s/unitFifthLevelIp.*$/unitFifthLevelIp=$userChooseLocalIp/g" onekey.cfg

                ## 2. 从同网段所有ip中找出核心网ip
                echo "查询核心网ip中，请等待。。。"
                echo "查询核心网ip中，请等待。。。"
                echo "查询核心网ip中，请等待。。。"
                sameNetAllAvailableIp=(`getSameNetAllAvailableIpReturnStrList $userChooseLocalIp`)
                if [[ "$sameNetAllAvailableIp" == "0" ]];then
                    echoE "同网段无可用ip"
                else
                    echo ""
    #                echo "同网段可用ip=  $sameNetAllAvailableIp"
                fi

                sameNetAllAvailableIpLen=${#sameNetAllAvailableIp[*]}
                for((i=0;i<sameNetAllAvailableIpLen;i++));
                do
                    echoN "$i. ${sameNetAllAvailableIp[$i]}"
                done

                echoN "998. 不知道"
                echoN "999. 自己输入IP"
                read -p "以上是同网段所有IP,请选择一个IP前的序号(此IP是核心网用的):" switchIpIndex
                if [[ $switchIpIndex -lt 998 ]];then
    #                echo "用户输入 < 998"
                    userChooseSwitchIp=${sameNetAllAvailableIp[$switchIpIndex]}
                    echoR "用户输入的序号和ip= $switchIpIndex $userChooseSwitchIp"
                elif [[ $switchIpIndex == "998" ]];then
                    echo "用户输入 998"
                    userChooseSwitchIp=$userChooseLocalIp
                elif [[ $switchIpIndex == "999" ]];then
                    echo "用户输入 999"
                    read -p "请输入IP： " userInputSwitchIp
                    if [[ `isValidIp $userInputSwitchIp` == "0"  ]];then
                        echoE "IP格式错误"
                        return 0
                    fi
                    userChooseSwitchIp=$userInputSwitchIp

                else
                    echoE "序号不支持"
                fi
                ## 2.1 修改配置文件 switchIp
                sed -i "s/switchIp.*$/switchIp=$userChooseSwitchIp/g" onekey.cfg
            fi

        fi

        echoR "用户引导完成，退出脚本！ 请重新运行脚本!"
        exit
        ;;
	2)
		# 不引导用户
		echoN "用户选择2. 否(本次不引导)"
		return 0
		;;
	3)
		# 永久跳过引导用户
		# 更新配置
		sed -i "s/ifGuideUser.*$/ifGuideUser=0/g" onekey.cfg
		;;
	esac
}


# 判断是否要引导用户
echoR "是否引导用户=== $ifGuideUser ！！！"
if [[  -n $ifGuideUser && $ifGuideUser -eq 0 || ${ifGuideUser,,} == "false" || ${ifGuideUser^^} == "FALSE" ]];then
    echoR "永久跳过引导。。。。"
elif [[ $ifGuideUser -eq 1 || ${ifGuideUser,,} == "true" || ${ifGuideUser^^} == "TRUE" || -z "$ifGuideUser" ]];then
    guideUser
fi