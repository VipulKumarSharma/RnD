
<%
/***************************************************

**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	  : STARS***** 
**** Operating environment :Tomcat, sql server 2000 ******
**** Description : This is first jsp file  for adding  users to whom approval page is assigned on behalf of others  ******
**** Modified By			: Manoj Chand
**** Modification			: Special Workflow change for Page Access Permission users
**** Date of Modification   : 01-05-2012
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

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<%-- <%@ include  file="systemStyle.jsp" %> --%>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
<%
// Variables declared and initialized



Connection objCon,objCon_1		=		null;			    // Object for connection
Statement objStmt,objStmt_1		=		null;			   // Object for Statement
ResultSet objRs,objRs_1			=		null;			  // Object for ResultSet
CallableStatement objCstmt		=		null;			// Object for Callable Statement

String		strDivId			=	null;	//	Variable for storing division id
String		strDivName			=	null;	// Variable for storing division name

//Create Connection
objCon=dbConBean.getConnection();
String	strSqlStr	=	""; // For sql Statements

%>
<script>
function checkData()
{

var strDiv= document.frm.pendingWith.value;
	
	if(strDiv=='S')
	{
	alert('<%=dbLabelBean.getLabel("alert.administration.pendingwithuser",strsesLanguage)%>');
	document.frm.pendingWith.focus();
	return false;
	}


var stviewTo= document.frm.viewTo.value;	
	if(stviewTo=='S' || stviewTo=='')
	{	
		//alert('Please select a value');		
		alert('<%=dbLabelBean.getLabel("alert.administration.pleaseselectviewtouser",strsesLanguage)%>');		
		document.getElementById("viewTo").focus();
		//document.frm.viewTo.focus();
		return false;
	}

var stSite= document.frm.site.value;	
	if(stSite=='S' || stSite=='')
	{	
		//alert('Please select a value');		
		alert('alert.pageaccesspermission.pleaseselectthesite');		
		document.getElementById("site").focus();
		//document.frm.site.focus();
		return false;
	}		
	else
	{
		return true;
	}
	
  }
  
  function test1(obj, length, str)
		{
			charactercheck(obj,str);
			limitlength(obj, length);
			spaceChecking(obj);
		
		}
  function progressImage(){
	  document.getElementById("showSessionTimeOut").style.visibility="hidden";
	  }

</script>
</head>
<!-- Start of body -->
<body onload="progressImage()"><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<span id="showSessionTimeOut" style="visibility: visible;">
	<img src=images/loading16.gif border=0 width=50 height=51>
	<br>      
	<font color="#000080" class="pageHead"><center><%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage)%></center></font> 
</span>
<script>
var xpos = (screen.availHeight/2)+100;
var ypos = screen.availWidth/2-350;
var dv = document.getElementById("showSessionTimeOut");
dv.style.position="absolute";       		
dv.style.left=(xpos+10)+"px";
dv.style.top=(ypos)+"px";  
document.getElementById("showSessionTimeOut").style.visibility="visible";
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="70%" height="35" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.pageaccesspermission.permissiontoviewapproverequestpage",strsesLanguage)%></li>
    </ul></td>
    <td width="30%" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
      <ul id="list-nav">
      <li><a href="PageAccessPermissionList.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage) %></a></li>
      </ul>
      </td>
		
      </tr>
    </table>
	</td> 
  </tr>
</table>

<!-- Start of Form -->
<form method=post name=frm action="M_PageAccessPermissionAddPost.jsp" onSubmit="javascript:return checkData();">
<table class="formborder" border="0" width="70%" align="center" cellspacing="1" cellpadding="2">
	<tr align="left"> 
	    <td width="23%" class="formtr2" nowrap="nowrap"><%=dbLabelBean.getLabel("label.pageaccesspermission.pendingwithuser",strsesLanguage)%></td>
	    <td   class="formtr1" colspan="3">
	    	<select name="pendingWith" class="textBoxCss" >
				<option value="S" ><%=dbLabelBean.getLabel("label.pageaccesspermission.selectuser",strsesLanguage)%></option>			
			<%
				objStmt		=	objCon.createStatement();	
				//strSqlStr	= "SELECT distinct approver_id,RTRIM(ISNULL(.dbo.user_name(approver_id),'-')) as approver_name FROM t_approvers order by 2";
				strSqlStr="select distinct approver_id,rtrim(isnull(.dbo.user_name(approver_id),'-')) as approver_name"+ 
					" from t_approvers ta inner join m_userinfo mu on ta.approver_id=mu.userid"+
					" where mu.status_id=10 and mu.loginstatus in ('active','enable') "+
					" and approver_id not  in (select distinct viewtouser from vw_page_access_permission where status=10 ) order by 2";
				//System.out.println("strSqlStr-1-->"+strSqlStr);
				objRs		= objStmt.executeQuery(strSqlStr);
				String strApproverId="";
				String strApproverName="";
				while(objRs.next())
				{
					strApproverId	=	objRs.getString("approver_id").trim();			
					strApproverName	=	objRs.getString("approver_name").trim();								
			%>
				<option value="<%=strApproverId%>"> <%=strApproverName%> </option>			
			<%	
				}	
				objRs.close();
				objStmt.close();	
			%>	
			</select>		 
		</td>
	</tr>
	<tr align="center"> 
   	 <td class="formtr2" width="23%" ><%=dbLabelBean.getLabel("label.pageaccesspermission.viewtouser",strsesLanguage)%></td>
   	 <td  class="formtr1" width="27%">
   		 <select id="s3" name="viewTo" class="textBoxCss" multiple="multiple" >		
			<%
				objStmt		= objCon.createStatement();	
				strSqlStr	= "SELECT distinct userid,RTRIM(.dbo.user_name(userid))+' ('+RTRIM(DBO.SITENAME(SITE_ID))+')' as name  FROM m_userinfo where m_userinfo.LOGINSTATUS in ('active','enable') and status_id=10  order by 2";
				//System.out.println("strSqlStr--2->"+strSqlStr);
				objRs		= objStmt.executeQuery(strSqlStr);
				String strViewToId="";
				String strViewToName="";
				while(objRs.next())
				{
					strViewToId	=	objRs.getString("userid").trim();
					strViewToName	=	objRs.getString("name").trim();					
			%>
			<option value="<%=strViewToId%>"> <%=strViewToName%> </option>
			<%
				}
				objRs.close();
				objStmt.close();
			%>
		</select>	 
	</td>
	<td class="formtr2" width="23%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.administration.site",strsesLanguage)%></td>
	<td class="formtr1" width="27%" >
		<select id="s6"  name="site"  class="textBoxCss"  multiple="multiple" >	
			<option value="-99"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage)%></option>		
				<%
				objStmt		=	objCon.createStatement();	
				strSqlStr	= "select site_id,SITE_name from m_site where STATUS_ID=10 order by 2";
				//System.out.println("strSqlStr--3->"+strSqlStr);
				objRs		= objStmt.executeQuery(strSqlStr);
				String strSiteId="";
				String strSiteName="";
				while(objRs.next())
				{
					strSiteId	=	objRs.getString("site_id").trim();
					strSiteName	=	objRs.getString("SITE_name").trim();					
				%>
			<option value="<%=strSiteId%>"> <%=strSiteName%> </option>
				<%
				}
				objRs.close();
				objStmt.close();			
				%>
		</select>
		
	</td>
	</tr>
	<tr align="center">
		<td class="formtr2" align="center"  colspan="4"><%=dbLabelBean.getLabel("label.pageaccesspermission.access",strsesLanguage) %>&nbsp;<select class="textBoxCss" name="Access" id="Access">
				<option value="View" selected><%=dbLabelBean.getLabel("label.requestdetails.view",strsesLanguage)%></option>
				<option value="Full"><%=dbLabelBean.getLabel("label.pageaccesspermission.fullcontrol",strsesLanguage)%></option>
			</select>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=dbLabelBean.getLabel("label.administration.showbeforepass",strsesLanguage)%>
			<input type="checkbox" value="Y"  name="ShowBeforePass" id="ShowBeforePass" ></input>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=dbLabelBean.getLabel("label.administration.showafterpass",strsesLanguage)%>
			<input type="checkbox" value="Y"  name="ShowAfterPass" id="ShowAfterPass" ></input>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=dbLabelBean.getLabel("label.administration.mailforward",strsesLanguage)%>
			<input type="checkbox" value="Y"  name="MailForward" id="MailForward" ></input>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=dbLabelBean.getLabel("label.administration.value",strsesLanguage) %><input type="text" size=15 class="textBoxCss" maxlength="15" value="5000" onKeyUp="return test1(this,15, 'n')" onblur="return test1(this,15,'n')"   name="papValue" id="papValue" ></input>
		
		</td>		
	</tr>	
	<tr align="center"> 
    	<td class="formbottom" colspan="4">
	      <input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("label.global.add",strsesLanguage)%>" class="formButton" >
	      <input type="Reset" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%>" class="formButton">
   		</td>
 	</tr>       
	<tr>
   		 <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
	</tr>
</table>
</form>
<%
try{
	objCon.close();
}catch(Exception e){
	e.printStackTrace();	
}
%>
<!-- End of Form -->
<script type="text/javascript">
/*$(function(){
	$("#s6").dropdownchecklist( {firstItemChecksAll:'true',emptyText:'Select',maxDropHeight: 150 ,forceMultiple: true, onComplete: function(selector) {
		var values = "";
		for( i=0; i < selector.options.length; i++ ) {
			if (selector.options[i].selected && (selector.options[i].value != "")) {
				if ( values != "" ) values += ";";
				values += selector.options[i].value;
			}
		}
		
	} });

	$("#s3").dropdownchecklist( {emptyText:'Select', maxDropHeight: 150 ,forceMultiple: true, onComplete: function(selector) {
		var values = "";
		for( i=0; i < selector.options.length; i++ ) {
			if (selector.options[i].selected && (selector.options[i].value != "")) {
				if ( values != "" ) values += ";";
				values += selector.options[i].value;
			}
		}
		
	} });
	
});*/

</script>
</body>
</html>
