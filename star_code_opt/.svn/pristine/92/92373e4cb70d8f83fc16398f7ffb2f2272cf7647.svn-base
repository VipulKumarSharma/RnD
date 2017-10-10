<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain	
 *Date of Creation 		:28 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for adding new DEPARTMENT in M_DEPARTMENT table of STAR database 
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 09 July 2012
 *Modification			: to resolve connection error coming in jtds connection.
 *******************************************************/
%>

<%@page import="java.net.URLEncoder"%><html>
<head>
<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbUtilityMethods" pageEncoding="UTF-8" %>
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
 DbUtilityMethods utilitymethod = new DbUtilityMethods(); 
// Variables declared and initialized
int index						= 0 ;
Connection con					=		null;			    // Object for connection
ResultSet objRs					=		null;			  // Object for ResultSet
CallableStatement cstmt			=		null;			// Object for Callable Statement
String strMessage               =       ""; 
String	sSqlStr=""; // For sql Statements
String	strDeptName			=	request.getParameter("departmentname");
String  strsitedivId		=	request.getParameter("hiddenSiteId");    //HIDDEN FIELD VALUE
String strDivId				=   request.getParameter("strDivId");
String strDeptDesc			=   request.getParameter("departmentDescr");

//System.out.println("deptid========="+deptid);
String strSqlStr			=   "";
String Record_type			=	"I"; 
String U_DATE  				=	""; //object to store U_date
String sitedivId					="";
sitedivId= request.getParameter("sitedivId");
//System.out.println("new select site id ---------------sitedivId--------"+sitedivId);

strMessage = request.getParameter("message") == null ?"" : request.getParameter("message");

con = dbConBean.getConnection();           //Get Connection
//this statement added by manoj chand on 09 july 2012 to resolve connection error coming in jtds connection.
con.setAutoCommit(false);
 ////Query changed by shiv on 20/04/2007

strSqlStr	=	"SELECT DIV_ID FROM M_DEPARTMENT WHERE DEPT_NAME=N'"+strDeptName+"' AND SITE_ID='"+sitedivId+"' AND  STATUS_ID=10 AND APPLICATION_ID=1";
objRs		= dbConBean.executeQuery(strSqlStr);
if(objRs.next())
{
	//response.sendRedirect("M_departmentAddDept.jsp?message="+strMessage);
	response.sendRedirect("m_deptDataResult.jsp?Type=Add&Error=2");
}
else
{
	try 
	{
		//int deptid					=   utilitymethod.getNewId("M_DEPARTMENT");
		int deptid					=   utilitymethod.getNewGeneratedId("DEPT_ID");
		
		if(deptid == 0)
		{
			strMessage = dbLabelBean.getLabel("label.department.departmentwasnotcreated",strsesLanguage);
			response.sendRedirect("M_departmentList.jsp?flag=true&message="+URLEncoder.encode(strMessage,"UTF-8"));
		}
		else
		{
			cstmt=con.prepareCall("{?=call PROC_ADDDEPARTMENT(?,?,?,?,?,?,?)}");
			cstmt.registerOutParameter(++index,java.sql.Types.INTEGER);
			cstmt.setString(++index, strDeptName.trim());
			cstmt.setString(++index, strDeptDesc.trim());
			cstmt.setString(++index, Suser_id);
			cstmt.setString(++index, sitedivId);//added by shiv on  19 th April  
			//cstmt.setString(++index, strsitedivId);
			cstmt.setInt(++index,deptid);
			cstmt.setString(++index,Record_type);
			cstmt.setString(++index,U_DATE);
			cstmt.execute();
			cstmt.close();
			con.commit();
			strMessage = dbLabelBean.getLabel("label.department.departmentcreatedsuccessfully",strsesLanguage);
			response.sendRedirect("M_departmentList.jsp?flag=true&message="+URLEncoder.encode(strMessage,"UTF-8"));
		}
	}
	catch(Exception e)
	{
		strMessage = dbLabelBean.getLabel("label.department.departmentwasnotcreated",strsesLanguage);
		System.out.println("Error occured at M_departmentAddPost.jsp"+ e);
		con.rollback();
		response.sendRedirect("M_departmentList.jsp?flag=false&message="+URLEncoder.encode(strMessage,"UTF-8"));	
	}
	finally
	{
		con.close();
	}
}

dbConBean.close();        //Close All Connection
%>

