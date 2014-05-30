#!/usr/bin/expect
#!/bin/bash
if {$::argc == 0} {
   puts "Incorrect parameter !"
   puts "Usage: ./test_gendefaultparam_missingparam.sh /wiperdog_home_path"
   exit
}
puts "*******************************"
puts "* TEST TOOL 'gendefaultparam' *"
puts "*******************************"

puts "\n>>>>> CASE 1: INPUT MISSING PARAM (param is not available) <<<<<"
set wiperdogPath  [lindex $argv 0]
spawn $wiperdogPath/bin/gendefaultparam.sh not_available
set status 1
expect {
	">>>>> INCORRECT FORMAT !!! <<<<<" {
    expect {
      "Correct format of command:" {
        expect {
          "    - gendefaultparam dbinfo" {
            expect {
              "    - gendefaultparam dest" {
                expect {
                  "    - gendefaultparam datadirectory" {
                    expect {
                      "    - gendefaultparam programdirectory" {
                        expect {
                          "    - gendefaultparam dbmsversion" {
                            expect {
                              "    - gendefaultparam dblogdir" {
                                set status 0
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
puts "================="
if { $status == 0 }  {
   puts "Case 1 :Success !"
} else {
   puts "Case 1 :Failed !"
}
puts "================="

puts "\n>>>>> CASE 2: INPUT MORE PARAMETER <<<<<"
set wiperdogPath  [lindex $argv 0]
spawn $wiperdogPath/bin/gendefaultparam.sh dest dblogdir
set status 1
expect {
  ">>>>> INCORRECT FORMAT !!! <<<<<" {
    expect {
      "Correct format of command:" {
        expect {
          "    - gendefaultparam dbinfo" {
            expect {
              "    - gendefaultparam dest" {
                expect {
                  "    - gendefaultparam datadirectory" {
                    expect {
                      "    - gendefaultparam programdirectory" {
                        expect {
                          "    - gendefaultparam dbmsversion" {
                            expect {
                              "    - gendefaultparam dblogdir" {
                                set status 0
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
puts "================="
if { $status == 0 }  {
   puts "Case 2 :Success !"
} else {
   puts "Case 2 :Failed !"
}
puts "================="