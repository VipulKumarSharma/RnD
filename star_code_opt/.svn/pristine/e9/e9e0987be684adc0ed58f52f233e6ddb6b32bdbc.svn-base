<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Manoj Chand
*Date			:   09/02/2011
*Description	:	Add Exchange Rate
*Project		:	STARS
**********************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>

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

<%
// Variables declared and initialized

String basecurflag=(request.getParameter("basecurflag")==null)?request.getParameter("baseCur"):request.getParameter("basecurflag");
//System.out.println("basecurrecy flag-->"+basecurflag);

Connection objCon		=		null;			 // Object for connection
Statement objStmt		=		null;			 // Object for Statement
ResultSet objRs			=		null;			 // Object for ResultSet
CallableStatement objCstmt=		null;	         // Object for Callable Statement


String dis="disabled";
String		strCurId			=	"";	
String		strCurrencyName		=	null;	
String strMonthId=null;
String strMonthName=null;
int strNo=0;
String strCur="";
String strConvRate="";
String strUpdatedOn="";
String strmonth="";
String stryear="";

double strConvRate1;
//Create Connection
String	strSqlStr	=	""; // For sql Statements
strmonth			=(request.getParameter("Month")==null)?"":request.getParameter("Month");
stryear				=(request.getParameter("year")==null)?"":request.getParameter("year");
String flag			=(request.getParameter("flag")==null)?"":request.getParameter("flag");
String copyflag		=(request.getParameter("copyflag")==null)?"":request.getParameter("copyflag");
String checkflag	=(request.getParameter("check")==null)?"":request.getParameter("check");

//System.out.println("month---->"+strmonth);
//System.out.println("year---->"+stryear);
String strMessage 	= URLDecoder.decode((request.getParameter("message") == null) ?"" : request.getParameter("message"), "UTF-8");

int tmonth=0,tyear=0;

//get from post page
//String smonth=request.getParameter("strmonth");
//String syear=request.getParameter("stryear");
%>

<script>
function test1(obj1,length,str)
{	
	charactercheck(obj1,str);
	spaceChecking(obj1); 
}

function copyFunActionTaken() // copy from previous month
{
	if(document.frm.Month.value=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.currency.pleaseselectmonth",strsesLanguage)%>');
		return false;
	}
	else if(document.frm.year.value=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.report.plaeaseselectyear",strsesLanguage)%>');
		return false;
	}
	else
	{
	   	if(confirm('<%=dbLabelBean.getLabel("alert.currency.areyousureyouwanttocopyfrompreviousmonth",strsesLanguage)%>'))
		{	
	 	window.document.frm.action="M_exchangeRateAdd.jsp?copyflag=c&flag=y";
	 	window.document.frm.submit();
	 	return true;
	 	}
	 	return false;
	 }	
}



function updateFunActionTaken()
{

var strmonth= document.frm.Month.value;
	
	if(strmonth=='-1')
	{
	alert('<%=dbLabelBean.getLabel("alert.currency.pleaseselectmonth",strsesLanguage)%>');
	document.frm.Month.focus();
	return false;
	}
var stryear= document.frm.year.value;
	
	if(stryear=='-1')
	{
	alert('<%=dbLabelBean.getLabel("alert.report.plaeaseselectyear",strsesLanguage)%>');
	document.frm.year.focus();
	return false;
	}
	
	window.document.frm.action="M_exchangeRateAddPost.jsp?";
	document.frm.submit();
	}





function goFunActionTaken() // for selection on month and year
{
	//window.document.forms[0].action="MST00160.do?actionPerform=select&flag=n";
	window.document.forms[0].action="M_exchangeRateAdd.jsp";
}
/*function test2(obj1,length,str)
{	
	AllowCharacterCheck(obj1,str);
}*/

function checkData()
{
var strmonth= document.frm.Month.value;
	
	if(strmonth=='-1')
	{
	alert('<%=dbLabelBean.getLabel("alert.currency.pleaseselectmonth",strsesLanguage)%>');
	document.frm.Month.focus();
	return false;
	}


var stryear= document.frm.year.value;
	
	if(stryear=='-1')
	{
	alert('<%=dbLabelBean.getLabel("alert.report.plaeaseselectyear",strsesLanguage)%>');
	document.frm.year.focus();
	return false;
	}
	else
	{
	return true;
	}
	
  }


</script>

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.currency.exchangerates",strsesLanguage)%> &nbsp; </li><font color='red'>  <%=strMessage%></font>
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

