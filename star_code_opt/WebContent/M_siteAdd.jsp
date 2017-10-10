<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:28 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is for adding a new SITE in M_SITE table of STAR Database.
 *Modification 			: 1.function to check for & ' " ; in site name  added by shiv on  9/25/2007
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By 			:Manoj Chand
 *Modification Date		:17 Dec 2012
 *Modification			:web service url textbox and site currency combo box added.
 
 *Modified By 			:Manoj Chand
 *Modification Date		:06 Mar 2013
 *Modification			:add company combobox and remove web service url textbox.
 
 *Modified By 			:Manoj Chand
 *Modification Date		:29 Apr 2013
 *Modification			:add tes request thresold count.
 
 *Modified By 			:Manoj Chand
 *Modification Date		:29 May 2013
 *Modification			:add two field REMINDER INTERVAL & REMINDER FREQUENCY
 
 *Modified By 			:Manoj Chand
 *Modification Date		:11 July 2013
 *Modification			:TES related caption changed
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :22 October 2013
 *Description			:uptotwohyphen function is added.
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

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<script language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<%
// Variables declared and initialized



Connection objCon		=		null;			    // Object for connection
Statement objStmt		=		null;			   // Object for Statement
ResultSet objRs			=		null;			  // Object for ResultSet
CallableStatement objCstmt		=		null;			// Object for Callable Statement

String		strDivId			=	null;	//	Variable for storing division id
String		strDivName			=	null;	// Variable for storing division name




//Create Connection
String	strSqlStr	=	""; // For sql Statements
%>
<script>
// function to check for & ' " ; in site name  added by shiv on  9/25/2007 
//upToTwoHyphen function is added by manoj chand on 22 oct 2013
function test1(obj1, length, str)
{	
	var obj;
	if(obj1=='Sitename')
	{
		obj = document.frm.Sitename;
		upToTwoHyphen(obj);
	}
	if(obj1=='Description')
	{
		obj = document.frm.Description;
		upToTwoHyphen(obj);
	}
	charactercheck(obj,str);
	zeroChecking(obj);
}

function checkData()
{

var strDiv= document.frm.Division.value;
	
	if(strDiv=='S')
	{
	alert('<%=dbLabelBean.getLabel("alert.mylinks.selectdivision",strsesLanguage)%>');
	document.frm.Division.focus();
	return false;
	}

	var strAgencyid = document.frm.agencyId.value;
	
	if(strAgencyid == '-1')
	{
	alert('Select Travel Site Agency');
	document.frm.agencyId.focus();
	return false;
	}

var strSite= document.frm.Sitename.value;
	
	if(strSite=='')
	{
	alert('<%=dbLabelBean.getLabel("alert.unit.pleaseenterunitname",strsesLanguage)%>');
	document.frm.Sitename.focus();
	return false;
	}

var strDesc= document.frm.Description.value;
	
	if(strDesc=='')
	{
	alert('<%=dbLabelBean.getLabel("alert.unit.pleaseenterunitdesc",strsesLanguage)%>');
	document.frm.Description.focus();
	return false;
	}


	else
	{
	return true;
	}
	
  }

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
};

//function added by manoj chand on 29 april 2013 to make integer check on tesreqcount textbox
function test2(obj1, length, str)
{	
			var obj;
			if(obj1=='TESreqcount')
			{
				obj = document.frm.TESreqcount;
			}
			if(obj1=='ReminderInterval')
			{
				obj = document.frm.ReminderInterval;
			}
			if(obj1=='ReminderFrequency')
			{
				obj = document.frm.ReminderFrequency;
			}
			charactercheck(obj,str);
			limitlength(obj, length);
			spaceChecking(obj);
}

</script>

</head>
<!-- Start of body -->

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.unit.unit",strsesLanguage)%></li>
    </ul></td>	
	<td width="23%" height="38" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
      <ul id="list-nav">
      <li><a href="M_siteList.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage)%></a></li>
      </ul>
      </td>
        
      </tr>
    </table>
	</td>
  </tr>
</table>

<form method=post name="frm" action="M_siteAddPost.jsp" onSubmit="javascript:return checkData();">
  <table width="70%" align="center" cellspacing="1" cellpadding="5">
    <tr align="left">
      <td colspan="2" class="formbottom">&nbsp;</td>
    </tr>
    <tr align="left">
      <td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.requestdetails.division",strsesLanguage)%></td>
      <!-- TO ADD DIVISION  -->
      <td width="65%" class="formtr1"><select name="Division" class="textBoxCss"  style="width:170px;">
        <option value="S"><%=dbLabelBean.getLabel("label.unit.selectdivision",strsesLanguage)%></option>
        <%
	strSqlStr	= "SELECT DIV_ID,DIV_NAME FROM M_DIVISION WHERE STATUS_ID=10 ORDER BY 2 ";
	objRs       =   dbConBean.executeQuery(strSqlStr); 
	while(objRs.next())
	{
					strDivId	=	objRs.getString("DIV_ID").trim();
					strDivName	=	objRs.getString("DIV_NAME").trim();
					
				%>
        <option value="<%=strDivId%>"> <%=strDivName%> </option>
        <%


	}

	objRs.close();
