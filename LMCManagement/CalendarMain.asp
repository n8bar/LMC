<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html>
<head>

<title>Tricom Management Center</title>

<!--  #include file="Common.asp"  -->
<%nc=LoadStamp%>
<script type="text/javascript" src="Modules/rcstri.js?nc=<%=nc%>" ></script>
<script type="text/javascript" src="Calendar/CalendarMain-JS.js?nc=<%=nc%>" ></script>
<script type="text/javascript" src="Calendar/CalendarCreate.js?nc=<%=nc%>" ></script>
<script type="text/javascript" src="Calendar/CalendarJS.js?nc=<%=nc%>" ></script>
<script type="text/javascript" src="Calendar/CalendarAJAX.js?nc=<%=nc%>" ></script>
<script type="text/javascript" src="Modules/DragNDropJS.js?nc=<%=nc%>" ></script>
<script type="text/javascript" src="Library/dhtmlgoodies_calendar.js?nc=<%=nc%>" ></script>

<script>//alert('finished JavaScript Libraries!');</script>

<script type="text/javascript" >var mX; var mY; </script>

<link rel=stylesheet href="Library/CSS_DEFAULTS.css" media=screen >
<link rel=stylesheet href="Calendar/CalendarCSS.css?nc=<%=nc%>" media=screen >
<link rel=stylesheet href="Calendar/CalendarMain-CSS.css?nc=<%=nc%>" media=screen >
<link type="text/css" rel="stylesheet" href="Library/dhtmlgoodies_calendar.css?random=20051112<%=nc%>" media=screen >

</head>

<body class=body onLoad="/*alert('startingOnLoad procedures'); setTimeout('Resize();',150);/**/ onLoad(); " onResize="Resize(); Gebi('ModalScreen').style.display='none'; " onmousemove="mX=parent.mX; mY=parent.mY;" onkeyup="" >

<div id=ModalScreen class=ModalScreen ></div>
<div id=HoverNotes class=HoverNotes onMouseOver="this.style.visibility='hidden';" ></div>

<div id=CalendarMain class=CalendarMain >
<div id=calDivDot>&nbsp;</div>

<div id=CalendarContainer >
	<div align="center" valign="top" id="CalendarLeftContainer" class="CalendarLeftContainer">
		<div class="ViewsTabs">
		
			<div id="MonthsTab" onMouseUp="tab(this);" class=vTab >Months</div>
			<div id="ViewsTab"  onMouseUp="tab(this);" class=vTab>Views</div>
			<div id="EventListTab" onMouseUp="tab(this);" class=selVTab>ToDo</div>
		</div>
		
		<div class="ViewsTabsBottom"></div>
	
	 
