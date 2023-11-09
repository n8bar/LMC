
<!--#include file="../LMC/RED.asp" -->


<%Response.Buffer="false"%>

<%
Dim sAction 

sAction = CStr(Request.QueryString("action"))

Select Case sAction

	Case "NewTreeListItem"
		NewTreeListItem

	Case "DelTreeItem"
		DelTreeItem

	Case "GetJobList"
		GetJobList
		
	Case "UpdateProgress"	
		UpdateProgress
		
	Case "UpdateSystemProgress"	
		UpdateSystemProgress

	Case "RefreshNotes"
		RefreshNotes
		
	Case "RefreshToDo"
		RefreshToDo		
		
	Case "SelectAllNotesAndToDo"	
		SelectAllNotesAndToDo
		
	Case "GetArchivedJobList"	
		GetArchivedJobList
		
	Case "GetExpandingInfoBox"	
		GetExpandingInfoBox		
		
	Case "UpdateDataBaseTable"	
		UpdateDataBaseTable

	Case "UpdateNotesandToDo"	
		UpdateNotesandToDo
		
	Case "NewNoteandToDo"	
		NewNoteandToDo

	Case "ChangeToDoStatus"
		ChangeToDoStatus
		
	Case "SelectNotesAndToDo"	
		SelectNotesAndToDo
		
	Case "RefreshNotesAndToDoSelect"	
		RefreshNotesAndToDoSelect
		
	Case "DeleteNotesAndToDo"	
		DeleteNotesAndToDo
	
	Case "LoadCustList"
		LoadCustList
	
	
		
	Case Else 
		 oops 
				
End Select		



