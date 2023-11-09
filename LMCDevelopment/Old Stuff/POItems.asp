<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Purchase Order Items</title>
<!--#include file="../../LMC/RED.asp" -->


<style>

html{border:1px white solid; border-right:1px white solid;}
html,body{margin:0; padding:0; width:100%; height:100%; overflow:hidden;}


div, html, input, span, textarea{-webkit-box-sizing:border-box;}

.Row{width:100%; height:20px; font-family:Verdana, Arial, Helvetica, sans-serif; border-bottom:1px solid black; overflow:hidden; margin:0; padding:0;}
.Row input{background:none; border-width:1px; font:inherit; margin:0; padding:0; outline-width:1px;}
.RowItem{float:left; margin:0; padding:0; border-right:1px solid black; height:100%; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;/**/}

</style>
<style media="screen">
	.MenuBtn{background-position:center; cursor:default; height:100%; text-align:center; width:2.5%; padding:1px 0 0 1px;}
	.MenuBtn:hover{background-color:#00FFFF; border:outset 1px; padding:0;}
	.MenuBtn:active{background-color:#008888; border:inset 1px; padding:0;}
	.SelItem{ height:100%; text-align:center; width:2.5%;}
	.ItemQty{ width:5%;}
</style>
<style media="print">
	.MenuBtn{ width:0; display:none;}
	.SelItem{ width:2.5; height:1px; overflow:hidden; display:inline;}
	.ItemQty{ width:7%;}
</style>

<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>
<script type="text/javascript">
var Append1=false;
function RowMenu(Row,POItemsID)
{
	PGebi('ItemMenu').style.top=(Row.offsetTop+PGebi('itemsFrame').offsetTop+Row.offsetHeight-2)+'px';
	PGebi('ItemMenu').style.display='block';
	PGebi('ItemMenuPOItemsID').value=POItemsID;
}

function RowUnMenu()
{
	PGebi('ItemMenu').style.display='none';
}

var bodyOnClickEnabled=true;
</script>
</head>

<body onclick="if(bodyOnClickEnabled){	PGebi('ItemMenu').style.display='none';	} else {bodyOnClickEnabled=true;}">
<%
POID=Request.QueryString("POID")

If IsNull(POID) Or POID ="" Then Response.End()

SQL="SELECT * FROM POItems WHERE POID="&POID
Set rs=Server.CreateObject("AdoDB.RecordSet")
rs.Open SQL, REDConnString

Dim Parts(320,5)
PartsI=0
Do Until rs.EOF
	PartsI=PartsI+1
	Parts(PartsI,0)=rs("POItemsID")
	Parts(PartsI,1)=rs("Qty")
	Parts(PartsI,2)=rs("PartNumber")
	Parts(PartsI,3)=rs("Description")
	Parts(PartsI,4)=rs("Cost")
	Parts(PartsI,5)=rs("Cost")*rs("Qty")
	rs.MoveNext
Loop

Max=15
SubTotal=0
BColor="background-color:#EFF;"
For P=1 To PartsI
	SubTotal=SubTotal+Parts(P,5)
	
	'alternating colors:
	If BColor="background-color:#EFF;" Then BColor="background-color:#FFF;" Else BColor="background-color:#EFF;"
	
	AppendIframe=False
	If P>Max Then
		%><div id="partRow<%=P%>" class="Row" style="font-size:100%; <%=BColor%>" >Continued on next page.<div class=RowItem style="width:12.5%; float:right; border-right:none;"><%=Parts(P,5)%>&nbsp;</div></div><%
		'Now I wanna append an Iframe for the next page.
		AppendIframe=True
		
		'We've hit the max for this page so were done with the For loop now.
		'Except we still want the total cost so:
		For theRest= P to PartsI
			SubTotal=SubTotal+Parts(theRest,5)
		Next
		
		Exit For
	End If

	%><div id="partRow<%=P%>" class="Row" style="font-size:100%; <%=BColor%>" ><label class="RowItem SelItem"><input id="Sel<%=Parts(P,0)%>" type="checkbox"/></label><div class="RowItem MenuBtn" onClick="RowMenu(this.parentNode,<%=Parts(P,0)%>); bodyOnClickEnabled=false;"><small>▼</small></div><input id="Qty<%=Parts(P,0)%>" class="RowItem ItemQty" value="<%=Parts(P,1)%>"/><div class=RowItem style="width:18%;"><%=Parts(P,2)%>&nbsp;</div><div class=RowItem style="width:48%;"><%=Parts(P,3)%>&nbsp;</div><div class=RowItem style="width:12%;"><%=Parts(P,4)%>&nbsp;</div></div><%
	
Next

If AppendIframe Then
	%>
	<script type="text/javascript">
		if(!Append1)
		{
			//How do I make this code execute only once?
			//parent.document.body.innerHTML+='<iframe src="POItemsPage.asp?POID=<%=POID%>&Start=<%=Max+1%>"></iframe>';
			Append1=true;
		}
	</script>
	<%
End If
%>

</body>

</html>
