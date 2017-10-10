<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="application.jsp"%>
<script language="JavaScript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script> 
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%	String isUpdate = null;
	hs.setAttribute("strUserStartedNewRas", "N");
	String userId = (String) hs.getValue("user_id");
	String updateFlag = "update m_userinfo set splash_flag = 'Y' where userid="
			+ userId;
	int count = dbConBean1.executeUpdate(updateFlag);
%>
<script>
	self.close();
</script>

</head>
<body>

</body>
</html>