<!--#include file="../TMC/RED.asp" -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<title>TMC Estimates</title>
<!--#include file="common.asp" -->

<script type="text/javascript" src="Service/mAccount.js?noCache=<%=noCache%>"></script>
<script type="text/javascript" src="Service/mAccountAJAX.js?noCache=<%=noCache%>"></script>

<link rel=stylesheet href="Library/CSS_DEFAULTS.css?noCache=<%=noCache%>" media=all>
<link rel=stylesheet href="Service/mAccount.css?noCache=<%=noCache%>" media=all>
<%
If Session("user")="" Then 
	QS=request.QueryString
	If QS <> "" Then QS= "?"&QS
	Session("LoginDestination")="../TMCManagement/BidAccount.asp"&QS
	Response.Redirect("blank.html")
End If
 
Sql0="SELECT Service FROM Access WHERE UserName='"&Session("user")&"'"
Set rs0=Server.CreateObject("AdoDB.RecordSet")
rs0.Open Sql0, REDConnString

If rs0.EOF Then Response.Redirect("blank.html")
If rs0("Service") <> "True" Then  Response.Redirect("blank.html")
 
acctId=Request.QueryString("id")

SQL="SELECT TOP 1 * FROM MonitoringAccounts WHERE Id="&acctId&" OR cKey='"&acctId&"'"
Set rs=Server.CreateObject("Adodb.RecordSet")
%><%'=SQL%><%
rs.Open SQL, REDConnString


acctId=rs("id") 
sName=DecodeChars(rs("SiteName"))
Address=DecodeChars(rs("Addr"))
City=DecodeChars(rs("City"))
RCSNotes=DecodeChars(CR2Br(rs("Notes")&" "))


Customer="[unknown]"
CustId=rs("CustId")
If IsNull(CustId) or CustId="" Then
Else
	custSQL="SELECT Top 1 Name From Contacts WHERE Id="&CustId
	Set custRS=Server.CreateObject("AdoDB.RecordSet")
	%><%'=custSQL%><%
	custRS.Open custSQL, RedConnString
	If not CustRS.EOF Then Customer = DecodeChars(CustRS("Name"))
End If

Provider="[unknown]"
ProvId=rs("ProviderId")
If IsNull(ProvId) or ProvId="" Then
Else
	provSQL="SELECT Top 1 Name From Contacts WHERE Id="&ProvId
	Set provRS=Server.CreateObject("AdoDB.RecordSet")
	%><%'=custSQL%><%
	provRS.Open provSQL, RedConnString
	If not ProvRS.EOF Then Provider = DecodeChars(provRS("Name"))
End If

rbSQL="DELETE FROM RecentMonitoring WHERE Id="&acctId
Set rbRS=Server.CreateObject("AdoDB.RecordSet")
rbRS.Open rbSQL, RedConnString

rbSQL="INSERT INTO RecentMonitoring (AccountId, userID) VALUES ("&acctId&", "&Session("EmpId")&")" 
'% ><%=rbSQL% ><%
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

loSQL="UPDATE MonitoringAccounts SET LastOpened='"&NowStr&"' WHERE Id="&acctId
'% ><%=loSQL% ><%
Set loRS=Server.CreateObject("AdoDB.RecordSet")
loRS.Open loSQL, RedConnString
set loRS=Nothing

editLink="<a class=""editLink"" style=""z-index:10000;"" onclick=""editField(this.parentNode);"" >Edit</a>"
currencyLink="<a class=""editLink"" onclick=""editCurrency(this.parentNode);"" >Edit</a>"
dateLink="<a class=""editLink"" onclick=""dateField(this.parentNode)"" >Edit</a>"
notesLink="<a class=editLink onClick=editNotes(this.parentNode);>Edit</a>"
phoneLink="<a class=editLink onClick=editPhone(this.parentNode);>Edit</a>"
custLink="<a class=editLink onClick=showAddCust();>Edit</a>"
provLink="<a class=editLink onClick=showAddProv();>Edit</a>"
%>
<script type="text/javascript">
	var accessEmpName='<%=Session("userName")%>';
	var editLink='<%=editLink%>';
	var acctId=<%=acctId%>;
	var editLink='<%=editLink%>';
	var currencyLink='<%=currencyLink%>';
	var dateLink='<%=dateLink%>';
	var notesLink='<%=notesLink%>';
	var phoneLink='<%=phoneLink%>';
	var custLink='<%=custLink%>';
	var provLink='<%=provLink%>';
	
	var AcctId=<%=acctId%>;