Sub NewTreeListItem () '----------------------------------------------------------------------------------------------------
	
	Dim JobName
	Dim EmpID
	Dim ParentID
	Dim Notes
	Dim JobTable
	Dim JobTableID
	Dim LastCreatedID
	
	
	JobName = CStr(Request.QueryString("JobName"))
	EmpID = CStr(Request.QueryString("EmpID")) 
	ParentID = CStr(Request.QueryString("ParentID"))
	Notes = CStr(Request.QueryString("Notes"))
	JobTable = CStr(Request.QueryString("JobTable"))
	JobTableID = CStr(Request.QueryString("JobTableID"))
	
	SQL="INSERT INTO TreeList (Name, EmpID, ParentID, Notes, JobTable, JobTableID)"
	SQL=SQL&" VALUES ('"&JobName&"', "&EmpID&", "&ParentID&", '"&Notes&"', '"&JobTable&"', "&JobTableID&")"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	
	
	Set rs=Nothing
	
	SQL="SELECT TreeListID FROM TreeList"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	
	
	Do Until rs.EOF
		LastCreatedID=rs("TreeListID")	
		rs.MoveNext
	Loop
	
	
	XML = "<root><SQL>"&SQL&"</SQL><JobName>"&JobName&"</JobName><ParentID>"&ParentID&"</ParentID><ID>"&LastCreatedID&"</ID><ItemName>"&JobName&"</ItemName></root>" 
	response.ContentType = "text/xml"
	response.Write(XML)
	
	Set rs=Nothing
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Sub DelTreeItem () '----------------------------------------------------------------------------------------------------

	Dim ID
	
	Dim TL
	TL=""
	Dim N1
	Dim N2
	Dim N3
	Dim N4
	
	ID = CStr(Request.QueryString("ID"))
	
	SQL="Select * FROM TreeList WHERE TreeListID="&ID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	
	
	Do Until rs.EOF
	
		SQL1="Select * FROM TreeList WHERE ParentID="&rs("TreeListID")
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring	
		
		Do Until rs1.EOF
		
			SQL2="Select * FROM TreeList WHERE ParentID="&rs1("TreeListID")
			set rs2=Server.CreateObject("ADODB.Recordset")
			rs2.Open SQL2, REDconnstring	

			Do Until rs2.EOF
			
				SQL3="Select * FROM TreeList WHERE ParentID="&rs2("TreeListID")
				set rs3=Server.CreateObject("ADODB.Recordset")
				rs3.Open SQL3, REDconnstring	
	
				Do Until rs3.EOF
				
					SQL4="DELETE FROM TreeList WHERE ParentID="&rs3("TreeListID")
					set rs4=Server.CreateObject("ADODB.Recordset")
					rs4.Open SQL4, REDconnstring	
		
					Do Until rs4.EOF
						N4=rs4("Name")
						TL=TL&"<"&N4&">"&N4&"</"&N4&">"
						rs4.MoveNext
					Loop
					
					Set rs4=Nothing
					
					rs3.MoveNext
				Loop
			
				SQL5="DELETE FROM TreeList WHERE ParentID="&rs2("TreeListID")
				set rs5=Server.CreateObject("ADODB.Recordset")
				rs5.Open SQL5, REDconnstring	
			
				Set rs5=Nothing
				Set rs3=Nothing
				
				rs2.MoveNext
			Loop
		
			SQL6="DELETE FROM TreeList WHERE ParentID="&rs1("TreeListID")
			set rs6=Server.CreateObject("ADODB.Recordset")
			rs6.Open SQL6, REDconnstring	
		
			Set rs6=Nothing
			Set rs2=Nothing
			
			rs1.MoveNext
		Loop
	
		SQL7="DELETE FROM TreeList WHERE ParentID="&rs("TreeListID")
		set rs7=Server.CreateObject("ADODB.Recordset")
		rs7.Open SQL7, REDconnstring	
	
		Set rs7=Nothing
		Set rs1=Nothing
		
		rs.MoveNext
	Loop
	
	SQL8="DELETE FROM TreeList WHERE TreeListID="&ID
	set rs8=Server.CreateObject("ADODB.Recordset")
	rs8.Open SQL8, REDconnstring	
	
	Set rs=Nothing
	
	XML = "<root><DeletedItems>"&TL&"</DeletedItems></root>" 
	response.ContentType = "text/xml"
	response.Write(XML)
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub GetJobList  () '----------------------------------------------------------------------------------------------------
	
	Dim Active
	Dim Archive
	Dim XML
	Dim L
	Dim LoopNum
	
	
	
	L = ""
	Dim JS: JS= ""
	LoopNum	= 1
 
	Active = CStr(Request.QueryString("Active"))
	If (IsNull(Active)) Or Active="" Or Active="True" Then 
		SQL = "SELECT * FROM Jobs WHERE Active = 'True'"  'and Obtained = 1"
	Else
		SQL = "SELECT * FROM Jobs " 
	End If
	 
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	
	'Dim MaxJobs : MaxJobs=10

	JobList=rs.GetRows()
	
	L=L&"<RecordCount>"&uBound(JobList,1)&"</RecordCount><FieldCount>"&uBound(JobList,2)-1&"</FieldCount>"
	For LoopNum = 0 to uBound(JobList,2)-1
		L=L&"<Row"&LoopNum&">"
		For FieldNum=0 to uBound(JobList,1)-1
			FVal=JobList(FieldNum,LoopNum)
			'If (Not IsNull(FVal)) And FVal<>"" Then
				L=L&"<"&rs.Fields(FieldNum).Name&">--"
				L=L&FVal
				L=L&"</"&rs.Fields(FieldNum).Name&">"
			'End If
		Next
		L=L&"</Row"&LoopNum&">"
	Next
	
	
	JS=JS&"ItemAttns=ItemAttnsList.split(',');"
	JS=JS&"Resize();"
			
	'L=Replace(Replace(Replace(L,"<","&lt;"),">","&gt;"),"^","""")
			
	set rs = nothing
	set rs1 = nothing
	set rs2 = nothing
 
	JS="//alert('More Garbage');"
 

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sub UpdateProgress() '-------------------------------------------------------------------------------------------------------

Dim NoteID
Dim ColumnID
Dim Phase
Dim TableName

NoteID = CStr(Request.QueryString("NoteID"))
ColumnID = CStr(Request.QueryString("ColumnID"))
Phase = CStr(Request.QueryString("Phase"))
TableName = CStr(Request.QueryString("TableName"))


	SQL = "UPDATE "&TableName&" SET "&ColumnID&" = '"&Phase&"'  WHERE NoteID = "&NoteID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sub UpdateSystemProgress() '------------------------------------------------------------------------------------------------

Dim NoteID
Dim ColumnID
Dim Phase
Dim TableName
Dim SystemID

NoteID = CStr(Request.QueryString("NoteID"))
ColumnID = CStr(Request.QueryString("ColumnID"))
Phase = CStr(Request.QueryString("Phase"))
TableName = CStr(Request.QueryString("TableName"))
SystemID = CStr(Request.QueryString("SystemID"))

	
	SQL = "UPDATE "&TableName&" SET "&ColumnID&" = '"&Phase&"'  WHERE NoteID = "&NoteID&" and SystemID = "&SystemID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub UpdateDataBaseTable() '-------------------------------------------------------------------------------------------------

Dim NoteID
Dim ColumnName
Dim InputValue
Dim TableName

