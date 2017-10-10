 
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:GURMEET SINGH
 *Date of Creation 		:24-Sep-2015
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is post jsp file  for Cancel the Requisition
 *Modification 			: 
 *Revision History		:
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
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
request.setCharacterEncoding("UTF-8");

Connection con				= null;	
ResultSet rs				= null;
CallableStatement cstmt		= null;
String	sSqlStr="";
//Create Connection
con=dbConBean.getConnection();

int intSuccess            		= 0; 
String strTravelType      		= "";
String strTravellerId   		= "";
String strTravllerSiteId 		= "";
String strRequisitionId     	= ""; 
String flage					= "";
String unitheadcheck			= "";
String chairmancheck			= "";
String strComments          	= "";
String strSiteId				= "";
String strUserSiteID			= "";
String strRoleId				= "";	
String strTableName				= "";
String strUserBillingClient		= "";
String strUrl					= "";
String strUserAccessCheckFlag 	= "";

strTravelType   				= request.getParameter("travel_type"); 
strRequisitionId				= request.getParameter("purchaseRequisitionId");
strComments		    			= request.getParameter("comments");

if(strTravelType != null && strTravelType.equals("INT")) {
   strTravelType = "I";
} else if(strTravelType != null && strTravelType.equals("DOM")) {
   strTravelType = "D";
}

strUserAccessCheckFlag = securityUtilityBean.validateAuthCancelTravelReq(strRequisitionId, strTravelType, Suser_id);
if(strUserAccessCheckFlag.equals("420")) {
	dbConBean.close(); 
	securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_Travel_Requisition_Cancel_ApprovedByAll_Post.jsp", "Unauthorized Access");
	response.sendRedirect("UnauthorizedAccess.jsp");
	return;
} else {
	try {
		cstmt=con.prepareCall("{?=call PROC_TRAVEL_REQ_CANCELATION_BY_ORIGINATOR(?,?,?,?)}");
		cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		cstmt.setString(2, strRequisitionId);
		cstmt.setString(3, strComments.trim());
		cstmt.setString(4, Suser_id);
		cstmt.setString(5, strTravelType);
		intSuccess = cstmt.executeUpdate();
		cstmt.close();
		
		if(intSuccess > 0 ) {
%>
			<jsp:include page="T_requisitionMailOnCancel_ApprovedByAll.jsp"> 
				<jsp:param name="purchaseRequisitionId" value="<%=strRequisitionId%>"/>
				<jsp:param name="CancelComments" value="<%=strComments.trim()%>"/>
				<jsp:param name="travelType" value="<%=strTravelType%>"/>
			</jsp:include>	
<%
		}
	}
	catch(Exception e) {
		System.out.println("Error in T_Travel_Requisition_Cancel_ApprovedByAll_Post.jsp====="+e);
	}
	
	strUrl = "T_Travel_Requisition_Cancel_ApprovedByAll.jsp?purchaseRequisitionId="+strRequisitionId+"&travel_type="+strTravelType;
	dbConBean.close();  //close All Connection
%>
<html>
<head>
<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<script language=JavaScript>
	function win() {
		window.location.href="<%=strUrl%>";
		window.opener.$('#goBtn').trigger('click');
		//self.close();
	}
</script>
</head>
<body onload="win();">
<form action=""></form>
</body>
<% } %>
</html>

