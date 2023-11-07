<!--#include file="../../TMC/RED.asp" -->

<%
Response.ContentType = "text/xml"

%>
<root>
	<action><%=Request.QueryString("action")%></action>
<%

Select Case CStr(Request.QueryString("action"))

	Case "ChangeHrs"
		ChangeHrs
		
	Case Else 
		 oops 
				
End Select		


%>
</root>
<%


Sub ChangeHrs  () '------------------------------------------------------------------------

	TimeID=Request.QueryString("TimeID")
	Hours=Request.QueryString("Hours")
	
	%><Hours><%=Hours%></Hours><%
	
		
	If Hours < 0 Then
		%><Error>-1</Error><%
	
	ElseIf Hours >= 24 Then
		%><Error>1</Error><%
	
	Else
		SQL="SELECT * FROM Time WHERE TimeID="&TimeID
		%><SQL><%=SQL%></SQL><%
		Set rs = Server.CreateObject("AdoDB.RecordSet")
		rs.Open SQL, REDConnString
		
		InH=rs("TimeInHr")
		InM=rs("TimeInMin")
		Set rs= Nothing
	%><InHr><%=InH%></InHr><%
	%><InMin><%=InM%></InMin><%
		
		Start=InH+(InM/60)
		
		Out=Start+Hours
		
		If Out >=24 Then Out= Out-24
		
		If Out <> Int(Out) Then	
			OutSplit=Split(CStr(Out),".")
			OutH=OutSplit(0)		
			OutM=CSng("."&OutSplit(1))*60
		Else
			OutH=Out
			OutM=0
		End If
		
		If OutH="" Then OutH=0
		If OutM="" Then OutM=0
		
		%>
		<Start><%=Start%></Start>
		<Out><%=Out%></Out>
		<OutH><%=OutH%></OutH>
		<OutM><%=OutM%></OutM>
		<%
		
		SQL1="UPDATE Time SET TimeOutHr="&OutH&", TimeOutMin="&OutM&" WHERE TimeID="&TimeID 
		%><SQL1><%=SQL1%></SQL1><%
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1, REDConnString
		
		
		%>
		<Error>0</Error>
		<%

	End If
	
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub oops ()'------------------------------------------------------------------------
	%>
	<Error>Missing: "action" routine!</Error>
	<%
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%>