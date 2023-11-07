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

AllProgress = new Array();//For creating an array of the progress list
AllPriority = new Array();//For creating an array of the progress list
AllEmps = new Array();//For creating an array of the Employee list
AllAreas = new Array();
AllSchemes = new Array();
AllProjects = new Array();//For creating an array of the Project list
AllFranchises = new Array();
AllSystemsList = new Array();
AllService = new Array();//For creating an array of the Service list
AllTestMaint = new Array();//For creating an array of the Service list


//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////
var xmlHttp;
var HttpText;
function GetXmlHttpObject(){
	xmlHttp=null;
	
	try{
		// Firefox, Opera 8.0+, Safari
		xmlHttp=new XMLHttpRequest();
  }
	catch (e){
		// Internet Explorer
		try{xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e){xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}
  }
	
	if (xmlHttp==null){
	  alert ("Your browser does not support AJAX!");
	  return;
	}
	return xmlHttp;
}
//------------------------------------------------------------------------------------------------


var ClosedWidth=10;
var RanReturnValidate;
function Validate()
{
	//Gebi('LoadInfo').innerHTML='Validating Login...';
	/**/
	RanReturnValidate=false;
	HttpText='CommonASP.asp?action=Validate';
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnValidate;
	xmlHttp.open('GET',HttpText, false);
	xmlHttp.send(null);
	try{if(xmlHttp.status == 200){ReturnValidate();}}catch(e){}
}
function ReturnValidate()
{
	//Gebi('LoadInfo').innerHTML+='...';
	if (xmlHttp.readyState == 4)
	{ 
		if (xmlHttp.status == 200)
		{
			//Gebi('LoadInfo').innerHTML+='...';
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var Validated = xmlDoc.getElementsByTagName('Validated')[0].childNodes[0].nodeValue.replace('--','');
			//alert(Validated);
			if(Validated!=1)
			{
				//window.location="http://"+window.location.href.substr(6)+"Website/TMC/TMC.Html";
				window.location="../TMC/TMC.Html";
				//alert('Login Required');
			}
			else
			{
				accessEngineering= xmlDoc.getElementsByTagName('Engineering')[0].childNodes[0].nodeValue.replace('--','');
				accessPurchasing= xmlDoc.getElementsByTagName('Purchasing')[0].childNodes[0].nodeValue.replace('--','');
				accessDataEntry= xmlDoc.getElementsByTagName('DataEntry')[0].childNodes[0].nodeValue.replace('--','');
				accessEstimates= xmlDoc.getElementsByTagName('Estimates')[0].childNodes[0].nodeValue.replace('--','');
				accessInventory= xmlDoc.getElementsByTagName('Inventory')[0].childNodes[0].nodeValue.replace('--','');
				accessProjects= xmlDoc.getElementsByTagName('Projects')[0].childNodes[0].nodeValue.replace('--','');
				accessTraining= xmlDoc.getElementsByTagName('Training')[0].childNodes[0].nodeValue.replace('--','');
				accessService= xmlDoc.getElementsByTagName('Service')[0].childNodes[0].nodeValue.replace('--','');
				accessWebsite= xmlDoc.getElementsByTagName('Website')[0].childNodes[0].nodeValue.replace('--','');
				accessOffice= xmlDoc.getElementsByTagName('Office')[0].childNodes[0].nodeValue.replace('--','');
				accessAdmin= xmlDoc.getElementsByTagName('Admin')[0].childNodes[0].nodeValue.replace('--','');
				accessTest= xmlDoc.getElementsByTagName('Test')[0].childNodes[0].nodeValue.replace('--','');
				accessTime= xmlDoc.getElementsByTagName('Time')[0].childNodes[0].nodeValue.replace('--','');
				accessEmpID= xmlDoc.getElementsByTagName('EmpID')[0].childNodes[0].nodeValue.replace('--','');
				accessUser= xmlDoc.getElementsByTagName('UserName')[0].childNodes[0].nodeValue.replace('--','');
				accessEmail= xmlDoc.getElementsByTagName('Email')[0].childNodes[0].nodeValue.replace('--','');
				accessEmpFName= xmlDoc.getElementsByTagName('FName')[0].childNodes[0].nodeValue.replace('--','');
				accessEmpLName= xmlDoc.getElementsByTagName('LName')[0].childNodes[0].nodeValue.replace('--','');
				accessEmpName=accessEmpFName+' '+accessEmpLName;

				//document.getElementById('CurrentUser').innerHTML = accessUser;

				RanReturnValidate=true;
				
				var DisabledTabs=xmlDoc.getElementsByTagName('DisabledTabs')[0].childNodes[0].nodeValue;
				
				logoutSeconds=30*60;
				
				//GetProgressList();
				//gCalLogin();
			}
				
		}
		else
		{
			AjaxErr('Problem with login validation request',HttpText);
		}
	}
	/**/
}



