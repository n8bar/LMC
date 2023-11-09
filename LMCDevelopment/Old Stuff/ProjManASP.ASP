 
<!--#include file="../../LMC/RED.asp" -->

<%

'Dim XML
Dim Text
Dim Table
Dim IDColumn
Dim Column
Dim RowID
Dim Ok
Dim BoxID
Dim ProjID
Dim ColumnID
Dim Phase
Dim TableName
Dim Symbol
Dim Color
Dim DivID
Dim SystemID
Dim Title
Dim Val
Dim FieldName
Dim TextString
Dim HTML
Dim OldHTML
Dim BomIsGenerated
Dim PL
Dim ItemID
Dim iBoxID
Dim OldiBoxID
Dim L
Dim SL
Dim SC
Dim FieldNum
Dim FVal

Dim sAction 

if Request.QueryString("HTML") <> "1" Then
	Response.ContentType="text/xml"
Else
	Response.ContentType="text/html"
End If

sAction = CStr(Request.QueryString("action"))
%>
<root>
<action><%=sAction%></action>
<%



Select Case sAction



Case "UpdateText" '------------------------------------------------------------------------------------------------------


	'BoxID = CStr(Request.QueryString("BoxID"))
	Text = CStr(Request.QueryString("Text"))
	Table = CStr(Request.QueryString("Table"))
	IDColumn = CStr(Request.QueryString("IDColumn"))
	Column = CStr(Request.QueryString("Column"))
	RowID = CStr(Request.QueryString("RowID"))
	SysOK = CStr(Request.QueryString("SysOK"))
	
	Text = Replace(Text, ",", "-COMMA-")
	Text = Replace(Text, "'", " ")
	Text = Replace(Text, "+", " ")
	'Text = Replace(Text, "/", "-")
	'Text = Replace(Text, chr(13), "--Return--")
	'Text = Replace(Text, chr(10), "--Ret--")
		
	SQL = "UPDATE "&Table&" SET "&Column&" ='"&Text&"' WHERE "&IDColumn&" = "&RowID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	if Key = "" then Key ="0" end if 	
	%>
	<SysID>--<%=RowID%></SysID>
	<Ok><%=SysOK%></Ok>
	<%
									  
'End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Case "UpdateProgress" '-------------------------------------------------------------------------------------------------------

ProjID = CStr(Request.QueryString("ProjID"))
ColumnID = CStr(Request.QueryString("ColumnID"))
Phase = CStr(Request.QueryString("Phase"))
Symbol=CStr(Request.QueryString("Symbol"))
TableName = CStr(Request.QueryString("TableName"))
DivID = CStr(Request.QueryString("DivID"))


	SQL = "UPDATE Projects SET "&ColumnID&" = '"&Phase&"'  WHERE ProjID = "&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing


	SQL = "SELECT * FROM "&TableName&" WHERE ProjID = "&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	SQL1 = "SELECT * FROM Progress WHERE ProgID = "&Phase
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	if rs1.eof then
		Phase=1
		Symbol="0"
		Color="FFF"
		DivID="PlanProg"
	else
	
		'Phase=1
		'Symbol="1"
		'Color="FFF"
		'DivID="PlanProg"
		
		Symbol=rs1("BGText")
		Color=rs1("BGColor")
		
		Phase = rs(ColumnID)
	
	end if
	'set rs = nothing
	'set rs1 = nothing
	
	
	%>
<Phase><%=Phase%></Phase><Symbol><%=Symbol%></Symbol><Color><%=Color%></Color><DivID><%=DivID%></DivID><ColumnID><%=ColumnID%></ColumnID>
<%

'End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	



Case "UpdateSystemProgress" '------------------------------------------------------------------------------------------------
	
	
	ProjID = CStr(Request.QueryString("ProjID"))
	ColumnID = CStr(Request.QueryString("ColumnID"))
	Phase = CStr(Request.QueryString("Phase"))
	TableName = CStr(Request.QueryString("TableName"))
	SystemID = CStr(Request.QueryString("SystemID"))
	
	SQL = "UPDATE "&TableName&" SET "&ColumnID&" = '"&Phase&"'  WHERE ProjectID = "&ProjID&" and SystemID = "&SystemID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
		
	%>
	<SQL><%=SQL%><SQL>
	<%

