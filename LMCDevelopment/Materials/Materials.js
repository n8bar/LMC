// JavaScript Document

function showTab(tab)	{
	
	var tabPage=Gebi(tab.id.replace('Tab','Page'));
	
	var activeTab=document.getElementsByClassName('activeTab')[0];
	if(!!activeTab) activeTab.setAttribute('class','tab');
	
	var activeTabPage=document.getElementsByClassName('activeTabPage')[0];
	if(!!activeTabPage) activeTabPage.setAttribute('class','tabPage');

	tab.setAttribute('class','activeTab');
	tabPage.setAttribute('class','activeTabPage');
	
	var userEmpId=session('EmpId');
	//alert(userEmpId);
	applicationWrite('MaterialsTab'+userEmpId,tab.id);
}



function showNewPart()	{
	Gebi('Modal').style.display='block';
	Gebi('npTitleName').innerHTML='New Part';
	Gebi('NewPartBox').style.display='block';
	Gebi('npPartName').focus();
}

function hideNewPart()	{
	Gebi('Modal').style.display='none';
	Gebi('NewPartBox').style.display='none';
}

function showNM()	{
	Gebi('Modal2').style.display='block';
	Gebi('NewMfgBox').style.display='block';
	Gebi('nmName').focus();
}
function hideNM()	{
	Gebi('Modal2').style.display='none';
	Gebi('NewMfgBox').style.display='none';
}

function showNC()	{
	Gebi('Modal2').style.display='block';
	Gebi('NewCatBox').style.display='block';
	Gebi('ncName').focus();
}
function hideNC()	{
	Gebi('Modal2').style.display='none';
	Gebi('NewCatBox').style.display='none';
}

function showNS()	{
	Gebi('Modal2').style.display='block';
	Gebi('NewSysBox').style.display='block';
	Gebi('nsName').focus();
}
function hideNS()	{
	Gebi('Modal2').style.display='none';
	Gebi('NewSysBox').style.display='none';
}

function toggleSearchSort()	{
	if(Gebi('SearchSort').style.display=='block')	{
		Gebi('SearchSort').style.display='none';
	}
	else {
		Gebi('SearchSort').style.display='block';
		Gebi('sName').focus();
	}
	Resize();
}

function npMfgChange() {
	////if(Gebi('npMfg').selectedIndex!=0) { if(Gebi('mChoose')) { Gebi('mChoose').parentNode.removeChild(Gebi('mChoose')); }	}
	////else { if(Gebi('mChoose')) { Gebi('mChoose').selected=false; } }
	//if(SelI('npMfg')==1) { showNewMfg(); }
}
function npCatChange() {}
function npSysChange() {}

function SavePart() {
	var pId=Gebi('editPId').innerHTML
	//if(pId=='') {
		var f='Manufacturer,Category1,System,Model,PartNumber,Description,Cost';//,LaborValue,System,Category1,Category2'
		//f+=',Vendor1,Cost1,Date1,Vendor2,Cost2,Date2,Vendor3,Cost3,Date3';
		var v="'"+CharsEncode(SelI('npMfg').innerHTML)+"'";
		v+=", '"+CharsEncode(SelI('npCat').innerHTML)+"'";
		v+=", '"+CharsEncode(SelI('npSys').innerHTML)+"'";
		v+=", '"+CharsEncode(Gebi('npPartName').value)+"'";
		v+=", '"+CharsEncode(Gebi('npPN').value)+"'";
		v+=", '"+CharsEncode(Gebi('npDesc').value)+"'";
		v+=", '"+Gebi('npCost').value+"'";
		var sql='INSERT INTO Parts ('+f+') VALUES ('+v+')'
		//alert(sql);
		WSQL(sql);
	//}
	//else {
	//	//var fv="Manfacturer='',Model='',PartNumber='',Description='',Cost='',LaborValue='',System='',Category1='',Category2=''";
	//	////fv+=",Vendor1='',Cost1='',Date1='',Vendor2='',Cost2='',Date2='',Vendor3='',Cost3='',Date3=''";
	//	//return WSQL('UPDATE Parts Set '+fv+' WHERE PartsID='+pId);
	//}
	hideNewPart();
	Gebi('sName').value=Gebi('npPN').value;
	Gebi('sMfg').selectedIndex=Gebi('npMfg').selectedIndex;
	Gebi('sCategory').selectedIndex=Gebi('npCat').selectedIndex;
	Gebi('sSystem').selectedIndex=Gebi('npSys').selectedIndex;
	Gebi('sDesc').value=Gebi('npDesc').value;
	Gebi('sMin').value=Gebi('npCost').value;
	Gebi('sMax').value=Gebi('npCost').value;
	Gebi('sAll').checked=true; Gebi('sAny').checked=false;
	
	//Gebi('sSystem').selectedIndex=0;
	//Gebi('sCategory').selectedIndex=0;
	Gebi('sVendor').selectedIndex=0;
	
	Search();
}
function savePart() {
	Gebi('NewPartBox').submit();
}


