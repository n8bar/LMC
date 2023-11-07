<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd"> <!-- -->
<html style=" height:100%; overflow-y:hidden;" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Part Details</title>
<!--#include file="common.asp" -->
<script type="text/javascript" src="Part.js"></script>
<script type="text/javascript" src="PartAJAX.js"></script>


<link type="text/css" rel=stylesheet href="Part.css" media="all"/>

<style>
#Top { font-size:20px; height:5%; width:100%; overflow:hidden; text-align:center; }
.button { width:80%; font-size:24px; padding:16px 0; }
.addNew { padding:0 4px 0 4px; font-family:consolas, courier; font-size:14px; height:14px; font-weight:bold; color:#040; border:1px solid rgba(224,224,224,.5); border-top-color:rgba(255,255,255,.5); border-bottom-color:rgba(96,96,96,.5); border-radius:4px; background-color:rgba(192,192,192,.75); }
.addNew:active { border-top-color:rgba(96,96,96,.5); border-bottom-color:rgba(255,255,255,.5); border-top-width:2px; border-bottom-width:0px;}

#Search { width:80%; height:5%; position:absolute; top:5%; min-height:40px; margin:0 0 2% 10%; padding:0; background:rgba(0,192,192,.5); border-radius:24px;
 background:-moz-linear-gradient(bottom, rgba(0,192,192,.75), rgba(0,144,144,.5) 50%, rgba(0,96,96,.5));
 background:-webkit-gradient(linear,0 0,0 100%, from(rgba(0,192,192,.75)) ,color-stop(.5,  rgba(0,144,144,.5)), to(rgba(0,96,96,.5)));
}
#innerSearch {position:relative; width:100%; top:15%; }
#SearchBox { width:50%; border-radius:4px; max-height:24px; line-height:24px; white-space:nowrap; }

#itemsHeadDiv { width:100%; height:5%; min-height:32px; z-index:100; position:absolute; top:15%; }

#itemsHead { width:95%; margin:2px 0 0 5%; overflow:hidden; max-height:42px; height:100%; line-height:24px;
 border:rgba(0,0,0,.333) solid 1px; border-left-width:2px; border-radius:10px; border-bottom-left-radius:4px; border-bottom-right-radius:4px;
 background:-moz-linear-gradient(bottom, rgba(0,192,192,.125), rgba(0,144,144,.25) 50%, rgba(0,96,96,.25));
 background:-webkit-gradient(linear,0 0,0 100%, from(rgba(0,192,192,.125)) ,color-stop(.5,  rgba(0,144,144,.25)), to(rgba(0,96,96,.25)));
}
#itemsHead div{ float:left; border-left:rgba(255,255,255,.75) solid 1px; border-right:rgba(0,0,0,.25) solid 1px; height:100%; }
#itemsHead:first-child{border-top-left-radius:9px; border-top-right-radius:9px;}

#itemsHeadTop { height:10px !important; width:100%; float:left; font-size:10px; line-height:10px; text-align:left; border:none !important; opacity:.5; overflow:hidden;
 background:-moz-linear-gradient(top, rgba(224,255,255,.25), /*rgba(0,192,192,.5) 50%,*/ rgba(128,144,144,.25));
 background:-webkit-gradient(linear,0 0,0 100%, from(rgba(224,255,255,.25)) /*,color-stop(.5, rgba(0,192,192,.5))*/, to(rgba(128,144,144,.25)));
}
#lItemsDiv {  width:95%; margin:0 0 0 2.5%; height:80%; /*border:1px rgba(0,0,0,.333) solid;*/ overflow:hidden; position:absolute; top:20%; z-index:0;
 border-radius:4px; border-top:none; border-bottom-left-radius:12px; border-bottom-right-radius:12px; }

#lItems { width:100%; margin:0%; height:100%; border:none; overflow:hidden;
 border-radius:4px; border-top:none; border-bottom-left-radius:12px; border-bottom-right-radius:12px;
}

.colRow label { width:50%; height:100%; float:left; min-height:21px !important; }
.colRow input { width:50%; float:right; }
.colRow div { width:50%; height:100%; min-height:100%; overflow:visible; float:right; background:rgba(224,255,255,.25); }
.colRow div select { width:100%; float:right; }

.fieldDiv select {float:left; width:98%; height:100%; margin:0; padding:0; }

.fieldDiv { white-space:nowrap; min-height:21px !important; }

