<!--#include file="RED.asp" -->

<%
Dim sAction 

sAction = CStr(Request.QueryString("action"))

Select Case sAction
	Case "n8"
		n8

	Case Else
		TheEnd
End Select




Sub n8 '-------------------------------------------------------

	
	Dim XML

	Dim BidCount

	Dim CustID, CustName, ProjID, ProjName, HasTheJob
	
	XML = ""
	
	SQL = "SELECT * FROM BidTo WHERE ProjID="&CStr(Request.QueryString("ProjID"))
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	BidCount = 1
	Do While Not rs.EOF 
		
		CustID = rs("CustID") : if (IsNull(CustID)) or (CustID = "") then CustID = 0
		CustName = rs("CustName") : if (IsNull(CustName)) or (CustName = "") then CustName = "NULL"
		ProjID = rs("ProjID") : if (IsNull(ProjID)) or (ProjID = "") then CustID = 0
		ProjName = rs("ProjName") : if (IsNull(ProjName)) or (ProjName = "") then ProjName = "NULL"
		HasTheJob = rs("HasTheJob") : if (IsNull(HasTheJob)) or (HasTheJob = "") then HasTheJob = "NULL"
		
		XML = XML+"<CustID"&BidCount&">"&rs("CustID")&"</CustID"&BidCount&">"
		XML = XML+"<CustName"&BidCount&">"&rs("CustName")&"</CustName"&BidCount&">" 
		XML = XML+"<ProjID"&BidCount&">"&rs("ProjID")&"</ProjID"&BidCount&">" 
		XML = XML+"<ProjName"&BidCount&">"&rs("ProjName")&"</ProjName"&BidCount&">" 
		XML = XML+"<HasTheJob"&BidCount&">"&rs("HasTheJob")&"</HasTheJob"&BidCount&">" 
		BidCount = BidCount + 1	
		
		rs.MoveNext 
	Loop
	
	set rs = nothing
	
	
	XML = ("<root>"&XML&"<BidCount>"&BidCount&"</BidCount></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)
	




End Sub '-------------------------------------------------------



Sub TheEnd
End Sub

%>

