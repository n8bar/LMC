var xmlHttp
var HttpText ='';
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

//window.top.accessUser='n8';

function GetXmlHttpObject()	{
	var xmlHttp=null;
	try	{
		xmlHttp=new XMLHttpRequest(); // Firefox, Opera 8.0+, Safari
	}
	catch (e)  {
		// Internet Explorer
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e)	{
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
	if (xmlHttp==null)	{
		alert ("Your browser does not support AJAX!");
		return;
	}
	return xmlHttp;
}

//------------------------------------------------------------------------------------------------

var XHRTries=1000;
var xhrTI=0;
function getSubTabs(parentTabId)	{
	
	return false;
	
	HttpTxt='LMCTabs-ASP.asp?action=subTabs&parentTabId='+parentTabId;
	var xhro = GetXmlHttpObject();
	xhro.onreadystatechange = ReturnGetSubTabs;
	xhro.open('GET',HttpTxt, false);
	xhro.send(null);
	try{if(xhro.status == 200){ReturnGetSubTabs();}}catch(e){}
	
	function ReturnGetSubTabs()	{
		if (xhro.readyState == 4) { 
			if (xhro.status == 200) {
				
				try {
					var xml = xhro.responseXML.documentElement;			
				}
				catch(e) {
					AjaxErr('There is an error in the getSubTabs Response.',HttpTxt);
					return false;
				}
				
				try {	var rCount= xml.getElementsByTagName('rCount')[0].childNodes[0].nodeValue;	}
				catch(e) { AjaxErr('Error: getSubTabs Response datum:rCount',HttpTxt);	return false; }
				
				var subTabId;
				var tabName;
				var frameSrc;
				var comingSoon;
				var txtColor;
				var tColor;
				
				var tW=100/((rCount*1)+1);
				
//				Gebi('subTabs').innerHTML='';
				//Gebi('frames').innerHTML='';
				for(r=1;r<=rCount;r++)	{
					subTabId=xml.getElementsByTagName('subTabId'+r)[0].childNodes[0].nodeValue;
					tabName=CharsDecode(xml.getElementsByTagName('tabName'+r)[0].childNodes[0].nodeValue);
					txtColor=xml.getElementsByTagName('txtColor'+r)[0].childNodes[0].nodeValue;
					tColor=xml.getElementsByTagName('tColor'+r)[0].childNodes[0].nodeValue;
					var now=new Date();
					now=now.getFullYear()+''+(now.getMonth()+1)+''+now.getDate()+''+now.getHours()+''+now.getMinutes()+''+now.getSeconds()+''+now.getMilliseconds();
					tabSrc=CharsDecode(xml.getElementsByTagName('frameSrc'+r)[0].childNodes[0].nodeValue).replace('--TIMESTAMP--',now);
					comingSoon=xml.getElementsByTagName('comingSoon'+r)[0].childNodes[0].nodeValue;
					
					sty=' style="color:#'+txtColor+'; border-color:#'+tColor+'; width:'+tW+'%;"';
					if (comingSoon=='True')	{
						tabSrc='coming.asp?link='+tabSrc;
						//txtColor='ccc !important'
						sty=' style="color:#'+txtColor+'; border-color:#'+tColor+'; width:'+tW+'%; opacity:.5; "';
					}
					/*
					Gebi('subTabs').innerHTML+='<div class=spacer>&nbsp;</div>';
					Gebi('subTabs').innerHTML+='<div id=subTab'+subTabId+' class="subTab" onClick="subTab(this,\''+tabSrc+'\');"'+sty+'>'+tabName+'</div>';
					Gebi('subTabs').innerHTML+='<div class=spacer>&nbsp;</div>';
					*/
					if(!Gebi('frame'+subTabId)) { //Build An iFrame for each subTab if there isn't one.
						Gebi('frames').innerHTML+='<iframe id=frame'+subTabId+' class="hiddenFrame" src=""></iframe>';
					}
				}
				/*
				var W=1400;//Gebi('subTabs').offsetWidth;
				var divs=Gebi('subTabs').getElementsByTagName('div');
				var w=0;
				for (var d=0; d<divs.length; d++) { w+=(divs[d].offsetWidth*1);}
				var spaceW=100-(100*((w+.5)/W));	//Gebi('topLinks').innerHTML+=(spaceW);
				Gebi('subTabs').innerHTML='<div class=spacer style="float:right; height:29px; width:'+spaceW+'%; ">&nbsp;</div>'+Gebi('subTabs').innerHTML;
			*/
		  var selSubTabId=sstIdArray[selectedMainTab.id];
			//Gebi('mainTab5').innerHTML=selectedMainTab.id+' = '+selSubTabId;
			//alert(selectedMainTab.id+sessionEmpID+'="'+appGet(selectedMainTab.id+sessionEmpID).replace('undefined','')+'"');
			
			if(!!Gebi(selSubTabId)) { 
				subTab(Gebi(selSubTabId),''); 
			}
			else { 
				var lastUserSelectedSubTabId=appGet(selectedMainTab.id+sessionEmpID).replace('undefined','');
				if(!!Gebi(lastUserSelectedSubTabId)) { Gebi(lastUserSelectedSubTabId).onclick(); }
				else { /*Gebi('subTabs').childNodes[0].onclick();*/ }
			}
				
				/*
				var startupSubTabId=xmlDoc.getElementsByTagName('subTabId1')[0].childNodes[0].nodeValue;
				var startupFrameSrc=CharsDecode(xmlDoc.getElementsByTagName('frameSrc1')[0].childNodes[0].nodeValue);
				//Gebi('subTab'+startupSubTabId).setAttribute('class', 'selectedSubTab');
				Gebi('frame'+startupSubTabId).setAttribute('class', 'frame');
				//Gebi('frame'+startupSubTabId).setAttribute('src', startupFrameSrc);
				*/
			}
		}
		else	{
			if (xhrTI<XHRTries) 	{
				xhrTI++;
				ReturnGetSubTabs();
				return false;
			}
			else	{
				//AjaxErr('\nError loading sub tabs\n Tried '+xhrTI+' times!  \n', HttpText);
				xhrTI=0;
			}
		}
	}
}




function keepAlive()	{
	HttpText='LMCTabs-ASP.asp?action=keepAlive';
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetSubTabs;
	xmlHttp.open('GET',HttpText, true);
	xmlHttp.send(null);
	try{if(xmlHttp.status == 200){ReturnGetSubTabs();}}catch(e){}
	
	function ReturnGetSubTabs()	{
		if (xmlHttp.readyState == 4)	{ 
			if (xmlHttp.status == 200)	{
				
				var xmlDoc = xmlHttp.responseXML.documentElement;	
				
				iterateKeepAlive();

						
				/** /
				var rCount= xmlDoc.getElementsByTagName('rCount')[0].childNodes[0].nodeValue;
				
				var subTabId;
				var tabName;
				var frameSrc;
				var comingSoon;
				var txtColor;
				
				var tW=100/((rCount*1)+1);
				
				Gebi('subTabs').innerHTML='';
				Gebi('frames').innerHTML='';
				for(r=1;r<=rCount;r++)	{
						subTabId=xmlDoc.getElementsByTagName('subTabId'+r)[0].childNodes[0].nodeValue;
						tabName=xmlDoc.getElementsByTagName('tabName'+r)[0].childNodes[0].nodeValue;
						frameSrc=CharsDecode(xmlDoc.getElementsByTagName('frameSrc'+r)[0].childNodes[0].nodeValue);
						comingSoon=xmlDoc.getElementsByTagName('comingSoon'+r)[0].childNodes[0].nodeValue;
					
					if (comingSoon=='True')	{
						frameSrc='coming.asp?link='+frameSrc;
						txtColor='color:#ccc;'
					}
					else	{
						txtColor='';
					}
					
					Gebi('subTabs').innerHTML+='<div id=subTab'+subTabId+' class="subTab" onClick="subTab(this,\''+frameSrc+'\');" style="'+txtColor+' width:'+tW+'%;">'+tabName+'</div>';
					Gebi('frames').innerHTML+='<iframe id=frame'+subTabId+' class="hiddenFrame" src=""></iframe>';
				}
				
				var startupSubTabId=xmlDoc.getElementsByTagName('subTabId1')[0].childNodes[0].nodeValue;
				var startupFrameSrc=CharsDecode(xmlDoc.getElementsByTagName('frameSrc1')[0].childNodes[0].nodeValue);
				Gebi('subTab'+startupSubTabId).setAttribute('class', 'selectedSubTab');
				Gebi('frame'+startupSubTabId).setAttribute('class', 'frame');
				Gebi('frame'+startupSubTabId).setAttribute('src', startupFrameSrc);
		/**/
			}
		}
		else	{
			//jaxErr('There is a connection problem.', HttpText);
		}
	}
}
