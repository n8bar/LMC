<?PHP
/*Dim REDconnstring*/
$REDconnstring = "DRIVER={SQL Server};SERVER=RCSTRI\SQLEXPRESS;UID=rcstricom;PWD=watf-771;DATABASE=Tribase";
$dbServer="RCSTRI\SQLEXPRESS";
$dbUser="rcstricom";
$dbPW="watf-771";
$db="Tribase";

//$dbConn=mssql_connect($dbServer,$dbUser,$dbPW);




/*Dim PDconn*/
$PDconn = "DRIVER={SQL Server};SERVER=whsql-v03.prod.mesa1.secureserver.net;UID=tricomelstore;PWD=watf-771;DATABASE=DB_16816";




/*DIM rs, rs1, rs2, rs3, rs4, rs5, rs6, rs7, SQL, SQL1, SQL2, SQL3, SQL4, SQL5, SQL6, SQL7, obj, obj2, obj3, obj4, obj5, obj6, obj7

Dim XML
Dim ItemName
Dim ItemDesc
Dim Cost
Dim Cost2
Dim Sell
Dim Sell2
Dim Qty
Dim MU
Dim Part
Dim Labor
Dim CostSub
Dim SellSub
Dim Total
Dim TParts
Dim TLabor
Dim TPartsC
Dim TLaborC
Dim ItemType
Dim VendID
Dim VendName
Dim Tax
*/





function ReadNotes()
{
$SQL = "SELECT * FROM estimates Where EstimateID = 508981";
//$rs = Server.CreateObject("ADODB.Recordset");
//$rs.Open($SQL, $REDconnstring);
//echo $rs("notes");
////echo (num1*num2)
}




/*
function WriteNotes()
{
$SQL2 = "Update estimates set Notes = 'Nice Notes 21' where EstimateID =508981";
$rs2=Server.CreateObject("ADODB.Recordset");
$rs2.Open $SQL2, $REDconnstring;

echo ("<SCRIPT language='JavaScript'>");
echo ("location.reload(); ");
echo ("</Script>");
}
*/




//function DecodeChars(TheString)
//{
//	$OldString=""
//	if($TheString!=NULL)
//	{
//		while($OldString<>$TheString)
//		{
//			$OldString=$TheString
//			$TheString=str_replace('-POUND-','#',str_replace('-PERCENT-','%',str_replace('-GREATERTHAN-','>',str_replace('-LESSTHAN-','<',str_replace('-APOSTROPHE-',"'",str_replace('-QUOTE-','"',str_replace('-AMPERSAND-','&',str_replace('-COMMA-',',',str_replace('--RET--',chr(13),TheString)))))))))
//		}
//	}
//	return $TheString
//}


//
//function EncodeChars(TheString)
//{
//	$OldString=""
//	if($TheString!=NULL)
//	{
//		while($OldString<>$TheString)
//		{
//			$OldString=$TheString
//			$TheString=str_replace('#','-POUND-',str_replace('%','-PERCENT-',str_replace('>','-GREATERTHAN-',str_replace('<','-LESSTHAN-',str_replace("'",'-APOSTROPHE-',str_replace('"','-QUOTE-',str_replace('&','-AMPERSAND-',str_replace(',','-COMMA-',str_replace(chr(13),'--RET--',TheString)))))))))
//		}
//	}
//	return $TheString
//}

?>
