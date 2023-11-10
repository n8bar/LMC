<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<!-- #include file="RED.asp" -->

<script type="text/javascript" src="ProjectsJS.js"></script>
<script type="text/javascript" src="ProjectsAJAX.js"></script>

<link rel="stylesheet" href="../../LMCManagement/Old Stuff/CSS_DEFAULTS.css" media="screen">
<link rel="stylesheet" href="ProjectsCSS.css" media="screen">


</head>

<body onclick="document.getElementById('menu').style.display ='none';" MARGINHEIGHT=0 MARGINWIDTH=0 TOPMARGIN=0 LEFTMARGIN=0>

<div id="ModalNewPart" class="ModalScreen"></div>
<div id="NewPartBox" class="NewPartBox">





</div>


<table   class="EstimateContainer"  border="0" >

<tr>
<td align="center" valign="top" class="EstimateLeftContainer">


    <div class="ViewsTabs">
    
    	<div id="CustomersTab" onMouseUp="" class="MainTab" onmouseover="MouseOverTab('CustomersTab')" onmouseout="MouseOutTab('CustomersTab')">Customers</div>
        <div id="OptionsTab" onMouseUp="" class="OtherTab"  onmouseover="MouseOverTab('OptionsTab')" onmouseout="MouseOutTab('OptionsTab')">Options</div>
        <div class="ListLinks" style="width:100px;"><a href="javascript:void(0);" onclick="ShowProjList();" >Show Project Lists</a></div>
    </div>
    
    <div class="ViewsTabsBottom"></div>
    
    
 
   
    
   
   <form  style="margin: 8px 0px 0px 0px;" name="CustomerSearch" action="javascript:GetCustomer();" >
        
        <Label class="TitleText11B" >Customer Search</Label>
        <input id="CustomerTxt" name="CustomerTxt" type="text" size="36" maxlength="28">
        
        <div Style="width:240px; text-align:center; margin: 3px 0px 0px 0px;"><input  class="Button11B" id="CustSubmit" name="CustSubmit"  type="submit"  value="Search"> </div>

       
    </form> 


    
 



    <div id="CustomersBox" class="HiddenBox">
    
        <div Style="position:relative; float:left; width:240px;">
            <div class="ListTitles">Customers</div>
            <!--<div class="ListLinks"><a href="javascript:void(0);" onclick="ShowCustNewBox()" >New Customer</a></div>-->
        </div>
        
        
        <div id="CustNewBox" class="HiddenBox200Border">
        
           <div class="TitleBox200Centered"><Label id="CustTitleName" class="TitleText11B">New Customer Info</Label></div>
           
               <form  style="margin: 0px 0px 0px 0px;" name="NewCustomer" action="javascript:GetCustomer();" >
                <Label class="TitleText10B" >Name</Label>
                <input name="CustName" type="text" size="25" maxlength="25">
                <Label class="TitleText10B" >Address</Label>
                <input name="CustAddress" type="text" size="25" maxlength="25">
                <Label class="TitleText10B" >City</Label>
                <input name="CustCity" type="text" size="25" maxlength="25">
                <Label class="TitleText10B" >State</Label>
                <input name="CustState" type="text" size="25" maxlength="25">
                <Label class="TitleText10B" >Zip</Label>
                <input name="CustZip" type="text" size="25" maxlength="25">
                <Label class="TitleText10B" >Phone</Label>
                <input name="CustPhone" type="text" size="25" maxlength="25">
                <br/>
                    <div Style="position:relative; float:leftwidth:200px;">
                        <div style="position:relative; float:left"><input  class="Button11B" name="Close" type="button" value="Cancel" onclick="CloseCustNewBox()"></div>
                        <div style="position:relative; float:right"><input  class="Button11B" name="CustSubmit" type="submit"  value="Save"></div>
                    </div>
                </form>
        </div>
        
        
        
        <div id="CustList" class="CustomerList"></div>
        
    </div>



    <br/>

 

