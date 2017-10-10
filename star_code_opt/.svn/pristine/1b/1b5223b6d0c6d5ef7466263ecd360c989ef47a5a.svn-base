
<%
	/***************************************************
	* Copyright (C) 2000 MIND 
	* All rights reserved.
	* The information contained here in is confidential and  
	* proprietary to MIND and forms the part of the MIND 
	* CREATED BY	  		 :Manoj Chand
	* Date			   		 :13 Nov 2011.
	  Project 		  		 :STARS
	* Operating environment  :Tomcat 6.0, sql server 2000
	* DESCRIPTION            :SSO LOGIC CHANGED IN STARS
	
	*Modified By			:Manoj Chand
	*Date of Modification	:14 Nov 2011
	*Modification			:remove jsp:forward tag and use form action to submit the page.
	
	*Modified By			:Manoj Chand
	*Date of Modification	:05 Sept 2012
	*Modification			:add check of domain name for smr sites
	
	*Modified By			: Manoj Chand
	*Modification 			: Create Database connection from stars.properties located outside STARS application.
	*Modification Date		: 02 Jan 2013
	
	 *Modified By			:Manoj Chand
	 *Date of Modification	:22 Oct 2013
	 *Modification			:redirection to https from http.
	**********************************************************/
%>
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,src.connection.PropertiesLoader" %>
<%response.setHeader("Cache-Control", "max-age=1");%>
<%
String strErrorcode  ="0";
String reqWinId =request.getParameter("reqWinId")==null?"":request.getParameter("reqWinId");
String reqDomain =request.getParameter("reqDomain")==null?"":request.getParameter("reqDomain"); 
strErrorcode      =request.getParameter("reqErrorCode")==null?"":request.getParameter("reqErrorCode"); ;  
%>
<html>
<head>
<script language=javascript>
	var strWinid='<%= reqWinId%>';
	var strDomain='<%= reqDomain%>';
	var strReqErrorCode='<%= strErrorcode%>';
	window.self.location = "https://stars.mindeservices.com/loginsso1.jsp?reqWinId="+strWinid+"&reqDomain="+strDomain+"&reqErrorCode="+strReqErrorCode+" ";
</script>
</head>

<body>

</body>
</html>