'End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Case "MakeInfoBox" '------------------------------------------------------------------------

	
	ProjID = CStr(Request.QueryString("ProjID"))
	Title = CStr(Request.QueryString("Title"))
	
	SQL1="SELECT * FROM InfoBoxes"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	Do Until rs1.eof
		'rs1.MoveLast
		OldiBoxID=rs1("InfoBoxID")
		rs1.MoveNext
	Loop
	
	SQL="INSERT INTO InfoBoxes (ProjID, Title) VALUES ("&ProjID&",'"&Title&"')"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
	Dim tries : tries =0
	iBoxID=OldiBoxID
	Do Until iBoxID <> OldiBoxID
		SQL1="SELECT * FROM InfoBoxes"
		set rs1=Server.CreateObject("ADODB.Recordset")
		rs1.Open SQL1, REDconnstring
		Do Until rs1.eof
			'rs1.MoveLast
			iBoxID=rs1("InfoBoxID")
			rs1.MoveNext
		Loop
		tries = tries+1
		If Tries>15 Then
			iBoxID=OldiBoxID+1
			Exit Do
		End If
	Loop
	%>
	<InfoBoxID><%=iBoxID%></InfoBoxID>
	<SQL><%=SQL%></SQL>
	<Tries><%=tries%></Tries>
	<%
	
	set rs1=nothing
'End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Case "MakeInfoBoxData" '------------------------------------------------------------------------
	
	InfoBoxID = CStr(Request.QueryString("InfoBoxID"))
	Title = CStr(Request.QueryString("Name"))
	
	SQL="INSERT INTO InfoBoxData (InfoBoxID, Name) VALUES ("&InfoBoxID&",'"&Title&"')"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
	SQL1="SELECT * FROM InfoBoxData"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	Do Until rs1.eof
		'rs1.MoveLast
		iBoxDataID=rs1("InfoBoxDataID")
		rs1.MoveNext
	Loop
	
	%>
	<InfoBoxDataID><%=iBoxDataID%></InfoBoxDataID>
	<Name><%=Title%></Name>
	<SQL><%=SQL%></SQL>
	<%
	set rs1=nothing
'End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Case "GetColumn" '------------------------------------------------------------------------
	
	
	ProjID = CStr(Request.QueryString("ProjID"))
	ColumnID = CStr(Request.QueryString("ColumnID"))
	
	SQL="SELECT * FROM Projects WHERE ProjID ="&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	Val=rs(ColumnID)
	
	set rs = nothing
	
	%>
<Value><%=Val%></Value><ColumnID>--<%=ColumnID%></ColumnID>
<%
	
