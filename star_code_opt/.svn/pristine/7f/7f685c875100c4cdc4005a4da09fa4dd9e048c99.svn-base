<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta	
 *Date of Creation 		:28 Nov	2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is for edit the  Designation in M_DESIGNATION table of STAR Database.
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
String		strDesigName			=	null;	// Variable for storing site name
String		strDesigDesc			=	null;	//Variable for storing site description
String		strSqlStr				=	""; // For sql Statements
String		strDesigId				=    "";
strDesigId	 	 					=	request.getParameter("desigId"); // GET Desig ID

%>
<script>

function checkData()
{

var strDesc= document.frm.Description.value;
	
	if(strDesc=='')
	{
	alert('<%=dbLabelBean.getLabel("alert.designation.pleaseenterdesigntiondesc",strsesLanguage)%>');
	document.frm.Description.focus();
	return false;
	}


	else
	{
	return true;
	}
	
  }

//function created by manoj chand on 22 oct 2013
function test1(obj1, length, str)
{	
	var obj;
	if(obj1=='Description')
	{
		 obj = document.frm.Description;
	}
	 charactercheck(obj,str);	
	 spaceChecking(obj);
  }
</script>

</head>

<%

	strSqlStr="SELECT  DESIG_NAME,DESIG_DESC FROM M_DESIGNATION WHERE STATUS_ID=10 AND DESIG_ID='"+strDesigId+"'";
	objRs	 = dbConBean.executeQuery(strSqlStr);
	while(objRs.next())
	{
		strDesigName	 	= objRs.getString("DESIG_NAME");
		strDesigDesc	   	= objRs.getString("DESIG_DESC");

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
      <li class="pageHead"><%=dbLabelBean.getLabel("label.designation.designation",strsesLanguage)%></li>
    </ul></td>	
	<td width="23%" height="38" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>   
		<ul id="list-nav">
			<li><a href="M_desigList.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage)%></a></li>
		</ul>
      </td>  
      </tr>
    </table>
	</td>
  </tr>
</table>
<!-- Start of Form -->
<form method=post name=frm action="M_desigEditPost.jsp" onSubmit="javascript:return checkData();">
<table width="70%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">

<tr align="left"> 
<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.mail.designationname",strsesLanguage)%></td>	<!-- DESIGNATION NAME -->
<td width="63%"class="formtr1"><input type="text" size=20 maxlength=50 name=Sitename value="<%=strDesigName%>" class="textBoxCss" READONLY> </td>
</tr>

<tr align="left"> 
<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.designation.designationdesc",strsesLanguage)%></td>	<!-- TO MODIFY THE DESIGNATION DESCRIPTION -->
<td width="63%" class="formtr1"><input type="text" size=30 maxlength=50 name=Description value="<%=strDesigDesc%>" class="textBoxCss" onkeyup="return test1('Description',30,'c');"> </td>
</tr>



  <tr align="center"> 
    <td class="formBottom" colspan="2">
      <input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)%>" class="formButton" >
      <input type="Reset" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%>"class="formButton" >
    </td>
  </tr>
        <input type="hidden" name="status_id" value="10" >
		<input type="hidden" name="strDesigId" value="<%=strDesigId%>">

</table>
</form>
<!-- End of Form -->
</body>
</html>
