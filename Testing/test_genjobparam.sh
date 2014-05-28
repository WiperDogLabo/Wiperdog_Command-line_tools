#!/usr/bin/expect
#!/bin/bash
if {$::argc == 0} {
   puts "Incorrect parameter !"
   puts "Usage: ./test_genjobparam.sh /wiperdog_home_path"
   exit
}
puts "***************************"
puts "* TEST TOOL 'genjobparam' *"
puts "***************************"

# ========= CASE 1 =========
puts "\n>>>>> CASE 1: INPUT ALL REQUIRE DATA <<<<<"
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobParam/A.params
set dest_file  $wiperdogPath/var/job/A.params
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobparam.sh
expect "Enter job file name for param creation (*) : "
send "A\r"
expect "Enter param name : "
send "a\r"
expect "Enter param value  (value can be a collection : \[a:1,b:2\]):"
send "1\r"
expect "Enter param name : "
send "b\r"
expect "Enter param value  (value can be a collection : \[a:1,b:2\]):"
send "2\r"
expect "Enter param name : "
send "\r"
expect "nothing"
sleep 1
#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "================"
if {$status == 0} {
   puts "Case 1 Success !\r"
} else {
   puts "Case 1 Failed ! \r"
}
puts "================"

# ========= CASE 2 =========
puts "\n>>>>> CASE 2: INPUT MISSING JOB FILE NAME <<<<<"
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobParam/A_2.params
set dest_file  $wiperdogPath/var/job/A_2.params
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobparam.sh
expect "Enter job file name for param creation (*) : "
send "\r"
set status 1
expect {
   "Enter job file name for param creation (*) : " {
      set status 0
   }
}
puts "================="
if { $status == 0 }  {
   puts "Case 2 :Success !"
} else {
   puts "Case 2 :Failed !"
}
puts "================="

# ========= CASE 3 =========
puts "\n>>>>> CASE 3: INPUT MISSING PARAM NAME <<<<<"
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobParam/A_3.params
set dest_file  $wiperdogPath/var/job/A_3.params
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobparam.sh
expect "Enter job file name for param creation (*) : "
send "A_3\r"
expect "Enter param name : "
send "\r"
expect "nothing"
#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "================"
if {$status == 0} {
   puts "Case 3 Success !\r"
} else {
   puts "Case 3 Failed ! \r"
}
puts "================"

# ========= CASE 4 =========
puts "\n>>>>> CASE 4: INPUT MISSING PARAM VALUE <<<<<"
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobParam/A_4.params
set dest_file  $wiperdogPath/var/job/A_4.params
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobparam.sh
expect "Enter job file name for param creation (*) : "
send "A_4\r"
expect "Enter param name : "
send "A_4\r"
expect "Enter param value  (value can be a collection : \[a:1,b:2\]):"
send "\r"
expect "Enter param name : "
send "\r"
expect "nothing"
sleep 1
#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "================"
if {$status == 0} {
   puts "Case 4 Success !\r"
} else {
   puts "Case 4 Failed ! \r"
} 
puts "================"

# ========= CASE 5 =========
puts "\n>>>>> CASE 5: UPDATE PARAM <<<<<"
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobParam/A_5.params
set dest_file  $wiperdogPath/var/job/A_5.params
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobparam.sh
expect "Enter job file name for param creation (*) : "
send "A_5\r"
expect "Enter param name : "
send "a\r"
expect "Enter param value  (value can be a collection : \[a:1,b:2\]):"
send "value_a\r"
expect "Enter param name : "
send "a\r"
expect "Param key existed ! ,do you want to update ? (y/n) !"
send "y\r"
expect "Enter param value  (value can be a collection : \[a:1,b:2\]):"
send "value_update\r"
expect "Enter param name : "
send "\r"
expect "nothing"
sleep 1
#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "================"
if {$status == 0} {
   puts "Case 5 Success !\r"
} else {
   puts "Case 5 Failed ! \r"
} 
puts "================"