// JavaScript Document   AJAX CONTROLS

//Main HTTPXML Request Code Comes From CommonAJAX.js


var xmlHttp


//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXmlHttpObject()
{
var xmlHttp=null;
try
  {
  // Firefox, Opera 8.0+, Safari
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
	  alert ("Your browser does not support AJAX!");
	  return;
	  }
	  
	  
return xmlHttp;
}
//------------------------------------------------------------------------------------------------



function n8()
{
	var ProjID = document.getElementById('txt').value;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnN8;
	xmlHttp.open('Get','n8ASP.asp?action=n8&ProjID='+ProjID, true);
	xmlHttp.send(null);
}
	function ReturnN8() 
	{
		if (xmlHttp.readyState == 4)
		{
			if (xmlHttp.status == 200)
			{
				var xmlDoc = xmlHttp.responseXML.documentElement;
				
				var BidCount = xmlDoc.getElementsByTagName('BidCount')[0].childNodes[0].nodeValue;
				
				var CustID = new Array; CustID.length = BidCount;
				
				var i;
				for(i=1; i<BidCount; i++)
				{
					CustID[i] = xmlDoc.getElementsByTagName('CustID'+i)[0].childNodes[0].nodeValue;
					
					document.write(Custid[i]+'<br />');
				}
				
			}
			else
			{
				alert('There was a problem with the request.');
}	}	}
//---------------------------------------------------------------