<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:28 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp list the name of the person whom the user wants to report to.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By 			: Manoj Chand
 *Date of Modification	: 23 July 2012
 *Modification			: set auto-commit mode of connection to false.
*******************************************************/%>
<%@page import="java.net.URLEncoder"%>
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
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
// Variables declared and initialized
Connection objCon			=		null;			    // Object for connection
Statement objStmt			=		null;			   // Object for Statement
ResultSet objRs				=		null;			  // Object for ResultSet
CallableStatement objCstmt	=		null;			// Object for Callable Statement
String	strSqlStr			=	""; // For sql Statements
String Record_type			=   "D";
String U_DATE				=   ""; //object to set U_DATE
String strSiteId			= 	"";
String strMessage           = 	"";
String sqlQuery				=   "";

strSiteId	 	 			=	request.getParameter("stId"); // GET SITE ID
	
	sqlQuery = "select username from M_USERINFO where SITE_ID="+strSiteId+" AND STATUS_ID=10";
	objRs = dbConBean.executeQuery("select username from M_USERINFO where SITE_ID="+strSiteId+" AND STATUS_ID=10");
 	
	if (objRs.next()){
		strMessage = dbLabelBean.getLabel("alert.unit.unitnotdeletedduetoactiveusers",strsesLanguage);
		response.sendRedirect("M_siteList.jsp?flag=false&message="+URLEncoder.encode(strMessage,"UTF-8"));
 	
	} else {
		objCon = dbConBean.getConnection();   //Get Connection
		objCon.setAutoCommit(false);
	
		try
		{	objCstmt=objCon.prepareCall("{?=call PROC_SITE_DELETE(?,?,?)}");//PROCEDURE FOR DELETING THE SITE
			objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);	
			objCstmt.setString(2, strSiteId);		
			objCstmt.setString(3,Record_type);	
			objCstmt.setString(4,U_DATE);
			objCstmt.execute();	
			objCstmt.close();
			objCon.commit();
			objCon.close();
			
			strMessage = dbLabelBean.getLabel("alert.unit.unitdeletedsuccessfully",strsesLanguage);
			response.sendRedirect("M_siteList.jsp?flag=true&message="+URLEncoder.encode(strMessage,"UTF-8"));
		}
		catch(Exception e)
		{
			objCon.rollback();
			strMessage = dbLabelBean.getLabel("alert.unit.unitcouldnotbedeleted",strsesLanguage);
			response.sendRedirect("M_siteList.jsp?flag=false&message="+URLEncoder.encode(strMessage,"UTF-8"));
		}
		finally 
		{
			objCon.close();		
		}	
	}			
	dbConBean.close();

%>

