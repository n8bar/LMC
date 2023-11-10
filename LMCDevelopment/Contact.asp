<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<title>Contact Information</title>
<!--#include file="Common.asp" -->

<script type="text/javascript" src="Contacts/Contact.js?noCache=<%=noCache%>"></script>
<script type="text/javascript" src="Contacts/ContactAJAX.js?noCache=<%=noCache%>"></script>

<link rel=stylesheet href="Library/CSS_DEFAULTS.css?noCache=<%=noCache%>" media=all>
<link rel=stylesheet href="Contacts/Contact.css?noCache=<%=noCache%>" media=all>
<%
If Session("user")="" Then 
	QS=request.QueryString
	If QS <> "" Then QS= "?"&QS
	Session("LoginDestination")="../LMCManagement/Contact.asp"&QS
	Response.Redirect("blank.html")
End If
 
'Sql0="SELECT Contacts FROM Access WHERE UserName='"&Session("user")&"'"
'Set rs0=Server.CreateObject("AdoDB.RecordSet")
'rs0.Open Sql0, REDConnString
'If rs0.EOF Then Response.Redirect("blank.html")
'If rs0("Contacts") <> "True" Then  Response.Redirect("blank.html")
 
contactId=Request.QueryString("id")

SQL="SELECT * FROM Contacts WHERE Id="&contactId
Set rs=Server.CreateObject("Adodb.RecordSet")
rs.Open SQL, REDConnString
 
cName=DecodeChars(rs("Name"))
Address=DecodeChars(rs("Address"))
City=DecodeChars(rs("City"))
cState=DecodeChars(rs("State"))
Zip=DecodeChars(rs("Zip"))
FullAddr=Address&", "&City&", "&cState&" "&Zip
Notes=DecodeChars(CR2Br(rs("Notes")&" "))

rbSQL="DELETE FROM RecentContacts WHERE ContactId="&ContactId
Set rbRS=Server.CreateObject("AdoDB.RecordSet")
rbRS.Open rbSQL, RedConnString

rbSQL="INSERT INTO RecentContacts (ContactId, UserId) VALUES ("&ContactId&","&Session("EmpId")&")"
%><span style="display:none;"><%=rbSQL%></span><%
Set rbRS=Server.CreateObject("AdoDB.RecordSet")
rbRS.Open rbSQL, RedConnString
Set rbRS=Nothing

DateStr=Date
timeStr=Time
tmr=timer
If (Instr(tmr,".") or Instr(".",tmr) ) Then mSec=split(tmr,".")(1) Else mSec=0
Hr=split(timeStr,":")(0)
Min=split(timeStr,":")(1)
Sec=split(split(timeStr,":")(2)," ")(0)
if split(timeStr," ")(1)="PM" and Hr<12 Then Hr=Hr+12
timeStr=Hr&":"&Min&":"&Sec&"."&mSec
NowStr=DateStr&" "&TimeStr

loSQL="UPDATE Contacts SET LastOpened='"&NowStr&"' WHERE Id="&ContactId
'% ><%=loSQL% ><%
Set loRS=Server.CreateObject("AdoDB.RecordSet")
loRS.Open loSQL, RedConnString
set loRS=Nothing

editLink="<a class=""editLink"" style=""z-index:10000;"" onclick=""editField(this.parentNode);"" >Edit</a>"
currencyLink="<a class=""editLink"" onclick=""editCurrency(this.parentNode);"" >Edit</a>"
dateLink="<a class=""editLink"" onclick=""dateField(this.parentNode)"" >Edit</a>"
notesLink="<a class=editLink onClick=editNotes(this.parentNode);>Edit</a>"
phoneLink="<a class=editLink onClick=editPhone(this.parentNode);>Edit</a>"
%>
<script type="text/javascript">
	var accessName='<%=Session("userName")%>';
	var editLink='<%=editLink%>';
	var ContactId=<%=ContactId%>;
	var editLink='<%=editLink%>';
	var currencyLink='<%=currencyLink%>';
	var dateLink='<%=dateLink%>';
	var notesLink='<%=notesLink%>';
	var phoneLink='<%=phoneLink%>';
</script>
</head>
<body onLoad="Resize(); " onResize="Resize();"> 

<div id=Modal onMouseMove="ModalMouseMove(event,'LinkerContainer');" align="center">
	<div style="width:100%; height:30%;"></div>
	<img src=../Images/roller.gif /><br/>
	<div id=modalStatus></div>
</div>
<div id="Employees" style="display:none;"><%EmployeeOptionList("active")%></div>

