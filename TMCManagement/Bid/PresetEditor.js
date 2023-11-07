
var oldHTML= new Array;
function editField(fieldBox) {
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1].replace('<div>','').replace('</div>','');
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="saveField(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function saveField(fBox) { 
	WSQLU('BidPresets', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'BidPresetID', pId);
	fBox.innerHTML='<a class=editLink onclick=editField(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
}


function editNotes(fieldBox) {
	var fieldValue=CharsBr2CR(fieldBox.innerHTML.split('</a>')[1]);
	Gebi('oldNotes').innerHTML=fieldBox.innerHTML;
	var newHTML='<textarea id='+fieldBox.id+'Value style="float:left; font-size:12px; height:100%; width:80%;" >'+fieldValue+'</textarea>';
	newHTML+='<div align=center style="float:right; height:100%; overflow:hidden; padding-top:2px; text-align:center; width:19%;"><div class="editButton" style=width:90%; onclick=saveNotes(this.parentNode.parentNode);>save</div>';
	newHTML+="<div class=editButton style=width:90%; onclick=this.parentNode.parentNode.innerHTML=Gebi('oldNotes').innerHTML;>cancel</div>";
	newHTML+='</div>';
	fieldBox.innerHTML=newHTML;
}
function saveNotes(fBox) { 
	WSQLU('BidPresets', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'BidPresetID', pId);
	fBox.innerHTML='<a class=editLink onclick=editNotes(this.parentNode);>Edit</a>'+CharsCR2Br(Gebi(fBox.id+'Value').value);
}

var bpSysOldIndex;
function b4sysChange() { bpSysOldIndex=Gebi('BidPresetSystem').selectedIndex; }
function systemChange() {
	if(confirm('Change system type to "'+SelI('BidPresetSystem').innerHTML+'"?')) {
		WSQLU('BidPresets','BidPresetSystemID',SelI('BidPresetSystem').value,'BidPresetID',pId);
		WSQLU('BidPresets','BidPresetSystem',SelI('BidPresetSystem').innerHTML,'BidPresetID',pId);
		SelI('BidPresetSystem')
	} else {
		Gebi('BidPresetSystem').selectedIndex=bpSysOldIndex;
		return false;
	}
}

function Rollup(arrow,rollUpDivId) {
	if(Gebi(rollUpDivId).style.display!='none') {
		arrow.innerHTML='►';
		Gebi(rollUpDivId).style.display='none';
	}
	else {
		arrow.innerHTML='▼';
		Gebi(rollUpDivId).style.display='block';
	}
}

function RollupC(arrow,rollUpDivId,CollapseDiv) {
	if(Gebi(rollUpDivId).style.display!='none') {
		arrow.innerHTML='►';
		Gebi(rollUpDivId).style.display='none';
	}
	else {
		arrow.innerHTML='▼';
		Gebi(rollUpDivId).style.display='block';
	}
	Collapse(CollapseDiv);
}

function Collapse(div) {
	var h=div.getAttribute('height').replace('px','');
	if(div.offsetHeight<h) { 
		div.style.height=h+('px');
	}
	else { div.style.height='32px'; }
}

function editPart(rowNum) {
	function fieldEdit(box) {
		box.setAttribute('contentEditable','true');
		box.style.fontFamily='Consolas';
		box.focus();
		box.select;
	}
	
	Gebi('Part-Edit'+rowNum).setAttribute('class', 'rowSave');
	Gebi('Part-Edit'+rowNum).setAttribute('onclick', 'savePart('+rowNum+')');
	
	fieldEdit(Gebi('Part-Qty'+rowNum));
}

function savePart(rowNum) {
	var bidItemsId=Gebi('Part-BidPresetItemsID'+rowNum).innerHTML
	
	function fieldSave(box, fieldName) {
		WSQL("UPDATE BidPresetItems SET "+fieldName+"='"+CharsEncode(box.innerHTML)+"' WHERE BidPresetItemsId="+bidItemsId);
		box.setAttribute('contentEditable','false');
		box.style.fontFamily='';
		box.style.backgroundColor='transparent';
	}

	Gebi('Part-Edit'+rowNum).setAttribute('class', 'rowEdit');
	Gebi('Part-Edit'+rowNum).setAttribute('onclick', 'editPart('+rowNum+')');

	Gebi('Part-Qty'+rowNum).style.backgroundColor='#F88';

	fieldSave(Gebi('Part-Qty'+rowNum),'Qty');
	//systemCost(sysId);
}



function editLabor(rowNum) {
	function fieldEdit(box) {
		box.setAttribute('contentEditable','true');
		box.style.fontFamily='Consolas';
		box.focus();
	}
	
	Gebi('Labor-Edit'+rowNum).setAttribute('class', 'rowSave');
	Gebi('Labor-Edit'+rowNum).setAttribute('onclick', 'saveLabor('+rowNum+')');
	
	fieldEdit(Gebi('Labor-Qty'+rowNum));
}

