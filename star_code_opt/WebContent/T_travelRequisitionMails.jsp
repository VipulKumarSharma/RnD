<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:4 October 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is the jsp file  for show the Mail Details of Travel Requisition
 *Modification 			: 
 *Reason of Modification: Query changed by shiv on 25 feb 2009 for using view 
 *Date of Modification  :
 *Revision History		:
 *Editor				:Editplus
 						:Modification by vaibhav to add cc mail column on 22 oct 2010
 *Modified By			: Manoj Chand
 *Date of Modification	: 04 july 2012
 *Modification			: Change in sql query to show multiple handover mail.
 *******************************************************/
%>
<html> 
<head>
<%@ page pageEncoding="UTF-8" %>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
</head>
<%
// Variables declared and initialized
ResultSet rs				 =		null;			  // Object for ResultSet
//Create Connection

String sSqlStr				=	"";			// For sql Statements
String strRequisitionNo		=	"";//For holding Purchase Requisition Id
strRequisitionNo			=	request.getParameter("travelReqNo");
String strPrsntApp			=	"";
String strNextApp			=	"";
String strNewPOStatusType	=	"";
int iCls = 0;
int i = 1;
String strStyleCls = "";
// Query changed by shiv on 25 feb 2009 for using views 
//sSqlStr="SELECT RECEIPENT_FROM,RECEIPENT_TO,isnull(RECEIPMENT_CC,'') AS RECEIPMENT_CC,MAIL_SUBJECT, MAIL_CREATED_DATE,MAIL_SEND_DATE,MAIL_CREATOR,ERROR_SUCCESS,MAIL_ID FROM VW_Req_mailBox  WHERE  REQ_NUMBER='"+strRequisitionNo+"' ORDER BY 9" ;
//query changed by manoj chand on 04 july 2012
sSqlStr="SELECT RECEIPENT_FROM,RECEIPENT_TO,isnull(RECEIPMENT_CC,'') AS RECEIPMENT_CC,MAIL_SUBJECT, MAIL_CREATED_DATE,MAIL_SEND_DATE,MAIL_CREATOR,ERROR_SUCCESS,MAIL_ID FROM VW_Req_mailBox  WHERE  SUBSTRING(REQ_NUMBER,CHARINDEX('"+strRequisitionNo+"',REQ_NUMBER,0),(CHARINDEX('||',REQ_NUMBER+'||')-1))  = '"+strRequisitionNo+"' ORDER BY 9";

rs = dbConBean.executeQuery(sSqlStr);

//System.out.println("sSqlStr================="+sSqlStr);
%>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<span id=main> </span>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.requestdetails.travelrequisitionmailmovementdetails",strsesLanguage) %></li>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top"><table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
     <ul id="list-nav">
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
     </ul>
       </td>
        
      </tr>
    </table></td>
  </tr>
</table>

<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <tr class="formhead"> 
    <td colspan="10"><%=dbLabelBean.getLabel("label.requestdetails.mailintheworkflow",strsesLanguage) %></td>
  </tr>
<tr class="formtr1"> 
	<td width="5%" class="listhead"><B>#</B></td>
	<td width="10%" class="listhead"><B><%=dbLabelBean.getLabel("label.requestdetails.mailfrom",strsesLanguage) %></B> </td>
	<td width="10%" class="listhead"><B><%=dbLabelBean.getLabel("label.requestdetails.mailto",strsesLanguage) %></B></td>
	<td width="10%" class="listhead"><B><%=dbLabelBean.getLabel("label.requestdetails.mailcc",strsesLanguage) %></B></td>
	<td width="20%" class="listhead"><B><%=dbLabelBean.getLabel("label.requestdetails.subject",strsesLanguage) %></B></td>
	<td width="10%" class="listhead"><B><%=dbLabelBean.getLabel("label.requestdetails.createddate",strsesLanguage) %></B></td>
	<td width="10%" class="listhead"><B><%=dbLabelBean.getLabel("label.requestdetails.senddate",strsesLanguage) %></B></td>
	<td width="10%" class="listhead"><B><%=dbLabelBean.getLabel("label.requestdetails.mailcreator",strsesLanguage) %></B></td>
	<td width="10%" class="listhead" nowrap="nowrap"><B><%=dbLabelBean.getLabel("label.requestdetails.mailstatus",strsesLanguage) %></B></td>
	<td width="10%" class="listhead" nowrap="nowrap"><B><%=dbLabelBean.getLabel("label.requestdetails.viewdetails",strsesLanguage) %></B></td>
  </tr>
<%
while(rs.next())
{

	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 


	  iCls++;
%>
<tr class="<%=strStyleCls%>"> 
	<td width="5%" class="listdata"><%=i++%></td>
	<td width="10%" class="listhead"><%=rs.getString(1)%></td>
	<td width="10%" class="listdata"><%=rs.getString(2)%></td>
	<td width="20%" class="listhead"><%=rs.getString(3)%></td>
	<td width="10%" class="listhead"><%=rs.getString(4)%></td><!--    Create date -->
	<td width="10%" class="listhead"><%=rs.getString(5)%></td>
	<td width="10%" class="listhead"><%=rs.getString(6)%></td><!-- mail creator --> 
	<td width="10%" class="listhead"><%=rs.getString(7)%></td>
	<td width="10%" class="listhead"><%=rs.getString(8)%></td>
	<td width="10%" class="listhead"><a href="#" onClick="MM_openBrWindow('T_TravelRequisitionMailsDetails.jsp?MAILID=<%=rs.getString(9)%>','REQMAILSDETAILS','scrollbars=yes,resizable=yes,width=775,height=250')"><%=dbLabelBean.getLabel("label.requestdetails.viewmailcontent",strsesLanguage) %></a></td>
  </tr>
<%
}
rs.close();
dbConBean.close();     //Close All Connection
%>

</table>

</body>

	</html>
