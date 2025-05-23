// JavaScript Document   AJAX CONTROLS

var xhr
var HttpText ='';
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function getXHRObject(){
	var xhr=false;
	try { xhr=new XMLHttpRequest(); /* Firefox, Opera 8.0+, Safari */	}
	catch (e) {									 	 // Internet Explorer
		try { xhr=new ActiveXObject("Msxml2.XMLHTTP"); }
		catch (e) { xhr=new ActiveXObject("Microsoft.XMLHTTP"); }
	}
	if (!xhr) alert ("Your browser does not support AJAX!");
	return xhr;
}
//------------------------------------------------------------------------------------------------

function LoadPreset(PresetID,secID) {
	HttpText='BidASP.asp?action=LoadPreset&PresetID='+PresetID+'&secId='+secId;
	xhr=getXHRObject();
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4) {
			if(xhr.status==200) {
				try { var xmlDoc = xhr.responseXML.documentElement }
				catch(e) { AjaxErr(' There was a problem with the LoadPreset response.', HttpText) }
				
				window.location=window.location;
			}
			else {
				AjaxErr('There was a problem with the LoadPreset request.', HttpText);
				return false;
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}

function copyBid() {
	var secType=SelI('cwSecType').innerHTML;
	if (secType==''||secType==' ') {
		alert('Please choose a Preset Section.');
		return false;
	}
	var secTypeId=SelI('cwSecType').value;
	var presetName=Gebi('cwPresetName').value;
	var copyQty='1';
	if (Gebi('cwQtyChk').checked) copyQty='0';
	HttpText='BidASP.asp?action=copyBid&secId='+secId+'&SecType='+secType+'&secTypeId='+secTypeId+'&Preset='+presetName+'&copyQty='+copyQty;
	xhr=getXHRObject();
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4) {
			if(xhr.status==200) {
				try { var xmlDoc = xhr.responseXML.documentElement }
				catch(e) { 
					AjaxErr(' There was a problem with the copyBid response.', HttpText); 
				}
				
				try { 
					//AjaxErr(' There is testin\' happenin\' with the copyBid response.', HttpText);
					var newPId=parseInt(xmlDoc.getElementsByTagName('newPId')[0].childNodes[0].nodeValue);
					
					if(confirm('Preset copied.  Do you want to open it?')) window.location='BidPresets.asp?id='+newPId;
				}
				catch(e) { 
					AjaxErr(' There was a problem with the copyBid response data.\n'+e.description+'\n', HttpText); 
				}
			}
			else {
				AjaxErr('There was a problem with the copyBid request.', HttpText);
				return false;
			}
			hide('copyModal');
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}

function dupBid() {
	var secName=Gebi('dwSecName').value;
	var move='1';
	if (Gebi('dwMoveChk').checked) move='0';
	HttpText='BidASP.asp?action=dupBid&secId='+secId+'&ProjID='+projId+'&secName='+secName+'&move='+move;
	xhr=getXHRObject();
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4) {
			if(xhr.status==200) {
				try { var xmlDoc = xhr.responseXML.documentElement }
				catch(e) { 
					AjaxErr(' There was a problem with the copyBid response.', HttpText); 
				}
				
				try { 
					//AjaxErr(' There is testin\' happenin\' with the copyBid response.', HttpText);
					var newPId=parseInt(xmlDoc.getElementsByTagName('newPId')[0].childNodes[0].nodeValue);
					alert('Transfer Complete.')
				}
				catch(e) { 
					AjaxErr(' There was a problem with the delBid response data.\n'+e.description+'\n', HttpText); 
				}
			}
			else {
				AjaxErr('There was a problem with the dupBid request.', HttpText);
				return false;
			}
			hide('dupModal');
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}

function sectionCost(secId) {
	HttpText='BidASP.asp?action=sectionCost&secId='+secId;
	xhr=getXHRObject(); 
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4) {
			if(xhr.status==200) {
				try { var xmlDoc = xhr.responseXML.documentElement }
				catch(e) { AjaxErr(' There was a problem with the sectionCost response.', HttpText) }
				//AjaxErr(' There wasn\'t a problem with the sectionCost response.', HttpText)
				//try { 
					var useNewBidder=xmlDoc.getElementsByTagName('useNewBidder')[0].childNodes[0].nodeValue;
					if (useNewBidder=='True') useNewBidder=true;  else useNewBidder=false;
					var roundUp=xmlDoc.getElementsByTagName('roundUp')[0].childNodes[0].nodeValue.replace('--','');
					if (roundUp=='True' && useNewBidder ) roundUp=true;  else roundUp=false;
					var totalFixed=xmlDoc.getElementsByTagName('totalFixed')[0].childNodes[0].nodeValue.replace('--','');
					if (totalFixed=='True') totalFixed=true;  else totalFixed=false;
					
					var MU=parseFloat(xmlDoc.getElementsByTagName('MU')[0].childNodes[0].nodeValue);
					var taxRate=parseFloat(xmlDoc.getElementsByTagName('taxRate')[0].childNodes[0].nodeValue)*.01;
					var overheadRate=parseFloat(xmlDoc.getElementsByTagName('overhead')[0].childNodes[0].nodeValue)*.01;
					
					var parts=parseFloat(xmlDoc.getElementsByTagName('parts')[0].childNodes[0].nodeValue);
					var labor=parseFloat(xmlDoc.getElementsByTagName('labor')[0].childNodes[0].nodeValue);
					var travel=parseFloat(xmlDoc.getElementsByTagName('travel')[0].childNodes[0].nodeValue);
					var equip=parseFloat(xmlDoc.getElementsByTagName('equip')[0].childNodes[0].nodeValue);
					var other=parseFloat(xmlDoc.getElementsByTagName('other')[0].childNodes[0].nodeValue);
					
					var fixedTotal=parseFloat(xmlDoc.getElementsByTagName('fixedTotal')[0].childNodes[0].nodeValue);
				//}
				//catch(e) { AjaxErr(' There was a problem with the sectionCost response data.', HttpText) }
				
				var expenses=travel+equip+other; 
				
				var M=(MU/100)+1;
				
				Gebi('TotalTravel').innerHTML=formatCurrency(travel);
				Gebi('TotalEquip').innerHTML=formatCurrency(equip);
				Gebi('TotalOther').innerHTML=formatCurrency(other);
				Gebi('ExpTotal').innerHTML=formatCurrency(expenses);

				if(useNewBidder)	{
					Gebi('TotalParts').innerHTML=formatCurrency(parts);
					Gebi('TotalLabor').innerHTML=formatCurrency(labor);
					if(totalFixed) { //Fixed Total 2010 Formula
						var secTotal = fixedTotal;
						var overhead=overheadRate*(parts+labor+expenses);
						var PLO=parts+labor+overhead;
						var M=secTotal/(PLO+(parts*taxRate)+expenses);
						var tax=parts*taxRate;
						var profit=secTotal-PLO-expenses-tax;
						MU=Math.round((M-1)*100000)/1000;
					}
					else { //Fixed Margin 2010 Formula
						var overhead=overheadRate*(parts+labor+expenses);
						var PLO=parts+labor+overhead; var M=1+(MU/100);
						var secTotal=(PLO*M)+(parts*taxRate)+expenses;
						var tax=parts*taxRate;
						
						if(roundUp) {
							var oldTot=secTotal;
							secTotal=Math.round(secTotal/10)*10;
							if(oldTot>secTotal) {secTotal+=10}
						}
						
						var profit=secTotal-PLO-expenses-tax;
						fixedTotal=secTotal;
					}
					
					var partsSell=parts*((MU/100)+1);
					var laborSell=labor*((MU/100)+1);
					
					Gebi('FixedPrice').innerHTML=currencyLink+(formatCurrency(fixedTotal));
					WSQLU('Sections','FixedPrice',fixedTotal,'SectionID',secId);
					Gebi('MU').innerHTML=editLink+(MU);
					WSQLU('Sections','MU',MU,'SectionID',secId);
					
					
					Gebi('SectionTotal').innerHTML=formatCurrency(secTotal);
	
					function p(number) {
						var p=Math.round((number/secTotal)*10000)/100;
						if(isNaN(p)) p=0;
						return p;
					}
					
				}
				else { // Old Formula
					Gebi('TotalParts').innerHTML=formatCurrency(parts*M);
					Gebi('TotalLabor').innerHTML=formatCurrency(labor*M);
					if(totalFixed) { //Fixed Total Old Formula
						var secTotal = fixedTotal;
						var overhead=overheadRate*(parts+labor+expenses);
						var PL=parts+labor; var EO=expenses+overhead;
						var M=secTotal/(PL+(parts*taxRate)+EO);
						var tax=(parts*M)*taxRate;
						var profit=secTotal-PL-EO-tax;
						MU=Math.round((M-1)*100000)/1000;
					}
					else { //Fixed Margin Old Formula
						var overhead=overheadRate*(parts+labor+expenses);
						var PL=parts+labor; var EO=expenses+overhead; var M=1+(MU/100);
						var secTotal=(PL*M)+((parts*M)*taxRate)+EO;
						var tax=(parts*M)*taxRate;
						
						if(roundUp) {
							var oldTot=secTotal;
							secTotal=Math.round(secTotal/10)*10;
							if(oldTot>secTotal) {secTotal+=10}
						}
						
						var profit=secTotal-PL-EO-tax;
						fixedTotal=secTotal;
					}
					
					var partsSell=parts*((MU/100)+1);
					var laborSell=labor*((MU/100)+1);
					
					Gebi('FixedPrice').innerHTML=currencyLink+(formatCurrency(fixedTotal));
					WSQLU('Sections','FixedPrice',fixedTotal,'SectionID',secId);
					Gebi('MU').innerHTML=editLink+(MU);
					WSQLU('Sections','MU',MU,'SectionID',secId);
					
					
					Gebi('SectionTotal').innerHTML=formatCurrency(secTotal);
	
					function p(number) {
						var p=Math.round((number/secTotal)*10000)/100;
						if(isNaN(p)) p=0;
						return p;
					}
					
					Gebi('PartsSell').innerHTML='<div style="float:left;">'+formatCurrency(partsSell)+'</div><div style="float:right;">'+p(partsSell)+'%</div>';
					Gebi('LaborSell').innerHTML='<div style="float:left;">'+formatCurrency(laborSell)+'</div><div style="float:right;">'+p(laborSell)+'%</div>';
				}
				Gebi('PartsCost').innerHTML='<div style="float:left;">'+formatCurrency(parts)+'</div><div style="float:right;">'+p(parts)+'%</div>';
				Gebi('LaborCost').innerHTML='<div style="float:left;">'+formatCurrency(labor)+'</div><div style="float:right;">'+p(labor)+'%</div>';
				Gebi('TravelCost').innerHTML='<div style="float:left;">'+formatCurrency(travel)+'</div><div style="float:right;">'+p(travel)+'%</div>';
				Gebi('EquipCost').innerHTML='<div style="float:left;">'+formatCurrency(equip)+'</div><div style="float:right;">'+p(equip)+'%</div>';
				Gebi('OtherCost').innerHTML='<div style="float:left;">'+formatCurrency(other)+'</div><div style="float:right;">'+p(other)+'%</div>';
				
				Gebi('TaxCost').innerHTML='<div style="float:left;">'+formatCurrency(tax)+'</div><div style="float:right;">'+p(tax)+'%</div>';
				Gebi('OverheadCost').innerHTML='<div style="float:left;">'+formatCurrency(overhead)+'</div><div style="float:right;">'+p(overhead)+'%</div>';
				
				Gebi('ProfitCost').innerHTML='<div style="float:left;">'+formatCurrency(profit)+'</div><div style="float:right;">'+p(profit)+'%</div>';
				
				var GraphSrc='pie.asp?GraphData=';
				var expensesP=p(travel+equip+other);
				var lessThan1=0;
				var expensesP=p(travel+equip+other);
				if(p(parts)>2)   {GraphSrc+='Materials_'+Math.round( parts ) +'_'; } else { lessThan1 += (parts*1) }
				if(p(labor)>2)   { GraphSrc+='.Labor_' + Math.round( labor ) +'_'; } else { lessThan1 += (labor*1) }
				if(expensesP>2)  {GraphSrc+='.Expenses_'+Math.round(expenses)+'_'; } else { lessThan1+=(expenses*1) }
				if(p(tax)>2)     { GraphSrc += '.Tax_' + Math.round( tax ) + '_' ; } else { lessThan1 += (tax*1) }
				if(p(overhead)>2){GraphSrc+='.Overhead_'+Math.round( overhead )+'_'; } else { lessThan1+=(overhead*1) }
				if(p(profit)>2)  {GraphSrc+='.Profit_' + Math.round( profit )+'_00FF00'; } else { lessThan1 += (profit*1) }
				if(p(profit)<0)  { GraphSrc+= '.Loss_' + Math.round( profit )+'_'; }
				if(lessThan1>0) { GraphSrc+= '.Everything Else_' + Math.round(lessThan1)+'_'; }
																		//'.Everything<5%	
				Gebi('Graph').src=encodeURI(GraphSrc);
			}
			else {
				AjaxErr('There was a problem with the sectionCost request.', HttpText);
				return false
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
}


function delSec(id) {
	HttpText='BidASP.asp?action=delSec&secId='+id;
	xhr=getXHRObject();
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4) {
			if(xhr.status==200) {
				try { var xmlDoc = xhr.responseXML.documentElement }
				catch(e) { AjaxErr(' There was a problem with the delSec response.', HttpText) }
				//AjaxErr(' n8 is ✔ing out the delSec response.',HttpText);
				
				//parent.showTab(PGebi('ProjInfoTab')); parent.ProjectCost(projId); 
				//window.location='BidSections.asp?projId='+projId;
				parent.location=parent.location;
			}
			else {
				AjaxErr('There was a problem with the delSec request.', HttpText);
				return false;
			}
		}
	}
	xhr.open('GET', HttpText, false)
	xhr.send(null);
	
}


// Font Readability Test:
//		Character distinguishability adds to readability.
//		
//		1Il|│ 
//		 i¡!‼
//		┬Ttτ┼π
//		°o○O0☺☻
//		
//		-─_
//		
//		= ═
//		
//		•∙·.,÷:;'`"
//		





//		☺ ☻ ♥ ♦ ♣ ♠ • ◘ ○ ◙ ♂ ♀ ♪ ♫ ☼ ► ◄ ↕ ‼ ¶ § ▬ ↨ ↑ ↓ → ← ∟ ↔ ▲ ▼
//		
//		⌂Ç
//		üéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ¢£¥₧ƒá
//		íóúñÑªº¿⌐¬½¼¡«»▒▓│┤╡╢╖╕╣║╗╝╜┐└
//		┴┬├─┼╞╟╚╔╩╦╠═╬╧╨╤╥╙╘╒╓╫╪
//		┘┌█▄▌▐▀αßΓπΣσµτΦΘΩδ∞φε∩≡±≥≤⌠⌡
//		ßΓπΣσµτCΘΩδ∞φε∩≡
//		±≥≤⌠⌡÷≈°∙·√ⁿ²■ 