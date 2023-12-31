<!--#include file="../../LMC/RED.asp" -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<title>LMC Estimates</title>

<script type="text/javascript">var InsideFrame=false;</script>

<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="EstimatesJS.js"></script>
<script type="text/javascript" src="EstimatesAJAX.js"></script>
<script type="text/javascript" src="../Library/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>

<link rel="stylesheet" href="../Library/CSS_DEFAULTS.css" media="screen">
<link rel="stylesheet" href="EstimatesCSS.css" media="screen">
<link type="text/css" rel="stylesheet" href="../Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">

<script type="text/javascript">

	var InsideFrame=false;
	
	if(!parent.accessEstimates){window.location='blank.html';}
	
	var EmployeeArray=parent.EmployeeArray;
	var accessEmpName=parent.accessEmpName;
	
	var ReportedError=false;
	window.onerror=function(msg, url, linenumber)
	{
		if(window.top.accessUser=='n8') // I was quickly filling up the database with
		{return false;}                 //development-related errors, but not anymore.
		
		ErrorReport(msg, url, linenumber, window.top.accessUser);		//Save the error to the database
		
		if(!ReportedError)
		{																
			alert('Errors in Estimates.');														//Show an alert box on the first error
			ReportedError=true;																				//Then be quiet.
		}
	}
</script>


</head>
<body onMouseMove="//MouseMove(event);" onLoad="//onResize();" onResize="//onResize();"> 

<div class="OverAllContainer" id="OverAllContainer" >

ProjId:<%=Request.QueryString("ProjId")%>
<!--	
	<div id="LeftContainer" class="LeftContainer">
		
		<div id="LeftModal" class="NewProjModal"></div>

		<div id="LeftTitle" class="SectionTitle" align="center">Estimating / Sales</div> 
		
		<div id="LeftTop" style="width:100%; height:39px;">
			<div style=" width:100%; font-size:14px; height:16px; padding:2px 2px 0 0; z-index:1000; border-bottom:1px #CCC solid;">
				<div style="float:left; font-size:16px; height:16px; position:relative; top:-3px;">View: &nbsp;  &nbsp; </div>
				<input id="ProjView" type="radio" style="float:left; padding:0; margin:0" checked onChange="Gebi('ToDoView').checked=!this.checked; ProjTodoToggle();" />
				<label for="ProjView" style="float:left;">Project </label>
				
				<label for="ToDoView" style="float:right; white-space:pre;">To-Do List &nbsp; </label>
				<input id="ToDoView" type="radio" style="float:right; padding:0; margin:0" onChange="Gebi('ProjView').checked=!this.checked; ProjTodoToggle();" />
			</div>
		
			<div style=" width:100%; font-size:13px; height:18px; padding-top:2px; text-align:center; z-index:1000;">
				<div id=NewProjLink style="text-align:center; width:auto; z-index:1000;">
					<a href=Javascript:Void(); onClick=ShowNewProjBox(); style="height:100%; background:url(images/Yellowish.png)"><b>New Project</b></a>
				</div>
			</div>
		
		</div>
		
		
		<div id="AreaContainer" class="AreaContainer">
		
			<!--  div id="LBackDrop" style="overflow:visible; width:100%; height:1px; position:relative; z-index:0;">
				<div id="LGrPos" style="width:100%; height:64px; position:relative; z-index:1;"></div>
				<div id="LGrad" style="width:216px; height:128px; background:url(images/Graydiant128.gif) repeat-x; position:relative; z-index:1;"></div>
			</div  - -> 
			    
			<div id="AreaTopBox" class="AreaTopBox">
			
				<label align="left" class="TitleText11B" style="float:left; margin:0;" for="AreaSearch">Select Area:</label><br/>
				<select class="AreaSearchSelect" id="AreaSearch" onChange="GetProjects(); onResize();" onFocus="SwitchToProjView();" style="float:left;">
				< %AreaOptionList("State") % >
				</select><br/><br/>
				
				<label class="TitleText11B" style="float:left; margin:0; width:52px; padding:6px 0 0 4px;" for="SearchDateFrom">Between:</label>
				<input id="SearchDateFrom" onChange="GetProjects();" onFocus="SwitchToProjView();" style="float:left; width:128px;" value="1/1/1900"/>
				<img class=DateButton onClick="PGebi('oldBidderFrame').style.display='none'; displayCalendar('SearchDateFrom','mm/dd/yyyy',this);" src="../../LMCManagement/Images/cal.gif" width="16" height="16" />
				<br/>
				
				<label class="TitleText11B" style="float:left; margin:0; width:52px; padding:6px 0 0 4px;" for="SearchDateTo"><div style="float:right;">and:</div></label>
				<input id="SearchDateTo" onChange="GetProjects();" onFocus="SwitchToProjView();" style="float:left; width:128px;"/>
				<img class=DateButton onClick="PGebi('oldBidderFrame').style.display='none'; displayCalendar('SearchDateTo','mm/dd/yyyy',this);" src="../../LMCManagement/Images/cal.gif" width="16" height="16" />
				<script type="text/javascript">var Today=new Date; Gebi('SearchDateTo').value=(Today.getMonth()+1)+'/'+Today.getDate()+'/'+Today.getFullYear(); </script>
				<br/>
				<br/>
				<div style="float:left; clear:both; width:100%;">
					<input id="ckShowObtained" type="checkbox" style="margin:0 0 8px 0;" onChange="GetProjects();"/>
					<label class="TitleText11B" style="position:relative; top:-2px; padding:0; margin:0; cursor:pointer;" for="ckShowObtained">Show Only Obtained</label>
				</div>	
				<br/>
				
				<label align="left" class="TitleText11B" style="float:left; width:100%;" for="CustomerTxt">Customer Search:</Label>
				<form action="javascript:GetCustomer(Gebi('CustomerTxt').value);">
					<input id="CustomerTxt" class="CustSearchTxt" type="text" size="20" maxlength="28" onKeyUp="GetCustomer(this.value);" onFocus="SwitchToProjView();">
					<input class="CustSearchBtn" type="submit" value="▼" title="Show Customer Results">
				</form>
				<button class=CustSearchBtn onClick="SearchCustID=0; Gebi('CustomerTxt').value=''; GetProjects();" title="Clear"><b>X</b></button>

			</div>
			
			<div id="CustomersBox" class="HiddenBox">
				<div id="CustList" class="CustomerList"></div>
			</div>
			
			<div class="ProjList" id="ProjList"></div>	
		</div><!-- End ProjectsContainer - -> 




  
  
		<div id="CustomerContainer" class="CustomerContainer"> 
			 
			<div class="CustomersContainer"> 
				
				<div>
				</div>
		
		
				
					<div Style="position:relative; float:left; width:208px; z-index:1000;">
						<div class="ListTitles">Customers</div>
					  <div class="ListLinks"></div>
			  </div>
							
					<div id="CustNewBox" class="HiddenBox200Border">
						
						<div class="TitleBox200Centered"><Label id="CustTitleName" class="TitleText11B">New Customer Info</Label></div>
							<form  style="margin: 0px 0px 0px 0px;" name="NewCustomer" action="javascript:GetCustomer();" >
								<Label for="CustName" class="TitleText10B">Name</Label>
								<input id="CustName" type="text" size="25" maxlength="25">
								<Label for="CustAddress" class="TitleText10B">Address</Label>
								<input id="CustAddress" type="text" size="25" maxlength="25">
								<Label for="CustCity" class="TitleText10B">City</Label>
								<input id="CustCity" type="text" size="25" maxlength="25">
								<Label for="CustState" class="TitleText10B">State</Label>
								<input id="CustState" type="text" size="25" maxlength="25">
								<Label for="CustZip" class="TitleText10B">Zip</Label>
								<input id="CustZip" type="text" size="25" maxlength="25">
								<Label for="CustPhone" class="TitleText10B">Phone</Label>
								<input id="CustPhone" type="text" size="25" maxlength="25">
								<br/>
								<div Style="position:relative; float:left; width:200px;">
									<div style="position:relative; float:left"><input  class="Button11B" name="Close" type="button" value="Cancel" onClick="CloseCustNewBox()"></div>
									<div style="position:relative; float:right"><input  class="Button11B" name="CustSubmit" type="submit" value="Save"></div>
								</div>
							</form>
						</div>
						
		
		</div>
		
		 
		 		 
		 
		 
		
		<!-- Main Dropdown Box For Showing Projects and Bids related to a customer ****************************************************************** - ->    
		<div id="ProjectsBox" class="ProjectListContainer">
			<div class="TitleBox200Centered" style="position:relative; width:208px; background:none;">
				<div class="ListTitles">Projects for</div>
				<Label id="CustNameTag" class="TitleText14B" style="position:relative; width:100%; height:2px; background:none;">.</Label>
			</div>
			
			<div id="ProjBox" class=""> <!-- Projects Tab --> 
				<!-- Project List Container - ->        
			</div> 
		</div>
		<!-- ********End Project Dropdown*********************** - -> 
		 
		 
		
	</div><!-- End CustomerContainer - -> 





