// JavaScript Document   AJAX CONTROLS


var xmlHttp;
var HttpText;
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXmlHttpObject()	{
	var xmlHttp=null;
	try	{
		xmlHttp=new XMLHttpRequest(); // Firefox, Opera 8.0+, Safari
	}
	catch (e)  {
		// Internet Explorer
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e)	{
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
	if (xmlHttp==null)	{
		alert ("Your browser does not support AJAX!");
		return;
	}
	return xmlHttp;
}
//------------------------------------------------------------------------------------------------

var SqlXML;

function SendSQL(ReadWrite,Statement){
	SqlXML=null;
	HttpText=encodeURI('SqlASP.asp?action='+ReadWrite+'&SQL='+Statement);
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnSQL;
	xmlHttp.open('Get',HttpText, false);
	xmlHttp.send(null);
}

function ReturnSQL()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			SqlXML=xmlHttp.responseXML.documentElement;
		}
		else{AjaxErr('Error in SqlAjax-SendSQL \n'+xmlHttp.status+'\n '+HttpText,HttpText);}
	}
}