function getGoogleInfo(data)
{
	var response = eval(data.currentTarget.responseText);
	//alert('Target: ' + response.Target + "\n" + 'Scope: ' + response.Scope + "\n" + 'Secure: ' + response.Secure);
	for(property in data.currentTarget)
	{
		//alert(property+':'+data.currentTarget[property]);
	}
}

function gCalLogin()
{
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnCalLogin;
	HttpText='session.asp?variable=calLogin'
	xmlHttp.open('GET',HttpText, false);
	xmlHttp.send(null);
	try{if(xmlHttp.status == 200){ReturnCalLogin();}}catch(e){}
}
function ReturnCalLogin()
{
	if (xmlHttp.readyState == 4)
	{ 
		if (xmlHttp.status == 200)
		{
			try{	var sessionCalLogin=xmlHttp.responseXML.documentElement.getElementsByTagName('value')[0].childNodes[0].nodeValue.replace;	}
			catch(e){	AjaxErr('Whazzup with the Google Calendar Authentication?',HttpText);	}
			
			scope = "https://www.google.com/calendar/feeds/";
			//if(google.accounts.user.checkLogin(scope)) alert('scope:'+scope+'\n\ncheckLogin:'+google.accounts.user.checkLogin(scope)+'\n\ntoken:'+token);
			//google.accounts.user.getInfo(getGoogleInfo);
			if(xmlHttp.responseXML.documentElement.getElementsByTagName('value')[0].childNodes[0].nodeValue!='1')
			{
				//alert(google.accounts.user.checkLogin(scope));
				var token = google.accounts.user.login(scope);
				//alert('scope:'+scope+'\n\ncheckLogin:'+google.accounts.user.checkLogin(scope)+'\n\ntoken:'+token);
				SessionWrite('calLogin','1');					
			}
			
			//if(xmlHttp.responseXML.documentElement.getElementsByTagName('value')[0].childNodes[0].nodeValue!='1')
			//{
			//	var token = google.accounts.user.login(scope);
			//	/** /
			//	returnUrl="https://www.rcstri.com/website/tmcdevelopment/tmc.html";
			//	window.open('https://www.google.com/a/tricomlv.com/AuthSubRequestJS?session=1&scope='+scope+'&next='+returnUrl,'_self');
			//	/**/
			//	SessionWrite('calLogin','1');
			//}
	
			
		}
		
		else
		{
			AjaxErr('Error with Google Calendar Authentication.',HttpText)
		}
	}
}







//Gets the Task Headers and their information and creates a global 3D array of the tasks called TaskArray-////////////////////////////////////////////////

function GetTaskList()
{	
	Gebi('LoadInfo').innerHTML='Loading Task/Tab Names';
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetTaskList;
	xmlHttp.open('GET','CommonASP.asp?action=GetTasks', false);
	xmlHttp.send(null);
	try{if(xmlHttp.status == 200){ReturnGetTaskList();}}catch(e){}
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
			
			GetProgressList();
			
		}
		else
		{
			alert('There was a problem with the GetTaskList request.');
		}
	}
}
//-------------------------------------------------------------------------------------------------


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////


//Gets the Progress List information and creates a global 3D array of the list called ProgressArray-////////////////////////////////////////////////

