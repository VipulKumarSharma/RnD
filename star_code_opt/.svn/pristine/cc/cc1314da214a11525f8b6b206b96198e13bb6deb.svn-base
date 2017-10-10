<HTML>
<head>
<%@ include  file="headerIncl.inc" %>
<%@ include  file="cacheInc.inc" %>
<html>
<head>
<link rel="stylesheet" href="styles/links.css?buildstamp=2_0_0" type="text/css">
<link rel="stylesheet" href="styles/fonts.css?buildstamp=2_0_0" type="text/css">

<%
	String lang = request.getParameter("lang")==null ? "en" : request.getParameter("lang");
%>

<script LANGUAGE="JavaScript">
(function() {
	
	var lang = '<%=lang%>';
	if(lang == 'en'){
		window.location.href="STARS_Manual/STARS_Handbook_English_Version_2_2016_10.pdf";
	} else if(lang == 'gr'){
		window.location.href="STARS_Manual/STARS_Handbuch_Deutsch_Version_3_2016_10.pdf";
	}
})();
	
function clAll(lang)
{
	if(lang == 'en'){
		window.location.href="STARS_Manual/STARS-en.pdf";
	} else if(lang == 'gr'){
		window.location.href="STARS_Manual/STARS-gr.pdf";
	}
	
}

</script>

</head>

<body bgcolor="#FFFFFF" text="#000000" class="login" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
</body>
</html>