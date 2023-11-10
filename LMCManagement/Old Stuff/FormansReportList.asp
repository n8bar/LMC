<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Forman's Daily Reports</title>

<!--#include file="../../LMC/RED.asp" -->

<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script>
	function resize()
	{
		Gebi('List').style.height=(document.body.offsetHeight-Gebi('List').offsetTop-3)+'px';
	}
</script>
<style>
html,body{width:100%; height:100%; margin:0; padding:0; text-align:center; position:absolute; font-family:Verdana; font-size:15px; overflow:hidden; }

div,img,input,label,span,select,textarea,iframe{padding:0; margin:0; -webkit-box-sizing:border-box; -moz-box-sizing:border-box;}
input,select{border:#FFF 1px solid; border-bottom:#000 1px solid; background:none;}

button{font-size:22px; color:#555;}

.vPadding3{width:100%; height:3px;}


#Toolbar{position:absolute; top:112px; width:100%; height:32px; }

.Row{width:100%; height:18px; text-shadow:#FFF 1px 1px 1px,#FFF 1px -1px 1px,#FFF -1px 1px 1px,#FFF -1px -1px 1px;} 
.Row:hover{background-color:#FF9900;}
	.RowItem{border:1px solid #555; display:inline; margin:0; padding:0; float:left; overflow:hidden; height:100%; background:none;}
	.Edit{min-width:28px; width:4%;}
		.btnEdit{position:relative; left:5%; width:90%; height:16px; background:none; background:url(../../LMCDevelopment/images/Pencil_16.png) no-repeat center; border-width:1px; cursor:pointer;}
	.Date{min-width:64px; width:10%; font-size: 14px;}
	.Forman{min-width:192px; width:29%;}
	.Work{min-width:384px; width:50%;}
	.RepNo{min-width:48px; width:7%;}

</style>
</head>

<body onLoad="document.body.style.width='1px'; setTimeout('document.body.style.width=\'100%\';',10);">

<%
ProjID=Request.QueryString("ProjID")

SQL="Select * From Projects WHERE ProjID="&ProjID
Set rsProj=Server.CreateObject("ADODB.RecordSet")
rsProj.Open SQL, REDConnString

SQL="SELECT * FROM FormansReport WHERE ProjID="&ProjID&" ORDER BY Date"
Set rsFRep=Server.CreateObject("ADODB.RecordSet")
rsFRep.Open SQL, REDConnString


RowNum=0
Do Until rsFRep.EOF
	RowNum=RowNum+1
	
	FormanID=rsFRep("FormanID")
	
	If IsNull(FormanID) Or FormanID="" Or FormanID=0 Then 
		
		FormanName = "---NOT ENTERED---"
		
	Else
	
		SQL="SELECT * FROM Employees WHERE EmpID="&FormanID
		Set rsForman=Server.CreateObject("ADODB.RecordSet")
		rsForman.Open SQL, REDConnString
		
		FormanName=rsForman("FName")&" "&rsForman("LName")
		
		set rsForman=Nothing
		
	End If
	
	rID=rsFRep("ReportID")
%>
	<div id=Row<%=RowNum%> class="Row">
		<div id="Edit<%=RowNum%>" class="Edit RowItem"><button class="btnEdit" onClick="parent.window.location='formansdaily.asp?Report=<%=rID%>';"></button></div>
		<div id="Date<%=RowNum%>" class="Date RowItem"><%=rsFRep("Date")%></div>
		<div id="Forman<%=RowNum%>" class="Forman RowItem"><%=FormanName%></div>
		<div id="Work<%=RowNum%>" class="Work RowItem"><%=rsFRep("Report")%></div>
		<div id="RepNo<%=RowNum%>" class="RepNo RowItem"><%=rID%></div>
	</div>
<%
	rsFRep.MoveNext
Loop
%>
	<div id=Row<%=RowNum+1%> class="Row">&nbsp;</div>
</body>
</html>
