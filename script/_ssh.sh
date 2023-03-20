#!/usr/bin/expect
set host [lindex $argv 0]
set port [lindex $argv 1]
set desc [lindex $argv 2]
set acct [lindex $argv 3]
set pass [lindex $argv 4]

# puts "$host,$port,$desc,$acct,$pass" 
set cmd_prompt "]#|~]?"
puts "开始登录:$desc" 
spawn ssh -p $port $acct@$host 
expect {
    "yes/no" {send "yes\r";exp_continue;}
    "*password:*" { send "$pass\r"}
}
if {$acct != "root"} {
    puts "开始登录$desc" 
    expect {
        -re $cmd_prompt {
            send "sudo su - root\r"
            expect {
                "*：" { send "$pass\r" }
            }
        }
    }
}
interact