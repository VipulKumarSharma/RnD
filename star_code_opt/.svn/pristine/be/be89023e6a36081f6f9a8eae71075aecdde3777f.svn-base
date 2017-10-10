<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Manoj Chand
*Date			:   08/02/2011
*Description	:	Edit Currency
*Project		:	STARS

*Modified By			:Manoj Chand
*Date of Modification	:22 Oct 2013
*Modification			:javascript validation to stop from typing --,'  symbol is added.
**********************************************************/
%>



<%-- Import Statements  --%>
<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbConnectionBean" pageEncoding="UTF-8"%>

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
ResultSet objRs						=	null;	// Object for ResultSet
String		strSqlStr				=	"";     // For sql Statements
String		strCurId				=   "";
String		strCurrency				=	"";
String 		strCurDesc				=	"";
String		strCurSymbol			=	"";
String		strCurCode				=	"";
String 		strchecked1				=	"";
String 		strchecked2				=	"";
String 		strbasecurrencyid		=	request.getParameter("basecurrencyid");

strCurId	=	request.getParameter("currencyId"); // GET Currency Id
String strflag=request.getParameter("strflag");
String strbaseflag=request.getParameter("baseflag");
if(strbaseflag.equals("Y"))
{
strchecked1="checked";	
}
else
{
	strchecked2="checked";
}
%>

<script>

function checkBase(flag,str){
if(str=="checked"){}
else{
	var x=confirm('<%=dbLabelBean.getLabel("alert.currency.ifyouchangethebasecurrencyyoumustupdate",strsesLanguage)%>');
	if(x){
		document.getElementById("ryes").checked=true;
	}
	else{
		document.getElementById("rno").checked=true;
		
}
}
}

function checkBase1(flag){
	if(flag=="Y"){
		alert('<%=dbLabelBean.getLabel("alert.currency.basecurrencycannotbechanged",strsesLanguage)%>');
		document.getElementById("ryes").checked=true;
		return false;
	}
}
function checkData() {
	var strDesc= document.frm.Description.value;
	if(strDesc=='') {
		alert('<%=dbLabelBean.getLabel("alert.currency.pleaseentercurrencydesc",strsesLanguage)%>');
		document.frm.Description.focus();
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

function test1(obj, length, str) {
	charactercheck(obj,str);
	limitlength(obj, length);
	spaceChecking(obj);
}
</script>
</head>

<%
	strSqlStr="select currency,cur_desc,CUR_SYMBOL,CUR_CODE from m_currency where status_id=10 and cur_id='"+strCurId+"'";
	//System.out.println("strSQLSTR----MCURRENCYEDIT-->"+strSqlStr);
	objRs	 = dbConBean.executeQuery(strSqlStr);
	while(objRs.next())
	{
		strCurrency	 	= objRs.getString("currency");
		strCurDesc	   	= objRs.getString("cur_desc");
		strCurSymbol	= objRs.getString("CUR_SYMBOL");
		strCurCode		= objRs.getString("CUR_CODE");
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
      <li class="pageHead"><%=dbLabelBean.getLabel("label.currency.currencylist",strsesLanguage)%></li>
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

<!-- Start of Form -->
<form method=post name=frm action="M_currencyEditPost.jsp" onSubmit="javascript:return checkData();">
<table width="70%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">

	<tr align="left"> 
		<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.currency.currencyname",strsesLanguage)%></td>	<!-- CURRENCY NAME -->
		<td width="63%"class="formtr1">
			<input type=text size=30 maxlength=20 name=Currencyname value="<%=strCurrency%>" class="textBoxCss input-disabled" READONLY
				onclick="blur();" style="line-height: 11px;"> 
		</td>
	</tr>
	
	<tr align="left"> 
		<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.currency.currencydesc",strsesLanguage)%></td>	<!-- TO MODIFY THE CURRENCY DESCRIPTION -->
		<td width="63%" class="formtr1">
			<input type=text size=30 maxlength=100 name=Description onKeyUp="return test1(this, 100, 'c.')" value="<%=strCurDesc%>" class="textBoxCss"> 
		</td>
	</tr>
	
	<tr align="left"> 
		<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.currency.basecurrency",strsesLanguage)%></td>	<!--BASE CURRENCY-->
		<td width="63%"class="formtr1">
			<input type="radio" id="ryes" value="Y"   name="baseCurflag" onclick="checkBase('<%=strflag %>','<%=strchecked1 %>')"; <%=strchecked1 %>><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%> &nbsp;&nbsp;<input type="radio" id="rno" value="N" name="baseCurflag" <%=strchecked2 %> onclick="return checkBase1('<%=strbaseflag %>')"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
		</td>
	</tr>
	
	<tr align="left"> 
		<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.currency.currencysymbol",strsesLanguage)%></td>	<!-- CURRENCY NAME -->
		<td width="63%"class="formtr1">
			<input type=text size=30 maxlength=10 name=currSymbol value="<%=strCurSymbol%>" class="textBoxCss"> 
		</td>
	</tr>
	
	<tr align="left"> 
		<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.currency.currencycode",strsesLanguage)%></td>	<!-- TO MODIFY THE CURRENCY DESCRIPTION -->
		<td width="63%" class="formtr1">
			<input type=text size=30 maxlength=10 name=currCode onKeyUp="return test1(this, 10, 'cur')" value="<%=strCurCode%>" class="textBoxCss"> 
		</td>
	</tr>
	
  	<tr align="center"> 
	    <td class="formBottom" colspan="2">
	    	<input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)%>" class="formButton" >
	    	<input type="Reset" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%>"class="formButton" >
	    </td>
  	</tr>
        <input type="hidden" name="status_id" value="10" >
		<input type="hidden" name="strCurrencyId" value="<%=strCurId%>">
		<input type="hidden" name="basecurrencyid" value="<%=strbasecurrencyid%>"></input>
		
</table>
</form>
<!-- End of Form -->
</body>
</html>