//Javascript Document

function showTab(tab)	{
	
	var tabPage=Gebi(tab.id.replace('Tab','Page'));
	
	var activeTab=document.getElementsByClassName('activeTab')[0];
	activeTab.setAttribute('class','tab');
	
	var activeTabPage=document.getElementsByClassName('activeTabPage')[0];
	activeTabPage.setAttribute('class','tabPage');

	tab.setAttribute('class','activeTab');
	tabPage.setAttribute('class','activeTabPage');
}



var oldHTML= new Array;
function editField(fieldBox) {
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1].replace('<div>','').replace('</div>','');
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="saveField(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function saveField(fBox) { 
	WSQLU('MonitoringAccounts', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'Id', AcctId);
	fBox.innerHTML=editLink+Gebi(fBox.id+'Value').value;
}

function editPhone(fieldBox) {
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=(fieldBox.innerHTML.split('</a>')[1].replace('<div>','').replace('</div>',''));
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="savePhone(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function savePhone(fBox) {
	var value=unPhone(Gebi(fBox.id+'Value').value)//.replace(/\(/g,'').replace(/\)/g,'').replace(/-/g,'').replace(/./g,'');
	//Gebi('AcctInfoTitle').innerHTML=value;
	WSQLU('MonitoringAccounts', fBox.id, value, 'Id', AcctId);
	fBox.innerHTML=phoneLink+formatPhone(Gebi(fBox.id+'Value').value);
}

function editCurrency(fieldBox) {
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="saveCurrency(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function saveCurrency(fBox) { 
	WSQLU('MonitoringAccounts', fBox.id, unCurrency(Gebi(fBox.id+'Value').value), 'Id', AcctId);
	fBox.innerHTML=currencyLink+Gebi(fBox.id+'Value').value;
}

function editNotes(fieldBox) {
	var fieldValue=CharsBr2CR(fieldBox.innerHTML.split('</a>')[1]);
	Gebi('oldNotes').innerHTML=fieldBox.innerHTML;
	var newHTML='<textarea id='+fieldBox.id+'Value style="float:left; font-size:12px; height:100%; width:80%;" >'+fieldValue+'</textarea>';
	newHTML+='<div align=center style="float:right; height:100%; overflow:hidden; padding-top:2px; text-align:center; width:19%;">';
	newHTML+='	<div class="editButton" style=width:90%; onclick=saveNotes(this.parentNode.parentNode);>save</div><br/>';
	newHTML+="	<div class=editButton style=width:90%; onclick=this.parentNode.parentNode.innerHTML=Gebi('oldNotes').innerHTML;>cancel</div>";
	newHTML+='</div>';
	fieldBox.innerHTML=newHTML;
}
function saveNotes(fBox) { 
	WSQLU('MonitoringAccounts', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'Id', AcctId);
	fBox.innerHTML=notesLink+CharsCR2Br(Gebi(fBox.id+'Value').value);
}


function dateField(fieldBox) {
	var oldHTML=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	var displayCal='displayCalendar(Gebi(\''+fieldBox.id+'Value\'),\'mm/dd/yyyy\',\'+fieldValue+\')';
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'" onfocus="'+displayCal+'"/>';
	fieldBox.innerHTML+='<img class=editImg src="../../images/cal24x24.gif" onclick="'+displayCal+'" />';
	fieldBox.innerHTML+='<div class="editButton" onclick="saveDate(this.parentNode);">save</div>';
	fieldBox.innerHTML+='<div class="editButton" onclick="this.parentNode.innerHTML=\'<a class=editLink onclick=dateField(this.parentNode);>Edit</a>'+fieldValue+'\';">cancel</div>';
}
function saveDate(fBox) { 
	WSQLU('MonitoringAccounts', fBox.id, Gebi(fBox.id+'Value').value, 'Id', AcctId);
	fBox.innerHTML=Gebi(fBox.id+'Value').value+dateLink;
}

function editCheck(field,bit)	{
	var trueOrFalse;
	if(bit) trueOrFalse='True';
	else trueOrFalse='False';
	
	WSQLU('MonitoringAccounts', field, trueOrFalse, 'Id', AcctId);
}

function showNewSys() {
	Gebi('Modal').style.display='block';
	Gebi('NewSysBox').style.display='block';
}
function hideNewSys() {
	Gebi('Modal').style.display='none';
	Gebi('NewSysBox').style.display='none';
}

function showAddCust() {
	Gebi('Modal').style.display='block';
	Gebi('addCustBox').style.display='block';
	Gebi('custName').focus();
}
function hideAddCust() {
	Gebi('Modal').style.display='none';
	Gebi('addCustBox').style.display='none';
}

