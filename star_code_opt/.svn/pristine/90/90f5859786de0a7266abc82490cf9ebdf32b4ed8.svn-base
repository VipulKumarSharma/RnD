<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Shiv Sharma 
 *Date of Creation 		:28 Aug	2008
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is for adding a new Division in M_DIVSION table of STAR Database.
 *Modification 			:
 *Reason of Modification: 
 *Date of Modification  :
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
		if(obj1=='divName')
		{
			obj = document.frm.divName;
		}
		if(obj1=='DivDescription')
		{
			 obj = document.frm.DivDescription;
		}	
		 charactercheck(obj,str);
		 spaceChecking(obj);
	  }

 function checkData()
     {
    	var strDesig= document.frm.divName.value;
	
	     if(strDesig=='')
	        { 
				alert('<%=dbLabelBean.getLabel("alert.division.divisionname",strsesLanguage)%>');
				document.frm.divName.focus();
				return false;
	        }

	var strDesc= document.frm.DivDescription.value;
	
	if(strDesc=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.division.divisiondesc",strsesLanguage)%>');
		document.frm.DivDescription.focus();
		return false;
	}
	return true;

}

 

</script>
</head>
<!-- Start of body -->

<%
String sSqlStr			= "";
String strDivisionName  = "";
String strDivId			= "";
ResultSet rs			=  null;
%>

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.division.division",strsesLanguage)%></li>
    </ul></td>	
	<td width="23%" height="38" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
     	 <ul id="list-nav">
			<li><a href="M_division.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage)%></a></li>
		</ul>
      </td>
               
      </tr>
    </table>
	</td>
  </tr>
</table>

<form method=post name=frm action="M_divPost.jsp" onSubmit="return checkData();">
  <table width="70%" align="center" cellspacing="1" cellpadding="5">
    <tr align="left">
      <td colspan="2" class="formbottom">&nbsp;</td>
     <tr align="left">
      <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.division.divisionname",strsesLanguage) %></td>
      <!-- TO ADD THE DESIGNATION NAME -->
      <td width="63%" class="formtr1"><input type="text" size=20 maxlength=50 name=divName  onKeyUp="return test1('divName', 50, 'c')" value="" class="textBoxCss">      </td>
    </tr>
    <tr align="left">
      <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.division.divisiondesc",strsesLanguage) %></td>
      <!-- TO ADD THE DESIGNATION DESCRIPTION -->
      <td width="63%" class="formtr1"><input type="text" size=30 maxlength=50 name=DivDescription  onKeyUp="return test1('DivDescription', 50, 'c')" value="" class="textBoxCss">      </td>
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
  <input type="hidden" name="strDivId" value="new"><!--HIDDEN FIELD-->
  <input type="hidden" name="action" value="INSERT"><!--HIDDEN FIELD-->
 </form>
<!-- Start of Form -->
<!-- End of Form -->
</body>
</html>
