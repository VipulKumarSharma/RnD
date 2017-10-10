<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Manoj Chand
*Date			:   08/02/2011
*Description	:	Edit Currency by updating database
*Project		:	STARS

*Modified By	: Manoj Chand
*Date of Modification:	23 jan 2013
*Modification		: resolve issue of gettig basflag of all curreny='N' when any currency name of desc updated.
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
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>

<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection objCon = null;			    // Object for connection
CallableStatement objCstmt = null;		// Object for Callable Statement
ResultSet rs;
Statement st=null;
String strSql="";

String	strSqlStr	    =""; // For sql Statements
String strDesc			=""; //object to store Description
String strStatusId		=""; //object to store Statusid	
String strCurName		="";
String strMessage		="";
String strBaseCurrency	="";
String strCurrSymbol	="";
String strCurrCode		="";
int CurId; //object to store designation id
String Record_type="U";
String strIPAddress=request.getRemoteAddr();
int basecurId=Integer.parseInt(request.getParameter("basecurrencyid"));

strBaseCurrency				=	request.getParameter("baseCurflag");
strDesc	 					=	request.getParameter("Description");	// GET DESCRIPTION
strCurName					=	request.getParameter("Currencyname");
strStatusId					=	request.getParameter("status_id");		// GET STATUS
CurId	 	 			    =	Integer.parseInt(request.getParameter("strCurrencyId"));		// GET DESIGNATION ID

strCurrSymbol				=	request.getParameter("currSymbol");
strCurrCode					=	request.getParameter("currCode");

objCon = dbConBean.getConnection();   //Get Connection
String currencyYesFlag="";
String currencyname="";
String currencydesc="";
//String currencyid="";
String curSymbol="";
String curCode="";

try {
	   st=objCon.createStatement();
	   //strSql="select cur_id from m_currency where base_cur_flag='Y' AND STATUS_ID=10";
	   strSql="select currency,cur_desc,base_cur_flag,CUR_SYMBOL,CUR_CODE from m_currency where status_id=10 and cur_id="+basecurId;
	   rs=st.executeQuery(strSql);
	   if(rs.next())
			{
			currencyYesFlag	= rs.getString("base_cur_flag");
			currencyname	= rs.getString("currency");
			currencydesc	= rs.getString("cur_desc");
			curSymbol		= rs.getString("CUR_SYMBOL");
			curCode			= rs.getString("CUR_CODE");
			 // currencyid=rs.getString("cur_id");
			}
    }
    catch (SQLException e1) {
			e1.printStackTrace();
    }


	//System.out.println("---------------------------->>>>"+currencyYesFlag);
//System.out.println("---------------------------->>>>"+currencyid);



//ADDED BY MANOJ CHAND ON 23 JAN 2013 strBaseCurrency.equals("Y")
if(currencyYesFlag.equals("Y") && basecurId!=0 && strBaseCurrency.equals("Y")){
	try {
		//objCstmt=objCon.prepareCall("{?=call SPG_CURRENCY(?,?,?,?,?,?,?,?)}");
		objCstmt=objCon.prepareCall("{?=call SPG_CURRENCY(?,?,?,?,?,?,?,?,?,?)}");
		objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		objCstmt.setInt(2,basecurId);
		//objCstmt.setString(2,strCurId);
		objCstmt.setString(3, currencyname );
		objCstmt.setString(4, currencydesc);
		objCstmt.setString(5, "N");
		objCstmt.setString(6, curSymbol);
		objCstmt.setString(7, curCode);
		objCstmt.setString(8, strIPAddress);
		objCstmt.setString(9, Suser_id);  
		objCstmt.setString(10, "UPDATE");
		objCstmt.registerOutParameter(11,java.sql.Types.INTEGER);
		objCstmt.execute();
		int retval		=	objCstmt.getInt(1);// get output parameter from the procedure
		//System.out.println("retval--------->"+retval);
	    if(retval==0)
	    request.setAttribute("processStatus", "U");
	    else
	    request.setAttribute("processStatus", "Error");
	     }
	catch (SQLException e){   
		e.printStackTrace();
	}
}





try {
	//objCstmt=objCon.prepareCall("{?=call SPG_CURRENCY(?,?,?,?,?,?,?,?)}");
	objCstmt=objCon.prepareCall("{?=call SPG_CURRENCY(?,?,?,?,?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setInt(2,CurId);
	//objCstmt.setString(2,strCurId);
	objCstmt.setString(3, strCurName);
	objCstmt.setString(4, strDesc);
	objCstmt.setString(5, strBaseCurrency);
	objCstmt.setString(6, strCurrSymbol);
	objCstmt.setString(7, strCurrCode);
	objCstmt.setString(8, strIPAddress);
	objCstmt.setString(9, Suser_id);  
	objCstmt.setString(10, "UPDATE");
	objCstmt.registerOutParameter(11,java.sql.Types.INTEGER);
	objCstmt.execute();
	int retval		=	objCstmt.getInt(1);// get output parameter from the procedure
		//System.out.println("retval--------->"+retval);
    if(retval==0)
    request.setAttribute("processStatus", "U");
    else
    request.setAttribute("processStatus", "Error");
    objCstmt.close();
    strMessage = dbLabelBean.getLabel("message.currency.currencyupdatedsuccessfully",strsesLanguage);
    response.sendRedirect("M_currencyList.jsp?message="+URLEncoder.encode(strMessage,"UTF-8"));
     }
catch (SQLException e){   
	e.printStackTrace();
}
dbConBean.close();       //CLOSE ALL CONNECTIONS


%>
