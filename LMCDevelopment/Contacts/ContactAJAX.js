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


function saveNewLink(Link) {
	HttpText='ContactASP.asp?action=saveNewLink&Link='+Link+'&projId='+projId
	xhr=getXHRObject()
	xhr.onreadystatechange=function () {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
			
				try	{	var xmlDoc = xhr.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the SaveNewLink response.',HttpText);	
				}
				
				//var RecordCount= xmlDoc.getElementsByTagName('RecordCount')[0].childNodes[0].nodeValue.replace('--','');
				window.location=window.location;
				hideNewLink();
			}
			else {
				AjaxErr('There was a problem with the SaveNewBid request.',HttpText);
			}
		}
	}
	xhr.open('GET',HttpText,true);
	xhr.send(null)
}


function searchContact(sStr) {
	HttpText='ContactASP.asp?action=searchContact&search='+CharsEncode(sStr);
	xhr = getXHRObject();
	xhr.onreadystatechange = function () {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				
				try	{	var xmlDoc = xhr.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the searchContact:"'+sStr+'" response.',HttpText);	
				}
				var recordCount=xmlDoc.getElementsByTagName('recordCount')[0].childNodes[0].nodeValue.replace('--','');
				
				var contactList='';
				for(r=1;r<=recordCount;r++) {
					var contactId=xmlDoc.getElementsByTagName('contactId'+r)[0].childNodes[0].nodeValue;
					var name=CharsDecode(xmlDoc.getElementsByTagName('name'+r)[0].childNodes[0].nodeValue);
					contactList+='<div onclick="addContact('+contactId+',\''+name+'\');" class=contactListItem >'+name+'</div>';
				}
				Gebi('contactList').innerHTML=contactList;
			}
			else {
				AjaxErr('There was a problem with the searchContact:"'+sStr+'" request. Continue?',HttpText);
			}
		}
	}
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}




function AddPart(PartID) {
	var LinkId = Gebi("LinkPage").contentWindow.LinkId;

	HttpText='ContactASP.asp?action=AddPart&PartID='+PartID+'&LinkID='+LinkId;
	xhr = getXHRObject();
	xhr.onreadystatechange = ReturnAddPart;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}
function AddBlankPart() {
	var LinkId = Gebi("LinkPage").contentWindow.LinkId;
	HttpText='ContactASP.asp?action=AddPart&PartID=0&LinkID='+LinkId;
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
			var LinkID = xmlDoc.getElementsByTagName("LinkID")[0].childNodes[0].nodeValue;
			
			//Gebi('PartsTabMain').innerHTML += ProjID;
			PartsList(LinkID);
		}
		else {
			AjaxErr('There was a problem with the AddPart request. Continue?',HttpText);
		}
	}
}


function AddLabor(LaborID) {
	var LinkId = Gebi("LinkPage").contentWindow.LinkId;

	HttpText='ContactASP.asp?action=AddLabor&LaborID='+LaborID+'&LinkID='+LinkId;
	xhr = getXHRObject();
	xhr.onreadystatechange = ReturnAddLabor;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}
function AddBlankLabor() {
	var LinkId = Gebi("LinkPage").contentWindow.LinkId;
	HttpText='ContactASP.asp?action=AddLabor&LinkID='+LinkId;
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
				var LinkID = xmlDoc.getElementsByTagName("LinkID")[0].childNodes[0].nodeValue;
			}
			catch(e) { AjaxErr('There was a problem with the AddLabor response.',HttpText); }
			LaborList(LinkID);
		}
		else {
			AjaxErr('There was a problem with the AddLabor request.',HttpText);
		}
	}
}

function AddExpense(Type,SubType,Origin,Dest,Units,Cost) {
	var LinkId = Gebi("LinkPage").contentWindow.LinkId;
	//var MU = Gebi('LinkExpFrame').contentWindow.document.getElementById("MU").value;
	
	//alert(LinkId);
	SubType=CharsEncode(SubType);
	Origin=CharsEncode(Origin);
	Dest=CharsEncode(Dest);
	HttpText='ContactASP.asp?action=AddExpense&Type='+Type+'&SubType='+SubType+'&Origin='+Origin+'&Dest='+Dest+'&Units='+Units+'&Cost='+Cost+'&LinkID='+LinkId;
	xhr = getXHRObject();
	xhr.onreadystatechange = function () {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				
				try { var xmlDoc = xhr.responseXML.documentElement; }
				catch(e) {
					AjaxErr('There was a problem with the AddPart response!',HttpText);
				}
				//var ProjID = xmlDoc.getElementsByTagName("ProjID")[0].childNodes[0].nodeValue;
				var LinkID = xmlDoc.getElementsByTagName("LinkID")[0].childNodes[0].nodeValue;
				
				ExpenseLists(LinkID);
			}
			else {
				AjaxErr('There was a problem with the AddPart request. Continue?',HttpText);
			}
		}
	}
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}


function AllLists(LinkId) {
	PartsList(LinkId);
	LaborList(LinkId);
	TravelList(LinkId);
	EquipList(LinkId);
	OtherList(LinkId);
}