<!-- Views----------------------------------------Views Tab------------------------------------------------------------------ -->    
		<%
		Session("eventListFrom0")="1/1/1900"
		Session("eventListTo0")=Date
		src="EventList.asp?Type=0&condense=1&jsLink=LoadExistingEvent&user=1&CHeading=<br/>Tasks for <b>"&Replace(Session("User"),"Conference","Everyone")&"</b> up to Today."
		%>
		<iframe class=vTabBox id=EventList src="<%=src%>" style="display:block; padding:0; border:none;" ></iframe>
		<div id=Views class=vTabBox >
			<div class=ViewsBox style="height:50%;">
			<div class=ViewsHeader style="">Detailed View</div>
			<div class=ViewDetailBox>
				<div class=ViewListTitle>Attention:</div> 
				<div class=ViewListItem align=left>
					<%    
					SQL = "select EmpID, FName, LName from Employees WHERE Active=1 ORDER BY FName, LName" 
					set rs=Server.CreateObject("ADODB.Recordset")
					rs.Open SQL, REDconnstring 
					%>
					<select class="ViewListMenu" name="ViewAttn" id="ViewAttn" >
						<option value="0" Selected ></option>
						<%
	Do Until rs.EOF
		%>
						<option  value="<%= rs("EmpID")%>"><%= rs("Fname")&" "&rs("Lname")%></option>
						<%   
						rs.MoveNext
						Loop
						set rs = nothing
						%>
					</select> 
					</div>
								
					<div class="ViewListTitle">Task:</div> 
					<div class="ViewListItem" >
						<%    
						SQL = "select TaskID, TaskName from Tasks order by TaskID" 
						set rs=Server.CreateObject("ADODB.Recordset")
						rs.Open SQL, REDconnstring 
						%>            
						<select class="ViewListMenu" name="ViewTask" id="ViewTask" onChange="">
							<option value="0"Selected></option>
							<%
	Do Until rs.EOF
		%>
								<option  value="<%= rs("TaskID")%>"><%= rs("TaskName")%></option>
								<%   
								rs.MoveNext
							Loop
							set rs = nothing
							%>
						 </select> 
					</div>
								
					<div class="ViewListTitle">Project Manager:</div> 
					<div class="ViewListItem" >
						<%    
						SQL = "select EmpID, FName, LName from Employees WHERE Active=1" 
						set rs=Server.CreateObject("ADODB.Recordset")
						rs.Open SQL, REDconnstring 
						%>            
						<select class="ViewListMenu" name="ViewPM" id="ViewPM">
							<option value="0"Selected></option>
							<%
	Do Until rs.EOF
		%>
								<option  value="<%= rs("EmpID")%>"><%= rs("Fname")&" "&rs("Lname")%></option>
								<%   
								rs.MoveNext
							Loop
							set rs = nothing
							%>
						</select> 
					</div>
								
					<div class="ViewListTitle">Area:</div>
					<div class="ViewListItem">
						<%    
						'SQL = "select AreaID, AreaDescription from Area" 
						'set rs=Server.CreateObject("ADODB.Recordset")
						'rs.Open SQL, REDconnstring 
						%>            
						<select class="ViewListMenu" name="ViewArea" id="ViewArea">
						<option value="0"Selected></option>
						<%
	'Do Until rs.EOF
		%>
							<!-- option  value="< %= rs("AreaID")%>">< %= rs("AreaDescription")%></option -->
							<%   
							'rs.MoveNext
						'Loop
					set rs = nothing
					%>
					</select> 
					</div>
					
					<div class="ViewListTitle">Phase:</div>
					<div class="ViewListItem">
						<%    
						SQL = "select PhaseID, PhaseName from Phase" 
						set rs=Server.CreateObject("ADODB.Recordset")
						rs.Open SQL, REDconnstring 
						%>
						<select class="ViewListMenu" name="ViewPhase" id="ViewPhase">
						<option value="0"selected></option>
						<%
	Do Until rs.EOF
		%>
							<option  value="<%= rs("PhaseID")%>"><%= rs("PhaseName")%></option>
							<%   
							rs.MoveNext
						Loop
						set rs = nothing
						%>
						</select>
					</div> 
					<div class="ViewListTitle">Customer:</div>
					<div class="ViewListItem">              
						<%    
						SQL = "select ID, Name from Contacts WHERE Customer!=0 order by Name" 
						set rs=Server.CreateObject("ADODB.Recordset")
						rs.Open SQL, REDconnstring 
						%>
						<select class="ViewListMenu" name="ViewCustomer" id="ViewCustomer" >
						<option value="0"selected="selected"></option>
						<%
	Do Until rs.EOF
		%>
							<option  value="<%= rs("ID")%>"><%= rs("Name")%></option>
							<%   
							rs.MoveNext
						Loop
						set rs = nothing
						%>
						</select>
					</div> 
													
					<div class="ViewListTitle"></div>
	
					<div class="ViewListButtons">
						<div style="float:left;"><input name="ClearBtn" type="button" value="Clear" onClick="ClearViews()"></div>
						<div style="float:left; margin:0 0 0 10px;"><input name=AllBtn type=button value=" All " onClick="QuickView('')"></div>
						<div style="float:right;"><input name="ViewBtn" type="button" value="Show" onClick="DetailView()"></div>
					</div>  
				</div>	
			</div> 
			
			 
			<div class=ViewsBox style="height:45%;">
				<div class=ViewsHeader>QuickView</div>
					<div class="QuickViewItems" style="border:none;">&nbsp;</div>
					<div class="QuickViewItems" onClick="QuickView('');">
						<div class="QuickViewTxt">
							<div class=QuickViewBtn >Show All</div>
							<!-- div class=QuickViewBtnLabel style="background:#FFF;color:#000;">#</div -->
						</div>
					</div>
					<%    
					SQL = "SELECT TaskID, OrderNum, BgColor, TextColor, TaskName FROM Tasks WHERE EnableCal>0 ORDER BY OrderNum" 
					set rs=Server.CreateObject("ADODB.Recordset")
					rs.Open SQL, REDconnstring
					
					Do Until rs.EOF
						tID=rs("TaskID")

						%>
						<div class="QuickViewItems" onClick="QuickView(<%=tID%>);">
							<div class=QuickViewTxt align="center">
								<!-- div class=QuickViewBtnLabel ><%=rs("OrderNum")%></div -->
								<div class=QuickViewBtn style="background:#<%=rs("BgColor")%>; color:#<%=rs("TextColor")%>;"><%=rs("TaskName")%></div>
							</div>
						</div>
						<% 
						rs.MoveNext
					Loop
					set rs = nothing
					%> 
			</div>     
		</div>
