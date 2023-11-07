
<!--#include file="../TMC/RED.asp" -->




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
		
	Case "GetSectionsList"
		GetSectionsList
	
	Case "Validate"
		Validate
	
	Case "LogOut"
		LogOut
	
	Case "LiveUpdater"
		LiveUpdater
						
	Case Else 
		 oops 
				
End Select		












Sub GetTasks  () '--------------------------------------------------------------------------------------------------------




	Dim XML
	Dim TaskLength
	Dim TaskNum
	
	
	
	TaskLength = 0

		
		SQL1 ="SELECT * FROM Tasks ORDER BY OrderNum"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
	
	XML = ""
		Do While Not rs1.EOF
		
			XML = XML+"  <TaskID"&rs1("TaskID")&">"&rs1("TaskID")&"</TaskID"&rs1("TaskID")&">    <TaskName"&rs1("TaskID")&">"&rs1("TaskName")&"</TaskName"&rs1("TaskID")&">"
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
		
			XML = XML+"  <TaskID"&TaskNum&">"&rs2("TaskID")&"</TaskID"&TaskNum&">    <TaskName"&TaskNum&">"&rs2("TaskName")&"</TaskName"&TaskNum&">"
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
		
	XML = ("<root>"&XMLtext&"<ProgressLength>--"&ProgressLength&"</ProgressLength></root>")
		
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
	'MOut = rs1("MOutTextColor")
	
	XMLtext = ""
	PriID=0
	Do Until rs1.EOF
		PriID=PriID+1
		XMLtext = XMLtext+"<PriID"&PriID&">"&PriID&"</PriID"&PriID&">" 
		XMLtext = XMLtext+"<BGColor"&PriID&">"&rs1("BGColor")&"</BGColor"&PriID&">"
		XMLtext = XMLtext+"<AltBGColor"&PriID&">"&rs1("AltBGColor")&"</AltBGColor"&PriID&">"
		XMLtext = XMLtext+"<BGText"&PriID&">"&rs1("BGText")&"</BGText"&PriID&">"
		XMLtext = XMLtext+"<Text"&PriID&">"&rs1("Text")&"</Text"&PriID&">"
		'XMLtext = XMLtext+"<MOTextColor"&PriID&">"&rs1("MOTextColor")&"</MOTextColor"&PriID&">"
		'XMLtext = XMLtext+"<MOutTextColor"&PriID&">"&MOut&"</MOutTextColor"&PriID&">"	
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
		
			FName = rs1("FName")
			LName = rs1("LName")
			Active = rs1("Active")
			Email = rs1("Email")
			
			If isNull(Active)  or  ( (isNull(Fname)or(FName="")) and (isNull(LName)or(LName="")) ) Then
			
			Else
				XMLtext = XMLtext+"<EmpID"&EmpNum&">"&rs1("EmpID")&"</EmpID"&EmpNum&">" 
				XMLtext = XMLtext+"<EmpFName"&EmpNum&">--"&FName&"</EmpFName"&EmpNum&">"
				XMLtext = XMLtext+"<EmpLName"&EmpNum&">--"&LName&"</EmpLName"&EmpNum&">"
				XMLtext = XMLtext+"<Active"&EmpNum&">--"&Active&"</Active"&EmpNum&">" 
				XMLtext = XMLtext+"<Email"&EmpNum&">--"&Email&"</Email"&EmpNum&">" 
						
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
			XMLtext = XMLtext+"<TaskName"&Num&">"&rs1("TaskName")&"</TaskName"&Num&">"
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
		
	SQL1 ="SELECT * FROM Projects ORDER BY Projname"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	ProjNum = 1

	XMLtext = ""
	Do While Not rs1.EOF
	
		XMLtext = XMLtext+"<ProjID"&ProjNum&">"&rs1("ProjID")&"</ProjID"&ProjNum&">" 
		XMLtext = XMLtext+"<ProjName"&ProjNum&">--"&rs1("ProjName")&"</ProjName"&ProjNum&">"
		XMLtext = XMLtext+"<Active"&ProjNum&">--"&rs1("Active")&"</Active"&ProjNum&">"
		XMLtext = XMLtext+"<Obtained"&ProjNum&">--"&rs1("Obtained")&"</Obtained"&ProjNum&">"
			
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

	
	SQL1 ="SELECT * FROM JobsLists WHERE Active = 'True' AND Type=3 order by Job"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	ServiceNum = 1

	XMLtext = ""
	Do While Not rs1.EOF
	
		XMLtext = XMLtext+"<ServiceID"&ServiceNum&">--"&rs1("NoteID")&"</ServiceID"&ServiceNum&">" 
		XMLtext = XMLtext+"<ServiceName"&ServiceNum&">--"&rs1("Job")&"</ServiceName"&ServiceNum&">"
				
		ServiceListLength = ServiceListLength + 1
		ServiceNum = ServiceNum + 1
		
	rs1.MoveNext
	Loop	

	
	
	
	XML = ("<root>"&XMLtext&"<ServiceListLength>--"&ServiceListLength&"</ServiceListLength></root>")
	
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

		
	SQL1 ="SELECT * FROM JobsLists WHERE Active = 'True' AND Type=4 ORDER BY Job"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	TestMaintNum = 1
	
	
	Do While Not rs1.EOF
	
		XMLtext = XMLtext+"<TestMaintID"&TestMaintNum&">--"&rs1("NoteID")&"</TestMaintID"&TestMaintNum&">" 
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

	
	
	
	






