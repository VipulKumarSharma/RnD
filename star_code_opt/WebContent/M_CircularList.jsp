<%
/***************************************************
 *The information contained here in is confidential and 
 *proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand
 *Date of Creation 		:23 Jan 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp list Circulars based on years
 
 *Modified By			:Manoj Chand
 *Modification 			:add year 2013 or 2014 in year combobox.
 *Modification Date		:04 Jan 2013
*******************************************************/%>
<html>
<head>
<%@ include  file="importStatement.jsp" %>
<%@ page pageEncoding="UTF-8" %>
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

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<style>
.formtr50
{
font-family:Arial, Helvetica, sans-serif;
font-size:11px;
BACKGROUND:#f7f7f7;
COLOR:#373737;
font-weight:normal; 
line-height:14px;
text-align: left;
}


.formtr51{
font-family:Arial, Helvetica, sans-serif;
font-size:11px;
BACKGROUND:#f2f2f2;
COLOR:#373737;
line-height:14px;
text-align:left;
}

.formtr50 a:link, .formtr51 a:link {
	color:#d62234;
}

.formtr50 a:visited, .formtr51 a:visited {
	color:#d62234;
}

.formtr50 a:active, .formtr51 a:active {
	color:#d62234;
}

.formtr50 a:hover, .formtr51 a:hover {
	color:#d62234;
}
</style>


<%
// Variables declared and initialized
ResultSet objRs			=		null;			  
ResultSet rs 			=		null;	
String	strSqlStr	=	"";
int iCls = 0;
String strStyleCls = "";
String strsiteid	 ="";
//added by manoj chand on 04 jan 2013 to get current year
Calendar cal=Calendar.getInstance();
int year=cal.get(Calendar.YEAR);
String strMessage = request.getParameter("strMsg") == null ?"" : request.getParameter("strMsg");
String stryear=(request.getParameter("year")==null)?""+year+"":request.getParameter("year");
%>
<script language=JavaScript >


function deleteConfirm()
{

if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage) %>'))
	return true;
else
	return false;
}

function fun_reload(){
	document.frm.submit();
}

</script>
<base target="middle">
</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<form name="frm" action="M_CircularList.jsp" method="get">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="32" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.circulars.circularlist",strsesLanguage) %>  &nbsp;</li><font color='red'><%=strMessage%></font>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td align="right">
         <ul id="list-nav">
<%
if(SuserRole.equalsIgnoreCase("AD")){
%>
         
          <li><a href="M_CircularAdd.jsp" ><%=dbLabelBean.getLabel("button.global.new",strsesLanguage) %></a></li>
          <%} %>
          <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
         </ul>
         </td>
      </tr>
    </table>
	</td>
  </tr>
</table>

<table width="100%" align="left" cellpadding="0" cellspacing="0"> 
<tr>
<td colspan="2">
<table width="100%" align="left" cellspacing="1" cellpadding="1">
<tr>
<td width="5%" colspan="1" class="formtr2" align="center">&nbsp;<%=dbLabelBean.getLabel("label.report.year",strsesLanguage) %></td>
<td class="formtr2">
    
    	 <select name="year" id="year" class="textBoxCss" onchange="fun_reload();">
    	 	<option value="2014">2014</option>
    	 	<option value="2013">2013</option>
    	 	<option value="2012">2012</option>
			<option value="2011">2011</option>
			<option value="2010">2010</option>
			<option value="2009">2009</option>
		<script type="text/javascript">
		    var currentYear = new Date().getFullYear();
			select = document.getElementById("year");
			select.innerHTML = "";
			var options='';
			for(var i = currentYear; i >= 2009; i--){
				 var option = document.createElement('option');
				 option.value = option.text = i;
				 select.add(option);      
			}				
			document.frm.year.value='<%=stryear%>';		
		</script>
		</select> 
		
 
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<table width="100%" align="left" border="0" cellpadding="5" cellspacing="1" class="formborder">
<tr align="left" class="formhead"> 
    <td width="5%"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
	<td width="30%"><%=dbLabelBean.getLabel("label.circulars.circulartitle",strsesLanguage) %></td>
    <td width="30%"><%=dbLabelBean.getLabel("label.circulars.circulatedby",strsesLanguage) %></td>
    <td width="16%"><%=dbLabelBean.getLabel("label.circulars.circulatedon",strsesLanguage) %></td>
    <td width="19%"><%=dbLabelBean.getLabel("label.requestdetails.view",strsesLanguage) %></td>
</tr>
  <%
		
	int		intSno		=	1;
  	int Counter			= 	0;
	String strSiteName  =   ""; 
	String strCircularTitle =   "";
 	int CirId=0;
	String strCirculatedBy = "";
	String strCreatedDate="";

	
	//Sql to get the the site list  from site table

	//strSqlStr="SELECT  DIV_ID, DIV_NAME, DIV_DESC, dbo.CONVERTDATE(C_DATE) AS create_date  FROM  M_DIVISION WHERE (STATUS_ID =           10) order by 2" ;
	strSqlStr="SELECT CircularId,C_Title,Circulated_By,dbo.CONVERTDATE(UPLOADED_ON) AS create_date FROM M_CIRCULAR WHERE datepart(year,UPLOADED_ON)='"+stryear+"' and  STATUS_ID=10 ORDER BY CIRCULARID DESC";
	//System.out.println("strSqlStr--1111-->"+strSqlStr); 
    objRs				= dbConBean.executeQuery(strSqlStr);
    
	while(objRs.next())
	{
		Counter++;
		CirId				= objRs.getInt("CircularId");
		strCircularTitle			= objRs.getString("C_Title");
		strCirculatedBy				= objRs.getString("Circulated_By"); 
		strCreatedDate	    = objRs.getString("create_date");
		

		if (iCls%2 == 0) { 
		strStyleCls="formtr50";
	    } else { 
		strStyleCls="formtr51";
		} 
	    iCls++;
%>
    <tr class="<%=strStyleCls%>"> 
    <td ><%=intSno%></td>
    <td ><%=strCircularTitle%></td>
	<td ><%=strCirculatedBy%></td>
	<td ><%=strCreatedDate%></td>
	<td ><a href="javascript:void(0);" onclick="window.open('./DownloadCircular?CircularId=<%=CirId%>','mywindow','menubar=0,resizable=yes,width=980,height=450,scrollbars=yes,left=15');"> <%=dbLabelBean.getLabel("label.circulars.viewcircular",strsesLanguage) %></a></td>
  </tr>
  <%
				intSno++;				
	}
	if(Counter==0){
		%>
		<tr>
		<td class="formtr51" colspan="5"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage) %></td>
		</tr>
	<%}
	objRs.close();
	dbConBean.close();   //Close All Connection
%>
 <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr>
</table>
</td></tr></table>
<br>
</form>
</body>
</html>