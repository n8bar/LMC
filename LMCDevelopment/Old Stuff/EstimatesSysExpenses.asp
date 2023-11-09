<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../../LMC/RED.asp" -->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>System Expenses</title>
<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="EstimatesJS.js"></script>
<script type="text/javascript" src="EstimatesAJAX.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>

<script type="text/javascript">
	var InsideFrame=true;
	
	var SysID=<%=Request.QueryString("SysID")%>;
	SelectedSysID=SysID;
</script>


<%
	Dim SysID
	SysID=Request.QueryString("SysID")
	SQL = "SELECT * FROM Systems WHERE SystemID="&SysID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	SQL1="SELECT * FROM TravelType"
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
%>

<style>

html{width:100%; height:100%; padding:0; margin:0;}
body{width:100%; height:100%; overflow-x:hidden; overflow-y:auto;}


.w100{width:100%;}

.h100{height:100%;}
.h50{height:50%;}
.h25{height:25%;}

.m0{margin:0;}
.p0{padding:0;}

.bL{height:100%; width:1px; border-left:1px solid #000; float:left; white-space:pre;}
.bR{height:100%; width:1px; border-right:1px solid #000; float:right; white-space:pre;}

.borderBox{-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;}


#Modal{position:absolute; top:0; left:0; width:100%; height:100%; background:#B1DB87;	filter:alpha(opacity=70);	opacity:0.70; display:none; z-index:10000;}

.AddEditBox{position:absolute; top:56px; left:33%; width:33%; z-index:10010; display:none; border:#70AB34 1px solid;}

.BoxTitle{width:100%; text-align:center; font-size:20px; background:#70AB34;}
.BoxRow{width:100%;}
.BoxLabel{width:50%; float:left; text-align:right; padding:2px 0 0 0;}
.BoxInput{width:50%; background:none; float:left; -webkit-box-sizing:border-box;}
.BoxBG{background-image:-webkit-gradient(linear,0% 0%,0% 100%,color-stop(0, #DDEFCB),color-stop(.2, #F8FCF3),color-stop(1, #B1DB87)); background-color:#EBF5E0;}

.Section{
	width:100%;	height:auto; float:left; clear:both; border-top:1px solid #FFF; border-bottom:2px solid #40631D; margin-top:1%;
	background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0, #B1DB87),color-stop(.3, #DDEFCB),color-stop(1, #B1DB87));
}
.SectionName{float:left; font-size:21px; text-shadow:-1px -1px 1px #FFF,3px 2px 1px #DDEFCB;}

.btnAdd{color:Green; font-family:Arial, Helvetica; font-size:17px; font-weight:bold; padding:0; height:22px; width:22px;}

.HeadRow{width:100%; height:16px; font-family:Arial, Helvetica, sans-serif; font-size:14px;}
.tHeadItem{
	float:left; width:20%; height:100%; border-bottom:1px #000 solid; white-space:nowrap; overflow:hidden; border-top:1px #000 solid; text-align:center;
	background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0, #DDEFCB),color-stop(.2, #F8FCF3),color-stop(1, #B1DB87));
}
.HeadItem{
	float:left; width:20%; height:100%; border-bottom:1px #000 solid; white-space:nowrap; overflow:hidden; border-top:1px #000 solid; text-align:center;
	background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0, #DDEFCB),color-stop(.2, #F8FCF3),color-stop(1, #B1DB87));
}
.ItemMO:hover{
	background-color:#FF0;
	background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0, #FF0),color-stop(.2, #F8FCF3),color-stop(1, #CC0));
}


.Row{width:100%; height:18px; font-family:Arial, Helvetica, sans-serif; font-size:14px; border-right:1px #000 solid; overflow:hidden;}
.Row:hover{color:#FFF; background-color:#558327;}
.RowItem{float:left; width:20%; height:17px; border-bottom:1px #000 solid; white-space:nowrap; overflow:hidden;}
.RowBtn{float:left; width:3%; height:17px; border-bottom:1px #000 solid; white-space:nowrap; overflow:hidden; color:#900; cursor:pointer; text-align:center;}

.gRow{width:110%; height:21px; float:left; clear:left; white-space:nowrap; margin:0; padding:0;}
.SystemInfoTag{
	float:left;
	width:45.45%;
	height:18px;
	margin: 0px 0px 0px 0px;
	padding: 2px 0px 0px 0px;
	font-family: Arial,Helvetica,sans-serif;
	font-size: 12px;
	font-weight:bold;
	text-align:right;
	/*
	background:#CBE7AF;
	border-bottom:1px solid #000;
	border-left:1px solid #000;
	/**/
}
.SystemInfoDiv{
	overflow:hidden;
	white-space:nowrap;
	height:18px;
	width:45.35%;
	font-family:Consolas, "Courier New", Courier, monospace;
	margin: 0px 0px 0px 0px;
	padding: 2px 0px 0px 0px;
	border:none;
	/*
	border-left:1px solid #000;
	border-bottom:1px solid #000;
	/**/
	background:none;
	background-image:-webkit-gradient(linear,0 0,100% 0,color-stop(0, rgba(255,255,255,.2)), color-stop(.02, rgba(255,255,255,.5)), color-stop(1, rgba(255,255,255,0)));
	z-index:10000;
}



.Numbers{font-family:Consolas, "Courier New", Courier, monospace;}

.TotalLine{width:100%; text-align:right; font-size:18px;}
.SectionTotal{float:right; font-family:Consolas, "Courier New", Courier, monospace; font-size:18px; width:14%; border:1px solid #000; margin:2px; padding:0 2px 0 0;}

</style>

</head>

<body class="w100 h100 m0 p0" onLoad="parent.document.getElementById('SysInfoFrame').contentWindow.CalculateEstTotal();">

<div id="Modal"></div>

<!-- <button id="ReloadFrame" onclick="window.location=window.location;"><img src="images/reloadblue24.png" style="width:100%; height:100%;"></button> -->



<div id="General" class="Section">
	<div class="SectionName">&nbsp;System Info.</div>
	<div class="borderBox" style="width:100%; height:48px; float:left; border-top:1px #000 solid;">
	
		<div id="g1" class="borderBox" style="width:25%; height:100%; padding-top:2px; float:left; border-right:1px #000 solid; ">
			<div class="gRow" >
				<div class="SystemInfoTag" >
					<LABEL style="POSITION: relative; TOP: 2px; float:right;" for=ckFixedTotal >Fixed Price &nbsp;</LABEL>
					<% If rs("TotalFixed")="True" Then FT="checked=""true""" Else FT=""%>
					<input id="ckFixedTotal" type="checkbox" style="POSITION: relative; TOP: -1px; float:right;" onClick="ToggleFT(this.checked);" <%=FT%>>
					<div style="float:left; font-weight:normal; font-size:9px;"></div>
				</div>
				
				<input id="FixedTotal" class="SystemInfoDiv" value="$<%=Round(FixedPrice*100)/100%>" readonly
				 onKeyUp="SendSQL('Write','UPDATE Systems SET FixedPrice=\''+this.value+'\' WHERE SystemID=<%=SysID%>'); PGebi('SysInfoFrame').contentWindow.CalculateEstTotal();"
				 onFocus="this.value=this.value.replace('$','');" 
				 onBlur="this.value=this.value.replace('$',''); this.value='$'+this.value;"
				/>
			</div>
		</div>

		<div id="g2" class="borderBox" style="width:25%; height:100%; padding-top:2px; float:left; border-right:1px #000 solid; ">
			
			<div class="gRow">
				<div class="SystemInfoTag">Profit &nbsp;</div>
				<input id="MU" class="SystemInfoDiv" value="<%=rs("MU")%>%"
				 onKeyUp="SendSQL('Write','UPDATE Systems SET MU='+this.value+' WHERE SystemID=<%=SysID%>'); PGebi('SysInfoFrame').contentWindow.CalculateEstTotal();"
				 onFocus="this.value=this.value.replace('%','');" 
				 onBlur="this.value=this.value.replace('%',''); this.value+='%';"
				/>
			</div>

		</div>
		
		
		<div id="g3" class="borderBox" style="width:25%; height:100%; padding-top:2px; float:left; border-right:1px #000 solid; ">
			<div class="gRow">
				<div class="SystemInfoTag">Sales Tax &nbsp;</div>
				<input id="TaxRate" class="SystemInfoDiv" value="<%=rs("TaxRate")%>%"
				 onKeyUp="SendSQL('Write','UPDATE Systems SET TaxRate=\''+this.value+'\' WHERE SystemID=<%=SysID%>'); PGebi('SysInfoFrame').contentWindow.CalculateEstTotal();"
				 onFocus="this.value=this.value.replace('%','');" 
				 onBlur="this.value=this.value.replace('%',''); this.value+='%';"
				/>
			</div>

		</div>
		
		<div id="g4" class="borderBox" style="width:25%; height:100%; padding-top:2px; float:left;">
			
			<div class="gRow">
				<div class="SystemInfoTag">OverHead &nbsp;</div>
				<input id="OH" class="SystemInfoDiv" value="<%=rs("Overhead")%>%"
				 onKeyUp="SendSQL('Write','UPDATE Systems SET Overhead=\''+this.value+'\' WHERE SystemID=<%=SysID%>'); CalculateEstTotal();"
				 onFocus="this.value=this.value.replace('%','');" 
				 onBlur="this.value=this.value.replace('%',''); this.value+='%';"
				/>
			</div>
		</div>
	</div>
</div>
		



<div id="AddTravel" class="AddEditBox">
	<div id="TravelBoxTitle" class="BoxTitle">Add Travel</div>
	<div class="BoxBG" style="height:152px;">
	
		<div class="BoxRow">
			<div class="BoxLabel">Method:</div>
			<select id="tSelType" class="BoxInput" onChange="Gebi('addBoxUnits').innerHTML=SelI(this.id).value+'s';Gebi('addBoxCostUnit').innerHTML=SelI(this.id).value;">
			
			<%
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
			<div class="BoxLabel">Cost per&nbsp;<div id="addBoxCostUnit" style="float:right;">Ticket</div></div>
			<input id="tCost" class="BoxInput Numbers"/>
		</div>
		<div class="BoxRow">
			<button style="float:left;" onClick="Gebi('AddTravel').style.display='none'; Gebi('Modal').style.display='none';">Cancel</button>
			<button id="tAdd" style="float:right;"
			 onClick="AddExpense('Travel', SelI('tSelType').innerHTML, Gebi('tOrigin').value, Gebi('tDest').value, Gebi('tAmount').value, Gebi('tCost').value);"
			>
				Add
			</button>
			<button id="tSave" style="float:right; display:none;"
			 onClick="SaveExpense('Travel', SelI('tSelType').innerHTML, Gebi('tOrigin').value, Gebi('tDest').value, Gebi('tAmount').value, Gebi('tCost').value);"
			>
				Save
			</button>
		</div>
	</div>
</div>


<div id="Travel" class="Section">

	<div style="width:100%; height:26px; background:none;">
		<div class="SectionName">&nbsp;Travel</div>
		<button style="height:22px; margin:2px 8px 2px 0; width:auto; float:right;"
		 onClick="Gebi('AddTravel').style.display='block'; Gebi('Modal').style.display='block'; Gebi('tSave').style.display='none'; Gebi('tAdd').style.display='block'; Gebi('TravelBoxTitle').innerHTML=Gebi('TravelBoxTitle').innerHTML.replace('Edit','Add');"
		>
			<img src="../../TMCDevelopment/images/plus_16.png" style="float:left;" />
			<div style="height:100%; float:left;">Add&nbsp;</div>
		</button>
	</div>
	
	<div id="TravelHead" class="HeadRow">
		<div class="tHeadItem" style="width:3%;"><div class="bL"> </div></div>
		<div class="tHeadItem ItemMO" style="width:3%;" onClick="DeleteExpenseAll('Travel')" title="DELETE ALL"><div class="bL"> </div><img src="../../TMCDevelopment/images/delete_16.png" /></div>
		<div class="tHeadItem" style="width:11%;"><div class="bL"> </div>Travel Type</div>
		<div class="tHeadItem"><div class="bL"> </div>Origin</div>
		<div class="tHeadItem"><div class="bL"> </div>Destination</div>
		<div class="tHeadItem"><div class="bL"> </div>Amount</div>
		<div class="tHeadItem" style="width:11%;"><div class="bL"> </div>Cost ea.</div>
		<div class="tHeadItem" style="width:12%;"><div class="bL"> </div>Total<div class="bR"> </div></div>
	</div>
	
	<div id="tRows" style="padding:0; float:left; width:100%;">
	<%
		tSQL="SELECT * FROM Expenses WHERE Type='Travel' AND SysID="&SysID
		set tRS=Server.CreateObject("ADODB.Recordset")
		tRS.Open tSQL, REDconnstring
		
		tCount=0
		tTotal=0
		
		w50="rgba(255,255,255,.4)"
		AltBG=w50
		
		Do Until tRS.EOF
			tCount=tCount+1
			
			if AltBG=w50 Then AltBG="none" Else AltBG=w50
			
			For t = 1 to UBound(TravelType)
				If TravelType(t,1) = tRS("SubType") Then 
					Units = TravelType(t,2)&"s"
					Exit For
				End If
			Next
			
			Amount=tRS("Units")
			Cost=tRS("UnitCost")
			RowTotal=Amount*Cost
			tTotal=tTotal+RowTotal
			
			
	%>
			<div id="tRow<%=tCount%>" class="Row" >
				<div id="tEdit<%=tCount%>" class="RowBtn ItemMO" title="Edit" style="background:<%=AltBG%>;"
				 onClick="
				 	 Gebi('TravelBoxTitle').innerHTML=Gebi('TravelBoxTitle').innerHTML.replace('Add','Edit');
					 Gebi('AddTravel').style.display='block';
					 Gebi('Modal').style.display='block'; 
					 Gebi('tSave').style.display='block'; 
					 Gebi('tAdd').style.display='none';
					 
					 for(i=0;i<(Gebi('tSelType').length);i++)
					 {
						 //alert(Gebi('tTypeInner<%=tCount%>').innerHTML);
						 if(Gebi('tSelType')[i].innerHTML==Gebi('tTypeInner<%=tCount%>').innerHTML)
						 {
						  	Gebi('tSelType').selectedIndex=i;
						 }
					 }
					 Gebi('tSelType').onchange();
					 
					 Gebi('tOrigin').value=Gebi('tOriginInner<%=tCount%>').innerHTML;
					 Gebi('tDest').value=Gebi('tDestInner<%=tCount%>').innerHTML;
					 Gebi('tAmount').value=Gebi('tAmountInner<%=tCount%>').innerHTML;
					 Gebi('tCost').value=Gebi('tCostInner<%=tCount%>').innerHTML;

					 ExpenseID=<%=tRS("ExpenseID")%>;
				">
					<div class="bL"> </div>
					<img src="../../TMCDevelopment/images/pencil_16.png" />
				</div>
				
				<div id="tX<%=tCount%>" class="RowBtn ItemMO" title="Delete" style="background:<%=AltBG%>;" onClick="DeleteExpense(<%=tRS("ExpenseID")%>)">
					<div class="bL"> </div>
					<img src="../../TMCDevelopment/images/delete_16.png" />
				</div>

				<div id="tType<%=tCount%>" class="RowItem" style="width:11%; background:<%=AltBG%>;" title="<%=tRS("SubType")%>">
					<div class="bL"> </div>
					<div id="tTypeInner<%=tCount%>"><%=tRS("SubType")%></div>
				</div>
				<div id="tOrigin<%=tCount%>" class="RowItem" title="<%=tRS("Origin")%>" style="background:<%=AltBG%>;">
					<div class="bL"> </div>
					<div id="tOriginInner<%=tCount%>"><%=tRS("Origin")%></div>
				</div>
				<div id="tDest<%=tCount%>" class="RowItem" title="<%=tRS("Destination")%>" style="background:<%=AltBG%>;">
					<div class="bL"> </div>
					<div id="tDestInner<%=tCount%>"><%=tRS("Destination")%></div>
				</div>
				<div id="tAmount<%=tCount%>" class="RowItem Numbers" title="<%=Amount%>" style=" background:<%=AltBG%>;">
					<div class="bL"> </div>
					<div id="tAmountInner<%=tCount%>" style="float:left;"><%=Amount%></div><div style="float:left;">&nbsp;<%=Units%></div>
				</div>
				<div id="tCost<%=tCount%>" class="RowItem Numbers" style="width:11%; background:<%=AltBG%>;" title="<%=Cost%>">
					<div class="bL"> </div>$
					<div id="tCostInner<%=tCount%>" style="float:right;"><%=Cost%></div>
				</div>
				<div id="tTotal<%=tCount%>" class="RowItem Numbers" style="width:12%; background:<%=AltBG%>;" title="<%=RowTotal%>">
					<div class="bL"> </div>$
					<div class="bR"> </div>
					<div id="tTotalInner<%=tCount%>" style="float:right;"><%=RowTotal%></div>
				</div>
				
			</div>
	<%
			tRS.MoveNext
		Loop
	%>
		<div class="TotalLine">
			<div id="TravelTotal" class="SectionTotal">$<%=tTotal%></div>
			<div style="padding:4px 0 0 0; float:right;">Travel Total:</div>
		</div>
	</div>
	<%'=tSQL%>
</div>




<div id="AddEquip" class="AddEditBox">
	
	<div id="EquipBoxTitle" class="BoxTitle">Add Equipment</div>
	
	<div class="BoxBG" style="height:100px;">
		
		<div class="BoxRow">
			<div class="BoxLabel">Description:</div>
			<input id="eDesc" class="BoxInput"/>
		</div>
		
		<div class="BoxRow">
			<div class="BoxLabel">Amount:</div>
			<input id="eAmount" class="BoxInput Numbers"/>
		</div>
		
		<div class="BoxRow">
			<div class="BoxLabel">Cost ea.:</div>
			<input id="eCost" class="BoxInput Numbers"/>
		</div>
		
		<div class="BoxRow">
	
			<button style="float:left;" onClick="Gebi('AddEquip').style.display='none'; Gebi('Modal').style.display='none';">Cancel</button>
			
			<button id="eAdd" style="float:right;"
			 onClick="AddExpense('Equip', Gebi('eDesc').value, 'NONE', 'NONE', Gebi('eAmount').value, Gebi('eCost').value);"
			>
				Add
			</button>
			
			<button id="eSave" style="float:right; display:none;"
			 onClick="SaveExpense('Equip', Gebi('eDesc').value, 'NONE', 'NONE', Gebi('eAmount').value, Gebi('eCost').value);"
			>
				Save
			</button>
		
		</div>
	
	</div>
</div>



<div id="Equipment" class="Section">
	<div style="width:100%; height:26px; background:none;">
		<div class="SectionName">&nbsp;Equipment</div>
		<button style="height:22px; margin:2px 8px 2px 0; width:auto; float:right;"
		 onClick="Gebi('AddEquip').style.display='block'; Gebi('Modal').style.display='block'; Gebi('eSave').style.display='none'; Gebi('eAdd').style.display='block'; Gebi('EquipBoxTitle').innerHTML=Gebi('EquipBoxTitle').innerHTML.replace('Edit','Add');"
		>
			<img src="../../TMCDevelopment/images/plus_16.png" style="float:left;" />
			<div style="height:100%; float:left;">Add&nbsp;</div>
		</button>
	</div>
	
	<div id="EquipHead" class="HeadRow">
		<div class="HeadItem" style="width:3%;"><div class="bL"> </div></div>
		<div class="HeadItem ItemMO" style="width:3%;" onClick="DeleteExpenseAll('Equip')" title="DELETE ALL"><div class="bL"> </div><img src="../../TMCDevelopment/images/delete_16.png" /></div>
		<div class="HeadItem" style="width:56%;"><div class="bL"> </div>Description</div>
		<div class="HeadItem" style="width:12%;"><div class="bL"> </div>Amount</div>
		<div class="HeadItem" style="width:12%;"><div class="bL"> </div>Cost ea.</div>
		<div class="HeadItem" style="width:14%;"><div class="bL"> </div>Total<div class="bR"> </div></div>
	</div>
	
	<div id="eRows" style="padding:0; float:left; width:100%;">
	<%
		eSQL="SELECT * FROM Expenses WHERE Type='Equip' AND SysID="&SysID
		set eRS=Server.CreateObject("ADODB.Recordset")
		eRS.Open eSQL, REDconnstring
		
		eCount=0
		eTotal=0
		
		w50="rgba(255,255,255,.4)"
		AltBG=w50
		
		Do Until eRS.EOF
			eCount=eCount+1
			
			if AltBG=w50 Then AltBG="none" Else AltBG=w50
			
			Units=""
			if eRS("SubType")="Fly" Then Units= "Tickets"
			if eRS("SubType")="Drive" Then Units = "Miles"
			
			Amount=eRS("Units")
			Cost=eRS("UnitCost")
			RowTotal=Amount*Cost
			eTotal=eTotal+RowTotal
	%>
			<div id="eRow<%=eCount%>" class="Row" >
				<div id="eEdit<%=eCount%>" class="RowBtn ItemMO" title="Edit" style="background:<%=AltBG%>;"
				 onClick="
				 	 Gebi('EquipBoxTitle').innerHTML=Gebi('EquipBoxTitle').innerHTML.replace('Add','Edit');
					 Gebi('AddEquip').style.display='block';
					 Gebi('Modal').style.display='block'; 
					 Gebi('eSave').style.display='block'; 
					 Gebi('eAdd').style.display='none';
					 
					 Gebi('eDesc').value=Gebi('eDescInner<%=eCount%>').innerHTML;
					 Gebi('eAmount').value=Gebi('eAmountInner<%=eCount%>').innerHTML;
					 Gebi('eCost').value=Gebi('eCostInner<%=eCount%>').innerHTML;
					 
					 ExpenseID=<%=eRS("ExpenseID")%>;
				">
					<div class="bL"> </div>
					<img src="../../TMCDevelopment/images/pencil_16.png" />
				</div>

				<div id="eX<%=eCount%>" class="RowBtn ItemMO" title="Delete" style="background:<%=AltBG%>;" onClick="DeleteExpense(<%=eRS("ExpenseID")%>)">
					<div class="bL"> </div>
					<img src="../../TMCDevelopment/images/delete_16.png" />
				</div>
				
				<div id="eDesc<%=eCount%>" class="RowItem" style="width:56%; background:<%=AltBG%>;" title="<%=eRS("SubType")%>">
					<div class="bL"> </div>
					<div id="eDescInner<%=eCount%>" title="<%=eRS("SubType")%>"><%=eRS("SubType")%></div>
				</div>
				
				<div id="eAmount<%=eCount%>" class="RowItem Numbers" style="width:12%; background:<%=AltBG%>;" title="<%=Amount%>">
					<div class="bL"> </div>
					<div id="eAmountInner<%=eCount%>" style="float:left;"><%=Amount%></div>
				</div>
				
				<div id="eCost<%=eCount%>" class="RowItem Numbers" style="width:12%; background:<%=AltBG%>;" title="<%=Cost%>">
					<div class="bL"> </div>$
					<div id="eCostInner<%=eCount%>" style="float:right;"><%=Cost%></div>
				</div>
				
				<div id="eTotal<%=eCount%>" class="RowItem Numbers" style="width:14%; background:<%=AltBG%>;" title="<%=RowTotal%>">
					<div class="bL"> </div>$
					<div class="bR"> </div>
					<div id="eTotalInner<%=eCount%>" style="float:right;"><%=RowTotal%></div>
				</div>
				
			</div>
	<%
			eRS.MoveNext
		Loop
	%>
		<div class="TotalLine">
			<div id="EquipTotal" class="SectionTotal">$<%=eTotal%></div>
			<div style="padding:4px 0 0 0; float:right;">Equipment Total:</div>
		</div>
	</div>
	<%'=tSQL%>
</div>




<div style="float:left; padding:8px 0 0 0;"> 
	<button style="font-size:12px; font-family:Georgia, Times, serif; color:#400;" onClick="DeleteAllExpenses(<%=SysID%>);">
		Clear Equipment and Travel
	</button>
</div>

<div style="float:right; font-size:28px; padding:4px;"> 
	Total Expenses: $<%=tTotal+eTotal+oTotal%>
</div>

</body>
</html>