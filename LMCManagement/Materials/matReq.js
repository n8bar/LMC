// JavaScript Document
	
function newMatReq(form) {
	var cKey=new Date();
	var date=(cKey.getMonth()+1)+'/'+(cKey.getDate()+1)+'/'+cKey.getFullYear();
	cKey=cKey.getFullYear()+(cKey.getMonth()+1)+cKey.getDate()+cKey.getHours()+cKey.getMinutes()+cKey.getSeconds()+cKey.getMilliseconds()+sessionID;
	
	var fields=' ProjID,ShipToName,ShipToAttn,ShipToAddress,ShipToCity,ShipToState,shipToZip,Date,Due,ByEmpId,creationKey,notes ';
	var values=ProjID;
	values+=", '"+CharsEncode(form.elements.shipToName.value)+"' ";
	values+=", '"+CharsEncode(form.elements.shipToAttn.value)+"' ";
	values+=", '"+CharsEncode(form.elements.shipToAddress.value)+"' ";
	values+=", '"+CharsEncode(form.elements.shipToCity.value)+"' ";
	values+=", '"+CharsEncode(form.elements.shipToState.value)+"' ";
	values+=", '"+CharsEncode(form.elements.shipToZip.value)+"' ";
	values+=", "+date+" ";
	values+=", "+form.elements.Due.value+" ";
	values+=", "+SelI(form.elements.empID.id).value+" ";
	values+=", '"+cKey+"' ";
	values+=", '"+CharsEncode(form.elements.notes.value)+"' ";
	//alert(values);
	
	var sql='INSERT INTO MaterialRequests ('+fields+') VALUES ( '+values+' )'
	var itWorked=WSQLs(sql);
	//alert(sql);
	if(itWorked) { noCacheReload() }
}

function updateMatReq(form) {
	WSQLU('MaterialRequests', 'ShipToName', CharsEncode(form.elements.shipToName.value), 'Id', mrId );
	WSQLU('MaterialRequests', 'shipToAttn', CharsEncode(form.elements.shipToAttn.value), 'Id', mrId );
	WSQLU('MaterialRequests', 'shipToAddress', CharsEncode(form.elements.shipToAddress.value), 'Id', mrId );
	WSQLU('MaterialRequests', 'shipToCity', CharsEncode(form.elements.shipToCity.value), 'Id', mrId );
	WSQLU('MaterialRequests', 'shipToState', CharsEncode(form.elements.shipToState.value), 'Id', mrId );
	WSQLU('MaterialRequests', 'shipToZip', CharsEncode(form.elements.shipToZip.value), 'Id', mrId );
	WSQLU('MaterialRequests', 'Due', CharsEncode(form.elements.Due.value), 'Id', mrId );
	WSQLU('MaterialRequests', 'ByEmpID', CharsEncode(SelI(form.elements.empID.id).value), 'Id', mrId );
	WSQLU('MaterialRequests', 'notes', CharsEncode(form.elements.notes.value), 'Id', mrId );
	form.style.display='none';
}
	

function copyPart(rI,biId) {
	Gebi('Modal').style.display='block';
	//alert(rI+','+biId);
	try {
		if(mrId==0) {
			alert('You need an active Material Request before you can add materials.')
			return false;
		}
		if(rI==0&&biId==0) {
			if(confirm('Do you want to copy the whole B.O.M to your material request?')) {
				var copiers=document.getElementsByClassName('copyButton');
				
				for(var c=0; c<copiers.length; c++) {
					copiers[c].onclick();
				}
				return true;
			}
			else { return false; }
		}
		BidPartToMR(biId);
	}
	finally {
		Gebi('Modal').style.display='none';
	}
}

function mrDelete(row,partsId) {
	var mrid=row.split('-')[0];
	SQL='DELETE FROM MatReqItems WHERE mrId='+mrid+' AND PartsID='+partsId;
	WSQL(SQL);
	Gebi('mrRow'+row).parentNode.removeChild(Gebi('mrRow'+row));
}

