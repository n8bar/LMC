// JavaScript Document

var oldHTML= new Array;
function editField(fieldBox) {
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1].replace('<div>','').replace('</div>','');
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="saveField(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function saveField(fBox) { 
	WSQLU('Parts', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'PartsID', pId);
	fBox.innerHTML='<a class=editLink onclick=editField(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
}


function editCurrency(fieldBox) {
	oldHTML[fieldBox.id]=fieldBox.innerHTML;
	var fieldValue=fieldBox.innerHTML.split('</a>')[1];
	fieldBox.innerHTML='<input id="'+fieldBox.id+'Value" type="text" class="editField" value="'+fieldValue+'"/>';
	fieldBox.innerHTML+='<div class=editButton onclick="saveCurrency(this.parentNode);">save</div>';
	fieldBox.innerHTML+="<div class=editButton onclick=\"this.parentNode.innerHTML=oldHTML['"+fieldBox.id+"'];\" >cancel</div>";
}
function saveCurrency(fBox) { 
	WSQLU('Parts', fBox.id, unCurrency(Gebi(fBox.id+'Value').value), 'PartsID', pId);
	fBox.innerHTML='<a class=editLink onclick=editCurrency(this.parentNode);>Edit</a>'+Gebi(fBox.id+'Value').value;
}

function editNotes(fieldBox) {
	var fieldValue=CharsBr2CR(fieldBox.innerHTML.split('</a>')[1]);
	Gebi('oldNotes').innerHTML=fieldBox.innerHTML;
	var newHTML='<textarea id='+fieldBox.id+'Value style="float:left; font-size:12px; height:100%; width:80%;" >'+fieldValue+'</textarea>';
	newHTML+='<div align=center style="float:right; height:100%; overflow:hidden; padding-top:2px; text-align:center; width:19%;">';
	newHTML+='	<div class=editButton style=width:90%; onclick=saveNotes(this.parentNode.parentNode);>save</div><br/>';
	newHTML+='	<div class=editButton style=width:90%; onclick="this.parentNode.parentNode.innerHTML=Gebi(\'oldNotes\').innerHTML;">cancel</div>';
	newHTML+='</div>';
	fieldBox.innerHTML=newHTML;
}
function saveNotes(fBox) { 
	WSQLU('Parts', fBox.id, CharsEncode(Gebi(fBox.id+'Value').value), 'PartsID', pId);
	fBox.innerHTML='<a class=editLink onclick=editNotes(this.parentNode);>Edit</a>'+CharsCR2Br(Gebi(fBox.id+'Value').value);
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
	WSQLU('Parts', fBox.id, Gebi(fBox.id+'Value').value, 'PartsID', pId);
	fBox.innerHTML=Gebi(fBox.id+'Value').value+'<a class=editLink onclick=dateField(this.parentNode);>Edit</a>';
}

function editCheck(field,bit)	{
	var trueOrFalse;
	if(bit) trueOrFalse='True';
	else trueOrFalse='False';
	
	WSQLU('Parts', field, trueOrFalse, 'PartsID', pId);
}