function addCust(id,name) {
	WSQLs('UPDATE MonitoringAccounts SET CustId='+id+' WHERE Id='+AcctId);
	//Gebi('Customers').innerHTML=Gebi('Customers').innerHTML.replace('</div><div','</div><div class=systemLink>'+name+'</div><div');
	//hideAddCust();
	window.location=window.location;
}

function showAddProv() {
	Gebi('Modal').style.display='block';
	Gebi('addProvBox').style.display='block';
	Gebi('provName').focus();
	Gebi('provSearchForm').submit();
}
function hideAddProv() {
	Gebi('Modal').style.display='none';
	Gebi('addProvBox').style.display='none';
}

function addProv(id,name) {
	WSQLs('UPDATE MonitoringAccounts SET ProviderId='+id+' WHERE Id='+AcctId);
	//Gebi('Customers').innerHTML=Gebi('Customers').innerHTML.replace('</div><div','</div><div class=systemLink>'+name+'</div><div');
	//hideAddCust();
	window.location=window.location;
}

function deleteCusts() {
	if(!confirm('All customers will be removed.')) { return false; }
	WSQLs('DELETE FROM BidTo WHERE AcctID='+AcctId);
	window.location=window.location;
}



function loadSystem(sysId)	{
	Gebi('SysPage').setAttribute('src','BidSystems.asp?sysId='+sysId+'&nocache='+noCache);
	showTab(Gebi('SysTab'));
}



function ShowAddPart() {
	//Gebi('Modal').style.display = 'block';
	//Gebi('AddPartContainer').style.display = 'block';
	FadeIn(Gebi('Modal'));
	setTimeout("FadeIn(Gebi('AddPartContainer'));",333);
	setTimeout("Gebi('AddPartBox').contentWindow.Gebi('SearchPartsTxt').focus();",500);
	//setTimeout("Gebi('AddPartBox').contentWindow.getElementById('SearchPartsTxt').focus();",300);
}   
  
function HideAddPart() {
	//Gebi('Modal').style.display = 'none';
	//Gebi('AddPartContainer').style.display = 'none';
	FadeOut(Gebi('AddPartContainer'));
	setTimeout("FadeOut(Gebi('Modal'));",250);
}

function ShowAddLabor() {
	//Gebi('Modal').style.display = 'block';
	//Gebi('AddLaborContainer').style.display = 'block';
	FadeIn(Gebi('Modal'));
	setTimeout("FadeIn(Gebi('AddLaborContainer'));",333);
	setTimeout("Gebi('AddLaborBox').contentWindow.Gebi('SearchLaborTxt').focus();",500);
}   
  
function HideAddLabor() {
	//Gebi('Modal').style.display = 'none';
	//Gebi('AddLaborContainer').style.display = 'none';
	FadeOut(Gebi('AddLaborContainer'));
	setTimeout("FadeLabor(Gebi('Modal'));",250);
}



function ShowAddTravel() {
	Gebi('Modal').style.display = 'block';
	Gebi('AddTravelContainer').style.display = 'block';
}   
function HideAddTravel() {
	Gebi('Modal').style.display = 'none';
	Gebi('AddTravelContainer').style.display = 'none';
}

var InnerMX, InnerMY
var mDown= new Array(false,false,false,false,false,false,false);
var BoxX;
var BoxY;
var OldBoxTop;
var OldBoxLeft;
var InnerMX;
var InnerMY;
var iMX;
var iMY;
function PartsMouseMove(event,boxID) {
	if (!event){event = window.event;}
	mX = event.clientX+Gebi(boxID).offsetLeft;
	mY = event.clientY+Gebi(boxID).offsetTop;
	iMX = event.clientX;
	iMY = event.clientY;
	
	if( !!InnerMX && !!InnerMY ) {
		if( mX >= 0  &&  mY >= 0  &&  mX < Gebi(boxID).offsetWidth ) { //&&mY<Gebi(boxID).offsetHeight-64
			//window.top.document.getElementById('UnderTabs').innerHTML='mX:'+mX+', mY:'+mY+', ix:'+InnerMX+', iy:'+InnerMY+'  -  Buttons:'+mDown;
			if(mDown[0]) { //left mouse button
				Gebi(boxID).style.left = (mX-InnerMX)+'px';
				Gebi(boxID).style.top = (mY-InnerMY)+'px';
			}
		}
	}
}

function PartsMouseDown(event) {
	//BoxX=mX; BoxY=mY;
	//window.top.document.getElementById('UnderTabs').innerHTML=event;
	InnerMX=iMX; InnerMY=iMY;
	mDown[event.button]=true;
}

