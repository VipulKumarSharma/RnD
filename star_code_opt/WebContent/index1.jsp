<%
	/***************************************************
	* Copyright (C) 2000 MIND 
	* All rights reserved.
	* The information contained here in is confidential and  
	* proprietary to MIND and forms the part of the MIND 
	* CREATED BY	  		 :Manoj Chand
	* Date			   		 :23 October 2013
	  Project 		  		 :STARS
	* Operating environment  :Tomcat 6.0 , sql server 2008
	* DESCRIPTION            :welcome file created
	**********************************************************/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
response.setHeader("Cache-Control", "max-age=1"); 
String strErrorcode = "0";
String strSessionID =request.getParameter("reqSID")==null?"":request.getParameter("reqSID");
String strTokenID   =request.getParameter("reqTID")==null?"":request.getParameter("reqTID"); 
strErrorcode      =request.getParameter("reqErrorCode")==null?"":request.getParameter("reqErrorCode");  
%>
<html>
<head>
<title></title>

<script language=javascript>
	var strReqTid='<%= strTokenID%>';
	var strReqSid='<%= strSessionID%>';
	var strReqErrorCode='<%= strErrorcode%>';
	window.self.location = "http://172.29.37.48:8088/star_code_opt/index.jsp?reqTID="+strReqTid+"&reqSID="+strReqSid+"&reqErrorCode="+strReqErrorCode+" ";
</script>
</head>
<body>
<P></P>
</body>
</html> 
