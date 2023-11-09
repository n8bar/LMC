<!--#include file="../../LMC/RED.asp" -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>System Information</title>

<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="OldEstimatesJS.js"></script>
<script type="text/javascript" src="OldEstimatesAJAX.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>
<script type="text/javascript" src="../Library/dhtmlgoodies_calendar.js?random=20060118"></script>

<script type="text/javascript">
	
	var InsideFrame=true;
	
	var SysID=<%=Request.QueryString("SysID")%>;
	SelectedSysID=SysID;
</script>

<link rel="stylesheet" href="../Library/CSS_DEFAULTS.css" media="screen">
<link type="text/css" rel="stylesheet" href="../Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">
<link rel="stylesheet" href="OldEstimatesCSS.css" media="screen">

<style>
body{
	overflow-x:hidden;
	overflow-y:scroll;
}

#LeftBox{
	float:left;
	width:49%;
	height:620px;
	border-right:1px #000 solid;
	border-bottom:1px #000 solid;
	white-space:nowrap;
	overflow:hidden;
}
#RightBox{
	float:right;
	width:49%;
	height:620px;
	border-right:1px #000 solid;
	border-bottom:1px #000 solid;
	white-space:nowrap;
	overflow:hidden;
}


.Title{width:100%;}

.Row{width:110%; height:21px; float:left; clear:both; white-space:nowrap; margin:0; padding:0;}