'End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Case "GenerateBOM" '------------------------------------------------------------------------------------------------

	ProjID = CStr(Request.QueryString("ProjID"))
		
	Dim PartIDs(65536)
	PartIDsI=0
		
	SQL="SELECT * FROM Systems WHERE ProjectID ="&ProjID&" AND Obtained='True'"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	SysNum=0
	Do Until rs.Eof
		SysNum=SysNum+1
		%><Sys<%=SysNum%>><%=rs("System")%>:<%=rs("SystemID")%></Sys><%=SysNum%>><%
		SQL2="SELECT * FROM BidItems WHERE Type='Part' AND SysID="&rs("SystemID")
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
		
		Dim PartID
		Do Until rs2.Eof
			
			InsertNew=True
			For eachPID = 0 to PartIDsI Step 1
				Response.Flush()
				If PartIDs(eachPID)=rs2("PartID") Then
					InsertNew=False
					SQL7="SELECT * FROM BomItems WHERE PartID='"&rs2("PartID")&"' AND ProjID="&ProjID
					Set rs7=Server.CreateObject("AdoDB.RecordSet")
					rs7.Open SQL7, REDConnString
					
					If Not rs7.EOF Then
						SQL8="UPDATE BomItems SET Qty="&rs7("Qty")+1&" WHERE PartID='"&rs2("PartID")&"' AND ProjID="&ProjID
						%><SQL8><%=SQL8%></SQL8><%
						Set rs8=Server.CreateObject("AdoDB.RecordSet")
						rs8.Open SQL8, REDConnString
						Set rs8=Nothing
					End If
					Set rs7=Nothing
					%><additionalPID><%=rs2("PartID")%></additionalPID><%
					Exit For
				End If
			Next
			
			If InsertNew Then
				
				thisPartID=rs2("PartID")
				if thisPartID="" Then thisPartID=0
				
				SQL3="INSERT INTO BOMItems (ProjID, PartID, Manufacturer, ItemName, Description, Qty)"
				SQL3=SQL3&" VALUES ("&ProjID&","&thisPartID&",'"&rs2("Manufacturer")&"','"&rs2("ItemName")&"','"&rs2("ItemDescription")&"',"&rs2("Qty")&")"
				%><SQL3><%=SQL3%></SQL3><%
				set rs3=Server.CreateObject("ADODB.Recordset")
				rs3.Open SQL3, REDconnstring
				
				PartIDs(PartIDsI)=rs2("PartID")
				%><PID<%=PartIDsI%>><%=rs2("PartID")%></PID><%=PartIDsI%>><%
				PartIDsI=PartIDsI+1
				'Redim PRESERVE PartIDs(PartIDsI)
			
			End If
			
			PartID=rs2("PartID")
			If (IsNull(PartID)) Or PartID="" Then
			Else
				SQL4="SELECT * FROM PartsInclude WHERE PartID="&PartID
				set rs4=Server.CreateObject("ADODB.Recordset")
				rs4.Open SQL4, REDconnstring
		
				Do Until rs4.eof
					SQL5="SELECT * FROM Parts WHERE PartsID="&rs4("SubPartID")
					set rs5=Server.CreateObject("ADODB.Recordset")
					rs5.Open SQL5, REDconnstring
					
					InsertNew=True
					For eachPID=0 to PartIDsI
						If PartIDs(eachPID)=rs2("ItemName") Then
							InsertNew=False
							SQL7="SELECT * FROM BomItems WHERE ItemName='"&rs2("ItemName")&"'"
							Set rs7=Server.CreateObject("AdoDB.RecordSet")
							rs7.Open SQL7, REDConnString
							
							SQL8="UPDATE BomItems SET Qty="&(rs7("Qty")+1)&" WHERE ItemName='"&rs2("ItemName")&"' AND ProjID="&ProjID
							Set rs8=Server.CreateObject("AdoDB.RecordSet")
							rs8.Open SQL8, REDConnString
							
							Set rs7=Nothing
							Set rs8=Nothing
							Exit For
						End If
					Next
					
					If InsertNew Then
						SQL6="INSERT INTO BOMItems (ProjID, PartID, Manufacturer, VendorID, ItemName, Description, Qty)"
						SQL6=SQL6&" VALUES ("&ProjID&","&rs5("PartsID")&",'"&rs5("Manufacturer")&"','"&rs5("Manufacturer")&"','"&rs5("Model")&"','"&rs5("Description")&"',0"&rs4("Qty")&")"
						set rs6=Server.CreateObject("ADODB.Recordset")
						rs6.Open SQL6, REDconnstring
						PartIDs(PartIDsI)=rs2("ItemName")
						%><PID<%=PartIDsI%>><%=rs2("ItemName")%>></PID><%=PartIDsI%>><%
						PartIDsI=PartIDsI+1
					End If
					
					Set rs6 = Nothing
					Set rs5 = Nothing
					
					rs4.MoveNext	
				Loop
						
				set rs4=nothing
						
			End If
			
			
			set rs3=nothing
			
			rs2.MoveNext
		Loop
		
		set rs2= nothing  
				
		rs.MoveNext
		Response.Flush()
	Loop
	
	set rs=nothing
	
	SQL1="UPDATE Projects SET BOMIsGenerated='True' WHERE ProjID="&ProjID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	set rs1 = nothing
	
	
	%><PartIDs><%=PartIDsI%></PartIDs><%
	For p=0 to PartIDsI-1
		%>
		<PID<%=p%>><%=PartIDs(p)%>></PID><%=p%>>
		<%
	Next
	
	%>
	<SQL><%=SQL%></SQL>
	<SQL2><%=SQL2%></SQL2>
	<SQL1><%=SQL1%></SQL1>
	<%

