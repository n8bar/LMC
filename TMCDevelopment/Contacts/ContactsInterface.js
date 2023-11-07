

var CurrentContactID=-1;
var CurrentRow=-1;
function EditContact(ContactInfoString) {
	Gebi('modal').style.display='block';
	Gebi('editWindow').style.display='block';
	Gebi('editTitle').innerHTML='Edit Contact';
	
	var info=ContactInfoString.split(',');
	
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
	
	CurrentContactID=pID;
	CurrentRow=row		
}

function newContact() {
	cancelContact();
	Gebi('modal').style.display='block';
	Gebi('editWindow').style.display='block';
	Gebi('editTitle').innerHTML='New Contact';
	Gebi('eMfr').focus();
}

function clearContact() {
	Gebi('eMfr').selectedIndex=0;
	Gebi('eMfr')[0].innerHTML='';
	Gebi('eName').value='';
	Gebi('ePN').value='';
	Gebi('eCost').value='';
	Gebi('eDesc').value='';
}

function saveContact() {
	var errTxt='';
	if (SelI('eMfr').innerHTML=='') errTxt+='\nManufacturer is needed.';
	if (Gebi('ePN').value=='') errTxt+='\nContact number is needed.';
	if (Gebi('eCost').value=='') errTxt+='\nCost is needed.';
	
	if (errTxt!='') {
		alert('Sorry. More information is needed:'+errTxt);
		return false;
	}
	
	if (CurrentContactID==-1) {
		
		var fields='Manufacturer, Model, ContactNumber, Cost, Description';
		
		var values="'"+CharsEncode(SelI('eMfr').innerHTML)+"'";
		values+=",'"+CharsEncode(Gebi('eName').value)+"'";
		values+=",'"+CharsEncode(Gebi('ePN').value)+"'";
		values+=","+Gebi('eCost').value;
		values+=",'"+CharsEncode(Gebi('eDesc').value)+"'";
		
		WSQLI('Contacts',fields,values);
		
		Gebi('SearchContactsTxt').value=Gebi('ePN').value;
		SearchContacts('ContactNumber');
	}
	else {
		WSQLU('Contacts','Manufacturer',CharsEncode(SelI('eMfr').innerHTML),'ContactsID',CurrentContactID);
		WSQLU('Contacts','Model',CharsEncode(Gebi('eName').value),'ContactsID',CurrentContactID);
		WSQLU('Contacts','ContactNumber',CharsEncode(Gebi('ePN').value),'ContactsID',CurrentContactID);
		WSQLU('Contacts','Cost',Gebi('eCost').value,'ContactsID',CurrentContactID);
		WSQLU('Contacts','Description',CharsEncode(Gebi('eDesc').value),'ContactsID',CurrentContactID);
		
		Gebi('Results').contentWindow.document.getElementById('Mfr'+CurrentRow).innerHTML=SelI('eMfr').innerHTML;
		Gebi('Results').contentWindow.document.getElementById('Model'+CurrentRow).innerHTML=Gebi('eName').value;
		Gebi('Results').contentWindow.document.getElementById('PN'+CurrentRow).innerHTML=Gebi('ePN').value;
		Gebi('Results').contentWindow.document.getElementById('Cost'+CurrentRow).innerHTML='$'+Gebi('eCost').value;
		Gebi('Results').contentWindow.document.getElementById('Desc'+CurrentRow).innerHTML=Gebi('eDesc').value;
	}
	
	cancelContact();
}

function delContact() {
	WSQL('DELETE FROM Contacts WHERE ContactsID='+CurrentContactID);
	cancelContact();
}
function cancelContact() {
	CurrentContactID=-1;
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
		if (nameChk.checked) text+='Name';
		if (phoneChk.checked) { 
			if(text!='') text+=',';
			text+='Phone1';
		}
		if (cIdChk.checked) { 
			if(text!='') text+=',';
			text+='ID';
		}
		if (cityChk.checked) { 
			if(text!='') text+=',';
			text+='City';
		}
		if (notesChk.checked) { 
			if(text!='') text+=',';
			text+='Notes';
		}
	}
	toSearch=setTimeout('SearchContacts(\''+text+'\');',750);
}

function SearchContacts(SearchName) {
	var SearchTxt = Gebi("SearchContactsTxt").value;
	Gebi('Results').src='ContactSearch.asp?SearchName='+SearchName+'&SearchTxt='+SearchTxt;
}

