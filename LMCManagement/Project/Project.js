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
	WSQLU('Projects', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'ProjID', projId);
	fBox.innerHTML='<a class=editLink onclick=editField(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
}
function eSysField(fieldBox) {
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="saveSysField(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function saveSysField(fBox) { 
	WSQLU('Systems', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'SystemID', sysId);
	fBox.innerHTML='<a class=editLink onclick=eSysField(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
	parent.AllLists(sysId);
}


function editCurrency(fieldBox) {
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="saveCurrency(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function saveCurrency(fBox) { 
	WSQLU('Projects', fBox.id, unCurrency(Gebi(fBox.id+'Value').value), 'ProjID', projId);
	fBox.innerHTML='<a class=editLink onclick=editCurrency(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
}
function eSysCurrency(fieldBox) {
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="saveSysCurrency(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function saveSysCurrency(fBox) { 
	WSQLU('Systems', fBox.id, unCurrency(Gebi(fBox.id+'Value').value), 'SystemID', sysId);
	fBox.innerHTML='<a class=editLink onclick=eSysCurrency(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
	parent.AllLists(sysId);
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
	WSQLU('PROJECTS', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'ProjID', projId);
	fBox.innerHTML='<a class=editLink onclick=editNotes(this.parentNode);>Edit</a>'+CharsCR2Br(Gebi(fBox.id+'Value').value);
}
function eSysNotes(fieldBox) {
	var fieldValue=CharsBr2CR(fieldBox.innerHTML.split('</a>')[1]);
	Gebi('oldNotes').innerHTML=fieldBox.innerHTML;
	var newHTML='<textarea id='+fieldBox.id+'Value style="float:left; font-size:12px; height:100%; width:80%;" >'+fieldValue+'</textarea>';
	newHTML+='<div align=center style="float:right; height:100%; overflow:hidden; padding-top:2px; text-align:center; width:19%;">';
	newHTML+='	<div class="editButton" style=width:90%; onclick=saveSysNotes(this.parentNode.parentNode);>save</div><br/>';
	newHTML+="	<div class=editButton style=width:90%; onclick=this.parentNode.parentNode.innerHTML=Gebi('oldNotes').innerHTML;>cancel</div>";
	newHTML+='</div>';
	fieldBox.innerHTML=newHTML;
}
function saveSysNotes(fBox) { 
	WSQLU('Systems', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'SystemID', sysId);
	fBox.innerHTML='<a class=editLink onclick=eSysNotes(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
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
	WSQLU('PROJECTS', fBox.id, Gebi(fBox.id+'Value').value, 'ProjID', projId);
	fBox.innerHTML=Gebi(fBox.id+'Value').value+'<a class=editLink onclick=dateField(this.parentNode);>Edit</a>';
}
function dateSysField(fieldBox) {
	var oldHTML=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	var displayCal='displayCalendar(Gebi(\''+fieldBox.id+'Value\'),\'mm/dd/yyyy\',\'+fieldValue+\')';
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'" onfocus="'+displayCal+'"/>';
	fieldBox.innerHTML+='<img class=editImg src="../../images/cal24x24.gif" onclick="'+displayCal+'" />';
	fieldBox.innerHTML+='<div class="editButton" onclick="saveSysDate(this.parentNode);">save</div>';
	fieldBox.innerHTML+='<div class="editButton" onclick="this.parentNode.innerHTML=\'<a class=editLink onclick=dateSysField(this.parentNode);>Edit</a>'+fieldValue+'\';">cancel</div>';
}
function saveSysDate(fBox) { 
	WSQLU('Systems', fBox.id, Gebi(fBox.id+'Value').value, 'SystemID', sysId);
	fBox.innerHTML=Gebi(fBox.id+'Value').value+'<a class=editLink onclick=dateField(this.parentNode);>Edit</a>';
}


function editCheck(field,bit)	{
	var trueOrFalse;
	if(bit) trueOrFalse='True';
	else trueOrFalse='False';
	
	WSQLU('Projects', field, trueOrFalse, 'ProjID', projId);
}
function eSysCheck(field,bit)	{
	var trueOrFalse;
	if(bit) trueOrFalse='True';
	else trueOrFalse='False';
	
	WSQLU('Systems', field, trueOrFalse, 'SystemID', sysId);
	systemBudget(sysId);
}



