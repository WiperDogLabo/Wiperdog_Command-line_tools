Source test for jobrunner (#400).
---------------------------------------------
A. How to test?  
- Step1: run ./run_test.sh with format  
	./run_test.sh -p /home/mrtit/Wiperdog/1205Wiperdog/ -c Case1  
- Step2: Check result  

Note:  
- "Case1, Case2, Case3" test job connect to database => Need to config default.params and password file connect to SQLServer, MYSQL, POSTGRES.  
- Test jobrunner use servlet with Case1, Case2, Case3, Case4, Case5, Case6, Case7 and Case11.  
- Test jobrunner use Grapes with Case1, Case2, Case3, Case4, Case5, Case6, Case7, Case8, Case9 and Case10.  

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

 11. Test get data in wiperdog.log success when job have error (Case11)  
  - Expected: Return data with message corresponding to jobfile successfully.  
