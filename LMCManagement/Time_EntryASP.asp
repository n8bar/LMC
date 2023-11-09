<!--#include file="../LMC/RED.asp" -->
<%
response.ContentType = "text/xml"
if request.QueryString("html")=1 then response.ContentType="text/html"
%>
<root>

<%
Dim sAction 

sAction = CStr(Request.QueryString("action"))
%><action><%=sAction%></action><%

Select Case sAction

	Case "LoadEmployeeInfo"
		LoadEmployeeInfo
	
	Case "UpdateTime"
		UpdateTime		
		
	Case "LoadEmployeeTime"
		LoadEmployeeTime
		
	Case "SaveNewTime"
		SaveNewTime
		
	Case "DeleteTimeEntry"
		DeleteTimeEntry

	Case "populatePhases"
		populatePhases
		
		
		
	Case Else 
		 oops 
				
End Select		







Sub LoadEmployeeInfo  () '--------------------------------------------------------------------------------------------------------

	Dim EmpID
	Dim EmpAddress
	Dim EmpPhone
	Dim EmpDCPhone
	Dim EmpEmail
	Dim EmpPos
	

	EmpID = CStr(Request.QueryString("EmpID"))	
	
	
	SQL1 ="SELECT * FROM Employees Where EmpID = "&EmpID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring

	EmpAddress = rs1("Address")	:if (IsNull(EmpAddress))=true or EmpAddress="" then EmpAddress = "--"
	EmpPhone = rs1("Phone")			:if (IsNull(EmpPhone)) = true or EmpPhone = "" then EmpPhone = "--"
	EmpDCPhone = rs1("DCPhone")	:if (IsNull(EmpDCPhone))=true or EmpDCPhone="" then EmpDCPhone = "--"
	EmpEmail = rs1("Email")			:if (IsNull(Email))  =   true or Email   =  "" then Email = "--"
	EmpPos = rs1("Position")		:if (IsNull(Position)) = true or Position = "" then Position = "--"
	EmpFName = rs1("Fname")			:if (IsNull(Fname))  =   true or Fname   =  "" then Fname = "--"
	EmpLName = rs1("Lname")			:if (IsNull(Lname))  =   true or Lname   =  "" then Lname = "--"
		
		
	
		
		
	%>
	<EmpID><%=EmpID%></EmpID>
	<EmpPos>--<%=EmpPos%></EmpPos>
	<EmpAddress><%=EmpAddress%></EmpAddress>
	<EmpFName><%=EmpFName%></EmpFName>
	<EmpLName><%=EmpLName%></EmpLName>"
	<EmpPhone><%=EmpPhone%></EmpPhone>
	<EmpDCPhone><%=EmpDCPhone%></EmpDCPhone>
	<EmpEmail>--<%=EmpEmail%></EmpEmail>
	<%	
	set rs = nothing
	set rs1 = nothing

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub LoadEmployeeTime  () '--------------------------------------------------------------------------------------------------------

	Dim EmpID
	Dim ColName
	Dim DESC_ASC
	Dim LoopNum	
	Dim EmpTimeListLength
	
	Locked=""
	EmpID = CStr(Request.QueryString("EmpID"))
	if Request.QueryString("showLocked")=0 Then	Locked="AND Archived='False'"
	ColName = "Date"
	DESC_ASC = "DESC"
	
	EmpTimeListLength = 0
		
	SQL = "SELECT * FROM Time Where EmpID = "&EmpID&" "&Locked&" ORDER BY "&ColName&" "&DESC_ASC&", TimeInHr DESC, TimeInMin DESC"
	%><SQL><%=SQL%></SQL><%
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	LoopNum = 1	
	
	Do While Not rs.EOF 		
		Archived=rs("Archived")
		If Archived = "" Or (IsNull(Archived)) Then Archived="False"
		
		Supervisor = rs("Supervisor")
		If Supervisor = "" Then Supervisor=EmpID
		
		%><%="<EmpTimeSup"&LoopNum&">"%>--<%=Supervisor%><%="</EmpTimeSup"&LoopNum&">"%><%
		SQL0="SELECT FName, LName, Wage FROM Employees WHERE EmpID=0"&SuperVisor
		Set rs0 = Server.CreateObject("AdoDB.RecordSet")
		rs0.Open SQL0, REDConnString
		If rs0.EOF Then
			SuperName= "&lt;b&gt;NONE&lt;/&gt;"
		Else
			SuperName = rs0("FName")&" "&rs0("LName")
		End If
		
		Wage=rs("Wage")
		
		Set rs0 = Nothing
		SQL0="SELECT FName, LName, Wage FROM Employees WHERE EmpID=0"&EmpID
		Set rs0 = Server.CreateObject("AdoDB.RecordSet")
		rs0.Open SQL0, REDConnString
		If Not rs0.EOF Then
			%><%="<EmpFileWage"&LoopNum&">"%>0<%=rs0("Wage")%><%="</EmpFileWage"&LoopNum&">"%><%
			If rs("Wage") = 0 Then Wage=rs0("Wage")
		End If
		Set rs0 = Nothing
		
		
		
		%>
		<EmpTimeID<%=LoopNum%>><%=rs("TimeID")&"</EmpTimeID"&LoopNum&">"%>
		<EmpTimeDate<%=LoopNum%>><%=rs("Date")&"</EmpTimeDate"&LoopNum&">"%>
		<EmpTimeInHr<%=LoopNum%>><%=rs("TimeInHr")&"</EmpTimeInHr"&LoopNum&">"%>
		<EmpTimeInMin<%=LoopNum%>><%=rs("TimeInMin")&"</EmpTimeInMin"&LoopNum&">"%>
		<EmpTimeOutHr<%=LoopNum%>><%=rs("TimeOutHr")&"</EmpTimeOutHr"&LoopNum&">"%>
		<EmpTimeOutMin<%=LoopNum%>><%=rs("TimeOutMin")&"</EmpTimeOutMin"&LoopNum&">"%>
		<EmpTimeDesc<%=LoopNum%>>--<%=rs("Description")&"</EmpTimeDesc"&LoopNum&">"%>
		<EmpTimeSup<%=LoopNum%>>--<%=rs("Supervisor")&"</EmpTimeSup"&LoopNum&">"%>
		<EmpTimeWage<%=LoopNum%>>0<%=Wage&"</EmpTimeWage"&LoopNum&">"%>
		<SuperName<%=LoopNum%>>--<%=SuperName&"</SuperName"&LoopNum&">"%>
		<EmpTimeJobName<%=LoopNum%>>--<%=rs("JobName")&"</EmpTimeJobName"&LoopNum&">"%>
		<EmpTimeJobID<%=LoopNum%>><%=rs("JobID")&"</EmpTimeJobID"&LoopNum&">"%>
		<EmpTimeJobPhase<%=LoopNum%>>--<%=rs("JobPhase")&"</EmpTimeJobPhase"&LoopNum&">"%>
		<EmpTimeJobType<%=LoopNum%>>--<%=rs("JobType")&"</EmpTimeJobType"&LoopNum&">"%>
		<EmpTimeArchStat<%=LoopNum%>>--<%=Archived&"</EmpTimeArchStat"&LoopNum&">"%>
		<%
		LoopNum = LoopNum + 1	
		EmpTimeListLength = EmpTimeListLength + 1      
		
		rs.MoveNext 
	Loop
	
	'SQL1="SELECT Time FROM Access WHERE EmpID="&Session("EmpId")
	'% ><SQL1><%=SQL1% ></SQL1><%
	'Set rs1= Server.CreateObject("adoDb.RecordSet")
	'rs1.open SQL1, RedConnString
	'If rs1.eof then
	'  AccessTime="False"
  'Else
	'  AccessTime=rs1("Time")
	'End If
	
	'<AccessTime><%=AccessTime% ></AccessTime>
	%>
	<EmpTimeListLength><%=EmpTimeListLength%></EmpTimeListLength>
	<EmpID><%=EmpID%></EmpID>

	<%	
	set rs = nothing
	set dbconn=nothing

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Sub UpdateTime() '------------------------------------------------------------------------------------------------------

	Dim TimeID
	Dim EditDate
	Dim InHr
	Dim InMin
	Dim OutHr
	Dim OutMin
	Dim Desc
	Dim ProjID
	Dim ProjName
	Dim SupID
	Dim JobPhase
	Dim JobType
	Dim XML

	TimeID = CStr(Request.QueryString("TimeID"))
	EditDate = CStr(Request.QueryString("EditDate"))
	InHr = CStr(Request.QueryString("TimeInHr"))
	InMin = CStr(Request.QueryString("TimeInMin"))
	OutHr = CStr(Request.QueryString("TimeOutHr"))
	OutMin = CStr(Request.QueryString("TimeOutMin"))
	Desc = CStr(Request.QueryString("EditTimeDesc"))
	SupID = CStr(Request.QueryString("SupID"))
	ProjID = CStr(Request.QueryString("ProjID"))
	ProjName = CStr(Request.QueryString("ProjName"))
	JobPhase = CStr(Request.QueryString("JobPhase"))
	JobType = CStr(Request.QueryString("JobType"))
	
	EditTimeDesc = Replace(EditTimeDesc, ",", " ")
	EditTimeDesc = Replace(EditTimeDesc, "'", " ")
	EditTimeDesc = Replace(EditTimeDesc, "+", " ")
	EditTimeDesc = Replace(EditTimeDesc, "&", " ")


	SQL = "UPDATE Time SET Date='"&EditDate&"', TimeInHr='"&InHr&"', TimeInMin='"&InMin&"', TimeOutHr='"&OutHr&"', TimeOutMin ='"&OutMin&"', Description='"&Desc
	SQL=SQL&"',Supervisor='"&SupID&"', JobID='"&ProjID&"', JobName='"&ProjName&"', JobPhase='"&JobPhase&"', JobType='"&JobType&"' WHERE TimeID="&TimeID
	%><SQL><%=SQL%></SQL><%
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		   
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	

