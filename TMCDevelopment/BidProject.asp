<!--#include file="../TMC/RED.asp" -->
<!DOCTYPE html>
<!-- checkpoint1 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<title>TMC Estimate</title>
<!-- checkpoint2 -->
<!--#include file="common.asp" -->
<!-- checkpoint3 -->

<script type="text/javascript" src="Bid/BidProject.js?noCache=<%=noCache%>"></script>
<script type="text/javascript" src="Bid/BidProjectAJAX.js?noCache=<%=noCache%>"></script>

<link rel=stylesheet href="Library/CSS_DEFAULTS.css?noCache=<%=noCache%>" media=all>
<link rel=stylesheet href="Bid/BidProject.css?noCache=<%=noCache%>" media=all>
<!-- checkpoint4 -->
<%
If Session("user")="" Then 
	QS=request.QueryString
	If QS <> "" Then QS= "?"&QS
	Session("LoginDestination")="../TMCManagement/BidProject.asp"&QS
	Response.Redirect("blank.html")
End If
 
%><!-- checkpoint5 --><%
Sql0="SELECT Estimates FROM Access WHERE UserName='"&Session("user")&"'"
Set rs0=Server.CreateObject("AdoDB.RecordSet")
rs0.Open Sql0, REDConnString
%><!-- checkpoint6 --><%

If rs0.EOF Then Response.Redirect("blank.html")
If rs0("Estimates") <> "True" Then  Response.Redirect("blank.html")
 
projId=Request.QueryString("id")

%><!-- checkpoint7 projID=<%=projId%> --><%
F="ProjName, Floors, SqFoot, RCSPM, BiddingDueDate, DateEnt, ProjAddress, ProjCity, ProjState, ProjZip, RCSNotes, Use2010Bidder"
F=F&",pLHeadID,pSecTotals,pLetter,pInc,pExc,pScope,pSubT,pTax,pTotal,pParts,pPartsPrice,pPartsTotal,pLabor,pLaborPrice,pLaborTotal,LicFooter,AddressFooter"
F=F&",pLetterTitle,pPrintDate,pScopeTitle,pAddressing,pSignedTCS,pSignedCust,pBody,pLegalNotes"
SQL="SELECT "&F&" FROM Projects WHERE ProjID="&projId
Set rs=Server.CreateObject("Adodb.RecordSet")
rs.Open SQL, REDConnString
%><!-- checkpoint8 --><%
 
pName=DecodeChars(rs("ProjName"))
Address=DecodeChars(rs("ProjAddress"))
City=DecodeChars(rs("ProjCity"))
RCSNotes=DecodeChars(CR2Br(rs("RCSNotes")&" "))
If rs("Use2010Bidder") = "True" Then useNewBidder= True Else useNewBidder=False

%><!-- checkpoint9 --><%

rbSQL="DELETE FROM RecentBids WHERE ProjID="&ProjID
Set rbRS=Server.CreateObject("AdoDB.RecordSet")
rbRS.Open rbSQL, RedConnString

rbSQL="INSERT INTO RecentBids (ProjID) VALUES ("&ProjID&")"
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

loSQL="UPDATE Projects SET LastOpened='"&NowStr&"' WHERE ProjID="&ProjID
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
	var noCache='<%=Request.QueryString("noCache")%>';
	var accessEmpName='<%=Session("userName")%>';
	var editLink='<%=editLink%>';
	var projId=<%=projId%>;
	var editLink='<%=editLink%>';
	var currencyLink='<%=currencyLink%>';
	var dateLink='<%=dateLink%>';
	var notesLink='<%=notesLink%>';
	var useNewBidder=<%=lCase(rs("Use2010Bidder"))%>;
</script>

