//Javascript Document

var useNewBidder=false;

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
	if(obtained) {
		if(!confirm('This Bid is under contract!  Are you sure you want to edit it?')) return false;	
	}
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="saveSysField(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function saveSysField(fBox) { 
	WSQLU('Services', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'ID', Id);
	fBox.innerHTML='<a class=editLink onclick=eSysField(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
	AllLists(Id);
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
	if(obtained) {
		if(!confirm('This Bid is under contract!  Are you sure you want to edit it?')) return false;	
	}
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="saveSysCurrency(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function saveSysCurrency(fBox) { 
	WSQLU('Services', fBox.id, unCurrency(Gebi(fBox.id+'Value').value), 'ID', Id);
	fBox.innerHTML='<a class=editLink onclick=eSysCurrency(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
	AllLists(Id);
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
	if(obtained) {
		if(!confirm('This Bid is under contract!  Are you sure you want to edit it?')) return false;	
	}
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
	WSQLU('Services', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'ID', Id);
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
	WSQLU('Services', fBox.id, Gebi(fBox.id+'Value').value, 'ID', Id);
	fBox.innerHTML=Gebi(fBox.id+'Value').value+'<a class=editLink onclick=dateField(this.parentNode);>Edit</a>';
}


function editCheck(field,bit)	{
	var trueOrFalse;
	if(bit) trueOrFalse='True';
	else trueOrFalse='False';
	
	WSQLU('Projects', field, trueOrFalse, 'ProjID', projId);
}
function eSysCheck(field,bit)	{
	if(obtained) {
		if(!confirm('This Bid is under contract!  Are you sure you want to edit it?')) {
			Gebi(field).checked=!Gebi(field).checked;
			return false;	
		}
	}
	var trueOrFalse;
	if(bit) trueOrFalse='True';
	else trueOrFalse='False';
	
	WSQLU('Services', field, trueOrFalse, 'ID', Id);
	serviceCost(Id);
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
	WSQLs('INSERT INTO BidTo (ProjID, CustID, CustName) VALUES ('+projId+', '+id+', \''+name+'\')');
	//Gebi('Customers').innerHTML=Gebi('Customers').innerHTML.replace('</div><div','</div><div class=serviceLink>'+name+'</div><div');
	//hideAddCust();
	window.location=window.location;
}

function deleteCusts() {
	if(!confirm('All customers will be removed.')) { return false; }
	WSQLs('DELETE FROM BidTo WHERE ProjID='+projId);
	window.location=window.location;
}



