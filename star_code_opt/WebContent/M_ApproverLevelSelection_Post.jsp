<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:18 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for active the USERS from the STAR database ******
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>

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

<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />

<base target="middle">
</head>
<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection objCon					=		null;			  // Object for connection
ResultSet rs						=       null;
CallableStatement cstmt  			=		null;		      // Object for Callable Statement
objCon                              =       dbConBean.getConnection(); 
String strSql                       =       "";
String strMessage                   =       "";  
String strUrl                       =       "";
String strUserId	    			=       "";
String strApproverLevel             =       "";
strMessage							=       (request.getParameter("message")==null)?"":request.getParameter("message"); 
strUserId	 	 		    		=       request.getParameter("userId");
strApproverLevel 		    		=       (request.getParameter("approverLevel")==null)?"0":request.getParameter("approverLevel");
String strNextPage                  =       request.getParameter("nextPage");  
String strIpAddress = request.getRemoteAddr();

//Procedure for Activating User from Deactivating state
try
{
   int i = 0;
   cstmt=objCon.prepareCall("{?=call PROC_UPDATE_USERINFO_BY_APPROVAL_LEVEL(?,?,?,?)}");//PROCEDURE FOR ACTIVE THE USER
   cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
   cstmt.setString(2,strUserId);
   cstmt.setString(3,strApproverLevel); //getting from session
   cstmt.setString(4,Suser_id);
   cstmt.setString(5,strIpAddress);
   i = cstmt.executeUpdate();
   cstmt.close();
   //strMessage = "User Successfully Activated";   
}
catch(Exception e)
{
	System.out.println("Error in M_ApproverLevelSelection_Post.jsp ==="+e);
}

//Connection Close
dbConBean.close();

if(strNextPage != null && strNextPage.equals("activeUserList"))
{
	strUrl = "M_userList.jsp?message="+URLEncoder.encode(strMessage,"UTF-8");
}
else
{
	strUrl = "M_deactiveUserList.jsp?message="+URLEncoder.encode(strMessage,"UTF-8");
}

response.sendRedirect(strUrl);

%>

