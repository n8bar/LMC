// JavaScript Document   AJAX CONTROLS

var xhr
var HttpText ='';
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function getXHRObject(){
	var xhr=false;
	try {	xhr=new XMLHttpRequest();	}// Firefox, Opera 8.0+, Safari
	catch (e) {	// Internet Explorer
		try {	xhr=new ActiveXObject("Msxml2.XMLHTTP");	}
		catch (e) {	xhr=new ActiveXObject("Microsoft.XMLHTTP");	}
	}
	
	if (!xhr) alert ("Your browser does not support AJAX!");
	
	return xhr;
}
//------------------------------------------------------------------------------------------------


function searchCust(sStr) {
	HttpText='BidASP.asp?action=searchCust&search='+CharsEncode(sStr);
	xhr = getXHRObject();
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				
				try	{	var xmlDoc = xhr.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the searchCust:"'+sStr+'" response.',HttpText);	
				}
				var recordCount=xmlDoc.getElementsByTagName('recordCount')[0].childNodes[0].nodeValue.replace('--','');
				
				var custList='';
				for(r=1;r<=recordCount;r++) {
					var custId=xmlDoc.getElementsByTagName('custId'+r)[0].childNodes[0].nodeValue;
					var name=CharsDecode(xmlDoc.getElementsByTagName('name'+r)[0].childNodes[0].nodeValue);
					custList+='<div onclick="addCust('+custId+',\''+name+'\');" class=custListItem >'+name+'</div>';
				}
				Gebi('custList').innerHTML=custList;
			}
			else {
				AjaxErr('There was a problem with the searchCust:"'+sStr+'" request. Continue?',HttpText);
			}
		}
	}
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}

function searchProv(sStr) {
	HttpText='BidASP.asp?action=searchMonProvider&search='+CharsEncode(sStr);
	xhr = getXHRObject();
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {

				try	{	var xmlDoc = xhr.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the searchProv:"'+sStr+'" response.',HttpText);	
				}
				var recordCount=xmlDoc.getElementsByTagName('recordCount')[0].childNodes[0].nodeValue.replace('--','');
				
				var provList='';
				for(r=1;r<=recordCount;r++) {
					var provId=xmlDoc.getElementsByTagName('custId'+r)[0].childNodes[0].nodeValue;
					var name=CharsDecode(xmlDoc.getElementsByTagName('name'+r)[0].childNodes[0].nodeValue);
					provList+='<div onclick="addProv('+provId+',\''+name+'\');" class=custListItem >'+name+'</div>';
				}
				Gebi('provList').innerHTML=provList;
			}
			else {
				AjaxErr('There was a problem with the searchProv:"'+sStr+'" request. Continue?',HttpText);
			}
		}
	}
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}




// Font Readability Test:
//		Character distinguishability is about 90% of readability.
//		
//		1Il|│ 
//		 i¡ !‼
//		┬Ttτ┼+πn∩Ω uµ
//		°o○O0☺☻
//		j⌡J
//		-─_
//		
//		≡═=
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