function saveLabor(rowNum) {
	var bidItemsId=Gebi('Labor-BidPresetItemsID'+rowNum).innerHTML
	
	function fieldSave(box, fieldName) {
		WSQL("UPDATE BidPresetItems SET "+fieldName+"='"+CharsEncode(box.innerHTML)+"' WHERE BidPresetItemsId="+bidItemsId);
		box.setAttribute('contentEditable','false');
		box.style.fontFamily='';
		box.style.backgroundColor='transparent';
	}

	Gebi('Labor-Edit'+rowNum).setAttribute('class', 'rowEdit');
	Gebi('Labor-Edit'+rowNum).setAttribute('onclick', 'editLabor('+rowNum+')');
	
	Gebi('Labor-Qty'+rowNum).style.backgroundColor='#F88';
	fieldSave(Gebi('Labor-Qty'+rowNum),'Qty');
	//systemCost(sysId);
}


function updatePartRow(row) { 
	if(Gebi('Part-Qty'+row).innerHTML<=0) { Gebi('pRow'+row).style.color='#C00'; }
	if(Gebi('Part-Qty'+row).innerHTML>0) { Gebi('pRow'+row).style.color='#000'; }
}
function updateLaborRow(row) {
	if(Gebi('Labor-Qty'+row).innerHTML<=0) { Gebi('lRow'+row).style.color='#C00'; }
	if(Gebi('Labor-Qty'+row).innerHTML>0) { Gebi('lRow'+row).style.color='#000'; }
}


function ShowAddPart() {
	Gebi('Modal').style.display = 'block';
	Gebi('AddPartContainer').style.display = 'block';
}   
function HideAddPart() {
	Gebi('Modal').style.display = 'none';
	Gebi('AddPartContainer').style.display = 'none';
}

function ShowAddLabor() {
	Gebi('Modal').style.display = 'block';
	Gebi('AddLaborContainer').style.display = 'block';
}   
function HideAddLabor() {
	Gebi('Modal').style.display = 'none';
	Gebi('AddLaborContainer').style.display = 'none';
}







                                            /////////////////////////////////////////////////
////////////////////////////////////////// //                     AJAX                    // /////////////////////////////////                                          /////////////////////////////////////////////////



var xhr
var HttpText ='';

function getXHRObject() {
	var xhr=null;
	try { // Firefox, Opera 8.0+, Safari
		xhr=new XMLHttpRequest();
	}
	catch (e) {
		// Internet Explorer
		try { xhr=new ActiveXObject("Msxml2.XMLHTTP"); }
		catch (e) { xhr=new ActiveXObject("Microsoft.XMLHTTP"); }
	}
	
	if (xhr==null) {
		alert ("Your browser does not support AJAX!");
		return;
	}
	
	return xhr;
}

pRow=10000;
function AddPart(PartID) {
	HttpText='BidASP.asp?action=AddPresetPart&PartID='+PartID+'&pId='+pId;
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
			var pIId = xmlDoc.getElementsByTagName("BidPresetItemsId")[0].childNodes[0].nodeValue;
			var Manufacturer = xmlDoc.getElementsByTagName("Manufacturer")[0].childNodes[0].nodeValue;
			var PN = xmlDoc.getElementsByTagName('PN')[0].childNodes[0].nodeValue.replace('--','');
			var Desc = xmlDoc.getElementsByTagName('Desc')[0].childNodes[0].nodeValue.replace('--','');
			var Cost = xmlDoc.getElementsByTagName('Cost')[0].childNodes[0].nodeValue.replace('--','');
			
			//Gebi('PartsTabMain').innerHTML += ProjID;
			//PartsList(SysID);
			var newRow='';
			pRow++;
			newRow +='<div id=pRow'+pRow+' class="ProjInfoListRow" style="color:#C00;">';
			newRow +='	<div id=Part-BidPresetItemsID'+pRow+' style="display:none;">'+pIId+'</div>';
			newRow +='	<div style="width:4%;" align="center"><input id=pSel'+pRow+' class=partCheckbox name=partCheckbox type=checkbox style="width:100%;"/></div>';
			newRow +='	<div style="width:4%;"><div id=Part-Edit'+pRow+' class=rowEdit onClick="editPart('+pRow+');"></div></div>';
			newRow +='	<div style="width:7%;" class=taRPi id=Part-Qty'+pRow+' onKeyUp=updatePartRow('+pRow+');>0</div>';
			newRow +='	<div style="width:15%;" class=taLPi id=Part-Manufacturer'+pRow+'>'+Manufacturer+'</div>';
			newRow +='	<div style="width:17%;" class=taLPi id=Part-PartNumber'+pRow+'>'+PN+'</div>';
			newRow +='	<div style="width:40%; text-align:left;" class=taLPi id=Part-Description'+pRow+'>'+Desc+'</div>';
			newRow +='	<div style="width:13%;" class=taRPi id=Part-Cost'+pRow+' onKeyUp=updatePartRow('+pRow+');>'+formatCurrency(Cost)+'</div>';
			newRow +='</div>';
			Gebi('BidSystemsParts').innerHTML+=newRow;
			//Gebi('partsTotal').innerHTML++;
		}
		else {
			AjaxErr('There was a problem with the AddPart request. Continue?',HttpText);
		}
	}
}