function GetProgressList()
{	
	Gebi('LoadInfo').innerHTML='Getting Progress States';
     
	HttpText='CommonASP.asp?action=GetProgList';
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetProgressList;
	xmlHttp.open('GET',HttpText, false);
	xmlHttp.send(null);
	try{if(xmlHttp.status == 200){ReturnGetProgressList();}}catch(e){}
}

var ProgressListTries=0;
function ReturnGetProgressList()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			
			//alert(xmlHttp.responseXML.documentElement);
			var xmlDoc = xmlHttp.responseXML.documentElement;
			if(xmlDoc==null)
			{
				alert('ProgressList Didn\'nt work!!');
				setTimeout('GetProjectList();',10000);
				ProgressListTries++
				return false;
			}
			var ProgressLength = xmlDoc.getElementsByTagName('ProgressLength')[0].childNodes[0].nodeValue.replace('--','');
			
			ProgArray = new Array();
			
			for (i = 1; i <= ProgressLength; i++)
			{
				
				var sProgID = 'ProgID'+i;
				var sBGColor = 'BGColor'+i;
				var sAltBGColor = 'AltBGColor'+i;
				var sBGText = 'BGText'+i;
				var sText = 'Text'+i;
				var sMOTextColor = 'MOTextColor'+i;
				var sMOutTextColor = 'MOutTextColor'+i;
				
				
				var ProgID = xmlDoc.getElementsByTagName(sProgID)[0].childNodes[0].nodeValue;
				var BGColor = xmlDoc.getElementsByTagName(sBGColor)[0].childNodes[0].nodeValue;
				var AltBGColor = xmlDoc.getElementsByTagName(sAltBGColor)[0].childNodes[0].nodeValue;
				var BGText = xmlDoc.getElementsByTagName(sBGText)[0].childNodes[0].nodeValue;//alert(BGText);
				//BGText=BGText.replace(/--AMPERSAND--/g,'&')
				var Text = xmlDoc.getElementsByTagName(sText)[0].childNodes[0].nodeValue;
				var MOTextColor = xmlDoc.getElementsByTagName(sMOTextColor)[0].childNodes[0].nodeValue;
				var MOutTextColor = xmlDoc.getElementsByTagName(sMOutTextColor)[0].childNodes[0].nodeValue;
				
				
				ProgArray[i] = new Array('',ProgID,BGColor,AltBGColor,BGText,Text,MOTextColor,MOutTextColor);
				//                       0   1      2       3          4      5    6           7
			}
			
			NumTasks = ProgressLength;
			
			ProgressArray = ProgArray;
			
			GetPriorityList();
			//alert (ProgressArray);
			
		}
		else
		{
			AjaxErr('There was a problem with the GetProgressList request.',HttpText);
			GetPriorityList();
		}
	}
	
	
}
//-------------------------------------------------------------------------------------------------





function GetPriorityList()
{	
	HttpText='CommonASP.asp?action=GetPriList';
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetPriorityList;
	xmlHttp.open('GET',HttpText, false);
	xmlHttp.send(null);
	try{if(xmlHttp.status == 200){ReturnGetPriorityList();}}catch(e){}
}


