// JavaScript Document

function toggleSearchSort()	{
	if(Gebi('SearchBar').style.display!='block')	{
		Gebi('SearchBar').style.display='block';
		Gebi('btnSearch').focus();
		Gebi('sName').focus();
	}
	else {
		Gebi('SearchBar').style.display='none';
	}
	Resize();
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




/*///////////////////////////////////// 
function ChangeToArchive(){
	Gebi("TestButton2").style.display = 'block';
	Gebi("TestButton1").style.display = 'none';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('BidListFrame').src=Gebi('BidListFrame').src.replace('BiddingArchive=False','BiddingArchive=True');
	Active='False';
}

function ChangeToActive(){
	Gebi("TestButton2").style.display = 'none';
	Gebi("TestButton1").style.display = 'block';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('BidListFrame').src=Gebi('BidListFrame').src.replace('BiddingArchive=True','BiddingArchive=False');
	Active='True';
}

function SortBy(NewSortBy) {
	//alert(SortedBy);
	Gebi('BidListFrame').src=Gebi('BidListFrame').src.replace('SortBy='+SortedBy,'SortBy='+NewSortBy);
	SortedBy=NewSortBy;
}

function showNewBid()	{
	Gebi('Modal').style.display='block';
	Gebi('NewBidBox').style.display='block';
	Gebi('nbProjName').focus();
}

function hideNewBid()	{
	Gebi('Modal').style.display='none';
	Gebi('NewBidBox').style.display='none';
}

function copyCity(city) {	
	if(city=='') { Gebi('nbCity2').innerHTML='\u001f' }
	else { Gebi('nbCity2').innerHTML=city }
}


function Search() {
	sessionWrite('BidSearch',1);
	sessionWrite('BidSearchProjName',Gebi('sName').value);
	sessionWrite('BidSearchProjState',SelI('sState').value);
	sessionWrite('BidSearchDateAfter',Gebi('sAfter').value);
	sessionWrite('BidSearchDateBefore',Gebi('sBefore').value);
	sessionWrite('ShownBids',0);
	Gebi('BidListFrame').contentWindow.location.reload();
}






function Schedule(ProjID,ProjName,From,To,Attn,Location) {
	var today=new Date;
	if(!isDate(From)){From=(today.getMonth()+1)+'/'+today.getDate()+'/'+today.getFullYear()}
	if(!isDate(To)){To=From}
	
	Gebi('SchProjID').innerHTML=ProjID;
	Gebi('SchProjName').innerHTML=ProjName;
	Gebi('Modal').style.display='block'; 
	Gebi('ScheduleBox').style.display='block';
	
	Gebi('SchDateFrom').value=From;
	Gebi('SchDateTo').value=To;
	
	if(!!Attn) {
		for(a=0;a<Gebi('SchAttn').length;a++) {
			if(Gebi('SchAttn')[a].value==Attn) Gebi('SchAttn').selectedIndex=a;
		}
	}
	
	if(!!Location) Gebi('SchLoc').value=Location;
	
	//if(!!Recurrence)...
}
function ScheduleEvent() {
	var schedProjName=Gebi('SchProjName').innerHTML;
	var schedD8From=Gebi('SchDateFrom').value;
	var schedD8To=Gebi('SchDateTo').value;
	var schedProjID=Gebi('SchProjID').innerHTML;
	var schedAttention=SelI('SchAttn').value;
	var schedLocation=Gebi('SchLoc').value;
	var schedCrew=Gebi('CrewList').value;
	var schedNotes=Gebi('NotesText').value;
	var schedPhase=SelI('SchPhase').innerHTML;
	
	
	//alert(schedNotes);
	parent.ToCal(schedProjName,schedD8From,schedD8To,calFeed,schedProjID,schedPhase,schedAttention,schedLocation,schedCrew,schedNotes);
	
	Gebi('ScheduleBox').style.display='none'; Gebi('Modal').style.display='none';
}
	/** /
}
*/