function PartsList(LinkId) {
	HttpText='ContactASP.asp?Action=PartsList&LinkID='+Gebi("LinkPage").contentWindow.LinkId;
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
				var partListDiv=Gebi('LinkPage').contentWindow.document.getElementById('BidLinksParts')
				partListDiv.innerHTML='';
				
				var BidItemsID;
				var Qty;
				var Manufacturer;
				var ItemName;
				var ItemDescription;
				var Cost;
				var Sell
				var costing
				
				var partsHTML=''
				var rowHTML;
				var pRow=100000;
				var partsTotal=0;
				
				
				for(r=1;r<=recordCount;r++)	{
					
					BidItemsID=xmlDoc.getElementsByTagName('BidItemsID'+r)[0].childNodes[0].nodeValue;
					Qty=xmlDoc.getElementsByTagName('Qty'+r)[0].childNodes[0].nodeValue*1;
					Manufacturer=xmlDoc.getElementsByTagName('Manufacturer'+r)[0].childNodes[0].nodeValue.replace('--','');
					ItemName=xmlDoc.getElementsByTagName('ItemName'+r)[0].childNodes[0].nodeValue.replace('--','');
					ItemDescription=CharsDecode(xmlDoc.getElementsByTagName('ItemDescription'+r)[0].childNodes[0].nodeValue.replace('--',''));
					Cost=xmlDoc.getElementsByTagName('Cost'+r)[0].childNodes[0].nodeValue;
					costing=(xmlDoc.getElementsByTagName('editable'+r)[0].childNodes[0].nodeValue!='False');
					var color='';
					if(Qty<=0) { color='color:#C00;'; } else { color=''; }
					
					if(!costing) {
						pRow++;
						rowHTML='';
						rowHTML+='<div id=pRow'+pRow+' class="ProjInfoListRow" style="'+color+' ">';
						rowHTML+='	<div id=Part-BidItemsID'+pRow+' style="display:none">'+BidItemsID+'</div>';
						rowHTML+='	<div style=width:3%; align=center><input id=pSel'+pRow+' class=partCheckbox name=partCheckbox type=checkbox style=width:100%;/></div>';
						rowHTML+='	<div style="width:3%;"><div id=Part-Edit'+pRow+' class=rowEdit onClick="editPart('+pRow+');"></div></div>';
						rowHTML+='	<div style="width:7%;" class=taRPi id=Part-Qty'+pRow+' onKeyUp=updatePartRow('+pRow+'); onblur="evalBox(this); updatePartRow('+pRow+');" >'+Qty+'</div>';
						rowHTML+='	<div style="width:12%;" class=taLPi id=Part-Manufacturer'+pRow+'>'+Manufacturer+'</div>';
						rowHTML+='	<div style="width:15%;" class=taLPi id=Part-PartNumber'+pRow+'>'+ItemName+'</div>';
						if(useNewBidder) {
							rowHTML+='	<div style="width:38%;" class=taLPi id=Part-ItemDescription'+pRow+'>'+ItemDescription+'</div>';
							rowHTML+='	<div style="width:10%;" class=taRPi id=Part-Cost'+pRow+' onKeyUp=updatePartRow('+pRow+'); onblur="evalBox(this); updatePartRow('+pRow+');" >'+formatCurrency(Cost)+'</div>';
							rowHTML+='	<div style="width:12%;" class=taRPi id=Part-Total'+pRow+'>'+formatCurrency(Cost*Qty)+'</div>';
							partsTotal+=(Cost*Qty);
						}
						else {
							Sell=Cost*M;
							rowHTML+='		<div style="width:28%; text-align:left;" class=taLPi id=Part-ItemDescription'+pRow+'>'+ItemDescription+'</div>';
							rowHTML+='		<div style="width:10%;" id=Part-Cost'+pRow+' class=taRPi onKeyUp=updatePartRow('+pRow+'); onblur="evalBox(this); updatePartRow('+pRow+');">'+formatCurrency(Cost)+'</div>';
							rowHTML+='		<div style="width:10%;" id=Part-Sell'+pRow+' class=taRPi >'+formatCurrency(Sell)+'</div>';
							rowHTML+='		<div style="border-right:none; width:12%;" class=taRPi id=Part-Total'+pRow+'>'+formatCurrency(Sell*Qty)+'</div>';
							partsTotal+=(Sell*Qty);
						}
						rowHTML+='</div>';
						partsHTML+=rowHTML;
					}
				}
				//alert(partsHTML);
				partListDiv.innerHTML=partsHTML;
				Gebi('LinkPage').contentWindow.LinkCost(LinkId);

				Gebi('LinkPage').contentWindow.Gebi('TotalParts').innerHTML=formatCurrency(partsTotal);
			}
			else {
				AjaxErr('There was a problem with the PartsList request.\n'+xhr.readyState+'\n Continue?',HttpText);
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}


