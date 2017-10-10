<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	SACHIN GUPTA
*Date			:   28/08/2006
*Description	:	Currency List
*Project		:	STARS

*Modification 	: 	give a provision for currency EDIT and DELETE
*Modified By	:	Manoj Chand
*Date of Modification	:10 feb 2011

*Modified By	        :MANOJ CHAND
*Date of Modification   :01 Feb 2013
*Description			:IE Compatibility Issue resolved

**********************************************************/
%>

<HTML>
<HEAD>
<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>

<%-- include remove cache  --%>
<%@ include  file="importStatement.jsp" %>
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

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<script language=JavaScript >
function deleteConfirm(flag)
{
if(flag=="Y")
{
	alert('<%=dbLabelBean.getLabel("label.currency.basecurrencycannotbedeleted",strsesLanguage)%>');
	return false;
}
else{
if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage)%>'))
	return true;
else
	return false;
}
}
</script>


<% 
// Variables declared and initialized
Connection con	=	null;			    // Object for connection
ResultSet rs	=	null;			  // Object for ResultSet
int intSerialNo=0;
String	sSqlStr=""; // For sql Statements
String	strCurrency			=	"";
String	strCurDesc		=	"";
String	strBaseCurrency			=	"";
String strCurId	=	"";
String curflag ="";
String curId="0";
int iCls	=	0;
String strStyleCls	=	"";
String flag="false";
String strMessage = URLDecoder.decode((request.getParameter("message") == null) ? "" : request.getParameter("message"), "UTF-8");

NumberFormat nf = NumberFormat.getNumberInstance();
nf.setMaximumFractionDigits(2);

String strBaseCur="";
String strCurr="";
String strbasecurId="";
//added by manoj  
sSqlStr="select cur_id,currency,cur_desc,base_cur_flag from m_currency where status_id=10 order by 1";
rs=dbConBean.executeQuery(sSqlStr);
while(rs.next())
{
strbasecurId=rs.getString("cur_id");
strCurr	= rs.getString("currency");
strBaseCur	= rs.getString("base_cur_flag");

if(strBaseCur.equals("Y")){
	  curId=strbasecurId;
	  curflag=strCurr;
	  flag="true";
}
}
/*System.out.println("curflag--->"+curId);
System.out.println("curflag--->"+curflag);
System.out.println("flag--->"+flag);*/

%>
</HEAD>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr >
    <td width="77%" height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.currency.currencylist",strsesLanguage)%> &nbsp; </li><font color='red'>   <%=strMessage%></font>
    </ul></td>
    
    
    <td width="23%" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
		<ul id="list-nav">
			<li><a href="M_currencyAdd.jsp?baseflag=<%=flag%>"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage) %></a></li>
			<li><a href="M_exchangeRateAdd.jsp?basecurflag=<%=curflag %>"><%=dbLabelBean.getLabel("label.currency.exchangerate",strsesLanguage)%></a></li>
		</ul>
      </td>
      </tr>
    </table>
    
    </td>
  </tr>
</table>

  <table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <tr class="formhead"> 
    <td width="5%" align="Left"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
    <td width="20%" align="Left"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%></td>
    <td width="25%" align="Left"><%=dbLabelBean.getLabel("label.currency.currencydesc",strsesLanguage)%></td>
    <td width="20%" align="Left"><%=dbLabelBean.getLabel("label.currency.basecurrency",strsesLanguage)%></td>
    <td width="30%" align="Left"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
  </tr>
  <%
  String strSetStatusCss	=	"";
  //sql to get the currency list
  //sSqlStr="SET DATEFORMAT DMY SELECT CURRENCY,  DATENAME(MONTH,'01/'+CONVERT(VARCHAR, RATE_MONTH)+'/2004'), RATE_YEAR, CONVERSION_RATE,ISNULL(STATUS_ID,'30') FROM DBO.EXCHANGE_RATE WHERE STATUS_ID=10 ORDER BY 5,1";
  //sSqlStr="SET DATEFORMAT DMY SELECT currency,  DATENAME(MONTH,'01/'+CONVERT(VARCHAR, RATE_MONTH)+'/2004'), RATE_YEAR, CONVERSION_RATE,ISNULL(EXCHANGE_RATE.STATUS_ID,'30') FROM m_currency inner join  DBO.EXCHANGE_RATE on EXCHANGE_RATE.CUR_ID = m_currency.CUR_ID  WHERE EXCHANGE_RATE.STATUS_ID=10 ORDER BY 5,1";
  sSqlStr="select cur_id,currency,cur_desc,base_cur_flag from m_currency where status_id=10 order by 1";
  rs=dbConBean.executeQuery(sSqlStr);
  while(rs.next())
  {
	strCurId = rs.getString("cur_id");
	strCurrency	= rs.getString("currency");
	strCurDesc	= rs.getString("cur_desc");	
	strBaseCurrency	= rs.getString("base_cur_flag");
	
	/*if(rs.getString(5).trim().equals("30"))
	  {
		strSetStatusCss="listdata";
	  }
	  else
	  {
		strSetStatusCss="listdata";
	  }*/
	  
	  
	  if (iCls%2 == 0) { 
		strStyleCls="formtr2";
	  } else { 
		strStyleCls="formtr1";
      } 

	  iCls++;
%>

 <tr class="<%=strStyleCls%>"> 
	  <td  width="5%" align="Left"><%=++intSerialNo%></td>
	  <td  width="20%" align="Left"><%=strCurrency%></td>
	  <td  width="25%" align="Left"><%=strCurDesc%></td>
	  <td  width="20%" align="Left"><%=strBaseCurrency%></td> 
	  <td  width="30%" align="left"><a href="M_currencyEdit.jsp?currencyId=<%=strCurId%>&baseflag=<%=strBaseCurrency %>&strflag=<%=flag%>&basecurrencyid=<%=curId %>"><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage)%></a> | <a href="M_currencyDelete.jsp?currencyId=<%=strCurId%>&baseflag=<%=strBaseCurrency %>" onClick="return  deleteConfirm('<%=strBaseCurrency %>');"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage)%></a></td>
 </tr>
 
	<%
  }
  rs.close();
  %>
   <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr>
  </table>

<% dbConBean.close();  //Close All Connection %>
</body>

</HTML>