function AddLabor(LaborID) {
	HttpText='BidASP.asp?action=AddPresetLabor&LaborID='+LaborID+'&pId='+pId;
	xhr = getXHRObject();
	xhr.onreadystatechange = ReturnAddLabor;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}
function ReturnAddLabor() {
	if (xhr.readyState == 4) {
		if (xhr.status == 200) {
			//AjaxErr('Looking at Addpart.',HttpText);
			try { var xmlDoc = xhr.responseXML.documentElement; }
			catch(e) { AjaxErr('There was an issue with the AddPart response.',HttpText); }
			var pIId = xmlDoc.getElementsByTagName('BidPresetItemsId')[0].childNodes[0].nodeValue;
			var Category = xmlDoc.getElementsByTagName('Category')[0].childNodes[0].nodeValue.replace('--','');
			var LaborName = xmlDoc.getElementsByTagName('LaborName')[0].childNodes[0].nodeValue.replace('--','');
			var Desc = xmlDoc.getElementsByTagName('Desc')[0].childNodes[0].nodeValue.replace('--','');
			var Cost = xmlDoc.getElementsByTagName('Cost')[0].childNodes[0].nodeValue.replace('--','');
			
			//Gebi('PartsTabMain').innerHTML += ProjID;
			//PartsList(SysID);
			var newRow='';
			lRow++;
			newRow +='<div id=lRow'+lRow+' class="ProjInfoListRow" style="color:#C00;">';
			newRow +='	<div id=Labor-BidPresetItemsID'+lRow+' style="display:none;">'+pIId+'</div>';
			newRow +='	<div style="width:4%;" align="center"><input id=pSel'+pRow+' class=partCheckbox name=partCheckbox type=checkbox style="width:100%;"/></div>';
			newRow +='	<div style="width:4%;"><div id=Labor-Edit'+lRow+' class=rowEdit onClick="editLabor('+pRow+');"></div></div>';
			newRow +='	<div style="width:5%;" class=taRPi id=Labor-Qty'+lRow+' onKeyUp=updateLaborRow('+pRow+');>0</div>';
			newRow +='	<div style="width:27%;" class=taLPi id=Labor-Name'+lRow+'>'+LaborName+'</div>';
			newRow +='	<div style="width:50%; text-align:left;" class=taLPi id=Labor-Description'+pRow+'>'+Desc+'</div>';
			newRow +='	<div style="width:10%;" class=taRPi id=Labor-Cost'+lRow+' onKeyUp=updateLaborRow('+pRow+');>'+formatCurrency(Cost)+'</div>';
			newRow +='</div>';
			Gebi('BidSystemsLabor').innerHTML+=newRow;
			//Gebi('partsTotal').innerHTML++;
		}
		else {
			AjaxErr('There was a problem with the AddLabor request. Continue?',HttpText);
		}
	}
}



function deleteBidItems(checkClass) {
	if(!confirm('Selected Items will be deleted!')) return false;
	
	if(checkClass=='partCheckbox') { pOrL='p'; partOrLabor='Part'; partsOrLabor='parts'}
	if(checkClass=='laborCheckbox') { pOrL='l'; partOrLabor='Labor'; partsOrLabor='labor'}
	var checkboxes=document.getElementsByClassName(checkClass);
	
	function doTheDeleteThing() {
		var checkboxes=document.getElementsByClassName(checkClass);
		for(c=0;c<checkboxes.length;c++) {
			if(checkboxes[c].checked) {
				var Row=Gebi(checkboxes[c].id.replace(pOrL+'Sel', pOrL+'Row'));
				var BidItemsIdId=checkboxes[c].id.replace(pOrL+'Sel', partOrLabor+'-BidPresetItemsID');
				//Gebi('Junk').innerHTML+=BidItemsIdId+'<br/><br/>';
				var BidPresetItemsId=Gebi(BidItemsIdId).innerHTML;
				WSQL('DELETE FROM BidPresetItems WHERE BidPresetItemsID='+BidPresetItemsId);
				Row.parentNode.removeChild(Row);
				var Qty=Gebi(partOrLabor+'-Qty'+Row.id.replace(pOrL+'Row',''));
				Gebi(partsOrLabor+'Total').innerHTML-=Qty.innerHTML;
			}
		}
	}
	//  I can't figure out why it won't delete parts that are immediately 
	//after one that it does delete, but here is a neato band aid:
	for(d=0;d<checkboxes.length*3;d++) { doTheDeleteThing(); }
	//systemCost(sysId);
}


/** /
function AddExpense(Type,SubType,Origin,Dest,Units,Cost) {
	var sysId = Gebi("SysPage").contentWindow.sysId;
	//var MU = Gebi('SysExpFrame').contentWindow.document.getElementById("MU").value;
	
	//alert(sysId);
	SubType=CharsEncode(SubType);
	Origin=CharsEncode(Origin);
	Dest=CharsEncode(Dest);
	HttpText='BidASP.asp?action=AddExpense&Type='+Type+'&SubType='+SubType+'&Origin='+Origin+'&Dest='+Dest+'&Units='+Units+'&Cost='+Cost+'&SysID='+sysId;
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
/**/

function ModalMouseMove() {}