function ReturnGetPriorityList()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			//alert(xmlDoc);
			var PriorityLength = xmlDoc.getElementsByTagName('PriorityLength')[0].childNodes[0].nodeValue;
			
			PriArray = new Array();
			
			for (i = 1; i <= PriorityLength; i++)
			{
				var sPriID = 'PriID'+i;
				var sBGColor = 'BGColor'+i;
				var sAltBGColor = 'AltBGColor'+i;
				var sBGText = 'BGText'+i;
				var sText = 'Text'+i;
				var sMOTextColor = 'MOTextColor'+i;
				var sMOutTextColor = 'MOutTextColor'+i;
				
				var PriID = xmlDoc.getElementsByTagName(sPriID)[0].childNodes[0].nodeValue;
				var BGColor = xmlDoc.getElementsByTagName(sBGColor)[0].childNodes[0].nodeValue;
				var AltBGColor = xmlDoc.getElementsByTagName(sAltBGColor)[0].childNodes[0].nodeValue;
				var BGText = xmlDoc.getElementsByTagName(sBGText)[0].childNodes[0].nodeValue;
				var Text = xmlDoc.getElementsByTagName(sText)[0].childNodes[0].nodeValue;
				//var MOTextColor = xmlDoc.getElementsByTagName(sMOTextColor)[0].childNodes[0].nodeValue;
				//var MOutTextColor = xmlDoc.getElementsByTagName(sMOutTextColor)[0].childNodes[0].nodeValue;
				
				PriArray[i] = new Array('',PriID,BGColor,AltBGColor,BGText,Text);
			}
			NumTasks = PriorityLength;
			
			PriorityArray = PriArray;

			GetEmployeeList();
			//alert (ProgressArray);
		
		
		}
		else
		{
			AjaxErr('There was a problem with the GetPriorityList request.',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------








//Gets the Employee List information and creates a global 3D array of the list called EmployeeArray-////////////////////////////////////////////////

function GetEmployeeList(stopHere)
{	
	try	{	Gebi('LoadInfo').innerHTML='Employees';	}
	catch(e)	{		}

	xmlHttp = GetXmlHttpObject();
	  
	xmlHttp.onreadystatechange = ReturnGetEmployeeList;
	xmlHttp.open('GET','CommonASP.asp?action=GetEmployeeList', false);
	xmlHttp.send(null);
	try{if(xmlHttp.status == 200){ReturnGetEmployeeList();}}catch(e){}

	function ReturnGetEmployeeList()
	{
		if (xmlHttp.readyState == 4)
		{
			if (xmlHttp.status == 200)
			{
				var xmlDoc = xmlHttp.responseXML.documentElement;			
				var EmpListLength = xmlDoc.getElementsByTagName('EmpListLength')[0].childNodes[0].nodeValue;
				var EmpNum = 1;
				EmpArray = new Array();
				
				EmpArray[0] = new Array('','','','','');
				
				for (i = 1; i <= EmpListLength; i++)
				{
					var sEmpID = 'EmpID'+EmpNum;
					var sEmpFName = 'EmpFName'+EmpNum;
					var sEmpLName = 'EmpLName'+EmpNum;					
					var sActive = 'Active'+EmpNum;					
					var sEmail = 'Email'+EmpNum;					
					
					var EmpID = xmlDoc.getElementsByTagName(sEmpID)[0].childNodes[0].nodeValue;
					var EmpFName = xmlDoc.getElementsByTagName(sEmpFName)[0].childNodes[0].nodeValue.replace('--','');					
					var EmpLName = xmlDoc.getElementsByTagName(sEmpLName)[0].childNodes[0].nodeValue.replace('--','');
					var Active = xmlDoc.getElementsByTagName(sActive)[0].childNodes[0].nodeValue.replace('--','');
					var Email = xmlDoc.getElementsByTagName(sEmail)[0].childNodes[0].nodeValue.replace('--','');
					
					EmpArray[i] = new Array('',EmpID,EmpFName,EmpLName,Active,Email);
					
					AllEmps[i]= new Object();
					AllEmps[i].ID=EmpID;
					AllEmps[i].fName=EmpFName;
					AllEmps[i].lName=EmpLName;
					AllEmps[i].active=strToBool(Active);
					AllEmps[i].email=Email;
					AllEmps[i].name=EmpFName+' '+EmpLName;
					
					EmpNum ++;
				}
				
				NumTasks = EmpListLength;
				
				EmployeeArray = EmpArray;
				//alert (EmployeeArray[1][2]);		
				
				
				if(stopHere) return false;
				
				GetAreaList();
							 
				}
				else
				{
					alert('There was a problem with the GetEmployeeList request.');
	}	}	}

}
////-------------------------------------------------------------------------------------------------













//Gets the Area List--////////////////////////////////////////////////

function GetAreaList()
{
	Gebi('LoadInfo').innerHTML='Area List';

	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetAreaList;
	xmlHttp.open('Get','CommonASP.asp?action=GetAreaList', false);
	xmlHttp.send(null);
	try{if(xmlHttp.status == 200){ReturnGetAreaList();}}catch(e){}
}


function ReturnGetAreaList() 
{
  
   
   
   if (xmlHttp.readyState == 4)
	  {
		if (xmlHttp.status == 200)
	    {
			
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var ArrCount = xmlDoc.getElementsByTagName("ArrCount")[0].childNodes[0].nodeValue;
			
           
			 	
			
				for (i = 1; i < ArrCount; i++)
				{
					var sAreaID = 'AreaID'+i;
					var sAreaDescription = 'AreaDescription'+i;
					
					var AreaID = xmlDoc.getElementsByTagName(sAreaID)[0].childNodes[0].nodeValue;
					var AreaDescription = xmlDoc.getElementsByTagName(sAreaDescription)[0].childNodes[0].nodeValue;
					
					AreaArray[i] = new Array('',AreaID,AreaDescription);
				}


				 
				 
			GetSchemes();
			 
			 
		  }
		 else
		 {
            alert('There was a problem with the GetAreaList request.');
         }
      }
	  
}
//-------------------------------------------------------------------------------------------------













//Gets the Schemes List information-////////////////////////////////////////////////

function GetSchemes()
{	
	Gebi('LoadInfo').innerHTML='Color Schemes';
	 
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetSchemes;
	xmlHttp.open('GET','CommonASP.asp?action=GetSchemes', false);
	xmlHttp.send(null);
	try{if(xmlHttp.status == 200){ReturnGetSchemes();}}catch(e){}
}


function ReturnGetSchemes()
{
	
	
      if (xmlHttp.readyState == 4)
	  {
		  
		 if (xmlHttp.status == 200)
	    {
			
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var ListLength = xmlDoc.getElementsByTagName('Length')[0].childNodes[0].nodeValue;
			var Num = 1;
			ShArray = new Array();
			
			
			
			for (i = 1; i <= ListLength; i++)
				{
					
					var sSchemeNum = 'SchemeNum'+Num;
					var sTaskName = 'TaskName'+Num;
					var sColorMain = 'ColorMain'+Num;	
					var sColorBG1 = 'ColorBG1'+Num;
					var sColorBG2 = 'ColorBG2'+Num;
					var sColorTabOn = 'ColorTabOn'+Num;
					var sColorTabOff = 'ColorTabOff'+Num;
					var sColorLinks = 'ColorLinks'+Num;
					var sColorLinksHover = 'ColorLinksHover'+Num;
					var sColorTxtHead1 = 'ColorTxtHead1'+Num;
					var sColorTxtHead2 = 'ColorTxtHead2'+Num;
					var sColorTxtTabOn = 'ColorTxtTabOn'+Num;
					var sColorTextTabOff = 'ColorTextTabOff'+Num;
					 
					var SchemeNum = xmlDoc.getElementsByTagName(sSchemeNum)[0].childNodes[0].nodeValue;
					var TaskName = xmlDoc.getElementsByTagName(sTaskName)[0].childNodes[0].nodeValue;					
					var ColorMain = xmlDoc.getElementsByTagName(sColorMain)[0].childNodes[0].nodeValue;
					var ColorBG1 = xmlDoc.getElementsByTagName(sColorBG1)[0].childNodes[0].nodeValue;
					var ColorBG2 = xmlDoc.getElementsByTagName(sColorBG2)[0].childNodes[0].nodeValue;
					var ColorTabOn = xmlDoc.getElementsByTagName(sColorTabOn)[0].childNodes[0].nodeValue;
					var ColorTabOff = xmlDoc.getElementsByTagName(sColorTabOff)[0].childNodes[0].nodeValue;
					var ColorLinks = xmlDoc.getElementsByTagName(sColorLinks)[0].childNodes[0].nodeValue;
					var ColorLinksHover = xmlDoc.getElementsByTagName(sColorLinksHover)[0].childNodes[0].nodeValue;
					var ColorTxtHead1 = xmlDoc.getElementsByTagName(sColorTxtHead1)[0].childNodes[0].nodeValue;
					var ColorTxtHead2 = xmlDoc.getElementsByTagName(sColorTxtHead2)[0].childNodes[0].nodeValue;
					var ColorTxtTabOn = xmlDoc.getElementsByTagName(sColorTxtTabOn)[0].childNodes[0].nodeValue;
					var ColorTextTabOff = xmlDoc.getElementsByTagName(sColorTextTabOff)[0].childNodes[0].nodeValue;
					
										
					ShArray[i] = new Array('',SchemeNum,TaskName,ColorMain,ColorBG1,ColorBG2,ColorTabOn,ColorTabOff,ColorLinks,ColorLinksHover,ColorTxtHead1,ColorTxtHead2,ColorTxtTabOn,ColorTextTabOff);
					
					Num ++;
					
				}
			
			
			
			SchemesArray = ShArray;
			
		   if (IEver>=9)	{
				 	CreateCalendarTabs();
					return true;
				}
			 
			GetProjectList()		
			
		//alert (SchemesArray[1][2]);
            
            
         }
		 else
		 {
            alert('There was a problem with the GetSchemes request.');
         }
      }


}
////-------------------------------------------------------------------------------------------------
















//Gets the Project List information and creates a global 3D array of the list called ProjectArray-////////////////////////////////////////////////

function GetProjectList()
{	
	Gebi('LoadInfo').innerHTML='Projects';
	 
	 xmlHttp = GetXmlHttpObject();
	  
	  xmlHttp.onreadystatechange = ReturnGetProjectList;
	  xmlHttp.open('GET','CommonASP.asp?action=GetActiveProjectList', false);
	  xmlHttp.send(null);
	try{if(xmlHttp.status == 200){ReturnGetProjectList();}}catch(e){}
}


function ReturnGetProjectList()
{
	/**/
	
      if (xmlHttp.readyState == 4)
	  {
		  
		 if (xmlHttp.status == 200)
	    {
			
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var ProjListLength = xmlDoc.getElementsByTagName('ProjListLength')[0].childNodes[0].nodeValue;
			var ProjNum = 1;
			ProjArray = new Array();
			
			ProjArray[0] = new Array('','','');
			
			for (i = 1; i <= ProjListLength; i++)
				{
					var sProjID = 'ProjID'+ProjNum;
					var sProjName = 'ProjName'+ProjNum;
					var sActive = 'Active'+ProjNum;
					var sObtained = 'Obtained'+ProjNum;
					
					var ProjID = xmlDoc.getElementsByTagName(sProjID)[0].childNodes[0].nodeValue;
					var ProjName = xmlDoc.getElementsByTagName(sProjName)[0].childNodes[0].nodeValue.replace('--','');					
					var Active = xmlDoc.getElementsByTagName(sActive)[0].childNodes[0].nodeValue.replace('--','');					
					var Obtained = xmlDoc.getElementsByTagName(sObtained)[0].childNodes[0].nodeValue.replace('--','');					
										
					ProjArray[i] = new Array('',ProjID,ProjName);
					
					ProjNum ++;
				}
			
			
			NumTasks = ProjListLength;
			
			ProjectArray = ProjArray;

		/**/	
			GetFranchiseList();
		/**/	
			//alert (ProjectArray);		
			
            
            
         }
		 else
		 {
            alert('There was a problem with the GetProjectList request.');
         }
      }

			/**/
}
////-------------------------------------------------------------------------------------------------


////-------------------------------------------------------------------------------------------------

function GetFranchiseList()
{	
	Gebi('LoadInfo').innerHTML='Hotel Franchises';
     
	 
	 xmlHttp = GetXmlHttpObject();
	  
	  xmlHttp.onreadystatechange = ReturnGetFranchiseList;
	  xmlHttp.open('GET','CommonASP.asp?action=GetFranchiseList', false);
	  xmlHttp.send(null);
		try{if(xmlHttp.status == 200){ReturnGetFranchiseList();}}catch(e){}
}


function ReturnGetFranchiseList()
{
	
	
      if (xmlHttp.readyState == 4)
	  {
		  
		 if (xmlHttp.status == 200)
	    {
			
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var ListLength = xmlDoc.getElementsByTagName('Length')[0].childNodes[0].nodeValue;
			var Num = 1;
			
			FranArray = new Array();
			
			FranArray[0] = new Array('None','None','','');
			
			
			
			for (i = 1; i <= ListLength; i++)
				{
					
					var sFranchiseID = 'FranchiseID'+Num;
					var sFranchiseName = 'FranchiseName'+Num;
					var sFranchiseParent = 'FranchiseParent'+Num;					
					
					var FranchiseID = xmlDoc.getElementsByTagName(sFranchiseID)[0].childNodes[0].nodeValue;
					var FranchiseName = xmlDoc.getElementsByTagName(sFranchiseName)[0].childNodes[0].nodeValue;					
					var FranchiseParent = xmlDoc.getElementsByTagName(sFranchiseParent)[0].childNodes[0].nodeValue;
					
										
					FranArray[i] = new Array('',FranchiseID,FranchiseName,FranchiseParent);
					
					Num ++;
					
					
					
				}
				
			
			
			FranchiseArray = FranArray;
			
			//alert (FranchiseArray);		
			
			 GetSystemsList();
            
            
         }
		 else
		 {
            alert('There was a problem with the GetFranchiseList request.');
         }
      }


}
////-------------------------------------------------------------------------------------------------












////-------------------------------------------------------------------------------------------------
function GetSystemsList()
{	
	Gebi('LoadInfo').innerHTML='Systems';
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetSystemsList;
	HttpText='CommonASP.asp?action=GetSystemsList';
	xmlHttp.open('GET',HttpText, true);
	xmlHttp.send(null);
	//if(xmlHttp.status == 200){ReturnGetSystemsList();}
}

function ReturnGetSystemsList()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			
			try
			{
				var Var='ListLength';
				var ListLength = xmlDoc.getElementsByTagName('Length')[0].childNodes[0].nodeValue.replace('--','');
			}
			catch(e)
			{
				AjaxErr('There is a problem with "GetSystemsList:'+Var+'" Data.',HttpText);
			}
			
			var Num = 1;
			
			SysListArray = new Array();
			
			SysListArray[0] = new Array('','');
			
			
			for (i = 1; i <= ListLength; i++)
			{
				var sSystemID = 'SystemID'+Num;
				var sSystemName = 'SystemName'+Num;					
				
				var SystemID = xmlDoc.getElementsByTagName(sSystemID)[0].childNodes[0].nodeValue;
				var SystemName = xmlDoc.getElementsByTagName(sSystemName)[0].childNodes[0].nodeValue;						
				
				SysListArray[i] = new Array(SystemID,SystemName);
				
				Num ++;
			}
			
			SystemsListArray = SysListArray;
			
			//GetAreaList();
			GetServiceList()
			
		}
		else
		{
			AjaxErr('There was a problem with the GetSystemsList request.',HttpText);
		}
	}
}
////-------------------------------------------------------------------------------------------------