Sub GetSectionsList  () '--------------------------------------------------------------------------------------------------------

	Dim XML
	Dim ListLength
	Dim XMLtext
	Dim Num
	
	Length = 0

		SQL1 ="SELECT * FROM SectionList order by SectionName"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		Num = 1
	
	XMLtext = ""
		Do While Not rs1.EOF
		
			XMLtext = XMLtext+"<SectionID"&Num&">"&rs1("SectionID")&"</SectionID"&Num&">" 
			XMLtext = XMLtext+"<SectionName"&Num&">"&rs1("SectionName")&"</SectionName"&Num&">"
		    	
			Length = Length + 1
			Num = Num + 1
			
		rs1.MoveNext
		Loop	

		
		
		
	XML = ("<root>"&XMLtext&"<Length>--"&Length&"</Length></root>")
		
	response.ContentType = "text/xml"
	if request.QueryString("html")=1 Then response.ContentType="text/html"
	response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	
	
'---------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------
Sub Validate
	response.ContentType = "text/xml"
	if request.QueryString("html")=1 Then response.ContentType="text/html"
	
	%>
	<root>
	<qs><%=request.QueryString%></qs>
	<%
	
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
	Dim Email
	Dim FName
	Dim LName
	
	Dim DisabledTabs
	
	%><sc><%=Session.Contents.Count%></sc><%
	
	If Session.Contents.Count<=1Then
		Validated=0
		%><val>false</val><%
	Else
		Pass=Session("Pass")
		User=Session("User")
		'if (IsNull(Pass)) or (IsNull(User)) or Pass = "" or User = "" Then
		if (IsNull(User)) or User = "" Then
			Validated=0
			%><val>false</val><%
			%><user>NULL</user><%
		Else

			SQL1 ="SELECT * FROM Access WHERE UserName='"&User&"' OR Email='"&User&"@tricomlv.com'"' AND Password='"&Pass&"'"
			%><SQL1><%=SQL1%></SQL1><%
			%><REDconnstring><%=REDconnstring%></REDconnstring><%
			set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			XMLtext = ""
			If rs1.EOF Then
				Validated=0 'This shouldn't happen.
			Else
				Validated=1
				
				DisabledTabs=0
				
				Engineering=rs1("Engineering")
				If  Engineering <>"True" then
					Engineering ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<Engineering>--"&Engineering&"</Engineering>"%><%
				Session("AccessPlan")=Engineering
				
				Purchasing=rs1("Purchasing")
				If  Purchasing <>"True" then
					Purchasing ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<Purchasing>--"&Purchasing&"</Purchasing>"%><%
				Session("AccessOrder")=Purchasing
				
				DataEntry=rs1("DataEntry")
				If  DataEntry <>"True" then
					DataEntry ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<DataEntry>--"&DataEntry&"</DataEntry>"%><%
				Session("AccessData")=DataEntry
				
				Estimates=rs1("Estimates")
				If  Estimates <>"True" then
					Estimates ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<Estimates>--"&Estimates&"</Estimates>"%><%
				Session("AccessBid")=Estimates
				
				Inventory=rs1("Inventory")
				If  Inventory <>"True" then
					Inventory ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<Inventory>--"&Inventory&"</Inventory>"%><%
				Session("AccessShip")=Inventory
				
				Projects=rs1("Projects")
				If  Projects <>"True" then
					Projects ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<Projects>--"&Projects&"</Projects>"%><%
				Session("AccessProj")=Projects
				
				Training=rs1("Training")
				If  Training <>"True" then
					Training ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<Training>--"&Training&"</Training>"%><%
				Session("AccessTrain")=Training
				
				Service=rs1("Service")
				If  Service <>"True" then
					Service ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<Service>--"&Service&"</Service>"%><%
				Session("AccessServ")=Service
				
				Website=rs1("Website")
				If  Website <>"True" then
					Website ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<Website>--"&Website&"</Website>"%><%
				Session("AccessWeb")=Website
				
				Office=rs1("Office")
				If  Office <>"True" then
					Office ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<Office>--"&Office&"</Office>"%><%
				Session("AccessOffice")=Office
				
				Admin=rs1("Admin")
				If  Admin <>"True" then
					Admin ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<Admin>--"&Admin&"</Admin>"%><%
				Session("AccessAdmin")=Admin
				
				TestMaint=rs1("Test")
				If  TestMaint <>"True" then
					TestMaint ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<Test>--"&TestMaint&"</Test>"%><%
				Session("AccessTest")=TestMaint
				
				TimeEntry=rs1("Time")
				If  TimeEntry <>"True" then
					TimeEntry ="False"
					DisabledTabs=DisabledTabs+1
				End If
				%><%="<Time>--"&TimeEntry&"</Time>"%><%
				Session("AccessTime")=TimeEntry
				
				EmpID=rs1("EmpID")
				If  (IsNull(EmpID)) Or EmpID="" then EmpID =0
				%><%="<EmpID>--"&EmpID&"</EmpID>"%>
				
				%><%="<UserName>--"&User&"</UserName>"%><%
				
				SQL2="SELECT * FROM Employees WHERE EmpID="&EmpID
				set rs2=Server.CreateObject("ADODB.Recordset")
				rs2.Open SQL2, REDconnstring
				
				If rs2.EOF Then
					%><%="<FName>FName</FName>"%><%
					%><%="<LName>LName</LName>"%><%
					%><%="<Email>--Email</Email>"%><%
				Else
					%><%="<FName>"&rs2("FName")&"</FName>"%><%
					%><%="<LName>"&rs2("LName")&"</LName>"%><%
					%><%="<Email>--"&rs2("Email")&"</Email>"%><%
				End If
				
				Set rs2=Nothing
				
			End if
		End If
	End If

	'XML = ("<root><Validated>--"&Validated&"</Validated><DisabledTabs>"&DisabledTabs&"</DisabledTabs>"&Access&"</root>")
	%></root><%
		
	
	set rs1 = nothing

End Sub'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


'---------------------------------------------------------------------------------------------------
Sub LogOut
	
	Application("Goodbye")=Application("Goodbye")+1
	Application("visitors")=Application("visitors")-1
	Session.Abandon()
	
	XML = ("<root><logout>LogOut</logout></root>")
		
	response.ContentType = "text/xml"
	response.Write(XML)
End Sub'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sub LiveUpdater
	response.ContentType = "text/xml"
	%><root><%
	
	%><Visitors><%=Application("visitors")%></Visitors><%
	
	%></root><%
End Sub'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub oops  () '--------------------------------------------------------------------------------------
	response.write "<root>Oops Didn't Work</root>"
End Sub '-------------------------------------------------------------------------------------------

	
%>