<!-- ----------------------------------------------------------------------------------------------------------------------- -->    
		<div id="Board" class="vTabBox">
			Dry Erase Board
			<button onClick="TestASP()">Click Me</button>
		</div>
		
		<div id="Alerts" class="vTabBox">
		</div>
		
		<div id="Months" class="vTabBox">
			
			<div id="Calendar2" style="position:relative; height:30%; width:100%; Border: 0px solid blue; z-index:1000;">
				<script language="JavaScript">
					//alert('begin defaults object construction');
				
					this.defaults2=
					({
						Format:'Popup', //Calendar or Popup
						SelectFunction:'PopupDayPlaner',//What Function is executed when a date is selected --DayClickHandler, PopupDayPlaner
						SetObject:'DateText',//The obect to which the popup writes when a date is selected
						threeMoControl:true,//For controling three side calendars to sync with the main

						// Turns the buttons and controlls on and off
						showControlBar:true,
						showDateSelect:false,
						showCreateBtn:false,
						showWeekBtn:false,
						showMonthBtn:false,
						showPrevNext:false,
						showToday:false,
						showWeekNumbers:true,
						showStatus:false,
						TodayText:' Td ',
		
						 // Sets the Button Styles
						fontButton:'Arial,Helvetica,sans-serif',
						colorButton:'#000',
						sizeButton:'10px',
						weightButton:'bold',
						heightButton:'18px',					
			
						// Sets the color schemes for the Calendar
						colorTopBG:'#55A9E8', // top control bar bg color
						colorTopOffBG:'#00F',
						colorCalendarBG:'#FFF', // Bg of all the days
						colorCalDayHeadersBG:'#DDD', //Bg of the top bar for each day
						colorTodayBG:'#FF5', // Bg of the today cell
						colorTodayTopBG:'#FF5',//Bg of the top bar for today
						colorCalOtherBG:'#EEE',// Bg of last month and next month cells
						colorCalOtherTopBG:'#DDD',//Bg of the top bar for last mo and this mo
						colorDayMouseOver:'#AAA', //BG of a day cell when the mouse hovers over it
						colorToDayMouseOver:'#00F',//BG of today cell when the mouse hovers over it
			
						// Borders
						borderMain:'1px solid #98CBF1', 
						borderWeekNames:'1px solid #98CBF1',
						borderDays:'1px solid #98CBF1', 
								
								
						 // Header Display Banner
						HeadingText:'Last Month',
						fontHead:'Arial,Helvetica,sans-serif',
						colorHead:'#000',
						sizeHead:'11px',
						fontHead:'Arial,Helvetica,sans-serif',
						weightHead:'bold',
						colorHeadBG:'#FFF',
						TextAlign:'left',
								
						// Month and Year Display at the top
						fontMonthYear:'Arial,Helvetica,sans-serif',
						colorMonthYear:'#FFF',
						hoverMonthYear:'#00F',
						sizeMonthYear:'11px',
						weightMonthYear:'bold',
			
								
						//Sets the DatePicker Styles
						fontPicker:'Arial,Helvetica,sans-serif',
						colorPicker:'#000',
						sizePicker:'11px',
						weightPicker:'normal',
						heightPicker:'18px',
			
								
						// Sets the CSS for the week Names M T W T F S
						sizeWeekNames:'10px',
						fontWeekNames:'Arial,Helvetica,sans-serif',
						colorWeekNames:'#000',
						colorWeekNamesBG:'#98CBF1',
						weightWeekNames:'bold',
						typeWeekNames:'short',//Sets long medium or short - Monday, Mon, M
			
				
						// Sets the CSS for the week number column down the L side
						sizeWeekNums:'8px',
						fontWeekNums:'Arial,Helvetica,sans-serif',
						colorWeekNums:'#000', 
						colorWeekNumsBG:'#C9E4F8',
						colorWeekNumsHover:'#55A9E8',
						weightWeekNums:'bold',
			
								
						 // Sets CSS for the date numbersS
						sizeDayNums:'10px',
						fontDayNums:'Arial,Helvetica,sans-serif',
						colorDayNums:'#09273E',
						weightDayNames:'bold'
					});
						
					Calendar(2,'minus',1); //(calendar instance,  plus or minus,  sets the month to this month -0, next month +1, last month -1 etc)

				</script>
			</div>  
						
			<br />

			<div id="Calendar3" style="position:relative; height:30%; width:100%; Border: 0px solid blue; z-index:1000;">
				<script language="JavaScript">
				this.defaults3=({
					Format:'Popup', //Calendar or Popup
					SelectFunction:'PopupDayPlaner',//What Function is executed when a date is selected --DayClickHandler, PopupSet
					SetObject:'DateText',//The obect to which the popup writes when a date is selected
					threeMoControl:true,//For controling three side calendars to sync with the main
					
					
					// Turns the buttons and controlls on and off
					showControlBar:true,
					showDateSelect:false,
					showCreateBtn:false,
					showWeekBtn:false,
					showMonthBtn:false,
					showPrevNext:false,
					showToday:false,
					showWeekNumbers:true,
					showStatus:false,
					TodayText:' Td ',
					
					// Sets the Button Styles
					fontButton:'Arial,Helvetica,sans-serif',
					colorButton:'#000',
					sizeButton:'10px',
					weightButton:'bold',
					heightButton:'18px',					
					
					// Sets the color schemes for the Calendar
					colorTopBG:'#55A9E8', // top control bar bg color
					colorTopOffBG:'#00F',
					colorCalendarBG:'#FFF', // Bg of all the days
					colorCalDayHeadersBG:'#DDD', //Bg of the top bar for each day
					colorTodayBG:'#FF5', // Bg of the today cell
					colorTodayTopBG:'#FF5',//Bg of the top bar for today
					colorCalOtherBG:'#EEE',// Bg of last month and next month cells
					colorCalOtherTopBG:'#DDD',//Bg of the top bar for last mo and this mo
					colorDayMouseOver:'#AAA', //BG of a day cell when the mouse hovers over it
					colorToDayMouseOver:'#00F',//BG of today cell when the mouse hovers over it
					
					// Borders
					borderMain:'1px solid #98CBF1', 
					borderWeekNames:'1px solid #98CBF1',
					borderDays:'1px solid #98CBF1', 
					
					
					// Header Display Banner
					HeadingText:'This Month',
					fontHead:'Arial,Helvetica,sans-serif',
					colorHead:'#000',
					sizeHead:'11px',
					fontHead:'Arial,Helvetica,sans-serif',
					weightHead:'bold',
					colorHeadBG:'#FFF',
					TextAlign:'left',
					
					// Month and Year Display at the top
					fontMonthYear:'Arial,Helvetica,sans-serif',
					colorMonthYear:'#FFF',
					hoverMonthYear:'#00F',
					sizeMonthYear:'11px',
					weightMonthYear:'bold',
					
					
					//Sets the DatePicker Styles
					fontPicker:'Arial,Helvetica,sans-serif',
					colorPicker:'#000',
					sizePicker:'11px',
					weightPicker:'normal',
					heightPicker:'18px',
					
					
					// Sets the CSS for the week Names M T W T F S
					sizeWeekNames:'10px',
					fontWeekNames:'Arial,Helvetica,sans-serif',
					colorWeekNames:'#000',
					colorWeekNamesBG:'#98CBF1',
					weightWeekNames:'bold',
					typeWeekNames:'short',//Sets long medium or short - Monday, Mon, M
					
					
					// Sets the CSS for the week number column down the L side
					sizeWeekNums:'8px',
					fontWeekNums:'Arial,Helvetica,sans-serif',
					colorWeekNums:'#000', 
					colorWeekNumsBG:'#C9E4F8',
					colorWeekNumsHover:'#55A9E8',
					weightWeekNums:'bold',
					
					
					// Sets CSS for the date numbersS
					sizeDayNums:'10px',
					fontDayNums:'Arial,Helvetica,sans-serif',
					colorDayNums:'#09273E',
					weightDayNames:'bold'
				});
				
				Calendar(3,'minus',0); //(calendar instance,  plus or minus,  sets the month to this month -0, next month +1, last month -1 etc)
				
				</script>
			</div> 

			<br>

			<div id="Calendar4" style="position:relative; height:30%; width:100%; Border: 0px solid blue; z-index:1000;">
				<script language="JavaScript">
				this.defaults4=({
					Format:'Popup', //Calendar or Popup
					SelectFunction:'PopupDayPlaner',//What Function is executed when a date is selected --DayClickHandler, PopupSet
					SetObject:'DateText',//The obect to which the popup writes when a date is selected
					threeMoControl:true,//For controling three side calendars to sync with the main
					
					
					// Turns the buttons and controlls on and off
					showControlBar:true,
					showDateSelect:false,
					showCreateBtn:false,
					showWeekBtn:false,
					showMonthBtn:false,
					showPrevNext:false,
					showToday:false,
					showWeekNumbers:true,
					showStatus:false,
					TodayText:' Td ',
					
					// Sets the Button Styles
					fontButton:'Arial,Helvetica,sans-serif',
					colorButton:'#000',
					sizeButton:'10px',
					weightButton:'bold',
					heightButton:'18px',					
					
					// Sets the color schemes for the Calendar
					colorTopBG:'#55A9E8', // top control bar bg color
					colorTopOffBG:'#00F',
					colorCalendarBG:'#FFF', // Bg of all the days
					colorCalDayHeadersBG:'#DDD', //Bg of the top bar for each day
					colorTodayBG:'#FF5', // Bg of the today cell
					colorTodayTopBG:'#FF5',//Bg of the top bar for today
					colorCalOtherBG:'#EEE',// Bg of last month and next month cells
					colorCalOtherTopBG:'#DDD',//Bg of the top bar for last mo and this mo
					colorDayMouseOver:'#AAA', //BG of a day cell when the mouse hovers over it
					colorToDayMouseOver:'#00F',//BG of today cell when the mouse hovers over it
					
					// Borders
					borderMain:'1px solid #98CBF1', 
					borderWeekNames:'1px solid #98CBF1',
					borderDays:'1px solid #98CBF1', 
					
					
					// Header Display Banner
					HeadingText:'Next Month',
					fontHead:'Arial,Helvetica,sans-serif',
					colorHead:'#000',
					sizeHead:'11px',
					fontHead:'Arial,Helvetica,sans-serif',
					weightHead:'bold',
					colorHeadBG:'#FFF',
					TextAlign:'left',
					
					// Month and Year Display at the top
					fontMonthYear:'Arial,Helvetica,sans-serif',
					colorMonthYear:'#FFF',
					hoverMonthYear:'#00F',
					sizeMonthYear:'11px',
					weightMonthYear:'bold',
					
					
					//Sets the DatePicker Styles
					fontPicker:'Arial,Helvetica,sans-serif',
					colorPicker:'#000',
					sizePicker:'11px',
					weightPicker:'normal',
					heightPicker:'18px',
					
					
					// Sets the CSS for the week Names M T W T F S
					sizeWeekNames:'10px',
					fontWeekNames:'Arial,Helvetica,sans-serif',
					colorWeekNames:'#000',
					colorWeekNamesBG:'#98CBF1',
					weightWeekNames:'bold',
					typeWeekNames:'short',//Sets long medium or short - Monday, Mon, M
					
					
					// Sets the CSS for the week number column down the L side
					sizeWeekNums:'8px',
					fontWeekNums:'Arial,Helvetica,sans-serif',
					colorWeekNums:'#000', 
					colorWeekNumsBG:'#C9E4F8',
					colorWeekNumsHover:'#55A9E8',
					weightWeekNums:'bold',
					
					
					// Sets CSS for the date numbersS
					sizeDayNums:'10px',
					fontDayNums:'Arial,Helvetica,sans-serif',
					colorDayNums:'#09273E',
					weightDayNames:'bold'
				});
				
				Calendar(4,'plus',1); //(calendar instance,  plus or minus,  sets the month to this month -0, next month +1, last month -1 etc)
				
				</script>
			</div>            
		</div> 
	</div>

	<div align="center" valign="top" class="CalendarMainContainer" id="CalendarMainContainer">
		<div id="CalendarPlaner" style="display:block; height:100%;">
			<div id="Calendar1" style="position:relative; height:100%; width:100%; top:1px; Border:0px solid blue; z-index:100; ">
				<script language="JavaScript">
					//alert(this);
					this.defaults1=({
						Format:'Calendar', /*Calendar or Popup/**/
						SelectFunction:'PopupSet',/*What Function is executed when a date is selected --DayClickHandler, PopupSet/**/
						SetObject:'DateText',/*The obect to which the popup writes when a date is selected/**/
						threeMoControl:true,/*For controling three side calendars to sync with the main/**/
						
						/* Turns the buttons and controlls on and off/**/
						showControlBar:true,
						showDateSelect:true,
						showCreateBtn:true,
						showWeekBtn:false,
						showMonthBtn:false,
						showPrevNext:true,
						showToday:true,
						showWeekNumbers:true,
						showStatus:true,
						TodayText:'Today',
						
						/* Sets the Button Styles/**/
						fontButton:'Arial,Helvetica,sans-serif',
						colorButton:'#000',
						sizeButton:'10px',
						weightButton:'bold',
						heightButton:'18px',					
						
						/* Sets the color schemes for the Calendar/**/
						colorTopBG:'#FFF', /* top control bar bg color/**/
						colorTopOffBG:'#00F',
						colorCalendarBG:'#FFF', /* Bg of all the days/**/
						colorCalDayHeadersBG:'#DDD', /*Bg of the top bar for each day/**/
						colorCalHeadersHover:'#CCC', /*Hover Color For Header Of Days/**/
						colorTodayBG:'#FF9', /* Bg of the today cell/**/
						colorTodayTopBG:'#FF9',/*Bg of the top bar for today/**/
						colorCalOtherBG:'#E5E5E5',/* Bg of last month and next month cells/**/
						colorCalOtherTopBG:'#DDD',/*Bg of the top bar for last mo and this mo/**/
						colorDayMouseOver:'#D5EBF9', /*BG of a day cell when the mouse hovers over it/**/
						colorToDayMouseOver:'#FF0',/*BG of today cell when the mouse hovers over it/**/
						
						/* Borders/**/
						borderMain:'1px solid #98CBF1', 
						borderWeekNames:'1px solid #98CBF1',
						borderDays:'1px solid #98CBF1', 
						
						
						/* Header Display Banner/**/
						HeadingText:'Monthly Planner',
						fontHead:'Arial,Helvetica,sans-serif',
						colorHead:'#000',
						sizeHead:'12px',
						fontHead:'Arial,Helvetica,sans-serif',
						weightHead:'bold',
						colorHeadBG:'#FFF',
						TextAlign:'center',
						
						/* Month and Year Display at the top/**/
						fontMonthYear:'Arial,Helvetica,sans-serif',
						colorMonthYear:'#000',
						hoverMonthYear:'#000',
						sizeMonthYear:'14px',
						weightMonthYear:'bold',
						
						
						/*Sets the DatePicker Styles/**/
						fontPicker:'Arial,Helvetica,sans-serif',
						colorPicker:'#000',
						sizePicker:'11px',
						weightPicker:'normal',
						heightPicker:'18px',
						
						
						/* Sets the CSS for the week Names M T W T F S/**/
						sizeWeekNames:'11px',
						fontWeekNames:'Arial,Helvetica,sans-serif',
						colorWeekNames:'#000',
						colorWeekNamesBG:'#55A9E8',					
						weightWeekNames:'bold',
						typeWeekNames:'long',/*Sets long medium or short - Monday, Mon, M
						
						
						/* Sets the CSS for the week number column down the L side/**/
						sizeWeekNums:'10px',
						fontWeekNums:'Arial,Helvetica,sans-serif',
						colorWeekNums:'#324358', 
						colorWeekNumsBG:'#C9E4F8',
						colorWeekNumsHover:'#55A9E8',
						weightWeekNums:'bold',
						
						
						/* Sets CSS for the date numbersS/**/
						sizeDayNums:'10px',
						fontDayNums:'Arial,Helvetica,sans-serif',
						weightDayNums:'bold',
						colorDayNums:'#09273E',
						
						// Week view specific/**/							
						show8dayWeek:true
						
					});
					Calendar(1,'plus',0); /*(calendar instance,  plus or minus,  sets the month to this month -0, next month +1, last month -1 etc)/**/
				</script>
			
				<ul id="dragContent"></ul>
				<div id="dragDropIndicator" style="background-image:url(../images/ArrowUpL.gif);"></div>
			</div> 
		</div>
	</div>
