<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Gurmeet Singh
 *Date of Creation 		:21 May 2014
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is second jsp file for manually update TES status with reason of Travel Request in T_TRAVEL_STATUS Table of the STAR Database
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
String strRequisitionId   = ""; 
String strTravelType      = "";
String strTESFlag         = "";
String strReason          = "";
String strWhichPage       = "";
String strTargetFlag      = "";
String strUpdateFlag      = "";

strRequisitionId		  =	request.getParameter("purchaseRequisitionId");
strTravelType             = request.getParameter("travel_type"); 
strReason		          = request.getParameter("reason");
strWhichPage              = request.getParameter("whichPage"); 
strTargetFlag             = request.getParameter("targetFrame");
strTESFlag   = "Y";

	if(strWhichPage == null){
	   strWhichPage = "#";
	}
	
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

	    
		
       try
	   {

		cstmt=con.prepareCall("{?=call SPG_UPDATE_TRAVEL_REQ_STATUS(?,?,?,?,?)}");
		cstmt.registerOutParameter(1,java.sql.Types.INTEGER);  
		cstmt.setInt(2,Integer.parseInt(strRequisitionId));						
		cstmt.setString(3,strTravelType);
		cstmt.setString(4,strTESFlag);
		cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
		cstmt.setString(6, strReason.trim());
		cstmt.execute();		
		String strStatusCode = cstmt.getString(5);// get output parameter from the procedure
		if(strStatusCode.equals("10")){
			strUpdateFlag = "Y";
		}
		cstmt.close();
		dbConBean.close();
	   }
	   catch(Exception e)
	   {
		   System.out.println("Error in T_TESStatus_RequestClose_Post.jsp====="+e);
	   }

	response.sendRedirect("T_TESStatus_RequestClose.jsp?purchaseRequisitionId="+strRequisitionId+"&travel_type="+strTravelType+"&whichPage="+strWhichPage+"&targetFrame="+strTargetFlag+"&updateFlag="+strUpdateFlag+"");
	
%>