<!--Main Dropdown Box For Showing Projects and Bids related to a customer ******************************************************************-->   
<div id="ProjectsBox" class="HiddenBox">
    
    
    <div class="TitleBox200Centered"><Label id="CustNameTag" class="TitleText14B">Please Select A Customer</Label></div>
    
    
    
     <div class="ViewsTabs">
        <div id="ProjectsTab" class="MainTab" >Projects</div>
     </div>
    <div class="ViewsTabsBottom"></div>   
    
    
    
<div id="ProjBox" class=""> <!--Projects Tab-->
        
            <div Style="position:relative; float:left; width:240px;">
                <div class="ListTitles">Projects</div>
                <!--<div class="ListLinks"><a href="javascript:void(0);" onclick="ShowProjNewBox()" >New Project</a></div>-->
            </div>
            
            <!--New Project Dropdown---------------------------------------------------------------------------------------------->         
            <div id="ProjNewBox" class="HiddenBox200Border">
            
              <div class="TitleBox200Centered"><Label id="CustTitleName" class="TitleText11B">New Project</Label></div>
               
                   <form  style="margin: 0px 0px 0px 0px;" name="NewCustomer" action="javascript:NewProject();" >
                    <Label class="TitleText10B" >Name</Label>
                    <input name="ProjName" type="text" size="25" maxlength="25">
                    <br/>
                        <div Style="position:relative; float:left; width:240px; margin: 3px 0px 0px 0px;">
                            <div style="position:relative; float:left"><input  class="Button11B" name="Close" type="button" value="Cancel" onclick="CloseProjNewBox()"></div>
                            <div style="position:relative; float:right"><input  class="Button11B" name="CustSubmit" type="submit" value="Save"></div>
                        </div>
                    </form>
            </div>
            <!---------------------------------------------------------------------------------------------------------------------> 
            
       
        <div id="ProjList" class="ProjectList"> </div><!--Project List Container-->
        
        <div Style="width:240px; text-align:center; margin: 3px 0px 0px 0px;"><input  class="Button11B" name="CustSubmit" type="submit" value="Printing"> </div>
        
            <!--Right Click Menu---------------------------------------------------------------------------------------------->        
            <div id="menu" class="RclickMenu">
            <table class="RclickMenuTable">
              <tr>
                <td style="border-right:1px groove #BBB;"width="10" rowspan="3">&nbsp;</td>
                <td ><div id="MenuItem1">1</div></td>
              </tr>
              <tr>
              <td><div id="MenuItem2">2</div></td>
              </tr>
               <tr>
              <td><div id="MenuItem3">3</div></td>
              </tr>
            </table>
            </div>
            <!---------------------------------------------------------------------------------------------------------------->  
 
        
</div> 
     



     
      
 </div><!--********End Project Dropdown******************************************************************************************************************************************************-->
    
<input name="HiddenCustID" id="HiddenCustID" type="Hidden" value="">    
<input name="HiddenProjID" id="HiddenProjID" type="Hidden" value="">  
<input name="HiddenEstID" id="HiddenEstID" type="Hidden" value=""> 
<input name="HiddenCustName" id="HiddenCustName" type="Hidden" value="">    
<input name="HiddenProjName" id="HiddenProjName" type="Hidden" value="">  
 
 
                        
     
</td>











<!--Main Screen--********************************************************************************************************************************************************************************-->     
<td align="center" valign="top" class="MainContainerTD">





<!--This is the Main White Board or task list-------------------------------------------------------------------------------------------------------->