<input id="HiddenCustID" type="Hidden" value="">    
<input id="HiddenProjID" type="Hidden" value="">  
<input id="HiddenEstID" type="Hidden" value=""> 
<input id="HiddenCustName" type="Hidden" value="">    
<input id="HiddenProjName" type="Hidden" value="">
<input id="HiddenJobObtained" type="Hidden" value="">
</div>
-->
<!-- End Left Container===========End Left Container --> 
<!-- End Left Container===========End Left Container --> 
<!-- End Left Container============================= -->




















<div id="NewSystemBox" class="NewSystemBox">
	<div id="" class="NewSystemHead">Create A New System Estimate</div>
	<hr/>
	<div class="NewSystemTitles">System Name</div>
	<div id="" class=""><input class="" style="width:200px;" name="NewSysName" id="NewSysName" type="text" value="" maxlength="60"></div>
	<div class="NewSystemTitles">Entered By</div>
	<div id="" class=""><select  class="" style="width:150px;" name="NewSysEnteredBy" id="NewSysEnteredBy" ></select></div>
	<div class="NewSystemTitles">Date</div>

	<div class="">
		<input class="" name="NewSysDate" id="NewSysDate" type="text" value="" maxlength="48" />
		<img style="cursor:pointer;"onclick="displayCalendar('NewSysDate','mm/dd/yyyy',this)" src="../../LMCManagement/Images/cal.gif" width="16" height="16">	</div>

	<div class="NewSystemTitles">Profit</div>
	<div id="" class=""><input class=""  style="width:50px;" name="NewSysMU" id="NewSysMU" type="text" value="100" maxlength="20"  ></div>
	<div class="NewSystemTitles">Tax</div>
	<div id="" class=""><input class=""  style="width:50px;" name="NewSysTax" id="NewSysTax" type="text" value="7.75" maxlength="20"></div>
	<br/>
	<hr/>
	<div id="" class="" style="position:relative; width:98%;">
		<button class="" style="float:left;" onClick="CloseNewSystemModal();">Cancel</button>
		<button class="" style="float:right;" onClick="NewSystem();">Save</button>
	</div>
</div>

<!-- Begin Right Container++++++++++++++++++++++++++++++++++++++++++++++++++ --> 

<div id="RightContainerContainer" style="float:left; overflow:visible; width:100%; height:100%; display:inline; position:absolute; top:0px; left:216px;">
<div id="RightContainer" class="RightContainer">


