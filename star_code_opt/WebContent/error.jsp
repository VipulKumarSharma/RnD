<%
/***************************************************
 *The information contained here in is confidential and  
 *proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand
 *Date of Creation 		:23 Oct 2013
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat 6.0, sql server 2008 
 *Description 			:To display error message when error occured.
 *******************************************************/
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body  onLoad="document.frm1.submit();" unload="window.close();"  >

<form method=post action="sessionExpiredMain.jsp" name="frm1" target=_top>
<!-- <table align="center" cellpadding="1" cellspacing="1">
<tr>
<th><img alt="Error" src="images/alert3.jpg?buildstamp=2_0_0"></th>
<th><h3>Sorry an exception occurred, please try again after some time</h3></th>
</tr>
<tr>
<th>Exception is:</th>
<th></th>
</tr>
</table>-->
</form>
</body>
</html>