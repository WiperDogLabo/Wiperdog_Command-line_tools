#!/usr/bin/expect
#!/bin/bash
if {$::argc == 0} {
   puts "Incorrect parameter !"
   puts "Usage: ./test_genjobinst.sh /wiperdog_home_path"
   exit
}
puts "**************************"
puts "* TEST TOOL 'genjobinst' *"
puts "**************************"

# ========= CASE 1 =========
puts "\n>>>>> CASE 1: INPUT ALL REQUIRE DATA <<<<<"
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
expect  -re "Enter params .* :"
send "\[a:1, b:2, c: \['c1', 'c2'\]\]\r"
expect "Enter instance name (*) :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "================"
if {$status == 0} {
   puts "Case 1 Success !\r"
} else {
   puts "Case 1 Failed ! \r"
}
puts "================"

# ========= CASE 2 =========
puts "\n>>>>> CASE 2: LEAVE SCHEDULE EMPTY <<<<<"
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
expect  -re "Enter params .* :"
send "\[a: 1, b: 2\ ,c :\[:\]\]\r"
expect "Enter instance name (*) :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "================"
if {$status == 0} {
   puts "Case 2 Success !\033\[0m\r"
} else {
   puts "Case 2 Failed ! \r"
}
puts "================"

# ========= CASE 3 =========
puts "\n>>>>> CASE 3: LEAVE PRAMS EMPTY <<<<<"
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
send "60i\r"
expect  -re "Enter params .* :"
send "\r"
expect "Enter instance name (*) :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "================"
if {$status == 0} {
   puts "Case 3 Success !\033\[0m\r"
} else {
   puts "Case 3 Failed ! \r"
}
puts "================"

# ========= CASE 4 =========
puts "\n>>>>> CASE 4: LEAVE SCHEDULE AND PRAMS EMPTY <<<<<"
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
send "\r"
expect  -re "Enter params .* :"
send "\r"
expect "Enter instance name (*) :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "================"
if {$status == 0} {
   puts "Case 4 Success !\033\[0m\r"
} else {
   puts "Case 4 Failed ! \r"
}
puts "================"

# ========= CASE 5 =========
puts "\n>>>>> CASE 5: INPUT MANY INSTANCES <<<<<"
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobInst/A_5.instances
set dest_file  $wiperdogPath/var/job/A_5.instances
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobinst.sh
expect "Enter job name need to create instance (*) :"
send "A_5\r"
expect "Enter instance name (*) :"
send "inst_1\r"
expect "Enter schedule :"
send "10i\r"
expect  -re "Enter params .* :"
send "\[a: 1, b: 2\]\r"
expect "Enter instance name (*) :"
send "inst_2\r"
expect "Enter schedule :"
send "\r"
expect  -re "Enter params .* :"
send "\[a: 3,b: 4\]\r"
expect "Enter instance name (*) :"
send "inst_3\r"
expect "Enter schedule :"
send "30i\r"
expect  -re "Enter params .* :"
send "\r"
expect "Enter instance name (*) :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "================"
if {$status == 0} {
   puts "Case 5 Success !\r"
} else {
   puts "Case 5 Failed ! \r"
} 
puts "================"

# ========= CASE 6 =========
puts "\n>>>>> CASE 6: LEAVE JOB NAME EMPTY <<<<<"
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobInst/A_6.instances
set dest_file  $wiperdogPath/var/job/A_6.instances
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobinst.sh
expect "Enter job name need to create instance (*) :"
send "\r"
set status 1
expect {
   "Enter job name need to create instance (*) :" {
      set status 0
   }
}
puts "\n================="
if { $status == 0 }  {
   puts "Case 6 :Success !"
} else {
   puts "Case 6 :Failed !"
}
puts "================="

# ========= CASE 7 =========
puts "\n>>>>> CASE 7: UPDATE INSTANCES <<<<<"
set wiperdogPath  [lindex $argv 0]
set source_file testGenJobInst/A_7.instances
set dest_file  $wiperdogPath/var/job/A_7.instances
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genjobinst.sh
expect "Enter job name need to create instance (*) :"
send "A_7\r"
expect "Enter instance name (*) :"
send "inst_1\r"
expect "Enter schedule :"
send "10i\r"
expect  -re "Enter params .* :"
send "\[a: 1, b: 2\]\r"
expect "Enter instance name (*) :"
send "inst_1\r"
expect "Instance name exists,do you want to update ? (y/n) !"
send "y\r"
expect "Enter schedule :"
send "30i\r"
expect  -re "Enter params .* :"
send "\[a: 11111, b: 22222\]\r"
expect "Enter instance name (*) :"
send "\r"
expect "nothing"
sleep 1
#After file written , check content with expected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "================"
if {$status == 0} {
   puts "Case 7 Success !\r"
} else {
   puts "Case 7 Failed ! \r"
} 
puts "================"