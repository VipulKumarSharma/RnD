<%
/***************************************************

**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	  : STARS****** 
**** Operating environment :Tomcat, sql server 2000 ******
**** Description : This is post jsp file  for adding  users to whom approval page is assigned on behalf of others  ******
**** Modified By			: Manoj Chand
**** Reason of Modification : Site, access type added for special workflow change 
**** Date of Modification   : 01-05-2012
**********************************************************/
%>
<%@ include  file="importStatement.jsp" %>
<html>
<head>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%@ include  file="systemStyle.jsp" %>
<%@page import="java.net.*" pageEncoding="UTF-8"%>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>


<%
// Variables declared and initialized
Connection objCon,strCon					=		null;			    // Object for connection
Statement objStmt,strStmt					=		null;			   // Object for Statement
ResultSet objRs						=		null;			  // Object for ResultSet
CallableStatement objCstmt			=		null;			// Object for Callable Statement

//Create Connection

objCon=dbConBean.getConnection();
strCon=dbConBean1.getConnection();
String	strSqlStr	=	""; // For sql Statements
%>

<%
String strPendingWith			=""; // Object to store Division ID
//Added By Anjali on 09-04-2012
String strSite[];
String strAccessType			="";
String strShowAfterPass			="";
String strShowBeforePass		="";
String strMailForward			="";
String strSiteSt				="";
String remoteAddress="";
String strPAPValue="0";
remoteAddress=request.getRemoteAddr();
InetAddress inetAddress = InetAddress.getByName(remoteAddress); 
remoteAddress=inetAddress.toString();
remoteAddress=remoteAddress.replaceAll("/","");
//Added By Anjali end
try
{

strPendingWith				=	request.getParameter("pendingWith");	//	GET DIVISION
String strViewTo[] 					=	request.getParameterValues("viewTo");	// GET SITE
//System.out.println("hi=============="+strViewTo);
strSite=request.getParameterValues("site");
strAccessType=request.getParameter("Access")==null?"View":request.getParameter("Access");
strShowAfterPass=request.getParameter("ShowAfterPass")==null?"N":request.getParameter("ShowAfterPass");
strShowBeforePass=request.getParameter("ShowBeforePass")==null?"N":request.getParameter("ShowBeforePass");
strMailForward=request.getParameter("MailForward")==null?"N":request.getParameter("MailForward");
strPAPValue=request.getParameter("papValue")==null?"0":request.getParameter("papValue");
if(strPAPValue.equals(""))
	strPAPValue="0";
int intPendingWith=0;
int intViewTo=0;
int flagNew=0;

if(strSite!=null)
{
	for(int siteN=0;siteN<strSite.length;siteN++){
		//System.out.println("strSiteSt >"+strSite[siteN]);
		if(strSite[siteN].equals("-99"))
		{
		strSiteSt="-99";		
		break;
		}
		strSiteSt=strSite[siteN]+","+strSiteSt;
		
	}	
	if(strSiteSt.charAt(strSiteSt.length()-1)==',')
	{
		strSiteSt=strSiteSt.substring(0,strSiteSt.length()-1);
	}
}

if(strPendingWith!=null || !strPendingWith.equals(""))
{
	intPendingWith=Integer.parseInt(strPendingWith);
}


	if(strViewTo!=null){
	for(int i=0;i<strViewTo.length;i++)
	{
	String strViewTo_selected=strViewTo[i];
	if(strViewTo_selected.trim().equals("S"))
	{
	break;
	}
	int  intViewTo_selected=Integer.parseInt(strViewTo_selected);
		
		//strSqlStr	=	"SELECT * FROM Page_Access_Permission WHERE pendingWithUser="+intPendingWith+" AND viewToUser="+intViewTo_selected+" AND  STATUS=10";
		strSqlStr	=	"SELECT * FROM VW_PAGE_ACCESS_PERMISSION WHERE pendingWithUser="+intPendingWith+" AND viewToUser="+intViewTo_selected+" AND Access_Level='"+strAccessType+"'  AND  STATUS=10  ";
		if(!strSiteSt.equals("-99"))
		{		
			strSqlStr=strSqlStr+" AND SITE_ID in("+strSiteSt+") ";
		}
		//System.out.println("strSqlStr-------->"+strSqlStr);	
		objStmt		= objCon.createStatement(); 
		objRs		= objStmt.executeQuery(strSqlStr);

		if(objRs.next())
		{
			flagNew=100;
			response.sendRedirect("PageAccessPermissionList.jsp?Type=Add&Error=2");
			//response.sendRedirect("M_PageAccessDataResult.jsp?Type=Add&Error=2");
			break;
		}
		//Added By Anjali on 20-04-2012 
		strSqlStr="SELECT * FROM VW_PAGE_ACCESS_PERMISSION WHERE pendingWithUser="+intPendingWith+" AND Access_Level='full' ";
		if(!strSiteSt.equals("-99"))
		{		
			strSqlStr=strSqlStr+" AND SITE_ID in("+strSiteSt+") ";
		}
		else{
			strSqlStr=strSqlStr+" and SITE_ID=site_id ";
		}
		objStmt		= objCon.createStatement(); 
		objRs		= objStmt.executeQuery(strSqlStr);

		if(objRs.next()  && strAccessType.equalsIgnoreCase("Full"))
		{
			flagNew=100;
			//response.sendRedirect("M_PageAccessDataResult.jsp?Type=Add&Error=8");
			response.sendRedirect("PageAccessPermissionList.jsp?Type=Add&Error=8");
			break;
		}
		//Added By Anjali end
		
		
		
	}
	}
	
		

		if(strViewTo!=null & flagNew==0){
		for(int i=0;i<strViewTo.length;i++)
		{
		String strViewTo_selected=strViewTo[i];
		if(strViewTo_selected.trim().equals("S"))
		{
		break;
		}
			int  intViewTo_selected=Integer.parseInt(strViewTo_selected);
		    String S_SQL="";
			int addRow=0;
			S_SQL="Exec PROC_PAGE_ACCESS_ADD  "+intPendingWith+","+intViewTo_selected+",'"+Suser_id.trim()+"', '"+strSiteSt+"', '"+strAccessType+"' , '"+strShowBeforePass+"' , '"+strShowAfterPass+"'  , '"+strMailForward+"','"+remoteAddress+"','"+strPAPValue+"' ";
			//System.out.println("S_SQL-------->"+S_SQL);			
			strStmt = strCon.createStatement(); 
			addRow = strStmt.executeUpdate(S_SQL);
			strStmt.close();			
		}
			//response.sendRedirect("M_PageAccessDataResult.jsp?Type=Add&Error=1");
		response.sendRedirect("PageAccessPermissionList.jsp?Type=Add&Error=1");

		}


objCon.close();
}
catch(Exception e)
{
	System.out.println("exception====in M_PAGEACCESSPERMISSIONADDPOST================"+e);
}
//CLOSE ALL CONNECTIONS

%>

