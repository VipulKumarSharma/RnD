<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>

<%@ page 
language="java"
contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"
%>
<%
String strFrom=request.getParameter("strFrom");
//System.out.println("strFrom in compileReport.jsp --> "+strFrom);
String strTo=request.getParameter("strTo");
//System.out.println("strTo in compileservlet.jsp --> "+strTo);
String strTravelType = request.getParameter("strTravelType");
//System.out.println(" strTravelType in compilereport.jsp--> "+strTravelType);
String reportName = request.getParameter("reportName");
//System.out.println("reportName in compileReport.jsp --> "+reportName);
%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Studio">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK href="../theme/Master.css?buildstamp=2_0_0" rel="stylesheet"
	type="text/css">
<TITLE>HtmlReportFormat.jsp</TITLE>
</HEAD>
<jsp:include page="CompileServlet?reportName=<%=reportName%>&strFrom=<%=strFrom%>&strTo=<%=strTo%>&strTravelType=<%=strTravelType%>"/>
<BODY leftmargin="0" topmargin="0" rightmargin="0">
</BODY>
</HTML>
