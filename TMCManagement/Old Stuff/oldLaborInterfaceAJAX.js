//javascript document

var xmlHttp
var HttpText ='';
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXmlHttpObject()
{
var xmlHttp=null;
try
  {
  // Firefox, Opera 8.0+, Safari
  xmlHttp=new XMLHttpRequest();
  }
catch (e)
  {
  // Internet Explorer
  try
    {
    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
  catch (e)
    {
    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
  }
  
  	if (xmlHttp==null)
	  {
	  alert ("Your browser does not support AJAX!");
	  return;
	  }
	  
return xmlHttp;
}
//------------------------------------------------------------------------------------------------


function SearchLabor(SearchName)
{
	var SearchTxt = Gebi("SearchLaborTxt").value;
	Gebi('Results').src='LaborSearch.asp?SearchTxt='+SearchTxt;
/** /	
	HttpText='LaborASP.asp?action=SearchLabor&SearchTxt='+SearchTxt+'&SearchName='+SearchName;
	xmlHttp = GetXmlHttpObject();
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
				html+=		'<button class="ItemAdd borderSizing" onClick="parent.AddLabor('+xmlTag("pID"+p)+');">Add</button>';
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
/**/
}


function AddLabor(LaborID)
{
/*
	parent.AddLabor(LaborID);
	var SysID = Gebi("HiddenEstID").value;
	//var MU = Gebi('SysExpFrame').contentWindow.document.getElementById("MU").value;
	
	//alert(LaborID);
	HttpText='EstimatesASP.asp?action=AddLabor&LaborID='+LaborID+'&SysID='+SysID;//+'&MU='+MU;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnAddLabor;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function AddBlankLabor()
{
	//var MU = Gebi('SysInfoFrame').contentWindow.document.getElementById("MU").value;

	HttpText='EstimatesASP.asp?action=AddLabor&LaborID=0&SysID='+Gebi('HiddenEstID').value;
	xmlHttp = GetXmlHttpObject();
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
			//AjaxErr('Looking at Addlabor.',HttpText);
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
/**/
}
