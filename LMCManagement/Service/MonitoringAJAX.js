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






//Loads all of the Current Bidding --////////////////////////////////////////////////
/*
function SaveNewAccount() {
	var name=CharsEncode(Gebi('nbProjName').value);
	var city=CharsEncode(Gebi('nbCity').value);
	var address=CharsEncode(Gebi('nbAddress').value);
	var state=CharsEncode(Gebi('nbState').value);
	var zip=CharsEncode(Gebi('nbZip').value);
	var sqFeet=parseInt(Gebi('nbSqFeet').value);
	var floors=parseInt(Gebi('nbFloors').value);
	if(isNaN(sqFeet)) { sqFeet=0; }
	if(isNaN(floors)) { floors=0; }
	var newAccount='True';
	if(!Gebi('nbNewAccountder').checked){ newAccount='False';}
	
	HttpText='AccountASP.asp?action=SaveNewAccount&name='+name+'&city='+city+'&address='+address+'&state='+state+'&zip='+zip+'&sqFeet='+sqFeet+'&floors='+floors+'&newAccount='+newAccount;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnSaveNewAccount;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	//Gebi('AccountOverlayTxt').innerHTML='Data Request Sent. Waiting on server.';

	function ReturnSaveNewAccount() {
		//Gebi('AccountOverlayTxt').innerHTML+='.';
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				//Gebi('AccountOverlayTxt').innerHTML='Interpreting Accountding Data...';
				
				try	{	var xmlDoc = xmlHttp.responseXML.documentElement;	}
				catch(e)	{					AjaxErr('There was a problem with the SaveNewAccount response.',HttpText); }
				
				try	{	var newProjId= xmlDoc.getElementsByTagName('projId')[0].childNodes[0].nodeValue; }
				catch(e)	{					AjaxErr('There was a problem with the SaveNewAccount response.',HttpText); }
				AccountList.location=AccountList.location;
				hideNewAccount();
				Gebi('AccountListFrame').contentWindow.Edit(newProjId);
			}
			else {
				AjaxErr('There was a problem with the SaveNewAccount request.',HttpText);
				//AccountOverlayTxt.innerHTML='';
			}
		}
	}
}
*/