<div id=linkTypeBox class="WindowBox" align="center" >
	<div class="WindowTitle" style="background:#40631D; color:#fff; text-align:center;">Link Type<div class="redXCircle" onClick="hideLinkType();" >X</div></div>
	<br/>
	<div class="linkTypeBoxRow" style="height:26px;">
		<label class="newLinkLabel" for="cLinkTypes">New Link:</label>
		<select id=cLinkTypes>
      <option id=cLType0>&nbsp;</option>
      <%
      contactLinkTypeOptionList("cLType")
      %>
    </select>
    <big>&nbsp;</big>
	</div>
	<br/>
	<div class="linkTypeBoxRow" style="width:95%;">
		<button style="float:left;" onclick=hideNewLink();>cancel</button>
		<button style="float:right;" onclick="saveNewLink(Gebi('newLinkName').value);">&nbsp;Save&nbsp;</button>
	</div>
</div>

<div id=linkContactBox class="WindowBox" align="center" >
	<div class=WindowTitle style="background:#40631D; color:#fff; text-align:center;">
		Link Contact
		<div class=redXCircle onClick=hideLinkContact();>X</div>
	</div>
	<br/>
	<div class="linkTypeBoxRow" style="height:26px;">
		<form action="javascript:searchContact(Gebi('custName').value);">
			<label for="contactName" style="float:left; height:22px;">&nbsp;Contact:</label>
			<div style="border:#bbb 1px solid; float:left; height:22px; width:70%;">
				<input id=contactName class=newLinkTxt type=search style="border:0px transparent; float:left; height:100%; outline:none; width:70%;" />
				<input type=submit value="&nbsp;Search&nbsp;" style="height:100%; line-height:8px; width:30%;" />
			</div>
		</form>
	</div>
	<br/>
	<div id=contactList></div>
	<div class="linkTypeBoxRow" style="width:95%;">
		<button onclick=hideAddContact(); >&nbsp;Cancel&nbsp;</button>
	</div>
</div>

<div id="LinkerContainer"> 
	<div id="LinkerTitle" onmousedown="PartsMouseDown(event)" onmouseup="PartsMouseUp(event)" onMouseMove="ModalMouseMove(event,'LinkerContainer')" onselectstart="return false;" >Link a contact</div>
	<iframe id="LinkerBox" class="LinkerBox" src="ContactsInterface.asp?BoxID=LinkerContainer&ModalID=Modal&MM=parent.PartsMouseMove(event,'LinkerContainer')&MD=parent.PartsMouseDown(event)&MU=parent.PartsMouseUp(event)"></iframe>
</div>

 

<div id=mainToolbar class="Toolbar" style="background:none;">
	<button onClick="window.history.go(-1);" style="float:left;">◄Back</button>
	<button id="ReloadFrame" class="tButton24" onClick="window.location=window.location;" style="float:right;"/><img src="../Images/reloadblue24.png" /></button>
</div>

<div id=pathToolbar class="Toolbar" style="background:none;">
	<div id=path>&nbsp; My LMC > <a href="Contacts.asp?noCache="<%=noCache%>>Contacts</a> > <big><b><%=cName%></b></big></div>
</div>

<div id=TabsBar style="display:none;">
	<span id=ProjInfoTab class="activeTab" onClick=" showTab(this); ContactCost(ContactId); ">Contact Information</span>
	<span id=LinkTab class="tab" onClick="showTab(this);">Links Editor</span>
	<span id=PrintingTab class="tab" onClick="showTab(this);">Proposal Printing</span>
</div>

