// JavaScript Document   AJAX CONTROLS

var xmlHttp;
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






//Loads all of the Current Contactding --////////////////////////////////////////////////
function SaveNewContact() {
	HttpText='Contacts_ASP.asp?action=SaveNewContact&name='+CharsEncode(Gebi('nbContactName').value)+'&newContact=True';
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnSaveNewContact;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	//Gebi('ContactOverlayTxt').innerHTML='Data Request Sent. Waiting on server.';

	function ReturnSaveNewContact() {
		//Gebi('ContactOverlayTxt').innerHTML+='.';
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				//Gebi('ContactOverlayTxt').innerHTML='Interpreting Contactding Data...';
				
				try	{	var xmlDoc = xmlHttp.responseXML.documentElement;	}
				catch(e)	{					AjaxErr('There was a problem with the SaveNewContact response.',HttpText); }
				
				try	{	var newContactId= xmlDoc.getElementsByTagName('id')[0].childNodes[0].nodeValue; }
				catch(e)	{					AjaxErr('There was a problem with the SaveNewContact response.',HttpText); return false; }
				ContactList.location=ContactList.location;
				hideNewContact();
				
				Gebi('ContactListFrame').contentWindow.Edit(newContactId);
			}
			else {
				AjaxErr('There was a problem with the SaveNewContact request.',HttpText);
				//ContactOverlayTxt.innerHTML='';
}	}	}	}