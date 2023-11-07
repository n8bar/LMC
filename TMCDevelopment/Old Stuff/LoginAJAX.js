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

function Login()
{
	var User = document.getElementById('UserName').value;
	var PW = document.getElementById('Password').value;
	document.getElementById('UserName').value='';
	document.getElementById('Password').value='';
	UserName.focus();
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnLogin;
	xmlHttp.open('Get','LoginASP.asp?action=Login&User='+User+'&PW='+PW, true);
	xmlHttp.send(null);
}

function ReturnLogin()
{
		if (xmlHttp.readyState == 4)
		{
			if (xmlHttp.status == 200)
			{
				var xmlDoc = xmlHttp.responseXML.documentElement;
				
				var EmpID = xmlDoc.getElementsByTagName('EmpID')[0].childNodes[0].nodeValue;
				
				alert(EmpID);
				if(EmpID!=null&&EmpID!=''&&EmpID!=0){parent.document.getElementById('LoginIframe').style.visibility='hidden';}
			}
			else
			{
				alert('There was a problem with the request.');
}	}	}



/////////////////////////////

function n8()
{
	var ProjID = document.getElementById('txt').value;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnN8;
	xmlHttp.open('Get','LoginASP.asp?action=n8&ProjID='+ProjID, true);
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
				
				
			}
			else
			{
				alert('There was a problem with the request.');
}	}	}
//---------------------------------------------------------------