function PartsMouseUp(event) { mDown[event.button]=false; }

function ModalMouseMove(event,boxID){
	if (!event){event = window.event;}
	mX = event.clientX;
	mY = event.clientY;
	iMX = /**/Gebi(boxID).offsetLeft-/**/event.clientX;
	iMY = /**/Gebi(boxID).offsetTop-/**/event.clientY;
	
	
	if(!!InnerMX&&!!InnerMY)
	{
		//if(mX>=0&&mY>=0&&mX<Gebi(boxID).offsetWidth)//&&mY<Gebi(boxID).offsetHeight-64
		//{
			//window.top.document.getElementById('UnderTabs').innerHTML='mX:'+mX+', mY:'+mY+', ix:'+InnerMX+', iy:'+InnerMY+'  -  Buttons:'+event.button//mDown;
		if(mDown[0]) { //left mouse button
			Gebi(boxID).style.left = (mX+InnerMX)+'px';
			Gebi(boxID).style.top = (mY+InnerMY)+'px';
		}
	//}
	}
}





function checkAll(klass, checked) {
	var checks=document.getElementsByClassName(klass);
	for(c=0;c<checks.length;c++) { checks[c].checked=checked; }
}


function deleteBidItems(checkClass) {
	if(!confirm('Selected Items will be deleted!')) return false;
	
	if(checkClass=='partCheckbox') { pOrL='p'; partOrLabor='Part'}
	if(checkClass=='laborCheckbox') { pOrL='l'; partOrLabor='Labor'}
	var checkboxes=document.getElementsByClassName(checkClass);
	
	function doTheDeleteThing() {
		var checkboxes=document.getElementsByClassName(checkClass);
		for(c=0;c<checkboxes.length;c++) {
			if(checkboxes[c].checked) {
				var Row=Gebi(checkboxes[c].id.replace(pOrL+'Sel', pOrL+'Row'))
				var BidItemsIdId=checkboxes[c].id.replace(pOrL+'Sel', partOrLabor+'-BidItemsID');
				//Gebi('Junk').innerHTML+=BidItemsIdId+'<br/><br/>';
				var BidItemsId=Gebi(BidItemsIdId).innerHTML;
				WSQL('DELETE FROM BidItems WHERE BidItemsID='+BidItemsId);
				Row.parentNode.removeChild(Row);
			}
		}
	}
	
	//  I can't figure out why it won't delete parts that are immediately 
	//after one that it does delete, but here is a neato band aid:
	for(d=0;d<checkboxes.length*3;d++) { doTheDeleteThing(); }
	systemCost(sysId);
}



function deleteExpenses(checkClass) {
	if(!confirm('Selected '+checkClass.replace('Checkbox','')+' items will be deleted!')) return false;
	
	if(checkClass=='travelCheckbox') { tOrEOrO='t'; travelOrEquipOrOther='Travel'}
	if(checkClass=='equipCheckbox') { tOrEOrO='e'; travelOrEquipOrOther='Equip'}
	if(checkClass=='otherCheckbox') { tOrEOrO='o'; travelOrEquipOrOther='Other'}
	var checkboxes=document.getElementsByClassName(checkClass);
	
	for(c=0;c<checkboxes.length;c++) {
		if(checkboxes[c].checked) {
			var Row=Gebi(checkboxes[c].id.replace(tOrEOrO+'Sel', tOrEOrO+'Row'))
			var ExpenseIdId=checkboxes[c].id.replace(tOrEOrO+'Sel', travelOrEquipOrOther+'-ExpenseID');
			//Gebi('Junk').innerHTML+=BidItemsIdId+'<br/><br/>';
			var ExpenseId=Gebi(ExpenseIdId).innerHTML;
			WSQL('DELETE FROM Expenses WHERE ExpenseID='+ExpenseId);
			Row.parentNode.removeChild(Row);
		}
	}
	//  I can't figure out why it won't delete parts that are immediately 
	//after one that it does delete, but here is a neato band aid:
	for(d=0;d<checkboxes.length*3;d++) { doTheDeleteThing(checkClass); }
	systemCost(sysId);
}
function doTheDeleteThing(checkClass) {
	var checkboxes=document.getElementsByClassName(checkClass);
	for(c=0;c<checkboxes.length;c++) {
		if(checkboxes[c].checked) {
			var Row=Gebi(checkboxes[c].id.replace(tOrEOrO+'Sel', tOrEOrO+'Row'))
			var ExpenseIdId=checkboxes[c].id.replace(tOrEOrO+'Sel', travelOrEquipOrOther+'-ExpenseID');
			//Gebi('Junk').innerHTML+=BidItemsIdId+'<br/><br/>';
			var ExpenseId=Gebi(ExpenseIdId).innerHTML;
			WSQL('DELETE FROM Expenses WHERE ExpenseID='+ExpenseId);
			Row.parentNode.removeChild(Row);
		}
	}
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
	
	fieldEdit(Gebi('Part-Cost'+rowNum));
	fieldEdit(Gebi('Part-ItemDescription'+rowNum));
	fieldEdit(Gebi('Part-PartNumber'+rowNum));
	fieldEdit(Gebi('Part-Manufacturer'+rowNum));
	fieldEdit(Gebi('Part-Qty'+rowNum));
}

