<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:06 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp is used to Display information about the travel approver to the User.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			:Manoj Chand
 *Modification			:Change in Query to show mata-initial and mata-final in workflow status
 *Date of modification	:05 March 2012
 
 *Date of Modification  :30 Mar 2012
 *Modified By	        :MANOJ CHAND	
 *Description			:implementing Red image for currently pending request.
 
 *Date of Modification  :02 July 2013
 *Modified By	        :MANOJ CHAND	
 *Description			:Display Caption Billing Approver as the designation of billing approver.
*******************************************************/%>

<%@ page import = "src.connection.DbConnectionBean" %>
<%@ include  file="importStatement.jsp" %>
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
<%--<%@ include  file="systemStyle.jsp" %>--%>

<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="bean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
<!-- <link rel="stylesheet" href="styles/fonts.css?buildstamp=2_0_0" type="text/css">
<link rel="stylesheet" href="styles/links.css?buildstamp=2_0_0" type="text/css"> -->
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
</head>
<body class="body">
<span id=main> </span>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.requestdetails.approvalcyclefortravelrequisition",strsesLanguage) %></li>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
  <tr align ="right">
  <td>
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

<%
// Variables declared and initialized
//Connection con		=		null;			    // Object for connection
//Statement stmt		=		null;			   // Object for Statement
ResultSet rs		=		null;			  // Object for ResultSet
int iCls = 0;
String strStyleCls = "";
//Create Connection
//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
//con = DriverManager.getConnection("jdbc:odbc:star","sa","");

String	sSqlStr					=	"";			// For sql Statements
String strtravelRequisitionId	=	"";			//For holding Purchase Requisition Id
String strTravellerId			=	"";
String strTRAVEL_ID				=	request.getParameter("travelRequisitionId");
strTravellerId					=	request.getParameter("strTravellerId");
String strTravelRequestNo		=	request.getParameter("strTravelRequestNo");
String strTravelType			=   request.getParameter("travelType");
String strAPPROVE_ID			=	"";
String strAPPROVER_Desig		=	"";
String strAPPROVE_STATUS		=	"";
String strAPPROVE_DATE			=	"";
String strUsername				=	"";
String strDesigid				=	"";
String strDesigdesc				=	"";
String sSqlStruser				=	"";
int iLoop						=	1;
//String travelReqno				=	"";

//Added By Gurmeet Singh
String strUserAccessCheckFlag = "";
strUserAccessCheckFlag = securityUtilityBean.validateAuthTravelDetails(strTRAVEL_ID, strTravelType, Suser_id);		