function LaborList(LinkID) {
	HttpText='ContactASP.asp?Action=LaborList&LinkID='+Gebi("LinkPage").contentWindow.LinkId;
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
				var laborListDiv=Gebi('LinkPage').contentWindow.document.getElementById('BidLinksLabor')
				laborListDiv.innerHTML='';
				
				var BidItemsID;
				var Qty;
				var ItemName;
				var ItemDescription;
				var Cost;
				var Sell
				var costing
				
				var rowHTML;
				var lRow=100000;
				var laborTotal=0;
				for(r=1;r<=recordCount;r++)	{
					
					BidItemsID=xmlDoc.getElementsByTagName('BidItemsID'+r)[0].childNodes[0].nodeValue;
					Qty=xmlDoc.getElementsByTagName('Qty'+r)[0].childNodes[0].nodeValue*1;
					ItemName=CharsDecode(xmlDoc.getElementsByTagName('ItemName'+r)[0].childNodes[0].nodeValue);
					ItemDescription=CharsDecode(xmlDoc.getElementsByTagName('ItemDescription'+r)[0].childNodes[0].nodeValue);
					Cost=xmlDoc.getElementsByTagName('Cost'+r)[0].childNodes[0].nodeValue;
					costing=(xmlDoc.getElementsByTagName('editable'+r)[0].childNodes[0].nodeValue!='False');
					
					if (!costing) {
						var color='';
						if(Qty<=0) { color='color:#C00;'; } else { color=''; }
						lRow++;
						rowHTML='';
						rowHTML+='<div id=lRow'+lRow+' class="ProjInfoListRow" style="'+color+' ">';
						rowHTML+='	<div id=Labor-BidItemsID'+lRow+' style="display:none">'+BidItemsID+'</div>';
						rowHTML+='	<div style="width:3%;" align="center"><input id=lSel'+lRow+' class="laborCheckbox" type="checkbox" style="width:100%;"/></div>';
						rowHTML+='	<div style="width:3%;"><div id=Labor-Edit'+lRow+' class=rowEdit onClick="editLabor('+lRow+');"></div></div>';
						rowHTML+='	<div style="width:4%;" class=taRPi id=Labor-Qty'+lRow+' onKeyUp=updateLaborRow('+lRow+'); onblur="evalBox(this); updateLaborRow('+lRow+');">'+Qty+'</div>';
						rowHTML+='	<div style="width:20%;" class=taLPi id=Labor-ItemName'+lRow+'>'+ItemName+'</div>';
						if(useNewBidder) {
							rowHTML+='	<div style="width:50%; text-align:left;" class=taLPi id=Labor-ItemDescription'+lRow+'>'+ItemDescription+'</div>';
							rowHTML+='	<div style="width:10%;" class=taRPi id=Labor-Cost'+lRow+' onKeyUp=updateLaborRow('+lRow+'); onblur="evalBox(this); updateLaborRow('+lRow+');">'+formatCurrency(Cost)+'</div>';
							rowHTML+='	<div style="width:10%;" class=taRPi id=Labor-Total'+lRow+'>'+formatCurrency(Cost*Qty)+'</div>';
							laborTotal+=(Cost*Qty);
						}
						else {
							Sell=((Cost*(MU+100))/100);
							rowHTML+='		<div style="width:40%; text-align:left;" class=taLPi id=Labor-ItemDescription'+lRow+'>'+ItemDescription+'</div>';
							rowHTML+='		<div style="width:10%;" class=taRPi id=Labor-Cost'+lRow+' onKeyUp=updateLaborRow('+lRow+'); onblur="evalBox(this); updateLaborRow('+lRow+');">'+formatCurrency(Cost)+'</div>';
							rowHTML+='		<div style="width:10%;" class=taRPi id=Labor-Sell'+lRow+'>'+formatCurrency(Sell)+'</div>';
							rowHTML+='		<div style="border-right:none; width:10%;" id=Labor-Total'+lRow+'>'+formatCurrency(Sell*Qty)+'</div>';
							laborTotal+=(Sell*Qty);
						}
						rowHTML+='</div>';
	
						laborListDiv.innerHTML+=rowHTML;
						Gebi('LinkPage').contentWindow.LinkCost(Gebi('LinkPage').contentWindow.LinkId);
						
						Gebi('LinkPage').contentWindow.Gebi('TotalLabor').innerHTML=formatCurrency(laborTotal);
					}
				}
			}
			else { AjaxErr('There was a problem with the LaborList request.\n'+xhr.readyState+'\n Continue?',HttpText); }
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}