function savePart(rowNum) {
	var bidItemsId=Gebi('Part-BidItemsID'+rowNum).innerHTML
	
	function fieldSave(box, fieldName) {
		WSQL("UPDATE BidItems SET "+fieldName+"='"+CharsEncode(box.innerHTML)+"' WHERE BidItemsId="+bidItemsId);
		box.setAttribute('contentEditable','false');
		box.style.fontFamily='';
		box.style.backgroundColor='transparent';
	}

	Gebi('Part-Edit'+rowNum).setAttribute('class', 'rowEdit');
	Gebi('Part-Edit'+rowNum).setAttribute('onclick', 'editPart('+rowNum+')');
	
	Gebi('Part-Cost'+rowNum).innerHTML=unCurrency(Gebi('Part-Cost'+rowNum).innerHTML);
	Gebi('Part-Cost'+rowNum).style.backgroundColor='#F88';
	Gebi('Part-ItemDescription'+rowNum).style.backgroundColor='#F88';
	Gebi('Part-PartNumber'+rowNum).style.backgroundColor='#F88';
	Gebi('Part-Manufacturer'+rowNum).style.backgroundColor='#F88';
	Gebi('Part-Qty'+rowNum).style.backgroundColor='#F88';
	fieldSave(Gebi('Part-Cost'+rowNum),'Cost');
	Gebi('Part-Cost'+rowNum).innerHTML=formatCurrency(Gebi('Part-Cost'+rowNum).innerHTML);
	fieldSave(Gebi('Part-ItemDescription'+rowNum),'ItemDescription');
	fieldSave(Gebi('Part-PartNumber'+rowNum),'ItemName');
	fieldSave(Gebi('Part-Manufacturer'+rowNum),'Manufacturer');
	fieldSave(Gebi('Part-Qty'+rowNum),'Qty');
	systemCost(sysId);
}



function editLabor(rowNum) {
	function fieldEdit(box) {
		box.setAttribute('contentEditable','true');
		box.style.fontFamily='Consolas';
		box.focus();
	}
	
	Gebi('Labor-Edit'+rowNum).setAttribute('class', 'rowSave');
	Gebi('Labor-Edit'+rowNum).setAttribute('onclick', 'saveLabor('+rowNum+')');
	
	fieldEdit(Gebi('Labor-Cost'+rowNum));
	fieldEdit(Gebi('Labor-ItemDescription'+rowNum));
	fieldEdit(Gebi('Labor-ItemName'+rowNum));
	fieldEdit(Gebi('Labor-Qty'+rowNum));
}

function saveLabor(rowNum) {
	var bidItemsId=Gebi('Labor-BidItemsID'+rowNum).innerHTML
	
	function fieldSave(box, fieldName) {
		WSQL("UPDATE BidItems SET "+fieldName+"='"+CharsEncode(box.innerHTML)+"' WHERE BidItemsId="+bidItemsId);
		box.setAttribute('contentEditable','false');
		box.style.fontFamily='';
		box.style.backgroundColor='transparent';
	}

	Gebi('Labor-Edit'+rowNum).setAttribute('class', 'rowEdit');
	Gebi('Labor-Edit'+rowNum).setAttribute('onclick', 'editLabor('+rowNum+')');
	
	Gebi('Labor-Cost'+rowNum).innerHTML=unCurrency(Gebi('Labor-Cost'+rowNum).innerHTML);
	Gebi('Labor-Cost'+rowNum).style.backgroundColor='#F88';
	Gebi('Labor-ItemDescription'+rowNum).style.backgroundColor='#F88';
	Gebi('Labor-ItemName'+rowNum).style.backgroundColor='#F88';
	Gebi('Labor-Qty'+rowNum).style.backgroundColor='#F88';
	fieldSave(Gebi('Labor-Cost'+rowNum),'Cost');
	Gebi('Labor-Cost'+rowNum).innerHTML=formatCurrency(Gebi('Labor-Cost'+rowNum).innerHTML);
	fieldSave(Gebi('Labor-ItemDescription'+rowNum),'ItemDescription');
	fieldSave(Gebi('Labor-ItemName'+rowNum),'ItemName');
	fieldSave(Gebi('Labor-Qty'+rowNum),'Qty');
	systemCost(sysId);
}