function loadService(Id)	{
	window.location='ServiceJob.asp?Id='+Id;
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
	serviceCost(Id);
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
	serviceCost(Id);
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
	serviceCost(Id);
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
	serviceCost(Id);
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
	serviceCost(Id);
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
	serviceCost(Id);
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
	serviceCost(Id);
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


function ExpenseLists(Id) {
	TravelList(Id);
	EquipList(Id);
	OtherList(Id);
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




function printCust(checked,bidToId) {
	if(!checked) { checked='True' }
	else { checked='False' }
	
	WSQL('UPDATE BidTo SET noPrint=\''+checked+'\' WHERE BidToID='+bidToId);
}

function printSys(checked,Id) {
	if(checked) { checked='True' }
	else { checked='False' }
	
	WSQL('UPDATE Services SET PrintChecked=\''+checked+'\' WHERE ID='+Id);
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
	var projURL='ServicePrint.asp?Id='+Id;
	var noCust=true;
	var openWindow=new Array
	
	var cc = document.getElementsByClassName('custCheck')
	
	for(i=0;i<cc.length;i++) {
		if(cc[i].checked) {
			noCust=false;
			openWindow[i]=window.open(projURL+'&CustID='+cc[i].id.replace('printCust',''));
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

function Resize()	{
	Gebi('mainToolbar').style.width=document.body.offsetWidth-22+('px');
	Gebi('pathToolbar').style.width=document.body.offsetWidth-22+('px');

	Gebi('OuterBox').style.height=document.body.offsetHeight-Gebi('TabsBar').offsetHeight-Gebi('pathToolbar').offsetHeight-Gebi('mainToolbar').offsetHeight+('px');
	Gebi('OuterBox').style.top=Gebi('TabsBar').offsetHeight+Gebi('pathToolbar').offsetHeight+Gebi('mainToolbar').offsetHeight+('px');
}


////////////////////////// AJAX Functions ///////////////////////////////////
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


function saveNewSys(system) {
	HttpText='BidASP.asp?action=saveNewSys&system='+system+'&projId='+projId
	xhr=getXHRObject()
	xhr.onreadystatechange=function () {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
			
				try	{	var xmlDoc = xhr.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the SaveNewSys response.',HttpText);	
				}
				
				//var RecordCount= xmlDoc.getElementsByTagName('RecordCount')[0].childNodes[0].nodeValue.replace('--','');
				window.location=window.location;
				hideNewSys();
			}
			else {
				AjaxErr('There was a problem with the SaveNewBid request.',HttpText);
			}
		}
	}
	xhr.open('GET',HttpText,true);
	xhr.send(null)
}


function searchCust(sStr) {
	HttpText='BidASP.asp?action=searchCust&search='+CharsEncode(sStr);
	xhr = getXHRObject();
	xhr.onreadystatechange = function () {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				
				try	{	var xmlDoc = xhr.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the searchCust:"'+sStr+'" response.',HttpText);	
				}
				var recordCount=xmlDoc.getElementsByTagName('recordCount')[0].childNodes[0].nodeValue.replace('--','');
				
				var custList='';
				for(r=1;r<=recordCount;r++) {
					var custId=xmlDoc.getElementsByTagName('custId'+r)[0].childNodes[0].nodeValue;
					var name=CharsDecode(xmlDoc.getElementsByTagName('name'+r)[0].childNodes[0].nodeValue);
					custList+='<div onclick="addCust('+custId+',\''+name+'\');" class=custListItem >'+name+'</div>';
				}
				Gebi('custList').innerHTML=custList;
			}
			else {
				AjaxErr('There was a problem with the searchCust:"'+sStr+'" request. Continue?',HttpText);
			}
		}
	}
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}




function AddPart(PartID) {
	//var serviceId = Id;
	
	HttpText='BidASP.asp?action=AddPart&PartID='+PartID+'&SysId='+Id;
	xhr = getXHRObject();
	xhr.onreadystatechange = ReturnAddPart;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}
function AddBlankPart() {
	var Id = Id;
	HttpText='BidASP.asp?action=AddPart&PartID=0&Id='+Id;
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
			var sId = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
			
			//Gebi('PartsTabMain').innerHTML += ProjID;
			PartsList(Id);
		}
		else {
			AjaxErr('There was a problem with the AddPart request. Continue?',HttpText);
		}
	}
}


function AddLabor(LaborID) {
	//var Id = Id;

	HttpText='BidASP.asp?action=AddLabor&LaborID='+LaborID+'&SysId='+serviceId;
	xhr = getXHRObject();
	xhr.onreadystatechange = ReturnAddLabor;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}
function AddBlankLabor() {
	var Id = Id;
	HttpText='BidASP.asp?action=AddLabor&Id='+Id;
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
				var Id = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
			}
			catch(e) { AjaxErr('There was a problem with the AddLabor response.',HttpText); }
			LaborList(Id);
		}
		else {
			AjaxErr('There was a problem with the AddLabor request.',HttpText);
		}
	}
}

function AddExpense(Type,SubType,Origin,Dest,Units,Cost) {
	//var MU = Gebi('SysExpFrame').contentWindow.document.getElementById("MU").value;
	
	//alert(Id);
	SubType=CharsEncode(SubType);
	Origin=CharsEncode(Origin);
	Dest=CharsEncode(Dest);
	HttpText='BidASP.asp?action=AddExpense&Type='+Type+'&SubType='+SubType+'&Origin='+Origin+'&Dest='+Dest+'&Units='+Units+'&Cost='+Cost+'&SysId='+Id;
	xhr = getXHRObject();
	xhr.onreadystatechange = function () {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				
				try { var xmlDoc = xhr.responseXML.documentElement; }
				catch(e) {
					AjaxErr('There was a problem with the AddPart response!',HttpText);
				}
				//var ProjID = xmlDoc.getElementsByTagName("ProjID")[0].childNodes[0].nodeValue;
				var Id = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
				
				ExpenseLists(Id);
			}
			else {
				AjaxErr('There was a problem with the AddPart request. Continue?',HttpText);
			}
		}
	}
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}


