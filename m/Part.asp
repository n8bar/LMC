<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Part Details</title>
<!--#include file="common.asp" -->
<script type="text/javascript" src="Part.js"></script>
<script type="text/javascript" src="PartAJAX.js"></script>

<link type="text/css" rel=stylesheet href="Part.css" media="all"/>

</head>
<body onResize="//Resize();" onLoad="//alert(pId);//Resize();" style="background-color:rgba(255,255,255,1);" >

<% 
pId=CLng("0"&Request.QueryString("pId"))

If pId=0 Then
	PN=Request.QueryString("pn")
	SQL="SELECT * FROM Parts WHERE PartNumber='"&PN&"'"
Else
	SQL= "SELECT * FROM Parts WHERE PartsID="&pId
End If
Set rs=Server.CreateObject("AdoDB.RecordSet")
rs.Open SQL, REDConnString
If rs.EOF Then Response.End()
pId=rs("PartsID")

%><script type="text/javascript">var pId=<%=pId%>;</script><%

editLink="<a class=""editLink"" style=""z-index:10000;"" onclick=""editField(this.parentNode);"" >Edit</a>"
currencyLink="<a class=""editLink"" onclick=""editCurrency(this.parentNode);"" >Edit</a>"
dateLink="<a class=""editLink"" onclick=""dateField(this.parentNode)"" >Edit</a>"
notesLink="<a class=editLink onClick=editNotes(this.parentNode);>Edit</a>"



%>
<div id=Top></div>
<div id=mainToolbar class=Toolbar style="background:none; height:48px; text-align:center; width:98%;">
	<div id=path> Part ID# <%=pId%> </div>
	

	<div class=tSpacer5 >&nbsp;</div>
	<!-- button id=newPart class=tButton32 onClick=showNewPart(); title="New Part" /><img src="../Images/plus_16.png" /></button -->
	<div class=tSpacer1 >&nbsp;</div>
	<!-- button id=searchParts class=tButton32 onClick="toggleSearchSort();" title="Search Parts" /><img src="../Images/search.png" /></button -->
	<div class=tSpacer5 >&nbsp;</div>
	<div class=tSpacer10 >&nbsp;</div>
	<div class=tSpacer10 >&nbsp;</div>
	<div class=tSpacer10 >&nbsp;</div>
	<div class=tSpacer10 >&nbsp;</div>
	<div class=tSpacer10 >&nbsp;</div>
	<button id=ReloadFrame class=tButton32 onClick="window.location=window.location;" title="Reload Part"/><img src="../Images/reloadblue24.png" /></button>
</div>

<div id=hiddenDiv style="display:none;">
	<div id=oldNotes ></div>
	<div id=Manufacturers ><%MfrOptionList("mfr")%></div>
	<div id=Categories ><%CategoryOptionList("cat")%></div>
	<div id=Systems ><%SysTypesOptionList("sys")%></div>
	<div id=Vendors ><%ContactsOptionList("vendors")%></div>
</div>

<div id=PartInfoTitle class=PartInfoTitle style="margin-top:1%;" >
	<div style=float:left;>Part Details</div>
