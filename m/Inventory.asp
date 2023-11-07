<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="common.asp" -->

<script type="text/javascript" src="../tmcManagement/CommonAJAX.js"></script>
<script type="text/javascript" src="../tmcManagement/rcstri.js"></script>


<script type="text/javascript">
function Void(){}

function logOut() {
	xmlHttp = GetXmlHttpObject();
	xmlHttp.open('POST','mobileASP.asp?action=LogOut', false);
	xmlHttp.send(null);
	window.location.reload();
}

function getCookie(c_name)
{
if (document.cookie.length>0)
  {
  c_start=document.cookie.indexOf(c_name + "=");
  if (c_start!=-1)
    {
    c_start=c_start + c_name.length+1;
    c_end=document.cookie.indexOf(";",c_start);
    if (c_end==-1) c_end=document.cookie.length;
    return unescape(document.cookie.substring(c_start,c_end));
    }
  }
return "";
}

function GetXmlHttpObject()
{ var xmlHttp=null;
	try{xmlHttp=new XMLHttpRequest();}// Firefox, Opera 8.0+, Safari, Chrome
	catch (e)
  {	try {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}// Internet Explorer
  	catch (e){xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}}
	if (xmlHttp==null){alert ("Your browser does not support AJAX!");return;}
	return xmlHttp;
}

/*
function Logout() {
	var D = new Date();
	D.setDate(D.getDate()-1);
	document.cookie='UserName=0;';
	document.cookie='Password=0;';
	document.cookie='EmpID=0;';
	//alert(document.cookie);

	window.location.reload();
}*/

function Login() {
	//var User = document.getElementById('txtUN').value;
	//var Pass = document.getElementById('txtPW').value;
	//document.cookie='UserName='+User+';';
	//document.cookie='Password='+Pass+';';
	var User=getCookie('UserName');
	var Pass=getCookie('Password');
	
	var msg='';
	if(User==''){msg='Username is blank\r';}
	if(Pass==''){msg+='Password is blank\r';}
	
	if(msg!='')
	{
		alert(msg);
		document.getElementById('txtUN').select()
		return false;
	}
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnLogin;
	xmlHttp.open('Get','LoginASP.asp?action=Login&User='+User+'&Pass='+Pass, true);
	xmlHttp.send(null);
}
var EmpID=0;
function ReturnLogin()
{
	//alert(xmlHttp.readyState);
	if (xmlHttp.readyState == 4)
	{
		//alert(xmlHttp.status);
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			EmpID = xmlDoc.getElementsByTagName('EmpID')[0].childNodes[0].nodeValue;
			document.cookie='EmpID='+EmpID+';';
			//alert(xmlDoc.getElementsByTagName('User')[0].childNodes[0].nodeValue.replace('--',''));
			
			if(EmpID=='0')
			{
				alert('Wrong username and/or password');
				
				//document.getElementById('user').value = '';
				document.getElementById('txtPW').value = '';
				document.getElementById('txtUN').focus();
			}
			else
			{
			}
			
			window.location.reload();
		}
		else
		{
			alert('There was a problem with the request.');
			window.location.reload();
}	}	}

function onLoad() {
	Gebi('SearchBox').focus();
}

function Search() {
	Gebi('lItems').src='InventoryList.asp?SearchString='+Gebi('SearchBox').value;
}

function sortBy(field,div) {
	sW('InventoryOrder',field);
	Search();
	Gebi('ihName').style.fontWeight='normal';
	Gebi('ihMfr').style.fontWeight='normal';
	Gebi('ihDesc').style.fontWeight='normal';
	Gebi('ihPN').style.fontWeight='normal';
	Gebi('ihStock').style.fontWeight='normal';
	div.style.fontWeight='bold';
}
</script>

<link rel="stylesheet" href="mobile.css" media="screen">

