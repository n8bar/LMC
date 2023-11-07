<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Purchase Orders</title>

<!--#include file="../../TMC/RED.asp" -->

<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="../Library/SqlAjax.js"></script>
<script type="text/javascript" src="../Library/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="PurchaseOrdersAJAX.js"></script>
<%
	ProjID=Request.QueryString("ProjID")
%>
<script>
	var ProjID=<%=ProjID%>;
	
	function resize()
	{
		Gebi('List').style.height=(document.body.offsetHeight-Gebi('List').offsetTop-3)+'px';
	}
	
	function ShowNewPOBox()
	{
		Gebi('Modal').style.display='block';
		Gebi('NewPOBox').style.display='block';
		Gebi('Create').disabled=true;
		Gebi('NewVendor').selectedIndex=0;
	}
	
	function CheckAll(c)
	{
		var Inputs=Gebi('List').contentDocument.getElementsByTagName('input');
		for(i=0;i<Inputs.length;i++)
		{
			if(Inputs[i].type=='checkbox')
			{
				Inputs[i].checked=c;
			}
		}
	}
</script>

<style>
html{width:100%; height:100%; margin:0; padding:8px 0 0 0; text-align:center; background:White; overflow:hidden; }
body{width:100%; height:100%; margin:0; padding:0; text-align:center; position:absolute; font-family:Verdana; font-size:13px }

