// JavaScript Document   AJAX CONTROLS

var xhr
var HttpText ='';
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function getXHRObject(){
	var xhr=null;
	try {
		// Firefox, Opera 8.0+, Safari
		xhr=new XMLHttpRequest();
	}
	catch (e) {
		// Internet Explorer
		try {
			xhr=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e) {
			xhr=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
	if (xhr==null) {
		alert ("Your browser does not support AJAX!");
		return;
	}
	
	return xhr;
}
//------------------------------------------------------------------------------------------------


function LoginCheck() {
	HttpText='RED2.asp?action=reLogin&user='+sessionUser+'&userName='+sessionUserName+'&EmpId='+sessionEmpId+'&userEmail='+sessionUserEmail;
	xhr=getXHRObject()
	xhr.onreadystatechange=function () {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
			
				try	{	var xmlDoc = xhr.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the LoginCheck response.',HttpText);	
				}
				
				//var RecordCount= xmlDoc.getElementsByTagName('RecordCount')[0].childNodes[0].nodeValue.replace('--','');
			}
			else {
				AjaxErr('There was a problem with the LoginCheck request.',HttpText);
			}
		}
	}
	xhr.open('GET',HttpText,true);
	xhr.send(null)
}








function AddPart(PartID) {
	var sysId = Gebi("SysPage").contentWindow.sysId;
	//var MU = Gebi('SysExpFrame').contentWindow.document.getElementById("MU").value;
	
	//alert(PartID);
	HttpText='BidASP.asp?action=AddPart&PartID='+PartID+'&SysID='+sysId;//+'&MU='+MU;
	xhr = getXHRObject();
	xhr.onreadystatechange = ReturnAddPart;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}
function AddBlankPart() {
	//var MU = Gebi('SysInfoFrame').contentWindow.document.getElementById("MU").value;

	HttpText='BidsASP.asp?action=AddPart&PartID=0&SysID='+Gebi("SysPage").contentWindow.sysId;
	xhr = getXHRObject();
	xhr.onreadystatechange = ReturnAddPart;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}
function ReturnAddPart() {
	if (xhr.readyState == 4) {
		if (xhr.status == 200) {
			//AjaxErr('Looking at Addpart.',HttpText);
			var xmlDoc = xhr.responseXML.documentElement;
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


function PartsList(SysID) {
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
				
				var MU=Gebi('SysPage').contentWindow.MU
				var partListDiv=Gebi('SysPage').contentWindow.document.getElementById('BidSystemsParts')
				partListDiv.innerHTML='';
				
				var BidItemsID;
				var Qty;
				var Manufacturer;
				var ItemName;
				var ItemDescription;
				var Cost;
				
				var rowHTML;
				var pRow=100000;
				for(r=1;r<=recordCount;r++)	{
					
					BidItemsID=xmlDoc.getElementsByTagName('BidItemsID'+r)[0].childNodes[0].nodeValue;
					Qty=xmlDoc.getElementsByTagName('Qty'+r)[0].childNodes[0].nodeValue;
					Manufacturer=xmlDoc.getElementsByTagName('Manufacturer'+r)[0].childNodes[0].nodeValue;
					ItemName=xmlDoc.getElementsByTagName('ItemName'+r)[0].childNodes[0].nodeValue;
					ItemDescription=xmlDoc.getElementsByTagName('ItemDescription'+r)[0].childNodes[0].nodeValue;
					Cost=xmlDoc.getElementsByTagName('Cost'+r)[0].childNodes[0].nodeValue;
					
					pRow++;
					rowHTML='';
					rowHTML+='<div id=pRow'+pRow+' class="ProjInfoListRow">';
					rowHTML+='	<div id=Part-BidItemsID'+pRow+' class="partCheckbox" style="display:none">'+BidItemsID+'</div>';
					rowHTML+='	<div style="width:3%;" align="center"><input id=pSel'+pRow+' type="checkbox" style="width:100%;"/></div>';
					rowHTML+='	<div style="width:3%;"><div id=Part-Edit'+pRow+' class=rowEdit onClick="editPart('+pRow+');"></div></div>';
					rowHTML+='	<div style="width:4%;" id=Part-Qty'+pRow+'>'+Qty+'</div>';
					rowHTML+='	<div style="width:15%;" id=Part-Manufacturer'+pRow+'>'+Manufacturer+'</div>';
					rowHTML+='	<div style="width:15%;" id=Part-PartNumber'+pRow+'>'+ItemName+'</div>';
					if(useNewBidder) {
						rowHTML+='	<div style="width:40%;" id=Part-ItemDescription'+pRow+'>'+ItemDescription+'</div>';
						rowHTML+='	<div style="width:10%;" id=Part-Cost'+pRow+'>'+formatCurrency(Cost)+'</div>';
						rowHTML+='	<div style="width:10%;" id=Part-Total'+pRow+'>'+formatCurrency(Cost*Qty)+'</div>';
					}
					else {
						rowHTML+='		<div style="width:30%;" id=Part-ItemDescription'+pRow+'>'+ItemDescription+'</div>';
						rowHTML+='		<div style="width:10%;" id=Part-Cost'+pRow+'>'+formatCurrency(Cost)+'</div>';
						rowHTML+='		<div style="width:10%;" id=Part-Sell'+pRow+'>'+formatCurrency(Cost*MU*.01)+'</div>';
						rowHTML+='		<div style="border-right:none; width:10%;" id=Part-Total'+pRow+'>'+formatCurrency((Cost*MU*.01)*Qty)+'</div>';
					}
					rowHTML+='</div>';

					partListDiv.innerHTML+=rowHTML;
				}
			}
			else {
				AjaxErr('There was a problem with the PartsList request.\n'+xhr.readyState+'\n Continue?',HttpText);
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}