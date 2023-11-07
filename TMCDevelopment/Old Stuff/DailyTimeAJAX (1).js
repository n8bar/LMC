 //JavaScriptDocument
var HttpText;
//CreatesthemainXMLHttpRequestobject////////////////////////////////////////////////////////
function GetXmlHttpObject()
{
	var xmlHttp=null;
	try
	{
		// Firefox, Opera 8.0+, Safari, Chrome
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
		alert ("Your lousy browser does not support AJAX!");
		return;
	}

	return xmlHttp;
}
//------------------------------------------------------------------------------------------------


var HoursBox=null;
function ChangeHrs(TimeID,txtObject)
{
	var Hours=txtObject.value;
	
	if(Hours>=24)
	{
		alert('After 24 Hours, you need to make another daily report.');
		txtObject.select();
		return false;
	}
	
	if(Hours<0)
	{
		alert('Minimum of 0 hours is required!');
		txtObject.select();
		return false;
	}
	
	//alert(HoursBox);
	//alert(txtObject);
	
	HoursBox=txtObject;
	HttpText='DailyTimeASP.asp?action=ChangeHrs&TimeID='+TimeID+'&Hours='+Numberize(Hours);
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnChangeHrs;
	xmlHttp.open('Get',HttpText,true);
	xmlHttp.send(null);
}
function ReturnChangeHrs()
{
	if(xmlHttp.readyState==4)
	{
		if(xmlHttp.status==200)
		{
			var xmlDoc=xmlHttp.responseXML.documentElement;
			var Error=xmlDoc.getElementsByTagName("Error")[0].childNodes[0].nodeValue;
			
			Saved(HoursBox.id);
		}
		else
		{
			AjaxErr('Ajax: ChangeHrs Failed', HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------


function NewTime(d8, ProjID, ProjName)
{
	SupID=PSelI('Forman').value;
	
	if(SupID==''||SupID==null){SupID=1542}
	
	var Fields='EmpID, Date,       TimeInHr, TimeInMin, TimeOutHr, TimeOutMin, JobID,      JobName,          JobPhase,  JobType,     Supervisor, JobSystemID';
	var Values='1542,  \''+d8+'\', 0,        0,         0,         0,          '+ProjID+', \''+ProjName+'\', \'N/A\',   \'Project\', '+SupID+',       0';
	var SQL='INSERT INTO Time ('+Fields+') VALUES ('+Values+')';
	SendSQL('Write',SQL);
	window.location=window.location;
}