<div id="TaskLists" class="TaskLists">

    <div id="TaskListHeader" class="TaskListHeader"><div id="" class="" style="float:left;"><button class="S">New</button></div> Header</div>
    
    <div id="TaskListBody" class="TaskListBody">
    
    
    
    
    
    
        <div id="TaskListItemsHead" class="TaskListItemsHead">
         	<div class="TaskListHeadEdit">Edit</div>
            <div class="TaskListHeadTime">Time</div>
            <div class="TaskListHeadSch">Sch</div>
            <div class="TaskListHeadJob">Task/Job</div>
            <div class="TaskListHeadDone" style="background:#CDD1D6;">Plan</div>
            <div class="TaskListHeadDone" style="background:#ECF4F0;">Perm</div>
            <div class="TaskListHeadDone" style="background:#CDD1D6;">UG</div>
            <div class="TaskListHeadDone" style="background:#ECF4F0;">Roug</div>
            <div class="TaskListHeadDone" style="background:#CDD1D6;">Insp</div>
            <div class="TaskListHeadDone" style="background:#ECF4F0;">Trim</div>
            <div class="TaskListHeadDone" style="background:#CDD1D6;">Insp</div>
            <div class="TaskListHeadDone" style="background:#ECF4F0;">Head</div>
            <div class="TaskListHeadDone" style="background:#CDD1D6;">Done</div>
            <div class="TaskListHeadDone" style="background:#ECF4F0;">Col</div>
            <div class="TaskListHeadAttn">Attention</div>
            <div class="TaskListHeadCust">Customer</div>
            <div class="TaskListHeadArea">Area</div>
            <div class="TaskListHeadNotes">Notes</div>
         </div>
         
         
         
         
         
       <div id="TLItemsContainer" class="TLItemsContainer">  
         
         
        
             <div id="TaskListItems" class="TaskListItems" onMouseOver="this.style.background = '#E6F3FB';" onMouseOut="this.style.background = '#FFF';">
                <div class="TaskListItemEdit">E</div>
                <div class="TaskListItemTime" style="">T</div>
                <div class="TaskListItemSch" style="">X</div>
                <div class="TaskListItemJob" onMouseOver="CloseProgressMenu();">Willow Creek San Martin</div>
                <div class="TaskListItemDone" style="background:#CDD1D6;"><div class="TaskListItemProg"  onClick="showProgressMenu(this,1);" style="background:#DABB9E">-</div></div>
                <div class="TaskListItemDone" style="background:#ECF4F0;"><div class="TaskListItemProg"  onClick="showProgressMenu(this,1);" style="background:#DABB9E">-</div></div>
                <div class="TaskListItemDone" style="background:#CDD1D6;"><div class="TaskListItemProg"  onClick="showProgressMenu(this,1);" style="background:#DABB9E">-</div></div>
                <div class="TaskListItemDone" style="background:#ECF4F0;"><div class="TaskListItemProg"  onClick="showProgressMenu(this,1);" style="background:#991A39">F</div></div>
                <div class="TaskListItemDone" style="background:#CDD1D6;"><div class="TaskListItemProg"  onClick="showProgressMenu(this,1);" style="background:#991A39">F</div></div>
                <div class="TaskListItemDone" style="background:#ECF4F0;"><div class="TaskListItemProg"  onClick="showProgressMenu(this,1);" style="background:#3599E3">P</div></div>
                <div class="TaskListItemDone" style="background:#CDD1D6;"><div class="TaskListItemProg"  onClick="showProgressMenu(this,1);" style="background:#00C400">R</div></div>
                <div class="TaskListItemDone" style="background:#ECF4F0;"><div class="TaskListItemProg"  onClick="showProgressMenu(this,1);" style="background:#00C400">R</div></div>
                <div class="TaskListItemDone" style="background:#CDD1D6;"><div class="TaskListItemProg"  onClick="showProgressMenu(this,1);" style="background:#FF0; color:#000;">&diams;</div></div>
                <div class="TaskListItemDone" style="background:#ECF4F0;"><div class="TaskListItemProg"  onClick="showProgressMenu(this,1);" style="">  </div></div>
                <div class="TaskListItemAttn" onMouseOver="CloseProgressMenu();">Ladell Bistline Jr</div>
                <div class="TaskListItemCust" onMouseOver="CloseProgressMenu();">Don Herman Construction</div>
                <div class="TaskListItemArea" onMouseOver="CloseProgressMenu();">Area 3 Needles Kingman Lauh</div>
                <div class="TaskListItemNotes" onMouseOver="CloseProgressMenu();">This is some notes on this job theres not a whole lot but this gives you an idea</div>
             </div>	
             
         
            
             
             
             
             
             
           <div id="TaskListBottom" class="TaskListBottom"> </div>  
                     
         
       </div>  
         

         
    </div>

