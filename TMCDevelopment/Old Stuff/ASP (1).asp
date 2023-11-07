<!--#include file="../../TMC/RED.asp" -->


<%

'SQL="Update Projects WHERE Area IS NULL Set Area='[Unknown]'"
'set rs=Server.CreateObject("ADODB.Recordset")
'rs.Open SQL, REDconnstring

'set rs = nothing

response.ContentType = "text/xml"
response.Write("<root><SQL>"&SQL&"</SQL><RecordLength>"&Counter&"</RecordLength></root>")		
%>