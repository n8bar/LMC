<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<title>LMC Bid Proposal</title>
	
	<!--#include file="../LMC/RED.asp" -->
	<!--#include file="Common.asp" -->
	
	<link rel=stylesheet href="Library/CSS_DEFAULTS.css" media=all>
	
	<script type="text/javascript" src="Modules/rcstri.js"></script>
	<script type="text/javascript" src="Modules/Num2word.js"></script>

<script type="text/javascript">
	function onLoad() {
		var h=document.body.offsetHeight;
		document.body.style.height='auto';
		var H=document.body.offsetHeight;
		
		var p=H/h;
		var P=Math.round(p);
		if(P<p) { P++; }
		
		document.body.style.height=(P*h)+'px';
		<%pageH=10.5%>
		for(l=1;l<P;l++) {                                             
			document.body.innerHTML+='<hr class=pageBreak style=" top:'+(<%=pageH%>*l)+'in;" />';
		}
		
		//window.print();
	}
</script>
	
<style>
html{background:#ccc; height:100%; margin:0; overflow:auto; padding:0; text-align:center; width:100%; }
body{background:#fff; border:none; box-sizing:border-box; font-family:Verdana, Geneva, sans-serif; font-size:.15625in; height:<%=pageH%>in; margin:0; margin:.0625in auto .25in auto; overflow:hidden; padding:0; text-align:left; width:8in;}


.pageBreak {border-color:skyblue; display:none; font-size:10px; position:absolute; width:8in; }

.bold {font-weight:bold;}
.ul {text-decoration:underline;}

.mL25 {margin-left:.25in;}

.mB0625 {margin-bottom:.0625in;}
.mB125 {margin-bottom:.125in;}

.pR25 {padding-right:.25in;}

.fs3-32 {font-size:.09375in;}
.fs1-8  {font-size:.125in;}
.fs5-32 {font-size:.15625in;}
.fs3-16 {font-size:.1875in;}
.fs11-64 {font-size:.171875in;}
.fs7-32  {font-size:.21875in;}
.fs1-4  {font-size:.25in;}
.fs5-16  {font-size:.3125in;}

#proposalTop { min-height:2.5in;}
#proposalBody { min-height:6.25in;}
#proposalBottom { min-height:1.713in;}

@media screen { body{border:.0078125in skyblue outset;} .pageBreak {display:block;} }
</style>

</head>

<body onLoad="onLoad();">
<%
ProjID = CStr(Request.QueryString("ProjID"))
CustID = CStr(Request.QueryString("CustID"))

F=F&"ID, pLHeadID, pLetter, pLetterTitle, pScopeTitle, pPrintDate, pTax, pScope, pInc, pExc, pSecTotals, pSubT, pTotal, pSignedTCS, pSignedCust, LicFooter, AddressFooter"
F=F&",pAddressing, pBody, pParts, pPartsPrice, pPartsTotal, pLabor, pLaborPrice, pLaborTotal, pTravel, pLegalNotes"
psSQL = "SELECT "&F&" FROM ProposalPrint WHERE ProjID = "&ProjID
set psRs=Server.CreateObject("ADODB.Recordset")
   %><%'=psSQL%><%
psRs.Open psSQL, REDconnstring

F="ProjName, ProjAddress, ProjCity, ProjState, ProjZip, Use2010Bidder"
SQL = "SELECT "&F&" FROM Projects WHERE ProjID = "&ProjID
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring

SQL3 = "SELECT Name, Address, City, State, Zip, Phone1, Fax, Contact1 FROM Contacts WHERE ID = "&CustID
set rs3=Server.CreateObject("ADODB.Recordset")
rs3.Open SQL3, REDconnstring

If rs3.EOF Then 
	%><br/>
	<center>
		<big>
			<big><big><big><big>Oops<big><i>!</i></big></big></big></big></big><br/><br/>
			We cannot generate this bid because Customer #<%=CustID%> has been deleted.<br/>
			Please assign a new Customer and print the bid again.<br/><br/>
		</big>
		Sorry for the inconvenience.
	</center>
	<%
	response.End()
End If

SQL5 = "SELECT CustName, Addressing, SignedBy FROM BidTo WHERE ProjID = "&ProjID&" AND CustID = "&CustID
set rs5=Server.CreateObject("ADODB.Recordset")
rs5.Open SQL5, REDconnstring

SQL2="SELECT Image, HeaderName, Abbreviation FROM LetterHeads WHERE HeaderID="&psRs("pLHeadID")
set rs2=Server.CreateObject("ADODB.Recordset")
rs2.Open SQL2, REDconnstring
LetterHeadImage=rs2("Image")
ThisCompany=rs2("HeaderName")
ThisCo=rs2("Abbreviation")


Customer=DecodeChars(rs3("Name"))
custAddress=DecodeChars(rs3("Address"))
custCity=DecodeChars(rs3("City"))
custState=DecodeChars(rs3("State"))
custZip=DecodeChars(rs3("Zip"))
custPhone=rs3("Phone1") : If IsNull(custPhone) Then custPhone=0 : custPhone=cDbl(custPhone)
custFax=rs3("Fax") : If IsNull(custFax) Then custFax=0 : custFax=cDbl(custFax)

%>
<div id=proposalTop>
<img src="../Images/<%=LetterHeadImage%>" width=100% />	
	
<div class="fs5-16 taC w100p" ><%=DecodeChars(psRs("pLetterTitle"))%></div>

<div class="w100p" style="height:1in;">
	<div class="w60p fL">
		<%=Customer%>
		<div class="fs1-8">
			<%
			If Not IsNull(custAddress) and custAddress<>"" Then 
				%><br/><%=custAddress%><%
				If Not IsNull(custCity) and custCity<>"" Then 
					%><br/><%=custCity%>,&nbsp;<%=custState%>&nbsp;<%=custZip%><%
				End If	
			End If
			If cStr(custPhone)<>"0" Then %><br/>Phone: <%=Phone(custPhone)%><%	End If
			If cStr(custFax)<>"0" Then %><br/>Fax: <%=Phone(custFax)%><% End If
			%>
		</div>
	</div>
	<div class="w40p fL">
		<%=Date%>&nbsp;<%'=Time%>
		<br/>
		Re:&nbsp;<%=DecodeChars(rs("ProjName"))%><br/>
		<%=rs("ProjAddress")%><br/> 
		<%=rs("ProjCity")%>,&nbsp;<%=rs("ProjState")%>&nbsp;<%=rs("ProjZip")%><br/>
		<br/>
		Bid# <%=ProjID%>
	</div>
</div>
<br/>
</div>
<div id=proposalBody>
<%

If psRs("pLetter")="True" Then 
	Addressing=psRs("pAddressing")
	If Addressing="" Or (IsNull(Addressing)) Then Addressing = rs3("Contact1")
	%>
	<div class="w100p">
		<%=Addressing%>&#44;<br/>
		&nbsp; &nbsp; <%=DecodeChars(CR2Br(psRs("pBody")))%>
	</div>
	<%
End If

secListSQL="SELECT * FROM ProposalPrintSections WHERE MasterID="&psRs("ID")
set secListRS=Server.CreateObject("ADODB.Recordset")
secListRS.Open secListSQL, REDconnstring

Do Until secListRS.EOF
	
	F="SectionID, Section, Notes, Includes, Excludes, TaxRate, FixedPrice, Overhead, MU, TotalFixed, Round, Notes"
	SQL4 = "SELECT "&F&" FROM Sections WHERE SectionID = "&secListRS("DetailID")
	set rs4=Server.CreateObject("ADODB.Recordset")
	rs4.Open SQL4, REDconnstring
	
	if rs4.EOF Then
		'Sometimes a section is deleted but not from ProposalPrintSections. This if block is a bandaid to ignore those.
	Else 
		SecID = rs4("SectionID")
		
			SecSection = DecodeChars(rs4("Section"))
			SecNotes = DecodeChars(CR2Br(rs4("Notes")))
			
			%>
			<br/>
			<div class="bold fs3-16 ul mB0625 w100p taC">&nbsp;<%=SecSection%>&nbsp;</div>
			<%
			If psRs("pScope") = "True" AND SecNotes <> "" Then 
				%>
				<div class="mL25">
					<div class="ul"><%=psRs("pScopeTitle")%></div>
					&nbsp; &nbsp; <%=SecNotes%>
				</div>
				<%
			End If
			
			useNewBidder=(rs("use2010Bidder")="True")
			If Not useNewBidder Then 
				PartsPrice=(psRs("pPartsPrice")="True")
				LaborPrice=(psRs("pLaborPrice")="True")
			Else 
				PartsPrice=False
				LaborPrice=False
			End If
			
			Margin=(rs4("MU")/100)+1
			
			If psRs("pParts")="True" Then
				%>
				<br/>
				<div class="w80p ul taC fs3-16" style="margin-left:10%;">Materials</div>
				<div class="w80p taC" style="border-bottom:.0078125in solid #ccc; height:.1875in; margin-left:10%;">
					<div class="w10p fL taR">Qty</div>
					<div class="w20p fL taC">Part#</div>
					<%
					If PartsPrice Then
						%>
						<div class="w40p fL taC">Description</div>
						<div class="w15p fL taR">Price</div>
						<div class="w15p fL taR">Total</div>
						<%
					Else
						%><div class="w70p fL taC">Description</div><%
					End If
					%>
				</div>
				<%
			End If
			
			Parts=0
			SQL6="SELECT BidItemsID, Cost, Qty, ItemName, ItemDescription FROM BidItems WHERE Type='Part' AND editable<>1 AND SecID = "&SecID
			Set rs6=Server.CreateObject("ADODB.Recordset")
			rs6.Open SQL6, REDconnstring
	
			Do Until rs6.EOF
				cost=rs6("Cost")
				qty=rs6("Qty") : if qty="" Or IsNull(qty) Then qty=0
				
				If UseNewBidder Then Parts=Parts+(cost*qty) Else Parts=Parts+(cost*qty*Margin)
				
				If psRs("pParts")="True" Then
					bIId=rs6("BidItemsID")
					
					itemPrice=cost*margin
					%><!-- <%
					%><%=qty%><br/><%
					%><%=cost%><br/><%
					%><%=margin%><br/><%
					%> --><%
					itemTotal=(qty*cost*Margin)*1
					boxStyle="overflow:hidden; text-overflow:ellipsis; white-space:nowrap; "
					%>
					<div class="w80p taC fs1-8" style="height:.1875in; margin-left:10%; overflow:hidden;">
						<div id=Qty<%=bIId%> class="h100p w10p fL taRP" style="<%=boxStyle%>"><font face=Consolas><%=qty%></font></div>
						<div id=PN<%=bIId%> class="h100p w20p fL taLP" style="<%=boxStyle%>"><%=DecodeChars(rs6("ItemName"))%></div>
						<%
						If PartsPrice Then
							if itemPrice=0 Then itemPrice="FREE" Else itemPrice=formatCurrency(itemPrice)
							%>
							<div id=Desc<%=bIId%> class="h100p w40p fL taLP" style="<%=boxStyle%>"><%=DecodeChars(rs6("ItemDescription"))%></div>
							<div id=Price<%=bIId%> class="h100p w15p fL taRP" style="<%=boxStyle%>"><font face=Consolas><%=itemPrice%></font></div>
							<div id=Total<%=bIId%> class="h100p w15p fL taRP" style="<%=boxStyle%>"><font face=Consolas><%=formatCurrency(itemTotal)%></font></div>
							<%
						Else
							%><div id=Desc<%=bIId%> class="h100p w70p fL taLP" style="<%=boxStyle%>"><%=DecodeChars(rs6("ItemDescription"))%></div><%
						End If
					%>
					</div>
					<%
				End IF
				
				rs6.MoveNext
			Loop
	
			SecTaxRate = rs4("TaxRate") : if SecTaxRate = "" or (IsNull(SecTaxRate)) then SecTaxRate = 0
			If UseNewBidder Then SecSalesTax = (SecTaxRate*Parts)/100 Else SecSalesTax = SecTaxRate*Parts/100
			FixedPrice="0"&rs4("FixedPrice")
			Overhead="0"&rs4("Overhead")
			Profit="0"&rs4("MU")
			
			TotalFixed=rs4("TotalFixed")
			
	
	
			If psRs("pPartsTotal") = "True" Then
				ShownMaterialsTotal=parts
				If NOT psRs("pTax")="True" Then ShownMaterialsTotal=ShownMaterialsTotal+SecSalesTax
				%>
				<div class="w80p taR" style="height:.25in; margin-left:10%; overflow:hidden;">
					Materials Total: &nbsp;<font face=Consolas><%=formatCurrency(ShownMaterialsTotal)%></font>
				</div>
				<%
			End If
			
			
			
			
			If psRs("pLabor")="True" Then
				%>
				<br/>
				<div class="w80p ul taC fs3-16" style="margin-left:10%;">Labor</div>
				<div class="w80p taC" style="border-bottom:.01in solid #ccc; height:.1875in; margin-left:10%;">
					<div class="w10p fL taC">Hrs</div>
					<div class="w20p fL taC">Labor</div>
					<%
					If LaborPrice Then
						%>
						<div class="w50p fL taC" style="<%=boxStyle%>" >Description</div>
						<div class="w20p fL taC">$</div>
						<%
					Else
						%><div class="w70p fL taC" style="<%=boxStyle%>">Description</div><%
					End If
					%>
				</div>
				<%
			End If
			
			Labor=0
			SQL7="SELECT BidItemsID, Cost, Qty, ItemName, ItemDescription FROM BidItems WHERE Type='Labor' AND editable<>1 AND SecID = "&SecID
			Set rs7=Server.CreateObject("ADODB.Recordset")
			rs7.Open SQL7, REDconnstring
	
			Do Until rs7.EOF
				cost=rs7("Cost")
				qty=rs7("Qty")
				
				If UseNewBidder Then Labor=Labor+(cost*qty) Else Labor=Labor+(cost*qty*Margin)
				
				If psRs("pLabor")="True" Then
					bIId=rs7("BidItemsID")
					
					itemTotal=qty*cost*Margin
					boxStyle="style="" overflow:hidden;"""
					%>
					<div class="w80p taC fs1-8" style="height:.1875in; margin-left:10%; overflow:hidden;">
						<div id=Qty<%=bIId%> class="h100p w10p fL taRP" style="<%=boxStyle%>"><font face=Consolas><%=qty%></font></div>
						<div id=LN<%=bIId%> class="h100p w20p fL taLP" style="<%=boxStyle%>"><%=DecodeChars(rs7("ItemName"))%></div>
						<%
						If LaborPrice Then
							%>
							<div id=Desc<%=bIId%> class="h100p w50p fL taLP" style="<%=boxStyle%>"><%=DecodeChars(rs7("ItemDescription"))%></div>
							<div id=Qty<%=bIId%> class="h100p w20p fL taRP" style="<%=boxStyle%>"><font face=Consolas><%=formatCurrency(itemTotal)%></font></div>
							<%
						Else
							%><div id=Desc<%=bIId%> class="h100p w70p fL taLP" style="<%=boxStyle%>"><%=DecodeChars(rs7("ItemDescription"))%></div><%
						End If
					%>
					</div>
					<%
				End IF
				
				rs7.MoveNext
			Loop
			
			
			
			
			
			Equipment=0
			Travel=0
			SQL8="Select UnitCost, Units, Type From Expenses WHERE editable<>1 AND SecID = "&SecID&" ORDER BY Type"
			set rs8=Server.CreateObject("ADODB.Recordset")
			rs8.Open SQL8, REDconnstring
			
			Do Until rs8.EOF
				
				itemCost=unCurrency(DecodeChars(rs8("UnitCost")))
				itemQty=rs8("Units")
				
				Select Case rs8("Type")
					Case "Equip"
						Equipment=Equipment+(itemCost*itemQty)
	
					Case "Travel"
						Travel=Travel+(itemCost*itemQty)
				
				End Select
				
				rs8.MoveNext
			Loop
			
			Set rs8=Nothing
			
			if Parts = "" or (IsNull(Parts)) then Parts = 0
			if Labor = "" or (IsNull(Labor)) then Labor = 0
			if Travel = "" or (IsNull(Travel)) then Travel = 0
			if Equipment = "" or (IsNull(Equipment)) then Equipment = 0
			Expenses=Travel+Equipment
	
	
			If psRs("pLaborTotal") = "True" Then
				ShownLaborTotal=labor
				If NOT psRs("pTravel")="True" Then ShownLaborTotal=ShownLaborTotal+Travel
				%>
				<div class="w80p taR" style="height:.25in; margin-left:10%; overflow:hidden;">
					Labor Total: &nbsp;<font id=LaborTotal face=Consolas><%=formatCurrency(ShownLaborTotal)%></font>
				</div>
				<%
			End If
	
	
	
			
			If Not useNewBidder and psRs("pLaborTotal") = "True" And psRs("pLabor")="True" Then
				If Travel <> 0 Then
					%>
					<div class="w60p ul taL fs3-16" style="margin-left:10%;">Travel <span style="font-family:Consolas;"><%=formatCurrency(Travel)%></span></div>
					<br/>
					<%
				End If
				If Equipment <> 0 Then
					%>
					<div class="w60p ul taL fs3-16" style="margin-left:10%;">Equipment <span style="font-family:Consolas;"><%=formatCurrency(Equipment)%></span></div>
					<br/>
					<%
				End If
				If Other <> 0 Then
					%>
					<div class="w60p ul taL fs3-16" style="margin-left:10%;">Goverment Fees and Misc Charges <span style="font-family:Consolas;"><%=formatCurrency(Other)%></span></div>
					<br/>
					<%
				End If
			End If
			
			%>
			<div style="display:none; white-space:pre; color:silver; font-size:10px; font-family:Consolas, 'Courier New', Courier, monospace;">
				SecSection: <%=SecSection%>
				Parts: <%=Parts%>
				Labor: <%=Labor%>
				Travel: <%=Travel%>
				Equipment: <%=Equipment%>
				Expenses: <%=Expenses%>
				Overhead: <%=Overhead%>
				Profit: <%=Profit%>
				Margin: <%=Margin%>
				FixedPrice: <%=FixedPrice%>
				SecTaxRate: <%=SecTaxRate%>
				SecSalesTax: <%=SecSalesTax%>
			</div>
	
			<%
			SecTotal=(FixedPrice*1)'+(SecSalesTax*1)
			OverheadCost=(Overhead*FixedPrice)/100
		
			ProfitDollars=FixedPrice-OverheadCost-Expenses-Parts-Labor
			
			ProfitDollars=(ProfitDollars*100)/100
			
			If psRs("pTax")="True" Then SecTotal=SecTotal - SecSalesTax
			
			If psRs("pLaborTotal") = "True" AND psRs("pPartsTotal") = "True" Then
				%>
				<script type="text/javascript">
					//	alert('<%=SecTotal%>');
					LaborTotal.innerHTML='<%=formatCurrency(SecTotal-ShownMaterialsTotal,2)%>';
				</script>
				<%
			End If
			
			MoneyFormat = SecTotal-SecSalesTax
			MoneyFormat = FormatCurrency(MoneyFormat,2)
			
	
			SecIncludes = DecodeChars(CR2Br(rs4("Includes")))
	
			SecExcludes = DecodeChars(CR2Br(rs4("Excludes")))
			
		End If 'This is supposed to be for the rs4 record-exist check.

		If psRs("pInc") = "True" AND SecIncludes <> "" Then 
			%>
			<div class="mL25 fs1-8">
				<div class="ul">Includes:</div>
				<%=SecIncludes%>
			</div>
			<%
		End If 
		
		If psRs("pExc") = "True" AND SecExcludes <> "" Then 
			%>
			<br/>
			<div class="mL25 fs1-8">
				<div class="ul">Excludes:</div>
				<%=SecExcludes%>
			</div>
			<%
		End If 

		SubTotal = SubTotal + SecTotal
		If psRs("pSecTotals") = "True" Then 
			%><div class="taRP ul pR25">Total For: <%=SecSection%> &nbsp; &nbsp; <font face="consolas"><%=FormatCurrency(SecTotal,2)%></font></div><%
		End If 

		If psRs("pTax")="True" Then TotalTax = TotalTax+SecSalesTax
			
		secListRS.MoveNext 
	Loop


	If psRs("pSubT") = "True" Then 
		%><div class="taRP ul bold pR25 fs11-64">Subtotal: &nbsp; <font face="consolas"><%=FormatCurrency(SubTotal,2)%></font> </div><%
	End If

	If psRs("pTax")="True" Then 
		%><div class="taRP ul pR25">Sales Tax @<%=SecTaxRate%>%: &nbsp; &nbsp; <font face="consolas"><%=FormatCurrency(TotalTax)%></font></div><%
		'TotalsTotal = TotalsTotal*(1+(SecSalesTax/100))
	End If


	If psRs("pTotal") = "True" Then 
		TotalsTotal=Round((SubTotal+TotalTax)*100)/100
		%>
		<div class="taRP ul bold pR25 fs3-16">Total: <font face="consolas"><%=FormatCurrency(TotalsTotal,2)%></font></div>
		<div id=WordPrice class="taRP ul pR25 fs3-16" style=" page-break-before:avoid; font-family:Verdana, Geneva, sans-serif;"></div>

		<script type="text/javascript">
			var Price = '<%=Round(TotalsTotal*100)/100%>';
			Price=Price.split('.');
			var Dollars= Num2Word(Price[0]);
			var Cents=Num2Word(Price[1]*1);
			Gebi('WordPrice').innerHTML=Dollars+' dollars and '+Cents+' cents';
		</script>
		<%
	End If 
			
	Set secListRS = Nothing
%> 
</div> 
<div id=proposalBottom>
	<hr style="margin: 3px 0;"/>  
	<p style="line-height:.1in; font-family:Verdana, Geneva, sans-serif; font-size:.1in;">&nbsp; &nbsp; <%=DecodeChars(CR2BR(psRs("pLegalNotes")))%></p> 
	<hr style="margin: 3px 0 1px 0;"/>  
	<div class=mL25 >The undersigned parties herby acknowledge the acceptance of the above detailed Proposal:</div>

	<div class=w100p>
		<div class="w50p taC fL">
			<%=ThisCo%> Representative
			<div class=w80p style="border-bottom:1px #000 solid; margin-left:10%; height:.375in;"></div>
			<font class="w80p taC fs3-32" face=Calibri style='display:block; margin-left:10%; height:.125in; border-top:1px #000 solid; '><%=psRs("pSignedTCS")%></font>
		</div>
		<div class="w50p taC fL">
			<%=Customer%> Representative
			<div class=w80p style="border-bottom:1px #000 solid; margin-left:10%; height:.375in;"></div>
			<font class="w80p taC fs3-32" face=Calibri style='display:block; margin-left:10%; height:.125in; border-top:1px #000 solid; '><%=psRs("pSignedCust")%></font>
		</div>
	</div>
	<!-- hr class="fL w100p" style="margin: 3px 0;"/ -->

	<div class="fL w100p" align=center style="overflow:visible; text-align:center; width:100%; border-top:#ccc 1px solid;">  
		<div class=CompanyInfo style="color:#402758;"><%=DecodeChars(psRs("AddressFooter"))%></div>
		<div id="FooterContainer"></div>
		<script type="text/javascript">
			Gebi('FooterContainer').innerHTML=CharsDecode('<%=psRs("LicFooter")%>');
		</script>      
	</div>
</div>
<%
set rs = nothing
set rs2 = nothing
set rs3 = nothing
%>
</body>
</html>