<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<title>TMC Estimates</title>
<!--#include file="common.asp" -->

<script type="text/javascript" src="Project/Project.js?nocache=<%=timer%>"></script>
<script type="text/javascript" src="Project/ProjectAJAX.js?nocache=<%=timer%>"></script>

<link rel=stylesheet href="Library/CSS_DEFAULTS.css?nocache=<%=timer%>" media=all>
<link rel=stylesheet href="Project/Project.css?nocache=<%=timer%>" media=all>
<%
If Session("user")="" Then 
	QS=request.QueryString
	If QS <> "" Then QS= "?"&QS
	Session("LoginDestination")="../TMCManagement/Project.asp"&QS
	Response.Redirect("blank.html")
End If
 
Sql0="SELECT Projects FROM Access WHERE UserName='"&Session("user")&"'"
Set rs0=Server.CreateObject("AdoDB.RecordSet")
rs0.Open Sql0, REDConnString

If rs0.EOF Then Response.Redirect("blank.html")
If rs0("Projects") <> "True" Then  Response.Redirect("blank.html")
 
 
projId=Request.QueryString("id")

F="ProjName, CustomerID, CustName, Floors, SqFoot, RCSPM, BiddingDueDate, DateEnt, DateStarted, DateDue, ProjAddress, ProjCity, ProjState, ProjZip, RCSNotes, Use2010Bidder"
F=F&",pLHeadID,pSysTotals,pLetter,pInc,pExc,pScope,pSubT,pTax,pTotal,pParts,pPartsPrice,pPartsTotal,pLabor,pLaborPrice,pLaborTotal,LicFooter"
F=F&",pLetterTitle,pPrintDate,pScopeTitle,pAddressing,pSignedTCS,pSignedCust,pBody,pLegalNotes"
SQL="SELECT "&F&" FROM Projects WHERE ProjID="&projId
Set rs=Server.CreateObject("Adodb.RecordSet")
rs.Open SQL, REDConnString
 
pName=DecodeChars(rs("ProjName"))
Address=DecodeChars(rs("ProjAddress"))
City=DecodeChars(rs("ProjCity"))
RCSNotes=DecodeChars(CR2Br(rs("RCSNotes")&" "))
Customer=DecodeChars(rs("CustName"))
If rs("Use2010Bidder") = "True" Then useNewBidder= True Else useNewBidder=False

If Customer="" Then
	custSQL="SELECT Name FROM Contacts WHERE CustomerID=0"&rs("CustomerID")
	Set custRS=Server.CreateObject("AdoDB.RecordSet")
	custRS.Open custSQL, REDConnString
	If Not custRS.EOF Then 
		Customer=DecodeChars(custRS("Name"))
	Else
		Set custRS=Nothing
		custSQL="SELECT CustName FROM BidTo WHERE ProjID="&projId
		Set custRS=Server.CreateObject("AdoDB.RecordSet")
		custRS.Open custSQL, REDConnString
		If Not custRS.EOF Then Customer=DecodeChars(custRS("CustName"))
	End If
End If
Set custRS=Nothing


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

loSQL="UPDATE Projects SET ProjectLastOpened='"&NowStr&"' WHERE ProjID="&ProjID
'% ><%=loSQL% ><%
Set loRS=Server.CreateObject("AdoDB.RecordSet")
loRS.Open loSQL, RedConnString
set loRS=Nothing

editLink="<a class=""editLink"" style=""z-index:10000;"" onclick=""editField(this.parentNode);"" >Edit</a>"
currencyLink="<a class=""editLink"" onclick=""editCurrency(this.parentNode);"" >Edit</a>"
dateLink="<a class=""editLink"" onclick=""dateField(this.parentNode)"" >Edit</a>"
notesLink="<a class=editLink onClick=editNotes(this.parentNode);>Edit</a>"
%>
<script type="text/javascript">
	var accessEmpName='<%=Session("userName")%>';
	var editLink='<%=editLink%>';
	var projId=<%=projId%>;
	var editLink='<%=editLink%>';
	var currencyLink='<%=currencyLink%>';
	var dateLink='<%=dateLink%>';
	var notesLink='<%=notesLink%>';
	var useNewBidder=<%=lCase(rs("Use2010Bidder"))%>;