//Gets the Service List information and creates a global 3D array of the list called ServiceArray-///////////////////////////////

function GetServiceList()
{	
	//xmlHttp.status=null;
	Gebi('LoadInfo').innerHTML='Service List';
	HttpText='CommonASP.asp?action=GetActiveServiceList';
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetServiceList;
	xmlHttp.open('GET',HttpText, true);
	xmlHttp.send(null);
	//if(xmlHttp.status == 200){ReturnGetServiceList();}
}


function ReturnGetServiceList()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;	
			var ServiceListLength = xmlDoc.getElementsByTagName('ServiceListLength')[0].childNodes[0].nodeValue.replace('--','');
			var ServiceNum = 1;
			ServeArray = new Array();
			
			ServeArray[0] = new Array('','','');
			
			for (i = 1; i <= ServiceListLength; i++)
			{
				var sServiceID = 'ServiceID'+ServiceNum;
				var sServiceName = 'ServiceName'+ServiceNum;
				
				var ServiceID = xmlDoc.getElementsByTagName(sServiceID)[0].childNodes[0].nodeValue.replace('--','');
				var ServiceName = xmlDoc.getElementsByTagName(sServiceName)[0].childNodes[0].nodeValue.replace('--','');					
				
				ServeArray[i] = new Array('',ServiceID,ServiceName);
				ServiceNum ++;
			}
			NumTasks = ServiceListLength;
			ServiceArray = ServeArray;
			
			GetTestMaintList();
		}
		else
		{
			AjaxErr('There was a problem with the GetServiceList request.',HttpText);
		}
	}
}
////-------------------------------------------------------------------------------------------------


