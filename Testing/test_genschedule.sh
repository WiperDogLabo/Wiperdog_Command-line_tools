#!/usr/bin/expect
#!/bin/bash
puts "++++++++++++++++++++++++++"
puts "Test tools 'genschedule'"
puts "++++++++++++++++++++++++++"

puts "#Case1: Input all require data: "
set wiperdogPath  [lindex $argv 0]
set source_file testGenSchedule/test.trg
set dest_file  $wiperdogPath/var/job/test.trg
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genschedule.sh -f test.trg -j A -s 10i
sleep 1
#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 1 Success !\r"
} else {
   puts "Case 1 Failed ! \r"
} 
puts "---------------------------------------"
puts "#Case2: Input missing job file name (-f parameter): "
set wiperdogPath  [lindex $argv 0]
set source_file testGenSchedule/A.trg
set dest_file  $wiperdogPath/var/job/A.trg
catch { exec rm $dest_file } errorCode
spawn $wiperdogPath/bin/genschedule.sh -j A -s 10i
sleep 1
#After file written , check content with efxpected file
set status [catch {exec diff "$source_file" "$dest_file"} result]
if {$status == 0} {
   puts "Case 2 Success !\r"
} else {
   puts "Case 2 Failed ! \r"
} 
puts "---------------------------------------"
puts "#Case3: Input missing job name (-j parameter): "
set wiperdogPath  [lindex $argv 0]
spawn $wiperdogPath/bin/genschedule.sh -f test.job -s 10i
set status 1
expect {
   "Missing job name !" {
      set status 0
   }
}
if { $status == 0 }  {
   puts "Case 3 :Success !"
} else {
   puts "Case 3 :Failed !"
}
puts "---------------------------------------"
puts "#Case4: Input missing schedule (-s parameter): "
set wiperdogPath  [lindex $argv 0]
spawn $wiperdogPath/bin/genschedule.sh -f test.job -j test
set status 1
expect {
   "Missing schedule !" {
      set status 0
   }
}
if { $status == 0 }  {
   puts "Case 4 :Success !"
} else {
   puts "Case 4 :Failed !"
}