</script>
	

</head>
<body onLoad="Resize(); ProjectBudget();" onResize="Resize();"> 

<div id=Modal onMouseMove="ModalMouseMove(event,'AddPartContainer');" align="center">
	<div style="width:100%; height:30%;"></div>
	<img src=../Images/roller.gif /><br/>
	<div id=modalStatus></div>
</div>
<div id="Employees" style="display:none;"><%EmployeeOptionList("active")%></div>

<div id=NewSysBox class="WindowBox" align="center" >
	<div class="WindowTitle" style="background:#40631D; color:#fff; text-align:center;">New System<div class="redXCircle" onClick="hideNewSys();" >X</div></div>
	<br/>
	<div class="newSysBoxRow" style="height:26px;">
		<label class="newSysLabel" for="nbProjName">New System:</label>
		<input id="newSysName" type="text" class="newSysTxt" /><big>&nbsp;</big>
	</div>
	<br/>
	<div class="newSysBoxRow" style="width:95%;">
		<button style="float:left;" onclick=hideNewSys();>cancel</button>
		<button style="float:right;" onclick="saveNewSys(Gebi('newSysName').value);">&nbsp;Save&nbsp;</button>
	</div>
</div>

<div id=addCustBox class="WindowBox" align="center" >
	<div class=WindowTitle style="background:#40631D; color:#fff; text-align:center;">
		Add Customer
		<div class=redXCircle onClick=hideAddCust();>X</div>
	</div>
	<br/>
	<div class="newSysBoxRow" style="height:26px;">
		<form action="javascript:searchCust(Gebi('custName').value);">
			<label for="custName" style="float:left; height:22px;">&nbsp;Customer:</label>
			<div style="border:#bbb 1px solid; float:left; height:22px; width:70%;">
				<input id=custName class=newSysTxt type=search style="border:0px transparent; float:left; height:100%; outline:none; width:70%;" />
				<input type=submit value="&nbsp;Search&nbsp;" style="height:100%; line-height:8px; width:30%;" />
			</div>
		</form>
	</div>
	<br/>
	<div id=custList></div>
	<div class="newSysBoxRow" style="width:95%;">
		<button onclick=hideAddCust(); >&nbsp;Cancel&nbsp;</button>
	</div>
</div>
 
<div id="AddPartContainer"> 
	<div id="AddPartTitle" onmousedown="PartsMouseDown(event)" onmouseup="PartsMouseUp(event)" onMouseMove="ModalMouseMove(event,'AddPartContainer')" onselectstart="return false;" >PARTS LIST SEARCH</div>
	<iframe id="AddPartBox" class="AddPartBox" src="PartsInterface.asp?BoxID=AddPartContainer&ModalID=Modal&MM=parent.PartsMouseMove(event,'AddPartContainer')&MD=parent.PartsMouseDown(event)&MU=parent.PartsMouseUp(event)"></iframe>
</div>
	
<div id="AddLaborContainer"> 
	<div id="AddLaborTitle" onmousedown="PartsMouseDown(event)" onmouseup="PartsMouseUp(event)" onMouseMove="ModalMouseMove(event,'AddLaborContainer')" onselectstart="return false;" >LABOR LIST SEARCH</div>
	<iframe id="AddLaborBox" class="AddLaborBox" src="LaborInterface.asp?BoxID=AddLaborContainer&ModalID=Modal&MM=parent.PartsMouseMove(event,'AddLaborContainer')&MD=parent.PartsMouseDown(event)&MU=parent.PartsMouseUp(event)"></iframe>
</div>