function AllLists(Id) {
	PartsList(Id);
	LaborList(Id);
	TravelList(Id);
	EquipList(Id);
	OtherList(Id);
}

function PartsList(Id) {
	HttpText='ServiceASP.asp?Action=PartsList&ServiceId='+Id;
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
				var partListDiv=Gebi('ServiceParts');//.contentWindow.document.getElementById('BidSystemsParts')
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
						rowHTML+='	<div style="width:7%;" class=taRPi id=Part-Qty'+pRow+' onKeyUp=updatePartRow('+pRow+');>'+Qty+'</div>';
						rowHTML+='	<div style="width:12%;" class=taLPi id=Part-Manufacturer'+pRow+'>'+Manufacturer+'</div>';
						rowHTML+='	<div style="width:15%;" class=taLPi id=Part-PartNumber'+pRow+'>'+ItemName+'</div>';
						//if(useNewBidder) {
						//	rowHTML+='	<div style="width:38%;" class=taLPi id=Part-ItemDescription'+pRow+'>'+ItemDescription+'</div>';
						//	rowHTML+='	<div style="width:10%;" class=taRPi id=Part-Cost'+pRow+' onKeyUp=updatePartRow('+pRow+');>'+formatCurrency(Cost)+'</div>';
						//	rowHTML+='	<div style="width:12%;" class=taRPi id=Part-Total'+pRow+'>'+formatCurrency(Cost*Qty)+'</div>';
						//	partsTotal+=(Cost*Qty);
						//}
						//else {
							Sell=Cost*M;
							rowHTML+='		<div style="width:28%; text-align:left;" class=taLPi id=Part-ItemDescription'+pRow+'>'+ItemDescription+'</div>';
							rowHTML+='		<div style="width:10%;" id=Part-Cost'+pRow+' class=taRPi onKeyUp=updatePartRow('+pRow+');>'+formatCurrency(Cost)+'</div>';
							rowHTML+='		<div style="width:10%;" id=Part-Sell'+pRow+' class=taRPi >'+formatCurrency(Sell)+'</div>';
							rowHTML+='		<div style="border-right:none; width:12%;" class=taRPi id=Part-Total'+pRow+'>'+formatCurrency(Sell*Qty)+'</div>';
							partsTotal+=(Sell*Qty);
						//}
						rowHTML+='</div>';
						partsHTML+=rowHTML;
					}
				}
				//alert(partsHTML);
				partListDiv.innerHTML=partsHTML;
				serviceCost(Id);

				Gebi('TotalParts').innerHTML=formatCurrency(partsTotal);
			}
			else {
				AjaxErr('There was a problem with the PartsList request.\n'+xhr.readyState+'\n Continue?',HttpText);
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}


