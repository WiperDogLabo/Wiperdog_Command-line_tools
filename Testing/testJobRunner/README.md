Source test for jobrunner (#400).
---------------------------------------------
A. How to test?  
- Step1: run ./run_test.sh with format  
	./run_test.sh -p /home/mrtit/Wiperdog/1205Wiperdog/ -c Case1  
- Step2: Check result  

Note: "Case1, Case2, Case3" test job connect to database => Need to config default.params and password file connect to SQLServer, MYSQL, POSTGRES.  

B. Case test 

 1. Test connect to SQLServer use QUERY (Case1)  
  - Expected: process job and return data successfully.  
  
 2. Test connect to MYSQL (Case2)  
  - Expected: process job and return data successfully.  

 3. Test connect to POSTGRES (Case3)  
  - Expected: process job and return data successfully.  

 4. Test connect to OS (Case4)  
  - Expected: process job and return data successfully.  

 5. Test job processing with GROUPKEY + ACCUMULATE + FINALLY (Case5)  
  - Expected: data of job will be process by ACCUMULATE and FINALLY. Return data successfully.  

 6. Test job processing with data Subtyped (Case6)  
  - Expected: Return data with message corresponding to jobfile successfully.  

 7. Test job processing with COMMAND + FORMAT (Case7)  
  - Expected: Return data contains "id", "name", "desc" successfully.  

 8. Test job processing with schedule as "5" (Case8)  
  - Expected: Return data with message corresponding to jobfile successfully.  

 9. Test job processing with schedule as "10i" (Case9)  
  - Expected: Return data with message corresponding to jobfile successfully.  

 10. Test job processing with schedule is Crontab (Case10)  
  - Expected: Return data with message corresponding to jobfile successfully.    