<div id="AddTravelContainer" class="WindowBox"> 
	<div id=AddTravelTitle class="WindowTitle">Add Travel Expense<div class="redXCircle" onClick="HideAddTravel();">X</div></div>
	
		<div class="BoxRow">
			<div class="BoxLabel">Method:</div>
			<select id="tSelType" class="BoxInput" onChange="Gebi('addBoxUnits').innerHTML=SelI(this.id).value+'s';Gebi('addBoxCostUnit').innerHTML=SelI(this.id).value;">
			
			<%
			SQL1="SELECT TravelTypeID, Type, Unit FROM TravelType"
			Set rs1= Server.CreateObject("ADODB.RecordSet")
			rs1.Open SQL1, REDConnString
			
			Dim TravelType(255,2)
			Dim t: t=0
			
			Do Until rs1.EOF
				If t+1>255 then Exit Do
				t=t+1
				
				TravelType(t,0)=rs1("TravelTypeID")
				TravelType(t,1)=rs1("Type")
				TravelType(t,2)=rs1("Unit")
				
				Rs1.MoveNext
			Loop
			
			Set rs1=Nothing
			
			For t = 1 to UBound(TravelType)
				If TravelType(t,0)<>"" Then
					%>
						<option id="TravelType<%=TravelType(t,0)%>" value="<%=TravelType(t,2)%>" ><%=TravelType(t,1)%></option>
					<%
				End If
			Next
			%>
			</select>
		</div>
		
		<div class="BoxRow">
			<div class="BoxLabel">From:</div>
			<input id="tOrigin" class="BoxInput"/>
		</div>
		<div class="BoxRow">
			<div class="BoxLabel">To:</div>
			<input id="tDest" class="BoxInput"/>
		</div>
		<div class="BoxRow">
			<div id="addBoxUnits" class="BoxLabel">Tickets</div>
			<input id="tAmount" class="BoxInput Numbers"/>
		</div>
		<div class="BoxRow">
			<div class="BoxLabel">Cost per&nbsp;<span id="addBoxCostUnit" style="">Ticket</span></div>
			<input id="tCost" class="BoxInput Numbers"/>
		</div>
		<div class="BoxRow">
			<button style=float:left; onClick=HideAddTravel(); >Cancel</button>
			<button id=tAdd style=float:right; onClick="AddExpense('Travel',SelI('tSelType').innerHTML, Gebi('tOrigin').value, Gebi('tDest').value, Gebi('tAmount').value, Gebi('tCost').value); HideAddTravel();">Save</button>
		</div>
</div>



<div id=mainToolbar class=Toolbar style="background:none;">
	<button onClick="window.history.go(-1);" style="float:left;">◄Back</button>
	<button id="ReloadFrame" class="tButton24" onClick="window.location=window.location;" style="float:right;"/><img src="../Images/reloadblue24.png" /></button>
</div>

<div id=pathToolbar class="Toolbar" style="background:none;">
	<div id=path>&nbsp; Projects > <a href="Projects.asp">Projects Management</a> > <big><b><%=pName%></b></big></div>
</div>

<div id=TabsBar>
	<span id=ProjInfoTab class=activeTab onClick=" showTab(this); ProjectBudget(projId); ">Project Budget Summary</span>
	<span id=SysTab class=tab onClick="showTab(this);">Budget Detail</span>
	<!-- span id=BOMTab class=tab onClick="showTab(this);">Bill of Materials</span -->
	<span id=ReportTab class=tab onClick="showTab(this);">Job Cost Report</span>
</div>

