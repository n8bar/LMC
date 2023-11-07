

var CurrentLaborID=-1;
var CurrentRow=-1;
function EditLabor(laborInfoString) {
	Gebi('modal').style.display='block';
	Gebi('editWindow').style.display='block';
	Gebi('editTitle').innerHTML='Edit Labor';
	
	var info=laborInfoString.split(',');
	
	var lID=info[0];
	var row=info[1];
	var name=CharsDecode(info[2]);
	var Cost=info[3];
	var Desc=CharsDecode(info[4]);
	
	Gebi('eCat').selectedIndex=0;
	Gebi('eCat')[0].innerHTML=Gebi('Results').contentWindow.document.getElementById('Cat'+row).innerHTML;
	Gebi('eName').value=Gebi('Results').contentWindow.document.getElementById('lName'+row).innerHTML;
	Gebi('eDesc').value=Gebi('Results').contentWindow.document.getElementById('Desc'+row).innerHTML;
	Gebi('eCost').value=Gebi('Results').contentWindow.document.getElementById('Cost'+row).innerHTML.replace('$','');
	Gebi('eCN').innerHTML=lID;
	
	CurrentLaborID=lID;
	CurrentRow=row		
}

function newLabor() {
	cancelLabor();
	Gebi('modal').style.display='block';
	Gebi('editWindow').style.display='block';
	Gebi('editTitle').innerHTML='New Labor';
}

function clearLabor() {
	Gebi('eCat').selectedIndex=0;
	Gebi('eCat')[0].innerHTML='';
	Gebi('eName').value='';
	Gebi('ePN').value='';
	Gebi('eCost').value='';
	Gebi('eDesc').value='';
}

function saveLabor() {
	var errTxt='';
	if (SelI('eCat').innerHTML=='') errTxt+='\nCategory is needed.';
	if (Gebi('eName').value=='') errTxt+='\nName is needed.';
	if (Gebi('eCost').value=='') errTxt+='\nRate is needed.';
	
	if (errTxt!='') {
		alert('Sorry. More information is needed:'+errTxt);
		return false;
	}
	
	if (CurrentLaborID==-1) {
		
		var fields='Category, Name, RateCost, Description';
		
		var values="'"+CharsEncode(SelI('eCat').innerHTML)+"'";
		values+=",'"+CharsEncode(Gebi('eName').value)+"'";
		values+=","+Gebi('eCost').value;
		values+=",'"+CharsEncode(Gebi('eDesc').value)+"'";
		
		WSQLI('Labor',fields,values);
		
		Gebi('SearchLaborTxt').value=Gebi('eName').value;
		SearchLabor('Name');
	}
	else {
		WSQLU('Labor','Category',CharsEncode(SelI('eCat').innerHTML),'LaborID',CurrentLaborID);
		WSQLU('Labor','Name',CharsEncode(Gebi('eName').value),'LaborID',CurrentLaborID);
		WSQLU('Labor','RateCost',Gebi('eCost').value,'LaborID',CurrentLaborID);
		WSQLU('Labor','Description',CharsEncode(Gebi('eDesc').value),'LaborID',CurrentLaborID);
		
		Gebi('Results').contentWindow.document.getElementById('Cat'+CurrentRow).innerHTML=SelI('eCat').innerHTML;
		Gebi('Results').contentWindow.document.getElementById('lName'+CurrentRow).innerHTML=Gebi('eName').value;
		Gebi('Results').contentWindow.document.getElementById('Cost'+CurrentRow).innerHTML='$'+Gebi('eCost').value;
		Gebi('Results').contentWindow.document.getElementById('Desc'+CurrentRow).innerHTML=Gebi('eDesc').value;
	}
	
	cancelLabor();
}

function delLabor() {
	WSQL('DELETE FROM Labor WHERE LaborID='+CurrentLaborID);
	cancelLabor();
	Gebi('Results').contentWindow.window.location=Gebi('Results').contentWindow.window.location;
}
function cancelLabor() {
	CurrentLaborID=-1;
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
		if (Gebi('catChk').checked) text+='Category';
		if (Gebi('nameChk').checked) { 
			if(text!='') text+=',';
			text+='Name';
		}
		if (Gebi('lIdChk').checked) { 
			if(text!='') text+=',';
			text+='LaborID';
		}
		if (Gebi('descChk').checked) { 
			if(text!='') text+=',';
			text+='Description';
		}
	}
	toSearch=setTimeout('SearchLabor(\''+text+'\');',750);
}


function newMfr() { 
	Gebi('catModal').style.display='block';
	Gebi('catName').focus();
	Gebi('eCat').selectedIndex=0;
}

