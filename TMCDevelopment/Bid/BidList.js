// JavaScript Document

function Edit(projId)	{
	sessionWrite('ShownBids',Gebi('selShowBids').selectedIndex);
	parent.location='BidProject.asp?id='+projId;
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

function downloadClick(downloadArrow,projId) {
	downloadArrow.src='../images/roller.gif';
	prepareProjectDownload(downloadArrow,projId);
	downloadArrow.style.visibility='visible';
}

var statusProjId=0;
var statusDiv=false;
function showStatusPopup(proj,posDiv,lost,won) {
	statusProjId=proj;
	statusDiv=posDiv;
	if(lost&&won) {
		WSQLUBit('Projects','Obtained',false,'ProjID',projId);
		WSQLUBit('Projects','BidLost',false,'ProjID',projId);
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
			WSQLUBit('Projects','Obtained',false,'ProjID',statusProjId);
			WSQLUBit('Projects','BidLost',false,'ProjID',statusProjId);
			WSQLUBit('Projects','Active',false,'ProjID',statusProjId);
			statusDiv.setAttribute('class','statusOpen');
			statusDiv.setAttribute('onclick','showStatusPopup('+statusProjId+', this, 0,0)');
		break;
		
		case 'Won' :
			Gebi('cbStatusWon').setAttribute('checked','checked');
			WSQLUBit('Projects','Obtained',true,'ProjID',statusProjId);
			WSQLUBit('Projects','BidLost',false,'ProjID',statusProjId);
			WSQLUBit('Projects','Active',true,'ProjID',statusProjId);
			var d=new Date();
			var d=(d.getMonth()+1).toString()+'/'+d.getDate().toString()+'/'+d.getFullYear().toString();
			alert(d);
			WSQLU('Projects','DateStarted',d,'ProjID',statusProjId);
			statusDiv.setAttribute('class','statusWon');
			statusDiv.setAttribute('onclick','showStatusPopup('+statusProjId+', this, 0,1)');
		break;
		
		case 'Lost' :
			Gebi('cbStatusLost').setAttribute('checked','checked');
			WSQLUBit('Projects','Obtained',false,'ProjID',statusProjId);
			WSQLUBit('Projects','BidLost',true,'ProjID',statusProjId);
			WSQLUBit('Projects','Active',false,'ProjID',statusProjId);
			statusDiv.setAttribute('class','statusLost');
			statusDiv.setAttribute('onclick','showStatusPopup('+statusProjId+', this, 1,0)');
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
	sessionWrite('SortBids',sortField);
	sessionWrite('ShownBids',Gebi('selShowBids').selectedIndex);
	//alert(Gebi('selShowBids').selectedIndex);
	try {
		parent.Search();
	}
	catch(e) { location=location;}
}

function selShowBids_Change(ssb) {
	sessionWrite('ShownBids',ssb.selectedIndex); 
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