</div>








<!--Popup Menu for assigning progress status to tasks-->
<div id="PhaseProgressMenu" class="PhaseProgressMenu">

   <div class="ProgressItemsHead">Progress</div> 
   <div class="ProgressItems"> <div class="ProgressColor" style="background:#DDD;">  </div> <div class="ProgressDesc"  onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)">Clear</div></div>  
   <div class="ProgressItems"> <div class="ProgressColor" style="background:#DABB9E;">-</div> <div class="ProgressDesc"  onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)">Not Needed</div></div>
   <div class="ProgressItems"> <div class="ProgressColor" style="background:#00C400;">R</div> <div class="ProgressDesc"  onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)">Ready To Do</div></div>
   <div class="ProgressItems"> <div class="ProgressColor" style="background:#3599E3;">P</div> <div class="ProgressDesc"  onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)">In Progress</div></div>
   <div class="ProgressItems"> <div class="ProgressColor" style="background:#991A39;">F</div> <div class="ProgressDesc"  onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)">Finished</div></div>
   <div class="ProgressItems"> <div class="ProgressColor" style="background:#FF0;  color:#000;">&diams;</div> <div class="ProgressDesc"  onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)">High Priority</div></div>
   <div class="ProgressItemsCancel"><button class="PICancelBtn" onClick="CloseProgressMenu();">Cancel</button></div>

</div>


<!--End White Board----------------------------------------------------------------------------------------------------------------------------------------->


















<div id="EstimateMain" class="MainContainer">






<!--Creates the Tabs for The Estimate-->

    <div class="ViewsTabs2">
    
    	<div id="InfoTab" onMouseUp="ShowTabInfo()" class="MainTab2" onmouseover="MouseOverTab('InfoTab')" onmouseout="MouseOutTab('InfoTab')">Information</div>
        <div id="PartsTab" onMouseUp="ShowTabParts()" class="OtherTab2" onmouseover="MouseOverTab('PartsTab')" onmouseout="MouseOutTab('PartsTab')">Parts</div>
        <div id="LaborTab" onMouseUp="ShowTabLabor()" class="OtherTab2" onmouseover="MouseOverTab('LaborTab')" onmouseout="MouseOutTab('LaborTab')">Labor</div>
        <div id="AnalysisTab" onMouseUp="ShowTabAnalysis()" class="OtherTab2" onmouseover="MouseOverTab('AnalysisTab')" onmouseout="MouseOutTab('AnalysisTab')">Analysis</div>
        <div id="EstTopInfo3" class="EstimateTopInfo">Reliance Electric1</div>
        <div class="EstimateTopInfo"> / </div>
        <div id="EstTopInfo2" class="EstimateTopInfo">Reliance Electric2</div>
        <div class="EstimateTopInfo"> / </div>
        <div id="EstTopInfo1" class="EstimateTopInfo">Reliance Electric3</div>
        
    </div>
    
    <div class="ViewsTabsBottom2"></div>




























