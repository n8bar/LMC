<!-- DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="../LMC/RED.asp" -->

<title>Lovo Management Center</title>

<script type="text/javascript">
function Void(){}

function logOut() {
	xmlHttp = GetXmlHttpObject();
	xmlHttp.open('POST','mobileASP.asp?action=LogOut', false);
	xmlHttp.send(null);
	window.location.reload();
}

function getCookie(c_name){
if (document.cookie.length>0)  {
  c_start=document.cookie.indexOf(c_name + "=");
  if (c_start!=-1)    {
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


function Login() {
	var User=getCookie('UserName');
	var Pass=getCookie('Password');
	
	var msg='';
	if(User==''){msg='Username is blank\r';}
	if(Pass==''){msg+='Password is blank\r';}
	
	if(msg!='') {
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
function ReturnLogin() {
	//alert(xmlHttp.readyState);
	if (xmlHttp.readyState == 4) {
		//alert(xmlHttp.status);
		if (xmlHttp.status == 200){
			var xmlDoc = xmlHttp.responseXML.documentElement;
			EmpID = xmlDoc.getElementsByTagName('EmpID')[0].childNodes[0].nodeValue;
			document.cookie='EmpID='+EmpID+';';
			//alert(xmlDoc.getElementsByTagName('User')[0].childNodes[0].nodeValue.replace('--',''));
			
			if(EmpID=='0') {
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
</script>

<%
Dim UserName
Dim Password

UserName=Session("User")
Password=Session("Pass")


Sub DebugAccess 
End Sub

SQL1 ="SELECT * FROM Access WHERE Password='"&Password&"' AND UserName='"&UserName&"'"
set rs1=Server.CreateObject("ADODB.Recordset")
rs1.Open SQL1, REDconnstring

if rs1.eof then 
	Response.Redirect("../lmc/m.asp")
  'Response.Write("UserName:&"UserName)
  'Response.Write("Password:&"Password)
end if
Dim EmpID
EmpID = rs1("EmpID")
Session("EmpID")=EmpID

%>

<link rel="stylesheet" href="mobile.css" media="screen">

<style type="text/css" media="all">
	html{ margin:0 0 0 0; width:100%; height:100%; overflow:hidden; background:#B4DAF5; text-align:center; }
	body{ margin:0 0 0 0; width:100%; height:100%; overflow:hidden; background:#E6F3FB; }
	a { width:100%; height:48px; display:block; border-radius:2px; margin:0; font-size:36px; line-height:48px; text-decoration:none; color:white; opacity:.75;  
	 font-family: "Arial Narrow", "Agency FB", "Swis721 LtCn BT"; font-weight:bold;
	 background:-moz-linear-gradient(top, rgba(0,120,192,.75), /*rgba(0,120,192,.5) 50%*/, rgba(0,108,172,.5));
	 background:-webkit-gradient(linear,0 100%,0 0, from(rgba(0,120,192,.75)) /*,color-stop(.5,  rgba(0,120,192,.5))*/, to(rgba(0,108,172,.5)));
	}
	a:focus { background-color:white; outline:invert thin solid; opacity:1; }
	a:active { background-color:black; }
	button { width:90%; height:32px; margin:4px 5% 4px 5%; }
	.space { width:100%; height:48px;}
	a: {}

	.frameHolder {width:100%; max-width: 100%; height:70%;}	

</style>

<meta name="viewport" content="width=600; user-scalable=0;" />

</head>

<body>
<div style="text-align:center; height:100%;">
	<b>Lovo Management Center Mobile</b>
	<small><div>Welcome <%=UserName%>!</div></small> <!-- -->
	<a href="../LMCManagement/CalendarMain.asp">Calendar</a>
	<div class=frameHolder>
		<iframe style="border:none; width:100%; height:100%;" src="/LMCManagement/CalendarMain.asp"></iframe>
	</div>
	<a href="Time.asp?EmpID=<%=EmpID%>">Time Entry</a>
	<a href="Inventory.asp?EmpID=<%=EmpID%>" disabled >Inventory</a>
	<!-- a href="JobPacking.asp?EmpID=<%=EmpID%>" disabled >Job Packing</a -->
	<br /><button id="Logout" onclick="logOut();">Logout</button><br />
</div>
</body>
</html>
