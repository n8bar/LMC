//Javascript Document

function Gebc(searchClass,tag,node) {
	var classElements = new Array();
	if ( node == null )
		node = document;
	if ( tag == null )
		tag = '*';
	var els = node.getElementsByTagName(tag);
	var elsLen = els.length;
	var pattern = new RegExp("(^|\\s)"+searchClass+"(\\s|$)");
	for (i = 0, j = 0; i < elsLen; i++) {
		if ( pattern.test(els[i].className) ) {
			classElements[j] = els[i];
			j++;
		}
	}
	return classElements;
}

function Gebi(id)//Shorjthand for doc 
{ return document.getElementById(id);}

function PGebi(id) {
	try{
			return parent.document.getElementById(id);
	}
	catch(err){
		//alert('PGebi Error:'+err.description+'\n id:'+id);
		alert('PGebi Error: id='+id);
	}
}


function SelI(id) {
	try{return Gebi(id)[Gebi(id).selectedIndex]}
	catch(err){alert('SelI Error:'+err.description+'\n Object:'+id);}
}
function PSelI(id) {
	try{return PGebi(id)[PGebi(id).selectedIndex]}
	catch(err){alert('SelI Error:'+err.description+'\n Object:'+id);}
}
function SelIMatch(id,Match) {
	if(typeof(Match)=='undefined')
	{
		DebugBox('SelIMatch error:'+id+' Match returned "undefined".');
		return false;
	}
	for(i=0;i<=Gebi(id).length;i++)
	{
		try
		{
			if(Gebi(id)[i].innerText==Match)
			{
				Gebi(id).selectedIndex=i;
				return true;
			}
		}
		catch(e)
		{//DebugBox(e);
		}
	}
	
	DebugBox('SelIMatch error: '+id+' Doesn\'t have "'+Match+'".');
	return false;
}

function hide(id) {
	Gebi(id).style.display='none';
}
function show(id) {
	Gebi(id).style.display='block';
}



function getInternetExplorerVersion() {
  var rv = 0; // Return value assumes failure.
  if (navigator.appName == 'Microsoft Internet Explorer')
  {
    var ua = navigator.userAgent;
    var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
    if (re.exec(ua) != null)
		rv = parseFloat( RegExp.$1 );
  }
  return rv;
}
var IEver = getInternetExplorerVersion();


var mX=0; var mY=0;
var mmEvent;
function MouseMove(event) {
	mmEvent=event;
	if (!event){event = window.event;}
	mX = event.clientX;
	mY = event.clientY;
	ResetLogoutTimer();
	//document.title=mX+','+mY;
}
document.onmousemove=MouseMove;


var SavedUnsavedBkg;// = new Array;
function Unsaved(objID) {
	SavedUnsavedBkg=toString(Gebi(objID).style.backgroundColor);
	Gebi(objID).style.backgroundColor='#FFE0E0';
}

function Saved(objID) {
	Gebi(objID).style.backgroundColor='#FFF';//SavedUnsavedBkg;
	//alert(objID+' : '+Gebi(objID).style.backgroundColor);
}

//var x;
//var y;
//if(!document.all){document.captureEvents(Event.MOUSEMOVE);}
//function getMousePos(e)
//{
//	if(document.all)
//	{x=event.clientX+document.body.scrollLeft;/*x=event.x+document.body.scrollLeft;*/y=event.clientY+document.body.scrollTop;/*y=event.y+document.body.scrollTop;*/}
//  else{x=e.pageX;y=e.pageY;}
//}