NoteID = CStr(Request.QueryString("NoteID"))
ColumnName = CStr(Request.QueryString("ColumnName"))
InputValue = CStr(Request.QueryString("InputValue"))
TableName = CStr(Request.QueryString("TableName"))

	
	SQL = "UPDATE "&TableName&" SET "&ColumnName&" = '"&InputValue&"'  WHERE NoteID = "&NoteID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Sub UpdateNotesandToDo() '--------------------------------------------------------------------------------------------------

Dim TableID
Dim ColumnName
Dim InputValue
Dim TableName

TableID = CStr(Request.QueryString("TableID"))
ColumnName = CStr(Request.QueryString("ColumnName"))
InputValue = CStr(Request.QueryString("InputValue"))
TableName = CStr(Request.QueryString("TableName"))

	
	SQL = "UPDATE "&TableName&" SET "&ColumnName&" = '"&InputValue&"'  WHERE ID = "&TableID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		
		

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub RefreshNotesAndToDoSelect() '-------------------------------------------------------------------------------------------

	SQL = "UPDATE JobToDo SET Selected = '0'"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	SQL1 = "UPDATE JobNotes SET Selected = '0'"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	set rs1 = nothing
		

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~








Sub SelectAllNotesAndToDo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Dim TableName
Dim NoteID

TableName = CStr(Request.QueryString("TableName"))
NoteID = CStr(Request.QueryString("NoteID"))

	SQL = "UPDATE "&TableName&" SET Selected = '1' WHERE NoteID = "&NoteID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~








Sub NewNoteandToDo() '------------------------------------------------------------------------------------------------------

Dim NoteID
Dim ColumnName
Dim TableName

NoteID = CStr(Request.QueryString("NoteID"))
ColumnName = CStr(Request.QueryString("ColumnName"))
TableName = CStr(Request.QueryString("TableName"))

	
	SQL = "INSERT INTO "&TableName&" ("&ColumnName&", Checked ) VALUES ("&NoteID&", '0')"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
			

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





















Sub GetArchivedJobList  () '--------------------------------------------------------------------------------------------------------


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
















Sub RefreshNotes() '--------------------------------------------------------------------------------------------------------


