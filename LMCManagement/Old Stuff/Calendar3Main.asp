<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<title>Tricom Management Center</title>

    
<!--  #include file="RED.asp"  -->

<script type="text/javascript" src="../../LMCDevelopment/Old Stuff/CalendarMain-JS.js"></script>
<script type="text/javascript" src="../../LMCDevelopment/Old Stuff/CalendarCreate.js"></script>
<script type="text/javascript" src="../../LMCDevelopment/Old Stuff/CalendarJS.js"></script>
<script type="text/javascript" src="../../LMCDevelopment/Old Stuff/CalendarAJAX.js"></script>
<script type="text/javascript" src="../../LMCDevelopment/Old Stuff/DragNDropJS.js"></script>
<SCRIPT type="text/javascript" src="../../LMCDevelopment/Old Stuff/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="../../LMCDevelopment/Old Stuff/rcstri.js"></script>

<script type="text/javascript"> var mX; var mY; </script>

<link rel="stylesheet" href="../../LMCDevelopment/Old Stuff/CalendarCSS.css" media="screen">
<link rel="stylesheet" href="../../LMCDevelopment/Old Stuff/CalendarMain-CSS.css" media="screen">
<link type="text/css" rel="stylesheet" href="../../LMCDevelopment/Old Stuff/dhtmlgoodies_calendar.css?random=20051112" media="screen">



</head>

<body class="body" onLoad="setTimeout('Resize();',150);" onResize="Resize();" onmousemove="mX=parent.mX; mY=parent.mY;" onkeyup="">

<div id="HoverNotes" class="HoverNotes" onMouseOver="this.style.display='none';"></div>








<div id="CalendarMain" class="CalendarMain">

<table class="CalendarContainer"  id="CalendarContainer"  border="0">

<tr>
<td align="center" valign="top" id="CalendarLeftContainer" class="CalendarLeftContainer">

 
    <div class="ViewsTabs">
    
    	<div id="MonthsTab" onMouseUp="showMonths()" class="MonthsTab">Months</div>
			<div id="ViewsTab" name="ViewsTab" onMouseUp="showViews()" class="ViewsTab">Views</div>
			<!-- <div id="BoardTab" onMouseUp="showBoard()" class="BoardTab">Board</div> -->
			<!-- <div id="AlertsTab" onMouseUp="showAlerts()" class="AlertsTab">Alerts</div> -->
			<small style="float:right;">
				<a href="../../LMCDevelopment/Old Stuff/calendarMain.asp" target="_self" style="text-decoration:underline; font-family:Arial, Helvetica, sans-serif;">Old Calendar</a>
				&nbsp;
			</small>
				
    </div>
    
    <div class="ViewsTabsBottom">   </div>
    
     