div,img,.textBox,label,span,select,textarea,iframe{padding:0; margin:0; -webkit-box-sizing:border-box; -moz-box-sizing:border-box; outline:none;}
.textBox,select{border:#FFF 1px solid; border-bottom:#000 1px solid; background:none; outline:none;}

h1{height:48px; margin:0;}
h4{height:28px; margin:0;}
h2{height:36px; margin:0;}

button{font-size:14px; color:#000; font-weight:normal; padding:0 2px 2px 1px; /** / background:-webkit-gradient( linear,0 0,0 100%,from(#F6F6F6),to(#CCC)); border-width:1px; border-radius:8px;/**/}
/** /button:hover{ background:-webkit-gradient( linear,0 0,0 100%,from(#FFF),to(#DDD));}/**/

button img{float:left; vertical-align:middle;}
button div{float:left; height:100%; vertical-align:middle;}

.vPadding3{width:100%; height:3px;}

#Modal{position:absolute; top:-8px; left:0; display:none; background:#466; filter:alpha(opacity=50); opacity:0.5; width:100%; height:100%; margin:0; z-index:5000;}

#NewPOBox{position:absolute; top:33%; left:33%; width:384px; height:192px; display:none; z-index:6000; border-radius:8px;	background:#E1FFFF;
	background-image:-webkit-gradient(linear, 0 0, 0 100%, from(#E1FFFF), /** /Color-Stop(.3, rgba(255,255,255,.5)),/**/ to(#C6FFFF));
	background-image:-moz-linear-gradient(top, #E1FFFF, #C6FFFF);
	}
	#NewPOTitle{width:100%; height:24px; font-size:18px; border-top-right-radius:8px; border-top-left-radius:7px;
	background:#00D5D5;
	background-image:-webkit-gradient(linear, 0 0, 0 100%, from(#8CFFFF), /** /Color-Stop(.3, rgba(255,255,255,.5)),/**/ to(#00D5D5));
	background-image:-moz-linear-gradient(top, #8CFFFF, /** /Color-Stop(.3, rgba(255,255,255,.5)),/**/ #00D5D5);
	}
	#lNewVendor{margin:0; padding:0; height:16px;}
	#NewVendor{border-radius:6px; -webkit-box-sizing:border-box; -moz-box-sizing:border-box; border:1px #000 solid; width:192px; height:100%; outline:none; background:none; margin:0; padding:0;}
	#lNewDate{margin:0; padding:0; height:16px;}
	#NewDate{border-radius:6px; -webkit-box-sizing:border-box; -moz-box-sizing:border-box; border:1px #000 solid; width:96px; height:100%; outline:none; background:none; margin:0; padding:0;}
	#NewDateImg{cursor:pointer; position:relative; top:2px;}
	#Create{display:inline; }
	#CancelNew{display:inline; }


#PageHead{position:absolute; top:24px; width:100%; height:120px; background:-webkit-gradient( linear,0 0,0 100%,to(#FFF),from(#CEE));}

	#Back{}
	#ReloadFrame {float:right; font-size:18px; height:24px; width:24px; margin:0px; padding:0px; position:relative; text-align:center; top:1px; vertical-align:top; }
	
	
#Head{position:absolute; top:160px; width:80%; height:24px; margin-left:10%;}
	.HeadItem{border:1px solid #555; display:inline; margin:0; padding:0; float:left; overflow:hidden; height:100%;}
	#hEdit{width:3%;}
	#hDel{width:3%;}
	#hDate{width:10%;}
	#hVendor{width:27%;}
	#hPONum{width:50%;}
	#hRepNo{width:7%;}
#List{position:absolute; top:184px; left:10%; width:80%; overflow:hidden;}
</style>

<link type="text/css" rel="stylesheet" href="../Library/CSS_DEFAULTS.css" media="screen">
<link type="text/css" rel="stylesheet" href="../Library/dhtmlgoodies_calendar.css?random=20051112" media="screen">

</head>

<body onLoad="resize();" onResize="resize();">
<%
	'Dim rsProj
	
	

	
	SQL="SELECT * FROM Projects WHERE ProjID="&ProjID
	Set rsProj=Server.CreateObject("ADODB.Recordset")
	rsProj.Open SQL, REDconnstring
	
	ProjName=DecodeChars(rsProj("ProjName"))
	BomIsGenerated=rsProj("BomIsGenerated")
	
	Set rsProj=Nothing
%>

<div id=Modal></div>

<div id=NewPOBox class="WindowBox">
	<div id=NewPOTitle>New P.O. for: &nbsp; <small><small><%=ProjName%></small></small></div>
	<br/>
	<br/>
	<label id=lNewVendor for=NewDate>Vendor:</label>
	<select id=NewVendor onChange="if(this.value!=''){Gebi('Create').disabled=false; Gebi('Create').focus();}">
		<option id="Vend0" value="" selected>Select Vendor:</option>
		<%
		SQL1="SELECT CustID,Name FROM Customers WHERE Vendor=1 ORDER BY Name"
		Set rs1=Server.CreateObject("AdoDB.RecordSet")
		rs1.Open SQL1, REDConnString
		
		Do Until rs1.EOF
			%>
			<option id="Vend<%=rs1("CustID")%>" value="<%=rs1("CustID")%>"><%=rs1("Name")%></option>
			<%
			rs1.MoveNext
		Loop
		%>
	</select>
	<!--
	<label id=lNewDate for=NewDate>Date:</label>
	<input id=NewDate onFocus="displayCalendar('NewDate','mm/dd/yyyy',NewDate);" onChange="if(this.value!=''){Gebi('Create').disabled=false; Gebi('Create').focus();}"/>
	
	<img id=NewDateImg onClick="displayCalendar('NewDate','mm/dd/yyyy',NewDate);" src="Images/cal.gif">
	-->
	<br/>
	<br/>
	<br/>
	<br/>
	<button id=Create onClick="NewPO(SelI('NewVendor').value,<%=ProjID%>);">Create</button>
	<button id=CancelNew onClick="Gebi('Modal').style.display='none'; Gebi('NewPOBox').style.display='none';">Cancel</button>
</div>

<div id=PageHead>
    <h1><big>Purchase Orders</big></h1>
    <h4>for</h4>
    <h2><%=ProjName%></h2>
</div>
    
<div id=Toolbar class="Toolbar" style="position:relative; top:-8px;" align=Left>
	<button id="ReloadFrame" onClick="window.location=window.location"><img src="../images/reloadblue24.png" width="100%" height="100%"></button>
	
	<button id=Back onClick="PGebi('PurchasingIframe').src='Purchase.html';"><img style="width:16px; height:16px;" src="../images/GreenLeftTriangle.png"/><div>Back 2 Purchasing Jobs</div></button>
	<span class="tSpacerLine" style="position:relative; top:-4px; margin-right:5px;"></span>
	<button id=New onClick="ShowNewPOBox();"><img id=imgPlus src="../images/plus_16.png"/><div>New</div></button>
	<%
	If BomIsGenerated="True" Then%><button id=New onClick="GeneratePOs(<%=ProjID%>);"><img id=imgPlus src="../images/plus_16.png"/><div>Generate P.O.'s from Bill of Materials.</div></button>
	<%End If%>
    <button id=New onClick="DelSelected();"><img id=imgMinus src="../images/minus_16.png"/><div>Delete Selected</div></button>
</div>

<div id=Head align=Center>
	<span id=hDel class=HeadItem>
    	<span class="vPadding3"></span><input type="checkbox" onClick="CheckAll(this.checked);"/></span>
	<span id=hEdit class=HeadItem><span class="vPadding3"></span><small>Edit</small></span>
	<span id=hDate class=HeadItem><span class="vPadding3"></span>Date</span>
	<span id=hVendor class=HeadItem><span class="vPadding3"></span>Vendor</span>
	<span id=hPONum class=HeadItem><span class="vPadding3"></span>PO Number</span>
	<span id=hRepNo class=HeadItem><span class="vPadding3"></span><small>PO&nbsp;ID#</small></span>
</div>

<iframe frameborder="0" id=List src="POList.asp?ProjID=<%=ProjID%>"></iframe>

</body>

</html>