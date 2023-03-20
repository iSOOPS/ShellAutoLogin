# ShellAutoLogin

这是一个shell登录服务器脚本
为啥我要写这个脚本？
日常我在使用iterm2去登录远程登录服务器，需要配置一些简单的脚本，使用secureCRT则需要配置服务器信息
最简单的原因就是我需要一键登录的前提下，可选择不同的用户，还可以直接切换到root用户权限,就像 **'su root'**
当然，我还需要一个脚本可以在多个终端工具中都可以兼容使用，而且不同终端工具不会保存我服务器的信息

It's a little tool for login remote server login script.
Why shold I pg this script？
I can used the iterm2 or secureCRT with some easy script or setting for a step to login remote.
Easy reson,I wan't a step to login remote with users selector and auto change to root user(u need have sudoers permission),like **'su root'**
also I need a script can used by any Terminal tool and I don't need to settings on Terminal tool,the Terminal tool can't save my server info too.

***

文件目录(file menu)

## root 
| -- README.md

| -- _actioncreator.sh 生成actions文件夹以及执行文件(this script can create actions dir and script for execute)

| -- script 主要脚本(main script)

| -- settings 配置服务器信息,账户信息(server info,account info)

## settings
| -- xxx.xxx.xxx.xxx.txt 账户信息xxx为host地址(account info,filename must be host)

| -- server.txt 配置服务器信息(server info)

## actions (通过_actioncreator生成) (create by _actioncreator script)
| -- xxx.xxx.xxx.xxx.sh 可执行文件,执行即可实现登录(execute the script can finish login remote server)

**ps:执行设备,也就是你的电脑,需要支持expect(u execute device must support expect)**

