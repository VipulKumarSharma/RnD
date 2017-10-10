<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:29 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp displays the answer to suggestions from M_Suggestion Table STAR database..
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>
<%@ page pageEncoding="UTF-8" %>
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
<%--<%@ include  file="systemStyle.jsp" %>--%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script>
function CheckDataSave()
{
	var a=document.frm.answer.value;
	if(a=="")
	{
		alert('<%=dbLabelBean.getLabel("label.suggestions.pleaseenteranswer",strsesLanguage) %>');
		document.frm.answer.focus();
		return false;
	}
	else
	{
		if(confirm('<%=dbLabelBean.getLabel("label.suggestions.areyousuretopostanswer",strsesLanguage) %>'))
			document.frm.submit();
		else
			return false;
	}
}
function test1(obj1, length, str)
{	
	var obj;
	
	if(obj1=='answer')
	{
		obj = document.frm.answer;
		upToTwoHyphen(obj);
	}
	charactercheck(obj,str);
    limitlength(obj, length);
	spaceChecking(obj);
  }
</script>
</head>
<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection con					=		null;			    // Object for connection
Statement stmt					=		null;			   // Object for Statement
ResultSet rs					=		null;			  // Object for ResultSet
String	sSqlStr=""; // For sql Statements
String strSuggestion	=	request.getParameter("suggestion");
String strPostedBy		=	request.getParameter("postedby");
String strPostedOn		=	request.getParameter("postedon");
String strSuggestionId	=	request.getParameter("suggestionId");
dbConBean.close();
%>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="77%" height="50" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.suggestions.answer",strsesLanguage) %></li>
    </ul></td>	
	<td width="23%" align="right" class="bodyline-top">
  <table width="39%" align="right" border="0" cellspacing="0" cellpadding="0">
  </table>
	</td>
  </tr>
  </table>
<form name=frm action="T_myAnsToSuggestionPost.jsp?suggestionId=<%=strSuggestionId%>" method=post>
		<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
			<tr align="left">
				<td width="30%" class="formtr2"><%=dbLabelBean.getLabel("label.mainmenu.suggestions",strsesLanguage) %></td>
				<td class="formtr1" ><%=strSuggestion%></td>
			</tr>
			<tr>
				<td width="30%" class="formtr2"><%=dbLabelBean.getLabel("label.global.postedby",strsesLanguage) %></td>
				<td class="formtr1"><%=strPostedBy%><%=dbLabelBean.getLabel("label.suggestions.on",strsesLanguage) %>&nbsp;<%=strPostedOn%></td>
			</tr>
			<tr>
				<td width="50%" class="formtr2"><%=dbLabelBean.getLabel("label.suggestions.answer",strsesLanguage) %></td>
				<td class="formtr1" colspan=""> 
					<textarea name="answer" cols=50 rows=8 class="frmfiels2" onKeyUp="test1('answer',500,'txt');"></textarea>
				</td>
			</tr>
			<tr class="formhead"> 
				<td colspan="3" class="listdata" align=center> 
					<input type=hidden name=buttonData>
						<input type="button" name="save" value="<%=dbLabelBean.getLabel("label.global.add",strsesLanguage) %>" class="formbutton" onClick="CheckDataSave();">
						<input type="reset" name="reset" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage) %>" class="formbutton">
				</td>
			</tr>
   <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
   </tr>
		</table>
</form>
  
</body>
</html>
