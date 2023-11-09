
<!--#include file="RED.asp" -->




<%
Dim sAction 

sAction = CStr(Request.QueryString("action"))

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
	
	Case "ShowEventNotes"
		ShowEventNotes
	
					
	Case Else 
		 oops 
				
End Select		


















Sub Events () '--------------------------------------------------------------------------------------------------------

	Dim Title
	Dim DateFrom
	Dim DateTo
	Dim Repeat, RepeatVal
	Dim Notes
	Dim Attn, AttnVal
	Dim Task, TaskVal
	Dim Job, JobVal
	Dim Super, SuperVal
	Dim Area, AreaVal
	Dim Phase, PhaseVal
	Dim Customer, CustomerVal
	Dim CrewNames
	Dim ActionType
	Dim EventID
	Dim sSource
	Dim DoneCheck
	Dim sDay, sMonth, sYear
	
	sSource = Request.QueryString("Source")
	Title = Request.QueryString("Title")
	DateFrom = Request.QueryString("DateFrom")
	DateTo = Request.QueryString("DateTo")
	Repeat = Request.QueryString("Repeat")
	RepeatVal = Request.QueryString("RepeatVal")
	Notes = Request.QueryString("Notes")
	Attn = Request.QueryString("Attn")
	AttnVal = Request.QueryString("AttnVal")
	Task = Request.QueryString("Task")
	TaskVal = Request.QueryString("TaskVal")
	DoneCheck = Request.QueryString("DoneCheck")
	Job = "0"
	JobVal = "0"
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
	
	
	'Remove problem characters and replace them
	Title = Replace(Title, ",", " ")
	Title = Replace(Title, "'", " ")
	Title = Replace(Title, "+", " and ")
	Title = Replace(Title, "&", " and ")
	Title = Replace(Title, "/", "-")
	
	Notes = Replace(Notes, ",", " ")
	Notes = Replace(Notes, "'", " ")
	Notes = Replace(Notes, "+", " and ")
	Notes = Replace(Notes, "&", " and ")
	Notes = Replace(Notes, "/", "-")
	
	'Split Individual Date Parts From Whole Date---
	'sDay = Day(DateFrom)
	'sMonth = Month(DateFrom)
	'sYear = Year(DateFrom)
	
	
	
	
	if (ActionType = "NewEvent") then
	
		SQL ="Insert into Calendar (Title,DateFrom,DateTo,Repeat,RepeatID,Note,Attention,AttentionID,Task,TaskID,Job,JobID,Super,SuperID,Area,AreaID,Phase,PhaseID,Customer,CustomerID,CrewNames,Done) VALUES ('"&Title&"','"&DateFrom&"','"&DateTo&"','"&Repeat&"',"&RepeatVal&",'"&Notes&"','"&Attn&"',"&AttnVal&",'"&Task&"',"&TaskVal&",'"&Job&"',"&JobVal&",'"&Super&"',"&SuperVal&",'"&Area&"',"&AreaVal&",'"&Phase&"',"&PhaseVal&",'"&Customer&"',"&CustomerVal&",'"&CrewNames&"', '"&DoneCheck&"')"
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring
		set rs = nothing
	
	end if
	
	if (ActionType = "UpdateEvent") then
	
		SQL="UPDATE Calendar SET"
		SQL=SQL&" Title ='"&Title&"',"
		SQL=SQL&" DateFrom ='"&DateFrom&"',"
		SQL=SQL&" DateTo ='"&DateTo&"',"
		SQL=SQL&" Repeat ='"&Repeat&"',"
		SQL=SQL&" RepeatID ="&RepeatVal&","
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
		SQL=SQL&" PhaseID ="&PhaseVal&","
		SQL=SQL&" Customer ='"&Customer&"',"
		SQL=SQL&" CustomerID ="&CustomerVal&","
		SQL=SQL&" Done = '"&DoneCheck&"'"
		SQL=SQL&" WHERE CalID = "&EventID
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring
		set rs = nothing
	
	end if

	
		XML = ("<Test>"&EventID&"</Test><Source>"&sSource&"</Source>'")
		XML = ("<root>"&XML&"</root>")
		
		response.ContentType = "text/xml"
		response.Write(XML)
	






End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~