.editLink { color:#088; }
.editLink:hover { text-shadow:#000 0 0 3px; }
.editField {float:left !important;}
.editButton {float:left !important; width:20% !important; min-height:16px !important;}

.colRow { width:100%; height:24px; }
</style>

<% 
upc=Request.QueryString("q")

SQL= "SELECT * FROM Parts WHERE upc="&upc
Set rs=Server.CreateObject("AdoDB.RecordSet")
rs.Open SQL, REDConnString

If rs.EOF Then
	%>
	<script>
		function Search() {
			Gebi('lItems').src='upcMatchList.asp?SearchString='+Gebi('SearchBox').value;
		}
		function matchPart(pID) {
			WSQLU('Parts','UPC','<%=upc%>','PartsID',pID) 
			//Gebi('oldPart').style.display='none';
			//window.document.body.innerHTML='<button onclick=window.location=window.location; >Go!</button>';
			//window.document.body.innerHTML='<button onclick="Gebi(\'oldPart\').style.display=\'block\';"><small><small>It didn\'t work!</small></small></button>';
		}
		function savePart() {
			var d8=new Date(); d8=(d8.getMonth()+1)+'/'+d8.getDate()+'/'+d8.getFullYear();
			var fields=' Manufacturer,Model,PartNumber,Description,Cost,Margin,LaborValue,System,Category1,Category2,Inventory,InventoryLevel,UPC,Vendor1,Cost1,Date1'
			var data=''; 
			data+=" '"+CharsEncode(SelI('Manufacturer').innerHTML)+"',  ";
			data+=" '"+CharsEncode(Gebi('Model').value)+"',  ";
			data+=" '"+CharsEncode(Gebi('PartNumber').value)+"',  ";
			data+=" '"+CharsEncode(Gebi('Description').innerHTML)+"',  ";
			data+=" 0"+Gebi('Cost').value+",  ";
			data+=" 0"+Gebi('Margin').value+",  ";
			data+=" 0"+Gebi('LaborValue').value+",  ";
			data+=" '"+CharsEncode(SelI('SystemList').innerHTML)+"',  ";
			data+=" '"+CharsEncode(SelI('Category1').innerHTML)+"',  ";
			data+=" '"+CharsEncode(SelI('Category2').innerHTML)+"',  ";
			data+=" 0"+Gebi('Inventory').value+",  ";
			data+=" 0"+Gebi('InventoryLevel').value+",  ";
			data+=" '"+<%=upc%>+"',  ";
			data+=" '"+CharsEncode(SelI('Vendor').innerHTML)+"',  ";
			data+=" 0"+Gebi('Cost').value+",  ";
			data+=" '"+d8+"' ";
			WSQL('INSERT INTO Parts ( '+fields+' ) VALUES ( '+data+' ) ')
			Gebi('newPart').style.display='none';
			window.document.body.innerHTML='<button onclick=window.location=window.location; >Go!</button>';
			//window.document.body.innerHTML='<button onclick="Gebi(\'newPart\').style.display=\'block\';"><small><small>It didn\'t work!</small></small></button>';
		}
		
		function addNew(table) {
			var what; var field;
			switch(table.toLowerCase()) {
				case 'manufacturers': what='Manufacturer', field='Name'; break;
				case 'systemlist': what='System Type'; field='SystemName'; break;
				case 'categories': what='Category'; field=what; break;
				case 'contacts': what='Vendor'; field='Name'; break;
				default: alert('I guess I can\'t handle "'+table+'"'); return false; break;
			}
			var value=prompt('Enter the name of the new '+what);
			if(!value || value.toString().replace(/ /g,'')=='') return false;
			//alert(value);
			WSQL('INSERT INTO '+table+' ('+field+') VALUES (\''+value+'\')');
			
			var opt='<option>'+value+'</option>';
			switch(table.toLowerCase()) {
				case 'manufacturers': 
					Gebi('Manufacturer').innerHTML=opt+Gebi('Manufacturer').innerHTML; 
					Gebi('Manufacturer').selectedIndex=0;
				break;
				case 'systemlist': 
					Gebi('SystemList').innerHTML=opt+Gebi('SystemList').innerHTML; 
					Gebi('SystemList').selectedIndex=0;
				break;
				case 'categories': 
					Gebi('Category1').innerHTML=opt+Gebi('Category1').innerHTML; 
					Gebi('Category2').innerHTML=Gebi('Category1').innerHTML;  
					Gebi('Category1').selectedIndex=0;
					Gebi('Category2').selectedIndex++;
				break;
				case 'contacts': 
					Gebi('Vendor').innerHTML=opt+Gebi('Vendor').innerHTML; 
					Gebi('Vendor').selectedIndex=0;
				break;
			}
		}
			
	</script> 
</head>
<body style="overflow-y:auto; height:100%;" >
	<div id=outerDiv style=" height:100%; width:100%; min-height:480px; position:relative; top:0; left:0;">
		<center>
			<!--																												'Elfring Bar Code 39 d Hb', -->
			<div id=Top>UPC <font style="font-family:Consolas, 'Courier New', monospace">*<%=upc%>*</font> not found!</div>
			<p>
			<br/>
			<button id=newPartButton class=button onclick="this.parentNode.style.display='none'; Gebi('newPart').style.display='block'; " ><b>Enter</b> a new part with this code</button>
			<br/><br/>
				<button id=oldPartButton class=button onclick="this.parentNode.style.display='none'; Gebi('oldPart').style.display='block'; " ><b>Match</b> this code to an existing part</button>
			</p>
			
			<form id=newPart action="javascript:savePart();" style="display:none;">
				
				<div id=PartInfoTitle class=PartInfoTitle style="margin-top:1%;" >Part Information</div>
				<div id=PartInfo class=PartInfo height="150px" style="height:25%; min-height:150px;" >
					<% 
				
					rowCount=6
					iRowH=((100/rowCount)*3)/3 
					iRowMH=((150/rowCount)*3)/3 
					iColH=100'iRowH*(rowCount-1)
					iColMH=150'iRowMH*(rowCount-1)
					InfoCellStyle="height:"&iRowH&"%; max-height:"&iRowH&"%; min-height:"&iRowMH&"px; -webkit-min-height:0px;"
					InfoBottomStyle="height:-moz-calc(100%-("&iRowH&"% * "&CStr(rowCount-1)&"); min-height:"&iRowMH&"px; -webkit-min-height:0px;"
					HH="<div style=""width:.01%; min-width:1px; height:"&iRowH&"%; max-height:"&iRowH&"% !important; min-height:"&iRowMH&"px; float:right; "">&nbsp;</div>"
					%>
					<div class="labelColumn w100p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
						<div class=colRow>
							<label style="<%=InfoCellStyle%>"><big>Part Name</big></label>
							<input class=fieldDiv required style="<%=InfoCellStyle%> z-index:0;" id=Model />
						</div>
						<div class=colRow>
							<label style="<%=InfoCellStyle%>">Part Number</label>
							<input class=fieldDiv required style="<%=InfoCellStyle%>" id=PartNumber />
						</div>
						<div class=colRow>
							<label style="<%=InfoCellStyle%>">Manufacturer <span class=addNew onclick="addNew('Manufacturers');" >+</span> </label>
							<div class=fieldDiv style="<%=InfoCellStyle%>" ><select required id=Manufacturer ><option></option><%MfrOptionList("mfr")%></select></div>
						</div>
						<div class=colRow>
							<label style="<%=InfoCellStyle%>">System Type <span class=addNew onclick="addNew('SystemList');" >+</span> </label>
							<div class=fieldDiv style="<%=InfoCellStyle%>" ><select required id=SystemList ><option></option><%SysTypesOptionList("sys")%></select></div>
						</div>
						<div class=colRow>
							<label style="<%=InfoCellStyle%>">In Stock</label>
							<input class=fieldDiv required style="<%=InfoCellStyle%>" id=Inventory />
						</div>
						<div class=colRow>
							<label style="<%=InfoCellStyle%>">Stock Maint. level</label>
							<input class=fieldDiv required style="<%=InfoCellStyle%>" id=InventoryLevel value="0" />
						</div>
						<div class=colRow>
							<label style="<%=InfoCellStyle%>">Cost</label>
							<input class=fieldDiv required id=Cost style="<%=InfoCellStyle%>" />
						</div>
						<div class=colRow>
							<label style="<%=InfoCellStyle%>">Margin</label>
							<input class=fieldDiv required id=Margin style="<%=InfoCellStyle%>" value="100" />
						</div>
						<div class=colRow>
							<label style="<%=InfoCellStyle%>">Primary Category <span class=addNew onclick="addNew('Categories')" >+</span></label>
							<div class=fieldDiv style="<%=InfoCellStyle%>" ><select required id=Category1 ><option></option><%CategoryOptionList("cat1-")%></select></div>
						</div>
						<div class=colRow>
							<label style="<%=InfoCellStyle%>">Secondary Category</label>
							<div class=fieldDiv style="<%=InfoCellStyle%>" ><select id=Category2 ><option></option><%CategoryOptionList("cat2-")%></select></div>
						</div>
						<div class=colRow>
							<label style="<%=InfoCellStyle%>">Installation Manhours</label>
							<input class=fieldDiv required id=LaborValue style="<%=InfoCellStyle%>" value=".25" />
						</div>
						<div class=colRow>
							<label style="<%=InfoCellStyle%>">Primary Vendor <span class=addNew onclick="addNew('Contacts')" >+</span></label>
							<div class=fieldDiv style="<%=InfoCellStyle%>" ><select id=Vendor ><option></option><%ContactsOptionList("vendors")%></select></div>
						</div>
					</div>
					<div class="labelColumn w100p" style="height:<%=iRowH%>%; min-height:<%=iRowMH%>px;">
						<label style="<%=InfoCellStyle%> text-align:center;">Part Description</label>
					</div>
					<div class="fieldColumn w100p" style="height:<%=iRowH%>%; min-height:<%=iRowMH%>px;">
						<textarea class="fieldDiv" id=Description style="height:<%=iColH-iRowH%>%; min-height:<%=iColMH-iRowMH%>px;"></textarea>
					</div>
				</div>
				<label><button type="submit" style="height:42px;" >&nbsp;Save&nbsp;</button></label>
			</form>
			
			<div id=oldPart style="display:none;">
				<div id=Search >
					<div id=innerSearch>
						<label>Search: <input id=SearchBox onkeypress="ifEnter(event,'Search();');" /></label>
						<button onclick="Search();"><b>Go</b></button>
					</div>
				</div>
				<div id=itemsHeadDiv>
					<div id=itemsHead>
						<div id=itemsHeadTop>
							<div id=ihName style="width:30%; font-weight:normal; " onclick="sortBy('Model',this);" >Name</div>
							<div id=ihMfr style="width:20%; font-weight:normal; " onclick="sortBy('Manufacturer',this);">Manufacturer</div>
							<div id=ihDesc style="width:20%; font-weight:normal; ">Description</div>
							<div id=ihSys style="width:15%; font-weight:normal; ">System Type</div>
							<div id=ihUPC style="width:15%; font-weight:normal; text-align:center; color:#000; "><b>UPC</b></div>
						</div>
						<div id=ihPN style="width:30%; font-weight:normal; " onclick="sortBy('PartNumber',this);" >Part#</div>
						<div id=ihRetail style="width:20%; font-weight:normal; " onclick="sortBy('Retail',this);">Retail</div>
						<div id=ihStock style="width:20%; font-weight:normal; " onclick="sortBy('Inventory DESC',this);">In Stock</div>
						<div id=ihCat style="width:15%; font-weight:normal; " onclick="sortBy('Category1',this);">Category</div>
						<div id=ihButtons style="width:15%; font-weight:normal; font-family:Consolas,Calibri,Tahoma,sans-serif; ">√</div>
					</div>
				</div>
				<div id=lItemsDiv><iframe id=lItems src="upcMatchList.asp?upc=<%=upc%>"></iframe></div>
			</div>
		</center>
	</div>
</body>
	<%
	response.End()
End If
%>
</head>
<body>
<%
pId=CInt("0"&Request.QueryString("pId"))
upc=Request.QueryString("q")

editLink="<a class=""editLink"" style=""z-index:10000;"" onclick=""editField(this.parentNode);"" >Edit</a>"
currencyLink="<a class=""editLink"" onclick=""editCurrency(this.parentNode);"" >Edit</a>"
dateLink="<a class=""editLink"" onclick=""dateField(this.parentNode)"" >Edit</a>"
notesLink="<a class=editLink onClick=editNotes(this.parentNode);>Edit</a>"

SQL= "SELECT * FROM Parts WHERE PartsID="&pId
Set rs=Server.CreateObject("AdoDB.RecordSet")
rs.Open SQL, REDConnString

If rs.EOF Then 
	
	SQL= "SELECT * FROM Parts WHERE upc="&upc
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.Open SQL, REDConnString

	If rs.EOF Then Response.End()
	
	pId=rs("PartsId")
End If

%>
<script type="text/javascript">var pId=<%=pId%>;</script>
<div id=hiddenDiv style="display:none;">
	<div id=oldNotes ></div>
	<div id=Manufacturers ><%MfrOptionList("mfr")%></div>
	<div id=Categories ><%CategoryOptionList("cat")%></div>
	<div id=Systems ><%SysTypesOptionList("sys")%></div>
	<div id=Vendors ><%ContactsOptionList("vendors")%></div>
</div>

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

<div id=PartInfoTitle class=PartInfoTitle style="margin-top:1%;" >
	<div style=float:left;>Part Details</div>
</div>
<div id=PartInfo class=PartInfo height="150px" style="height:50%; min-height:308px;" >
	<% 
	rowCount=14
	iColH=100
	iColMH=308
	iRowH=((iColH/rowCount))
	iRowMH=((iColMH/rowCount)) 
	InfoCellStyle="height:"&iRowH&"%; max-height:"&iRowH&"%; min-height:"&iRowMH&"px;"
	InfoBottomStyle="height:-moz-calc(100%-("&iRowH&"% * "&CStr(rowCount-1)&"); min-height:"&iRowMH&"px; "
	%>
	<div class="labelColumn w100p" style="height:<%=iColH%>%; min-height:<%=iColMH%>px;">
		<div class="colRow" style="<%=InfoCellStyle%>">
			<label class=labelColumn style=""><big>Part Name</big></label>
			<div class=fieldDiv style=" font-size:18px;" id=Model ><%=editLink%><%=DecodeChars(rs("Model"))%></div>
		</div>
		<div class="colRow" style="<%=InfoCellStyle%>">
			<label class=labelColumn style="">Part Number</label>
			<div class=fieldDiv id=PartNumber><%=editLink%><%=DecodeChars(rs("PartNumber"))%></div>
		</div>
		<div class="colRow" style="<%=InfoCellStyle%>">
			<label class=labelColumn style="">Manufacturer</label>
			<div class=fieldDiv style="" id="Manufacturer"><%=editLink&DecodeChars(rs("Manufacturer"))%></div>
		</div>
		<div class="colRow" style="<%=InfoCellStyle%>">
			<label class=labelColumn style="">System Type</label>
			<div class=fieldDiv style="" id=System><%=editLink&DecodeChars(rs("System"))%></div>
		</div>
		<div class="colRow" style="<%=InfoCellStyle%>">
			<label class=labelColumn style="">In Stock</label>
			<div class=fieldDiv style="" id=Inventory><%=editLink&rs("Inventory")%></div>
		</div>
		<div class="colRow" style="<%=InfoCellStyle%>">
			<label class=labelColumn style="">Stock Maintenance level.</label>
			<div class=fieldDiv style="" id=InventoryLevel><%=editLink&rs("InventoryLevel")%></div>
		</div>
		<div class="colRow" style="<%=InfoCellStyle%>">
			<label class=labelColumn style="">Part ID#</label>
			<div class=fieldDiv id=pId style=""><%=pId%></div>
		</div>
		<div class="colRow" style="<%=InfoCellStyle%>">
			<label class=labelColumn style="">Cost</label>
			<div class=fieldDiv id=Cost style=""><%=currencyLink&formatCurrency(rs("Cost"))%></div>
		</div>
		<div class="colRow" style="<%=InfoCellStyle%>">
			<label class=labelColumn style="">Margin</label>
			<div class=fieldDiv id=Margin style=""><%=editLink&rs("Margin")%></div>
		</div>
		<div class="colRow" style="<%=InfoCellStyle%>">
			<label class=labelColumn style="">Primary Category</label>
			<div class=fieldDiv id=Category1 style=""><%=editLink&DecodeChars(rs("Category1"))%></div>
		</div>
		<div class="colRow" style="<%=InfoCellStyle%>">
			<label class=labelColumn style="">Secondary Category</label>
			<div class=fieldDiv id=Category2 style=""><%=editLink&DecodeChars(rs("Category2"))%></div>
		</div>
		<div class="colRow" style="<%=InfoCellStyle%>">
			<label class=labelColumn style="">Installation Manhours</label>
			<div class=fieldDiv id=LaborValue style=""><%=editLink&rs("LaborValue")%></div>
		</div>
		<label class=labelColumn style=" text-align:center;">Part Description</label>
		<div class=fieldDiv id=Description style="<%=InfoCellStyle%> height:<%=iColH-iRowH%>%; max-height:100%; min-height:<%=iColMH-iRowMH%>px;"><%=notesLink&DecodeChars(rs("Description"))%></div>
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