function editTravel(rowNum) {
	function fieldEdit(box) {
		box.setAttribute('contentEditable','true');
		box.style.fontFamily='Consolas';
		box.focus();
	}
	
	Gebi('Travel-Edit'+rowNum).setAttribute('class', 'rowSave');
	Gebi('Travel-Edit'+rowNum).setAttribute('onclick', 'saveTravel('+rowNum+')');
	
	fieldEdit(Gebi('Travel-Origin'+rowNum));
	fieldEdit(Gebi('Travel-Destination'+rowNum));
	fieldEdit(Gebi('Travel-Cost'+rowNum));
	fieldEdit(Gebi('Travel-Qty'+rowNum));
}

function saveTravel(rowNum) {
	var expenseId=Gebi('Travel-ExpenseID'+rowNum).innerHTML
	
	function fieldSave(box, fieldName) {
		WSQL("UPDATE Expenses SET "+fieldName+"='"+CharsEncode(box.innerHTML)+"' WHERE ExpenseID="+expenseId);
		box.setAttribute('contentEditable','false');
		box.style.fontFamily='';
		box.style.backgroundColor='transparent';
	}

	Gebi('Travel-Edit'+rowNum).setAttribute('class', 'rowEdit');
	Gebi('Travel-Edit'+rowNum).setAttribute('onclick', 'editTravel('+rowNum+')');
	
	Gebi('Travel-Origin'+rowNum).style.backgroundColor='#F88';
	Gebi('Travel-Destination'+rowNum).style.backgroundColor='#F88';
	Gebi('Travel-Cost'+rowNum).style.backgroundColor='#F88';
	Gebi('Travel-Qty'+rowNum).style.backgroundColor='#F88';
	fieldSave(Gebi('Travel-Qty'+rowNum),'Units');
	fieldSave(Gebi('Travel-Cost'+rowNum),'UnitCost');
	fieldSave(Gebi('Travel-Destination'+rowNum),'Destination');
	fieldSave(Gebi('Travel-Origin'+rowNum),'Origin');
	systemCost(sysId);
}



function editEquip(rowNum) {
	function fieldEdit(box) {
		box.setAttribute('contentEditable','true');
		box.style.fontFamily='Consolas';
		box.focus();
	}
	
	Gebi('Equip-Edit'+rowNum).setAttribute('class', 'rowSave');
	Gebi('Equip-Edit'+rowNum).setAttribute('onclick', 'saveEquip('+rowNum+')');
	
	fieldEdit(Gebi('Equip-Qty'+rowNum));
	fieldEdit(Gebi('Equip-Desc'+rowNum));
	fieldEdit(Gebi('Equip-Cost'+rowNum));
}

function saveEquip(rowNum) {
	var expenseId=Gebi('Equip-ExpenseID'+rowNum).innerHTML
	
	function fieldSave(box, fieldName) {
		WSQL("UPDATE Expenses SET "+fieldName+"='"+CharsEncode(box.innerHTML).replace('_LT_br_GT_','')+"' WHERE ExpenseID="+expenseId);
		box.setAttribute('contentEditable','false');
		box.style.fontFamily='';
		box.style.backgroundColor='transparent';
	}

	Gebi('Equip-Edit'+rowNum).setAttribute('class', 'rowEdit');
	Gebi('Equip-Edit'+rowNum).setAttribute('onclick', 'editEquip('+rowNum+')');
	
	Gebi('Equip-Desc'+rowNum).style.backgroundColor='#F88';
	Gebi('Equip-Cost'+rowNum).style.backgroundColor='#F88';
	Gebi('Equip-Qty'+rowNum).style.backgroundColor='#F88';
	fieldSave(Gebi('Equip-Qty'+rowNum),'Units');
	fieldSave(Gebi('Equip-Cost'+rowNum),'UnitCost');
	fieldSave(Gebi('Equip-Desc'+rowNum),'SubType');
	systemCost(sysId);
}