</div>

<script type="text/javascript">Resize();</script>

<!-- Everything below are divs used for popups////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->

<div id="NewEventTaskBox" class="NewEventTaskBox WindowBox" align="center">

	<div style="font-size:18px; background-color:#1294D0; width:100%; color:#FFFFFF;" class="WindowTitle">
		<div onClick="hideEventModal();" class="redXCircle">X</div>
		New Event <span id="NewEventDate"></span>
	</div>
	
	<label style="font-size:24px; width:100%;">Please choose an event category:</label>

	<%
		Dim TaskID
		SQL = "SELECT TaskID, TaskName, BorderColor, OrderNum, AltName FROM Tasks WHERE EnableCal=1 ORDER BY OrderNum" 
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring 
	%> 
	<!--           
		<select id="TaskLister" onChange="TaskListerRedirect(SelI(this.id).value);" multiple="multiple" style="width:90%; left:5%;">
			<option value="0" Selected>----</option>
	-->
	<%
		tIndex=0
		Do Until rs.EOF
			
			Do While Session("Access"&rs("AltName"))="False"
				rs.MoveNext
				If rs.EOF Then Exit Do
			Loop
			
			If rs.EOF Then Exit Do
			
			TaskID=rs("TaskID")
			TaskName=rs("TaskName")
			Color=rs("BorderColor")
			tIndex=tIndex+1
			%>	
			<br/>
			<button onClick="TaskListerRedirect(<%=TaskID%>,<%=tIndex%>);" style="width:70%; color:#<%=Color%>; font-size:18px; float:left; margin:0 0 0 15%;">
				<%=TaskName%>
			</button>
			<%   
			'rs.MoveNext
			'If rs.EOF Then Exit Do
			'
			'Do While Session("Access"&rs("AltName"))="False"
			'	rs.MoveNext
			'	If rs.EOF Then Exit Do
			'Loop
			'If rs.EOF Then Exit Do
			
			'TaskID=rs("TaskID")
			'TaskName=rs("TaskName")
			'Color=rs("BorderColor")
			%>
			<!--button onClick="TaskListerRedirect(<%=TaskID%>,<%=rs("OrderNum")%>);" style="width:40%; color:#<%=Color%>; font-weight:bold; float:right; margin:0 7.5% 0 0;">
				<%=TaskName%>
			</button -->
			<br/>
			<br/>
			<%   
			rs.MoveNext
		Loop

		set rs = nothing
	%>

