#!/bin/bash

redisIp='redis_ip'  #网管redis IP
redisPort='redis_port'    #网管redis 端口号  
frequency=5     #多少秒上报一次
string='$GNGGA,095528.000,2318.1133,N,11319.7210,E,1,06,3.7,55.1,M,-5.4,M,,0000*69'
OLD_IFS="$IFS"
IFS=","
count=0
cat /dev/ttyAMA1 | while read LINE
do
    string=${LINE}
    array=($string)
#    echo "${array[0]}->${count}"
    if [ "${array[0]}" = '$GNGGA' ]
    then
        if [ ${count} == ${frequency} ]
        then
            if [ ${array[6]} != '0' ]
            then
                value="{"longitude":"${array[4]}","latitude":"${array[2]}","high":"${array[9]}","time":"${array[1]}"}"
#		echo ${value}
                redis-cli -h ${redisIp} set com.sunkaisens.location.jds "${value}"
                count=0
            else
                value="Not locate"
#		echo ${value}
                redis-cli -h ${redisIp} set com.sunkaisens.location.jds "${value}"
                count=0
            fi
        else
            ((count++))
	fi
    fi
done
