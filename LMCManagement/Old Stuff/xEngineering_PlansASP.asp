
<!--#include file="RED.asp" -->




<%
Dim sAction 

sAction = CStr(Request.QueryString("action"))

Select Case sAction

  	Case "PopulateEngineeringList"
		PopulateEngineeringList

	Case "UpdateProgress"
		UpdateProgress
		
	Case "UpdateEngineer"
		UpdateEngineer
		
	Case "UpdateEngineerNotes"
		UpdateEngineerNotes
	
	Case "GetEngTaskList"
		GetEngTaskList
		
	Case "EmployeeList"
		EmployeeList	
		
	Case "ArchiveStatus"
		ArchiveStatus
		
	Case "GetEngArchivedTaskList"	
		GetEngArchivedTaskList
		
	Case "DeleteEngineeringTask"	
		DeleteEngineeringTask
	
	Case Else 
		 oops 
				
End Select		






Sub PopulateEngineeringList  () '--------------------------------------------------------------------------------------------------------




	Dim XML
	Dim TaskLength
	
	
	
	TaskLength = 0

		
		SQL1 ="SELECT * FROM Calendar Where TaskID = 5"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
	
	XML = ""
		Do While Not rs1.EOF
		
			XML = XML+"  <ProjectID>"&rs1("CalID")&"</ProjectID>    <JobName>"&rs1("Title")&"</JobName>"
		    XML = XML+"  <Attention>"&rs1("AttentionID")&"</Attention>   <CustomerID>"&rs1("CustomerID")&"</CustomerID>"
			XML = XML+"  <Area>"&rs1("AreaID")&"</Area>"	
			TaskLength = TaskLength + 1
			
		rs1.MoveNext
		Loop	

		
		
		
	XML = ("<root>"&XML&"<TaskLength>"&TaskLength&"</TaskLength></root>")
		
		response.ContentType = "text/xml"
		response.Write(XML)
	
	set rs = nothing
	set rs1 = nothing





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub UpdateProgress() '-------------------------------------------------------------------------------------------------------



Dim ID
Dim ColumnID
Dim Phase

ID = CStr(Request.QueryString("ID"))
ColumnID = CStr(Request.QueryString("ColumnID"))
Phase = CStr(Request.QueryString("Phase"))

	
	SQL = "UPDATE Engineering SET "&ColumnID&" = '"&Phase&"'  WHERE ID = "&ID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		
		
		
									  
	

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~







Sub UpdateEngineer() '-------------------------------------------------------------------------------------------------------



Dim TaskID
Dim EngineerName

TaskID = CStr(Request.QueryString("TaskID"))
EngineerName = CStr(Request.QueryString("EngineerName"))

	
	SQL = "UPDATE Engineering SET Engineer = '"&EngineerName&"'  WHERE ID = "&TaskID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		
		
		
									  



End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






Sub UpdateEngineerNotes() '-------------------------------------------------------------------------------------------------------



Dim TaskID
Dim EngineerNotes

TaskID = CStr(Request.QueryString("TaskID"))
EngineerNotes = CStr(Request.QueryString("UpdatedNotes"))

	
	SQL = "UPDATE Engineering SET notes = '"&EngineerNotes&"'  WHERE ID = "&TaskID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		
		
		
									  



End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~









Sub ArchiveStatus() '-------------------------------------------------------------------------------------------------------



Dim TaskID
Dim TaskStatus

TaskID = CStr(Request.QueryString("TaskID"))
TaskStatus = CStr(Request.QueryString("TaskStatus"))

	
	SQL = "UPDATE Engineering SET status = '"&TaskStatus&"' WHERE ID = "&TaskID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		
		
		
									  
XML = "<root><TaskStatus>"&TaskStatus&"</TaskStatus></root>" 
	response.ContentType = "text/xml"
	response.Write(XML)



End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub DeleteEngineeringTask() '-------------------------------------------------------------------------------------------------------



Dim TaskID
Dim TaskStatus

TaskID = CStr(Request.QueryString("TaskID"))
TaskStatus = CStr(Request.QueryString("TaskStatus"))

	
	SQL = "DELETE FROM Engineering WHERE ID = "&TaskID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		
		
		
									  