function LaborList(Id) {
	HttpText='ServiceASP.asp?Action=LaborList&ServiceID='+Id;
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
				var laborListDiv=Gebi('ServiceLabor')
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
						rowHTML+='	<div style="width:4%;" class=taRPi id=Labor-Qty'+lRow+' onKeyUp=updateLaborRow('+lRow+');>'+Qty+'</div>';
						rowHTML+='	<div style="width:20%;" class=taLPi id=Labor-ItemName'+lRow+'>'+ItemName+'</div>';
						//if(useNewBidder) {
						//	rowHTML+='	<div style="width:50%; text-align:left;" class=taLPi id=Labor-ItemDescription'+lRow+'>'+ItemDescription+'</div>';
						//	rowHTML+='	<div style="width:10%;" class=taRPi id=Labor-Cost'+lRow+' onKeyUp=updateLaborRow('+lRow+');>'+formatCurrency(Cost)+'</div>';
						//	rowHTML+='	<div style="width:10%;" class=taRPi id=Labor-Total'+lRow+'>'+formatCurrency(Cost*Qty)+'</div>';
						//	laborTotal+=(Cost*Qty);
						//}
						//else {
							Sell=((Cost*(MU+100))/100);
							rowHTML+='		<div style="width:40%; text-align:left;" class=taLPi id=Labor-ItemDescription'+lRow+'>'+ItemDescription+'</div>';
							rowHTML+='		<div style="width:10%;" class=taRPi id=Labor-Cost'+lRow+' onKeyUp=updateLaborRow('+lRow+');>'+formatCurrency(Cost)+'</div>';
							rowHTML+='		<div style="width:10%;" class=taRPi id=Labor-Sell'+lRow+'>'+formatCurrency(Sell)+'</div>';
							rowHTML+='		<div style="border-right:none; width:10%;" id=Labor-Total'+lRow+'>'+formatCurrency(Sell*Qty)+'</div>';
							laborTotal+=(Sell*Qty);
						//}
						rowHTML+='</div>';
	
						laborListDiv.innerHTML+=rowHTML;
						serviceCost(Id);
						
						Gebi('TotalLabor').innerHTML=formatCurrency(laborTotal);
					}
				}
			}
			else { AjaxErr('There was a problem with the LaborList request.\n'+xhr.readyState+'\n Continue?',HttpText); }
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}


