import java.io.BufferedReader
import java.io.InputStreamReader
import groovy.json.JsonBuilder

def checkExists(mapParams,paramName){
	def check = false
	if(mapParams != null && paramName != null) {
		mapParams.each{key,value ->
			if(paramName.equalsIgnoreCase(key)) {
				check = true	
				return 			
			}
		}
	}
	return check
}
BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
println ""
println "Please input data for job params creation: "
println "***Note : Field with (*) is mandatory ,another is option"
println "Leave job param name empty to exit input !"
println "---------------------------"
print "Enter job file name for param creation (*) : " ;
def jobFileName =  reader.readLine()
def mapParams = [:]
def basedir = new File(getClass().protectionDomain.codeSource.location.path).parent
def paramFile = new File(basedir + "/../var/job", jobFileName+".params")
if(paramFile.exists()) {
	def shell = new GroovyShell()
	def currentParams =  shell.evaluate(paramFile)
	if(currentParams != null){
		mapParams << currentParams
	}
} else {
	paramFile.createNewFile()
}

while(true){
	label1:
	print "Enter param name : " ; 
	def paramKey = reader.readLine()
	if(paramKey == null || paramKey.trim().equals("")) {
		break;
	} else {
		if(checkExists(mapParams,paramKey)){
			println "Param key existed ! ,try again ! \n"
			continue label1;
		}
	}
	print "Enter param value : " ; 
	def paramVal = reader.readLine()
	mapParams[paramKey] = paramVal
}
def builder = new JsonBuilder(mapParams)
def stringToFile = builder.toPrettyString().replace("{","[").replace("}","]")
paramFile.setText(stringToFile)
println "---------------------------"
println "Finished! Params file create at : ${paramFile.getCanonicalPath()}"