'End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Case "DeleteBOM" '------------------------------------------------------------------------------------------------

	ProjID = CStr(Request.QueryString("ProjID"))

	SQL="SELECT * FROM Systems WHERE ProjectID ="&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	Do Until rs.Eof
		
		SQL2="DELETE FROM BOMItems WHERE ProjID="&ProjID
		set rs2=Server.CreateObject("ADODB.Recordset")
		rs2.Open SQL2, REDconnstring
		set rs2= nothing  
		
		rs.MoveNext
	Loop
	
	set rs=nothing
	
	SQL1="UPDATE Projects SET BOMIsGenerated='False' WHERE ProjID="&ProjID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	set rs1 = nothing
	
	%>
<SQL><%=SQL2%></SQL>
<%

'End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Case "searchParts" '------------------------------------------------------------------------------------------------
	PN=Request.QueryString("PN")
	%><searchPN><%=PN%></searchPN><%
	set rs=Server.CreateObject("AdoDB.RecordSet")
	SQL="SELECT * FROM Parts WHERE PartNumber Like '%"&PN&"%'"
	rs.Open SQL, REDConnString
	
	pCount=0
	Do Until rs.EOF
		pCount=pCount+1
		%>
		<partsID<%=pCount%>><%=rs("PartsID")%></partsID><%=pCount%>>
		<Vendor2.<%=pCount%>><%=rs("Vendor2")%></Vendor2.><%=pCount%>>
		<Vendor1.<%=pCount%>><%=rs("Vendor1")%></Vendor1.><%=pCount%>>
		<Mfr<%=pCount%>><%=rs("Manufacturer")%></Mfr><%=pCount%>>
		<PN<%=pCount%>><%=rs("PartNumber")%></PN><%=pCount%>>
		<Desc<%=pCount%>><%=rs("Description")%></Desc><%=pCount%>>
		<%
		rs.MoveNext
	Loop
	
	%>
	<pCount><%=pCount%></pCount>
	<SQL><%=SQL%></SQL>
	<%
	
'End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Case "ListEntryUpdate" 'Updates the Text from the Parts or Labor text field on blur----------------------------------------------------------------------


	RowID = CStr(Request.QueryString("RowID"))
	FieldName = CStr(Request.QueryString("FieldName"))
	TextString = CStr(Request.QueryString("TextString"))
	if (IsNull(TextString)) Or TextString="" Then TextString="0"
	
	SQL = "UPDATE BomItems SET "&FieldName&" ='"&TextString&"' WHERE BomItemsID = "&RowID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	%>
<ts><%=TextString%></ts><SQL><%=SQL%></SQL><RowID><%=RowID%></RowID>
<%
	
