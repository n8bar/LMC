<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Forman's Daily Reports</title>

<!--#include file="../../TMC/RED.asp" -->

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
.Row:hover{background-color:#0FF;}
	.RowItem{border:1px solid #555; display:inline; margin:0; padding:0; float:left; overflow:hidden; height:100%; background:none;}
	.Del{width:3%;}
	.btnEdit{width:3%; background:none; border-width:1px; cursor:pointer; background:url(../images/Pencil_16.png) no-repeat center;}
	.Date{width:10%; font-size: 14px;}
	.Vendor{width:27%;}
	.PONum{width:50%;}
	.POID{width:7%;}

</style>
</head>

<body onLoad="document.body.style.width='1px'; setTimeout('document.body.style.width=\'100%\';',10);">

<%
ProjID=Request.QueryString("ProjID")

SQL="Select * From Projects WHERE ProjID="&ProjID
Set rsProj=Server.CreateObject("ADODB.RecordSet")
rsProj.Open SQL, REDConnString

SQL="SELECT * FROM PurchaseOrders WHERE ProjID="&ProjID&" ORDER BY Date"
Set rsPO=Server.CreateObject("ADODB.RecordSet")
rsPO.Open SQL, REDConnString


RowNum=0
Do Until rsPO.EOF
	RowNum=RowNum+1
	
	PONum=rsPO("PONum")
	
	VendorID=rsPO("VendorID")
	If VendorID="" OR (IsNull(VendorID)) Then VendorID=801
	'% >VendorID: "<%=VendorID% >"<%
	
	
	SQL="SELECT * FROM Customers WHERE CustID="&VendorID
	Set rsVendor=Server.CreateObject("ADODB.RecordSet")
	rsVendor.Open SQL, REDConnString
	
	If rsVendor.EOF Then
		VendorName="&lt;Unknown Vendor>"
	Else
		VendorName=rsVendor("Name")
	End If
		
	set rsVendor=Nothing
	
	POID=rsPO("POID")
%>
	<div id=Row<%=RowNum%> class="Row">
		<span id="Chk<%=RowNum%>" class="Del RowItem"><input id="Del<%=POID%>-<%=VendorID%>" type="checkbox" class="chkSel" /></span>
		<button id="Edit<%=RowNum%>" class="btnEdit RowItem" onClick="parent.window.location='PO.asp?POID=<%=POID%>';"></button>
		<span id="Date<%=RowNum%>" class="Date RowItem"><%=rsPO("Date")%></span>
		<span id="Vendor<%=RowNum%>" class="Vendor RowItem"><%=VendorName%></span>
		<span id="PONum<%=RowNum%>" class="PONum RowItem"><%=rsPO("PONum")%></span>
		<span id="POID<%=RowNum%>" class="POID RowItem"><%=POID%></span>
	</div>
<%
	rsPO.MoveNext
Loop
%>
	<div id=Row<%=RowNum+1%> class="Row">&nbsp;</div>
</body>
</html>