</div>

<div id="ProjectSelectionBox" class="WindowBox JobSelectionBox">
	<div id="ProjSelTitle" class="WindowTitle" style="background:#1C80CA; color:#fff;">
		<div onClick="this.parentNode.parentNode.style.display='none';" class="redXCircle" style="cursor:pointer; float:right; ">X</div>
		Please Choose a Project
	</div>
	<br>
	<!--
	<input id="cbActive" type="checkbox" checked/><label for="cbActive">Active</label>&nbsp; &nbsp;
	<input id="cbObtained" type="checkbox" /><label for="cbObtained">Obtained</label>&nbsp; &nbsp;
	<input id="cbInactive" type="checkbox" /><label for="cbInactive">Inactive</label><br>
	-->
	<br>
	<select id="selEventProj" onChange="JobSched(SelI(this.id)); this.selectedIndex=0;">
		<option value="0">Select An Active Project:</option>
		<%
			ProjectOptionList("active")
			'SQL1="SELECT ProjID,Area,RCSPM,ProjName FROM Projects WHERE Active=1 AND Obtained=1 ORDER BY ProjName"
			'Set rs1=Server.CreateObject("ADODB.Recordset")
			'rs1.Open SQL1, REDconnstring 
			
			'Do Until rs1.EOF
				%>
					<!-- option value="< %=rs1("ProjID")%>" area="< %=rs1("Area")%>" attn="< %=rs1("RCSPM")%>" >< %=DecodeChars(rs1("ProjName"))%></option -->
				<%
			'	rs1.MoveNext
			'Loop
			
			'Set rs1= Nothing
		%>
	</select>