function mrEditSave(row) {
	if (Gebi('mrEditSaveImg'+row).getAttribute('class')=='pencil') {mrEdit(row); } else {mrSave(row);}
}
function mrEdit(row) {
	Gebi('mrQty'+row).removeAttribute('readonly');
	Gebi('mrEditSaveImg'+row).setAttribute('class','save');
	Gebi('mrQty'+row).focus();
	Gebi('mrQty'+row).select();
}
function mrSave(row) {
	var newQty=Gebi('mrQty'+row).value;
	var unitSize=Gebi('mrUnitSize'+row).value*1
	newQty=roundUp(newQty/unitSize)*unitSize;
	var original=Gebi('mrQty'+row).getAttribute('ovalue')*1;
	if (newQty/unitSize>10000) {
		if(confirm('Woops!\n There is a limit of 10000 for each Part Number, because not much more would overload the system. \n\n   Would you like to go ahead and do 10000?') ) {
			newQty=10000
		}
		else {
			//alert(' If you need more than 10000 parts, consider adding a whole package as a new part to the parts library.  \n   For example: If I needed 20000 Horns, Part # MG1F-HD, for a big fire alarm job.  Since they come in boxes of 50, I\'d add a new part called something like "Box of 50 Horns" with a Part # like "MG1F-HD-50ea".  Then, after adding that part to my Material Request, I\'d calculate 20000 Horns divided by 50 per box 20000 / 50 = 400 boxes, so I\'d enter a quantity of 400.');
			return false;
		}
	}
	var diff=(newQty-original)/unitSize;
	//alert(diff+' >> '+roundUp(diff));
	diff=roundUp(diff);
	var idList=Gebi('idList'+row).value.split(',');
	idList=idList.map(function (x) { return x*1; } );
	//alert(idList.length+' hoonies :'+idList);
	
	/*
	if(idList.length*1!=(original/unitSize)*1) {
		if (confirm('Count Mismatch Error\n['+idList.length+':'+(original/unitSize)+'] \n\n This is most likely caused by someone else simultaneously editing this M.R. \n Click OK to reload.')) noCacheReload();
		return false;
	}
	*/
	
	var cost=unCurrency(Gebi('mrCost'+row).innerHTML)
	if(diff>0) {
		//Gebi('right').innerHTML+='<br/>adding '+diff+'<br/>';
		var fields='mRID,ProjID,PartsID,Mfr,PartNo,Description,unitSize,Cost,CreationKey';
		var values=mrId+",";
		values+=ProjID+",";
		values+=Gebi('mrPartsID'+row).value+",";
		values+="'"+CharsEncode(Gebi('mrMfr'+row).innerHTML)+"',";
		values+="'"+CharsEncode(Gebi('mrPN'+row).innerHTML)+"',";
		values+="'"+CharsEncode(Gebi('mrDesc'+row).innerHTML)+"',";
		values+=unitSize+",";
		values+=cost+",";
		for(var p=0;p<diff;p++) {
			var cKey=''+uid();
			var sql="INSERT INTO MatReqItems ("+fields+") VALUES ("+values+"'"+cKey+"')"
			//Gebi('right').innerHTML+='<br/>'+p+'<br/>'+sql;
			WSQLs(sql);
			//Gebi('right').innerHTML+='<br/><small style=font-family:Condensed; ><small><small>'+idList.toString()+'</small></small></small>';
			idList.push(cKey);
			//Gebi('right').innerHTML+='<br/><small style=font-family:Condensed; ><small><small>'+idList.toString()+'</small></small></small>';
		}
	}
	if(diff<0) {
		for(var p=0; p<Math.abs(diff); p++) {
			var sql="DELETE FROM MatReqItems WHERE Id='"+idList[0]+"' OR CreationKey='"+idList[0]+"'";
			//Gebi('right').innerHTML+='<br/>'+sql;
			WSQLs(sql);
			//Gebi('right').innerHTML+='<br/><small style=font-family:Condensed; ><small><small>'+idList.toString()+'</small></small></small>';
			idList.reverse(); idList.pop(); idList.reverse(); 
			//Gebi('right').innerHTML+='<br/><small style=font-family:Condensed; ><small><small>'+idList.toString()+'</small></small></small>';
		}
	}
	newQty=idList.length*unitSize;
	Gebi('idList'+row).value=idList.toString();
	Gebi('mrQty'+row).value=newQty;
	Gebi('mrQty'+row).setAttribute('ovalue',newQty)
	Gebi('mrQty'+row).setAttribute('readonly','true');
	Gebi('mrTotal'+row).innerHTML=formatCurrency(cost*newQty);
	Gebi('mrEditSaveImg'+row).setAttribute('class','pencil');
}

function deleteMR() {
	if(!confirm('Are you sure you want to delete the Material Request #'+mrId)) {  return false; } 
	
}

function submitMR(id) {
	if(MRData.MatReq[0].empty) {alert('There is no need to submit an empty Material Request!'); return false; }
	//if (confirm('After submitting a Material Request, any changes will have to be made under Job Packs.')) {
		WSQLs("UPDATE MaterialRequests SET Done=1 WHERE id="+id); 
		noCacheReload();
	//}
}


function toggleDetails() {
	if (Gebi('newMR').style.display=='none') { Gebi('newMR').style.display='block'; } else { Gebi('newMR').style.display='none'; }
}



var lsTimer;
function leftScroll() {
	Gebi('bidItemsHead').style.visibility='hidden';
	clearTimeout(lsTimer);
	lsTimer=setTimeout("Gebi('bidItemsHead').style.top=Gebi('left').scrollTop+'px'; Gebi('bidItemsHead').style.visibility='visible';",250);
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

var addToSysId;
function showAddPart() {
	Gebi('Modal').style.display='block';
	//alert(sysNames);
	var Dialog=new Object;
	Dialog.title='System Chooser';
	Dialog.ask='Please Choose a System:';
	Dialog.labels=sysNames;
	Dialog.values=sysIDs;
	addToSysId=showModalDialog('ChooserDialog.html',Dialog,'dialogwidth:640; dialogheight:480; resizable:no;');
	
	if(!addToSysId) {
		Gebi('Modal').style.display='none';
		return false;
	}

	Gebi('AddPartContainer').style.display='block';
}