.Stats{ font-family: Arial, Helvetica, sans-serif; font-weight:bold; font-size:12px; color:#1F300E;}

img.Cal{cursor:pointer;}

</style>

<%
	Dim SysID
	SysID=Request.QueryString("SysID")
	SQL = "SELECT * FROM Systems WHERE SystemID="&SysID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	FixedPrice=rs("FixedPrice")
	If FixedPrice="" Or IsNull(FixedPrice) Then FixedPrice=0
	
	Dim Employee(9999)
	
	SQL1 = "SELECT * FROM Employees WHERE Active='True'"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	
	Do Until rs1.EOF
		Employee(rs1("EmpID"))=rs1("FName")&" "&rs1("LName")
		rs1.MoveNext
	Loop
	
	Set rs1=Nothing
%>

</head>

<body onLoad="CalculateEstTotal();">

<div id="LeftBox">
	
	<div id="Title" class="Title">
		<div class="SystemInfoLTName" align="center">System Name</div>
		<input type="text" id="SystemTxt" class="SystemInfoLTTxt" value="<%=rs("System")%>"
		 onKeyUp="SendSQL('Write','UPDATE Systems SET System=\''+CharsEncode(this.value)+'\' WHERE SystemID=<%=SysID%>'); PGebi('Tab<%=SysID%>').innerHTML=this.value;"
		/>
	</div>
		
	<div id="LT" style="height:147px;">
		<div class="Row">
			<div class="SystemInfoTag">Entered By &nbsp;</div>
			<div class="SystemInfoDiv" style="padding-top:0px; height:20px;">
				<select class="SystemSelectBox" id="EnteredBy" onChange="UpdateText('EnteredBy','List','Systems','SystemID','EnteredByID');">
					<option value="<%=rs("EnteredByID")%>"><%=Employee(rs("EnteredByID"))%></option>
				<%
					For E = 1 to UBound(Employee)
						If Employee(E)<>"" Then
						%><option value="<%=E%>"><%=Employee(E)%></option><%
						End If
					Next
				%>
				</select>
			</div>
		</div>
		
		<div class="Row">
			<div class="SystemInfoTag">Date &nbsp;</div>
			<div id="DateEntered" class="SystemInfoDiv Stats" style="padding-left:2px;"><%=rs("DateEntered")%></div>
		</div>
		
		<div class="Row">
			<div class="SystemInfoTag">Date Bid &nbsp;</div>
			<div class="SystemInfoDiv" style="padding:0; height:20px;">
				<input id="DateBid" style="border:none; margin:0; padding:0; width:85%; background:none; top:0; float:left;" value="<%=rs("DateBid")%>"
				 onchange="SendSQL('Write','UPDATE Systems SET DateBid=\''+this.value+'\' WHERE SystemID=<%=SysID%>');" 
				 onKeyUp="SendSQL('Write','UPDATE Systems SET DateBid=\''+this.value+'\' WHERE SystemID=<%=SysID%>');"
				/>
				<div align="center" style=" float:left; clear:right;"><img class="Cal" onClick="displayCalendar('DateBid','mm/dd/yyyy',this)" src="../Images/cal.gif"/></div>
			</div>
		</div>
		
		<div class="Row">
			<div class="SystemInfoTag">Date Won &nbsp;</div>
			<div class="SystemInfoDiv" style="padding:0; height:20px;">
				<input id=DateWon style="border:none; margin:0; padding:0; width:85%; background:none; top:0; float:left;" value="<%=rs("DateWon")%>"
				 onchange="SendSQL('Write','UPDATE Systems SET DateWon=\''+this.value+'\' WHERE SystemID=<%=SysID%>');" 
				 onKeyUp="SendSQL('Write','UPDATE Systems SET DateWon=\''+this.value+'\' WHERE SystemID=<%=SysID%>');"
				/>
				<div align="center" style=" float:left; clear:right;"><img class="Cal" onClick="displayCalendar('DateWon','mm/dd/yyyy',this)" src="../Images/cal.gif"/></div>
			</div>
		</div>
		
		<div class="Row">
			<div class="SystemInfoTag">Margin &nbsp;</div>
			<input id="MU" class="SystemInfoDiv" value="<%=rs("MU")%>"
			 onKeyUp="SendSQL('Write','UPDATE Systems SET MU='+this.value+' WHERE SystemID=<%=SysID%>'); CalculateEstTotal();"
			/>
		</div>
		
		<div class="Row" >
			<div class="SystemInfoTag" >
				<LABEL style="POSITION: relative; TOP: 2px; float:right;" for=ckFixedTotal >Fixed Price &nbsp;</LABEL>
				<% If rs("TotalFixed")="True" Then FT="checked=""true""" Else FT=""%>
				<input id="ckFixedTotal" type="checkbox" style="POSITION: relative; TOP: -1px; float:right;" onClick="ToggleFT(this.checked);" <%=FT%>>
				<div style="float:left; font-weight:normal; font-size:9px;"></div>
			</div>
			
			<input id="SystemTotal" class="SystemInfoDiv" value="$<%=Round(FixedPrice*100)/100%>" readonly
			 onKeyUp="SendSQL('Write','UPDATE Systems SET FixedPrice=\''+this.value+'\' WHERE SystemID=<%=SysID%>'); CalculateEstTotal();"
			 onFocus="this.value=this.value.replace('$','');" 
			 onBlur="this.value=this.value.replace('$',''); this.value='$'+this.value;"
			/>
		</div>
		
		<div class="Row">
			<div class="SystemInfoTag">Tax &nbsp;</div>
			<input id="TaxRate" class="SystemInfoDiv" value="<%=rs("TaxRate")%>%"
			 onKeyUp="SendSQL('Write','UPDATE Systems SET TaxRate=\''+this.value+'\' WHERE SystemID=<%=SysID%>'); CalculateEstTotal();"
			 onFocus="this.value=this.value.replace('%','');" 
			 onBlur="this.value=this.value.replace('%',''); this.value+='%';"
			/>
		</div>
		
		<!--
		<div class="Row">
			<div class="SystemInfoTag">Travel &nbsp;</div>
			<input class="SystemInfoDiv" value="<%'=rs("Travel")%>"
			 onKeyUp="SendSQL('Write','UPDATE Systems SET Travel=\''+this.value+'\' WHERE SystemID=<%'=SysID%>'); CalculateEstTotal();"
			/>
		</div>
		
		<div class="Row">
			<div class="SystemInfoTag">Equipment &nbsp;</div>
			<input class="SystemInfoDiv" value="<%'=rs("Equipment")%>"
			 onKeyUp="SendSQL('Write','UPDATE Systems SET Equipment=\''+this.value+'\' WHERE SystemID=<%'=SysID%>'); CalculateEstTotal();"
			/>
		</div>
		
		<div class="Row">
			<div class="SystemInfoTag">Overhead &nbsp;</div>
			<input class="SystemInfoDiv" value="<%'=rs("Overhead")%>"
			 onKeyUp="SendSQL('Write','UPDATE Systems SET Overhead=\''+this.value+'\' WHERE SystemID=<%'=SysID%>'); CalculateEstTotal();"
			/>
		</div>
		-->
		
	</div>
	
	<div id="LM" style="height:161px;">
		<div class="SystemInfoLTName" style="border-top:none;">Costing Breakdown</div>
		
		<div class="Row">
			<div class="SystemInfoTag">Parts &nbsp;</div>
			<div id="SysInfoParts" class="SystemInfoDiv Stats"></div>
		</div>

		<div class="Row">
			<div class="SystemInfoTag">Labor &nbsp;</div>
			<div id="SysInfoLabor" class="SystemInfoDiv Stats"></div>
		</div>

		<div class="Row">
			<div class="SystemInfoTag">Travel &nbsp;</div>
			<div id="SysInfoTravel" class="SystemInfoDiv Stats"></div>
		</div>

		<div class="Row">
			<div class="SystemInfoTag">Equipment &nbsp;</div>
			<div id="SysInfoEquipment" class="SystemInfoDiv Stats"></div>
		</div>

		<div class="Row"> 
			<div class="SystemInfoTag">Tax &nbsp;</div>
			<div id="SysInfoTax" class="SystemInfoDiv Stats"></div>
		</div>

		<div class="Row">
			<div class="SystemInfoTag">Overhead &nbsp;</div>
			<div id="SysInfoOverhead" class="SystemInfoDiv Stats"></div>
		</div>

		<div class="Row">
			<div class="SystemInfoTag">Profit &nbsp;</div> 
			<div id="SysInfoProfit" class="SystemInfoDiv Stats"></div>
		</div>

	</div>	
	
	<div id="LB" style="width:100%; height:253px; padding:0;">
		<div class="Row" style="height:auto;">
			<DIV class="SystemInfoLLB" ><!-- Left Box Left Column Bottom Box -->
				
				<div class="Row">
					<DIV class="SystemInfoTag2"></DIV>
					<DIV class="SystemInfoDiv2" style="text-align:center; background:#CBD9BD; font-weight:bold;">Cost</DIV>
				</div>	
		
				<div class="Row">
					<DIV class="SystemInfoTag2">Parts &nbsp;</DIV>
					<DIV id=PartsCost class="SystemInfoDiv2 Stats"></DIV>
				</div>	
		
				<div class="Row">
					<DIV class="SystemInfoTag2">Labor &nbsp;</DIV>
					<DIV id=LaborCost class="SystemInfoDiv2 Stats"></DIV>
				</div>	
		
				<div class="Row">
					<DIV class="SystemInfoTag2">Subtotal &nbsp;</DIV>
					<DIV id=TotalCost class="SystemInfoDiv2 Stats"></DIV>
				</div>	
		
				<div class="Row">
					<DIV class="SystemInfoTag2"></DIV>
					<DIV style="BACKGROUND: #CBD9BD" class="SystemInfoDiv2 Stats"></DIV>
				</div>	
		
				<div class="Row">
					<DIV class="SystemInfoTag2"></DIV>
					<DIV style="BACKGROUND: #CBD9BD" class="SystemInfoDiv2 Stats"></DIV>
				</div>	
		
				<div class="Row">
					<DIV class="SystemInfoTag2"></DIV>
					<DIV style="BACKGROUND: #CBD9BD" class="SystemInfoDiv2 Stats"></DIV>
				</div>	
		
				<div class="Row">
					<DIV class="SystemInfoTag2"></DIV>
					<DIV style="BACKGROUND: #CBD9BD" class="SystemInfoDiv2 Stats"></DIV>
				</div>	
		
				<div class="Row">
					<DIV class="SystemInfoTag2"></DIV>
					<DIV style="BACKGROUND: #CBD9BD" class=SystemInfoDiv2 align="right">
					</DIV>
				</div>	
		
				<div class="Row">
					<DIV class="SystemInfoTag2">Sq Footage</DIV>
					<INPUT id=SysSqFt class="SystemInfoDiv2" style="padding-left:4px;"
					 onkeyup="SendSQL('Write','UPDATE Systems SET SqFoot='+this.value+' WHERE SystemID=<%=SysID%>'); CalculateEstTotal();"
					/> 
				</div>	
		
				<div class="Row">
					<DIV class="SystemInfoTag2">Price/Sq.Ft.</DIV>
					<DIV id=SysSqFtPrice class="SystemInfoDiv2 Stats"></DIV>
				</div>	
		
				<div class="Row">
					<DIV class="SystemInfoTag2">Materials/Price</DIV> 
					<DIV id=SysMatPrice class="SystemInfoDiv2 Stats"></DIV>
				</div>	
					
			</DIV>
			
			<DIV class=SystemInfoLRB>
				<div class="Row" style="height:188px;;">
					<DIV class=SystemInfoLRBL>
						<DIV style="TEXT-ALIGN: center; FONT-SIZE: 11px; FONT-WEIGHT: bold; width:100%;" class=SystemInfoTag2>Margin</DIV>
						<DIV id=PartsPL class="SystemInfoDiv2 Stats" style=" width:100%;"></DIV>
						<DIV id=LaborPL class="SystemInfoDiv2 Stats" style=" width:100%;"></DIV>
						<DIV id=TotalMargin class="SystemInfoDiv2 Stats" style=" width:100%;"></DIV>
						<DIV class=SystemInfoTag2 style=" width:100%;">Tax &nbsp;</DIV>
						<DIV class=SystemInfoTag2 style=" width:100%;">Travel &nbsp;</DIV>
						<DIV class=SystemInfoTag2 style=" width:100%;">Equipment &nbsp;</DIV>
						<DIV class=SystemInfoTag2 style=" width:100%;">Overhead &nbsp;</DIV>
						<DIV class=SystemInfoTag2 style=" width:100%;">Total &nbsp;</DIV>
					</DIV>
					
					<DIV class=SystemInfoLRBR>
						<DIV style="TEXT-ALIGN: center; BACKGROUND: #CBD9BD; FONT-SIZE: 11px; FONT-WEIGHT: bold;" class="SystemInfoDiv3">Sell</DIV>
						<DIV id=PartsSell class="SystemInfoDiv3 Stats"></DIV>
						<DIV id=LaborSell class="SystemInfoDiv3 Stats"></DIV>
						<DIV id=SubTotal class="SystemInfoDiv3 Stats"></DIV>
						<DIV id=Tax class="SystemInfoDiv3 Stats"></DIV>
						<DIV id=Travel class="SystemInfoDiv3 Stats"></DIV>
						<DIV id=Equipment class="SystemInfoDiv3 Stats"></DIV>
						<DIV id=OH class="SystemInfoDiv3 Stats"></DIV>
						<DIV id=TotalSell class=" SystemInfoDiv3 Total" style="font-size:16px;"></DIV>
					</DIV>
				</div>
					
				<DIV class=SystemInfoLRBBox>
					<DIV class=SystemInfoDiv style="position:relative; top:1px; width:100%; height:20px; padding:1px 0 0 0; margin-top: 1px;" align=left>
						<INPUT style="MARGIN: 3px 0px 0px 4px" id=ckIncludeSqFt onchange=UpdateSqFtAdd(this.checked); type=checkbox>
						<LABEL style="POSITION: relative; TOP: -2px" for=ckIncludeSqFt>Add Sq. Ft. to Total</LABEL>
					</DIV>
					
					<DIV class=SystemInfoDiv style="position:relative; top:0px; width:100%; height:19px;" align=left> 
						<INPUT style="MARGIN: 3px 0px 0px 4px" id=ckRound onchange=UpdateRound(this.checked); type=checkbox>
						<LABEL style="POSITION: relative; TOP: -2px" for=ckRound>Round up to next $10</LABEL>
					</DIV>
					
					<DIV class=SystemInfoDiv style="position:relative; top:0px; width:100%; height:18px;" align=left> 
						<INPUT style="margin: 3px 0px 0px 4px" id="ckIncludeSys" onchange=UpdateIncludeSys(this.checked); type=checkbox>
						<label style="position: relative; TOP: -2px" for="ckIncludeSys">Include in project</label>
					</DIV>
					
				</DIV>
					
			</DIV>
			
		</div>	
	</div>	

</div>
		


<div id="RightBox">

	<div style="border:1px Solid #2E4615;">
		<div class="SystemInfoRtitle">RCS Notes (These Are Not Seen By The Customer)</div>
		<textarea style="height:101px;" class="SystemInfoNotes" id="RCSBidText" rows="22"
		 onKeyUp="SendSQL('Write','UPDATE Systems SET RCSNotes=\''+CharsEncode(this.value)+'\' WHERE SystemID=<%=SysID%>')"><%=DecodeChars(rs("RCSNotes"))%></textarea>
									
		<div class="SystemInfoRtitle"><label for="BidText">SCOPE OF WORK / NOTES</label></div>
		<textarea style="height:172px;" class="SystemInfoNotes" id="BidText" rows="25"
		 onKeyUp="SendSQL('Write','UPDATE Systems SET Notes=\''+this.value+'\' WHERE SystemID=<%=SysID%>')"><%=DecodeChars(rs("Notes"))%></textarea>
										
		<div class="SystemInfoRtitle">INCLUDES</div>
										
		<textarea style="height:81px;" class="SystemInfoNotes" id="IncludesText" rows="22"
		 onKeyUp="SendSQL('Write','UPDATE Systems SET Includes=\''+this.value+'\' WHERE SystemID=<%=SysID%>')"><%=DecodeChars(rs("Includes"))%></textarea>
										
		<div class="SystemInfoRtitle">EXCLUDES</div>
		<textarea style="height:92px;" class="SystemInfoNotes" id="ExcludesText"  rows="22"
		 onKeyUp="SendSQL('Write','UPDATE Systems SET Excludes=\''+this.value+'\' WHERE SystemID=<%=SysID%>')"><%=DecodeChars(rs("Excludes"))%></textarea>

<!--
		<div class="SystemInfoRtitle">RCS Notes (These Are Not Seen By The Customer)</div>
		<textarea style="height:101px;" class="SystemInfoNotes" id="RCSBidText" rows="22" onKeyUp="UpdateText('RCSBidText','Text','Systems','SystemID','RcsNotes');"></textarea>
									
		<div class="SystemInfoRtitle"><label for="BidText">SCOPE OF WORK / NOTES</label></div>
		<textarea style="height:172px;" class="SystemInfoNotes" id="BidText" rows="25" onKeyUp="UpdateText('BidText','Text','Systems','SystemID','Notes');"></textarea>
										
		<div class="SystemInfoRtitle">INCLUDES</div>
										
		<textarea style="height:81px;" class="SystemInfoNotes" id="IncludesText" rows="22" onKeyUp="UpdateText('IncludesText','Text','Systems','SystemID','Includes');"></textarea>
										
		<div class="SystemInfoRtitle">EXCLUDES</div>
		<textarea style="height:92px;" class="SystemInfoNotes" id="ExcludesText"  rows="22" onKeyUp="UpdateText('ExcludesText','Text','Systems','SystemID','Excludes');"></textarea>
-->		
	</div>
	
	<div class="SystemLink" Style="width:100%; height:61px; border-left:#000 1px solid; padding:8px; text-align:center;">
		<a href="Javascript:Void();" onClick="DeleteSystem();" style="float:left;">Delete System</a>
		<a href="Javascript:Void();" onClick="Gebi('BidPresetsModal').style.display='block'; Gebi('CopySystemBox').style.display='block'; Gebi('CopySysName').focus();">
			Copy System
		</a>
		<div style="float:right; padding:0;"><a href="Javascript:Void();" onClick="OpenPresets();">BID PRESETS</a> &nbsp; &nbsp; </div>
	</div>
		
</div>

<script type="text/javascript">
	function CopySystem()
	{
		var Fields='Selected, Obtained, ProjectID, System, DateEntered, DateBid, DateWon, Description, Notes, RCSNotes, Includes, Excludes, EnteredByID, EnteredBy, MU, Travel, Equipment, Overhead, LaborCost, LaborSell, PartsCost, PartsSell, SalesTax, TotalSale, LaborPL, PartsPL, TotalPL, TaxRate, Email, FixedPrice, TotalCost, Subtotal, Plans, Permits, UnderGround, Rough, RoughInspect, OrderMaterials, Trim, FinalInspect, Finished, ConstType, OccRating, SqFoot, SqFootAdd, Round, ExcludeSys, Floors, Rooms, PrintChecked, TotalFixed, CopiedSysID';
		
		var TimeStamp='<%=Date&" "&Time%>'
		
		var Values="'<%=rs("Selected")%>',";
		Values+="'<%=rs("Obtained")%>',";
		Values+="'<%=rs("ProjectID")%>',";
		Values+="'"+Gebi('CopySysName').value+"',";
		Values+="'"+TimeStamp+"',";
		Values+="'<%=rs("DateBid")%>',";
		Values+="'<%=rs("DateWon")%>',";
		Values+="'<%=rs("Description")%>',";
		
		Values+="'"+CharsEncode(Gebi('BidText').value)+"',";
		Values+="'"+CharsEncode(Gebi('RCSBidText').value)+"',";
		Values+="'"+CharsEncode(Gebi('IncludesText').value)+"',";
		Values+="'"+CharsEncode(Gebi('ExcludesText').value)+"',";
		
		Values+="'<%=rs("EnteredByID")%>',";
		Values+="'<%=rs("EnteredBy")%>',";
		Values+="'<%=rs("MU")%>',";
		Values+="'<%=rs("Travel")%>',";
		Values+="'<%=rs("Equipment")%>',";
		Values+="'<%=rs("Overhead")%>',";
		Values+="'<%=rs("LaborCost")%>',";
		Values+="'<%=rs("LaborSell")%>',";
		Values+="'<%=rs("PartsCost")%>',";
		Values+="'<%=rs("PartsSell")%>',";
		Values+="'<%=rs("SalesTax")%>',";
		Values+="'<%=rs("TotalSale")%>',";
		Values+="'<%=rs("LaborPL")%>',";
		Values+="'<%=rs("PartsPL")%>',";
		Values+="'<%=rs("TotalPL")%>',";
		Values+="'<%=rs("TaxRate")%>',";
		Values+="'<%=rs("Email")%>',";
		Values+="'<%=rs("FixedPrice")%>',";
		Values+="'<%=rs("TotalCost")%>',";
		Values+="'<%=rs("Subtotal")%>',";
		Values+="'<%=rs("Plans")%>',";
		Values+="'<%=rs("Permits")%>',";
		Values+="'<%=rs("UnderGround")%>',";
		Values+="'<%=rs("Rough")%>',";
		Values+="'<%=rs("RoughInspect")%>',";
		Values+="'<%=rs("OrderMaterials")%>',";
		Values+="'<%=rs("Trim")%>',";
		Values+="'<%=rs("FinalInspect")%>',";
		Values+="'<%=rs("Finished")%>',";
		Values+="'<%=rs("ConstType")%>',";
		Values+="'<%=rs("OccRating")%>',";
		Values+="'<%=rs("SqFoot")%>',";
		Values+="'<%=rs("SqFootAdd")%>',";
		Values+="'<%=rs("Round")%>',";
		Values+="'<%=rs("ExcludeSys")%>',";
		Values+="'<%=rs("Floors")%>',";
		Values+="'<%=rs("Rooms")%>',";
		Values+="'<%=rs("PrintChecked")%>',";
		Values+="'<%=rs("TotalFixed")%>',";
		Values+="'<%=rs("SystemID")%>'"
		SendSQL("Write","INSERT INTO SYSTEMS ("+Fields+") VALUES ("+Values+")");
		
		parent.OpenProject(<%=rs("ProjectID")%>);
	}
	//alert('CopySystem izzzzzz defined');
</script>

<div id="CopySystemBox" style="position:absolute; top:96px; left:33%; width:33%; display:none; background:#B1DB87; z-index:200001; text-align:center;">
	<div style=" width:100%; height:24px; text-align:center; background:#DDEFCB;">Copy System</div>
	<label for="CopySysName">System Name:</label><input id="CopySysName" /><br>
	Note: Parts, Labor, and Expenses are not copied.
	<div style=" width:100%; height:24px;">
		<button style="float:left;" onClick="Gebi('CopySystemBox').style.display='none'; Gebi('BidPresetsModal').style.display='none';">Cancel</button>
		<button style="float:right;" onClick=" CopySystem(); Gebi('CopySystemBox').style.display='none'; Gebi('BidPresetsModal').style.display='none';">Copy</button>
	</div>
</div>


<!-- BID PRESET //////////////////////////////////////////////////////////////////////////////////////////////////// --> 



<div id="BidPresetsModal" class="BidPresetsModal"></div>

<div id="BidPresetsContainer" class="BidPresetsContainer"> 

	<div id="PresetPage1" class="PresetPage1">
		<div id="" class="PresetTitle">Please Select A System</div>
		
		<div id="" class="PresetSystemSelect"><select class="" style="width:150px;" id="PresetSystemsList" onChange="BidPresetList();" ></select></div>
			<div id="PresetBottom" class="PresetBottom" align="center">
				<div id="" class="PresetLBtn" onClick="ClosePresets();"><button>CANCEL</button></div>	
				<!-- <div id="" class="PresetRBtn" onClick="BidPresetList();"><button>NEXT</button></div> -->
			</div>
    </div>	
    
	<div id="PresetPage2" class="PresetPage2"> 
	
		<div id="" class="PresetTitle">Please Select A Preset</div>
		<div id="PresetList" class="PresetList">  </div>
		
		<div id="PresetBottom" class="PresetBottom">
		<div id="" class="PresetLBtn" onClick="ClosePresets();"><button>CANCEL</button></div>	
		<div id="PreHiddenTxt" class="PreHiddenTxt">0</div>
		<div id="" class="PresetRBtn" onClick="BidPresetCreate();"><button>CREATE</button></div>
	</div>
</div>
</div>

<script type="text/javascript">
//SYSTEMS DROPDOWN------------------------------------- 
	var SysArray = parent.parent.SystemsListArray;
	var SysLen = parent.parent.SystemsListArray.length; 
	 
	Gebi('PresetSystemsList').length=null;
	 
	   var newOption = document.createElement("OPTION");
	  // PresetSystemsList.options.add(newOption);
	  // newOption.value = 0;
	  //  newOption.innerText = 'None';
	 
	for (var y = 0; y < SysLen; y++)
	 {
	   var newOption = document.createElement("OPTION");
	   Gebi('PresetSystemsList').options.add(newOption);
	   newOption.value = SysArray[y][0];
	   newOption.innerText = SysArray[y][1];
	 } 

</script>

<!-- END BID PRESET //////////////////////////////////////////////////////////////////////////////////////////////// --> 

</body>
</html>
