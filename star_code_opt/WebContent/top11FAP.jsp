	<% 
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:
	 *Date of Creation 		:
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STARS
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is the Menu Builder File, For adding Menus enter the data in ROLES_RESOURCES table
	 *Modification 			:1. menuSize is added for the All Pending Menu item made for chairman -
	                         : 2:added a new block of code for adding  new role for reports  open ==== 30-Apr-08  
							 3Added a new role for Corporate person to provide report Access on 05-Jun-08 by shiv sharma 
							 4:added flage for identifing visio corp user on 12 aug  2009

	 *Reason of Modification:1. Change Request
	 *Date of Modification  :1.09-Apr-2007 By Gaurav Aggarwal						 
	 *Revision History		:
	 *Editor				:Editplus
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:21 july 2011
	 *Modification			:Remove Main Menu label
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:01 June 2012
	 *Modification			:Implementing multilingual for all menus/submenus
	 *******************************************************/
	%>
	
	
	<%
		//	Modification History: By @Gaurav 09-March-2007 
	%>
	<%@ page pageEncoding="UTF-8" %>
	<%@ include  file="importStatement.jsp" %> 
	<html>
	<head>
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript1.2" src="ScriptLibrary/main.js?buildstamp=2_0_0" type="text/javascript"></SCRIPT>
	<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	function sbtFrm()
	{
		 document.frm1.submit();
	}
	//-->
	</SCRIPT>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<%-- include page styles  --%>
	<%-- <%@ include  file="systemStyle.jsp" %> --%>
	
	<%@ page  language="java"  import="java.io.*,java.util.*,src.connection.PropertiesLoader" %>
	
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	
	<!--Create the DbUtilityMethods object for utility methods-->
	<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	
	<style type="text/css">
	#dhtmltooltip{
	position: absolute;
	border: 2px solid black;
	padding: 2px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	font-style: normal;
	font-weight: normal;
	color: #000000;
	text-decoration: none;
	letter-spacing: normal;
	word-spacing: normal;
	border: 1px #333333 solid;
	background:#FFFFFF;
	visibility: hidden;
	z-index: 200;
	
	}
	</style>
	
	</head>
	
	<%
	
	// Variables declared and initialized
	ResultSet objRs,objRs1				=		null;			  // Object for ResultSet
	String	strSqlStr	=	""; // For sql Statements
			
	String strIPAddress = "127.1.1.1";   
	strIPAddress = request.getRemoteAddr();   
	strIPAddress = " ["+strIPAddress+"]";
	//varriable added by vaibhav
	String help_desk_mail = "";

	String strLangValue= request.getParameter("language")==null?strsesLanguage:request.getParameter("language");
	
	hs.putValue("sesLanguage",strLangValue);
	
	String m1Flag 		= hs.getValue("frmApp") == null ? "" : (String) hs.getValue("frmApp");
	String domain 		= hs.getValue("domain") == null ? "" : (String)hs.getValue("domain");
	String winUserId 	= hs.getValue("winUserId") == null ? "" : (String)hs.getValue("winUserId");
	String userFirstName= hs.getValue("sUserFirstName") == null ? "" : (String)hs.getValue("sUserFirstName");
	String userLastName	= hs.getValue("sUserLastName") == null ? "" : (String) " "+hs.getValue("sUserLastName");
	String userName		= userFirstName + userLastName;
	String tooltipName	= userLastName+", "+userFirstName+" ("+domain.toUpperCase()+")";
	int colspanCnt		= 3;
	%>
	
	
	<body class="body"  >
		<div class="motherson1tooltip" style="display: none;">
			Motherson 1
		</div>
		<div class="starstooltip" style="display: none;">
			Samvardhana Motherson Travel AppRoval System (STARS)
		</div>
		<div class="usernametooltip" style="display: none;">
			<%=tooltipName%>
		</div>
		 
	  <form name=frm1 method=post action="intro.jsp?id=2" target="middle">
	  </form>
	  <DIV id="TipLayer" style="visibility:hidden;position:absolute;z-index:1000;top:-100"></DIV>
	  <SCRIPT language="JavaScript1.2" src="ScriptLibrary/style.js?buildstamp=2_0_0" type="text/javascript"></SCRIPT>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td height="60" valign="top" background="images/header_bg.gif?buildstamp=2_0_0">
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr>
	      	<%	if("MONE".equals(m1Flag)) { 
	      			++colspanCnt;
	      	%>
        		<td width="8%" height="60" nowrap="nowrap">
          			<a id="motherson1" href="https://one.motherson.com/SitePages/main.aspx" target="_blank">
						<img src="images/m1-logo.png?buildstamp=2_0_0" border=0>
					</a>
          		</td>
            	<td width="40%" height="60" nowrap="nowrap">
	       	<%	} else { %>
	       		 <td width="50%" height="60" nowrap="nowrap">
	        <%  } %>
	            	<table width="95%" border="0" cellspacing="0" cellpadding="0">
	            		<tr>
	            			<td class="headerTxt2" nowrap="nowrap">
	            				<a class="homeLink" href="intro.jsp?id=1" target="middle">
	            					&nbsp;<%=dbLabelBean.getLabel("label.header.samvardhanamothersontravelapprovalsystem",strLangValue)%> (<%=dbLabelBean.getLabel("label.header.stars",strLangValue)%>)
	            				</a>
	            			</td>
	            		</tr>
	            	</table>
	            </td>
		        <td width="20%" class="headerTxt3" style="text-align: right;padding-top: 5px;font-size: 10px;"><%=userName %></td>
			    <td width="22%" align="right" style="text-align: right;">
			    	<table width="350px" border="0" cellspacing="0" cellpadding="0">
			    		<tr>
			    			<td width="100%" align="right" style="padding-top:10px; padding-right:3px;">
			    			
							<%	
								help_desk_mail 	    = PropertiesLoader.config.getProperty("help_desk_mail");
							 %>
					            <table width="100%" border="0" cellspacing="0" cellpadding="0">
					            	<tr valign="top">					            			
					            		<td align="center" class="linkIconHeaderTd">					            			
					            			<div align="center" class="userImageDiv">
												<img id="uploadedImage" class="userImage" src="https://one.motherson.com/_layouts/15/userphoto.aspx?size=s&accountname=<%=domain %>\<%=winUserId %>">
											</div>					            			
					            		</td>	
					            		<td align="center" class="linkIconHeaderTd">					            			
					            			<a href="#" id="statistics" title="<%=dbLabelBean.getLabel("label.footer.statistics",strLangValue)%>">
					            				<div class="linkIconHeader">
													<img src="images/statistics.png?buildstamp=2_0_0" border=0>
													 <span><%=dbLabelBean.getLabel("label.footer.statistics",strLangValue)%></span>
												</div>
					            			</a>					            			
					            		</td>					            		
					            		<td align="center" class="linkIconHeaderTd">
					            			<a href="intro.jsp?id=1" id="home" target=middle title="<%=dbLabelBean.getLabel("label.footer.home",strLangValue)%>">
					            				<div class="linkIconHeader">
													<img src="images/home.png?buildstamp=2_0_0" border=0>
													 <span><%=dbLabelBean.getLabel("label.footer.home",strLangValue)%></span>
												</div>
					            			</a>
					            		</td>
					            <%	
					            	String agencyId = session.getAttribute("isMataGmbHSite") == null ? "" : (String)session.getAttribute("isMataGmbHSite");
					            
					            	if("true".equalsIgnoreCase(agencyId)) {
			            		%>		
			            				<td align="center" class="linkIconHeaderTd">
					            			<a href="#" id="GmbHManual" title="Manuals">
					            				<div class="linkIconHeader">
													<img src="images/HelpGmbH.png?buildstamp=2_0_0" border=0>
													 <span>Handbook</span>
												</div>
					            			</a>
					            		</td>
					            
					            <%	} else { %>	
					            		<td align="center" class="linkIconHeaderTd">
					            			<a href="#" id="presentation" title="<%=dbLabelBean.getLabel("label.footer.presentation",strLangValue)%>" onClick="window.open('STAR_Presentation.jsp','STAR','scrollbars=yes,resizable=yes,width=850,height=500')">
					            				<div class="linkIconHeader">
													<img src="images/presentation.png?buildstamp=2_0_0" border=0>
													 <span><%=dbLabelBean.getLabel("label.footer.presentation",strLangValue)%></span>
												</div>
					            			</a>
					            		</td>
					            <%	} %>		
					            		
					            		<td align="center" class="linkIconHeaderTd">
					            			<a href="#" onClick="mailTo();" id="helpdesk" class="textlink" title="<%=dbLabelBean.getLabel("label.footer.helpdesk",strLangValue)%>">
					            				<div class="linkIconHeader">
													<img src="images/mail.png?buildstamp=2_0_0" border=0>
													 <span><%=dbLabelBean.getLabel("label.footer.helpdesk",strLangValue)%></span>
												</div>
					            			</a>
					            		</td>
					            		<td align="center" class="linkIconHeaderTd">
					            			<a href=<%= "\"sessionExpired.jsp?sessionUid="+Suser_id+"\"" %> id="logout" title="<%=dbLabelBean.getLabel("label.footer.logout",strLangValue)%>" target=_parent >
					            				<div class="linkIconHeader">
													<img src="images/logout.png?buildstamp=2_0_0" border=0>
													 <span><%=dbLabelBean.getLabel("label.footer.logout",strLangValue)%></span>
												</div>
					            			</a>
					            		</td>
					            	</tr>					            	
					            </table>											
							</td>
						</tr>
			    	</table>
			    </td>
			  </tr>
	          <tr>
	            <td height="37"  colspan="<%=colspanCnt %>" valign="middle">
				  <table width="100%" border="0" cellspacing="0" cellpadding="0">          
				    <tr>
	<%
	String link=null; 
	int iWidthLoop=0;
	float fltTotalWidth		=	100;
	
	//objStmt  = objCon.createStatement();
	
	
	 
	
	if(SuserRole.trim().equals("AD"))
	{
	  strSqlStr="SELECT DISTINCT MAIN_LABEL,MAIN_TOOLTIPS,ARR_NO,MAINORDER FROM ROLES_RESOURCES WHERE ACCESS like '%"+SuserRole.trim()+"%' ORDER BY MAINORDER";
	}
	else if(SuserRole.trim().equals("CHAIRMAN"))
	{
	  strSqlStr="SELECT DISTINCT MAIN_LABEL,MAIN_TOOLTIPS,ARR_NO,MAINORDER FROM ROLES_RESOURCES WHERE ACCESS like '%"+SuserRole.trim()+"%' ORDER BY MAINORDER";
	}
	else
	{
	  strSqlStr="SELECT DISTINCT MAIN_LABEL,MAIN_TOOLTIPS,ARR_NO,MAINORDER FROM ROLES_RESOURCES WHERE ACCESS like '%All%' ORDER BY MAINORDER";
	}
	
	//New Check for local administrator
	if((SuserRoleOther.trim().equals("LA")))
	{
	  strSqlStr="SELECT DISTINCT MAIN_LABEL,MAIN_TOOLTIPS,ARR_NO,MAINORDER FROM ROLES_RESOURCES WHERE ACCESS like '%"+SuserRoleOther.trim()+"%' ORDER BY MAINORDER";
	}
	
	
	//
	
	// added a new block of code for adding  new role for reports  open ==== 30-Apr-08
	//Added a new role for Corporate person to provide report Access on 05-Jun-08 by shiv sharma 
	
	if((SuserRole.trim().equals("SM")) || SuserRole.trim().equals("CORP"))
	{
	  strSqlStr="SELECT DISTINCT MAIN_LABEL,MAIN_TOOLTIPS,ARR_NO,MAINORDER FROM ROLES_RESOURCES WHERE ACCESS like '%"+SuserRole.trim()+"%' ORDER BY MAINORDER";
	}
	
	 
	//  close
	
	
	objRs   = dbConBean.executeQuery(strSqlStr); 
	while(objRs.next())
	{
		iWidthLoop++;
	}
	objRs.close();
	objRs                   = dbConBean.executeQuery(strSqlStr); 
	fltTotalWidth           =  0/iWidthLoop;
	
	String m_label          =  null;
	int loop                =  1;
	int loop1               =  1;
	String strMAIN_TOOLTIPS =  "";
	String strMainID        =  "";
	String strTravelType    =  ""; 
	
	while(objRs.next())
	{   
	  m_label				= objRs.getString(1); 
	  strMAIN_TOOLTIPS	    = objRs.getString(2); 
	  //strMainID			= objRs.getString(4); 
	  if(m_label!=null && m_label.equals("label.mainmenu.internationaltravelrequest"))
	  {
		  strTravelType = "INT";
	  }
	  if(m_label!=null && m_label.equals("label.mainmenu.domestictravelrequest"))
	  {
		  strTravelType = "DOM";
	  }
	
 
	
	  if(m_label!=null && m_label.trim().equalsIgnoreCase("label.mainmenu.reports"))
	  {
		//Get the Access on Report for the login user
		String strReportAccess   = dbUtility.findReportAccessInMainMenu(SuserRole, SuserRoleOther, strSiteIdSS, Suser_id);	
	
		//System.out.println("strReportAccess======"+strReportAccess);
		if(strReportAccess != null && strReportAccess.equals("no"))
		{
			//Not show the Reports Link in Main menus		
		}
		else
		{
	%> 
					  <td width=<%=fltTotalWidth%> height="37" >  
					   
						<a class="menu" href="topMenuBuildUp.jsp?id=<%=m_label%>&travel_type=<%=strTravelType%>"><%=dbLabelBean.getLabel(m_label,strsesLanguage)%></a>
					  </td>  
	<%
		}
		 	
	  }
	  //new 3/8/2007
	  
	  else if(m_label!=null && m_label.trim().equalsIgnoreCase("Pending For Approval"))
	  {
	 	
	%>
		<td width=<%=fltTotalWidth%> height="37" > 
	 <!--@Gaurav 09-March-2007 menuSize is for the All Pending Menu item made for chairman -->
						<a class="menuSize" href="T_approveTravelRequisitions_All.jsp" target="middle"><%=m_label.trim()%></a>
						<!--<a class="menu" href="topMenuBuildUp.jsp?id=<%=m_label%>&travel_type=<%=strTravelType%>"><%=m_label.trim()%></a>-->
		</td>
	<%
	
		}
	//
	  else
	  {
		 
		// added flage for identifing visio corp user on 12 aug  2009
		 if(ssflage.equals("1")){ 
			 if (m_label.equals("label.mainmenu.internationaltravelrequest"))
			 	{
				 m_label="label.submenu.outsideregion";  
			 	}else if(m_label.equals("label.mainmenu.domestictravelrequest"))
			 	{
			 		m_label="label.submenu.withinregion";  
			 	}
			 
			 
		 }else if(ssflage.equals("3")){ 
			 if (m_label.equals("label.mainmenu.internationaltravelrequest"))
			 	{
			 	  m_label="label.global.interconttravelrequest"; 
			 	}else if(m_label.equals("label.mainmenu.domestictravelrequest"))
			 	{
			 		m_label="label.global.domesticeuropetravelrequest";   
			 	}
			 
			 
		 } else{
			 
		 }
	%> 
					  <td width=<%=fltTotalWidth%> height="37" > 
					    <a class="menu" href="topMenuBuildUp.jsp?id=<%=m_label%>&travel_type=<%=strTravelType%>"><%=dbLabelBean.getLabel(m_label,strsesLanguage)%></a>
					  </td>  
	<%
	  }  		
	%>
	<%
	}//end of while loop
	objRs.close();
	dbConBean.close();  //Close Connection
	%>
					</tr>
				  </table>
				</td>
			  </tr>
	        </table>
	      </td>
		</tr>
	  </table>
	 </body>
	</html>
