// JavaScript Document   AJAX CONTROLS

var xhr
var HttpText ='';
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function getXHRObject(){
	var xhr=false;
	try {	xhr=new XMLHttpRequest();	}// Firefox, Opera 8.0+, Safari
	catch (e) {	// Internet Explorer
		try {	xhr=new ActiveXObject("Msxml2.XMLHTTP");	}
		catch (e) {	xhr=new ActiveXObject("Microsoft.XMLHTTP");	}
	}
	
	if (!xhr) alert ("Your browser does not support AJAX!");
	
	return xhr;
}
//------------------------------------------------------------------------------------------------



function AddPart(PartID) {
	var sysId = Gebi("SysPage").contentWindow.sysId;

	HttpText='BidASP.asp?action=AddPart&PartID='+PartID+'&SysID='+sysId+'&costing=1';
	xhr = getXHRObject();
	xhr.onreadystatechange = ReturnAddPart;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}
function AddBlankPart() {
	var sysId = Gebi("SysPage").contentWindow.sysId;
	HttpText='BidASP.asp?action=AddPart&PartID=0&SysID='+sysId+'&costing=1';
	xhr = getXHRObject();
	xhr.onreadystatechange = ReturnAddPart;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}
function ReturnAddPart() {
	if (xhr.readyState == 4) {
		if (xhr.status == 200) {
			//AjaxErr('Looking at Addpart.',HttpText);
			try { var xmlDoc = xhr.responseXML.documentElement; }
			catch(e) { AjaxErr('There was an issue with the AddPart response.',HttpText); }
			//var ProjID = xmlDoc.getElementsByTagName("ProjID")[0].childNodes[0].nodeValue;
			var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
			
			//Gebi('PartsTabMain').innerHTML += ProjID;
			PartsList(SysID);
		}
		else {
			AjaxErr('There was a problem with the AddPart request. Continue?',HttpText);
		}
	}
}


function AddLabor(LaborID) {
	var sysId = Gebi("SysPage").contentWindow.sysId;

	HttpText='BidASP.asp?action=AddLabor&LaborID='+LaborID+'&SysID='+sysId+'&costing=1';
	xhr = getXHRObject();
	xhr.onreadystatechange = ReturnAddLabor;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}
function AddBlankLabor() {
	var sysId = Gebi("SysPage").contentWindow.sysId;
	HttpText='BidASP.asp?action=AddLabor&SysID='+sysId+'&costing=1';
	xhr = getXHRObject();
	xhr.onreadystatechange = ReturnAddLabor
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}
function ReturnAddLabor() {
	if (xhr.readyState == 4) {
		if (xhr.status == 200) {
			try {
				var xmlDoc = xhr.responseXML.documentElement;
				var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
			}
			catch(e) { AjaxErr('There was a problem with the AddLabor response.',HttpText); }
			LaborList(SysID);
		}
		else {
			AjaxErr('There was a problem with the AddLabor request.',HttpText);
		}
	}
}

function AddExpense(Type,SubType,Origin,Dest,Units,Cost) {
	var sysId = Gebi("SysPage").contentWindow.sysId;
	//var MU = Gebi('SysExpFrame').contentWindow.document.getElementById("MU").value;
	
	//alert(sysId);
	SubType=CharsEncode(SubType);
	Origin=CharsEncode(Origin);
	Dest=CharsEncode(Dest);
	HttpText='BidASP.asp?action=AddExpense&Type='+Type+'&SubType='+SubType+'&Origin='+Origin+'&Dest='+Dest+'&Units='+Units+'&Cost='+Cost+'&SysID='+sysId+'&costing=1';
	xhr = getXHRObject();
	xhr.onreadystatechange = function () {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				
				try { var xmlDoc = xhr.responseXML.documentElement; }
				catch(e) {
					AjaxErr('There was a problem with the AddPart response!',HttpText);
				}
				//var ProjID = xmlDoc.getElementsByTagName("ProjID")[0].childNodes[0].nodeValue;
				var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
				
				ExpenseLists(SysID);
			}
			else {
				AjaxErr('There was a problem with the AddPart request. Continue?',HttpText);
			}
		}
	}
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}


function AllLists(sysId) {
	PartsList(sysId);
	LaborList(sysId);
	TravelList(sysId);
	EquipList(sysId);
	OtherList(sysId);
}

