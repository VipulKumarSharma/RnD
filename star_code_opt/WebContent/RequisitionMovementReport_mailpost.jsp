 <%
/***************************************************
 *The information contained here in is confidential and 
 *proprietary to MIND and forms the part of the MIND 
 *Author				:Shiv Sharma 
 *Date of Creation 		:30 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is second(post) jsp file for sending mail to the origenator and current approver.
 *Modification 			:
 *Date of Modification  : 
 *Revision History		: 
 *Modified By			:
 *Editor				:Editplus
 *******************************************************/
%>
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
<%@ include  file="systemStyle.jsp" %>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
String strCount="";

String strCheck			=	request.getParameter("strCheck_forMail");
String strTravelType	=	request.getParameter("strTravelType_forMail");
String strFrom			=	request.getParameter("strFrom_forMail");
String strTo			=	request.getParameter("strTo_forMail");
String strUnitHidden	=	request.getParameter("strUnitHidden_forMail");
String strReq_startus   =  request.getParameter("strReq_startus_forMail");

String url="";
String strReq="";
String strStatus="Approve";
url="RequisitionMovementReport_Post.jsp?chkData="+strCheck+"&travelType="+strTravelType+"&from="+strFrom+"&to="+strTo+"&SelectUnit="+strUnitHidden+"&REQ_STATUS="+strReq_startus; 


strCount	 				=	request.getParameter("count");	// GET COUNT

if(strTravelType.equalsIgnoreCase("I"))
	{
strReq	=	"International Travel";
	}
	else
	{
strReq	=	"Domestic Travel";
	}
 

 String strCheckValue  ="";
 String strTravelId	   ="";
 String strTravellerId ="";
 StringTokenizer token       = null;  
 String strTravellerSiteId   ="";
 String  strComments="canceled by  star  Admin";
 
int intCount					=	Integer.valueOf(strCount).intValue();


for (int j=0;j<=intCount+1;j++)
{
  strCheckValue = request.getParameter("chk"+j);
  if(strCheckValue!=null)
	{
      token = new StringTokenizer(strCheckValue,";"); 
	  while(token.hasMoreTokens())
	  {
		  strTravelId     =  token.nextToken();
		  strTravellerId  =  token.nextToken();
	  }

 	  try
		  {
     %>
      <jsp:include page="T_requisitionMailOnExpired.jsp" >
		<jsp:param name="purchaseRequisitionId" value="<%=strTravelId%>"/>
        <jsp:param name="rad" value="<%=strStatus.trim()%>"/>
        <jsp:param name="COMMENTS" value="<%=strComments.trim()%>"/>
	    <jsp:param name="ReqTyp" value="<%=strReq%>"/>
     </jsp:include>
 
     <%
		  }
	 catch(Exception e)
		{
		 System.out.println("Error is ......."+e);
	 }  
	}
}

 

%>
<body onLoad="document.frm.submit()" >
 
<form name=frm action="RequisitionMovementReport_Post.jsp" target="middle">

<input type="hidden" name=chkData value="<%=strCheck%>"/>
<input type="hidden" name=travelType value="<%=strTravelType%>"/>
<input type="hidden" name=from value="<%=strFrom%>"/>
<input type="hidden" name=to value="<%=strTo%>"/>
<input type="hidden" name=SelectUnit value="<%=strUnitHidden%>"/>
<input type="hidden" name=REQ_STATUS value="<%=strReq_startus%>"/>

</form>
 
<%

  
%>


