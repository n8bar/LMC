

var CurrentPartID=-1;
var CurrentRow=-1;
function EditPart(partInfoString) {
	Gebi('modal').style.display='block';
	Gebi('editWindow').style.display='block';
	Gebi('editTitle').innerHTML='Edit Part';
	
	var info=partInfoString.split(',');
	
	var pID=info[0];
	var row=info[1];
	var model=CharsDecode(info[2]);
	var PN=CharsDecode(info[3]);
	var Cost=info[4];
	var Desc=CharsDecode(info[5]);
	
	Gebi('eMfr').selectedIndex=0;
	Gebi('eMfr')[0].innerHTML=Gebi('Results').contentWindow.document.getElementById('Mfr'+row).innerHTML;
	Gebi('eName').value=Gebi('Results').contentWindow.document.getElementById('Model'+row).innerHTML;
	Gebi('ePN').value=Gebi('Results').contentWindow.document.getElementById('PN'+row).innerHTML;
	Gebi('eCost').value=Gebi('Results').contentWindow.document.getElementById('Cost'+row).innerHTML.replace('$','');
	Gebi('eDesc').value=Gebi('Results').contentWindow.document.getElementById('Desc'+row).innerHTML;
	Gebi('eCN').innerHTML=pID;
	
	CurrentPartID=pID;
	CurrentRow=row		
}

function newPart() {
	cancelPart();
	Gebi('modal').style.display='block';
	Gebi('editWindow').style.display='block';
	Gebi('editTitle').innerHTML='New Part';
	Gebi('eMfr').focus();
}

function clearPart() {
	Gebi('eMfr').selectedIndex=0;
	Gebi('eMfr')[0].innerHTML='';
	Gebi('eName').value='';
	Gebi('ePN').value='';
	Gebi('eCost').value='';
	Gebi('eDesc').value='';
}

function savePart() {
	var errTxt='';
	if (SelI('eMfr').innerHTML=='') errTxt+='\nManufacturer is needed.';
	if (Gebi('ePN').value=='') errTxt+='\nPart number is needed.';
	if (Gebi('eCost').value=='') errTxt+='\nCost is needed.';
	
	if (errTxt!='') {
		alert('Sorry. More information is needed:'+errTxt);
		return false;
	}
	
	if (CurrentPartID==-1) {
		
		var fields='Manufacturer, Model, PartNumber, Cost, Description';
		
		var values="'"+CharsEncode(SelI('eMfr').innerHTML)+"'";
		values+=",'"+CharsEncode(Gebi('eName').value)+"'";
		values+=",'"+CharsEncode(Gebi('ePN').value)+"'";
		values+=","+Gebi('eCost').value;
		values+=",'"+CharsEncode(Gebi('eDesc').value)+"'";
		
		WSQLI('Parts',fields,values);
		
		Gebi('SearchPartsTxt').value=Gebi('ePN').value;
		SearchParts('PartNumber');
	}
	else {
		WSQLU('Parts','Manufacturer',CharsEncode(SelI('eMfr').innerHTML),'PartsID',CurrentPartID);
		WSQLU('Parts','Model',CharsEncode(Gebi('eName').value),'PartsID',CurrentPartID);
		WSQLU('Parts','PartNumber',CharsEncode(Gebi('ePN').value),'PartsID',CurrentPartID);
		WSQLU('Parts','Cost',Gebi('eCost').value,'PartsID',CurrentPartID);
		WSQLU('Parts','Description',CharsEncode(Gebi('eDesc').value),'PartsID',CurrentPartID);
		
		Gebi('Results').contentWindow.document.getElementById('Mfr'+CurrentRow).innerHTML=SelI('eMfr').innerHTML;
		Gebi('Results').contentWindow.document.getElementById('Model'+CurrentRow).innerHTML=Gebi('eName').value;
		Gebi('Results').contentWindow.document.getElementById('PN'+CurrentRow).innerHTML=Gebi('ePN').value;
		Gebi('Results').contentWindow.document.getElementById('Cost'+CurrentRow).innerHTML='$'+Gebi('eCost').value;
		Gebi('Results').contentWindow.document.getElementById('Desc'+CurrentRow).innerHTML=Gebi('eDesc').value;
	}
	
	cancelPart();
}

