<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Manoj Chand
*Date			:   08/02/2011
*Description	:	Add Currency
*Project		:	STARS

*Modified By			:Manoj Chand
*Date of Modification	:22 Oct 2013
*Modification			:javascript validation to stop from typing --,'  symbol is added.
**********************************************************/
%>

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
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script type="text/javascript" language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>

<%
// Variables declared and initialized
Connection objCon		=		null;			 // Object for connection
Statement objStmt		=		null;			 // Object for Statement
ResultSet objRs			=		null;			 // Object for ResultSet
CallableStatement objCstmt=		null;	         // Object for Callable Statement

String		strCurId			=	null;	
String		strCurrencyName		=	null;	
String strMonthId=null;
String strMonthName=null;
String strflag=request.getParameter("baseflag");
//System.out.println("flag at add---->"+strflag);

//Create Connection
String	strSqlStr	=	""; // For sql Statements
%>

<script>

function checkBase(flag){

	if(flag=="true"){
		alert('<%=dbLabelBean.getLabel("alert.currency.basecurrencyalreadyexists",strsesLanguage)%>');
		document.getElementById("rno").checked=true;
		return false;
	}else
		return true;
}


function test1(obj, length, str) {
	charactercheck(obj,str);
	limitlength(obj, length);
	spaceChecking(obj);
}

function checkData()
{
	var strcurName= document.frm.currencyName.value;
	if(strcurName=='') {
		alert('<%=dbLabelBean.getLabel("alert.currency.pleaseentercurrencyname",strsesLanguage)%>');
		document.frm.currencyName.focus();
		return false;
	}

	var strcurDesc= document.frm.curDesc.value;
	if(strcurDesc=='') {
		alert('<%=dbLabelBean.getLabel("alert.currency.pleaseentercurrencydesc",strsesLanguage)%>');
		document.frm.curDesc.focus();
		return false;
	} 
	
	var strcursymb= document.frm.currSymbol.value;
	if(strcursymb=='') {
		alert('<%=dbLabelBean.getLabel("alert.currency.pleaseentercurrencysymbol",strsesLanguage)%>');
		document.frm.currSymbol.focus();
		return false;
	}
	
	var strcurCode= document.frm.currCode.value;
	if(strcurCode=='') {
		alert('<%=dbLabelBean.getLabel("alert.currency.pleaseentercurrencycode",strsesLanguage)%>');
		document.frm.currCode.focus();
		return false;
	}
	return true;
}

</script>

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.currency.addcurrency",strsesLanguage)%></li>
    </ul></td>	
	<td width="23%" height="38" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td> 
		<ul id="list-nav">
			<li><a href="M_currencyList.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage)%></a></li>
		</ul>
      </td>    
      </tr>
    </table>
	</td>
  </tr>
</table>

<form method=post name=frm action="M_currencyAddPost.jsp" onSubmit="javascript:return checkData();">
  <table width="70%" align="center" cellspacing="0" cellpadding="3">
   
    <tr align="left">
      <td class="formtr2" width="22%"><%=dbLabelBean.getLabel("label.currency.currencyname",strsesLanguage) %></td>  
      <td width="22%" class="formtr2"><%=dbLabelBean.getLabel("label.currency.currencydesc",strsesLanguage)%></td>
      <td width="26%" class="formtr2"><%=dbLabelBean.getLabel("label.currency.basecurrency",strsesLanguage)%></td>
 	</tr>
    
    <tr align="left">
      <td class="formtr1" width="22%">
      	<input type =text size=20 maxlength=20 name=currencyName onKeyUp="return test1(this, 20, 'cur')" value="" class="textBoxCss">
      	</td>
      <td width="22%" class="formtr1">
      	<input type=text size=20 maxlength=100 name=curDesc onKeyUp="return test1(this, 100, 'c.')"value="" class="textBoxCss">
      </td>
      <td width="26%" class="formtr1"">
      	<input type="radio" value="Y" name="baseCurflag" onclick="checkBase('<%=strflag %>')";><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%> &nbsp;&nbsp;<input type="radio" id="rno" value="N" name="baseCurflag"  checked ><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
      </td>
	</tr>
	
	<tr align="left">
      <td class="formtr2" width="22%"><%=dbLabelBean.getLabel("label.currency.currencysymbol",strsesLanguage)%></td>
      <td class="formtr2" width="22%" colspan="2"><%=dbLabelBean.getLabel("label.currency.currencycode",strsesLanguage) %></td>  
 	</tr>
 	
 	<tr align="Left">
    	<td width="22%" class="formtr1">
    		<input type =text size=20 maxlength=10 name=currSymbol value="" class="textBoxCss">
    	</td>
      	<td width="22%" class="formtr1" colspan="2">
      		<input type =text size=20 maxlength=10 name=currCode onKeyUp="return test1(this, 10, 'cur')" value="" class="textBoxCss">
      	</td>
 	</tr>
 	
    <tr align="center"> 
		<td class="formbottom" colspan="3">
			<input type="Submit" name="Submit" value=" <%=dbLabelBean.getLabel("label.global.add",strsesLanguage)%> " class="formButton" tabIndex=6>
			<input type="Reset" name="Submit2" value=" <%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%> " class="formButton" tabIndex=7>
		</td>
	</tr>
</table>
</form>  
 </body>
     