<div id="InfoBox" class="EstimateInput"><!--The Main Information Tab-->





            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="2">
              <tr>
                <td height="15" colspan="3"><div align="right">
                    <label>
                    <div align="center">System</div>
                    </label>
                    </div></td>
              </tr>
              <tr>
                <td style="border-bottom:1px solid #AAA" height="8" colspan="3"><div align="center">
                  <input type="text" name="SystemTxt" id="SystemTxt" size="60" maxlength="60"   onKeyUp="UpdateEstimateInfo('SystemTxt','System')"/>
                  <br>
                  <br>
                </div>
                </td>
              </tr>
              <tr>
                <td height="8">&nbsp;</td>
                <td height="8">&nbsp;</td>
                <td style="" height="8"><div align="center">Bid Description</div></td>
              </tr>
              <tr>
                <td width="25%" height="25"><div align="right">Date Created</div></td>
                <td width="25%">
                  <div align="left">
                    <input type="text" name="DateCreatedTxt" id="DateCreatedTxt" size="16" maxlength="25"/>
                  </div>
                  </td>
                <td style="border-left:1px solid #AAA; padding: 0px 8px 0px 8px;" width="52%" rowspan="7" align="center" valign="top">
                <textarea style="width:90%; height:100%;"class="TextArea100" name="BidText" id="BidText" cols="45" rows="15" onKeyUp="UpdateEstimateInfo('BidText','Notes')"></textarea></td>
              </tr>
              <tr>
                <td height="25"><div align="right">Entered By</div></td>
                <td>
                  <div align="left">
                    <%    
                    SQL5 = "select * from Employees" 
                    set rs5=Server.CreateObject("ADODB.Recordset")
                    rs5.Open SQL5, REDconnstring 
                    %>
                    <div align="left" class="BubbleInputs">
                    <select  name="EnteredBy" id="EnteredBy"  class=""  onChange="UpdateEstimateInfo('EnteredBy','EnteredBy','List')"></div>
                        <% Do While Not rs5.EOF%>
                              <option  value="<%= rs5("EmpID")%>"><%= rs5("Fname")&" "&rs5("Lname")%></option>
                        <%   
                            rs5.MoveNext
                            Loop
                            set rs5 = nothing 
                        %>
                    </select> 
                  </div>
                </td>
              </tr>
              <tr>
                <td height="25"><div align="right">Date Bid</div></td>
                <td>
                  <div align="left">
                    <input type="text" name="DateBid" id="DateBid" size="16" maxlength="25" />
                  </div>
                </td>
              </tr>
              <tr>
                <td height="25"><div align="right">Date Won</div></td>
                <td>
                  <div align="left">
                    <input type="text" name="DateWon" id="DateWon" size="16" maxlength="25"/>
                  </div>
                </td>
              </tr>
              <tr>
                <td height="25"><div align="right">Tax Rate</div></td>
                <td>
                  <div align="left">
                    <input type="text" name="TaxRate" id="TaxRate" size="16" maxlength="25" onKeyUp="UpdateEstimateInfo('TaxRate','TaxRate')" />
                  </div>
                </td>
              </tr>
              <tr >
                <td  height="25" ><div align="right">Margin</div></td>
                <td>
                  <div align="left">
                    <input type="text" name="MU" id="MU" size="16" maxlength="25" onKeyUp="UpdateEstimateInfo('MU','MU')"/>
                  </div>
                </td>
              </tr>
              <tr >
                <td  height="25" ><div align="right">Locked Price</div></td>
                <td>
                  <div align="left">
                    <input type="text" name="LockedPrice" id="LockedPrice" size="16" maxlength="25"/>
                  </div>
                </td>
              </tr>
              <tr >
                <td  height="40%" colspan="2" ><!--Open Area--></td>
                <td style="border-left:1px solid #AAA; padding: 0px 8px 0px 8px;" width="52%" align="center" valign="top">RCS Notes (This does not show on the bid)<br />
                <textarea style="width:90%;" class="TextArea100" name="RCSBidText" id="RCSBidText" cols="45" rows="5"  onKeyUp="UpdateEstimateInfo('RCSBidText','RCSNotes')" ></textarea>
                </td>
              </tr>
              <tr >
                <td  height="30" colspan="3" align="center" ></td>
              </tr>
            </table>


</div>
    
   
   
   
   
    
    

	<div id="PartsBox" class="EstimateInput">
    
    	Parts
        <input name="NewPart" type="button" onclick=" ShowNewPartModal()"  value=" Add New Part">

	</div>
    
    
    
    
    <div id="LaborBox" class="EstimateInput">
    
    	Labor

	</div>
    
    
    
    
    <div id="AnalysisBox" class="EstimateInput">
    
    	Analysis

	</div>
    



<!--Right Click Menu////////////////////////////////////////////////////////////-->


<!--Right Click Menu////////////////////////////////////////////////////////////-->




</div>


</td>
</tr>
</table>



</body>
</html>



















