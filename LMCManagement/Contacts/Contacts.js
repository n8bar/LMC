// JavaScript Document

function ChangeToArchive(){
	Gebi("TestButton2").style.display = 'block';
	Gebi("TestButton1").style.display = 'none';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('ContactListFrame').src=Gebi('ContactListFrame').src.replace('ContactdingArchive=False','ContactdingArchive=True');
	Active='False';
}

function ChangeToActive(){
	Gebi("TestButton2").style.display = 'none';
	Gebi("TestButton1").style.display = 'block';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('ContactListFrame').src=Gebi('ContactListFrame').src.replace('ContactdingArchive=True','ContactdingArchive=False');
	Active='True';
}

function SortBy(NewSortBy) {
	//alert(SortedBy);
	Gebi('ContactListFrame').src=Gebi('ContactListFrame').src.replace('SortBy='+SortedBy,'SortBy='+NewSortBy);
	SortedBy=NewSortBy;
}

function showNewContact()	{
	Gebi('Modal').style.display='block';
	Gebi('NewContactBox').style.display='block';
	Gebi('nbContactName').focus();
}

function hideNewContact()	{
	Gebi('Modal').style.display='none';
	Gebi('NewContactBox').style.display='none';
}

function copyCity(city) {	
	if(city=='') { Gebi('nbCity2').innerHTML='\u001f' }
	else { Gebi('nbCity2').innerHTML=city }
}

function toggleSearchSort()	{
	/*
	if(Gebi('SearchBar').style.display!='block')	{
		Gebi('SearchBar').style.display='block';
		Gebi('btnSearch').focus();
		Gebi('sName').focus();
	}
	else {
		Gebi('SearchBar').style.display='none';
	}
	Resize();
	*/
}

function Search() {
	sessionWrite('ContactSearch','Advanced');
	sessionWrite('ContactSearchOmni',Gebi('sName').value);
	sessionWrite('ContactSearchCity',Gebi('sCity').value);
	sessionWrite('ContactSearchState',SelI('sState').value);
	sessionWrite('ContactSearchNotes',Gebi('sNotes').value);

	sessionWrite('ShownContacts', Gebi('sStatus').selectedIndex );
	//alert(Gebi('sStatus').selectedIndex);
	Gebi('ContactListFrame').contentWindow.location.reload();
	//toggleSearchSort();
}

var pauseTimeout=setTimeout('',0);
function omniSearch() {
	sessionWrite('ContactSimpleSearch',Gebi('sOmniSearch').value);
	//pause before reloading in case some more characters were typed.  clearTimeout when they are.
	clearTimeout(pauseTimeout);
	sessionWrite('ContactSearch','Simple');
	pauseTimeout=setTimeout("Gebi('ContactListFrame').contentWindow.location.reload();",500); 
}

function searchAdvanced() { sbSimple.style.display='none'; sbAdvanced.style.display='block'; SearchBar.reset(); }
function searchSimple() { sbSimple.style.display='block'; sbAdvanced.style.display='none'; SearchBar.reset(); }

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

function Resize() {
	var H= Math.abs(document.body.offsetHeight-0);//54
	Gebi('OverAllContainer').style.height =H +'px';
	var H2=Gebi('Top').offsetHeight+Gebi('mainToolbar').offsetHeight+Gebi('SearchBar').offsetHeight;//+Gebi('SearchSort').offsetHeight;
	Gebi('ListBody').style.height = Math.abs(Gebi('Lists').offsetHeight-H2-8)+'px';//96
	Gebi('TLItemsContainer').style.height=(Gebi('ListBody').offsetHeight-0)+'px';
	var FrameH=Gebi('TLItemsContainer').offsetHeight-0;//-49;
	Gebi('ContactListFrame').style.height=FrameH+'px';
	Gebi('ItemNotesContainer').style.height=Math.abs(Gebi('ListBody').offsetHeight-28)+'px';
	/**/
}