function editOther(rowNum) {
	function fieldEdit(box) {
		box.setAttribute('contentEditable','true');
		box.style.fontFamily='Consolas';
		box.focus();
	}
	
	Gebi('Other-Edit'+rowNum).setAttribute('class', 'rowSave');
	Gebi('Other-Edit'+rowNum).setAttribute('onclick', 'saveOther('+rowNum+')');
	
	fieldEdit(Gebi('Other-Qty'+rowNum));
	fieldEdit(Gebi('Other-Desc'+rowNum));
	fieldEdit(Gebi('Other-Cost'+rowNum));
}

function saveOther(rowNum) {
	var expenseId=Gebi('Other-ExpenseID'+rowNum).innerHTML
	
	function fieldSave(box, fieldName) {
		WSQL("UPDATE Expenses SET "+fieldName+"='"+CharsEncode(box.innerHTML).replace('_LT_br_GT_','')+"' WHERE ExpenseID="+expenseId);
		box.setAttribute('contentEditable','false');
		box.style.fontFamily='';
		box.style.backgroundColor='transparent';
	}

	Gebi('Other-Edit'+rowNum).setAttribute('class', 'rowEdit');
	Gebi('Other-Edit'+rowNum).setAttribute('onclick', 'editOther('+rowNum+')');
	
	Gebi('Other-Desc'+rowNum).style.backgroundColor='#F88';
	Gebi('Other-Cost'+rowNum).style.backgroundColor='#F88';
	Gebi('Other-Qty'+rowNum).style.backgroundColor='#F88';
	fieldSave(Gebi('Other-Qty'+rowNum),'Units');
	fieldSave(Gebi('Other-Cost'+rowNum),'UnitCost');
	fieldSave(Gebi('Other-Desc'+rowNum),'SubType');
	systemCost(sysId);
}



function updatePartRow(row) {
	var Qty=Gebi('Part-Qty'+row).innerHTML;
	var Cost=(unCurrency(Gebi('Part-Cost'+row).innerHTML)*1);
	if(useNewBidder) {
		Gebi('Part-Total'+row).innerHTML=formatCurrency(Cost*Qty);
	}
	else {
		var M=1+(MU/100);
		var Sell=Cost*M
		Gebi('Part-Sell'+row).innerHTML=formatCurrency(Sell);
		Gebi('Part-Total'+row).innerHTML=formatCurrency(Sell*Qty);
	}
	if(Gebi('Part-Qty'+row).innerHTML<=0) { Gebi('pRow'+row).style.color='#C00'; }
	if(Gebi('Part-Qty'+row).innerHTML>0) { Gebi('pRow'+row).style.color='#000'; }
}

function updateLaborRow(row) {
	var Qty=Gebi('Labor-Qty'+row).innerHTML
	var Cost=(unCurrency(Gebi('Labor-Cost'+row).innerHTML)*1);
	if(useNewBidder) {
		Gebi('Labor-Total'+row).innerHTML=formatCurrency(Cost*Qty);
	}
	else {
		var M=1+(MU/100);
		var Sell=Cost*M
		Gebi('Labor-Sell'+row).innerHTML=formatCurrency(Sell);
		Gebi('Labor-Total'+row).innerHTML=formatCurrency(Sell*Qty);
	}
	if(Gebi('Labor-Qty'+row).innerHTML<=0) { Gebi('lRow'+row).style.color='#C00'; }
	if(Gebi('Labor-Qty'+row).innerHTML>0) { Gebi('lRow'+row).style.color='#000'; }
}

function updateTravelRow(row) {
	var Qty=Gebi('Travel-Qty'+row).innerHTML;
	var Cost=Gebi('Travel-Cost'+row).innerHTML.replace('$','').replace(/,/g,'');
	Gebi('Travel-Total'+row).innerHTML=formatCurrency(Cost*Qty);
}

function updateEquipRow(row) {
	var Qty=Gebi('Equip-Qty'+row).innerHTML;
	var Cost=Gebi('Equip-Cost'+row).innerHTML.replace('$','').replace(/,/g,'');
	Gebi('Equip-Total'+row).innerHTML=formatCurrency(Cost*Qty);
}

function updateOtherRow(row) {
	var Qty=Gebi('Other-Qty'+row).innerHTML;
	var Cost=Gebi('Other-Cost'+row).innerHTML.replace('$','').replace(/,/g,'');
	Gebi('Other-Total'+row).innerHTML=formatCurrency(Cost*Qty);
}


function ExpenseLists(sysID) {
	TravelList(sysID);
	EquipList(sysID);
	OtherList(sysID);
}


