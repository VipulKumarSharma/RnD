<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Kaveri Garg	
 *Date of Creation 		:21 Aug 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2008 
 *Description 			:This is for edit the  Cost Centre in M_COST_CENTRE table of STAR Database.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			:Manoj Chand
 *Date of Modification	:22 Oct 2013
 *Modification			:javascript validation to stop from typing --,'  symbol is added.
*******************************************************/%>
<%-- Import Statements  --%>
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8"%>

<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbConnectionBean" %>

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
String		strCostCentreCode			=	null;	// Variable for storing COST CENTRE CODE
String		strCostCentreDesc			=	null;	//Variable for storing COST CENTRE DESCRIPTION
String		strSqlStr				=	""; // For sql Statements
String		strCostCentreId				=    "";
strCostCentreId	 	 					=	request.getParameter("CostCentreId"); // GET COST CENTRE ID
String strsiteid= null;
strsiteid = request.getParameter("sitedivId");
%>
<script>
function charactercheck1(val, type) 
{
   if(type=='c')                              // c for character and no only
   {
	mikExp = /[/\$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\>\<\!\-\:\;]/;
   } else if(type=='c2')                              
   { 
		mikExp = /[\$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\'\"\?\>\<\!\-\:\;]/;
	}

   var strPass = val.value;
   var strLength = strPass.length; 
     if(strLength > 0)
   {
	   for(var i=0; i<strLength; i++)
	   {
		   var lchar = val.value.charAt(i); 
		   if(lchar.search(mikExp) != -1) 
           { 
              var tst = val.value.substring(0, i);
			  var last = val.value.substring(i+1,strLength);
              val.value = tst+last;
			  i--;
		   }

	   }
   }
}

function checkData()
{

var strCostCentreDesc= document.frm.Description.value;
	
	if(strCostCentreDesc=='')
	{
	alert('<%=dbLabelBean.getLabel("label.costcentre.pleaseenterccdescription",strsesLanguage) %>');
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
	
	 charactercheck1(obj,str);	
	 spaceChecking(obj);
  }
</script>

</head>

<%

	strSqlStr="SELECT  CC_CODE,CC_DESC,SITE_ID FROM M_COST_CENTRE WHERE STATUS_ID=10 AND CC_ID='"+strCostCentreId+"'";
	objRs	 = dbConBean.executeQuery(strSqlStr);
	while(objRs.next())
	{
		strCostCentreCode	 	= objRs.getString("CC_CODE");
		strCostCentreDesc	   	= objRs.getString("CC_DESC");
		strsiteid               = objRs.getString("SITE_ID");
	}
objRs.close();
dbConBean.close();

%>
<!-- Start of body -->

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="45" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.createrequest.costcentre",strsesLanguage) %></li>
    </ul></td>	
	<td height="45" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
<td>
     <ul id="list-nav">
           <li><a href="M_CostCentreList.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage) %></a></li>
     </ul>
       </td>
      </tr>
    </table>
	</td>
  </tr>
</table>
<!-- Start of Form -->
<form method=post name=frm action="M_CostCentreAddPost.jsp" onSubmit="javascript:return checkData();">
<table width="70%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">

<tr align="left"> 
<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.costcentre.costcentrecode",strsesLanguage) %></td>	<!-- COST CENTRE CODE -->
<td width="63%"class="formtr1"><input type=text size=20 maxlength=50 name=costCentreCode value="<%=strCostCentreCode%>" class="textBoxCss" READONLY> </td>
</tr>

<tr align="left"> 
<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.costcentre.costcentredescription",strsesLanguage) %></td>	<!-- TO MODIFY THE COST CENTRE DESCRIPTION -->
<td width="63%" class="formtr1"><input type=text size=30 maxlength=50 name=Description value="<%=strCostCentreDesc%>" class="textBoxCss" onkeyup="return test1('Description',50,'c2');"> </td>
</tr>



  <tr align="center"> 
    <td class="formBottom" colspan="2">
      <input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage) %>" class="formButton" >
      <input type="Reset" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage) %>" class="formButton" >
    </td>
  </tr>
        <input type="hidden" name="status_id" value="10" >
        <input type="hidden" name="sitedivId" value="<%=strsiteid%>" >
		<input type="hidden" name="action1" value="update"><!--HIDDEN FIELD-->

</table>
</form>
<!-- End of Form -->
</body>
</html>
