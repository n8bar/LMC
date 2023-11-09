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
function eSecField(fieldBox) {
	if(obtained) {
		if(!confirm('This Bid is under contract!  Are you sure you want to edit it?')) return false;	
	}
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="saveSecField(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function saveSecField(fBox) { 
	WSQLU('Sections', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'SectionID', secId);
	fBox.innerHTML='<a class=editLink onclick=eSecField(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
	parent.AllLists(secId);
}
function ePrintField(fieldBox) {
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="savePrintField(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function savePrintField(fBox) { 
	WSQLU('ProposalPrint', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'ID', printSettingsID);
	fBox.innerHTML='<a class=editLink onclick=ePrintField(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
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
function eSecCurrency(fieldBox) {
	if(obtained) {
		if(!confirm('This Bid is under contract!  Are you sure you want to edit it?')) return false;	
	}
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="saveSecCurrency(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function saveSecCurrency(fBox) { 
	WSQLU('Sections', fBox.id, unCurrency(Gebi(fBox.id+'Value').value), 'SectionID', secId);
	fBox.innerHTML='<a class=editLink onclick=eSecCurrency(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
	parent.AllLists(secId);
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
function eSecNotes(fieldBox) {
	if(obtained) {
		if(!confirm('This Bid is under contract!  Are you sure you want to edit it?')) return false;	
	}
	var fieldValue=CharsBr2CR(fieldBox.innerHTML.split('</a>')[1]);
	Gebi('oldNotes').innerHTML=fieldBox.innerHTML;
	var newHTML='<textarea id='+fieldBox.id+'Value style="float:left; font-size:12px; height:100%; width:80%;" >'+fieldValue+'</textarea>';
	newHTML+='<div align=center style="float:right; height:100%; overflow:hidden; padding-top:2px; text-align:center; width:19%;">';
	newHTML+='	<div class="editButton" style=width:90%; onclick=saveSecNotes(this.parentNode.parentNode);>save</div><br/>';
	newHTML+="	<div class=editButton style=width:90%; onclick=this.parentNode.parentNode.innerHTML=Gebi('oldNotes').innerHTML;>cancel</div>";
	newHTML+='</div>';
	fieldBox.innerHTML=newHTML;
}
function saveSecNotes(fBox) { 
	WSQLU('Sections', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'SectionID', secId);
	fBox.innerHTML='<a class=editLink onclick=eSecNotes(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
}
function ePrintNotes(fieldBox) {
	var fieldValue=CharsBr2CR(fieldBox.innerHTML.split('</a>')[1]);
	Gebi('oldNotes').innerHTML=fieldBox.innerHTML;
	var newHTML='<textarea id='+fieldBox.id+'Value style="float:left; font-size:12px; height:100%; width:80%;" >'+fieldValue+'</textarea>';
	newHTML+='<div align=center style="float:right; height:100%; overflow:hidden; padding-top:2px; text-align:center; width:19%;">';
	newHTML+='	<div class="editButton" style=width:90%; onclick=savePrintNotes(this.parentNode.parentNode);>save</div><br/>';
	newHTML+="	<div class=editButton style=width:90%; onclick=this.parentNode.parentNode.innerHTML=Gebi('oldNotes').innerHTML;>cancel</div>";
	newHTML+='</div>';
	fieldBox.innerHTML=newHTML;
}
function savePrintNotes(fBox) { 
	WSQLU('ProposalPrint', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'ID', printSettingsID);
	fBox.innerHTML='<a class=editLink onclick=ePrintNotes(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
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
function dateSecField(fieldBox) {
	var oldHTML=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	var displayCal='displayCalendar(Gebi(\''+fieldBox.id+'Value\'),\'mm/dd/yyyy\',\'+fieldValue+\')';
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'" onfocus="'+displayCal+'"/>';
	fieldBox.innerHTML+='<img class=editImg src="../../images/cal24x24.gif" onclick="'+displayCal+'" />';
	fieldBox.innerHTML+='<div class="editButton" onclick="saveSecDate(this.parentNode);">save</div>';
	fieldBox.innerHTML+='<div class="editButton" onclick="this.parentNode.innerHTML=\'<a class=editLink onclick=dateSecField(this.parentNode);>Edit</a>'+fieldValue+'\';">cancel</div>';
}
function saveSecDate(fBox) { 
	WSQLU('Sections', fBox.id, Gebi(fBox.id+'Value').value, 'SectionID', secId);
	fBox.innerHTML=Gebi(fBox.id+'Value').value+'<a class=editLink onclick=dateField(this.parentNode);>Edit</a>';
}
function datePrintField(fieldBox) {
	var oldHTML=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	var displayCal='displayCalendar(Gebi(\''+fieldBox.id+'Value\'),\'mm/dd/yyyy\',\'+fieldValue+\')';
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'" onfocus="'+displayCal+'"/>';
	fieldBox.innerHTML+='<img class=editImg src="../../images/cal24x24.gif" onclick="'+displayCal+'" />';
	fieldBox.innerHTML+='<div class="editButton" onclick="savePrintDate(this.parentNode);">save</div>';
	fieldBox.innerHTML+='<div class="editButton" onclick="this.parentNode.innerHTML=\'<a class=editLink onclick=dateSecField(this.parentNode);>Edit</a>'+fieldValue+'\';">cancel</div>';
}
function savePrintDate(fBox) { 
	WSQLU('ProposalPrint', fBox.id, Gebi(fBox.id+'Value').value, 'ID', printSettingsID);
	fBox.innerHTML=Gebi(fBox.id+'Value').value+'<a class=editLink onclick=datePrintField(this.parentNode);>Edit</a>';
}


function editCheck(field,bit)	{
	var trueOrFalse;
	if(bit) trueOrFalse='True';
	else trueOrFalse='False';
	
	WSQLU('Projects', field, trueOrFalse, 'ProjID', projId);
}
function eSecCheck(field,bit)	{
	if(obtained) {
		if(!confirm('This Bid is under contract!  Are you sure you want to edit it?')) {
			Gebi(field).checked=!Gebi(field).checked;
			return false;	
		}
	}
	var trueOrFalse;
	if(bit) trueOrFalse='True';
	else trueOrFalse='False';
	
	WSQLU('Sections', field, trueOrFalse, 'SectionID', secId);
	sectionCost(secId);
}

function showNewSec() {
	Gebi('Modal').style.display='block';
	Gebi('NewSecBox').style.display='block';
}
function hideNewSec() {
	Gebi('Modal').style.display='none';
	Gebi('NewSecBox').style.display='none';
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
	//Gebi('Customers').innerHTML=Gebi('Customers').innerHTML.replace('</div><div','</div><div class=sectionLink>'+name+'</div><div');
	//hideAddCust();
	window.location=window.location;
}

function deleteCusts() {
	if(!confirm('All customers will be removed.')) { return false; }
	WSQLs('DELETE FROM BidTo WHERE ProjID='+projId);
	window.location=window.location;
}



function loadSection(secId)	{
	Gebi('SecPage').setAttribute('src','BidSections.asp?secId='+secId+'&nocache='+noCache);
	showTab(Gebi('SecTab'));
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
	sectionCost(secId);
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
	sectionCost(secId);
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
	
	sectionCost(secId);
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
	sectionCost(secId);
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
	sectionCost(secId);
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
	sectionCost(secId);
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
	sectionCost(secId);
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
	if(Gebi('Part-Qty'+row).innerHTML*1<=0) { Gebi('pRow'+row).style.color='#c00'; }
	else { Gebi('pRow'+row).style.color='#000'; }
	
	//pitMaterials.innerHTML=(Gebi('pRow'+row).style.color);
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


function ExpenseLists(secID) {
	TravelList(secID);
	EquipList(secID);
	OtherList(secID);
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
	WSQL("INSERT INTO ProposalPrint (Name, ProjID, CreationKey) VALUES ('"+Gebi("newPresetName").value+"',"+projId+",'"+cKey+"')");
}

function printCust(checked,bidToId) {
	if(!checked) { checked='True' }
	else { checked='False' }
	
	WSQL('UPDATE BidTo SET noPrint=\''+checked+'\' WHERE BidToID='+bidToId);
}

function printSec(checked,proposalPrintID,sectionId) {
	if(checked) { WSQL('INSERT INTO ProposalPrintSections (MasterID,DetailID) VALUES ('+proposalPrintID+','+sectionId+')') }
	else { WSQL('DELETE FROM ProposalPrintSections WHERE MasterID='+proposalPrintID+' AND DetailID='+sectionId) }
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
	var projURL='BidPrint.asp?ProjID='+projId+'&printID='+SelI('printPreset').value;
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
	
	Gebi('cwPresetName').value=secName;
	Gebi('cwSecType').selectedIndex=0;
	//SelI('cwSecType').innerHTML=secType;
}

function showBidDuplicate() {
	Gebi('dwMoveChk').checked=false;
	Gebi('dupModal').style.display='block';
	hideMenus();
	
	Gebi('cwPresetName').value=secName;
	Gebi('cwSecType').selectedIndex=0;
	//SelI('cwSecType').innerHTML=secType;
}

function showBidMove() {
	Gebi('dwMoveChk').checked=true;
	Gebi('moveModal').style.display='block';
	hideMenus();
	
	Gebi('cwPresetName').value=secName;
	Gebi('cwSecType').selectedIndex=0;
	//SelI('cwSecType').innerHTML=secType;
}

var leftyZipped=false;
function zipLefty() {
	if(leftyZipped) {
		Lefty.style.display='block';
		lZipUp.innerHTML='▲';
		lZipLeft.innerHTML='◄';
		lZipLeft.style.position='static';
		lZipLeft.style.top=Lefty.offsetTop+('px')
	} else {
		Lefty.style.display='none';
		lZipUp.innerHTML='▼';
		lZipLeft.innerHTML='►';
		lZipLeft.style.position='absolute';
		lZipLeft.style.top=OuterBox.offsetTop+('px')
	}
	leftyZipped=!leftyZipped;
	Resize();
}


var widescreen=true;
function Resize()	{
	var leftyH;
	if (document.body.offsetWidth>1270) {
		widescreen=true;
		Gebi('Lefty').style.width='20%';
		leftyH=document.body.offsetHeight-Gebi('pathToolbar').offsetHeight-Gebi('mainToolbar').offsetHeight;
		OuterBox.style.height=(leftyH-TabsBar.offsetHeight)+('px');
		OuterBox.style.width= leftyZipped ? '98%' : '75%';
		Lefty.style.height=leftyH+('px');
		lZipLeft.style.height=OuterBox.offsetHeight+('px');
		lZipUp.style.display='none';
		lZipLeft.style.display='block';
		
		var piBoxes=document.getElementsByClassName('piBox')
		for(var i=0; i<piBoxes.length; i++) {
			piBoxes[i].style.width='100%';
			piBoxes[i].style.height='33%';
			//lDivs[i].style.marginTop='0';
		
			var lDivs=piBoxes[i].getElementsByTagName('div');
			for(var dI=0; dI<lDivs.length; dI++) {
				if (lDivs[dI].className=='ProjInfo') {
					lDivs[dI].style.height='78%';
				}
			}
		}
		
		//top.document.title='widescreen'+document.body.offsetWidth;
	}
	else {
		widescreen=false;
		Lefty.style.width='100%';
		Lefty.style.height='192px';
		lZipUp.style.display='block';
		lZipLeft.style.display='none';
		
		var piBoxes=document.getElementsByClassName('piBox')
		for(var i=0; i<piBoxes.length; i++) {
			piBoxes[i].style.width='33.3%';
			piBoxes[i].style.height='100%';
			//lDivs[i].style.marginTop='0';
		
			var lDivs=piBoxes[i].getElementsByTagName('div');
			for(var dI=0; dI<lDivs.length; dI++) {
				if (lDivs[dI].className=='ProjInfo') {
					lDivs[dI].style.height='70%';
				}
			}
		}
		
		OuterBox.style.width="98%";
		OuterBox.style.height=document.body.offsetHeight-pathToolbar.offsetHeight-mainToolbar.offsetHeight-Lefty.offsetHeight-TabsBar.offsetHeight+('px');
		
		//top.document.title='narrowscreen'+document.body.offsetWidth;
	}
		
	Gebi('costPie').contentWindow.location+='';
}