function AddBlankEquip() { AddExpense('Equip', 'Miscellaneous Equipment Expense', 'NONE', 'NONE', 1, 100); }
function AddBlankOther() { AddExpense('OH', 'Miscellaneous Job Expense', 'NONE', 'NONE', 1, 100); }



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
		//Gebi(rollUpDivId).parentNode.nextElementSibling.style.height='32px';
	}
	else {
		arrow.innerHTML='▼';
		Gebi(rollUpDivId).style.display='block';
		//Gebi(rollUpDivId).parentNode.style.height=Gebi(rollUpDivId).parentNode.style.height;
	}
	Collapse(CollapseDiv);
}

function Collapse(div) {
	
	var h=div.getAttribute('height').replace('px','');
	if(div.offsetHeight<h) { 
		div.style.height=h+('px');
	}
	else {div.style.height='32px'; }
}


function showMenu(posBox) {
	Gebi('Menu').style.display='block';
	Gebi('Menu').style.top=mY+(posBox.offsetHeight/2)+'px';//posBox.offsetTop+posBox.offsetHeight-6+('px');
	Gebi('Menu').style.left=(mX-(0))+'px';//posBox.offsetLeft+4+('px');
}
function showPresetMenu(posBox) {
	Gebi('PresetMenu').style.display='block';
	Gebi('PresetMenu').style.top=mY+(posBox.offsetHeight/2)+'px';//posBox.offsetTop+posBox.offsetHeight-6+('px');
	Gebi('PresetMenu').style.left=(mX-(Gebi('PresetMenu').offsetWidth/2))+'px';//posBox.offsetLeft+4+('px');
}
function hideMenus () {
	var Menus=document.getElementsByClassName('MenuBox');
	for(m=0;m<Menus.length;m++) {
		Menus[m].style.display='none';
	}
}
function showPresetList(Menu,posBox) {
	Menu=Gebi(Menu);
	Menu.style.top=posBox.offsetTop+posBox.offsetHeight+('px');
	Menu.style.display='block';
	Menu.style.left=posBox.parentNode.offsetLeft-Menu.offsetWidth+('px');
}
function hidePresetLists() {
	var presetLists=document.getElementsByClassName('presetList');
	for(p=0;p<presetLists.length;p++) {
		presetLists[p].style.display='none';
	}
}

function showModal(status) {
	if(!status) { status='Please Wait...' }
	Gebi('Modal').style.display='block';
	Gebi('modalStatus').innerHTML=status;
}
function hideModal() { 
	Gebi('Modal').style.display='none';
	Gebi('modalStatus').innerHTML='';
}



function addProposalPreset() {
	var ts=new Date()
	var rawTime=ts.getTime()*1;
	var cKey=sessionEmpID+''+rawTime;
	WSQL("INSERT INTO ProposalPrint (Name, AcctID, CreationKey) VALUES ('"+Gebi("newPresetName").value+"',"+AcctId+",'"+cKey+"')");
	
	
}

function printCust(checked,bidToId) {
	if(!checked) { checked='True' }
	else { checked='False' }
	
	WSQL('UPDATE BidTo SET noPrint=\''+checked+'\' WHERE BidToID='+bidToId);
}

function printSys(checked,proposalPrintID,systemId) {
	if(checked) { WSQL('INSERT INTO ProposalPrintSystems (MasterID,DetailID) VALUES ('+proposalPrintID+','+systemId+')') }
	else { WSQL('DELETE FROM ProposalPrintSystems WHERE MasterID='+proposalPrintID+' AND DetailID='+systemId) }
}

function printLH(cb,lhId,ppId) {
	if(!cb.checked) { 
		cb.checked=true;
		return false;
	}
	
	var LHs=document.getElementsByClassName('lhCheck');
	for(l=0;l<LHs.length;l++) {
		LHs[l].checked=(LHs[l].id===cb.id);
	}
	
	WSQL('UPDATE ProposalPrint SET pLHeadID=\''+lhId+'\' WHERE id='+ppId);
}


function Print() {
	var AcctURL='BidPrint.asp?AcctID='+AcctId+'&printID='+SelI('printPreset').value;
	var noCust=true;
	var openWindow=new Array
	
	var cc = document.getElementsByClassName('custCheck')
	
	for(i=0;i<cc.length;i++) {
		if(cc[i].checked) {
			noCust=false;
			openWindow[i]=window.open(AcctURL+'&CustID='+cc[i].id.replace('printCust',''));
		}
	}
	if(noCust) {
		alert('Please Choose a Customer!');
		return false;
	}
	return openWindow;
}

function showBidCopy() {
	Gebi('copyModal').style.display='block';
	hideMenus();
	
	Gebi('cwPresetName').value=sysName;
	Gebi('cwSysType').selectedIndex=0;
	//SelI('cwSysType').innerHTML=sysType;
}

