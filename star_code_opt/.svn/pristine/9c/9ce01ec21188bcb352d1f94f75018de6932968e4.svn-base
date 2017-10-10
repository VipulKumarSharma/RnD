<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand
 *Date of Creation 		:07 March 2013
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat 6.0 , sql server 2008 
 *Description 			:TO Delete the company from list.
*******************************************************/
%>

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

<script language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
<base target="middle">
</head>
<%
// Variables declared and initialized
Connection objCon			=		null;			    // Object for connection
Statement objStmt					=		null;			   // Object for Statement
ResultSet objRs						=		null;			  // Object for ResultSet
CallableStatement objCstmt			=		null;			// Object for Callable Statement
String	strSqlStr	=	""; // For sql Statements
String Record_type="D";
String strCompanyId				="";

strCompanyId	 	 				=	request.getParameter("cmpId"); // GET SITE ID

objCon = dbConBean.getConnection();   //Get Conneciton
objCon.setAutoCommit(false);

		try
		 {		
			objCstmt=objCon.prepareCall("{?=call PROC_COMPANY_DELETE(?,?,?)}");
			objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);	
			objCstmt.setString(2,strCompanyId);		
			objCstmt.setString(3,Record_type);	
			objCstmt.setString(4,Suser_id);
			objCstmt.execute();	
			objCstmt.close();
			objCon.commit();
			objCon.close();
			response.sendRedirect("M_companyList.jsp?flag=true");
			}
		catch(Exception e)
		{
			System.out.println("Exception at M_companyDelete.jsp?false");
			objCon.rollback();
			response.sendRedirect("M_companyList.jsp?flag=false");
		}
		finally 
		{
			objCon.close();		
		}	
				
dbConBean.close();

%>

