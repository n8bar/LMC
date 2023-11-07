<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>P.O.</title>

<!--#include file="../../TMC/RED.asp" -->

<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>
<script type="text/javascript" src="../Library/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="PO.js"></script>
<!--	<script type="text/javascript" src="PurchaseOrdersAJAX.js"></script>	-->
<%
	POID=int(Request.QueryString("POID"))
	SQL="SELECT * FROM PurchaseOrders WHERE POID="&POID
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.Open SQL, REDConnString
	
	if rs.EOF Then 
		Response.End()
	End If
	
	ProjID=Int(rs("ProjID"))
	VendorID=Int(rs("VendorID"))
	If IsNull(VendorID) Or VendorID="" Then VendorID=801
	
	SQL1="SELECT * FROM Customers WHERE CustID="&VendorID
	Set rs1=Server.CreateObject("AdoDB.RecordSet")
	rs1.Open SQL1, REDConnString

Page=1
%>
<script type="text/javascript">
	var Page=1;
	var PartsI=0;
	var POID=<%=POID%>;
	var ProjID=<%=ProjID%>;
</script>

<link type="text/css" rel="stylesheet" href="../Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">
<link type="text/css" rel="stylesheet" href="../Library/CSS_DEFAULTS.css">

<link type="text/css" rel="stylesheet" href="PO.css" media="print" >
<link type="text/css" rel="stylesheet" href="PO.css" media="screen" >
</head>

<body onResize="Resize();" onLoad="Resize();" onMouseMove="PartsMouseMove(event,'PartsBox');" onclick="Gebi('ChangePOMenu').style.diplay='block';">

<div id="Toolbar" class="Toolbar">
	<button id=Back2 onClick="PGebi('PurchasingIframe').src='Purchase.html';"><img style="width:16px; height:16px;" src="../images/GreenDblLeftTriangle.png"/>Back 2 Purchasing Jobs</button>
	<button id=Back onClick="PGebi('PurchasingIframe').src='PurchaseOrders.asp?ProjID=<%=ProjID%>';"><img style="width:16px; height:16px;" src="../images/GreenLeftTriangle.png"/>Back 2 P.O. List</button>
	<span class="tSpacerLine"></span>
	<button onClick="Gebi('PartsBox').style.display='block';" ><img style="width:16px; height:16px;" src="../images/plus_16.png"/>&nbsp;Add</button>
	<button onClick="DeletePOItem();" ><img style="width:16px; height:16px;" src="../images/delete_16.png"/>&nbsp;Delete</button>
	<button id=ChangePO onClick="Gebi('ChangePOMenu').style.display='block'; Gebi('MenuFocus').focus();"	><img style="width:16px; height:16px;" src="../images/SendLeft.png" />&nbsp;Move to P.O.</button>
	<button	onClick="PlusPOItem(1);" ><img style="width:16px; height:16px;" src="../images/plus_16.png"/>&nbsp;Qty's+1</button>
	<button	onClick="PlusPOItem(-1);" ><img style="width:16px; height:16px;" src="../images/minus_16.png"/>&nbsp;Qty's-1</button>
	<button	id="ReloadFrame" style="float:right;" onClick="window.location.reload();"><img src="../images/reloadblue24.png" style="width:100%; height:100%;"/></button>
</div>