</script>
	

</head>
<body onLoad="Resize();" onResize="Resize();"> 

<div id=Modal onMouseMove="ModalMouseMove(event,'addCustBox');" align="center">
	<div style="width:100%; height:30%;"></div>
	<img src=../Images/roller.gif /><br/>
	<div id=modalStatus></div>
</div>
<div id="Employees" style="display:none;"><%EmployeeOptionList("active")%></div>

<div id=NewSysBox class="WindowBox" align="center" >
	<div class="WindowTitle" style="background:#40631D; color:#fff; text-align:center;">New System<div class="redXCircle" onClick="hideNewSys();" >X</div></div>
	<br/>
	<div class="newSysBoxRow" style="height:26px;">
		<label class="newSysLabel" for="nbAcctName">New System:</label>
		<input id="newSysName" type="text" class="newSysTxt" /><big>&nbsp;</big>
	</div>
	<br/>
	<div class="newSysBoxRow" style="width:95%;">
		<button style="float:left;" onclick=hideNewSys();>cancel</button>
		<button style="float:right;" onclick="saveNewSys(Gebi('newSysName').value);">&nbsp;Save&nbsp;</button>
	</div>
</div>

<div id=addCustBox class=WindowBox align=center >
	<div class=WindowTitle style="background:#40631D; color:#fff; text-align:center;">
		Customer
		<div class=redXCircle onClick=hideAddCust();>X</div>
	</div>
	<br/>
	<div class=newSysBoxRow style="height:26px;">
		<form id=custSearchForm action="javascript:searchCust(Gebi('custName').value);">
			<label for=custName style="float:left; height:22px;">&nbsp;Customer:</label>
			<div style="border:#bbb 1px solid; float:left; height:22px; width:70%;">
				<input id=custName class=newSysTxt type=search style="border:0px transparent; float:left; height:100%; outline:none; width:70%;" />
				<input type=submit value="&nbsp;Search&nbsp;" style="height:100%; line-height:8px; width:30%;" />
			</div>
		</form>
	</div>
	<br/>
	<div id=custList></div>
	<div class=newSysBoxRow style="width:95%;" >
		<button onclick=hideAddCust(); >&nbsp;Cancel&nbsp;</button>
	</div>
</div>

<div id=addProvBox class=WindowBox align=center >
	<div class=WindowTitle style="background:#40631D; color:#fff; text-align:center;">
		Monitoring Service Provider
		<div class=redXCircle onClick=hideAddProv();>X</div>
	</div>
	<br/>
	<div class=newSysBoxRow style="height:26px;" >
		<form id=provSearchForm action="javascript:searchProv(Gebi('provName').value);">
			<label for=provName style="float:left; height:22px;">&nbsp;Monitoring Vendor Name:</label>
			<div style="border:#bbb 1px solid; float:left; height:22px; width:70%;">
				<input id=provName class=newSysTxt type=search style="border:0px transparent; float:left; height:100%; outline:none; width:70%;" />
				<input type=submit value="&nbsp;Search&nbsp;" style="height:100%; line-height:8px; width:30%;" />
			</div>
		</form>
	</div>
	<br/>
	<div id=provList></div>
	<div class=newSysBoxRow style="width:95%;">
		<button onclick=hideAddProv(); >&nbsp;Cancel&nbsp;</button>
	</div>
</div>
 


<div id=statusPopup>
	<label><input id=cbStatusActive type=checkbox onChange="setStatus('Active', this.checked);"/>Active</label>
	<div class=smallRedXCircle onClick="Gebi('statusPopup').style.display='none';">X</div><br/>
	<label><input id=cbStatusInactive type=checkbox onChange="setStatus('Inactive', this.checked);"/>Inactive</label><br/>
	<label><input id=cbStatusOnTest type=checkbox onChange="setStatus('OnTest', this.checked);" />On Test</label><label> until: <input id=statusTestUntil onFocus="cbStatusOnTest.checked=false; cbStatusActive.checked=false; cbStatusInactive.checked=false;" onBlur="setStatus('OnTest', cbStatusOnTest.checked);" /></label>
</div>


