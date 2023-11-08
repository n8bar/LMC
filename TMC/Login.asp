<!DOCTYPE HTML>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<script type="text/javascript" src="LoginAJAX.js"></script>
<script type="text/javascript" src="rcstri.js"></script>
 
<style>
	table,tr,td,form,font,label,input,div,a,b,i { -webkit-box-sizing:border-box; -moz-box-sizing:border-box; box-sizing:border-box; }
	html { margin:0; padding:0; width:100%; height:100%; overflow:hidden; background-color:#A0AC50;
		background: -moz-linear-gradient( 90deg bottom left, #113322 0, rgba(240,192,96,1) 30%, rgba(240,192,96,1) 70%, #113322 100% );
		background: -webkit-gradient( linear,0 100%,0 0, from(#113322), color-stop(.5, rgba(240,192,96,1)), color-stop(.6, rgba(240,192,96,1)), to(#113322) );
		background: gradient( linear,0 100%,0 0, from(#113322), color-stop(.3, rgba(240,192,96,1)), color-stop(.7, rgba(240,192,96,1)), to(#113322) );
	}
	body { margin:0; padding:0; width:100%; height:100%; overflow:hidden; color:#230; /* background-image:url(Logos/Acorn.png); background-size:cover; */ }
	
	.text{outline:none; border-radius:6px; -ie-border-radius:6px; border:inset 1px; background-color:rgba(255,255,255,.75); margin:2px; padding:2px;}
	strong{text-shadow:#fff 0px 0px 1px, #fff 0px 0px 2px, #fff 0px 0px 3px, #fff 0px 0px 5px, #fff 0px 0px 10px, #fff 0px 0px 20px, #fff 0px 0px 40px;}
	#caseSensitive{text-shadow:#fff 0px 0px 1px, #fff 0px 0px 2px, #fff 0px 0px 3px, #fff 0px 0px 5px, #fff 0px 0px 10px, #fff 0px 0px 20px, #fff 0px 0px 40px;}
	.tmc{
			font-family:"Dejavu sans", Arial, Geneva, sans-serif; font-size:48px; /*font-style:italic;*/ font-weight:bold; text-align:center; padding: 12px 0 0 0;
			text-shadow:#fff 0 0 40px, #fff 0 0 36px, #fff 0 0 32px, #fff 0 0 28px, #fff 0 0 24px, #fff 0 0 20px, #fff 0 0 16px, #fff 0 0 12px, #fff 0 0 8px, #fff 0 0 4px;
	}	
	#loginMeat { margin:0 auto 0 auto; background:rgba(144,184,128,.67); width:50%; border:rgba(64,112,72,.25) 5px solid; border-radius:32px; box-shadow: #fff, 0 0 10px;}
	.mobile{display:block; float:right; text-decoration:none; padding:3px; font-weight:bold; color:#240; text-align:center; }
</style>

 
</head>
 
<body onLoad="document.getElementById('user').focus();" >
<table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0" >
	<tr height="64" valign="bottom" >
		<td class=tmc><span style="position:absolute; top:0; left:0; width:100%; text-align:center;"><br/><%="Lovo"%> Management Center</span></td>
	</tr>
	<tr> 
		<td width="100%" height="100%" align="center" valign="middle"> 
			<table width=768 height=768 border=0 cellpadding=0 cellspacing=0 >
				<tr>
					<td width="648" height="500" align="center" valign="middle" style="background:url(Logos/LovoL.png) center fixed no-repeat; "> 
						<span action="javascript:Login();" method=post >
							<div id=loginMeat>
								<br/>
								<label style="">
									<font color=black size=2 face="Verdana, Arial, Helvetica, sans-serif" style="" ><strong>Username:</strong></font>
									<input class=text type=text id=user size=16 onKeyPress="ifEnter(event,'pass.focus();');"/>
								</label>
								<br/>
								<label>
									<font color=black size=2 face="Verdana, Arial, Helvetica, sans-serif" ><strong>Password:</strong></font>
									<input class=text type=password id=pass size=16 onKeyPress="ifEnter(event,'Login();')" onFocus="//Gebi('caseSensitive').innerHTML='Case Sensitive!';" onBlur="Gebi('caseSensitive').innerHTML='&nbsp;';" />
								</label>
								<table width="222" border="0" cellspacing="0" cellpadding="0">
									<tr> 
										<td width="78" height="26">
											<input type=reset name=Cancel value=Clear >
										</td>
										<td width="66"></td>
										<td width="78">
											<!-- input type="submit" name="Login" value="Login"/ -->
											<input type=button name=Login onClick="Login();" value=Login />
										</td>
									</tr>
								</table>
								<br/>
							</div> 
						</span>
					</td>  
				</tr>
				<tr height="24" ></tr>
				<tr height="24" >
					<td ><!-- button class="mobile" onclick="window.top.location='../m';">TMC Mobile</button --></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<script type="text/javascript">Validate();</script>
</body>
</html>