<div id=ChangePOMenu class="MenuBox" onblur="this.display='none';">
	<input id=MenuFocus style=" background:none; border:none; height:1px; margin:0; outline:none; overflow:hidden; padding:0; position:absolute; top:-20px; width:1px;" onBlur="setTimeout('Gebi(\''+this.parentNode.id+'\').style.display=\'none\';',150);"/>
	<span align="left" style="float:left;" onClick="parentNode.style.display=block;">PO's for this project:</span><br/>
	<%
	SQL3="SELECT POID,PONum FROM PurchaseOrders WHERE ProjID="&ProjID
	Set rs3=Server.CreateObject("AdoDB.RecordSet")
	rs3.Open SQL3, REDConnString
	
	Do Until rs3.EOF
		If Int(rs3("POID"))<>POID Then
			%>
			<div class="MenuBoxItem" onClick="ChangePO(<%=rs3("POID")%>); this.parentNode.style.display='none';" ><%=rs3("PONum")%></div>
			<%
		End If
		rs3.MoveNext
	Loop
	%>
	<!-- <span style="width:100%; height:24px;" align="center"><button style="width:80%;" onClick="NewPO('',ProjID);">New P.O.</button></span>	-->
	<hr/>
	<span align="left" style="float:left;" onClick="parentNode.style.display=block;">All Other PO's:</span><br/>
	<%
	SQL4="SELECT POID,PONum,ProjID FROM PurchaseOrders ORDER BY ProjID"
	Set rs4=Server.CreateObject("AdoDB.RecordSet")
	rs4.Open SQL4, REDConnString
	
	Do Until rs4.EOF
		If rs4("ProjID")<>ProjID Then
			%>
			<div class="MenuBoxItem" onClick="ChangePO(<%=rs4("POID")%>); this.parentNode.style.display='none';" ><%=rs4("PONum")%></div>
			<%
		End If
		rs4.MoveNext	
	Loop
	%>
	<span style="width:100%;" align="center"><button style="margin:0; padding:0; width:80%;" onClick="this.parentNode.parentNode.style.display='none';">Close</button></span>
</div>


<div id=PartsBox class="AddPartsBox WindowBox">
	<div id=PartsTitle align=center onmousedown="PartsMouseDown(event)" onmouseup="PartsMouseUp(event)" onMouseMove="PartsMouseMove(event,'PartsBox')" onselectstart="return false;" >Parts Database</div>
	<iframe id="PartsInterface" src="../PartsInterface.asp?BoxID=PartsInterface&ModalID=PartsBox&MM=parent.pMouseMove(event,'PartsBox')&MD=parent.PartsMouseDown(event)&MU=parent.PartsMouseUp(event)"></iframe>
</div>

