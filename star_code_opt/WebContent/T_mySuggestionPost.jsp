<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:29 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp posts suggestion in the M_Suggestion Table STAR database..
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>

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
String	strSuggestion	=	request.getParameter("suggestion");
%>
<%
	cstmt=con.prepareCall("{?=call PROC_ADDSUGGESTION(?,?)}");
	cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	cstmt.setString(2, strSuggestion.trim());
	cstmt.setString(3, Suser_id);
	cstmt.execute();
	  
	 
	cstmt.close();

   //Close All Connection
   dbConBean.close();
   
	%>
	
	<jsp:include page="T_requisitionMailOnSuggestion.jsp" flush="true" > 
	<jsp:param name="userid" value="<%=Suser_id.trim()%>"/>
     <jsp:param name="COMMENTS" value="<%=strSuggestion.trim()%>"/> 
    </jsp:include> 
   
   <%
  
  
  

	//response.sendRedirect("M_mySuggestionsList.jsp");
	
%>

<SCRIPT LANGUAGE="JavaScript">
function lo()
{
	document.frm.action ="M_mySuggestionsList.jsp";
 
	 
}
</SCRIPT>
<base target="middle">
<body onLoad="lo();document.frm.submit()" >
 <form name=frm   target="middle"/>
</body>