<div id="OuterBox">
	<div id=blankDiv style="display:none;"></div>	
	<div id=ProjInfoPage class="activeTabPage">
		<div id=ProjInfoWidth>
			<div id=ProjInfoTop >
				<div id=ProjInfoLeft>
					<div id=ProjInfoTitle class=ProjInfoTitle style="margin-top:1%;" >
						<div style=float:left;>Project Information</div>
						<div id=BudgetTotal class=total style="font-size:24px; float:right; line-height:20px; margin-right:8px;"></div>
						<div id=ProjectTotal class=total style="font-size:24px; float:right; line-height:20px; margin-right:32px;"></div>
					</div>
					<% 
					If rs("Use2010Bidder")="True" Then 
						notNewBidder=0
						bidType="Lump Sum"
						notBidType="Itemized Materials"
					Else
						notNewBidder=1
						bidType="Itemized Materials" 
						notBidType="Lump Sum"
					End If
					
					rowCount=5
					iRowH=((100/rowCount)*3)/3 
					iRowMH=((144/rowCount)*3)/3 
					iColH=100'iRowH*(rowCount-1)
					iColMH=144'iRowMH*(rowCount-1)
					InfoCellStyle="height:"&iRowH&"%; max-height:"&iRowH&"%; min-height:"&iRowMH&"px; -moz-min-height:0px;"
					InfoBottomStyle="height:-moz-calc(100%-("&iRowH&"% * "&CStr(rowCount-1)&"); min-height:"&iRowMH&"px; -moz-min-height:0px;"
					%>
					<div id=ProjInfo class=ProjInfo height="178px" style="height:25%; min-height:<%=iColMH%>px;" >
						<div class="labelColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
							<label style="<%=InfoCellStyle%>"><big>Project Name</big></label>
							<label style="<%=InfoCellStyle%>"># of Floors</label>
							<label style="<%=InfoCellStyle%>">Square Footage</label>
							<label style="<%=InfoCellStyle%>">Date Started</label>
							<label style="<%=InfoCellStyle%>">Closing Date</label>
							<!-- <label style="< %=InfoCellStyle%>">Bid Type</label> -->
						</div>
						<div class="fieldColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
							<div class=fieldDiv style="<%=InfoCellStyle%> z-index:0;" id=ProjName ><%=editLink%><div><%=pName%></div></div>
							<div class=fieldDiv style="<%=InfoCellStyle%>" id="Floors"><%=editLink&rs("Floors")%></div>
							<div class=fieldDiv style="<%=InfoCellStyle%>" id=SqFoot><%=editLink&rs("SqFoot")%></div>
							<div class=fieldDiv style="<%=InfoCellStyle%>"><%=rs("DateStarted")%></div>
							<div class=fieldDiv id=BiddingDueDate style="<%=InfoCellStyle%>"><%=dateLink&rs("DateDue")%></div>
							<%onClick="WSQLUBit('Projects','Use2010Bidder',"&notNewBidder&",'ProjID',"&projId&"); window.location=window.location;"%>
							<!-- <div class=fieldDiv id=Use2010Bidder style="height:100%;"><span style="float:left; font-size:14px; line-height:20px;"><%=bidType%></span></div> -->
						</div>
						<div class="labelColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
							<label style="<%=InfoCellStyle%>">Customer</label>
							<label style="<%=InfoCellStyle%>">Project Manager</label>
							<label style="<%=InfoCellStyle%>">Address</label>
							<label style="<%=InfoCellStyle%>">City</label>
							<label style="<%=InfoCellStyle%>">State</label>
							<label style="<%=InfoCellStyle%>">Zip</label>
						</div>
						<div class="fieldColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
							<div class=fieldDiv id=RCSPM style="<%=InfoCellStyle%>"><%=Customer%></div>
							<div class=fieldDiv id=RCSPM style="<%=InfoCellStyle%>"><%=editLink&rs("RCSPM")%></div>
							<div class=fieldDiv id=ProjAddress style="<%=InfoCellStyle%>"><%=editLink&Address%></div>
							<div class=fieldDiv id=ProjCity style="<%=InfoCellStyle%>"><%=editLink&City%></div>
							<div class=fieldDiv id=ProjState style="<%=InfoCellStyle%>"><%=editLink&rs("ProjState")%></div>
							<div class=fieldDiv id=ProjZip style="<%=InfoCellStyle%>"><%=editLink&rs("ProjZip")%></div>
						</div>
						<div class="labelColumn w50p" style="height:<%=iRowMH%>px; min-height:<%=iRowMH%>px;"></div>
					</div>
					
				</div>
				
				<div id=ProjInfoRight >
					<div id=SysTitle class=ProjInfoTitle style="margin-top:1%;">
						<div style="float:left;">Systems</div>
					</div>
					<div id=Systems class=ProjInfo height=150px style="min-height:150px; height:25%; overflow-y:scroll;">
						<%
						sysSQL="SELECT System, SystemID FROM Systems WHERE ProjectID="&ProjID
						Set sysRS=Server.createObject("Adodb.Recordset")
						sysRS.open sysSQL, REDConnstring
						
						newSysStyle=""
						newSysText="New System"
						If sysRS.eof Then 
							newSysStyle=" color:#a44; font-size:20px; font-weight:bold; height:32px; width:100%;"
							newSysText="Click here to create a new system."
						End If
						
						Do Until sysRS.eof
							thisSys=DecodeChars(sysRS("System"))
							thisSysId=sysRS("SystemID")
							
							
							%>
							<a class="systemLink" onClick="loadSystem(<%=thisSysId%>);" align=center style="overflow:hidden;" >
								<span class=sysLinkText><%=thisSys%></span>
								<span id=sysStatus<%=thisSysId%> class=sysStatus title="">&nbsp;</span>
							</a>
							
							<%
							sysRS.moveNext
						Loop
						Set sysRS=Nothing
						%>
					</div>
				</div>
			</div>

			<div id=ProjInfoBottom >		
				<div id=CostingTitle class=ProjInfoTitle style=" margin-top:1%;">Job Cost Summary</div>
				<div id=Costing class=ProjInfo height=418px style="height:49%; min-height:256px; margin-bottom:1%;">
					<div class="fieldColumn w33p" style="height:100%;">
						<div class="labelColumnT w33p" style="height:80% !important; min-height:256px;">
							<%
							cRowH=fix((100/6)*3)/3 
							cRowMH=fix((256/6)*3)/3 
							costingCellStyle="height:"&cRowH&"%; min-height:"&cRowMH&"px; -moz-min-height:0px; font-size:12px;"
							costingBottomStyle="height:"&cRowH&"%; height:-moz-calc(100%-("&cRowH&"%*5)); height:-webkit-calc(100%-("&cRowH&"%*5)); height:calc(100%-("&cRowH&"%*5)); min-height:"&cRowMH&"px; -moz-min-height:0px; font-size:12px; border-bottom:1px solid #888;"
							%>
							<label style="<%=costingCellStyle%>">&nbsp;</label>
							<label style="<%=costingCellStyle%>">Materials</label>
							<label style="<%=costingCellStyle%>">Labor</label>
							<label style="<%=costingCellStyle%>">Expenses</label>
							<label style="<%=costingCellStyle%>">Taxes</label>
							<label style="<%=costingBottomStyle%>">Total</label>
						</div>
						<div class="fieldColumn w34p" style="height:80%; min-height:256px;">
							<div class=fieldDivT style="<%=costingCellStyle%>" align="center"><b>$</b></div>
							<div class=fieldDivT style="<%=costingCellStyle%>" id=PartsCost align=right></div>
							<div class=fieldDivT style="<%=costingCellStyle%>" id=LaborCost align=right></div>
							<div class=fieldDivT style="<%=costingCellStyle%>" id=ExpensesCost align=right></div>
							<div class=fieldDivT style="<%=costingCellStyle%>" id=TaxCost align=right></div>
							<div class="fieldDivT Total" style="<%=costingBottomStyle%>" id=ProjectTotal2 align=right></div>
						</div>
						<div class="fieldColumn w33p" style="height:80%; min-height:256px;">
							<div class=fieldDivT style="<%=costingCellStyle%>" align="center"><b>%</b></div>
							<div class=fieldDivT style="<%=costingCellStyle%>" id=PartsPerc align=right></div>
							<div class=fieldDivT style="<%=costingCellStyle%>" id=LaborPerc align=right></div>
							<div class=fieldDivT style="<%=costingCellStyle%>" id=ExpensesPerc align=right></div>
							<div class=fieldDivT style="<%=costingCellStyle%>" id=TaxPerc align=right></div>
							<div class="fieldDivT Total" style="<%=costingBottomStyle%>" align=right>100%</div>
						</div>
            <button style="font-size:24px; min-height:64px; height:20%; width:100%; float:left;" onClick="PrintBudget();">Print Budget Summary</button>
					</div>
					<iframe id=costPie class=fieldColumn style="border:none; height:100%; min-height:256px; width:66.6667%;"></iframe>
				</div>
      </div>
		</div>		
	</div>
	
	<!-- iframe id=SysPage class="tabPage" src="System.asp?projId=< %=projId%>&nocache=< %=timer%>"></iframe -->
	<iframe id=SysPage class="tabPage" src="BudgetDetail.asp?projId=<%=projId%>&nocache=<%=timer%>"></iframe>
	
	<iframe id=BOMPage class=tabPage src="" ></iframe>
	
	<div id=ReportPage class="tabPage">

		<div id=PrintBidToTitle class=ProjInfoTitle>Details disclosed</div>
		<div id=PrintDetails class=ProjInfo height=154px style="height:154px;">
			<div class=ProjInfoHeading>
				<div class="fL taC w33p"></div>
				<div class="fL taC w34p"></div>
				<div class="fL taC w33p"></div>
			</div>
			<div class="fieldColumn w33p" style="height:120px; overflow-x:hidden; overflow-y:auto;">
				<% If rs("pSysTotals")="True" then checked="checked" Else checked="" %>
				<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pSysTotals',this.checked,'ProjID',projId);" /><span>System Totals</span>
				</label>
				<% If rs("pSubT")="True" then checked="checked" Else checked="" %>
				<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pSubT',this.checked,'ProjID',projId);" /><span>Subtotal</span>
				</label>
				<% If rs("pTax")="True" then checked="checked" Else checked="" %>
				<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pTax',this.checked,'ProjID',projId);" /><span>Tax</span>
				</label>
				<% If rs("pTotal")="True" then checked="checked" Else checked="" %>
				<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pTotal',this.checked,'ProjID',projId);" /><span>Total</span>
				</label>
			</div>
			
			<div class="fieldColumn w34p" style="height:120px; overflow-x:hidden; overflow-y:auto;">
				<% If rs("pLetter")="True" then checked="checked" Else checked="" %>
				<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pLetter',this.checked,'ProjID',projId);" /><span>Letter</span>
				</label>
				<% If rs("pScope")="True" then checked="checked" Else checked="" %>
				<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pScope',this.checked,'ProjID',projId);" /><span>Scope of work</span>
				</label>
				<% If rs("pInc")="True" then checked="checked" Else checked="" %>
				<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pInc',this.checked,'ProjID',projId);" /><span>Includes</span>
				</label>
				<% If rs("pExc")="True" then checked="checked" Else checked="" %>
				<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pExc',this.checked,'ProjID',projId);" /><span>Excludes</span>
				</label>
			</div>
			
			<div class="fieldColumn w33p" style="height:120px; overflow-x:hidden; overflow-y:auto;">
				<% style="style=""margin-left:12px;""" %>
				<% If rs("pParts")="True" then checked="checked" Else checked="" %>
				<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pParts',this.checked,'ProjID',projId);" /><span>Show Itemized Materials <small>(Parts List)</small></span>
				</label>
				
				
				<% If rs("pPartsPrice")="True" then checked="checked" Else checked="" %>
				<% If useNewBidder then checked=" disabled"%>
				<label class="fieldDiv" style="width:50%;"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pPartsPrice',this.checked,'ProjID',projId);" <%=style%> /><span>Parts Pricing</span></label>
				
				<% If rs("pPartsTotal")="True" then checked="checked" Else checked="" %>
				<% If useNewBidder then checked=" disabled"%>
				<label class="fieldDiv" style="width:50%;"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pPartsTotal',this.checked,'ProjID',projId);" <%=style%> /><span>Parts Total</span></label>
				
				<% If rs("pLabor")="True" then checked="checked" Else checked="" %>
				<label class="fieldDiv"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pLabor',this.checked,'ProjID',projId);" /><span>Show Itemized Labor <small>(Labor List)</small></span></label>
				
				<% If rs("pLaborPrice")="True" then checked="checked" Else checked="" %>
				<% If useNewBidder then checked=" disabled"%>
				<label class="fieldDiv" style="width:50%;"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pLaborPrice',this.checked,'ProjID',projId);" <%=style%> /><span>Labor Pricing</span></label>
				
				<% If rs("pLaborTotal")="True" then checked="checked" Else checked="" %>
				<% If useNewBidder then checked=" disabled"%>
				<label class="fieldDiv" style="width:50%;"><input class=pdCheck <%=checked%> type=checkbox onChange="WSQLUBit('Projects','pLaborTotal',this.checked,'ProjID',projId);" <%=style%> /><span>Labor Total</span></label>
				
			</div>
		</div>

		<div style="float:left; width:100%; height:24px;"></div>
		<div style="float:left; width:87.5%; margin-left:5%;" align=center>
			<button style="font-size:24px; height:64px; width:75%;" onClick="Print();">Print</button>
		</div>
		
		<br/>
		
		
		
		<div style="float:left; width:100%; height:16px;"></div>
	</div>
	
</div>
<br/>
</body>
</html>