function sortBy(hColumn) {
	if(hColumn.getAttribute('class')=='hColSort') { return false; }
	
	document.getElementsByClassName('hColSort')[0].setAttribute('class','hColumn');
	hColumn.setAttribute('class','hColSort');
	
	Search();
}


function eRow(r) {
	var MfrList=Gebi('sMfg').innerHTML.replace('[Any]',Gebi('Mfr-'+r).innerHTML)
	Gebi('Mfr-'+r).innerHTML='<select class=eSel id=selMfr'+r+'>'+MfrList+'</select>';
	Gebi('Mfr-'+r).style.backgroundColor='rgba(0,255,255,.125)';
	Gebi('Model-'+r).contentEditable='true';
	Gebi('Model-'+r).style.backgroundColor='rgba(0,255,255,.125)';
	Gebi('PartNumber-'+r).contentEditable='true';
	Gebi('PartNumber-'+r).style.backgroundColor='rgba(0,255,255,.125)';
	Gebi('Cost-'+r).contentEditable='true';
	Gebi('Cost-'+r).innerHTML=unCurrency(Gebi('Cost-'+r).innerHTML); 
	Gebi('Cost-'+r).style.backgroundColor='rgba(0,255,255,.125)';
	Gebi('Qty-'+r).contentEditable='true';
	Gebi('Qty-'+r).style.backgroundColor='rgba(0,255,255,.125)';
	Gebi('System-'+r).innerHTML='<select class=eSel id=selSys'+r+'>'+Gebi('sSystem').innerHTML.replace('[Any]',Gebi('System-'+r).innerHTML)+'</select>';
	Gebi('System-'+r).style.backgroundColor='rgba(0,255,255,.125)';
	Gebi('Category-'+r).innerHTML='<select class=eSel id=selCat'+r+'>'+Gebi('sCategory').innerHTML.replace('[Any]',Gebi('Category-'+r).innerHTML)+'</select>';
	Gebi('Category-'+r).style.backgroundColor='rgba(0,255,255,.125)';
	Gebi('Desc-'+r).contentEditable='true';
	Gebi('Desc-'+r).style.backgroundColor='rgba(0,255,255,.125)';
	Gebi('edit-'+r).setAttribute('class',Gebi('edit-'+r).getAttribute('class').replace('editBtn','saveBtn'));
	Gebi('edit-'+r).setAttribute('onclick','sRow('+r+');');
}