<!-- Views----------------------------------------Views Tab------------------------------------------------------------------ -->    
  <div id="Views" class="Views">
  

      
      
      
       
      

	

   <div  class="ViewsBox">
			
        <div class="ViewsHeader">Detailed View</div>
        
        
        <div class="ViewDetailBox">
        
        
        
                <div class="ViewListTitle">Attention:</div> 
                <div class="ViewListItem" align="left">
                            <%    
                            SQL = "select * from Employees" 
                            set rs=Server.CreateObject("ADODB.Recordset")
                            rs.Open SQL, REDconnstring 
                            %>
                  <select class="ViewListMenu" name="ViewAttn" id="ViewAttn" >
                        <option value="0" Selected ></option>
                            <% Do While Not rs.EOF%>
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
                            SQL = "select * from Tasks order by TaskID" 
                            set rs=Server.CreateObject("ADODB.Recordset")
                            rs.Open SQL, REDconnstring 
                            %>            
                  <select class="ViewListMenu" name="ViewTask" id="ViewTask" onChange="">
                        <option value="0"Selected></option>
                            <% Do While Not rs.EOF%>
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
                            SQL = "select * from Employees" 
                            set rs=Server.CreateObject("ADODB.Recordset")
                            rs.Open SQL, REDconnstring 
                            %>            
                  <select class="ViewListMenu" name="ViewPM" id="ViewPM">
                        <option value="0"Selected></option>
                            <% Do While Not rs.EOF%>
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
                            SQL = "select * from Area" 
                            set rs=Server.CreateObject("ADODB.Recordset")
                            rs.Open SQL, REDconnstring 
                            %>            
                  <select class="ViewListMenu" name="ViewArea" id="ViewArea">
                        <option value="0"Selected></option>
                            <% Do While Not rs.EOF%>
                        <option  value="<%= rs("AreaID")%>"><%= rs("AreaDescription")%></option>
                            <%   
                            rs.MoveNext
                            Loop
                            set rs = nothing
                            %>
                   </select> 
                </div>
                 
                <div class="ViewListTitle">Phase:</div>
                <div class="ViewListItem">
							<%    
                            SQL = "select * from Phase" 
                            set rs=Server.CreateObject("ADODB.Recordset")
                            rs.Open SQL, REDconnstring 
                            %>
                  <select class="ViewListMenu" name="ViewPhase" id="ViewPhase">
                    <option value="0"selected></option>
                    <% Do While Not rs.EOF%>
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
                            SQL = "select * from Customers order by Name" 
                            set rs=Server.CreateObject("ADODB.Recordset")
                            rs.Open SQL, REDconnstring 
                            %>
                   <select class="ViewListMenu" name="ViewCustomer" id="ViewCustomer" >
                   <option value="0"selected="selected"></option>
                            <% Do While Not rs.EOF%>
                   <option  value="<%= rs("CustID")%>"><%= rs("Name")%></option>
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
                  <div style="float:left; margin: 0px 0px 0px 10px;"><input name="AllBtn" type="button" value=" All " onClick="QuickView('')"></div>
                  <div style="float:right;"><input name="ViewBtn" type="button" value="Show" onClick="DetailView()"></div>
              </div>  
		</div>	
      </div> 
      
       
       
       
       
       
     <div  class="ViewsBox">
      
      	 <div class="ViewsHeader">QuickView</div>
         
         <div class="QuickViewBox"> 
           
                <div class="QuickViewItems">  <div onClick="QuickView('');" class="QuickViewBtn" style="background:#FFF;color:#000;">A</div>  <div class="QuickViewTxt">Show All</div> </div>
          
                <%    
                    SQL = "select * from Tasks order by TaskID" 
                    set rs=Server.CreateObject("ADODB.Recordset")
                    rs.Open SQL, REDconnstring
                    
                    Do While Not rs.EOF
                %>
                
                    <div class="QuickViewItems">  <div onClick="QuickView(<%=rs("TaskID")%>);" class="QuickViewBtn" style="background:#<%=rs("BgColor")%>;color:#<%=rs("TextColor")%>;"><%=rs("TaskID")%></div>  <div class="QuickViewTxt"><%=rs("TaskName")%></div> </div>
                    
                <% 
                    rs.MoveNext
                    Loop
                    set rs = nothing
                %> 
         </div>    
	</div>     
