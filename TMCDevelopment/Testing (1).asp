<!--#include file="../TMC/RED.asp" -->
<html>
<body>
<%
If Request.QueryString("Update") <> 1 Then
	%>Add Update=1 to the QueryString to update the price list.<%
	Response.End
End If

plSQL = "SELECT * FROM Vigilant2011"
Set PriceList = Server.CreateObject("AdoDB.RecordSet")
PriceList.Open plSQL, REDConnString

Do Until PriceList.EOF
	
	PN=PriceList("PN")
	Desc=EncodeChars(PriceList("Description"))
	Price=PriceList("Price")
	
	partsSQL="SELECT PartsID, Manufacturer, PartNumber, Description, Cost FROM Parts WHERE PartNumber='"&PN&"' AND Manufacturer='GE'"
	Set Parts = Server.CreateObject("AdoDB.RecordSet")
	Parts.Open partsSQL, REDConnString

	If Parts.EOF Then 
	
		%><%=PN%><br/><%
		
		SQL="INSERT INTO Parts (Manufacturer, PartNumber, Description, Cost) VALUES ('GE', '"&PN&"', '"&Desc&"', "&Price&",)"
		Set newPart = Server.CreateObject("AdoDB.RecordSet")
		'newPart.Open SQL, REDConnString
	Else	
	
		Do Until Parts.EOF
			
			SQL="UPDATE Parts SET PartNumber='"&PN&"', Description='"&Desc&"', Cost="&Price&" WHERE PartsID="&Parts("PartsID")
			Set Part = Server.CreateObject("AdoDB.RecordSet")
			'Part.Open SQL, REDConnString
			
			Parts.MoveNext
		Loop
	
	End If
		
	PriceList.MoveNext
Loop

%>
</body>
</html>