
function secType(secID) {
	
	if(Gebi('sec'+secID).getAttribute('class')=='selSecType') {
		Gebi('sec'+secID).setAttribute('class','sectionType');
		Gebi('sec'+secID+'list').setAttribute('class','presetList');
		return true;
	}
	
	//try { document.getElementsByClassName('selSecType')[0].setAttribute('class','sectionType'); }
	//catch(e) { }
	Gebi('sec'+secID).setAttribute('class','selSecType');
	
	//try { document.getElementsByClassName('selPresetList')[0].setAttribute('class','presetList'); }
	//catch(e) { }
	Gebi('sec'+secID+'list').setAttribute('class','selPresetList');
}
console.log('secType() is loaded');

function loadPreset(presetID) {
	Gebi('presetEdit').setAttribute('src','PresetEditor.asp?id='+presetID);
}

function showNewPreset() {
	Gebi('npModal').style.display='block';
	Gebi('npName').focus();
}
function closeNewPreset() {
	Gebi('npName').value='';
	Gebi('npSecList').selectedIndex=0;
	Gebi('npModal').style.display='none';
	Gebi('npSave').disabled=true;
	Gebi('stDel').disabled=true;
}

function npEnableSave() {
	Gebi('npSave').disabled= !( Gebi('npSecList').selectedIndex>2 && Gebi('npName').value!='' );
	Gebi('stDel').disabled=!( Gebi('npSecList').selectedIndex>2);
	
	if (Gebi('npSecList').selectedIndex==1) {
		showNewSec();
		Gebi('npSecList').selectedIndex=0;
		Gebi('npSave').disabled=true;
		Gebi('stDel').disabled=true;
	}
}

function delSecType() {
	if (!confirm('Deleting section types can really mess things up. \n Continue only if you KNOW the section type contains no bid presets.')) return false;
	if (!confirm('Really???')) return false;
	WSQL('WHERE SectionID='+SelI('npSytsList').value);
}

function newPreset(pName, secType, secTypeID) {
	var dt=new Date();
	var creationKey=dt.getFullYear().toString()
		+dt.getMonth().toString()
		+dt.getDate().toString()
		+dt.getHours().toString()
		+dt.getMinutes().toString()
		+dt.getSeconds().toString()
		+dt.getMilliseconds().toString()
		+'-'+sessionID;
	WSQL('INSERT INTO BidPresets (BidPresetName, BidPresetSection, BidPresetSectionID, creationKey) VALUES (\''+CharsEncode(pName)+'\',\''+CharsEncode(secType)+'\','+secTypeID+',\''+creationKey+'\')');
	closeNewPreset();
	var html='';
	html+='<div class=Preset onclick="loadPreset(\''+creationKey+'\',this);">';
	html+='	<span class=PresetX style="width:100%; display:inline-block;" onClick="delPreset(\''+creationKey+'\');">&nbsp;</span>';
	html+='	<span onclick="loadPreset(\''+creationKey+'\',this);" style="width:100%; display:inline-block;">'+pName+'</span>';
	html+='</div>';
	Gebi('sec'+secTypeID+'list').innerHTML+=html;
	loadPreset(creationKey);
}

function delPreset(pKey,xObj) {
	if (!confirm('Are you absolutely positively sure you want to delete this preset???') ) return false;
	if(!!pKey.length) if(pKey.length()>10) { delPresetByCreationKey(pKey); }
	else {	WSQL('DELETE FROM BidPresetItems WHERE BidPresetID=\''+pKey+'\'');	}
	WSQL('DELETE FROM BidPresets WHERE creationKey=\''+pKey+'\' or BidPresetID=\''+pKey+'\'');
	xObj.parentNode.parentNode.removeChild(xObj.parentNode);
}

function showNewSec() {
}
                                          ///////////////////
/////////////////////////////////////////// 		AJAX		  ///////////////////////////////////////////
                                        ///////////////////
var xhr
var HttpText ='';
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function getXHRObject(){
	var xhr=null;
	try { xhr=new XMLHttpRequest();}// Firefox, Opera 8.0+, Safari
	catch (e) { // Internet Explorer
		try { xhr=new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e) {	xhr=new ActiveXObject("Microsoft.XMLHTTP");	}
	}
	
	if (xhr==null) alert ("Your browser does not support AJAX!");
	
	return xhr;
}
//------------------------------------------------------------------------------------------------


