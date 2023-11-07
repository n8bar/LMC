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
	var values=projId+",'"+CharsEncode(f.jpShelf.value)+"','"+CharsEncode(f.shipToAttn.value)+"','"+CharsEncode(f.shipToName.value)+"','"+CharsEncode(f.shipToAddress.value)+"','"+CharsEncode(f.shipToCity.value)+"','"+CharsEncode(f.shipToState.value)+"','"+CharsEncode(f.shipToZip.value)+"','"+CharsEncode(+f.notes.value)+"'";
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
	var jpIncomplete=false;
	var stati=document.getElementsByClassName('jpiStatus');
	
	var sCanDo=jpiStatus.canDo.replace(/\//g,'').replace(/"/g,'').replace(/\./g,'').replace(/ /g,'').replace(/</g,'').replace(/>/g,'').toUpperCase();
	var sCheck=jpiStatus.check.replace(/\//g,'').replace(/"/g,'').replace(/\./g,'').replace(/ /g,'').replace(/</g,'').replace(/>/g,'').toUpperCase();
	var sCheese=jpiStatus.cheese.replace(/\//g,'').replace(/"/g,'').replace(/\./g,'').replace(/ /g,'').replace(/</g,'').replace(/>/g,'').toUpperCase();
	
	for(var s=0; s<stati.length; s++) {
		var rowNum=stati[s].id.replace('status','')
		var status=stati[s].innerHTML.replace(/\//g,'').replace(/"/g,'').replace(/\./g,'').replace(/ /g,'').replace(/</g,'').replace(/>/g,'').toUpperCase();
		//alert('canDo:\n  '+sCanDo+'\n\ncheck:\n  '+sCheck+'\n\ncheese:\n  '+sCheese+'\n\nthis1:\n  '+status);		
		if(status!=sCheck && status!=sCheese) { jpIncomplete=true;  /** /alert('showing Incomplete!?!\n check:'+(status==sCheck)+'\ncheese:'+(status==sCheese)+'\n'+status+'\n'+sCheck+'\n'+sCheese)/**/ }
		if(status==sCanDo) {
			canDoMsg+='There are '+Gebi('iQty'+rowNum).innerHTML+' '+Gebi('PN'+rowNum).innerHTML+'\'s available in inventory.\n';
		}
	}
	if(canDoMsg!='') {
		canDoMsg+='\nClick OK only if you are sure we are sending this Job Pack without them.  ';
		if(!confirm(canDoMsg)) return false;
	}
	
	var keepJobPack=jpIncomplete;
	var daNullThingy=null;//thanks kendon!
	if(jpIncomplete) {
		var theRest= {
			title: 'The Job Pack is Still Incomplete!',
			ask: ' &nbsp; &nbsp;There are still missing parts for this Material Request.\n\nDo you want to keep these items (when they come) in this Job Pack or just have them drop shipped? <span id=moreInfo><button onClick="moreInfo.innerHTML=\'<br/> &nbsp; &nbsp;Since this Job Pack is incomplete, we will be ordering the remainder of the parts.  If all of these parts will be shipped directly to the Job Site, there is no need to keep a Job Pack for them so click [Drop Ship].  If some or all of these parts will NOT be shipping directly to the job, you will likely need to keep a job pack when the product(s) arrive, so click [Keep Job Pack]\';"><small><small>Explain This.</small></small></button></span>',
			labels: ['Keep Job Pack','Drop Ship','Cancel'],
			values:[true,false,daNullThingy]
		}
	
		keepJobPack=showModalDialog("ButtonDialog.html",theRest,"dialogwidth:480; dialogheight:120; resizable:no")
	
		//alert(keepJobPack);
	
		if (keepJobPack==null) return false;
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
		WSQLUSJAX('JobPacks','ShipToName',iResult[s2Name],'ID',jpId);
		WSQLUSJAX('JobPacks','ShipToAttn',iResult[s2Attn],'ID',jpId);
		WSQLUSJAX('JobPacks','ShipToAddress',iResult[s2Addr],'ID',jpId);
		WSQLUSJAX('JobPacks','ShipToCity',iResult[s2City],'ID',jpId);
		WSQLUSJAX('JobPacks','ShipToState',iResult[s2State],'ID',jpId);
		WSQLUSJAX('JobPacks','ShipToZip',iResult[s2Zip],'ID',jpId);
		WSQLUSJAX('JobPacks','dateShipped',iResult[s2Date],'ID',jpId);
		WSQLUSJAX('JobPacks','SentVia',iResult[s2Via],'ID',jpId);
		WSQLUSJAX('JobPacks','Tracking',iResult[s2Track],'ID',jpId);
		//if(!keepJobPack) WSQLUBitSJAX('JobPacks','Shipped',true,'ID',jpId);		
		sendItems(keepJobPack);
	}
	if(!jpIncomplete) {
		WSQLUBitSJAX('MaterialRequests','RequestFilled',true,'id',mrId);
		var jpUrl=window.location.toString().toLowerCase();
		//alert(jpUrl);
		if(jpUrl.indexOf('&id='+mrId)>0 || jpUrl.indexOf('?id='+mrId)>0) {
			jpUrl=jpUrl.replace('&id='+mrId,'&jp='+jpId).replace('?id='+mrId,'?jp='+jpId);
		}
		else {
			jpUrl=window.location.toString().split('?')[0]
		}
		//alert(jpUrl);
		sW('JPFrameURL',CharsEncode(jpUrl));
		parent.location=parent.location;
	}
}


//////////AJAX/SJAX///////////////////////

function updateJPQ(partsID,qty,row) {
	HttpText='MaterialsASP.asp?action=updatejpq&partsID='+partsID+'&mrid='+mrId+'&JPID='+jpId+'&qty='+qty+'&noCache='+uid();
	xmlHttp = getXHR();
	xmlHttp.onreadystatechange = updatedJPQ
	xmlHttp.open('Get',HttpText, false); //false=SJAX
	xmlHttp.send(null);
	if(xmlHttp.status==200) {return updatedJPQ();} //Firefox code for SJAX (AJAX doesn't use this line)
	
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

function sendItems(keepJP) {
	HttpText='MaterialsASP.asp?action=JPsendItems&JPID='+jpId+'&keepJP='+keepJP+'&noCache='+uid();
	xmlHttp = getXHR();
	xmlHttp.onreadystatechange = sentItems
	xmlHttp.open('Get',HttpText, false); //false=SJAX
	xmlHttp.send(null);
	if(xmlHttp.status==200) {return sentItems();} //Firefox code for SJAX (AJAX doesn't use this line)
	
	function sentItems() {
  	if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				try {var xmlDoc = xmlHttp.responseXML.documentElement; }
				catch(e) { AjaxErr('There is an error with the updateJPQ response document.',HttpText) }
				//AjaxErr('√ the updateJPQ response document.',HttpText) 
				var xml=xml2json(xmlDoc);
				
				
			}
		}
	}
}