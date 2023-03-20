#!/bin/bash

#获取脚本文件根目录,当前路径(绝对路径)
path=$(dirname $(readlink -f "$0"))

SERVER_TEXT="$path/settings/server.txt"

rm -rf $path/actions
mkdir $path/actions

for host in $(awk '{print $1}' $SERVER_TEXT)
do
    dirname=$path/actions/$host.sh
    touch $dirname

    echo "#!/bin/bash" >> $dirname
    echo "#由于执行目录不同，直接使用相对路径是基于执行目录的，无法动态获取当前文件路径，遂获取绝对路径使用"  >> $dirname
    echo "#获取脚本文件根目录(绝对路径)"  >> $dirname
    echo "path=\$(dirname \$(dirname \$(readlink -f \"\$0\")))"  >> $dirname
    echo "#获取文件名称，去除后缀"  >> $dirname
    echo "host=\$(basename \$0 .sh)"  >> $dirname
    echo "#拼接下一个执行文件路径"  >> $dirname
    echo "_actions_path=\"\$path/script/_constructor.sh\""  >> $dirname
    echo "#执行下一个脚本，传递当前文件名(服务器ip)"  >> $dirname
    echo "sh \$_actions_path \$host"  >> $dirname
    echo $host 构建完成
done

chmod u+x $path/actions/*.sh


