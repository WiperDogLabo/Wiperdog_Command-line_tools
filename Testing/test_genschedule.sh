#!/usr/bin/expect
#!/bin/bash
if {$::argc == 0} {
   puts "Incorrect parameter !"
   puts "Usage: ./test_genschedule.sh /wiperdog_home_path"
   exit
}
puts "***************************"
puts "* TEST TOOL 'genschedule' *"
puts "***************************"

# ========= CASE 1 =========
puts ">>>>> CASE 1: INPUT ALL REQUIRE DATA <<<<<"
set wiperdogPath  [lindex $argv 0]
set source_file testGenSchedule/test.trg
set dest_file  $wiperdogPath/var/job/test.trg
spawn $wiperdogPath/bin/genschedule.sh -f test.trg -j A -s 10i
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
puts ">>>>> CASE 2: INPUT MISSING JOB FILE NAME (-f parameter): "
set wiperdogPath  [lindex $argv 0]
set source_file testGenSchedule/A.trg
set dest_file  $wiperdogPath/var/job/A.trg
spawn $wiperdogPath/bin/genschedule.sh -j A -s 10i
sleep 1
#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
puts "================"
if {$status == 0} {
   puts "Case 2 Success !\r"
} else {
   puts "Case 2 Failed ! \r"
}
puts "================"

# ========= CASE 3 =========
puts ">>>>> CASE 3: INPUT MISSING JOB NAME (-j parameter): "
set wiperdogPath  [lindex $argv 0]
spawn $wiperdogPath/bin/genschedule.sh -f test.trg -s 10i
set status 1
expect {
   "Missing job name !" {
      set status 0
   }
}
puts "================="
if { $status == 0 }  {
   puts "Case 3 :Success !"
} else {
   puts "Case 3 :Failed !"
}
puts "================="

# ========= CASE 4 =========
puts ">>>>> CASE 4: INPUT MISSING SCHEDULE (-s parameter): "
set wiperdogPath  [lindex $argv 0]
spawn $wiperdogPath/bin/genschedule.sh -f test.trg -j test
set status 1
expect {
   "Missing schedule !" {
      set status 0
   }
}
puts "================="
if { $status == 0 }  {
   puts "Case 4 :Success !"
} else {
   puts "Case 4 :Failed !"
}
puts "================="

