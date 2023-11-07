
<!--#include file="../../TMC/RED.asp" -->




<%
'Dim sAction 
'sAction = 

Select Case CStr(Request.QueryString("action"))
	Case "LoadNotes"
		LoadNotes
	
	Case "GetLists"
		GetLists
	
	Case "FindCust"
		FindCust
		
	Case "SaveTask"
		SaveTask
	
	Case "DelTask"
		DelTask
	
	Case "UpdateTask"
		UpdateTask
		
	Case"ArchiveTask"
		ArchiveTask
		
	Case"Activate"
		Activate
		
	Case "UpdateProgress"
		UpdateProgress
		
	Case "ToCalendar"
		ToCalendar
		
		
			
		
	Case Else 
		 oops 
				
End Select		





Sub LoadNotes  () '------------------------------------------------------------------------
	'Exit Sub	
	Dim XML
	Dim List
	Dim ActiveList
	Dim ArchiveList
	Dim TaskLength
	Dim Length
	Dim ArchiveLength
	
	Dim OrderBy
	Dim Active
	Dim NoteID
	Dim Job	
	Dim d8 	
	Dim Cust
	Dim Area 		
	dim Attn		
	dim Notes			
	

	'array for defining progress state in task list.-------------------------------------
	
		SQL1 = "SELECT * FROM Progress "
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		Dim A
		Dim B
		Dim C 
		Dim ProgArray(10)
	
		Do While Not rs1.EOF
			A = rs1("BGColor")
			B = rs1("BGText")
			C = C+ 1
			ProgArray(C) = array(A,B)
			
			rs1.MoveNext
		Loop		
		set rs1 = nothing
	'end array---------------------------------------------------------------------
	'array for defining priority in task list.-------------------------------------
	
		SQL1 = "SELECT * FROM Priority"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		
		'reDim A
		'reDim B
		C=0 
		Dim PriArray(10)
	
		Do While Not rs1.EOF
			A = rs1("BGColor")
			B = rs1("BGText")
			PriArray(C) = array(A,B)
			C = C+ 1
			
			rs1.MoveNext
		Loop		
		set rs1 = nothing
	'end array-------------------------------------------------------------------------------		


	
	TaskLength = 0
	OrderBy = Request.QueryString("OrderBy")
	if OrderBy <> "Priority" then 
		OrderBy = OrderBy&", Priority DESC" 'Sort by Priority as secondary if not primary
	else
		OrderBy = OrderBy&" DESC" 'Priority 1 listed 1st
	End If
		
	SQL1 ="SELECT * FROM JobsLists WHERE Type=1 ORDER BY "&OrderBy
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring

	XML = ""
	
	
	Dim ItemBgImage : ItemBgImage = "<div style='width:100%; height:1px; z-index:0;'><img src='images/RowBGYellow3.jpg' width='100%' height='27px' /></div>"
	Do While Not rs1.EOF
		Active = rs1("Active"): if(IsNull(Active)) then Active = "True"
		NoteID = rs1("NoteID")   
		Progress = rs1("Progress")	: if (IsNull(Progress)) or Progress < 1 then Progress = 1
		Pri = rs1("Priority")	: if (IsNull(Pri)) or Pri < 1 then Pri = 1
		Job = rs1("Job")    	: if (IsNull(Job)) or Job = "" then Job = "--"
		d8 = rs1("Date")    	: if (IsNull(d8)) or d8 = "" then d8 = "01/01/1900"
		Cust = rs1("Cust")   	: if (IsNull(Cust)) or Cust = "" then Cust = "--"
		Area = rs1("Area")   	: if (IsNull(Area)) or Area = "" then Area = "--"
		Attn = rs1("Attn")   	: if (IsNull(Attn)) or Attn = "" then Attn = "--"
		Notes = rs1("Notes") 	: if (IsNull(Notes)) or Notes = "" then Notes = "--"
	
		If Active = "True" Then
			Length = TaskLength
		Else	
			Length = ArchiveLength
		End If	
		
		List = List	& "<div id='ItemRowDiv' class='ItemRow'>"
		'List = List & ItemBgImage
		List = List	& "		<div id='ItemRowTop"&Length&"' class='ItemRowTop'>"
		List = List	& "			<div class='ItemEditButton' name='ItemEditButton' title='Edit' onclick='EditTask("&NoteID&");'></div>"
		List = List	& "			<div id='' class='ItemDelButton' title='Delete' onclick='DelTask("&NoteID&");'></div>"
		List = List	& "			<div id='' class='ItemSchButton' title='Schedule on Calendar' onclick='ToCal("&NoteID&");'></div>"

		If Active = "False" Then
			List = List&"<div id='' class='ItemActivateButton' onclick='Activate("&NoteID&")' onmouseout='UnArchMOut(this);' onmouseover='UnArchMOver(this);'></div>"
		Else	
			List = List&"<div id='' class='ItemArchiveButton' onclick='ArchiveTask("&NoteID&")' onmouseout='ArchMOut(this);' onmouseover='ArchMOver(this);'></div>"
		End If
		List = List	& "				<div title='Set priority of task' id='Pri"&Length&"' class='ItemPri' onMouseOver='MouseOver(this,^blue^);' onmouseout='MouseOut(this);'"	
		List = List & "			 	 onClick='showPriMenu(^Pri"&Length&"^,"&NoteID&");'><div>"&PriArray(Pri)(1)&"</div>"
		List = List	& "				</div>"

		List = List	& "			<div id='sizeJob"&NoteID&"' class='ItemJob' >"& Job &"</div>"
		List = List & "			<input id='HiddenJobID"&Length&"' type='hidden' value='sizeJob"&NoteID&"' />"
			
		List = List & "			<div title='Set task progress.' onMouseOver='' class='ItemDone' >"
		List = List	& "				<div id='Prog"&Length&"' class='ItemProg' "				
		List = List & "			 	onClick='showProgressMenu(^Prog"&Length&"^,"&NoteID&",^Progress^,this.offsetLeft,this.offsetTop);'"
		List = List & "			 	style='background:#"&ProgArray(Progress)(0)&"'>"'&ProgArray(Progress)(1)	
		List = List	& "				</div>"
		List = List	& "			</div>"

		List = List	& "			<div id='Date"&NoteID&"' class='ItemDate'>"&d8&"</div>"
		List = List & "			<input id='HiddenDateID"&Length&"' type='hidden' value='Date"&NoteID&"' />"
		List = List	& "			<div id='sizeCust"&NoteID&"' class='ItemCust'>"&Cust&"</div>"
		List = List & "			<input id='HiddenCustID"&Length&"' type='hidden' value='sizeCust"&NoteID&"' />"
		List = List	& "			<div id='Area"&NoteID&"' class='ItemArea'>"&Area&"</div>"
		List = List & "			<input id='HiddenAreaID"&Length&"' type='hidden' value='Area"&NoteID&"' />"
		List = List	& "			<div id='Attn"&NoteID&"' class='ItemAttn'>"&Attn&"</div>"
		List = List & "			<input id='HiddenAttnID"&Length&"' type='hidden' value='Attn"&NoteID&"' />"
		List = List	& "		</div>"
		List = List	& "		<div id='ItemRowBottom"&Length&"' class='ItemRowBottom' title='"&Notes&"'>"
		List = List & "			<div id='Notes"&NoteID&"' class='ItemNotes'>"
		List = List & "				<b>Notes: </b> "&Notes
		List = List & "			</div>"
		
		List = List	& "		</div>"
		List = List	& "	</div>"
		List = List & "<input id='HiddenNotes"&NoteID&"' type='hidden' value='"&Notes&"' />"
		List = List & "<input id='ProgByNoteID"&NoteID&"' type='hidden' value='"&Length&"' />"
		
		Do Until List = Replace(Replace(Replace(List,"^",""""),"<","&lt;"),"/","&#47;")
			List = Replace(Replace(Replace(List,"^",""""),"<","&lt;"),"/","&#47;")
		Loop

		If Active = "True" Then
			TaskLength = TaskLength + 1
			ActiveList = ActiveList & List
		Else	
			ArchiveLength = ArchiveLength + 1
			ArchiveList = ArchiveList & List
		End If	
		

		'XML = XML+"  <Job>--NotNull--"&rs1("Job")&"</Job>"
		List = ""
		rs1.MoveNext
	Loop	
	
	if IsNull(ActiveList) or (ActiveList="") then ActiveList = "No Active Tasks. Click 'New Task' to create a task, or 'Archive' to view Archived Tasks."
	if IsNull(ArchiveList) or (ArchiveList="") then ArchiveList = "No Tasks in Archive. Click 'Active' to view Active Tasks."
	
	ActiveList = "<List>"&ActiveList&"</List>"
	ArchiveList = "<Archive>"&ArchiveList&"</Archive>"
	XML="<root>"&ActiveList&ArchiveList&"<TaskLength>"&TaskLength&"</TaskLength><ArchiveLength>--"&ArchiveLength&"</ArchiveLength></root>"
	
	response.ContentType = "text/xml"
	response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub GetLists() '------------------------------------------------------

	XML = ("<root><two>1</two></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)
Exit Sub

	Dim XML
	Dim dbconn
	
	Dim EmpList
	Dim EmpCount
	
	EmpList = ""
	EmpCount = 1
     
	SQL = "SELECT * FROM Employees"
	set rs=Server.CreateObject("ADODB.Recordset")
	set dbconn = server.createobject("adodb.connection")
	dbconn.open REDconnstring
	rs.Open SQL, dbconn
	
	Do While Not rs.EOF 
	
		EmpList = EmpList+"<EmpID"&EmpCount&">"&rs("EmpID")&"</EmpID"&EmpCount&">"
		EmpList = EmpList+"<Fname"&EmpCount&">"&rs("Fname")&"</Fname"&EmpCount&">" 
		EmpList = EmpList+"<Lname"&EmpCount&">"&rs("Lname")&"</Lname"&EmpCount&">"
		
		EmpCount = EmpCount + 1	
	
	rs.MoveNext 
	Loop
	
	
	
	set rs = nothing
	set dbconn=nothing
	
	
	
	
	XML = ("<root><one>1</one>"&EmpList&"<EmpCount>"&EmpCount&"</EmpCount></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub FindCust  () '--------------------------------------------------------------------------------------------------------

	Dim CustText
		
	Dim XML
	Dim CustList
	Dim dbconn
	Dim Names
	
	Dim CustID
	Dim cName
	
	CustText = CStr(Request.QueryString("CustText"))
	
	SQL = "SELECT * FROM Customers WHERE Name LIKE '%"&CustText&"%'"
	set rs=Server.CreateObject("ADODB.Recordset")
	set dbconn = server.createobject("adodb.connection")
	dbconn.open REDconnstring
	rs.Open SQL, dbconn
	
	Dim cCount
	Dim onClick
	CustList = ""
	Do While Not rs.EOF
		cCount = cCount + 1 
		CustID = rs("CustID")
		cName = rs("Name")
		OnClick = "onclick=^GrabCust('"&cName&"')^"
		CustList = CustList & "<div id='' class='CustListItems' "&OnClick&">"
		CustList = CustList & cName &"</div> <br/>" 
		rs.MoveNext 
	Loop
	
	Do Until Custlist = Replace(Replace(Replace(CustList, "^", """"), ">", "&gt;"), "<", "&lt;")
		CustList = Replace(Replace(Replace(CustList, "^", """"), ">", "&gt;"), "<", "&lt;")
	Loop
	
	set rs = nothing
	set dbconn=nothing


	XML = ("<root><CustList>"&CustList&"</CustList><Test>sam</Test></root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sub SaveTask  () '--------------------------------------------------------------------------------------------------------
	
	Dim XML
	Dim DateNow
	
	
	Dim d8   	:   d8 = CStr(Request.QueryString("d8"))
	Dim Job  	:  Job = CStr(Request.QueryString("Job"))
	Dim Cust 	: Cust = CStr(Request.QueryString("Cust"))
	Dim Area 	: Area = CStr(Request.QueryString("Area"))
	Dim Attn 	: Attn = CStr(Request.QueryString("Attn"))
	Dim Notes	:Notes = CStr(Request.QueryString("Notes"))
	
	
	
	'ProjName = Replace(ProjName, ",", " ")
	'ProjName = Replace(ProjName, "'", " ")
	'ProjName = Replace(ProjName, "+", " ")
	'ProjName = Replace(ProjName, "&", " ")
	'ProjName = Replace(ProjName, "/", "-")
	
	
	'DateNow = Now()
	
	SQL ="Insert into JobsLists (Type,Date,Job,Cust,Area,Attn,Notes,Active) VALUES (1,'"&d8&"','"&Job&"','"&Cust&"','"&Area&"','"&Attn&"','"&Notes&"','True')"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		
		
		
																		
	set rs = nothing



	XML = ("<Event>Updated</Event><CustID>"&CustID&"</CustID>")
	XML = ("<root>"&XML&"</root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)



End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub DelTask  () '--------------------------------------------------------------------------------------------------------

Dim XML

Dim NoteID	:NoteID =Request.QueryString("NoteID")

SQL ="DELETE JobsLists WHERE NoteID = "&NoteID
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring
set rs = nothing
	


XML = ("<Event>Updated</Event><NoteID>"&NoteID&"</NoteID>")
XML = ("<root>"&XML&"</root>")

response.ContentType = "text/xml"
response.Write(XML)



End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub UpdateTask() '--------------------------------------------------------------------------------------------------------
	
	Dim XML
	Dim DateNow
	
	
	Dim d8	    :     d8 = CStr(Request.QueryString("d8"))
	Dim Job	    :    Job = CStr(Request.QueryString("Job"))
	Dim Cust	  :   Cust = CStr(Request.QueryString("Cust"))
	Dim Area	  :   Area = CStr(Request.QueryString("Area"))
	Dim Attn	  :   Attn = CStr(Request.QueryString("Attn"))
	Dim Notes	  :  Notes = CStr(Request.QueryString("Notes"))
	Dim NoteID	: NoteID = CStr(Request.QueryString("NoteID"))
	
	
	
	'ProjName = Replace(ProjName, ",", " ")
	'ProjName = Replace(ProjName, "'", " ")
	'ProjName = Replace(ProjName, "+", " ")
	'ProjName = Replace(ProjName, "&", " ")
	'ProjName = Replace(ProjName, "/", "-")
	
	
	'DateNow = Now()
	
	'  (Date,Job,Cust,Area,Attn,Notes) VALUES ('"&d8&"','"&Job&"','"&Cust&"','"&Area&"','"&Attn&"','"&Notes&"')"
	SQL = "UPDATE JobsLists SET Job = '"&Job&"', Date = '"&d8&"', Cust = '"&Cust&"', Area = '"&Area&"', Attn = '"&Attn&"', Notes = '"&Notes&"'"
	SQL = SQL & " WHERE NoteID = "&NoteID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		



	XML = ("<Event>Updated</Event><SQL>"&SQL&"</SQL>")
	XML = ("<root>"&XML&"</root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub ArchiveTask() '--------------------------------------------------------------------------------------------------------
	
	Dim XML
	Dim DateNow
	
	Dim NoteID: NoteID = CStr(Request.QueryString("NoteID"))
	
	SQL1 = "SELECT * FROM JobsLists WHERE NoteID ="&NoteID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	Dim Progress
	Progress=rs1("Progress")
	set rs1 = nothing
	
	SQL = "UPDATE JobsLists SET Active = 'False' WHERE NoteID = "&NoteID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		
	XML = ("<Event>Updated</Event><SQL>"&SQL&"</SQL>")
	XML = "<root>"&XML&"</root>"
	
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Sub Activate() '--------------------------------------------------------------------------------------------------------
	
	Dim XML
	Dim DateNow
	
	Dim NoteID	: NoteID = CStr(Request.QueryString("NoteID"))
	
	'ProjName = Replace(ProjName, ",", " ")
	'ProjName = Replace(ProjName, "'", " ")
	'ProjName = Replace(ProjName, "+", " ")
	'ProjName = Replace(ProjName, "&", " ")
	'ProjName = Replace(ProjName, "/", "-")
	
	
	'DateNow = Now()
	
	'  (Date,Job,Cust,Area,Attn,Notes) VALUES ('"&d8&"','"&Job&"','"&Cust&"','"&Area&"','"&Attn&"','"&Notes&"')"
	SQL = "UPDATE JobsLists SET Active = 'True' WHERE NoteID = "&NoteID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		



	XML = ("<Event>Updated</Event><SQL>"&SQL&"</SQL>")
	XML = ("<root>"&XML&"</root>")
	
	response.ContentType = "text/xml"
	response.Write(XML)


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub UpdateProgress() '-------------------------------------------------------------------------------------------------------
	Dim NoteID
	Dim ColumnID
	Dim Phase
	
	NoteID = CStr(Request.QueryString("NoteID"))
	ColumnID = CStr(Request.QueryString("ColumnID"))
	Phase = CStr(Request.QueryString("Phase"))
		
	SQL = "UPDATE JobsLists SET "&ColumnID&" = "&Phase&"  WHERE NoteID = "&NoteID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



























Sub oops  () '-------------------------------------------------------------------------------------------


response.write "Oops Didn't Work"

msgbox "action error"





End Sub '------------------------------------------------------------------------------------------------------------------------

%>