function TravelList(LinkID) {
	HttpText='ContactASP.asp?Action=ExpenseList&Type=Travel&LinkID='+Gebi("LinkPage").contentWindow.LinkId;
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
				
				var travelListDiv=Gebi('LinkPage').contentWindow.document.getElementById('BidLinksTravel')
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
						var Qty=xmlDoc.getElementsByTagName('Units'+r)[0].childNodes[0].nodeValue*1;
						var Unit=xmlDoc.getElementsByTagName('Unit'+r)[0].childNodes[0].nodeValue.replace('--','');
						var costing=(xmlDoc.getElementsByTagName('editable'+r)[0].childNodes[0].nodeValue!='False');
					}
					catch(e)	{	
						AjaxErr('There was a problem with the TravelList response data.',HttpText);	
						return false;
					}
					if(!costing) {
						tRow++;
						rowHTML='';
			
						rowHTML+='<div id=tRow'+tRow+' class="ProjInfoListRow">';
						rowHTML+='	<div id=Travel-ExpenseID'+tRow+' style="display:none;">'+ExpenseID+'</div>';
						rowHTML+='	<div style="width:3%;" align="center"><input id=tSel'+tRow+' class=travelCheckbox type=checkbox style=width:100%; /></div>';
						rowHTML+='	<div style="width:3%;"><div id=Travel-Edit'+tRow+' class=rowEdit onClick="editTravel('+tRow+');"></div></div>';
						rowHTML+='	<div style="width:7%;" id=Travel-SubType'+tRow+'>'+SubType+'</div>';
						rowHTML+='	<div style="width:27%; text-overflow:ellipsis;" class=taLPi id=Travel-Origin'+tRow+'>'+Origin+'</div>';
						rowHTML+='	<div style="width:27%; text-overflow:ellipsis;" class=taLPi id=Travel-Destination'+tRow+'>'+Destination+'</div>';
						rowHTML+='	<div style="width:10%;" class=taRPi id=Travel-Cost'+tRow+' onKeyUp=updateTravelRow('+tRow+'); onblur="evalBox(this); updateTravelRow('+lRow+');">'+formatCurrency(Cost)+'</div>';
						rowHTML+='	<div style="width:4%;" class=taRPi id=Travel-Qty'+tRow+' onKeyUp=updateTravelRow('+tRow+'); onblur="evalBox(this); updateTravelRow('+lRow+');">'+Qty+'</div>';
						rowHTML+='	<div style="width:9%;" class=taLPi id=Travel-Unit'+tRow+' >'+Unit+'</div>';
						rowHTML+='	<div style="width:10%;" class=taRPi id=Travel-Total'+tRow+'>'+formatCurrency(Cost*Qty)+'</div>';
						rowHTML+='</div>';
	
						travelTotal+=(Cost*Qty);
	
						travelListDiv.innerHTML+=rowHTML;
						Gebi('LinkPage').contentWindow.LinkCost(Gebi('LinkPage').contentWindow.LinkId);
	
						Gebi('LinkPage').contentWindow.Gebi('TotalTravel').innerHTML=formatCurrency(travelTotal);
					}
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

