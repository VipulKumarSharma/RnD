<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta	
 *Date of Creation 		:28 Nov	2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is for edit the  Designation in M_DESIGNATION table of STAR Database.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>

<%@ page pageEncoding="UTF-8" %>
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>


<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection objCon= null;			    // Object for connection
CallableStatement objCstmt			=		null;			// Object for Callable Statement
String	strSqlStr	=	""; // For sql Statements
String strDesc				=""; //object to store Description
String strStatusId			=""; //object to store Statusid	
String strDesigId			=""; //object to store designation id
String Record_type="U";

strDesc	 					=	request.getParameter("Description");	// GET DESCRIPTION
strStatusId					=	request.getParameter("status_id");		// GET STATUS
strDesigId	 	 			=	request.getParameter("strDesigId");		// GET DESIGNATION ID


objCon = dbConBean.getConnection();   //Get Connection


		

//Procedure for Nominal Code
objCstmt=objCon.prepareCall("{?=call PROC_DESIG_EDIT(?,?,?,?)}");//PROCEDURE TO update THE DESIGNATION IN M_DESIGNATION TABLE
objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
objCstmt.setString(2, strDesigId);
objCstmt.setString(3, strDesc);
objCstmt.setString(4, Suser_id);
objCstmt.setString(5,Record_type);
objCstmt.execute();
objCstmt.close();

dbConBean.close();  //CLOSE ALL CONNECTIONS


response.sendRedirect("M_desigList.jsp");



%>

