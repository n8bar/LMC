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
function SaveNewBid()
{
	var name=CharsEncode(Gebi('nbProjName').value);
	var city=CharsEncode(Gebi('nbCity').value);
	var address=CharsEncode(Gebi('nbAddress').value);
	var state=CharsEncode(Gebi('nbState').value);
	var zip=CharsEncode(Gebi('nbZip').value);
	var sqFeet=parseInt(Gebi('nbSqFeet').value);
	var floors=parseInt(Gebi('nbFloors').value);
	if(isNaN(sqFeet)) { sqFeet=0; }
	if(isNaN(floors)) { floors=0; }
	var newBid='True';
	if(!Gebi('nbNewBidder').checked){ newBid='False';}
	
	HttpText='BidASP.asp?action=SaveNewBid&name='+name+'&city='+city+'&address='+address+'&state='+state+'&zip='+zip+'&sqFeet='+sqFeet+'&floors='+floors+'&newBid='+newBid;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnSaveNewBid;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	//Gebi('BidOverlayTxt').innerHTML='Data Request Sent. Waiting on server.';

	function ReturnSaveNewBid() {
		//Gebi('BidOverlayTxt').innerHTML+='.';
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				//Gebi('BidOverlayTxt').innerHTML='Interpreting Bidding Data...';
				
				try	{	var xmlDoc = xmlHttp.responseXML.documentElement;	}
				catch(e)	{					AjaxErr('There was a problem with the SaveNewBid response.',HttpText); }
				
				try	{	var newProjId= xmlDoc.getElementsByTagName('projId')[0].childNodes[0].nodeValue; }
				catch(e)	{					AjaxErr('There was a problem with the SaveNewBid response.',HttpText); }
				BidList.location=BidList.location;
				hideNewBid();
				Gebi('BidListFrame').contentWindow.Edit(newProjId);
			}
			else {
				AjaxErr('There was a problem with the SaveNewBid request.',HttpText);
				//BidOverlayTxt.innerHTML='';
			}
		}
	}
}
