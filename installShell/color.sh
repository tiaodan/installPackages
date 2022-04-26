#!/bin/bash

##变量
nostyle="\033[0m"

# 背景色
bg_black="\033[40m"
bg_red="\033[41m"
bg_green="\033[42m"
bg_yellow="\033[43m"
bg_blue="\033[44m"
bg_purple="\033[45m"
bg_deep_green="\033[46m"
bg_white="\033[47m"

# 字体色
font_black="\033[30m"
font_red="\033[31m"
font_green="\033[32m"
font_yellow="\033[33m"
font_blue="\033[34m"
font_purple="\033[35m"
font_deep_green="\033[36m"
font_white="\033[37m"
font_has_underline="\033[38m"
font_no_underline="\033[39m"

# 效果
effect_no="\033[0m"
effect_highlight="\033[1m"
effect_lowlight="\033[2m"
effect_underline="\033[4m"
effect_flashing="\033[5m"
effect_reverse="\033[7m"
effect_hide="\033[8m"

# 正确错误提示效果
right_color=$font_green
error_color=$bg_red
nomal_color=$bg_blue
right_info=$font_green
error_info=$bg_red
nomal_info=$bg_blue



function getColorHelp(){
	# \033[+bg+;+font_color+;+效果+m
	echo -e "\033[41m haha \033[42m heihei \033[0m"
	echo -E "$bg_deep_green haha \033[42m heihei \033[0m"
	# echo -e "${1}${@:2}${PLAIN}"
	
	echo 背景色
	echo 背景色取值范围: 40-49
	echo -e "$bg_black 40: 黑 $nostyle"
	echo -e "$bg_red 41: 红 $nostyle" 
	echo -e	"$bg_green 42: 绿 $nostyle"
	echo -e	"$bg_yellow 43: 黄 $nostyle}" 
	echo -e	"$bg_blue 44: 蓝 $nostyle"
	echo -e	"$bg_purple 45: 紫 $nostyle"
	echo -e	"$bg_deep_green 46: 深绿 $nostyle" 
	echo -e	"$bg_white 47: 灰白 $nostyle"
	echo 字体色
	echo 字体颜色取值范围: 30-39
	echo -e "$font_black 30: 黑 $nostyle"
	echo -e "$font_red 31: 红 $nostyle" 
	echo -e	"$font_green 32: 绿 $nostyle"
	echo -e	"$font_yellow 33: 黄 $nostyle" 
	echo -e	"$font_blue 34: 蓝 $nostyle"
	echo -e	"$font_purple 35: 紫 $nostyle"
	echo -e	"$font_deep_green 36: 深绿 $nostyle" 
	echo -e	"$font_white 37: 灰白 $nostyle"
	echo -e	"$font_has_underline 38:在默认的前景颜色上设置下划线  $nostyle"
	echo -e	"$font_no_underline 39:在默认的前景颜色上关闭下划线 $nostyle"
	echo 效果
	echo 效果取值范围: 0-8
	echo -e	"$effect_no 0:不使用效果 $nostyle"
	echo -e	"$effect_highlight 1:高亮(加深)显示 $nostyle"
	echo -e	"$effect_lowlight 2:低亮(减弱)显示 $nostyle"
	echo -e	"$effect_underline 4:下划线 $nostyle"
	echo -e	"$effect_flashing 5:闪烁 $nostyle"
	echo -e	"$effect_reverse 7:反显(替换背景色和字体颜色) $nostyle"
	echo -e	"$effect_hide 8:消隐 $nostyle"
}

function colorEcho(){
	echo -e "$@ $nostyle"
}

function colorEchoTest_nouse(){
	echo '参数个数argNum$#=' $#
	argNum=$#
	for((i=0;i<$argNum;i++))
	do
		# echo $1 $2 $3	
		echo $(${i})
	done
	### 无用代码
        for i in $@
        do
		echo -e "$bg_green 第$index $bg_red 个变量value= $i $nostyle"
		index=$[$index+1]
	done
	### 无用代码
}


function echoN(){
    echo -e "$nomal_color $@ $nostyle"
}


function echoR(){
    echo -e "$right_color $@ $nostyle"
}


function echoE(){
    echo -e "$error_color $@ $nostyle"
}