function showBidDuplicate() {
	Gebi('dwMoveChk').checked=false;
	Gebi('dupModal').style.display='block';
	hideMenus();
	
	Gebi('cwPresetName').value=sysName;
	Gebi('cwSysType').selectedIndex=0;
	//SelI('cwSysType').innerHTML=sysType;
}

function showBidMove() {
	Gebi('dwMoveChk').checked=true;
	Gebi('moveModal').style.display='block';
	hideMenus();
	
	Gebi('cwPresetName').value=sysName;
	Gebi('cwSysType').selectedIndex=0;
	//SelI('cwSysType').innerHTML=sysType;
}

var statusAcctId=0;
var statusDiv=false;
function showStatusPopup(Id,posDiv,inactive,active) {
	statusAcctId=Id;
	statusDiv=posDiv;
	
	Gebi('statusPopup').style.display='block';
	var Now=new Date();
	var testUntil = new Date(Gebi(posDiv.id.replace('acctStatus','testUntil')).innerHTML); 
	var onTest=(Now<testUntil)
	Gebi('cbStatusOnTest').checked=onTest && active;
	Gebi('statusTestUntil').value=mdyyyyhhmm(testUntil);
	Gebi('cbStatusActive').checked=active && !onTest;
	Gebi('cbStatusInactive').checked=inactive;
	
	if(Gebi('cbStatusOnTest').checked) setTimeout('Gebi(\'cbStatusOnTest\').checked=false;',750); 
	
	Gebi('statusPopup').style.left=(posDiv.offsetLeft+posDiv.offsetWidth-5)+'px';
	Gebi('statusPopup').style.top=(posDiv.offsetTop+posDiv.offsetHeight-5/*-Gebi('List').scrollTop*/)+'px';
	Gebi('statusPopup').style.display='block';
}
function setStatus(state, stateIs) {
	
	Gebi('cbStatusActive').removeAttribute('checked');
	Gebi('cbStatusInactive').removeAttribute('checked');
	Gebi('cbStatusOnTest').removeAttribute('checked');
	var tU=new Date(Gebi('statusTestUntil').value);
	
	switch(state) {
		case 'OnTest':
			if(stateIs) {
				if (tU<Date.now()) {
					Gebi('cbStatusActive').checked=false;
					Gebi('cbStatusInactive').checked=false;
					Gebi('statusTestUntil').select();
					return false;
				}
			}
			Gebi('cbStatusOnTest').setAttribute('checked','checked');
			WSQLUBit('MonitoringAccounts','active',true,'ID',statusAcctId);
			WSQLU('MonitoringAccounts','testUntil',Gebi('statusTestUntil').value,'ID',statusAcctId);
			statusDiv.setAttribute('class','statusOnTest');
			statusDiv.setAttribute('onclick','showStatusPopup('+statusAcctId+', this, 0,1)');
			Gebi(statusDiv.id.replace('acctStatus','testUntil')).innerHTML=Gebi('statusTestUntil').value;
			Gebi('acctStatusText').innerHTML='<small>On test until: '+Gebi('statusTestUntil').value+'</small>';
		break;
		
		case 'Active' :
			if(stateIs) {
				if (tU>Date.now()) {
					WSQLU('MonitoringAccounts','testUntil',mdyyyyhhmm(Date.now()-1),'ID',statusAcctId);
				}
			}
			Gebi('cbStatusActive').setAttribute('checked','checked');
			WSQLUBit('MonitoringAccounts','active',true,'ID',statusAcctId);
			statusDiv.setAttribute('class','statusActive');
			statusDiv.setAttribute('onclick','showStatusPopup('+statusAcctId+', this, 0,1)');
			Gebi('acctStatusText').innerHTML='Active';
		break;
		
		case 'Inactive' :
			Gebi('cbStatusInactive').setAttribute('checked','checked');
			WSQLUBit('MonitoringAccounts','active',false,'ID',statusAcctId);
			statusDiv.setAttribute('class','statusInactive');
			statusDiv.setAttribute('onclick','showStatusPopup('+statusAcctId+', this, 1,0)');
			Gebi('acctStatusText').innerHTML='Inactive';
		break;
	}
	Gebi('statusPopup').style.display='none';
}


function Resize()	{
	Gebi('OuterBox').style.height=document.body.offsetHeight-Gebi('TabsBar').offsetHeight-Gebi('pathToolbar').offsetHeight-Gebi('mainToolbar').offsetHeight+('px');
}
