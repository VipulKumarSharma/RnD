<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Shiv sharma 
 *Date of Creation 		:06 November 2008
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp list the name of the person whom the user wants to report to.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *Modified By			:Manoj Chand
 *Date of Modification	:31 jan 2012
 *Modification			:IE 10 COMPATIBILITY ISSUE RESOLVED BY ADDING META TAG.
*******************************************************/%>
<%@ page pageEncoding="UTF-8" %>
<%String strsesLanguage=request.getParameter("lang")==null?"en_US":request.getParameter("lang");
//System.out.println("strsesLanguage-1-->"+strsesLanguage);

%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<%
String strsite_id			= request.getParameter("site_id");
String  strradioselected	= request.getParameter("i");

String windowTitle = dbLabelBean.getLabel("label.mylinks.reporttoperson",strsesLanguage);

if(request.getParameter("selectHod") != null && "Y".equals(request.getParameter("selectHod"))){
	windowTitle = dbLabelBean.getLabel("label.mylinks.departmenthead",strsesLanguage);
}
%>
<title><%=windowTitle%></title>
</head>
 <FRAMESET >
	<FRAME SRC="report_to.jsp?lang=<%=strsesLanguage %>&site_id=<%=strsite_id%>&i=<%=strradioselected%>&selectHod=<%= request.getParameter("selectHod")%>" NAME="jsp1">
 </FRAMESET>
</html>