<div id="ProjectContainer" class="ProjectContainer" style="display:none;">
	
	<div id="ProjectOverlay" class="ProjectOverlay">
		<div id="ProjectOverlayTxt" class="ProjectOverlayTxt">1234</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<img name="" src="../../LMCManagement/Images/Roller.gif" width="32" height="32" alt="" />	</div>
		
		<div class="EstimateMainHeader"> 
			<div id="EstTopInfo3" class="ProjectMainHeaderTxt"></div>
			<div class="ProjectMainHeaderTxt">&nbsp;/&nbsp;</div>
			<div id="EstTopInfo2" class="ProjectMainHeaderTxt"></div>
			<div class="ProjectMainHeaderTxt">&nbsp;/&nbsp;</div>
			<div id="EstTopInfo1" class="ProjectMainHeaderTxt"></div>
			<button id="ReloadFrame" onClick="window.location=window.location"><img src="../../LMCManagement/images/reloadblue24.png" width="100%" height="100%"/></button>
		</div>
				
		<div id="ProjectBox" class="ProjectBox">
		 
			<div class="EstimateTabsBox"><!-- Creates the Tabs for The Estimate --> 
	
				<div id="ProjMainTab" onMouseUp="ProjTabs('ProjectMainBox','ProjMainTab')" class="ProjTab1">
					<div id="ProjMainTabText" class="ProjTab1Text">Project</div>
				</div>
				<div id="ProjPrintTab" onClick="PrintSystemsList(); ProjTabs('ProjPrintBox','ProjPrintTab')" class="ProjTab2">
					<div id="ProjMainTabText" class="ProjTab2Text">Printing</div>
				</div>
			
				<div id="ProjSysTabs">
					<div id="ProjSysTab" onMouseUp="ProjTabs('ProjSysBox','ProjSysTab')" class="ProjTab3" >Systems</div>
				</div>
			</div>

			<div class="EstimateTabsBottom"></div>
				
			<div id="ProjectMainBox" class="ProjectMainBox">
				
				<!-- <div id="ProjectLock1"	class="ProjectLock1"></div> -->
			
				<div id="ProjInfoBox" class="ProjInfoBox">
				
					<div class="ProjInfoL"><!-- Left Main Box --> 
					
						<div class="SystemLink" style="height:18px; width:100%; margin-top:3px; overflow:visible;">
							<div style="width:25%; float:left;" align="center">
								<a id="NewSysLink" href="Javascript:Void();" onClick="NewSystemModal();" >New System</a>
							</div>
							<div style="width:25%; float:left;" align="center">
								<a id="DelProjLink" href="Javascript:Void();" onClick="UnBidToAll(HiddenProjID.value); DeleteProject();" >Delete Project</a>
							</div>
							<!--
							<div id="ActivateDiv" style="width:25%; float:left;" align="center">
								<a id="ActivateProj" href="Javascript:Void();" onClick="ActivateProj(HiddenProjID.value);" >Activate Project</a>
							</div>
							-->
							<div style="width:25%; float:left;" align="center">
								<!-- <a id="ContractSigned" href="Javascript:Void()" onClick="ObtainBidModal()" >Contract Signed</a>
								<a id="UnContract" href="Javascript:Void();" onClick="UnContract();" style="display:none;">Revert to Bid</a>	 -->
							</div>
						</div>
	
						<div class="ProjInfoLT"><!-- Left Top  --> 
	
						<div class="ProjInfoLTName">The Project Name</div>
						<div class="">
							<input class="ProjInfoLTTxt" name="ProjectName" id="ProjectName" type="text" value="Kemmerr Best Western" maxlength="49"
							 onKeyUp="UpdateText(this.id,'Text','Projects','ProjID','ProjName')";>
						</div>
					</div>
								
					<div class="ProjInfoLL"><!-- Left Box Left Column --> 
					
						<div class="ProjInfoLLT"><!-- Left Box Left Column Top Box --> 
							<div class="ProjInfoTag">Address</div>
							<div class="ProjInfoTag">City</div>
							<div class="ProjInfoTag">State</div>
							<div class="ProjInfoTag">Zip</div>
							<div class="ProjInfoTag"></div>
							<div class="ProjInfoTag">Date Created</div>
							<div class="ProjInfoTag">Area</div>
							<div class="ProjInfoTag">Franchise</div>
							<div class="ProjInfoTag">Subsidiary Of</div>
							<div class="ProjInfoTag">Owner</div>
							<div class="ProjInfoTag">Contact</div>
							<div class="ProjInfoTag">Phone</div>
							<div class="ProjInfoTag">Fax</div>
							<div class="ProjInfoTag">Email</div>
						</div>
					
						<div class="ProjInfoLLB"><!-- Left Box Left Column Bottom Box --> 
						
							<div class="ProjInfoLLBL"><!-- Left Box Right Column Bottom Box --> 
								<div style="border-left:1px solid #2E4615;" class="ProjInfoTag2">Square Footage</div>
								<div style="border-left:1px solid #2E4615;" class="ProjInfoTag2"># of Floors</div>
								<div style="border-left:1px solid #2E4615;" class="ProjInfoTag2"># of Rooms </div>
								<div style="border-left:1px solid #2E4615;" class="ProjInfoTag2"># of Rm ADA</div>
								<div style="border-left:1px solid #2E4615;" class="ProjInfoTag2">Ceiling Heights</div>
							</div>
					
							<div class="ProjInfoLLBR"><!-- Left Box Right Column Bottom Box --> 
								
								<div class="ProjInfoDiv2">
									<input class="ProjInfoTxt2"name="SqFoot" id="SqFoot" type="text" value="" maxlength="48" onFocus="OldTxt[this.id]=this.value;" readonly
								 onblur="OldTxt[this.id]=null;" onKeyUp="CheckComma(event,this); UpdateText('SqFoot','Text','Projects','ProjID','SqFoot');">
								</div>
								
								<div class="ProjInfoDiv2">
									<input class="ProjInfoTxt2"name="Floors" id="Floors" type="text" value="" maxlength="48"
									 onKeyUp="UpdateText('Floors','Text','Projects','ProjID','Floors');">
								</div>
								
								<div class="ProjInfoDiv2">
									<input class="ProjInfoTxt2"name="Rooms" id="Rooms" type="text" value="" maxlength="48"
									 onKeyUp="UpdateText('Rooms','Text','Projects','ProjID','Rooms');">
								</div>
								
								<div class="ProjInfoDiv2">
									<input class="ProjInfoTxt2"name="ADArooms" id="ADArooms" type="text" value="" maxlength="48"
									 onKeyUp="UpdateText('ADArooms','Text','Projects','ProjID','ADArooms');">
								</div>
								
								<div class="ProjInfoDiv2">
									<input class="ProjInfoTxt2"name="CeilingHeight" id="CeilingHeight" type="text" value="" maxlength="48"
									 onKeyUp="UpdateText('CeilingHeight','Text','Projects','ProjID','CeilingHeight');">
								</div>                    
							</div>            
						</div>
									
					<div id="ProjIDTxt" class="ProjInfoLLBBox"></div>
				</div> 
		
		