</div>

<div id="ServiceSelectionBox" class="WindowBox JobSelectionBox">
	<div id="ServeSelTitle" class="WindowTitle" style="background:#1C80CA; color:#fff;">
		Please Choose a Service Job
		<div onClick="this.parentNode.parentNode.style.display='none';" class="redXCircle" style="cursor:pointer; float:right; ">X</div>
	</div>
	<br>
	<!--
	<input id="cbActive" type="checkbox" checked/><label for="cbActive">Active</label>&nbsp; &nbsp;
	<input id="cbObtained" type="checkbox" /><label for="cbObtained">Obtained</label>&nbsp; &nbsp;
	<input id="cbInactive" type="checkbox" /><label for="cbInactive">Inactive</label><br>
	-->
	<br>
	<select id="selEventServ" onChange="JobSched(SelI(this.id)); this.selectedIndex=0;">
		<option value="0">Select An Active Service Job:</option>
		<%
			SQL1="SELECT NoteID,Area,Attn,Job FROM JobsLists WHERE Active=1 And Type=3 ORDER BY Job"
			Set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring 
			
			Do Until rs1.EOF
				%>
					<option value="<%=rs1("NoteID")%>" area="<%=rs1("Area")%>" attn="<%=rs1("Attn")%>" ><%=DecodeChars(rs1("Job"))%></option>
				<%
				rs1.MoveNext
			Loop
			
			Set rs1= Nothing
		%>
	</select>
</div>

