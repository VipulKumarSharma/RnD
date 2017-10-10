<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:29 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp add new suggestion in the M_Suggestion Table STAR database..
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			:Manoj Chand
 *Date of Modification	:22 Oct 2013
 *Modification			:javascript validation to stop from typing --,'  symbol is added.
*******************************************************/%>

<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbConnectionBean" %>
<html>
<head>
<%@ page pageEncoding="UTF-8" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="scripts/CommonValida1.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script>
function CheckDataSave()
{
	var a=document.frm.suggestion.value;
	if(a=="")
	{
		alert('<%=dbLabelBean.getLabel("label.suggestions.pleaseentersuggestion",strsesLanguage) %>');
		document.frm.suggestion.focus();
		return false;
	}
	else
	{
		if(confirm('<%=dbLabelBean.getLabel("label.suggestions.areyousuretopostsuggestion",strsesLanguage) %>'))
			document.frm.submit();
		else
			return false;
	}
}
function test1(obj1, length, str)
{	
	var obj;
	
	if(obj1=='suggestion')
	{
		obj = document.frm.suggestion;
	}
	charactercheck(obj,str);
	limitlength(obj, length);
	spaceChecking(obj);
	upToTwoHyphen(obj);
}
</script>
</head>
<%
// Object of DbConnectionBean created
DbConnectionBean bean = new DbConnectionBean();
ResultSet rs					=		null;			  // Object for ResultSet
String	sSqlStr=""; // For sql Statements
%>
<body onload="document.frm.suggestion.focus();">
<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="32" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("submenu.suggestions.suggestionstitle",strsesLanguage) %></li>
    </ul></td>	
 <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
         <td align="right">
         <ul id="list-nav">
         <li><a href="M_mySuggestionsList.jsp" ><%=dbLabelBean.getLabel("button.global.back",strsesLanguage) %></a></li>
         </ul>
         </td>
      </tr>
    </table>
	</td>
  </tr>
</table>
 
<form name=frm action="T_mySuggestionPost.jsp" method=post>
		<table width="75%" align="center" cellspacing="0" border=0 cellpadding="2" class="table">
			<tr align="left" valign="top"> 
				<td width="50%" class="formtr3"><%=dbLabelBean.getLabel("label.mainmenu.suggestions",strsesLanguage) %></td>
				<td class="formtr1" colspan="2"> 
					<textarea name="suggestion" cols=50 rows=8 class="textBoxCss" onkeyup="test1('suggestion', 500, 'txt');"></textarea>
				</td>
			</tr>
			<tr> 
				<td colspan="3" class="formbottom" align=center> 
					<input type=hidden name=buttonData>
						<input type="button" name="save" value="<%=dbLabelBean.getLabel("label.global.add",strsesLanguage) %>" class="formbutton" onClick="CheckDataSave();">
						<input type="reset" name="reset" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage) %>" class="formbutton" onClick="document.frm.suggestion.focus();">
				</td>
			</tr>
		</table>
</form>

</body>
</html>
