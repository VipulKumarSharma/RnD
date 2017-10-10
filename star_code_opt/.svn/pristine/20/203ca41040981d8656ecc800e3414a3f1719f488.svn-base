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
 *Reason of Modification:1 .Bug Fixing 
									    2.      Bug Fixing
									    3. Gaurav 
 *Date of Modification  : 1. 09 may 2007
								 : 2.  10 may 2007 
								  : 3. 12-May-07  
 *Revision History		:"1. Added a query for deactiavting user if he is Unit head for that site" by shiv on " 
								: 2. Chaged by Sachin Gupta on 10 May  
								  3. code added by   gaurav  for deactivating removing LA from   USER_MULTIPLE_ACCESS  
 *Editor				:Editplus
*******************************************************/%>

<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbUtilityMethods" pageEncoding="UTF-8" %>

<%@page import="java.net.URLEncoder"%><html>
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>


<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
String strMessage               =	request.getParameter("message")==null ? "" : request.getParameter("message");
String	strSqlStr				=	""; // For sql Statements
String strSiteId				=	""; //object to store Site Name
String strUserId				=	""; //object to store Description
String strUrl                   =   "";
ResultSet rs= null;
int intCount	=0;
String strIpAddress = request.getRemoteAddr();

strSiteId		=	request.getParameter("siteId") == null ?"-1" : request.getParameter("siteId");
strUserId		=	request.getParameter("userId") == null ?"-1" : request.getParameter("userId");

//strSqlStr	=	"UPDATE M_USERINFO SET UNIT_HEAD=0 WHERE USERID="+strUserId ;
strSqlStr = "UPDATE USER_MULTIPLE_ACCESS SET UNIT_HEAD=0 ,U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"' WHERE USERID="+strUserId+" and site_id="+strSiteId+" and status_id=10 ";
 intCount	= dbConBean.executeUpdate(strSqlStr);


// added by sachin  on 10-May-2007 Close  


///   code added by   gaurav on 12-May-07  for deactivating removing LA from   USER_MULTIPLE_ACCESS Open 
strSqlStr = "Select * from M_USERROLE WHERE USERID="+strUserId+" and site_id="+strSiteId+" and status_id=10";
 rs= dbConBean.executeQuery(strSqlStr);
 if(!rs.next()){	
	strSqlStr = "UPDATE USER_MULTIPLE_ACCESS SET status_id=50,U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"' WHERE USERID="+strUserId+" and site_id="+strSiteId+" and status_id=10 "; 
	dbConBean.executeUpdate(strSqlStr);
  }
///   code added by   gaurav on 12-May-07  for deactivating removing LA from   USER_MULTIPLE_ACCESS close 


if(intCount > 0)
	strMessage = dbLabelBean.getLabel("message.user.unitheaddeletedsuccessfully",strsesLanguage);
else
	strMessage = dbLabelBean.getLabel("message.user.unitheadnotdeleted",strsesLanguage);



strUrl = "M_UnitHeadList.jsp?message="+URLEncoder.encode(strMessage,"UTF-8");

response.sendRedirect(strUrl);


%>