<div id="TestMaintSelectionBox" class="WindowBox JobSelectionBox">
	<div id="TestSelTitle" class="WindowTitle" style="background:#1C80CA; color:#fff;">
		Please Choose a Testing / Maintenance Job
		<div onClick="this.parentNode.parentNode.style.display='none';" class="redXCircle" style="cursor:pointer; float:right; ">X</div>
	</div>
	<br>
	<!--
	<input id="cbActive" type="checkbox" checked/><label for="cbActive">Active</label>&nbsp; &nbsp;
	<input id="cbObtained" type="checkbox" /><label for="cbObtained">Obtained</label>&nbsp; &nbsp;
	<input id="cbInactive" type="checkbox" /><label for="cbInactive">Inactive</label><br>
	-->
	<br>
	<select id="selEventTest" onChange="JobSched(SelI(this.id)); this.selectedIndex=0;">
		<option value="0">Select An Active Testing/Maintenance Job:</option>
		<%
			SQL1="SELECT NoteID,Area,Attn,Job FROM JobsLists WHERE Active=1 And Type=4 ORDER BY Job"
			Set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring 
			
			Do Until rs1.EOF
				%>
					<option value="<%=rs1("NoteID")%>" area="<%=rs1("Area")%>" attn="<%=rs1("Attn")%>" ><%=DecodeChars(rs1("Job"))%></option>
				<%
				rs1.MoveNext
			Loop
			
			Set rs1= Nothing
		%>
	</select>
</div>

