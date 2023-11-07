// JavaScript Document

function Edit(acctId)	{
	sessionWrite('ShownAccounts',Gebi('selShowAccounts').selectedIndex);
	parent.location='MonitoringAccount.asp?id='+acctId;
}


function delAccounts()	{
	var cbSel=document.getElementsByClassName('ItemCheckBox');
	
	if(!cbSel.length>0) return false;
	
	if(!confirm('This will remove each selected account!')) return false;
	if(!confirm('Are you sure? This cannot be undone!!!')) return false;
	
	for(cb=0;cb<cbSel.length;cb++)	{
		if(cbSel[cb].checked)	{
			delAcct(Gebi(cbSel[cb].id.replace('sel','AcctID')).innerHTML);
			var row=cbSel[cb].parentNode.parentNode;
			row.parentNode.removeChild(row);
		}
	}
}

function delAcct(id) {
	WSQL('DELETE FROM MonitoringAccounts WHERE Id='+id)
}


function downloadClick(downloadArrow,projId) {
	downloadArrow.src='../images/roller.gif';
	prepareProjectDownload(downloadArrow,projId);
	downloadArrow.style.visibility='visible';
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
	Gebi('statusPopup').style.top=(posDiv.offsetTop+posDiv.offsetHeight-5-Gebi('List').scrollTop)+'px';
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
		break;
		
		case 'Inactive' :
			Gebi('cbStatusInactive').setAttribute('checked','checked');
			WSQLUBit('MonitoringAccounts','active',false,'ID',statusAcctId);
			statusDiv.setAttribute('class','statusInactive');
			statusDiv.setAttribute('onclick','showStatusPopup('+statusAcctId+', this, 1,0)');
		break;
	}
	Gebi('statusPopup').style.display='none';
}

function contractAccount(projId, cb, won) {
	var conf='This will set all Estimating progress phases to Done.';
	if(won) { conf='This will Activate the job, lock the Account, and set all Estimating progress phases to Done.'; }
	if(!confirm(conf)) { cb.checked=!cb.checked; return false; }
	if(cb.checked) {
		WSQLUBit('Projects','Obtained',won,'ProjID',projId);
		WSQLUBit('Projects','AccountLost',!won,'ProjID',projId);
	}
	window.location=window.location;
}

function sortCol(sortField,columnDiv) {
	sessionWrite('SortAccounts',sortField);
	sessionWrite('ShownAccounts',Gebi('selShowAccounts').selectedIndex);
	//alert(Gebi('selShowAccounts').selectedIndex);
	try {
		parent.Search();
	}
	catch(e) { location=location;}
}

function selShowAccounts_Change(ssb) {
	sessionWrite('ShownAccounts',ssb.selectedIndex); 
	try{ 
		PGebi('sStatus').selectedIndex=ssb.selectedIndex;
		parent.Search(); 
	} 
	catch(e) { window.location=window.location; } 
}

function Resize()	{
	Gebi('RowContainerContainer').style.width=Gebi('ItemsHead').offsetWidth+'px';
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