XML = "<root><TaskStatus>"&TaskStatus&"</TaskStatus></root>" 
	response.ContentType = "text/xml"
	response.Write(XML)



End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






Sub GetEngTaskList  () '--------------------------------------------------------------------------------------------------------
	
	
	
	Dim EngID
	Dim XML
	Dim System
	Dim XMLtasks
	
	Dim LoopNum
	Dim EmployeeArray
	
	
	
	
	' array for defining progress state in task list.-------------------------------------
	
	
		SQL1 = "SELECT * FROM Progress"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
	
		Dim C
		Dim A
		Dim B
		Dim TaskProgressArray(10)
		
		C = 1
		
			Do While Not rs1.EOF
			
				A = rs1("BGColor")
				B = rs1("BGText")
			
				 TaskProgressArray(C) = array(A,B)
				 C = C+ 1
				
			rs1.MoveNext
			Loop		
			
			
		
	'end array-------------------------------------------------------------------------------		
	
	' array for defining Employee list.-------------------------------------
	
	
		SQL2 = "SELECT * FROM Employees"
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
	
		Dim C1
		Dim A1
		Dim B1
		Dim D1
		Dim EmployeeListArray(8192)
		
		C1 = 1
		
			Do Until rs2.EOF
			
				A1 = rs2("EmpID")
				B1 = rs2("Fname")
				D1 = rs2("Lname")
			
				EmployeeListArray(C1) = array(A1,B1,D1)
				 C1 = C1+ 1
				
				rs2.MoveNext
			Loop		

	'		
	'	
	'end array-------------------------------------------------------------------------------		
	
	
	
				
		
	EngID = CStr(Request.QueryString("EngID"))
					
	XMLtasks = ""	
	LoopNum	= 1
	EmployeeArray = CStr(Request.QueryString("EmpArray"))
	 
	
		 
			SQL = "SELECT * FROM Engineering WHERE status = 1"
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring	
	
	
		Do While Not rs.EOF		
						
				
								
					XMLtasks = XMLtasks+("&lt;div id='TaskListItems"&LoopNum&"' class='TaskListItems' onMouseOver='TaskListBkGndOn("&LoopNum&");' onMouseOut='TaskListBkGndOff("&LoopNum&");'&gt; ")				
					XMLtasks = XMLtasks+("&lt;div class='TaskListItemArchive'; title='Send to Archive' onClick='EngineeringArchive("&rs("ID")&",""False"");'")
					XMLtasks = XMLtasks+(" onMouseOver='ArchiveButtonMouseOver("&LoopNum&");' onMouseOut='ArchiveButtonMouseOut("&LoopNum&");' &gt;")				
					XMLtasks = XMLtasks+(" &lt;div id='ArchiveButton"&LoopNum&"' class='TaskListItemArchiveButton'; ")
					XMLtasks = XMLtasks+("&gt; &lt;/div&gt; ")				
					XMLtasks = XMLtasks+("&lt;/div&gt;")
					XMLtasks = XMLtasks+("&lt;div class='TaskListItemDel' title='Delete this Task' onClick='DeleteEngineeringTask(""Active"","&rs("ID")&","""&rs("JobName")&""");' ")
					XMLtasks = XMLtasks+("&gt;&lt;div class='TaskListItemDelBackground' &gt;&lt;/div&gt;&lt;/div&gt;")
					XMLtasks = XMLtasks+("&lt;div class='TaskListItemTime' title='Time Entry' onClick='alertfunction1()' &gt;&lt;div class='TaskListItemTimeBackground' &gt;  &lt;/div&gt;&lt;/div&gt;")
					XMLtasks = XMLtasks+("&lt;div class='TaskListItemSch' title='Schedule this Task' onClick='alertfunction2()' &gt;&lt;div class='TaskListItemSchBackground'&gt;  &lt;/div&gt;&lt;/div&gt;")				
					XMLtasks = XMLtasks+("&lt;div class='TaskListItemJob' onMouseOver='CloseProgressMenu(),CloseEmployeeList(),CloseNotes();' &gt;"&rs("JobName")&"&lt;/div &gt;")	
					XMLtasks = XMLtasks+("&lt;div class='TaskListItemCust' onMouseOver='CloseProgressMenu(),CloseEmployeeList(),CloseNotes();'&gt;"&rs("Customer")&"&lt;/div&gt;")
					XMLtasks = XMLtasks+("&lt;div class='TaskListItemArea' onMouseOver='CloseProgressMenu(),CloseEmployeeList(),CloseNotes();'&gt;"&rs("Area")&"&lt;/div&gt;")							
					XMLtasks = XMLtasks+("&lt;div title='click to set the progress of the task' class='TaskListItemDone' &gt; &lt;div id='iArchOrig"&LoopNum&"' class='TaskListItemProg'")
					XMLtasks = XMLtasks+("onClick='showProgressMenu(""iArchOrig"&LoopNum&""","&rs("ID")&",""ArchOrig"");' onMouseOver='CloseEmployeeList(),CloseNotes();'") 
					XMLtasks = XMLtasks+("style='background:#"&TaskProgressArray(rs("ArchOrig"))(0)&"'")
					XMLtasks = XMLtasks+("&gt;"&TaskProgressArray(rs("ArchOrig"))(1)&"&lt;/div&gt;&lt;/div&gt;")								
					XMLtasks = XMLtasks+("&lt;div title='click to set the progress of the task' class='TaskListItemDone' &gt;&lt;div id='iDraw"&LoopNum&"' class='TaskListItemProg'")
					XMLtasks = XMLtasks+("onClick='showProgressMenu(""iDraw"&LoopNum&""","&rs("ID")&",""Draw"");' onMouseOver='CloseEmployeeList(),CloseNotes();'") 
					XMLtasks = XMLtasks+("style='background:#"&TaskProgressArray(rs("Draw"))(0)&"'")
					XMLtasks = XMLtasks+("&gt;"&TaskProgressArray(rs("Draw"))(1)&"&lt;/div&gt;&lt;/div&gt;")								
					XMLtasks = XMLtasks+("&lt;div title='click to set the progress of the task' class='TaskListItemDone' &gt;&lt;div id='iPlot"&LoopNum&"' class='TaskListItemProg'")
					XMLtasks = XMLtasks+("onClick='showProgressMenu(""iPlot"&LoopNum&""","&rs("ID")&",""Plot"");' onMouseOver='CloseEmployeeList(),CloseNotes();' ")
					XMLtasks = XMLtasks+("style='background:#"&TaskProgressArray(rs("Plot"))(0)&"'")
					XMLtasks = XMLtasks+("&gt;"&TaskProgressArray(rs("Plot"))(1)&"&lt;/div&gt;&lt;/div&gt;")				
					XMLtasks = XMLtasks+("&lt;div title='click to set the progress of the task' class='TaskListItemDone' &gt;&lt;div id='iReview"&LoopNum&"' class='TaskListItemProg'")
					XMLtasks = XMLtasks+("onClick='showProgressMenu(""iReview"&LoopNum&""","&rs("ID")&",""Review"");' onMouseOver='CloseEmployeeList(),CloseNotes();'")
					XMLtasks = XMLtasks+("style='background:#"&TaskProgressArray(rs("Review"))(0)&"'")
					XMLtasks = XMLtasks+("&gt;"&TaskProgressArray(rs("Review"))(1)&"&lt;/div&gt;&lt;/div&gt;")				
					XMLtasks = XMLtasks+("&lt;div title='click to set the progress of the task' class='TaskListItemDone' &gt;&lt;div id='iSubmit"&LoopNum&"' class='TaskListItemProg'") 
					XMLtasks = XMLtasks+("onClick='showProgressMenu(""iSubmit"&LoopNum&""","&rs("ID")&",""Submit"");' onMouseOver='CloseEmployeeList(),CloseNotes();'") 
					XMLtasks = XMLtasks+("style='background:#"&TaskProgressArray(rs("Submit"))(0)&"'")
					XMLtasks = XMLtasks+("&gt;"&TaskProgressArray(rs("Submit"))(1)&"&lt;/div&gt;&lt;/div&gt;")				
					XMLtasks = XMLtasks+("&lt;div title='click to set the progress of the task' class='TaskListItemDone' &gt;&lt;div id='iRedraw"&LoopNum&"' class='TaskListItemProg'") 
					XMLtasks = XMLtasks+("onClick='showProgressMenu(""iRedraw"&LoopNum&""","&rs("ID")&",""Redraw"");' onMouseOver='CloseEmployeeList(),CloseNotes();'") 
					XMLtasks = XMLtasks+("style='background:#"&TaskProgressArray(rs("Redraw"))(0)&"'")
					XMLtasks = XMLtasks+("&gt;"&TaskProgressArray(rs("Redraw"))(1)&"&lt;/div&gt;&lt;/div&gt;")				
					XMLtasks = XMLtasks+("&lt;div title='click to set the progress of the task' class='TaskListItemDone' &gt;&lt;div id='iCompleted"&LoopNum&"' class='TaskListItemProg'")
					XMLtasks = XMLtasks+("onClick='showProgressMenu(""iCompleted"&LoopNum&""","&rs("ID")&",""Completed"");' onMouseOver='CloseEmployeeList(),CloseNotes();'")
					XMLtasks = XMLtasks+(" style='background:#"&TaskProgressArray(rs("Completed"))(0)&"'")
					XMLtasks = XMLtasks+("&gt;"&TaskProgressArray(rs("Completed"))(1)&"&lt;/div&gt;&lt;/div&gt;")
					XMLtasks = XMLtasks+("&lt;div class='TaskListItemDivider'&gt;&lt;/div&gt;")	
					XMLtasks = XMLtasks+("&lt;div id='EngineerButton"&LoopNum&"' class='TaskListItemAttnButton' onClick='ShowEmployeeList(""EngineerName"&LoopNum&""","&rs("ID")&"),CloseNotes();' ")
					XMLtasks = XMLtasks+("onMouseOver='CloseProgressMenu();' &gt;&lt;/div&gt;")			
					XMLtasks = XMLtasks+("&lt;div id='EngineerName"&LoopNum&"' title='Project Engineer' class='TaskListItemAttn' onClick='CloseEmployeeList(),CloseNotes();' ")
					XMLtasks = XMLtasks+("onMouseOver='CloseProgressMenu();'&gt;  "&rs("Engineer")&"&lt;/div&gt;")			
					XMLtasks = XMLtasks+("&lt;div class='TaskListItemDivider'&gt;&lt;/div&gt;")
					XMLtasks = XMLtasks+("&lt;div id='NotesButton"&LoopNum&"' class='TaskListItemNotesButton' onClick='ShowNotes(""iNotes"&LoopNum&""","&rs("ID")&"),CloseEmployeeList();'")
					XMLtasks = XMLtasks+(" onMouseOver='CloseProgressMenu();' &gt;&lt;/div&gt; &lt;br/&gt;  ")
					XMLtasks = XMLtasks+("&lt;div class='TaskListItemNotesInfo' onMouseOver='NotesPopUpBox(""iNotes"&LoopNum&""")' onMouseOut='NotesPopUpBoxClose()' &gt;&lt;/div&gt;")
					XMLtasks = XMLtasks+("&lt;div class='TaskListItemNotes' title='"&rs("notes")&"' id='iNotes"&LoopNum&"' onClick='CloseEmployeeList(),CloseNotes();'")
					XMLtasks = XMLtasks+(" onMouseOver='CloseProgressMenu();' &gt;"&rs("notes")&"&lt;/div&gt;")       			
					XMLtasks = XMLtasks+("&lt;/div&gt;")							
					
				LoopNum	= LoopNum + 1	
				rs.MoveNext 
				Loop
							
		set rs = nothing
		set rs1 = nothing
		set rs2 = nothing
		
	
		
	 
		 
		XML = "<root><Tasks>--"&XMLtasks&"</Tasks></root>" 
		response.ContentType = "text/xml"
		response.Write(XML)
	
	
	
	

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Sub GetEngArchivedTaskList  () '--------------------------------------------------------------------------------------------------------

Dim XML
Dim System
Dim XMLtasks
Dim LoopNum
	
XMLtasks = ""	
LoopNum	= 1

	 
    SQL = "SELECT * FROM Engineering WHERE status = 0"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	


	Do While Not rs.EOF		
				
							
				XMLtasks = XMLtasks+("&lt;div title='To Modify any Items in This Task, Return it to Active Status.' id='ArchivedTaskListItems"&LoopNum&"'")
				XMLtasks = XMLtasks+(" class='TaskListItems' onMouseOver='ArchivedTaskListBkGndOn("&LoopNum&");' onMouseOut='ArchivedTaskListBkGndOff("&LoopNum&");'&gt; ")				
				XMLtasks = XMLtasks+("&lt;div class='TaskListItemArchive'; title='Return To Active' onClick='EngineeringArchive("&rs("ID")&",""True"");'")
				XMLtasks = XMLtasks+("onMouseOver='ArchiveButtonMouseOver1("&LoopNum&");' onMouseOut='ArchiveButtonMouseOut1("&LoopNum&");' &gt;")				
				XMLtasks = XMLtasks+(" &lt;div id='ArchivedArchiveButton"&LoopNum&"' class='ArchivedTaskListItemArchiveButton'; &gt; &lt;/div&gt;&lt;/div&gt; ")						
				XMLtasks = XMLtasks+("&lt;div title='Delete Task' class='TaskListItemDel' onClick='DeleteEngineeringTask(""Archive"","&rs("ID")&","""&rs("JobName")&""");'")
				XMLtasks = XMLtasks+("&gt; &lt;div class='TaskListItemDelBackground' &gt;&lt;/div&gt;&lt;/div&gt;")	 
				XMLtasks = XMLtasks+("&lt;div class='TaskListItemTime' style=background-color:#DDDDDD &gt;&lt;/div&gt;")
				XMLtasks = XMLtasks+("&lt;div class='TaskListItemSch' style=background-color:#DDDDDD&gt;&lt;/div&gt;")
				XMLtasks = XMLtasks+("&lt;div class='TaskListItemJob' &gt;"&rs("JobName")&"&lt;/div &gt;")	
				XMLtasks = XMLtasks+("&lt;div class='TaskListItemCust' &gt;"&rs("Customer")&"&lt;/div&gt;")
				XMLtasks = XMLtasks+("&lt;div class='TaskListItemArea' &gt;"&rs("Area")&"&lt;/div&gt;")							
				XMLtasks = XMLtasks+("&lt;div class='ArchivedProgress'  id='ArchivedProgress"&LoopNum&"' class='TaskListItemProg' style=background-color:#DDDDDD")
				XMLtasks = XMLtasks+("&gt;&lt;/div&gt;")								
				XMLtasks = XMLtasks+("&lt;div id='ArchivedEngineerName"&LoopNum&"' class='TaskListItemAttn' style=width:94px; &gt;   "&rs("Engineer")&"&lt;/div&gt;")			
				XMLtasks = XMLtasks+("&lt;div class='TaskListItemDivider'&gt;&lt;/div&gt;")
				XMLtasks = XMLtasks+("&lt;div title='' class='TaskListItemNotesInfo' onMouseOver='NotesPopUpBox(""ArchivedNotes"&LoopNum&""")'onMouseOut='NotesPopUpBoxClose()'&gt;&lt;/div&gt;")
				XMLtasks = XMLtasks+("&lt;div title='' class='TaskListItemNotes' id='ArchivedNotes"&LoopNum&"' &gt;"&rs("notes")&"&lt;/div&gt;")       			
				XMLtasks = XMLtasks+("&lt;/div&gt;")							
				
			LoopNum	= LoopNum + 1	
			rs.MoveNext 
			Loop
						
	set rs = nothing
	
	 
	XML = "<root><Tasks>"&XMLtasks&"</Tasks></root>" 
	response.ContentType = "text/xml"
	response.Write(XML)





End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~









Sub oops  () '--------------------------------------------------------------------------------------------------------


response.write "Oops Didn't Work"







End Sub '------------------------------------------------------------------------------------------------------------------------

%>