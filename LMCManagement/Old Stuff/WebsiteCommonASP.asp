
<!--#include file="../../LMC/RED.asp" -->




<%
Dim sAction 

sAction = CStr(Request.QueryString("action"))

Select Case sAction

	Case "GetTasks"
		GetTasks
		
	Case "GetProgList"	
		GetProgList
		
	Case "GetPriList"	
		GetPriList
		
	Case "ProgressSelect"	
		ProgressSelect
	
	Case "GetEmployeeList"	
		GetEmployeeList	
	
	Case "GetAreaList"
		GetAreaList
		
	Case "GetSchemes"
		GetSchemes

	Case "GetActiveProjectList"
		GetActiveProjectList
		
	Case "GetActiveServiceList"
		GetActiveServiceList

	Case "GetActiveTestMaintList"
		GetActiveTestMaintList

	Case "GetFranchiseList"
		GetFranchiseList
		
	Case "GetSystemsList"
		GetSystemsList
	
	Case "Validate"
		Validate
	
	Case "LogOut"
		LogOut
		
						
	Case Else 
		 oops 
				
End Select		












Sub GetTasks  () '--------------------------------------------------------------------------------------------------------




	Dim XML
	Dim TaskLength
	Dim TaskNum
	
	
	
	TaskLength = 0

		
		SQL1 ="SELECT * FROM Tasks"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
	
	XML = ""
		Do While Not rs1.EOF
		
			XML = XML+"  <TaskID"&rs1("TaskID")&">"&rs1("TaskID")&"</TaskID"&rs1("TaskID")&">    <TaskName"&rs1("TaskID")&">"&rs1("AltName")&"</TaskName"&rs1("TaskID")&">"
		    XML = XML+"  <BgColor"&rs1("TaskID")&">"&rs1("BgColor")&"</BgColor"&rs1("TaskID")&">   <TextColor"&rs1("TaskID")&">"&rs1("TextColor")&"</TextColor"&rs1("TaskID")&">"
			XML = XML+"  <Link"&rs1("TaskID")&">"&rs1("Link")&"</Link"&rs1("TaskID")&">"	
			TaskLength = TaskLength + 1
			
		rs1.MoveNext
		Loop	





		

	TaskNum = 100
	
		SQL2 ="SELECT * FROM Tasks order by OrderNum"
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring


		Do While Not rs2.EOF
		
			XML = XML+"  <TaskID"&TaskNum&">"&rs2("TaskID")&"</TaskID"&TaskNum&">    <TaskName"&TaskNum&">"&rs2("AltName")&"</TaskName"&TaskNum&">"
		    XML = XML+"  <BgColor"&TaskNum&">"&rs2("BgColor")&"</BgColor"&TaskNum&">   <TextColor"&TaskNum&">"&rs2("TextColor")&"</TextColor"&TaskNum&">"
			XML = XML+"  <Link"&TaskNum&">"&rs2("Link")&"</Link"&TaskNum&">"	
			TaskNum = TaskNum + 1
			
		rs2.MoveNext
		Loop
		
		
		
				
		
	XML = ("<root>"&XML&"<TaskLength>"&TaskLength&"</TaskLength></root>")
		
		response.ContentType = "text/xml"
		response.Write(XML)
	
	set rs1 = nothing
	set rs2 = nothing





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub GetProgList  () '--------------------------------------------------------------------------------------------------------

	Dim XML
	Dim ProgressLength
	Dim XMLtext
	
	ProgressLength = 0

	Dim MOut
		
	SQL1 ="SELECT * FROM Progress"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	MOut = rs1("MOutTextColor")
	
	XMLtext = ""
		Do While Not rs1.EOF
		
			XMLtext = XMLtext+"<ProgID"&rs1("ProgID")&">"&rs1("ProgID")&"</ProgID"&rs1("ProgID")&">" 
			XMLtext = XMLtext+"<BGColor"&rs1("ProgID")&">"&rs1("BGColor")&"</BGColor"&rs1("ProgID")&">"
			XMLtext = XMLtext+"<AltBGColor"&rs1("ProgID")&">"&rs1("AltBGColor")&"</AltBGColor"&rs1("ProgID")&">"
			XMLtext = XMLtext+"<BGText"&rs1("ProgID")&">"&rs1("BGText")&"</BGText"&rs1("ProgID")&">"
			XMLtext = XMLtext+"<Text"&rs1("ProgID")&">"&rs1("Text")&"</Text"&rs1("ProgID")&">"
			XMLtext = XMLtext+"<MOTextColor"&rs1("ProgID")&">"&rs1("MOTextColor")&"</MOTextColor"&rs1("ProgID")&">"
			XMLtext = XMLtext+"<MOutTextColor"&rs1("ProgID")&">"&MOut&"</MOutTextColor"&rs1("ProgID")&">"	
			ProgressLength = ProgressLength + 1
			
		rs1.MoveNext
		Loop	
		
	XML = ("<root>"&XMLtext&"<ProgressLength>"&ProgressLength&"</ProgressLength></root>")
		
		response.ContentType = "text/xml"
		response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