function PartsList(sysId) {
	HttpText='BidASP.asp?Action=PartsList&SysID='+Gebi("SysPage").contentWindow.sysId;
	xhr=getXHRObject();
	xhr.onreadystatechange=function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				
				try	{	var xmlDoc = xhr.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the PartsList response.',HttpText);	
					return false;
				}
				
				var recordCount = xmlDoc.getElementsByTagName("recordCount")[0].childNodes[0].nodeValue;
				
				var MU=(xmlDoc.getElementsByTagName("MU")[0].childNodes[0].nodeValue*1);
				var M=1+(MU/100);
				var partListDiv=Gebi('SysPage').contentWindow.document.getElementById('BidSystemsParts')
				partListDiv.innerHTML='';
				
				var BidItemsID;
				var Qty;
				var Manufacturer;
				var ItemName;
				var ItemDescription;
				var Cost;
				var Sell
				var editable;
				
				var partsHTML=''
				var rowHTML;
				var pRow=100000;
				var partsTotal=0;
				var aPartsTotal=0;
				//alert(recordCount);
				for(r=1;r<=recordCount;r++)	{
					
					BidItemsID=xmlDoc.getElementsByTagName('BidItemsID'+r)[0].childNodes[0].nodeValue;
					Qty=xmlDoc.getElementsByTagName('Qty'+r)[0].childNodes[0].nodeValue;
					ActualQty=xmlDoc.getElementsByTagName('ActualQty'+r)[0].childNodes[0].nodeValue;
					Mfg=xmlDoc.getElementsByTagName('Manufacturer'+r)[0].childNodes[0].nodeValue.replace('--','');
					PN=xmlDoc.getElementsByTagName('ItemName'+r)[0].childNodes[0].nodeValue.replace('--','');
					Desc=CharsDecode(xmlDoc.getElementsByTagName('ItemDescription'+r)[0].childNodes[0].nodeValue.replace('--',''));
					Cost=xmlDoc.getElementsByTagName('Cost'+r)[0].childNodes[0].nodeValue;
					CostDiff=xmlDoc.getElementsByTagName('CostDiff'+r)[0].childNodes[0].nodeValue;
					aCost=Cost-CostDiff;
					editable=(xmlDoc.getElementsByTagName('editable'+r)[0].childNodes[0].nodeValue=='True');
					
					var color='';
					if(Qty!=0 && ActualQty==0) { color='color:#C00;'; } else { color=''; }
					
					pRow++;
					var checkbox='<img align=absmiddle src="../../Images/padlock-gray.png" height=16 width=16 style="margin:auto;" />';
					if (editable) checkbox='<input id=pSel'+pRow+' class=partCheckbox type=checkbox style="width:100%;" />';
					rowHTML='';
					rowHTML+='<div id=pRow'+pRow+' class="ProjInfoListRow" style="'+color+' ">';
					rowHTML+='		<div id=Part-BidItemsID'+pRow+' style="display:none">'+BidItemsID+'</div>';
					rowHTML+='	<div style="width:3%; " align="center">'+checkbox+'</div>';
					rowHTML+='	<div style="width:3%; "><div id=Part-Edit'+pRow+' class=rowEdit onClick="editPart('+pRow+');"></div></div>';
					rowHTML+='	<div style="width:5%; " class=taRPi id=Part-Qty'+pRow+' >'+Qty+'</div>';
					rowHTML+='	<div style="width:5%; " class=taRPi id=Part-ActualQty'+pRow+' onKeyUp=updatePartRow('+pRow+');>'+ActualQty+'</div>';
					rowHTML+='	<div style="width:9%; " class=taLPi id=Part-Manufacturer'+pRow+'>'+Mfg+'</div>';
					rowHTML+='	<div style="width:12%; " class=taLPi id=Part-PartNumber'+pRow+'>'+PN+'</div>';
					rowHTML+='	<div style="width:28%;  text-align:left;" class=taLPi id=Part-ItemDescription'+pRow+'>'+Desc+'</div>';
					rowHTML+='	<div style="width:8%; " class=taRPi id=Part-Cost'+pRow+' onKeyUp=updatePartRow('+pRow+');>'+formatCurrency(Cost)+'</div>';
					rowHTML+='	<div style="width:9%; " class=taRPi id=Part-Total'+pRow+'>'+formatCurrency(Cost*Qty)+'</div>';
					rowHTML+='	<div style="width:9%;" class=taRPi id=Part-Actual'+pRow+'>'+formatCurrency(Cost*ActualQty)+'</div>';

					var Diff=Cost*(Qty-ActualQty);
					dColor=" color:#0c0; ";
					if (Diff<0) dColor=" color:#f00; " ;
					if (Diff==0) dColor="" ;

					rowHTML+='		<div style="width:9%; font-weight:bold; '+dColor+'" class=taRPi id=Part-Diff'+pRow+'>'+formatCurrency(Diff)+'</div>';
					rowHTML+='	</div>';

					partsTotal+=(Cost*Qty);
					aPartsTotal+=(aCost*ActualQty);
					
					partsHTML+=rowHTML;
				}
				//alert(partsHTML);
				partListDiv.innerHTML=partsHTML;
				Gebi('SysPage').contentWindow.systemBudget(sysId);

				Gebi('SysPage').contentWindow.Gebi('TotalParts').innerHTML=formatCurrency(partsTotal);
			}
			else {
				AjaxErr('There was a problem with the PartsList request.\n'+xhr.readyState+'\n Continue?',HttpText);
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}