function TravelList(Id) {
	HttpText='ServiceASP.asp?Action=ExpenseList&Type=Travel&Id='+Id;
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
				
				var travelListDiv=Gebi('ServiceTravel')
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
						rowHTML+='	<div style="width:10%;" class=taRPi id=Travel-Cost'+tRow+' onKeyUp=updateTravelRow('+tRow+');>'+formatCurrency(Cost)+'</div>';
						rowHTML+='	<div style="width:4%;" class=taRPi id=Travel-Qty'+tRow+' onKeyUp=updateTravelRow('+tRow+');>'+Qty+'</div>';
						rowHTML+='	<div style="width:9%;" class=taLPi id=Travel-Unit'+tRow+' >'+Unit+'</div>';
						rowHTML+='	<div style="width:10%;" class=taRPi id=Travel-Total'+tRow+'>'+formatCurrency(Cost*Qty)+'</div>';
						rowHTML+='</div>';
	
						travelTotal+=(Cost*Qty);
	
						travelListDiv.innerHTML+=rowHTML;
						serviceCost(Id);	
						Gebi('TotalTravel').innerHTML=formatCurrency(travelTotal);
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

function EquipList(Id) {
	HttpText='ServiceASP.asp?Action=ExpenseList&Type=Equip&Id='+Id;
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
				
				var equipListDiv=Gebi('ServiceEquipment')
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
						rowHTML+='	<div style="width:8%;" class=taRPi id=Equip-Qty'+eRow+' onKeyUp=updateEquipRow('+eRow+');>'+Qty+'</div>';
						rowHTML+='	<div style="width:40%;" class=taLPi id=Equip-Desc'+eRow+'>'+SubType+'</div>';
						rowHTML+='	<div style="width:20%;" class=taRPi id=Equip-Cost'+eRow+' onKeyUp=updateEquipRow('+eRow+');>'+formatCurrency(Cost)+'</div>';
						rowHTML+='	<div style="width:20%;" class=taRPi id=Equip-Total'+eRow+'>'+formatCurrency(Cost*Qty)+'</div>';
						rowHTML+='</div>';
	
						equipTotal+=(Cost*Qty);
	
						equipListDiv.innerHTML+=rowHTML;
						
						serviceCost(Id);
						hideModal();
	
						Gebi('TotalEquip').innerHTML=formatCurrency(equipTotal);
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

function OtherList(Id) {
	HttpText='ServiceASP.asp?Action=ExpenseList&Type=OH&Id='+Id;
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
				
				var otherListDiv=Gebi('ServiceOther')
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
						rowHTML+='	<div style="width:8%;" class=taRPi id=Other-Qty'+oRow+' onKeyUp=updateOtherRow('+oRow+');>'+Qty+'</div>';
						rowHTML+='	<div style="width:40%;" class=taLPi id=Other-Desc'+oRow+'>'+SubType+'</div>';
						rowHTML+='	<div style="width:20%;" class=taRPi id=Other-Cost'+oRow+' onKeyUp=updateOtherRow('+oRow+');>'+formatCurrency(Cost)+'</div>';
						rowHTML+='	<div style="width:20%;" class=taRPi id=Other-Total'+oRow+'>'+formatCurrency(Cost*Qty)+'</div>';
						rowHTML+='</div>';
	
						otherTotal+=(Cost*Qty);
	
						otherListDiv.innerHTML+=rowHTML;
	
						Gebi('TotalOther').innerHTML=formatCurrency(otherTotal);
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


function serviceCost(serviceId) {
	HttpText='ServiceASP.asp?action=Cost&serviceId='+serviceId;
	xhr=getXHRObject();
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4) {
			if(xhr.status==200) {
				try { var xmlDoc = xhr.responseXML.documentElement }
				catch(e) { AjaxErr(' There was a problem with the systemCost response.', HttpText) }
				//AjaxErr(' There was a problem with the systemCost response.', HttpText)
				
				//var useNewBidder=xmlDoc.getElementsByTagName('useNewBidder')[0].childNodes[0].nodeValue;
				//if (useNewBidder=='True') useNewBidder=true;  else useNewBidder=false;
				//var roundUp=xmlDoc.getElementsByTagName('roundUp')[0].childNodes[0].nodeValue;
				//if (roundUp=='True' && useNewBidder ) roundUp=true;  else roundUp=false;
				//var totalFixed=xmlDoc.getElementsByTagName('totalFixed')[0].childNodes[0].nodeValue.replace('--','');
				//if (totalFixed=='True') totalFixed=true;  else totalFixed=false;
				
				var rDatum='Nothing';
				try { 
					rDatum='MU'; var MU=parseFloat(xmlDoc.getElementsByTagName(rDatum)[0].childNodes[0].nodeValue);
					rDatum='taxRate'; var taxRate=parseFloat(xmlDoc.getElementsByTagName(rDatum)[0].childNodes[0].nodeValue)*.01;
					rDatum='overhead'; var overheadRate=parseFloat(xmlDoc.getElementsByTagName(rDatum)[0].childNodes[0].nodeValue)*.01;
					
					rDatum='parts'; var parts=parseFloat(xmlDoc.getElementsByTagName(rDatum)[0].childNodes[0].nodeValue);
					rDatum='labor'; var labor=parseFloat(xmlDoc.getElementsByTagName(rDatum)[0].childNodes[0].nodeValue);
					rDatum='travel'; var travel=parseFloat(xmlDoc.getElementsByTagName(rDatum)[0].childNodes[0].nodeValue);
					rDatum='equip'; var equip=parseFloat(xmlDoc.getElementsByTagName(rDatum)[0].childNodes[0].nodeValue);
					rDatum='other'; var other=parseFloat(xmlDoc.getElementsByTagName(rDatum)[0].childNodes[0].nodeValue);
					
					rDatum='fixedPrice'; var fixedPrice=parseFloat(xmlDoc.getElementsByTagName(rDatum)[0].childNodes[0].nodeValue);
					rDatum='isFixedPrice'; var isFixedPrice=(xmlDoc.getElementsByTagName(rDatum)[0].childNodes[0].nodeValue.toLowerCase()=='true');
					
					var expenses=travel+equip+other; 
				} 
				catch(e) { AjaxErr(' There was a problem with the serviceCost response datum:'+rDatum+' \n\n ---ERROR---\n'+e.name+':'+e.message , HttpText) }
				
				Gebi('TotalTravel').innerHTML=formatCurrency(travel);
				Gebi('TotalEquip').innerHTML=formatCurrency(equip);
				Gebi('TotalOther').innerHTML=formatCurrency(other);
				
				
				/*
				if(useNewBidder)	{
					Gebi('TotalParts').innerHTML=formatCurrency(parts);
					Gebi('TotalLabor').innerHTML=formatCurrency(labor);
					if(totalFixed) { //Fixed Total 2010 Formula
						var sysTotal = fixedTotal;
						var overhead=overheadRate*(parts+labor+expenses);
						var PL=parts+labor; var EO=expenses+overhead;
						var M=sysTotal/(PL+(parts*taxRate)+EO);
						var tax=parts*taxRate;
						var profit=sysTotal-PL-EO-tax;
						MU=Math.round((M-1)*100000)/1000;
					}
					else { //Fixed Margin 2010 Formula
						var overhead=overheadRate*(parts+labor+expenses);
						var PL=parts+labor; var EO=expenses+overhead; var M=1+(MU/100);
						var sysTotal=(PL*M)+(parts*taxRate)+EO;
						var tax=parts*taxRate;
						
						if(roundUp) {
							var oldTot=sysTotal;
							sysTotal=Math.round(sysTotal/10)*10;
							if(oldTot>sysTotal) {sysTotal+=10}
						}
						
						var profit=sysTotal-PL-EO-tax;
						fixedTotal=sysTotal;
					}
					
					var partsSell=parts*((MU/100)+1);
					var laborSell=labor*((MU/100)+1);
					
					Gebi('FixedPrice').innerHTML=currencyLink+(formatCurrency(fixedTotal));
					WSQLU('Systems','FixedPrice',fixedTotal,'SystemID',serviceId);
					Gebi('MU').innerHTML=editLink+(MU);
					WSQLU('Systems','MU',MU,'SystemID',serviceId);
					
					
					Gebi('SystemTotal').innerHTML=formatCurrency(sysTotal);
	
					function p(number) {
						return Math.round((number/sysTotal)*10000)/100
					}
					
				}
				else { // Old Formula
				*/
					Gebi('TotalParts').innerHTML=formatCurrency(parts*M);
					Gebi('TotalLabor').innerHTML=formatCurrency(labor*M);
					if(isFixedPrice) { //Fixed Total Old Formula
						var sysTotal = fixedTotal;
						var overhead=overheadRate*(parts+labor+expenses);
						var PL=parts+labor; var EO=expenses+overhead;
						var M=sysTotal/(PL+(parts*taxRate)+EO);
						var tax=(((parts)*M)+parts)*taxRate;
						var profit=sysTotal-PL-EO-tax;
						MU=Math.round((M-1)*100000)/1000;
					}
					else { //Fixed Margin Old Formula
						var overhead=overheadRate*(parts+labor+expenses);
						var PL=parts+labor; var EO=expenses+overhead; var M=1+(MU/100);
						var sysTotal=(PL*M)+((parts*M)*taxRate)+EO;
						var tax=(((parts)*M)+parts)*taxRate;
						
						if(roundUp) {
							var oldTot=sysTotal;
							sysTotal=Math.round(sysTotal/10)*10;
							if(oldTot>sysTotal) {sysTotal+=10}
						}
						
						var profit=sysTotal-PL-EO-tax;
						fixedTotal=sysTotal;
					}
					
					var partsSell=parts*((MU/100)+1);
					var laborSell=labor*((MU/100)+1);
					
					Gebi('FixedPrice').innerHTML=currencyLink+(formatCurrency(fixedTotal));
					WSQLU('Systems','FixedPrice',fixedTotal,'SystemID',serviceId);
					Gebi('MU').innerHTML=editLink+(MU);
					WSQLU('Systems','MU',MU,'SystemID',serviceId);
					
					
					Gebi('JobTotal').innerHTML=formatCurrency(sysTotal);
	
					function p(number) {
						return Math.round((number/sysTotal)*10000)/100
					}
					
					Gebi('PartsSell').innerHTML='<div style="float:left;">'+formatCurrency(partsSell)+'</div><div style="float:right;">'+p(partsSell)+'%</div>';
					Gebi('LaborSell').innerHTML='<div style="float:left;">'+formatCurrency(laborSell)+'</div><div style="float:right;">'+p(laborSell)+'%</div>';
				//}
				Gebi('PartsCost').innerHTML='<div style="float:left;">'+formatCurrency(parts)+'</div><div style="float:right;">'+p(parts)+'%</div>';
				Gebi('TotalParts').innerText=formatCurrency(parts);
				Gebi('LaborCost').innerHTML='<div style="float:left;">'+formatCurrency(labor)+'</div><div style="float:right;">'+p(labor)+'%</div>';
				Gebi('TotalLabor').innerText=formatCurrency(labor);
				Gebi('TravelCost').innerHTML='<div style="float:left;">'+formatCurrency(travel)+'</div><div style="float:right;">'+p(travel)+'%</div>';
				Gebi('TotalTravel').innerText=formatCurrency(travel);
				Gebi('EquipCost').innerHTML='<div style="float:left;">'+formatCurrency(equip)+'</div><div style="float:right;">'+p(equip)+'%</div>';
				Gebi('TotalEquip').innerText=formatCurrency(equip);
				Gebi('OtherCost').innerHTML='<div style="float:left;">'+formatCurrency(other)+'</div><div style="float:right;">'+p(other)+'%</div>';
				Gebi('TotalOther').innerText=formatCurrency(other);
				
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
				AjaxErr('There was a problem with the systemCost request.', HttpText);
				return false
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}




function ProjectCost() {
	HttpText='BidASP.asp?action=projectCost&projId='+projId;
	xhr=getXHRObject();
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4) {
			if(xhr.status==200) {
				try { var xmlDoc = xhr.responseXML.documentElement }
				catch(e) { AjaxErr(' There was a problem with the ProjectCost response.', HttpText) }

				var overhead;
				var tax;
				var profit;
				var sysTotal;
				var partsSell;
				var laborSell;
				function sysCost(totalFixed,roundUp,fixedTotal,overheadRate,parts,labor,expenses,MU,taxRate) {
					
					if(useNewBidder)	{
						if(totalFixed) { //Fixed Total 2010 Formula
							sysTotal = fixedTotal;
							overhead=overheadRate*(parts+labor+expenses);
							var PLO=parts+labor+overhead;
							var M=sysTotal/(PLO+(parts*taxRate)+expenses);
							tax=parts*taxRate;
							profit=sysTotal-PLO-expenses-tax;
							MU=Math.round((M-1)*100000)/1000;
						}
						else { //Fixed Margin 2010 Formula
							overhead=overheadRate*(parts+labor+expenses);
							var PLO=parts+labor+overhead; var M=1+(MU/100);
							sysTotal=(PLO*M)+(parts*taxRate)+expenses;
							tax=parts*taxRate;
							
							if(roundUp) {
								var oldTot=sysTotal;
								sysTotal=Math.round(sysTotal/10)*10;
								if(oldTot>sysTotal) {sysTotal+=10}
							}
							
							profit=sysTotal-PLO-expenses-tax;
							fixedTotal=sysTotal;
						}
						
						partsSell=parts*((MU/100)+1);
						laborSell=labor*((MU/100)+1);
					}
					else { // Old Formula
						if(totalFixed) { //Fixed Total Old Formula
							sysTotal = fixedTotal;
							overhead=overheadRate*(parts+labor+expenses);
							var PL=parts+labor; var EO=expenses+overhead;
							var M=sysTotal/(PL+(parts*taxRate)+EO);
							tax=(((parts)*M)+parts)*taxRate;
							profit=sysTotal-PL-EO-tax;
							MU=Math.round((M-1)*100000)/1000;
						}
						else { //Fixed Margin Old Formula
							overhead=overheadRate*(parts+labor+expenses);
							var PL=parts+labor; var EO=expenses+overhead; var M=1+(MU/100);
							sysTotal=(PL*M)+((parts*M)*taxRate)+EO;
							tax=(((parts)*M)+parts)*taxRate;
							
							if(roundUp) {
								var oldTot=sysTotal;
								sysTotal=Math.round(sysTotal/10)*10;
								if(oldTot>sysTotal) {sysTotal+=10}
							}
							
							profit=sysTotal-PL-EO-tax;
							fixedTotal=sysTotal;
							
							//alert(' P:'+parts+' L:'+labor+' E:'+expenses+' O:'+overhead+' T:'+tax);
						}
						
						partsSell=parts*((MU/100)+1);
						laborSell=labor*((MU/100)+1);
						
					}
					
					return sysTotal;
				}
				//sysCost(totalFixed,fixedTotal,overheadRate,parts,labor,expenses,MU,taxRate)
				
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
					
					projTotal+=sysCost(totalFixed,roundUp,fixedTotal,overheadRate,parts,labor,expenses,MU,taxRate);
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