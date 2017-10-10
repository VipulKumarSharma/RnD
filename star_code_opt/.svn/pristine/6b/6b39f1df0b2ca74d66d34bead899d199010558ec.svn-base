<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta
 *Date of Creation 		:26 Feb 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp updates the M_SITE table of STAR Database.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>


<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbUtilityMethods" %>
<html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%@ include  file="systemStyle.jsp" %>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />


<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>


<%
 
// Variables declared and initialized
String strMessage               =	request.getParameter("message")==null ? "" : request.getParameter("message");
String	strSqlStr				=	""; // For sql Statements
String strSiteId				=	""; //object to store Site Name
String strUserId				=	""; //object to store Description
String strUrl                   =   "";


strSiteId		=	request.getParameter("strSiteId") ;//== null ?"-1" : request.getParameter("siteId");strUserId
strUserId		=	request.getParameter("strUserId");// == null ?"-1" : request.getParameter("userId");
                                                    
	


    ///// strSqlStr	=	"UPDATE user_multiple_access SET Status_id=50 WHERE USERID="+strUserId+"";
	 //AND site_id="+strSiteId+"" ;
		
		
		//System.out.println("----------3333-----"+strSqlStr)	;
int intCount	= dbConBean.executeUpdate(strSqlStr);
dbConBean.close();       //CLOSE ALL CONNECTIONS

/*
if(intCount > 0)
	strMessage = "Unit Head Deleted Successfully";
else
	strMessage = "Unit Head Not Deleted";
*/
strUrl = "Admin_User_Profile_Edit.jsp?userId="+strUserId;

response.sendRedirect(strUrl);


%>