function LaborList(SysID) {
	HttpText='BidASP.asp?Action=LaborList&SysID='+Gebi("SysPage").contentWindow.sysId;
	xhr=getXHRObject();
	xhr.onreadystatechange=function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				
				try	{	var xmlDoc = xhr.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the LaborList response.',HttpText);	
					return false;
				}
				
				var recordCount = xmlDoc.getElementsByTagName("recordCount")[0].childNodes[0].nodeValue;
				
				var MU=(xmlDoc.getElementsByTagName("MU")[0].childNodes[0].nodeValue*1);
				var M=1+(MU/100);
				var laborListDiv=Gebi('SysPage').contentWindow.document.getElementById('BidSystemsLabor')
				laborListDiv.innerHTML='';
				
				var BidItemsID;
				var Qty;
				var ItemName;
				var ItemDescription;
				var Cost;
				var Sell
				var editable;
				
				var rowHTML;
				var lRow=100000;
				var laborTotal=0;
				for(r=1;r<=recordCount;r++)	{
					
					BidItemsID=xmlDoc.getElementsByTagName('BidItemsID'+r)[0].childNodes[0].nodeValue;
					Qty=xmlDoc.getElementsByTagName('Qty'+r)[0].childNodes[0].nodeValue;
					ItemName=CharsDecode(xmlDoc.getElementsByTagName('ItemName'+r)[0].childNodes[0].nodeValue);
					ItemDescription=CharsDecode(xmlDoc.getElementsByTagName('ItemDescription'+r)[0].childNodes[0].nodeValue);
					Cost=xmlDoc.getElementsByTagName('Cost'+r)[0].childNodes[0].nodeValue;
					editable=xmlDoc.getElementsByTagName('editable'+r)[0].childNodes[0].nodeValue;
					
					var color='';
					if(Qty!=0 && ActualQty==0) { color='color:#C00;'; } else { color=''; }
					lRow++;
					var checkbox='<img align=absmiddle src="../../Images/padlock-gray.png" height=16 width=16 style="margin:auto;" />';
					if (editable==1) checkbox='<input id=lSel'+lRow+' class=laborCheckbox type=checkbox style="width:100%;" />';
					rowHTML='';
					rowHTML+='<div id=lRow'+lRow+' class="ProjInfoListRow" style="'+color+' ">';
					rowHTML+='	<div id=Labor-BidItemsID'+lRow+' style="display:none;">'+lRS("BidItemsID")+'</div>';
					rowHTML+='	<div style="width:3%;" align="center">'+checkbox+'</div>';
					rowHTML+='	<div style="width:3%;"><div id=Labor-Edit'+lRow+' class=rowEdit onClick="editLabor('+lRow+');"></div></div>';
					rowHTML+='	<div style="width:4%;" class=taRPi id=Labor-Qty'+lRow+' onKeyUp=updateLaborRow('+lRow+');>'+lRS("Qty")+'</div>';
					rowHTML+='	<div style="width:4%;" class=taRPi id=Labor-ActualQty'+lRow+' onKeyUp=updateLaborRow('+lRow+');>'+lRS("ActualQty")+'</div>';
					rowHTML+='	<div style="width:17%;" class=taLPi id=Labor-ItemName'+lRow+'>'+ItemName+'</div>';
					rowHTML+='	<div style="width:42%;" text-align:left; text-overflow:ellipsis;" class=taLPi id=Labor-ItemDescription '+lRow+'>'+ItemDescription+'</div>';
					rowHTML+='	<div style="width:6%;" class=taRPi id=Labor-Cost'+lRow+' onKeyUp=updateLaborRow('+lRow+');>'+formatCurrency(Cost)+'</div>';
					rowHTML+='	<div style="width:7%;" class=taRPi id=Labor-Total'+lRow+'>'+formatCurrency(Cost*Qty)+'</div>';
					rowHTML+='	<div style="width:7%;" class=taRPi id=Labor-Total'+lRow+'>'+formatCurrency(Cost*ActualQty)+'</div>';
					rowHTML+='	<div style="width:7%;" class=taRPi id=Labor-Total'+lRow+'>'+formatCurrency((Cost*Qty)-(ActualQty))+'</div>';
					rowHTML+='</div>';

					laborListDiv.innerHTML+=rowHTML;
					Gebi('SysPage').contentWindow.systemBudget(Gebi('SysPage').contentWindow.sysId);
					
					Gebi('SysPage').contentWindow.Gebi('TotalLabor').innerHTML=formatCurrency(laborTotal);
				}
			}
			else { AjaxErr('There was a problem with the LaborList request.\n'+xhr.readyState+'\n Continue?',HttpText); }
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}


function TravelList(SysID) {
	HttpText='BidASP.asp?Action=ExpenseList&Type=Travel&SysID='+Gebi("SysPage").contentWindow.sysId;
	xhr=getXHRObject();
	xhr.onreadystatechange=function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				
				try	{	var xmlDoc = xhr.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the TravelList document.',HttpText);	
					return false;
				}
				//AjaxErr('See the TravelList response?',HttpText);
				
				var recordCount = xmlDoc.getElementsByTagName("recordCount")[0].childNodes[0].nodeValue;
				
				var travelListDiv=Gebi('SysPage').contentWindow.document.getElementById('BidSystemsTravel')
				travelListDiv.innerHTML='';

				var rowHTML;
				var tRow=100000;
				var travelTotal=0;
				for(r=1;r<=recordCount;r++)	{
					try	{	
						var ExpenseID=xmlDoc.getElementsByTagName('ExpenseID'+r)[0].childNodes[0].nodeValue;
						var SubType=CharsDecode(xmlDoc.getElementsByTagName('SubType'+r)[0].childNodes[0].nodeValue.replace('--',''));
						var Origin=CharsDecode(xmlDoc.getElementsByTagName('Origin'+r)[0].childNodes[0].nodeValue.replace('--',''));
						var Destination=CharsDecode(xmlDoc.getElementsByTagName('Destination'+r)[0].childNodes[0].nodeValue.replace('--',''));
						var Cost=xmlDoc.getElementsByTagName('UnitCost'+r)[0].childNodes[0].nodeValue;
						var Qty=xmlDoc.getElementsByTagName('Units'+r)[0].childNodes[0].nodeValue;
						var ActualQty=xmlDoc.getElementsByTagName('ActualUnits'+r)[0].childNodes[0].nodeValue;
						var Unit=xmlDoc.getElementsByTagName('Unit'+r)[0].childNodes[0].nodeValue.replace('--','');
						var editable=(xmlDoc.getElementsByTagName('editable'+r)[0].childNodes[0].nodeValue.replace('--','').toLowerCase()=='true');
					}
					catch(e)	{	
						AjaxErr('There was a problem with the TravelList response.',HttpText);	
						return false;
					}
					tRow++;
					rowHTML='';
					
					var checkbox='';
					if (!editable) { checkbox='<img align=absmiddle src="../../Images/padlock-gray.png" height=16 width=16 style="margin:auto;" />'; }
					else { checkbox='<input id=tSel'+tRow+' class=travelCheckbox type=checkbox style="width:100%;" />'; }
					 
					rowHTML+='<div id=tRow'+tRow+' class="ProjInfoListRow">';
					rowHTML+='	<div id=Travel-ExpenseID'+tRow+' style="display:none;">'+ExpenseID+'</div>';
					rowHTML+='	<div style="width:3%;" align="center">'+checkbox+'</div>';
					rowHTML+='	<div style="width:3%;"><div id=Travel-Edit'+tRow+' class=rowEdit onClick="editTravel('+tRow+');"></div></div>';
					rowHTML+='	<div style="width:6%;" id=Travel-SubType'+tRow+'>'+SubType+'</div>';
					rowHTML+='	<div style="width:20%; text-overflow:ellipsis;" class=taLPi id=Travel-Origin'+tRow+'>'+Origin+'</div>';
					rowHTML+='	<div style="width:20%; text-overflow:ellipsis;" class=taLPi id=Travel-Destination'+tRow+'>'+Destination+'</div>';
					rowHTML+='	<div style="width:9%;" class=taRPi id=Travel-Cost'+tRow+' onKeyUp=updateTravelRow('+tRow+');>'+formatCurrency(Cost)+'</div>';
					rowHTML+='	<div style="width:5%; text-align:right; padding:0 2px 0 0;" id=Travel-Qty'+tRow+' onKeyUp=updateTravelRow('+tRow+'); >'+Qty+'</div>';
					rowHTML+='	<div style="width:5%; text-align:right; padding:0 2px 0 0;" id=Travel-ActualQty'+tRow+' onKeyUp=updateTravelRow('+tRow+'); >'+ActualQty+'</div>';
					rowHTML+='	<div style="width:8%;" class=taLPi id=Travel-Unit'+tRow+' >'+Unit+'</div>';
					rowHTML+='	<div style="width:7%;" class=taRPi id=Travel-Total'+tRow+'>'+formatCurrency(Cost*Qty)+'</div>';
					rowHTML+='	<div style="width:7%;" class=taRPi id=Travel-Actual'+tRow+'>'+formatCurrency(Cost*ActualQty)+'</div>';
					rowHTML+='	<div style="width:7%;" class=taRPi id=Travel-Diff'+tRow+'>'+formatCurrency(Cost*(Qty-ActualQty))+'</div>';
					rowHTML+='</div>';

					travelTotal+=(Cost*Qty);

					travelListDiv.innerHTML+=rowHTML;
					Gebi('SysPage').contentWindow.systemBudget(Gebi('SysPage').contentWindow.sysId);

					Gebi('SysPage').contentWindow.Gebi('TotalTravel').innerHTML=formatCurrency(travelTotal);
				}
			}
			else {
				AjaxErr('There was a problem with the TravelList request.\n'+xhr.readyState+'\n Continue?',HttpText);
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}

