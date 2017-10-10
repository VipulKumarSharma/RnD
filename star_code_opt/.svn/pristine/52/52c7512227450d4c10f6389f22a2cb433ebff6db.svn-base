<%
/***************************************************
**** The information contained here in is confidential and ******
**** proprietary to MIND and forms the part of the MIND ****** 
*Author			  :Deepali Dhar
*Date of Creation : 01 June 2004

**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	  : SERS ****** 
**** Operating environment :Tomcat, sql server 2000 ******
**** Description : This is first jsp file  for listing all the  USERS from the SERS database ******
**** Modification : ******
**** Reason of Modification : ******
**** Date of Modification   : ******
**** Revision History		: none******
**** Editor					:Editplus ******

*Modified By			:	Manoj Chand
*Date of Modification	:	16 Apr 2012
*Modification			:	Work in designing of Search user screen.

*Modified By			:	Manoj Chand
*Date of Modification	:	22 Oct 2013
*Modification			:	' and -- special characters validation implemented in username textbox
**********************************************************/
%>

<%@ page pageEncoding="UTF-8" %>
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
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<!--<SCRIPT language=JavaScript src="scripts/CommonValida.js?buildstamp=2_0_0"></SCRIPT>-->
<%
// Variables declared and initialized
Connection objCon,objCon_1		=		null;			    // Object for connection
Statement objStmt,objStmt_1		=		null;			   // Object for Statement
ResultSet  objRs_1			=		null;			  // Object for ResultSet
ResultSet objRs1 			=		null;	
ResultSet objRs 			=		null;	
ResultSet rs1		=		null;	
CallableStatement objCstmt		=		null;			// Object for Callable Statement

//Create Connection
//Class.forName(Sdbdriver);
//objCon=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);

String	strSqlStr	=	""; // For sql Statements
String	strDivid	=	null;	//object for storing division id
String	strDivnm	=	null;	//object for storing division name
String	strSiteid	=	null;	//object for storing site id
String	strSitenm	=	null;	//object for storing site name
String	strDeptid	=	null;	//object for storing department id
String	strDeptnm	=	null;	//object for storing department name
String	strUserid	=	null;	//object for storing user id
String	strUsernm	=	null;	//object for storing user name
String strSiteID		=null;	
String strBreak		="";
String strAfterBreak		="";
String  strDeptID		="";
int		intBreak	=	0;


String selectsite="";
selectsite=request.getParameter("selectsite");
strSiteid  = request.getParameter("unit")==null?"-1":request.getParameter("unit");
// out.println("select site are 222222222222222"+selectsite);
 	
%>
<script language=JavaScript>

  
function checkData(frm)
{  
	/*if(document.frm2.unit.value == "-1")
	{
		alert("Please select the unit");
		document.frm2.unit.focus();
		return false;
	}*/	
	 /*if(document.frm2.department.value == "-1")
	{
		alert("Please select the Department ");
		document.frm2.department.focus();
		return false;
	}	*/
	//added by manoj chand on 16 April 2012 to show alert
	if(frm.unit.value=='-1' && frm.username.value==''){
		alert('<%=dbLabelBean.getLabel("alert.master.pleaseselecttheunit",strsesLanguage)%>');
		frm.unit.focus();
		return false;
	}
    frm.flag.value="yes";
	frm.action="M_searchList.jsp";
	frm.submit();
  
 
}
function test1(obj1, length, str)
{	
		var obj;
		if(obj1=='username')
		{
			obj = document.frm2.username;
		}
	   charactercheck(obj,str);
	   spaceChecking(obj);
}

function siteChange(frm)
{
	var siteId = frm.unit.value;
	var target = frm.target;
	//alert("siteId=="+siteId);
	//alert("target===="+target);
	frm.target = "ListHeader";
	target = frm.target;
	//alert("target===="+target);
	frm.action="M_searchHead.jsp";
	frm.submit();
}
function charCheck(obj1, length, str)
{	
	//restrictChar(obj1,str);	
	spaceChecking(obj1);
}
		 
 
</script>
<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
</head>
<body class="body" style="overflow-y:hidden">
<form method="post" name="frm2" action="M_searchList.jsp"  target="ListBody"  >
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="">
  	<tr>
	  	<td height="25" class="pageHead" valign="middle">&nbsp;&nbsp;>>&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.user.searchusers",strsesLanguage)%></td>
  	</tr>
