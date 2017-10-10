<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:08 Feb 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for permanent deleting the USERS from the STAR database. make status 50 for permanet delete in m_userinfo table ******
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>

<%@ include  file="importStatement.jsp" %>
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
<base target="middle">
</head>
<%
// Variables declared and initialized
Connection objCon					=		null;			  // Object for connection
CallableStatement cstmt  			=		null;		      // Object for Callable Statement
objCon                              =       dbConBean.getConnection(); 
String strUserId	    			=       "";
strUserId	 	 		    		=       request.getParameter("userId");
String strIpAddress = request.getRemoteAddr();

//Procedure for Deleting Nominal Code
try
{
   cstmt=objCon.prepareCall("{?=call PROC_USER_ADMIN_PERMANENT_DELETE(?,?,?)}");//PROCEDURE FOR DELETING THE USER
   cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
   cstmt.setString(2,strUserId);
   cstmt.setString(3,Suser_id); //getting from session
   cstmt.setString(4,strIpAddress);
   cstmt.execute();
   cstmt.close();
}
catch(Exception e)
{
	System.out.println("Error in M_userPermanentDelete.jsp ==="+e);
}
//Connection Close
dbConBean.close();
response.sendRedirect("M_deactiveUserList.jsp");

%>