function CharsEncode(S) {
	if(!S){return ''}
	S=S.replace(/</g,'_LT_');
	S=S.replace(/>/g,'_GT_');
	S=S.replace(/"/g,'_QU_;');
	S=S.replace(/%/g,'_PE_');
	S=S.replace(/\r/g,'_CR_');
	S=S.replace(/\n/g,'_CR_');
	S=S.replace(/'/g,'_AP_');
	S=S.replace(/,/g,'_CO_');
	S=S.replace(/&/g,'_AM_');
	S=S.replace(/#/g,'_PO_');
	S=S.replace(/\+/g,'_PL_');
	S=S.replace(/°/g,'_DE_');
	return S;
}

function CharsDecode(S) {
	if(!S){return ''}
	
	S=S.replace(/</g,'<');
	S=S.replace(/>/g,'>');
	
	S=S.replace(/<br>/g,'\r');
	S=S.replace(/<br\/>/g,'\r');
	
	S=S.replace(/-POUND-/g,'#');
	S=S.replace(/-AMPERSAND-/g,'&');
	S=S.replace(/-COMMA-/g,',');
	S=S.replace(/-APOSTROPHE-/g,"'");
	S=S.replace(/--RET--/g,'\r');
	S=S.replace(/-PERCENT-/g,'%');
	S=S.replace(/-QUOTE-/g,'"');
	S=S.replace(/-LESSTHAN-/g,'<');
	S=S.replace(/-GREATERTHAN-/g,'>');

	S=S.replace(/_DE_/g,'°');
	S=S.replace(/_PL_/g,'+');
	S=S.replace(/_PO_/g,'#');
	S=S.replace(/_AM_/g,'&');
	S=S.replace(/_CO_/g,',');
	S=S.replace(/_CO/g,',');
	S=S.replace(/_AP_/g,"'");
	S=S.replace(/_CR_/g,'\r');
	S=S.replace(/_PE_/g,'%');
	S=S.replace(/_QU_/g,'"');
	S=S.replace(/_LT_/g,'<');
	S=S.replace(/_GT_/g,'>');
	return S;
}

function CharsCR2Br(S) {
	if(!S){return ''}
	var br='<br/>';
	S=S.replace(/\r/g, br);
	S=S.replace(/\n/g, br);
	S=S.replace(/--RET--/g, br);
	S=S.replace(/_CR_/g, br);
	return S;
}

function CharsBr2CR(S) {
	if(!S){return ''}
	S=S.replace(/<br>/g,'\r');
	S=S.replace(/<br\/>/g,'\r');
	S=S.replace(/<bR>/g,'\r');
	S=S.replace(/<bR\/>/g,'\r');
	S=S.replace(/<Br>/g,'\r');
	S=S.replace(/<Br\/>/g,'\r');
	S=S.replace(/<BR>/g,'\r');
	S=S.replace(/<BR\/>/g,'\r');
	return S;
}

function formatCurrency(num) {
	if(!num){num=0}
	num = num.toString().replace(/\$|\,/g,'');
	if(isNaN(num))
	num = "0";
	sign = (num == (num = Math.abs(num)));
	num = Math.floor(num*100+0.50000000001);
	cents = num%100;
	num = Math.floor(num/100).toString();
	if(cents<10)
	cents = "0" + cents;
	for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
	num = num.substring(0,num.length-(4*i+3))+','+
	num.substring(num.length-(4*i+3));
	//return (((sign)?'':'-') + '' + num + '.' + cents);
	return (((sign)?'':'-') + '$' + num + '.' + cents);   //Add A Dollar Sign $
}
function unCurrency(C)	{	
	//if(isNaN(C))	{ return 'NaN';	}
	C=C.toString();
	return (C.replace('$','').replace('%','').replace(/,/g,''))*1;
}

function formatPercent(num,precision) {
	if(!num){num=0}
	num = num.toString().replace(/\$|\,/g,'');
	if(isNaN(num))
	num = 0;
	
	precision=Math.pow(10,precision);
	
	return Math.round(num*precision*100)/precision+('%');
}

function msToDays(d8)	{
	var dayt=d8 / 1000;
	dayt /= 60;
	dayt /= 60;
	return dayt / 24;
}

function daysToMs(d8)	{
	var dayt=d8 * 1000;
	dayt *= 60;
	dayt *= 60;
	return dayt * 24;
}

function mdyyyy(d8)	{
	var d8=new Date(d8);
	return (d8.getMonth()+1)+'/'+d8.getDate()+'/'+d8.getFullYear();
}

function yyyymd(d8)	{
	var d8=new Date(d8);
	return d8.getFullYear()+'/'+(d8.getMonth()+1)+'/'+d8.getDate();
}

function strToBool(str)	{
	if (str.toLowerCase()=='true'||str==1) return true;
	if (str.toLowerCase()=='false'||str==0) return false;
	return null;
}


function FadeIn(Obj) {
	Obj.style.opacity=".01";
	Obj.style.display="block";	
	setTimeout('Gebi('+Obj.id+').style.opacity=".2");',50);	
	setTimeout('Gebi('+Obj.id+').style.opacity=".4");',50);	
	setTimeout('Gebi('+Obj.id+').style.opacity=".6");',100);	
	setTimeout('Gebi('+Obj.id+').style.opacity=".8");',150);	
	setTimeout('Gebi('+Obj.id+').style.opacity="1");',200);	
}
function FadeOut(Obj) {
	setTimeout('Gebi('+Obj.id+').style.opacity=".8");',50);	
	setTimeout('Gebi('+Obj.id+').style.opacity=".6");',100);	
	setTimeout('Gebi('+Obj.id+').style.opacity=".4");',150);	
	setTimeout('Gebi('+Obj.id+').style.opacity=".2");',200);	

	setTimeout('Gebi('+Obj.id+').style.display="none");',250);	

}


var OldMMOColor = new Array
function MainMOverColor(This,NewColor){OldMMOColor[This.id]=This.style.color; This.style.color=NewColor;}
function MainMOutColor(This){This.style.color=OldMOColor[This.id];}

var OldMMOBkg = new Array
function MainMOverBkg(This,NewValue){OldMMOColor[This.id]=This.style.background; This.style.background=NewValue;}
function MainMOutBkg(This){This.style.background=OldMOColor[This.id];}

function alpha(e,allow,obj) {
	var k;
	//var evtobj=window.event? event : e;
	k=document.all?parseInt(e.keyCode): parseInt(e.which);
	//alert(k);
	if (k!=13 && k!=8 && k!=0)
	{
		//alert(allow.indexOf(String.fromCharCode(k))!=-1);
		if ((e.ctrlKey==false) && (e.altKey==false)) {return (allow.indexOf(String.fromCharCode(k))!=-1);}
		else {return true;}
	} 
	else{return true;}
}

function a(Str){
	return '<a href="../TMC/'+Str+'">'+Str+'</a>';
}



function Pause(millis) 
{
var date = new Date();
var curDate = null;

do { curDate = new Date(); } 
while(curDate-date < millis);
} 


var DBoxCount=0; // DEBUG BOX --------------------------------------------------------------------------------------
function DebugBox(HTML,X,Y,W,H) {
	try{if(window.top.accessUser!='n8'){return false}}
	catch(e)
	{
		try{if(window.location.pathname.indexOf('evelopment')<0){return false;}}
		catch(e){return false}
	}
	
	if(isNaN(X*1)){X=0}
	if(isNaN(Y*1)){Y=0}
	if(isNaN(W*1)){W=0}
	if(isNaN(H*1)){H=0}
	
	DBoxCount++;
	var D=document.body;
	
	var DBoxID ='DebugBox'+DBoxCount;
	var XYWH=' top:'+Y+'px; left:'+X+'px;';
	if(W!=0){XYWH+=' width:'+W+'px;';}
	if(H!=0){XYWH+=' height:'+H+'px;';}
	var DBoxStyle='border:3px #CCCC33 solid; background:#844; position:absolute; z-index:100000000; color:#FFF; overflow-x:hidden; overflow-y:scroll; '+XYWH;
	D.innerHTML+='<div id="'+DBoxID+'" style="'+DBoxStyle+'"></div>';
	
	Gebi(DBoxID).innerHTML+='<div style="float:right; background:#CC0000; cursor:pointer;" onclick="Gebi(\''+DBoxID+'\').style.display=\'none\';"><b>X</b></div>';
	Gebi(DBoxID).innerHTML+='<div>'+HTML+'</div>';
	return true;
}// End Debug Box ------------------------------------------------------------------------------------------------


function Numberize(Num) {
	Num=Num*1;
	if(isNaN(Num)) {Num=0}
	
	//if(typeof(Num)=="undefined") {Num=0}
	
	return Num
}


/**
 * DHTML date validation script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */
// Declaring valid date character, minimum year and maximum year
var dtCh= "/";
var minYear=1900;
var maxYear=2100;

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}



function isDate(dtStr){
	if(!dtStr){return false;}
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strMonth=dtStr.substring(0,pos1)
	var strDay=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		alert("The date format should be : mm/dd/yyyy")
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		alert("Please enter a valid month")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		alert("Please enter a valid day")
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		alert("Please enter a valid date")
		return false
	}
return true
}

function dayAdd(d8,Addend) {
	if(!Addend){Addend=1}
	
	var valueofDate=d8.valueOf()+(24*60*60*1000*Addend); 
	var newDate =new Date(valueofDate);
	return newDate
	
	//alert(newDate.toLocaleDateString());
}

function daysDiff(date1,date2) {
	var diff = new Date();
	
	// sets difference date to difference of first date and second date
	diff.setTime(Math.abs(date1.getTime() - date2.getTime()));
	var timediff = diff.getTime();
	
	return Math.floor(timediff / (1000 * 60 * 60 * 24)); 
}


function ifEnter(e,js) {
	var key = ( document.all ) ? window.event.keyCode : e.keyCode;
	if(key==13) { eval(js); }
}

function keyCheck(e,allow) {
	var k;
	//var evtobj=window.event? event : e;
	k=document.all?parseInt(e.keyCode): parseInt(e.which);
	//alert(k);
	if (k!=13 && k!=8 && k!=0)
	{
		//alert(allow.indexOf(String.fromCharCode(k))!=-1);
		if ((e.ctrlKey==false) && (e.altKey==false)) {return (allow.indexOf(String.fromCharCode(k))!=-1);}
		else {return true;}
	} 
	else{return true;}
}


function limitInput(/*myfield,*/ e, inputChars/*, dec*/) { //inputChars can be '0123456789.' for example.
	var key;
	var keychar;
	
	if (window.event) key = window.event.keyCode;
	else if (e) key = e.which;
	else return true;
	
	keychar = String.fromCharCode(key);
	// control keys     a           Backspace   Tab         Enter        Esc
	if ((key==null) || (key==0) || (key==8) || (key==9) || (key==13) || (key==27) ) return true;
	// numbers
	else if (((inputChars).indexOf(keychar) > -1)) return true;

	else return false;
}










//var LogoutTimerInterval=1*60*60*1000;
var LogoutTimerInterval=30000;
var LogoutTimer//=window.setTimeout('LogOut();',LogoutTimerInterval);
var RLTCount=0;
function ResetLogoutTimer() {
	window.clearTimeout(LogoutTimer);
	
	LogoutTimer=window.setTimeout('//LogOut();',LogoutTimerInterval);
	
	//RLTCount++
	//parent.document.getElementById('CurrentUser').innerHTML=RLTCount;
}



//////////////////////////////////////////  AJAX  /////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////  AJAX  /////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////  AJAX  /////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////  AJAX  /////////////////////////////////////////////////////////////////////////
function AjaxErr(Message,URL)	{
	if (window.top.accessUser=='n8')	{
		if(confirm(window.top.accessUser+': '+Message+'\n@\n'+URL)){	window.open(URL,'','scrollbars=yes,height=704,width=980, resizable=yes',false);	}
	}
	else {
		alert(Message);
	}
}
//////////////////////////////////////////  AJAX  /////////////////////////////////////////////////////////////////////////
function xmlTag(tagName)	{
	return xmlHttp.responseXML.documentElement.getElementsByTagName(tagName)[0].childNodes[0].nodeValue;
}
//////////////////////////////////////////  AJAX  /////////////////////////////////////////////////////////////////////////

var HttpText='';
function getXHR() {
	var xmlHttp=false;
	try {	xmlHttp=new XMLHttpRequest(); }	// Firefox, Opera 8.0+, Safari, Chrome
	catch (e) {// Internet Explorer
		try {	xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e) {	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");	}
	}
	if (!xmlHttp) alert ("Your browser does not support AJAX!");
	return xmlHttp;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

function ErrorReport(errorMsg, url, lineNumber, User)	{
	HttpText='ErrorReportASP.asp?url='+encodeURI(window.location)+'&Msg='+errorMsg.msg+'&Line='+lineNumber+'&UN='+User;
	xmlHttp = getXHR();
	xmlHttp.onreadystatechange = ReturnErrorReport;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	
	function ReturnErrorReport()	{
   if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				var xmlDoc = xmlHttp.responseXML.documentElement;
				var SQL = xmlDoc.getElementsByTagName("SQL")[0].childNodes[0].nodeValue;
			}
			else	{
				AjaxErr('There was a problem with an Error-Reporting request in rcstri.js ', HttpText);
			}
		}
	}
}


function sessionWrite(Variable,Value)	{
	HttpText='SessionWrite.asp?Variable='+Variable+'&Value='+Value;
	xmlHttp = getXHR();
	xmlHttp.onreadystatechange = ReturnSessionWrite;
	xmlHttp.open('Get',HttpText, false);
	xmlHttp.send(null);
	
	function ReturnSessionWrite()	{
  	if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				try { var xmlDoc = xmlHttp.responseXML.documentElement; }
				catch(e) {
					//AjaxErr('AJAX Error in XML Response\n function: sessionWrite\n Variable:'+variable+'\n Value:'+value, HttpText);
					return false;
				}
				var variable = xmlDoc.getElementsByTagName("variable")[0].childNodes[0].nodeValue;
				var value = xmlDoc.getElementsByTagName("value")[0].childNodes[0].nodeValue;
			}
			else	{
				AjaxErr('AJAX Error in function: sessionWrite\n Variable:'+Variable+'\n Value:'+Value, HttpText);
			}
		}
	}
}