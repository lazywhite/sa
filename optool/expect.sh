#!/usr/bin/expect -f

set timeout 10

spawn su - ansible
expect "Password"
send "123456\r"
expect "$*"
send "ls -al\r"
send "exit\r"
expect eof

exit
