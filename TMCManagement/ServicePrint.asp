<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<title>Tricom Bid</title>
	
	<!--#include file="../TMC/RED.asp" -->
	<!--#include file="common.asp" -->
	
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


@media screen { body{border:.0078125in skyblue outset;} .pageBreak {display:block;} }
</style>

</head>

<body onLoad="onLoad();">
<%
ProjID = CStr(Request.QueryString("ProjID"))
CustID = CStr(Request.QueryString("CustID"))

F="ProjName, ProjAddress, ProjCity, ProjState, ProjZip, Use2010Bidder"
F=F&",pLHeadID, pLetter, pLetterTitle, pScopeTitle, pPrintDate, pTax, pScope, pInc, pExc, pSysTotals, pSubT, pTotal, pSignedTCS, pSignedCust, LicFooter, AddressFooter"
F=F&",pAddressing, pBody, pParts, pPartsPrice, pPartsTotal, pLabor, pLaborPrice, pLaborTotal, pLegalNotes"
SQL = "SELECT "&F&" FROM Projects WHERE ProjID = "&ProjID
set rs=Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring

SQL3 = "SELECT Name, Address, City, State, Zip, Phone1, Fax, Contact1 FROM Contacts WHERE ID = "&CustID
set rs3=Server.CreateObject("ADODB.Recordset")
rs3.Open SQL3, REDconnstring

Dim Customer: Customer=DecodeChars(rs3("Name"))


SQL5 = "SELECT CustName, Addressing, SignedBy FROM BidTo WHERE ProjID = "&ProjID&" AND CustID = "&CustID
set rs5=Server.CreateObject("ADODB.Recordset")
rs5.Open SQL5, REDconnstring

SQL2="SELECT Image FROM LetterHeads WHERE HeaderID="&rs("pLHeadID")
set rs2=Server.CreateObject("ADODB.Recordset")
rs2.Open SQL2, REDconnstring

%>
<img src="../Images/<%=rs2("Image")%>" width=100% />	
	
<div class="fs5-16 taC w100p" ><%=DecodeChars(rs("pLetterTitle"))%></div>

<div class="w100p" style="height:1in;">
	<div class="w60p fL">
		<%=Customer%><br/>
		<div class="fs1-8">
			<%=rs3("Address")%><br/><%=rs3("City")%>,&nbsp;<%=rs3("State")%>&nbsp;<%=rs3("Zip")%><br/>
			Phone: <%=rs3("Phone1")%><br/>Fax: <%=rs3("Fax")%>
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
<%

If rs("pLetter")="True" Then 
	Addressing=rs("pAddressing")
	If Addressing="" Or (IsNull(Addressing)) Then Addressing = rs3("Contact1")
	%>
	<div class="w100p">
		<%=Addressing%>&#44;<br/>
		&nbsp; &nbsp; <%=DecodeChars(CR2Br(rs("pBody")))%>
	</div>
	<%
End If
	
F="SystemID, PrintChecked, System, Notes, Includes, Excludes, TaxRate, FixedPrice, Overhead, MU, TotalFixed, Round, Notes"
SQL4 = "SELECT "&F&" FROM Systems WHERE ProjectID = "&ProjID&" AND PrintChecked = 'True' "
set rs4=Server.CreateObject("ADODB.Recordset")
rs4.Open SQL4, REDconnstring

