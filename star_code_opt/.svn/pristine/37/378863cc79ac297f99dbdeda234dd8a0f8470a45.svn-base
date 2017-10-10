<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Shiv Sharma 	
 *Date of Creation 		:28 Aug 2008
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is for edit the  Division in M_DIVISION table of STAR Database.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :22 October 2013
 *Description			:javascript validation implemented.
*******************************************************/%>
<%-- Import Statements  --%>
<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbConnectionBean" pageEncoding="UTF-8" %>

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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<%
// Variables declared and initialized
ResultSet objRs						=	null;			  // Object for ResultSet
String		strSqlStr				=	""; // For sql Statements
String		strDivId				=    "";
String      strDivName				=    "";	
String      strDivDesc				=    ""; 
String      strDesigId="";
strDivId	 	 					=	request.getParameter("divId"); // GET Desig ID
%>
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
    var strDivName= document.frm.divName.value;
	if(strDivName=='')
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
	else
	{
	return true;
	}
	
  }


</script>

</head>

<%

	strSqlStr="SELECT div_id, DIV_NAME, DIV_DESC, DIV_ID FROM M_DIVISION WHERE   (STATUS_ID = 10) AND DIV_ID ="+strDivId;

 	objRs	 = dbConBean.executeQuery(strSqlStr);
	while(objRs.next())
	{
		strDivId        = objRs.getString("div_id");  
		strDivName	 	= objRs.getString("DIV_NAME");
		strDivDesc	   	= objRs.getString("DIV_DESC");

	}
objRs.close();
dbConBean.close();

%>
<!-- Start of body -->

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
<!-- Start of Form -->
<form method=post name=frm action="M_divPost.jsp" onSubmit="javascript:return checkData();">
<table width="70%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">

<tr align="left"> 
<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.division.divisionname",strsesLanguage)%></td>	<!-- DESIGNATION NAME -->
<td width="63%"class="formtr1"><input type="text" size=20 maxlength=50 name=divName value="<%=strDivName%>" class="textBoxCss" onKeyUp="return test1('divName', 50, 'c')"  > </td>
</tr>

<tr align="left"> 
<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.division.divisiondesc",strsesLanguage)%></td>	<!-- TO MODIFY THE DESIGNATION DESCRIPTION -->
<td width="63%" class="formtr1"><input type="text" size=30 maxlength=50 name=DivDescription value="<%=strDivDesc%>" class="textBoxCss" onKeyUp="return test1('DivDescription', 50, 'c')" > </td>
</tr>



  <tr align="center"> 
    <td class="formBottom" colspan="2">
      <input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)%>" class="formButton" >
      <input type="Reset" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%>" class="formButton" >
    </td>
  </tr>
        <input type="hidden" name="status_id" value="10" >
		<input type="hidden" name="strDivId" value="<%=strDivId%>">
		<input type="hidden" name="action" value="update">

</table>
</form>
<!-- End of Form -->
</body>
</html>