<div class="ProjInfoLR"><!-- Left Box Right Column --> 

		<!-- <div id="ProjectLock2" class="ProjectLock2"><img alt="Bid is locked" src="images/Bidlock.png" width="100%" height="98%"/></div> -->


	<div class="ProjInfoLRT"><!-- Left Box Right Column Top Box --> 

		<div class="ProjInfoDiv">
			<input class="ProjInfoTxt" name="ProjAddress" id="ProjAddress" type="text" value="" maxlength="48"
			onKeyUp="UpdateText('ProjAddress','Text','Projects','ProjID','ProjAddress');" >
		</div>
		<div class="ProjInfoDiv">
			<input class="ProjInfoTxt" name="ProjCity" id="ProjCity" type="text" value="" maxlength="48"
			onKeyUp="UpdateText('ProjCity','Text','Projects','ProjID','ProjCity');">
		</div>
		<div class="ProjInfoDiv">
			<input class="ProjInfoTxt" name="ProjState" id="ProjState" type="text" value="" maxlength="48"
			onKeyUp="UpdateText('ProjState','Text','Projects','ProjID','ProjState');">
		</div>
		<div class="ProjInfoDiv">
			<input class="ProjInfoTxt" name="ProjZip" id="ProjZip" type="text" value="" maxlength="10" onBlur="OldTxt[this.id]=null;"
			onKeyUp="CheckZip(event,this); UpdateText('ProjZip','Text','Projects','ProjID','ProjZip');">
		</div>
		<div class="ProjInfoDiv">
			<input class="ProjInfoTxt" name="XXXXXX" id="XXXXXX" type="text" value="" maxlength="48" readonly />
		</div>
		<div>
		<div class="ProjInfoDiv">
			<input class="ProjInfoTxt" name="DateEnt" id="DateEnt" type="text" value="" maxlength="48" readonly />
		</div>
		<div class="ProjInfoDiv">
			<select  class="SystemSelectBox" style="background:#F8FCF3; width:100%;" id="ProjectArea" onFocus="CheckLock(this);"
			onChange="UpdateText('ProjectArea','ListTxt','Projects','ProjID','Area'); AreaSearch.selectedIndex = this.selectedIndex; LoadAreaProj();"></select>
		</div>
		<div class="ProjInfoDiv">
			<select  class="SystemSelectBox" style="background:#F8FCF3; width:100%;" id="ProjectFranchise"
			 onChange="UpdateSubOf(); UpdateText('ProjectFranchise','ListTxt','Projects','ProjID','Franchise');"></select>
		</div>
		<div class="ProjInfoDiv">
			<input class="ProjInfoTxt" name="SubOf" id="SubOf" type="text" value="" maxlength="48" onFocus=""
			 onBlur="UpdateText('SubOf','Text','Projects','ProjID','SubOf');" readonly>
		</div>
		</div>
		<div class="ProjInfoDiv">
			<input class="ProjInfoTxt" name="OwnName" id="OwnName" type="text" value="" maxlength="48"
			 onKeyUp="UpdateText('OwnName','Text','Projects','ProjID','OwnName');">
		</div>
		<div class="ProjInfoDiv">
			<input class="ProjInfoTxt" name="OwnContact" id="OwnContact" type="text" value="" maxlength="48" 
			onKeyUp="UpdateText('OwnContact','Text','Projects','ProjID','OwnContact');">
		</div>
		<div class="ProjInfoDiv">
			<input class="ProjInfoTxt" name="OwnPhone1" id="OwnPhone1" type="text" value="" maxlength="48" onFocus="OldTxt[this.id]=this.value;"
			 onblur="OldTxt[this.id]=null;" onKeyUp="CheckPhone(event,this); UpdateText('OwnPhone1','Text','Projects','ProjID','OwnPhone1');">
		</div>
		<div class="ProjInfoDiv">
			<input class="ProjInfoTxt" name="OwnFax" id="OwnFax" type="text" value="" maxlength="48" onFocus="OldTxt[this.id]=this.value;"
			 onblur="OldTxt[this.id]=null;"	onKeyUp="CheckPhone(event,this); UpdateText('OwnFax','Text','Projects','ProjID','OwnFax');">
		</div>
		<div class="ProjInfoDiv">
			<input class="ProjInfoTxt" name="OwnEmail" id="OwnEmail" type="text" value="" maxlength="48" 
			onKeyUp="UpdateText('OwnEmail','Text','Projects','ProjID','OwnEmail');">
		</div>
	</div>
				
	<div class="ProjInfoLRB"><!-- Left Box Right Column Bottom Box --> 
		
		<div class="ProjInfoLRBL"><!-- Left Box Right Column Bottom Box --> 
			<div class="ProjInfoTag2">Constr Type</div>
			<div class="ProjInfoTag2">Occ Rating</div>
			<div class="ProjInfoTag2">Occ Load</div>
			<div class="ProjInfoTag2">Wiring Method</div>
			<div class="ProjInfoTag2">Adopted Codes</div>
		</div>
		
		<div class="ProjInfoLRBR"><!-- Left Box Right Column Bottom Box --> 
			
			<div class="ProjInfoDiv3">
				<input class="ProjInfoTxt2" name="ConstrType" id="ConstrType" type="text" value="" maxlength="48"
				 onKeyUp="UpdateText('ConstrType','Text','Projects','ProjID','ConstrType');">
			</div>
			<div class="ProjInfoDiv3">
				<input class="ProjInfoTxt2" name="OccRating" id="OccRating" type="text" value="" maxlength="48"
				 onKeyUp="UpdateText('OccRating','Text','Projects','ProjID','OccRating');">
			</div>
			<div class="ProjInfoDiv3">
				<input class="ProjInfoTxt2" name="OccLoad" id="OccLoad" type="text" value="" maxlength="48"
				 onKeyUp="UpdateText('OccLoad','Text','Projects','ProjID','OccLoad');">
			</div>
			<div class="ProjInfoDiv3">
				<input class="ProjInfoTxt2" name="Wiring" id="Wiring" type="text" value="" maxlength="48"
				 onKeyUp="UpdateText('Wiring','Text','Projects','ProjID','Wiring');">
			</div>
			<div class="ProjInfoDiv3">
				<input class="ProjInfoTxt2" name="Codes" id="Codes" type="text" value="" maxlength="48"
				 onKeyUp="UpdateText('Codes','Text','Projects','ProjID','Codes');">
			</div>
		</div>           
	</div>
	
	<div class="ProjInfoLRBBox"></div>
		
	<div  class="SystemLink"  Style="float:right; padding-right:4px; margin-top:4px">	</div>
	</div><!-- Left Box Right Colunm++++++++++++++++++++++++++++++++++++++++++++++ --> 
