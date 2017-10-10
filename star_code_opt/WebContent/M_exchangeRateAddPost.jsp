<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Manoj Chand
*Date			:   09/02/2011
*Description	:	Add Exchange Rate Post
*Project		:	STARS
**********************************************************/
%>

<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbUtilityMethods" pageEncoding="UTF-8"%>

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
//Statement objStmt					=		null;			// Object for Statement
//ResultSet objRs						=		null;			// Object for ResultSet
CallableStatement objCstmt			=		null;			// Object for Callable Statement

objCon = dbConBean1.getConnection(); 						 //Get the Conneciton
DbUtilityMethods utilitymethod = new DbUtilityMethods();     // getNewID method defined in this file
String	strSqlStr	=	""; 								 // For sql Statements
String  strMessage  =   "";
String Record_type="U";
String strIPAddress=request.getRemoteAddr();
String strStatusId			= ""; //object to store Statusid	
String U_DATE  				= ""; //object to store U_date
int retval;
int Month=Integer.parseInt(request.getParameter("Month"));
int Year=Integer.parseInt(request.getParameter("year"));
//String strconRate=request.getParameter("conversionRate");
//String strcurid=request.getParameter("conrateId2");
int count=Integer.parseInt(request.getParameter("count"));
///System.out.println("CONVERSION RATE-->"+strconRate);
//System.out.println("Month-->"+Month);
//System.out.println("Year-->"+Year);
//System.out.println("strcurid-->"+strcurid);

//System.out.println("hidden value  count is-->"+count);
int intyear,intmonth;
//float strconRate;
String strconRate;
String strconId="";
objCon = dbConBean.getConnection();   //Get Connection
//System.out.println("conversion rate- is-->"+request.getParameter("conversionRate13"));
for(int loop=1;loop<=count;loop++){
try {
	// strconRate=Float.parseFloat(request.getParameter("conversionRate"+loop));
	strconRate=(request.getParameter("conversionRate"+loop)=="")?"0.0":request.getParameter("conversionRate"+loop);
	 strconId=request.getParameter("conrateId"+loop);
	// System.out.println("strconRate-------1-------->"+strconRate);
	// System.out.println("strconId-----------2------>"+strconId);
	//objCstmt=objCon.prepareCall("{?=call SPG_CURRENCY(?,?,?,?,?,?,?,?)}");
	objCstmt=objCon.prepareCall("{?=call SPG_ExchangeRate(?,?,?,?,?,?)}");
				objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				//objCstmt.setInt(2,strconId);
				objCstmt.setString(2,strconId);
				objCstmt.setInt(3,Month);
				objCstmt.setInt(4,Year);
									
				//objCstmt.setFloat(5,strconRate);
				objCstmt.setString(5,strconRate);
				objCstmt.setString(6,strIPAddress);
				objCstmt.setString(7,Suser_id);    
																		
				objCstmt.execute();	// executing procedure
				objCstmt.getMoreResults();
				retval		=	objCstmt.getInt(1);// get output parameter from the procedure
									
				//intmonth=   Integer.parseInt(MST00160_FB_OB.getMonth());
				//intyear=    Integer.parseInt(MST00160_FB_OB.getYear());
				//request.setAttribute("rYear",intyear);
				//request.setAttribute("rMonth",intmonth);
	//System.out.println("retval--------->"+retval);
    if(retval==0)
    request.setAttribute("processStatus", "U");
    else
    request.setAttribute("processStatus", "Error");
    objCstmt.close();
    strMessage = dbLabelBean.getLabel("label.currency.exchangerateupdatedsuccessfully",strsesLanguage);
   // System.out.println("Month---end-->"+Month);
   // System.out.println("Year---end-->"+Year);
    
    
    //response.sendRedirect("M_exchangeRateAdd.jsp?message="+strMessage+"&strmonth="+Month+"&stryear="+Year);
    //response.sendRedirect("M_exchangeRateAdd.jsp");
     
}
catch(SQLException e){   
	System.out.println("--------------catch---------------");
	e.printStackTrace();
}
}
RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/M_exchangeRateAdd.jsp?message="+URLEncoder.encode(strMessage,"UTF-8")+"&strmonth="+Month+"&stryear="+Year+"&flag=y");
requestDispatcher.include(request,response);
dbConBean.close();       //CLOSE ALL CONNECTIONS


%>