function EquipList(LinkID) {
	HttpText='ContactASP.asp?Action=ExpenseList&Type=Equip&LinkID='+Gebi("LinkPage").contentWindow.LinkId;
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
				
				var equipListDiv=Gebi('LinkPage').contentWindow.document.getElementById('BidLinksEquipment')
				equipListDiv.innerHTML='';

				var rowHTML;
				var eRow=100000;
				var equipTotal=0;
				if(r<1) { hideModal(); return true; }
				for(r=1;r<=recordCount;r++)	{
					try	{	
						var ExpenseID=xmlDoc.getElementsByTagName('ExpenseID'+r)[0].childNodes[0].nodeValue;
						var Qty=xmlDoc.getElementsByTagName('Units'+r)[0].childNodes[0].nodeValue*1;
						var SubType=xmlDoc.getElementsByTagName('SubType'+r)[0].childNodes[0].nodeValue;
						var Cost=xmlDoc.getElementsByTagName('UnitCost'+r)[0].childNodes[0].nodeValue;
						var costing=(xmlDoc.getElementsByTagName('editable'+r)[0].childNodes[0].nodeValue!='False');
					}
					catch(e)	{	
						AjaxErr('There was a problem with the EquipList response.',HttpText);	
						hideModal();
						return false;
					}
					
					if(!costing) {
						eRow++;
						rowHTML='';
			
						rowHTML+='<div id=eRow'+eRow+' class="ProjInfoListRow" style="margin:0; width:95%;">';
						rowHTML+='	<div id=Equip-ExpenseID'+eRow+' style="display:none;">'+ExpenseID+'</div>';
						rowHTML+='	<div style="width:6%;" align="center"><input id=eSel'+eRow+' class=equipCheckbox type=checkbox style=width:100%; /></div>';
						rowHTML+='	<div style="width:6%;"><div id=Equip-Edit'+eRow+' class=rowEdit onClick="editEquip('+eRow+');"></div></div>';
						rowHTML+='	<div style="width:8%;" class=taRPi id=Equip-Qty'+eRow+' onKeyUp=updateEquipRow('+eRow+'); onblur="evalBox(this); updateEquipRow('+lRow+');">'+Qty+'</div>';
						rowHTML+='	<div style="width:40%;" class=taLPi id=Equip-Desc'+eRow+'>'+SubType+'</div>';
						rowHTML+='	<div style="width:20%;" class=taRPi id=Equip-Cost'+eRow+' onKeyUp=updateEquipRow('+eRow+');  onblur="evalBox(this); updateEquipRow('+lRow+');">'+formatCurrency(Cost)+'</div>';
						rowHTML+='	<div style="width:20%;" class=taRPi id=Equip-Total'+eRow+'>'+formatCurrency(Cost*Qty)+'</div>';
						rowHTML+='</div>';
	
						equipTotal+=(Cost*Qty);
	
						equipListDiv.innerHTML+=rowHTML;
						
						Gebi('LinkPage').contentWindow.LinkCost(Gebi('LinkPage').contentWindow.LinkId);
						hideModal();
	
						Gebi('LinkPage').contentWindow.Gebi('TotalEquip').innerHTML=formatCurrency(equipTotal);
					}
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

function OtherList(LinkID) {
	HttpText='ContactASP.asp?Action=ExpenseList&Type=OH&LinkID='+Gebi("LinkPage").contentWindow.LinkId;
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
				
				var otherListDiv=Gebi('LinkPage').contentWindow.document.getElementById('BidLinksOther')
				otherListDiv.innerHTML='';
				var rowHTML;
				var oRow=100000;
				var otherTotal=0;
				for(r=1;r<=recordCount;r++)	{
					try	{	
						var ExpenseID=xmlDoc.getElementsByTagName('ExpenseID'+r)[0].childNodes[0].nodeValue;
						var Qty=xmlDoc.getElementsByTagName('Units'+r)[0].childNodes[0].nodeValue*1;
						var SubType=xmlDoc.getElementsByTagName('SubType'+r)[0].childNodes[0].nodeValue;
						var Cost=xmlDoc.getElementsByTagName('UnitCost'+r)[0].childNodes[0].nodeValue;
						var costing=(xmlDoc.getElementsByTagName('editable'+r)[0].childNodes[0].nodeValue!='False');
					}
					catch(e)	{	
						AjaxErr('There was a problem with the OtherList response.',HttpText);	
						return false;
					}
					
					if(!costing) {
						oRow++;
						rowHTML='';
			
						rowHTML+='<div id=oRow'+oRow+' class="ProjInfoListRow" style="margin:0; width:95%;">';
						rowHTML+='	<div id=Other-ExpenseID'+oRow+' style="display:none;">'+ExpenseID+'</div>';
						rowHTML+='	<div style="width:6%;" align="center"><input id=oSel'+oRow+' class=otherCheckbox type=checkbox style=width:100%; /></div>';
						rowHTML+='	<div style="width:6%;"><div id=Other-Edit'+oRow+' class=rowEdit onClick="editOther('+oRow+');"></div></div>';
						rowHTML+='	<div style="width:8%;" class=taRPi id=Other-Qty'+oRow+' onKeyUp=updateOtherRow('+oRow+'); onblur="evalBox(this); updateOtherRow('+lRow+');">'+Qty+'</div>';
						rowHTML+='	<div style="width:40%;" class=taLPi id=Other-Desc'+oRow+'>'+SubType+'</div>';
						rowHTML+='	<div style="width:20%;" class=taRPi id=Other-Cost'+oRow+' onKeyUp=updateOtherRow('+oRow+'); onblur="evalBox(this); updateOtherRow('+lRow+');">'+formatCurrency(Cost)+'</div>';
						rowHTML+='	<div style="width:20%;" class=taRPi id=Other-Total'+oRow+'>'+formatCurrency(Cost*Qty)+'</div>';
						rowHTML+='</div>';
	
						otherTotal+=(Cost*Qty);
	
						otherListDiv.innerHTML+=rowHTML;
	
						Gebi('LinkPage').contentWindow.Gebi('TotalOther').innerHTML=formatCurrency(otherTotal);
					}
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


function LinkCost(LinkId) {
	HttpText='ContactASP.asp?action=LinkCost&LinkId='+LinkId;
	xhr=getXHRObject();
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4) {
			if(xhr.status==200) {
				try { var xmlDoc = xhr.responseXML.documentElement }
				catch(e) { AjaxErr(' There was a problem with the LinkCost response.', HttpText) }
				//AjaxErr(' There was a problem with the LinkCost response.', HttpText)
				var useNewBidder=xmlDoc.getElementsByTagName('useNewBidder')[0].childNodes[0].nodeValue;
				if (useNewBidder=='True') useNewBidder=true;  else useNewBidder=false;
				var roundUp=xmlDoc.getElementsByTagName('roundUp')[0].childNodes[0].nodeValue;
				if (roundUp=='True' && useNewBidder ) roundUp=true;  else roundUp=false;
				var totalFixed=xmlDoc.getElementsByTagName('totalFixed')[0].childNodes[0].nodeValue.replace('--','');
				if (totalFixed=='True') totalFixed=true;  else totalFixed=false;
				
				var MU=parseFloat(xmlDoc.getElementsByTagName('MU')[0].childNodes[0].nodeValue);
				var taxRate=parseFloat(xmlDoc.getElementsByTagName('taxRate')[0].childNodes[0].nodeValue)*.01;
				var overheadRate=parseFloat(xmlDoc.getElementsByTagName('overhead')[0].childNodes[0].nodeValue)*.01;
				
				var parts=parseFloat(xmlDoc.getElementsByTagName('parts')[0].childNodes[0].nodeValue);
				var labor=parseFloat(xmlDoc.getElementsByTagName('labor')[0].childNodes[0].nodeValue);
				var travel=parseFloat(xmlDoc.getElementsByTagName('travel')[0].childNodes[0].nodeValue);
				var equip=parseFloat(xmlDoc.getElementsByTagName('equip')[0].childNodes[0].nodeValue);
				var other=parseFloat(xmlDoc.getElementsByTagName('other')[0].childNodes[0].nodeValue);
				
				var fixedTotal=parseFloat(xmlDoc.getElementsByTagName('fixedTotal')[0].childNodes[0].nodeValue);
				
				var expenses=travel+equip+other; 
				
				Gebi('TotalTravel').innerHTML=formatCurrency(travel);
				Gebi('TotalEquip').innerHTML=formatCurrency(equip);
				Gebi('TotalOther').innerHTML=formatCurrency(other);
				
				
				if(useNewBidder)	{
					Gebi('TotalParts').innerHTML=formatCurrency(parts);
					Gebi('TotalLabor').innerHTML=formatCurrency(labor);
					if(totalFixed) { //Fixed Total 2010 Formula
						var LinkTotal = fixedTotal;
						var overhead=overheadRate*(parts+labor+expenses);
						var PL=parts+labor; var EO=expenses+overhead;
						var M=LinkTotal/(PL+(parts*taxRate)+EO);
						var tax=parts*taxRate;
						var profit=LinkTotal-PL-EO-tax;
						MU=Math.round((M-1)*100000)/1000;
					}
					else { //Fixed Margin 2010 Formula
						var overhead=overheadRate*(parts+labor+expenses);
						var PL=parts+labor; var EO=expenses+overhead; var M=1+(MU/100);
						var LinkTotal=(PL*M)+(parts*taxRate)+EO;
						var tax=parts*taxRate;
						
						if(roundUp) {
							var oldTot=LinkTotal;
							LinkTotal=Math.round(LinkTotal/10)*10;
							if(oldTot>LinkTotal) {LinkTotal+=10}
						}
						
						var profit=LinkTotal-PL-EO-tax;
						fixedTotal=LinkTotal;
					}
					
					var partsSell=parts*((MU/100)+1);
					var laborSell=labor*((MU/100)+1);
					
					Gebi('FixedPrice').innerHTML=currencyLink+(formatCurrency(fixedTotal));
					WSQLU('Links','FixedPrice',fixedTotal,'LinkID',LinkId);
					Gebi('MU').innerHTML=editLink+(MU);
					WSQLU('Links','MU',MU,'LinkID',LinkId);
					
					
					Gebi('LinkTotal').innerHTML=formatCurrency(LinkTotal);
	
					function p(number) {
						return Math.round((number/LinkTotal)*10000)/100
					}
					
				}
				else { // Old Formula
					Gebi('TotalParts').innerHTML=formatCurrency(parts*M);
					Gebi('TotalLabor').innerHTML=formatCurrency(labor*M);
					if(totalFixed) { //Fixed Total Old Formula
						var LinkTotal = fixedTotal;
						var overhead=overheadRate*(parts+labor+expenses);
						var PL=parts+labor; var EO=expenses+overhead;
						var M=LinkTotal/(PL+(parts*taxRate)+EO);
						var tax=(((parts)*M)+parts)*taxRate;
						var profit=LinkTotal-PL-EO-tax;
						MU=Math.round((M-1)*100000)/1000;
					}
					else { //Fixed Margin Old Formula
						var overhead=overheadRate*(parts+labor+expenses);
						var PL=parts+labor; var EO=expenses+overhead; var M=1+(MU/100);
						var LinkTotal=(PL*M)+((parts*M)*taxRate)+EO;
						var tax=(((parts)*M)+parts)*taxRate;
						
						if(roundUp) {
							var oldTot=LinkTotal;
							LinkTotal=Math.round(LinkTotal/10)*10;
							if(oldTot>LinkTotal) {LinkTotal+=10}
						}
						
						var profit=LinkTotal-PL-EO-tax;
						fixedTotal=LinkTotal;
					}
					
					var partsSell=parts*((MU/100)+1);
					var laborSell=labor*((MU/100)+1);
					
					Gebi('FixedPrice').innerHTML=currencyLink+(formatCurrency(fixedTotal));
					WSQLU('Links','FixedPrice',fixedTotal,'LinkID',LinkId);
					Gebi('MU').innerHTML=editLink+(MU);
					WSQLU('Links','MU',MU,'LinkID',LinkId);
					
					
					Gebi('LinkTotal').innerHTML=formatCurrency(LinkTotal);
	
					function p(number) {
						return Math.round((number/LinkTotal)*10000)/100
					}
					
					Gebi('PartsSell').innerHTML='<div style="float:left;">'+formatCurrency(partsSell)+'</div><div style="float:right;">'+p(partsSell)+'%</div>';
					Gebi('LaborSell').innerHTML='<div style="float:left;">'+formatCurrency(laborSell)+'</div><div style="float:right;">'+p(laborSell)+'%</div>';
				}
				Gebi('PartsCost').innerHTML='<div style="float:left;">'+formatCurrency(parts)+'</div><div style="float:right;">'+p(parts)+'%</div>';
				Gebi('LaborCost').innerHTML='<div style="float:left;">'+formatCurrency(labor)+'</div><div style="float:right;">'+p(labor)+'%</div>';
				Gebi('TravelCost').innerHTML='<div style="float:left;">'+formatCurrency(travel)+'</div><div style="float:right;">'+p(travel)+'%</div>';
				Gebi('EquipCost').innerHTML='<div style="float:left;">'+formatCurrency(equip)+'</div><div style="float:right;">'+p(equip)+'%</div>';
				Gebi('OtherCost').innerHTML='<div style="float:left;">'+formatCurrency(other)+'</div><div style="float:right;">'+p(other)+'%</div>';
				
				Gebi('TaxCost').innerHTML='<div style="float:left;">'+formatCurrency(tax)+'</div><div style="float:right;">'+p(tax)+'%</div>';
				Gebi('OverheadCost').innerHTML='<div style="float:left;">'+formatCurrency(overhead)+'</div><div style="float:right;">'+p(overhead)+'%</div>';
				
				Gebi('ProfitCost').innerHTML='<div style="float:left;">'+formatCurrency(profit)+'</div><div style="float:right;">'+p(profit)+'%</div>';
				
				var GraphSrc='pie.asp?GraphData=';
				var expensesP=p(travel+equip+other);
				var lessThan1=0;
				var expensesP=p(travel+equip+other);
				if(p(parts)>2)   {GraphSrc+='Materials_'+Math.round(p(parts) * 100) +'_'; } else { lessThan1 += p(parts) }
				if(p(labor)>2)   { GraphSrc+='.Labor_' + Math.round(p(labor) * 100) +'_'; } else { lessThan1 += p(labor) }
				if(expensesP>2)  {GraphSrc+='.Expenses_'+Math.round(expensesP*100)+'_'; } else { lessThan1+=expensesP }
				if(p(tax)>2)     { GraphSrc += '.Tax_' + Math.round( p(tax) * 100 ) + '_' ; } else { lessThan1 += p(tax) }
				if(p(overhead)>2){GraphSrc+='.Overhead_'+Math.round(p(overhead)*100)+'_'; } else { lessThan1+=p(overhead) }
				if(p(profit)>2)  {GraphSrc+='.Profit_' + Math.round(p(profit) * 100)+'_00FF00'; } else { lessThan1 += p(profit) }
				if(p(profit)<0)  { GraphSrc+= '.Loss_' + Math.round(p(profit) * 100)+'_'; }
				if(lessThan1>0) { GraphSrc+= '.<small><small>Everything Else</small></small>_' + Math.round(lessThan1 * 100)+'_'; }
																		//'.Everything<5%	
				Gebi('Graph').src=encodeURI(GraphSrc);
			}
			else {
				AjaxErr('There was a problem with the LinkCost request.', HttpText);
				return false
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}




function ProjectCost() {
	HttpText='ContactASP.asp?action=projectCost&projId='+projId;
	xhr=getXHRObject();
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4) {
			if(xhr.status==200) {
				try { var xmlDoc = xhr.responseXML.documentElement }
				catch(e) { AjaxErr(' There was a problem with the ProjectCost response.', HttpText) }

				var overhead;
				var tax;
				var profit;
				var LinkTotal;
				var partsSell;
				var laborSell;
				function LinkCost(totalFixed,roundUp,fixedTotal,overheadRate,parts,labor,expenses,MU,taxRate) {
					
					if(useNewBidder)	{
						if(totalFixed) { //Fixed Total 2010 Formula
							LinkTotal = fixedTotal;
							overhead=overheadRate*(parts+labor+expenses);
							var PLO=parts+labor+overhead;
							var M=LinkTotal/(PLO+(parts*taxRate)+expenses);
							tax=parts*taxRate;
							profit=LinkTotal-PLO-expenses-tax;
							MU=Math.round((M-1)*100000)/1000;
						}
						else { //Fixed Margin 2010 Formula
							overhead=overheadRate*(parts+labor+expenses);
							var PLO=parts+labor+overhead; var M=1+(MU/100);
							LinkTotal=(PLO*M)+(parts*taxRate)+expenses;
							tax=parts*taxRate;
							
							if(roundUp) {
								var oldTot=LinkTotal;
								LinkTotal=Math.round(LinkTotal/10)*10;
								if(oldTot>LinkTotal) {LinkTotal+=10}
							}
							
							profit=LinkTotal-PLO-expenses-tax;
							fixedTotal=LinkTotal;
						}
						
						partsSell=parts*((MU/100)+1);
						laborSell=labor*((MU/100)+1);
					}
					else { // Old Formula
						if(totalFixed) { //Fixed Total Old Formula
							LinkTotal = fixedTotal;
							overhead=overheadRate*(parts+labor+expenses);
							var PL=parts+labor; var EO=expenses+overhead;
							var M=LinkTotal/(PL+(parts*taxRate)+EO);
							tax=(((parts)*M)+parts)*taxRate;
							profit=LinkTotal-PL-EO-tax;
							MU=Math.round((M-1)*100000)/1000;
						}
						else { //Fixed Margin Old Formula
							overhead=overheadRate*(parts+labor+expenses);
							var PL=parts+labor; var EO=expenses+overhead; var M=1+(MU/100);
							LinkTotal=(PL*M)+((parts*M)*taxRate)+EO;
							tax=(((parts)*M)+parts)*taxRate;
							
							if(roundUp) {
								var oldTot=LinkTotal;
								LinkTotal=Math.round(LinkTotal/10)*10;
								if(oldTot>LinkTotal) {LinkTotal+=10}
							}
							
							profit=LinkTotal-PL-EO-tax;
							fixedTotal=LinkTotal;
							
							//alert(' P:'+parts+' L:'+labor+' E:'+expenses+' O:'+overhead+' T:'+tax);
						}
						
						partsSell=parts*((MU/100)+1);
						laborSell=labor*((MU/100)+1);
						
					}
					
					return LinkTotal;
				}
				//LinkCost(totalFixed,fixedTotal,overheadRate,parts,labor,expenses,MU,taxRate)
				
				var recordCount=xmlDoc.getElementsByTagName('recordCount')[0].childNodes[0].nodeValue;
				
				//AjaxErr(' There weren\'t any problems yet with the ProjectCost response.', HttpText)
				
				var projTotal=0;
				var pTotal=0;
				var lTotal=0;
				var eTotal=0;
				var oTotal=0;
				var tTotal=0;
				var profitTotal=0;
				
				for(r=1;r<=recordCount;r++) {
					var totalFixed = xmlDoc.getElementsByTagName('totalFixed'+r)[0].childNodes[0].nodeValue.replace('--','');
					totalFixed=(totalFixed.toLowerCase()=='true');
					var roundUp = xmlDoc.getElementsByTagName('roundUp'+r)[0].childNodes[0].nodeValue.replace('--','');
					if(roundUp=='True' && useNewBidder ) { roundUp=true; }  else  { roundUp=false; }
					var fixedTotal = parseFloat(xmlDoc.getElementsByTagName('fixedTotal'+r)[0].childNodes[0].nodeValue);
					var overheadRate = parseFloat(xmlDoc.getElementsByTagName('overhead'+r)[0].childNodes[0].nodeValue);
					var parts = parseFloat(xmlDoc.getElementsByTagName('parts'+r)[0].childNodes[0].nodeValue);
					var labor = parseFloat(xmlDoc.getElementsByTagName('labor'+r)[0].childNodes[0].nodeValue);
					var expenses = parseFloat(xmlDoc.getElementsByTagName('expenses'+r)[0].childNodes[0].nodeValue);
					var MU = parseFloat(xmlDoc.getElementsByTagName('MU'+r)[0].childNodes[0].nodeValue);
					var taxRate = parseFloat(xmlDoc.getElementsByTagName('taxRate'+r)[0].childNodes[0].nodeValue);
					
					projTotal+=LinkCost(totalFixed,roundUp,fixedTotal,overheadRate,parts,labor,expenses,MU,taxRate);
					pTotal+=parts;
					lTotal+=labor;
					eTotal+=expenses;
					oTotal+=overhead;
					tTotal+=tax;
					profitTotal+=profit;
				}
				
				Gebi('ProjectTotal').innerHTML=formatCurrency(projTotal);
				Gebi('ProjectTotal2').innerHTML=formatCurrency(projTotal);
				
				WSQLU('Projects','BidTotal',projTotal,'ProjID',projId);
				
				Gebi('PartsCost').innerHTML=formatCurrency(pTotal);
				Gebi('LaborCost').innerHTML=formatCurrency(lTotal);
				Gebi('ExpensesCost').innerHTML=formatCurrency(eTotal);
				Gebi('OverheadCost').innerHTML=formatCurrency(oTotal);
				Gebi('TaxCost').innerHTML=formatCurrency(tTotal);
				Gebi('ProfitCost').innerHTML=formatCurrency(profitTotal);
				
				
				function p(n) { return formatPercent(n/projTotal,2); }
				
				Gebi('PartsPerc').innerHTML=p(pTotal);
				Gebi('LaborPerc').innerHTML=p(lTotal);
				Gebi('ExpensesPerc').innerHTML=p(eTotal);
				Gebi('OverheadPerc').innerHTML=p(oTotal);
				Gebi('TaxPerc').innerHTML=p(tTotal);
				Gebi('ProfitPerc').innerHTML=p(profitTotal);
				
				pieSrc='pie.asp?GraphData=';
				function g(name,number) {
					number=Math.round(number);
					if (number>=10) { pieSrc+=name+'_'+number+'_'; }
				}
				
				g('Materials',pTotal);
				g('.Labor',lTotal);
				g('.Expenses',eTotal);
				g('.Overhead',oTotal);
				g('.Taxes',tTotal);
				g('.Profit',profitTotal);
				
				Gebi('costPie').src=pieSrc;
			}
			else {
				AjaxErr('There was a problem with the ProjectCost request.', HttpText);
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