<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Kaveri Garg	
 *Date of Creation 		:21 Aug	2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2008 
 *Description 			:This is for adding a new Cost Centre in M_COST_CENTRE table of STAR Database.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>

<%-- Import Statements  --%>
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8"%>
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
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
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


		function test1(obj1, length, str)
		{	
			var obj;
			if(obj1=='costCentreCode')
			{
				obj = document.frm.costCentreCode;
			}
			if(obj1=='Description')
			{
				 obj = document.frm.Description;
			}	
			charactercheck1(obj,str);
			 spaceChecking(obj);
		  }
		 
function checkData()
{
	
	var site = document.frm.sitedivId.value;
	if(site == "-1")
	{
		alert('<%=dbLabelBean.getLabel("alert.handover.pleaseselectsite",strsesLanguage) %>');
		document.frm.sitedivId.focus();
		return false;
	}	
	var strCostCentreCode= document.frm.costCentreCode.value;
	
	if(strCostCentreCode=='')
	{ 
		alert('<%=dbLabelBean.getLabel("label.costcentre.pleaseentercccode",strsesLanguage) %>');
		document.frm.costCentreCode.focus();
		return false;
	}

	var strCostCentreDesc= document.frm.Description.value;
	
	if(strCostCentreDesc=='')
	{
		alert('<%=dbLabelBean.getLabel("label.costcentre.pleaseenterccdescription",strsesLanguage) %>');
		document.frm.Description.focus();
		return false;
	}
	         
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
String strMessage = request.getParameter("strMsg") == null ?"" : request.getParameter("strMsg");
String selected = request.getParameter("selected") == null ?"" : request.getParameter("selected");
%>

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="45" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.createrequest.costcentre",strsesLanguage) %></li>&nbsp;&nbsp;<font color='red'><%=strMessage%></font>
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

<form method=post name=frm action="M_CostCentreAddPost.jsp" onsubmit="return checkData();">
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
	<OPTION VALUE="-1"><%=dbLabelBean.getLabel("label.createrequest.selectunit",strsesLanguage) %></option>
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
<script>
document.frm.sitedivId.value='<%=selected%>';
</script>

</select>
	           
	      

	<!--     <input type=textbox size=20 maxlength=50 name=sitedivId readOnly value="<%=strSiteFullName%>" class="textBoxCss"> -->
	  </td>
<%
	}
	else
	{
%>
		<td  align="left" valign="top" class="formtr1" >
		  <select name="sitedivId"  class="textBoxCss" onChange="changeInSite(this.form)">
			<OPTION VALUE="-1"><%=dbLabelBean.getLabel("label.handover.selectsite",strsesLanguage) %></option>
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
		<script>
document.frm.sitedivId.value='<%=selected%>';
</script>
		  </select>          
		</td>
<%
	}
//
%>

    </tr>

    <tr align="left">
      <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.costcentre.costcentrecode",strsesLanguage) %></td>
      <!-- TO ADD THE COST CENTRE CODE -->
      <td width="63%" class="formtr1"><input type=textbox size=20 maxlength=50 name=costCentreCode  onKeyUp="return test1('costCentreCode', 50, 'c')" value="" class="textBoxCss">      </td>
    </tr>
    <tr align="left">
      <td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.costcentre.costcentredescription",strsesLanguage) %></td>
      <!-- TO ADD THE COST CENTRE DESCRIPTION -->
      <td width="63%" class="formtr1"><input type=textbox size=30 maxlength=50 name=Description  onKeyUp="return test1('Description', 50, 'c2')" value="" class="textBoxCss">      </td>
    </tr>
    <tr align="center">
      <td class="formbottom" colspan="2">
		<input type="Submit" name="Submit" value="<%=dbLabelBean.getLabel("label.global.add",strsesLanguage) %>" class="formButton"  onclick="return checkData();">
        <input type="Reset" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage) %>" class="formButton">    
	  </td>
    </tr>
    <tr>
      <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
    </tr>
  </table>
  <input type="hidden" name="status_id" value="10" ><!--HIDDEN FIELD-->
  <input type="hidden" name="hiddenSiteId" value="<%=strSiteId%>"><!--Hidden Site Id Field-->
  <input type="hidden" name="action1" value="insert"><!--HIDDEN FIELD-->
</form>
<!-- Start of Form -->
<!-- End of Form -->
</body>
</html>