if(strUserAccessCheckFlag.equals("420")){	
	bean.close();  	
	securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_TravelRequisitionWorkFlowDiagram.jsp", "Unauthorized Access");
	response.sendRedirect("UnauthorizedAccess.jsp");		
} else {

//sSqlStr="SELECT DBO.USER_NAME(APPROVER_ID) as APPROVER_NAME , DBO.DESIG_FROM_USERID(APPROVER_ID) as DESIGN_DESC ,ISNULL(DBO.CONVERTDATEDMY1(APPROVE_DATE),'-') AS APPROVE_DATE, APPROVE_STATUS,case when ORIGINAL_APPROVER='0' then '0' else dbo.user_name(ORIGINAL_APPROVER) end  as ORIGINAL_APPROVER FROM T_APPROVERS WHERE TRAVEL_ID ='"+ strTRAVEL_ID +"'AND TRAVELLER_ID ='"+ strTravellerId +"'  AND TRAVEL_TYPE ='"+strTravelType+"' ORDER BY order_ID";
//query changed by manoj chand on 05 march 2012 to display designation mata-initial and mata-final
//if else added by manoj chand on 02 july 2013 to dispaly caption Billing approver in case billing approver exists.
if(strTravelType.equals("I")){
sSqlStr="SELECT DBO.USER_NAME(APPROVER_ID) as APPROVER_NAME ,"+
		" CASE  ORDER_ID  WHEN (SELECT MIN(T.ORDER_ID)"+ 	
		" FROM T_APPROVERS T"+ 	
		" WHERE (T.TRAVEL_ID = T_APPROVERS.TRAVEL_ID ) AND   (T.TRAVELLER_ID = T_APPROVERS.TRAVELLER_ID)"+ 
		" AND (T.TRAVEL_TYPE = T_APPROVERS.TRAVEL_TYPE) AND T.ROLE='MATA' 	HAVING COUNT(*)>1)"+	 
		" THEN RTRIM(ISNULL(DBO.DESIG_FROM_USERID(APPROVER_ID), '-'))+'-Initial'"+  
		" WHEN (SELECT MAX(T.ORDER_ID)"+	  	
		" FROM T_APPROVERS T 	"+
		" WHERE (T.TRAVEL_ID = T_APPROVERS.TRAVEL_ID ) AND 	 (T.TRAVELLER_ID = T_APPROVERS.TRAVELLER_ID)"+
		" AND (T.TRAVEL_TYPE = T_APPROVERS.TRAVEL_TYPE) AND T.ROLE='MATA'"+
		" HAVING COUNT(*)>1)   "+
		" THEN RTRIM(ISNULL(DBO.DESIG_FROM_USERID(APPROVER_ID), '-'))+'-Final'"+  
		//"ELSE RTRIM(ISNULL(DBO.DESIG_FROM_USERID(APPROVER_ID), '-')) END as DESIGN_DESC"+
		" ELSE CASE WHEN (SELECT 1 FROM T_TRAVEL_DETAIL_INT TTDI WHERE TTDI.TRAVEL_ID=T_APPROVERS.TRAVEL_ID AND TTDI.BILLING_CLIENT=convert(varchar(10),T_APPROVERS.APPROVER_ID))>0 THEN 'Billing Approver' ELSE  RTRIM(ISNULL(DBO.DESIG_FROM_USERID(APPROVER_ID), '-')) END END as DESIGN_DESC"+
		" ,ISNULL(DBO.CONVERTDATEDMY1(APPROVE_DATE),'-') AS APPROVE_DATE, APPROVE_STATUS,case when ORIGINAL_APPROVER='0' then '0' else dbo.user_name(ORIGINAL_APPROVER) end  as ORIGINAL_APPROVER FROM T_APPROVERS WHERE TRAVEL_ID ='"+ strTRAVEL_ID +"'AND TRAVELLER_ID ='"+ strTravellerId +"'  AND TRAVEL_TYPE ='"+strTravelType+"' AND T_APPROVERS.STATUS_ID=10 ORDER BY order_ID";
}else{
	sSqlStr="SELECT DBO.USER_NAME(APPROVER_ID) as APPROVER_NAME ,"+
	" CASE  ORDER_ID  WHEN (SELECT MIN(T.ORDER_ID)"+ 	
	" FROM T_APPROVERS T"+ 	
	" WHERE (T.TRAVEL_ID = T_APPROVERS.TRAVEL_ID ) AND   (T.TRAVELLER_ID = T_APPROVERS.TRAVELLER_ID)"+ 
	" AND (T.TRAVEL_TYPE = T_APPROVERS.TRAVEL_TYPE) AND T.ROLE='MATA' 	HAVING COUNT(*)>1)"+	 
	" THEN RTRIM(ISNULL(DBO.DESIG_FROM_USERID(APPROVER_ID), '-'))+'-Initial'"+  
	" WHEN (SELECT MAX(T.ORDER_ID)"+	  	
	" FROM T_APPROVERS T 	"+
	" WHERE (T.TRAVEL_ID = T_APPROVERS.TRAVEL_ID ) AND 	 (T.TRAVELLER_ID = T_APPROVERS.TRAVELLER_ID)"+
	" AND (T.TRAVEL_TYPE = T_APPROVERS.TRAVEL_TYPE) AND T.ROLE='MATA'"+
	" HAVING COUNT(*)>1)   "+
	" THEN RTRIM(ISNULL(DBO.DESIG_FROM_USERID(APPROVER_ID), '-'))+'-Final'"+  
	//"ELSE RTRIM(ISNULL(DBO.DESIG_FROM_USERID(APPROVER_ID), '-')) END as DESIGN_DESC"+
	" ELSE CASE WHEN (SELECT 1 FROM T_TRAVEL_DETAIL_DOM TTDI WHERE TTDI.TRAVEL_ID=T_APPROVERS.TRAVEL_ID AND TTDI.BILLING_CLIENT=convert(varchar(10),T_APPROVERS.APPROVER_ID))>0 THEN 'Billing Approver' ELSE  RTRIM(ISNULL(DBO.DESIG_FROM_USERID(APPROVER_ID), '-')) END END as DESIGN_DESC"+
	" ,ISNULL(DBO.CONVERTDATEDMY1(APPROVE_DATE),'-') AS APPROVE_DATE, APPROVE_STATUS,case when ORIGINAL_APPROVER='0' then '0' else dbo.user_name(ORIGINAL_APPROVER) end  as ORIGINAL_APPROVER FROM T_APPROVERS WHERE TRAVEL_ID ='"+ strTRAVEL_ID +"'AND TRAVELLER_ID ='"+ strTravellerId +"'  AND TRAVEL_TYPE ='"+strTravelType+"' AND T_APPROVERS.STATUS_ID=10 ORDER BY order_ID";
}
//System.out.println("<---->"+sSqlStr);
//SELECT dbo.USER_NAME(APPROVER_ID) as APPROVER_NAME ,ISNULL(dbo.DESIG_FROM_USERID(APPROVER_ID),'-') AS DESIGN_DESC ,ISNULL(dbo.CONVERTDATEDMY1(APPROVE_DATE),'-') AS APPROVE_DATE, APPROVE_STATUS FROM T_APPROVERS WHERE TRAVEL_ID ='"+strTravelId +"'AND TRAVELLER_ID ='"+ strTravellerId +"' AND TRAVEL_TYPE='I'  ORDER BY order_ID

//System.out.println("*******************************************************************************");
//System.out.println("********* sSqlStr <--->   "+sSqlStr);
//System.out.println("********************************************************************************");
%>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <tr class="formhead"> 
    <td colspan="5" class="listhead"><%=dbLabelBean.getLabel("label.requestdetails.approverslist",strsesLanguage) %></td>
  </tr>
  <tr class="formhead"> 
     <td width="5%" class="listhead">#</td>
    <td width="25%" class="listhead"><%=dbLabelBean.getLabel("label.requestdetails.name",strsesLanguage) %></td>
    <td width="27%" class="listhead"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></td>
    <td width="15%" class="listhead"><%=dbLabelBean.getLabel("label.requestdetails.status",strsesLanguage) %></td>
    <td width="33%" class="listhead"><%=dbLabelBean.getLabel("label.requestdetails.approvaldate",strsesLanguage) %></td>
  </tr>

<%	
	//System.out.println("sSqlStr --> "+sSqlStr);

	String strstrORIGINAL_APPROVERName	=	"";
	String strORIGINAL_APPROVER			=	"";
	String strMsg							=	"";
	String strImg							=	"Red";
	rs = bean.executeQuery(sSqlStr);
	while(rs.next())
	{
	strAPPROVE_ID		=	rs.getString("APPROVER_NAME");
	strAPPROVER_Desig	=	rs.getString("DESIGN_DESC");
	strAPPROVE_DATE		=	rs.getString("APPROVE_DATE");
	strAPPROVE_STATUS	=	rs.getString("APPROVE_STATUS");
    strORIGINAL_APPROVER    =	rs.getString("ORIGINAL_APPROVER");
    

		/*if(strAPPROVE_STATUS.equals("0"))
			{
			strAPPROVE_STATUS="<img src=images/cross.gif border=0>";
			}*/
			//added by Manoj Chand on 28 March 2012 to show Current Pending request with red p.
		    if(strAPPROVE_STATUS.equals("0") && !strImg.equalsIgnoreCase("Red"))
	   	    {
		    	strAPPROVE_STATUS="<img src=images/cross.gif border=0>";
	   	    }
	   	    else if(strAPPROVE_STATUS.equals("0") && strImg.equalsIgnoreCase("Red"))
	   	    {
	   	    	strAPPROVE_STATUS="<img src=images/mark.gif border=0>";
	   			strImg="black";
	   	    }
			else 		if(strAPPROVE_STATUS.equals("4"))
			{
			strAPPROVE_STATUS="<font color=red>"+dbLabelBean.getLabel("label.requestdetails.rejected",strsesLanguage)+"</font>";
			strImg="black";
			}

			else 		if(strAPPROVE_STATUS.equals("3"))

			{
			strAPPROVE_STATUS="<font color=red>"+dbLabelBean.getLabel("label.requestdetails.returned",strsesLanguage)+"</font>";
			strImg="black";
			}
			else 		if(strAPPROVE_STATUS.equals("6"))

			{
			strAPPROVE_STATUS="<font color=red>"+dbLabelBean.getLabel("label.requestdetails.cancelled",strsesLanguage)+"</font>";
			strImg="black";
			}


			else
			{
			strAPPROVE_STATUS="<img src=images/tick.gif border=0>";
			}
		
		if(strORIGINAL_APPROVER.equals("0") )
		{	
			strMsg="";
		}else
		 {
		  strMsg="<font color=red >("+dbLabelBean.getLabel("label.requestdetails.onbehalfof",strsesLanguage)+strORIGINAL_APPROVER+")</font>";	
		}
		

%>
	  <tr valign="top" class="formtr2"> 
      <td width="5%" class="listdata"><%=iLoop++%></td>
      <td width="25%"  class="listdata"><%=strAPPROVE_ID%> <%=strMsg%></td>
      <td width="27%"  class="listdata"><%=strAPPROVER_Desig%> </td>
	  <td width="15%"  class="listdata"><%=strAPPROVE_STATUS%> </td>
	  <td width="33%"  class="listdata"><%=strAPPROVE_DATE%> </td>
	  
	  
	 <%//	if(strAPPROVE_STATUS.equals("<img src=images/tick.gif border=0>")){ %>
			
			    <!--<td width="18%"  class="listdata"><%//=strAPPROVE_DATE%> </td>-->
	<%// } else { %>
			 	<!--<td width="18%"  class="listdata"> - </td> -->
						
	<%// } %>
	 </tr>

<% }	
	
bean.close();
//System.out.println("***********************************************************************************************************");
%>
	<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	 <tr class="formhead"> 
	    <td width="38%" class="formhead"  align="center"> <%=dbLabelBean.getLabel("label.requestdetails.approverfortravelrequest",strsesLanguage) %> <%=strTravelRequestNo%></td>
		</td>
	 </tr>
    </table>
   <%} %>
</body>
  </html>
