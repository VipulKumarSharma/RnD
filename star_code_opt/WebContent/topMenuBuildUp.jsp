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
	 *Modification 			:1.User Manual & Admin Manual links are added.These manuals are situated at  star\STARS_Manual.
	                         2. Added a new role for Corporate person to provide report Access on 05-Jun-08 by shiv sharma
							 3  added flage for identifing visio corp user on 12 aug  2009  
	
	 *Reason of Modification:1. Change Request
	 *Date of Modification  :1.19-Apr-2007 By Gaurav Aggarwal						 
	 *Revision History		:
	 *Editor				:Editplus
	 
	 *Modification			:Add new sub menu for Hand Over Request.
	 *Date of Modification	:19 jan 2011
	 *Modified By			:Manoj	
	 *Editor				:Eclipse 3.5
	 
	 *Modification			:Remove leftpadding from submenu
	 *Date of Modification	:02 feb 2012
	 *Modified By			:Manoj Chand	
	 *Editor				:Eclipse 3.5
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:01 June 2012
	 *Modification			:Implementing multilingual for all menus/submenus
	 *******************************************************/
	%>
	<%@ page pageEncoding="UTF-8" %>
	<%@ include  file="importStatement.jsp" %>
	<html>
	<head>
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript1.2" src="ScriptLibrary/main.js?buildstamp=2_0_0"type="text/javascript"></SCRIPT>
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<script type="text/javascript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	
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
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	
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
	
	.selectedSubMenu{
	border:0;
	}
	</style>
	
	</head>
	
	<%
	
	// Variables declared and initialized
	
	
	ResultSet objRs,objRs1				=  null;		  // Object for ResultSet
	String	strSqlStr	                =  ""; // For sql Statements
	String strTravelType                =  request.getParameter("travel_type"); 
	String strAllRptMenuFlag ="N";
	
	String strIPAddress = "127.1.1.1";   
	strIPAddress = request.getRemoteAddr();   
	strIPAddress = " ["+strIPAddress+"]";
	//varriable added by vaibhav
	String help_desk_mail = "";
	
	String m1Flag 		= hs.getValue("frmApp") == null ? "" : (String) hs.getValue("frmApp");
	String domain 		= hs.getValue("domain") == null ? "" : (String)hs.getValue("domain");
	String winUserId 	= hs.getValue("winUserId") == null ? "" : (String)hs.getValue("winUserId");
	String userFirstName= hs.getValue("sUserFirstName") == null ? "" : (String)hs.getValue("sUserFirstName");
	String userLastName	= hs.getValue("sUserLastName") == null ? "" : (String) " "+hs.getValue("sUserLastName");
	String userName		= userFirstName + userLastName;
	String tooltipName	= userLastName+", "+userFirstName+" ("+domain.toUpperCase()+")";
	int colspanCnt		= 3;
	%>
	
	
	<body>
		<div class="motherson1tooltip" style="display: none;">
			Motherson 1
		</div>
		<div class="starstooltip" style="display: none;">
			Samvardhana Motherson Travel AppRoval System (STARS)
		</div>
		<div class="usernametooltip" style="display: none;">
			<%=tooltipName%>
		</div>
		
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
	            					&nbsp;<%=dbLabelBean.getLabel("label.header.samvardhanamothersontravelapprovalsystem",strsesLanguage)%> (<%=dbLabelBean.getLabel("label.header.stars",strsesLanguage)%>)
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
					            			<a href="#" id="statistics" title="<%=dbLabelBean.getLabel("label.footer.statistics",strsesLanguage)%>">
					            				<div class="linkIconHeader">
													<img src="images/statistics.png?buildstamp=2_0_0" border=0>
													 <span><%=dbLabelBean.getLabel("label.footer.statistics",strsesLanguage)%></span>
												</div>
					            			</a>					            			
					            		</td>					            		
					            		<td align="center" class="linkIconHeaderTd">
					            			<a href="intro.jsp?id=1" id="home" target=middle title="<%=dbLabelBean.getLabel("label.footer.home",strsesLanguage)%>">
					            				<div class="linkIconHeader">
													<img src="images/home.png?buildstamp=2_0_0" border=0>
													 <span><%=dbLabelBean.getLabel("label.footer.home",strsesLanguage)%></span>
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
					            			<a href="#" id="presentation" title="<%=dbLabelBean.getLabel("label.footer.presentation",strsesLanguage)%>" onClick="window.open('STAR_Presentation.jsp','STAR','scrollbars=yes,resizable=yes,width=850,height=500')">
					            				<div class="linkIconHeader">
													<img src="images/presentation.png?buildstamp=2_0_0" border=0>
													 <span><%=dbLabelBean.getLabel("label.footer.presentation",strsesLanguage)%></span>
												</div>
					            			</a>
					            		</td>
					            <%	} %>		
					            		
					            		<td align="center" class="linkIconHeaderTd">
					            			<a href="#" onClick="mailTo();" id="helpdesk" class="textlink" title="<%=dbLabelBean.getLabel("label.footer.helpdesk",strsesLanguage)%>">
					            				<div class="linkIconHeader">
													<img src="images/mail.png?buildstamp=2_0_0" border=0>
													 <span><%=dbLabelBean.getLabel("label.footer.helpdesk",strsesLanguage)%></span>
												</div>
					            			</a>
					            		</td>
					            		<td align="center" class="linkIconHeaderTd">
					            			<a href=<%= "\"sessionExpired.jsp?sessionUid="+Suser_id+"\"" %> id="logout" title="<%=dbLabelBean.getLabel("label.footer.logout",strsesLanguage)%>" target=_parent >
					            				<div class="linkIconHeader">
													<img src="images/logout.png?buildstamp=2_0_0" border=0>
													 <span><%=dbLabelBean.getLabel("label.footer.logout",strsesLanguage)%></span>
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
			  <td height="28"  colspan="<%=colspanCnt %>" valign="bottom">
			    <table width="40%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
	
	<%
	String link=null;
	int iWidthLoop=0;
	String strNewMainLabel="";
	strNewMainLabel=request.getParameter("id");
	
	

	 //System.out.println(" 	strNewMainLabel ====================="+strNewMainLabel);
	 //added by manoj chand on 31 May 2012
	 if(strNewMainLabel.trim().equals("label.submenu.outsideregion") || strNewMainLabel.trim().equals("label.global.interconttravelrequest")){
		 strNewMainLabel="label.mainmenu.internationaltravelrequest";
	 }else if(strNewMainLabel.trim().equals("label.submenu.withinregion") || strNewMainLabel.trim().equals("label.global.domesticeuropetravelrequest")){
		 strNewMainLabel="label.mainmenu.domestictravelrequest";
	 }
	 
	 //strNewMainLabel=strNewMainLabel.substring(0,4); 
	 
	strSqlStr =  "SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE APPROVER_ID="+Suser_id+" AND STATUS_ID=10 AND APPLICATION_ID=1";
	objRs   = dbConBean.executeQuery(strSqlStr); 
	while(objRs.next())
	{
		strAllRptMenuFlag ="Y";
	}
	
	
	if(SuserRole.trim().equals("AD"))
	{
	  strSqlStr="SELECT DISTINCT MAIN_LABEL,MAIN_TOOLTIPS,ARR_NO FROM ROLES_RESOURCES WHERE ACCESS like '%"+SuserRole.trim()+"%' AND MAIN_LABEL = '"+strNewMainLabel+"'  ORDER BY 1";
	 
	}
	else if(SuserRole.trim().equals("CHAIRMAN"))
	{
	  strSqlStr="SELECT DISTINCT MAIN_LABEL,MAIN_TOOLTIPS,ARR_NO FROM ROLES_RESOURCES WHERE ACCESS like '%"+SuserRole.trim()+"%' AND MAIN_LABEL = '"+strNewMainLabel+"'  ORDER BY 1";
	}
	else
	{
	  strSqlStr="SELECT DISTINCT MAIN_LABEL,MAIN_TOOLTIPS,ARR_NO FROM ROLES_RESOURCES WHERE ACCESS like '%All%' AND MAIN_LABEL = '"+strNewMainLabel+"' ORDER BY 1";
	}
	
	//New Check for local administrator
	if(SuserRoleOther.trim().equals("LA"))
	{
	  strSqlStr="SELECT DISTINCT MAIN_LABEL,MAIN_TOOLTIPS,ARR_NO FROM ROLES_RESOURCES WHERE ACCESS like '%"+SuserRoleOther.trim()+"%' AND MAIN_LABEL = '"+strNewMainLabel+"'  ORDER BY 1";
	}
	//
	// addec a code for adding new corp on 04-Jun-08
	if(SuserRole.trim().equals("SM") || SuserRole.trim().equals("CORP"))
	{
	  strSqlStr="SELECT DISTINCT MAIN_LABEL,MAIN_TOOLTIPS,ARR_NO FROM ROLES_RESOURCES WHERE ACCESS like '%"+SuserRole.trim()+"%' AND MAIN_LABEL = '"+strNewMainLabel+"'  ORDER BY 1";
	}
	 
	
	//System.out.println("strSqlStr=====123=========="+strSqlStr);      
	
	objRs   = dbConBean.executeQuery(strSqlStr); 
	while(objRs.next())
	{
		iWidthLoop++;
	}
	objRs.close();
	
	objRs   = dbConBean.executeQuery(strSqlStr); 
	float fltTotalWidth		=	0;
	fltTotalWidth=100/iWidthLoop;
	String m_label = null;
	int loop=1;
	int loop1=1;
	String strMAIN_TOOLTIPS="";
	String strMainID="";
	while(objRs.next())
	{   
					m_label			= objRs.getString(1);  
					strMAIN_TOOLTIPS	= objRs.getString(2);
					// added flage for identifing visio corp user on 12 aug  2009
					//change by manoj chand on 1 june 2012 to implement multilingual
						 if(ssflage.equals("1")){ 
							if(m_label.equals("label.mainmenu.internationaltravelrequest")) {
								m_label="label.submenu.outsideregion"; 
							} else if(m_label.equals("label.mainmenu.domestictravelrequest")) { 
								m_label="label.submenu.withinregion";        
							}
			              } else if(ssflage.equals("3")) { 
			     			 if (m_label.equals("label.mainmenu.internationaltravelrequest")) {
			     				m_label="label.global.interconttravelrequest"; 
			 			 	 } else if(m_label.equals("label.mainmenu.domestictravelrequest")) {
			 			 		m_label="label.global.domesticeuropetravelrequest";   
			 			     }		 			 
		 		 		  }

	%>
				    <td width="15%" height="26px" align="left">
					  <a href="top11.jsp?id=2" class="menu"><%= dbLabelBean.getLabel("label.mainmenu.mainmenu",strsesLanguage)%></a> 
					</td>
		            <td width="30%" height="26px" background="images/SlectedMenuBG.gif?buildstamp=2_0_0" class="selectedmenubg">
		            <a href="#"  class="selectedmenu" ><%= dbLabelBean.getLabel(m_label,strsesLanguage).trim()%></a>   
					     
					</td>          
	<%
	}
	objRs.close();
	%>
				  </tr>
	            </table>
			  </td>
			</tr>
		  </table>
		</td>
	  </tr>
	</table>
	
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bottommenuBG"> 
	  <tr valign="top">
	<%
	//m_label=m_label.substring(0,4);      
