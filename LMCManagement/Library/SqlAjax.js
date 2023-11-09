// JavaScript Document   AJAX CONTROLS

//The xmlHTTPRequest object is created with the getXHR function in rcstri.js.

//------------------------------------------------------------------------------------------------

var SqlXML;

function SendSQL(ReadWrite,Statement) {
	SqlXML=null;
	var sql=Statement.toLowerCase()
	if(sql.replace('where')==sql && sql.replace('insert into')==sql) { 
		alert('Dangerous SQL Statement! \n "WHERE" clause is missing! \n\n SQL will not be executed.\n\n ['+Statement+']');
		return false;
	}
	HttpText='SqlASP.asp?action='+ReadWrite+'&SQL='+encodeURI(Statement);
	xmlHttp = getXHR();
	xmlHttp.onreadystatechange = ReturnSQL;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	
	function ReturnSQL()	{
		if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				try { 
					//alert('trying');
					SqlXML=xmlHttp.responseXML.documentElement; 
					//alert('tried and proven');
				}
				catch(e) {
					//alert('catched');
					var errText=' Error Name:'+e.name+'\n Error Message:'+e.message
					AjaxErr('Error in SqlAjax-SendSQL \n'+xmlHttp.status+'\n\n'+Statement+'\n\n'+errText,HttpText); 
			}	}
			else { if(ReadWrite!='QW') AjaxErr('Error in SqlAjax-SendSQL \n'+xmlHttp.status+'\n\n'+Statement,HttpText);	}
}	}	}

function SendSQLsjax(ReadWrite,Statement) {
	var returnVal=false;
	SqlXML=null;
	var sql=Statement.toLowerCase()
	if(sql.replace('where')==sql && sql.replace('insert into')==sql) { 
		alert('Dangerous SQL Statement! \n "WHERE" clause is missing! \n\n SQL will not be executed.\n\n ['+Statement+']');
		return false;
	}
	HttpText='SqlASP.asp?action='+ReadWrite+'&SQL='+encodeURI(Statement);
	xmlHttp = getXHR();
	xmlHttp.onreadystatechange = ReturnSQL;
	xmlHttp.open('Get',HttpText, false);
	xmlHttp.send(null);
	if(xmlHttp.status==200) {return ReturnSQL();}//Firefox code for SJAX (AJAX doesn't need this line)
	
	function ReturnSQL()	{
		if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				SqlXML=xmlHttp.responseXML.documentElement;
				returnVal=true;
			}
			else {
				if(ReadWrite!='QW') AjaxErr('Error in SqlAjax-SendSQLsjax \n'+xmlHttp.status+'\n\n'+Statement,HttpText); 
				return false;
			}
		}
		return true;
	}
	return returnVal;
}

////////////////////////////////////////////////
///////////////////////// Shorthand Functions

function WSQLs(SQL) { return SendSQLsjax('Write',SQL);	} 

function WSQL(SQL)	{	return SendSQL('Write',SQL);	}

function QWSQL(SQL)	{	return SendSQL('QW',SQL);	}

function WSQLU(table,set,sValue,where,wValue)	{
	return WSQL('UPDATE '+table+' SET '+set+' = \''+CharsEncode(sValue)+'\' WHERE '+where+'=\''+wValue+'\'');
}
function WSQLUSJAX(table,set,sValue,where,wValue)	{
	return WSQLs('UPDATE '+table+' SET '+set+' = \''+CharsEncode(sValue)+'\' WHERE '+where+'=\''+wValue+'\'');
}

function WSQLI(table,fields,values)	{
	return WSQL('INSERT INTO '+table+' ('+fields+') VALUES ('+values+')');
}

function WSQLUBit(table,set,sValue,where,wValue) {
	if(!!sValue) { sValue='True'}
	else { sValue='False'; }
	
	return WSQLU(table,set,sValue,where,wValue);
}
function WSQLUBitSJAX(table,set,sValue,where,wValue) {
	if(!!sValue) { sValue='True'}
	else { sValue='False'; }
	
	return WSQLUSJAX(table,set,sValue,where,wValue);
}