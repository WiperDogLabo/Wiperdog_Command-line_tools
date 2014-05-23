import java.io.BufferedReader
import java.io.InputStreamReader
import groovy.json.JsonBuilder

def checkExistsInst(mapInstances,instName){
	def check = false
	if(mapInstances != null && instName != null) {
		mapInstances.each{key,value ->
			if(instName.equalsIgnoreCase(key)) {
				check = true	
				return 			
			}
		}
	}
	return check
}
def mapInstances = [:]
BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
println ""
println "Please input data for job instance creation: "
println "***Note : Field with (*) is mandatory ,another is option"
println "Leave instance name empty to exit input !"
println "---------------------------"
def jobName = null
while(jobName == null || jobName.equals("")) {
 print "Enter job name need to create instance (*) :" ;
 jobName =  reader.readLine()
}

def instFile = new File("../var/job/" + jobName + ".instances")
def instTxt = ""
if(!instFile.exists()){
	instFile.createNewFile()
} else {
	def shell = new GroovyShell()
	def currentInstance = shell.evaluate(instFile)
	if(currentInstance != null && currentInstance != [:])  {
		mapInstances << currentInstance 
	}
}
def leaveInput = false
println mapInstances
while(!leaveInput) {
	def instName = null
	def instance = [:]
	label1:
	print "Enter instance name (*) :" ;
	instName =  reader.readLine()
	if(instName.trim().equals("")){
		leaveInput = true
		break;
	} else {
		println instName + "----------" +mapInstances
		if(checkExistsInst(mapInstances,instName)) {
			print "Instance name exists,please try again !\n" ;
			continue label1
		}
	}

	mapInstances[instName] = [:];
	print "Enter schedule :" ;
	def schedule =  reader.readLine()

	if(schedule != null && schedule != ""){
		mapInstances[instName]["schedule"] = schedule
	}
	def listParams = []
	while(true) {
		print "Enter params (ex: param1=1 , param2=3 ) :" ;
		def params =  reader.readLine()
		if(params != null && !params.equals("")) {
			try{
				def tmpListParams = params.split(",")
			
			tmpListParams.each{
				def tmpMap = [:]
				def tmpSplit = it.split("=");
				tmpMap[tmpSplit[0]] = tmpSplit[1]
				listParams.add(tmpMap)
			}
			break;
		   } catch(ArrayIndexOutOfBoundsException ex) {
		   		println "Incorrect params input ,try again !"
		   } 
		} else {
			break;
		}
	}
	if(listParams != []) {
		mapInstances[instName]["param"] = listParams
	}
}

def builder = new groovy.json.JsonBuilder(mapInstances)
def stringToFile = builder.toPrettyString().replace("{","[").replace("}","]")
instFile.setText(stringToFile)
println "---------------------------"
println "Finished! Instance file create at : ${instFile.getCanonicalPath()}"