<script type="text/javascript">

function mailTo() {
	var helpDeskMail = '<%=help_desk_mail %>';
	var ipAddress = '<%=strIPAddress%>';
	window.location = "mailto:"+helpDeskMail+"?subject=STARS"+ipAddress;
}
	
$(document).ready(function() {
	
	 var statsBox = '<div class="statscontainer_div"><iframe id="statscontainer_iframe" border="0" frameborder="0" scrolling="no" noresize="noresize" src="statisticsModalPopup.jsp"></iframe></div>';
	$("a#statistics").click(function() {
		$(top.frames['middle'].document.body).append(statsBox);
	});
	
	var helpManualBox = '<div class="helpManualcontainer_div"><iframe id="helpManualcontainer_iframe" border="0" frameborder="0" scrolling="no" noresize="noresize" src="helpManualModalPopup.jsp"></iframe></div>';
	$("a#GmbHManual").click(function() {
		$(top.frames['middle'].document.body).append(helpManualBox);
	});
	
	$(document).click(function(event) { 
	    if(!$(event.target).closest('#statistics').length) {
	    	$('div.statscontainer_div',top.frames['middle'].document).css("display", "none");
	    }

	    if(!$(event.target).closest('#GmbHManual').length) {
	    	$('div.helpManualcontainer_div',top.frames['middle'].document).css("display", "none");
	    }
	});
	
	$('#motherson1').hover(function () {
 	   var elm = $(this);
	   var offset = elm.offset();	
	   var bottom = $(window).height() - elm.height();
	   bottom = offset.top - bottom;
 	   $('div.motherson1tooltip').css({"top" : parseInt(17),"left" : parseInt(offset.left+160), "display" : "block"});
    }, 
    function () {
 	   $('div.motherson1tooltip').css("display","none");
	});
	
	$('.homeLink').hover(function () {
 	   var elm = $(this);
		   var offset = elm.offset();	
		   var bottom = $(window).height() - elm.height();
		   bottom = offset.top - bottom;
 	   $('div.starstooltip').css({"top" : parseInt(17),"left" : parseInt(offset.left+430), "display" : "block"});
    }, 
    function () {
 	   $('div.starstooltip').css("display","none");
 	});
		
	$('div.userImageDiv').hover(function () {
 	   var elm = $(this);
	   var offset = elm.offset();	
	   var bottom = $(window).height() - elm.height();
	   bottom = offset.top - bottom;
   	   var right = $(window).width() - elm.width();
   	   right = offset.left - right;
 	   $('div.usernametooltip').css({"top" : parseInt(20),"left" : parseInt(offset.left-180), "display" : "block"});
    }, 
    function () {
 	   $('div.usernametooltip').css("display","none");
	});
});
	

</script>