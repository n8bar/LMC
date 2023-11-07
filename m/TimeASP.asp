
<!--#include file="RED.asp" -->




<%
Dim sAction 

sAction = CStr(Request.QueryString("action"))

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


	Case Else 
		 oops 
				
End Select		







Sub LoadEmployeeInfo  () '--------------------------------------------------------------------------------------------------------




	Dim XML
	Dim EmpID
	Dim EmpAddress
	Dim EmpPhone
	Dim EmpDCPhone
	Dim EmpEmail
	Dim EmpPos
	

	XML = ""	
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
		
		
	
		
		
	XML = ("<root>"&XML&"<EmpID>"&EmpID&"</EmpID><EmpPos>--"&EmpPos&"</EmpPos><EmpAddress>"&EmpAddress&"</EmpAddress><EmpFName>"&EmpFName&"</EmpFName><EmpLName>"&EmpLName&"</EmpLName>")
	XML = XML+("<EmpPhone>"&EmpPhone&"</EmpPhone><EmpDCPhone>"&EmpDCPhone&"</EmpDCPhone><EmpEmail>--"&EmpEmail&"</EmpEmail></root>")
		
		response.ContentType = "text/xml"
		response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub LoadEmployeeTime  () '--------------------------------------------------------------------------------------------------------

	Dim XML
	Dim EmpID
	Dim ColName
	Dim DESC_ASC
	Dim XMLtext
	Dim LoopNum	
	Dim EmpTimeListLength
	
	
	EmpID = CStr(Request.QueryString("EmpID"))
	XML = ""
	
	ColName = "Date"
	DESC_ASC = "DESC"



     	EmpTimeListLength = 0
		
			SQL = "SELECT * FROM Time Where EmpID = "&EmpID&" ORDER BY "&ColName&" "&DESC_ASC&", TimeInHr DESC, TimeInMin DESC"
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring

		LoopNum = 1	
		
		XMLtext = ""	
		
			Do While Not rs.EOF 
			
				XMLtext = XMLtext+"<EmpTimeID"&LoopNum&">"&rs("TimeID")&"</EmpTimeID"&LoopNum&">" 
				XMLtext = XMLtext+"<EmpTimeDate"&LoopNum&">"&rs("Date")&"</EmpTimeDate"&LoopNum&">" 
				XMLtext = XMLtext+"<EmpTimeInHr"&LoopNum&">"&rs("TimeInHr")&"</EmpTimeInHr"&LoopNum&">"
				XMLtext = XMLtext+"<EmpTimeInMin"&LoopNum&">"&rs("TimeInMin")&"</EmpTimeInMin"&LoopNum&">"
				XMLtext = XMLtext+"<EmpTimeOutHr"&LoopNum&">"&rs("TimeOutHr")&"</EmpTimeOutHr"&LoopNum&">"
				XMLtext = XMLtext+"<EmpTimeOutMin"&LoopNum&">"&rs("TimeOutMin")&"</EmpTimeOutMin"&LoopNum&">"
				XMLtext = XMLtext+"<EmpTimeDesc"&LoopNum&">--"&rs("Description")&"</EmpTimeDesc"&LoopNum&">"
				XMLtext = XMLtext+"<EmpTimeSup"&LoopNum&">--"&rs("Supervisor")&"</EmpTimeSup"&LoopNum&">"
				XMLtext = XMLtext+"<EmpTimeJobName"&LoopNum&">--"&rs("JobName")&"</EmpTimeJobName"&LoopNum&">"
				XMLtext = XMLtext+"<EmpTimeJobID"&LoopNum&">"&rs("JobID")&"</EmpTimeJobID"&LoopNum&">"
				XMLtext = XMLtext+"<EmpTimeJobPhase"&LoopNum&">--"&rs("JobPhase")&"</EmpTimeJobPhase"&LoopNum&">"
				XMLtext = XMLtext+"<EmpTimeJobType"&LoopNum&">--"&rs("JobType")&"</EmpTimeJobType"&LoopNum&">"
				XMLtext = XMLtext+"<EmpTimeArchStat"&LoopNum&">"&rs("Archived")&"</EmpTimeArchStat"&LoopNum&">"
				
			LoopNum = LoopNum + 1	
			EmpTimeListLength = EmpTimeListLength + 1      
			
			rs.MoveNext 
			Loop

	

    XML = ("<root>"&XMLtext&"<EmpTimeListLength>"&EmpTimeListLength&"</EmpTimeListLength><EmpID>"&EmpID&"</EmpID></root>")
	
		response.ContentType = "text/xml"
		response.Write(XML)
	
	
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
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		   
		
	XML = ("<root><Test>test</Test></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)		

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
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	set rs1 = nothing
	
		
    XML = ("<root><EmpID>"&EmpID&"</EmpID></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)		
									  
	

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub DeleteTimeEntry() '------------------------------------------------------------------------------------------------------

Dim EmpID
Dim XML

	TimeID = CStr(Request.QueryString("TimeID"))
	EmpID = CStr(Request.QueryString("EmpID"))
	
	SQL ="DELETE FROM Time WHERE TimeID = "&TimeID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
		
    XML = ("<root><EmpID>"&EmpID&"</EmpID></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)		
									  
	

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






Sub oops  () '--------------------------------------------------------------------------------------------------------


response.write "Oops Didn't Work"







End Sub '------------------------------------------------------------------------------------------------------------------------

%>