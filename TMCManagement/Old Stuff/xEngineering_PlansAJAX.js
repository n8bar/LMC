// JavaScript Document   AJAX CONTROLS




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





//loads the current projects--////////////////////////////////////////////////

function GetEngTaskList()
{
 	  xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnGetEngTaskList;
	  xmlHttp.open('Get','Engineering_PlansASP.asp?action=GetEngTaskList', true);
	  xmlHttp.send(null);
}


function ReturnGetEngTaskList() 
{
      if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
			//alert('Not me!');
		  	
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var Tasks = xmlDoc.getElementsByTagName('Tasks')[0].childNodes[0].nodeValue.replace('--','');
			
			//document.getElementById('SendToArchive').innerHTML = "Arch<br />ive";
			//document.getElementById('TLItemsContainer').innerHTML = Tasks;
			//document.getElementById('ActiveTasksButton').style.display = "none";
			//document.getElementById('ArchiveTasksButton').style.display = "block";
			//document.getElementById('TaskListHeaderRight').style.display = "none";
	
         }
		 else
		 {
            alert('There was a problem with the request.');
         }
      }
	  
}
//-------------------------------------------------------------------------------------------------



/////Gets the list of archived tasks///////////////////////////////////////////////////////////////////////
function GetArchivedEngTaskList()
{
	
	  xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnGetArchivedEngTaskList;
	  xmlHttp.open('Get','Engineering_PlansASP.asp?action=GetEngArchivedTaskList', true);
	  xmlHttp.send(null);
	  
}


function ReturnGetArchivedEngTaskList() 
{
	
      if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
		  	
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var Tasks = xmlDoc.getElementsByTagName('Tasks')[0].childNodes[0].nodeValue;
			
		
			document.getElementById('SendToArchive').innerHTML = "<br/>Active";
			document.getElementById('TLItemsContainer').innerHTML = Tasks;
			document.getElementById('ArchiveTasksButton').style.display = "none";
			document.getElementById('ActiveTasksButton').style.display = "block";
			document.getElementById('TaskListHeaderRight').style.display = "block";
						
		 }
		 else
		 {
            alert('There was a problem with the request.');
         }
      }
	  
}
//-------------------------------------------------------------------------------------------------





function alertfunction()
{
	alert('what')
}


function alertfunction1(){ alert('Time Entry') }
function alertfunction2(){ alert('Scheduling') }




//updates the progress in the database//////////////////////////////////////////////////////////////////////////////////////
function ProgressClick(ID,Phase,DivID,Color,Txt,ColumnID)
{
		
	document.getElementById(DivID).style.background = '#'+Color;    ///these are used to instantly change the progress without refreshing the entire page.
	document.getElementById(DivID).innerHTML = Txt ;
	
	
	  
 	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnProgressClick;
	  xmlHttp.open('Get','Engineering_PlansASP.asp?action=UpdateProgress&ID='+ID+'&Phase='+Phase+'&ColumnID='+ColumnID+'', true);
	  xmlHttp.send(null);
	  
}


function ReturnProgressClick() 
{
	
      if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
	
			CloseProgressMenu();
	     }
		 else
		 {
            alert('There was a problem with the request.');
         }
      }
	  
}


//-----------------------------------------------------------------------------------------------------------------------






///Update the Engineer column in the engineering/plans table/////////////////////////////////////////////////////////////////////////////////////

function UpdateEngineer(EngineerName,DivID,TaskID)
{
	
	if (EngineerName == 1){EngineerName = parent.EmployeeArray[1][2] + " " + parent.EmployeeArray[1][3]}
	if (EngineerName == 2) {EngineerName = parent.EmployeeArray[2][2] + " " + parent.EmployeeArray[2][3]}
	if (EngineerName == 3) {EngineerName = parent.EmployeeArray[3][2] + " " + parent.EmployeeArray[3][3]}
	if (EngineerName == 4) {EngineerName = parent.EmployeeArray[4][2] + " " + parent.EmployeeArray[4][3]}
	if (EngineerName == 5) {EngineerName = parent.EmployeeArray[5][2] + " " + parent.EmployeeArray[5][3]}
	if (EngineerName == 6) {EngineerName = parent.EmployeeArray[6][2] + " " + parent.EmployeeArray[6][3]}
	if (EngineerName == 7) {EngineerName = parent.EmployeeArray[7][2] + " " + parent.EmployeeArray[7][3]}
	if (EngineerName == 8) {EngineerName = parent.EmployeeArray[8][2] + " " + parent.EmployeeArray[8][3]}
	if (EngineerName == 9) {EngineerName = parent.EmployeeArray[9][2] + " " + parent.EmployeeArray[9][3]}
	if (EngineerName == 10) {EngineerName = parent.EmployeeArray[10][2] + " " + parent.EmployeeArray[10][3]}
	if (EngineerName == 11) {EngineerName = parent.EmployeeArray[11][2] + " " + parent.EmployeeArray[11][3]}
	if (EngineerName == 12) {EngineerName = parent.EmployeeArray[12][2] + " " + parent.EmployeeArray[12][3]}
	

	  xmlHttp = GetXmlHttpObject();
      xmlHttp.onreadystatechange = ReturnUpdateEngineer;
	  xmlHttp.open('Get','Engineering_PlansASP.asp?action=UpdateEngineer&EngineerName='+EngineerName+'&TaskID='+TaskID+'', true);
	  xmlHttp.send(null);

	document.getElementById(DivID).innerHTML = EngineerName;
	
}