<form method=post name=frm action="M_exchangeRateAdd.jsp?flag=y&check=t" onSubmit="javascript:return checkData();">
  <table width="68%" align="center" cellspacing="0" cellpadding="3">
   
    <tr align="left">
      <td  class="formtr2"><%=dbLabelBean.getLabel("label.currency.month",strsesLanguage)%></td>
      <td  class="formtr2"><%=dbLabelBean.getLabel("label.report.year",strsesLanguage)%></td>
      <td class="formtr2"><%=dbLabelBean.getLabel("label.currency.basecurrency",strsesLanguage) %></td>
      <td class="formtr2"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
 	</tr>
    
    <tr align="left">
<!--<td class="formtr1">&nbsp;</td>-->
<td class="formtr1">
    
    	 <select name="Month"  class="textBoxCss">
			<OPTION VALUE="-1" selected><%=dbLabelBean.getLabel("label.currency.selectmonth",strsesLanguage) %></option>
		<%			
			strSqlStr="SET DATEFORMAT DMY SELECT distinct rate_month, DATENAME(MONTH,'01/'+CONVERT(VARCHAR, RATE_MONTH)+'/2004') as month from exchange_rate";
			//System.out.println("strSqlStr---->"+strSqlStr);
			objRs = dbConBean.executeQuery(strSqlStr);
			while(objRs.next())
			{
				strMonthId		=	objRs.getString(1);
				strMonthName	=	objRs.getString(2);
		%>
				<OPTION VALUE="<%=strMonthId%>"><%=strMonthName%></option>
		<%
			}
			objRs.close();			
		%>
		<script>
			document.frm.Month.value='<%=strmonth%>';		
		</script>
		  </select> 
</td>



<td class="formtr1">
    
    	 <select name="year" class="textBoxCss"><option value="-1"><%=dbLabelBean.getLabel("label.report.selectyear",strsesLanguage)%></option>
			<option value="2011" selected="selected">2011</option>
			<option value="2012">2012</option>
			<option value="2013">2013</option>
			<option value="2014">2014</option>
			<option value="2015">2015</option>
			<option value="2016">2016</option>
			<option value="2017">2017</option>
			<option value="2018">2018</option>
			<script>
			document.frm.year.value='<%=stryear%>';		
		</script>
		</select> 
		
		
 
</td>

      
      <td class="formtr1"><input type=text size=17 maxlength=50 name="baseCur" value="<%=basecurflag %>" readonly="readonly" class="textBoxCss"></td>
      <td class="formtr1" >
      		<input type="Submit" size="20" class="input_butt" value=" <%=dbLabelBean.getLabel("button.search.go",strsesLanguage)%> " width="30"></input>
      		<script>
      document.frm.baseCur.value='<%=basecurflag%>';
      </script>
      </td>
      
 	</tr>
 </table>	
 <table width="67.8%" cellspacing="0" cellpadding="0" align="center">
    <tr align="Left">
    <td class="formtr2" ><font size="2" style="font-weight: bold"> <%=dbLabelBean.getLabel("label.currency.exchangeratelists",strsesLanguage) %></font></td>
 	</tr>
 </table>    
 
 
 
<div id="tbl">
<table  width="100%">
<tr>
<td>

<table class="formtr2" width="68%" align="center" border="1" bordercolor="white" cellpadding="2" cellspacing="1" >
<tr>
<th align="left"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></th>
<th align="left"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%></th>
<th align="center"><%=dbLabelBean.getLabel("label.currency.conversionrate",strsesLanguage)%></th>
<th align="center"><%=dbLabelBean.getLabel("label.currency.updatedon",strsesLanguage)%></th>
</tr>

<%
if(copyflag.equals("c"))
{
	if (strmonth.equals("1"))
	{
		tmonth=12;
		tyear=Integer.parseInt(stryear)-1;
%>		
<%	}
	else
	{
%>
<%		
		tmonth=Integer.parseInt(strmonth)-1;
		tyear=Integer.parseInt(stryear);
	}
	//strSqlStr="select m.cur_id,currency,conversion_rate,m.u_date	from m_currency m left outer join exchange_rate ex on m.cur_id=ex.cur_id and ex.rate_month="+tmonth+" and ex.rate_year="+tyear+"	where  m.status_id=10  order by 1";
}
%>


<%