function loadSystem(sysId)	{
	var d=new Date()
	Gebi('SysPage').setAttribute('src','System.asp?sysId='+sysId+'&nocache='+d.getMilliseconds());
	showTab(Gebi('SysTab'));
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
var BoxX, BoxY;
var OldBoxTop, OldBoxLeft;
var iMX, iMY;
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
				Gebi('Junk').innerHTML+=BidItemsIdId+'<br/><br/>';
				var BidItemsId=Gebi(BidItemsIdId).innerHTML;
				
				WSQL('DELETE FROM BidItems WHERE BidItemsID='+BidItemsId);
				Row.parentNode.removeChild(Row);
			}
		}
	}
	//  I can't figure out why it won't delete parts that are immediately after one that it does delete, but here is a neato band aid:
	for(d=0;d<checkboxes.length*3;d++) { doTheDeleteThing(); }
	systemBudget(sysId);
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
	systemBudget(sysId);
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
	
	/*
	fieldEdit(Gebi('Part-Cost'+rowNum));
	fieldEdit(Gebi('Part-ItemDescription'+rowNum));
	fieldEdit(Gebi('Part-PartNumber'+rowNum));
	fieldEdit(Gebi('Part-Manufacturer'+rowNum));
	*/
	if (!!Gebi('pSel'+rowNum)) {
		fieldEdit(Gebi('Part-Manufacturer'+rowNum));
		fieldEdit(Gebi('Part-PartNumber'+rowNum));
		fieldEdit(Gebi('Part-ItemDescription'+rowNum));
		fieldEdit(Gebi('Part-Cost'+rowNum));
		Gebi('Part-Cost'+rowNum).innerHTML=Gebi('Part-Cost'+rowNum).innerHTML.replace('$','');
	}
	fieldEdit(Gebi('Part-ActualQty'+rowNum));
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
	
	Gebi('Part-ActualQty'+rowNum).style.backgroundColor='rgba(255,0,0,.5)';
	fieldSave(Gebi('Part-ActualQty'+rowNum),'ActualQty');
	Gebi('Part-Manufacturer'+rowNum).style.backgroundColor='rgba(255,0,0,.5)';
	fieldSave(Gebi('Part-Manufacturer'+rowNum),'Manufacturer');
	Gebi('Part-PartNumber'+rowNum).style.backgroundColor='rgba(255,0,0,.5)';
	fieldSave(Gebi('Part-PartNumber'+rowNum),'ItemName');
	Gebi('Part-ItemDescription'+rowNum).style.backgroundColor='rgba(255,0,0,.5)';
	fieldSave(Gebi('Part-ItemDescription'+rowNum),'ItemDescription');
	Gebi('Part-Cost'+rowNum).style.backgroundColor='rgba(255,0,0,.5)';
	fieldSave(Gebi('Part-Cost'+rowNum),'Cost');
	Gebi('Part-Cost'+rowNum).innerHTML=formatCurrency(Gebi('Part-Cost'+rowNum).innerHTML);
	systemBudget(sysId);
}

