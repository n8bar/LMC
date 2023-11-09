<!--#include file="../LMC/RED.asp" -->
<%
Response.ContentType="text/xml"
If Request.Querystring("html")=1 then Response.ContentType="text/html"

SysID=Request.QueryString("SysID")

SQL0="SELECT * FROM Systems WHERE SystemID="&SysID
'% ><sql0><%=SQL0% ></sql0><%
Set rs0=Server.CreateObject("AdoDB.RecordSet")
rs0.open SQL0, RedConnString
SysName=rs0("System")

ProjID=rs0("ProjectID")

SQL="SELECT * FROM Projects WHERE ProjID="&ProjID
'% ><sql><%=SQL% ></sql><%
Set rs=Server.CreateObject("AdoDB.RecordSet")
rs.Open SQL, REDConnString

'<?xml version="1.0" encoding="utf-8"?>

GUID=right("00000000"&ProjID,8) & "-" &right("0000"&ProjID,4) & "-" &right("0000"&ProjID,4) & "-" &right("0000"&ProjID,4) & "-" &right("0000000000000"&SysID,12)
sGUID=right("000000a0"&ProjID,8) & "-" &right("000a"&ProjID,4) & "-" &right("000a"&ProjID,4) & "-" &right("000a"&ProjID,4) & "-" &right("00000000000a0"&SysID,12)

