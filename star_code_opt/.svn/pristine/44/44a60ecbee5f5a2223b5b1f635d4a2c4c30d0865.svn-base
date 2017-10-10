<%
/*
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is second jsp file  for create the Forex Details
 *Created On			:   09/05/2012
 *Description			:   to show reviewer Comments to original approver
*/
%>
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<script>
</script>
<%
// Variables declared and initialized
Connection con					=		null;			    // Object for connection
Statement stmt					=		null;			   // Object for Statement
ResultSet rs					=		null;			  // Object for ResultSet
//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
String	sSqlStr=""; // For sql Statements
String strPurchaseRequisitionId	=	request.getParameter("travelRequisitionId")==null?"":request.getParameter("travelRequisitionId").toString().trim();
String strApproveId				=	request.getParameter("ApproverId")==null?"":request.getParameter("ApproverId").toString().trim();
String strPAPFlag				=	request.getParameter("papFlag")==null?"":request.getParameter("papFlag").toString().trim();
String strReqNo					=	request.getParameter("reqNo")==null?"":request.getParameter("reqNo").toString().trim();
int iCls = 0;
String strStyleCls = "";
 %>
</head>
<body ><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50%" height="35" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><b><%=dbLabelBean.getLabel("stars.approve.reviewercomments",strsesLanguage)%></b></li>
    </ul></td>
    <td width="50%" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td colspan="2" align="right">
      <ul id="list-nav">
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
      </ul>
      </td>
     </tr>
    </table>
	</td>
  </tr>
</table>

<table width="75%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
<tr class="formhead" >
	<td colspan="5" class="listhead" align="left" valign="top"><%=strReqNo%></td>
</tr>
			<tr class="formhead">
				<td class="listhead" width="5%" align="left" valign="top" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
				<td class="listhead" width="35%" align="left" valign="top"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%></td>
				<td class="listhead" width="25%" align="left" valign="top"><%=dbLabelBean.getLabel("label.global.postedby",strsesLanguage)%></td>
				<td class="listhead" width="25%"><%=dbLabelBean.getLabel("label.global.postedon",strsesLanguage)%></td>
 				<td class="listhead" width="20%"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>

			</tr>
		<%
	try{
		String strCommentId		=	null;
		String strComments		=	null;
		String strPostedBy		=	null;
		String strPostedOn		=	null;
	    String strCommentsId			=	"";
		 String strOriginatedUserId=	"";

		sSqlStr="select REV_COMMENTS_ID,COMMENTS,DBO.[user_name](POSTED_BY) AS REVIEWER,.DBO.CONVERTDATE(POSTED_ON) AS POSTED_ON ,POSTED_BY from TRAVEL_REQ_REV_COMMENTS"+
			    " WHERE TRAVEL_REQ_ID='"+strPurchaseRequisitionId+"'  AND TRAVEL_REQ_REV_COMMENTS.ORIGINAL_APPROVER_ID='"+Suser_id+"' ORDER BY POSTED_ON DESC";
		//out.print(sSqlStr);
		stmt = con.createStatement(); 
		rs = stmt.executeQuery(sSqlStr);

	 int intSno=1;
	 if(rs.next())
	 {
		do
		 {
			 strCommentId			=	rs.getString("REV_COMMENTS_ID");
			 strComments			=	rs.getString("COMMENTS");
			 strPostedBy			=	rs.getString("REVIEWER");
			 strPostedOn			=	rs.getString("POSTED_ON");			
			 strOriginatedUserId	=	rs.getString("POSTED_BY");
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
				<td class="listdata" width="5%" align="center" valign="top"><%=intSno++%></td>
				<td class="listdata" width="35%" align="left" valign="top"><%=strComments%></td>
				<td class="listdata" width="25%" align="left" valign="top"><%=strPostedBy%></td>
				<td class="listdata" width="25%"><%=strPostedOn%></td> 			
				<td class="listdata" width="20%" >
				<% if(strPAPFlag.equalsIgnoreCase("A")){
					%>	<%=dbLabelBean.getLabel("label.reports.approved",strsesLanguage)%>
					<%}
					else if(strPAPFlag.equalsIgnoreCase("P"))
					{
					%>	<%=dbLabelBean.getLabel("label.mail.passed",strsesLanguage)%>
					<%}else
					{%>
					-
					<%}%>
				</td> 				
				</tr>
			<%
			}while(rs.next());
	 }
	 rs.close();
	 stmt.close();
	 con.close();
	}
	catch(SQLException e)
	{
		e.printStackTrace();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally{
		con.close();
	}
	
%>
</table>
</body>
</html>