function EquipList(SysID) {
	HttpText='BidASP.asp?Action=ExpenseList&Type=Equip&SysID='+Gebi("SysPage").contentWindow.sysId;
	xhr=getXHRObject();
	xhr.onreadystatechange=function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				
				
				try	{	var xmlDoc = xhr.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the EquipList response.',HttpText);	
					hideModal();
					return false;
				}
				//AjaxErr('See the EquipList response?',HttpText);
				
				var recordCount = xmlDoc.getElementsByTagName("recordCount")[0].childNodes[0].nodeValue;
				
				var equipListDiv=Gebi('SysPage').contentWindow.document.getElementById('BidSystemsEquipment')
				equipListDiv.innerHTML='';

				var rowHTML;
				var eRow=100000;
				var equipTotal=0;
				if(r<1) { hideModal(); return true; }
				for(r=1;r<=recordCount;r++)	{
					var field='';
					try	{
						field='ExpenseID'+r;
						var ExpenseID=xmlDoc.getElementsByTagName(field)[0].childNodes[0].nodeValue;
						field='Units'+r;
						var Qty=xmlDoc.getElementsByTagName(field)[0].childNodes[0].nodeValue;
						field='ActualUnits'+r;
						var ActualQty=xmlDoc.getElementsByTagName(field)[0].childNodes[0].nodeValue;
						field='SubType'+r;
						var SubType=xmlDoc.getElementsByTagName(field)[0].childNodes[0].nodeValue;
						field='UnitCost'+r;
						var Cost=xmlDoc.getElementsByTagName(field)[0].childNodes[0].nodeValue;
						field='editable'+r;
						var editable=(xmlDoc.getElementsByTagName('editable'+r)[0].childNodes[0].nodeValue.replace('--','').toLowerCase()=='true');
					}
					catch(e)	{	
						AjaxErr('There was a problem with the EquipList response data.\n Field:'+field,HttpText);	
						hideModal();
						return false;
					}
					
					eRow++;
					rowHTML='';
		
					var checkbox='<img align=absmiddle src="../../Images/padlock-gray.png" height=16 width=16 style="margin:auto;" />';
					if (editable) checkbox='<input id=eSel'+eRow+' class=equipCheckbox type=checkbox style="width:100%;" />';
					rowHTML+='<div id=eRow'+eRow+' class="ProjInfoListRow" style="margin:0; ">';
					rowHTML+='	<div id=Equip-ExpenseID'+eRow+' style="display:none;">'+ExpenseID+'</div>';
					rowHTML+='	<div style="width:3%;" align="center">'+checkbox+'</div>';
					rowHTML+='	<div style="width:3%;"><div id=Equip-Edit'+eRow+' class=rowEdit onClick="editEquip('+eRow+');"></div></div>';
					rowHTML+='	<div style="width:8%;" class=taRPi id=Equip-Qty'+eRow+' onKeyUp=updateEquipRow('+eRow+');>'+Qty+'</div>';
					rowHTML+='	<div style="width:8%;" class=taRPi id=Equip-ActualQty'+eRow+' onKeyUp=updateEquipRow('+eRow+');>'+ActualQty+'</div>';
					rowHTML+='	<div style="width:47%;" class=taLPi id=Equip-Desc'+eRow+'>'+SubType+'</div>';
					rowHTML+='	<div style="width:10%;" class=taRPi id=Equip-Cost'+eRow+' onKeyUp=updateEquipRow('+eRow+');>'+formatCurrency(Cost)+'</div>';
					rowHTML+='	<div style="width:7%;" class=taRPi id=Equip-Total'+eRow+'>'+formatCurrency(Cost*Qty)+'</div>';
					rowHTML+='	<div style="width:7%;" class=taRPi id=Equip-Actual'+eRow+'>'+formatCurrency(Cost*ActualQty)+'</div>';
					rowHTML+='	<div style="width:7%;" class=taRPi id=Equip-Diff'+eRow+'>'+formatCurrency(Cost*(Qty-ActualQty))+'</div>';
					rowHTML+='</div>';

					equipTotal+=(Cost*Qty);

					equipListDiv.innerHTML+=rowHTML;
					
					Gebi('SysPage').contentWindow.systemBudget(Gebi('SysPage').contentWindow.sysId);
					hideModal();

					Gebi('SysPage').contentWindow.Gebi('TotalEquip').innerHTML=formatCurrency(equipTotal);
				}
			}
			else {
				AjaxErr('There was a problem with the EquipList request.\n'+xhr.readyState+'\n Continue?',HttpText);
				hideModal();
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}