<style>*{ color:#462; }</style>

</head>
<!-- checkpoint4.0 -->
<body onLoad="ProjectCost();" onResize="Resize();"> 

<div id=Modal onMouseMove="ModalMouseMove(event,'AddPartContainer');" align="center">
	<div style="width:100%; height:30%;"></div>
	<img src=../Images/roller.gif /><br/>
	<div id=modalStatus></div>
</div>
<div id="Employees" style="display:none;"><%EmployeeOptionList("active")%></div>

<div id=NewSecBox class="WindowBox" align="center" >
	<div class="WindowTitle" style="background:#40631D; color:#fff; text-align:center;">New Section<div class="redXCircle" onClick="hideNewSec();" >X</div></div>
	<br/>
	<div class="newSecBoxRow" style="height:26px;">
		<label class="newSecLabel" for="nbProjName">New Section:</label>
		<input id="newSecName" type="text" class="newSecTxt" /><big>&nbsp;</big>
	</div>
	<br/>
	<div class="newSecBoxRow" style="width:95%;">
		<button style="float:left;" onclick=hideNewSec();>cancel</button>
		<button style="float:right;" onclick="saveNewSec(Gebi('newSecName').value);">&nbsp;Save&nbsp;</button>
	</div>
</div>

<div id=addCustBox class="WindowBox" align="center" >
	<div class=WindowTitle style="background:#40631D; color:#fff; text-align:center;">
		Add Customer
		<div class=redXCircle onClick=hideAddCust();>X</div>
	</div>
	<br/>
	<div class="newSecBoxRow" style="height:26px;">
		<form action="javascript:searchCust(Gebi('custName').value);">
			<label for="custName" style="float:left; height:22px;">&nbsp;Customer:</label>
			<div style="border:#bbb 1px solid; float:left; height:22px; width:70%;">
				<input id=custName class=newSecTxt type=search style="border:0px transparent; float:left; height:100%; outline:none; width:70%;" />
				<input type=submit value="&nbsp;Search&nbsp;" style="height:100%; line-height:8px; width:30%;" />
			</div>
		</form>
	</div>
	<br/>
	<div id=custList></div>
	<div class="newSecBoxRow" style="width:95%;">
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

<div id=mainToolbar class="Toolbar" style="background:none;">
	<button onClick="window.history.go(-1);" style="float:left;">◄Back</button>
	<button id="ReloadFrame" class="tButton24" onClick="noCacheReload();" style="float:right;"/><img src="../Images/reloadblue24.png" /></button>
</div>

<div id=pathToolbar class="Toolbar" style="background:none;">
	<div id=path>&nbsp; Jobs > <a href="Bid.asp">Estimating/Sales</a> > <big><b><%=pName%></b></big></div>
	<div id=ProjectTotal class="total taR fS24 fwB fR lh20"></div>
</div>


<div id=Lefty >
	<div class="piBox">
    <div id=SecTitle class=ProjInfoTitle>
      <div style="float:left;">Sections</div>
      <button onclick=showNewSec(); style="float:right; width:auto;" title="Add Section"><img src="../images/plus_16.PNG">New Section</button>
    </div>
    <div id=Sections class=ProjInfo height=140px style="min-height:140px; height:25%; overflow-y:scroll;">
      <%
      secSQL="SELECT Section, SectionID FROM Sections WHERE ProjectID="&ProjID
      Set secRS=Server.createObject("Adodb.Recordset")
      secRS.open secSQL, REDConnstring
      
      newSecStyle=""
      newSecText="New Section"
      If secRS.eof Then 
        newSecStyle=" color:#a44; font-size:20px; font-weight:bold; height:32px; width:100%;"
        newSecText="Click here to create a new section."
      End If
      
      Do Until secRS.eof
        thisSec=DecodeChars(secRS("Section"))
        thisSecId=secRS("SectionID")
        
        
        %>
        <a class="sectionLink" onClick="loadSection(<%=thisSecId%>);" align=center style="overflow:hidden;" >
          <span class=secLinkText><%=thisSec%></span>
          <span id=secStatus<%=thisSecId%> class=secStatus title="">&nbsp;</span>
        </a>
        
        <%
        secRS.moveNext
      Loop
      Set secRS=Nothing
      %>
    </div>
	</div>
	
  <div class="piBox">
    <div id="CustTitle" class="ProjInfoTitle">
      <span style="float:left;">Bidding Customers</span>
      <button onclick="deleteCusts();" style="float:right; width:24px;" title="Remove All Customers"><img src="../images/delete16.PNG"></button>
      <button onclick="showAddCust();" style="float:right; width:24px;" title="Add a Customer"><img src="../images/plus_16.PNG"></button>
    </div>
    <div id=Customers class=ProjInfo height="120px" style="min-height:120px; height:20%; overflow-y:scroll;">
      <%
      custSQL="SELECT CustID, CustName FROM BidTo WHERE ProjID="&ProjID
      Set custRS=Server.createObject("Adodb.Recordset")
      custRS.open custSQL, REDConnstring
  
      newCustStyle=""
      newCustTxt="Add Customer"
      If custRS.eof Then 
        newCustStyle=" color:#a44; font-size:20px; font-weight:bold; height:32px; width:100%;"
        newCustText="Click here to add a customer."
      End If
  
      Do Until custRS.eof
        %>
        <div class=sectionLink><%=DecodeChars(custRS("CustName"))%></div>
        <%
        custRS.moveNext
      Loop
      Set custRS=Nothing
      If newCustStyle<>"" Then
        %>
        <a class="sectionLink" style="overflow:hidden; padding:0; <%=newCustStyle%>" onClick="showAddCust();">
          <img src="../images/plus_16.png" style="cursor:inherit; height:10px; width:10px;"/><%=newCustTxt%>
        </a>
        <%
      End If
      %>
    </div>
	</div>
	
  <div class="piBox">
		<div id="NotesTitle" class="ProjInfoTitle">Notes</div>
    <div id=Notes class=ProjInfo height=140px style="min-height:140px; height:25%;">
      <!--
      <div class="labelColumn w15p" onDblClick="editNotes(Gebi('RCSNotes'));" style="height:100%;">
        <label style="height:100%; padding-top:50%;" onDblClick="editNotes(Gebi('RCSNotes'));">Notes</label>
      </div>
      -->
      <div class="fieldColumn w100p h100p" >
        <div id=RCSNotes class=fieldDiv style="height:100%; white-space:pre-wrap;"><%=notesLink&RCSNotes%></div>
        <div id=oldNotes class=fieldDiv style="display:none;"></div>
      </div>
    </div>
  </div>
</div>
<div id=lZipLeft onClick="zipLefty();" title="Show/Hide left panel.">◄</div>
<div id=lZipUp onClick="zipLefty();" title="Show/Hide top panel.">▲</div>




<div id=TabsBar>
	<span id=ProjInfoTab class="activeTab" onClick=" showTab(this); ProjectCost(projId); ">Project Information</span>
	<span id=SecTab class="tab" onClick="showTab(this);">Sections Editor</span>
	<span id=PrintingTab class="tab" onClick="showTab(this);">Proposal Printing</span>
</div>
<div id="OuterBox">
	
	<div id=blankDiv style="display:none;"></div>
	
	<div id=ProjInfoPage class="activeTabPage">
		<div id=ProjInfoWidth>
			<div id=ProjInfoMain>
				<div id=ProjInfoTitle class=ProjInfoTitle style="margin-top:1%;" >
					<div style=float:left;>Project Information</div>
				</div>
				<div id=ProjInfo class=ProjInfo height="178px" style="height:25%; min-height:146px;" >
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

					rowCount=6
					iRowH=((100/rowCount)*3)/3 
					iRowMH=((146/rowCount)*3)/3 
					iColH=100'iRowH*(rowCount-1)
					iColMH=146'iRowMH*(rowCount-1)
					InfoCellStyle="height:"&iRowH&"%; max-height:"&iRowH&"%; min-height:"&iRowMH&"px; -moz-min-height:0px;"
					InfoBottomStyle="height:-moz-calc(100%-("&iRowH&"% * "&CStr(rowCount-1)&"); min-height:"&iRowMH&"px; -moz-min-height:0px;"
					%>
					<div class="labelColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
						<label style="<%=InfoCellStyle%>"><big>Project Name</big></label>
						<label style="<%=InfoCellStyle%>"># of Floors</label>
						<label style="<%=InfoCellStyle%>">Square Footage</label>
						<label style="<%=InfoCellStyle%>">Date Created</label>
						<label style="<%=InfoCellStyle%>">Bid Due</label>
						<label style="<%=InfoCellStyle%>">Bid Type</label>
					</div>
					<div class="fieldColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
						<div class=fieldDiv style="<%=InfoCellStyle%> z-index:0;" id=ProjName ><%=editLink%><div><%=pName%></div></div>
						<div class=fieldDiv style="<%=InfoCellStyle%>" id="Floors"><%=editLink&rs("Floors")%></div>
						<div class=fieldDiv style="<%=InfoCellStyle%>" id=SqFoot><%=editLink&rs("SqFoot")%></div>
						<div class=fieldDiv style="<%=InfoCellStyle%>"><%=rs("DateEnt")%></div>
						<div class=fieldDiv id=BiddingDueDate style="<%=InfoCellStyle%>"><%=dateLink&rs("BiddingDueDate")%></div>
						<%onClick="WSQLUBitSJAX('Projects','Use2010Bidder',"&notNewBidder&",'ProjID',"&projId&"); window.location=window.location;"%>
						<div class=fieldDiv id=Use2010Bidder style="height:100%;"><span style="float:left; font-size:14px; line-height:20px;"><%=bidType%></span></div>
					</div>
					<div class="labelColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
						<label style="<%=InfoCellStyle%>">Project Manager</label>
						<label style="<%=InfoCellStyle%>">Address</label>
						<label style="<%=InfoCellStyle%>">City</label>
						<label style="<%=InfoCellStyle%>">State</label>
						<label style="<%=InfoCellStyle%>">Zip</label>
						<label style="<%=InfoCellStyle%>">Bid Convert</label>
					</div>
					<div class="fieldColumn w25p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
						<div class=fieldDiv id=RCSPM style="<%=InfoCellStyle%>"><%=editLink&rs("RCSPM")%></div>
						<div class=fieldDiv id=ProjAddress style="<%=InfoCellStyle%>"><%=editLink&Address%></div>
						<div class=fieldDiv id=ProjCity style="<%=InfoCellStyle%>"><%=editLink&City%></div>
						<div class=fieldDiv id=ProjState style="<%=InfoCellStyle%>"><%=editLink&rs("ProjState")%></div>
						<div class=fieldDiv id=ProjZip style="<%=InfoCellStyle%>"><%=editLink&rs("ProjZip")%></div>
						<div class=fieldDiv style="<%=InfoCellStyle%> white-space:normal;">
							<span class="ToolbarButton fR h20 tO" style="font-size:14px; margin:0 3px 0 0;" onClick="<%=onClick%>">Convert to <%=notBidType%></span>
						</div>
					</div>
					<div class="labelColumn w50p" style="height:<%=iRowMH%>px; min-height:<%=iRowMH%>px;">
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
				<div id=CostingTitle class=ProjInfoTitle>Project Cost Breakdown</div>
				<div id=Costing class=ProjInfo height=418px style="height:49%; min-height:256px; margin-bottom:32px;">
					<div class="labelColumnT w16p" style="height:100%; min-height:256px;">
						<%
						cRowH=fix((100/8)*3)/3 
						cRowMH=fix((256/8)*3)/3 
						costingCellStyle="height:"&cRowH&"%; min-height:"&cRowMH&"px; -moz-min-height:0px;"
						costingBottomStyle="height: calc(100% - ("&cRowH&"% * 7) ); min-height:"&cRowMH&"px; -moz-min-height:0px;"
						%>
						<label style="<%=costingCellStyle%>">&nbsp;</label>
						<label style="<%=costingCellStyle%>">Materials</label>
						<label style="<%=costingCellStyle%>">Labor</label>
						<label style="<%=costingCellStyle%>">Expenses</label>
						<label style="<%=costingCellStyle%>">Overhead</label>
						<label style="<%=costingCellStyle%>">Taxes</label>
						<label style="<%=costingCellStyle%>">Profit</label>
						<label style="<%=costingBottomStyle%>">Total</label>
					</div>
					<div class="fieldColumn w16p" style="height:100%; min-height:256px;" >
						<div class=fieldDivT style="<%=costingCellStyle%>" align="center"><b>$</b></div>
						<div class=fieldDivT style="<%=costingCellStyle%>" id=PartsCost align=right></div>
						<div class=fieldDivT style="<%=costingCellStyle%>" id=LaborCost align=right></div>
						<div class=fieldDivT style="<%=costingCellStyle%>" id=ExpensesCost align=right></div>
						<div class=fieldDivT style="<%=costingCellStyle%>" id=OverheadCost align=right></div>
						<div class=fieldDivT style="<%=costingCellStyle%>" id=TaxCost align=right></div>
						<div class=fieldDivT style="<%=costingCellStyle%>" id=ProfitCost align=right></div>
						<div class="fieldDivT Total" style="<%=costingBottomStyle%>" id=ProjectTotal2 align=right></div>
					</div>
					<div class="fieldColumn w16p" style="height:100%; min-height:256px;" >
						<div class=fieldDivT style="<%=costingCellStyle%>" align="center"><b>%</b></div>
						<div class=fieldDivT style="<%=costingCellStyle%>" id=PartsPerc align=right></div>
						<div class=fieldDivT style="<%=costingCellStyle%>" id=LaborPerc align=right></div>
						<div class=fieldDivT style="<%=costingCellStyle%>" id=ExpensesPerc align=right></div>
						<div class=fieldDivT style="<%=costingCellStyle%>" id=OverheadPerc align=right></div>
						<div class=fieldDivT style="<%=costingCellStyle%>" id=TaxPerc align=right></div>
						<div class=fieldDivT style="<%=costingCellStyle%>" id=ProfitPerc align=right></div>
						<div class="fieldDivT Total" style="<%=costingBottomStyle%>" align=right>100%</div>
					</div>
					<iframe id=costPie class=fieldColumn style="border:none; height:100%; min-height:256px; width:50%;"></iframe>
				</div>
			</div>
			
			
		</div>
	</div>
	
	<iframe id=SecPage class="tabPage" src="BidSections.asp?projId=<%=projId%>"></iframe>
	
	<div id=PrintingPage class="tabPage">
		<script>	var crashBang=setTimeout('location=location;',500);	</script>
		<!--#include file="Bid\PrintingTab.asp" -->
	</div>
	
</div>
<br/>
<script>setTimeout('Resize();',50);</script>
</body>
</html>