</div>
           
            
            
            
		<div class="ProjInfoR">
			
			<div style="border:1px Solid #2E4615; ">
				<div class="ProjInfoRtitle">RCS Notes</div>
				<textarea class="ProjInfoNotes" id="ProjNotes"
				 onkeyup="SendSQL('Write','UPDATE Projects SET RCSNotes=\''+CharsEncode(this.value)+'\' WHERE ProjID='+Gebi('HiddenProjID').value);"></textarea>
			</div>
			
			<div style="border:1px Solid #2E4615; margin-top:12px;">

					<div class="ProjInfoRtitle" style="border-top:none;">Total Project Costing Breakdown</div>
					
					<div>
						<div class="ProjInfoTag" style="border-left:none; padding:0px;">
							<div id="ProjInfoParts" class="ProjInfoDivR"></div>
							<div style="float:right;">Materials &nbsp;</div>
						</div>
					</div>
			
					<div class="ProjInfoTag" style="border-left:none; padding:0px;">Labor &nbsp;<div id="ProjInfoLabor" class="ProjInfoDivR"></div></div>

					<div class="ProjInfoTag" style="border-left:none; padding:0px;">
						<div id="ProjInfoTravel" class="ProjInfoDivR" ></div>
						<div style="float:right;">Travel &nbsp;</div>
					</div>
		
					<div class="ProjInfoTag" style="border-left:none; padding:0px;">
						<div id="ProjInfoEquipment" class="ProjInfoDivR" ></div>
						<div style="float:right;">Equipment &nbsp;</div>
					</div>
		
					<div class="ProjInfoTag" style="border-left:none; padding:0px;">
						<div id="ProjInfoTax" class="ProjInfoDivR" </div>
						<div style="float:right;">Tax &nbsp;</div>
					</div>
		
					<div class="ProjInfoTag" style="border-left:none; padding:0px;">
						<div id="ProjInfoOverhead" class="ProjInfoDivR" ></div>
						<div style="float:right;">Overhead &nbsp;</div>
					</div>
		
					<div class="ProjInfoTag" style="border-left:none; padding:0px;">
						<div id="ProjInfoProfit" class="ProjInfoDivR" ></div>
						<div style="float:right;">Profit &nbsp;</div> 
					</div>
		
					<div class="ProjInfoTag" style="border-left:none; padding:0px; border-bottom:none;">
						<div id="ProjInfoTotal" class="ProjInfoDivR" style="font-size:16px;"></div>
						<div style="float:right;">Total &nbsp;</div> 
					</div>
		
			</div>

			
			<div class="BidToLink" style="white-space:nowrap;">
				<a style="float:right;" id="UnBidAllLink" href="Javascript:Void();" onClick="UnBidToAll(HiddenProjID.value);" >Remove All Customers</a>
				<a style="" id="AddCustLink" href="Javascript:Void();" onClick="BidToAdd();" >Add Customer</a>
			</div>
			
			<div id="ProjBidToTitle" class="ProjBidToTitle">Bid To:</div>
			<div style="top:30px; border:1px Solid #2E4615; border-top:none;">
				<div class="ProjBidToList" name="BidToList" id="BidToList"  ></div>
			</div>	
		
		</div>
	</div>
	<!-- End Project Info Box++++++++++++++++++++++++++++++++++++++++++++++ --> 
</div>
    
</div> 
    

<div id="ProjPrintBox" class="ProjPrintBox"><!-- Start Print++++++++++++++++++++++++++++++++++++++++++TAB --> 

	<div class="PrintBoxL"><div style="width:125%">
		<div class="PrintSetupHeader">Customers</div>

		<div id="PrintForList" class="PrintForList">
			<div>
				<input name="rb1" type="radio" /> Keep Sweet <br />
				<input name="rb1" type="radio" checked /> Keep Sweeter			</div>
		</div>
		<hr/>
		
		<div class="PrintSetupHeader">Systems</div>
		<div id="PrintSystemList" class="PrintSystemList">
			<div><input name="cb1" type="checkbox" /> Keep Sweet</div>
		</div>
		<hr/>
		
		<div class="PrintSetupHeader">Letterhead</div>
		<div><input id="TFP_TCS" type="checkbox" onClick="LetterHeadSW('TFP_TCS','TFP','TCS'); "/><label for="TFP_TCS">TFP/ TCS</label></div>
		<div><input id="TFP" type="checkbox" onClick="LetterHeadSW('TFP','TFP_TCS','TCS');"/><label for="TFP">TFP</label></div>
		<div><input id="TCS" type="checkbox" onClick="LetterHeadSW('TCS','TFP_TCS','TFP');"/><label for="TCS">TCS</label></div>
		<hr/>

		<div class="PrintSetupHeader">General</div>
		<div><input id="SystemTotals" type="checkbox" onClick="PrintChecked(this);"/><label for="SystemTotals">System Totals</label></div>
		<div><input id="LetterBody" type="checkbox" onClick="PrintChecked(this);"/><label for="LetterBody">Letter Body</label></div>
		<div><input id="Includes" type="checkbox" onClick="PrintChecked(this);"/><label for="Includes">Includes</label></div>
		<div><input id="Excludes" type="checkbox" onClick="PrintChecked(this);"/><label for="Excludes">Excludes</label></div>
		<div><input id="pNotes" type="checkbox" onClick="PrintChecked(this);"/><label for="pNotes">Scope of work</label></div>
		<div><input id="pSubtotal" type="checkbox" onClick="PrintChecked(this);"/><label for="pSubtotal">Subtotal</label></div>
		<div><input id="pTax" type="checkbox" onClick="PrintChecked(this);"/><label for="pTax">Tax</label></div>
		<div><input id="pTotal" type="checkbox" onClick="PrintChecked(this);"/><label for="pTotal">Total</label></div>
		<hr/>
			
		<div class="PrintSetupHeader">License Footers</div>
			<div id="PrintLicenseList" class="PrintForList">			</div>
		</div>
			
	<!-- div class="PrintSetupHeader">Parts</div>
		<div><input name="PartsDesc" id="PartsDesc" type="checkbox" onClick="PrintChecked(this);"/>Description</div>
		<div><input name="PartsQty" id="PartsQty" type="checkbox" onClick="PrintChecked(this);"/>Qty</div>
		<div><input name="PartsPricing" id="PartsPricing" type="checkbox" onClick="PrintChecked(this);"/>Pricing</div>
		<div><input name="PartsTotal" id="PartsTotal" type="checkbox" onClick="PrintChecked(this);"/>Parts Total</div>
		<hr/>
	<div class="PrintSetupHeader">Labor</div>
		<div><input name="LaborDesc" id="LaborDesc" type="checkbox" onClick="PrintChecked(this);"/>Description</div>
		<div><input name="LaborQty" id="LaborQty" type="checkbox" onClick="PrintChecked(this);"/>Qty</div>
		<div><input name="LaborPricing" id="LaborPricing" type="checkbox" onClick="PrintChecked(this);"/>Pricing</div>
		<div><input name="LaborTotal" id="LaborTotal" type="checkbox" onClick="PrintChecked(this);"/>Labor Total</div  --> 
                
				<!--  div style="height:200px; width:98%;"></div  -->  
	</div>

	<div id="PrintBoxR" class="PrintBoxR">
		<hr/><div class="PrintSetupHeader">PROPOSAL CREATION</div><hr/>
		
		<div class="PrintTopBox">
			<div class="PrintTopBoxL">
				<div class="PrintSetupTitles">Letter Title</div>
				<div class="PrintSetupTextInput"><input name="LetterTitle" id="LetterTitle"type="text" value="Proposal" onKeyUp="UpdateText('LetterTitle','Text','ProjectPrint','ProjectID','LetterTitle');"/></div>
				<div class="PrintSetupTitles">Scope Title</div>
				<div class="PrintSetupTextInput"><input name="ScopeTitle" id="ScopeTitle" type="text" value="Scope Of Work"  onKeyUp="UpdateText('ScopeTitle','Text','ProjectPrint','ProjectID','ScopeTitle');"/></div>
				<div class="PrintSetupTitles">Parts Page Title</div>
				<div class="PrintSetupTextInput"><input name="PartsTitle" id="PartsTitle" type="text" value="Parts"  onKeyUp="UpdateText('PartsTitle','Text','ProjectPrint','ProjectID','PartsTitle');"/></div>
				<div class="PrintSetupTitles">Labor Page Title</div>
				<div class="PrintSetupTextInput"><input name="LaborTitle" id="LaborTitle" type="text" value="Labor"  onKeyUp="UpdateText('LaborTitle','Text','ProjectPrint','ProjectID','LaborTitle');"/></div>
			</div>
				
		<div class="PrintTopBoxR">
			<div class="PrintSetupTitles">Signed By Tricom</div>
				<div class="PrintSetupTextInput"><input name="SignedTCS" id="SignedTCS" type="text" value="Tricom"  onKeyUp="UpdateText('SignedTCS','Text','ProjectPrint','ProjectID','SignedTCS');"/></div>
				<div class="PrintSetupTitles">Signed By Customer</div>
				<div class="PrintSetupTextInput"><input name="SignedCust" id="SignedCust" type="text" value="Customer" onKeyUp="UpdateText('SignedCust','Text','ProjectPrint','ProjectID','SignedCust');" /></div>
				<div class="PrintSetupTitles">Date</div>
				<div class="PrintSetupTextInput">
					<input name="PrintDate" id="PrintDate" type="text" value="" onChange="UpdateText('PrintDate','Text','ProjectPrint','ProjectID','PrintDate');"/>
					<img style="cursor:pointer;"onclick="displayCalendar('PrintDate','mm/dd/yyyy',this)" src="../../LMCManagement/Images/cal.gif" width="16" height="16">				</div>
			</div>
		</div><br/><br/><br/><br/><br/><br/><br/><br/><br/>

		<div id="AddressingBox" class="PrintSetupTitles">
			<div class="PrintSetupTitles">Addressing</div>
			<div class="PrintSetupTextInput"><input name="Addressing" id="Addressing" type="text" value="Dear Sir,"  onKeyUp="UpdateText('Addressing','Text','ProjectPrint','ProjectID','Addressing');"/></div>
		</div><br/><br/><br/>
		<div class="PrintSetupTitles">Body Of Letter</div>
		<textarea id="Body" class="PrintSetupTextBox" rows="8" onKeyUp="UpdateText('Body','Text','ProjectPrint','ProjectID','Body');" ></textarea>
		<div class="PrintSetupTitles">Legal Notes</div>
		<textarea id="LegalNotes" class="PrintSetupTextBox" rows="4" onKeyUp="UpdateText('LegalNotes','Text','ProjectPrint','ProjectID','LegalNotes');"></textarea>
		<!--  div class="PrintSetupTitles">Parts Page Note</div>
		<div> <textarea name="PartsNotes" id="PartsNotes" class="PrintSetupTextBox" rows="4"  onKeyUp="UpdateText('PartsNotes','Text','ProjectPrint','ProjectID','PartsNotes');"></textarea></div>
		<div class="PrintSetupTitles">Labor Page Note</div>
		<div> <textarea name="LaborNotes" id="LaborNotes" class="PrintSetupTextBox" rows="4"  onKeyUp="UpdateText('LaborNotes','Text','ProjectPrint','ProjectID','LaborNotes');"></textarea></div  --> 
		
		
								
		<div class="PrintTopBox">
			<a href="Javascript:Void()" onClick="OpenPrintMain()">Print Estimate</a>
			&nbsp;&nbsp;
			<a href="Javascript:Void()" onClick="OpenPrintPartsLabor('Part')">Print Parts</a>
			&nbsp;&nbsp;
			<a href="Javascript:Void()" onClick="OpenPrintPartsLabor('Labor')">Print Labor</a>
			&nbsp;&nbsp;
			<a href="Javascript:Void()" onClick="OpenPrintExpenses()">Print Expenses</a>
			&nbsp;&nbsp;
			<label style="float:right;"><input id=ckPrintCost type="checkbox" checked />Print Parts/Labor Costs</label>
		</div>
	</div>
