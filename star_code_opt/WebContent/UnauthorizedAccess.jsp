<%
/*******************************************************
 * Project		 	: STARS
 * Created By		: Manoj Chand
 *Created On		: 28 Oct 2013
 *Description		: Unauthorized user page access
*******************************************************/
%>
<html>
<head>
<%@ include  file="cacheInc.inc" %>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title>WELCOME TO STARS:  SAMVARDHANA MOTHERSON TRAVEL  APPROVAL SYSTEM Version No:- 1.0  </title>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<script type="text/javascript">
	if (top.frames.length > 0)
	{
	 top.location=self.location;
	}
</script>
</head>

<body>
<%
HttpSession hs = request.getSession();
String strLangValue = (String)hs.getValue("sesLanguage")==null?"en_US":(String)hs.getValue("sesLanguage");
%>
<div align="center" style="margin-top: 20px;"><p><h2><%=dbLabelBean.getLabel("message.unauthorized.youarenotable",strLangValue)  %></h2></p></div>
</body>
</html>


