//JavaScript Document






///////////// AJAX ///////////////////////////////////////////////
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



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function SetBit(Field, Bit, ReportID)
{
	if(!!Bit)	{Bit='True'}	else	{Bit='False'}
	SendSQL('Write','UPDATE FormansReport SET '+Field+'=\''+Bit+'\' WHERE ReportID='+ReportID);
}


function DateChange(OldD8, NewD8, ProjID, ReportID)
{
	if(confirm('Since there can only be one report per project per day, Changing the date will replace a report with that date with this one, if one exists. However, all time from both reports will be preserved and merged into this report.  Is this Ok?'))
	{
		SendSQL('Write','DELETE FROM FormansReport WHERE Date=\''+NewD8+'\'','NoErrors')
		SendSQL('Write','UPDATE FormansReport SET Date=\''+NewD8+'\' WHERE ReportID='+ReportID);
		SendSQL('Write','UPDATE Time SET Date=\''+NewD8+'\' WHERE Date=\''+OldD8+'\' AND JobID='+ProjID);
	}
	window.location=window.location;
}


function FormanChange(Forman, ProjID, d8, ReportID)
{
	SendSQL('Write','UPDATE FormansReport SET FormanID='+Forman+' WHERE ReportID='+ReportID);
	SendSQL('Write','UPDATE Time SET Supervisor=\''+Forman+'\' WHERE Date=\''+d8+'\' AND JobID='+ProjID);
	
	//window.location=window.location;
}
