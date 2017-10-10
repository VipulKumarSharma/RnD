<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain	
 *Date of Creation 		:28 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for add new DEPARTMENT in M_DEPARTMENT table of STAR database 
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :22 October 2013
 *Description			:javascript validation implemented.
 *******************************************************/
%>
<html>
<head>
<%@ page pageEncoding="UTF-8" %>
<%-- include remove cache  --%>
<%@ include  file="importStatement.jsp" %>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
// Variables declared and initialized
Connection con		=		null;			    // Object for connection
ResultSet rs		=		null;			  // Object for ResultSet
String	sSqlStr=""; // For sql Statements
String strSiteId		=	"";
String strSiteName		=	"";
String strDivisionName	=	"";
String strDivId			=	"";
String strMessage = request.getParameter("message") == null ?"" : request.getParameter("message");


%>
<script language=JavaScript >

function validateMyForm()
{
	if(document.frm.sitedivId.value=='-1') 
	{
		alert('<%=dbLabelBean.getLabel("alert.master.pleaseselecttheunit",strsesLanguage)%>');
		document.frm.sitedivId.focus();
		return false;
	}
    if(document.frm.departmentname.value==0)
	{
		alert('<%=dbLabelBean.getLabel("alert.unit.pleaseenterthedepartmentname",strsesLanguage)%>');
		document.frm.departmentname.focus();
		return false;
	}
	if(document.frm.departmentDescr.value==0)
	{
		alert('<%=dbLabelBean.getLabel("alert.department.pleaseenterdepartmentdescription",strsesLanguage)%>');
		document.frm.departmentDescr.focus();
		return false;
	}
	//document.frm.submit();
	return true;	
}

function changeInSite(f1)
{
  f1.hiddenSiteId.value = f1.sitedivId.value;
  //alert(f1.hiddenSiteId.value);  
}

//function added by manoj chand on 22 oct 2013 to implement javascript validation
function test1(obj1, length, str)
{	
	
			var obj;
			if(obj1=='departmentname')
			{
				obj = document.frm.departmentname;
				upToTwoHyphen(obj);
			}
			charactercheck(obj,str);
			limitlength(obj, length);
			spaceChecking(obj);
}
</script>
<base target="middle">
</head>

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.unit.department",strsesLanguage)%></li><font color='red'><%=strMessage%></font>
    </ul></td>	
	<td width="23%" height="38" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
        <td>
        <ul id="list-nav">
        <li><a href="M_departmentList.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage)%></a></li>
        </ul>
        </td>       
      </tr>
    </table>
	</td>
  </tr>
</table>

<%
	
%>
<!--<form method=post name=frm action="M_departmentAddPost.jsp?strDivId="<%=strDivId%> onSubmit="javascript:return checkData();">-->
<form method=post name=frm action="M_departmentAddPost.jsp?strDivId="<%=strDivId%> onSubmit="return validateMyForm();">
  <table width="70%" align="center" cellspacing="1" cellpadding="5">
    <tr align="left">
	  <td colspan="2" class="formbottom">&nbsp;</td>
	</tr>
	<tr align="left"> 
	  <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>

<%
//New Check for local administrator
	if((SuserRoleOther.trim().equals("LA"))) //Chang done by shiv on 18th April  Open
	{
%>     
      <td width="63%" class="formtr1">
		<select name="sitedivId"  class="textBoxCss" style="width:50%;">
			<OPTION VALUE="-1"><%=dbLabelBean.getLabel("label.createrequest.selectunit",strsesLanguage)%></option>
	<%
	sSqlStr="SELECT SITE_ID,DBO.SITENAME(SITE_ID) FROM M_USERROLE WHERE userid="+Suser_id+" and STATUS_ID=10 ORDER BY 2 ";
	rs = dbConBean.executeQuery(sSqlStr);
	while(rs.next())
	{
	%>
       		<OPTION VALUE="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
	<%
	}
rs.close();
 //Chang done by shiv on 18th April  closed
	%>

	 	</select>

	   <!--  <input type=textbox size=20 maxlength=50 name=sitedivId readOnly value="<%=strSiteFullName%>" class="textBoxCss"> -->
	 </td>
<%
	}
	else
	{
%>
	  <td  align="left" valign="top" class="formtr1" >
		<select name="sitedivId"  class="textBoxCss" style="width:50%;" onChange="changeInSite(this.form)">
	  	  <OPTION VALUE="-1"><%=dbLabelBean.getLabel("label.department.selectdivisionandunit",strsesLanguage)%></option>
<%
			sSqlStr="SELECT   SITE_ID,dbo.DIVISIONNAME(DIV_ID),ISNULL(SITE_NAME,'-'), DIV_ID FROM M_SITE WHERE STATUS_ID=10 ORDER BY 2,3";
			rs = dbConBean.executeQuery(sSqlStr);
			while(rs.next())
			{
				strSiteId		=	rs.getString(1);
				strDivisionName	=	rs.getString(2);
				strSiteName		=	rs.getString(3);
				strDivId		=	rs.getString(4);
%>
			<OPTION VALUE="<%=strSiteId%>"><%=strDivisionName%> / <%=strSiteName%></option>
<%
			}
			rs.close();	
%>
		</select>
	  </td>
<%
	}
%>
    </tr>
	<tr align="left"> 
	  <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.requestdetails.department",strsesLanguage)%></td>
	  <td width="63%" class="formtr1"><input type="text" size=48 maxlength=50  name=departmentname class="textBoxCss" onkeyup="return test1('departmentname',100,'all')"></td>
	</tr>
	<tr align="left"> 
	  <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.department.departmentdescription",strsesLanguage)%></td>
	  <td width="63%" class="formtr1"><input type="text" size=48 maxlength=150  name=departmentDescr class="textBoxCss" onkeyup="return test1('departmentname',100,'all')"></td>
	</tr>
	<tr align="center"> 
	  <td class="formbottom" colspan="2">

<!--		<input type="button" name="Submit" value="Add " class="formButton" onSubmit="return validateMyForm();">-->
		<input type="Submit" name="Submit" value=" <%=dbLabelBean.getLabel("label.global.add",strsesLanguage)%> " class="formButton" onClick="return validateMyForm();">
		<input type="Reset" name="Submit2" value=" <%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%> " class="formButton">			
	  </td>
	</tr>
	<tr>
		<td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
	</tr>
  </table>
  <input type="hidden" name="hiddenSiteId" value="<%=strSiteIdSS%>"/><!--Hidden Site Id Field-->
</form>
<% dbConBean.close();  //Close Connection %>
</body>
</html>
