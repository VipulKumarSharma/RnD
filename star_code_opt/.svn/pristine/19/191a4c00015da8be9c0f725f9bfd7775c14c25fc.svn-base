<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Shiv sharma
 *Date of Creation 		:18 April 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:     This is Jsp file  for delect and deactivating  local Administrator those have  Multiple  Site  Access
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				        :         Editplus
 
 *Modified By		:Manoj Chand
 *Date of Modification	: 19 dec 2011
 *Modification		: modify page to delete billing approver from m_billingapprover table
 
 *Modified By		:Manoj Chand
 *Date of Modification	: 28 Mar 2012
 *Modification		: modify page to delete board member
 
 *Modified By	        :	 MANOJ CHAND
 *Date of Modification  :	 06 August 2013
 *Description			:	 delete access of user from access rights screen.
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbUtilityMethods" %>

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
String strIpAddress = request.getRemoteAddr();

//added by manoj chand on 01 august 2013 to delete user from user right screen
String strpagefrom = request.getParameter("frompage")==null?"":request.getParameter("frompage");
String strfromunit = request.getParameter("fromunit")==null?"-1":request.getParameter("fromunit");
String strseluser = request.getParameter("seluser")==null?"-1":request.getParameter("seluser");
String strtounit = request.getParameter("tounit")==null?"-1":request.getParameter("tounit");
//added by manoj chand on 13 nov 2013 to get value of unit head flag
String strUnitHeadFlag = request.getParameter("unithead")==null?"":request.getParameter("unithead");
//int intCountnew			  =	0;



strUserId		=	request.getParameter("strUserId") ;
strSiteId		=	request.getParameter("strSiteId");
            
//System.out.println("strUserId-->"+strUserId);
//System.out.println("strSiteId-->"+strSiteId);

   strSqlStr	=	"UPDATE USER_MULTIPLE_ACCESS SET Status_id=50,U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"'   WHERE   USERID="+strUserId+"  AND site_id="+strSiteId+" and USER_MULTIPLE_ACCESS.STATUS_ID=10" ;
	int intCount	= dbConBean.executeUpdate(strSqlStr);
	
    //CLOSE ALL CONNECTIONS

    strSqlStr	=	"UPDATE M_USERROLE  SET Status_id=50,U_USERID='"+Suser_id+"',U_DATETIME=GETDATE(),IP_ADDRESS='"+strIpAddress+"' WHERE  USERID="+strUserId+" and site_id="+strSiteId+" and M_USERROLE.STATUS_ID=10";
	int intCountnew	= dbConBean.executeUpdate(strSqlStr);
	
//Added by manoj chand on 19 december 2011 to delete billing approver 
	strSqlStr="delete from M_BILLING_APPROVER WHERE SITE_ID="+strSiteId+" and APPROVER_ID="+strUserId;
	int intDeleteCount	= dbConBean.executeUpdate(strSqlStr);
	
//end here

//Added by manoj chand on 27 march 2012 to delete board member
	strSqlStr="UPDATE M_BOARD_MEMBER SET STATUS_ID=50,U_USER_ID='"+Suser_id+"',U_DATE=GETDATE() WHERE SITE_ID="+strSiteId+" and STATUS_ID=10 AND USERID="+strUserId;
//System.out.println("strSqlStr---111-->"+strSqlStr);
	int intDelCount	= dbConBean.executeUpdate(strSqlStr);
	if(intDelCount>0 || intDeleteCount>0 || intCount>0 || intCountnew>0){
		strMessage=dbLabelBean.getLabel("message.master.recorddeletedsuccessfully",strsesLanguage);
	}
//end here
//added by manoj chand on 13 nov 2013 to update role_id of Unithead.
if(strUnitHeadFlag.equalsIgnoreCase("Y")){
	strSqlStr ="update dbo.M_USERINFO set ROLE_ID=ORG_ROLE,U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"' where USERID="+strUserId+" and STATUS_ID=10";
	int result	= dbConBean.executeUpdate(strSqlStr);
}

dbConBean.close();       //CLOSE ALL CONNECTIONS

 /*
 strSqlStr	=	"UPDATE M_USERROLE  SET Status_id=50  WHERE  USERID="+strUserId+" and site_id="+strSiteId+"";
		

int intCountnew1	= dbConBean.executeUpdate(strSqlStr);
dbConBean.close();       //CLOSE ALL CONNECTIONS


 
if(intCount > 0)
	strMessage = "Unit Head Deleted Successfully";
else
	strMessage = "Unit Head Not Deleted";
*/
//change by manoj chand on 19 dec 2011 to show delete record message.
strUrl = "Admin_User_Profile_Edit.jsp?userId="+strUserId+"&strMessage="+URLEncoder.encode(strMessage.trim(),"UTF-8");
if(strpagefrom.equals("userrights")){
	strUrl = "M_userRights.jsp?userId="+strUserId+"&Message="+URLEncoder.encode(strMessage.trim(),"UTF-8")+"&Site="+strfromunit+"&userName="+strseluser+"&AssignSite="+strtounit+"&flag=2";
}

response.sendRedirect(strUrl);

%>