</div>
<div id=PartInfo class=PartInfo height="150px" style="height:25%; min-height:150px;" >
	<% 

	rowCount=6
	iRowH=((100/rowCount)*3)/3 
	iRowMH=((150/rowCount)*3)/3 
	iColH=100'iRowH*(rowCount-1)
	iColMH=150'iRowMH*(rowCount-1)
	InfoCellStyle="height:"&iRowH&"%; max-height:"&iRowH&"%; min-height:"&iRowMH&"px; -moz-min-height:0px;"
	InfoBottomStyle="height:-moz-calc(100%-("&iRowH&"% * "&CStr(rowCount-1)&"); min-height:"&iRowMH&"px; -moz-min-height:0px;"
	%>
	<div class="labelColumn w20p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
		<label style="<%=InfoCellStyle%>"><big>Part Name</big></label>
		<label style="<%=InfoCellStyle%>">Part Number</label>
		<label style="<%=InfoCellStyle%>">Manufacturer</label>
		<label style="<%=InfoCellStyle%>">System Type</label>
		<label style="<%=InfoCellStyle%>">In Stock</label>
		<label style="<%=InfoCellStyle%>">Stock Maintenance level.</label>
	</div>
	<div class="fieldColumn w20p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
		<div class=fieldDiv style="<%=InfoCellStyle%> z-index:0;" id=Model ><%=editLink%><div><%=DecodeChars(rs("Model"))%></div></div>
		<div class=fieldDiv style="<%=InfoCellStyle%>" id=PartNumber><%=editLink%><%=DecodeChars(rs("PartNumber"))%></div>
		<div class=fieldDiv style="<%=InfoCellStyle%>" id="Manufacturer"><%=editLink&DecodeChars(rs("Manufacturer"))%></div>
		<div class=fieldDiv style="<%=InfoCellStyle%>" id=System><%=editLink&DecodeChars(rs("System"))%></div>
		<div class=fieldDiv style="<%=InfoCellStyle%>" id=Inventory><%=editLink&rs("Inventory")%></div>
		<div class=fieldDiv style="<%=InfoCellStyle%>" id=InventoryLevel><%=editLink&rs("InventoryLevel")%></div>
	</div>
	<div class="labelColumn w20p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
		<label style="<%=InfoCellStyle%>">Part ID#</label>
		<label style="<%=InfoCellStyle%>">Cost</label>
		<label style="<%=InfoCellStyle%>">Margin</label>
		<label style="<%=InfoCellStyle%>">Primary Category</label>
		<label style="<%=InfoCellStyle%>">Secondary Category</label>
		<label style="<%=InfoCellStyle%>">Installation Manhours</label>
	</div>
	<div class="fieldColumn w20p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
		<div class=fieldDiv id=pId style="<%=InfoCellStyle%>"><%=pId%></div>
		<div class=fieldDiv id=Cost style="<%=InfoCellStyle%>"><%=currencyLink&formatCurrency(rs("Cost"))%></div>
		<div class=fieldDiv id=Margin style="<%=InfoCellStyle%>"><%=editLink&rs("Margin")%></div>
		<div class=fieldDiv id=Category1 style="<%=InfoCellStyle%>"><%=editLink&DecodeChars(rs("Category1"))%></div>
		<div class=fieldDiv id=Category2 style="<%=InfoCellStyle%>"><%=editLink&DecodeChars(rs("Category2"))%></div>
		<div class=fieldDiv id=LaborValue style="<%=InfoCellStyle%>"><%=editLink&rs("LaborValue")%></div>
	</div>
	<div class="labelColumn w20p" style="height:<%=iRowH%>%; min-height:<%=iRowMH%>px;">
		<label style="<%=InfoCellStyle%> text-align:center;">Part Description</label>
	</div>
	<div class="fieldColumn w20p" style="height:<%=iColH-iRowH%>%; min-height:<%=iColMH-iRowMH%>px;">
		<div class=fieldDiv id=Description style="<%=InfoCellStyle%> height:100%; max-height:100%;"><%=notesLink&DecodeChars(rs("Description"))%></div>
	</div>
	<div class="labelColumn w50p" style="height:<%=iRowMH%>px; min-height:<%=iRowMH%>px;">
	</div>
</div>

<%
	inStock=CSng("0"&rs("Inventory"))
	stockUp=CSng("0"&rs("InventoryLevel"))
	stockLevel=0
	If stockUp<>0 Then stockLevel=(inStock/stockUp)*100
%>
<div id=NoticesTitle class=PartInfoTitle>Part Statistics</div>
<div id=Notices class=PartInfo height=90px style="height:15%; min-height:90px;">
	<div class="fieldColumn w10p h100p">
		<div class="graphBar">
			<div class="graphFill" style="height:<%=stockLevel%>%; top:<%=100-stockLevel%>%;">Stock Level</div>
		</div>
	</div>
	<div class="fieldColumn w90p h100p" style=" font-family:Consolas, 'Courier New';">
		<p>There are 0 of these coming unreceived purchase orders</p><br/>
		<p>We need <%=stockUp-InStock%> more of these to maintain stock level</p><br/>
		<p>There are 0 of these in Job Packs</p><br/>
	</div>
</div>

<div id=PricingTitle class=PartInfoTitle>Part Pricing</div>
<div id=Pricing class=PartInfo height=120px style="height:20%; min-height:120px; margin-bottom:1%;">
</div>

</body>
</html>