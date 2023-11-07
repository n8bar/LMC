 //JavaScriptDocument
var HttpText;
//CreatesthemainXMLHttpRequestobject////////////////////////////////////////////////////////
function GetXmlHttpObject()
{
	var xmlHttp=null;
	try
	{
		// Firefox, Opera 8.0+, Safari, Chrome
		xmlHttp=new XMLHttpRequest();
	}
	catch (e)
	{
		// Internet Explorer
		try
		{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e)
		{
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
		
	if (xmlHttp==null)
	{
		alert ("Your lousy browser does not support AJAX!");
		return;
	}

	return xmlHttp;
}
//------------------------------------------------------------------------------------------------


var HoursBox=null;
function NewPO(VendorID, ProjID)
{
	HttpText='PurchaseOrdersASP.asp?action=NewPO&ProjID='+ProjID+'&VendorID='+VendorID;
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnNewPO;
	xmlHttp.open('Get',HttpText,true);
	xmlHttp.send(null);
}
function ReturnNewPO()
{
	if(xmlHttp.readyState==4)
	{
		if(xmlHttp.status==200)
		{
			var xmlDoc=xmlHttp.responseXML.documentElement;
			var Exists=(xmlDoc.getElementsByTagName("Exists")[0].childNodes[0].nodeValue==1);
			//var Vendor=xmlDoc.getElementsByTagName("Vendor")[0].childNodes[0].nodeValue;
			var ProjID=xmlDoc.getElementsByTagName("ProjID")[0].childNodes[0].nodeValue;
			
			//AjaxErr('Ajax: NewReport Check', HttpText);
			
			if(Exists)
			{
				//var POID=xmlDoc.getElementsByTagName("POID")[0].childNodes[0].nodeValue;
				alert('This project has multiple PO\'s for this vendor.');
				Gebi('List').src=Gebi('List').src;
			}
			else
			{
				//'PO.asp?PO=ByDate&Date='+d8+'&ProjID='+ProjID;	
				Gebi('List').src=Gebi('List').src;
			}
			
			Gebi('Modal').style.display='none';
			Gebi('NewPOBox').style.display='none';
		}
		else
		{
			AjaxErr('Ajax: NewPO Failed', HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------


function GeneratePOs(ProjID)
{
	HttpText='PurchaseOrdersASP.asp?action=GeneratePOs&ProjID='+ProjID;
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnNewReport;
	xmlHttp.open('Get',HttpText,true);
	xmlHttp.send(null);
}
function ReturnNewReport()
{
	if(xmlHttp.readyState==4)
	{
		if(xmlHttp.status==200)
		{
			try{var xmlDoc=xmlHttp.responseXML.documentElement;}
			catch(e){	AjaxErr('There was a problem with the GeneratePOs response XML.', HttpText)}
			function xmlTag(tagName){return xmlDoc.getElementsByTagName(tagName)[0].childNodes[0].nodeValue;}
			
			//AjaxErr('View the XML for testing Purposes?', HttpText);
							
			Gebi('List').src=Gebi('List').src;
		}
		else
		{
			AjaxErr('There was a problem with the GeneratePOs request.', HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------

	
function DelSelected()
{
	if(! confirm('This will delete all selected Purchase Orders and the items they contain!')){return false;}
	
	var Inputs=Gebi('List').contentDocument.getElementsByTagName('input');
	for(i=0;i<Inputs.length;i++)
	{
		if(Inputs[i].type=='checkbox' && Inputs[i].checked)
		{
			var thisPO=Inputs[i].id.replace('Del','');
			var thisPOID=thisPO.split('-')[0];
			//var thisVendorID=thisPO.split('-')[1];
			//var thisVendorID=thisPO.split('-')[1];
			SendSQL('Write','DELETE FROM PurchaseOrders WHERE POID='+thisPOID);//+' AND VendorID='+thisVendorID);
			SendSQL('Write','DELETE FROM POItems WHERE POID='+thisPOID);// ProjID='+ProjID+' AND VendorID='+thisVendorID);
			
			Gebi('List').src=Gebi('List').src;
		}
	}
}
//-------------------------------------------------------------------------------------------------