function sRow(r) {

	Gebi('Mfr-'+r).innerHTML=SelI('selMfr'+r).innerHTML;
	Gebi('Mfr-'+r).style.backgroundColor='rgba(255,0,0,.1)';
	WSQLU('Parts','Manufacturer',Gebi('Mfr-'+r).innerHTML,'PartsID',Gebi('PartsID-'+r).innerHTML);
	Gebi('Mfr-'+r).style.backgroundColor='transparent';
	
	Gebi('Model-'+r).contentEditable='false';
	Gebi('Model-'+r).style.backgroundColor='rgba(255,0,0,.1)';
	WSQLU('Parts','Model',Gebi('Model-'+r).innerHTML,'PartsID',Gebi('PartsID-'+r).innerHTML);
	Gebi('Model-'+r).style.backgroundColor='transparent';
	
	Gebi('PartNumber-'+r).contentEditable='false';
	Gebi('PartNumber-'+r).style.backgroundColor='rgba(255,0,0,.1)';
	WSQLU('Parts','PartNumber',Gebi('PartNumber-'+r).innerHTML,'PartsID',Gebi('PartsID-'+r).innerHTML);
	Gebi('PartNumber-'+r).style.backgroundColor='transparent';
	
	Gebi('Cost-'+r).contentEditable='false';
	Gebi('Cost-'+r).innerHTML=formatCurrency(Gebi('Cost-'+r).innerHTML); 
	Gebi('Cost-'+r).style.backgroundColor='rgba(255,0,0,.1)';
	WSQLU('Parts','Cost',Gebi('Cost-'+r).innerHTML,'PartsID',Gebi('PartsID-'+r).innerHTML);
	Gebi('Cost-'+r).style.backgroundColor='transparent';
	
	Gebi('Qty-'+r).contentEditable='false';
	Gebi('Qty-'+r).style.backgroundColor='rgba(255,0,0,.1)';
	WSQLU('Parts','Inventory',Gebi('Qty-'+r).innerHTML,'PartsID',Gebi('PartsID-'+r).innerHTML);
	Gebi('Qty-'+r).style.backgroundColor='transparent';
	
	Gebi('System-'+r).innerHTML=SelI('selSys'+r).innerHTML;
	Gebi('System-'+r).style.backgroundColor='rgba(255,0,0,.1)';
	WSQLU('Parts','System',Gebi('System-'+r).innerHTML,'PartsID',Gebi('PartsID-'+r).innerHTML);
	Gebi('System-'+r).style.backgroundColor='transparent';
	
	Gebi('Category-'+r).innerHTML=SelI('selCat'+r).innerHTML;
	Gebi('Category-'+r).style.backgroundColor='rgba(255,0,0,.1)';
	WSQLU('Parts','Category1',Gebi('Category-'+r).innerHTML,'PartsID',Gebi('PartsID-'+r).innerHTML);
	Gebi('Category-'+r).style.backgroundColor='transparent';
	
	Gebi('Desc-'+r).contentEditable='false';
	Gebi('Desc-'+r).style.backgroundColor='rgba(255,0,0,.1)';
	WSQLU('Parts','Description',Gebi('Desc-'+r).innerHTML,'PartsID',Gebi('PartsID-'+r).innerHTML);
	Gebi('Desc-'+r).style.backgroundColor='transparent';
	
	Gebi('edit-'+r).setAttribute('class',Gebi('edit-'+r).getAttribute('class').replace('saveBtn','editBtn'));
	Gebi('edit-'+r).setAttribute('onclick','eRow('+r+');');
}

var openPartRow=0;
function oRow(r) {
	//openPartRow=r;
	Gebi('frameX').style.display='block';
	openPart(Gebi('PartsID-'+r).innerHTML);
}

function closeFrames() {
	Gebi('PartFrame').style.display='none'; 
	Gebi('DataFrame').style.display='none'; 
	Gebi('frameX').style.display='none';
}

function dataClick(obj,r) {
	var ce=obj.getAttribute('contenteditable');
	//obj.innerHTML=ce;
	if (ce=='true') { return false; }
	eRow(r);
	obj.focus();
	//obj.selectAll(); How do ya hilight da contents?
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
	var H=0;
	
	H+=Gebi('Top').offsetHeight;
	H+=Gebi('mainToolbar').offsetHeight;
	H+=Gebi('SearchSort').offsetHeight;
	H+=12;
	Gebi('ListBody').style.height=document.body.offsetHeight-H+('px');
	
	Gebi('ListHead').style.width=Gebi('emptyRow').offsetWidth+('px');
	Gebi('ListHead').style.top=Gebi('ListBody').offsetTop+Gebi('listToolbar').offsetHeight+16+('px');
}