<form action="javascript:SaveEvent(document.getElementById('EventBoxForm'));" id="EventBoxForm" style="">
	<input id=EventJobID type="hidden" value="0" />
	<div id="NewEventBox" class="NewEventBox WindowBox" style="height:auto;"><!-- For Entering a new event -->
		<div id=NewEventBoxTitle class="WindowTitle" style="border-bottom:1px solid #AAA; background:#3599E3;">
			<div  id="EventHeaderTxt" class="NewEventHeaderText" align="left">Create New Event</div>
		</div>
	 
		<div id=NewEventBoxLeft style="" align=left >
			<div class=EventLabelText >Title&nbsp;</div>
			<input type=text id=EventTitleText class=EventTextBox style="font-size:12px; font-weight:bold;" size=36 maxlength=44 />
			<br/>
			<br/>
			<div class="EventLabelText" >Date&nbsp;</div>
			<input type="text" name="FromDateTxt" id="FromDateTxt" class="EventTextBox" size="32" maxlength="20" value=""/>
			<img style="cursor:pointer;" onClick="displayCalendar('FromDateTxt','mm/dd/yyyy',this); posCal();" onMouseOver="calPosUpdate(event,this);" src="../images/cal.gif" width=16 height=16>
			<br/>
			<div class="EventLabelText" >To Date&nbsp;</div>
			<input type="text" name="ToDateTxt" id="ToDateTxt" class="EventTextBox" size="28"  onChange="ToDateChange();" maxlength="20"/>
			<img style="cursor:pointer;"onclick="displayCalendar('ToDateTxt','mm/dd/yyyy',this); posCal();" onMouseOver="calPosUpdate(event,this);" src="../images/cal.gif" width="16" height="16">
			<br/>
			<br/>
			<div class="EventLabelText" >Notes&nbsp;</div>
			<textarea name="EventNewNotes" id="EventNewNotes" class="EventTextBox" cols=32 rows=6 ></textarea>
			<br/>
			<label class="EventLabelText" ><input type="checkbox" name="DoneCheck" id="DoneCheck" />Done</label>
			<br/>
			<input type="submit" name="DeleteEventBtn" id="DeleteEventBtn" value="Delete" onClick="return EventDeleteConfirm();"/>
		</div>
		
		<div id=NewEventBoxRight style="" align=left >
			<div class="EventLabelText" >Attention&nbsp;</div>
			<%    
			SQL = "select EmpID, FName, LName from Employees WHERE Active=1 Order By FName" 
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring 
			%>
			<select name=AttnList id=AttnList style="width:204px;">
				<option value=1500 >----</option>
				<% 
				Do While Not rs.EOF
				%><option value="<%= rs("EmpID")%>"><%= rs("Fname")&" "&rs("Lname")%></option><%   
					rs.MoveNext
				Loop
				
				Set rs = Nothing
				%>
			</select>
			<br/>
			<br/>
			<div class="EventLabelText" >Event Type&nbsp;</div>
			<%    
			SQL = "SELECT TaskID, TaskName FROM Tasks WHERE EnableCal=1 ORDER BY OrderNum" 
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring 
			%>            
			<select name=TaskList id=TaskList style="width:196px;" onChange="EventProjectSelect();">
				<option value="0" Selected>----</option>
				<%
				Do While Not rs.EOF
					%><option  value="<%= rs("TaskID")%>"><%= rs("TaskName")%></option><%
					rs.MoveNext
				Loop
				set rs = nothing
				%>
			</select>
			<br/><br/>
			<label class="EventLabelText" id=BillField ><input type="checkbox" name="BillCheck" id="BillCheck" onChange="BillStatus();" checked />Billable</label>
			<label class="EventLabelText" id=BilledField ><input type="checkbox" name="BilledCheck" id="BilledCheck" onChange="BillStatus();" />Billed</label>
			
			<select name=JobName id=JobName style="display:none;"></select>
			<br/>
			
			<div class="EventLabelText" style="display:none;" >Phase</div>
			<%    
			SQL = "select PhaseID, PhaseName from Phase" 
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring 
			%>
			<select name=PhaseList id=PhaseList style="display:none;">
				<option value="0" selected>----</option>
				<%
				Do Until rs.EOF
					%><option value="<%= rs("PhaseID")%>"><%= rs("PhaseName")%></option><%   
					rs.MoveNext
				Loop
				set rs = nothing
				%>
			</select>
			<div class=EventLabelText >Project Manager&nbsp;</div>
			<%    
			SQL = "SELECT EmpID, FName, LName FROM Employees WHERE Active=1" 
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring 
			%>            
			<select name=SuperList id=SuperList style="width:156px;">
				<option value=0 Selected>----</option>
				<%
				Do Until rs.EOF
					%>
					<option  value="<%= rs("EmpID")%>" ><%= rs("Fname")&" "&rs("Lname")%></option>
					<%   
					rs.MoveNext
				Loop
				set rs = nothing
				%>
			</select> 
			<br/>
			<div class=EventLabelText >Area&nbsp;</div>
			<%    
			SQL = "SELECT Abbr, State FROM States" 
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring 
			%>            
			<select name=AreaList id=AreaList style="width:244px;">
				<option value="0"Selected>----</option>
				<% 
				Do Until rs.EOF
					%><option  value="<%=rs("Abbr")%>"><%=rs("State")%></option><%   
					rs.MoveNext
				Loop
				set rs = nothing
				%>
			</select>
			<br/>
			<div class="EventLabelText" >Customer&nbsp;</div>
			<%    
			SQL = "SELECT ID, Name FROM Contacts WHERE Customer=1 ORDER BY Name" 
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring 
			%>
			<select name=CustomerList id=CustomerList style="font-size:10px; width:212px">
				<option value="0"selected="selected">----</option>
				<%
				Do While Not rs.EOF
					%><option  value="<%= rs("ID")%>"><%= rs("Name")%></option><%
					rs.MoveNext
				Loop
				set rs = nothing
				%>
			</select>
			<br/>
			<br/>
			<div class=EventLabelText >Crew&nbsp;</div>
			<%    
			SQL = "select EmpID, FName, LName from Employees WHERE Active=1" 
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.Open SQL, REDconnstring 
			%>
			<select id=CrewList onChange="Gebi('CrewNames').value+='\n'+SelI('CrewList').innerHTML; this.selectedIndex=0;" style="width:244px;">
				<option value=0 selected=selected >Click a name to add.</option>
				<% 
				Do Until rs.EOF
					%><option  value="<%= rs("EmpID")%>"><%= rs("Fname")&" "&rs("Lname")%></option><%   
					rs.MoveNext
				Loop
				Set rs = nothing
				%>
			</select>
			<br/>
			<textarea name=CrewNames id=CrewNames class=EventTextBox cols=41 rows=3 style="margin-bottom:8px;" ></textarea>
			<br/>
			 <input type="submit" name="SaveEventBtn" id="SaveEventBtn" value="Update/Save" style="float:right;" />
			 &nbsp;&nbsp;
			 <input type="Button" name="CancelEventBtn" id="CancelEventBtn" value="Cancel" style="float:right;" onClick="hideEventModal();"/>
			</div>
		<!-- 
		<div class=EventLabelText >Repeat</div>
		<select name=EventRepeat id=EventRepeat class=EventListBox >
			<option value="0"Selected>No Repeat</option>
			<option value="365">Every Day</option>
			<option value="52">Once A Week</option>
			<option value="12">Once A Month</option>
			<option value="4">Every 3 Months</option>
			<option value="2">Every 6 Months</option>
			<option value="1">Once A Year</option>
		</select>
		-->
		
		<input name=EventID id=EventID type=hidden />
		<input name=Source id=Source type=hidden />
		
		<div id="EventDetailsScreen"  Class="EventDetailsScreen"></div>
		
		
		<div id="EventDetails2"  Class="EventDetailsScreen" >
		</div>
		<!--	<div height="23"><div class="EventLabelText" style="float:right;">Area</div>
			<div>< %    		'SQL = "select AreaID, AreaDescription from Area"				'set rs=Server.CreateObject("ADODB.Recordset")			'rs.Open SQL, REDconnstring				%>
			<select name="AreaList2" id="AreaList2" style="font-size:12px; width:200px">			<option value="0"selected="selected">----</option>			< %	'Do Until rs.EOF		%>
			<option value="< %'= rs("AreaID")%>">< %'= rs("AreaDescription")%></option>			< %				'rs.MoveNext		'Loop			'set rs = nothing		%>			</select>		</div>	</div>	-->
	</div>
</div>
	
		<!-- Popup For the Day Events/////////////////////////////////////////////////////////////////////////////////// -->
		<div id="EventPopup" style="position:absolute; display:none; top:400px; left:100px; width:200px; height:200px; z-index:10000;" >
			<div width="200"  style="background:#CC9999;" border="1"  border="1" cellpadding="0" cellspacing="0">
				<div>
					<div>All Day Events</div>
				</div>
				<div>
					<div><div id="EventPopupItems" style="width:100%; height:100%;"></div></div>
				</div>
			</div>
		</div>
			
	</div> 		
</form>

<!-- Drag and drop ------------------------------------------------------------------------------------------------------ -->

<ul id="dragContent"></ul>
<div id="dragDropIndicator"><img src="../images/Arrow20X25R2.gif"></div>

<!-- -------------------------------------------------------------------------------------------------------------------- -->


    
</body>
</html>
