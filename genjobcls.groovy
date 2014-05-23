import java.io.BufferedReader
import java.io.InputStreamReader

def jobClass 
def concurrency
def maxRunTime
def maxWaitTime

BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
println ""
println "Please input data for job class creation: "
println "***Note : Field with (*) is mandatory ,another is option"
println "Leave job class name empty to exit input !"
println "---------------------------"
print "Enter job file name:" ;
def jobClassFileName =  reader.readLine()
print "Enter job class name (*) :" ;
jobClass =  reader.readLine()
if(jobClass.trim().equals("")){
	println "Abort creating !. Exit."
	return;
}
def whileCondition = false
while(!whileCondition){
	try{
		print "Enter job concurrency :" ;
		concurrency =  reader.readLine()
		if(!concurrency.trim().equals("")) {
			concurrency = Integer.parseInt(concurrency);
			whileCondition = true
		} else {
			break
		}
	}catch(Exception ex){
		println "Job concurrency must be numberic ,please try again !"				
	}
}
whileCondition = false
while(!whileCondition){
	try{
		print "Enter job max run time :" ;
		maxRunTime =  reader.readLine()
		if(!maxRunTime.trim().equals("")) {
			maxRunTime = Integer.parseInt(maxRunTime);
			whileCondition = true
		} else {
			break
		}
	}catch(Exception ex){
		println "Max run time must be numberic ,please try again !"				
	}
}

whileCondition = false
while(!whileCondition){
	try{
		print "Enter job max wait time :" ;
		maxWaitTime =  reader.readLine()
		if(!maxWaitTime.trim().equals("")) {
			maxWaitTime = Integer.parseInt(maxWaitTime);
			whileCondition = true
		} else {
			break
		}
	}catch(Exception ex){
		println "Max wait time must be numberic ,please try again !"				
	}
}

if(jobClassFileName == null || jobClassFileName.trim().equals("") ){
	jobClassFileName = jobClass
}
if(!jobClassFileName.endsWith(".cls")){
	jobClassFileName += ".cls"
}
def basedir = new File(getClass().protectionDomain.codeSource.location.path).parent
File jobClassFile = new File(basedir + "/../var/job",jobClassFileName);
if(!jobClassFile.exists()){
	jobClassFile.createNewFile()
} 
def jobClsTxt = jobClassFile.getText()
if(!jobClsTxt.trim().equals("")){
	jobClsTxt+= "\n"
}
jobClsTxt+= "name: \"${jobClass}\""			

if(concurrency != null &&  !concurrency.equals("")) {
	jobClsTxt+= ",concurrency : ${concurrency}"	
}
if(maxRunTime != null &&  !maxRunTime.equals("")) {
	jobClsTxt+= ",maxrun : ${maxRunTime}"	
}
if(maxWaitTime != null &&  !maxWaitTime.equals("")) {
	jobClsTxt+= ",maxwait : ${maxWaitTime}"	
}
jobClassFile.setText(jobClsTxt)
println "---------------------------"
println "Finished! Job class file create at : ${jobClassFile.getCanonicalPath()}"