//Gets the Test/Maintenance List information and creates a global 3D array of the list called TestMaintArray-///////////////////////

function GetTestMaintList()
{	
	Gebi('LoadInfo').innerHTML='Test / Maintenance List';
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetTestMaintList;
	xmlHttp.open('GET','CommonASP.asp?action=GetActiveTestMaintList', false);
	xmlHttp.send(null);
	if(xmlHttp.status == 200){ReturnGetTestMaintList();}
}

function ReturnGetTestMaintList()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var TestMaintListLength = xmlDoc.getElementsByTagName('TestMaintListLength')[0].childNodes[0].nodeValue;
			var TestMaintNum = 1;
			TestArray = new Array();
			
			TestArray[0] = new Array('','','');
			
			for (i = 1; i <= TestMaintListLength; i++)
			{
				var sTestMaintID = 'TestMaintID'+TestMaintNum;
				var sTestMaintName = 'TestMaintName'+TestMaintNum;
				
				var TestMaintID = xmlDoc.getElementsByTagName(sTestMaintID)[0].childNodes[0].nodeValue.replace('--','');
				var TestMaintName = xmlDoc.getElementsByTagName(sTestMaintName)[0].childNodes[0].nodeValue.replace('--','');					
				
				TestArray[i] = new Array('',TestMaintID,TestMaintName);
				TestMaintNum ++;
			}
			NumTasks = TestMaintListLength;
			TestMaintArray = TestArray;
			
			//var General=document.getElementById('GeneralIframe').contentWindow.document;
			//General.LoadNotes();
			
			
			/*Done Loading Now*/
			
			var i=1;
			if(IEver!=0)
			{
				for(o=document.getElementById('Modal').style.opacity*100;o<1;o--)
				{
					//setTimeout('document.getElementById("Modal").style.opacity="'+(o/100)+'"',i*100);
						setTimeout('document.getElementById("Modal").style.filter="alpha(opacity='+o+')"',i*100);
					i++;
				}
			}
			setTimeout('document.getElementById("Modal").style.display="none";',i*100);
			
			
			
			CreateCalendarTabs();
		}
		else
		{
			alert('There was a problem with the GetTestMaintList request.');
		}
	}
}
////-------------------------------------------------------------------------------------------------


