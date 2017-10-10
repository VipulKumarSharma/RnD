<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta	
 *Date of Creation 		:28 Nov	2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is for adding a new Designation in M_DESIGNATION table of STAR Database.
 *Modification 			: Selection of site in case of LA who has multiple access of site ,  
 *Reason of Modification: 
 *Date of Modification  : 18 april '07  by shiv 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :22 October 2013
 *Description			:javascript validation implemented.
*******************************************************/%>

<%@ page pageEncoding="UTF-8" %>
<%-- Import Statements  --%>
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
<!--Create Conneciton by useBean-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script>
//charactercheck calling added by manoj chand on 22 oct 2013
		function test1(obj1, length, str)
		{	
			var obj;
			if(obj1=='desigName')
			{
				obj = document.frm.desigName;
			}
			if(obj1=='Description')
			{
				 obj = document.frm.Description;
			}
			 charactercheck(obj,str);	
			 spaceChecking(obj);
		  }
		 



function checkData()
{

	 
	var site = document.frm.sitedivId.value;
	if(site == "-1")
	{
		alert('<%=dbLabelBean.getLabel("alert.master.pleaseselecttheunit",strsesLanguage)%>');
		document.frm.sitedivId.focus();
		return false;
	}	
	var strDesig= document.frm.desigName.value;
	
	if(strDesig=='')
	{ 
		alert('<%=dbLabelBean.getLabel("alert.designation.pleaseenterdesigntionname",strsesLanguage)%>');
		document.frm.desigName.focus();
		return false;
	}

	var strDesc= document.frm.Description.value;
	
	if(strDesc=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.designation.pleaseenterdesigntiondesc",strsesLanguage)%>');
		document.frm.Description.focus();
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

</script>
</head>
<!-- Start of body -->

<%
String sSqlStr			= "";
String strSiteId		= "";
String strDivisionName  = "";
String strSiteName		= "";
String strDivId			= "";
ResultSet rs			=  null;
%>

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.designation.designation",strsesLanguage)%></li>
    </ul></td>	
	<td width="23%" height="38" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
      <ul id="list-nav">
		<li><a href="M_desigList.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage) %></a></li>
	</ul>
      </td>
               
      </tr>
    </table>
	</td>
  </tr>
</table>

<form method=post name=frm action="M_desigAddPost.jsp" onSubmit="return checkData();">
  <table width="70%" align="center" cellspacing="1" cellpadding="5">
    <tr align="left">
      <td colspan="2" class="formbottom">&nbsp;</td>
    </tr>

	<tr align="left">
	  <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage) %></td>
<%
//New Check for local administrator
	if((SuserRoleOther.trim().equals("LA")))
	{
%>     
      <td width="63%" class="formtr1">
<!--     new code added on 18 april open-->
	<select name="sitedivId"  class="textBoxCss">
	<OPTION VALUE="-1"><%=dbLabelBean.getLabel("label.createrequest.selectunit",strsesLanguage)%></option>
	<%
	sSqlStr="SELECT  DISTINCT SITE_ID,DBO.SITENAME(SITE_ID) FROM M_USERROLE WHERE userid="+Suser_id+" and STATUS_ID=10 ORDER BY 2 ";
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

	           
	      

	<!--     <input type=textbox size=20 maxlength=50 name=sitedivId readOnly value="<%=strSiteFullName%>" class="textBoxCss"> -->
	  </td>
<%
	}
	else
	{
%>
		<td  align="left" valign="top" class="formtr1" >
		  <select name="sitedivId"  class="textBoxCss" onChange="changeInSite(this.form)">
			<OPTION VALUE="-1"><%=dbLabelBean.getLabel("label.department.selectdivisionandunit",strsesLanguage)%></option>
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
		</td>
<%
	}
//
%>

    </tr>

    <tr align="left">
      <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.mail.designationname",strsesLanguage) %></td>
      <!-- TO ADD THE DESIGNATION NAME -->
      <td width="63%" class="formtr1"><input type="text" size=20 maxlength=50 name=desigName  onKeyUp="return test1('desigName', 50, 'c')" value="" class="textBoxCss">      </td>
    </tr>
    <tr align="left">
      <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.designation.designationdesc",strsesLanguage)%></td>
      <!-- TO ADD THE DESIGNATION DESCRIPTION -->
      <td width="63%" class="formtr1"><input type="text" size=30 maxlength=50 name=Description  onKeyUp="return test1('Description', 50, 'c')" value="" class="textBoxCss">      </td>
    </tr>
    <tr align="center">
      <td class="formbottom" colspan="2">
		<input type="Submit" name="Submit" value="<%=dbLabelBean.getLabel("label.global.add",strsesLanguage)%>" class="formButton"  onclick="return checkData();">
        <input type="Reset" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%>" class="formButton">    
	  </td>
    </tr>
    <tr>
      <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
    </tr>
  </table>
  <input type="hidden" name="status_id" value="10" ><!--HIDDEN FIELD-->
  <input type="hidden" name="hiddenSiteId" value="<%=strSiteIdSS%>"/><!--Hidden Site Id Field-->
</form>
<!-- Start of Form -->
<!-- End of Form -->
</body>
</html>
