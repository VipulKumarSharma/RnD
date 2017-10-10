<%@ include  file="importStatement.jsp" %>
<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Manoj Chand
*Date			:   25 Feb 2013
*Description	:	Travel Requisition Unhold from List
*Project		:   STARS
**********************************************************/
%>
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
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
// Variables declared and initialized
Connection objCon				=		null;			    // Object for connection
CallableStatement cstmt			=		null;			// Object for Callable Statement
CallableStatement objCstmt		=		null;			// Object for Callable Statement

String strTravelId	            =       "";           // Object to store Requisition ID
String strTravelReqId	        =       "";           
String strTravelType            =       "";   
strTravelId     				=	request.getParameter("travelId");
strTravelReqId                  =	request.getParameter("travelReqId");
strTravelType     				=	request.getParameter("travelType");
String strIpAddr = request.getRemoteAddr();
try
{
   objCon =  dbConBean.getConnection();
   cstmt  =  objCon.prepareCall("{?=call PROC_TRAVEL_REQ_HOLD_BY_ADMIN(?,?,?,?,?,?,?,?)}");
   cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
   cstmt.setString(2, strTravelId);
   cstmt.setString(3, strTravelType);
   cstmt.setInt(4, 30);
   cstmt.setString(5, "U");
   cstmt.setString(6, strIpAddr);
   cstmt.setString(7, Suser_id);
   cstmt.setString(8, "");
   cstmt.setString(9, "UNHOLD");
   cstmt.executeUpdate();
   cstmt.close();   
   dbConBean.close(); //Close Connection
}
catch(Exception e)
{
	System.out.println("Error in T_TravelRequisitionUnhold.jsp======="+e);
}

response.sendRedirect("M_HoldRequestList.jsp");

%>