ProjName=rs("ProjName")
%>
<dtp:SI5Project xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ProjectGuid="<%=GUID%>" SaveGuid="<%=sGUID%>" CreatedByID="1" xmlns:dtp="http://www.d-tools.com/schemas/SI5/Project">
  <dtp:Id><%=ProjID%></dtp:Id>
  <dtp:Name><%=ProjName%> - <%=SysName%></dtp:Name>
  <dtp:ProjectNumber><%=ProjID%></dtp:ProjectNumber>
  <dtp:SiteAddress>
    <dtp:CompanyName><%=ProjName%></dtp:CompanyName>
    <dtp:Address1><%=rs("ProjAddress")%></dtp:Address1>
    <dtp:Address2 />
    <dtp:City><%=rs("ProjCity")%></dtp:City>
    <dtp:State><%=rs("ProjState")%></dtp:State>
    <dtp:PostalCode><%=rs("ProjZip")%></dtp:PostalCode>
    <dtp:Country>USA</dtp:Country>
    <dtp:PhoneNumber><%=rs("ProjPhone1")%></dtp:PhoneNumber>
    <dtp:FaxNumber><%=rs("ProjFax")%></dtp:FaxNumber>
		<%
	  SQL1="SELECT * FROM Contacts WHERE ID=0"&rs("CustomerID")
    %><sql1><%=SQL1%></sql1><%
		Set rs1=Server.CreateObject("AdoDB.recordSet")
		rs1.open SQL1, REDConnString
	  If not rs1.eof then
			%>
			<dtp:Contact><%=rs1("Contact1")%></dtp:Contact>
			<dtp:ContactTitle></dtp:ContactTitle>
			<dtp:ContactEmail><%=rs1("Email1")%></dtp:ContactEmail>
			<dtp:ContactPhoneNumber><%=rs1("Cphone1")%></dtp:ContactPhoneNumber>
			<%
		Else
			%>
			<dtp:Contact />
			<dtp:ContactTitle />
			<dtp:ContactEmail />
			<dtp:ContactPhoneNumber />
			<%
		End If
		%>
  </dtp:SiteAddress>

  <dtp:BillingAddress>
    <dtp:CompanyName><%=rs("CustName")%></dtp:CompanyName>
	  <%
    If not rs1.eof then
			%>
      <dtp:Address1><%=rs1("Address")%></dtp:Address1>
      <dtp:Address2><%=rs1("Address2")%></dtp:Address2>
      <dtp:City><%=rs1("City")%></dtp:City>
      <dtp:State><%=rs1("State")%></dtp:State>
      <dtp:PostalCode><%=rs1("Zip")%></dtp:PostalCode>
      <dtp:Country>USA</dtp:Country>
      <dtp:PhoneNumber><%=rs1("Phone1")%></dtp:PhoneNumber>
      <dtp:FaxNumber><%=rs1("Fax")%></dtp:FaxNumber>
			<%
		Else
			%>
      <dtp:Address1 />
      <dtp:Address2 />
      <dtp:City />
      <dtp:State />
      <dtp:PostalCode />
      <dtp:Country />
      <dtp:PhoneNumber />
      <dtp:FaxNumber />
			<%
		End If
		%>
  </dtp:BillingAddress>
  <dtp:CompanyAddress>
    <dtp:CompanyName>Tricom Communications</dtp:CompanyName>
    <dtp:Address1>3540 W. Sahara Ave. #431</dtp:Address1>
    <dtp:Address2 />
    <dtp:City>Las Vegas</dtp:City>
    <dtp:State>Nevada</dtp:State>
    <dtp:PostalCode>89102</dtp:PostalCode>
    <dtp:Country>United States</dtp:Country>
    <dtp:PhoneNumber>8553852800</dtp:PhoneNumber>
    <dtp:FaxNumber>7029403378</dtp:FaxNumber>
    <dtp:EmailAddress>tricom@tricomlv.com</dtp:EmailAddress>
    <dtp:LicenseNumber />
    <dtp:CompanyLogo />
    <dtp:DoNotSync>false</dtp:DoNotSync>
  </dtp:CompanyAddress>
	<% 
  
	Set rs1=Nothing
	
  %>
  <dtp:BOM>
    <dtp:Equipment>
			<%
      
			SQL2="SELECT * FROM BidItems WHERE SysID="&SysID
      Set rs2=Server.CreateObject("AdoDB.RecordSet")
			rs2.open SQL2, RedConnString
			
			Do until rs2.eof
				%>
				<dtp:ID>1</dtp:ID>
				<dtp:ComponentID></dtp:ComponentID>
				<dtp:Manufacturer>LEVITON</dtp:Manufacturer>
				<dtp:Model>40831</dtp:Model>
				<dtp:Description>F Connector Gold- Plated 
	color Notes-white,ivory,almond</dtp:Description>
				<dtp:ClientDescription />
				<dtp:Category>
					<dtp:Name>ACCESSORIES</dtp:Name>
					<dtp:Type>Equipment</dtp:Type>
				</dtp:Category>
				<dtp:Specification>
					<dtp:BTU>0</dtp:BTU>
					<dtp:Depth>1.01</dtp:Depth>
					<dtp:Dispersion />
					<dtp:Height>0.83</dtp:Height>
					<dtp:HeadEnd />
					<dtp:RackMount>false</dtp:RackMount>
					<dtp:RackUnits>0</dtp:RackUnits>
					<dtp:Voltage>0</dtp:Voltage>
					<dtp:Weight>0</dtp:Weight>
					<dtp:Width>0.64</dtp:Width>
					<dtp:WireLength>0</dtp:WireLength>
					<dtp:Amps>0</dtp:Amps>
				</dtp:Specification>
				<dtp:Price>
					<dtp:UnitPrice>3.75</dtp:UnitPrice>
					<dtp:ExtendedPrice>3.75</dtp:ExtendedPrice>
					<dtp:InstallationPrice>43.51</dtp:InstallationPrice>
					<dtp:LaborPrice>37.50</dtp:LaborPrice>
					<dtp:MiscLaborPrice>0.00</dtp:MiscLaborPrice>
					<dtp:MgtLaborPrice>0.00</dtp:MgtLaborPrice>
					<dtp:DesignLaborPrice>0.00</dtp:DesignLaborPrice>
					<dtp:MiscPartsAdjustment>1.13</dtp:MiscPartsAdjustment>
					<dtp:EquipmentAdjustment>1.13</dtp:EquipmentAdjustment>
					<dtp:ItemTaxes>
						<dtp:ItemTax>
							<dtp:TaxCode />
							<dtp:Description>Sales Tax</dtp:Description>
							<dtp:Amount>3.53</dtp:Amount>
							<dtp:EquipmentAmount>0.49</dtp:EquipmentAmount>
							<dtp:LaborAmount>3.04</dtp:LaborAmount>
						</dtp:ItemTax>
					</dtp:ItemTaxes>
				</dtp:Price>
				<dtp:Cost>
					<dtp:UnitCost>1.75</dtp:UnitCost>
					<dtp:ExtendedCost>1.75</dtp:ExtendedCost>
					<dtp:LaborCost>12.50</dtp:LaborCost>
					<dtp:MiscLaborCost>0.00</dtp:MiscLaborCost>
					<dtp:MgtLaborCost>0.00</dtp:MgtLaborCost>
					<dtp:DesignLaborCost>0.00</dtp:DesignLaborCost>
				</dtp:Cost>
				<dtp:Discount>0</dtp:Discount>
				<dtp:PriceType>A</dtp:PriceType>
				<dtp:LaborCalculationMethod>0</dtp:LaborCalculationMethod>
				<dtp:LaborHours>0.5</dtp:LaborHours>
				<dtp:ActualLaborHours>0</dtp:ActualLaborHours>
				<dtp:CalculateUsingActualHours>false</dtp:CalculateUsingActualHours>
				<dtp:ItemType>Coaxial F</dtp:ItemType>
				<dtp:Location xsi:nil="true" />
				<dtp:Zone xsi:nil="true" />
				<dtp:Phase>
					<dtp:Id>2</dtp:Id>
					<dtp:Name>Trim</dtp:Name>
					<dtp:Action />
					<dtp:Order>2</dtp:Order>
					<dtp:DifficultyFactor>1</dtp:DifficultyFactor>
					<dtp:MiscPartsFactor>0</dtp:MiscPartsFactor>
					<dtp:MiscEquipmentFactor>0</dtp:MiscEquipmentFactor>
					<dtp:PhaseSpecific>false</dtp:PhaseSpecific>
					<dtp:IgnoreLabor>false</dtp:IgnoreLabor>
					<dtp:LaborCost>
						<dtp:Rate>25</dtp:Rate>
						<dtp:Factor>1</dtp:Factor>
						<dtp:Profit>66.6666666666667</dtp:Profit>
						<dtp:Sale>75</dtp:Sale>
					</dtp:LaborCost>
					<dtp:MiscLaborCost>
						<dtp:Rate>0</dtp:Rate>
						<dtp:Factor>0</dtp:Factor>
						<dtp:Profit>0</dtp:Profit>
						<dtp:Sale>0</dtp:Sale>
					</dtp:MiscLaborCost>
					<dtp:MgtCost>
						<dtp:Rate>0</dtp:Rate>
						<dtp:Factor>0</dtp:Factor>
						<dtp:Profit>0</dtp:Profit>
						<dtp:Sale>0</dtp:Sale>
					</dtp:MgtCost>
					<dtp:DesignCost>
						<dtp:Rate>0</dtp:Rate>
						<dtp:Factor>0</dtp:Factor>
						<dtp:Profit>0</dtp:Profit>
						<dtp:Sale>0</dtp:Sale>
					</dtp:DesignCost>
				</dtp:Phase>
				<dtp:IgnoreZeroDimensions>false</dtp:IgnoreZeroDimensions>
				<dtp:IgnoreZeroListPrice>false</dtp:IgnoreZeroListPrice>
				<dtp:SalesOrderID>0</dtp:SalesOrderID>
				<dtp:WorkOrderID>0</dtp:WorkOrderID>
				<dtp:SKU />
				<dtp:Guid>691AEE1A-663C-4FD4-B249-B86187D63C5C</dtp:Guid>
				<dtp:Installed>false</dtp:Installed>
				<dtp:ExpectedInstallDate>0001-01-01T00:00:00</dtp:ExpectedInstallDate>
				<dtp:InstallDate>0001-01-01T00:00:00</dtp:InstallDate>
				<dtp:AssignedResource>0</dtp:AssignedResource>
				<dtp:Image />
				<dtp:OwnerFurnishedEquipment>false</dtp:OwnerFurnishedEquipment>
				<dtp:Taxable>true</dtp:Taxable>
				<dtp:MSRP>3.7</dtp:MSRP>
				<dtp:URL />
				<dtp:IPAddress />
				<dtp:CanadianProductTaxCode />
				<dtp:CanadianLaborTaxCode />
				<dtp:CanadianPurchaseTaxCode />
				<dtp:InputList />
				<dtp:InputSignal />
				<dtp:InputTerminal />
				<dtp:OutputList />
				<dtp:OutputSignal />
				<dtp:OutputTerminal />
				<dtp:FixedLaborCost>0</dtp:FixedLaborCost>
				<dtp:FixedLaborPrice>0</dtp:FixedLaborPrice>
				<dtp:SerialNumber />
				<dtp:ItemPrices>
					<dtp:LevelA>
						<dtp:Cost>1.75</dtp:Cost>
						<dtp:Price>3.75</dtp:Price>
					</dtp:LevelA>
					<dtp:LevelB>
						<dtp:Cost>0</dtp:Cost>
						<dtp:Price>0</dtp:Price>
					</dtp:LevelB>
					<dtp:LevelC>
						<dtp:Cost>0</dtp:Cost>
						<dtp:Price>0</dtp:Price>
					</dtp:LevelC>
				</dtp:ItemPrices>
				<dtp:CustomProperties>
					<dtp:CustomProperty>
						<dtp:Name />
						<dtp:Value>Sample Data</dtp:Value>
					</dtp:CustomProperty>
					<dtp:CustomProperty>
						<dtp:Name />
						<dtp:Value />
					</dtp:CustomProperty>
					<dtp:CustomProperty>
						<dtp:Name />
						<dtp:Value />
					</dtp:CustomProperty>
					<dtp:CustomProperty>
						<dtp:Name />
						<dtp:Value />
					</dtp:CustomProperty>
					<dtp:CustomProperty>
						<dtp:Name />
						<dtp:Value />
					</dtp:CustomProperty>
					<dtp:CustomProperty>
						<dtp:Name />
						<dtp:Value />
					</dtp:CustomProperty>
					<dtp:CustomProperty>
						<dtp:Name />
						<dtp:Value />
					</dtp:CustomProperty>
					<dtp:CustomProperty>
						<dtp:Name />
						<dtp:Value />
					</dtp:CustomProperty>
					<dtp:CustomProperty>
						<dtp:Name />
						<dtp:Value />
					</dtp:CustomProperty>
					<dtp:CustomProperty>
						<dtp:Name />
						<dtp:Value />
					</dtp:CustomProperty>
				</dtp:CustomProperties>
				<dtp:AccountingItemID>LEVITON 40831</dtp:AccountingItemID>
				<dtp:AccountingVendorName>AVCON</dtp:AccountingVendorName>
				<dtp:Keywords>
					<dtp:Keyword />
					<dtp:Keyword />
					<dtp:Keyword />
				</dtp:Keywords>
				<dtp:ChangeType>None</dtp:ChangeType>
				<dtp:Summarize>false</dtp:Summarize>
				<dtp:EquipmentPriceSummary>
					<dtp:UnitPrice>3.75</dtp:UnitPrice>
					<dtp:ExtendedPrice>3.75</dtp:ExtendedPrice>
					<dtp:InstallationPrice>43.51</dtp:InstallationPrice>
					<dtp:LaborPrice>37.50</dtp:LaborPrice>
					<dtp:MiscLaborPrice>0.00</dtp:MiscLaborPrice>
					<dtp:MgtLaborPrice>0.00</dtp:MgtLaborPrice>
					<dtp:DesignLaborPrice>0.00</dtp:DesignLaborPrice>
					<dtp:MiscPartsAdjustment>1.13</dtp:MiscPartsAdjustment>
					<dtp:EquipmentAdjustment>1.13</dtp:EquipmentAdjustment>
					<dtp:ItemTaxes>
						<dtp:ItemTax>
							<dtp:TaxCode />
							<dtp:Description>Sales Tax</dtp:Description>
							<dtp:Amount>3.53</dtp:Amount>
							<dtp:EquipmentAmount>0.49</dtp:EquipmentAmount>
							<dtp:LaborAmount>3.04</dtp:LaborAmount>
						</dtp:ItemTax>
					</dtp:ItemTaxes>
				</dtp:EquipmentPriceSummary>
				<dtp:EquipmentCostSummary>
					<dtp:UnitCost>0</dtp:UnitCost>
					<dtp:ExtendedCost>0</dtp:ExtendedCost>
					<dtp:LaborCost>0</dtp:LaborCost>
					<dtp:MiscLaborCost>0</dtp:MiscLaborCost>
					<dtp:MgtLaborCost>0</dtp:MgtLaborCost>
					<dtp:DesignLaborCost>0</dtp:DesignLaborCost>
				</dtp:EquipmentCostSummary>
      <%
			  rs2.MoveNext
			Loop
			%>
			</dtp:Equipment>
    <dtp:Total>0</dtp:Total>
  </dtp:BOM>
  <dtp:MiscCosts />
  <dtp:Phases>
    <dtp:Phase>
      <dtp:Id>1</dtp:Id>
      <dtp:Name>Rough-In</dtp:Name>
      <dtp:Action>HeadEnd</dtp:Action>
      <dtp:Order>1</dtp:Order>
      <dtp:DifficultyFactor>1</dtp:DifficultyFactor>
      <dtp:MiscPartsFactor>0</dtp:MiscPartsFactor>
      <dtp:MiscEquipmentFactor>0</dtp:MiscEquipmentFactor>
      <dtp:PhaseSpecific>false</dtp:PhaseSpecific>
      <dtp:IgnoreLabor>false</dtp:IgnoreLabor>
      <dtp:LaborCost>
        <dtp:Rate>25</dtp:Rate>
        <dtp:Factor>1</dtp:Factor>
        <dtp:Profit>28.5714285714286</dtp:Profit>
        <dtp:Sale>35</dtp:Sale>
      </dtp:LaborCost>
      <dtp:MiscLaborCost>
        <dtp:Rate>0</dtp:Rate>
        <dtp:Factor>0</dtp:Factor>
        <dtp:Profit>0</dtp:Profit>
        <dtp:Sale>0</dtp:Sale>
      </dtp:MiscLaborCost>
      <dtp:MgtCost>
        <dtp:Rate>0</dtp:Rate>
        <dtp:Factor>0</dtp:Factor>
        <dtp:Profit>0</dtp:Profit>
        <dtp:Sale>0</dtp:Sale>
      </dtp:MgtCost>
      <dtp:DesignCost>
        <dtp:Rate>25</dtp:Rate>
        <dtp:Factor>0</dtp:Factor>
        <dtp:Profit>28.5714285714286</dtp:Profit>
        <dtp:Sale>35</dtp:Sale>
      </dtp:DesignCost>
    </dtp:Phase>
    <dtp:Phase>
      <dtp:Id>2</dtp:Id>
      <dtp:Name>Trim</dtp:Name>
      <dtp:Action />
      <dtp:Order>2</dtp:Order>
      <dtp:DifficultyFactor>1</dtp:DifficultyFactor>
      <dtp:MiscPartsFactor>0</dtp:MiscPartsFactor>
      <dtp:MiscEquipmentFactor>0</dtp:MiscEquipmentFactor>
      <dtp:PhaseSpecific>false</dtp:PhaseSpecific>
      <dtp:IgnoreLabor>false</dtp:IgnoreLabor>
      <dtp:LaborCost>
        <dtp:Rate>25</dtp:Rate>
        <dtp:Factor>1</dtp:Factor>
        <dtp:Profit>66.6666666666667</dtp:Profit>
        <dtp:Sale>75</dtp:Sale>
      </dtp:LaborCost>
      <dtp:MiscLaborCost>
        <dtp:Rate>0</dtp:Rate>
        <dtp:Factor>0</dtp:Factor>
        <dtp:Profit>0</dtp:Profit>
        <dtp:Sale>0</dtp:Sale>
      </dtp:MiscLaborCost>
      <dtp:MgtCost>
        <dtp:Rate>0</dtp:Rate>
        <dtp:Factor>0</dtp:Factor>
        <dtp:Profit>0</dtp:Profit>
        <dtp:Sale>0</dtp:Sale>
      </dtp:MgtCost>
      <dtp:DesignCost>
        <dtp:Rate>0</dtp:Rate>
        <dtp:Factor>0</dtp:Factor>
        <dtp:Profit>0</dtp:Profit>
        <dtp:Sale>0</dtp:Sale>
      </dtp:DesignCost>
    </dtp:Phase>
    <dtp:Phase>
      <dtp:Id>3</dtp:Id>
      <dtp:Name>Programming</dtp:Name>
      <dtp:Action />
      <dtp:Order>3</dtp:Order>
      <dtp:DifficultyFactor>1</dtp:DifficultyFactor>
      <dtp:MiscPartsFactor>0</dtp:MiscPartsFactor>
      <dtp:MiscEquipmentFactor>0</dtp:MiscEquipmentFactor>
      <dtp:PhaseSpecific>false</dtp:PhaseSpecific>
      <dtp:IgnoreLabor>false</dtp:IgnoreLabor>
      <dtp:LaborCost>
        <dtp:Rate>75</dtp:Rate>
        <dtp:Factor>1</dtp:Factor>
        <dtp:Profit>50</dtp:Profit>
        <dtp:Sale>150</dtp:Sale>
      </dtp:LaborCost>
      <dtp:MiscLaborCost>
        <dtp:Rate>0</dtp:Rate>
        <dtp:Factor>0</dtp:Factor>
        <dtp:Profit>0</dtp:Profit>
        <dtp:Sale>0</dtp:Sale>
      </dtp:MiscLaborCost>
      <dtp:MgtCost>
        <dtp:Rate>0</dtp:Rate>
        <dtp:Factor>0</dtp:Factor>
        <dtp:Profit>0</dtp:Profit>
        <dtp:Sale>0</dtp:Sale>
      </dtp:MgtCost>
      <dtp:DesignCost>
        <dtp:Rate>0</dtp:Rate>
        <dtp:Factor>0</dtp:Factor>
        <dtp:Profit>0</dtp:Profit>
        <dtp:Sale>0</dtp:Sale>
      </dtp:DesignCost>
    </dtp:Phase>
    <dtp:Phase>
      <dtp:Id>4</dtp:Id>
      <dtp:Name>Finish</dtp:Name>
      <dtp:Action />
      <dtp:Order>4</dtp:Order>
      <dtp:DifficultyFactor>1</dtp:DifficultyFactor>
      <dtp:MiscPartsFactor>0</dtp:MiscPartsFactor>
      <dtp:MiscEquipmentFactor>0</dtp:MiscEquipmentFactor>
      <dtp:PhaseSpecific>false</dtp:PhaseSpecific>
      <dtp:IgnoreLabor>false</dtp:IgnoreLabor>
      <dtp:LaborCost>
        <dtp:Rate>25</dtp:Rate>
        <dtp:Factor>1</dtp:Factor>
        <dtp:Profit>66.6666666666667</dtp:Profit>
        <dtp:Sale>75</dtp:Sale>
      </dtp:LaborCost>
      <dtp:MiscLaborCost>
        <dtp:Rate>0</dtp:Rate>
        <dtp:Factor>0</dtp:Factor>
        <dtp:Profit>0</dtp:Profit>
        <dtp:Sale>0</dtp:Sale>
      </dtp:MiscLaborCost>
      <dtp:MgtCost>
        <dtp:Rate>0</dtp:Rate>
        <dtp:Factor>0</dtp:Factor>
        <dtp:Profit>0</dtp:Profit>
        <dtp:Sale>0</dtp:Sale>
      </dtp:MgtCost>
      <dtp:DesignCost>
        <dtp:Rate>0</dtp:Rate>
        <dtp:Factor>0</dtp:Factor>
        <dtp:Profit>0</dtp:Profit>
        <dtp:Sale>0</dtp:Sale>
      </dtp:DesignCost>
    </dtp:Phase>
  </dtp:Phases>
  <dtp:Zones>
    <dtp:Zone>
      <dtp:Id>1</dtp:Id>
      <dtp:Name>Are "Zones" System Types?</dtp:Name>
      <dtp:Description />
      <dtp:Order>1</dtp:Order>
    </dtp:Zone>
    <dtp:Zone>
      <dtp:Id>2</dtp:Id>
      <dtp:Name>Like "Fire Alarm" or sumpn?</dtp:Name>
      <dtp:Description />
      <dtp:Order>2</dtp:Order>
    </dtp:Zone>
    <dtp:Zone>
      <dtp:Id>3</dtp:Id>
      <dtp:Name>Surveillance? idunno</dtp:Name>
      <dtp:Description />
      <dtp:Order>3</dtp:Order>
    </dtp:Zone>
  </dtp:Zones>
  <dtp:LocationTypes>
    <dtp:LocationType>
      <dtp:Id>1</dtp:Id>
      <dtp:TypeName>Building</dtp:TypeName>
      <dtp:OrderId>1</dtp:OrderId>
    </dtp:LocationType>
    <dtp:LocationType>
      <dtp:Id>2</dtp:Id>
      <dtp:TypeName>Floor</dtp:TypeName>
      <dtp:OrderId>2</dtp:OrderId>
    </dtp:LocationType>
    <dtp:LocationType>
      <dtp:Id>3</dtp:Id>
      <dtp:TypeName>Room</dtp:TypeName>
      <dtp:OrderId>3</dtp:OrderId>
    </dtp:LocationType>
  </dtp:LocationTypes>
  <dtp:Locations />
  <dtp:Contacts>
    <dtp:Contact>
      <dtp:Id>1</dtp:Id>
      <dtp:Type>Client</dtp:Type>
      <dtp:Address>
        <dtp:CompanyName>Reliance Electric</dtp:CompanyName>
        <dtp:Address1>1250 W. Utah Ave</dtp:Address1>
        <dtp:Address2 />
        <dtp:City>Hildale</dtp:City>
        <dtp:State>UT</dtp:State>
        <dtp:PostalCode>84784</dtp:PostalCode>
        <dtp:Country />
        <dtp:PhoneNumber>435-874-1250</dtp:PhoneNumber>
        <dtp:FaxNumber />
        <dtp:Contact>Randy Barlow</dtp:Contact>
        <dtp:ContactTitle>Leed Estimator</dtp:ContactTitle>
        <dtp:ContactEmail>randy@reliancelectric.us</dtp:ContactEmail>
        <dtp:ContactPhoneNumber>435-874-1250</dtp:ContactPhoneNumber>
      </dtp:Address>
    </dtp:Contact>
  </dtp:Contacts>
  <dtp:CustomProperties>
    <dtp:CustomProperty>
      <dtp:Name>P1</dtp:Name>
      <dtp:Value />
    </dtp:CustomProperty>
    <dtp:CustomProperty>
      <dtp:Name>P2</dtp:Name>
      <dtp:Value />
    </dtp:CustomProperty>
    <dtp:CustomProperty>
      <dtp:Name>P3</dtp:Name>
      <dtp:Value />
    </dtp:CustomProperty>
    <dtp:CustomProperty>
      <dtp:Name>P4</dtp:Name>
      <dtp:Value />
    </dtp:CustomProperty>
    <dtp:CustomProperty>
      <dtp:Name>P5</dtp:Name>
      <dtp:Value />
    </dtp:CustomProperty>
    <dtp:CustomProperty>
      <dtp:Name>P6</dtp:Name>
      <dtp:Value />
    </dtp:CustomProperty>
    <dtp:CustomProperty>
      <dtp:Name>P7</dtp:Name>
      <dtp:Value />
    </dtp:CustomProperty>
    <dtp:CustomProperty>
      <dtp:Name>P8</dtp:Name>
      <dtp:Value />
    </dtp:CustomProperty>
    <dtp:CustomProperty>
      <dtp:Name>P9</dtp:Name>
      <dtp:Value />
    </dtp:CustomProperty>
    <dtp:CustomProperty>
      <dtp:Name>P10</dtp:Name>
      <dtp:Value />
    </dtp:CustomProperty>
  </dtp:CustomProperties>
  <dtp:PriceFactors>
    <dtp:SalesTaxRate>0.081</dtp:SalesTaxRate>
    <dtp:LaborSalesTaxRate>0.081</dtp:LaborSalesTaxRate>
    <dtp:MiscPartsFactor>0.3</dtp:MiscPartsFactor>
    <dtp:MiscEquipmentFactor>0.3</dtp:MiscEquipmentFactor>
  </dtp:PriceFactors>
  <dtp:ContractPercentages>
    <dtp:ContractPercentage>
      <dtp:PaymentType>Plans/Permits</dtp:PaymentType>
      <dtp:BillingPercentage>9</dtp:BillingPercentage>
      <dtp:BillingDate />
      <dtp:BillingAmount>0.0000</dtp:BillingAmount>
      <dtp:CurrencySymbol />
    </dtp:ContractPercentage>
    <dtp:ContractPercentage>
      <dtp:PaymentType>Rough In Materials</dtp:PaymentType>
      <dtp:BillingPercentage>13.5</dtp:BillingPercentage>
      <dtp:BillingDate />
      <dtp:BillingAmount>0.0000</dtp:BillingAmount>
      <dtp:CurrencySymbol />
    </dtp:ContractPercentage>
    <dtp:ContractPercentage>
      <dtp:PaymentType>Rough In Labor</dtp:PaymentType>
      <dtp:BillingPercentage>18</dtp:BillingPercentage>
      <dtp:BillingDate />
      <dtp:BillingAmount>0.0000</dtp:BillingAmount>
      <dtp:CurrencySymbol />
    </dtp:ContractPercentage>
    <dtp:ContractPercentage>
      <dtp:PaymentType>Finish Materials</dtp:PaymentType>
      <dtp:BillingPercentage>40.5</dtp:BillingPercentage>
      <dtp:BillingDate />
      <dtp:BillingAmount>0.0000</dtp:BillingAmount>
      <dtp:CurrencySymbol />
    </dtp:ContractPercentage>
    <dtp:ContractPercentage>
      <dtp:PaymentType>Finish Labor</dtp:PaymentType>
      <dtp:BillingPercentage>7.2</dtp:BillingPercentage>
      <dtp:BillingDate />
      <dtp:BillingAmount>0.0000</dtp:BillingAmount>
      <dtp:CurrencySymbol />
    </dtp:ContractPercentage>
    <dtp:ContractPercentage>
      <dtp:PaymentType>Programming/Final Inspections</dtp:PaymentType>
      <dtp:BillingPercentage>1.8</dtp:BillingPercentage>
      <dtp:BillingDate />
      <dtp:BillingAmount>0.0000</dtp:BillingAmount>
      <dtp:CurrencySymbol />
    </dtp:ContractPercentage>
    <dtp:ContractPercentage>
      <dtp:PaymentType>Retention</dtp:PaymentType>
      <dtp:BillingPercentage>10</dtp:BillingPercentage>
      <dtp:BillingDate />
      <dtp:BillingAmount>0.0000</dtp:BillingAmount>
      <dtp:CurrencySymbol />
    </dtp:ContractPercentage>
  </dtp:ContractPercentages>
  <dtp:TaxRates>
    <dtp:Country>Canada</dtp:Country>
    <dtp:TaxRate>
      <dtp:TaxRate>
        <dtp:TaxCode>E</dtp:TaxCode>
        <dtp:Description>Exempt</dtp:Description>
        <dtp:PSTRate>0</dtp:PSTRate>
        <dtp:GSTRate>0</dtp:GSTRate>
      </dtp:TaxRate>
      <dtp:TaxRate>
        <dtp:TaxCode>G</dtp:TaxCode>
        <dtp:Description>GST Only</dtp:Description>
        <dtp:PSTRate>0</dtp:PSTRate>
        <dtp:GSTRate>0</dtp:GSTRate>
      </dtp:TaxRate>
      <dtp:TaxRate>
        <dtp:TaxCode>P</dtp:TaxCode>
        <dtp:Description>PST Only</dtp:Description>
        <dtp:PSTRate>0.14</dtp:PSTRate>
        <dtp:GSTRate>0</dtp:GSTRate>
      </dtp:TaxRate>
      <dtp:TaxRate>
        <dtp:TaxCode>S</dtp:TaxCode>
        <dtp:Description>Standard</dtp:Description>
        <dtp:PSTRate>0</dtp:PSTRate>
        <dtp:GSTRate>0</dtp:GSTRate>
      </dtp:TaxRate>
      <dtp:TaxRate>
        <dtp:TaxCode>Z</dtp:TaxCode>
        <dtp:Description>Zero</dtp:Description>
        <dtp:PSTRate>0</dtp:PSTRate>
        <dtp:GSTRate>0</dtp:GSTRate>
      </dtp:TaxRate>
    </dtp:TaxRate>
  </dtp:TaxRates>
  <dtp:InternationalSettings>
    <dtp:Measurement>US</dtp:Measurement>
    <dtp:Currency>Dollar</dtp:Currency>
    <dtp:DateFormat>mm/dd/yyyy</dtp:DateFormat>
    <dtp:TaxCountry>Standard</dtp:TaxCountry>
  </dtp:InternationalSettings>
  <dtp:WireConnections />
  <dtp:ScopeOfWork>So I get to type in the cooly cooly scope here.</dtp:ScopeOfWork>
  <dtp:ChangeOrderComments />
  <dtp:Revision>0</dtp:Revision>
  <dtp:Status>01 - Discovery</dtp:Status>
  <dtp:Owner>Reliance Electric</dtp:Owner>
  <dtp:ProjectStaff1>Stanton Bistline</dtp:ProjectStaff1>
  <dtp:ProjectStaff2>Edmund Barlow Jr.</dtp:ProjectStaff2>
  <dtp:ProjectStaff3>Stanton Bistline</dtp:ProjectStaff3>
  <dtp:ProjectStaff4>Darren Jessop</dtp:ProjectStaff4>
  <dtp:DateCreated>2012-04-11T14:04:33</dtp:DateCreated>
  <dtp:DateModified>2012-04-11T17:13:14</dtp:DateModified>
  <dtp:DateStarted>2012-04-11T14:05:00</dtp:DateStarted>
  <dtp:DateCompleted>0001-01-01T00:00:00</dtp:DateCompleted>
  <dtp:ClientGuid>4f6252c0-f7ad-4095-99a3-48ea730a125c</dtp:ClientGuid>
  <dtp:ProjectFolder />
  <dtp:DefaultPriceType>A</dtp:DefaultPriceType>
  <dtp:DefaultWireLength>150</dtp:DefaultWireLength>
  <dtp:MaintainZoneOrder>true</dtp:MaintainZoneOrder>
  <dtp:ComponentIDFormats>
    <dtp:ComponentIDFormat>
      <dtp:Field>true</dtp:Field>
      <dtp:Name>Type</dtp:Name>
      <dtp:Length>3</dtp:Length>
    </dtp:ComponentIDFormat>
  </dtp:ComponentIDFormats>
  <dtp:QuickLinks />
</dtp:SI5Project>
