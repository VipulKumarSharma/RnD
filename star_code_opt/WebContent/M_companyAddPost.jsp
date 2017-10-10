<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand
 *Date of Creation 		:07 Mar 2013
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat 6.0, sql server 2008
 *Description 			:This jsp is used to insert company data in m_company table.
 *Modified By			:Manoj Chand
 *Date of Modification	:23-Aug-2013
 *Modification			:add textarea to add xml parameter string for ERP web service
*******************************************************/
%>

<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbUtilityMethods,src.connection.PropertiesLoader" pageEncoding="UTF-8"%>
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection objCon					=		null;			    // Object for connection
Statement objStmt					=		null;			   // Object for Statement
ResultSet objRs						=		null;			  // Object for ResultSet
CallableStatement objCstmt			=		null;			// Object for Callable Statement

objCon = dbConBean.getConnection();  //Get the Conneciton
String	strSqlStr	=	""; // For sql Statements
String strCompany			="";
String U_DATE  				="";
String strWsUrl				="";
String strERPWsUrl			="";
String strMsg				="";
String strERPData = "";
strCompany	 				=	request.getParameter("Companyname")==null?"":request.getParameter("Companyname");	// GET SITE
strWsUrl					=	request.getParameter("wsurl")==null?"":request.getParameter("wsurl");
strERPWsUrl					=	request.getParameter("erpwsurl")==null?"":request.getParameter("erpwsurl");
strERPData					=	request.getParameter("erpxmldata")==null?"":request.getParameter("erpxmldata");
String strIpaddress			=	request.getRemoteAddr();
		strSqlStr	=	"SELECT * from dbo.M_COMPANY mc WHERE mc.COMPANY_NAME=N'"+strCompany+"' AND mc.STATUS_ID=10";
		objRs		= dbConBean.executeQuery(strSqlStr);
		if(objRs.next())
		{
			strMsg=dbLabelBean.getLabel("message.company.alreadyexists",strsesLanguage);
			response.sendRedirect("M_companyList.jsp?message="+strMsg);
		}
		else
		{
			objCstmt=objCon.prepareCall("{?=call PROC_COMPANY_ADD(?,?,?,?,?,?,?,?,?)}");//PROCEDURE TO ADD THE USER IN SITE TABLE
			objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			objCstmt.setString(2, strCompany.trim());
			objCstmt.setString(3, strWsUrl.trim());
			objCstmt.setString(4, strERPWsUrl.trim());
			objCstmt.setInt(5, 10);
			objCstmt.setString(6, Suser_id);
			objCstmt.setString(7,strIpaddress);
			objCstmt.setString(8,"I");
			objCstmt.setString(9,strERPData.trim());
			objCstmt.registerOutParameter(10,java.sql.Types.INTEGER);
			objCstmt.execute();
			int resOut	= objCstmt.getInt(10);
			objCstmt.close();
			if(resOut==0){
				strMsg=dbLabelBean.getLabel("message.company.addedsuccessfully",strsesLanguage);
			}else{
				strMsg=dbLabelBean.getLabel("message.company.notadded",strsesLanguage);
			}
			response.sendRedirect("M_companyList.jsp?message="+strMsg);
		}
objRs.close();
dbConBean.close();
%>