function editLabor(rowNum) {
	function fieldEdit(box) {
		box.setAttribute('contentEditable','true');
		box.style.fontFamily='Consolas';
		box.focus();
	}
	Gebi('Labor-Edit'+rowNum).setAttribute('class', 'rowSave');
	Gebi('Labor-Edit'+rowNum).setAttribute('onclick', 'saveLabor('+rowNum+')');

	if (!!Gebi('lSel'+rowNum)) {
		fieldEdit(Gebi('Labor-ItemName'+rowNum));
		fieldEdit(Gebi('Labor-ItemDescription'+rowNum));
		fieldEdit(Gebi('Labor-Cost'+rowNum));
		Gebi('Labor-Cost'+rowNum).innerHTML=Gebi('Labor-Cost'+rowNum).innerHTML.replace('$','');
	}
	fieldEdit(Gebi('Labor-ActualQty'+rowNum));
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
	
	Gebi('Labor-ActualQty'+rowNum).style.backgroundColor='rgba(255,0,0,.5)';
	fieldSave(Gebi('Labor-ActualQty'+rowNum),'ActualQty');
	Gebi('Labor-ItemName'+rowNum).style.backgroundColor='rgba(255,0,0,.5)';
	fieldSave(Gebi('Labor-ItemName'+rowNum),'ItemName');
	Gebi('Labor-ItemDescription'+rowNum).style.backgroundColor='rgba(255,0,0,.5)';
	fieldSave(Gebi('Labor-ItemDescription'+rowNum),'ItemDescription');
	Gebi('Labor-Cost'+rowNum).style.backgroundColor='rgba(255,0,0,.5)';
	fieldSave(Gebi('Labor-Cost'+rowNum),'Cost');
	Gebi('Labor-Cost'+rowNum).innerHTML=formatCurrency(Gebi('Labor-Cost'+rowNum).innerHTML);
	systemBudget(sysId);
}


function editTravel(rowNum) {
	function fieldEdit(box) {
		box.setAttribute('contentEditable','true');
		box.style.fontFamily='Consolas';
		box.focus();
	}
	Gebi('Travel-Edit'+rowNum).setAttribute('class', 'rowSave');
	Gebi('Travel-Edit'+rowNum).setAttribute('onclick', 'saveTravel('+rowNum+')');
	
	
	if(!!Gebi('tSel'+rowNum)) {
		fieldEdit(Gebi('Travel-Origin'+rowNum));
		fieldEdit(Gebi('Travel-Destination'+rowNum));
		Gebi('Travel-Cost'+rowNum).innerHTML=Gebi('Travel-Cost'+rowNum).innerHTML.replace('$','');
		fieldEdit(Gebi('Travel-Cost'+rowNum));
	}
	fieldEdit(Gebi('Travel-ActualQty'+rowNum));
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
	fieldSave(Gebi('Travel-Origin'+rowNum),'Origin');
	Gebi('Travel-Destination'+rowNum).style.backgroundColor='#F88';
	fieldSave(Gebi('Travel-Destination'+rowNum),'Destination');
	Gebi('Travel-Cost'+rowNum).style.backgroundColor='#F88';
	fieldSave(Gebi('Travel-Cost'+rowNum),'UnitCost'); Gebi('Travel-Cost'+rowNum).innerHTML=formatCurrency(Gebi('Travel-Cost'+rowNum).innerHTML);
	Gebi('Travel-ActualQty'+rowNum).style.backgroundColor='#F88';
	fieldSave(Gebi('Travel-ActualQty'+rowNum),'ActualUnits');
	systemBudget(sysId);
}



function editEquip(rowNum) {
	function fieldEdit(box) {
		box.setAttribute('contentEditable','true');
		box.style.fontFamily='Consolas';
		box.focus();
	}
	
	Gebi('Equip-Edit'+rowNum).setAttribute('class', 'rowSave');
	Gebi('Equip-Edit'+rowNum).setAttribute('onclick', 'saveEquip('+rowNum+')');
	
	fieldEdit(Gebi('Equip-ActualQty'+rowNum));
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
	
	Gebi('Equip-ActualQty'+rowNum).style.backgroundColor='#F88';
	fieldSave(Gebi('Equip-ActualQty'+rowNum),'Units');
	systemBudget(sysId);
}



function editOther(rowNum) {
	function fieldEdit(box) {
		box.setAttribute('contentEditable','true');
		box.style.fontFamily='Consolas';
		box.focus();
	}
	
	Gebi('Other-Edit'+rowNum).setAttribute('class', 'rowSave');
	Gebi('Other-Edit'+rowNum).setAttribute('onclick', 'saveOther('+rowNum+')');
	
	fieldEdit(Gebi('Other-ActualQty'+rowNum));
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
	
	Gebi('Other-ActualQty'+rowNum).style.backgroundColor='#F88';
	fieldSave(Gebi('Other-ActualQty'+rowNum),'Units');
	systemBudget(sysId);
}


