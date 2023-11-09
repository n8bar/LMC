<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../../LMC/RED.asp" -->

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>System Expenses</title>
<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="OldEstimatesJS.js"></script>
<script type="text/javascript" src="OldEstimatesAJAX.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>

<script type="text/javascript">
	var InsideFrame=true;
	
	var SysID=<%=Request.QueryString("SysID")%>;
	SelectedSysID=SysID;
</script>

<%
	Dim SysID
	SysID=Request.QueryString("SysID")
	SQL = "SELECT * FROM Systems WHERE SystemID="&SysID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
%>

<style>

html{width:100%; height:100%; padding:0; margin:0;}
body{width:100%; height:100%; overflow-x:hidden; overflow-y:auto; padding:0; margin:0;}

/*
div{-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;}
*/

.w100{width:100%;}

.h100{height:100%;}
.h50{height:50%;}
.h25{height:25%;}

.m0{margin:0;}
.p0{padding:0;}

.bL{height:100%; width:1px; border-left:1px solid #000; float:left; white-space:pre;}
.bR{height:100%; width:1px; border-right:1px solid #000; float:right; white-space:pre;}

#Modal{position:absolute; top:0; left:0; width:100%; height:100%; background:#B1DB87;	filter:alpha(opacity=70);	opacity:0.70; display:none; z-index:10000;}

.AddEditBox{position:absolute; top:56px; left:33%; width:33%; z-index:10010; display:none; border:#70AB34 1px solid;}

.BoxTitle{width:100%; text-align:center; font-size:20px; background:#70AB34;}
.BoxRow{width:100%;}
.BoxLabel{width:50%; float:left; text-align:right; padding:2px 0 0 0;}
.BoxInput{width:50%; background:none; float:left; -webkit-box-sizing:border-box;}
.BoxBG{background-image:-webkit-gradient(linear,0% 0%,0% 100%,color-stop(0, #DDEFCB),color-stop(.2, #F8FCF3),color-stop(1, #B1DB87)); background-color:#EBF5E0;}

.item{
	width:100%;	height:auto; float:left; clear:both; border-top:1px solid #FFF; border-bottom:2px solid #40631D; margin-top:1%;
	background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0, #B1DB87),color-stop(.3, #DDEFCB),color-stop(1, #B1DB87));
}
.itemName{
	float:left; font-size:21px; text-shadow:-1px -1px 1px #FFF,3px 2px 1px #DDEFCB;
}

.btnAdd{color:Green; font-family:Arial, Helvetica; font-size:17px; font-weight:bold; padding:0; height:22px; width:22px;}

.HeadRow{width:100%; height:16px; font-family:Arial, Helvetica, sans-serif; font-size:14px;}
.tHeadItem{
	float:left; width:20%; height:100%; border-bottom:1px #000 solid; white-space:nowrap; overflow:hidden; border-top:1px #000 solid; text-align:center;
	background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0, #DDEFCB),color-stop(.2, #F8FCF3),color-stop(1, #B1DB87));
}
.HeadItem{
	float:left; width:20%; height:100%; border-bottom:1px #000 solid; white-space:nowrap; overflow:hidden; border-top:1px #000 solid; text-align:center;
	background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0, #DDEFCB),color-stop(.2, #F8FCF3),color-stop(1, #B1DB87));
}
.ItemMO:hover{
	background-color:#FF0;
	background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0, #FF0),color-stop(.2, #F8FCF3),color-stop(1, #CC0));
}


.Row{width:100%; height:25px; font-family:Arial, Helvetica, sans-serif; font-size:14px; border-right:1px #000 solid; overflow:hidden;}
.Row:hover{color:#FFF; background-color:#558327;}
.RowItem{float:left; width:20%; height:16px; border-bottom:1px #000 solid; white-space:nowrap; overflow:hidden;}
.RowBtn{float:right; width:3%; height:16px; white-space:nowrap; overflow:hidden; color:#900; cursor:pointer; text-align:center; padding:4px 0 4px; 0}

.Numbers{font-family:Consolas, "Courier New", Courier, monospace;}

.TotalLine{width:100%; text-align:right; font-size:18px;}
.SectionTotal{float:right; font-family:Consolas, "Courier New", Courier, monospace; font-size:18px; width:14%; border:1px solid #000; margin:2px; padding:0 2px 0 0;}

</style>

</head>

<body>

<button style="height:22px; margin:0 8px 0 0; width:auto; float:right;"
 onClick="
	Gebi('AddBox').style.display='block'; 
	Gebi('Modal').style.display='block'; 
	Gebi('altSave').style.display='none'; 
	Gebi('altAdd').style.display='block'; 
	Gebi('BoxTitle').innerHTML=Gebi('BoxTitle').innerHTML.replace('Edit','Add');
	
	Gebi('Desc').value='';
	Gebi('Details').value='';
	Gebi('Cost').value='';
">
	<img src="../images/plus_16.png" style="float:left;" />
	<div style="height:100%; float:left;">Add&nbsp;</div>
</button>


<div id="Modal"></div>

<div id="AddBox" class="AddEditBox">
	
	<div id="BoxTitle" class="BoxTitle">Add Alt</div>
	
	<div class="BoxBG" style="height:128px;">
		
		<div class="BoxRow">
			<div class="BoxLabel">Description :</div>
			<input id="Desc" class="BoxInput"/>
		</div>
		
		<div class="BoxRow">
			<div class="BoxLabel">Cost $</div>
			<input id="Cost" class="BoxInput Numbers"/>
		</div>
		
		<div class="BoxRow">
			<div class="BoxLabel">Details :</div>
			<textarea id="Details" style="height:48px;" class="BoxInput Numbers"></textarea>
		</div>
		
		<div class="BoxRow">
	
			<button style="float:left;" onClick="Gebi('AddBox').style.display='none'; Gebi('Modal').style.display='none';">Cancel</button>
			
			<button id="altAdd" style="float:right;"
			 onClick="
				var Fields='SysID, Description, Details, Price';
				var Values='<%=SysID%>, \''+Gebi('Desc').value+'\', \''+Gebi('Details').value+'\', \''+Gebi('Cost').value+'\'';
				var SQL='INSERT INTO SysAlt ('+Fields+') VALUES ('+Values+')';
				SendSQL('Write',SQL); 
				window.location=window.location;
			">
				Add
			</button>
			
			<button id="altSave" style="float:right; display:none;"
			 onClick="
				var SQL='UPDATE SysAlt SET Description=\''+Gebi('Desc').value+'\', Details=\''+Gebi('Details').value+'\', Price=\''+Gebi('Cost').value+'\' WHERE SysAltID='+SysAltID;
				SendSQL('Write',SQL); 
				window.location=window.location;
			">
				Save
			</button>
		
		</div>
	
	</div>
</div>



<%

SQL1="SELECT * FROM SysAlt WHERE SysID="&SysID
Set rs1=Server.CreateObject("ADODB.RecordSet")
rs1.Open SQL1, REDConnString

iCount=0

Do Until rs1.EOF
	iCount=iCount+1
	
	Price=rs1("Price")
	If Price="" Or IsNUll(Price) Then Price=0
	
	Offer="checked"
	If rs1("Exclude")="True" Then Offer=""
	
	ThisAlt=rs1("SysAltID")
%>

<div id="item<%=iCount%>" class="item">

	<div id="Row<%=iCount%>" style="width:100%; height:48px; background:none;">
		<label class=itemName for=Show<%=iCount%> title="Offer <%=rs1("Description")%>">
			<input id=Show<%=iCount%> type=checkbox <%=Offer%> 
			 onClick="
			 if(this.checked)
			 {
				 Exclude='False';
			 }
			 else
			 {
				 Exclude='True';
			 }
			 SQL='UPDATE SysAlt SET Exclude=\''+Exclude+'\' WHERE SysAltID=<%=ThisAlt%>';
			 //alert(SQL);
			 SendSQL('Write',SQL);
			"/>
			&nbsp;
		</label>
		<div id="Desc<%=iCount%>" class="itemName"><%=rs1("Description")%></div>
		
		<div id="iX<%=iCount%>" class="RowBtn ItemMO" title="Delete" style="background:<%=AltBG%>;"
		 onClick="
		 	if(confirm('Deleting <%=rs1("Description")%> ...'))
			{
				SendSQL('Write','DELETE FROM SysAlt WHERE SysAltID=<%=ThisAlt%>')
				window.location=window.location;
			}
		 ">
			<img src="../images/delete_16.png" />
		</div>
		<div id="iEdit<%=iCount%>" class="RowBtn ItemMO" title="Edit" style="background:<%=AltBG%>;"
		 onClick="
			 Gebi('BoxTitle').innerHTML=Gebi('BoxTitle').innerHTML.replace('Add','Edit');
			 Gebi('AddBox').style.display='block';
			 Gebi('Modal').style.display='block'; 
			 Gebi('altSave').style.display='block'; 
			 Gebi('altAdd').style.display='none';
			 
			 Gebi('Desc').value=Gebi('Desc<%=iCount%>').innerHTML;
			 Gebi('Details').value=Gebi('Details<%=iCount%>').innerHTML;
			 Gebi('Cost').value=Gebi('Price<%=iCount%>').innerHTML.replace('$','');

			 SysAltID=<%=rs1("SysAltID")%>;
		">
			<img src="../images/pencil_16.png" />

		
		</div>

		<div id="Price<%=iCount%>" class="itemName" style="float:right; background:inherit;">$<%=Round(Price*100)/100%></div>
		<div style="width:100%;">
			<DIV id="Details<%=iCount%>" style="float:left; font-size:14px; padding:6px 0 0 16px; width:100%;" title="<%=rs1("Details")%>"><%=rs1("Details")%></div>
		</div>
	
	<%'=tSQL%>
	</div>
</div>

<%
		rs1.MoveNext
	Loop
	Set rs1=Nothing
	Set rs=Nothing
%>
</body>
</html>