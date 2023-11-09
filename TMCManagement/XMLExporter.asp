
<!--#include file="../LMC/RED.asp" -->
<%
Response.ContentType = "text/xml"
If Request.QueryString("html")=1 Then Response.ContentType = "text/html"
Response.Buffer="false"
sAction = lcase(CStr(Request.QueryString("action")))
%>
<root>
	<action><%=sAction%></action>
<%
	'<QueryString><%=EncodeChars(Request.QueryString())% ></QueryString>



Set Conn = Server.CreateObject ("ADODB.Connection")
Conn.Open REDConnString
Const adSchemaColumns=4

Function getTableColumns(table)
	Set ColumnsSchema = Conn.OpenSchema(adSchemaColumns, Array(Empty, Empty, ""&table))
	ColumnNames=""
	WriteColumns=""
	Loops=0
	Do Until ColumnsSchema.EOF
		Loops=Loops+1
		If ColumnNames<>"" Then ColumnNames=ColumnNames&","
		If WriteColumns<>"" Then WriteColumns=WriteColumns&","
		
		ColumnNames=ColumnNames&ColumnsSchema("COLUMN_NAME")
		If Loops>1 Then WriteColumns=WriteColumns&ColumnsSchema("COLUMN_NAME")
		
		ColumnsSchema.MoveNext
	Loop
	getTableColumns=Split(ColumnNames,",")

End Function

Set shell=CreateObject("WScript.Shell")

'shell.run "c:\Inetpub\wwwroot\cmd.exe /c ""cd \Inetpub\wwwroot"""
'shell.run "c:\Inetpub\wwwroot\cmd.exe /c ""c:\info2.bat"""


Function Output(outputStr)
	Str="c:\Inetpub\wwwroot\cmd.exe /c ""c:\Inetpub\wwwroot\n8echo.exe "&EncodeChars(outputStr)&""" >> "&oPath&oFileName
	'Str="c:\Inetpub\wwwroot\cmd.exe /c ""c:\Inetpub\wwwroot\n8echo.exe "&EncodeChars(outputStr)&""" >> "&oPath&oFileName
	Response.Write(DecodeChars(outputStr))
	'shell.run Str
	Output = Str
End Function

Sub Sleep(milliseconds)
	t=timer
	Do while timer<t+milliseconds
		a=a+1
	Loop
End Sub

Select Case sAction
	
	Case "project"'-----------------------------------------------------------------------------------------
		
		timest=right("0000"&Year(Date),2)&right("00"&Month(Date),2)&right("00"&Day(Date),2)
		timest=timest&right("00"&Hour(Time),2)&right("00"&Minute(Time),2)&right("00"&Second(Time),2)
		ProjId=Request.QueryString("id")
		dlPath="../downloads/projects/"
		oPath = "C:\inetpub\wwwroot\downloads\projects\"
		oFilename=ProjID&"-"&timest&".xml"'.tmcProject"
		
		shell.run "c:\Inetpub\wwwroot\cmd.exe /c ""c:\Inetpub\wwwroot\n8echo.exe _LT_root_GT_  >> "&oPath&oFileName&""""
		Sleep(1)
		shell.run "c:\Inetpub\wwwroot\cmd.exe /c ""c:\Inetpub\wwwroot\n8echo.exe _LT_action_GT_project_LT_/action_GT_  >> "&oPath&oFileName&""""
		'response.write("c:\Inetpub\wwwroot\cmd.exe /c ""n8echo.exe _LT_root_GT_  >> "&oPath&oFileName&"""")
		'response.end()
				
		
		'shell.run "c:\Inetpub\wwwroot\cmd.exe /c ""c:\Inetpub\wwwroot\n8echo.exe "&EncodeChars("<data>")&" >> "&oPath&oFileName
		
		Columns=getTableColumns("Projects")
		SQL="SELECT * FROM Projects WHERE ProjId="&ProjId
		Set rs=server.CreateObject("AdoDB.recordSet")
		rs.Open SQL, REDConnString
		xmlData=chr(13)
		For c=0 to uBound(Columns)
			xmlData=xmlData&"		<"&Columns(c)&">"&rs(Columns(C))&"</"&Columns(c)&">"&Chr(13)
		Next
		Shell.Run Output("	<data>"&xmlData&"</data>")
		
		Columns=getTableColumns("BidTo")
		SQL="SELECT * FROM BidTo WHERE ProjId="&ProjId
		Set rs=server.CreateObject("AdoDB.recordSet")
		rs.Open SQL, REDConnString
		cCount=0
		Do Until rs.EOF
			xmlData=chr(13)
			For c=0 to uBound(Columns)
			xmlData=xmlData&"		<"&Columns(c)&">"&rs(Columns(C))&"</"&Columns(c)&">"&chr(13)
			Next
			Shell.Run Output("	<customers__"&cCount&">"&xmlData&"</customers__"&cCount&">")
			cCount=cCount+1
			rs.MoveNext
		Loop
		Shell.Run Output("<CustCount>"&cCount&"</CustCount>")
		
		Columns=getTableColumns("Systems")
		SQL="SELECT * FROM Systems WHERE ProjectID="&ProjId
		Set rs=server.CreateObject("AdoDB.recordSet")
		rs.Open SQL, REDConnString
		sCount=0

		Do Until rs.EOF
			Sleep(1)
			Shell.Run Output("	<systems__"&sCount&" name="""&rs("System")&"""> ")
			xmlData=chr(13)
			For c=0 to uBound(Columns)
				xmlData=xmlData&"			<"&Columns(c)&">"&rs(Columns(C))&"</"&Columns(c)&">"&chr(13)
			Next
			Shell.Run Output("	 <data>"&xmlData&"</data>")
			
			biColumns=getTableColumns("BidItems")
			sysSQL="SELECT * FROM BidItems WHERE SysID="&rs("SystemId")
			Set sysRS=server.CreateObject("AdoDB.recordSet")
			sysRS.Open sysSQL, REDConnString
			biCount=0
			Do Until sysRS.EOF
				xmlData=chr(13)
				For c=0 to uBound(biColumns)
					xmlData=xmlData&"			<"&biColumns(c)&">"&sysRS(biColumns(c))&"</"&biColumns(c)&">"&chr(13)
				Next
				Shell.run Output("		<bidItems__"&biCount&">"&xmlData&"</bidItems__"&biCount&">")
				biCount=biCount+1
				sysRS.MoveNext
			Loop
			Shell.run Output("		<biCount>"&biCount&"</biCount>")
			Shell.Run Output("	</systems__"&sCount&"> ")
			sCount=sCount+1
			rs.MoveNext
		Loop
		Shell.run Output("	<sysCount>"&sCount&"</sysCount>")
		
		Sleep(.5)
		shell.run "c:\Inetpub\wwwroot\cmd.exe /c ""c:\Inetpub\wwwroot\n8echo.exe _LT_/root_GT_  >> "&oPath&oFileName&""""
		

	Case Else '══════─
		%>
		<error>No subroutine found for:<%=sAction%> </error>
		<%
End Select		

%>
</root>