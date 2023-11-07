<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
//<!-- #include file="../TMC/RED.asp" -->
//<script> //I'm grateful I can get my IDE to play well with a javascript file that has a .asp extension
//I'm thinking its cool how we can deprecate AJAX for Asynchronous Javascript.
<%

partsID=Request.QueryString("partsID")
sysID=Request.QueryString("sysID")

SQL="SELECT Manufacturer, PartNumber, Description, LaborValue, Cost, Category1 FROM Parts WHERE PartsID="&partsID
Set rs=Server.CreateObject("AdoDB.RecordSet")
rs.Open SQL, REDConnString

If rs.EOF Then
	%>postMessage(false);<%
	Response.End()
End If

Mfr=rs("Manufacturer")
PN=rs("PartNumber")
Desc=rs("Description")
Labor=rs("LaborValue")
Cost=rs("Cost")
Category=rs("Category1")

CKey=CStr(SessionID)&CSTR(Timer)
SQL1="INSERT INTO BidItems (SysID,PartID,Manufacturer,ItemName,ItemDescription,LaborValue,Type,Cost,Category,ActualQty,editable,creationKey) "
SQL1 = SQL1 & " VALUES ( "&sysID&","&partsID&",'"&Mfr&"','"&PN&"','"&Desc&"',"&Labor&",'Part',"&Cost&",'"&Category&"',0,1,'"&CKey&"')"
%>
//<%=SQL1%>
<%
Set rs1=Server.CreateObject("AdoDB.RecordSet")
rs1.Open SQL1, REDConnString


SQL2="SELECT BidItemsID FROM BidItems WHERE creationKey='"&CKey&"'"
Set rs2=Server.CreateObject("AdoDB.RecordSet")
rs2.Open SQL2, REDConnString

BIId=rs2("BidItemsID")

Set rs=Nothing
Set rs1=Nothing
Set rs2=Nothing
%>	

var part=new Object;

part.SQL=['<%=Replace(SQL,"'","\'")%>','<%=Replace(SQL1,"'","\'")%>','<%=Replace(SQL2,"'","\'")%>'];

part.mfr='<%=Replace(DecodeChars(Mfr),"'","\'")%>';
part.pn='<%=Replace(DecodeChars(PN),"'","\'")%>';
part.desc='<%=Replace(DecodeChars(Desc),"'","\'")%>';
part.labor=<%=Labor%>;
part.cost=<%=Cost%>;
part.category='<%=Replace(DecodeChars(Category),"'","\'")%>';
part.biId=<%=BIId%>;
part.partsId=<%=partsID%>;

postMessage(part);
	
//</script>