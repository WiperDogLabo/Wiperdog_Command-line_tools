#!/usr/bin/expect
#!/bin/bash
puts "++++++++++++++++++++++++++"
puts "Test tools 'genjobinst'"
puts "++++++++++++++++++++++++++"

puts "#Case1: Input all require data: "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobInst/A.instances
set dest_file  $wiperdogPath/var/job/A.instances
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobinst.sh
expect "Enter job name need to create instance (*) :"
send "A\r"
expect "Enter instance name (*) :"
send "inst_1\r"
expect "Enter schedule :"
send "10i\r"
expect "Enter params (ex: param1=1 , param2=3 ) :"
send "a=1,b=2\r"
expect "Enter instance name (*) :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 1 Success !\r"
} else {
   puts "Case 1 Failed ! \r"
} 
puts "---------------------------------------"
puts "#Case2: Leave schedule empty: "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobInst/A_2.instances
set dest_file  $wiperdogPath/var/job/A_2.instances
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobinst.sh
expect "Enter job name need to create instance (*) :"
send "A_2\r"
expect "Enter instance name (*) :"
send "inst_1\r"
expect "Enter schedule :"
send "\r"
expect "Enter params (ex: param1=1 , param2=3 ) :"
send "a=1,b=2\r"
expect "Enter instance name (*) :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 2 Success !\033\[0m\r"
} else {
   puts "Case 2 Failed ! \r"
} 
puts "---------------------------------------"
puts "#Case3: Leave schedule + param empty: "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobInst/A_3.instances
set dest_file  $wiperdogPath/var/job/A_3.instances
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobinst.sh
expect "Enter job name need to create instance (*) :"
send "A_3\r"
expect "Enter instance name (*) :"
send "inst_1\r"
expect "Enter schedule :"
send "\r"
expect "Enter params (ex: param1=1 , param2=3 ) :"
send "\r"
expect "Enter instance name (*) :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 3 Success !\033\[0m\r"
} else {
   puts "Case 3 Failed ! \r"
} 
puts "---------------------------------------"
puts "#Case4: Input many instances: "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobInst/A_4.instances
set dest_file  $wiperdogPath/var/job/A_4.instances
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobinst.sh
expect "Enter job name need to create instance (*) :"
send "A_4\r"
expect "Enter instance name (*) :"
send "inst_1\r"
expect "Enter schedule :"
send "10i\r"
expect "Enter params (ex: param1=1 , param2=3 ) :"
send "a=1,b=2\r"
expect "Enter instance name (*) :"
send "inst_2\r"
expect "Enter schedule :"
send "\r"
expect "Enter params (ex: param1=1 , param2=3 ) :"
send "a=3,b=4\r"
expect "Enter instance name (*) :"
send "inst_3\r"
expect "Enter schedule :"
send "30i\r"
expect "Enter params (ex: param1=1 , param2=3 ) :"
send "\r"
expect "Enter instance name (*) :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 4 Success !\r"
} else {
   puts "Case 4 Failed ! \r"
} 
puts "---------------------------------------"

puts "#Case5: Leave job name + instance name empty : "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobInst/A_5.instances
set dest_file  $wiperdogPath/var/job/A_5.instances
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobinst.sh
expect "Enter job name need to create instance (*) :"
send "\r"
expect "Enter job name need to create instance (*) :"
send "A_5\r"
expect "Enter instance name (*) :"
send "instance_1\r"
expect "Enter schedule :"
send "\r"
expect "Enter params (ex: param1=1 , param2=3 ) :"
send "\r"
expect "Enter instance name (*) :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 5 Success !\033\[0m\r"
} else {
   puts "Case 5 Failed ! \r"
} 