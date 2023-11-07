// JavaScript Document   AJAX CONTROLS

var xhr;
var HttpText;
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXmlHttpObject(){
	var xmlHttp=null;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp=new XMLHttpRequest();
	}
	catch (e) {
		// Internet Explorer
		try {
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e) {
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
	if (xmlHttp==null) {
		alert ("Your browser does not support AJAX!");
		return;
	}
	
	return xmlHttp;
}
//------------------------------------------------------------------------------------------------





function delProj(projId)	{
/** /	
	HttpText='BidASP.asp?action=delProj&projId='+projId;
	xhr = GetXmlHttpObject();
	xhr.onreadystatechange = ReturnDelProj;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
	
	function ReturnDelProj ()	{
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				//AjaxErr('What\'s happening? with the DelProj request.',HttpText);
				window.location=window.location;
			}
			else {
				AjaxErr('There was a problem with the DelProj request.',HttpText);
			}
		}
	}
	/**/
}