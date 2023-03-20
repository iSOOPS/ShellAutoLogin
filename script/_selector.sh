#!/bin/bash
host=$1
port=$2
desc=$3

#获取脚本文件根目录(绝对路径)
path=$(dirname $(dirname $(readlink -f "$0")))

ACCOUNT_TEXT="$path/settings/$host.txt"
acct_list=()
pass_list=()

creat_list () {
    index=0
    for user in $(awk '{print $1}' $ACCOUNT_TEXT)
    do
        pass=$(awk -v I="$user" 'I==$1{print $2}' $ACCOUNT_TEXT)
        acct_list[$index]=$user
        pass_list[$index]=$pass
        ((index++))
    done
}

views () {
    echo "longer"
    echo $host
    echo $port
    echo $desc
    index=0
    for name in "${acct_list[@]}"
    do
        echo "$name"
        echo ${pass_list[$index]}
        ((index++))
    done

}

# 创建一个交互式shell
# 使用readline库实现通过箭头上下选择命令并执行特定功能

# 退出shell的函数
quit_shell() {
  echo "Goodbye!"
  exit 2
}


commands() {
    clear
    expect "$path/script/_ssh.sh" $host $port $desc ${acct_list[$1]} ${pass_list[$1]}
    exit 2
}

creat_list
if [ "${#acct_list[@]}" = "1" ]; then
  commands 0
  exit 2
fi

# views
# 定义变量用于跟踪选项的位置
option_pos=0
# 无限循环，直到退出shell
while true
do
  # 清屏
  clear
  echo HOST - $host
  echo PORT - $port
  echo DESC - $desc
  echo 请选择登录的账号: ${acct_list[$option_pos]}
  # 显示选项列表
  for ((i=0; i<${#acct_list[@]}; i++))
  do
    if [ $i -eq $option_pos ]
    then
      echo "> ${acct_list[$i]}"
    else
      echo "  ${acct_list[$i]}"
    fi
  done

  # 读取用户输入
  read -s -n 1 input

  # 根据用户输入执行相应的操作
  case $input in
    A) # 上箭头
      if [ $option_pos -gt 0 ]
        echo ${acct_list[$option_pos]}
      then
        option_pos=$((option_pos-1))
      fi
      ;;
    B) # 下箭头
      if [ $option_pos -lt $((${#options[@]}-1)) ]
        echo ${acct_list[$option_pos]}
      then
        option_pos=$((option_pos+1))
      fi
      ;;
    '') # 回车键
      # 调用相应的命令函数
      commands $option_pos
      ;;
    *) # 其他输入
      continue
      ;;
  esac
done


