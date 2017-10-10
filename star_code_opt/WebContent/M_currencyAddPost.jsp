<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Manoj Chand
*Date			:   08/02/2011
*Description	:	Add Currency Post
*Project		:	STARS
**********************************************************/
%>


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
Connection objCon					=		null;			// Object for connection
Statement objStmt					=		null;			// Object for Statement
ResultSet objRs						=		null;			// Object for ResultSet
CallableStatement objCstmt			=		null;			// Object for Callable Statement

objCon = dbConBean1.getConnection(); 						 //Get the Conneciton
DbUtilityMethods utilitymethod = new DbUtilityMethods();     // getNewID method defined in this file
String	strSqlStr	=	""; 								 // For sql Statements
String  strMessage  =   "";

String strStatusId			= ""; //object to store Statusid	
String U_DATE  				= ""; //object to store U_date
String strIPAddress=request.getRemoteAddr();

String strCurrName=request.getParameter("currencyName");
String strCurrencyDesc=request.getParameter("curDesc");
String strBaseCurFlag=request.getParameter("baseCurflag");
String strCurrSymbol=request.getParameter("currSymbol");
String strCurrCode=request.getParameter("currCode");

/*System.out.println("currencyName--->"+strCurrName);
System.out.println("curDesc--->"+strCurrencyDesc);
System.out.println("baseCurflag--->"+strBaseCurFlag);
System.out.println("Suser_id-->"+Suser_id);*/
//int user_id=Integer.parseInt("Suser_id");
strSqlStr =  "SELECT CUR_ID FROM M_CURRENCY WHERE CURRENCY=N'"+strCurrName+"' AND  STATUS_ID=10 ";
//System.out.println("strSQLSTR==>"+strSqlStr);
objRs		= dbConBean.executeQuery(strSqlStr);
if(objRs.next())
{
	response.sendRedirect("M_currencyDataResult.jsp?Type=Add&Error=2");//change need here
}
else{

	try
	{
	/*    int intDesigId	=   utilitymethod.getNewGeneratedId("DESIG_ID");
		if(intDesigId == 0)
		{
			strMessage = "Designation not created";
			response.sendRedirect("M_desigList.jsp?flag=true&message="+strMessage);
            System.out.println ("STARS----->Inside inside loop");
		}*/
	
			//Procedure for Nominal Code
			objCstmt=objCon.prepareCall("{?=call SPG_CURRENCY(?,?,?,?,?,?,?,?,?,?)}");
			//objCstmt=objCon.prepareCall("{?=call SPG_CURRENCY(?,?,?,?,?,?,?,?)}");//PROCEDURE TO ADD THE USER IN DESIG TABLE
			objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			
		    objCstmt.setInt(2,0);
		    objCstmt.setString(3, strCurrName);
		    objCstmt.setString(4, strCurrencyDesc);
		    objCstmt.setString(5, strBaseCurFlag);
		    objCstmt.setString(6, strCurrSymbol);
		    objCstmt.setString(7, strCurrCode);
		    objCstmt.setString(8, strIPAddress);
		    objCstmt.setString(9, Suser_id);
		    objCstmt.setString(10,"INSERT");
		    objCstmt.registerOutParameter(11,java.sql.Types.INTEGER);
		    objCstmt.execute();
		    
			int retval = objCstmt.getInt(1);// get output parameter from the procedure
				if(retval==0)
				    request.setAttribute("processStatus", "I");
				else
					request.setAttribute("processStatus", "Error");
			objCstmt.close();
			strMessage = dbLabelBean.getLabel("message.currency.currencyaddedsuccessfully",strsesLanguage);
			response.sendRedirect("M_currencyList.jsp?message="+URLEncoder.encode(strMessage,"UTF-8") );
	}
catch(Exception e)
	{
		strMessage = dbLabelBean.getLabel("message.currency.currencynotcreated",strsesLanguage);
		//System.out.println("Error occured at M_currencyAddPost.jsp=========="+ e);
		objCon.rollback();
		response.sendRedirect("M_desigList.jsp?flag=false&message="+URLEncoder.encode(strMessage,"UTF-8"));	
	}

}
objRs.close();
dbConBean.close();       //CLOSE ALL CONNECTIONS
dbConBean1.close();		 //CLOSE ALL CONNECTIONS
%>