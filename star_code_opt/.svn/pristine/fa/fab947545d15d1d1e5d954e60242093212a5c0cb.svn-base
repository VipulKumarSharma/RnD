<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta
 *Date of Creation 		:28 Nov 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp for delete the designation.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>

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

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
// Variables declared and initialized
Connection objCon			=		null;			    // Object for connection
ResultSet objRs						=		null;			  // Object for ResultSet
CallableStatement objCstmt			=		null;			// Object for Callable Statement
String Record_type="D";
String U_DATE	=""; //object to set U_DATE
String strDesigId				="";

strDesigId	 	 				=	request.getParameter("desigId"); // GET SITE ID

objCon = dbConBean.getConnection();   //Get Conneciton
objCon.setAutoCommit(false);

		try
		 {		
			objCstmt=objCon.prepareCall("{?=call PROC_DESIG_DELETE(?,?,?)}");//PROCEDURE FOR DELETING THE SITE
			objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);	
			objCstmt.setString(2, strDesigId);		
			objCstmt.setString(3,Record_type);	
			objCstmt.setString(4,U_DATE);
			objCstmt.execute();	
			objCstmt.close();
			objCon.commit();
			objCon.close();
			response.sendRedirect("M_desigList.jsp?flag=true");
			}
		catch(Exception e)
		{
			System.out.println("Exception at M_desigDelete.jsp?false");
			objCon.rollback();
			response.sendRedirect("M_desigList.jsp?flag=false");
		}
		finally 
		{
			objCon.close();		
		}	
				
dbConBean.close();

%>