<style type="text/css" media="all">
html{ margin:0 0 0 0; width:100%; height:100%; overflow:auto; background:#EFF; text-align:center; font-family:Arial;}
body{ margin:0 0 0 0; width:100%; min-width:240px; height:100%; min-height:240px; overflow:hidden; background:#EFF; }
a { width:100%; height:48px; display:block; float:left; border-radius:2px; margin:0; font-size:36px; line-height:48px; text-decoration:none; color:white; opacity:.75;  
 font-family: "Arial Narrow", "Agency FB", "Swis721 LtCn BT"; font-weight:bold;
 background:-moz-linear-gradient(top, rgba(0,120,192,.75), /*rgba(0,120,192,.5) 50%*/, rgba(0,108,172,.5));
 background:-webkit-gradient(linear,0 100%,0 0, from(rgba(0,120,192,.75)) /*,color-stop(.5,  rgba(0,120,192,.5))*/, to(rgba(0,108,172,.5)));
}
a:focus { background-color:white; outline:invert thin solid; opacity:1; }
a:active { background-color:black; }
a:hover { }
.space { width:100%; height:48px;}

#Search { width:80%; height:10%; max-height:64px; min-height:40px; margin:2px 0 0 10%; padding:0; background:rgba(0,192,192,.5); border-radius:24px;
 background:-moz-linear-gradient(bottom, rgba(0,192,192,.75), rgba(0,144,144,.5) 50%, rgba(0,96,96,.5));
 background:-webkit-gradient(linear,0 0,0 100%, from(rgba(0,192,192,.75)) ,color-stop(.5,  rgba(0,144,144,.5)), to(rgba(0,96,96,.5)));
}
#innerSearch {position:relative; width:100%; top:15%; }
#SearchBox { width:50%; border-radius:4px; max-height:24px; line-height:24px; white-space:nowrap; }

#itemsHead { width:90%; margin:2px 0 0 5%; overflow:hidden; max-height:42px; min-height:30px; height:7.5%; line-height:24px;
 border:rgba(0,0,0,.333) solid 1px; border-left-width:2px; border-radius:10px; border-bottom-left-radius:4px; border-bottom-right-radius:4px;
 background:-moz-linear-gradient(bottom, rgba(0,192,192,.125), rgba(0,144,144,.25) 50%, rgba(0,96,96,.25));
 background:-webkit-gradient(linear,0 0,0 100%, from(rgba(0,192,192,.125)) ,color-stop(.5,  rgba(0,144,144,.25)), to(rgba(0,96,96,.25)));
}
#itemsHead div{ float:left; border-left:rgba(255,255,255,.75) solid 1px; border-right:rgba(0,0,0,.25) solid 1px; height:100%; }
#itemsHead:first-child{border-top-left-radius:9px; border-top-right-radius:9px;}

#itemsHeadTop { height:10px !important; width:100%; float:left; font-size:10px; line-height:10px; text-align:left; border:none !important; opacity:.5; overflow:hidden;
 background:-moz-linear-gradient(top, rgba(224,255,255,.25), /*rgba(0,192,192,.5) 50%,*/ rgba(128,144,144,.25));
 background:-webkit-gradient(linear,0 0,0 100%, from(rgba(224,255,255,.25)) /*,color-stop(.5, rgba(0,192,192,.5))*/, to(rgba(128,144,144,.25)));
}

.fwN {font-weight:normal;}
.fwB {font-weight:bold;}

#lItemsDiv {  width:90%; margin:0 0 0 5%; height:80%; /*border:1px rgba(0,0,0,.333) solid;*/ overflow:hidden;
 border-radius:4px; border-top:none; border-bottom-left-radius:12px; border-bottom-right-radius:12px; }

#lItems { width:100%; margin:0%; height:100%; border:none; overflow:hidden;
 border-radius:4px; border-top:none; border-bottom-left-radius:12px; border-bottom-right-radius:12px;
}
</style>

<%

UserName=Session("User")
Password=Session("Pass")

Sub DebugAccess 
End Sub

SQL1 ="SELECT * FROM Access WHERE Password='"&Password&"' AND UserName='"&UserName&"'"
set rs1=Server.CreateObject("ADODB.Recordset")
rs1.Open SQL1, REDconnstring
if rs1.eof then
	%><script>window.location=('../tmc/m.asp?Destination='+encodeURI(window.location));</script><%
  'Response.Write("UserName:&"UserName)
  'Response.Write("Password:&"Password)
end if

EmpID = Session("EmpID")
%>
</head>
<body onload="onLoad();">
<div id=Search >
	<div id=innerSearch>
		<label>Search: <input id=SearchBox onkeypress="ifEnter(event,'Search();');" value="<%=Request.QueryString("search")%>" /></label>
		<button onclick="Search();"><b>Go</b></button>
	</div>
</div>
<div id=itemsHead>
	<div id=itemsHeadTop>
		<div id=ihName style="width:30%; font-weight:normal; " onclick="sortBy('Model',this);" >Name</div>
		<div id=ihMfr style="width:20%; font-weight:normal; " onclick="sortBy('Manufacturer',this);">Manufacturer</div>
		<div id=ihDesc style="width:20%; font-weight:normal; ">Description</div>
		<div id=ihDesc style="width:30%; font-weight:normal; text-align:center; color:#000; "><b>Stock</b></div>
	</div>
	<div id=ihPN style="width:30%; font-weight:normal; " onclick="sortBy('PartNumber',this);" >Part#</div>
	<div id=ihRetail style="width:20%; font-weight:normal; " onclick="sortBy('Retail',this);">Retail</div>
	<div id=ihStock style="width:20%; font-weight:normal; " onclick="sortBy('Inventory DESC',this);">In Stock</div>
	<div id=ihButtons style="width:30%; font-weight:normal; ">Adjustments</div>
</div>
<div id=lItemsDiv><iframe id=lItems src="InventoryList.asp?SearchString=<%=Request.QueryString("search")%>"></iframe></div>

</body>
</html>
