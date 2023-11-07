<?php
include("RED.php"); 

echo "Sweeeeeeeeeet. PHP now works on our site!!<br>";

echo "But.... Does it connect to the database?<br>";

//echo $REDconnstring;


$rs=mssql_connect($dbServer,$dbUser,$dbPW);

?>