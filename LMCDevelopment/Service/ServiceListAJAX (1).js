// JavaScript Document   AJAX CONTROLS

var CheckArray = "";

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


function delJob(Id)	{
	
	HttpText='ServiceASP.asp?action=delJob&Id='+Id;
	xhr = GetXmlHttpObject();
	xhr.onreadystatechange = ReturnDelJob;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
	
	function ReturnDelJob ()	{
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				//AjaxErr('What\'s happening? with the DelJob request.',HttpText);
				
				//alert('wouldBReloadin...');
				window.location=window.location;
			}
			else {
				AjaxErr('There was a problem with the DelJob request.',HttpText);
			}
		}
	}
}