Sub GetPriList  () '--------------------------------------------------------------------------------------------------------

	Dim XML
	Dim PriorityLength
	Dim XMLtext
	
	PriorityLength = 0
	
	Dim PriID
	Dim MOut
		
	SQL1 ="SELECT * FROM Priority"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring

	PriID = rs1("PriID")
	MOut = rs1("MOutTextColor")
	
	XMLtext = ""
	PriID=0
	Do Until rs1.EOF
		PriID=PriID+1
		XMLtext = XMLtext+"<PriID"&PriID&">"&PriID&"</PriID"&PriID&">" 
		XMLtext = XMLtext+"<BGColor"&PriID&">"&rs1("BGColor")&"</BGColor"&PriID&">"
		XMLtext = XMLtext+"<AltBGColor"&PriID&">"&rs1("AltBGColor")&"</AltBGColor"&PriID&">"
		XMLtext = XMLtext+"<BGText"&PriID&">"&rs1("BGText")&"</BGText"&PriID&">"
		XMLtext = XMLtext+"<Text"&PriID&">"&rs1("Text")&"</Text"&PriID&">"
		XMLtext = XMLtext+"<MOTextColor"&PriID&">"&rs1("MOTextColor")&"</MOTextColor"&PriID&">"
		XMLtext = XMLtext+"<MOutTextColor"&PriID&">"&MOut&"</MOutTextColor"&PriID&">"	
		PriorityLength = PriorityLength + 1
		
		rs1.MoveNext
	Loop	
	
	XML = ("<root>"&XMLtext&"<PriorityLength>"&PriorityLength&"</PriorityLength></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~













Sub GetEmployeeList  () '--------------------------------------------------------------------------------------------------------




	Dim XML
	Dim EmpListLength
	Dim XMLtext
	Dim EmpNum
	Dim FName
	Dim LName
	Dim Active
	
	EmpListLength = 0

		
		SQL1 ="SELECT * FROM Employees order by Fname"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		EmpNum = 1
	
	XMLtext = ""
		Do While Not rs1.EOF
		
			Active = rs1("Active")
			FName = rs1("FName")
			LName = rs1("LName")
			
			If isNull(Active)  or  ( (isNull(Fname)or(FName="")) and (isNull(LName)or(LName="")) ) Then
			
			Else
				XMLtext = XMLtext+"<Active"&EmpNum&">--"&Active&"</Active"&EmpNum&">" 
				XMLtext = XMLtext+"<EmpID"&EmpNum&">"&rs1("EmpID")&"</EmpID"&EmpNum&">" 
				XMLtext = XMLtext+"<EmpFName"&EmpNum&">--"&FName&"</EmpFName"&EmpNum&">"
				XMLtext = XMLtext+"<EmpLName"&EmpNum&">--"&LName&"</EmpLName"&EmpNum&">"
						
				EmpListLength = EmpListLength + 1
				EmpNum = EmpNum + 1
			End If
			
		rs1.MoveNext
		Loop	

		
		
		
	XML = ("<root>"&XMLtext&"<EmpListLength>"&EmpListLength&"</EmpListLength></root>")
		
		response.ContentType = "text/xml"
		response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		










Sub GetAreaList  () '--------------------------------------------------------------------------------------------------------



Dim XML
Dim XML_Events
Dim dbconn
Dim ArrCount


XML_Events = ""
ArrCount = 1
     
			SQL = "SELECT * FROM Area order by AreaDescription"
			set rs=Server.CreateObject("ADODB.Recordset")
			set dbconn = server.createobject("adodb.connection")
			dbconn.open REDconnstring
			rs.Open SQL, dbconn
			
			Do While Not rs.EOF 
			
			    XML_Events = XML_Events+"<AreaID"&ArrCount&">"&rs("AreaID")&"</AreaID"&ArrCount&">"
				XML_Events = XML_Events+"<AreaDescription"&ArrCount&">"&rs("AreaDescription")&"</AreaDescription"&ArrCount&">" 
				
			ArrCount = ArrCount + 1	
			       
			rs.MoveNext 
			Loop
			
			
			
			set rs = nothing
			set dbconn=nothing


	

    XML = ("<root>"&XML_Events&"<ArrCount>"&ArrCount&"</ArrCount></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)
			
			
			
			

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub GetSchemes  () '--------------------------------------------------------------------------------------------------------




	Dim XML
	Dim EmpListLength
	Dim XMLtext
	Dim Num
	Dim Length
	
	Length = 0

		
		SQL1 ="SELECT * FROM Schemes order by SchemeNum"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		Num = 1
	
	XMLtext = ""
		Do While Not rs1.EOF
		
			XMLtext = XMLtext+"<SchemeNum"&Num&">"&rs1("SchemeNum")&"</SchemeNum"&Num&">" 
			XMLtext = XMLtext+"<TaskName"&Num&">"&rs1("AltName")&"</TaskName"&Num&">"
			XMLtext = XMLtext+"<ColorMain"&Num&">"&rs1("ColorMain")&"</ColorMain"&Num&">"
			XMLtext = XMLtext+"<ColorBG1"&Num&">"&rs1("ColorBG1")&"</ColorBG1"&Num&">" 
			XMLtext = XMLtext+"<ColorBG2"&Num&">"&rs1("ColorBG2")&"</ColorBG2"&Num&">"
			XMLtext = XMLtext+"<ColorTabOn"&Num&">"&rs1("ColorTabOn")&"</ColorTabOn"&Num&">"
			XMLtext = XMLtext+"<ColorTabOff"&Num&">"&rs1("ColorTabOff")&"</ColorTabOff"&Num&">" 
			XMLtext = XMLtext+"<ColorLinks"&Num&">"&rs1("ColorLinks")&"</ColorLinks"&Num&">"
			XMLtext = XMLtext+"<ColorLinksHover"&Num&">"&rs1("ColorLinksHover")&"</ColorLinksHover"&Num&">"
			XMLtext = XMLtext+"<ColorTxtHead1"&Num&">"&rs1("ColorTxtHead1")&"</ColorTxtHead1"&Num&">"
			XMLtext = XMLtext+"<ColorTxtHead2"&Num&">"&rs1("ColorTxtHead2")&"</ColorTxtHead2"&Num&">"
			XMLtext = XMLtext+"<ColorTxtTabOn"&Num&">"&rs1("ColorTxtTabOn")&"</ColorTxtTabOn"&Num&">"
			XMLtext = XMLtext+"<ColorTextTabOff"&Num&">"&rs1("ColorTextTabOff")&"</ColorTextTabOff"&Num&">"
		    	
			Length = Length + 1
			Num = Num + 1
			
		rs1.MoveNext
		Loop	

		
		
		
	XML = ("<root>"&XMLtext&"<Length>"&Length&"</Length></root>")
		
		response.ContentType = "text/xml"
		response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub GetActiveProjectList  () '--------------------------------------------------------------------------------------------------------

	Dim XML
	Dim ProjListLength
	Dim XMLtext
	Dim ProjNum
	
	ProjListLength = 0
		
	SQL1 ="SELECT * FROM Projects WHERE Active = 1 order by Projname"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	ProjNum = 1

	XMLtext = ""
	Do While Not rs1.EOF
	
		XMLtext = XMLtext+"<ProjID"&ProjNum&">"&rs1("ProjID")&"</ProjID"&ProjNum&">" 
		XMLtext = XMLtext+"<ProjName"&ProjNum&">--"&rs1("ProjName")&"</ProjName"&ProjNum&">"
			
		ProjListLength = ProjListLength + 1
		ProjNum = ProjNum + 1
		
		rs1.MoveNext
	Loop	
		
	XML = ("<root>"&XMLtext&"<ProjListLength>"&ProjListLength&"</ProjListLength></root>")
		
	response.ContentType = "text/xml"
	response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub GetActiveServiceList() '--------------------------------------------------------------------------------------------------------


	Dim XML
	Dim ServiceListLength
	Dim XMLtext
	Dim ServiceNum
	
	ServiceListLength = 0

		
		SQL1 ="SELECT * FROM Service WHERE Active = 'True' order by Job"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		ServiceNum = 1
	
	XMLtext = ""
		Do While Not rs1.EOF
		
			XMLtext = XMLtext+"<ServiceID"&ServiceNum&">--"&rs1("ServiceID")&"</ServiceID"&ServiceNum&">" 
			XMLtext = XMLtext+"<ServiceName"&ServiceNum&">--"&rs1("Job")&"</ServiceName"&ServiceNum&">"
		    	
			ServiceListLength = ServiceListLength + 1
			ServiceNum = ServiceNum + 1
			
		rs1.MoveNext
		Loop	

		
		
		
	XML = ("<root>"&XMLtext&"<ServiceListLength>"&ServiceListLength&"</ServiceListLength></root>")
		
		response.ContentType = "text/xml"
		response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub GetActiveTestMaintList() '--------------------------------------------------------------------------------------------------------

	Dim XML
	Dim TestMaintListLength
	Dim XMLtext : XMLtext = ""
	Dim TestMaintNum
	
	TestMaintListLength = 0

		
	SQL1 ="SELECT * FROM TestMaint WHERE Active = 'True' order by Job"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	TestMaintNum = 1
	
	
	Do While Not rs1.EOF
	
		XMLtext = XMLtext+"<TestMaintID"&TestMaintNum&">--"&rs1("TestMaintID")&"</TestMaintID"&TestMaintNum&">" 
		XMLtext = XMLtext+"<TestMaintName"&TestMaintNum&">--"&rs1("Job")&"</TestMaintName"&TestMaintNum&">"
				
		TestMaintListLength = TestMaintListLength + 1
		TestMaintNum = TestMaintNum + 1
		
	rs1.MoveNext
	Loop	

		
	XML = ("<root>"&XMLtext&"<TestMaintListLength>"&TestMaintListLength&"</TestMaintListLength></root>")
		
	response.ContentType = "text/xml"
	response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub GetFranchiseList  () '--------------------------------------------------------------------------------------------------------

	Dim XML
	Dim ListLength
	Dim XMLtext
	Dim Num
	
	Length = 0

		
		SQL1 ="SELECT * FROM Franchise order by FranchiseName"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		Num = 1
	
	XMLtext = ""
		Do While Not rs1.EOF
		
			XMLtext = XMLtext+"<FranchiseID"&Num&">"&rs1("FranchiseID")&"</FranchiseID"&Num&">" 
			XMLtext = XMLtext+"<FranchiseName"&Num&">"&rs1("FranchiseName")&"</FranchiseName"&Num&">"
			XMLtext = XMLtext+"<FranchiseParent"&Num&">"&rs1("FranchiseParent")&"</FranchiseParent"&Num&">"
		    	
			Length = Length + 1
			Num = Num + 1
			
		rs1.MoveNext
		Loop	

		
		
		
	XML = ("<root>"&XMLtext&"<Length>"&Length&"</Length></root>")
		
		response.ContentType = "text/xml"
		response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	
	
	
	






Sub GetSystemsList  () '--------------------------------------------------------------------------------------------------------




	Dim XML
	Dim ListLength
	Dim XMLtext
	Dim Num
	
	Length = 0

		
		SQL1 ="SELECT * FROM SystemList order by SystemName"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		Num = 1
	
	XMLtext = ""
		Do While Not rs1.EOF
		
			XMLtext = XMLtext+"<SystemID"&Num&">"&rs1("SystemID")&"</SystemID"&Num&">" 
			XMLtext = XMLtext+"<SystemName"&Num&">"&rs1("SystemName")&"</SystemName"&Num&">"
		    	
			Length = Length + 1
			Num = Num + 1
			
		rs1.MoveNext
		Loop	

		
		
		
	XML = ("<root>"&XMLtext&"<Length>"&Length&"</Length></root>")
		
	response.ContentType = "text/xml"
	response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	
	
'---------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------
Sub Validate
	
	Dim Validated
	
	Dim Pass
	Dim User
	
	Dim DataEntry
	Dim Estimates
	Dim Projects
	Dim Service
	Dim TestMaint
	Dim Engineering
	Dim Purchasing
	dim TimeEntry
	Dim Office
	Dim Inventory
	Dim Training
	Dim Website
	Dim Admin
	Dim EmpID
	
	Dim XML
	Dim Access:Access=""
	
	If Session.Contents.Count<=1Then
		Validated=0
	Else
		Pass=Session("Pass")
		User=Session("User")
		if (IsNull(Pass)) or (IsNull(User)) or Pass = "" or User = "" Then
			Validated=0
		Else

			SQL1 ="SELECT * FROM Access WHERE Password='"&Pass&"' AND UserName='"&User&"'"
			set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			XMLtext = ""
			If rs1.EOF Then
				Validated=0 'This shouldn't happen.
			Else
				Validated=1
				
				Engineering=rs1("Engineering"):If Engineering <>"True" then Engineering ="False"
				Access=Access&"<Engineering>--"&Engineering&"</Engineering>"
				
				Purchasing=rs1("Purchasing"):If Purchasing <>"True" then Purchasing ="False"
				Access=Access&"<Purchasing>--"&Purchasing&"</Purchasing>"
				
				DataEntry=rs1("DataEntry"):if DataEntry <>"True" then DataEntry ="False"
				Access=Access&"<DataEntry>--"&DataEntry&"</DataEntry>"
				
				Estimates=rs1("Estimates"):if Estimates <>"True" then Estimates ="False"
				Access=Access&"<Estimates>--"&Estimates&"</Estimates>"
				
				Inventory=rs1("Inventory"):if Inventory <>"True" then Inventory ="False"
				Access=Access&"<Inventory>--"&Inventory&"</Inventory>"
				
				Projects=rs1("Projects"):if Projects <>"True" then Projects ="False"
				Access=Access&"<Projects>--"&Projects&"</Projects>"
				
				Training=rs1("Training"):if Training <>"True" then Training ="False"
				Access=Access&"<Training>--"&Training&"</Training>"
				
				Service=rs1("Service"):if Service <>"True" then Service ="False"
				Access=Access&"<Service>--"&Service&"</Service>"
				
				Website=rs1("Website"):if Website <>"True" then Website ="False"
				Access=Access&"<Website>--"&Website&"</Website>"
				
				Office=rs1("Office"):if Office <>"True" then Office ="False"
				Access=Access&"<Office>--"&Office&"</Office>"
				
				Admin=rs1("Admin"):if Admin <>"True" then Admin ="False"
				Access=Access&"<Admin>--"&Admin&"</Admin>"
				
				TestMaint=rs1("Test"):if TestMaint <>"True" then TestMaint ="False"
				Access=Access&"<Test>--"&TestMaint&"</Test>"
				
				TimeEntry=rs1("Time"):if TimeEntry <>"True" then TimeEntry ="False"
				Access=Access&"<Time>--"&TimeEntry&"</Time>"
				
				EmpID=rs1("EmpID"):if (IsNull(EmpID)) Or EmpID="" then EmpID =0
				Access=Access&"<EmpID>--"&EmpID&"</EmpID>"
				
				Access=Access&"<UserName>--"&User&"</UserName>"
				
			End if
		End If
	End If

	XML = ("<root><Validated>--"&Validated&"</Validated>"&Access&"</root>")
		
	response.ContentType = "text/xml"
	response.Write(XML)
	
	set rs1 = nothing

End Sub'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


'---------------------------------------------------------------------------------------------------
Sub LogOut
	Session.Contents.RemoveAll()

	XML = ("<root><Logout>LogOut</LogOut></root>")
		
	response.ContentType = "text/xml"
	response.Write(XML)
End Sub'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub oops  () '--------------------------------------------------------------------------------------------------------
	response.write "<root>Oops Didn't Work</root>"
End Sub '------------------------------------------------------------------------------------------------------------------------

	
%>