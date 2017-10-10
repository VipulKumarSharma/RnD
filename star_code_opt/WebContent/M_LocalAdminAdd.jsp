<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:23 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp file  for add a new local admin for a site by super admin
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>


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
<%-- <%@ include  file="systemStyle.jsp" %> --%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />


<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
// Variables declared and initialized
ResultSet rs			=		null;			  // Object for ResultSet

String	sSqlStr         =       "";                         // For sql Statements
String  strMessage      =       ""; 
int iCls                =       0;
String strStyleCls      =       "";
String strSiteId        = "";
String strDivisionName  = "";
String strSiteName      = "";
String strDivId         = ""; 
String strUserId		= "";	
String strUserName      = "";
String strSiteIdForUser = "";

strSiteIdForUser        = request.getParameter("sitedivId")==null ?"-1" :request.getParameter("sitedivId");
strMessage              = request.getParameter("message")==null ?"" :request.getParameter("message");
strUserId              = request.getParameter("userId")==null ?"-1" :request.getParameter("userId");
%>

<!--Java Script-->
<script language=JavaScript >
function checkData()
{
	var site = document.frm.sitedivId.value;
	if(site == "-1")
	{
		alert("Please select the unit");
		document.frm.sitedivId.focus();
		return false;
	}	
	var userId= document.frm.userId.value;
	if(userId=='-1')
	{
		alert("Please select the user name");
		document.frm.userId.focus();
		return false;
	}

	var strRole= document.frm.roleId.value;	
	if(strRole=='')
	{
		alert("Please enter Role Id");
		document.frm.roleId.focus();
		return false;
	}
	
	return true;
	
}
function deleteConfirm()
{

if(confirm('Are you sure you want to delete the record !'))
	return true;
else
	return false;
}

 
function MM_openBrWindow(theURL,winName,features) 
{ 
window.open(theURL,winName,features);
}

function changeInSite(f1)
{
  f1.action = "M_LocalAdminAdd.jsp";
  f1.submit();
  //alert(f1.hiddenSiteId.value);  
}

</script>
<base target="middle"> 
</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="70%" height="45" class="bodyline-top">
	    <ul class="pagebullet"><li class="pageHead">ADD STARS Local Admin(s) <font color='red'><%=strMessage%></font></li>
	    </ul>
	  </td>
      <td width="30%" align="right" valign="bottom" class="bodyline-top">
   	    <table width="43%" align="right" border="0" cellspacing="0" cellpadding="0">
          <tr align="right">
			<td width="100%" align="right"><a href="M_localAdminUserList.jsp"><img src="images/IconList.gif?buildstamp=2_0_0" width="57" height="24" border="0" /></a></td>               	
          </tr>
        </table>
	  </td> 
    </tr>
  </table>

  <br>
  <form method=post name=frm action="M_LocalAdminAdd_Post.jsp" >
  <table width="70%" align="center" cellspacing="1" cellpadding="5">
    <tr align="left">
      <td colspan="2" class="formbottom">&nbsp;</td>
    </tr>

	<tr align="left">
	  <td class="formtr2" width="37%">Unit Name</td>
<%
//New Check for local administrator
	if((SuserRoleOther.trim().equals("LA")) )
	{
%>     
      <td width="63%" class="formtr1">
	    <input type=textbox size=20 maxlength=50 name=sitedivId readOnly value="<%=strSiteFullName%>" class="textBoxCss">
	  </td>
<%
	}
	else
	{
%>
		<td  align="left" valign="top" class="formtr1" >
		  <select name="sitedivId"  class="textBoxCss" onChange="changeInSite(this.form)">
			<OPTION VALUE="-1">Select Division / Unit</option>
		<%	
			
			//sSqlStr="SELECT SITE_ID,ISNULL(SITE_NAME,'-') FROM SITE ORDER BY 2";
			sSqlStr="SELECT SITE_ID,dbo.DIVISIONNAME(DIV_ID),ISNULL(SITE_NAME,'-'), DIV_ID FROM M_SITE WHERE STATUS_ID=10 ORDER BY 2,3";
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
		  <script>
			document.frm.sitedivId.value="<%=strSiteIdForUser%>";
		  </script>	
		</td>
<%
	}
//
%>
    </tr>
	<tr align="left">	  
	  <td class="formtr2" width="37%">User Name</td>
      <!-- TO ADD THE DESIGNATION NAME -->
      <td width="63%" class="formtr1">
	    <select name="userId">
		  <option value="-1">Select User Name</option>
		  <%	
			
			//sSqlStr="SELECT SITE_ID,ISNULL(SITE_NAME,'-') FROM SITE ORDER BY 2";
			sSqlStr="SELECT USERID,RTRIM(DBO.USER_NAME(USERID)) AS UNAME FROM M_USERINFO WHERE SITE_ID="+strSiteIdForUser+" AND STATUS_ID=10 ORDER BY 2";
			rs = dbConBean.executeQuery(sSqlStr);
			while(rs.next())
			{				
%>
			  <OPTION VALUE="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%
			}
			rs.close();			
%>
		</select>
		<script>
			document.frm.userId.value="<%=strUserId%>";
		</script>	
	  </td>
	</tr>

    <tr align="left">
      <td class="formtr2" width="37%">Role Id</td>
      <!-- TO ADD THE ROLE ID -->
      <td width="63%" class="formtr1"><input type=textbox size=20 maxlength=10 name=roleId  value="LA" readOnly class="textBoxCss"/></td>
    </tr>
    <tr align="center">
      <td class="formbottom" colspan="2">
		<input type="submit" name="Submit" value="Add" class="formButton" onClick="javascript:return checkData();">
        <input type="Reset" name="Submit2" value="Reset " class="formButton">    
	  </td>
    </tr>
    <tr>
      <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
    </tr>
  </table>
</form>

</body>
</html>
