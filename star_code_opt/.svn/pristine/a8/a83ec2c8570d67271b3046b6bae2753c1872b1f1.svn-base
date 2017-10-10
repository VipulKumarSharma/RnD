<%@ include  file="importStatement.jsp" %>
<!-- Header -->
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:29 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is the first jsp which displays the User suggestions.
 *Editor			    	:Editplus
 *Reason of Modification	: suggestions can be viewed only  by  the persons who has 
	 						  posted the same.	
 *Date of Modification  	: 25-feb-2011
 *Modified By	     		: Manoj Chand
 
*******************************************************/%>


<%@page import="java.net.URLEncoder" pageEncoding="UTF-8"%>
<HTML>
<HEAD>
<%@ page import = "src.connection.DbConnectionBean" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<%
request.setCharacterEncoding("UTF-8");
// Object of DbConnectionBean created
DbConnectionBean bean = new DbConnectionBean();
// Variables declared and initialized
ResultSet rs	=	null;			  // Object for ResultSet
String sSqlStr	=	"";//For SQL Statements
int iCls = 0;
String strStyleCls = "";

 String strEmail = "";
  sSqlStr="SELECT EMAIL FROM M_USERINFO WHERE USERID="+Suser_id+" AND APPLICATION_ID=1 AND STATUS_ID=10";
  rs=bean.executeQuery(sSqlStr);
  if(rs.next())
  {
    strEmail = rs.getString("EMAIL");
  }
  rs.close();

%>
</HEAD>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="32" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("submenu.suggestions.suggestionstitle",strsesLanguage) %></li>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
<%
  if(strEmail!=null && strEmail.equals("sachin.gupta@mind-infotech.com"))
  {
%>
        <td width="52%" align="right"><a href="#"  onClick="MM_openBrWindow('requisitionAttachmentTest.jsp','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')">
		<font color='white'><%=dbLabelBean.getLabel("label.suggestions.test",strsesLanguage) %></font></a></td>	
		<td width="52%" align="right"><a href="TESTQUERY.jsp"><font color='white'><%=dbLabelBean.getLabel("label.suggestions.test",strsesLanguage) %></font></a></td>
		<td width="52%" align="right"><a href="UpdateQuery.jsp"><font color='white'><%=dbLabelBean.getLabel("label.suggestions.test",strsesLanguage) %></font></a></td>
		<td width="52%" align="right"><a href="#" onClick="MM_openBrWindow('Security/logInfo.txt','LogInfo','scrollbars=yes,resizable=yes,width=775,height=550')"><font color='white'><%=dbLabelBean.getLabel("label.suggestions.test",strsesLanguage) %></font></a></td>

<%
  }