Do Until rs4.EOF
	
	SysID = rs4("SystemID")
	PrintChecked = rs4("PrintChecked")
	
		SysSystem = DecodeChars(rs4("System"))
		SysNotes = DecodeChars(CR2Br(rs4("Notes")))
		
		%>
		<br/>
		<div class="bold fs3-16 ul mB0625 w100p taC">&nbsp;<%=SysSystem%>&nbsp;</div>
		<%
		If rs("pScope") = "True" AND SysNotes <> "" Then 
			%>
			<div class="mL25">
				<div class="ul"><%=rs("pScopeTitle")%></div>
				&nbsp; &nbsp; <%=SysNotes%>
			</div>
			<%
		End If
		
		useNewBidder=(rs("use2010Bidder")="True")
		If Not useNewBidder Then 
			PartsPrice=(rs("pPartsPrice")="True")
			LaborPrice=(rs("pLaborPrice")="True")
		Else 
			PartsPrice=False
			LaborPrice=False
		End If
		
		Margin=(rs4("MU")/100)+1
		
		If rs("pParts")="True" Then
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
		SQL6="SELECT BidItemsID, Cost, Qty, ItemName, ItemDescription FROM BidItems WHERE Type='Part' AND editable<>1 AND SysID = "&SysID
		Set rs6=Server.CreateObject("ADODB.Recordset")
		rs6.Open SQL6, REDconnstring

		Do Until rs6.EOF
			cost=rs6("Cost")
			qty=rs6("Qty") : if qty="" Or IsNull(qty) Then qty=0
			
			If UseNewBidder Then Parts=Parts+(cost*qty) Else Parts=Parts+(cost*qty*Margin)
			
			If rs("pParts")="True" Then
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
		If rs("pPartsTotal") = "True" Then
			%>
			<div class="w80p taR" style="height:.25in; margin-left:10%; overflow:hidden;">
				Materials Total: &nbsp;<font face=Consolas><%=formatCurrency(parts)%></font>
			</div>
			<%
		End If
		
		
		
		
		If rs("pLabor")="True" Then
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
		SQL7="SELECT BidItemsID, Cost, Qty, ItemName, ItemDescription FROM BidItems WHERE Type='Labor' AND editable<>1 AND SysID = "&SysID
		Set rs7=Server.CreateObject("ADODB.Recordset")
		rs7.Open SQL7, REDconnstring

		Do Until rs7.EOF
			cost=rs7("Cost")
			qty=rs7("Qty")
			
			If UseNewBidder Then Labor=Labor+(cost*qty) Else Labor=Labor+(cost*qty*Margin)
			
			If rs("pLabor")="True" Then
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
		If rs("pLaborTotal") = "True" Then
			%>
			<div class="w80p taR" style="height:.25in; margin-left:10%; overflow:hidden;">
				Labor Total: &nbsp;<font face=Consolas><%=formatCurrency(labor)%></font>
			</div>
			<br/>
			<%
		End If
		
		
		
		
		
		Equipment=0
		Travel=0
		SQL8="Select UnitCost, Units, Type From Expenses WHERE editable<>1 AND SysID = "&SysID&" ORDER BY Type"
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
		
		SysTaxRate = rs4("TaxRate") : if SysTaxRate = "" or (IsNull(SysTaxRate)) then SysTaxRate = 0
		If UseNewBidder Then SysSalesTax = (SysTaxRate*Parts)/100 Else SysSalesTax = SysTaxRate*Parts/100
		FixedPrice="0"&rs4("FixedPrice")
		Overhead="0"&rs4("Overhead")
		Profit="0"&rs4("MU")
		
		TotalFixed=rs4("TotalFixed")
		
		If Not useNewBidder Then
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
			SysSystem: <%=SysSystem%>
			Parts: <%=Parts%>
			Labor: <%=Labor%>
			Travel: <%=Travel%>
			Equipment: <%=Equipment%>
			Expenses: <%=Expenses%>
			Overhead: <%=Overhead%>
			Profit: <%=Profit%>
			Margin: <%=Margin%>
			FixedPrice: <%=FixedPrice%>
			SysTaxRate: <%=SysTaxRate%>
			SysSalesTax: <%=SysSalesTax%>
		</div>

		<%
		SysTotal=(FixedPrice*1)'+(SysSalesTax*1)
		OverheadCost=(Overhead*FixedPrice)/100
	
		ProfitDollars=FixedPrice-OverheadCost-Expenses-Parts-Labor
		
		ProfitDollars=(ProfitDollars*100)/100
		
		If rs("pTax")="True" Then SysTotal=SysTotal - SysSalesTax
		
		'% ><script type="text/javascript">alert('<%=SysTotal% >');< /script><%
		MoneyFormat = SysTotal-SysSalesTax
		MoneyFormat = FormatCurrency(MoneyFormat,2)
		

		SysIncludes = DecodeChars(CR2Br(rs4("Includes")))

		SysExcludes = DecodeChars(CR2Br(rs4("Excludes")))

		If rs("pInc") = "True" AND SysIncludes <> "" Then 
			%>
			<br/>
			<div class="mL25">
				<div class="ul">Includes:</div>
				<%=SysIncludes%>
			</div>
			<%
		End If 
		
		If rs("pExc") = "True" AND SysExcludes <> "" Then 
			%>
			<br/>
			<div class="mL25">
				<div class="ul">Excludes:</div>
				<%=SysExcludes%>
			</div>
			<%
		End If 

		SubTotal = SubTotal + SysTotal
		If rs("pSysTotals") = "True" Then 
			%>
			<div class="taRP ul pR25">Total For: <%=SysSystem%> &nbsp; &nbsp; <font face="consolas"><%=FormatCurrency(SysTotal,2)%></font></div>
			<%
		End If 

		If rs("pTax")="True" Then TotalTax = TotalTax+SysSalesTax
			
		rs4.MoveNext 
	Loop


	If rs("pSubT") = "True" Then 
		%><div class="taRP ul bold pR25 fs11-64">Subtotal: &nbsp; <font face="consolas"><%=FormatCurrency(SubTotal,2)%></font> </div><%
	End If

	If rs("pTax")="True" Then 
		%><div class="taRP ul pR25">Sales Tax @<%=SysTaxRate%>%: &nbsp; &nbsp; <font face="consolas"><%=FormatCurrency(TotalTax)%></font></div><%
		'TotalsTotal = TotalsTotal*(1+(SysSalesTax/100))
	End If


	If rs("pTotal") = "True" Then 
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
			
	Set rs4 = Nothing
%>  

<hr/>  
<p style="line-height:.1in; font-family:Verdana, Geneva, sans-serif; font-size:.1in;">&nbsp; &nbsp; <%=DecodeChars(CR2BR(rs("pLegalNotes")))%></p> 
<br/>
<div class="mL25">The undersigned parties herby acknowledge the acceptance of the above detailed Proposal:</div>

<div class=w100p>
	<div class="w50p taC fL">
		Tricom Representative
		<div class=w80p style="border-bottom:1px #000 solid; margin-left:10%; height:.375in;"></div>
		<font class="w80p taC fs3-32" face="Calibri" style='display:block; margin-left:10%; height:.125in; border-top:1px #000 solid; '><%=rs("pSignedTCS")%></font>
	</div>
	<div class="w50p taC fL">
		<%=Customer%> Representative
		<div class=w80p style="border-bottom:1px #000 solid; margin-left:10%; height:.375in;"></div>
		<font class="w80p taC fs3-32" face="Calibri" style='display:block; margin-left:10%; height:.125in; border-top:1px #000 solid; '><%=rs("pSignedCust")%></font>
	</div>
</div>
<hr class="fL w100p"/>

<div class="fL w100p" align="center" style="overflow:visible; text-align:center; width:100%;">  
	<div class="CompanyInfo"><%=DecodeChars(rs("AddressFooter"))%></div>
	<div id="FooterContainer"></div>
	<script type="text/javascript">
		Gebi('FooterContainer').innerHTML=CharsDecode('<%=rs("LicFooter")%>');
	</script>      
</div>

<%
set rs = nothing
set rs2 = nothing
set rs3 = nothing
%>
</body>
</html>