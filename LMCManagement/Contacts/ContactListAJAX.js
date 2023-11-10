// JavaScript Document   AJAX CONTROLS

var CheckArray = "";

var xhr;
var HttpText;
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXmlHttpObject(){
	var xmlHttp=null;
	try { xmlHttp=new XMLHttpRequest(); }	// Firefox, Opera 8.0+, Safari
	catch (e) {  // Internet Explorer		
		try {			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");		}
		catch (e) {			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");		}
	}
	if (xmlHttp==null) alert ("Your browser does not support AJAX!");
	
	return xmlHttp;
}
//------------------------------------------------------------------------------------------------


function delContact(ContactID)	{
	
	HttpText='Contacts_ASP.asp?action=ContactDel&id='+ContactID;
	xhr = GetXmlHttpObject();
	xhr.onreadystatechange = ReturnDelContact;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
	
	function ReturnDelContact ()	{
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				//AjaxErr('What\'s happening? with the DelProj request.',HttpText);
				//location+='';
			}
			else {
				AjaxErr('There was a problem with the DelProj request.',HttpText);
			}
		}
	}
}

function prepareProjectDownload(downloadArrow,projId) {
	
	location='XMLX.lmcProject?action=project&id='+projId;
	/** /
	HttpText='XMLX.asp?action=project&id='+projId;
	xhr = GetXmlHttpObject();
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				try { var xmlDoc = xhr.responseXML.documentElement; }
				catch(e) {
					AjaxErr('There was a problem with the prepareProjectDownload response.',HttpText);
				}
				//AjaxErr('What\'s happening? with the prepareProjectDownload request.',HttpText);
				//window.location=window.location;
				
				//var filename = xmlDoc.getElementsByTagName("filename")[0].childNodes[0].nodeValue;
				
				var json=xml2json(xmlDoc);
				
				downloadArrow.onclick=function() {
					requestFileSystem(PERSISTENT, 1048576, function(fs) {  });//, function(e) {  });
										
				}
				downloadArrow.src='../images/download_64.png';
			}
			else {
				AjaxErr('There was a problem with the prepareProjectDownload request.',HttpText);
			}
		}
	}
	xhr.open('Get',HttpText, true);
	xhr.send(null);
	/**/
}