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
function NewReport(d8, ProjID)
{
	HttpText='FormansDailyReportsASP.asp?action=NewReport&ProjID='+ProjID+'&Date='+d8;
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnNewReport;
	xmlHttp.open('Get',HttpText,true);
	xmlHttp.send(null);
}
function ReturnNewReport()
{
	if(xmlHttp.readyState==4)
	{
		if(xmlHttp.status==200)
		{
			var xmlDoc=xmlHttp.responseXML.documentElement;
			var Exists=xmlDoc.getElementsByTagName("Exists")[0].childNodes[0].nodeValue;
			var d8=xmlDoc.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
			var ProjID=xmlDoc.getElementsByTagName("ProjID")[0].childNodes[0].nodeValue;
			
			
			//AjaxErr('Ajax: NewReport Check', HttpText);
			
			if(Exists==1)
			{
				var ReportID=xmlDoc.getElementsByTagName("ReportID")[0].childNodes[0].nodeValue;
				
				if(confirm('This project already has a report for '+d8+'.  \n Click OK to edit it.'))
				{	window.location='formansdaily.asp?Report='+ReportID;	}
				else
				{ return false;	}
			}
			else
			{
				window.location='formansdaily.asp?Report=ByDate&Date='+d8+'&ProjID='+ProjID;	
			}
		}
		else
		{
			AjaxErr('Ajax: NewReport Failed', HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------
