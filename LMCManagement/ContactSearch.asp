<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Contacts Search List</title>
<!--#include file="../LMC/RED.asp" -->
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
<script type="text/javascript" src="Contacts/ContactsInterface.js"></script>


<link rel="stylesheet" href="Library/CSS_DEFAULTS.css" media="screen">
<style>
html{width:100%; height:100%; padding:0; margin:0;}
body{width:100%; height:100%; padding:0 0 0 0; margin:0; overflow-x:hidden; overflow-y:scroll;}

#AboveHeadItems{width:18px; height:10%; max-height:32px; background:#dff; border:1px solid #000; border-left:none; position:absolute; top:0; right:0; z-index:2000;}
#UnderHeadItems{width:100%; height:10%; max-height:32px;}

#ListBox{ border:1px solid #000; border-top-color:rgba(0,0,0,0); float:left; width:100%; height:90%;}

/*Contacts Search Box Items ////////////////////////////////////////////////////*/
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

<body onLoad="parent.resize(); parent.HeadItems.style.width=contact1.offsetWidth+('px');">

<!--
<div id="AboveHeadItems">&nbsp;</div> 
<div id=HeadItems>
  <div class="HeadItem " style="width:4%; border-left:none; font-weight:normal; font-size:12px;">Add</div>
  <div class="HeadItem " style="width:4%; font-weight:normal; font-size:12px; ">Edit</div>
  <div class="HeadItem " style="width:7%; font-weight:normal; font-size:12px; ">Catalog#</div>
  <div class="HeadItem " style="width:12%; ">Name</div>
  <div class="HeadItem " style="width:15%; ">ContactNumber</div>
  <div class="HeadItem " style="width:10%; ">City</div>
  <div class="HeadItem " style="width:38%; ">Notesription</div>
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
	
  SQL = "SELECT ID, Name, Phone1, Address+'<br/>'+City+' '+State+' '+Zip AS Addr, City Notes FROM Contacts WHERE "&Where&" ORDER BY "&SearchFields(0)
  %><%'=SQL%><%
  set rs=Server.CreateObject("ADODB.Recordset")
  rs.Open SQL, REDconnstring	
  
  cIDColor = "000"  
  NameColor = "000"  
  PhoneColor = "000"  
  CityColor = "000"  
  NotesColor = "000"  
  
  rNum=0 : MaxReached=False
  Do Until rs.EOF Or MaxReached 
    rNum=rNum+1
    
    cID=rs("ID")
    cPhone=(rs("Phone1")): If cPhone="" Then cPhone="&nbsp;"
    cName=(rs("Name")): If cName="" Then cName="&nbsp;"
    Addr=(rs("Addr")): If Addr="" Then Addr="&nbsp;"
    Notes=(rs("Notes")): If Notes="" Then Notes="&nbsp;"
    If Cost="" OR IsNull(Cost) Then Cost=0
		%><%'=""""&Cost&""""%><%
		Cost=formatCurrency(Cost) 
    
    If Instr(lcase(cID),lcase(SearchTxt) ) Then cIDColor = "00c" 
    If Instr(lcase(cName),lcase(SearchTxt) ) Then NameColor = "00c" 
    If Instr(lcase(City),lcase(SearchTxt) ) Then CityColor = "00c" 
    If Instr(lcase(cPhone),lcase(SearchTxt) ) Then PhoneColor = "00c" 
    If Instr(lcase(Notes),lcase(SearchTxt) ) Then NotesColor = "00c" 
    
    %>
    <div id="contact<%=rNum%>" class="ItemRow borderSizing" >
      <input id=contactIdRow<%=cID%> type="hidden" value="<%=rNum%>" />
      <input id=rowContactId<%=rNum%> type="hidden" value="<%=cID%>" />
      <span class="Item " style="width:4%; border-left:none; opacity:<%=session("AddOpacity")%>" onselectstart="return false;">
        <div class="ItemAdd ToolbarButton" onClick="parent.parent.receiveContactLinkInfo(<%=cID%>,<%=cName%>);">
        	<img id=imgAddPic style="display:none;" src="../Images/check_64.png" />
        	<img id=imgAddHover style="display:none;" src="../Images/check_64-bold.png" />
        	<img id=imgAdd src="../Images/check_64.png" height="24" width="24" onMouseOver="this.src=Gebi('imgAddHover').src;" onMouseOut="this.src=Gebi('imgAddPic').src;" />
        </div>
      </span>
      <!-- span class="Item borderSizing" style="width:4%; border-left:" onselectstart="return false;">
        <div class="ItemAdd ToolbarButton taC" id=bEdit< %=rNum%> onClick="parent.EditContact('< %=cID&","&rNum&","&City&","&cPhone&","&Cost&","&Notes%>');">
        	<img id=imgEditPic style="display:none;" src="../Images/Pencil_64.png" />
        	<img id=imgEditHover style="display:none;" src="../Images/Pencil_64-bold.png" />
        	<img id=imgEdit src="../Images/Pencil_64.png" height="24" width="24" onMouseOver="this.src=Gebi('imgEditHover').src;" onMouseOut="this.src=Gebi('imgEditPic').src;" />
				</div>
      </span -->
      <!-- span class="Item taRi" id=cID< %=rNum%>  style="width:7%; color:#<%=cIDColor%>; font-family:Consolas, 'Courier New', monospace;">< %=cID%></span -->
      <span class="Item " id=Name<%=rNum%>  style="width:29%; color:#<%=NameColor%>;  font-size:20px; line-height:28px;"  ><%=DecodeChars(cName)%></span> 
      <span class="Item " id=Phone<%=rNum%> style="width:12%; color:#<%=PhoneColor%>; font-size:16px; font-family:Narrow;"><%=Phone(cPhone)%></span> 
      <span class="Item " id=City<%=rNum%>  style="width:30%; color:#<%=CityColor%>;  font-size:14px; font-family:Narrow; line-height:13px;" ><%=DecodeChars(Addr)%></span>
      <span class="Item " id=Notes<%=rNum%> style="width:25%; color:#<%=NotesColor%>; font-size:10px; line-height:8px; font-family:Condensed"><%=DecodeChars(Notes)%></span>
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