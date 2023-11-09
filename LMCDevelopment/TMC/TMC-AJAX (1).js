// JavaScript Document

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


function GetViewers()
{
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnViewers;
	HttpText='TMC-ASP.asp?action=GetViewers'
	xmlHttp.open('GET',HttpText, false);
	xmlHttp.send(null);
	try{if(xmlHttp.status == 200){ReturnViewers();}}catch(e){}
}
function ReturnViewers()
{
	//Gebi('LoadInfo').innerHTML+='...';
	if (xmlHttp.readyState == 4)
	{ 
		if (xmlHttp.status == 200)
		{
			//AjaxErr('There isn\'t an error with seeing who\'s looking!',HttpText)
		
		}
		
		else
		{
			AjaxErr('There is an error with seeing who\'s looking!',HttpText)
		}
		
		
	}
}





