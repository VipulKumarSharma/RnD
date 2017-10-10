<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:29 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp Post the answers to the suggestion in the Star database.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>
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
<%@ include  file="importStatement.jsp" %>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
// Variables declared and initialized
Connection con					=		null;			    // Object for connection
Statement stmt					=		null;			   // Object for Statement
ResultSet rs					=		null;			  // Object for ResultSet
CallableStatement cstmt			=		null;			// Object for Callable Statement
request.setCharacterEncoding("UTF-8");
//Create Connection
con = dbConBean.getConnection();
String	sSqlStr=""; // For sql Statements
String	strSuggestionId	=	request.getParameter("suggestionId");
String	strAnswer		=	request.getParameter("answer");
%>
<%
	cstmt=con.prepareCall("{?=call PROC_UPDATESUGGESTION(?,?,?)}");
	cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	cstmt.setString(2, strSuggestionId);
	cstmt.setString(3, strAnswer.trim());
	cstmt.setString(4, Suser_id);
	cstmt.execute();
	cstmt.close();

dbConBean.close();

	response.sendRedirect("M_mySuggestionsList.jsp");
	
%>