Dim LoopNum
Dim DivID
Dim TList
Dim XML
Dim NoteID

	
	DivID = CStr(Request.QueryString("DivID"))
	NoteID = CStr(Request.QueryString("NoteID"))
	LoopNum = CStr(Request.QueryString("LoopNum"))


						SQL = "SELECT * FROM JobNotes WHERE NoteID = "&NoteID
						set rs=Server.CreateObject("ADODB.Recordset")
						rs.Open SQL, REDconnstring	
					
				Do While Not rs.EOF					

				TList = TList+("&lt;div class='NoteBox' id='NoteBox"&LoopNum&"'&gt;")
						TList = TList+("&lt;input name='NoteSelect' type='checkbox' class='NoteSelectCheckbox' value='Selected'&gt;  ")
						TList = TList+(" &lt;textarea type='text' class='NoteBoxInput' ")
						TList = TList+(" onkeyup='UpdateNotesandToDo(""JobNotes"",""Note"",value,"""&rs("ID")&""")' ")
						TList = TList+(" &gt;"&rs("Note")&"&lt;/textarea&gt;")
						TList = TList+("&lt;/div&gt;")						
				TList = TList+("&lt;div class='NoteSpacer'&gt;&lt;/div&gt;")	
							
					NoteNum = NoteNum + 1	
		
				rs.MoveNext
				Loop

				set rs = nothing
		XML = "<root><Tasks>"&TList&"</Tasks><DivID>"&DivID&"</DivID></root>" 
		response.ContentType = "text/xml"
		response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~









Sub RefreshToDo() '-------------------------------------------------------------------------------------------------------

Dim ToDoNum
Dim DivID
Dim TList
Dim XML
Dim NoteID

	
	DivID = CStr(Request.QueryString("DivID"))
	NoteID = CStr(Request.QueryString("NoteID"))
	ToDoNum = 1

						SQL = "SELECT * FROM JobToDo WHERE NoteID = "&NoteID
						set rs=Server.CreateObject("ADODB.Recordset")
						rs.Open SQL, REDconnstring	
					
				Do While Not rs.EOF					

				if rs("Checked") = "True" then Checked = "checked='checked'" end if
				if rs("Selected") = "True" then Selected = "checked='checked'" end if		

					TList = TList+("&lt;div id='ToDoListBox"&ToDoNum&"' class='ToDoListBox'&gt;")
					TList = TList+("&lt;input name='ToDoItemSelect' "&Selected&" id='ToDoItemSelect"&LoopNum&""&ToDoNum&"'")
					TList = TList+("onclick='SelectNotesAndToDo("""&rs("ID")&""",""JobToDo"","""&NoteID&""",""ToDoBoxInside"&LoopNum&""","""&rs("Selected")&""")'")
					TList = TList+(" type='checkbox' class='ToDoSelectCheckbox' value='"&rs("ID")&"'&gt;")
					TList = TList+("&lt;div class='CheckBoxSeperator'&gt; &lt;/div&gt;")
					TList = TList+("&lt;input name='ToDoItemStatus' type='checkbox' "&Checked&"")
					TList = TList+("onclick='ToDoItemStatusChange("""&rs("ID")&""","""&rs("Checked")&""","""&NoteID&""",""ToDoBoxInside"&LoopNum&""")'  class='ToDoItemCheckbox' value='Done'&gt;")
					TList = TList+("&lt;div class='CheckBoxSeperator'&gt; &lt;/div&gt;")
					TList = TList+("&lt;input name='ToDoItem' type='text' class='ToDoItem' ")
					TList = TList+("onkeyup='UpdateNotesandToDo(""JobToDo"",""ToDo"",value,"""&rs("ID")&""")' ")
					TList = TList+("value='"&rs("ToDo")&"'&gt;")
					TList = TList+("&lt;/div&gt;")
							
					ToDoNum = ToDoNum + 1	
					Checked = ""
					Selected = ""
		
				rs.MoveNext
				Loop


				set rs = nothing

		XML = "<root><Tasks>"&TList&"</Tasks><DivID>"&DivID&"</DivID></root>" 
		response.ContentType = "text/xml"
		response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~










Sub ChangeToDoStatus() '-------------------------------------------------------------------------------------------------
Dim XML
Dim TrueOrFalse
Dim ToDoID
Dim NoteID
Dim DivID
	
	TrueOrFalse = CStr(Request.QueryString("TrueOrFalse"))
	ToDoID = CStr(Request.QueryString("ToDoID"))
	NoteID = CStr(Request.QueryString("NoteID"))
	DivID = CStr(Request.QueryString("DivID"))

						SQL = "UPDATE JobToDo SET Checked = '"&TrueOrFalse&"'  WHERE ID = "&ToDoID
						set rs=Server.CreateObject("ADODB.Recordset")
						rs.Open SQL, REDconnstring	
			
		XML = "<root><NoteID>"&NoteID&"</NoteID><DivID>"&DivID&"</DivID></root>" 
		response.ContentType = "text/xml"
		response.Write(XML)

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~








Sub SelectNotesAndToDo() '------------------------------------------------------------------------------------------------

Dim XML
Dim TableName
Dim Checked
Dim ID
	
	
	TableName = CStr(Request.QueryString("TableName"))
	Checked = CStr(Request.QueryString("Checked"))
	ID = CStr(Request.QueryString("ID"))
	

						SQL = "UPDATE "&TableName&" SET Selected = '"&Checked&"'  WHERE ID = "&ID
						set rs=Server.CreateObject("ADODB.Recordset")
						rs.Open SQL, REDconnstring	


End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~








	
Sub DeleteNotesAndToDo() '------------------------------------------------------------------------------------------------

	Dim TableName
	Dim NoteID
		
	TableName = CStr(Request.QueryString("TableName"))
	NoteID = CStr(Request.QueryString("NoteID"))
        
	SQL = "DELETE FROM "&TableName&"  WHERE NoteID ="&NoteID&" and Selected = 1"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~







Sub LoadCustList() '------------------------------------------------------------------------------------------------

	Dim Search: Search=Request.QueryString("Search")
	Dim XML: XML=""
	Dim L: L=0
	Dim Max: Max=0 
	
	SQL= "SELECT * FROM Customers WHERE Name LIKE '"&Search&"%' ORDER BY Name"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	If rs.EOF	Then XML=XML&"<Cust0><em>No Results</em></Cust0>"

	Do Until rs.EOF
		L=L+1
		XML=XML&"<Cust"&L&">"&rs("Name")&"</Cust"&L&">"
		
		If L>=12 Then
			Max=1
			Exit Do
		End If
		
		rs.MoveNext
	Loop
	
		L=L+1
		XML=XML&"<Cust"&L&">-NONE-</Cust"&L&">"
		L=L+1
		XML=XML&"<Cust"&L&">-NONE-</Cust"&L&">"

	XML=XML&"<length>"&L&"</length><SQL>"&SQL&"</SQL><Max>"&Max&"</Max>"
	
	response.ContentType = "text/xml"
	response.Write("<root><test>test</test>"&XML&"</root>")
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Sub oops  () '-----------------------------------------------------------------------------------------------------------

response.write "Oops Didn't Work"

End Sub '----------------------------------------------------------------------------------------------------------------

%>