//javascript document

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
/**/
}


function AddPart(PartID)
{
/*
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
/**/
}


