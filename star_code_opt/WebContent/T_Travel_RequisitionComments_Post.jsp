<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:05 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is second jsp file  for add Comment with the travel requisition in TRAVEL_COMMENT Table of the STAR Database
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modification				:Multilingual functionality added
 *Modified by				:Manoj Chand
 *Date of Modification		:28 May 2012
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

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
// Variables declared and initialized
request.setCharacterEncoding("UTF-8");
String strTravelType      = "";
String strTravelTypeFlag  = "";

strTravelType   =  request.getParameter("travel_type"); 

String strWhichPage    =  "";
String strTargetFlag   =  "";
strWhichPage    =  request.getParameter("whichPage"); 

if(strWhichPage == null)
   strWhichPage = "#";

strTargetFlag    =  request.getParameter("targetFrame"); 
if(strTargetFlag !=null && strTargetFlag.equals("yes"))
{
	strTargetFlag = "yes";
}
Connection con					=		null;			    // Object for connection
ResultSet rs					=		null;			  // Object for ResultSet
CallableStatement cstmt			=		null;			// Object for Callable Statement

//Create Connection
con=dbConBean.getConnection();
String	sSqlStr=""; // For sql Statements
 
        if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
		{
		   strTravelType = "I";
		}
		if(strTravelType != null && strTravelType.equals("DOM"))   
		{
		   strTravelType = "D";
		}

	    String strRequisitionId     	=   ""; // Object to store Requisition ID
		strRequisitionId				=	request.getParameter("purchaseRequisitionId");
		String strComments          	=   "";
		strComments		            	=   request.getParameter("comments");
		//Added By Gurmeet Singh
		String strUserAccessCheckFlag = "";
		strUserAccessCheckFlag = securityUtilityBean.validateAuthCommentsTravelReq(strRequisitionId, strTravelType, Suser_id);

		if(strUserAccessCheckFlag.equals("420")){	
			dbConBean.close();  	
			securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_Travel_RequisitionComments_Post.jsp", "Unauthorized Access");
			response.sendRedirect("UnauthorizedAccess.jsp");		
		} else {
       try
	   {

		cstmt=con.prepareCall("{?=call PROC_TRAVEL_REQ_ADDCOMMENTS(?,?,?,?)}");
		cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		cstmt.setString(2, strRequisitionId);
		cstmt.setString(3, strComments.trim());
		cstmt.setString(4, Suser_id);
		cstmt.setString(5, strTravelType);
		cstmt.execute();
		cstmt.close();
		dbConBean.close();
	   }
	   catch(Exception e)
	   {
		   System.out.println("Error in T_Travel_RequisitionComments_Post.jsp====="+e);
	   }

	response.sendRedirect("T_Travel_RequisitionComments.jsp?purchaseRequisitionId="+strRequisitionId+"&travel_type="+strTravelType+"&whichPage="+strWhichPage+"&targetFrame="+strTargetFlag+"");
	
}%>