<div id=Document>
<div id="Body">
	<div id=HeadingTop>
		<!--
		<div class=HeadSection>
			
		</div>
		-->
		<div class=HeadSection><img id=Logo src="../images/TricomLogo2.jpg"/></div>
		<div class=HeadSection style="width:50%; float:right;">
			<span id=PONumTitle>Purchase Order Number:</span>
			<input id=PONumber onChange="WSQLU('PurchaseOrders','PONum',this.value,'POID',POID);" value="<%=rs("PONum")%>" />
		</div>
	</div>
	<hr/>
	<div id=AddressLine>3540 W Sahara #431 Las Vegas, NV 89102 &nbsp; Phone: (702) 383-2800 &nbsp; Fax: (702) 537-6709</div>
	<hr/>
	<div id=docTitle>PURCHASE ORDER</div>
	<div id=HeadingBottom>
		<div class=HBBoxTitles>Vendor:</div>
		<div class=HBBoxTitles>Ship To:</div>
		<div class=HBBox>
			<label class="HBBLabelFull">Name:</label>
			<Select id=VendorName class=HBBInputFull value="<%=rs1("Name")%>" onChange="SelectVendor(SelI(this.id));" >
				<option id="Vendor0%>" value="0" >Select Vendor</option>
				<%
				SQL5="SELECT CustID, Name FROM Customers WHERE Vendor=1 ORDER BY Name"
				Set rs5=Server.CreateObject("AdoDB.RecordSet")
				rs5.Open SQL5, REDConnString
				
				
				Do Until rs5.EOF
					If Int(rs5("CustID"))=VendorID Then	Selected="selected"	Else	Selected=""	End If
					%>
					<option id="Vendor<%=rs5("CustID")%>" value="<%=rs5("CustID")%>" <%=Selected%>><%=rs5("Name")%></option>
					<%
					rs5.MoveNext
				Loop
				%>
			</Select>
			<label class="HBBLabelFull">Address:</label> <div id=VendorAddress class=HBBInputFull > &nbsp;<%=rs1("Address")%></div>
			<label class="HBBLabelFull"></label><div style="float:right;" id=VendorAddress2 class=HBBInputFull > &nbsp;<%=rs1("Address2")%></div><br/><br/>
			<label class="HBBLabelHalf">City:</label><span id=VendorCity class=HBBInputHalf > &nbsp;<%=rs1("City")%></span>
			<label class="HBBLabelQtr"><small>State:</small></label><span id=VendorState class=HBBInputQtr > &nbsp;<%=rs1("State")%></span>
			<label class="HBBLabelQtr">Zip:</label><span id=VendorZip class=HBBInputQtr > &nbsp;<%=rs1("Zip")%></span><br/>
			<label class="HBBLabelHalf">Phone:</label><span id=VendorPhone class=HBBInputHalf > &nbsp;<%=Replace(Replace(rs1("Phone1"),"(",""),")","")%></span>
			<label class="HBBLabelHalf">Fax:</label><span id=VendorFax class=HBBInputHalf > &nbsp;<%=rs1("Fax")%></span>
		</div>
		<div class=HBBox>
			<label class="HBBLabelFull">Name:</label><input id=OurName class=HBBInputFull value="<%=rs("ShipToName")%>" onChange="WSQLU('PurchaseOrders','ShipToName',this.value,'POID',POID);" />
			<label class="HBBLabelFull">Address:</label><input id=OurAddress class=HBBInputFull value="<%=rs("ShipToAddress")%>" onChange="WSQLU('PurchaseOrders','ShipToAddress',this.value,'POID',POID);" />
			<label class="HBBLabelFull"></label><input id=OurAddress2 class=HBBInputFull value="<%=rs("ShipToAddress2")%>" onChange="WSQLU('PurchaseOrders','ShipToAddress2',this.value,'POID',POID);" />
			<label class="HBBLabelHalf">City:</label><input id=OurCity class=HBBInputHalf value="<%=rs("ShipToCity")%>" onChange="WSQLU('PurchaseOrders','ShipToCity',this.value,'POID',POID);" />
			<label class="HBBLabelQtr"><small>State:</small></label><input id=OurState class=HBBInputQtr value="<%=rs("ShipToState")%>" onChange="WSQLU('PurchaseOrders','ShipToState',this.value,'POID',POID);" />
			<label class="HBBLabelQtr">Zip:</label><input id=OurZip class=HBBInputQtr value="<%=rs("ShipToZip")%>" onChange="WSQLU('PurchaseOrders','ShipToZip',this.value,'POID',POID);" />
			<label class="HBBLabelHalf">Phone:</label><input id=OurPhone class=HBBInputHalf value="<%=rs("ShipToPhone")%>" onChange="WSQLU('PurchaseOrders','ShipToPhone',this.value,'POID',POID);" />
			<label class="HBBLabelHalf">Fax:</label><input id=OurFax class=HBBInputHalf value="<%=rs("ShipToFax")%>" onChange="WSQLU('PurchaseOrders','ShipToFax',this.value,'POID',POID);" />
		</div>
	</div>
	
	
  	<!-- <iframe id=itemsFrame src="POItems.asp?POID=< %=POID%>"></iframe> -->
	
		<div id=HeadItems class=HeadItems onMouseMove="MouseMove(event);">
			<div class="HeadItem" style="-webkit-box-sizing:content-box; width:5%; white-space:nowrap;">
				<input id=CheckAll type="checkbox" onClick="CheckAllPOItems(this.checked); "/>
			</div>
			<div class=HeadItem style="width:5%;">QTY</div>
			<div class=HeadItem style="width:18%;">PART #</div>
			<div class=HeadItem style="width:48%;">DESCRIPTION</div>
			<div class=HeadItem style="width:12%;">UNIT PRICE</div>
			<div class=HeadItem style="width:12%;">TOTAL</div>
		</div>
    <div id=POItemsList1 class=POItemsList style="margin:0; padding:0;">
		<%
        SQL2="SELECT * FROM POItems WHERE POID="&POID
        Set rs2=Server.CreateObject("AdoDB.RecordSet")
        rs2.Open SQL2, REDConnString
        
        Dim Parts(320,5)
        PartsI=0
        Do Until rs2.EOF
            PartsI=PartsI+1
            Parts(PartsI,0)=rs2("POItemsID")
            Parts(PartsI,1)=rs2("Qty")
            Parts(PartsI,2)=rs2("PartNumber")
            Parts(PartsI,3)=rs2("Description")
            Parts(PartsI,4)=rs2("Cost")
            Parts(PartsI,5)=rs2("Cost")*rs2("Qty")
            rs2.MoveNext
        Loop
        
        SubTotal=0
        partMax=15
        BColor="EFF"
        For P=1 To PartsI
            SubTotal=SubTotal+Parts(P,5)
            
            'alternating colors:
            If BColor="EFF" Then BColor="FFF" Else BColor="EFF"
            
						Page=1
            AnotherPage=False
            If P>partMax Then
							nextPageStart=P'+1
                %>
								<div id="partRow<%=P%>" class="Row" style="font-size:100%; <%=BColor%>" >
									Continued on page <%=Page+1%>.
									<!--
									<span class=RowItemD style="width:12.5%; float:right; border-right:none;">$< %=Parts(P,5)%>&nbsp;</span>
									<span class=RowItem style="width:12%; float:right; text-algin:right;">Page Total:</span>
									-->
									<span class=RowItem style="width:12%; float:right; text-algin:right;">Page <%=Page%></span>
								</div>
								<%
                AnotherPage=True
                'We've hit the max for this page so were done with the For loop now.
                'Except we still want the total cost so:
                For theRest= P to PartsI
                    SubTotal=SubTotal+Parts(theRest,5)
                Next
                
                Exit For
            End If
        
				Color="black"
				If Parts(P,4)=0 Then Color="red"
        %>
        <div id=partRow<%=P%> class=Row style="background-color:#<%=BColor%>; color:<%=Color%>;" >
            <label class="RowItem" style="width:5%; padding-top:2px;" align=center>
                <input id="Sel<%=Parts(P,0)%>" type="checkbox"/>
            </label>
            <input id="Qty<%=Parts(P,0)%>" class="ItemQty RowItem" style="width:5%; color:inherit;" value="<%=Parts(P,1)%>"
						 onKeyUp="
								var Q= this.value;
								if(Q==''){Q=0;}
								this.style.backgroundColor='rgba(255,0,0,.25)';
								SendSQL('Write','UPDATE POItems SET Qty='+Q+' WHERE POITemsID=<%=Parts(P,0)%>');
								Gebi('RowTotal<%=Parts(P,0)%>').innerHTML=(Q*<%=Parts(P,4)%>);
								Total();
								this.style.backgroundColor='rgba(128,128,128,.25)';
						 "
						/>
            <span class="RowItem" style="width:18%;" ><%=Parts(P,2)%>&nbsp;</span>
            <span class="RowItem" style="width:48%;" ><%=Parts(P,3)%>&nbsp;</span>
            <span class="RowItemD" style="width:12%;" ><%=FormatCurrency(Parts(P,4))%>&nbsp;</span>
            <span class="RowItemD RowTotal" id="RowTotal<%=Parts(P,0)%>" style="width:12%; border-right:none;" ><%=FormatCurrency(Parts(P,5))%></span>
        </div>
		<%
        Next
        %>
    </div>
    
	<div id=underFrame>
		<!--
        <button id=Print onClick="printPO();">Print</button>
        -->
		<div id=notesContainer>
            <div id="notesLabel"><em>NOTES</em></div><br/>
            <div id="notesBox" contentEditable="True"></div>
		</div>
		<div id="Totals">
			<label class=totalsLabel style="top:7px;"><div id=subTotal class=totalsBox></div>SUBTOTAL:</label>
			<label class=totalsLabel style="top:4px;"><input id="SH" class="totalsBox" />SHIPPING &amp; HANDLING:</label>
			<label class=totalsLabel style="top:0px;"><input id=taxRate class=totalsBox />TAX Rate:</label>
			<label class=totalsLabel style="top:-4px;"><div id=taxesBox class=totalsBox></div>TAXES:</label>
			<label id=totalLabel style="top:-4px;"><div id=totalBox style="position:relative; top:-4px;"></div><i><b>TOTAL:</b></i></label>
		</div>
	</div>
		
	<div id="payLabel"><i>TYPE OF PAYMENT</i></div>
	<div id="payBox">
		<div id="payTypes">
			<label class="payTypeLabel"><input type=radio name=payTypes />CREDIT CARD</label>
			<label class="payTypeLabel"><input type=radio name=payTypes checked />ACCOUNT</label>
			<label class="payTypeLabel"><input type=radio name=payTypes />CASH</label>
			<label class="payTypeLabel"><input type=radio name=payTypes />CHECK</label>
		</div>
		<div class=payTypeRow>
			<label class="payInfoLabel">Name:<input id=payInfoName class="payInput" value="<%=rs("CCName")%>"/></label>
			<label class="payInfoLabel">CC#:<input id=payInfoCC class="payInput" value="<%=rs("CCNum")%>"/></label>
			<label class="payInfoLabel">Exp. Date:<input id=payInfoExp class="payInput" style="width:96px;" value="<%=rs("CCExp")%>"/></label>
		</div>
		<div class="payTypeRow">
			<label class="payInfoLabel">Status:<input id=payInfoAcct class="payInput" value="<%=rs("Status")%>"/></label>
		</div>
		<div class="payTypeRow"></div>
		<div class="payTypeRow">
			<label class="payInfoLabel">Check #:<input id=payInfoCheck class="payInput" value="<%=rs("CheckNum")%>"/></label>
		</div>
	</div>
	<hr/>
	<div id="bottom">
		<div id="bottomInfo" align="right">
			<label class="bottomLabel">Ordered By:<input class="bottomInput" style="border-top-right-radius:16px;" value="<%=rs("Notes")%>"/></label>
			<label class="bottomLabel">Date:<input class="bottomInput" value="<%=rs("Date")%>"/></label>
			<label class="bottomLabel">Vendor&nbsp;Rep:<input class="bottomInput" value="<%=rs("VendorRep")%>"/></label>
			<label class="bottomLabel">Ship&nbsp;Via:<input class="bottomInput" value="<%=rs("ShipVia")%>"/></label>
		</div>
		<label id="ApprovalLabel">APPROVAL</label>
		<div id="ApprovalLine">&nbsp;</div>
	</div>
