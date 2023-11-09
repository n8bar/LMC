// JavaScript Document   AJAX CONTROLS

var xhr;
var HttpText;
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXmlHttpObject(){
	var xmlHttp=null;
	try { // Firefox, Opera 8.0+, Safari
		xmlHttp=new XMLHttpRequest();
	}
	catch (e) { // Internet Explorer
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


function openPart(pId) {
	HttpText='MaterialsASP.asp?action=openPart&pID='+pId;
	xhr = GetXmlHttpObject();
	xhr.onreadystatechange = ReturnOpenPart;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
	
	function ReturnOpenPart ()	{
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				try { var xmlDoc=xhr.responseXML.documentElement; }
				catch(e) { 
					AjaxErr('There is an error in the openPart response.',HttpText);
					return false;
				}

				var Mfr=CharsDecode(xmlDoc.getElementsByTagName('Manufacturer')[0].childNodes[0].nodeValue.replace('--',''));
				var pName=CharsDecode(xmlDoc.getElementsByTagName('Model')[0].childNodes[0].nodeValue.replace('--',''));
				var PN=CharsDecode(xmlDoc.getElementsByTagName('PartNumber')[0].childNodes[0].nodeValue.replace('--',''));
				var Labor=(xmlDoc.getElementsByTagName('LaborValue')[0].childNodes[0].nodeValue*1);
				var Cost=xmlDoc.getElementsByTagName('Cost')[0].childNodes[0].nodeValue;
				var System=xmlDoc.getElementsByTagName('System')[0].childNodes[0].nodeValue.replace('--','');
				var Category1=xmlDoc.getElementsByTagName('Category1')[0].childNodes[0].nodeValue.replace('--','');
				var Category2=xmlDoc.getElementsByTagName('Category2')[0].childNodes[0].nodeValue.replace('--','');
				var Vendor1=CharsDecode(xmlDoc.getElementsByTagName('Vendor1')[0].childNodes[0].nodeValue.replace('--',''));
				var Vendor2=CharsDecode(xmlDoc.getElementsByTagName('Vendor2')[0].childNodes[0].nodeValue.replace('--',''));
				var Vendor3=CharsDecode(xmlDoc.getElementsByTagName('Vendor3')[0].childNodes[0].nodeValue.replace('--',''));
				var Cost1=xmlDoc.getElementsByTagName('Cost1')[0].childNodes[0].nodeValue;
				var Cost2=xmlDoc.getElementsByTagName('Cost2')[0].childNodes[0].nodeValue;
				var Cost3=xmlDoc.getElementsByTagName('Cost3')[0].childNodes[0].nodeValue;
				var Date1=xmlDoc.getElementsByTagName('Date1')[0].childNodes[0].nodeValue.replace('--','');
				var Date2=xmlDoc.getElementsByTagName('Date2')[0].childNodes[0].nodeValue.replace('--','');
				var Date3=xmlDoc.getElementsByTagName('Date3')[0].childNodes[0].nodeValue.replace('--','');
				var Description=CharsDecode(xmlDoc.getElementsByTagName('Description')[0].childNodes[0].nodeValue.replace('--',''));
			}
		}
	}
}