if(flag.equals("y")){
	
	if(copyflag.equals("c"))
	{
		if (strmonth.equals("1"))
		{
			tmonth=12;
			tyear=Integer.parseInt(stryear)-1;
%>		
<%	}
		else
		{
%>
<%		
			tmonth=Integer.parseInt(strmonth)-1;
			tyear=Integer.parseInt(stryear);
}
strSqlStr="select m.cur_id,currency,conversion_rate,convert(varchar, ex.u_date, 101)as u_date	from m_currency m left outer join exchange_rate ex on m.cur_id=ex.cur_id and ex.rate_month="+tmonth+" and ex.rate_year="+tyear+"	where  m.status_id=10  order by 1";
//System.out.println("strSqlStr--copy-->"+strSqlStr);
}else
{
	//strSqlStr="select m.cur_id,currency,conversion_rate,ex.u_date	from m_currency m left outer join exchange_rate ex on m.cur_id=ex.cur_id and ex.rate_month='"+strmonth+"' and ex.rate_year='"+stryear+"'	where  m.status_id=10  order by 1";
	strSqlStr="select m.cur_id,currency,conversion_rate,convert(varchar, ex.u_date, 101)as u_date	from m_currency m left outer join exchange_rate ex on m.cur_id=ex.cur_id and ex.rate_month='"+strmonth+"' and ex.rate_year='"+stryear+"'	where  m.status_id=10  order by 1";
	//System.out.println("strSqlStr-----normal-->"+strSqlStr);
}

%>
	
<%
objRs = dbConBean.executeQuery(strSqlStr);

while(objRs.next())
{
	strCurId=objRs.getString("cur_id");
	strCur=objRs.getString("currency");
	strConvRate=objRs.getString("conversion_rate");
	if(strConvRate==null)
		strConvRate="";
	else{
	strConvRate1=Double.parseDouble(strConvRate);
	DecimalFormat df = new DecimalFormat("#0.00###", new DecimalFormatSymbols(Locale.US));
    strConvRate=df.format(strConvRate1);
	}
/*	if(strConvRate==null)
		strConvRate="";*/
	
	
	strUpdatedOn=objRs.getString("u_date");
		if(strUpdatedOn==null)
			strUpdatedOn="";
	strNo++;
	/*System.out.println("strcur"+strCurId);
	System.out.println("strcurId"+strCur);*/
	//System.out.println("sno.--->"+strNo+"conversion rate"+strConvRate);
%>

<tr align="Left">
<input type="hidden" name="conrateId<%=strNo%>" value="<%=strCurId%>" ></input> 

<td align="left" ><%=strNo%></td>
<td align="left" ><%=strCur%></td>
<td align="center"><input type="text" name="conversionRate<%=strNo%>" size="15" class="textBoxCss"  maxlength="20" value="<%=strConvRate%>"  onkeyup="test1(this,8,'n.')" onblur="test1(this,8,'n.')"></input></td>
<td align="center"><%=strUpdatedOn%></td>
</tr>
<%
}
%>
<tr>

<%
if(checkflag.equals("t"))
{

	if (strmonth.equals("1"))
	{
		tmonth=12;
		tyear=Integer.parseInt(stryear)-1;
		//System.out.println("tmonth--1--->"+tmonth);
		//System.out.println("tyear--1--->"+tyear);
%>		
<%	}
	else
	{
%>
<%		
		tmonth=Integer.parseInt(strmonth)-1;
		tyear=Integer.parseInt(stryear);
		//System.out.println("tmonth--2--->"+tmonth);
		//System.out.println("tyear--2--->"+tyear);
}
}
strSqlStr="select m.cur_id,currency,conversion_rate,convert(varchar, ex.u_date, 101)as u_date	from m_currency m left outer join exchange_rate ex on m.cur_id=ex.cur_id and ex.rate_month="+tmonth+" and ex.rate_year="+tyear+" where  m.status_id=10  order by 1";

//System.out.println("strSqlStr--12-->"+strSqlStr);	
objRs = dbConBean.executeQuery(strSqlStr);

while(objRs.next())
{
	strConvRate=objRs.getString("conversion_rate");
	if(strConvRate!=null)
		dis="enabled";
}
%>

	
<td class="formtr1" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="textBoxCss"  <%=dis%>="<%=dis %>" value="<%=dbLabelBean.getLabel("label.currency.copyfrompreviousmonth",strsesLanguage)%>" onclick="return copyFunActionTaken();"/>
&nbsp;&nbsp;<input type="button" class="textBoxCss" size="10" value="<%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)%>" onclick="return updateFunActionTaken();"  />
&nbsp;&nbsp;<input type="reset" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%>" class="textBoxCss">
</td>
</tr>
<tr>
<td class="formtr1" colspan="4">&nbsp;&nbsp;</td>
</tr>
</table>

</td>
</tr>
</table></div>
<%} %>

<input type="hidden" name="count" value="<%=strNo %>"></input>
</form>  
 </body>