function OtherList(SysID) {
	HttpText='BidASP.asp?Action=ExpenseList&Type=OH&SysID='+Gebi("SysPage").contentWindow.sysId;
	xhr=getXHRObject();
	xhr.onreadystatechange=function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				
				try	{	var xmlDoc = xhr.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the OtherList response.',HttpText);	
					return false;
				}
				//AjaxErr('See the OtherList response?',HttpText);
				
				var recordCount = xmlDoc.getElementsByTagName("recordCount")[0].childNodes[0].nodeValue;
				
				var otherListDiv=Gebi('SysPage').contentWindow.document.getElementById('BidSystemsOther')
				otherListDiv.innerHTML='';
				var rowHTML;
				var oRow=100000;
				var otherTotal=0;
				for(r=1;r<=recordCount;r++)	{
					try	{	
						var ExpenseID=xmlDoc.getElementsByTagName('ExpenseID'+r)[0].childNodes[0].nodeValue;
						var Qty=parseFloat(xmlDoc.getElementsByTagName('Units'+r)[0].childNodes[0].nodeValue);
						var ActualQty=parseFloat(xmlDoc.getElementsByTagName('ActualUnits'+r)[0].childNodes[0].nodeValue);
						var SubType=xmlDoc.getElementsByTagName('SubType'+r)[0].childNodes[0].nodeValue;
						var Cost=parseFloat(xmlDoc.getElementsByTagName('UnitCost'+r)[0].childNodes[0].nodeValue);
						var editable=(xmlDoc.getElementsByTagName('editable'+r)[0].childNodes[0].nodeValue.replace('--','').toLowerCase()=='true');
					}
					catch(e)	{	
						AjaxErr('There was a problem with the OtherList response.',HttpText);	
						return false;
					}
					
					oRow++;
					rowHTML='';
		
					var checkbox='<img align=absmiddle src="../../Images/padlock-gray.png" height=16 width=16 style="margin:auto;" />';
					if (editable) checkbox='<input id=oSel'+oRow+' class=otherCheckbox type=checkbox style="width:100%;" />';
					rowHTML+='<div id=oRow'+oRow+' class="ProjInfoListRow" style="margin:0; ">';
					rowHTML+='	<div id=Other-ExpenseID'+oRow+' style="display:none;">'+ExpenseID+'</div>';
					rowHTML+='	<div style="width:3%;" align="center">'+checkbox+'</div>';
					rowHTML+='	<div style="width:3%;"><div id=Other-Edit'+oRow+' class=rowEdit onClick="editOther('+oRow+');"></div></div>';
					rowHTML+='	<div style="width:8%;" class=taRPi id=Other-Qty'+oRow+' onKeyUp=updateOtherRow('+oRow+');>'+Qty+'</div>';
					rowHTML+='	<div style="width:8%;" class=taRPi id=Other-ActualQty'+oRow+' onKeyUp=updateOtherRow('+oRow+');>'+ActualQty+'</div>';
					rowHTML+='	<div style="width:47%;" class=taLPi id=Other-Desc'+oRow+'>'+SubType+'</div>';
					rowHTML+='	<div style="width:10%;" class=taRPi id=Other-Cost'+oRow+' onKeyUp=updateOtherRow('+oRow+');>'+formatCurrency(Cost)+'</div>';
					rowHTML+='	<div style="width:7%;" class=taRPi id=Other-Total'+oRow+'>'+formatCurrency(Cost*Qty)+'</div>';
					rowHTML+='	<div style="width:7%;" class=taRPi id=Other-Actual'+oRow+'>'+formatCurrency(Cost*ActualQty)+'</div>';
					rowHTML+='	<div style="width:7%;" class=taRPi id=Other-Diff'+oRow+'>'+formatCurrency(Cost*(Qty-ActualQty))+'</div>';
					rowHTML+='</div>';

					otherTotal+=(Cost*Qty);

					otherListDiv.innerHTML+=rowHTML;

					Gebi('SysPage').contentWindow.Gebi('TotalOther').innerHTML=formatCurrency(otherTotal);
				}
			}
			else {
				AjaxErr('There was a problem with the OtherList request.\n'+xhr.readyState+'\n Continue?',HttpText);
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}