%>	    
       <td align="right">
     <ul id="list-nav">
     <li><a href="T_myNewSuggestions.jsp" ><%=dbLabelBean.getLabel("button.global.new",strsesLanguage) %></a></li>
     </ul>
       </td>
      </tr>
    </table>
	</td>
  </tr>
  </table>

  <table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <tr class="formhead"> 
    <td  width="2%" align="Center"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
    <td  width="6%" align="Center"><%=dbLabelBean.getLabel("label.mainmenu.suggestions",strsesLanguage) %></td>
    <!--<td class="listhead" width="3%" align="Center">Suggestion No</td>-->
	<td  width="8%" align="Center"><%=dbLabelBean.getLabel("label.global.postedby",strsesLanguage) %></td>
    <td  width="8%" align="Center"><%=dbLabelBean.getLabel("label.suggestions.answer",strsesLanguage) %></td>
	<td  width="6%" align="Center"><%=dbLabelBean.getLabel("label.suggestions.answeredby",strsesLanguage) %></td>
	<% if(SuserRole.trim().equals("AD"))
		{
	%>
	<td  width="6%" align="Center"><%=dbLabelBean.getLabel("label.suggestions.postanswer",strsesLanguage) %></td>
	<%
		}
	%>
  </tr>
  <%
  int intSerialNo	=	0;
  String strSuggestionId=	"";
  String strSuggestion	=	"";
  String strPostedBy	=	"";
  String strPostedOn	=	"";
  String strAnswer		=	"";
  String strAnsweredBy	=	"";
  String strAnsweredOn	=	"";

  
  if(SuserRole.equals("AD"))
 	sSqlStr="SELECT SUGGESTION_ID, RTRIM(ISNULL(SUGGESTIONS,'-')), dbo.USER_NAME(POSTED_BY), dbo.CONVERTDATE(POSTED_ON), RTRIM(ISNULL(ANSWERS,'-')), dbo.USER_NAME(ANSWERED_BY), dbo.CONVERTDATE(ANSWERED_ON) FROM M_SUGGESTIONS ORDER BY POSTED_ON DESC";
  else
  sSqlStr="SELECT SUGGESTION_ID, RTRIM(ISNULL(SUGGESTIONS,'-')), dbo.USER_NAME(POSTED_BY), dbo.CONVERTDATE(POSTED_ON), RTRIM(ISNULL(ANSWERS,'-')), dbo.USER_NAME(ANSWERED_BY), dbo.CONVERTDATE(ANSWERED_ON) FROM M_SUGGESTIONS where posted_by='"+Suser_id+"' ORDER BY POSTED_ON DESC";
  //System.out.println("sSQLSTR--->"+sSqlStr);
  rs=bean.executeQuery(sSqlStr);
  if(rs.next())
  {
	  do
	  {
			strSuggestionId		=	rs.getString(1);
			strSuggestion		=	rs.getString(2);
			strPostedBy			=	rs.getString(3);
			strPostedOn			=	rs.getString(4);
			strAnswer			=	rs.getString(5);
			strAnsweredBy		=	rs.getString(6);
			strAnsweredOn		=	rs.getString(7);
  %>
	<%
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 


	  iCls++;
	%>
			  <tr class="<%=strStyleCls%>"> 
				<td  width="2%" align="Center"><%=++intSerialNo%></td>
				<td  width="6%" align="Center"><%=strSuggestion%></td>
				<!--<td class="listdata" width="3%" align="Center"><%=strSuggestionId%></td>-->
				<td  width="8%" align="Center"><%=strPostedBy%><br><%=strPostedOn%></td>
				<td  width="8%" align="Center"><%=strAnswer%></td>
				<td  width="6%" align="Center"><%=strAnsweredBy%><br><%=strAnsweredOn%></td>
				
				<% if(SuserRole.trim().equals("AD"))
				{
					if(strAnswer.equals("-"))
				{ %>
					<td class="listdata" width="6%" align="Center"><a href="T_myAnswerToSuggestion.jsp?suggestion=<%=URLEncoder.encode(strSuggestion,"UTF-8") %>&postedby=<%=strPostedBy%>&postedon=<%=strPostedOn%>&suggestionId=<%=strSuggestionId%>" class="rtlinks"><%=dbLabelBean.getLabel("label.suggestions.postanswer",strsesLanguage) %></a></td>
				<%}
				else
				{%>
					<td class="listdata" width="6%" align="Center"><a href="T_myAnswerToSuggestion.jsp?suggestion=<%=URLEncoder.encode(strSuggestion,"UTF-8")%>&postedby=<%=strPostedBy%>&postedon=<%=strPostedOn%>&suggestionId=<%=strSuggestionId%>" class="rtlinks"><%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage) %></a></td>
				<%}
				}%>				
			  </tr>
  <%
	  }
	  while(rs.next());
  }
  else
  {
  %>
  <tr> 
    <td colspan="10" class="formtr1"><%=dbLabelBean.getLabel("label.suggestions.norecordsavailable",strsesLanguage) %> </td>
  </tr>
  <%}%>
<tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
</tr>
</table>
<% bean.close(); %>
</body>
</HTML>