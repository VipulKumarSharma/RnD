	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Manoj Chand
	 *Date of Creation 		:07 Mar 2013
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STARS
	 *Operating environment :Tomcat 6.0, sql server 2008 
	 *Description 			:This jsp file updates the COMPANY in M_COMPANY table of STAR database.
	 *Modified By			:Manoj Chand
	 *Date of Modification	:23-Aug-2013
	 *Modification			:add textarea to add xml parameter string for ERP web service
	*******************************************************/%>

<%@ page pageEncoding="UTF-8" import="src.connection.PropertiesLoader"%>
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
	<jsp:useBean id="wsClientObj" scope="page" class="wsclient.WSClient" />

	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<base target="middle">
	</head>


	<%
	request.setCharacterEncoding("UTF-8");
	// Variables declared and initialized
	Connection objCon= null;			    // Object for connection
	CallableStatement objCstmt	=	null;			// Object for Callable Statement
	String	strSqlStr	=	""; // For sql Statements
	String strCompanyId			=""; 
	String strCompanyName			="";	
	String strMATAWsUrl				="";
	String strERPWsUrl				="";
	String strERPData = "";
    strMATAWsUrl				=	request.getParameter("wsurl")==null?"":request.getParameter("wsurl");
    strERPWsUrl			=	request.getParameter("erpwsurl")==null?"":request.getParameter("erpwsurl");
    strCompanyId	 	 			=	request.getParameter("strCompanyId");
    strCompanyName					=	request.getParameter("Companyname")==null?"":request.getParameter("Companyname");
    strERPData					=	request.getParameter("erpxmldata")==null?"":request.getParameter("erpxmldata");
    String strIpaddress			=	request.getRemoteAddr();
	objCon = dbConBean.getConnection();   //Get Connection
	//Procedure for Nominal Code
	try{
	objCstmt=objCon.prepareCall("{?=call PROC_COMPANY_EDIT(?,?,?,?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setString(2, strCompanyId);
	objCstmt.setString(3, strCompanyName.trim());
	objCstmt.setString(4, strMATAWsUrl.trim());
	objCstmt.setString(5,strERPWsUrl.trim());
	objCstmt.setString(6,Suser_id);  
	objCstmt.setString(7,strIpaddress);
	objCstmt.setString(8,"U");
	objCstmt.setString(9,strERPData.trim());
	objCstmt.registerOutParameter(10,java.sql.Types.INTEGER);
	objCstmt.execute();
	int resOut	= objCstmt.getInt(10);
	}catch(Exception ex){
		System.out.println("error in PROC_COMPANY_EDIT procedure calling-->"+ex.getMessage());
		ex.printStackTrace();
	}
	
	//System.out.println("resOut-edit-->"+resOut);
	objCstmt.close();
	dbConBean.close();  //CLOSE ALL CONNECTIONS
	response.sendRedirect("M_companyList.jsp");
	%>
	