%>
      </select>      </td>
    </tr>
    
    <tr align="left">
      <td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.sitemaster.travelsiteagency",strsesLanguage)%></td>
      <!-- TO ADD DIVISION  -->
      <td width="65%" class="formtr1">
	      <select name="agencyId" class="textBoxCss" style="width:170px;">
	      	<option value="-1"><%=dbLabelBean.getLabel("label.sitemaster.selectagency",strsesLanguage)%></option>
	        <option value="1"><%=dbLabelBean.getLabel("label.sitemaster.mataindia",strsesLanguage)%></option>
	        <option value="2"><%=dbLabelBean.getLabel("label.sitemaster.matagmbh",strsesLanguage)%></option>
	        <option value="0"><%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage)%></option>
	      </select>      
      </td>
    </tr>
    
    <tr align="left">
      <td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td>
      <!-- TO ADD THE SITE NAME -->
      <td width="65%" class="formtr1">
      	<input type="text" maxlength=50 name=Sitename value="" class="textBoxCss" onKeyUp="return test1('Sitename', 12, 'all')"  style="width:170px;">      
      </td>
    </tr>
    <tr align="left">
      <td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.unit.unitdescription",strsesLanguage)%></td>
      <!-- TO ADD THE SITE DESCRIPTION -->
      <td width="65%" class="formtr1"><input type="text" size=30 maxlength=50 name=Description value="" class="textBoxCss" onKeyUp="return test1('Description', 12, 'all')"  style="width:170px;">      </td>
    </tr>
    <!-- added by manoj chand on 14 dec 2012 to add Base Currency and Web Service Url -->
    <tr align="left">
      <td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.currency.basecurrency",strsesLanguage)%></td>
      <td width="65%" class="formtr1">
      	<select name="baseCurrency" id="baseCurrency" class="textBoxCss">
	     <option value=""><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
			<%
			objRs=null;
			strSqlStr = "Select rtrim(Currency), rtrim(Currency) from m_currency where status_id=10";
			objRs       =   dbConBean.executeQuery(strSqlStr); 
				while (objRs.next()) {
			%>
                         <option value="<%=objRs.getString(1)%>"><%=objRs.getString(2)%></option>  
			<%}
				objRs.close();
					%>
        </select>
      </td>
    </tr>
    <!-- added by manoj chand on 07 Mar 2013 to add company-->
    <tr align="left">
      <td class="formtr2" width="35%"><%=dbLabelBean.getLabel("submenu.master.company",strsesLanguage)%></td>
      <td width="65%" class="formtr1">
      	<select name="company" id="Company" class="textBoxCss">
	     <option value="0"><%=dbLabelBean.getLabel("label.global.notapplicable",strsesLanguage) %></option>
			<%
			objRs=null;
			strSqlStr = "Select CID, ltrim(rtrim(COMPANY_NAME)) from m_company where status_id=10";
			objRs       =   dbConBean.executeQuery(strSqlStr); 
				while (objRs.next()) {
			%>
                         <option value="<%=objRs.getString(1)%>"><%=objRs.getString(2)%></option>  
			<%}
				objRs.close();
				dbConBean.close();    // close all the connections
		%>
        </select>
        <span style="color: red">*</span>&nbsp;<%=dbLabelBean.getLabel("label.company.applicableincas",strsesLanguage) %>
      </td>
    </tr>
    <!-- added by manoj chand on 29 Apr 2013 to add tes thresold count number-->
    <tr align="left">
      <td class="formtr2" width="35%"><%=dbLabelBean.getLabel("alert.site.reqlimitwithouttes",strsesLanguage) %></td> 
      <td width="65%" class="formtr1"><input type="text" size="3" maxlength="2" name="TESreqcount" value="0" class="textBoxCss" onKeyUp="return test2('TESreqcount', 2, 'n')">
      <span style="color: red">*</span>&nbsp;<%=dbLabelBean.getLabel("label.unit.numberofrequestallowed",strsesLanguage) %>
      </td>
    </tr>
    
    <!--  ADDED BY MANOJ CHAND ON 29 MAY 2013 TO UPDATE REMINDER INTERVAL AND REMINDER FREQUENCY -->
	<tr align="left"> 
	<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.site.reminderinterval",strsesLanguage) %></td>	
	<td width="65%"class="formtr1"><input type="text" size="3" maxlength="2" name="ReminderInterval" value="0" class="textBoxCss" onKeyUp="return test2('ReminderInterval', 2, 'n')"> 
	<span style="color: red">*</span>&nbsp;<%=dbLabelBean.getLabel("label.unit.daysafterapproved",strsesLanguage) %>
	</td>
	</tr>
	<tr align="left"> 
	<td class="formtr2" width="35%"><%=dbLabelBean.getLabel("label.site.reminderfrequency",strsesLanguage) %></td>	
	<td width="65%"class="formtr1"><input type="text" size="3" maxlength="2" name="ReminderFrequency" value="0" class="textBoxCss" onKeyUp="return test2('ReminderFrequency', 2, 'n')"> 
	<span style="color: red">*</span>&nbsp;<%=dbLabelBean.getLabel("label.unit.daysafterfirstreminder",strsesLanguage) %>
	</td>
	</tr>
    
    
    <tr align="center">
      <td class="formbottom" colspan="2"><input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("label.global.add",strsesLanguage)%>" class="formButton" >
          <input type="Reset" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%>" class="formButton">      </td>
    </tr>
    <input type="hidden" name="status_id" value="10" >
    <tr>
      <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
    </tr>
  </table>
</form>
<!-- Start of Form -->
<!-- End of Form -->
</body>
</html>
