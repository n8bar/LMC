// JavaScript Document

function Edit(projId)	{
	sessionWrite('ShownProjects',Gebi('selShowBids').selectedIndex);
	parent.location='Project.asp?id='+projId;
}


function delBids()	{
	var cbSel=document.getElementsByClassName('ItemCheckBox');
	
	if(!cbSel.length>0) return false;
	
	if(!confirm('This will remove each selected project and every last system therein!')) return false;
	if(!confirm('Are you sure?')) return false;
	
	for(cb=0;cb<cbSel.length;cb++)	{
		if(cbSel[cb].checked)	{
			delProj(Gebi(cbSel[cb].id.replace('sel','ProjID')).innerHTML);
		}
	}
}

var statusProjId=0;
var statusDiv=false;
function showStatusPopup(projId,posDiv,sOpen,sClosed) {
	statusProjId=projId;
	statusDiv=posDiv;
	if(sOpen==sClosed) {
		WSQLUBit('Projects','Active',true,'ProjID',projId);
		sOpen=true;
		sClosed=false;
	}
	Gebi('cbStatusClosed').checked=sClosed;
	Gebi('cbStatusOpen').checked=sOpen;
	
	Gebi('statusPopup').style.left=(posDiv.offsetLeft+posDiv.offsetWidth-5)+'px';
	Gebi('statusPopup').style.top=(posDiv.offsetTop+posDiv.offsetHeight-5-Gebi('List').scrollTop)+'px';
	Gebi('statusPopup').style.display='block';
}

function setStatus(state, stateIs) {
	switch(state) {
		case 'Open':
			Gebi('cbStatusClosed').checked=false;
			Gebi('cbStatusOpen').checked=true;
			WSQLUBit('Projects','Active',true,'ProjID',statusProjId);
			statusDiv.setAttribute('class','statusWon');
		break;
		
		case 'Closed' :
			Gebi('cbStatusClosed').checked=true;
			Gebi('cbStatusOpen').checked=false;
			WSQLUBit('Projects','Active',false,'ProjID',statusProjId);
			statusDiv.setAttribute('class','statusLost');
			statusDiv.setAttribute('onclick','showStatusPopup('+statusProjId+', this, 0,1);');
		break;
	}
	Gebi('statusPopup').style.display='none';
}

function contractBid(projId, cb, won) {
	var conf='This will set all Estimating progress phases to Done.';
	if(won) { conf='This will Activate the job, lock the bid, and set all Estimating progress phases to Done.'; }
	if(!confirm(conf)) { cb.checked=!cb.checked; return false; }
	if(cb.checked) {
		WSQLUBit('Projects','Obtained',won,'ProjID',projId);
		WSQLUBit('Projects','BidLost',!won,'ProjID',projId);
	}
	window.location=window.location;
}

function sortCol(sortField,columnDiv) {
	sessionWrite('SortProjects',sortField);
	sessionWrite('ShownProjects',Gebi('selShowBids').selectedIndex);
	//alert(Gebi('selShowBids').selectedIndex);
	try {
		parent.Search();
	}
	catch(e) { location=location;}
}

function selShowBids_Change(ssb) {
	sessionWrite('ShownProjects',ssb.selectedIndex); 
	//alert('ShownProjects:'+ssb.selectedIndex);
	try{ 
		PGebi('sStatus').selectedIndex=ssb.selectedIndex;
		PGebi('sStatus').onchange();
		//alert('dewit!!');
		parent.Search(); 
	} 
	catch(e) { window.location=window.location; } 
}


function Resize()	{
	/*
	var rows=document.getElementsByClassName('RowContainer');
	for(r=0;r<rows.length;r++) {
		rows[r].style.width=Gebi('ItemsHead').offsetWidth+'px';
	}
	Gebi('List').style.height='100%';
	Gebi('List').style.height=Gebi('List').offsetHeight-Gebi('listHead').offsetHeight-Gebi('ItemsHead').offsetHeight-8+('px');
	*/
	Gebi('RowContainerContainer').style.width=Gebi('ItemsHead').offsetWidth+'px';
	Gebi('LoadText').innerHTML='Loading...';
	Gebi('List').style.height='100%';
	Gebi('List').style.height=Gebi('List').offsetHeight-Gebi('listHead').offsetHeight-Gebi('ItemsHead').offsetHeight-8+('px');
}
