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



function searchCustList(e,searchTxt) {
	HttpText='ServiceASP.asp?action=searchCust&txt='+searchTxt;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				try	{	var xmlDoc = xmlHttp.responseXML.documentElement;	}
				catch(e)	{ AjaxErr('There was a problem with the searchCustList response.',HttpText); }
				
				var response=xml2json(xmlDoc);
				
				Gebi('custList').innerHTML='';
				Gebi('custList').style.top=Gebi('nbCust').offsetTop+Gebi('nbCust').offsetHeight+('px');
				Gebi('custList').style.left=Gebi('nbCust').offsetLeft+('px');
				Gebi('custList').style.width=Gebi('nbCust').offsetWidth+('px');
				//alert(response.count);
				for(var i=0; i<response.count; i++) {
					itemTxt=response.id[i]+': '+response.name[i];
					Gebi('custList').innerHTML+='<div id=custListItem'+i+' onclick="setCust(\''+itemTxt+'\');" >'+itemTxt+'</div>'
				}
				
			}
		}
	}
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

//Loads all of the Current Servicing --////////////////////////////////////////////////
function SaveNewService() {
	var name=CharsEncode(Gebi('nbJobName').value);
	var city=CharsEncode(Gebi('nbCity').value);
	var addr=CharsEncode(Gebi('nbAddress').value);
	var state=CharsEncode(Gebi('nbState').value);
	var zip=CharsEncode(Gebi('nbZip').value);
	var active=nbActivate.checked;
	var custId=Gebi('nbCustID').value;
	try { custId*=1 }
	catch(e) { alert('Customer Selection Failed.  Please Re-Choose Customer.'); return false; }
	//var sqFeet=parseInt(Gebi('nbSqFeet').value);
	//var floors=parseInt(Gebi('nbFloors').value);
	//if(isNaN(sqFeet)) { sqFeet=0; }
	//if(isNaN(floors)) { floors=0; }
	//var newService='True';
	//if(!Gebi('nbNewServicer').checked){ newService='False';}
	
	HttpText='ServiceASP.asp?action=SaveNewService&name='+name+'&custid='+custId+'&city='+city+'&addr='+addr+'&state='+state+'&zip='+zip+'&active='+active;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnSaveNewService;
	xmlHttp.open('Get',HttpText, false);
	xmlHttp.send(null);
	//Gebi('ServiceOverlayTxt').innerHTML='Data Request Sent. Waiting on server.';

	function ReturnSaveNewService() {
		//Gebi('ServiceOverlayTxt').innerHTML+='.';
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				//Gebi('ServiceOverlayTxt').innerHTML='Interpreting Servicing Data...';
				
				try	{	var xmlDoc = xmlHttp.responseXML.documentElement;	}
				catch(e)	{					AjaxErr('There was a problem with the SaveNewService response.',HttpText); }
				
				try	{	var newJobId= xmlDoc.getElementsByTagName('Id')[0].childNodes[0].nodeValue; }
				catch(e)	{					AjaxErr('There was a problem with the SaveNewService response.',HttpText); }
				ServiceList.location=ServiceList.location;
				hideNewService();
				Gebi('ServiceListFrame').contentWindow.Edit(newJobId);
			}
			else {
				AjaxErr('There was a problem with the SaveNewService request.',HttpText);
				//ServiceOverlayTxt.innerHTML='';
			}
		}
	}
}