//System.out.println("m_label--2->"+m_label);
	if(m_label.trim().equals("label.submenu.outsideregion") || m_label.trim().equals("label.global.interconttravelrequest")){
		m_label="label.mainmenu.internationaltravelrequest";
	}else if(m_label.trim().equals("label.submenu.withinregion") || m_label.trim().equals("label.global.domesticeuropetravelrequest")){
		m_label="label.mainmenu.domestictravelrequest";
	} 


	if(SuserRole.trim().equals("AD"))
	{
	  strSqlStr="SELECT    MAIN_LABEL, LINK, SUBLABEL, TARGET, TITLE,SUBORDER FROM        ROLES_RESOURCES WHERE MAIN_LABEL  = '"+m_label+"' AND ACCESS like '%"+SuserRole.trim()+"%' ORDER BY SUBORDER";
	}
	else if(SuserRole.trim().equals("CHAIRMAN"))  
	{
	  strSqlStr="SELECT     MAIN_LABEL, LINK, SUBLABEL, TARGET, TITLE,SUBORDER FROM         ROLES_RESOURCES WHERE MAIN_LABEL = '"+m_label+"' AND ACCESS like '%"+SuserRole.trim()+"%' ORDER BY SUBORDER";
	  //System.out.println(strSqlStr);
	}
	/*else if(SuserRole.trim().equals("HR")) 
	{
	  strSqlStr="SELECT     MAIN_LABEL, LINK, SUBLABEL, TARGET, TITLE,SUBORDER FROM         ROLES_RESOURCES WHERE MAIN_LABEL  like '%"+m_label+"%' AND ACCESS like '%"+SuserRole.trim()+"%' ORDER BY SUBORDER";
	}*/
	else if(SuserRole.trim().equals("MATA"))  
	{
	  strSqlStr="SELECT     MAIN_LABEL, LINK, SUBLABEL, TARGET, TITLE,SUBORDER FROM         ROLES_RESOURCES WHERE MAIN_LABEL = '"+m_label+"' AND ACCESS like '%"+SuserRole.trim()+"%' ORDER BY SUBORDER";
	}
	else
	{
	strSqlStr="SELECT     MAIN_LABEL, LINK, SUBLABEL, TARGET, TITLE,SUBORDER FROM         ROLES_RESOURCES WHERE MAIN_LABEL ='"+m_label+"' AND ACCESS like '%All%'  ORDER BY SUBORDER";
	}
	//out.print(strSqlStr);
	//strSqlStr="SELECT     MAIN_LABEL, LINK, SUBLABEL, TARGET, TITLE,SUBORDER FROM         ROLES_RESOURCES WHERE MAIN_LABEL ='"+m_label+"' ORDER BY SUBORDER";
	//New Check for local administrator
	if((SuserRoleOther.trim().equals("LA")))
	{
	  strSqlStr="SELECT     MAIN_LABEL, LINK, SUBLABEL, TARGET, TITLE,SUBORDER FROM         ROLES_RESOURCES WHERE MAIN_LABEL  = '"+m_label+"' AND ACCESS like '%"+SuserRoleOther.trim()+"%' ORDER BY SUBORDER";
	}
	//
	//added  a new new block of code for  new role  for SM senior management  on 30-Apr-08 by shiv sharma 
	
	//added a new role for Corporate person to provide report Access on 05-Jun-08 by shiv sharma 
	if((SuserRole.trim().equals("SM")) || (SuserRole.trim().equals("CORP")) )
	{
	  strSqlStr="SELECT     MAIN_LABEL, LINK, SUBLABEL, TARGET, TITLE,SUBORDER FROM         ROLES_RESOURCES WHERE MAIN_LABEL  = '"+m_label+"' AND ACCESS like '%"+SuserRole.trim()+"%' ORDER BY SUBORDER";
	}
	
	objRs   = dbConBean.executeQuery(strSqlStr); 
	String mLabel		="";
	String mLink		="";
	String mSubLabel	="";
	String mTarget		="";
	String mTitle		="";

	while(objRs.next()) 
	{   
		//System.out.println("inside");  
		mLabel					= objRs.getString(1).trim(); 
		mLink					= objRs.getString(2).trim();
		mSubLabel				= objRs.getString(3).trim(); 
		mTarget					= objRs.getString(4).trim(); 
		mTitle					= objRs.getString(5).trim(); 
		//@Gaurav 19-Apr-2007 Added the code for User Manual && Admin Manual on Menu Bar
		//ADDED BY MANOJ CHAND ON 07 FEB 2012 TO MANAGE SPACE FOR REPORTS SUBMENU.
	 if((mLink.equals("T_EmployeeWiseDestinationReport.jsp") || mLink.equals("T_traveldateWiseReport.jsp") || mLink.equals("T_DestinationReport.jsp") || mLink.equals("RequisitionSummaryReport.jsp") || mLink.equals("R_TravelUtilizationReport.jsp") || mLink.equals("RequisitionMovementReport.jsp") || mLink.equals("R_Approval_Statistics.jsp"))){
		 //System.out.println("----------1-----------");
		 //Added By GURMEET SINGH For OR person to provide "Requisition Movement Report" Access ON 29 JAN 2014 
		if(SuserRole.trim().equals("OR") && SuserRoleOther.equals("")){ 
			
			if(mLink.equals("RequisitionMovementReport.jsp")){%>
				<td align="left" height="24">
					<a  class="selectedmenu2 selectedSubMenu" href="<%=mLink%>?travel_type=<%=strTravelType%>" target="<%=mTarget%>" title="<%=dbLabelBean.getLabel(mTitle.trim(),strsesLanguage)%>"><%=dbLabelBean.getLabel(mSubLabel.trim(),strsesLanguage)%></a>
				</td>
			<%} 
			else{ 
				continue;
			}
			
		} else if((SuserRole.trim().equals("AC") && SuserRoleOther.equals("")) && strAllRptMenuFlag.equals("N")){ 
			
			if(mLink.equals("RequisitionMovementReport.jsp") || mLink.equals("T_traveldateWiseReport.jsp")){%>
				<td align="left" height="24">
					<a  class="selectedmenu2 selectedSubMenu" href="<%=mLink%>?travel_type=<%=strTravelType%>" target="<%=mTarget%>" title="<%=dbLabelBean.getLabel(mTitle.trim(),strsesLanguage)%>"><%=dbLabelBean.getLabel(mSubLabel.trim(),strsesLanguage)%></a>
				</td>
			<%} 
			else{ 
				continue;
			}
			
		} else {%>
		 
		 <!-- Remove leftpadding 15 px from submenu by manoj chand on 02 feb 2012-->
			<td align="left" height="24">
				<a  class="selectedmenu2 selectedSubMenu" href="<%=mLink%>?travel_type=<%=strTravelType%>" target="<%=mTarget%>" title="<%=dbLabelBean.getLabel(mTitle.trim(),strsesLanguage)%>"><%=dbLabelBean.getLabel(mSubLabel.trim(),strsesLanguage)%></a>
			</td>
	 <% }
		
	}
	 else if(!(mLink.equals("AdminManual.jsp") || mLink.equals("userManual.jsp"))){ 
	%> 
	<!-- Remove leftpadding 15 px from submenu by manoj chand on 02 feb 2012-->
			<td height="24" style="padding-left:15px;">
				<a  class="selectedmenu2 selectedSubMenu" href="<%=mLink%>?travel_type=<%=strTravelType%>" target="<%=mTarget%>" title="<%=dbLabelBean.getLabel(mTitle.trim(),strsesLanguage)%>"><%=dbLabelBean.getLabel(mSubLabel.trim(),strsesLanguage)%></a>
			</td>
	<%}else if(mLink.equals("AdminManual.jsp")){ %>
			<td height="24" style="padding-left:15px;">
				<a class="selectedmenu2 selectedSubMenu" href="#" title="<%=dbLabelBean.getLabel("submenu.mylinks.adminmanualtitle",strsesLanguage)%>" onClick="window.open('STARS_Manual/STARSAdministratorGuide.pdf','STARS','scrollbars=yes,resizable=yes,width=850,height=500')" ><%=dbLabelBean.getLabel("submenu.mylinks.adminmanual",strsesLanguage)%></a>
			</td>
	<%}else {
		%>
			<td height="24" style="padding-left:15px;">
				<a class="selectedmenu2 selectedSubMenu" href="#" title="<%=dbLabelBean.getLabel("submenu.mylinks.usermanualtitle",strsesLanguage) %>"  onClick="window.open('STARS_Manual/STARSUserGuide.pdf','STARS','scrollbars=yes,resizable=yes,width=850,height=500')" ><%=dbLabelBean.getLabel("submenu.mylinks.usermanual",strsesLanguage) %></a>
				</td> 
	<%		
		}	//End Code @Gaurav 19-Apr-2007
	}
	objRs.close();
	dbConBean.close(); //Close Connection
	%>
	  </tr>
	</table>
	
<script type="text/javascript">

function mailTo() {
	var helpDeskMail = '<%=help_desk_mail %>';
	var ipAddress = '<%=strIPAddress%>';
	window.location = "mailto:"+helpDeskMail+"?subject=STARS"+ipAddress;
}

$(document).ready(function() {
	
	$("a.selectedSubMenu").click(function() {	
		$("a.selectedSubMenu").each(function() {
			if($("a.selectedSubMenu").hasClass("selectedmenu3")) {
				$(this).removeClass("selectedmenu3");
				$(this).addClass("selectedmenu2");	
			}						
		});	
		
		$(this).removeClass("selectedmenu2");
		$(this).addClass("selectedmenu3");
	});
	
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
