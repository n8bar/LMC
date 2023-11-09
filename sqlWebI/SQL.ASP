<!--#include file="../LMC/RED.asp" -->
<!--#include file="adovbs.inc" -->
<!DOCTYPE html>
<html>
<head>
<title>SQL Web Interface</title>
<script type="text/javascript" src="./../tmcManagement/Modules/rcstri.js"></script>
<script type="text/javascript" src="SqlAJAX.js"></script>
<style>
a{font-size:18px; font-family:Verdana, Arial, Helvetica, sans-serif;}
a:hover{font-size:17px; font-weight:bold;}

body{width:100%; margin:0; padding:0;}
html{width:100%; margin:0; padding:0;}

a,b,button,div,input,p,select,textarea{box-sizing:border-box; -moz-box-sizing:border-box; margin:0; padding:0;}

.HeadItem{display:inline-block; overflow:hidden; white-space:nowrap; text-overflow:ellipsis; border:1px #000 solid; border-left:none; min-width:96px;}
.ListItem{display:inline-block; position:relative; border:1px #CCC solid; border-left:none; min-width:96px;}
.ListItemIDBox{height:100%; min-width:96px;}
</style>
</head>
<body align=center>
<%
	Set Conn = Server.CreateObject ("ADODB.Connection")
	
	Conn.Open REDConnString
	
	Set Rs = Conn.OpenSchema (adSchemaTables)
	
	Table=Request.QueryString("Table")
	%>
	<select onchange="window.location='SQL.ASP?Table='+this[this.selectedIndex].value;">
	<%	
	Do While Not Rs.EOF
		tName=Rs("TABLE_NAME")
		If Table=tName Then Selected="Selected" Else Selected=""
		If instr(tName,"_") < 1 Then
			%>
			<option value="<%=tName%>" <%=Selected%>><%=tName%></option>
			<%
		End if
		Rs.MoveNext
	Loop
	%>
	</select>
	<%	

	Set Rs=Nothing
	'Set Conn=Nothing
	
%>
<hr/>
<%
	
	
	
	Set RS=Server.CreateObject("AdoDB.RecordSet")
	rsEOF=True
	If Table <> "" Then
		SQL="SELECT * From "&Table
		RS.Open SQL, REDConnString
		rsEOF=RS.EOF
	End If
	If Table="" OR rsEOF Then
		%>
		<p>Please Choose a table</p>
		<%
	Else
	
		Set ColumnsSchema = Conn.OpenSchema(adSchemaColumns, Array(Empty, Empty, "" & Table))
		Columns=""
		WriteColumns=""
		Loops=0
		Do Until ColumnsSchema.EOF
			Loops=Loops+1
			If Columns<>"" Then Columns=Columns&","
			If WriteColumns<>"" Then WriteColumns=WriteColumns&","
			
			Columns=Columns&ColumnsSchema("COLUMN_NAME")
			If Loops>1 Then WriteColumns=WriteColumns&ColumnsSchema("COLUMN_NAME")
			
			ColumnsSchema.MoveNext
		Loop
		Cols=Split(Columns,",")
	
	
		totalCols=uBound(Cols)+1
		colWidth=(int(10000/totalCols)/100)*.99
		%>
		<div style="width:auto; height:22px; white-space:nowrap; text-align:left;">
			<%
			For C = 0 to uBound(Cols)
				%><div class="HeadItem" style="width:<%=colWidth%>%;" title="<%=Cols(c)%>"><%=Cols(c)%></div><%
			Next
			%>
		</div >
		<%
		SQLKey="SELECT * FROM TableKeys WHERE TableName='"&Table&"'"
		Set rsKey=Server.CreateObject("Adodb.RecordSet")
		rsKey.Open SQLKey, REDConnString
		If rsKey.EOF Then 
			%>TableKey is unkown: Table is not accessible.<%
			Response.End() 
		End If
		KeyName=rsKey("TableKey")
		OrderField=rsKey("OrderField")
		Set rsKey=Nothing
		%>
		<div style="width:auto; height:22px; white-space:nowrap; text-align:left;">
			<div class=HeadItem style="width:<%=colWidth%>%; height:100%; font-size:10px; font-family:Arial, Helvetica, sans-serif;">
				<button style="float:right; height:100%; font:inherit;"
					onclick="
						var SQL=' INSERT INTO <%=Table%> (<%=WriteColumns%>) ';
						SQL+='VALUES';
						
						<%	theValue="'+Gebi('txt"&Cols(1)&"').value+'"	%>
						SQL+='( \'<%=theValue%>\'';
						<%
						For C= 2 to uBound(Cols)
							theValue="'+Gebi('txt"&Cols(C)&"').value+'"
							%>SQL+=', \'<%=theValue%>\'';
							<%
						Next
						%>
						SQL+=')';
						
						//alert(SQL);
						SendSQL('Write',SQL);
						window.location=window.location;
					"
				>Save New─►</button>
			</div><%
			
			
			For C = 1 to uBound(Cols)
				%><input id="txt<%=Cols(c)%>" class="ListItem" style="width:<%=colWidth%>%; height:100%; background-color:#EFE; top:-6px;" title="<%=Cols(c)%>"
				/><%
				
			Next
			%>
			
		</div >
		<%
		SQL="SELECT * FROM "&Table&" ORDER BY "&OrderField&" DESC"
		Set rs=Server.CreateObject("Adodb.RecordSet")
		rs.Open SQL, REDConnString
		
		
		Max=4096
		LoopI=0
		Do Until rs.EOF
			LoopI=LoopI+1
			%><div style="width:100%; height:18px; float:left; font-size:16px; white-space:nowrap; text-align:left;"><%
			%><div class=ListItemIDBox style="border:2px rgba(0,0,0,.5) solid; border-bottom:none; float:left; height:100%; padding:0 0 1px 0; text-align:center; width:<%=colWidth%>%;"><%=rs(Cols(0))%></div><%
			For C = 1 to uBound(Cols)
				colValue=rs(Cols(C))
				%><input class="ListItem" style="width:<%=colWidth%>%; height:100%;" title="<%=colValue%>" value="<%=colValue%>" onkeyup="this.style.backgroundColor='#FCC'; this.changed=true;" <% 
				If KeyName = Cols(C) Then
				%> readonly=True <%
				Else
					If KeyName <> "" Then
						%> onblur="if(this.changed)	{
								SendSQL('Write','UPDATE <%=Table%> SET <%=Cols(C)%>=(N\''+this.value+'\') WHERE <%=KeyName%>=\'<%=rs(KeyName)%>\'');
								this.style.background='none';
								this.changed=false;
							}"
						<%
					End If
				%>/><%
				End If
			Next
			%></div><%
			if LoopI/100 = Round(LoopI/100) Then Response.Flush()
			If LoopI>=Max Then Exit Do
			rs.MoveNext
		Loop
		
	End If
%>
</body>
</html>