function LogOut()
{
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnLogOut;
	xmlHttp.open('GET','CommonASP.asp?action=LogOut', false);
	xmlHttp.send(null);
	if(xmlHttp.status == 200){ReturnLogOut();}
}
function ReturnLogOut()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			//var xmlDoc = xmlHttp.responseXML.documentElement;
			//var LogOut = xmlDoc.getElementsByTagName('LogOut')[0].childNodes[0].nodeValue;
			window.location='../TMC/TMC.HTML';
		}
		else
		{
			alert('Problem with logout request');
		}
	}
}
//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------




//var mainTimer=setInterval(LiveUpdater,3000)
var LUHttpText='';
function LiveUpdater()
{
	LUHttpText='CommonASP.asp?action=LiveUpdater'
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = function() {if (xmlHttp.readyState == 4) ReturnLiveUpdater();}
	xmlHttp.open('GET', LUHttpText, false);
	xmlHttp.send(null);
	if(xmlHttp.status == 200){ReturnLiveUpdater();}
}
function ReturnLiveUpdater()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			function xmlTag(tagName) { return xmlHttp.responseXML.documentElement.getElementsByTagName(tagName)[0].childNodes[0].nodeValue; }
			var Visitors = xmlTag('Visitors');
			
			//try{Gebi('CurrentUsers').innerHTML=Visitors;}catch(e){}
			
		}
		else
		{
			AjaxErr('Problem with LiveUpdater request!',LUHttpText);
		}
	}
}
//LiveUpdater();
//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------

