<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Manoj Chand
*Date			:   08/02/2011
*Description	:	Delete Currency
*Project		:	STARS
**********************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>

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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>

<base target="middle">
</head>
<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection objCon					=		null;			    // Object for connection
ResultSet objRs						=		null;			  // Object for ResultSet
Statement st						=		null;
CallableStatement objCstmt			=		null;			// Object for Callable Statement
String strSql						=       "";
String strMessage					=		"";
String strIPAddress=request.getRemoteAddr();
//String Record_type="D";
//String U_DATE	=""; //object to set U_DATE
int CurId;				

CurId	 	 				=Integer.parseInt(request.getParameter("currencyId")); // GET CURRENCY ID
//System.out.println("CurId----------->"+CurId);
objCon = dbConBean.getConnection();   //Get Conneciton
objCon.setAutoCommit(false);
String baseflag=request.getParameter("baseflag");

if(baseflag.equals("N"))
		{
try
{		
	/*objCstmt=objCon.prepareCall("{?=call PROC_DESIG_DELETE(?,?,?)}");//PROCEDURE FOR DELETING THE SITE
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);	
	objCstmt.setString(2, strDesigId);		
	objCstmt.setString(3,Record_type);	
	objCstmt.setString(4,U_DATE);
	objCstmt.execute();	
	objCstmt.close();*/
		//System.out.println("---------------1---------------");
	objCstmt=objCon.prepareCall("{?=call SPG_CURRENCY(?,?,?,?,?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);

    objCstmt.setInt(2,CurId);
    objCstmt.setString(3, "");
    objCstmt.setString(4, "");
    objCstmt.setString(5, "");
    objCstmt.setString(6, "");
    objCstmt.setString(7, "");
    objCstmt.setString(8, strIPAddress);
    objCstmt.setString(9, Suser_id);
    objCstmt.setString(10, "DELETE");
    objCstmt.registerOutParameter(11,java.sql.Types.INTEGER);
    objCstmt.execute();
    	//System.out.println("---------------2--------------");
    int retval		=	objCstmt.getInt(1);// get output parameter from the procedure
   // System.out.println("retval====>"+retval);
	if(retval==0)
	    request.setAttribute("processStatus", "D");
	else
		request.setAttribute("processStatus", "Error");
	objCstmt.close(); // close procedure
	objCon.commit();
	//objCon.close();
	strMessage = dbLabelBean.getLabel("message.currency.currencydeletedsuccessfully",strsesLanguage);
	//response.sendRedirect("M_currencyList.jsp?flag=true");
	response.sendRedirect("M_currencyList.jsp?flag=true&message="+URLEncoder.encode(strMessage,"UTF-8"));
	}
catch(Exception e)
{
	System.out.println("Exception at M_currencyDelete.jsp?false");
	objCon.rollback();
	response.sendRedirect("M_currencyList.jsp?flag=false");
}
		
finally 
{
	objCon.close();		
}	
	

dbConBean.close();
		}				 			
%>				