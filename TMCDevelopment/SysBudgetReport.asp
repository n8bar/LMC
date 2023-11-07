<%
	sysID = Session("BudgetSysID")

	F="SystemID, PrintChecked, System, Notes, Includes, Excludes, TaxRate, FixedPrice, Overhead, MU, TotalFixed, Round, Notes"
	sbSQL = "SELECT "&F&" FROM Systems WHERE SystemID = "&sysID
	set sbRS=Server.CreateObject("ADODB.Recordset")
	sbRS.Open sbSQL, REDconnstring

	SysSystem = DecodeChars(sbRS("System"))
	SysNotes = DecodeChars(CR2Br(sbRS("Notes")))
	
	%>
	<br/>
	<div class="bold fs1-8 ul mB0625 w50p fL taL">&nbsp;<%=projName%>&nbsp;</div>
	<div class="bold fs1-8 ul mB0625 w50p fL taR">&nbsp;<%=SysSystem%>&nbsp;</div>
	<%
	Margin=1'(sbRS("MU")/100)+1
	%>
	<br/>
	<div class="w90p ul taC fs3-16" style="margin-left:5%;">Materials Taken</div>
	<div class="w90p taL fs1-8" style="margin-left:5%;">
		<b>Instructions:</b> Please list <i>Everything</i> taken from inventory.  Including items from the Job Pack Shelf.<br/>
		&nbsp; &nbsp; - Quantity is required.  Guesstimates are fine for small items like wire nuts, screws, connectors, clamps, etc.<br/>
		&nbsp; &nbsp; - PartNumber is required unless it isn't readily available.<br/>
		&nbsp; &nbsp; - Description is only required if you don't have a PartNumber.  Be sure to say what size or kind etc.<br/>
		&nbsp; &nbsp; - Price is necessary, if any prices cannot be easily obtained, have purchasing fill it in by project end.<br/>
		&nbsp; &nbsp; - <i class=ul >Do Not</i> list items purchased elsewhere while on the job.  Be sure to turn in your receipts on those.<br/>
	</div><br/>
	<div class="w90p taC" style="height:.1875in; margin-left:5%;">
		<div class="w10p fL taC" style="border:.015425in solid #000;">Qty</div>
		<div class="w20p fL taC" style="border:.015425in solid #000;">Part#</div>
		<div class="w40p fL taC" style="border:.015425in solid #000;">Description</div>
		<div class="w15p fL taC" style="border:.015425in solid #000;">Price</div>
		<div class="w15p fL taC" style="border:.015425in solid #000;">Total</div>
	</div>
	<%
	
	Parts=0
	boxStyle="overflow:hidden; text-overflow:ellipsis; white-space:nowrap; border:.015425in solid #888; line-height:inherit;"
	pSQL="SELECT BidItemsID, Cost, Qty, ItemName, ItemDescription FROM BidItems WHERE Type='Part' AND SysID = "&SysID
	Set pRS=Server.CreateObject("ADODB.Recordset")
	pRS.Open pSQL, REDconnstring
	Do Until pRS.EOF
		cost=pRS("Cost")
		qty="0"&pRS("Qty")
		
		Parts=Parts+(cost*qty)
		bIId=pRS("BidItemsID")
		
		itemPrice=cost*margin
		itemTotal=qty*cost*Margin
		%>
		<div class="w90p taC fs1-8" style="height:.1875in; line-height:.1875in; margin-left:5%; overflow:hidden;">
			<div id=Qty<%=bIId%> class="h100p w10p fL taC" style="<%=boxStyle%> color:#ddd;" valign=bottom ><font face=Consolas><%=qty%></font></div>
			<div id=PN<%=bIId%> class="h100p w20p fL taLP" style="<%=boxStyle%>" ><%=DecodeChars(pRS("ItemName"))%></div>
			<div id=Desc<%=bIId%> class="h100p w40p fL taLP" style="<%=boxStyle%>" ><%=DecodeChars(pRS("ItemDescription"))%></div>
			<div id=Price<%=bIId%> class="h100p w15p fL taRP" style="<%=boxStyle%>" ><font face=Consolas><%=formatCurrency(itemPrice)%></font></div>
			<div id=Total<%=bIId%> class="h100p w15p fL taRP" style="<%=boxStyle%>" ><font face=Consolas><%=formatCurrency(itemTotal)%></font></div>
		</div>
		<%
		
		pRS.MoveNext
	Loop

	For lines=1 to 10
		%>
		<div class="w90p taC fs1-8" style="height:.25in; line-height:.1875in; margin-left:5%; overflow:hidden;">
			<div id=Qty<%=lines%> class="h100p w10p fL taC" style="<%=boxStyle%> color:#ddd;" valign=bottom >Qty</div>
			<div id=PN<%=lines%> class="h100p w20p fL taC" style="<%=boxStyle%> color:#ddd;" >PartNumber</div>
			<div id=Desc<%=lines%> class="h100p w40p fL taC" style="<%=boxStyle%> color:#ddd;" >Description</div>
			<div id=Price<%=lines%> class="h100p w15p fL taC" style="<%=boxStyle%> color:#ddd;" >Unit Price</font></div>
			<div id=Total<%=lines%> class="h100p w15p fL taC" style="<%=boxStyle%> color:#ddd;" >Total $</font></div>
		</div>
		<%
	Next
	%>
	<br/>
	<div class="nextPage"></div>
	<div class="bold fs1-8 ul mB0625 w50p fL taL">&nbsp;<%=projName%>&nbsp;</div>
	<div class="bold fs1-8 ul mB0625 w50p fL taR">&nbsp;<%=SysSystem%>&nbsp;</div>
	<div class="w90p ul taC fs3-16" style="margin-left:5%;">Materials Returned to Inventory</div>
	<div class="w90p taL fs1-8" style="margin-left:5%;">
		<b>Instructions:</b> List <i>Everything</i> not used on this job here and return it to Inventory.<br/>
		&nbsp; &nbsp; - If you need any of these items on another job, just keep them and <i>also</i> list them in the <span class=ul style="white-space:nowrap;" >Materials Taken</span> of that job.<br/>
	</div><br/>
	<%
	For lines=1 to 10
		%>
		<div class="w90p taC fs1-8" style="height:.25in; line-height:.1875in; margin-left:5%; overflow:hidden;">
			<div id=Qty<%=lines%> class="h100p w10p fL taC" style="<%=boxStyle%> color:#ddd;" valign=bottom >Qty</div>
			<div id=PN<%=lines%> class="h100p w20p fL taC" style="<%=boxStyle%> color:#ddd;" >PartNumber</div>
			<div id=Desc<%=lines%> class="h100p w40p fL taC" style="<%=boxStyle%> color:#ddd;" >Description</div>
			<div id=Price<%=lines%> class="h100p w15p fL taC" style="<%=boxStyle%> color:#ddd;" >Unit Price</font></div>
			<div id=Total<%=lines%> class="h100p w15p fL taC" style="<%=boxStyle%> color:#ddd;" >Total $</font></div>
		</div>
		<%
	Next
	%>
	<div class="w90p taR" style="height:.25in; margin-left:5%; overflow:hidden;">
		Materials Budget: &nbsp;<font face=Consolas style=""><%=formatCurrency(parts)%></font>
	</div>
	
	<% response.Flush() %>
	
	<div class="w90p ul taC fs3-16" style="margin-left:5%;">Labor</div>
	<div class="w90p taL fs1-8" style="margin-left:5%;">
		<b>Instructions:</b> <i>Do Not</i> list labor here.  Just be sure to turn in your time using these items for your job phases.<br/>
	</div><br/>
	<div class="w90p taC" style="border-bottom:.01in solid #ccc; height:.1875in; margin-left:5%;">
		<div class="w20p fL taC" style="border:.015425in solid #000;" >Labor</div>
		<div class="w70p fL taC" style="border:.015425in solid #000;" >Description</div>
		<div class="w10p fL taC" style="border:.015425in solid #000;" >Total Hrs</div>
	</div>
	<%
	
	Labor=0 : LaborHrs=0
	lSQL="SELECT BidItemsID, Cost, Qty, ItemName, ItemDescription FROM BidItems WHERE Type='Labor' AND SysID = "&SysID
	Set rs7=Server.CreateObject("ADODB.Recordset")
	rs7.Open lSQL, REDconnstring

	Do Until rs7.EOF
		cost=rs7("Cost")
		qty=rs7("Qty")
		
		Labor=Labor+(cost*qty)
		LaborHrs=LaborHrs+qty
	
		bIId=rs7("BidItemsID")
		
		itemTotal=qty*cost*Margin
		%>
		<div class="w90p taC fs1-8" style="height:.1875in; line-height:.1875in; margin-left:5%; overflow:hidden;">
			<div id=LN<%=bIId%> class="h100p w20p fL taLP" style="<%=boxStyle%>" ><%=DecodeChars(rs7("ItemName"))%></div>
			<div id=Desc<%=bIId%> class="h100p w70p fL taLP" style="<%=boxStyle%>" ><%=DecodeChars(rs7("ItemDescription"))%></div>
			<div id=Qty<%=bIId%> class="h100p w10p fL taRP" style="<%=boxStyle%> color:#000;" ><font face=Consolas><%=qty%></font></div>
		</div>
		<%
			'<div id=LTotal<%=bIId% > class="h100p w20p fL taRP" <%=boxStyle% >><font face=Consolas><%=formatCurrency(itemTotal)% ></font></div>
	
		rs7.MoveNext
	Loop
	%>
	<div class="w90p taR" style="height:.25in; margin-left:5%; overflow:hidden;">
		Labor Budget: &nbsp;<font face=Consolas><%=(laborHrs)%> Hrs.</font>
	</div>
	<% response.Flush() %>
	
	<!-- div class=nextPage></div>
	<div class="bold fs1-8 ul mB0625 w50p fL taL">&nbsp;< %=projName%>&nbsp;</div>
	<div class="bold fs1-8 ul mB0625 w50p fL taR">&nbsp;< %=SysSystem%>&nbsp;</div -->
	<div class="w90p ul taC fs3-16" style="margin-left:5%;">Travel / Meals</div>
	<div class="w90p taL fs1-8" style="margin-left:5%;">
		<b>Instructions:</b> <i>Do Not</i> list anything here.  Just be sure to turn in your receipts.<br/>
	</div><br/>
	<div class="w90p taC" style="border-bottom:.01in solid #ccc; height:.1875in; margin-left:5%;">
		<div class="w10p fL taC" style="border:.015425in solid #000;" >Type</div>
		<div class="w25p fL taC" style="border:.015425in solid #000;" >From</div>
		<div class="w25p fL taC" style="border:.015425in solid #000;" >To</div>
		<div class="w7p fL taC" style="border:.015425in solid #000;" >Qty</div>
		<div class="w8p fL taC" style="border:.015425in solid #000;" >Unit</div>
		<div class="w12p fL taC" style="border:.015425in solid #000;" >$ each</div>
		<div class="w13p fL taC" style="border:.015425in solid #000;" >Total</div>
	</div>
	<%	
	
	Travel=0
	SQL8="Select ExpenseID, SubType, Origin, Destination, UnitCost, Units, Type From Expenses WHERE SysID = "&SysID&" AND Type LIKE 'Travel' "
	set rs8=Server.CreateObject("ADODB.Recordset")
	rs8.Open SQL8, REDconnstring
	
	Do Until rs8.EOF
		
		expId=rs8("ExpenseID")
		tType=rs8("SubType")
		Orig=DecodeChars(rs8("Origin"))
		Dest=DecodeChars(rs8("Destination"))
		Qty=rs8("Units")
		Cost=rs8("UnitCost")
		Total=Qty*Cost
		
		Travel=Travel+Total
		
		Unit=""
		SQL9="SELECT Unit FROM TravelType WHERE Type LIKE '"&tType&"'"
		set rs9=Server.CreateObject("AdoDB.RecordSet")
		rs9.Open SQL9, REDConnString
		If Not rs9.EOF Then Unit=rs9("Unit")
		Set rs9=Nothing
		if Unit="" Then Unit="Unit"
		If Qty<>1 Then Unit=Unit&"s"
		
		%>
		<div class="w90p taC fs1-8" style="height:.1875in; line-height:.1875in; margin-left:5%; overflow:hidden;">
			<div id=Type<%=expId%> class="h100p w10p fL taLP" style="<%=boxStyle%>" ><%=tType%></div>
			<div id=Orig<%=expId%> class="h100p w25p fL taLP" style="<%=boxStyle%>" ><%=Orig%></div>
			<div id=Dest<%=expId%> class="h100p w25p fL taLP" style="<%=boxStyle%>" ><%=Dest%></div>
			<div id=Qty<%=expId%> class="h100p w7p fL taRP" style="<%=boxStyle%> color:#000;" ><font face=Consolas><%=qty%></font></div>
			<div id=Unit<%=expId%> class="h100p w8p fL taLP" style="<%=boxStyle%>" ><%=Unit%></div>
			<div id=Cost<%=expId%> class="h100p w12p fL taRP" style="<%=boxStyle%> color:#000;" ><font face=Consolas><%=Cost%></font></div>
			<div id=Total<%=expId%> class="h100p w13p fL taRP" style="<%=boxStyle%> color:#000;" ><font face=Consolas><%=formatCurrency(Total)%></font></div>
		</div>
		<%
		
		rs8.MoveNext
	Loop

	Set rs8=Nothing
	%>
	<div class="w90p taR" style="height:.25in; margin-left:5%; overflow:hidden;">
		Travel Budget: &nbsp;<font face=Consolas><%=(formatCurrency(Travel))%></font>
	</div>
	<br/>
	<% response.Flush() %>
	
	<div class="w90p ul taC fs3-16" style="margin-left:5%;">Equipment</div>
	<div class="w90p taL fs1-8" style="margin-left:5%;">
		<b>Instructions:</b> This is primarily for rental equipment used for this job.<br/>
		Hopefully nothing else needs listed, but, these spaces can be used for Tricom's equipment that was lost, stolen, or damaged or other losses that cannot be shown with receipts.<br/>
	</div><br/>
	<div class="w90p taC" style="border-bottom:.01in solid #ccc; height:.1875in; margin-left:5%;">
		<div class="w12p fL taC" style="border:.015425in solid #000;" >Qty</div>
		<div class="w60p fL taC" style="border:.015425in solid #000;" >Description</div>
		<div class="w12p fL taC" style="border:.015425in solid #000;" >$ each</div>
		<div class="w15p fL taC" style="border:.015425in solid #000;" >Total</div>
	</div>
	<%
	Equip=0
	SQL10="Select ExpenseID, Origin, UnitCost, Units, Type From Expenses WHERE SysID = "&SysID&" AND Type = 'Equip' "
	set rs10=Server.CreateObject("ADODB.Recordset")
	rs10.Open SQL10, REDconnstring
	
	Do Until rs10.EOF
		
		expId=rs10("ExpenseID")
		Desc=DecodeChars(rs10("Origin"))
		Qty=rs10("Units")
		Cost=rs10("UnitCost")
		Total=Qty*Cost
		
		Equip=Equip+Total
					
		%>
		<div class="w90p taC fs1-8" style="height:.1875in; line-height:.1875in; margin-left:5%; overflow:hidden;">
			<div id=eQty<%=expId%> class="h100p w12p fL taRP" style="<%=boxStyle%> color:#ddd;" ><font face=Consolas><%=qty%></font></div>
			<div id=eDesc<%=expId%> class="h100p w60p fL taLP" style="<%=boxStyle%>" ><%=Orig%></div>
			<div id=eCost<%=expId%> class="h100p w12p fL taRP" style="<%=boxStyle%> color:#ddd;" ><font face=Consolas><%=Cost%></font></div>
			<div id=eTotal<%=expId%> class="h100p w15p fL taRP" style="<%=boxStyle%> color:#ddd;" ><font face=Consolas><%=formatCurrency(Total)%></font></div>
		</div>
		<%
		
		rs10.MoveNext
	Loop
	
	For Lines=1 to 3
		%>
		<div class="w90p taC fs3-32" style="height:.25in; line-height:.25in; margin-left:5%; overflow:hidden;">
			<div id=eQty<%=Lines%> class="h100p w12p fL taC" style="<%=boxStyle%> color:#ddd;" >Qty</div>
			<div id=eDesc<%=Lines%> class="h100p w60p fL taC" style="<%=boxStyle%> color:#ddd;" >Description</div>
			<div id=eCost<%=Lines%> class="h100p w12p fL taC" style="<%=boxStyle%> color:#ddd;" >$/Unit</div>
			<div id=eTotal<%=Lines%> class="h100p w15p fL taC" style="<%=boxStyle%> color:#ddd;" >Total</div>
		</div>
		<%
	Next

	Set rs10=Nothing
	%>
	<div class="w90p taR" style="height:.25in; margin-left:5%; overflow:hidden;">
		Equipment Budget: &nbsp;<font face=Consolas><%=(formatCurrency(Equip))%></font>
	</div>
	<% response.Flush() %>
	
	<script type="text/javascript">Gebi('<%=SysID%>Budget').innerHTML='<%=formatCurrency(parts+labor+travel+equip)%>';</script>
	<% response.Flush() %>

	<%
	if Parts = "" or (IsNull(Parts)) then Parts = 0
	if Labor = "" or (IsNull(Labor)) then Labor = 0
	if Travel = "" or (IsNull(Travel)) then Travel = 0
	if Equipment = "" or (IsNull(Equipment)) then Equipment = 0
	Expenses=Travel+Equipment
	
	SysTaxRate = sbRS("TaxRate") : if SysTaxRate = "" or (IsNull(SysTaxRate)) then SysTaxRate = 0
	If UseNewBidder Then SysSalesTax = (SysTaxRate*Parts)/100 Else SysSalesTax = SysTaxRate*Parts/100
	FixedPrice="0"&sbRS("FixedPrice")
	Overhead="0"&sbRS("Overhead")
	Profit="0"&sbRS("MU")
	
	TotalFixed=sbRS("TotalFixed")
	
	SysBudget=Expenses+Parts+Labor

	SysTotal=(FixedPrice*1)'+(SysSalesTax*1)
	OverheadCost=(Overhead*FixedPrice)/100

	ProfitDollars=FixedPrice-OverheadCost-Expenses-Parts-Labor
	
	ProfitDollars=(ProfitDollars*100)/100
	
	'If rs("pTax")="True" Then SysTotal=SysTotal - SysSalesTax
	
	'% ><script type="text/javascript">alert('<%=SysTotal% >');< /script><%
	'MoneyFormat = SysTotal-SysSalesTax
	'MoneyFormat = FormatCurrency(MoneyFormat,2)
	
	%>
	<br/>
	<div class="taRP ul pR25">Total Budget For: <%=SysSystem%> &nbsp; &nbsp; <font face="consolas"><%=FormatCurrency(SysBudget,2)%></font></div>
	<%

	'If rs("pTax")="True" Then TotalTax = TotalTax+SysSalesTax
		
%>