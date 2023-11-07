// JavaScript Document

function ChangeToArchive(){
	Gebi("TestButton2").style.display = 'block';
	Gebi("TestButton1").style.display = 'none';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('MonitoringListFrame').src=Gebi('MonitoringListFrame').src.replace('AccountArchive=False','AccountArchive=True');
	Active='False';
}

function ChangeToActive(){
	Gebi("TestButton2").style.display = 'none';
	Gebi("TestButton1").style.display = 'block';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('MonitoringListFrame').src=Gebi('MonitoringListFrame').src.replace('AccountArchive=True','AccountArchive=False');
	Active='True';
}

function SortBy(NewSortBy) {
	//alert(SortedBy);
	Gebi('MonitoringListFrame').src=Gebi('MonitoringListFrame').src.replace('SortBy='+SortedBy,'SortBy='+NewSortBy);
	SortedBy=NewSortBy;
}

function showNewAccount()	{
	Gebi('Modal').style.display='block';
	Gebi('NewAccountBox').style.display='block';
	Gebi('nbAcctName').focus();
}

function hideNewAccount()	{
	Gebi('Modal').style.display='none';
	Gebi('NewAccountBox').style.display='none';
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
	sessionWrite('AccountSearch',1);
	sessionWrite('AccountSearchName',Gebi('sName').value);
	sessionWrite('AccountSearchState',SelI('sState').value);
	sessionWrite('AccountSearchDateAfter',Gebi('sAfter').value);
	sessionWrite('AccountSearchDateBefore',Gebi('sBefore').value);
	sessionWrite('ShownAccounts', Gebi('sStatus').selectedIndex );
	//alert(Gebi('sStatus').selectedIndex);
	Gebi('MonitoringListFrame').contentWindow.location.reload();
}






function Schedule(AcctID,AcctName,From,To,Attn,Location) {
	var today=new Date;
	if(!isDate(From)){From=(today.getMonth()+1)+'/'+today.getDate()+'/'+today.getFullYear()}
	if(!isDate(To)){To=From}
	
	Gebi('SchAcctID').innerHTML=AcctID;
	Gebi('SchAcctName').innerHTML=AcctName;
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
	var schedAcctName=Gebi('SchAcctName').innerHTML;
	var schedD8From=Gebi('SchDateFrom').value;
	var schedD8To=Gebi('SchDateTo').value;
	var schedAcctID=Gebi('SchAcctID').innerHTML;
	var schedAttention=SelI('SchAttn').value;
	var schedLocation=Gebi('SchLoc').value;
	var schedCrew=Gebi('CrewList').value;
	var schedNotes=Gebi('NotesText').value;
	var schedPhase=SelI('SchPhase').innerHTML;
	
	
	//alert(schedNotes);
	parent.ToCal(schedAcctName,schedD8From,schedD8To,calFeed,schedAcctID,schedPhase,schedAttention,schedLocation,schedCrew,schedNotes);
	
	Gebi('ScheduleBox').style.display='none'; Gebi('Modal').style.display='none';
}


var newAcctCKey;
function SaveNewAccount() {
	var name=CharsEncode(Gebi('nbAcctName').value);
	var address=CharsEncode(Gebi('nbAddress').value);
	var city=CharsEncode(Gebi('nbCity').value);
	var state=CharsEncode(Gebi('nbState').value);
	var zip=CharsEncode(Gebi('nbZip').value);
	var AcctNo=Gebi('naNumber').value;
	var providerID=parseInt(SelI('naProvider').value);
	var date=new Date();
	date=mdyyyy(date);
	var newAccount='True';
	
	newAcctCKey=uid()
	WSQLs("INSERT INTO MonitoringAccounts (SiteName, Addr, City, State, Zip, AcctNo, ProviderID, DateEnt, cKey) VALUES ('"+name+"','"+address+"','"+city+"','"+state+"','"+zip+"','"+AcctNo+"',"+providerID+",'"+date+"','"+newAcctCKey+"')");
	
	MonitoringListFrame.location+='';
	hideNewAccount();
	if(confirm('Account Created.\nWould you like to open it?')) Gebi('MonitoringListFrame').contentWindow.Edit(newAcctCKey);	
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



function Resize() {
	var H= Math.abs(document.body.offsetHeight-0); //54
	Gebi('OverAllContainer').style.height =H +'px';
	var H2=Gebi('Top').offsetHeight+Gebi('mainToolbar').offsetHeight+Gebi('SearchSort').offsetHeight+Gebi('SearchBar').offsetHeight
	Gebi('ListBody').style.height = Math.abs(Gebi('Lists').offsetHeight-H2-8)+'px';//96
	Gebi('TLItemsContainer').style.height=(Gebi('ListBody').offsetHeight-0)+'px';
	var FrameH=Gebi('TLItemsContainer').offsetHeight-0;
	Gebi('MonitoringListFrame').style.height=FrameH+'px';
	Gebi('ItemNotesContainer').style.height=Math.abs(Gebi('ListBody').offsetHeight-28)+'px';
	/**/
}
