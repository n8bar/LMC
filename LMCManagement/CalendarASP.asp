
<!--#include file="../LMC/RED.asp" -->
<% 
Response.ContentType="text/xml" 
If Request.QueryString("html")=1 Then Response.ContentType="text/html" 
%>


<root>
<%
sAction = CStr(Request.QueryString("action"))
%><action><%=sAction%></action><%

Select Case sAction

	Case "Events"
		Events
		
	Case "DeleteEvent"
		DeleteEvent
		
	Case "GetEvent"
		GetEvent
		
	Case "NewEventSingle"
		NewEventSingle
	
	Case "CalendarEvents"
		CalendarEvents
		
	Case "DayEvents"
		DayEvents
	
	Case "UpdateDragDrop"
		UpdateDragDrop	
	
	Case "populateExistingContacts"	
		PopulateExistingContacts
	
	Case "UseAsCust"
		UseAsCust
	
	Case "insertNewCustomer"
		insertNewCustomer
	
	Case "ShowEventNotes"
		ShowEventNotes
	
					
	Case Else 
		 oops 
				
End Select		


















Sub Events () '--------------------------------------------------------------------------------------------------------

	sSource = Request.QueryString("Source")
	Title = Request.QueryString("Title")
	DateFrom = Request.QueryString("DateFrom")
	DateTo = Request.QueryString("DateTo")
	'Repeat = Request.QueryString("Repeat")
	'RepeatVal = Request.QueryString("RepeatVal")
	Notes = Request.QueryString("Notes")
	DoneCheck = Request.QueryString("DoneCheck")
	Attn = Request.QueryString("Attn")
	AttnVal = Request.QueryString("AttnVal")
	Task = Request.QueryString("Task")
	TaskVal = Request.QueryString("TaskVal")
	Bill = Replace(Replace(Request.QueryString("BillCheck"),"false","0"),"true","1")
	Billed = Replace(Replace(Request.QueryString("BilledCheck"),"false","0"),"true","1")
	Job = "0"
	JobID = Request.QueryString("JobID")
	Super = Request.QueryString("Super")
	SuperVal = Request.QueryString("SuperVal")
	Area = Request.QueryString("Area")
	AreaVal = Request.QueryString("AreaVal")
	Phase = Request.QueryString("Phase")
	PhaseVal = Request.QueryString("PhaseVal")
	Customer = Request.QueryString("Customer")
	CustomerVal = Request.QueryString("CustomerVal")
	CrewNames = Request.QueryString("CrewNames")
	ActionType = CStr(Request.QueryString("Type"))
	EventID = CStr(Request.QueryString("EventID"))
	
	
	Title=EncodeChars(Title)
	
	Notes=EncodeChars(Notes)
	
	if (ActionType = "NewEvent") then
	
		SQL ="Insert into Calendar (Title,DateFrom,DateTo,Note,Attention,AttentionID,Task,TaskID,Billable,Billed,JobID,Super,SuperID,Area,AreaID,Phase,PhaseID,Customer,CustomerID,CrewNames,Done) VALUES ('"&Title&"','"&DateFrom&"','"&DateTo&"','"&Notes&"','"&Attn&"',"&AttnVal&",'"&Task&"',"&TaskVal&",'"&Bill&"','"&Billed&"',"&JobID&",'"&Super&"',"&SuperVal&",'"&Area&"','"&AreaVal&"','"&Phase&"',"&PhaseVal&",'"&Customer&"',"&CustomerVal&",'"&CrewNames&"', '"&DoneCheck&"')"
		set rs=Server.CreateObject("ADODB.Recordset")
		%><sql><%=SQL%></sql><%
		rs.Open SQL, REDconnstring
		set rs = nothing
	
	end if
	
	if (ActionType = "UpdateEvent") then
	
		SQL="UPDATE Calendar SET"
		SQL=SQL&" Title ='"&Title&"',"
		SQL=SQL&" DateFrom ='"&DateFrom&"',"
		SQL=SQL&" DateTo ='"&DateTo&"',"
		'SQL=SQL&" Repeat ='"&Repeat&"',"
		'SQL=SQL&" RepeatID ="&RepeatVal&","
		SQL=SQL&" Note ='"&Notes&"',"
		SQL=SQL&" Attention ='"&Attention&"',"
		SQL=SQL&" AttentionID ="&AttnVal&","
		SQL=SQL&" Task ='"&Task&"',"
		SQL=SQL&" TaskID ="&TaskVal&", "
		'SQL=SQL&" Job ='"&Job&"',"
		'SQL=SQL&" JobID ="&JobVal&","
		'SQL=SQL&" Super ='"&Super&"' "
		'SQL=SQL&" SuperID ="&SuperVal&", " 
		'SQL=SQL&" Area ='"&Area&"',"
		'SQL=SQL&" AreaID ="&AreaVal&","
		SQL=SQL&" Phase ='"&Phase&"',"
		SQL=SQL&" PhaseID =0"&PhaseVal&","
		SQL=SQL&" Customer ='"&Customer&"',"
		SQL=SQL&" CustomerID ="&CustomerVal&","
		SQL=SQL&" Done = '"&DoneCheck&"',"
		SQL=SQL&" Billable = '"&Bill&"',"
		SQL=SQL&" Billed = '"&Billed&"'"
		SQL=SQL&" WHERE CalID = "&EventID
		set rs=Server.CreateObject("ADODB.Recordset")
		%><br/><sql><%=SQL%></sql><%
		rs.Open SQL, REDconnstring
		set rs = nothing
	
	end if

	
	XML = XML&"</root>"
		
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub DeleteEvent  () '--------------------------------------------------------------------------------------------------------
	EventID = CStr(Request.QueryString("EventID"))
	
	SQL ="DELETE FROM Calendar WHERE CalID = "&EventID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	XML = ("<EventID>"&EventID&"</EventID><Source></Source>")
	XML = ("<root>"&XML&"</root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub NewEventSingle  () '--------------------------------------------------------------------------------------------------------
	sDate = Request.Form("Date")
	sEvent = Request.Form("Event")
	sAttn = CStr(Request.QueryString("EmpName"))
	sAttnID = Request.Form("Employee")
	sNotes = Request.Form("Notes")
	sDay = Request.Form("Day")

	sEvent=EncodeChars(sEvent)

	sNotes=EncodeChars(sNotes)

	SQL ="Insert into Calendar (DateFrom,DateTo,Job,IDnum,Event,Note,Attention,AttentionID) VALUES ('"&sDate&"','"&sDate&"','Note','1','"&sEvent&"','"&sNotes&"','"&sAttn&"',"&sAttnID&")"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	Color = "#FFFF66"

	XML = "<Event>&lt;div Class=""DayEvent"" style=""background:"&Color&";""&gt;"&sEvent&"&lt;/div&gt;</Event><Date>"&sDate&"</Date>"
	XML = "<root>"&XML&"</root>"
	
	response.ContentType = "text/xml"
	response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub GetEvent() '--------------------------------------------------------------------------------------------------------

	EventID = CStr(Request.QueryString("EventID"))
	TaskLength = 0
	
	F="TaskEventID, TaskEventTable, Title, DateFrom, DateTo, RepeatID, Note, AttentionID, TaskID, JobID, AreaID, PhaseID, CustomerID, CrewNames, Done, Billable, Billed"
	SQL ="SELECT "&F&" FROM Calendar WHERE CalID = "&EventID 
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	If rs.EOF Then
		response.Write("<TaskEventTable>--</TaskEventTable>")
		response.Write("<TaskEventID>--</TaskEventID>")
		
		response.Write("<Title>DELETED OR MISSING</Title>")
		response.Write("<DateFrom>--</DateFrom>")
		response.Write("<DateTo>--</DateTo>")
		response.Write("<RepeatID>--</RepeatID>")
		response.Write("<Note>ERROR &amp;nbsp; EVENT IS MISSING CALID:"&EventID&"</Note>")
		response.Write("<AttentionID>0</AttentionID>")
		response.Write("<TaskID>0</TaskID>")
		response.Write("<JobID>0</JobID>")
		response.Write("<AreaID>0</AreaID>")
		response.Write("<PhaseID>0</PhaseID>")
		response.Write("<CustomerID>0</CustomerID>")
		response.Write("<CrewNames>--</CrewNames>")
		response.Write("<DoneCheck>1</DoneCheck>")
		response.Write("<BillCheck>1</BillCheck>")
		response.Write("<BilledCheck>1</BilledCheck>")
		response.Write("</root>")
		response.End()
	End If
	
	tName=rs("TaskEventTable")
	
	SQL1 ="SELECT TaskID, TaskName, BgColor, TextColor FROM Tasks"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring

	XML = ""
	Do While Not rs1.EOF
	
		XML=XML&"<TaskName"&rs1("TaskID")&">"&rs1("TaskName")&"</TaskName"&rs1("TaskID")&"><BgColor"&rs1("TaskID")&">"&rs1("BgColor")&"</BgColor"&rs1("TaskID")&"><TextColor"&rs1("TaskID")&">"&rs1("TextColor")&"</TextColor"&rs1("TaskID")&">"	
		TaskLength = TaskLength + 1
		
		rs1.MoveNext
	Loop	
	
	If tName = "" Or (IsNull(tName)) Then
	Else
		SQL2="SELECT TableKey FROM TableKeys WHERE TableName='"&rs("TaskEventTable")&"'"
		Set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
		
		SQL3="SELECT "&rs2("TableKey")&" FROM "&rs("TaskEventTable")&" WHERE "&rs2("TableKey")&"="&rs("TaskEventID")
		Set rs3=Server.CreateObject("ADODB.Recordset")
		rs3.Open SQL3, REDconnstring
		
		If rs3.EOF Then
		Else
			Dim AreaID
			AreaID=67
			'AreaID=rs3("AreaID")
			Dim PhaseID
		End If
		
		Set rs2=Nothing
		Set rs3=Nothing
	End If
	
	XML=XML&"<TaskEventTable>"&rs("TaskEventTable")&"</TaskEventTable>"
	XML=XML&"<TaskEventID>"&rs("TaskEventID")&"</TaskEventID>"
	
	XML=XML&"<Title>--"&EncodeChars(rs("Title"))&"</Title>"
	XML=XML&"<DateFrom>"&rs("DateFrom")&"</DateFrom>"
	XML=XML&"<DateTo>"&rs("DateTo")&"</DateTo>"
	XML=XML&"<RepeatID>--"&rs("RepeatID")&"</RepeatID>"
	XML=XML&"<Note>--"&EncodeChars(rs("Note"))&"</Note>"
	XML=XML&"<AttentionID>--"&rs("AttentionID")&"</AttentionID>"
	XML=XML&"<TaskID>--"&rs("TaskID")&"</TaskID>"
	XML=XML&"<JobID>0"&rs("JobID")&"</JobID>"
	'XML=XML&"<SuperID>--"&rs("SuperID")&"</SuperID>"
	XML=XML&"<AreaID>--"&rs("AreaID")&"</AreaID>"
	XML=XML&"<PhaseID>--"&rs("PhaseID")&"</PhaseID>"
	XML=XML&"<CustomerID>--"&rs("CustomerID")&"</CustomerID>"
	XML=XML&"<CrewNames>--"&rs("CrewNames")&"</CrewNames>"
	XML=XML&"<DoneCheck>--"&rs("Done")&"</DoneCheck>"
	XML=XML&"<BillCheck>--"&rs("Billable")&"</BillCheck>"
	XML=XML&"<BilledCheck>--"&rs("Billed")&"</BilledCheck>"
		
	XML = "<root>"&XML&"<TaskLength>"&TaskLength&"</TaskLength></root>"
	
	response.Write(XML)

	set rs = nothing
	set rs1 = nothing
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub CalendarEvents  () '---------------------------------------------------------------------------------------------------
	
	CSS = CStr(Request.QueryString("CSS"))
	sSource = CStr(Request.QueryString("Source"))
	QuickViewID = CStr(Request.QueryString("QuickViewID"))
	ViewAttn = CStr(Request.QueryString("ViewAttn"))
	ViewTask = CStr(Request.QueryString("ViewTask"))
	ViewPM = CStr(Request.QueryString("ViewPM"))
	ViewArea = CStr(Request.QueryString("ViewArea"))
	ViewPhase = CStr(Request.QueryString("ViewPhase"))
	ViewCustomer = CStr(Request.QueryString("ViewCustomer"))
	EventCountMax=CInt(Request.QueryString("EventCountMax"))
	IE=CInt(Request.QueryString("IE"))
	
	Dates = CStr(Request.QueryString("Array"))
	%><Dates><%=Dates%></Dates><%
	DateArray = Split(Dates,",")
	
	If uBound(DateArray) AND sSource="Day" > 1 Then
		DateArray=Array(Dates,Dates)
	End If
	%><ArrayLength><%=ubound(DateArray)%></ArrayLength><%
	
	DateCount = 1
	
	EvHTML = ""
	EvHTML2 = ""
	XML_EventList = ""
	XML_EventList2 = ""
	
	' Create an array of css properies based on Task
	FormatNum = 1
	SQL = "SELECT * from Tasks "
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	dim BgArray(100)
	dim TxtColorArray(100)
	dim TxtSizeArray(100)
	dim TxtWeightArray(100)
	dim BorderColorArray(100)
	dim HeightArray(100)
	TaskLength = 1			
	
	Do While Not rs.EOF
		BgArray(FormatNum) = rs("BgColor")
		TxtColorArray(FormatNum) = rs("TextColor")
		TxtSizeArray(FormatNum) = rs("TextPX")
		TxtWeightArray(FormatNum) = rs("TextWeight")
		BorderColorArray(FormatNum) = rs("BorderColor")
		HeightArray(FormatNum) = rs("Height")
		FormatNum = FormatNum + 1
		TaskLength = TaskLength + 1
		
		rs.MoveNext
	Loop
	
	set rs = nothing
	
	
	' Create an array of css properies based on Task, Alternate Style
	FormatNum = 1
	SQL = "SELECT * from Tasks "
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	dim AltBgArray(100)
	dim AltTxtColorArray(100)
	
	TaskLength = 1			
	
	Do While Not rs.EOF
		AltBgArray(FormatNum) = rs("AltBgColor")
		AltTxtColorArray(FormatNum) = rs("AltTextColor")
		FormatNum = FormatNum + 1
		TaskLength = TaskLength + 1
	
		rs.MoveNext
	Loop
	
	set rs = nothing			
				
				
	Quickview = " "
	DetailedView = " "
	
	if not QuickViewID = "" then Quickview = " and TaskID = "&QuickViewID&" "      end if
	if not ViewAttn = "0"   then DetailedView = DetailedView +" and AttentionID="&ViewAttn&" " end if
	if not ViewTask = "0"   then DetailedView = DetailedView + " and TaskID = "&ViewTask&" " end if
	if not ViewPM = "0"     then DetailedView = DetailedView + " and SuperID = "&ViewPM&" " end if
	if not ViewArea = "0"   then DetailedView = DetailedView + " and AreaID = "&ViewArea&" " end if
	if not ViewPhase ="0"   then DetailedView = DetailedView + " and PhaseID = "&ViewPhase&" " end if
	if not ViewCustomer="0" then DetailedView = DetailedView +" and CustomerID="&ViewCustomer&" " end if
	
	DateCount=0
	Do 'For DateCount = 1 to ubound(DateArray) 
		DateCount=DateCount+1

		If sSource = "Day" Then 
			thisDate=replace(Dates,",","")
		Else
			If DateArray(DateCount)="" And DateCount>1 Then
				''This is a workaround for some of the dates not coming thru from the request.
				'prevDate=DateArray(DateCount-1)
				'mdy=split(prevDate,"/")
				'DateArray(DateCount)=mdy(0)&"/"&(mdy(1)+0)&"/"&mdy(2)
			End If 
			thisDate=DateArray(DateCount)
		End If
		
		
		Response.Write("<Event"&DateCount&">--"&EvHTML&"</Event"&DateCount&">")
		Response.Write("<DateID"&DateCount&">"&thisDate&"</DateID"&DateCount&">")
		
		SQL1 = "SELECT CalID, TaskID, Title, Done, AttentionID, Personal, DateFrom, DateTo FROM Calendar WHERE DateFrom <='"&thisDate&"' and DateTo >='"&thisDate&"'  "&Quickview&"   "&DetailedView&"  ORDER BY Done, TaskID, CalID"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
	
		EventCount = 0 
		Do While Not rs1.EOF
			
			AttnID=rs1("AttentionID")
			If AttnID= "" Then AttnID=0
			Do While rs1("Personal")="True" And AttnID<>Session("EmpID")
				rs1.MoveNext
				If rs1.EOF Then Exit Do
			Loop
			If rs1.EOF Then Exit Do
			
			EventCount = EventCount + 1
			
			Task = rs1("TaskID")
			Done = rs1("Done")
			
			For x = 1 to TaskLength ' This sets up the CSS for each Event added to the Calendar
				
				If Task = x Then
					
					If Done = True then 
						BgColor = "#"&AltBgArray(x) 
						Bg = "#"&AltBgArray(x) 
						TextColor = "#"&AltTxtColorArray(x)
						TextShadow=""
					End If
					
					TextD=""
					opacity=""
					If Done = False then 
						TextD="text-decoration:line-through;"
						opacity="opacity:0.5;"
						TextColor = "#"&TxtColorArray(x)
						Bg="#"&BgArray(x)
						'Bg=" -webkit-gradient(linear, left bottom, left top, color-stop(0,#"&BgArray(x)&"), color-stop(.5,#FFF), color-stop(1,#"&AltBgArray(x)&"));"
						'TextShadow="text-shadow: -0px -0px 3px #fff;"
						'TextShadow="text-shadow:-1px -1px 1px #"&AltBgArray(x)&", -1px 1px 1px #"&AltBgArray(x)&", 1px -1px 1px #"&AltBgArray(x)&", 1px 1px 1px #"&AltBgArray(x)&" ;"
						TxtWt="0"
						TextD=""
						
						If IE>=7 Then
							'Bg="-webkit-gradient(linear, left bottom, left top, color-stop(0,#"&BgArray(x)&"), color-stop(.5,#FFF), color-stop(1,#"&AltBgArray(x)&")) ;"
							Bg="#"&BgArray(x)
							TextColor="#"&TxtColorArray(x)
						End If
					End if
					
					TextPx = TxtSizeArray(x)&"px"
					LineH = (TxtSizeArray(x)+3)&"px"
					TextWeight = "Bold"'TxtWeightArray(x)
					BorderColor = "#"&BorderColorArray(x)
					BoxHeight = HeightArray(x)&"px"
				End If 
			Next
			
			EvWidth=100
			'This rounds the start and end of an event!
			If CDate(thisDate)<=cDate(rs1("DateFrom")) Then 
				BrL=" border-top-left-radius:16px; border-bottom-left-radius:16px; padding-left:3px; margin-left:.75%; "
				EvWidth=EvWidth-2
			Else 
				BrL=" border-top-left-radius:0; border-bottom-left-radius:0; "
			End If
			
			If CDate(thisDate)>=CDate(rs1("DateTo")) Then 
				BrR=" border-top-right-radius:16px; border-bottom-right-radius:16px;" 
				EvWidth=EvWidth-1
			Else
				BrR=" border-top-right-radius:0; border-bottom-right-radius:0;"
			End If
			
			TxtWt=TextWeight
			BoxHt=BoxHeight
			Bkg=BgColor
			
			Bg=Replace(lCase(bg),"#ffffff","rgba(255,255,255,.7)")
			
			EvStyle="overflow:hidden; background:"&Bg&"; color:"&TextColor&"; "&BrR&BrL
			EvStyle=EvStyle&" font-size:"&TextPx&"; line-height:"&LineH&"; "'font-weight:"&TxtWt&"; "&TextD&" "&opacity&" "&TextShadow
			EvStyle=EvStyle&" min-height:"&BoxHt&"; height:"&BoxHt&"; width:"&EvWidth&"%; border-bottom:1px solid "&TextColor&";"'&TxtWt&";"
			
			Response.Write("<CalID"&DateCount&"-"&EventCount&">"&rs1("CalID")&"</CalID"&DateCount&"-"&EventCount&">")
			Response.Write("<TaskID"&DateCount&"-"&EventCount&">"&rs1("TaskID")&"</TaskID"&DateCount&"-"&EventCount&">")
			Response.Write("<Title"&DateCount&"-"&EventCount&">"&rs1("Title")&"</Title"&DateCount&"-"&EventCount&">")
			Response.Write("<AttentionID"&DateCount&"-"&EventCount&">"&rs1("AttentionID")&"</AttentionID"&DateCount&"-"&EventCount&">")
			Personal=0 : If rs1("Personal")="True" Then Personal=1
			Response.Write("<Personal"&DateCount&"-"&EventCount&">"&Personal&"</Personal"&DateCount&"-"&EventCount&">")
			
			Response.Write("<CSS"&DateCount&"-"&EventCount&">"&CSS&"</CSS"&DateCount&"-"&EventCount&">")
			Response.Write("<EvStyle"&DateCount&"-"&EventCount&">"&EvStyle&"</EvStyle"&DateCount&"-"&EventCount&">")
			
			rs1.MoveNext
		Loop
		
		
		Set rs1 = nothing
	
		Do While InStr(EvHTML,"<")>0 And InStr(EvHTML,">")>0
			EvHTML=Replace(Replace(EvHTML,"<","&lt;"),">","&gt;")
		Loop
		
		Response.Write("<EventCount"&DateCount&">0"&EventCount&"</EventCount"&DateCount&">")
		
		EvHTML = ""
	Loop Until DateCount >= uBound(DateArray) 'Next
	
	%>
	<TaskLength><%=TaskLength%></TaskLength>
	<%
	Response.Write("")

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






Sub UpdateDragDrop  () '--------------------------------------------------------------------------------------------------------
	DropedDate = CStr(Request.QueryString("DropedDate"))
	EventID = CStr(Request.QueryString("EventID"))
	
	Refresh = 0
	
	SQL1 = "select * from Calendar where CalID = "&EventID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	DateFrom = rs1("DateFrom")
	DateTo = rs1("DateTo")
	
	
	Months = (DateDiff("m",Date,"12/31/2002") & "<br />")
	Days = (DateDiff("d",DateFrom,DateTo))
	Seconds =(DateDiff("n",Date,"12/31/2002"))
	DateToNew = DateAdd("d", Days, DropedDate)
	
	if Days > 0 then Refresh = 1 end if
	
	SQL = "UPDATE Calendar SET DateFrom ='"&DropedDate&"' , DateTo ='"&DateToNew&"' WHERE CalID = "&EventID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing	
	
	
	
	%>
	<Refresh><%=Refresh%></Refresh>
	<EventID><%=DropedDate%></EventID>
	<DropedDate><%=DateToNew%></DropedDate>
	<%


End Sub '------------------------------------------------------------------------------------------------------------------------




Sub PopulateExistingContacts '-------------------------------------------------------------------------------------------------
	   Dim searchText
	   searchText = CStr(Request.QueryString("searchText"))
	   
	   Dim ConactID
	   Dim ContactName
	   
	   SQL1="SELECT ID, Name, Phone1, Email FROM Contacts WHERE Customer=0 AND Name like '%"&searchText&"%' ORDER BY Name"
	   set rs1=Server.CreateObject("ADODB.Recordset")
	   	%><SQL><%=SQL1%></SQL><%
	rs1.Open SQL1, REDconnstring
	rC=0
	If rs1.EOF Then
		Error="Error reading Contact ID "&ContactID
	Else
	   	Do Until rs1.EOF
	   		rC=rC+1
	   		
			ConactID = rs1("ID")
			ContactName=rs1("Name")
			If(IsNull(ContactName))Or ContactName="" Then ContactName="[No Name]"

			%>
			<%="<ID"&rC&">0"&rs1("ID")&"</ID"&rC&">"%>
			<%="<Name"&rC&">--"&ContactName&"</Name"&rC&">"%>
			<%="<Phone"&rC&">--"&Phone(rs1("Phone1"))&"</Phone"&rC&">"%>
			<%="<Email"&rC&">--"&rs1("Email")&"</Email"&rC&">"%>
			<%
	   		rs1.MoveNext
	   	Loop
		Set rs1 = Nothing
	End If
	%><recordCount>0<%=rC%></recordCount><%
	   
	   
End Sub '--------------------------------------------------------------------------------------------------------------------

				
				

Sub UseAsCust '---------------------------------------------------------------------------------------------------------------
	Dim ContactID
	Dim CName
	ContactID= CStr(Request.QueryString("id"))
	
	SQL1="UPDATE Contacts SET Customer=1 WHERE id = "&ContactID
	%><sql1><%=SQL1%></sql1><%	
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring

	'If rs1.EOF Then
		
	'Else
		%><success>1</success><%
	'End If
	
	Set rs1=Nothing
	
	
End Sub '---------------------------------------------------------------------------------------------------------------------


Sub insertNewCustomer '---------------------------------------------------------------------------------------------------------------
	Dim CName
	Dim Phone
	Dim Email
	
	CName = EncodeChars(CStr(Request.QueryString("cName")))
	Phone = CStr(Request.QueryString("phone"))
	Email = CStr(Request.QueryString("email"))
	
	cKey = newCreationKey()
		
	
	SQL ="INSERT INTO Contacts (Name, Phone1, Email, Customer, cKey)"		
	SQL=SQL&" VALUES ('"&CName&"','"&Phone&"','"&Email&"', 1, '"&cKey&"')"
	%><Name><%=CName%></Name><%
	%><cKey><%=cKey%></cKey><%
	%><SQL><%=SQL%></SQL><%
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
	
	SQL="SELECT Id FROM Contacts WHERE cKey='"&cKey&"'"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	%><id><%=rs("ID")%></id><%
	set rs = nothing
	
End Sub '----------------------------------------------------------------------------------------------------------------------
				
				
				
Sub ShowEventNotes '-------------------------------------------------------------------------------------------------------------

	Dim CalID
	CalID = CStr(Request.QueryString("CalID"))
	Dim XML
	Dim Notes
	Dim Nam
		
	SQL1 = "SELECT Title, Note FROM Calendar WHERE CalID = "&CalID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	If rs1.EOF Then
		Nam="Error reading CalID "&CalID
		Notes="Someone else may have deleted this event since last reload."
	Else
		Nam = rs1("Title")
		Notes=rs1("Note")
		If(IsNull(Notes))Or Notes="" Then Notes="NONE"
		Notes=EncodeChars(Replace(Notes,"Notes:",""))
		Do Until Notes = Replace(Notes, chr(13),"&lt;br/&gt;")
			Notes= Replace(Notes, chr(13),"&lt;br/&gt;")
		Loop
	End If
		
	%>
	<Notes>&lt;big&gt;<%=Nam%>&lt;/big&gt;&lt;br/&gt;&lt;hr style="margin:0; padding:0;"/&gt;&lt;small&gt;<%=EncodeChars(Notes)%>&lt;/small&gt;</Notes>
	<%
	
	
	set rs1 = nothing
	SQL1 = ""

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub oops  () '--------------------------------------------------------------------------------------------------------


response.write "<oops>Oops Didn't Work</oops>"







End Sub '------------------------------------------------------------------------------------------------------------------------






%>
</root>





