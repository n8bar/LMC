// JavaScript Document   AJAX CONTROLS

var CheckArray = "";

var xhr;
var HttpText;
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXmlHttpObject(){
	var xmlHttp=null;
	try { // Firefox, Opera 8.0+, Safari
		xmlHttp=new XMLHttpRequest();
	}
	catch (e) { // Internet Explorer
		try {
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e) {
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
	if (xmlHttp==null) {
		alert ("Your browser does not support AJAX!");
		return;
	}
	
	return xmlHttp;
}
//------------------------------------------------------------------------------------------------

function Search() {
	Gebi('Modal').style.display='block';
	Gebi('mSwirl').style.display='block';
	Gebi('mStatus').style.display='block';
	Gebi('mStatus').innerHTML='Searching';
	var Mfg=SelI('sMfg').textContent;
	var PN=Gebi('sName').value;
	var Desc=Gebi('sDesc').value;
	var Max=parseFloat(Gebi('sMax').value);
	var Min=parseFloat(Gebi('sMin').value);
	var Sys=SelI('sSystem').textContent;
	var Cat=SelI('sCategory').textContent;
	var Vendor=SelI('sVendor').textContent;
	var and=Gebi('sAll').checked;
	
	var Order=document.getElementsByClassName('hColSort')[0].id;
	
	HttpText='MaterialsASP.asp?action=Search&Mfg='+Mfg+'&Name='+PN+'&Desc='+Desc+'&Max='+Max+'&Min='+Min+'&System='+Sys+'&Category='+Cat+'&Vendor='+Vendor+'&and='+and+'&Order='+Order;
	//DebugBox('<a href="../../TMCDevelopment/'+HttpText+'">SearchXML</a>');
	xhr=GetXmlHttpObject();
	xhr.onreadystatechange = function () {
		Gebi('mStatus').innerHTML+='.';
		if (xhr.readyState == 4) {
			Gebi('mStatus').innerHTML+='...';
			if (xhr.status == 200) {
				Gebi('mStatus').innerHTML='Loading search results...';
				
				//AjaxErr('There is an error in the Search response.',HttpText);
				
				try { var xmlDoc=xhr.responseXML.documentElement; }
				catch(e) { 
					AjaxErr('There is an error in the Search response.',HttpText);
					return false;
				}
				
				var rMax=(xmlDoc.getElementsByTagName('recordMax')[0].childNodes[0].nodeValue*1);
				var results=xmlDoc.getElementsByTagName('recordCount')[0].childNodes[0].nodeValue;
				Gebi('mStatus').innerHTML=results+' matches found.';
				
				//var w=Gebi('ListHead').offsetWidth;
				//w=(w/Gebi('LItemsContainer').offsetWidth)*100;
				
				Gebi('LItemsContainer').innerHTML='<div class=row id=emptyRow style="border:none; height:1px;"></div>';
				
				if(results>0) { 
					Gebi('mStatus').innerHTML='Loading '+results+' matches. Please Wait.';
					for(r=1;r<=results;r++) {
						Gebi('mStatus').innerHTML='Loaded '+r+' of '+results+' matches.';
						var PartsID=xmlDoc.getElementsByTagName('PartsID'+r)[0].childNodes[0].nodeValue;
						var pName=CharsDecode(xmlDoc.getElementsByTagName('Model'+r)[0].childNodes[0].nodeValue.replace('--',''));
						var PN=CharsDecode(xmlDoc.getElementsByTagName('PartNumber'+r)[0].childNodes[0].nodeValue.replace('--',''));
						var Qty=(xmlDoc.getElementsByTagName('Qty'+r)[0].childNodes[0].nodeValue*1);
						var Level=(xmlDoc.getElementsByTagName('Level'+r)[0].childNodes[0].nodeValue*1);
						var Labor=(xmlDoc.getElementsByTagName('Labor'+r)[0].childNodes[0].nodeValue*1);
						var Cost=xmlDoc.getElementsByTagName('Cost'+r)[0].childNodes[0].nodeValue;
						var Mfr=CharsDecode(xmlDoc.getElementsByTagName('Manufacturer'+r)[0].childNodes[0].nodeValue.replace('--',''));
						var System=xmlDoc.getElementsByTagName('System'+r)[0].childNodes[0].nodeValue.replace('--','');
						var Category1=xmlDoc.getElementsByTagName('Category1-'+r)[0].childNodes[0].nodeValue.replace('--','');
						var Category2=xmlDoc.getElementsByTagName('Category2-'+r)[0].childNodes[0].nodeValue.replace('--','');
						/*
						var Vendor1=CharsDecode(xmlDoc.getElementsByTagName('Vendor1-'+r)[0].childNodes[0].nodeValue.replace('--',''));
						var Vendor2=CharsDecode(xmlDoc.getElementsByTagName('Vendor2-'+r)[0].childNodes[0].nodeValue.replace('--',''));
						var Vendor3=CharsDecode(xmlDoc.getElementsByTagName('Vendor3-'+r)[0].childNodes[0].nodeValue.replace('--',''));
						var Cost1=xmlDoc.getElementsByTagName('Cost1-'+r)[0].childNodes[0].nodeValue;
						var Cost2=xmlDoc.getElementsByTagName('Cost2-'+r)[0].childNodes[0].nodeValue;
						var Cost3=xmlDoc.getElementsByTagName('Cost3-'+r)[0].childNodes[0].nodeValue;
						var Date1=xmlDoc.getElementsByTagName('Date1-'+r)[0].childNodes[0].nodeValue.replace('--','');
						var Date2=xmlDoc.getElementsByTagName('Date2-'+r)[0].childNodes[0].nodeValue.replace('--','');
						var Date3=xmlDoc.getElementsByTagName('Date3-'+r)[0].childNodes[0].nodeValue.replace('--','');
						*/
						var Description=CharsDecode(xmlDoc.getElementsByTagName('Description'+r)[0].childNodes[0].nodeValue.replace('--',''));
						
						var style=''//style="width:'+w+'%;"';
						var keypress='onkeypress="ifEnter(event,\'sRow('+r+'); Gebi(\\\'btnSearch\\\').focus();\');"';
						var dC='onDblClick="dataClick(this,'+r+');"';
						var row='<div id=row'+r+' class=row '+style+'>';
						row+='	<input type=hidden id=PartsIDRow-'+PartsID+' value="'+r+'" />';
						row+='	<div id=edit-'+r+' class="editBtn" style="height:24px; text-align:center;" onclick="eRow('+r+');" > </div>';
						row+='	<div id=open-'+r+' class="openBtn" style="height:24px; text-align:center;" onclick="oRow('+r+');" > </div>';
						row+='	<div id=del-'+r+' class="delBtn" style="height:24px; text-align:center;" onclick="delPart('+PartsID+');" > </div>';
						row+='	<div id=PartsID-'+r+' class="pIdW taC h24" >'+PartsID+'</div>';
						row+='	<div id=Model-'+r+' class="modelW taL h24" >'+pName+'</div>';
						row+='	<div id=PartNumber-'+r+' class="PNW taL h24" title="'+PN+'" >'+PN+'</div>';
						row+='	<div id=Qty-'+r+' class="qtyW taRPi h24" '+dC+' '+keypress+'>'+Qty+'</div>';
						row+='	<div id=Cost-'+r+' class="costW taRPi h24" contentEditable=false >'+formatCurrency(Cost)+'</div>';
						row+='	<div id=Mfr-'+r+' class="mfrW taL h24" >'+Mfr+'</div>';
						row+='	<div id=System-'+r+' class="systemW taL h24" >'+System+'</div>';
						row+='	<div id=Category-'+r+' class="categoryW taL h24" >'+Category1+'</div>';
						row+='	<div id=DescT-'+r+' class="descriptionL taR h24" title="'+Description.replace('"','\"')+'" >Description:</div>';
						row+='	<div id=Desc-'+r+' class="descriptionW taL h24" title="'+Description.replace('"','\"')+'" >'+Description+'	</div>';
						//row+='	<div id=DescT-'+r+' class="descH taR h24" title="'+Description.replace('"','\"')+'" >Description</div>'
						//row+='	<div id=Description-'+r+' class="descW taL h24" title="'+Description.replace('"','\"')+'" >'+Description+'	</div>';
						row+='</div>';
						Gebi('LItemsContainer').innerHTML+=row;
					}
					Gebi('LItemsContainer').innerHTML+='<div id=lastRow class=row>'+(r-1)+' matches found</div>';
				}
				else {
					Gebi('LItemsContainer').innerHTML+='<div class=row>No Matches.</div>'; 
				}
				
				if(results>=rMax) { 
					if(!!Gebi('lastRow')) Gebi('lastRow').innerHTML+='<br/>The maximum of '+rMax+' matches has been reached.  Please refine your search.'; 
				}
				
				Resize();
				
				Gebi('Modal').style.display='none';
			}
			else {
				AjaxErr('There was an error in the Search request', HttpText);
			}
		}
	}
	xhr.open('Get',HttpText,true);
	xhr.send(null);
}

function openPart(pId) {
	Gebi('PartFrame').src='Part.asp?pid='+pId;
	Gebi('PartFrame').style.display='block';
	Gebi('frameX').style.display='block';
	/*
	HttpText='MaterialsASP.asp?action=openPart&pID='+pId;
	xhr = GetXmlHttpObject();
	xhr.onreadystatechange = ReturnDelPart;
	xhr.open('Get',HttpText, true);
	xhr.send(null);
	
	function ReturnDelPart ()	{
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				try { var xmlDoc=xhr.responseXML.documentElement; }
				catch(e) { 
					AjaxErr('There is an error in the openPart response.',HttpText);
					return false;
				}

				var Mfr=CharsDecode(xmlDoc.getElementsByTagName('Manufacturer')[0].childNodes[0].nodeValue.replace('--',''));
				var pName=CharsDecode(xmlDoc.getElementsByTagName('Model')[0].childNodes[0].nodeValue.replace('--',''));
				var PN=CharsDecode(xmlDoc.getElementsByTagName('PartNumber')[0].childNodes[0].nodeValue.replace('--',''));
				var Labor=(xmlDoc.getElementsByTagName('LaborValue')[0].childNodes[0].nodeValue*1);
				var Cost=xmlDoc.getElementsByTagName('Cost')[0].childNodes[0].nodeValue;
				var System=xmlDoc.getElementsByTagName('System')[0].childNodes[0].nodeValue.replace('--','');
				var Category1=xmlDoc.getElementsByTagName('Category1')[0].childNodes[0].nodeValue.replace('--','');
				var Category2=xmlDoc.getElementsByTagName('Category2')[0].childNodes[0].nodeValue.replace('--','');
				var Vendor1=CharsDecode(xmlDoc.getElementsByTagName('Vendor1')[0].childNodes[0].nodeValue.replace('--',''));
				var Vendor2=CharsDecode(xmlDoc.getElementsByTagName('Vendor2')[0].childNodes[0].nodeValue.replace('--',''));
				var Vendor3=CharsDecode(xmlDoc.getElementsByTagName('Vendor3')[0].childNodes[0].nodeValue.replace('--',''));
				var Cost1=xmlDoc.getElementsByTagName('Cost1')[0].childNodes[0].nodeValue;
				var Cost2=xmlDoc.getElementsByTagName('Cost2')[0].childNodes[0].nodeValue;
				var Cost3=xmlDoc.getElementsByTagName('Cost3')[0].childNodes[0].nodeValue;
				var Date1=xmlDoc.getElementsByTagName('Date1')[0].childNodes[0].nodeValue.replace('--','');
				var Date2=xmlDoc.getElementsByTagName('Date2')[0].childNodes[0].nodeValue.replace('--','');
				var Date3=xmlDoc.getElementsByTagName('Date3')[0].childNodes[0].nodeValue.replace('--','');
				var Description=CharsDecode(xmlDoc.getElementsByTagName('Description')[0].childNodes[0].nodeValue.replace('--',''));

				showNewPart();
				Gebi('npTitleName').innerHTML='PartID# '+pId;
				
				var matchedMfr=false;
				var opts=Gebi('npMfg').getElementsByTagName('option');
				for(var m=0; m<opts.length; m++) {
					if (opts[m].innerHTML.toLowerCase()==Mfr.toLowerCase()) {
						//alert(opts[m].innerHTML+'='+Mfr+'\nI:'+m);
						Gebi('npMfg').selectedIndex=m;
						opts[m].setAttribute('selected','true');
						matchedMfr=true;
						//alert('m='+Gebi('npMfg').selectedIndex);
						//break;
					}
				}
				if (!matchedMfr) {
					if (Gebi('npMfg')[0].innerHTML.indexOf('Please')>=0) { Gebi('npMfg').removeChild(Gebi('npMfg')[0]);}
					Gebi('npMfg').innerHTML='<option selected>'+Mfr+'</option>'+Gebi('npMfg').innerHTML;
				}
				
				Gebi('npPartName').value=pName;
				Gebi('npPN').value=PN;
				
				
			}
			else {
				AjaxErr('There was a problem with the openPart request.',HttpText);
			}
		}
	}
	*/
}


function delPart(PartId)	{
	
	if(!confirm('Are you sure to delete this part? \nThis cannot be undone!')) return false;
	
	HttpText='MaterialsASP.asp?action=delPart&PartId='+PartId;
	xhr = GetXmlHttpObject();
	xhr.onreadystatechange = ReturnDelPart;
	xhr.open('Get',HttpText, false);
	xhr.send(null);
	
	function ReturnDelPart ()	{
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				//AjaxErr('What\'s happening? with the DelPart request.',HttpText);
				try { var row=Gebi('row'+Gebi('PartsIDRow-'+PartId).value) }
				catch(e) { alert('Error: Part ID# '+PartId+' not found in list.'); return false; }
				row.parentNode.removeChild(row);
			}
			else {
				AjaxErr('There was a problem with the DelPart request.',HttpText);
			}
		}
	}
}

function saveNM(name) {
	if( name==null || name=='' || !name) { return false; }
	HttpText='MaterialsASP.asp?action=newMfg&name='+CharsEncode(name);
	
	xhr = GetXmlHttpObject();
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				//AjaxErr('What\'s happening? with the saveNM request.',HttpText);
				var xmlDoc=xhr.responseXML.documentElement;

				var ID=xmlDoc.getElementsByTagName('ID')[0].childNodes[0].nodeValue*1;
				
				Gebi('sMfg').innerHTML+='<option value='+ID+'>'+name+'</option>';
				Gebi('npMfg').innerHTML='<option value='+ID+'>'+name+'</option>'+Gebi('npMfg').innerHTML;
				hideNM();
			}
			else {
				AjaxErr('There was a problem with the saveNM request.',HttpText);
			}
		}
	}
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}