function resize() {
	if( !!Gebi('Results').contentWindow.document.getElementById('Contact1') && !!Gebi('HeadItems') )  {
		Gebi('HeadItems').style.width=Gebi('Results').contentWindow.document.getElementById('Contact1').offsetWidth+'px';
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
function SearchContacts(SearchName)
{
	var SearchTxt = Gebi("SearchContactsTxt").value;
	Gebi('Results').src='ContactSearch.asp?SearchName='+SearchName+'&SearchTxt='+SearchTxt;
	HttpText='ContactsASP.asp?action=SearchContacts&SearchTxt='+SearchTxt+'&SearchName='+SearchName;
	xmlHttp = GetXHR();
	xmlHttp.onreadystatechange = ReturnSearchContacts;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnSearchContacts() 
{
	if (xmlHttp.readyState == 4)
	{
		
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			function xmlTag(tagName)
			{
				try{	return xmlDoc.getElementsByTagName(tagName)[0].childNodes[0].nodeValue;	}
				catch(e){	AjaxErr('There was a problem with the SearchContacts Response:'+tagName,HttpText);	}
			}
			
			var matches=xmlTag("matches");
			
			var html = '';//xmlDoc.getElementsByTagName("Contacts")[0].childNodes[0].nodeValue;
			
			var MfrColor=xmlTag('MfrColor');
			var ContactColor=xmlTag('ContactColor');
			var DescColor=xmlTag('DescColor');
			
			for(p=1;p<=matches;p++)
			{
				html+='<div id="Contact'+p+'" class="ItemRow borderSizing" >';
				html+=	'<span class="Item borderSizing" style="width:4%; ">';
				html+=		'<button class="ItemAdd borderSizing" onClick="parent.AddContact('+xmlTag("pID"+p)+');">Add</button>';
					html+='</span>';
					html+='<span class="Item borderSizing" style="width:25%; border-left: 1px solid #000; color:#'+MfrColor+';">'+xmlTag("Mfr"+p)+'</span>';
					html+='<span class="Item borderSizing" style="width:25%; border-left: 1px solid #000; color:#'+ContactColor+';">'+xmlTag("PN"+p)+'</span>';
					html+='<span class="Item borderSizing" style="width:12%; border-left: 1px solid #000;display:inline;">$'+xmlTag("Cost"+p)+'</span>';
					html+='<span class="Item borderSizing" style="width:33%; border-left: 1px solid #000;display:inline; color:#'+DescColor+'">'+xmlTag("Desc"+p)+'</span>';
				html+='</div>';
			}
			
			if(xmlTag('maxed')==1) html+='<div id="Contact'+(p+1)+'" class="ItemRow borderSizing" style="color:red;">Maximum of '+xmlTag('max')+' results shown.</div>';
			
			Gebi('Results').innerHTML = html;

		}
		else
		{
			AjaxErr('There was a problem with the SearchContacts request.',HttpText);
		}
	}
}
/**/


/*
function AddContact(ContactID)
{
	parent.AddContact(ContactID);
	var SysID = Gebi("HiddenEstID").value;
	//var MU = Gebi('SysExpFrame').contentWindow.document.getElementById("MU").value;
	
	//alert(ContactID);
	HttpText='EstimatesASP.asp?action=AddContact&ContactID='+ContactID+'&SysID='+SysID;//+'&MU='+MU;
	xmlHttp = GetXHR();
	xmlHttp.onreadystatechange = ReturnAddContact;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function AddBlankContact()
{
	//var MU = Gebi('SysInfoFrame').contentWindow.document.getElementById("MU").value;

	HttpText='EstimatesASP.asp?action=AddContact&ContactID=0&SysID='+Gebi('HiddenEstID').value;
	xmlHttp = GetXHR();
	xmlHttp.onreadystatechange = ReturnAddContact;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function ReturnAddContact() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			//AjaxErr('Looking at AddContact.',HttpText);
			var xmlDoc = xmlHttp.responseXML.documentElement;
			//var ProjID = xmlDoc.getElementsByTagName("ProjID")[0].childNodes[0].nodeValue;
			var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
			
			//Gebi('ContactsTabMain').innerHTML += ProjID;
			ContactsList(SysID);
		}
		else
		{
			AjaxErr('There was a problem with the AddContact request. Continue?',HttpText);
		}
	}
}
/**/