'End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Case "BomContent" 'Generates BOM HTML ----------------------------------------------------------------------------------------------------

	ProjID = CStr(Request.QueryString("ProjID"))
	BomIsGenerated = CStr(Request.QueryString("BomIsGenerated"))
	
	
	If BomIsGenerated="True" Then
	
		HTML="<br/><br/>"
		HTML=HTML&"<div style=""width:100%; font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif; font-weight:normal;"" align=left>"
		HTML=HTML&	"&amp;nbsp; &amp;nbsp; <a onclick=""delParts();"">Delete</a>&amp;nbsp;&amp;nbsp;"
		'HTML=HTML&	"<a>Consolidate</a>"
		HTML=HTML&"</div>"
		HTML=HTML&"<br/><br/>"
		HTML=HTML&""'<h2><small style='font-weight:normal; font-family:""Courier New"", Courier, monospace;'>System:</small> "&rs3("System")&"</h2>"
		HTML=HTML&"<div style=""margin-left:5%; width:90%; border:1px solid #666; background:#ECE8EF; white-space:nowrap;"">"
		
		HTML=HTML&"	<div align=""left"" style=""font-family:Consolas, monospace, sans-serif; font-size:14px; overflow:hidden;"">"
		HTML=HTML&"		<div style=""float:left; width:4%; background:#ECE8EF; display:inline;""><input id=selAll type=checkbox /></div>"
		HTML=HTML&"		<div style=""float:left; width:4%; border-left:1px solid #666; background:#ECE8EF; display:inline;""> Qty</div>"
		HTML=HTML&"		<div style=""float:left; width:15%; border-left:1px solid #666; background:#ECE8EF; display:inline;""> Manufacturer</div>"
		HTML=HTML&"		<div style=""float:left; width:15%; border-left:1px solid #666; background:#ECE8EF; display:inline;""> Part Number</div>"
		HTML=HTML&"		<div style=""float:left; width:33%; border-left:1px solid #666; background:#ECE8EF; display:inline; overflow:visible;"">"
		HTML=HTML&"			<div style=""width:200%;""> Description</div>"
		HTML=HTML&"		</div>"
		HTML=HTML&"	</div>"
		
		PL = ""
		SQL5="SELECT * FROM BOMItems WHERE ProjID = "&ProjID
		set rs5=Server.CreateObject("ADODB.Recordset")
		rs5.Open SQL5, REDconnstring	
		
		Dim PIT: PIT="class='PartsItemText'"			
		Color="#E8EEEC"
		Do Until rs5.EOF
			If Color="#E8EEEC" Then Color="#EEECE8" Else Color="#E8EEEC"
			ItemID=rs5("BOMItemsID")
	
			HTML=HTML&"	<div class='PartsItemRow'>"
			
			HTML=HTML&"		<div class=""PartsItemTxtBox"" style=""width:4%; border:none; background:"&Color&";"" >"
			HTML=HTML&"			<div "&PIT&" align=""center"">"
			HTML=HTML&"				<input id=""SelItem"&ItemID &""" type=checkbox style=""padding:0;"" onClick=""//BomRemove("&ItemID &");""/>"
			HTML=HTML&"			</div>"
			HTML=HTML&"		</div>"
			
			HTML=HTML&"		<div class='PartsItemTxtBox' style='width:4%; ' >"
			HTML=HTML&"			<input "&PIT&" style='width:100%; height:100%; background:"&Color&";' type='text' id='Qty"&ItemID&"' maxlength='10' value='"&rs5("Qty") &"'"
			HTML=HTML&"			 onkeypress='//return alpha(event,numbers1+decimal,this)'"
			HTML=HTML&"			 onKeyUp='ListEntryUpdate("&ItemID &",""Qty"",this.id);'/>"
			HTML=HTML&"		</div>"
			
			HTML=HTML&"		<div class='PartsItemTxtBox' style='width:15%;'>"
			HTML=HTML&"			<input "&PIT&" style='width:100%; background:"&Color&";' type='text' id='Manuf"&ItemID&"' maxlength='20' value='"&rs5("Manufacturer") &"'"
			HTML=HTML&"			 onKeyUp='ListEntryUpdate("&ItemID&",""Manufacturer"",this.id);'/>"
			HTML=HTML&"		</div>"
				
			HTML=HTML&"		<div class='PartsItemTxtBox' style='width:15%;'>"
			HTML=HTML&"			<input "&PIT&" style='width:100%; background:"&Color&";' type='text' id='Name"&ItemID&"' maxlength='25' value='"&rs5("ItemName") &"'"
			HTML=HTML&"			 onKeyUp='ListEntryUpdate("&ItemID &",""ItemName"",this.id);'/>"
			HTML=HTML&"		</div >"
			
			HTML=HTML&"		<div class='PartsItemTxtBox' style='width:33%; overflow:visible;'>"
			HTML=HTML&"			<input "&PIT&" style='width:200%; background:"&Color&";' type='text' id='Desc"&ItemID&"' maxlength='299' value='"&rs5("Description")&"'"
			HTML=HTML&"		 	 onKeyUp='ListEntryUpdate("&ItemID &",""ItemDescription"",this.id);'/>"
			HTML=HTML&"		</div>"
			
			HTML=HTML&"</div>"
	
			rs5.MoveNext 
		Loop
		Set rs5 = nothing	
		
		
	
		HTML=HTML&"</div>"
		
		HTML=HTML&"</div>"
		HTML=HTML&"</div>"
		
		HTML=HTML&"<div style='width:90%; height:24px; margin-left:4%;' align=left >"
		HTML=HTML&	"<button onclick=""showPartsBox();"" style='padding-top:2px;'><img src='images/plus_16.png' >Add Parts</button>"
		HTML=HTML&	"<button id=addBlankPart onClick=""SendSQL('Write','INSERT INTO BOMItems (ProjID,Qty) VALUES ("&ProjID&",1)'); BomContent("&ProjID&",'True');"" style='padding-top:2px;'><img src='images/plus_16.png' >Add blank line.</button>"
		HTML=HTML&"</div>"
		
		HTML=HTML&	"<div style=width:100%;'><br/>"
		HTML=HTML&		"<button style=""width:49%; height:10%; color:#003300;"" onClick=""if(DeleteBOM()){GenerateBOM();}"">Delete and Regenerate</button>"
		HTML=HTML&		"<button style=""width:49%; height:10%; color:#330000;"" onClick=""DeleteBOM();"">Delete for good</button>"
		HTML=HTML&	"</div><br/>&amp;nbsp;"
		HTML=HTML&"</div>"

	Else

		HTML=HTML&"<div id=""BomGen"" style=""width:100%; height:100%;"">"
		HTML=HTML&"	<button style=""position:relative; width:25%; height:25%; top:37.5%; font-size:36px;"" onClick=""GenerateBOM();"">"
		HTML=HTML&"		Generate<br />From Bid<br />"
		HTML=HTML&"	</button>"
		HTML=HTML&"	<button style=""position:relative; width:25%; height:25%; top:37.5%; font-size:36px;"" onClick=""GenerateEmptyBOM();"">"
		HTML=HTML&"		Build From Scratch"
		HTML=HTML&"	</button>"
		HTML=HTML&"</div>"

	End If

	'HTML="<br/><br/>"&HTML

	OldHTML=""
	Do While OldHTML <> HTML
		OldHTML=HTML
		HTML=Replace(Replace(HTML,"<","&lt;"),">","&gt;")
	Loop

	
%>
<BOM><%=HTML%></BOM>
<SQL5><%=SQL5%></SQL5>
<BomIsGenerated><%=BomIsGenerated%></BomIsGenerated>
<%

'End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Case "BomRemove" 'Removes an Entry from the BOM----------------------------------------------------------------------------------

	RowID = CStr(Request.QueryString("RowID"))
	
	SQL = "DELETE FROM BomItems WHERE BOMItemsID ="&RowID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	%>
<BomItemsID><%=RowID%></BomItemsID>
<%

'End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Case "LoadSchList" 'Load The Schedule List for the project---------------------------------------------------------------------
	ProjID = CStr(Request.QueryString("ProjID"))

	SQL="SELECT * FROM Calendar WHERE TaskEventTable = 'Projects' AND TaskEventID = "&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	SC=0
	Do Until rs.EOF
		SC=SC+1
		L=L&"<Row"&SC&">"
			L=L&"<CalID>--"
			L=L&rs("CalID")
			L=L&"</CalID>"
			L=L&"<Title>--"
			L=L&rs("Title")
			L=L&"</Title>"
			L=L&"<DateFrom>--"
			L=L&rs("DateFrom")
			L=L&"</DateFrom>"
			L=L&"<DateTo>--"
			L=L&rs("DateTo")
			L=L&"</DateTo>"
			L=L&"<Time>--"
			L=L&rs("Time")
			L=L&"</Time>"
			L=L&"<Repeat>--"
			L=L&rs("Repeat")
			L=L&"</Repeat>"
			L=L&"<RepeatID>--"
			L=L&rs("RepeatID")
			L=L&"</RepeatID>"
			L=L&"<Note>--"
			L=L&rs("Note")
			L=L&"</Note>"
			L=L&"<AttentionID>--"
			L=L&rs("AttentionID")
			L=L&"</AttentionID>"
			L=L&"<Phase>--"
			L=L&rs("Phase")
			L=L&"</Phase>"
			L=L&"<CrewNames>--"
			L=L&rs("CrewNames")
			L=L&"</CrewNames>"
			L=L&"<Done>--"
			L=L&rs("Done")
			L=L&"</Done>"
			
		L=L&"</Row"&SC&">"
		If SC>=100 Then Exit Do
		rs.MoveNext
	Loop
	L=L&"<RecordCount>"&SC&"</RecordCount>"
	
	set rs = nothing

	%><%=L%><%

'End LoadSchList~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





Case Else 
	 'oops 
	%>
<Error>No Routine Entry for '<%=sAction%>'</Error>
<%
				
End Select		

%>
</root>