<div id="OuterBox">
	
	<div id=blankDiv style="display:none;"></div>
	
	<div id=ProjInfoPage class="activeTabPage">
		<div id=ProjInfoWidth>
			<div id=ProjInfoLeft>
				<div id=ProjInfoTitle class=ProjInfoTitle style="margin-top:1%;" >
					<div style=float:left;>Contact Information</div>
					<div id=ContactTotal class=total style="font-size:32px; float:right; line-height:20px; margin-right:8px;"></div>
				</div>
				<div id=ProjInfo class=ProjInfo height="178px" style="height:25%; min-height:146px;" >
					<% 
					rowCount=6
					iRowH=((100/rowCount)*3)/3 
					iRowMH=((146/rowCount)*3)/3 
					iColH=100'iRowH*(rowCount-1)
					iColMH=146'iRowMH*(rowCount-1)
					InfoCellStyle="height:"&iRowH&"%; max-height:"&iRowH&"%; min-height:"&iRowMH&"px; -moz-min-height:0px;"
					InfoBottomStyle="height:-moz-calc(100%-("&iRowH&"% * "&CStr(rowCount-1)&"); min-height:"&iRowMH&"px; -moz-min-height:0px;"
					%>
					<div class="labelColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
						<label style="<%=InfoCellStyle%>"><big>Contact Name</big></label>
						<label style="<%=InfoCellStyle%>">Address</label>
						<label style="<%=InfoCellStyle%>">City</label>
						<label style="<%=InfoCellStyle%>">State</label>
						<label style="<%=InfoCellStyle%>">Zip</label>
						<label style="<%=InfoCellStyle%>">Customer</label>
					</div>
					<div class="fieldColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
						<div class=fieldDiv style="<%=InfoCellStyle%> z-index:0;" id=Name ><%=editLink%><div><%=cName%></div></div>
						<div class=fieldDiv style="<%=InfoCellStyle%>" id="Address"><%=editLink&rs("Address")%></div>
						<div class=fieldDiv style="<%=InfoCellStyle%>" id=City><%=editLink&rs("City")%></div>
						<div class=fieldDiv style="<%=InfoCellStyle%>" id=State><%=rs("State")%></div>
						<div class=fieldDiv style="<%=InfoCellStyle%>" id=Zip><%=editLink&rs("Zip")%></div>
						<%If rs("Customer")="True" Then chk="checked" else chk=""%>
						<label class="fieldDiv" style="<%=InfoCellStyle%>">&nbsp; &nbsp; &nbsp; <input id=Customer type=checkbox <%=chk%> onChange="eCheck(this.id,this.checked);" /></label>
					</div>
					<div class="labelColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
						<label style="<%=InfoCellStyle%>">Primary Phone</label>
						<label style="<%=InfoCellStyle%>">Secondary Phone</label>
						<label style="<%=InfoCellStyle%>">Fax</label>
						<label style="<%=InfoCellStyle%>">Email</label>
						<label style="<%=InfoCellStyle%>">Website</label>
						<label style="<%=InfoCellStyle%>">Vendor</label>
					</div>
					<div class="fieldColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
						<div class=fieldDiv id=Phone1 style="<%=InfoCellStyle%>"><%=phoneLink&rs("Phone1")%></div>
						<div class=fieldDiv id=Phone2 style="<%=InfoCellStyle%>"><%=phoneLink&rs("Phone2")%></div>
						<div class=fieldDiv id=Fax style="<%=InfoCellStyle%>"><%=phoneLink&rs("Fax")%></div>
						<div class=fieldDiv id=Email style="<%=InfoCellStyle%>"><%=editLink&rs("Email")%></div>
						<div class=fieldDiv id=Website style="<%=InfoCellStyle%>"><%=editLink&rs("Website")%></div>
						<%If rs("Vendor")="True" Then chk="checked" else chk=""%>
						<label class="fieldDiv" style="<%=InfoCellStyle%>">&nbsp; &nbsp; &nbsp; <input id=Vendor type=checkbox <%=chk%> onChange="eCheck(this.id,this.checked);" /></label>
					</div>
				</div>
				
				<!--
				<div id=LocationInfo class=ProjInfo height="82px" style="height:82px;">
					<div id="LocationInfoTitle" class="ProjInfoTitle">Location Information</div>
					<div class="labelColumn w25p">
					</div>
					<div class="fieldColumn w25p">
					</div>
					<div class="labelColumn w25p">
					</div>
					<div class="fieldColumn w25p">
					</div>
				</div>
				-->
				<div id=LinksTitle class=ProjInfoTitle>Linked Contacts</div>
				<div id=Links class=ProjInfo height=auto style="height:auto; margin-top:0;">
					<div class=ProjInfoHeading>
						<div class="fL taC w33p">&nbsp;</div>
						<div class="fL taC w33p">Name</div>
						<div class="fL taC w33p">Number</div>
					</div>
					<iframe class="fieldColumn w100p h200" style="border:none;" src="ContactList.asp?noCache=<%=noCache%>&LinksTo=<%=ContactId%>"></iframe>
					<!-- div class="fieldColumn w33p" style="height:218px; overflow-x:hidden; overflow-y:auto;"></div -->
				</div>				
			</div>
			
			<div id=ProjInfoRight >
				<div id="NotesTitle" class="ProjInfoTitle">Notes</div>
				<div id=Notes class=ProjInfo height=420px style="min-height:420px; height:25%;">
					<!--
					<div class="labelColumn w15p" onDblClick="editNotes(Gebi('Notes'));" style="height:100%;">
						<label style="height:100%; padding-top:50%;" onDblClick="editNotes(Gebi('Notes'));">Notes</label>
					</div>
					-->
					<div class="fieldColumn w100p h100p" >
						<div id=Notes class=fieldDiv style="height:100%; white-space:pre-wrap;"><%=notesLink&Notes%></div>
						<div id=oldNotes class=fieldDiv style="display:none;"></div>
					</div>
				</div>
				
				<br/>
				
				<!-- div id=LinksTitle class="ProjInfoTitle">
					<span style="float:left;">Linked Contacts</span>
					<button onclick="deleteCusts();" style="float:right; width:24px;" title="Remove All Customers"><img src="../images/delete16.PNG"></button>
					<button onclick="showAddCust();" style="float:right; width:24px;" title="Add a Customer"><img src="../images/plus_16.PNG"></button>
				</div -->
				
			</div>
		</div>
	</div>
	
	<div id=LinkPage class="tabPage"></div>
	<div id=PrintingPage class="tabPage"></div>
	
</div>
<br/>
</body>
</html>