function systemBudget(sysId) {
	HttpText='BidASP.asp?action=systemCost&sysId='+sysId;
	xhr=getXHRObject();
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4) {
			if(xhr.status==200) {
				try { var xmlDoc = xhr.responseXML.documentElement }
				catch(e) { AjaxErr(' There was a problem with the systemBudget response.', HttpText); return false; }
				//AjaxErr(' There was a problem with the systemBudget response.', HttpText)
				var useNewBidder=xmlDoc.getElementsByTagName('useNewBidder')[0].childNodes[0].nodeValue;
				if (useNewBidder=='True') useNewBidder=true;  else useNewBidder=false;
				var roundUp=xmlDoc.getElementsByTagName('roundUp')[0].childNodes[0].nodeValue;
				if (roundUp=='True' && useNewBidder ) roundUp=true;  else roundUp=false;
				var totalFixed=xmlDoc.getElementsByTagName('totalFixed')[0].childNodes[0].nodeValue.replace('--','');
				if (totalFixed=='True') totalFixed=true;  else totalFixed=false;
				try {
					var taxRate=parseFloat(xmlDoc.getElementsByTagName('taxRate')[0].childNodes[0].nodeValue)*.01;
					var parts=parseFloat(xmlDoc.getElementsByTagName('parts')[0].childNodes[0].nodeValue);
					var labor=parseFloat(xmlDoc.getElementsByTagName('labor')[0].childNodes[0].nodeValue);
					var travel=parseFloat(xmlDoc.getElementsByTagName('travel')[0].childNodes[0].nodeValue);
					var equip=parseFloat(xmlDoc.getElementsByTagName('equip')[0].childNodes[0].nodeValue);
					var other=parseFloat(xmlDoc.getElementsByTagName('other')[0].childNodes[0].nodeValue);
					var fixedTotal=parseFloat(xmlDoc.getElementsByTagName('fixedTotal')[0].childNodes[0].nodeValue);
					var aParts=parseFloat(xmlDoc.getElementsByTagName('aParts')[0].childNodes[0].nodeValue);
					var aLabor=parseFloat(xmlDoc.getElementsByTagName('aLabor')[0].childNodes[0].nodeValue);
					var aTravel=parseFloat(xmlDoc.getElementsByTagName('aTravel')[0].childNodes[0].nodeValue);
					var aEquip=parseFloat(xmlDoc.getElementsByTagName('aEquip')[0].childNodes[0].nodeValue);
					var aOther=parseFloat(xmlDoc.getElementsByTagName('aOther')[0].childNodes[0].nodeValue);
					var dParts=parts-aParts;
					var dLabor=labor-aLabor;
					var dTravel=travel-aTravel; //alert(travel+' - '+dTravel+' - '+aTravel);
					var dEquip=equip-aEquip;
					var dOther=other-aOther;
				}
				catch (e) {
					AjaxErr(' There was a problem with the systemBudget response data.', HttpText) 
				}
				
				var expenses=travel+equip+other; 
				
				//AjaxErr('n8 is Examining systemBudget response data.', HttpText) 
				
				Gebi('TotalTravel').innerHTML=formatCurrency(travel);
				Gebi('TotalEquip').innerHTML=formatCurrency(equip);
				Gebi('TotalOther').innerHTML=formatCurrency(other);
				Gebi('TotalParts').innerHTML=formatCurrency(parts);
				Gebi('TotalLabor').innerHTML=formatCurrency(labor);
				
				
				if(totalFixed) { //Fixed Total 
					var sysTotal = fixedTotal;
					var PL=parts+labor; var EO=expenses;
				}
				else { //Fixed Margin 
					var PL=parts+labor; var EO=expenses;
					var sysTotal=(PL)+(parts*taxRate)+EO;
					fixedTotal=sysTotal;
				}
				var tax=parts*taxRate;
				var aTax=aParts*taxRate;
				var aSysTotal=(aParts*(1+taxRate))+aLabor+aTravel+aEquip+aOther;
				var dTax=tax-aTax;
				var dSysTotal=sysTotal-aSysTotal;
				
				function p(number) {
					return Math.round((number/sysTotal)*10000)/100
				}
					
				
				Gebi('SystemTotal').innerHTML=formatCurrency(sysTotal);
				Gebi('ActualTotal').innerHTML=formatCurrency(aSysTotal);
				if(aSysTotal==sysTotal) Gebi('SystemTotal').style.color='rgba(0,0,0,.34)';
				else Gebi('SystemTotal').style.opacity='.5';
				if(aSysTotal>sysTotal) {
					Gebi('budgetCondition').innerHTML='over budget';
					Gebi('plusMinus').innerHTML='+';
					Gebi('ActualTotal').style.color='#D00';
					Gebi('plusMinus').style.color='#D00';
					Gebi('diff').style.color='#D00';
				}
				if(aSysTotal<sysTotal) {
					Gebi('budgetCondition').innerHTML='within budget';
					Gebi('plusMinus').innerHTML='';
					Gebi('ActualTotal').style.color='#0D0';
					Gebi('plusMinus').style.color='#0D0';
					Gebi('diff').style.color='#0D0';
				}
				Gebi('diff').innerHTML=formatCurrency(Math.abs(sysTotal-aSysTotal));
				
					
				Gebi('bPartsCost').innerHTML=formatCurrency(parts); 
				Gebi('bLaborCost').innerHTML=formatCurrency(labor);
				Gebi('bTravelCost').innerHTML=formatCurrency(travel);
				Gebi('bEquipCost').innerHTML=formatCurrency(equip);
				Gebi('bOtherCost').innerHTML=formatCurrency(other);
				//Gebi('bTaxCost').innerHTML=formatCurrency(tax);
				Gebi('bPartsPerc').innerHTML=p(parts)+'%';
				Gebi('bLaborPerc').innerHTML=p(labor)+'%';
				Gebi('bTravelPerc').innerHTML=p(travel)+'%';
				Gebi('bEquipPerc').innerHTML=p(equip)+'%';
				Gebi('bOtherPerc').innerHTML=p(other)+'%';
				//Gebi('bTaxPerc').innerHTML=p(tax)+'%';
				var g='#080'; var r='#C00';	
				Gebi('aPartsCost').innerHTML=formatCurrency(aParts); if(aParts<parts) Gebi('aPartsCost').style.color=r; if(aParts<parts) Gebi('aPartsCost').style.color=g;
				Gebi('aLaborCost').innerHTML=formatCurrency(aLabor); if(aLabor<labor) Gebi('aLaborCost').style.color=r; if(aLabor<labor) Gebi('aLaborCost').style.color=g;
				Gebi('aTravelCost').innerHTML=formatCurrency(aTravel); if(aTravel<travel) Gebi('aTravelCost').style.color=r; if(aTravel<travel) Gebi('aTravelCost').style.color=g;
				Gebi('aEquipCost').innerHTML=formatCurrency(aEquip); if(aEquip<equip) Gebi('aEquipCost').style.color=r; if(aEquip<equip) Gebi('aEquipCost').style.color=g;
				Gebi('aOtherCost').innerHTML=formatCurrency(aOther); if(aOther<other) Gebi('aOtherCost').style.color=r; if(aOther<other) Gebi('aOtherCost').style.color=g;
				//Gebi('aTaxCost').innerHTML=formatCurrency(aTax);
				Gebi('aPartsPerc').innerHTML=p(aParts)+'%'; Gebi('aPartsPerc').style.color=Gebi('aPartsCost').style.color;
				Gebi('aLaborPerc').innerHTML=p(aLabor)+'%'; Gebi('aLaborPerc').style.color=Gebi('aLaborCost').style.color;
				Gebi('aTravelPerc').innerHTML=p(aTravel)+'%'; Gebi('aTravelPerc').style.color=Gebi('aTravelCost').style.color;
				Gebi('aEquipPerc').innerHTML=p(aEquip)+'%'; Gebi('aEquipPerc').style.color=Gebi('aEquipCost').style.color;
				Gebi('aOtherPerc').innerHTML=p(aOther)+'%'; Gebi('aOtherPerc').style.color=Gebi('aOtherCost').style.color;
				//Gebi('aTaxPerc').innerHTML=p(aTax)+'%';
				
				var GraphSrc='pie.asp?GraphData=';
				var lessThan1=0;
				if(p(aParts+tax)>2)   {GraphSrc+='Materials <small><sup>(w/tax)</sup></small>_'+Math.round(p(parts+tax) * 100) +'_'; } else { lessThan1 += p(parts+tax) }
				if(p(aLabor)>2)   { GraphSrc+='.Labor_' + Math.round((aLabor) * 1) +'_'; } else { lessThan1 += p(aLabor) }
				if(p(aTravel)>2)   { GraphSrc+='.Travel_' + Math.round((aTravel) * 1) +'_'; } else { lessThan1 += p(aTravel) }
				if(p(aEquip)>2)   { GraphSrc+='.Equipment_' + Math.round((aEquip) * 1) +'_'; } else { lessThan1 += p(aEquip) }
				if(p(aOther)>2)   { GraphSrc+='.Other Exp_' + Math.round((aOther) * 1) +'_'; } else { lessThan1 += p(aOther) }
				//if(p(tax)>2)     { GraphSrc += '.Tax_' + Math.round( p(tax) * 100 ) + '_' ; } else { lessThan1 += p(tax) }
				if(lessThan1>0) { GraphSrc+= '.<small><small>Everything Else</small></small>_' + Math.round(lessThan1 * 100)+'_'; }
				
				var noCache=new Date(); noCache=noCache.getMilliseconds();
				Gebi('bGraph').src=encodeURI(GraphSrc+'&nocache='+noCache);
				
				//var dO=Math.min(dParts,dLabor,dTravel,dEquip,dOther,dTax);
				
				var Bottom=0;
				if (-parts<Bottom) Bottom=-parts;
				if (-labor<Bottom) Bottom=-labor;
				if (-travel<Bottom) Bottom=-travel;
				if (-equip<Bottom) Bottom=-equip;
				if (-other<Bottom) Bottom=-other;
				
				var GraphSrc='vBar.asp?GraphData=';
				var lessThan1=0;
				GraphSrc+='.Bottomer_' + Math.round((Bottom/4) * 100) +'_CC0';
				GraphSrc+='.Materials<br/><small><sup>(w/tax)</sup></small>_'+Math.round((0-dParts) * 100) +'_0CC';
				GraphSrc+='.Labor_' + Math.round((0-dLabor) * 100) +'_F80';
				GraphSrc+='.Travel<br/>%26amp; Meals_' + Math.round((0-dTravel) * 100) +'_89F';
				GraphSrc+='.Equipment_' + Math.round((0-dEquip) * 100) +'_CB8';
				GraphSrc+='.Other Exp_' + Math.round((0-dOther) * 100) +'_CC0';
				//GraphSrc += '.Tax_' + Math.round( (0-dTax) * 100 ) + '_8C0' ;

				Gebi('aGraph').src=GraphSrc;
				//Gebi('SysInfoTitle').innerHTML=GraphSrc;
			}
			else {
				AjaxErr('There was a problem with the systemBudget request.', HttpText);
				return false
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}




function ProjectBudget() {
	HttpText='BidASP.asp?action=ProjectCost&projId='+projId;
	xhr=getXHRObject();
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4) {
			if(xhr.status==200) {
				try { var xmlDoc = xhr.responseXML.documentElement }
				catch(e) { AjaxErr(' There was a problem with the ProjectBudget response.', HttpText) }

				var tax;
				var profit;
				var sysTotal;
				var partsSell;
				var laborSell;
				
				function sysBudg(totalFixed,fixedTotal,parts,labor,expenses,taxRate) {
					if(totalFixed) { 
						sysTotal = fixedTotal;
						var PLO=parts+labor;
						tax=parts*taxRate;
					}
					else { 
						var PLO=parts+labor;
						sysTotal=(PLO)+(parts*taxRate)+expenses;
						tax=parts*taxRate;
						
						fixedTotal=sysTotal;
					}
					return sysTotal;
				}
				
				try {	var recordCount=xmlDoc.getElementsByTagName('recordCount')[0].childNodes[0].nodeValue; }
				catch(e) { AjaxErr(' There are issues with the ProjectBudget response data.', HttpText) }
				
				var projTotal=0;
				var pTotal=0;
				var lTotal=0;
				var eTotal=0;
				//var oTotal=0;
				var tTotal=0;
				//var profitTotal=0;
				var aProjTotal=0;
				var aPTotal=0;
				var aLTotal=0;
				var aETotal=0;
				var aTTotal=0;
				
				for(r=1;r<=recordCount;r++) {
					var totalFixed = xmlDoc.getElementsByTagName('totalFixed'+r)[0].childNodes[0].nodeValue.replace('--','');
					totalFixed=(totalFixed.toLowerCase()=='true');
					var fixedTotal = parseFloat(xmlDoc.getElementsByTagName('fixedTotal'+r)[0].childNodes[0].nodeValue);
					var parts = parseFloat(xmlDoc.getElementsByTagName('parts'+r)[0].childNodes[0].nodeValue);
					var labor = parseFloat(xmlDoc.getElementsByTagName('labor'+r)[0].childNodes[0].nodeValue);
					var expenses = parseFloat(xmlDoc.getElementsByTagName('expenses'+r)[0].childNodes[0].nodeValue);
					var taxRate = parseFloat(xmlDoc.getElementsByTagName('taxRate'+r)[0].childNodes[0].nodeValue);
					var aFixedTotal = parseFloat(xmlDoc.getElementsByTagName('aFixedTotal'+r)[0].childNodes[0].nodeValue);
					var aParts = parseFloat(xmlDoc.getElementsByTagName('aParts'+r)[0].childNodes[0].nodeValue);
					var aLabor = parseFloat(xmlDoc.getElementsByTagName('aLabor'+r)[0].childNodes[0].nodeValue);
					var aExpenses = parseFloat(xmlDoc.getElementsByTagName('aExpenses'+r)[0].childNodes[0].nodeValue);
					
					projTotal+=sysBudg(totalFixed,fixedTotal,parts,labor,expenses,taxRate);
					pTotal+=parts;
					lTotal+=labor;
					eTotal+=expenses;
					tTotal+=tax;
					aProjTotal+=sysBudg(totalFixed,aFixedTotal,aParts,aLabor,aExpenses,taxRate);
					aPTotal+=aParts;
					aLTotal+=aLabor;
					aETotal+=aExpenses;
				}
				tTotal=pTotal*taxRate;
				aTTotal=aPTotal*taxRate;
								
				Gebi('ProjectTotal').innerHTML=formatCurrency(projTotal);
				Gebi('ProjectTotal2').innerHTML=formatCurrency(projTotal);
				Gebi('BudgetTotal').innerHTML=formatCurrency(aProjTotal);
				if(aProjTotal==projTotal) Gebi('ProjectTotal').style.color='rgba(0,0,0,.34)';
				else Gebi('ProjectTotal').style.opacity='.5';
				if(aProjTotal>projTotal) Gebi('BudgetTotal').style.color='#D00';
				if(aProjTotal<projTotal) Gebi('BudgetTotal').style.color='#0D0';
				
				WSQLU('Projects','BidTotal',projTotal,'ProjID',projId);
				
				Gebi('PartsCost').innerHTML=formatCurrency(aPTotal);
				Gebi('LaborCost').innerHTML=formatCurrency(aLTotal);
				Gebi('ExpensesCost').innerHTML=formatCurrency(aETotal);
				Gebi('TaxCost').innerHTML=formatCurrency(aTTotal);
				
				
				function p(n) { return formatPercent(n/projTotal,2); }
				
				Gebi('PartsPerc').innerHTML=p(aPTotal);
				Gebi('LaborPerc').innerHTML=p(aLTotal);
				Gebi('ExpensesPerc').innerHTML=p(aETotal);
				Gebi('TaxPerc').innerHTML=p(aTTotal);
				
				pieSrc='pie.asp?GraphData=';
				function g(name,number) {
					number=Math.round(number);
					if (number>=10) { pieSrc+=name+'_'+number+'_'; }
				}
				
				g('Materials',aPTotal);
				g('.Labor',aLTotal);
				g('.Expenses',aETotal);
				//g('.Overhead',oTotal);
				g('.Taxes',aTTotal);
				//g('.Profit',profitTotal);
				
				Gebi('costPie').src=pieSrc;
			}
			else {
				AjaxErr('There was a problem with the ProjectBudget request.', HttpText);
				return false
			}
		}
	}
	xhr.open('GET', HttpText, false);
	xhr.send(null);
}


// Font Readability Test:
//		Character distinguishability is about 90% of readability.
//		
//		1Il|│ 
//		 i¡!‼
//		┬Ttτ┼π
//		°o○O0☺☻
//		
//		-─_
//		
//		= ═
//		
//		•∙·.,÷:;'`"
//		


//		☺ ☻ ♥ ♦ ♣ ♠ • ◘ ○ ◙ ♂ ♀ ♪ ♫ ☼ ► ◄ ↕ ‼ ¶ § ▬ ↨ ↑ ↓ → ← ∟ ↔ ▲ ▼
//		
//		⌂Ç
//		üéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ¢£¥₧ƒá
//		íóúñÑªº¿⌐¬½¼¡«»▒▓│┤╡╢╖╕╣║╗╝╜┐└
//		┴┬├─┼╞╟╚╔╩╦╠═╬╧╨╤╥╙╘╒╓╫╪
//		┘┌█▄▌▐▀αßΓπΣσµτΦΘΩδ∞φε∩≡±≥≤⌠⌡
//		ßΓπΣσµτCΘΩδ∞φε∩≡
//		±≥≤⌠⌡÷≈°∙·√ⁿ²■ 