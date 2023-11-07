<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Labor Interface</title>
<!--#include file="../TMC/RED.asp" -->
<%
	SearchName=request.QueryString("SearchName")
	SearchTxt=request.QueryString("SearchTxt")
	MaxResults=request.QueryString("MaxResults")
  if MaxResults<=0 or MaxResults="" then MaxResults=256
	
	If SearchName="" Or SearchTxt="" Or IsNull(SearchName) Or  IsNull(SearchTxt) Then Response.End()
	
	SearchFields=Split(SearchName,",")
	
%>
<script type="text/javascript" src="Modules/rcstri.js"></script>
<script type="text/javascript" src="Library/SqlAjax.js"></script>
<script type="text/javascript" src="Bid/LaborInterface.js"></script>


<link rel="stylesheet" href="Library/CSS_DEFAULTS.css" media="screen">
<style>
html{width:100%; height:100%; padding:0; margin:0;}
body{width:100%; height:100%; padding:0 0 0 0; margin:0; overflow-x:hidden; overflow-y:scroll;}

#AboveHeadItems{width:18px; height:10%; max-height:32px; background:#dff; border:1px solid #000; border-left:none; position:absolute; top:0; right:0; z-index:2000;}
#UnderHeadItems{width:100%; height:10%; max-height:32px;}

#ListBox{ border:1px solid #000; border-top-color:rgba(0,0,0,0); float:left; width:100%; height:90%;}