<div id=mainToolbar class="Toolbar" style="background:none;">
	<button onClick="window.history.go(-1);" style="float:left;">◄Back</button>
	<button id="ReloadFrame" class="tButton24" onClick="window.location=window.location;" style="float:right;"/><img src="../Images/reloadblue24.png" /></button>
</div>

<div id=pathToolbar class="Toolbar" style="background:none;">
	<div id=path>&nbsp; Service > <a href="Monitoring.asp">Monitoring</a> > <%=sName%></div>
</div>

<div id=TabsBar style="display:none;">
	<span id=AcctInfoTab class=activeTab onClick=" showTab(this); AccountCost(acctId); ">Account Information</span>
	<span id=SysTab class=tab onClick="showTab(this);">Systems Editor</span>
	<span id=PrintingTab class=tab onClick="showTab(this);">Proposal Printing</span>
</div>

<div id="OuterBox">
	
	<div id=blankDiv style="display:none;"></div>
	
	<div id=oldNotes class=dN><%=DecodeChars(rs("AdditionalContacts"))%></div>
	
	<div id=AcctInfoPage class="activeTabPage">
		<div id=AcctInfoWidth>
			<div id=AcctInfoTitle class=AcctInfoTitle style="margin-top:1%;" >
				<div style=float:left;>Account Information</div>
				<div id=AccountTotal class=total style="font-size:32px; float:right; line-height:20px; margin-right:8px;"></div>
			</div>
			<div id=AcctInfo class=AcctInfo height=400px style="height:90%; min-height:400px;" >
				<% 

				rowCount=15
				iRowH=((100/rowCount)*3)/3 
				iRowMH=((146/rowCount)*3)/3 
				iColH=100'iRowH*(rowCount-1)
				iColMH=146'iRowMH*(rowCount-1)
				InfoCellStyle="height:"&iRowH&"%; max-height:"&iRowH&"%; min-height:"&iRowMH&"px; -moz-min-height:0px;"
				InfoCell2x="height:"&iRowH*2&"%; max-height:"&iRowH*2&"%; min-height:"&iRowMH*2&"px; -moz-min-height:0px;"
				InfoCell3x="height:"&iRowH*3&"%; max-height:"&iRowH*3&"%; min-height:"&iRowMH*3&"px; -moz-min-height:0px;"
				InfoBottomStyle="height:-moz-calc(100%-("&iRowH&"% * "&CStr(rowCount-1)&"); min-height:"&iRowMH&"px; -moz-min-height:0px;"
				%>
				<div class="labelColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
					<label style="<%=InfoCellStyle%>"><big>Account Name</big></label>
					<label style="<%=InfoCellStyle%>">Site Address</label>
					<label style="<%=InfoCellStyle%>">City</label>
					<label style="<%=InfoCellStyle%>">State</label>
					<label style="<%=InfoCellStyle%>">Zip</label>
					<label style="<%=InfoCellStyle%>">Code</label>
					<label style="<%=InfoCellStyle%>">2<sup>nd</sup> Code</label>
					<label style="<%=InfoCellStyle%>">Customer</label>
					<label style="<%=InfoCellStyle%>">1<sup>st</sup> Contact</label>
					<label style="<%=InfoCellStyle%>">2<sup>nd</sup> Contact</label>
					<label style="<%=InfoCellStyle%>">3<sup>rd</sup> Contact</label>
					<label style="<%=InfoCellStyle%>">4<sup>th</sup> Contact</label>
					<label style="<%=InfoCell3x%>">Additional Contacts</label>
				</div>
				<div class="fieldColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
					<div class=fieldDiv id=SiteName style="<%=InfoCellStyle%>" ><%=editLink%><div><%=sName%></div></div>
					<div class=fieldDiv id=Addr style="<%=InfoCellStyle%>"><%=editLink&Address%></div>
					<div class=fieldDiv id=City style="<%=InfoCellStyle%>"><%=editLink&City%></div>
					<div class=fieldDiv id=State style="<%=InfoCellStyle%>"><%=editLink&rs("State")%></div>
					<div class=fieldDiv id=Zip style="<%=InfoCellStyle%>"><%=editLink&rs("Zip")%></div>
					<div class=fieldDiv id=Code style="<%=InfoCellStyle%>"  ><%=editLink&rs("Code")%></div>
					<div class=fieldDiv id=Code2 style="<%=InfoCellStyle%>" ><%=editLink&rs("Code2")%></div>
					<div class=fieldDiv id=Customer style="<%=InfoCellStyle%>"><%=custLink&Customer%></div>
					<div class=fieldDiv id=ContactName1 style="<%=InfoCellStyle%>"><%=editLink&rs("ContactName1")%></div>
					<div class=fieldDiv id=ContactName2 style="<%=InfoCellStyle%>"><%=editLink&rs("ContactName2")%></div>
					<div class=fieldDiv id=ContactName3 style="<%=InfoCellStyle%>"><%=editLink&rs("ContactName3")%></div>
					<div class=fieldDiv id=ContactName4 style="<%=InfoCellStyle%>"><%=editLink&rs("ContactName4")%></div>
					<div class=fieldDiv id=AdditionalContacts style="<%=InfoCell3x%>"><%=notesLink&DecodeChars(rs("AdditionalContacts"))%></div>
				</div>
				<div class="labelColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
					<label style="<%=InfoCellStyle%>">Monitoring Provider</label>
					<label style="<%=InfoCellStyle%>">Account Number</label>
					<label style="<%=InfoCellStyle%>">Date Created</label>
					<label style="<%=InfoCellStyle%>">Account Status</label>
					<label style="<%=InfoCellStyle%>">Panel Model</label>
					<label style="<%=InfoCellStyle%>">Panel Primary Number</label>
					<label style="<%=InfoCellStyle%>">Panel Secondary Number</label>
					<label style="<%=InfoCellStyle%>">Site Phone Number</label>
					<label style="<%=InfoCellStyle%>">1<sup>st</sup> Contact Phone Number</label>
					<label style="<%=InfoCellStyle%>">2<sup>nd</sup> Contact Phone Number</label>
					<label style="<%=InfoCellStyle%>">3<sup>rd</sup> Contact Phone Number</label>
					<label style="<%=InfoCellStyle%>">4<sup>th</sup> Contact Phone Number</label>
					<label style="<%=InfoCell3x%>">Notes</label>
				</div>
				<div class="fieldColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
					<div class=fieldDiv id=Customer style="<%=InfoCellStyle%>"><%=provLink&Provider%></div>
					<div class=fieldDiv id=AcctNo style="<%=InfoCellStyle%>"><%=editLink&rs("AcctNo")%></div>
					<div class=fieldDiv id=DateEnt style="<%=InfoCellStyle%>"><%=rs("DateEnt")%></div>
					<div class=fieldDiv id=Active style="<%=InfoCellStyle%> white-space:nowrap;"><%
						aActive= (rs("active")="True")
						aInactive= Not aActive
						aOnTest= aActive And (rs("testUntil") > Now)
						
						If aInactive Then 
							cssClass="statusInactive"
							statusText="Inactive"
						End If
						If aActive Then 
							cssClass="statusActive"
							statusText="Active"
						End If
						If aOnTest Then 
							cssClass="statusOnTest"
							statusText="<small>On test until "&rs("testUntil")&"</small>"
						End If
						
						If aActive Then aActive=1 Else aActive=0
						If aInactive Then aInactive=1 Else aInactive=0
						%><div id=acctStatus class=<%=cssClass%> onClick="showStatusPopup(<%=AcctID%>, this, <%=aInactive%>,<%=aActive%>);">&nbsp;</div><div id=acctStatusText><%=statusText%></div><div id=testUntil style="display:none;"><%=rs("testUntil")%></div>
					</div>
					<div class=fieldDiv id=PanelModel style="<%=InfoCellStyle%>"><%=editLink&rs("PanelModel")%></div>
					<div class=fieldDiv id=PanelPhone style="<%=InfoCellStyle%>"><%=phoneLink&Phone(rs("PanelPhone"))%></div>
					<div class=fieldDiv id=PanelPhone2 style="<%=InfoCellStyle%>"><%=phoneLink&Phone(rs("PanelPhone2"))%></div>
					<div class=fieldDiv id=sitePhone style="<%=InfoCellStyle%>"><%=phoneLink&Phone(rs("sitePhone"))%></div>
					<div class=fieldDiv id=ContactNumber1 style="<%=InfoCellStyle%>"><%=phoneLink&Phone(rs("ContactNumber1"))%></div>
					<div class=fieldDiv id=ContactNumber2 style="<%=InfoCellStyle%>"><%=phoneLink&Phone(rs("ContactNumber2"))%></div>
					<div class=fieldDiv id=ContactNumber3 style="<%=InfoCellStyle%>"><%=phoneLink&Phone(rs("ContactNumber3"))%></div>
					<div class=fieldDiv id=ContactNumber4 style="<%=InfoCellStyle%>"><%=phoneLink&Phone(rs("ContactNumber4"))%></div>
					<div class=fieldDiv id=Notes style="<%=InfoCell3x%>"><%=notesLink&rs("Notes")%></div>
				</div>
				<div class="labelColumn w50p" style="height:<%=iRowMH%>px; min-height:<%=iRowMH%>px;">
				</div>
			</div>
			
			<!--
			<div id=LocationInfo class=AcctInfo height="82px" style="height:82px;">
				<div id="LocationInfoTitle" class="AcctInfoTitle">Location Information</div>
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
			<!-- div id=CostingTitle class=AcctInfoTitle>Account Cost Breakdown</div>
			<div id=Costing class=AcctInfo height=418px style="height:49%; min-height:256px; margin-bottom:32px;">
				<div class="labelColumnT w16p" style="height:100%; min-height:256px;">
					< %
					cRowH=fix((100/8)*3)/3 
					cRowMH=fix((256/8)*3)/3 
					costingCellStyle="height:"&cRowH&"%; min-height:"&cRowMH&"px; -moz-min-height:0px;"
					costingBottomStyle="height: calc(100% - ("&cRowH&"% * 7) ); min-height:"&cRowMH&"px; -moz-min-height:0px;"
					%>
					<label style="< %=costingCellStyle%>">&nbsp;</label>
					<label style="< %=costingCellStyle%>">Materials</label>
					<label style="< %=costingCellStyle%>">Labor</label>
					<label style="< %=costingCellStyle%>">Expenses</label>
					<label style="< %=costingCellStyle%>">Overhead</label>
					<label style="< %=costingCellStyle%>">Taxes</label>
					<label style="< %=costingCellStyle%>">Profit</label>
					<label style="< %=costingBottomStyle%>">Total</label>
				</div>
				<div class="fieldColumn w16p" style="height:100%; min-height:256px;">
					<div class=fieldDivT style="< %=costingCellStyle%>" align="center"><b>$</b></div>
					<div class=fieldDivT style="< %=costingCellStyle%>" id=PartsCost align=right></div>
					<div class=fieldDivT style="< %=costingCellStyle%>" id=LaborCost align=right></div>
					<div class=fieldDivT style="< %=costingCellStyle%>" id=ExpensesCost align=right></div>
					<div class=fieldDivT style="< %=costingCellStyle%>" id=OverheadCost align=right></div>
					<div class=fieldDivT style="< %=costingCellStyle%>" id=TaxCost align=right></div>
					<div class=fieldDivT style="< %=costingCellStyle%>" id=ProfitCost align=right></div>
					<div class="fieldDivT Total" style="< %=costingBottomStyle%>" id=AccountTotal2 align=right></div>
				</div>
				<div class="fieldColumn w16p" style="height:100%; min-height:256px;">
					<div class=fieldDivT style="< %=costingCellStyle%>" align="center"><b>%</b></div>
					<div class=fieldDivT style="< %=costingCellStyle%>" id=PartsPerc align=right></div>
					<div class=fieldDivT style="< %=costingCellStyle%>" id=LaborPerc align=right></div>
					<div class=fieldDivT style="< %=costingCellStyle%>" id=ExpensesPerc align=right></div>
					<div class=fieldDivT style="< %=costingCellStyle%>" id=OverheadPerc align=right></div>
					<div class=fieldDivT style="< %=costingCellStyle%>" id=TaxPerc align=right></div>
					<div class=fieldDivT style="< %=costingCellStyle%>" id=ProfitPerc align=right></div>
					<div class="fieldDivT Total" style="< %=costingBottomStyle%>" align=right>100%</div>
				</div>
				<iframe id=costPie class=fieldColumn style="border:none; height:100%; min-height:256px; width:50%;"></iframe>
			</div -->
		
		</div>
	</div>
	
	
</div>
<br/>
</body>
</html>