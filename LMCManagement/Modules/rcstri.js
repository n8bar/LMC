//Javascript Document

function noCacheReload() { location=location.toString().replace(parentNoCache,uid()); }

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

function Gebi(id)//Shorthand for document.getElementById 
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

function gebtNv(parentNode,tagName) { return parentNode.getElementsByTagName(tagName)[0].nodeValue; }



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
	S=S.toString();
	S=S.replace(/</g,'_LT_');
	S=S.replace(/>/g,'_GT_');
	S=S.replace(/"/g,'_QU_');
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
	S=S.toString();
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
	S=S.toString();
	var br='<br/>';
	S=S.replace(/\r/g, br);
	S=S.replace(/\n/g, br);
	S=S.replace(/--RET--/g, br);
	S=S.replace(/_CR_/g, br);
	return S;
}

function CharsBr2CR(S) {
	if(!S){return ''}
	S=S.toString();
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

function formatPhone(int) {
	var i=unPhone(int);
	if(!i) {
		//alert('The phone number, "'+int+'" cannot be processed.\nPlease remove non-numeric characters from the number and try again.')
		var err=new Error('The string, "'+int+'" could not be phone formatted because it contains non-numeric characters');
		throw(err);
		return int*1;
	}
	
	var str=i.toString()
	if(isNaN(i)) i=0;
	
	//If len(str) > 4 Then str=left(str,len(str)-4)&"-"&right(str,4)
	if(str.length > 4) str=str.slice(0,str.length-4)+'-'+str.slice(-4,str.length+1);
	//If len(str) > 8 Then
	if(str.length > 8) {
		//str=left(str,len(str)-8)&")"&right(str,8)
		str=str.slice(0,str.length-8)+')'+str.slice(-8,str.length+1);
		//If len(str) > 12 Then
		if(str.length > 12) {
			//str=left(str,len(str)-12)&"("&right(str,12)
			str=str.slice(0,str.length-12)+'('+str.slice(-12,str.length+1);
		}	else {
			str='('+str
		}
	}	/**/
	return str;
}

function unPhone(str) {
	var i= str.replace(/\./g,'').replace(/-/g,'').replace(/\(/g,'').replace(/\)/g,'');
	while (i.indexOf(' ') > 0 ) { i=i.replace(' ',''); }
	i*=1;
	if(isNaN(i)) {
		alert('Phone Number: "'+str+'" could not be processed because it contains illegal characters.');
		return false;
	}
	return i;
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

function hhmm(d8) {
	var d8=new Date(d8);
	var hh='00'+d8.getHours();
	var mm='00'+d8.getMinutes();
	return (hh.slice(-2)+':'+mm.slice(-2));
}

function mdyyyyhhmm(d8)	{
	var d8=new Date(d8);
	return mdyyyy(d8)+' '+hhmm(d8);
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
	var o=0;
	for(o=0; o<=100; o++) {	
		setTimeout('Gebi("'+Obj.id+'").style.opacity="'+(o/100)+'";',o*2.5);
	}
	/*
	setTimeout('Gebi("'+Obj.id+'").style.opacity=".4";',50);	
	setTimeout('Gebi("'+Obj.id+'").style.opacity=".6";',100);	
	setTimeout('Gebi("'+Obj.id+'").style.opacity=".8";',150);	
	setTimeout('Gebi("'+Obj.id+'").style.opacity="1";',200);	
	*/
}
function FadeOut(Obj) {
	var o=100;
	for(o=100; o>=0; o--) {	
		setTimeout('Gebi("'+Obj.id+'").style.opacity="'+(o/100)+'";',o*2.5);
	}
	/*
	setTimeout('Gebi("'+Obj.id+'").style.opacity=".8";',50);	
	setTimeout('Gebi("'+Obj.id+'").style.opacity=".6";',100);	
	setTimeout('Gebi("'+Obj.id+'").style.opacity=".4";',150);	
	setTimeout('Gebi("'+Obj.id+'").style.opacity=".2";',200);	

	*/
	setTimeout('Gebi("'+Obj.id+'").style.display="none");',250);	
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
	
	return Num;
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

function evalBox(box) {
	try {
		if (!!box.value) {	box.value=eval(box.value)	}
		else {	
			if(!!box.innerText) {	
				 box.innerText=eval(box.innerText) 
			}
			else {	
				if(!!box.innerHTML) {	box.innerHTML=eval(box.innerHTML)	}
			}
		}
	}
	catch(e) { 
		try {
			if (!!box.value) {	box.value=unCurrency(box.value)	}
			else {	
				if(!!box.innerText) {	
					 box.innerText=unCurrency(box.innerText) 
				}
				else {	
					if(!!box.innerHTML) {	box.innerHTML=unCurrency(unCurrencybox.innerHTML)	}
				}
			}
			evalBox(box);
		}
		catch(e) { 
			n8alert('evalBox Error: \n\n'+' v:'+box.value+'\n iT:'+box.innerText+'\n iH:'+box.innerHTML);
		}
	}
	box.onkeyup();
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

function a(Str){
	return '<a href="../../LMCDevelopment/'+Str+'">'+Str+'</a>';
}

function limitInput(/*myfield,*/ e, inputChars/*, dec*/) { //inputChars can be '0123456789.' for example.
	var key;
	var keychar;
	
	if (window.event) key = window.event.keyCode;
	//else if (e) key = e.which;
	else return false;//true;
	
	keychar = String.fromCharCode(key);
	// control keys     null        Backspace   Tab         Enter        Esc
	if ((key==null) || (key==0) || (key==8) || (key==9) || (key==13) || (key==27) ) return true;
	// numbers
	else if (((inputChars).indexOf(keychar) > -1)) return true;

	else return false;
}

function numbersonly( e ) {//for textboxes
	var unicode = e.charCode ? e.charCode : e.keyCode;
	
	//if the key isn't the backspace key or hyphen
	if( unicode != 8 )	{
		//if not a number
		if( unicode < 48 || unicode > 57 ) {return false;} else {return true;}
	}//end if
	else {return true;}
}//end function


var oldAcceptValues=new Array
function onlyAccept(e, inputChars, obj) { //inputChars can be '0123456789.' for example.
	var key;
	var keychar;
	var good=true;
	
	if(obj.tagName=='INPUT') {oldAcceptValues[obj.id]=obj.value} else oldAcceptValues[obj.id]=obj.innerHTML;
	if(!oldAcceptValues[obj.id]) oldAcceptValues[obj.id]='';
	
	//alert(oldAcceptValues[obj.id]);
	
	if (window.event) key = window.event.keyCode;
	else if (e) key = e.which;
	else return true;
	
	keychar = String.fromCharCode(key);
	//alert(keychar);
	// control keys     null        Backspace   Tab         Enter        Esc
	if ((key==null) || (key==0) || (key==8) || (key==9) || (key==13) || (key==27) ) return true;
	// numbers
	else if (((inputChars).indexOf(keychar) > -1)) return true;

	else {
		var js;
		if(obj.tagName=='INPUT') { js="Gebi('"+obj.id+"').value='"+oldAcceptValues[obj.id]+"';" } 
		else {js="Gebi('"+obj.id+"').innerHTML='"+oldAcceptValues[obj.id]+"';"} 
		setTimeout(js,100);
		//alert('bonk: ['+oldAcceptValues[obj.id]+']');
		return false;
	}
}

function roundUp(num) {
	var mult=1;
	var add=0;
	num=num*1;
	if (num<0) mult=-1;
	num=num.toString().split('.')
	var dec=num[1];
	num=num[0];
	//alert(num+'.'+dec);
	if(!!dec) add=1;
	return (num*1)+(add*mult);
}


function uid() {
	var cKey=new Date();
	//cKey=cKey.getFullYear().toString()+(cKey.getMonth()+1).toString()+cKey.getDate().toString()+cKey.getHours().toString()+cKey.getMinutes().toString()+cKey.getSeconds().toString()+cKey.getMilliseconds().toString()+sessionID;
	return cKey.valueOf();
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



//////////////////////////////////////////  XML  /////////////////////////////////////////////////////////////////////////


var x2jDepth=0;
function xml2json(xmlNode) {
	if (x2jDepth>256) return 'too deep';
	x2jDepth++;
	var jsonObject=new Object;
	
	var arrayNamesList=new Array;
	var arrayIndex=-1;
	
	var value=null;
	
	if(!xmlNode) return 'invalid or empty node';
	
	for(var x=0; x<xmlNode.childNodes.length; x++) {
		var nn=xmlNode.childNodes[x].nodeName;
		if(nn.indexOf('#')>-1) continue;
		
		if(nn.indexOf('__')>-1) {
			arrayIndex=nn.split('__')[1];
			nn=nn.split('__')[0];
			if(arrayIndex==0) eval('try{jsonObject.'+nn+'= new Array;} catch(e) { alert(\'xml2json error on nodeName:+'+nn+'\'); } ');
			nn=nn+'['+arrayIndex+']';
		}
		
		if(xmlNode.childNodes[x].childNodes.length>1) {
			var js='jsonObject.'+nn+'=xml2json(xmlNode.childNodes[x])'
		}
		else {
			var value=CharsDecode(xmlNode.childNodes[x].textContent);
			switch(value.toLowerCase()) {
				case 'true': value=true; break;
				case 'false': value=false; break;
			}
			
			var js='jsonObject.'+nn+'=value';
		}
		//alert(js);
		var evalText=''
		evalText+='try {'+js+'} ';
		evalText+='catch(e) { ';
		evalText+=	'var errMsg=\'xml2json error:\\n\\n\'; ';
		evalText+=	'errMsg+=\'javascript:\\n'+js+'\\n\'; ';
		evalText+=	'errMsg+=\'value:\'+value+\'\\n\'; ';
		evalText+=	'errMsg+=\'\\n\'; ';
		evalText+=	'errMsg+=\'Error:\'+e.name+\'\\n\'; ';
		evalText+=	'errMsg+=\'\'+e.message+\'\\n\'; ';
		//evalText+=	'errMsg+=\'\'; ';
		//evalText+=	'errMsg+=\'\'; ';
		//evalText+=	'errMsg+=\'\'; ';
		//evalText+=	'errMsg+=\'\'; ';
		//evalText+=	'errMsg+=\'\'; ';
		evalText+=	'AjaxErr(errMsg,HttpText);';
		evalText+='}';
		eval(evalText);
		arrayIndex=-1;
	}
	
	x2jDepth--;
	return jsonObject;
}

function n8CanHide(object) { if (window.top.accessUser=='n8') object.style.display='none'; }
function n8alert(msg) {
	if (window.top.accessUser=='n8') alert(msg);
}

//////////////////////////////////////////  AJAX  /////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////  AJAX  /////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////  AJAX  /////////////////////////////////////////////////////////////////////////
function AjaxErr(Message,URL)	{
	
	if(confirm(window.top.accessUser+': '+Message+'\n@\n'+URL)){	window.open(URL,'','scrollbars=yes,height=704,width=980, resizable=yes',false);	}
	/*
	if (window.top.accessUser=='n8')	{
		if(confirm(window.top.accessUser+': '+Message+'\n@\n'+URL)){	window.open(URL,'','scrollbars=yes,height=704,width=980, resizable=yes',false);	}
	}
	else {
		alert(Message);
	}
	*/
	
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

function session(Variable) {
	HttpText='SessionRead.asp?Variable='+Variable;
	xmlHttp = getXHR();
	xmlHttp.onreadystatechange = sessionReadyStateChange()
	var returnVal=null;
	function sessionReadyStateChange() {
  	if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				try { 
					var xmlDoc = xmlHttp.responseXML.documentElement; 
					var value = xmlDoc.getElementsByTagName("value")[0].childNodes[0].nodeValue.replace('--','');
					if (!value) value='';
					returnVal=value;
				}
				catch(e) {
					AjaxErr('There is an error in the session read response', HttpText)
					return false;
				}
			}
		}
	}
	xmlHttp.open('Get',HttpText, false); //false= SJAX
	xmlHttp.send(null);
	if(xmlHttp.status==200) {sessionReadyStateChange();}//Firefox code for SJAX (AJAX doesn't need this line)
	return returnVal;
}
	
function appGet(Variable) {
	HttpText='ApplicationRead.asp?Variable='+Variable;
	xmlHttp = getXHR();
	xmlHttp.onreadystatechange = sessionReadyStateChange()
	var returnVal=null;
	function sessionReadyStateChange() {
  	if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				try { 
					var xmlDoc = xmlHttp.responseXML.documentElement; 
					var value = xmlDoc.getElementsByTagName("value")[0].childNodes[0].nodeValue.replace('--');
					if (!value) value='';
					returnVal=value;
				}
				catch(e) {
					AjaxErr('There is an error in the session read response', HttpText)
					return false;
				}
			}
		}
	}
	xmlHttp.open('Get',HttpText, false); //false= SJAX
	xmlHttp.send(null);
	if(xmlHttp.status==200) {sessionReadyStateChange();}//Firefox code for SJAX (AJAX doesn't need this line)
	return returnVal;
}
	
function sW(v,val) { sessionWrite(v,val) }
function sessionWrite(Variable,Value)	{
	//alert('Writing: '+Variable+'='+Value);
	HttpText='SessionWrite.asp?Variable='+Variable+'&Value='+Value;
	xmlHttp = getXHR();
	xmlHttp.onreadystatechange = ReturnSessionWrite;
	xmlHttp.open('Get',HttpText, false);
	xmlHttp.send(null);
	if(xmlHttp.status==200) {ReturnSessionWrite();}//Firefox code for SJAX (AJAX doesn't need this line)
	
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
				//alert('Wrote: '+variable+'='+value);
			}
			else	{
				AjaxErr('AJAX Error in function: sessionWrite\n Variable:'+Variable+'\n Value:'+Value, HttpText);
			}
		}
	}
}

function applicationWrite(Variable,Value)	{
	//alert('Writing: '+Variable+'='+Value);
	HttpText='ApplicationWrite.asp?Variable='+Variable+'&Value='+Value;
	xmlHttp = getXHR();
	xmlHttp.onreadystatechange = ReturnApplicationWrite;
	xmlHttp.open('Get',HttpText, false);
	xmlHttp.send(null);
	
	function ReturnApplicationWrite()	{
  	if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				try { var xmlDoc = xmlHttp.responseXML.documentElement; }
				catch(e) {
					//AjaxErr('AJAX Error in XML Response\n function: sessionWrite\n Variable:'+variable+'\n Value:'+value, HttpText);
					return false;
				}
				var variable = xmlDoc.getElementsByTagName("variable")[0].childNodes[0].nodeValue;
				var value = xmlDoc.getElementsByTagName("value")[0].childNodes[0].nodeValue;
				//alert('Wrote: '+variable+'='+value);
			}
			else	{
				AjaxErr('AJAX Error in function: sessionWrite\n Variable:'+Variable+'\n Value:'+Value, HttpText);
			}
		}
	}
}