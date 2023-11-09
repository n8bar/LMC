 //JavaScriptDocument
var ManufArray=new Array();
var SystemsArray=new Array();
var CategoryArray=new Array();
var VendorArray=new Array();
var gSearchName='';
var gSearchTXT='';
var xmlHttp;
var HttpText;
var GlobalCustID='';
//CreatesthemainXMLHttpRequestobject////////////////////////////////////////////////////////
function GetXmlHttpObject()
{
	var xmlHttp=null;
	try
	{
		// Firefox, Opera 8.0+, Safari, Chrome
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


//UpdatesTextfromaTextboxonKeyup////////////////////////////////////////////////
function UpdateText(BoxID,BoxType,Table,IDColumn,Column,RowID)
{
	
	var SysOK='No';	
	if(BoxType=='List'){var Text=Gebi(BoxID)[Gebi(BoxID).selectedIndex].value;}
	if(BoxType=='ListTxt'){var Obj=Gebi(BoxID);var Text=(Obj[Obj.selectedIndex].text);}
	if(BoxType=='Text'){var Text=Gebi(BoxID).value;}
	if(BoxType=='CheckBox'){var Text=Gebi(BoxID).checked;}
	if(Table=='BidPresets'){var RowID=Gebi('BidPresetID').innerHTML;}
	
	Text=Text.replace(/\r/g,'');
Text=Text.replace(/\n/g,'--RET--');
	
	//Text=Text.replace(/--RET--/g,'\n');//Ontheotherend
	
	//alert(Ret);
		
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnUpdateText;
	xmlHttp.open('Get','DataEntryASP.asp?action=UpdateText&Text='+Text+'&Table='+Table+'&IDColumn='+IDColumn+'&Column='+Column+'&RowID='+RowID+'&SysOK='+SysOK+'&BoxID='+BoxID+'&BoxType='+BoxType,true);
	xmlHttp.send(null);
	
}
function ReturnUpdateText()
{
if(xmlHttp.readyState==4)
	{
		if(xmlHttp.status==200)
	{
			
			var xmlDoc=xmlHttp.responseXML.documentElement;
			
			var Ok=xmlDoc.getElementsByTagName("Ok")[0].childNodes[0].nodeValue;
			var BoxID=xmlDoc.getElementsByTagName("BoxID")[0].childNodes[0].nodeValue;
			var BoxType=xmlDoc.getElementsByTagName("BoxType")[0].childNodes[0].nodeValue;
			var Table=xmlDoc.getElementsByTagName("Table")[0].childNodes[0].nodeValue;
			var IDColumn=xmlDoc.getElementsByTagName("IDColumn")[0].childNodes[0].nodeValue;
			var Column=xmlDoc.getElementsByTagName("Column")[0].childNodes[0].nodeValue;
			var RowID=xmlDoc.getElementsByTagName("RowID")[0].childNodes[0].nodeValue;
			
			if(BoxID=='SystemTypes'){UpdateText(BoxID,'ListTxt',Table,IDColumn,'BidPresetSystem',RowID);}
		}
		else
		{
alert('Problem related to AJAX function: UpdateText :(');
}
}
	
}
//-------------------------------------------------------------------------------------------------




function LoadList(ArrayName,DivID,Count)//LoadsComboboxlists
{
	if(Count){}
	else
	{
		Count=ArrayName.length;	
	}
	
	for(var y=0;y<Count;y++)
	{
		var Div=eval('Gebi("'+DivID+'")');
		var newOption=document.createElement("OPTION");
		Div.options.add(newOption);
		newOption.value=ArrayName[y][2];
		newOption.innerText=ArrayName[y][2];
	}	
	
}



//GetstheManufacturesList////////////////////////////////////////////////
function GetManufList()
{
		//ReturnGetManufList();
	xmlHttp=GetXmlHttpObject();
		xmlHttp.onreadystatechange=ReturnGetManufList;
	xmlHttp.open('Get','DataEntryASP.asp?action=GetManufList',true);
	xmlHttp.send(null);
}
function ReturnGetManufList()
{
	
	//alert('.readyState='+xmlHttp.readyState);
	if(xmlHttp.readyState==4)
	{
		//alert('.status='+xmlHttp.status);
		if(xmlHttp.status==200)
		{
			var xmlDoc=xmlHttp.responseXML.documentElement;
			//alert(xmlDoc.getElementsByTagName('ArrCount').length);
			var ArrCount=xmlDoc.getElementsByTagName('ArrCount')[0].childNodes[0].nodeValue;
			
			ManufArray[0]=new Array('','1','----');
			
			for(i=1;i<ArrCount;i++)
			{
				var sID='ID'+i;
				var sName='Name'+i;
				
				var ID=xmlDoc.getElementsByTagName(sID)[0].childNodes[0].nodeValue;
				var Name=xmlDoc.getElementsByTagName(sName)[0].childNodes[0].nodeValue;
				
				ManufArray[i]=new Array('',ID,Name);
				
			}
			
			
			LoadList(ManufArray,'Manufacturer',ArrCount);
			
			
			GetSystemsList();
			
			//alert(ManufArray);
			
		}
		else
		{
			alert('Problem related to AJAX function: GetManufList :(');
		}
	}
	
}
//-------------------------------------------------------------------------------------------------






//GetstheSystemsList////////////////////////////////////////////////
function GetSystemsList()
{
	xmlHttp=GetXmlHttpObject();
xmlHttp.onreadystatechange=ReturnGetSystemList;
	xmlHttp.open('Get','DataEntryASP.asp?action=GetSystemsList',true);
	xmlHttp.send(null);
		
		
}

function ReturnGetSystemList()
{
if(xmlHttp.readyState==4)
	{
		if(xmlHttp.status==200)
	{
			
			var xmlDoc=xmlHttp.responseXML.documentElement;
			var ArrCount=xmlDoc.getElementsByTagName("ArrCount")[0].childNodes[0].nodeValue;
			
			
			SystemsArray[0]=new Array('','1','----');
			
			for(i=1;i<ArrCount;i++)
				{
					var sID='ID'+i;
					var sName='Name'+i;
					
					var ID=xmlDoc.getElementsByTagName(sID)[0].childNodes[0].nodeValue;
					var Name=xmlDoc.getElementsByTagName(sName)[0].childNodes[0].nodeValue;
					
					SystemsArray[i]=new Array('',ID,Name);
					
				}
				
				
				LoadList(SystemsArray,'System',ArrCount);
							
				
				GetCategoryList();
		}
		else
		{
alert('Problem related to AJAX function: GetSystemsList :(');
}
}
	
}
//-------------------------------------------------------------------------------------------------







//GetstheSystemsList////////////////////////////////////////////////

function GetCategoryList()
{

	xmlHttp=GetXmlHttpObject();
xmlHttp.onreadystatechange=ReturnGetCategoryList;
	xmlHttp.open('Get','DataEntryASP.asp?action=GetCategoryList',true);
	xmlHttp.send(null);
		
		
}


function ReturnGetCategoryList()
{
if(xmlHttp.readyState==4)
	{
		if(xmlHttp.status==200)
	{
			
			var xmlDoc=xmlHttp.responseXML.documentElement;
			var ArrCount=xmlDoc.getElementsByTagName("ArrCount")[0].childNodes[0].nodeValue;
			
			
			CategoryArray[0]=new Array('','1','----');
			
			for(i=1;i<ArrCount;i++)
				{
					var sID='ID'+i;
					var sName='Name'+i;
					
					var ID=xmlDoc.getElementsByTagName(sID)[0].childNodes[0].nodeValue;
					var Name=xmlDoc.getElementsByTagName(sName)[0].childNodes[0].nodeValue;
					
					CategoryArray[i]=new Array('',ID,Name);
					
				}
				
				LoadList(CategoryArray,'Category1',ArrCount);
				LoadList(CategoryArray,'Category2',ArrCount);
				
				
				GetVendorList();
		}
		else
		{
alert('Problem related to AJAX function:  :(');
}
}
	
}
//-------------------------------------------------------------------------------------------------





//GetstheSystemsList////////////////////////////////////////////////

function GetVendorList()
{
	HttpText='DataEntryASP.asp?action=GetVendorList'
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnGetVendorList;
	xmlHttp.open('Get',HttpText,true);
	xmlHttp.send(null);
		
		
}


function ReturnGetVendorList()
{
if(xmlHttp.readyState==4)
	{
		if(xmlHttp.status==200)
	{
			
			var xmlDoc=xmlHttp.responseXML.documentElement;
			var ArrCount=xmlDoc.getElementsByTagName("ArrCount")[0].childNodes[0].nodeValue;
			
			
			VendorArray[0]=new Array('','1','----');
			
			for(i=1;i<ArrCount;i++)
				{
					var sID='ID'+i;
					var sName='Name'+i;
					
					var ID=xmlDoc.getElementsByTagName(sID)[0].childNodes[0].nodeValue;
					var Name=xmlDoc.getElementsByTagName(sName)[0].childNodes[0].nodeValue;
					
					VendorArray[i]=new Array('',ID,Name);
					
				}
				
				
				LoadList(VendorArray,'Vendor1');
				LoadList(VendorArray,'Vendor2');
				LoadList(VendorArray,'Vendor3');
				LoadList(VendorArray,'Vendor4');
				LoadList(VendorArray,'Vendor5');
				LoadList(VendorArray,'Vendor6');
				
				//GetSystemsList();
		}
		else
		{
			AjaxErr('Problem related to AJAX function:  GetVendorList',HttpText);
		}
}
	
}
//-------------------------------------------------------------------------------------------------








//Pulls a list o fparts based on the search text////////////////////////////////////////////////

function SearchParts()
{
	
	var SearchFields='';
	
	if(Gebi('SearchPartsManufBtn').checked){SearchFields+='Manufacturer.'}
	if(Gebi('SearchPartsModelBtn').checked){SearchFields+='Model.'}
	if(Gebi('SearchPartsItemNumBtn').checked){SearchFields+='PartNumber.'}
	if(Gebi('SearchPartsSystemBtn').checked){SearchFields+='System.'}
	if(Gebi('SearchPartsCategoryBtn').checked){SearchFields+='Category1.Category2.'}
	if(Gebi('SearchPartsVendorBtn').checked){SearchFields+='Vendor1.Vendor2.Vendor3.Vendor4.Vendor5.Vendor6.'}
	if(Gebi('SearchPartsDescBtn').checked){SearchFields+='Description.'}
	
	if(SearchFields==''){return false}
	
	var SearchTxt=Gebi("SearchPartsTxt").value;

	Gebi('SearchingPartsModal').style.display='block';
	
	gSearchName=SearchFields;
	gSearchTxt=SearchTxt;
	
	HttpText=encodeURI('DataEntryASP.asp?action=SearchParts&SearchTxt='+SearchTxt+'&SearchFields='+SearchFields);
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnSearchParts;
	xmlHttp.open('Get',HttpText,true);
	xmlHttp.send(null);
	
}


function ReturnSearchParts()
{
	if(xmlHttp.readyState==4)
	{
		if(xmlHttp.status==200)
		{
			//AjaxErr('View the SearchParts Response',HttpText);
			var xmlDoc=xmlHttp.responseXML.documentElement;
			var Parts=xmlDoc.getElementsByTagName("Parts")[0].childNodes[0].nodeValue;
			Gebi('AddPartBoxScroll').innerHTML=Parts;
			Gebi('SearchingPartsModal').style.display='none';
		}
		else
		{
			Gebi('SearchingPartsModal').style.display='none';
			AjaxErr('Problem related to AJAX function: SearchParts :(',HttpText);
		}
	}
}//-------------------------------------------------------------------------------------------------



var xmlHttp3;
function IncludedPartsList()
{
	HttpText='DataEntryASP.asp?action=IncludedPartsList&PartID='+EditPartID;
	//DebugBox(a(HTTP),48,300);
	xmlHttp3=GetXmlHttpObject();
	xmlHttp3.onreadystatechange=ReturnIncludedPartsList;
	xmlHttp3.open('Get',HttpText,true);
	xmlHttp3.send(null);
}	
function ReturnIncludedPartsList()
{
	if(xmlHttp3.readyState==4)
	{
		if(xmlHttp3.status==200)
		{
			var xmlDoc=xmlHttp3.responseXML.documentElement;
			//DebugBox(xmlDoc.getElementsByTagName('SQL')[0].childNodes[0].nodeValue);
			
			var PartCount= xmlDoc.getElementsByTagName('PartCount')[0].childNodes[0].nodeValue;
			
			var pListHTML='';
			if(PartCount>0)
			{
				var SubPID;
				var RowID;
				var Qty;
				var Mfr;
				var Model;
				var PN;
				var Sys;
				var Cat;
				var Desc;
								
				var RowClr='E0E8ED'
				for(P=1;P<=PartCount;P++)
				{
					SubPID=xmlDoc.getElementsByTagName('SubPartID'+P)[0].childNodes[0].nodeValue;
					RowID=xmlDoc.getElementsByTagName('RowID'+P)[0].childNodes[0].nodeValue;
					Qty=xmlDoc.getElementsByTagName('Qty'+P)[0].childNodes[0].nodeValue;
					Mfr=xmlDoc.getElementsByTagName('Mfr'+P)[0].childNodes[0].nodeValue;
					Model=xmlDoc.getElementsByTagName('Model'+P)[0].childNodes[0].nodeValue;
					PN=xmlDoc.getElementsByTagName('PN'+P)[0].childNodes[0].nodeValue;
					Sys=xmlDoc.getElementsByTagName('Sys'+P)[0].childNodes[0].nodeValue;
					Cat=xmlDoc.getElementsByTagName('Cat'+P)[0].childNodes[0].nodeValue;
					Desc=xmlDoc.getElementsByTagName('Desc'+P)[0].childNodes[0].nodeValue;
					//alert(Desc);
					
					if(RowClr=='E0E8ED')
						{RowClr='E8EDE0';}
					else
						{RowClr='E0E8ED';}
						
					pListHTML+='<div id="Part'+SubPID+'" class="IncPartsListItemRow" style="background:#'+RowClr+'">'
					pListHTML+='<div class="IncPartsListItem" style="width:60px;">'
						pListHTML+='<button class="PartsListItemEdit" onClick="ExcludePart('+RowID+');">▲Remove</button>'
					pListHTML+='</div>'
					pListHTML+='<div class="IncPartsListItem" style="width:24px;" title="'+Qty+'">'+Qty+'</div>'
					pListHTML+='<div class="IncPartsListItem" style="width:112px;" title="'+Mfr+'">'+Mfr+'</div>'
					pListHTML+='<div class="IncPartsListItem" style="width:48px;" title="'+Model+'">'+Model+'</div>'
					pListHTML+='<div class="IncPartsListItem" style="width:48px;" title="'+PN+'">'+PN+'</div>'
					pListHTML+='<div class="IncPartsListItem" style="width:48px;" title="'+Sys+'">'+Sys+'</div>'
					pListHTML+='<div class="IncPartsListItem" style="width:64px;" title="'+Cat+'">'+Cat+'</div>'
					pListHTML+='<div class="IncPartsListItem" style="overflow:visible;" title="'+Desc+'">'+Desc+'</div>'
					//pListHTML+='<div class="IncPartsListItem" style="width:48px; '>'+rs('')+'</div>'
					pListHTML+='</div>'
				}
				
				//if(PartCount>99){pListHTML+='First 100 parts shown. Please refine search.'}
				
				var PLHeads
				PLHeads='<div style="height:8%;border:1px#000solid;border-left:none;border-top:none; position:relative;">'
				PLHeads+='<div class="SRHeads" style="width:60px;"><b>-</b></div>'
				PLHeads+='<div class="SRHeads" style="width:24px;">Qty</div>'
				PLHeads+='<div class="SRHeads" style="width:112px;">Manufacturer</div>'
				PLHeads+='<div class="SRHeads" style="width:48px;">Model</div>'
				PLHeads+='<div class="SRHeads" style="width:48px;">P/N</div>'
				PLHeads+='<div class="SRHeads" style="width:48px;">Sys</div>'
				PLHeads+='<div class="SRHeads" style="width:64px;">Category</div>'
				PLHeads+='<div class="SRHeads" >Description</div>'
				PLHeads+='</div>'
				
				Gebi('IncPartsList').innerHTML=PLHeads+pListHTML;
			}
			
			
		}
		else
		{
			alert('Problem related to AJAX function: IncludedPartsList :(');
			DebugBox(a(HttpText));
		}
	}
}
//---------------------------------------------------------------------------


function IncludeSearchParts()
{
	var HTTP='DataEntryASP.asp?action=IncludeSearchParts';
	HTTP+='&Mfr='+Gebi('ipsMfr').value;
	HTTP+='&Model='+Gebi('ipsModel').value;
	HTTP+='&PN='+Gebi('ipsPN').value;
	HTTP+='&Sys='+Gebi('ipsSys').value;
	HTTP+='&Desc='+Gebi('ipsDesc').value;
	
	//try{Gebi('SearchResultsModal').style.display='block';}
	//catch(e){alert('DataEntryAJAX.jsLine602:'+e.description);}
	
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnIncludeSearchParts;
	xmlHttp.open('Get',HTTP,false);
	xmlHttp.send(null);
	
	function ReturnIncludeSearchParts()
	{
		//Gebi('AddPartSearchTitle').innerHTML=xmlHttp.readyState;
		if(xmlHttp.readyState==4)
		{
			//Gebi('AddPartSearchTitle').innerHTML=xmlHttp.readyState+""+xmlHttp.status;
			if(xmlHttp.status==200)
			{
				var xmlDoc=xmlHttp.responseXML.documentElement
				var L=xmlDoc.getElementsByTagName("L")[0].childNodes[0].nodeValue.replace('--','');
				var SQL=xmlDoc.getElementsByTagName("SQL")[0].childNodes[0].nodeValue;
				
				var SRHeads=
				
				SRHeads='<div style="height:8%;border:1px#000solid;border-left:none;border-top:none; position:relative;">'
				SRHeads+='<div class="SRHeads" style="width:42px;"><b>+</b></div>'
				SRHeads+='<div class="SRHeads" style="width:96px;">Manufacturer</div>'
				SRHeads+='<div class="SRHeads" style="width:48px;">Model</div>'
				SRHeads+='<div class="SRHeads" style="width:48px;">P/N</div>'
				SRHeads+='<div class="SRHeads" style="width:48px;">Sys</div>'
				SRHeads+='<div class="SRHeads" style="width:64px;">Category</div>'
				SRHeads+='<div class="SRHeads" style="overflow:visible;">Description</div>'
				SRHeads+='</div>'
				
				Gebi('IncPartsSearchResults').innerHTML=SRHeads+L+'<br/>'+SQL;
			}
			else{alert('Problem related to AJAX function: IncludeSearchParts :(');}
		}
	}
}

function IncludePart(PN)
{
	var HTTP='DataEntryASP.asp?action=IncludePart&PartID='+EditPartID+'&IncPartID='+PN;
	//Gebi('PartsEntryHead').innerHTML='<a href="../../TMCDevelopment/'+HTTP+'">IncludePart Response</a>';
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnIncludePart;
	xmlHttp.open('Get',HTTP,true);
	xmlHttp.send(null);

	function ReturnIncludePart()
	{
		if(xmlHttp.readyState==4)
		{
			if(xmlHttp.status==200)
			{
				var xmlDoc=xmlHttp.responseXML.documentElement;
				//DebugBox(xmlHttp.responseText);
				IncludedPartsList();
			}
			else
			{
				alert('Problem related to AJAX function: IncludePart');
			}
		}
	}
}

function ExcludePart(RowID)
{
	var HTTP='DataEntryASP.asp?action=ExcludePart&RowID='+RowID;
	//Gebi('PartsEntryHead').innerHTML='<a href="../../TMCDevelopment/'+HTTP+'">IncludePart Response</a>';
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnExcludePart;
	xmlHttp.open('Get',HTTP,true);
	xmlHttp.send(null);

	function ReturnExcludePart()
	{
		if(xmlHttp.readyState==4)
		{
			if(xmlHttp.status==200)
			{
				var xmlDoc=xmlHttp.responseXML.documentElement;
				//DebugBox(xmlHttp.responseText,16,32);
				IncludedPartsList();
			}
			else
			{
				alert('Problem related to AJAX function: ExcludePart');
			}
		}
	}
}




//Opens the EditParts Modal////////////////////////////////////////////////

var EditPartID=0;
var xmlHttp2
function EditPart(PartID)
{
	EditPartID=PartID
	var Http='DataEntryASP.asp?action=EditPart&PartID='+EditPartID;
	//DebugBox('<a href="../../TMCDevelopment/'+Http+'">EditPart HTTP</a>',100,100,0,0);
	xmlHttp2=GetXmlHttpObject();
	xmlHttp2.onreadystatechange=ReturnEditPart;
	xmlHttp2.open('Get',Http,false);
	xmlHttp2.send(null);
}
function ReturnEditPart()
{
	if(xmlHttp2.readyState==4)
	{
		if(xmlHttp2.status==200)
		{
			ClearPartEdit();
			Gebi('SaveNew').style.display='none';
			Gebi('SaveNew').style.visibility='hidden';
			Gebi('SaveExisting').style.display='block';
			Gebi('SaveExisting').style.visibility='visible';
			
			//DebugBox(xmlHttp2.responseText,100,200,0,0);
			var xmlDoc=xmlHttp2.responseXML.documentElement;
			//DebugBox('documentElement returns as:'+xmlHttp2.responseXML.documentElement);
			ShowPartEditModal();
			
			//DebugBox(xmlDoc.getElementsByTagName("root").innerText,100,200,0,0);
			var PartID=xmlDoc.getElementsByTagName("PartID")[0].childNodes[0].nodeValue.replace('-','');
			var Manufacturer=xmlDoc.getElementsByTagName("Manufacturer")[0].childNodes[0].nodeValue.replace('-','');
			var Model=xmlDoc.getElementsByTagName("Model")[0].childNodes[0].nodeValue.replace('-','');
			var PartNumber=xmlDoc.getElementsByTagName("PartNumber")[0].childNodes[0].nodeValue.replace('-','');
			var Description=xmlDoc.getElementsByTagName("Description")[0].childNodes[0].nodeValue.replace('-','');
			var LaborValue=xmlDoc.getElementsByTagName("LaborValue")[0].childNodes[0].nodeValue.replace('-','');
			var System=xmlDoc.getElementsByTagName("System")[0].childNodes[0].nodeValue.replace('-','');
			var Category1=xmlDoc.getElementsByTagName("Category1")[0].childNodes[0].nodeValue.replace('-','');
			var Category2=xmlDoc.getElementsByTagName("Category2")[0].childNodes[0].nodeValue.replace('-','');
			var Vendor1=xmlDoc.getElementsByTagName("Vendor1")[0].childNodes[0].nodeValue.replace('-','');
			var Vendor2=xmlDoc.getElementsByTagName("Vendor2")[0].childNodes[0].nodeValue.replace('-','');
			var Vendor3=xmlDoc.getElementsByTagName("Vendor3")[0].childNodes[0].nodeValue.replace('-','');
			var Vendor4=xmlDoc.getElementsByTagName("Vendor4")[0].childNodes[0].nodeValue.replace('-','');
			var Vendor5=xmlDoc.getElementsByTagName("Vendor5")[0].childNodes[0].nodeValue.replace('-','');
			var Vendor6=xmlDoc.getElementsByTagName("Vendor6")[0].childNodes[0].nodeValue.replace('-','');
			var Cost=xmlDoc.getElementsByTagName("Cost")[0].childNodes[0].nodeValue.replace('-','');
			var Cost1=xmlDoc.getElementsByTagName("Cost1")[0].childNodes[0].nodeValue.replace('-','');
			var Cost2=xmlDoc.getElementsByTagName("Cost2")[0].childNodes[0].nodeValue.replace('-','');
			var Cost3=xmlDoc.getElementsByTagName("Cost3")[0].childNodes[0].nodeValue.replace('-','');
			var Cost4=xmlDoc.getElementsByTagName("Cost4")[0].childNodes[0].nodeValue.replace('-','');
			var Cost5=xmlDoc.getElementsByTagName("Cost5")[0].childNodes[0].nodeValue.replace('-','');
			var Cost6=xmlDoc.getElementsByTagName("Cost6")[0].childNodes[0].nodeValue.replace('-','');
			var Date1=xmlDoc.getElementsByTagName("Date1")[0].childNodes[0].nodeValue.replace('-','');
			var Date2=xmlDoc.getElementsByTagName("Date2")[0].childNodes[0].nodeValue.replace('-','');
			var Date3=xmlDoc.getElementsByTagName("Date3")[0].childNodes[0].nodeValue.replace('-','');
			var Date4=xmlDoc.getElementsByTagName("Date4")[0].childNodes[0].nodeValue.replace('-','');
			var Date5=xmlDoc.getElementsByTagName("Date5")[0].childNodes[0].nodeValue.replace('-','');
			var Date6=xmlDoc.getElementsByTagName("Date6")[0].childNodes[0].nodeValue.replace('-','');
			
			xmlGebTag=null;
			
			var PartIDTxt='Part#'+PartID
			
			if(Category2==''){Category2='----';}
			if(Model==''){Model='----';}
			
			if(Cost2==''){Cost2='0';}
			if(Cost3==''){Cost3='0';}
			if(Cost4==''){Cost4='0';}
			if(Cost5==''){Cost5='0';}
			if(Cost6==''){Cost6='0';}
			
			if(Date2==''){Date2='';}
			if(Date3==''){Date3='';}
			if(Date4==''){Date4='';}
			if(Date5==''){Date5='';}
			if(Date6==''){Date6='';}
			
			
			Gebi('SaveExisting').style.display='block';
			Gebi('SaveExisting').style.visibility='visible';
			
			
			
			Gebi('PartsEntryFoot').innerHTML=PartIDTxt;
			Gebi('HiddenPartID').value=PartID;
			
			Gebi('Manufacturer')[0].innerText=Manufacturer.replace('undefined','----');
			Gebi('Manufacturer').selectedIndex=0;
			//Gebi('Manufacturer')[Gebi('Manufacturer').selectedIndex].value=;
			
			Gebi('Model').value=Model;
			Gebi('PartNumber').value=PartNumber;
			Gebi('Description').value=Description;
			Gebi('LaborValue').value=LaborValue;
			
			Gebi('System')[0].innerText=System.replace('undefined','----');
			Gebi('System').selectedIndex=0;
			
			Gebi('Category1')[0].innerText=Category1.replace('undefined','----');
			Gebi('Category1').selectedIndex=0;
			
			Gebi('Category2')[0].innerText=Category2.replace('undefined','----');
			Gebi('Category2').selectedIndex=0;
			
			Gebi('Vendor1')[0].innerText=Vendor1.replace('undefined','----');
			Gebi('Vendor1').selectedIndex=0;
			
			Gebi('Vendor2')[0].innerText=Vendor2.replace('undefined','----');
			Gebi('Vendor2').selectedIndex=0;
			
			Gebi('Vendor3')[0].innerText=Vendor3.replace('undefined','----');
			Gebi('Vendor3').selectedIndex=0;
			
			Gebi('Vendor4')[0].innerText=Vendor4.replace('undefined','----');
			Gebi('Vendor4').selectedIndex=0;
			
			Gebi('Vendor5')[0].innerText=Vendor5.replace('undefined','----');
			Gebi('Vendor5').selectedIndex=0;
			
			Gebi('Vendor6')[0].innerText=Vendor6.replace('undefined','----');
			Gebi('Vendor6').selectedIndex=0;
			
			Gebi('Cost').value=Cost;
			Gebi('Cost1').value=Cost1;
			Gebi('Cost2').value=Cost2;
			Gebi('Cost3').value=Cost3;
			Gebi('Cost4').value=Cost4;
			Gebi('Cost5').value=Cost5;
			Gebi('Cost6').value=Cost6;
			Gebi('Date1').value=Date1;
			Gebi('Date2').value=Date2;
			Gebi('Date3').value=Date3;
			Gebi('Date4').value=Date4;
			Gebi('Date5').value=Date5;
			Gebi('Date6').value=Date6;
			
		}
		else
		{
			alert('Problem related to AJAX function: EditPart :(');
		}
	}
}
//-------------------------------------------------------------------------------------------------



//UpdatesaPart////////////////////////////////////////////////

function SaveExistingPart()
{
	var PartID=Gebi('HiddenPartID').value;
	var Manufacturer=SelI('Manufacturer').innerText;
	var Model=Gebi('Model').value;
	var PartNumber=Gebi('PartNumber').value;
	var Description=Gebi('Description').value;
	var LaborValue=Gebi('LaborValue').value;
	var System=SelI('System').innerText;
	var Category1=SelI('Category1').innerText;
	var Category2=SelI('Category2').innerText;
	var Cost=Gebi('Cost').value;
	var Cost1=Gebi('Cost1').value;
	var Cost2=Gebi('Cost2').value;
	var Cost3=Gebi('Cost3').value;
	var Cost4=Gebi('Cost4').value;
	var Cost5=Gebi('Cost5').value;
	var Cost6=Gebi('Cost6').value;
	var Vendor1=SelI('Vendor1').innerText;
	var Vendor2=SelI('Vendor2').innerText;
	var Vendor3=SelI('Vendor3').innerText;
	var Vendor4=SelI('Vendor4').innerText;
	var Vendor5=SelI('Vendor5').innerText;
	var Vendor6=SelI('Vendor6').innerText;
	var Date1=Gebi('Date1').value;
	var Date2=Gebi('Date2').value;
	var Date3=Gebi('Date3').value;
	var Date4=Gebi('Date4').value;
	var Date5=Gebi('Date5').value;
	var Date6=Gebi('Date6').value;
	
	if(Manufacturer==''){alert('Manufacturer is required.');return false;}
	if(Model==''){alert('Model is required.');return false;}
	if(PartNumber==''){alert('PartNumber is required.');return false;}
	if(Description==''){alert('Description is required.');return false;}
	if(Cost==''){alert('BidCost is required.');return false;}
	if(LaborValue==''){alert('LaborHr is required.');return false;}
	if(System==''){alert('System is required.');return false;}
	if(Category1==''){alert('Category1 is required.');return false;}
	if(Vendor1==''){alert('Vendor1 is required.');return false;}
	if(Cost1==''){alert('Cost1 is required.');return false;}
	if(Date1==''){alert('Date1 is required.');return false;}
		
	HttpText='DataEntryASP.asp?action=SaveExistingPart&PartID='+PartID+'&Manufacturer='+Manufacturer+'&Model='+Model;
	HttpText+='&PartNumber='+PartNumber+'&Description='+Description+'&LaborValue='+LaborValue+'&Cost='+Cost+'&System='+System;
	HttpText+='&Category1='+Category1+'&Category2='+Category2+'&Cost1='+Cost1+'&Cost2='+Cost2;
	HttpText+='&Cost3='+Cost3+'&Cost4='+Cost4+'&Cost5='+Cost5+'&Cost6='+Cost6;
	HttpText+='&Vendor1='+Vendor1+'&Vendor2='+Vendor2+'&Vendor3='+Vendor3+'&Vendor4='+Vendor4+'&Vendor5='+Vendor5+'&Vendor6='+Vendor6;
	HttpText+='&Date1='+Date1+'&Date2='+Date2+'&Date3='+Date3+'&Date4='+Date4+'&Date5='+Date5+'&Date6='+Date6;

	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnSaveExistingPart;
	xmlHttp.open('Get',HttpText,true);
	xmlHttp.send(null);
}


function ReturnSaveExistingPart()
{
	if(xmlHttp.readyState==4)
	{
		if(xmlHttp.status==200)
		{
			var xmlDoc=xmlHttp.responseXML.documentElement;
			SearchParts(gSearchName,gSearchTxt);
			HidePartEditModal();
			DebugBox(xmlDoc.getElementsByTagName('SQL')[0].childNodes[0].nodeValue);
		}
		else{AjaxErr('Problem related to AJAX function: SaveExistingPart :(',HttpText);}
	}
}
//-------------------------------------------------------------------------------------------------








//Savesanewpart////////////////////////////////////////////////

function SaveNewPart()
{
		
		var Manufacturer=Gebi('Manufacturer')[Gebi('Manufacturer').selectedIndex].value;
		var Model=Gebi('Model').value;
		var PartNumber=Gebi('PartNumber').value;
		var Description=Gebi('Description').value;
		var LaborValue=Gebi('LaborValue').value;
		var System=Gebi('System')[Gebi('System').selectedIndex].value;
		var Category1=Gebi('Category1')[Gebi('Category1').selectedIndex].value;
		var Category2=Gebi('Category2')[Gebi('Category2').selectedIndex].value;
		var Cost=Gebi('Cost').value;
		var Cost1=Gebi('Cost1').value;
		var Cost2=Gebi('Cost2').value;
		var Cost3=Gebi('Cost3').value;
		var Cost4=Gebi('Cost4').value;
		var Cost5=Gebi('Cost5').value;
		var Cost6=Gebi('Cost6').value;
		var Vendor1=Gebi('Vendor1')[Gebi('Vendor1').selectedIndex].value;
		var Vendor2=Gebi('Vendor2')[Gebi('Vendor2').selectedIndex].value;
		var Vendor3=Gebi('Vendor3')[Gebi('Vendor3').selectedIndex].value;
		var Vendor4=Gebi('Vendor4')[Gebi('Vendor4').selectedIndex].value;
		var Vendor5=Gebi('Vendor5')[Gebi('Vendor5').selectedIndex].value;
		var Vendor6=Gebi('Vendor6')[Gebi('Vendor6').selectedIndex].value;
		var Date1=Gebi('Date1').value;
		var Date2=Gebi('Date2').value;
		var Date3=Gebi('Date3').value;
		var Date4=Gebi('Date4').value;
		var Date5=Gebi('Date5').value;
		var Date6=Gebi('Date6').value;
		
		
		
		if(Manufacturer==''){alert('PleaseFillouttheManufacturerBox');return false;}
		if(Model==''){alert('PleaseFillouttheModelBox');return false;}
		if(PartNumber==''){alert('PleaseFilloutthePartNumberBox');return false;}
		if(Description==''){alert('PleaseFillouttheDescriptionBox');return false;}
		if(Cost==''){alert('PleaseFillouttheBidCostBox');return false;}
		if(LaborValue==''){alert('PleaseFillouttheLaborHrBox');return false;}
		if(System==''){alert('PleaseFillouttheSystemBox');return false;}
		if(Category1==''){alert('PleaseFillouttheCategory1Box');return false;}
		if(Vendor1==''){alert('PleaseFillouttheVendor1Box');return false;}
		if(Cost1==''){alert('PleaseFillouttheCost1Box');return false;}
		if(Date1==''){alert('PleaseFillouttheDate1Box');return false;}
		
		
		
		//alert('Hi');
var HttpText='';
	
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnSaveNewPart;
	HttpText=HttpText+('DataEntryASP.asp?action=SaveNewPart&Manufacturer='+Manufacturer+'&Model='+Model);
	HttpText=HttpText+('&PartNumber='+PartNumber+'&Description='+Description+'&LaborValue='+LaborValue+'&Cost='+Cost+'&System='+System);
	HttpText=HttpText+('&Category1='+Category1+'&Category2='+Category2+'&Cost1='+Cost1+'&Cost2='+Cost2);
	HttpText=HttpText+('&Cost3='+Cost3+'&Cost4='+Cost4+'&Cost5='+Cost5+'&Cost6='+Cost6);
	HttpText=HttpText+('&Vendor1='+Vendor1+'&Vendor2='+Vendor2+'&Vendor3='+Vendor3+'&Vendor4='+Vendor4+'&Vendor5='+Vendor5+'&Vendor6='+Vendor6);
	HttpText=HttpText+('&Date1='+Date1+'&Date2='+Date2+'&Date3='+Date3+'&Date4='+Date4+'&Date5='+Date5+'&Date6='+Date6);
	xmlHttp.open('Get',HttpText,true);
	xmlHttp.send(null);
	
}


function ReturnSaveNewPart()
{

	
if(xmlHttp.readyState==4)
	{
		
		if(xmlHttp.status==200)
	{
			
		var xmlDoc=xmlHttp.responseXML.documentElement;
			var Part=xmlDoc.getElementsByTagName("Part")[0].childNodes[0].nodeValue;
			
			Gebi('AddPartBoxScroll').innerHTML+=Part;
			
			HidePartEditModal();
}
		else
		{
alert('Problem related to AJAX function:  :(');
}
}
	
}
//-------------------------------------------------------------------------------------------------












//Deletesapart////////////////////////////////////////////////

function DeletePart(PartID)
{
	var answer=confirm('Delete this Part?');
	
if(answer)
	{
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnDeletePart;
	xmlHttp.open('Get','DataEntryASP.asp?action=DeletePart&PartID='+PartID,true);
	xmlHttp.send(null);
	}
	else
	{
		return;
	}
}


function ReturnDeletePart()
{

	
if(xmlHttp.readyState==4)
	{
		
		if(xmlHttp.status==200)
	{
			
			SearchParts(gSearchName,gSearchTxt);	
			
}
		else
		{
alert('Problem related to AJAX function:  :(');
}
}
	
}
//-------------------------------------------------------------------------------------------------







//////////////////////////////////////////////////

function BidPresetNew()
{
	var PresetName=Gebi('PresetNameTxtNew').value;
	var SystemType=Gebi('SystemTypesNew')[Gebi('SystemTypesNew').selectedIndex].value;
	
	var Obj=Gebi('SystemTypesNew');
	var SystemTypeText=(Obj[Obj.selectedIndex].text);
	
	if(PresetName==''){alert('Please Enter a Preset Name.');return false;}
	if(SystemType==''){alert('Please Select a System Type.');return false;}
	
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnBidPresetNew;
	xmlHttp.open('Get','DataEntryASP.asp?action=BidPresetNew&PresetName='+PresetName+'&SystemType='+SystemType+'&SystemTypeText='+SystemTypeText,true);
	xmlHttp.send(null);
}

function ReturnBidPresetNew()
{
	if(xmlHttp.readyState==4)
	{
		if(xmlHttp.status==200)
		{
			var xmlDoc=xmlHttp.responseXML.documentElement;
			var BidPresetID=xmlDoc.getElementsByTagName("BidPresetID")[0].childNodes[0].nodeValue;
			var PresetName=xmlDoc.getElementsByTagName("PresetName")[0].childNodes[0].nodeValue;
			var SystemType=xmlDoc.getElementsByTagName("SystemType")[0].childNodes[0].nodeValue;
			
			Gebi('BidPresetID').innerHTML=BidPresetID;
			Gebi('PresetNameTxt').value=PresetName;
			Gebi('SystemTypes')[Gebi('SystemTypes').selectedIndex].value=SystemType;
			
			Gebi('BidPresetModal').style.display='none';
			Gebi('BidPresetNewBox').style.display='none';
			Gebi('BidPresetLBottom').style.display='block';
			Gebi('BidPresetLTop').style.display='block';
			
			Gebi('BidPresetPartsList').innerHTML='PleaseAddParts';
			
			BidPresetList();
			
			alert('Whoa Dude');
			
			ShowPresetText();
			setTimeout('ShowPresetParts();',150);
		}
		else
		{
			AjaxErr('Problem related to AJAX function:  :(',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------







//////////////////////////////////////////////////

function BidPresetList()
{
	
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnBidPresetList;
	xmlHttp.open('Get','DataEntryASP.asp?action=BidPresetList',true);
	xmlHttp.send(null);
	
	

}


function ReturnBidPresetList()
{

	
if(xmlHttp.readyState==4)
	{
		
		if(xmlHttp.status==200)
	{
		
			var xmlDoc=xmlHttp.responseXML.documentElement;
			var BidPresetList=xmlDoc.getElementsByTagName("BidPresetList")[0].childNodes[0].nodeValue;
			
			//alert(BidPresetList);
			Gebi('BidPresetRList').innerHTML=BidPresetList;
		
			
}
		else
		{
alert('Problem related to AJAX function:  :(');
}
}
	
}
//-------------------------------------------------------------------------------------------------










//////////////////////////////////////////////////

function BidPresetEdit(BidPresetID)
{
	
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnBidPresetEdit;
	xmlHttp.open('Get','DataEntryASP.asp?action=BidPresetEdit&BidPresetID='+BidPresetID,true);
	xmlHttp.send(null);
	
	

}


function ReturnBidPresetEdit() {
	if(xmlHttp.readyState==4) {
		
		if(xmlHttp.status==200)
	{
		
			var xmlDoc=xmlHttp.responseXML.documentElement;
			var BidPresetName=xmlDoc.getElementsByTagName("BidPresetName")[0].childNodes[0].nodeValue;
			var SystemType=xmlDoc.getElementsByTagName("BidPresetSystemID")[0].childNodes[0].nodeValue;
			var BidPresetID=xmlDoc.getElementsByTagName("BidPresetID")[0].childNodes[0].nodeValue;
			var PartsList=xmlDoc.getElementsByTagName("PartsList")[0].childNodes[0].nodeValue;
			var LaborList=xmlDoc.getElementsByTagName("LaborList")[0].childNodes[0].nodeValue;
			var Scope=xmlDoc.getElementsByTagName("Scope")[0].childNodes[0].nodeValue;
			var Includes=xmlDoc.getElementsByTagName("Includes")[0].childNodes[0].nodeValue;
			var Excludes=xmlDoc.getElementsByTagName("Excludes")[0].childNodes[0].nodeValue;
			
			if(Scope=='--'){Scope='';}
			if(Includes=='--'){Includes='';}
			if(Excludes=='--'){Excludes='';}
			
			Scope=Scope.replace(/--RET--/g,'\n');
			Includes=Includes.replace(/--RET--/g,'\n');
			Excludes=Excludes.replace(/--RET--/g,'\n');
			
			//alert(Scope);
			
			Gebi('PresetNameTxt').value=BidPresetName;
			//SelI('SystemTypes').value=SystemType;
			Gebi('BidPresetID').innerHTML=BidPresetID;
			Gebi('BidPresetLHeader').innerHTML=BidPresetName;
			Gebi('ScopeText').value=Scope;
			Gebi('IncludesText').value=Includes;
			Gebi('ExcludesText').value=Excludes;
			
			Gebi('BidPresetPartsList').innerHTML=PartsList;
			Gebi('BidPresetLaborList').innerHTML=LaborList;
		
			Gebi('BidPresetLBottom').style.display='block';
			Gebi('BidPresetLTop').style.display='block';
}
		else
		{
alert('Problem related to AJAX function:  :(');
}
}
	
}
//-------------------------------------------------------------------------------------------------









//Pullsalistofpartsbasedonthesearchtext////////////////////////////////////////////////

function SearchPresetParts(SearchName)
{
	
	var SearchTxt=Gebi("PresetSearchPartsTx1t").value;

	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnSearchPresetParts;
	xmlHttp.open('Get','DataEntryASP.asp?action=PresetSearchParts&SearchTxt='+SearchTxt+'&SearchName='+SearchName,true);
	xmlHttp.send(null);
	
}


function ReturnSearchPresetParts()
{

	
if(xmlHttp.readyState==4)
	{
		
		if(xmlHttp.status==200)
	{
			
		var xmlDoc=xmlHttp.responseXML.documentElement;
			var Parts=xmlDoc.getElementsByTagName("Parts")[0].childNodes[0].nodeValue;
			
			Gebi('PresetNewPartsList').innerHTML=Parts;
			
			//alert(Parts);
}
		else
		{
alert('Problem related to AJAX function:  :(');
}
}
	
}
//-------------------------------------------------------------------------------------------------







//AddspartstothePreset////////////////////////////////////////////////

function PresetAddItem(ItemID,Type)
{
	var PresetID=Gebi("BidPresetID").innerHTML;
		
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnPresetAddItem;
	xmlHttp.open('Get','DataEntryASP.asp?action=PresetAddItem&ItemID='+ItemID+'&PresetID='+PresetID+'&Type='+Type,true);
	xmlHttp.send(null);
	
}


function ReturnPresetAddItem()
{

	
if(xmlHttp.readyState==4)
	{
		
		if(xmlHttp.status==200)
	{
			
		var xmlDoc=xmlHttp.responseXML.documentElement;
			var PresetID=xmlDoc.getElementsByTagName("PresetID")[0].childNodes[0].nodeValue;
			
			BidPresetEdit(PresetID);
			
			//alert(PresetID+''+PartID);
			
}
		else
		{
alert('Problem related to AJAX function:  :(');
}
}
	
}
//-------------------------------------------------------------------------------------------------













//DeletesaBidPreset////////////////////////////////////////////////

function BidPresetDelete(PresetID)
{
	
	var answer=confirm('Delete this Preset?');
	
if(answer)
	{
	
		var answer=confirm('Really delete the entire preset? This cannot be undone.');
		
		if(answer)
		{	
	
		xmlHttp=GetXmlHttpObject();
		xmlHttp.onreadystatechange=ReturnBidPresetDelete;
		xmlHttp.open('Get','DataEntryASP.asp?action=BidPresetDelete&PresetID='+PresetID,true);
		xmlHttp.send(null);
	
		}
		else
		{
			return;
		}	
	
	}
	else
	{
		return;
	}
}


function ReturnBidPresetDelete()
{

	
if(xmlHttp.readyState==4)
	{
		
		if(xmlHttp.status==200)
	{
						
			BidPresetList();	
			
}
		else
		{
alert('Problem related to AJAX function:  :(');
}
}
	
}
//-------------------------------------------------------------------------------------------------













//Deletesapart////////////////////////////////////////////////

function PresetDeletePart(PartID)
{
	var PresetID=Gebi("BidPresetID").innerHTML;
	
	var answer=confirm('Delete this Part?');
	
if(answer)
	{
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnPresetDeletePart;
	xmlHttp.open('Get','DataEntryASP.asp?action=PresetDeletePart&PartID='+PartID+'&PresetID='+PresetID,true);
	xmlHttp.send(null);
	}
	else
	{
		return;
	}
}


function ReturnPresetDeletePart()
{

	
if(xmlHttp.readyState==4)
	{
		
		if(xmlHttp.status==200)
	{
			var xmlDoc=xmlHttp.responseXML.documentElement;
			var PresetID=xmlDoc.getElementsByTagName("PresetID")[0].childNodes[0].nodeValue;
			
			BidPresetEdit(PresetID);	
			
}
		else
		{
alert('Problem related to AJAX function:  :(');
}
}
	
}
//-------------------------------------------------------------------------------------------------









//PullsalistofLabor////////////////////////////////////////////////

function PresetSearchLabor()
{
	
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=ReturnPresetSearchLabor;
	xmlHttp.open('Get','DataEntryASP.asp?action=PresetSearchLabor',true);
	xmlHttp.send(null);
	
}


function ReturnPresetSearchLabor()
{

	
if(xmlHttp.readyState==4)
	{
		
		if(xmlHttp.status==200)
	{
			
		var xmlDoc=xmlHttp.responseXML.documentElement;
			var Labor=xmlDoc.getElementsByTagName("Labor")[0].childNodes[0].nodeValue;
			
			Gebi('PresetNewLaborList').innerHTML=Labor;
			
			//alert(Parts);
}
		else
		{
alert('Problem related to AJAX function:  :(');
}
}
	
}
//-------------------------------------------------------------------------------------------------