function ReturnUpdateEngineer() 
{
      if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
		  	
			CloseProgressMenu();

         }
		 else
		 {
            alert('There was a problem with the request.');
         }
      }
	  
}






////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function UpdateEngineerNotes(DivID,TaskID)
{
	var UpdatedNotes = 	document.getElementById('EngineeringNoteBox').value	
		
 document.getElementById(DivID).innerHTML = UpdatedNotes ;
 
   xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnShowNotes;
	  xmlHttp.open('Get','Engineering_PlansASP.asp?action=UpdateEngineerNotes&TaskID='+TaskID+'&UpdatedNotes='+UpdatedNotes+'', true);
	  xmlHttp.send(null);
   
 }

function ReturnShowNotes()
{
 
  if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
			
			CloseNotes();						
			
         }
		 else
		 {
            alert('There was a problem with the request.');
         }
      }
}






///////Changes Status of Tasks/////////////////////////////////////////////////////////////////////////

function EngineeringArchive(TaskID,TaskStatus)
{
				
				
		var ConfirmText	= ""	
				if (TaskStatus == "False"){ ConfirmText = "Are you sure you want to Archive this Task?"}
				if (TaskStatus == "True"){ ConfirmText = "Are you sure you want to Return this Task to Active?"}
				
				
		var iconfirm=confirm(ConfirmText)
		
	if (iconfirm==true)
		{
			
		
		xmlHttp = GetXmlHttpObject();
		  xmlHttp.onreadystatechange = ReturnArchiveStatus;
		  xmlHttp.open('Get','Engineering_PlansASP.asp?action=ArchiveStatus&TaskID='+TaskID+'&TaskStatus='+TaskStatus+'', true);
		  xmlHttp.send(null);
		  
		}
		
	    
 }


function ReturnArchiveStatus()
{
  if (xmlHttp.readyState == 4)
	  {
		if (xmlHttp.status == 200)
	    {
		 
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var ArchiveTaskStatus = xmlDoc.getElementsByTagName('TaskStatus')[0].childNodes[0].nodeValue;
			
			if (ArchiveTaskStatus == "False")
			{
				GetEngTaskList();
			}
			
			if (ArchiveTaskStatus == "True")
			{
				GetArchivedEngTaskList();
			}
			
		}
		 else
		 {
            alert('There was a problem with the request.');
         }
      }
}








//Deletes tasks from list///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function DeleteEngineeringTask(TaskStatus,TaskID,JobName)
{
						
		
		
	var xconfirm=confirm('Are You Sure You Want To Delete' + " " +JobName)
		
		if (xconfirm==true)
			{
		
				var iconfirm=confirm("I'm Sorry for the Inconvenience, But are You Really Sure?")
				
			if (iconfirm==true)
				{
					
				
				xmlHttp = GetXmlHttpObject();
				  xmlHttp.onreadystatechange = ReturnDeleteEngineeringTask;
				  xmlHttp.open('Get','Engineering_PlansASP.asp?action=DeleteEngineeringTask&TaskID='+TaskID+'&TaskStatus='+TaskStatus+'', true);
				  xmlHttp.send(null);
				  
				}
			}
	    
 }


function ReturnDeleteEngineeringTask()
{
  if (xmlHttp.readyState == 4)
	  {
		if (xmlHttp.status == 200)
	    {
		  	
			
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var ArchiveTaskStatus = xmlDoc.getElementsByTagName('TaskStatus')[0].childNodes[0].nodeValue;
			
			if (ArchiveTaskStatus == "Active")
			{
				GetEngTaskList();
			}
			
			if (ArchiveTaskStatus == "Archive")
			{
				GetArchivedEngTaskList();
			}
			
		}
		 else
		 {
            alert('There was a problem with the request.');
         }
      }
}



