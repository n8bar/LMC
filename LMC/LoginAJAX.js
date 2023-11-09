// JavaScript Document

//Create the main XMLHttpRequest object////////////////////////////////////////////////////////
var HttpText;
function GetXmlHttpObject() {
	var xmlHttp=false;
	try  {  xmlHttp=new XMLHttpRequest();  }// Firefox, Opera 8.0+, Safari
	catch (e) {  // Internet Explorer
		try  { xmlHttp=new ActiveXObject("Msxml2.XMLHTTP"); }
	  catch (e) { xmlHttp=new ActiveXObject("Microsoft.XMLHTTP"); }
  }
  
  if (!xmlHttp) alert ("Your browser does not support AJAX!");
	  
	return xmlHttp;
}
//------------------------------------------------------------------------------------------------


//Loads projects for selected area--////////////////////////////////////////////////

function Login() {
	if(document.getElementById('pass').value==null||document.getElementById('pass').value=='') {	
	/**/
		document.getElementById('pass').value='';
		//document.getElementById('user').value='';
		alert('Password cannot be blank.');
		document.getElementById('pass').focus();
	/**/
	}
	else  {
		var User = encodeURI(document.getElementById('user').value);
		var Pass = encodeURI(document.getElementById('pass').value);
		var Crypt = Math.random();
		
		HttpText='LoginASP.asp?action=Login&User='+User+'&Pass='+Pass+'&Crypt='+Crypt;
	
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnLogin;//		
		xmlHttp.open('Get',HttpText, false);
		xmlHttp.send(null);
		if(xmlHttp.status==200) {ReturnLogin();}//Firefox code for SJAX (AJAX doesn't need this line)
	}
}

function ReturnLogin() {
	//alert(xmlHttp.readyState);
	if (xmlHttp.readyState == 4) {
		//alert(xmlHttp.status);
		if (xmlHttp.status == 200) {
			try{var xmlDoc = xmlHttp.responseXML.documentElement;}
			catch(e) {AjaxErr('There is a problem with the login response.',HttpText); return false;}
			var EmpID = xmlDoc.getElementsByTagName('EmpID')[0].childNodes[0].nodeValue;
			//alert(xmlDoc.getElementsByTagName('User')[0].childNodes[0].nodeValue.replace('--',''));
			//AjaxErr('n8: "I\'m working on the login so bare with me for a few minutes.  Thanx."',HttpText);
			
			if(EmpID=='0') {
				alert('Wrong username and/or password! ');

				//document.getElementById('user').value = '';
				document.getElementById('pass').value = '';
				document.getElementById('user').focus();
				document.getElementById('user').select();
				
				return false;
			}

			parent.EmpID = EmpID;
			parent.EmpFName = xmlDoc.getElementsByTagName('EmpFName')[0].childNodes[0].nodeValue.replace('--','');
			parent.EmpLName = xmlDoc.getElementsByTagName('EmpLName')[0].childNodes[0].nodeValue.replace('--','');
			var user = xmlDoc.getElementsByTagName('user')[0].childNodes[0].nodeValue.replace('--','');
			var URL =xmlDoc.getElementsByTagName('url')[0].childNodes[0].nodeValue.replace('--','');
			var loginDest = xmlDoc.getElementsByTagName('loginDest')[0].childNodes[0].nodeValue.replace('--','');
			//var mDest = xmlDoc.getElementsByTagName('mDest')[0].childNodes[0].nodeValue.replace('--','');
			if (loginDest=='') {
				if(mDest=='') window.top.location=URL;
				else window.top.location =mDest ;
			}
			else {
				if( URL.toLowerCase().replace('tmcdevelopment','') !=URL.toLowerCase() ) { 
					loginDest=loginDest.toLowerCase().replace('tmcmanagement','tmcdevelopment');
				}
				parent.location=loginDest;
			}

		}
		else  {
			AjaxErr('There was a problem with the Main Login request.',HttpText);
			//alert('There was a problem with the Main Login request.');
			window.open(HttpText,'','scrollbars=yes,height=704,width=980, resizable=yes',false);
		}
	}
}



function Validate() {
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnValidate;
	xmlHttp.open('GET','LoginASP.asp?action=Validate', false);
	xmlHttp.send(null);
	function ReturnValidate() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				var xmlDoc = xmlHttp.responseXML.documentElement;			
				var Validated = xmlDoc.getElementsByTagName('Validated')[0].childNodes[0].nodeValue;
				if(Validated==1) {
					var URL = xmlDoc.getElementsByTagName('URL')[0].childNodes[0].nodeValue.replace('--','');
					//parent.document.getElementById('MainFrame').src = URL;
					//parent.document.getElementById('MainFrame').style.visibility = 'visible';
					//parent.document.getElementById('Login').style.height='0px';
					//parent.document.getElementById('bottomFrame').style.height='0px';
					parent.window.location=URL;
				}
			}
			else  {
				AjaxErr('Problem with login check request','LoginASP.asp?action=Validate');
			}
		}
	}
}

var mDest='';
function LoginMobile(Destination) {
	mDest=Destination;
	if(document.getElementById('pass').value==null||document.getElementById('pass').value=='') {	
	/**/
		document.getElementById('pass').value='';
		//document.getElementById('user').value='';
		alert('Password cannot be blank.');
		document.getElementById('pass').focus();
	/**/
	}
	else  {
		var User = encodeURI(document.getElementById('user').value);
		var Pass = encodeURI(document.getElementById('pass').value);
		var Crypt = Math.random();
		
		HttpText='LoginASP.asp?action=Login&User='+User+'&Pass='+Pass+'&M=Mobile';
	
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnLogin;//		
		xmlHttp.open('Get',HttpText, false);
		xmlHttp.send(null);
		if(xmlHttp.status==200) {ReturnLogin();}//Firefox code for SJAX (AJAX doesn't need this line)
	}
}

function Validate() {
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnValidate;
	xmlHttp.open('GET','LoginASP.asp?action=Validate', false);
	xmlHttp.send(null);
	function ReturnValidate() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				var xmlDoc = xmlHttp.responseXML.documentElement;			
				var Validated = xmlDoc.getElementsByTagName('Validated')[0].childNodes[0].nodeValue;
				if(Validated==1) {
					var URL = xmlDoc.getElementsByTagName('URL')[0].childNodes[0].nodeValue.replace('--','');
					//parent.document.getElementById('MainFrame').src = URL;
					//parent.document.getElementById('MainFrame').style.visibility = 'visible';
					//parent.document.getElementById('Login').style.height='0px';
					//parent.document.getElementById('bottomFrame').style.height='0px';
					parent.window.location=URL;
				}
			}
			else  {
				AjaxErr('Problem with login check request','LoginASP.asp?action=Validate');
			}
		}
	}
}