</table><!-- FORM FOR SEARCHING USERS ON THE BASIS OF SITE -->

<table width="100%" border="0" align="center" cellspacing="1" cellpadding="3"  style="border-top: 1px solid lightgray;">
    <tr>
      <td width="20%" class="formtr1">&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.user.searchusersonthebasisofunit",strsesLanguage)%></td>
      <td width="20%" class="formtr1">
	    <select name="unit" class="textBoxCss" onChange="return siteChange(this.form)">
	      <option value="-1"><%=dbLabelBean.getLabel("label.report.selectunit",strsesLanguage)%></option>
<%
		
			if(SuserRole != null && SuserRole.trim().equalsIgnoreCase("AD"))
			{
				  strSqlStr		="SELECT DISTINCT SITE_ID,SITE_NAME FROM M_SITE WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2 ";				 
			}
			if(SuserRoleOther != null && SuserRoleOther.trim().equalsIgnoreCase("LA"))
			{
				strSqlStr="SELECT  SITE_ID,DBO.SITENAME(SITE_ID) AS SITE_NAME FROM M_USERROLE  WHERE STATUS_ID=10 AND USERID="+Suser_id+" order by 1";			
		   	}
			objRs			= dbConBean.executeQuery(strSqlStr);
			while(objRs.next())
			{
				//strSiteid 	=	.trim();
				//strSitenm=	.trim();
%>
		        <option value="<%=objRs.getString("SITE_ID").trim()%>"> <%=objRs.getString("SITE_NAME")%> </option>
<%
			}
			objRs.close();
%>
		  </select>
		  <script>
		    document.frm2.unit.value="<%=strSiteid%>";
		  </script>
		</td>
		
		<td width="20%" class="formtr1">&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.user.searchusersonthebasisofdept",strsesLanguage)%></td>
      <td width="20%" class="formtr1"><select name="department" class="textBoxCss" style="width: 220px">
          <option value="-1"><%=dbLabelBean.getLabel("label.user.selectdepartment",strsesLanguage)%></option>
<%
		strSqlStr		="SELECT DISTINCT DEPT_NAME,DEPT_ID FROM M_DEPARTMENT WHERE SITE_ID="+strSiteid+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 1 ";
		objRs			= dbConBean.executeQuery(strSqlStr);
		while(objRs.next())
		{
			strDeptnm	=	objRs.getString("DEPT_NAME").trim();
			strDeptID	=	objRs.getString("DEPT_ID").trim();
%>
          <option value="<%=strDeptID%>"> <%=strDeptnm%> </option>
  <%
		}
		objRs.close();
		dbConBean.close();
		//dbConBean1.close();

%>
		</select>
			</td>
</tr>

    <tr>
			
      <td width="20%" class="formtr1">&nbsp;&nbsp;&nbsp; <%=dbLabelBean.getLabel("label.user.searchusersonthebasisofusername",strsesLanguage)%></td>
      <td width="20%" class="formtr1" height="10">
      	 <input type="text" name="username" value="" size="37" class="textBoxCss" onKeyUp="test1('username',29,'a')" onBlur="test1('username',29,'a')" >
      </td>
 		
 		<td width="20%" class="formtr1" align="center" valign="middle" colspan="2">
 			<input type="button" name="Submit" value="  <%=dbLabelBean.getLabel("button.global.search",strsesLanguage)%>  " 
 				class="formButton-green" onclick="return checkData(this.form);" style="width: 60px;font-size: 10px;margin-left: 14px;">
          	<input type="hidden" name="flag" >
      	</td>
  </tr>
    
  </table>
</form>
</body>
</html>