function delPart() {
	WSQL('DELETE FROM Parts WHERE PartsID='+CurrentPartID);
	cancelPart();
}
function cancelPart() {
	CurrentPartID=-1;
	CurrentRow=-1;
	Gebi('modal').style.display='none';
	Gebi('editWindow').style.display='none';
	Gebi('eCN').innerHTML='';
}

var toSearch=setTimeout('',0);
function Search(text) {
	clearTimeout(toSearch);
	if(text=='checkboxes') {
		text='';	
		if (Gebi('mfrChk').checked) text+='Manufacturer';
		if (Gebi('modelChk').checked) { 
			if(text!='') text+=',';
			text+='Model';
		}
		if (Gebi('PNChk').checked) { 
			if(text!='') text+=',';
			text+='PartNumber';
		}
		if (Gebi('pIdChk').checked) { 
			if(text!='') text+=',';
			text+='PartsID';
		}
		if (Gebi('descChk').checked) { 
			if(text!='') text+=',';
			text+='Description';
		}
	}
	toSearch=setTimeout('SearchParts(\''+text+'\');',750);
}


function newMfr() { 
	Gebi('mfrModal').style.display='block';
	Gebi('mfrName').focus();
	Gebi('eMfr').selectedIndex=0;
}

function saveMfr() {
	WSQLI('Manufacturers','Name',"'"+CharsEncode(Gebi('mfrName').value)+"'");
	
	var newOption = document.createElement("OPTION");
	var newOption2 = document.createElement("OPTION");
	Gebi('eMfr').options.add(newOption);
	Gebi('dMfr').options.add(newOption2);
	newOption.innerHTML=Gebi('mfrName').value;
	newOption2.innerHTML=Gebi('mfrName').value;
	
	Gebi('eMfr').selectedIndex=Gebi('eMfr').length-1;
	Gebi('mfrModal').style.display='block';
	Gebi('mfrName').value='';
}
function delMfr() {
	if(confirm('Are you sure you want to delete the manufacturer:'+SelI('dMfr').innerHTML)){
		WSQL('DELETE FROM Manufacturers WHERE ManufID='+SelI('dMfr').value);
	}
	var mfrID=SelI('dMfr').value;
	Gebi('dMfr').removeChild(Gebi('dMfr'+mfrID));
	Gebi('eMfr').removeChild(Gebi('eMfr'+mfrID));
}


function SearchParts(SearchName) {
	var SearchTxt = Gebi("SearchPartsTxt").value;
	Gebi('Results').src='PartSearch.asp?SearchName='+SearchName+'&SearchTxt='+SearchTxt;
}

