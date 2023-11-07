// JavaScript Document   AJAX CONTROLS

//The xmlHTTP object is created in rcstri.js.

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
	xmlHttp.open('Get',HttpText, false);
	xmlHttp.send(null);
	
	function ReturnSQL()	{
		if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				SqlXML=xmlHttp.responseXML.documentElement;
			}
			else {
				if(ReadWrite!='QW') AjaxErr('Error in SqlAjax-SendSQL \n'+xmlHttp.status+'\n\n'+Statement,HttpText); 
			}
		}
	}
}

////////////////////////////////////////////////
///////////////////////// Shorthand Functions

function WSQL(SQL)	{	return SendSQL('Write',SQL);	}

function QWSQL(SQL)	{	return SendSQL('QW',SQL);	}

function WSQLU(table,set,sValue,where,wValue)	{
	return WSQL('UPDATE '+table+' SET '+set+' = \''+CharsEncode(sValue)+'\' WHERE '+where+'=\''+wValue+'\'');
}

function WSQLI(table,fields,values)	{
	return WSQL('INSERT INTO '+table+' ('+fields+') VALUES ('+values+')');
}

function WSQLUBit(table,set,sValue,where,wValue) {
	if(!!sValue) { sValue='True'}
	else { sValue='False'; }
	
	return WSQLU(table,set,sValue,where,wValue);
}