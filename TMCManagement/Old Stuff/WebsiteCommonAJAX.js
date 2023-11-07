// JavaScript Document


TaskArray = new Array();//For creating an array of the task masters
TaskArrayOrdered = new Array();//For creating an array of the task masters in an order
NumTasks = 0;


ProgressArray = new Array();//For creating an array of the progress list
PriorityArray = new Array();//For creating an array of the progress list
EmployeeArray = new Array();//For creating an array of the Employee list
AreaArray = new Array();
SchemesArray = new Array();
ProjectArray = new Array();//For creating an array of the Project list
FranchiseArray = new Array();
SystemsListArray = new Array();
ServiceArray = new Array();//For creating an array of the Service list
TestMaint = new Array();//For creating an array of the Service list








var xmlHttp

//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXmlHttpObject()
{
var xmlHttp=null;
try
  {
  // Firefox, Opera 8.0+, Safari
  xmlHttp=new XMLHttpRequest();
  }
catch (e)
  {
  // Internet Explorer
  try
    {
    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
  catch (e)
    {
    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
  }
  
  	if (xmlHttp==null)
	  {
	  alert ("Your browser does not support AJAX!");
	  return;
	  }
	  
	  
return xmlHttp;
}
//------------------------------------------------------------------------------------------------












//Gets the Task Headers and their information and creates a global 3D array of the tasks called TaskArray-////////////////////////////////////////////////

function GetTaskList()
{	
	
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetTaskList;
	xmlHttp.open('GET','WebsiteCommonASP.asp?action=GetTasks', true);
	xmlHttp.send(null);

}


function ReturnGetTaskList()
{
	
	
	if (xmlHttp.readyState == 4)
	{
	
		if (xmlHttp.status == 200)
		{			
		var xmlDoc = xmlHttp.responseXML.documentElement;	
		var TaskLength = xmlDoc.getElementsByTagName('TaskLength')[0].childNodes[0].nodeValue;
		
		TArray = new Array();
		
		for (i = 1; i <= TaskLength; i++)
		{
			var sTaskID = 'TaskID'+i;
			var sTaskName = 'TaskName'+i;
			var sBgColor = 'BgColor'+i;
			var sTextColor = 'TextColor'+i;
			var sLink = 'Link'+i;
			
			var TaskID = xmlDoc.getElementsByTagName(sTaskID)[0].childNodes[0].nodeValue;
			var TaskName = xmlDoc.getElementsByTagName(sTaskName)[0].childNodes[0].nodeValue;
			var BgColor = xmlDoc.getElementsByTagName(sBgColor)[0].childNodes[0].nodeValue;
			var TextColor = xmlDoc.getElementsByTagName(sTextColor)[0].childNodes[0].nodeValue;
			var Link = xmlDoc.getElementsByTagName(sLink)[0].childNodes[0].nodeValue;
			
			
			TArray[i] = new Array('',TaskID,TaskName,BgColor,TextColor,Link);
		}
	
		TaskArray = TArray;
		
		OArray = new Array();
		var OrdNum = 100;

		for (i = 1; i <= TaskLength; i++)
		{
			var sTaskID = 'TaskID'+OrdNum;
			var sTaskName = 'TaskName'+OrdNum;
			var sBgColor = 'BgColor'+OrdNum;
			var sTextColor = 'TextColor'+OrdNum;
			var sLink = 'Link'+OrdNum;
			
			var TaskID = xmlDoc.getElementsByTagName(sTaskID)[0].childNodes[0].nodeValue;
			var TaskName = xmlDoc.getElementsByTagName(sTaskName)[0].childNodes[0].nodeValue;
			var BgColor = xmlDoc.getElementsByTagName(sBgColor)[0].childNodes[0].nodeValue;
			var TextColor = xmlDoc.getElementsByTagName(sTextColor)[0].childNodes[0].nodeValue;
			var Link = xmlDoc.getElementsByTagName(sLink)[0].childNodes[0].nodeValue;
			
			
			OArray[i] = new Array('',TaskID,TaskName,BgColor,TextColor,Link);
			
			OrdNum ++;
		}
	
	
		TaskArrayOrdered = OArray;			
		
		//alert(TaskArrayOrdered);
		
		
		
		NumTasks = TaskLength;
		
		
		CreateCalendarTabs();
		
		
		
		
		}
		else
		{
			alert('There was a problem with the request.');
		}
	}
	
	
}
//-------------------------------------------------------------------------------------------------