function saveCat() {
	WSQLI('Manufacturers','Name',"'"+CharsEncode(Gebi('catName').value)+"'");
	
	var newOption = document.createElement("OPTION");
	var newOption2 = document.createElement("OPTION");
	Gebi('eCat').options.add(newOption);
	Gebi('dMfr').options.add(newOption2);
	newOption.innerHTML=Gebi('catName').value;
	newOption2.innerHTML=Gebi('catName').value;
	
	Gebi('eCat').selectedIndex=Gebi('eCat').length-1;
	Gebi('catModal').style.display='block';
}
function delMfr() {
	if(confirm('Are you sure you want to delete the manufacturer:'+SelI('dMfr').innerHTML)){
		WSQL('DELETE FROM Manufacturers WHERE ManufID='+SelI('dMfr').value);
	}
}


function SearchLabor(SearchName) {
	var SearchTxt = Gebi("SearchLaborTxt").value;
	Gebi('Results').src='LaborSearch.asp?SearchName='+SearchName+'&SearchTxt='+SearchTxt;
}

function resize() {
	if( !!Gebi('Results').contentWindow.document.getElementById('Labor1') && !!Gebi('HeadItems') )  {
		Gebi('HeadItems').style.width=Gebi('Results').contentWindow.document.getElementById('Labor1').offsetWidth+'px';
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
function SearchLabor(SearchName)
{
	var SearchTxt = Gebi("SearchLaborTxt").value;
	Gebi('Results').src='LaborSearch.asp?SearchName='+SearchName+'&SearchTxt='+SearchTxt;
	HttpText='LaborASP.asp?action=SearchLabor&SearchTxt='+SearchTxt+'&SearchName='+SearchName;
	xmlHttp = GetXHR();
	xmlHttp.onreadystatechange = ReturnSearchLabor;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnSearchLabor() 
{
	if (xmlHttp.readyState == 4)
	{
		
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			function xmlTag(tagName)
			{
				try{	return xmlDoc.getElementsByTagName(tagName)[0].childNodes[0].nodeValue;	}
				catch(e){	AjaxErr('There was a problem with the SearchLabor Response:'+tagName,HttpText);	}
			}
			
			var matches=xmlTag("matches");
			
			var html = '';//xmlDoc.getElementsByTagName("Labor")[0].childNodes[0].nodeValue;
			
			var MfrColor=xmlTag('MfrColor');
			var LaborColor=xmlTag('LaborColor');
			var DescColor=xmlTag('DescColor');
			
			for(p=1;p<=matches;p++)
			{
				html+='<div id="Labor'+p+'" class="ItemRow borderSizing" >';
				html+=	'<span class="Item borderSizing" style="width:4%; ">';
				html+=		'<button class="ItemAdd borderSizing" onClick="parent.AddLabor('+xmlTag("lID"+p)+');">Add</button>';
					html+='</span>';
					html+='<span class="Item borderSizing" style="width:25%; border-left: 1px solid #000; color:#'+MfrColor+';">'+xmlTag("Mfr"+p)+'</span>';
					html+='<span class="Item borderSizing" style="width:25%; border-left: 1px solid #000; color:#'+LaborColor+';">'+xmlTag("PN"+p)+'</span>';
					html+='<span class="Item borderSizing" style="width:12%; border-left: 1px solid #000;display:inline;">$'+xmlTag("Cost"+p)+'</span>';
					html+='<span class="Item borderSizing" style="width:33%; border-left: 1px solid #000;display:inline; color:#'+DescColor+'">'+xmlTag("Desc"+p)+'</span>';
				html+='</div>';
			}
			
			if(xmlTag('maxed')==1) html+='<div id="Labor'+(p+1)+'" class="ItemRow borderSizing" style="color:red;">Maximum of '+xmlTag('max')+' results shown.</div>';
			
			Gebi('Results').innerHTML = html;

		}
		else
		{
			AjaxErr('There was a problem with the SearchLabor request.',HttpText);
		}
	}
}
/**/


/*
function AddLabor(LaborID)
{
	parent.AddLabor(LaborID);
	var SysID = Gebi("HiddenEstID").value;
	//var MU = Gebi('SysExpFrame').contentWindow.document.getElementById("MU").value;
	
	//alert(LaborID);
	HttpText='EstimatesASP.asp?action=AddLabor&LaborID='+LaborID+'&SysID='+SysID;//+'&MU='+MU;
	xmlHttp = GetXHR();
	xmlHttp.onreadystatechange = ReturnAddLabor;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function AddBlankLabor()
{
	//var MU = Gebi('SysInfoFrame').contentWindow.document.getElementById("MU").value;

	HttpText='EstimatesASP.asp?action=AddLabor&LaborID=0&SysID='+Gebi('HiddenEstID').value;
	xmlHttp = GetXHR();
	xmlHttp.onreadystatechange = ReturnAddLabor;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function ReturnAddLabor() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			//AjaxErr('Looking at AddLabor.',HttpText);
			var xmlDoc = xmlHttp.responseXML.documentElement;
			//var ProjID = xmlDoc.getElementsByTagName("ProjID")[0].childNodes[0].nodeValue;
			var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
			
			//Gebi('LaborTabMain').innerHTML += ProjID;
			LaborList(SysID);
		}
		else
		{
			AjaxErr('There was a problem with the AddLabor request. Continue?',HttpText);
		}
	}
}
/**/