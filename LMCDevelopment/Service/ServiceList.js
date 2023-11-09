// JavaScript Document

function Edit(Id)	{
	sessionWrite('ShownServices',Gebi('selShowServices').selectedIndex);
	parent.location='ServiceJob.asp?id='+Id;
}


function delServices()	{
	var cbSel=document.getElementsByClassName('ItemCheckBox');
	
	if(!cbSel.length>0) return false;
	
	if(!confirm('This will delete each and all the checked jobs and cannot be undone!')) return false;
	if(!confirm('Really???')) return false;
	
	for(cb=0;cb<cbSel.length;cb++)	{
		if(cbSel[cb].checked)	{
			delJob(Gebi(cbSel[cb].id.replace('sel','ID')).innerHTML);
		}
	}
}

var statusJobId=0;
var statusDiv=false;
function showStatusPopup(job,posDiv,lost,won,done) {
	statusJobId=job;
	statusDiv=posDiv;
	lost=(lost==1);
	won=(won==1);
	done=(done==1);
	if((lost&&won)) {
		WSQLUBit('Services','CustAgreed',false,'ID',Id);
		WSQLUBit('Services','CustDeclined',false,'ID',Id);
		lost=false;
		won=false;
	}
	var active=won;
	if(done) active=false;
	
	var sOpen=!(lost||active||done)
	Gebi('cbStatusOpen').checked=sOpen;
	Gebi('cbStatusWon').checked=!(lost||sOpen||done);
	Gebi('cbStatusLost').checked=!(active||sOpen||done);
	Gebi('cbStatusDone').checked=!(active||sOpen||lost);
	
	Gebi('statusPopup').style.left=(posDiv.offsetLeft+posDiv.offsetWidth-5)+'px';
	Gebi('statusPopup').style.top=(posDiv.offsetTop+posDiv.offsetHeight-5-Gebi('List').scrollTop)+'px';
	Gebi('statusPopup').style.display='block';
}

function setStatus(state, stateIs) {
	Gebi('cbStatusWon').removeAttribute('checked');
	Gebi('cbStatusLost').removeAttribute('checked');
	Gebi('cbStatusOpen').removeAttribute('checked');
	Gebi('cbStatusDone').removeAttribute('checked');
	
	//alert(state+', '+stateIs)
	
	switch(state) {
		case 'Open':
			Gebi('cbStatusOpen').setAttribute('checked','checked');
			WSQLUBit('Services','CustAgreed',false,'ID',statusJobId);
			WSQLUBit('Services','CustDeclined',false,'ID',statusJobId);
			WSQLUBit('Services','Active',false,'ID',statusJobId);
			WSQLUBit('Services','Done',false,'ID',statusJobId);
			statusDiv.setAttribute('class','statusOpen'); statusDiv.innerHTML='';
			statusDiv.setAttribute('onclick','showStatusPopup('+statusJobId+', this, 0,0,0)');
		break;
		
		case 'Active' :
			Gebi('cbStatusWon').setAttribute('checked','checked');
			WSQLUBit('Services','CustAgreed',true,'ID',statusJobId);
			WSQLUBit('Services','CustDeclined',false,'ID',statusJobId);
			WSQLUBit('Services','Active',true,'ID',statusJobId);
			WSQLUBit('Services','Done',false,'ID',statusJobId);
			var d=new Date();
			var d=(d.getMonth()+1).toString()+'/'+d.getDate().toString()+'/'+d.getFullYear().toString();
			statusDiv.setAttribute('class','statusWon'); statusDiv.innerHTML='';
			statusDiv.setAttribute('onclick','showStatusPopup('+statusJobId+', this, 0,1,0)');
		break;
		
		case 'Lost' :
			Gebi('cbStatusLost').setAttribute('checked','checked');
			WSQLUBit('Services','CustAgreed',false,'ID',statusJobId);
			WSQLUBit('Services','CustDeclined',true,'ID',statusJobId);
			WSQLUBit('Services','Active',false,'ID',statusJobId);
			WSQLUBit('Services','Done',false,'ID',statusJobId);
			statusDiv.setAttribute('class','statusLost'); statusDiv.innerHTML='';
			statusDiv.setAttribute('onclick','showStatusPopup('+statusJobId+', this, 1,0,0)');
		break;
		
		case 'Done' :
			Gebi('cbStatusDone').setAttribute('checked','checked');
			WSQLUBit('Services','CustAgreed',true,'ID',statusJobId);
			WSQLUBit('Services','CustDeclined',false,'ID',statusJobId);
			WSQLUBit('Services','Active',false,'ID',statusJobId);
			WSQLUBit('Services','Done',true,'ID',statusJobId);
			statusDiv.setAttribute('class','statusDone'); statusDiv.innerHTML='✔';
			statusDiv.setAttribute('onclick','showStatusPopup('+statusJobId+', this, 0,0,1)');
		break;
	}
	Gebi('statusPopup').style.display='none';
}

function contractService(projId, cb, won) {
	var conf='This will set all progress phases to Done.';
	if(won) { conf='This will Activate the job, lock the Quote, and set all progress phases to Done.'; }
	if(!confirm(conf)) { cb.checked=!cb.checked; return false; }
	if(cb.checked) {
		WSQLUBit('Services','CustAgreed',won,'ProjID',projId);
		WSQLUBit('Services','CustDeclined',!won,'ProjID',projId);
	}
	window.location=window.location;
}

function sortCol(sortField,columnDiv) {
	sessionWrite('SortServices',sortField);
	sessionWrite('ShownServices',Gebi('selShowServices').selectedIndex);
	//alert(Gebi('selShowServices').selectedIndex);
	try {
		parent.Search();
	}
	catch(e) { location=location;}
}

function selShowServices_Change(ssb) {
	sessionWrite('ShownServices',ssb.selectedIndex); 
	try{ 
		PGebi('sStatus').selectedIndex=ssb.selectedIndex;
		parent.Search(); 
	} 
	catch(e) { window.location=window.location; } 
}

function Resize()	{
	if(!!Gebi('RowContainerContainer')) Gebi('RowContainerContainer').style.width=Gebi('ItemsHead').offsetWidth+'px';
	//var rows=document.getElementsByClassName('RowContainer');
	//var rL=rows.length;
	//alert('rL:'+rL);
	//for(r=0;r<rL;r++) {		
	//	//rows[r].style.width=Gebi('ItemsHead').offsetWidth+'px';
	//	Gebi('RowContainerContainer').style.height=Gebi('rowContainerContainer').offsetHeight+rows[r].offsetHeight+('px');
	//}
	Gebi('LoadText').innerHTML='Loading...';
	Gebi('List').style.height='100%';
	Gebi('List').style.height=Gebi('List').offsetHeight-Gebi('listHead').offsetHeight-Gebi('ItemsHead').offsetHeight-8+('px');
}