Sub DeleteEvent  () '--------------------------------------------------------------------------------------------------------



Dim EventID
'Dim sSource

EventID = CStr(Request.QueryString("EventID"))
'sSource = CStr(Request.QueryString("Source"))


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



Dim sDate
Dim sEvent
Dim sAttn
Dim sAttnID
Dim sNotes
Dim sDay
Dim Color
Dim XML


sDate = Request.Form("Date")
sEvent = Request.Form("Event")
sAttn = CStr(Request.QueryString("EmpName"))
sAttnID = Request.Form("Employee")
sNotes = Request.Form("Notes")
sDay = Request.Form("Day")




sEvent = Replace(sEvent, ",", "")
sEvent = Replace(sEvent, "'", "")

sNotes = Replace(sNotes, ",", "")
sNotes = Replace(sNotes, "'", "")


SQL ="Insert into Calendar (DateFrom,DateTo,Job,IDnum,Event,Note,Attention,AttentionID) VALUES ('"&sDate&"','"&sDate&"','Note','1','"&sEvent&"','"&sNotes&"','"&sAttn&"',"&sAttnID&")"
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring
set rs = nothing
	


	Color = "#FFFF66"

    XML = ("<Event>&lt;div Class=""DayEvent"" style=""background:"&Color&";""&gt;"&sEvent&"&lt;/div&gt;</Event><Date>"&sDate&"</Date>")
	XML = ("<root>"&XML&"</root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)






End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Sub GetEvent() '--------------------------------------------------------------------------------------------------------

	Dim EventID
	Dim XML
	Dim TaskLength
	
	EventID = CStr(Request.QueryString("EventID"))
	TaskLength = 0
	
		SQL ="SELECT * FROM Calendar WHERE CalID = "&EventID 
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring
		
		
		SQL1 ="SELECT * FROM Tasks"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
	
	XML = ""
		Do While Not rs1.EOF
		
			XML = XML+"<TaskName"&rs1("TaskID")&">"&rs1("TaskName")&"</TaskName"&rs1("TaskID")&"><BgColor"&rs1("TaskID")&">"&rs1("BgColor")&"</BgColor"&rs1("TaskID")&"><TextColor"&rs1("TaskID")&">"&rs1("TextColor")&"</TextColor"&rs1("TaskID")&">"	
			TaskLength = TaskLength + 1
			
		rs1.MoveNext
		Loop	

	Dim tName: tName=rs("TaskEventTable")
	If tName = "" Or (IsNull(tName)) Then
	Else
		SQL2="SELECT * FROM TableKeys WHERE TableName='"&rs("TaskEventTable")&"'"
		Set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
		
		SQL3="SELECT * FROM "&rs("TaskEventTable")&" WHERE "&rs2("TableKey")&"="&rs("TaskEventID")
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
	
	XML=XML&"<Title>"&rs("Title")&"</Title>"
	XML=XML&"<DateFrom>"&rs("DateFrom")&"</DateFrom>"
	XML=XML&"<DateTo>"&rs("DateTo")&"</DateTo>"
	XML=XML&"<RepeatID>--"&rs("RepeatID")&"</RepeatID>"
	XML=XML&"<Note>--"&EncodeChars(rs("Note"))&"</Note>"
	XML=XML&"<AttentionID>--"&rs("AttentionID")&"</AttentionID>"
	XML=XML&"<TaskID>--"&rs("TaskID")&"</TaskID>"
	'XML=XML&"<JobID>"&rs("JobID")&"</JobID>"
	'XML=XML&"<SuperID>--"&rs("SuperID")&"</SuperID>"
	XML=XML&"<AreaID>--"&rs("AreaID")&"</AreaID>"
	XML=XML&"<PhaseID>--"&rs("PhaseID")&"</PhaseID>"
	XML=XML&"<CustomerID>--"&rs("CustomerID")&"</CustomerID>"
	XML=XML&"<CrewNames>--"&rs("CrewNames")&"</CrewNames>"
	XML=XML&"<DoneCheck>--"&rs("Done")&"</DoneCheck>"
		
		
		
		
	XML = ("<root>"&XML&"<TaskLength>"&TaskLength&"</TaskLength></root>")
		
		response.ContentType = "text/xml"
		response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






Sub CalendarEvents  () '---------------------------------------------------------------------------------------------------




Dim sDate
Dim Dates
Dim DateArray
Dim DateArrayLength
Dim DateCount
Dim XML
Dim XML_Events
Dim XML_Events2
Dim XML_EventList
Dim XML_EventList2
Dim EventCheck
Dim EventCount
Dim EventCountMax
Dim CSS
Dim Task
Dim BgColor
Dim Bg
Dim TextColor
Dim TextPx
Dim TextWeight
Dim BorderColor
Dim TaskLength
Dim BoxHeight
Dim sSource
Dim QuickViewID
Dim Quickview
Dim ViewAttn
Dim ViewTask
Dim ViewPM
Dim ViewArea
Dim ViewPhase
Dim ViewCustomer
Dim CalRows
Dim DetailedView
Dim Done
Dim IE



Dates = CStr(Request.QueryString("Array"))
DateArray = Split(Dates,",")

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

DateArrayLength = (ubound(DateArray))

DateCount = 1


XML_Events = ""
XML_Events2 = ""
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
	 
	if not QuickViewID = ""     then Quickview = " and TaskID = "&QuickViewID&" "      end if
	if not ViewAttn = "0"     then DetailedView = DetailedView + " and AttentionID = "&ViewAttn&" "      end if
	if not ViewTask = "0"     then DetailedView = DetailedView + " and TaskID = "&ViewTask&" "      end if
	if not ViewPM = "0"     then DetailedView = DetailedView + " and SuperID = "&ViewPM&" "      end if
	if not ViewArea = "0"     then DetailedView = DetailedView + " and AreaID = "&ViewArea&" "      end if
	if not ViewPhase = "0"     then DetailedView = DetailedView + " and PhaseID = "&ViewPhase&" "      end if
	if not ViewCustomer = "0"     then DetailedView = DetailedView + " and CustomerID = "&ViewCustomer&" "      end if
	
	
	
	


      for i = 1 to DateArrayLength
	  
				SQL1 = "SELECT * FROM Calendar WHERE DateFrom <='"&DateArray(DateCount)&"' and DateTo >='"&DateArray(DateCount)&"'  "&Quickview&"   "&DetailedView&"  ORDER BY Done, TaskID, CalID"
				set rs1=Server.CreateObject("ADODB.Recordset")
				rs1.Open SQL1, REDconnstring
			
				EventCount = 0 
				Do While Not rs1.EOF
					EventCount = EventCount + 1
			
					Task = rs1("TaskID")
				  Done = rs1("Done")
				  
				  for x = 1 to TaskLength ' This sets up the CSS for each Event added to the Calendar
				     
						 if Task = x then
					 	  
							if Done = true then 
								BgColor = "#"&AltBgArray(x) 
								Bg = "#"&AltBgArray(x) 
								TextColor = "#"&AltTxtColorArray(x)
								TextShadow=""
							end if
						  
							If Done = False then 
								TextColor = "#"&TxtColorArray(x)
								'Bg=" -webkit-gradient(linear, left bottom, left top, color-stop(0,#"&BgArray(x)&"), color-stop(.5,#FFF), color-stop(1,#"&AltBgArray(x)&"));"
								Bg="#"&BgArray(x)
								TextShadow="text-shadow: -0px -0px 3px #fff;"
								'TextShadow="text-shadow:-1px -1px 1px #"&AltBgArray(x)&", -1px 1px 1px #"&AltBgArray(x)&", 1px -1px 1px #"&AltBgArray(x)&", 1px 1px 1px #"&AltBgArray(x)&" ;"
								TxtWt="0"
								
								If IE=7 Or IE=8 Or IE=9 Then
									'Bg=" -webkit-gradient(linear, left bottom, left top, color-stop(0,#"&BgArray(x)&"), color-stop(.5,#FFF), color-stop(1,#"&AltBgArray(x)&"));"
									Bg="#"&BgArray(x)
									TextColor="#"&TxtColorArray(x)
								End If
							End if
							
						  TextPx = TxtSizeArray(x)&"px"
						  TextWeight = "Bold"'TxtWeightArray(x)
						  BorderColor = "#"&BorderColorArray(x)
						  BoxHeight = HeightArray(x)&"px"
					  End If 
				  
					next
				  
			dim TxtWt: TxtWt=TextWeight
			dim BoxHt: BoxHt=BoxHeight
			dim Bkg: Bkg=BgColor
			dim EvStyle
			EvStyle="overflow:hidden; background:"&Bg&"; color:"&TextColor&";"
			EvStyle=EvStyle&" font-size:"&TextPx&";font-weight:"&TxtWt&"; "&TextShadow
			EvStyle=EvStyle&" min-height:"&BoxHt&"; height:"&BoxHt&"; min-width:100%; width:100%; float:left; clear:both; border-bottom:1px solid #444;"'&TxtWt&";"
			dim XE: XE=""	  
			if sSource = "Month" then	  
				if EventCount <= EventCountMax  then
					'If EventCount = 4 then EvStyle=EvStyle&" margin-bottom:"&TxtHt&";"
					
					XE=XE&"<li id=""li"&rs1("CalID")&""" Class='"&CSS&"' "
					XE=XE&"style='"&EvStyle&"'"
					'onmousedown=""//EventClickUpdate("&rs1("CalID")&");""
					XE=XE&" onmouseover=""ShowEventNotes("&rs1("CalID")&");"" onMouseOut=""HideEventNotes();"""
					'XE=XE&" onmousemove=""PosEventNotes("&rs1("CalID")&"); """'//document.getElementById('li"&rs1("CalID")&"').innerHTML='"&CSS&"';
					XE=XE&" onmousedown=""CapturedID="&rs1("CalID")&";"""
					XE=XE&" onclick='LoadExistingEvent("&rs1("CalID")&");' >"&rs1("Title")&"</li>"
					
					XML_Events = XML_Events&XE
				end if
			end if
				
      if sSource = "Week" then
				XE=""
				
				'XE=XE&"<li id=""li"&rs1("CalID")&""" Title=''"
				'XE=XE&"style='"&EvStyle&" border:none;'"' border:"&TxtWt&";"
				'XE=XE&"onMouseOver=""ShowEventNotes("&rs1("CalID")&"); //EventClickUpdate("&rs1("CalID")&"); "" onMouseOut=""HideEventNotes();"""
				'XE=XE&" onmousemove=""PosEventNotes("&rs1("CalID")&");"""
				'XE=XE&" onMouseUp=""showEventInfo("&rs1("CalID")&");""   Class="""&CSS&""" >"&rs1("Title")&"</li>"
				
				XE=XE&"<li id=""li"&rs1("CalID")&""" Class='"&CSS&"' "
				XE=XE&"style='"&EvStyle&"'"
				'onmousedown=""//EventClickUpdate("&rs1("CalID")&");""
				XE=XE&" onmouseover=""ShowEventNotes("&rs1("CalID")&");"" onMouseOut=""HideEventNotes();"""
				XE=XE&" onmousemove=""PosEventNotes("&rs1("CalID")&"); """'//document.getElementById('li"&rs1("CalID")&"').innerHTML='"&CSS&"';
				XE=XE&" onmousedown=""CapturedID="&rs1("CalID")&";"""
				XE=XE&" onclick='LoadExistingEvent("&rs1("CalID")&");' >"&rs1("Title")&"</li>"
				
				XML_Events = XML_Events&XE
			end if
					

			'EventClickUpdate("&rs1("CalID")&")
			'XML_Events2= XML_Events2+("&lt;div onclick=""showEventInfo("&rs1("CalID")&");"" Class="""&CSS&""" style=""background:"&BgColor&"; color:"&TextColor&"; font-size:11px; font-weight:bold;""&gt;"&rs1("Title")&"&lt;/div&gt;")
			    
				rs1.MoveNext
			Loop

            set rs1 = nothing

			Do While InStr(XML_Events,"<")>0 And InStr(XML_Events,">")>0
				XML_Events=Replace(Replace(XML_Events,"<","&lt;"),">","&gt;")
			Loop
			
			if XML_Events = "" then XML_Events = "-No Data-" end if
			
			if XML_Events2 = "" then XML_Events2 = "-No Data-" end if
			
			XML_EventList = XML_EventList+"<Event"&DateCount&">"&XML_Events&"</Event"&DateCount&"><DateID"&DateCount&">"&DateArray(DateCount)&"</DateID"&DateCount&"><EventCount"&DateCount&">"&EventCount&"</EventCount"&DateCount&">"
			XML_Events = ""
			XML_EventList2 = XML_EventList2+"<Event2"&DateCount&">"&XML_Events2&"</Event2"&DateCount&"><DateID2"&DateCount&">"&DateArray(DateCount)&"</DateID2"&DateCount&"><EventCount"&DateCount&">"&EventCount&"</EventCount"&DateCount&">"
			XML_Events2 = ""
			DateCount = DateCount + 1
     next


'"&XML_EventList&"   "&6&"  "&DateArray(DateCount)&"
	

    XML = ("<root>"&XML_EventList&XML_EventList2&"<ArrayLength>"&DateArrayLength&"</ArrayLength><TaskLength>"&TaskLength&"</TaskLength></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~







Sub DayEvents  () '--------------------------------------------------------------------------------------------------------


Dim sDate
Dim XML
Dim XML_Events
Dim EventCheck
Dim CSS


CSS = CStr(Request.QueryString("CSS"))
sDate = CStr(Request.QueryString("Date"))

XML_Events = ""
     
            SQL1 = "select * from Calendar where DateFrom <='"&sDate&"' and DateTo >='"&sDate&"' order By Job "
			'SQL1 = "select * from Calendar where DateFrom ='"&sDate&"'order By Job "
			set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			Do While Not rs1.EOF
			
				  Job = rs1("Job")
			   
				  if Job = "Project" then Color = "#FFC693" End If
				  if Job = "Service" then Color = "#7CBDED" End If
				  if Job = "Maintenance" then Color = "#DFBBC5" End If
				  if Job = "Note" then Color = "#FFFF66" End If
				  if Job = "Eng" then Color = "#79ECC7" End If
			  
				
				XML_Events = XML_Events+("&lt;div onclick=""showEventHover();"" Class="""&CSS&""" style=""background:"&Color&";""&gt;"&rs1("Title")&"&lt;/div&gt;")  
			    
			
			rs1.MoveNext
			Loop
			
			
			if XML_Events = "" then
			
			    XML_Events = "-No Data-"
				
			end if
			
			
			set rs1 = nothing
			



'"&XML_EventList&"   "&6&"  "&DateArray(DateCount)&"
	

    XML = ("<root><Event>"&XML_Events&"</Event></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)




End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Sub UpdateDragDrop  () '--------------------------------------------------------------------------------------------------------


Dim XML
Dim DropedDate
Dim EventID
Dim DateFrom 
Dim DateTo
Dim Days
Dim Refresh
Dim DateToNew


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
	
	
	
	
	
	
	 XML = ("<root><Refresh>"&Refresh&"</Refresh><EventID>"&DropedDate&"</EventID><DropedDate>"&DateToNew&"</DropedDate></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '------------------------------------------------------------------------------------------------------------------------








Sub ShowEventNotes '-------------------------------------------------------------------------------------------------------------

	Dim CalID
	CalID = CStr(Request.QueryString("CalID"))
	Dim XML
	Dim Notes
	Dim Nam
		
	SQL1 = "SELECT * FROM Calendar WHERE CalID = "&CalID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	Nam = rs1("Title")
	Notes=rs1("Note")
	If(IsNull(Notes))Or Notes="" Then Notes="NONE"
	Notes=EncodeChars(Replace(Notes,"Notes:",""))
	Do Until Notes = Replace(Notes, chr(13),"&lt;br/&gt;")
		Notes= Replace(Notes, chr(13),"&lt;br/&gt;")
	Loop
	
	XML="<root><Notes>--&lt;big&gt;"&Nam&"&lt;/big&gt;&lt;br/&gt;&lt;small&gt;&lt;b&gt;Notes:&lt;/b&gt;"&EncodeChars(Notes)&"&lt;/small&gt;</Notes></root>"
		
	response.ContentType = "text/xml"
	response.Write(XML)
	
	set rs1 = nothing
	SQL1 = ""

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


















Sub oops  () '--------------------------------------------------------------------------------------------------------


response.write "Oops Didn't Work"







End Sub '------------------------------------------------------------------------------------------------------------------------






%>






