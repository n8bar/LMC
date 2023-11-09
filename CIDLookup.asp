<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="LMC/RED.asp"-->
<%
response.ContentType="text/html"
num=request.QueryString("num")

SQL="SELECT Name FROM Contacts WHERE Phone1 LIKE '%"&num&"%' OR Phone2 LIKE '%"&num&"%' OR CPhone1 LIKE '%"&num&"%' OR CPhone2 LIKE '%"&num&"%' OR Fax LIKE '%"&num&"%'"
Set rs=Server.CreateObject("AdoDB.RecordSet")
rs.Open SQL, REDConnString

If Not rs.EOF Then result=rs("Name") Else result="["&num&"]"
Set rs=Nothing

Application("cidLookupLastCallerName")=result
Application("cidLookupLastCallerNumber")=Num
Application("cidLookupLastCallerTime")=Date&" "&Time

%><%=uCase(result)%>
