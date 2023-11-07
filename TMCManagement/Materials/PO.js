// JavaScript Document
function resize() {
	//Gebi('jpItemsHead').style.width=Gebi('nothingRow').offsetWidth+'px';
	Gebi('top').style.position='relative';
	Gebi('top').style.width=Gebi('top').offsetWidth+'px';
	Gebi('top').style.position='absolute';
	try { Gebi('jpItemsHead').style.width=Gebi('nothingRow').offsetWidth+('px'); } catch(e) {}
}

function newJobPack() {
	var f=Gebi('newJP').elements;
	var fields="ProjID,Shelf,ShipToAttn,ShipToName,ShipToAddress,ShipToCity,ShipToState,ShipToZip,notes";
	var values=projId+",'"+CharsDecode(f.jpShelf.value)+"','"+CharsDecode(f.shipToAttn.value)+"','"+CharsDecode(f.shipToName.value)+"','"+CharsDecode(f.shipToAddress.value)+"','"+CharsDecode(f.shipToCity.value)+"','"+CharsDecode(f.shipToState.value)+"','"+CharsDecode(f.shipToZip.value)+"','"+CharsDecode(+f.notes.value)+"'";
	WSQLs('INSERT INTO JobPacks ('+fields+') VALUES ('+values+')');
	noCacheReload();
}

function movePart(r) {
	var iQty=Gebi('iQty'+r).innerHTML*1;
	var nQty=Gebi('nQty'+r).innerHTML*1;
	var jpQty=Gebi('jpQty'+r).value;
	var xQty= nQty>iQty ? iQty : nQty;	
	Gebi('jpQty'+r).value+=xQty;	
	WSQLs('UPDATE Parts SET Inventory=0'+(iQty-xQty)+' WHERE PartsID='+Gebi('PartsID'+r).value);
	sRow(r);
	//Gebi('iQty'+r).innerHTML-=xQty;
	//Gebi('nQty'+r).innerHTML-=xQty;
}

function eRow(r) {
	Gebi('edit'+r).setAttribute('class',Gebi('edit'+r).getAttribute('class').replace('editBtn','saveBtn'));
	Gebi('edit'+r).setAttribute('onclick','sRow('+r+');');
	Gebi('jpQty'+r).removeAttribute('readonly');
	Gebi('jpQty'+r).select();
}

function sRow(r) {
	var qty=Gebi('jpQty'+r).value*1;
	updateJPQ(Gebi('PartsID'+r).value,qty,r); 
	//var qty=Gebi('jpQty'+r).value;
	//updateJPQ(Gebi('PartsID'+r).value,qty+1,r);//ya know what I'm sayin?
	Gebi('jpQty'+r).setAttribute('readonly',true);
	Gebi('edit'+r).setAttribute('class',Gebi('edit'+r).getAttribute('class').replace('saveBtn','editBtn'));
	Gebi('edit'+r).setAttribute('onclick','eRow('+r+');');
}


function sendJP() {

	var canDoMsg='';
	var stati=document.getElementsByClassName('jpiStatus');
	for(var s=0; s<stati.length; s++) {
		var rowNum=stati[s].id.replace('status','')
		if(stati[s].innerHTML==jpiStatus.canDo) {
			canDoMsg+='There are '+Gebi('iQty'+rowNum).innerHTML+' of Part Number: '+Gebi('PN'+rowNum).innerHTML+' in inventory.\n\n';
		}
	}
	if(canDoMsg!='') {
		canDoMsg+='\nAre you sure we need to order these parts anyway??';
		if(!confirm(canDoMsg)) return false;
	}
	var s2Name='Ship To:';
	var s2Attn='ATTN:';
	var s2Addr='Address:';
	var s2City='City:';
	var s2State='State:';
	var s2Zip='Zip:';
	var s2Date='Sent Date:';
	var s2Via='Sent Via <small>[<small>Ex: UPS,FedEx,EmployeeName</small>]</small>';
	var s2Track='Tracking# or Phone# of Carrier';
	var d8=new Date;
	d8=(d8.getMonth()+1)+'/'+d8.getDate()+'/'+d8.getFullYear();
	var data=new Object;
	data.title='Job Pack Information';
	data.ask='<big><b>Confirm Job Pack Information</b></big><br/>Notes:\n   <p>'+jpNotes.innerHTML+'</p>';
	data.labels=[s2Name,s2Attn,s2Addr,s2City,s2State,s2Zip,s2Date,s2Via,s2Track];
	data.values=[shipToName.innerHTML,shipToAttn.innerHTML,shipToAddress.innerHTML,shipToCity.innerHTML,shipToState.innerHTML,shipToZip.innerHTML,d8,'',''];
	data.isDate=[ 'text', 'text', 'text', 'text', 'text', 'text', 'date', 'text' ];
	var iResult=showModalDialog("CustomDialog.html",data,"dialogwidth:640; dialogheight:480; resizable:no")
	
	if(!!iResult) {
		WSQLU('JobPacks','ShipToName',iResult[s2Name],'ID',jpId);
		WSQLU('JobPacks','ShipToAttn',iResult[s2Attn],'ID',jpId);
		WSQLU('JobPacks','ShipToAddress',iResult[s2Addr],'ID',jpId);
		WSQLU('JobPacks','ShipToCity',iResult[s2City],'ID',jpId);
		WSQLU('JobPacks','ShipToState',iResult[s2State],'ID',jpId);
		WSQLU('JobPacks','ShipToZip',iResult[s2Zip],'ID',jpId);
		WSQLU('JobPacks','dateShipped',iResult[s2Date],'ID',jpId);
		WSQLU('JobPacks','SentVia',iResult[s2Via],'ID',jpId);
		WSQLU('JobPacks','Tracking',iResult[s2Track],'ID',jpId);
		WSQLUBitSJAX('JobPacks','Shipped',true,'ID',jpId);
		
	}
}


//////////AJAX/SJAX///////////////////////

function updateJPQ(partsID,qty,row) {
	HttpText='MaterialsASP.asp?action=updatejpq&partsID='+partsID+'&mrid='+mrId+'&JPID='+jpId+'&qty='+qty+'&noCache='+uid();
	xmlHttp = getXHR();
	xmlHttp.onreadystatechange = updatedJPQ
	xmlHttp.open('Get',HttpText, false);
	xmlHttp.send(null);
	if(xmlHttp.status==200) {return updatedJPQ();} //Firefox code for SJAX (AJAX doesn't make good use of this line)
	
	function updatedJPQ() {
  	if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				try {var xmlDoc = xmlHttp.responseXML.documentElement; }
				catch(e) { AjaxErr('There is an error with the updateJPQ response document.',HttpText) }
				//AjaxErr('√ the updateJPQ response document.',HttpText) 
				var xml=xml2json(xmlDoc);
				
				Gebi('jpQty'+row).value=xml.jpQty*1;
				Gebi('nQty'+row).innerHTML=xml.nQty*1;
				Gebi('iQty'+row).innerHTML=xml.iQty*1;
				
				Gebi('status'+row).innerHTML=Gebi('canDo').innerHTML;
				if(xml.nQty*1 == 0 ) Gebi('status'+row).innerHTML=Gebi('check').innerHTML;
				if(xml.nQty*1 < 0 ) Gebi('status'+row).innerHTML=Gebi('cheese').innerHTML;
				if( ( xml.nQty*1 > 0 ) && ( xml.iQty<xml.nQty )  ) Gebi('status'+row).innerHTML=Gebi('need2order').innerHTML;
			}
		}
	}
}
