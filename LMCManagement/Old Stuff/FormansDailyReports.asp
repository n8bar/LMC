<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Forman's Daily Reports</title>

<!--#include file="../../LMC/RED.asp" -->

<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="../Library/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="FormansDailyReportsAJAX.js"></script>

<script>
	function resize()
	{
		Gebi('List').style.height=(document.body.offsetHeight-Gebi('List').offsetTop-3)+'px';
	}
	
	function ShowNewReportBox()
	{
		Gebi('Modal').style.display='block';
		Gebi('NewReportBox').style.display='block';
		Gebi('Create').disabled=true;
		Gebi('NewDate').value='';
	}
</script>
<style>
html{width:100%; height:100%; margin:0; padding:8px 0 0 0; text-align:center; background:White; overflow:hidden; }
body{width:100%; height:100%; margin:0; padding:0; text-align:center; position:absolute; font-family:Verdana; font-size:13px }

div,img,.textBox,label,span,select,textarea,iframe{padding:0; margin:0; -webkit-box-sizing:border-box; -moz-box-sizing:border-box; border-radius:2px; outline:none;}
.textBox,select{border:#FFF 1px solid; border-bottom:#000 1px solid; background:none; outline:none;}

h1{height:48px; margin:0;}
h4{height:28px; margin:0;}
h2{height:36px; margin:0;}

button{font-size:22px; color:#555;}

.vPadding3{width:100%; height:3px;}

#Modal{position:absolute; top:-8px; left:0; display:none; background:#444; filter:alpha(opacity=50); opacity:0.5; width:100%; height:100%; margin:0; z-index:5000;}

#NewReportBox{position:absolute; top:33%; left:33%; width:384px; height:192px; display:none; z-index:6000; border-radius:8px;	background:#FFF5EC;
	background-image:-webkit-gradient(linear, 0 0, 0 100%, from(#FFF5EC), /** /Color-Stop(.3, rgba(255,255,255,.5)),/**/ to(#FFE4CC));
	}
	#NewReportTitle{width:100%; height:24px; font-size:18px; border-top-right-radius:8px; border-top-left-radius:7px;
	background:#FF912D; background-image:-webkit-gradient(linear, 0 0, 0 100%, from(#FFC693), /** /Color-Stop(.3, rgba(255,255,255,.5)),/**/ to(#FF912D));
	}
	#lNewDate{margin:0; padding:0; height:16px;}
	#NewDate{border-radius:6px; -webkit-box-sizing:border-box; border:1px #000 solid; width:96px; height:100%; outline:none; background:none; margin:0; padding:0;}
	#NewDateImg{cursor:pointer; position:relative; top:2px;}
	#Create{display:inline; }
	#CancelNew{display:inline; }

#Back{position:absolute; top:7px; left:4px; font-size:14px;}

#Toolbar{position:absolute; top:112px; width:100%; height:32px; }

#Head{position:absolute; top:160px; width:80%; height:24px; margin-left:10%;}
	.HeadItem{border:1px solid #555; display:inline; margin:0; padding:0; float:left; overflow:hidden; height:100%;}
	#hEdit{min-width:28px; width:4%;}
	#hDate{min-width:64px; width:10%;}
	#hForman{min-width:192px; width:29%;}
	#hWork{min-width:384px; width:50%;}
	#hRepNo{min-width:48px; width:7%;}
#List{position:absolute; top:184px; width:80%; margin-left:10%;}
</style>

<link type="text/css" rel="stylesheet" href="../Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">

</head>

<body onLoad="resize();" onResize="resize();">
<button id=Back onClick="PGebi('ProjectsIframe').src='Projects.asp';">◄ Back 2 Projects</button>
<%
	'Dim rsProj
	
	

	ProjID=Request.QueryString("ProjID")
	
	SQL="SELECT * FROM Projects WHERE ProjID="&ProjID
	Set rsProj=Server.CreateObject("ADODB.Recordset")
	rsProj.Open SQL, REDconnstring
	
	ProjName=DecodeChars(rsProj("ProjName"))
	
	Set rsProj=Nothing
%>

<div id=Modal></div>

<div id=NewReportBox>
	<div id=NewReportTitle>New Report for: &nbsp; <small><small><%=ProjName%></small></small></div>
	<br/>
	<br/>
	<label id=lNewDate for=NewDate>Date:</label>
	<input id=NewDate onFocus="displayCalendar('NewDate','mm/dd/yyyy',NewDate);" onChange="if(this.value!=''){Gebi('Create').disabled=false; Gebi('Create').focus();}"/>
	
	<img id=NewDateImg onClick="displayCalendar('NewDate','mm/dd/yyyy',NewDate);" src="../../TMCDevelopment/Images/cal.gif">
	<br/>
	<br/>
	<br/>
	<br/>
	<button id=Create onClick="NewReport(Gebi('NewDate').value,<%=ProjID%>);">Create</button>
	<button id=CancelNew onClick="Gebi('Modal').style.display='none'; Gebi('NewReportBox').style.display='none';">Cancel</button>
</div>

<h1><big>Forman's Daily Reports</big></h1>
<h4>for</h4>
<h2><%=ProjName%></h2>

<div id=Toolbar align=Left>
	&nbsp; &nbsp;<button id=New onClick="ShowNewReportBox();"><div class="vPadding3"></div><img id=imgPlus src="../../TMCDevelopment/images/plus_16.png"/> New</button>
</div>

<div id=Head align=Center>
	<div id=hEdit class=HeadItem><div class="vPadding3"></div><small>Edit</small></div>
	<div id=hDate class=HeadItem><div class="vPadding3"></div>Date</div>
	<div id=hForman class=HeadItem><div class="vPadding3"></div>Forman</div>
	<div id=hWork class=HeadItem><div class="vPadding3"></div>Work Performed</div>
	<div id=hRepNo class=HeadItem><div class="vPadding3"></div><small>Report&nbsp;#</small></div>
</div>

<iframe frameborder="0" id=List src="FormansReportList.asp?ProjID=<%=ProjID%>"></iframe>

</body>

</html>