function updatePartRow(row) {
	var ActualQty=Gebi('Part-ActualQty'+row).innerHTML;
	var Cost=(unCurrency(Gebi('Part-Cost'+row).innerHTML)*1);
	Gebi('Part-Actual'+row).innerHTML=formatCurrency(Cost*ActualQty);
	if(Gebi('Part-ActualQty'+row).innerHTML<=0) { Gebi('pRow'+row).style.color='#C00'; }
	if(Gebi('Part-ActualQty'+row).innerHTML>0) { Gebi('pRow'+row).style.color='#000'; }
}

function updateLaborRow(row) {
	var Qty=Gebi('Labor-Qty'+row).innerHTML
	var Cost=(unCurrency(Gebi('Labor-Cost'+row).innerHTML)*1);
	Gebi('Labor-Total'+row).innerHTML=formatCurrency(Cost*Qty);
	if(Gebi('Labor-ActualQty'+row).innerHTML<=0) { Gebi('lRow'+row).style.color='#C00'; }
	if(Gebi('Labor-ActualQty'+row).innerHTML>0) { Gebi('lRow'+row).style.color='#000'; }
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


function AddBlankEquip() { AddExpense('Equip', 'Miscellaneous Equipment Expense', 'NONE', 'NONE', 0, 0); }
function AddBlankOther() { AddExpense('OH', 'Miscellaneous Job Expense', 'NONE', 'NONE', 0, 0); }



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
	else {div.style.height='32px'; }
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




function printCust(checked,bidToId) {
	if(!checked) { checked='True' }
	else { checked='False' }
	
	WSQL('UPDATE BidTo SET noPrint=\''+checked+'\' WHERE BidToID='+bidToId);
}

function printSys(checked,systemId) {
	if(checked) { checked='True' }
	else { checked='False' }
	
	WSQL('UPDATE Systems SET PrintChecked=\''+checked+'\' WHERE SystemID='+systemId);
}

function printLH(cb,lhId) {
	if(!cb.checked) { 
		cb.checked=true;
		return false;
	}
	
	var LHs=document.getElementsByClassName('lhCheck');
	for(l=0;l<LHs.length;l++) {
		LHs[l].checked=(LHs[l].id===cb.id);
	}
	
	WSQL('UPDATE Projects SET pLHeadID=\''+lhId+'\' WHERE ProjID='+projId);
}

function Print() {
	var projURL='JobCostReport.asp?ProjID='+projId;
	var noCust=true;
	var openWindow;//=new Array
	
	var cc = document.getElementsByClassName('custCheck')
	
	openWindow/*[0]*/=window.open(projURL);

	return openWindow;
}

function PrintBudget() {
	var projURL='ProjectBudget.asp?ProjID='+projId;
	var noCust=true;
	var openWindow;//=new Array
	
	var cc = document.getElementsByClassName('custCheck')
	
	openWindow/*[0]*/=window.open(projURL);

	return openWindow;
}

function PrintSystemBudget(sysID) {
	var sysURL='SystemBudget.asp?SysID='+sysID;
	var openWindow;//=new Array
	openWindow/*[0]*/=window.open(sysURL);
	return openWindow;
}

function sysResize() {}

function Resize()	{
	Gebi('OuterBox').style.height=document.body.offsetHeight-Gebi('TabsBar').offsetHeight-Gebi('pathToolbar').offsetHeight-Gebi('mainToolbar').offsetHeight+('px');

	Gebi('ProjInfo').style.height='100%';
	Gebi('Systems').style.height='100%';
	Gebi('Costing').style.height='98%';
	Gebi('ProjInfo').style.height=Gebi('ProjInfo').offsetHeight-Gebi('ProjInfoTitle').offsetHeight-32+('px');
	Gebi('Systems').style.height=Gebi('Systems').offsetHeight-Gebi('SysTitle').offsetHeight-32+('px');
	Gebi('Costing').style.height=Gebi('Costing').offsetHeight-Gebi('CostingTitle').offsetHeight-32+('px');
}