/*Labor Search Box Items ////////////////////////////////////////////////////*/
.ItemRow { height:28px; width:100%; float:left; overflow:hidden; position:relative; white-space:nowrap; background:rgba(255,255,255,.75); border: 1px solid rgba(0,0,0,.5); border-top:none; }
.ItemRow:hover {
background:-moz-linear-gradient(center top, #eff, #eff 50%, #dff 95%, #9ff); 
background:-webkit-gradient(linear,0 0,0 100%, from(#eff),color-stop(.5, #eff), color-stop(.95, #dff), to(#9ff)); 
}
.Item {float:left; height:100%; overflow:hidden; white-space:nowrap; text-overflow:ellipsis; margin:0; padding:0; font-family:Arial,Helvetica,sans-serif; font-size:12px; font-weight:normal; text-align:left; color:#000; border-left: 1px solid #000; }
.Item button{width:100%; height:100%;}
.ItemAdd {height:100%; margin:auto auto auto auto; padding:0; position:static; font-family: Arial,Helvetica,sans-serif; font-size:10px; font-weight:normal; text-align:center; color:#000; }

</style>
</head>

<body onLoad="parent.resize();">

<!--
<div id="AboveHeadItems">&nbsp;</div> 
<div id=HeadItems>
  <div class="HeadItem " style="width:4%; border-left:none; font-weight:normal; font-size:12px;">Add</div>
  <div class="HeadItem " style="width:4%; font-weight:normal; font-size:12px; ">Edit</div>
  <div class="HeadItem " style="width:7%; font-weight:normal; font-size:12px; ">Catalog#</div>
  <div class="HeadItem " style="width:12%; ">Manufacturer</div>
  <div class="HeadItem " style="width:15%; ">LaborNumber</div>
  <div class="HeadItem " style="width:10%; ">Model</div>
  <div class="HeadItem " style="width:38%; ">Description</div>
  <div class="HeadItem " style="width:10%; ">Cost</div>
  <div class="HeadItem " style="width:10%; height:110%; ">&nbsp;</div>
</div>
<!-- div id=UnderHeadItems></div -->

	<%
'<div id=ListBox>    
	Where=""
  For i=0 to uBound(SearchFields)
		If Where <> "" Then Where=Where&" OR "
		Where=Where&SearchFields(i)&" LIKE '%"&SearchTxt&"%'"
	Next
	
  SQL = "SELECT LaborID, Name, Description, RateCost, Category FROM Labor WHERE "&Where&" ORDER BY "&SearchFields(0)
  %><%'=SQL%><%
  set rs=Server.CreateObject("ADODB.Recordset")
  rs.Open SQL, REDconnstring	
  
  lIdColor = "000"  
  CatColor = "000"  
  ModelColor = "000"  
  LaborColor = "000"  
  DescColor = "000"  
  
  rNum=0 : MaxReached=False
  Do Until rs.EOF Or MaxReached 
    rNum=rNum+1
    
    lID=rs("LaborID")
    lName=(rs("Name")): If lName="" Then lName="&nbsp;"
    Cat=(rs("Category")): If Cat="" Then Cat="&nbsp;"
    Desc=(rs("Description")): If Desc="" Then Desc="&nbsp;"
    Cost=formatCurrency(rs("RateCost")): If Cost="" Then Cost="$0.00"
    
    If Instr(lcase(lID),lcase(SearchTxt) ) Then lIdColor = "00c" 
    If Instr(lcase(Cat),lcase(SearchTxt) ) Then CatColor = "00c" 
    If Instr(lcase(lName),lcase(SearchTxt) ) Then LaborColor = "00c" 
    If Instr(lcase(Desc),lcase(SearchTxt) ) Then DescColor = "00c" 
    
    %>
    <div id="Labor<%=rNum%>" class="ItemRow borderSizing" >
      <input id=laborIdRow<%=lID%> type="hidden" value="<%=rNum%>" />
      <input id=rowLaborId<%=rNum%> type="hidden" value="<%=lID%>" />
      <span class="Item " style="width:4%; border-left:none; opacity:<%=session("AddOpacity")%>" onselectstart="return false;">
        <div class="ItemAdd ToolbarButton" onClick="parent.parent.AddLabor(<%=lID%>);">
        	<img id=imgAddPic style="display:none;" src="../Images/check_64.png" />
        	<img id=imgAddHover style="display:none;" src="../Images/check_64-bold.png" />
        	<img id=imgAdd src="../Images/check_64.png" height="24" width="24" onMouseOver="this.src=Gebi('imgAddHover').src;" onMouseOut="this.src=Gebi('imgAddPic').src;" />
        </div>
      </span>
      <span class="Item borderSizing" style="width:4%; border-left:" onselectstart="return false;">
        <div class="ItemAdd ToolbarButton taC" id=bEdit<%=rNum%> onClick="parent.EditLabor('<%=lID&","&rNum&","&lName&","&Cost&","&Desc%>');">
        	<img id=imgEditPic style="display:none;" src="../Images/Pencil_64.png" />
        	<img id=imgEditHover style="display:none;" src="../Images/Pencil_64-bold.png" />
        	<img id=imgEdit src="../Images/Pencil_64.png" height="24" width="24" onMouseOver="this.src=Gebi('imgEditHover').src;" onMouseOut="this.src=Gebi('imgEditPic').src;" />
				</div>
      </span>
      <span class="Item taRi" id=PiD<%=rNum%>  style="width:7%; color:#<%=lIdColor%>; font-family:Consolas, 'Courier New', monospace;"><%=lId%></span>
      <span class="Item " id=Cat<%=rNum%>      style="width:12%; color:#<%=CatColor%>;"><%=DecodeChars(Cat)%></span>
      <span class="Item " id=lName<%=rNum%>    style="width:15%; color:#<%=LaborColor%>;"><%=DecodeChars(lName)%></span>
      <span class="Item " id=Desc<%=rNum%>     style="width:48%; color:#<%=DescColor%>;"><%=DecodeChars(Desc)%></span>
      <span class="Item taRi" id=Cost<%=rNum%> style="width:10%; font-family:Consolas, 'Courier New', Courier, monospace;"><%=Cost%></span>
    </div>
    <%
    Response.Flush()
		
		MaxReached=(rNum>=MaxResults)
    rs.MoveNext 
  Loop
  Set rs = nothing
	MaxNotice=""
	if MaxReached Then MaxNotice="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Maximum of "&MaxResults&" results shown.  Refine your search if necessary."				 
  %>
  <div id="ResultCount" class="ItemRow" style="background:none; border:none;" >Found <%=rNum%> Matches. <%=MaxNotice%></div>

<%
'</div>
%>

</body>
</html>