</div><!-- End Print++++++++++++++++++++++++++++++++++++++++++TAB --> 
    
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
    
<div id="ProjSysBox" class="SystemContainer">

<!-- Systems+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --> 
<div id="EstimateMain" class="SystemContainer" style="background:#DDEFCB; overflow:visible;">

	<div id="SystemOverlay" class="SystemOverlay">
		<div id="SystemOverlayTxt" class="SystemOverlayTxt">1234</div>
			<br/>
			<br/>
			<br/>
			<br/>
		<img name="" src="../../LMCManagement/Images/Roller.gif" width="32" height="32" alt="" />	</div>

	<div class="SysTabsBox">
		<div id="InfoTab" onClick="ShowSysTab(this.id)" class="SystemTab1" onMouseOver="MouseOverTab(this.id)" onMouseOut="MouseOutTab(this.id)">Information</div>
		<div id="PartsTab" onClick="ShowSysTab(this.id); PartsList(SelectedSysID);" class="SystemTab2" onMouseOver="MouseOverTab(this.id)" onMouseOut="MouseOutTab(this.id)">Materials</div>
		<div id="LaborTab" onClick="ShowSysTab(this.id); LaborList(SelectedSysID);" class="SystemTab2" onMouseOver="MouseOverTab(this.id)" onMouseOut="MouseOutTab(this.id)">Labor</div>
		<div id="ExpensesTab" onClick="ShowSysTab(this.id)" class="SystemTab2" onMouseOver="MouseOverTab(this.id)" onMouseOut="MouseOutTab(this.id)">Expenses</div>
		<div id="AltsTab" onClick="ShowSysTab(this.id)" class="SystemTab2" onMouseOver="MouseOverTab(this.id)" onMouseOut="MouseOutTab(this.id)">Add-Alts</div>
		<label id=Contract style="position:relative; top:8px; left:8px;" draggable=true><input id=ckContract type=checkbox onChange=Contract(this.checked);>Contract Signed</label>
		
		<div id="SysTotal" class="Total" style="font-family:Consolas, 'Courier New', Courier, monospace; font-size:24px; float:right;"></div>
	</div>
	
	<div class="SysTabsBottom"></div>
    

<div id="SystemLock" class="SystemLock" onClick="alert('This system is under contract.')"></div>

<div id="InfoBox" class="SystemInput Graydient"><!-- The System Information Tab- - - - - - - - - - - - - - - - - - - - - - - - - --> 
	<iframe id="SysInfoFrame" src="" width="100%" height="99%;" frameborder="0"></iframe>