function resize() {
	if( !!Gebi('Results').contentWindow.document.getElementById('Part1') && !!Gebi('HeadItems') )  {
		Gebi('HeadItems').style.width=Gebi('Results').contentWindow.document.getElementById('Part1').offsetWidth+'px';
		Gebi('HeadItems').style.display='block';
	}
}
/*
var xmlHttp
var HttpText ='';
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXHR() {
	var XHR=false;
	try { XHR=new XMLHttpRequest(); }// Firefox, Opera 8.0+, Safari
	catch (e) { // Internet Explorer
		try { XHR=new ActiveXObject("Msxml2.XMLHTTP"); }
		catch(e) { XHR=new ActiveXObject("Microsoft.XMLHTTP"); }
	}
	if (!XHR) alert ("Your browser does not support AJAX!");
	return XHR;
}
//------------------------------------------------------------------------------------------------


/** /	
function SearchParts(SearchName)
{
	var SearchTxt = Gebi("SearchPartsTxt").value;
	Gebi('Results').src='PartSearch.asp?SearchName='+SearchName+'&SearchTxt='+SearchTxt;
	HttpText='PartsASP.asp?action=SearchParts&SearchTxt='+SearchTxt+'&SearchName='+SearchName;
	xmlHttp = GetXHR();
	xmlHttp.onreadystatechange = ReturnSearchParts;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnSearchParts() 
{
	if (xmlHttp.readyState == 4)
	{
		
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			function xmlTag(tagName)
			{
				try{	return xmlDoc.getElementsByTagName(tagName)[0].childNodes[0].nodeValue;	}
				catch(e){	AjaxErr('There was a problem with the SearchParts Response:'+tagName,HttpText);	}
			}
			
			var matches=xmlTag("matches");
			
			var html = '';//xmlDoc.getElementsByTagName("Parts")[0].childNodes[0].nodeValue;
			
			var MfrColor=xmlTag('MfrColor');
			var PartColor=xmlTag('PartColor');
			var DescColor=xmlTag('DescColor');
			
			for(p=1;p<=matches;p++)
			{
				html+='<div id="Part'+p+'" class="ItemRow borderSizing" >';
				html+=	'<span class="Item borderSizing" style="width:4%; ">';
				html+=		'<button class="ItemAdd borderSizing" onClick="parent.AddPart('+xmlTag("pID"+p)+');">Add</button>';
					html+='</span>';
					html+='<span class="Item borderSizing" style="width:25%; border-left: 1px solid #000; color:#'+MfrColor+';">'+xmlTag("Mfr"+p)+'</span>';
					html+='<span class="Item borderSizing" style="width:25%; border-left: 1px solid #000; color:#'+PartColor+';">'+xmlTag("PN"+p)+'</span>';
					html+='<span class="Item borderSizing" style="width:12%; border-left: 1px solid #000;display:inline;">$'+xmlTag("Cost"+p)+'</span>';
					html+='<span class="Item borderSizing" style="width:33%; border-left: 1px solid #000;display:inline; color:#'+DescColor+'">'+xmlTag("Desc"+p)+'</span>';
				html+='</div>';
			}
			
			if(xmlTag('maxed')==1) html+='<div id="Part'+(p+1)+'" class="ItemRow borderSizing" style="color:red;">Maximum of '+xmlTag('max')+' results shown.</div>';
			
			Gebi('Results').innerHTML = html;

		}
		else
		{
			AjaxErr('There was a problem with the SearchParts request.',HttpText);
		}
	}
}
/**/


/*
function AddPart(PartID)
{
	parent.AddPart(PartID);
	var SysID = Gebi("HiddenEstID").value;
	//var MU = Gebi('SysExpFrame').contentWindow.document.getElementById("MU").value;
	
	//alert(PartID);
	HttpText='EstimatesASP.asp?action=AddPart&PartID='+PartID+'&SysID='+SysID;//+'&MU='+MU;
	xmlHttp = GetXHR();
	xmlHttp.onreadystatechange = ReturnAddPart;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function AddBlankPart()
{
	//var MU = Gebi('SysInfoFrame').contentWindow.document.getElementById("MU").value;

	HttpText='EstimatesASP.asp?action=AddPart&PartID=0&SysID='+Gebi('HiddenEstID').value;
	xmlHttp = GetXHR();
	xmlHttp.onreadystatechange = ReturnAddPart;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function ReturnAddPart() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			//AjaxErr('Looking at Addpart.',HttpText);
			var xmlDoc = xmlHttp.responseXML.documentElement;
			//var ProjID = xmlDoc.getElementsByTagName("ProjID")[0].childNodes[0].nodeValue;
			var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
			
			//Gebi('PartsTabMain').innerHTML += ProjID;
			PartsList(SysID);
		}
		else
		{
			AjaxErr('There was a problem with the AddPart request. Continue?',HttpText);
		}
	}
}
/**/