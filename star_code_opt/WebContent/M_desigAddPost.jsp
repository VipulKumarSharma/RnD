<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta	
 *Date of Creation 		:28 Nov	2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is for adding a new Designation in M_DESIGNATION table of STAR Database.
 *Modification 			:  Query changed  by shiv 
 *Date of Modification  : 20/04/2007 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>

<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbUtilityMethods" pageEncoding="UTF-8" %>

<%@page import="java.net.URLEncoder"%><html>
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>


<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection objCon					=		null;			    // Object for connection
Statement objStmt					=		null;			   // Object for Statement
ResultSet objRs						=		null;			  // Object for ResultSet
CallableStatement objCstmt			=		null;			// Object for Callable Statement

objCon = dbConBean1.getConnection();  //Get the Conneciton
DbUtilityMethods utilitymethod = new DbUtilityMethods(); // getNewID method defined in this file
String	strSqlStr	=	""; // For sql Statements
String  strMessage  =   "";

String Record_type			= "I"; // Setting Record Type to I in case if insert

//String strDesignation		= ""; //object to store Site Name
//String strDesc				= ""; //object to store Description
String strStatusId			= ""; //object to store Statusid	
String U_DATE  				= ""; //object to store U_date
String strHiddenSiteId      = "";
//String sitedivId					="";
String strDesignation	 			=	request.getParameter("desigName"); 	// GET SITE
 String strDesc	 					=	request.getParameter("Description");	// GET DESCRIPTION
strStatusId					=	request.getParameter("status_id");	// GET STATUS
strHiddenSiteId				=	request.getParameter("hiddenSiteId");	// GET HIDDEN SITE ID 
String sitedivId				=	request.getParameter("sitedivId");

 
strMessage = request.getParameter("message") == null ?"" : request.getParameter("message");
		
/// Change query by shiv on 20/04/2007
strSqlStr =  "SELECT DESIG_ID FROM M_DESIGNATION WHERE DESIG_NAME=N'"+strDesignation+"' AND SITE_ID='"+sitedivId+"'  AND  STATUS_ID=10 AND APPLICATION_ID=1";
 
 


objRs		= dbConBean.executeQuery(strSqlStr);
if(objRs.next())
{
	response.sendRedirect("M_desigDataResult.jsp?Type=Add&Error=2");
}
else
{
	try
	{
		//int intDesigId	
//System.out.println ("STARS----->Inside M_desigaddpost");			= utilitymethod.getNewId("M_DESIGNATION"); //Getting unique SITE_ID from the bean
		int intDesigId	=   utilitymethod.getNewGeneratedId("DESIG_ID");
		if(intDesigId == 0)
		{
			strMessage = dbLabelBean.getLabel("message.designation.designationnotcreated",strsesLanguage);
			response.sendRedirect("M_desigList.jsp?flag=true&message="+URLEncoder.encode(strMessage,"UTF-8"));
//System.out.println ("STARS----->Inside inside loop");
		}
		else
		{
		
			//Procedure for Nominal Code

			objCstmt=objCon.prepareCall("{?=call PROC_DESIG_ADD(?,?,?,?,?,?,?,?)}");//PROCEDURE TO ADD THE USER IN DESIG TABLE
			objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			
		//NEW
			objCstmt.setString(2, sitedivId); //added by shiv on 19 th April 
			///objCstmt.setString(2, strHiddenSiteId);
		//

			objCstmt.setString(3, strDesignation);
			objCstmt.setString(4, strDesc);
			objCstmt.setString(5, "10");
			objCstmt.setString(6, Suser_id);
			objCstmt.setInt(7,intDesigId);
			objCstmt.setString(8,Record_type);
			objCstmt.setString(9,U_DATE);
			objCstmt.execute();
			objCstmt.close();
			strMessage = dbLabelBean.getLabel("message.designation.designationcreatedsuccessfully",strsesLanguage);
			response.sendRedirect("M_desigList.jsp?message="+URLEncoder.encode(strMessage,"UTF-8"));
		}
	}
	catch(Exception e)
	{
		strMessage = dbLabelBean.getLabel("message.designation.designationnotcreated",strsesLanguage);;
		System.out.println("Error occured at M_desigAddPost.jsp=========="+ e);
		objCon.rollback();
		response.sendRedirect("M_desigList.jsp?flag=false&message="+URLEncoder.encode(strMessage,"UTF-8"));	
	}
}

objRs.close();
dbConBean.close();       //CLOSE ALL CONNECTIONS
dbConBean1.close();       //CLOSE ALL CONNECTIONS


%>