</div>
 <!-- END INFO TAB////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->    
   
   
   
   
    
    
    
    
    
    
    
<!-- BEGIN PARTS TAB////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --> 

<div id="PartsBox" class="" >
	
	<!-- <div id="ProjectLock3" class="ProjectLock3"></div> -->
	
	<div class="PartsTabContainer">
		
		<div class="PartsTabTop">
			<div class="PartsTabTopP">
				<a class="PartsTabTopLink" href="javascript:Void();" onClick="ShowAddPartModal();" >Add Materials</a>
				&nbsp;&nbsp;
				<a class="PartsTabTopLink" href="javascript:Void();" onClick="AddBlankPart();" >Add Blank</a>
				&nbsp;&nbsp;
				<a class="PartsTabTopLink" href="javascript:Void();" onClick="DeleteItems('PartsList');" >Delete</a>			</div>
		</div>
			
		<div id="PartsTabMainTop" class="PartsTabMainTop">
			<div class="PartsItemsHead">
				<div class="PartsItemsHeadTxt" style="width:6%;">Select</div>
				<div class="PartsItemsHeadTxt" style="width:3%;"> <!-- Lab --></div> 
				<div class="PartsItemsHeadTxt" style="width:5%;">Qty</div>  
				<div class="PartsItemsHeadTxt" style="width:10%;">Manufacturer</div>  
				<div class="PartsItemsHeadTxt" style="width:10%;">Part Number</div>  
				<div class="PartsItemsHeadTxt" style="width:53%;">Descrition</div>  
				<div class="PartsItemsHeadTxt" style="width:7%;">Cost Each</div>  
				<div class="PartsItemsHeadTxt" style="width:8%;">Cost Subtotal</div>
				<!--  
				<div class="PartsItemsHeadTxt" style="width:7%;">Sell Ea</div>  
				<div class="PartsItemsHeadTxt" style="width:9%;">Sell Sub</div>
				-->
			</div>
		</div>
		<div id="PartsTabMain" class="PartsTabMain"></div>
	</div>
</div>



<!-- BEGIN LABOR TAB////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --> 

			<div id="LaborBox" class="LaborTabContainer">
				<!-- <div id="ProjectLock3" class="ProjectLock3"></div> -->
				
				<div class="LaborTabTop">
				
					<a class="LaborTabTopLink" href="javascript:Void(0);" onClick="ShowAddLaborModal();" >Add Labor</a>
					&nbsp;&nbsp;
					<a class="LaborTabTopLink" href="javascript:Void(0);" onClick="AddBlankLabor();" >Add Blank Labor</a>
					&nbsp;&nbsp;
					<a class="LaborTabTopLink" href="javascript:Void(0);" onClick="DeleteItems('LaborList');" >Delete</a>				</div>
				
				
				<div id="LaborTabMainTop" class="LaborTabMainTop">
				
					<div class="LaborItemsHead">
					<div class="LaborItemsHeadTxt" style="width:3%;">Sel</div> 
					<div class="LaborItemsHeadTxt" style="width:5%;">Qty</div> 
					<div class="LaborItemsHeadTxt" style="width:15%;">Labor</div>  
					<div class="LaborItemsHeadTxt" style="width:61%;">Descrition</div>  
					<div class="LaborItemsHeadTxt" style="width:7%;">Cost Ea</div>  
					<div class="LaborItemsHeadTxt" style="width:8%;">Cost Sub</div>
					<!--  
					<div class="LaborItemsHeadTxt" style="width:7%;">Sell Ea</div>  
					<div class="LaborItemsHeadTxt" style="width:9%;">Sell Sub</div>  
					-->
				</div>
			</div>
			
			<div id="LaborTabMain" class="LaborTabMain">            </div>
</div>

<div id="ExpensesBox" class="">
	<!-- <div id="ProjectLock5" class="ProjectLock5"></div> -->
  <iframe id="SysExpFrame" style="width:100%; height:100%;" frameborder="0"></iframe>
</div>    

<div id="AltsBox" class="">
	<!-- <div id="ProjectLock4" class="ProjectLock4"></div> -->
  <iframe id="SysAltsFrame" style="width:100%; height:100%;" frameborder="0"></iframe>
</div>    


</div>  
</div>
</div>
</div>

<!--  End Right Container=================================================================================================================End Right Container>
<!- -  - - - End Right Container=================================================================================================================End Right Container --> 
</div>
<!--  - - - End Right Container Container=====================================================================================End Right Container Container  --> 
</div>
 
 
 
 

<div id="AddPartContainer" class="AddPartContainer"> 
	<div id="AddPartTitle" class="AddPartTitle" onmousedown="PartsMouseDown(event)" onmouseup="PartsMouseUp(event)" onMouseMove="ModalMouseMove(event,'AddPartContainer')" onselectstart="return false;" >PARTS LIST SEARCH</div>
	<iframe id="AddPartBox" class="AddPartBox" src="../PartsInterface.asp?BoxID=AddPartContainer&ModalID=AddPartModal&MM=parent.PartsMouseMove(event,'AddPartContainer')&MD=parent.PartsMouseDown(event)&MU=parent.PartsMouseUp(event)"></iframe>
	
</div>











<div id="AddLaborContainer" class="AddLaborContainer"> 
    
    <div id="AddLaborBox" class="AddLaborBox">
     
        <div id="AddLaborBoxTitle" class="AddLaborBoxTitle">LABOR SEARCH</div>
        <div id="AddLaborBoxSearch" class="AddLaborBoxSearch">
       	    <div id="AddLaborBoxClose" class="AddLaborBoxClose" onClick="HideAddLaborModal();"><button>Close</button></div>
            <input onClick="javascript:SearchLabor('Description');"name="SearchLaborDescBtn" id="SearchLaborDescBtn"  class="AddLaborBoxSearchBtn" type="button" value="Description" />
            <input onClick="javascript:SearchLabor('Category');"name="SearchLaborSystemBtn" id="SearchLaborSystemBtn"  class="AddLaborBoxSearchBtn" type="button" value="Category" />
            <input onClick="javascript:SearchLabor('Name');"name="SearchLaborNameBtn" id="SearchLaborNameBtn"  class="AddLaborBoxSearchBtn" type="button" value="Name" />
            <div class="AddLaborBoxSearchTxt"><input name="SearchLaborTxt" id="SearchLaborTxt"type="text" size="12" maxlength="12" /></div>
        </div>
        <div id="AddLaborBoxScroll" class="AddLaborBoxScroll">Labor</div>
    </div> 
</div>





