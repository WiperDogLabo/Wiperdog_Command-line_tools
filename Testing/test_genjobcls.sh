#!/usr/bin/expect
#!/bin/bash
if {$::argc == 0} {
   puts "Incorrect parameter !"
   puts "Usage: ./test_genjobinst.sh /wiperdog_home_path"
   exit
}
puts "++++++++++++++++++++++++++"
puts "Test tools 'genjobcls'"
puts "++++++++++++++++++++++++++"
puts "#Case1: Input all require data: "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobCls/A.cls
set dest_file  $wiperdogPath/var/job/A.cls
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobcls.sh
expect "Enter job file name:"
send "A\r"
expect "Enter job class name (*) :"
send "class_test\r"
expect "Enter job concurrency :"
send "1\r"
expect "Enter job max run time :"
send "2\r"
expect "Enter job max wait time :"
send "3\r"
expect "nothing"
sleep 1
#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 1 Success !\r"
} else {
   puts "Case 1 Failed ! \r"
} 
puts "---------------------------------------"

puts "#Case2: Leave job max wait empty: "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobCls/A_2.cls
set dest_file  $wiperdogPath/var/job/A_2.cls
catch { exec rm $dest_file } errorCode

spawn $wiperdogPath/bin/genjobcls.sh
expect "Enter job file name:"
send "A_2\r"
expect "Enter job class name (*) :"
send "class_test\r"
expect "Enter job concurrency :"
send "1\r"
expect "Enter job max run time :"
send "2\r"
expect "Enter job max wait time :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 2 Success !\033\[0m\r"
} else {
   puts "Case 2 Failed ! \r"
} 
puts "---------------------------------------"
puts "#Case3: Leave maxrun and maxwait empty: "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobCls/A_3.cls
set dest_file  $wiperdogPath/var/job/A_3.cls
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobcls.sh
expect "Enter job file name:"
send "A_3\r"
expect "Enter job class name (*) :"
send "class_test\r"
expect "Enter job concurrency :"
send "1\r"
expect "Enter job max run time :"
send "\r"
expect "Enter job max wait time :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 3 Success !\033\[0m\r"
} else {
   puts "Case 3 Failed ! \r"
} 
puts "---------------------------------------"
puts "#Case4: Leave maxrun and maxwait empty: "
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobCls/A_4.cls
set dest_file  $wiperdogPath/var/job/A_4.cls
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobcls.sh
expect "Enter job file name:"
send "A_4\r"
expect "Enter job class name (*) :"
send "class_test\r"
expect "Enter job concurrency :"
send "1\r"
expect "Enter job max run time :"
send "\r"
expect "Enter job max wait time :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 4 Success !\r"
} else {
   puts "Case 4 Failed ! \r"
} 
