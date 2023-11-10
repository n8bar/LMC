<!-- #include file="../LMC/RED.asp" -->
<%

'noCache=Request.QueryString("noCache") : if noCache="" Then noCache="0"
parentNoCache=Request.QueryString("nc") : if parentNoCache="" Then parentNoCache="0"
noCache=SessionID&Timer
loadStamp=Year(Date)&Month(Date)&Day(Date)&fix(Timer)

'LoginCheck()
%>
<script>
var noCache=<%=noCache%>;
var parentNoCache=<%=parentNoCache%>;
var loadStamp=<%=loadStamp%>;
var sessionID=<%=Session.SessionID%>;
//try {
	var sessionEmpID=<%=Session("EmpID")%>;
	var accessUser='<%=Session("User")%>';
//}
//catch(e) {
//	sessionWrite('LoginDestination',location);
//	location='../LMC/LMC.html';
//}
</script>

<script type='text/javascript' src='../lib/jquery/jquery-1.5.1.min.js?nc=<%=noCache%>'></script>
<script type='text/javascript' src='../lib/jquery/jquery-ui-1.8.10.custom.min.js?nc=<%=noCache%>'></script>
<script type='text/javascript' src='../lib/jquery/jquery-upl-colorpicker.js?nc=<%=noCache%>'></script>
<script type='text/javascript' src='../lib/jquery/jquery-upl-easing.1.3.js?nc=<%=noCache%>'></script>
<script type='text/javascript' src='../lib/jquery/jquery-upl-windowAero.js?nc=<%=noCache%>'></script>
<link rel='stylesheet' href='../lib/jquery/css/ui-lightness/AeroWindow.css?nc=<%=noCache%>' />
<link rel='stylesheet' href='../lib/jquery/css/ui-lightness/colorpicker.css?nc=<%=noCache%>' />
<link rel='stylesheet' href='../lib/jquery/css/ui-lightness/jquery-ui-1.8.10.custom.css?nc=<%=noCache%>' />

<%

'Employee Drop-Down:


Sub EmployeeOptionList(Opt)
	LoginCheck
	
	Select Case lcase(Opt)
		
		Case "all"
			empSQL="SELECT EmpID, FName, LName FROM Employees ORDER BY FName, LName"
		
		Case "allactive"
			empSQL="SELECT EmpID, FName, LName FROM Employees WHERE Active=1 ORDER BY FName, LName"
			selectUser=False
			
		Case Else '"active"
			empSQL="SELECT EmpID, FName, LName FROM Employees WHERE Active=1 ORDER BY FName, LName"
			selectUser=True
		
	End Select
	
	set empRS=Server.CreateObject("AdoDB.Recordset")
	empRS.Open empSQL, REDConnString
	
	Do Until empRS.EOF
		if selectUser AND empRS("EmpID")=Session("EmpId") Then 
			selected=" selected="""&DoSelect&""" "
		Else
			selected=""
		End If
			%><option value="<%=empRS("EmpID")%>" <%=selected%>><%=empRS("FName")&" "&empRS("LName")%></option><%
		empRS.MoveNext
	Loop
	
End Sub



Sub ProjectOptionList(Opt)
	LoginCheck
	
	Where=""
	Select Case lcase(Opt)
		
		Case "all"
			Where=" WHERE Obtained=1"
		
		Case "active"
			Where=" WHERE Active=1 AND Obtained=1"
			
		Case "old"
			Where=" WHERE Active=0 AND Obtained=1"
		
	End Select
	
	pSQL="SELECT ProjID, ProjName, ProjCity, ProjState FROM Projects "&Where&" ORDER BY ProjName"
	
	set pRS=Server.CreateObject("AdoDB.Recordset")
	pRS.Open pSQL, REDConnString
	
	Do Until pRS.EOF
			%><option value="<%=pRS("ProjID")%>" <%=selected%>><%=DecodeChars(pRS("ProjName")&" - "&pRS("ProjCity")&", "&pRS("ProjState"))%></option><%
		pRS.MoveNext
	Loop
	
End Sub

Function ProjectListChoose(Id,Opt)
	LoginCheck
	
	Where=""
	Select Case lcase(Opt)
		
		Case "all"
			Where=" WHERE Obtained=1"
		
		Case "active"
			Where=" WHERE Active=1 AND Obtained=1"
			
		Case "old"
			Where=" WHERE Active=0 AND Obtained=1"
		
	End Select
	
	pSQL="SELECT ProjID, ProjName, ProjCity, ProjState FROM Projects "&Where&" ORDER BY ProjName"
	
	set pRS=Server.CreateObject("AdoDB.Recordset")
	pRS.Open pSQL, REDConnString
	
	Do Until pRS.EOF
		If pRS("ProjID")*1=Id*1 Then Selected="Selected=""true""" Else selected=""
			ProjectListChoose=ProjectListChoose&"<option value="""&pRS("ProjID")&""" "&selected&" >"&DecodeChars(pRS("ProjName")&" - "&pRS("ProjCity")&", "&pRS("ProjState"))&"</option>"
		pRS.MoveNext
	Loop
	
End Function




Sub AreaOptionList(Opt)
'	Select Case lcase(Opt)
'		Case "all"
'			areaSQL="SELECT AreaID, AreaDescription FROM Area ORDER BY AreaDescription"
'		case else	
'			areaSQL="SELECT AreaID, AreaDescription FROM Area ORDER BY AreaDescription"
'	End Select
'	set areaRS=Server.CreateObject("ADODB.Recordset")
'	areaRS.Open areaSQL, REDConnString
'	Do Until areaRS.EOF
'			% ><option value="<%=areaRS("AreaID")% >" ><%=areaRS("AreaDescription")% ></option><%
'		areaRS.MoveNext
'	Loop
End Sub



Sub StateOptionList(Opt)
	
	stSQL="SELECT Abbr, State FROM States"
	
	set stRS=Server.CreateObject("ADODB.Recordset")
	stRS.Open stSQL, REDConnString
	
	Do Until stRS.EOF
		Select Case Opt
			Case "Abbr"
				Val=stRS("Abbr")
				Desc=stRS("Abbr")
			Case Else
				Val=stRS("Abbr")
				Desc=stRS("Abbr")&" "&stRS("State")
		End Select
		%><option value="<%=Val%>" ><%=Desc%></option><%
		stRS.MoveNext
	Loop
	
End Sub


Sub SecTypesOptionList(idPrefix)
	sSQL="SELECT SectionID, SectionName FROM SectionList ORDER BY SectionName"
	Set sRS=Server.CreateObject("AdoDB.RecordSet")
	sRS.Open sSQL, REDConnString
	Do Until sRS.EOF
		%><option id=<%=idPrefix&sRS("SectionID")%> value="<%=sRS("SectionID")%>" ><%=DecodeChars(sRS("SectionName"))%></option><%
		sRS.MoveNext
	Loop
End Sub


Sub MfrOptionList(idPrefix)
  mSQL="SELECT ManufID, Name from Manufacturers ORDER BY Name"
	Set mRS=Server.CreateObject("AdoDB.RecordSet")
	mRS.Open mSQL, REDConnString
	Do Until mRS.EOF
    %><option id=<%=idPrefix&mRS("ManufID")%> value="<%=mRS("ManufID")%>"><%=mRS("Name")%></option><%
		mRS.MoveNext
	Loop
End Sub

Sub CategoryOptionList(idPrefix)
  catSQL="SELECT CategoryID, Category from Categories ORDER BY Category"
	Set catRS=Server.CreateObject("AdoDB.RecordSet")
	catRS.Open catSQL, REDConnString
	Do Until catRS.EOF
    %><option id=<%=idPrefix&catRS("CategoryID")%> value="<%=catRS("CategoryID")%>"><%=catRS("Category")%></option><%
		catRS.MoveNext
	Loop
End Sub





Sub ContactsOptionList(Opt)
		
	cSQL="SELECT ID, Name FROM Contacts"
	
	Where=""
	Select Case lCase(Opt)
		Case "vendors"
			Where=" WHERE Vendor=1"
			
		Case "customers"
			Where=" WHERE Customer=1"
	End Select
	
	cSQL=cSQL&Where&" ORDER BY Name"
	
	set cRS=Server.CreateObject("ADODB.Recordset")
	cRS.Open cSQL, REDConnString
	
	Do Until cRS.EOF
		%><option id=<%=Opt%>Contact<%=cRS("ID")%> value="<%=cRS("ID")%>" ><%=DecodeChars(cRS("Name"))%></option><%
		cRS.MoveNext
	Loop
	
	Set cRS=Nothing
	
End Sub

Sub HandyContactLister(custvend,element)
		
	cSQL="SELECT ID, Name FROM Contacts"
	
	Where=""
	Select Case lCase(custvend)
		Case "vendors"
			Where=" WHERE Vendor=1"
			
		Case "customers"
			Where=" WHERE Customer=1"
	End Select
	
	cSQL=cSQL&Where&" ORDER BY Name"
	
	set cRS=Server.CreateObject("ADODB.Recordset")
	cRS.Open cSQL, REDConnString
	
	Do Until cRS.EOF
		%><<%=element%> id=<%=custvend%>Contact<%=cRS("ID")%> value="<%=cRS("ID")%>" ><%=DecodeChars(cRS("Name"))%></<%=element%>><%
		cRS.MoveNext
	Loop
	
	Set cRS=Nothing
	
End Sub



Sub contactLinkTypeOptionList(idPrefix)
  mSQL="SELECT ManufID, Name from Manufacturers ORDER BY Name"
	Set mRS=Server.CreateObject("AdoDB.RecordSet")
	mRS.Open mSQL, REDConnString
	Do Until mRS.EOF
    %><option id=<%=idPrefix&mRS("ManufID")%> value="<%=mRS("ManufID")%>"><%=mRS("Name")%></option><%
		mRS.MoveNext
	Loop
End Sub

%>
<script type="text/javascript" src="Modules/rcstri.js?nocache=<%=timer%>"></script>
<script type="text/javascript" src="Library/SqlAjax.js?nocache=<%=timer%>"></script>
<script type="text/javascript" src="Library/dhtmlgoodies_calendar.js?nocache=<%=timer%>"></script>
<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?nocache=<%=timer%>" media="all">
<link rel="stylesheet" href="Library/CSS_DEFAULTS.css?nocache=<%=timer%>" media="all">

<style media="all">

<%
For p= 0 to 100 step .25
	'if (p=fix(p)) then 
	'	% ><%=chr(13)&chr(10)%><% 
	'End If
		
	pdec=replace(p,".","p")
	%>.w<%=pdec%>p {width:<%=p%>% !important;} <%
	%>.h<%=pdec%>p {height:<%=p%>% !important;} <%
	%>.m<%=pdec%>p {margin:<%=p%>% !important;} <%
	%>.mT<%=pdec%>p {margin-top:<%=p%>% !important;} <%
	%>.mR<%=pdec%>p {margin-right:<%=p%>% !important;} <%
	%>.mB<%=pdec%>p {margin-bottom:<%=p%>% !important;} <%
	%>.mL<%=pdec%>p {margin-left:<%=p%>% !important;} <%
	%>.p<%=pdec%>p {padding:<%=p%>% !important;} <%
	%>.pT<%=pdec%>p {padding-top:<%=p%>% !important;} <%
	%>.pR<%=pdec%>p {padding-right:<%=p%>% !important;} <%
	%>.pB<%=pdec%>p {padding-bottom:<%=p%>% !important;} <%
	%>.pL<%=pdec%>p {padding-left:<%=p%>% !important;} <%
	%>.o<%=pdec%> {opacity:<%=p%>% !important;} <%

	%>.shade<%=pdec%> { <%
		%>background:-webkit-gradient(linear,0 100%,0 0, from(rgba(0,0,0,.<%=right("0"&p,2)%>)), to(rgba(255,255,255,0)));<%
		%>background:-moz-linear-gradient(top, rgba(0,0,0,<%=p%>%), rgba(255,255,255,0));<%
	%>}<%
	
	%><%=chr(13)&chr(10)%><% 
	if p/10 = fix(p/10) then %><%=chr(13)&chr(10)%><% End If
Next

%><%=chr(13)&chr(10)&chr(13)&chr(10)&chr(13)&chr(10)%><%

For h= 0 to 1080
	%>.h<%=h%> {height:<%=h%>px !important;} <%
	%>.mT<%=h%> {margin-top:<%=h%>px !important;} <%
	%>.mB<%=h%> {margin-bottom:<%=h%>px !important;} <%
	%>.pT<%=h%> {padding-top:<%=h%>px !important;} <%
	%>.pB<%=h%> {padding-bottom:<%=h%>px !important;} <%
	%>.fS<%=h%> {font-size:<%=h%>px !important;} <%
	%>.lH<%=h%> {line-height:<%=h%>px !important;}<%
	%><%=chr(13)&chr(10)%><%
	if h/10 = fix(h/10) then %><%=chr(13)&chr(10)%><% End If
Next
For w= 1 to 1920
	%>.w<%=w%> {width:<%=w%>px !important;} <%
	%>.m<%=w%> {margin:<%=w%>px !important;} <%
	%>.mT<%=w%> {margin-top:<%=w%>px !important;} <%
	%>.mR<%=w%> {margin-right:<%=w%>px !important;} <%
	%>.mB<%=w%> {margin-bottom:<%=w%>px !important;} <%
	%>.mL<%=w%> {margin-left:<%=w%>px !important;} <%
	%>.p<%=w%> {padding:<%=w%>px !important;} <%
	%>.pT<%=w%> {padding-top:<%=w%>px !important;} <%
	%>.pR<%=w%> {padding-right:<%=w%>px !important;} <%
	%>.pB<%=w%> {padding-bottom:<%=w%>px !important;} <%
	%>.pL<%=w%> {padding-left:<%=w%>px !important;} <%
	%><%=chr(13)&chr(10)%><%
	if w/10 = fix(w/10) then %><%=chr(13)&chr(10)%><% End If
Next

%>

.w66-7p {width:66.66667% !important;}
.w66p {width:66.6666% !important;}
.w33p {width:33.3333% !important;}
.w33-4p {width:33.3334% !important;}
.w17p {width:16.6667% !important;}
.w16p {width:16.6666% !important;}

</style>