<div class="NewProjBox" id="NewProjBox">

	<div class="NewProjLTop">
		<br/>
		<div class="NewProjLTxt"><big>Project Name*:</big></div><br>
		<br/>
		<!-- 
		<div class="NewProjLTxt"> Customer<b>:</b></div>
		 -->
		<br/>
	</div>

	<div class="NewProjRTop">
		<br/>
		<input class="NewProjRTxt" id="NewProjName" maxlength="49" style="height:22px; font-size:16px; margin:2px 0 0 0;"	type="text" />
		<br />&nbsp;
		<br />&nbsp;
		<!-- 
		<input class="NewProjRTxt" id="NewProjCustomer" type="text" readonly="readonly" onFocus="NewProjCustListToggle();" /><input id="NewProjCustID" type="hidden" />
		<button id="NewProjCustListBtn" style="height:20px; width:20px;" onClick="NewProjCustListToggle();"><b>...</b></button>
		 -->
		<br />&nbsp;
		<br />&nbsp;
		<br />
	</div>
	
	
	<div class = "NewProjLBottom">
		<br/>
		<br/>
		<br/>
		<div class="NewProjLTxt"> Address<b>:</b></div>
		<br/>
		<div class="NewProjLTxt"> City<b>:</b></div>
		<br/>
		<div class="NewProjLTxt"> State*<b>:</b></div>
		<br/>
		<div class="NewProjLTxt"> Zip<b>:</b></div>
		<br/>
		<br /><br />
		<div class="NewProjLTxt"> Sq. Footage<b>:</b></div>
		<br/>
		<div class="NewProjLTxt"> # of Floors*<b>:</b></div>
		<br/>
		<div class="NewProjLTxt"> Area*<b>:</b></div>
		<br/>
		<div class="NewProjLTxt"> Franchise*<b>:</b></div>
		<br/>
		<div class="NewProjLTxt"> Subsidiary Of<b>:</b></div>
	<br/>	</div>

	<div class="NewProjRBottom">
		<br/>
		<br/>
		<br/>
		<div><input class="NewProjRTxt" id="NewProjAddress"	style="margin-bottom:2px;" type="text" />
		</div><br/>
		<div><input class="NewProjRTxt" id="NewProjCity" 	 	style="margin-bottom:2px;" type="text" />
		</div><br/>
		<div><input class="NewProjRTxt" id="NewProjState"  	style="margin-bottom:2px;" type="text" maxlength="2" />
		</div><br/>
		<div><input class="NewProjRTxt" id="NewProjZip"			style="margin-bottom:2px;" type="text" onBlur="OldTxt[this.id]=null;" onKeyUp="CheckZip(event,this)"/>
		</div><small><small><br/><br/></small></small>
		
		<br />
		<input class="NewProjRTxt" id="NewProjSqFoot" style="margin-bottom:2px;" type="text" />
		<br/>
		<input class="NewProjRTxt" id="NewProjFloors" style="margin-bottom:2px;" type="text" />
		<br/>
		<select class="NewProjRDrop" id="NewProjArea" style="margin-bottom:2px;" onChange="Gebi('AreaSearch').selectedIndex =this.selectedIndex; LoadAreaProj();"></select>
		<br/>
		<select class="NewProjRDrop" id="NewProjFran" style="margin-bottom:2px;" onChange="NewProjUpdateSubOf();"></select>
		<br/>
		<input class="NewProjRTxt" id="NewProjSubOf" style="margin-bottom:2px;" type="text" value="-NONE-" readonly />
	</div>

	<div class = "NewProjBottomL">
		<div class="NewProjButtonL"><button id="NewProjCancel" value="Cancel" onClick="CloseNewProjBox();">Cancel</button></div>
	</div>
	
	<div class = "NewProjBottomC">
		<div align="center" style="width:99%; height:16px; float:left;"><small>*=required.</small></div>
	</div>
	
	<div class = "NewProjBottomR">
		<div class="NewProjButtonR"><input id="NewProjSave" name="NewProjSave" value="Save" type="button" onClick="NewProjSave();" /></div>
	</div>
</div>
<div id="NewProjSearch" name="NewProjSearch" class="NewProjBox" style="z-index:303000">
	<div style="margin:1.5% .5% 1.5% 1.5%;">
		Search:
		<div><input id="NewProjCustSearch" name="NewProjCustSearch" type="text" onKeyUp="GetCustomerForNewProj();" style="width:100%;" /></div>
	</div>
	<div id="NewProjCustList" name="NewProjCustList" class="NewProjCustList"></div>
</div>



<div id="BidToCustBox" class="BidToCustBox">
	<div align="center" ><h3><br />Choose a customer to bid for:</div>
	<div style="margin-left:3%;"><small>Search:</small></div>
	<input id="BidToCustomerSearchText" type="text" onKeyUp="GetCustomerForBidTo();" style="width:93%; background:#F5F8F3; margin:0px 4% 5px 3%;" />
	<div id="BidToCustSearchList" class="BidToCustomerSearchList"></div>
	<button onClick="BidToAddClose();" style="float:left; margin:12px 0px 0px 3%;">Cancel</button>
</div>



<div id="ObtainBidBox" class="ObtainBidBox">
	<div id="" class="NewSystemHead">Contract Signed</div>
	<hr/>
	
	<div style="width:100%; float:left; clear:both;">Job Obtained With:</div>
	<div id="ObtainWithContainer"></div>
	<div style="text-align:center;">
		<div style="float:left; width:128px;">on <input id="ObtainDate" type="text" style="width:80%;" /></div>
		<div style="float:left; margin-top:3px; height:20px;">
			<img style="cursor:pointer; float:right" onClick="displayCalendar('ObtainDate','mm/dd/yyyy',this);" src="../../LMCManagement/Images/cal.gif" width="16" height="16">
		</div>
	</div><!--
	<hr/>
	<div style="width:100%"><div style="width:70%; left:15%; font-size:12px; position:relative;">WARNING - Bid becomes uneditable upon activation.</div></div>
	 -->
	<hr style="width:100%; float:left; margin-left:0;" />
	<div id="" class="" style="position:relative; width:100%; text-align:center; float:left;">
		<!-- 
		<button class="" style="float:left;" onClick="CloseObtainBidModal();">Cancel</button>
		 -->
		<button class="" style="float:none;" onClick="ObtainBid();">Activate</button>
	</div>
</div>

 
 
    
</div><!-- End OveralDiv$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ --> 

<div class="ObtainModal" id="ObtainModal"></div>
<div class="NewProjModal" id="NewProjModal"></div>
<div id="AddLaborModal" class="AddLaborModal"></div>
<div id="AddPartModal" class="AddPartModal" onMouseMove="ModalMouseMove(event,'AddPartContainer');"></div>
<div id="SystemModal" class="ObtainModal"></div>

</body>
</html>