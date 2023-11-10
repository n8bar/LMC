<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>LMC Contacts</title>
	<!--#include file="Common.asp" -->
	<script type="text/javascript" src="Contacts/Contacts_JS.js"></script>
	<script type="text/javascript" src="Contacts/Contacts_AJAX.js"></script>
	<script type="text/javascript" src="Library/dhtmlgoodies_calendar.js?random=20060118"></script>
	
	<link rel="stylesheet" href="Library/ListsCommon.css" media="all">
	<link rel="stylesheet" href="Contacts/Contacts_CSS.css" media="screen" />
	<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?random=20051112" media="screen" />
</head>
<body onmousemove="parent.ResetLogoutTimer();" onkeyup="parent.ResetLogoutTimer();" >

<div id="ContactsModal" class="ContactsModal"></div>
    
<div id="ContactsModalBox" class="ContactsModalBox">
	<div id="CMBLeft" class="CMBLeft"><br />
		<div class=CMBLabelL> Company Name: </div><div class=CMBLabelR><input id=txtName type=text width=200 maxlength=50 /> </div><br />
		<div class=CMBLabelL> Address: </div><div class=CMBLabelR><input id=txtAddress	 type=text width=200 maxlength=50 /> </div><br />
		<div class=CMBLabelL> City: </div><div class=CMBLabelR><input id=txtCity 				 type=text width=200 maxlength=50 /> </div><br />
		<div class=CMBLabelL> State: </div><div class=CMBLabelR><input id=txtState 			 type=text width=200 maxlength=50 /> </div><br />
		<div class=CMBLabelL> Zip: </div><div class=CMBLabelR><input id=txtZip 					 type=text width=200 maxlength=10 /> </div><br />
		<div class=CMBLabelL> Phone 1: </div><div class=CMBLabelR><input id=txtPhone1		 type=text width=200 maxlength=50 /> </div><br />
		<div class=CMBLabelL> Phone 2: </div><div class=CMBLabelR><input id=txtPhone2		 type=text width=200 maxlength=50 /> </div><br />
		<div class=CMBLabelL> Fax: </div><div class=CMBLabelR><input id=txtFax					 type=text width=200 maxlength=50 /> </div><br />
		<div class=CMBLabelL> Email: </div><div class=CMBLabelR><input id=txtEmail			 type=text width=200 maxlength=75 /> </div><br />
		<label class=CMBLabelRow>Website: <div class=CMBLabelR><input id=txtWebsite type=text width=200 maxlength=50 /></div></label><br/>
		<!-- label class=CMBLabelRow>Tax Rate: <div class=CMBLabelR><input id=txtTax		type=text width=200 maxlength=50 /></div></label><br />
		<label class=CMBLabelRow>Markup: <div class=CMBLabelR><input id=txtMU			type=text width=200 maxlength=50 /></div></label><br / -->
		<div class=CMBLabelL> Notes: </div><div class=CMBLabelR><textarea id=txtNotes 	type=text columns=190 rows=8 maxlength=50 ></textarea></div><br />
	</div>
		
	<div id="CMBCenter" class="CMBCenter"><br />
		<div class=CMBLabelL style="color:#888;">Rep1 Name:</div><div class=CMBLabelR><input id=txtContact1 type=text width=200 maxlength=50 disabled /></div><br/>
		<div class=CMBLabelL style="color:#888;">Rep1 Phone:</div><div class=CMBLabelR><input id=txtCphone1 type=text width=200 maxlength=50 disabled /></div><br/>
		<div class=CMBLabelL style="color:#888;">Rep1 Email:</div><div class=CMBLabelR><input id=txtEmail1 type=text width=200 maxlength=50 disabled /></div><br />
		<div class=CMBLabelL style="color:#888;">Rep2 Name:</div><div class=CMBLabelR><input id=txtContact2 type=text width=200 maxlength=50 disabled /></div><br/>
		<div class=CMBLabelL style="color:#888;">Rep2 Phone:</div><div class=CMBLabelR><input id=txtCphone2 type=text width=200 maxlength=50 disabled /></div><br/>
		<div class=CMBLabelL style="color:#888;">Rep2 Email:</div><div class=CMBLabelR><input id=txtEmail2 type=text width=200 maxlength=50 disabled /></div><br />
		<div class="CMBLabelRow taLi">Linked Contacts</div>
		<div class=" h192 " style="border: 1px solid #555; overflow:auto; padding:5px 0 0 0; ">
		</div>
	</div>
	
	<div id="CMBRight" class="CMBRight"><br />
		<div style="display:none;" ><input id=txtCustomer type=text maxlength=6 /></div>
		<div style="display:none;" ><input id=txtVendor type=text maxlength=6 /></div>
		<div style="display:none;" ><input id=txtHuman type=text maxlength=6 /></div>
		<div style="display:none;" ><input id=txtBusiness type=text maxlength=6 /></div>
		<div class="CMBLabelRow taLi">Entity type:</div>
		<label class="CMBLabelRow taLi">
			&nbsp; &nbsp;<input id=chkBusiness onClick="chkHuman.checked=!this.checked; CBHumBiz();" type=checkbox width=200 /> Business
		</label>
		<label class="CMBLabelRow taLi">
			&nbsp; &nbsp;<input id=chkHuman onClick="chkBusiness.checked=!this.checked; CBHumBiz();" type=checkbox width=200/ > Individual
		</label>
		<div class="CMBLabelRow taLi">Contact type:</div>
		<label class="CMBLabelRow taLi">&nbsp; &nbsp;<input id=chkCustomer onClick=CBCust(); type=checkbox width=200 /> Customer</label>
		<label class="CMBLabelRow taLi">&nbsp; &nbsp;<input id=chkVendor onClick=CBVend(); type=checkbox width=200 /> Vendor</label>
		<div id=cTypeBox class=" h224 " style="border: 1px solid #555; overflow:auto; padding:5px 0 0 0; ">
			<small style="width:100%; line-height:8px;"><b>Note:</b> The following update<br/> immediately and don't work for<br/> new contacts yet. To set for new<br/> ones, just re-open after saving.</small>
			<%
			Set cTypeRS=Server.CreateObject("ADODB.RecordSet")
			cTypeRS.Open "SELECT * FROM ContactTypes ORDER BY Type", RedConnString
			ctCount=0
			ctIdList=""
			Do Until cTypeRS.EOF
				ctCount=ctCount+1
				%><label class="CMBLabelRow taLi">&nbsp;<input id=chkCType<%=cTypeRS("ID")%> onClick="cTypeSet(0<%=cTypeRS("ID")%>);" type=checkbox width=200 /> <%=cTypeRS("Type")%></label><%
				cTypeRS.MoveNext
			Loop
			%>
			<script> var ctCount=0<%=ctCount%>;</script>
		</div>
	</div>
	
	<div style="float:left; width:50%; height:8%;">
		<input style="margin:0 0 0 10px;" id=ContactDel type=button onClick=ContactDel(); value="Delete Contact" />
	</div>
	<div style="float:right; width:88px; height:8%;"><input class=ContactSave id=ContactSave value=Save type=button onClick=SaveContact(); />
		<input id=ContactUpdate value=Update type=button onClick=ContactUpdate(); />
	</div>
	<div style="float:right; height:8%;"> &nbsp; <input type="button" onClick="ContactsModalClose();" value="Cancel" /></div>