</div>

<%
Do While AnotherPage
	Page=Page+1
	AnotherPage=False
	%>
	<div id="Page<%=Page%>" class="Page">
		<div id=HeadItems<%=Page%> class="HeadItems" onMouseMove="MouseMove(event);">
			<div class="HeadItem" style="-webkit-box-sizing:content-box; width:5%; white-space:nowrap;">
				<span style="width:50%; height:100%; float:left; padding:0 0 0 5%; "><input id=CheckAll<%=Page%> type="checkbox" onClick="CheckAllPOItems(this.checked); "/></span><span class="HeadMenuButton" style="width:50%; height:100%; float:right; margin:0; position:relative; border:none; top:-1px;" onClick="PartMenu(this);">▼</span>
			</div>
			<div class=HeadItem style="width:5%;">QTY</div>
			<div class=HeadItem style="width:18%;">PART #</div>
			<div class=HeadItem style="width:48%;">DESCRIPTION</div>
			<div class=HeadItem style="width:12%;">UNIT PRICE</div>
			<div class=HeadItem style="width:12%;">TOTAL</div>
		</div>
    <div id=POItemsList<%=Page%> class=POItemsList style="margin:0; padding:0;">
			<%
			partMax=42+nextPageStart
			BColor="EFF"
			For P=nextPageStart To PartsI
				If BColor="EFF" Then BColor="FFF" Else BColor="EFF"'alternating colors:
				If P>partMax Then
					nextPageStart=P'+1
					%>
					<div id="partRow<%=P%>" class="Row" style="font-size:100%; <%=BColor%>" >
						Continued on Page <%=Page+1%>.
						<!--
						<span class=RowItemD style="width:12.5%; float:right; border-right:none;">$<%=Parts(P,5)%></span>
						<span class=RowItem style="width:12%; float:right; text-algin:right;">Page Total:</span>
						-->
						<span class=RowItem style="width:12%; float:right; text-algin:right;">Page <%=Page%></span>
					</div>
					<%
					AnotherPage=True
					'We've hit the max for this page so were done with the For loop now.
					Exit For
				End If
				
				Color="black"
				If Parts(P,4)=0 Then Color="red"
				%>
				<div id=partRow<%=P%> class=Row style="background-color:#<%=BColor%>; color:<%=Color%>;" >
					<label class="RowItem" style="width:5%; padding-top:2px;" align=center>
					<input id="Sel<%=Parts(P,0)%>" type="checkbox"/>
					</label>
					<input id="Qty<%=Parts(P,0)%>" class="ItemQty RowItem" style="width:5%; color:inherit;" value="<%=Parts(P,1)%>"
					 onKeyUp="
					 		var Q= this.value;
					 		if(Q==''){Q=0;}
							this.style.backgroundColor='rgba(255,0,0,.25)';
							SendSQL('Write','UPDATE POItems SET Qty='+Q+' WHERE POITemsID=<%=Parts(P,0)%>');
							Gebi('RowTotal<%=Parts(P,0)%>').innerHTML=(Q*<%=Parts(P,4)%>);
							Total();
							this.style.backgroundColor='rgba(128,128,128,.25)';
					 "
					/>
					<span class="RowItem" style="width:18%;" ><%=Parts(P,2)%>&nbsp;</span>
					<span class="RowItem" style="width:48%;" ><%=Parts(P,3)%>&nbsp;</span>
					<span class="RowItemD" style="width:12%;" ><%=FormatCurrency(Parts(P,4))%>&nbsp;</span>
					<span id="RowTotal<%=Parts(P,0)%>" class="RowItemD RowTotal" style="width:12%; border-right:none;" ><%=FormatCurrency(Parts(P,5))%></span>
				</div>
				<%
			Next
			If Not AnotherPage Then
				%>
				<div id="partRow<%=P%>" class="Row" style="font-size:100%; <%=BColor%>" >
					Last Page.
					<!-- 
					<span class=RowItemD style="width:12.5%; float:right; border-right:none;">$< %=Parts(P,5)%></span>
					<span class=RowItem style="width:12%; float:right; text-algin:right;">Page Total:</span>
					-->
					<span class=RowItem style="width:12%; float:right; text-algin:right;">Page <%=Page%></span>
				</div>
				<%
			End If
			%>
		</div>
	</div>
	<div style="width:100%; position:relative; top:-24px; height:1px; overflow:visible;">Page <%=Page%></div>
	<%
Loop
%>
</div>
<script type="text/javascript">
	Page=<%=Page%>;
	PartsI=<%=PartsI%>;
	Total();
</script>
</body>
</html>
