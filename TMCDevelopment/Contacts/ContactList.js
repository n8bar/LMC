// JavaScript Document

function Edit(ContactId)	{
	sessionWrite('ShownContacts',Gebi('selShowContacts').selectedIndex);
	parent.location='Contact.asp?id='+ContactId;
}


function delContacts()	{
	var cbSel=document.getElementsByClassName('ItemCheckBox');
	
	if(!cbSel.length>0) return false;
	
	if(!confirm('This will remove each selected Contact')) return false;
	if(!confirm('Are you sure?')) return false;
	
	for(cb=0;cb<cbSel.length;cb++)	{
		if(cbSel[cb].checked)	{
			delContact(Gebi(cbSel[cb].id.replace('sel','ContactID')).innerHTML);
			cbSel[cb].parentNode.parentNode.parentNode.parentNode.removeChild(cbSel[cb].parentNode.parentNode.parentNode);
		}
	}
}

function downloadClick(downloadArrow,ContactId) {
	downloadArrow.src='../images/roller.gif';
	prepareContactDownload(downloadArrow,ContactId);
	downloadArrow.style.visibility='visible';
}

var statusContactId=0;
var statusDiv=false;
function showStatusPopup(Contact,posDiv,lost,won) {
	statusContactId=Contact;
	statusDiv=posDiv;
	if(lost&&won) {
		WSQLUBit('Contacts','Obtained',false,'ContactID',ContactId);
		WSQLUBit('Contacts','ContactLost',false,'ContactID',ContactId);
		lost=false;
		won=false;
	}
	Gebi('cbStatusOpen').checked=!(lost||won);
	Gebi('cbStatusWon').checked=won;
	Gebi('cbStatusLost').checked=lost;
	
	Gebi('statusPopup').style.left=(posDiv.offsetLeft+posDiv.offsetWidth-5)+'px';
	Gebi('statusPopup').style.top=(posDiv.offsetTop+posDiv.offsetHeight-5-Gebi('List').scrollTop)+'px';
	Gebi('statusPopup').style.display='block';
}

function setStatus(state, stateIs) {
	Gebi('cbStatusWon').removeAttribute('checked');
	Gebi('cbStatusLost').removeAttribute('checked');
	Gebi('cbStatusOpen').removeAttribute('checked');
	switch(state) {
		case 'Open':
			Gebi('cbStatusOpen').setAttribute('checked','checked');
			WSQLUBit('Contacts','Obtained',false,'ContactID',statusContactId);
			WSQLUBit('Contacts','ContactLost',false,'ContactID',statusContactId);
			WSQLUBit('Contacts','Active',false,'ContactID',statusContactId);
			statusDiv.setAttribute('class','statusOpen');
			statusDiv.setAttribute('onclick','showStatusPopup('+statusContactId+', this, 0,0)');
		break;
		
		case 'Won' :
			Gebi('cbStatusWon').setAttribute('checked','checked');
			WSQLUBit('Contacts','Obtained',true,'ContactID',statusContactId);
			WSQLUBit('Contacts','ContactLost',false,'ContactID',statusContactId);
			WSQLUBit('Contacts','Active',true,'ContactID',statusContactId);
			var d=new Date();
			var d=(d.getMonth()+1).toString()+'/'+d.getDate().toString()+'/'+d.getFullYear().toString();
			alert(d);
			WSQLU('Contacts','DateStarted',d,'ContactID',statusContactId);
			statusDiv.setAttribute('class','statusWon');
			statusDiv.setAttribute('onclick','showStatusPopup('+statusContactId+', this, 0,1)');
		break;
		
		case 'Lost' :
			Gebi('cbStatusLost').setAttribute('checked','checked');
			WSQLUBit('Contacts','Obtained',false,'ContactID',statusContactId);
			WSQLUBit('Contacts','ContactLost',true,'ContactID',statusContactId);
			WSQLUBit('Contacts','Active',false,'ContactID',statusContactId);
			statusDiv.setAttribute('class','statusLost');
			statusDiv.setAttribute('onclick','showStatusPopup('+statusContactId+', this, 1,0)');
		break;
	}
	Gebi('statusPopup').style.display='none';
}

function contractContact(ContactId, cb, won) {
	var conf='This will set all Estimating progress phases to Done.';
	if(won) { conf='This will Activate the job, lock the Contact, and set all Estimating progress phases to Done.'; }
	if(!confirm(conf)) { cb.checked=!cb.checked; return false; }
	if(cb.checked) {
		WSQLUBit('Contacts','Obtained',won,'ContactID',ContactId);
		WSQLUBit('Contacts','ContactLost',!won,'ContactID',ContactId);
	}
	window.location=window.location;
}

function sortCol(sortField,columnDiv) {
	sessionWrite('SortContacts',sortField);
	sessionWrite('ShownContacts',Gebi('selShowContacts').selectedIndex);
	//alert(Gebi('selShowContacts').selectedIndex);
	try { parent.Search();	}
	catch(e) { location=location;}
}

function selShowContacts_Change(ssb) {
	sessionWrite('ShownContacts',ssb.selectedIndex); 
	try{ 
		PGebi('sStatus').selectedIndex=ssb.selectedIndex;
		parent.Search(); 
	} 
	catch(e) { 
		try { parent.toggleSearchSort(); } catch(e) {}
		location+=''; 
	} 
}

function Resize()	{
	if(LinksTo) {
		Gebi('RowContainerContainer').style.width='100%';
	}
	else {
		Gebi('RowContainerContainer').style.width=Gebi('ItemsHead').offsetWidth+'px';
	}
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