Sub SaveNewTime() '------------------------------------------------------------------------------------------------------

	Dim EmpID
	Dim JobID
	Dim TimeDate
	Dim TimeInHr
	Dim TimeInMin
	Dim TimeOutHr
	Dim TimeOutMin
	Dim TimeDesc
	Dim SupID
	Dim JobPhase
	Dim JobType
	Dim JobName
	Dim XML

	EmpID = CStr(Request.QueryString("EmpID"))
	JobID = CStr(Request.QueryString("ProjectID"))
	TimeDate = CStr(Request.QueryString("TimeEntryDate"))
	TimeInHr = CStr(Request.QueryString("TimeInHr"))
	TimeInMin = CStr(Request.QueryString("TimeInMin"))
	TimeOutHr = CStr(Request.QueryString("TimeOutHr"))
	TimeOutMin = CStr(Request.QueryString("TimeOutMin"))
	TimeDesc = CStr(Request.QueryString("TimeDesc"))
	SupID = CStr(Request.QueryString("SupID"))
	JobPhase = CStr(Request.QueryString("JobPhase"))
	JobType = CStr(Request.QueryString("JobType"))
	JobName = CStr(Request.QueryString("ProjectName"))

	TimeDesc = Replace(TimeDesc, ",", " ")
	TimeDesc = Replace(TimeDesc, "'", " ")
	TimeDesc = Replace(TimeDesc, "+", " ")
	TimeDesc = Replace(TimeDesc, "&", " ")
	
	
	SQL ="Insert into Time (EmpID,Date,TimeInHr,TimeInMin,TimeOutHr,TimeOutMin,Description,Supervisor,JobName,JobId,JobPhase,JobType,Archived)"
	SQL=SQL+("VALUES ('"&EmpID&"','"&TimeDate&"','"&TimeInHr&"','"&TimeInMin&"',"&TimeOutHr&","&TimeOutMin&",'"&TimeDesc&"','"&SupID&"','"&JobName&"','"&JobID&"','"&JobPhase&"','"&JobType&"',0)")
	%><SQL><%=SQL%></SQL><%
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	set rs1 = nothing
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub DeleteTimeEntry() '------------------------------------------------------------------------------------------------------

	Dim EmpID
	Dim XML

	TimeID = CStr(Request.QueryString("TimeID"))
	EmpID = CStr(Request.QueryString("EmpID"))
	
	SQL ="DELETE FROM Time WHERE TimeID = "&TimeID
	%><SQL><%=SQL%></SQL><%
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub populatePhases() '------------------------------------------------------------------------------------------------------
	
	projID=Request.QueryString("ProjID")
	
	SQL="SELECT SystemID FROM Systems WHERE ProjectID="&projID
	%><SQL><%=SQL%></SQL><%
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.Open SQL,RedConnString	
	
	Dim phases(1024)
	pI=-1
		
	Do Until rs.EOF
		sysID=rs("SystemID")
	
		SQL1="SELECT ItemName FROM BidItems WHERE SysID="&sysID&" AND type='labor'"
		%><SQL1><%=SQL1%></SQL1><%
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1,RedConnString	
		
		Do Until rs1.EOF
			noMatch=true
			thisPhase=uCase(rs1("ItemName"))
			If pI>-1 Then
				For p=0 to pI
					if phases(p) = thisPhase Then
						noMatch=false
						Exit For
					End If
				Next
			Else
				noMatch=True
			End If
			
			If noMatch Then 
				pI=pI+1
				phases(pI)=thisPhase
				%><%="<phase"&pI&">"&thisPhase&"</phase"&pI&">"%><%
			End If
			
			rs1.MoveNext
		Loop
		
		rs.MoveNext
	Loop
	
	%><phaseCount><%=pI+1%></phaseCount><%
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub oops() '--------------------------------------------------------------------------------------------------------
	%><oops>Action <%=sAction%> not found.</oops><%
End Sub '------------------------------------------------------------------------------------------------------------------------

%>
</root>