</div>  

	<div class=ContactsCenterTitle>
		<span id=Title onDblClick="location='Contacts.asp';" title="New contacts page coming soon!  Double click to check progress!!">Contacts</span>
		<button id=ReloadFrame onClick=noCacheReload(); ><img src="../images/reloadblue24.png" width="100%" height="100%"/></button>
  </div>
	
	<div class="ContactsCenter">
		<div class="ContactsCenterTop">
     	Search
			<input id=SearchContactsTxt name=SearchContactsTxt type=text size=20 maxlength=20 onKeyUp=SearchContacts(); />
			<select  id="ContactTypeSelect" name="ContactTypeSelect" size="">
				<option value="All" Selected >All</option>
				<option value="Customer" >Customers</option>
				<option value="Vendor" >Vendors</option>
			</select>
			&nbsp;
			<button class="ContactsButtons" onClick="AddContact();">Add New</button>
		</div>
    
		<div id="Header">
			<div style="width:2.5%;" >&nbsp;</div>
			<div style="width:22.5%;" ><big>Name</big></div>
			<div style="width:30%;" >Address</div>
			<div style="width:11%;" >Phone</div>
			<div style="width:11%;" >Fax</div>
			<div style="width:12%;" ><big>Contact</big></div>
			<div style="width:11%;" >Phone</div>
		</div>
    <div id="List"></div>
  </div>
  
  
</body>
</html>