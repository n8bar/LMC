// JavaScript Document

function ChangeToArchive(){
	Gebi("TestButton2").style.display = 'block';
	Gebi("TestButton1").style.display = 'none';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('ServiceListFrame').src=Gebi('ServiceListFrame').src.replace('ServicingArchive=False','ServicingArchive=True');
	Active='False';
}

function ChangeToActive(){
	Gebi("TestButton2").style.display = 'none';
	Gebi("TestButton1").style.display = 'block';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('ServiceListFrame').src=Gebi('ServiceListFrame').src.replace('ServicingArchive=True','ServicingArchive=False');
	Active='True';
}

function SortBy(NewSortBy) {
	//alert(SortedBy);
	Gebi('ServiceListFrame').src=Gebi('ServiceListFrame').src.replace('SortBy='+SortedBy,'SortBy='+NewSortBy);
	SortedBy=NewSortBy;
}

function showNewService()	{
	Gebi('Modal').style.display='block';
	Gebi('NewServiceBox').style.display='block';
	Gebi('nbJobName').focus();
}

function hideNewService()	{
	Gebi('Modal').style.display='none';
	Gebi('NewServiceBox').style.display='none';
}

function copyCity(city) {	
	if(city=='') { Gebi('nbCity2').innerHTML='\u001f' }
	else { Gebi('nbCity2').innerHTML=city }
}


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


function Search() {
	sessionWrite('ServiceSearch',1);
	sessionWrite('ServiceSearchJobName',Gebi('sName').value);
	sessionWrite('ServiceSearchJobState',SelI('sState').value);
	sessionWrite('ServiceSearchDateAfter',Gebi('sAfter').value);
	sessionWrite('ServiceSearchDateBefore',Gebi('sBefore').value);
	sessionWrite('ShownServices', Gebi('sStatus').selectedIndex );
	//alert(Gebi('sStatus').selectedIndex);
	Gebi('ServiceListFrame').contentWindow.location.reload();
}



function Schedule(JobID,JobName,From,To,Attn,Location) {
	var today=new Date;
	if(!isDate(From)){From=(today.getMonth()+1)+'/'+today.getDate()+'/'+today.getFullYear()}
	if(!isDate(To)){To=From}
	
	Gebi('SchJobID').innerHTML=JobID;
	Gebi('SchJobName').innerHTML=JobName;
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
	var schedJobName=Gebi('SchJobName').innerHTML;
	var schedD8From=Gebi('SchDateFrom').value;
	var schedD8To=Gebi('SchDateTo').value;
	var schedJobID=Gebi('SchJobID').innerHTML;
	var schedAttention=SelI('SchAttn').value;
	var schedLocation=Gebi('SchLoc').value;
	var schedCrew=Gebi('CrewList').value;
	var schedNotes=Gebi('NotesText').value;
	var schedPhase=SelI('SchPhase').innerHTML;
	
	
	//alert(schedNotes);
	parent.ToCal(schedJobName,schedD8From,schedD8To,calFeed,schedJobID,schedPhase,schedAttention,schedLocation,schedCrew,schedNotes);
	
	Gebi('ScheduleBox').style.display='none'; Gebi('Modal').style.display='none';
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


function setCust(txt) {
	//var tempfunc=new Gebi('nbCust').onkeyup;
	Gebi('nbCust').value=txt;
	Gebi('custList').innerHTML='';
	if(txt.indexOf(':')>0) {
		Gebi('nbCustID').value=txt.split(':')[0];
	}
	else {
		Gebi('nbCustID').value='';
	}
}
function nbCustFocus() {
	Gebi('nbCust').value.replace('Please choose from the list.','');
}
function nbCustBlur() {
	if(Gebi('nbCustID').value=='') Gebi('nbCust').value='Please choose from the list.';
	setTimeout("Gebi('custList').innerHTML=''",1000);
	//we needed some time to see if sumpn in the list needed a onclick to execute.
}
function nbCustKeyPress(e) {
	if(e.keyCode==9) Gebi('nbAddress').focus();
}
function nbCustIDFocus(e) {
	//alert(Object.getOwnPropertyNames(e));
	//alert(e.target.tagName+'#'+e.target.id);
	//alert(e.srcElement.tagName+'#'+e.srcElement.id);
	//var execJS="e.relatedTarget.value=(e.relatedTarget.tagName+'#'+e.relatedTarget.id);"
	var execJS="Gebi('nbAddress').focus();"
	Gebi('nbCust').focus();
	eval(execJS);
}
function nbAddressKeyDown(e) {
	//alert(Object.getOwnPropertyNames(e));
	//Gebi('nbAddrL').innerHTML=e.keyCode+' '+e.shiftKey;
	if(e.keyCode==9 && e.shiftKey) { //Make shift+Tab work
		setTimeout("Gebi('nbCust').focus();",100);
	}
}

function Resize() {
	var H= Math.abs(document.body.offsetHeight-0);//54
	Gebi('OverAllContainer').style.height =H +'px';
	var H2=Gebi('Top').offsetHeight+Gebi('mainToolbar').offsetHeight+Gebi('SearchSort').offsetHeight+Gebi('SearchBar').offsetHeight
	Gebi('ListBody').style.height = Math.abs(Gebi('Lists').offsetHeight-H2-8)+'px';//96
	Gebi('TLItemsContainer').style.height=(Gebi('ListBody').offsetHeight-0)+'px';
	var FrameH=Gebi('TLItemsContainer').offsetHeight-0;//-49;
	Gebi('ServiceListFrame').style.height=FrameH+'px';
	Gebi('ItemNotesContainer').style.height=Math.abs(Gebi('ListBody').offsetHeight-28)+'px';
	/**/
}
