<%
/***************************************************
**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	  : STARS**** 
**** Operating environment :Tomcat, sql server 2000 ******
**** Description : This is first jsp file  for deleting the users to whom approval page is assigned ******
**** Modified By			: Manoj Chand 
**** Reason of Modification : To pass papId for PROC_PAGE_ACCESS_DELETE procedure  
**** Date of Modification   : 01-05-2012 
**********************************************************/
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
<%@page import="java.net.*" %>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
// Variables declared and initialized
Connection objCon,objCon_1		=		null;			    // Object for connection
Statement objStmt,objStmt_1		=		null;			   // Object for Statement
ResultSet objRs,objRs_1			=		null;			  // Object for ResultSet
CallableStatement objCstmt		=		null;			// Object for Callable Statement


objCon=dbConBean.getConnection();
String	strSqlStr	=	""; // For sql Statements
%>

<%
		
		String strSiteId				="";
		int intPendingWith=0;
		int intViewTo=0;
		String strPendingWithId	 	 				=	request.getParameter("strPendingWithId"); // GET SITE ID
		String strViewToId	 	 					=	request.getParameter("strViewToId"); // GET SITE ID
		String strPapId								=	request.getParameter("reqPAP_ID")==null?"0":request.getParameter("reqPAP_ID");
		String remoteAddress="";
		remoteAddress=request.getRemoteAddr();
		InetAddress inetAddress = InetAddress.getByName(remoteAddress); 
		remoteAddress=inetAddress.toString();
		remoteAddress=remoteAddress.replaceAll("/","");
		if(strPendingWithId!=null || !strPendingWithId.equals(""))
		{
		intPendingWith=Integer.parseInt(strPendingWithId);
		}
		if(strViewToId!=null || !strViewToId.equals(""))
		{
		intViewTo=Integer.parseInt(strViewToId);
		}
			//Procedure for Deleting Nominal Code
			objCstmt=objCon.prepareCall("{?=call PROC_PAGE_ACCESS_DELETE(?,?)}");//PROCEDURE FOR DELETING THE SITE
			objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			objCstmt.setInt(2, Integer.parseInt(strPapId));		
			objCstmt.setString(3, remoteAddress);					
			objCstmt.execute();
			objCstmt.close();
			//response.sendRedirect("M_PageAccessDataResult.jsp?Type=Delete&Error=4");
			response.sendRedirect("PageAccessPermissionList.jsp?Type=Delete&Error=4");
			
		
%>