<!-- </div>
 </div> 
 ----------------------------------------------------------------------------------------------------------------------- -->    
         

    
    <div id="Board" class="Board">
    Dry Erase Board
    <button onClick="TestASP()">Click Me</button>
    </div>
    
    <div id="Alerts" class="Alerts">
    Alerts
    <button onClick="DayEventsAJAX()">AJAX</button>
    </div>
    
    
    
    
    
    
    
    
    
        
  <div id="Months" class="Months">
      
		<div id="Calendar2" style="position:relative; height:160px; width:200px; Border: 0px solid blue; z-index:1000;">
            <script language="JavaScript">
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



		<div id="Calendar3" style="position:relative; height:160px; width:200px; Border: 0px solid blue; z-index:1000;">
            <script language="JavaScript">
                this.defaults3=
                ({
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

 
 <div id="Calendar4" style="position:relative; height:160px; width:200px; Border: 0px solid blue; z-index:1000;">
            
						<script language="JavaScript">
                this.defaults4=
                ({
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
   
<br/>   
  
   

</td>
     

     
     
     
<td align="center" valign="top" class="CalendarMainContainer" id="CalendarMainContainer">






<div id="CalendarPlaner" style="display:block; height:100%;">



    <div id="Calendar1" style="position:relative; height:100%; width:100%; top:1px; Border:0px solid blue; z-index:100; ">
        <script language="JavaScript">
                //alert(this);
								this.defaults1=
                ({
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
                    colorDayNums:'#09273E'
                    
	});
	
		Calendar(1,'plus',0); /*(calendar instance,  plus or minus,  sets the month to this month -0, next month +1, last month -1 etc)/**/
	  </script>
      
    <ul id="dragContent"></ul>
    
		<div id="dragDropIndicator" style="background-image:url(../../LMCDevelopment/Old%20Stuff/images/ArrowUpL.gif);"></div>
    </div>
</div>  </td>
  </tr>
</table>

</div>





<script type="text/javascript">Resize();</script>

<!-- </div>
Everything below are divs used for popups////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->









<div id="ModalScreen" class="ModalScreen">

</div>



<div id="NewEventTaskBox" class="NewEventTaskBox">

	<div style="font-size:18px; background-color:#1294D0; width:100%; color:#FFFFFF;">
		New Event
		<img onClick="hideEventModal();" style="cursor:pointer; float:right;" src="../../LMCDevelopment/Old Stuff/Images/close15X15.gif" width="15" height="15" />
	</div>
	
	<label style="font-size:24px; width:100%;">Please choose an event category:</label>
	<div style="width:100%;">
	<%
		Dim TaskID
		SQL = "select * from Tasks order by OrderNum" 
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.Open SQL, REDconnstring 
	%> 
	<!--           
		<select id="TaskLister" onChange="TaskListerRedirect(SelI(this.id).value);" multiple="multiple" style="width:90%; left:5%;">
			<option value="0" Selected>----</option>
	-->
	<%
		TaskCount=0
		Do While Not rs.EOF
			
			TaskCount=TaskCount+1
			TaskID=rs("TaskID")
			TaskName=rs("TaskName")
			Color=rs("BorderColor")
			%>	
			<br/>
			<button onClick="TaskListerRedirect(<%=TaskID%>,<%=TaskCount%>);" style="width:40%; color:#<%=Color%>; font-weight:bold; float:left; margin:0 0 0 7.5%;">
				<%=TaskName%>
			</button>
			<%   
			rs.MoveNext
			
			If Not rs.EOF Then
				TaskCount=TaskCount+1
				TaskID=rs("TaskID")
				TaskName=rs("TaskName")
				Color=rs("BorderColor")
				%>
				<button onClick="TaskListerRedirect(<%=TaskID%>,<%=TaskCount%>);" style="width:40%; color:#<%=Color%>; font-weight:bold; float:right; margin:0 7.5% 0 0;">
					<%=TaskName%>
				</button>
				<br/>
				<br/>
				<%   
				rs.MoveNext
			End If
		Loop
		set rs = nothing
	%>
	</div> 

</div>

<div id="ProjectSelectionBox">
	<img onClick="this.parentNode.style.display='none';" style="cursor:pointer; float:right;" src="../../LMCDevelopment/Old Stuff/Images/close15X15.gif" width="15" height="15" />
	<br>
	<!--
	<input id="cbActive" type="checkbox" checked/><label for="cbActive">Active</label>&nbsp; &nbsp;
	<input id="cbObtained" type="checkbox" /><label for="cbObtained">Obtained</label>&nbsp; &nbsp;
	<input id="cbInactive" type="checkbox" /><label for="cbInactive">Inactive</label><br>
	-->
	<br>
	<select id="selEventProj" onChange="ProjRedirect(SelI(this.id).value);">
		<option value="0">Select An Active Project:</option>
		<%
			SQL1="SELECT * FROM Projects WHERE Active= 'True'"
			Set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring 
			
			Do Until rs1.EOF
				%>
					<option value="<%=rs1("ProjID")%>"><%=DecodeChars(rs1("ProjName"))%></option>
				<%
				rs1.MoveNext
			Loop
			
			Set rs1= Nothing
		%>
	</select>
</div>

<form action="javascript:SaveEvent(document.getElementById('EventBoxForm'));" id="EventBoxForm">


<div id="NewEventBox" class="NewEventBox"><!-- For Entering a new event -->


        <table width="616" height="359"border="0" cellpadding="4" cellspacing="0" bgcolor="#E6F3FB">
          <tr height="16">
            <td id="EventTopL" style="border-bottom: 1px solid #AAA;"colspan="3" bgcolor="#3599E3"><div  id="EventHeaderTxt" class="NewEventHeadderText" align="left">Create New Event</div>            </td>
            <td id="EventTopR" style="border-bottom: 1px solid #AAA;"width="203" bgcolor="#3599E3">
            <div align="right">
                        </div>            </td>
          </tr>
					<tr height="32" style=""></tr>
          <tr height="16">
            <td width="67" height="41" valign="bottom">
            <div class="EventLabelText" >
              <div>Title</div>
            </div>
            <div align="left"></div>            </td>
            <td width="225" align="left" valign="bottom">
            <div align="left">
              <input type="text" id="EventTitleText" class="EventTextBox" style="font-size:12px; font-weight:bold;" size="36" maxlength="38"/>
            </div>            </td>
            <td width="89" align="right" valign="bottom" style="border-left: 1px solid #AAA;">
            <div class="EventLabelText" >Attention</div>            </td>
            <td align="left" valign="bottom">
            <div align="left">
						<%    
                        SQL = "select * from Employees Order By FName" 
                        set rs=Server.CreateObject("ADODB.Recordset")
                        rs.Open SQL, REDconnstring 
                        %>
              <select name="AttnList" id="AttnList" >
                    <option value="1500" >----</option>
						<% Do While Not rs.EOF%>
                    <option value="<%= rs("EmpID")%>"><%= rs("Fname")&" "&rs("Lname")%></option>
						<%   
                        rs.MoveNext
                        Loop
						set rs = nothing
                        %>
               </select> 
            </div>            </td>
          </tr>
          <tr height="16">
            <td>
            <div class="EventLabelText" >Date</div>            </td>
            <td align="left" valign="bottom">
            <div align="left">
              <input type="text" name="FromDateTxt" id="FromDateTxt" class="EventTextBox" size="18" maxlength="20" value=""/>
              <img style="cursor:pointer;"onclick="displayCalendar('FromDateTxt','mm/dd/yyyy',this)" src="../../LMCDevelopment/Old Stuff/Images/cal.gif" width="16" height="16"></div>
              </td>
            <td align="right" valign="bottom" style="border-left: 1px solid #AAA;">
            <div class="EventLabelText" >Task</div>            </td>
            <td align="left" valign="bottom">
            <div align="left">
						<%    
                        SQL = "select * from Tasks order by OrderNum" 
                        set rs=Server.CreateObject("ADODB.Recordset")
                        rs.Open SQL, REDconnstring 
                        %>            
              <select name="TaskList" id="TaskList" onChange="EventProjectSelect()">
                    <option value="0"Selected>----</option>
						<% Do While Not rs.EOF%>
                    <option  value="<%= rs("TaskID")%>"><%= rs("TaskName")%></option>
						<%   
                        rs.MoveNext
                        Loop
						set rs = nothing
                        %>
               </select> 
            </div>            </td>
          </tr>
          <tr height="16">
            <td><div class="EventLabelText" >To Date</div>            </td>
            <td align="left" valign="bottom">
            <div align="left">
              <input type="text" name="ToDateTxt" id="ToDateTxt" class="EventTextBox" size="18"  onChange="ToDateChange();" maxlength="20"/>
            <img style="cursor:pointer;"onclick="displayCalendar('ToDateTxt','mm/dd/yyyy',this);" src="../../LMCDevelopment/Old Stuff/Images/cal.gif" width="16" height="16"></div>            </td>
            <td align="right" valign="bottom" style="border-left: 1px solid #AAA;">
            <!-- <div class="EventLabelText" >Job Name</div>   -->          </td>
            <td align="left" valign="bottom">
            <div align="left">
              <select name="JobName" id="JobName" style="display:none;">
              </select>
            </div>            </td>
          </tr>
          <tr height="16" style="display:none;">
            <td>
            <div class="EventLabelText" >Repeat</div>            </td>
            <td align="left" valign="bottom">
            <div align="left">
              <select name="EventRepeat" id="EventRepeat" class="EventListBox">
                  <option value="0"Selected>No Repeat</option>
                  <option value="365">Every Day</option>
                  <option value="52">Once A Week</option>
                  <option value="12">Once A Month</option>
                  <option value="4">Every 3 Months</option>
                  <option value="2">Every 6 Months</option>
                  <option value="1">Once A Year</option>
              </select>
            </div>            </td>
            <td align="right" valign="bottom" style="border-left: 1px solid #AAA;">
            <div class="EventLabelText" >Proj Mgr</div>            </td>
            <td align="left" valign="bottom">
            <div align="left">
						<%    
                        SQL = "select * from Employees" 
                        set rs=Server.CreateObject("ADODB.Recordset")
                        rs.Open SQL, REDconnstring 
                        %>            
              <select name="SuperList" id="SuperList">
                    <option value="0"Selected>----</option>
						<% Do While Not rs.EOF%>
                    <option  value="<%= rs("EmpID")%>"><%= rs("Fname")&" "&rs("Lname")%></option>
						<%   
                        rs.MoveNext
                        Loop
						set rs = nothing
                        %>
               </select> 
            </div>            </td>
          </tr>
          <tr height="16">
            <td align="left" valign="bottom">
            <div class="EventLabelText" >
              <div>Notes</div>
            </div>            </td>
            <td rowspan="5" align="left" valign="top"><textarea name="EventNewNotes" id="EventNewNotes" class="EventTextBox" cols="38" rows="8"></textarea></td>
            <td align="right" valign="bottom" style="border-left: 1px solid #AAA;">
            <div class="EventLabelText" style="float:right;">Area</div>           </td>
            <td align="left" valign="bottom">
            <div align="left">
						<%    
                        SQL = "select * from Area" 
                        set rs=Server.CreateObject("ADODB.Recordset")
                        rs.Open SQL, REDconnstring 
                        %>            
              <select name="AreaList" id="AreaList">
                    <option value="0"Selected>----</option>
						<% Do While Not rs.EOF%>
                    <option  value="<%= rs("AreaID")%>"><%= rs("AreaDescription")%></option>
						<%   
                        rs.MoveNext
                        Loop
						set rs = nothing
                        %>
               </select> 
            </div>            </td>
          </tr>
          <tr height="16">
            <td align="left" valign="top">&nbsp;</td>
            <td height="31" align="right" valign="bottom" style="border-left: 1px solid #AAA;"><div class="EventLabelText" >Phase</div></td>
            <td align="left" valign="bottom">
			            <%    
                        SQL = "select * from Phase" 
                        set rs=Server.CreateObject("ADODB.Recordset")
                        rs.Open SQL, REDconnstring 
                        %>
              <select name="PhaseList" id="PhaseList">
                <option value="0"selected>----</option>
                <% Do While Not rs.EOF%>
                <option  value="<%= rs("PhaseID")%>"><%= rs("PhaseName")%></option>
                        <%   
                        rs.MoveNext
                        Loop
						set rs = nothing
                        %>
              </select>              </td>
          </tr>
          <tr height="16">
            <td align="left" valign="top">&nbsp;</td>
            <td style="border-left: 1px solid #AAA;"><div class="EventLabelText" >Crew</div></td>
            <td align="left" valign="bottom"><div align="left">
                <%    
                        SQL = "select * from Employees" 
                        set rs=Server.CreateObject("ADODB.Recordset")
                        rs.Open SQL, REDconnstring 
                        %>
                <select name="CrewList" id="CrewList">
                  <option value="0"selected="selected">----</option>
                  <% Do While Not rs.EOF%>
                  <option  value="<%= rs("EmpID")%>"><%= rs("Fname")&" "&rs("Lname")%></option>
                  <%   
                        rs.MoveNext
                        Loop
						set rs = nothing
                        %>
                </select>
                <input type="button" name="AddCrewBtn" id="AddCrewBtn" value="Add" onClick="Gebi('CrewNames').value+='\n'+SelI('CrewList').innerHTML;" />
            </div></td>
          </tr>
          <tr height="16">
            <td align="left" valign="top">&nbsp;</td>
            <td style="border-left: 1px solid #AAA;">&nbsp;            </td>
            <td rowspan="3" align="left" valign="top"><textarea name="CrewNames" id="CrewNames" class="EventTextBox" cols="36" rows="3"></textarea></td>
          </tr>
          <tr height="16">
            <td align="left" valign="top">&nbsp;</td>
            <td style="border-left: 1px solid #AAA;">&nbsp;            </td>
          </tr>
          <tr height="16">
            <td align="left" valign="top"><div class="EventLabelText" >
              <div>Done</div>
            </div></td>
            <td align="left" valign="top"><input type="checkbox" name="DoneCheck" id="DoneCheck" /></td>
            <td height="27" style="border-left: 1px solid #AAA;"><input name="EventID" id="EventID"type="hidden" size="1"><input name="Source" id="Source"type="hidden" size="1"></td>
          </tr>
          <tr height="16">
            <td style="border-top: 1px solid #AAA;"colspan="4">
            <div style="width:95%; padding: 1px 0px 1px 12px;" >
              <div id="EventDelete" style="float:left; display:none;">
                <input type="submit" name="DeleteEventBtn" id="DeleteEventBtn" value="Delete" onClick="return EventDeleteConfirm()"/>
              </div> 
              <div style="position:relative; float:right;">
               <input type="Button" name="CancelEventBtn" id="CancelEventBtn" value="Cancel" onClick="hideEventModal()"/>&nbsp;&nbsp; <input type="submit" name="SaveEventBtn" id="SaveEventBtn" value="Update/Save" /> 
              </div>
            </div>             </td>
          </tr>
					
        </table>





<div id="EventDetailsScreen"  Class="EventDetailsScreen">

</div>





<div id="EventDetails2"  Class="EventDetailsScreen">
<br/>
<br/>


        <table width="280" border="0" cellspacing="0" cellpadding="2">
          <tr>
            <td width="100"><div class="EventLabelText" style="float:right;">Customer</div></td>
            <td width="180"><%    
                                SQL = "select * from Customers order by Name" 
                                set rs=Server.CreateObject("ADODB.Recordset")
                                rs.Open SQL, REDconnstring 
                                %>
              <select name="CustomerList" id="CustomerList" style="font-size:12px; width:200px">
                <option value="0"selected="selected">----</option>
                <% Do While Not rs.EOF%>
                <option  value="<%= rs("CustID")%>"><%= rs("Name")%></option>
                <%   
                                rs.MoveNext
                                Loop
                                set rs = nothing
                                %>
              </select></td>
          </tr>
          <tr>
            <td height="23"><div class="EventLabelText" style="float:right;">Area</div></td>
            <td><%    
                                SQL = "select * from Area" 
                                set rs=Server.CreateObject("ADODB.Recordset")
                                rs.Open SQL, REDconnstring 
                                %>
              <select name="AreaList2" id="AreaList2" style="font-size:12px; width:200px">
                <option value="0"selected="selected">----</option>
                <% Do While Not rs.EOF%>
                <option  value="<%= rs("AreaID")%>"><%= rs("AreaDescription")%></option>
                <%   
                                rs.MoveNext
                                Loop
                                set rs = nothing
                                %>
              </select></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table>

		</div>


		<!-- Popup For the Day Events/////////////////////////////////////////////////////////////////////////////////// -->
		<div id="EventPopup" style="position:absolute; display:none; top:400px; left:100px; width:200px; height:200px; z-index:10000;" >
			<table width="200"  style="background:#CC9999;" border="1"  border="1" cellpadding="0" cellspacing="0">
				<tr>
					<td>
					All Day Events
					
					</td>
				</tr>
				<tr>
					<td > 
					<div id="EventPopupItems" style="width:100%; height:100%;">
					
					</div>
					</td>
				</tr>
			</table>

		</div>
		
	</div> 
</form>









<!-- END MAIN CALENDAR********************EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE******************************************************************************/ -->
<!-- END MAIN CALENDAR********************EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE******************************************************************************/ -->
<!-- END MAIN CALENDAR********************EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE******************************************************************************/ -->
<!-- END MAIN CALENDAR********************EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE******************************************************************************/ -->
<!-- END MAIN CALENDAR********************EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE******************************************************************************/ -->
<!-- END MAIN CALENDAR********************EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE******************************************************************************/ -->
<!-- END MAIN CALENDAR********************EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE******************************************************************************/ -->
<!-- END MAIN CALENDAR********************EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE******************************************************************************/ -->
<!-- END MAIN CALENDAR********************EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE******************************************************************************/ -->
<!-- END MAIN CALENDAR********************EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE******************************************************************************/ -->
<!-- END MAIN CALENDAR********************EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE******************************************************************************/ -->
<!-- END MAIN CALENDAR********************EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE******************************************************************************/ -->









<!-- Drag and drop///////////////////////////////////////////////////////////////////////////////////////////////// -->

<ul id="dragContent"></ul>
<div id="dragDropIndicator"><img src="../../LMCDevelopment/Old Stuff/Images/Arrow20X25R2.gif"></div>

<!-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->


    
</body>
</html>
