<%
/*************************************************** 
 *The information contained here in is confidential and 
 *proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand 
 *Date of Creation 		:01 August 2013 
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat 6.0, sql server 2005 
 *Description 			:This file is used to assign rights to user of any site.
 *******************************************************/
%>

<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include  file="importStatement.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>

<script language="JavaScript">

//JQUERY DROPDOWN FILLING IMPLEMENTAION STARTS

		function getUsers(siteid,userid) {
			var siteId = siteid;
			var lang = '<%=strsesLanguage%>';
			var urlParams2 = '&reqpage=assignrights&language1='+lang;
			var urlParams = "siteId="+siteId+urlParams2;
			if(siteId!='-1'){
			$.ajax({
	            type: "post",
	            url: "AjaxMaster.jsp",
	            data: urlParams,
	            success: function(result){
	            	 $("#userName").html(result);
	            	 $("#userName").val(userid);
	            },
				error: function(){
					alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
	            }
	          });
			}
		}

		jQuery(document).ready(function($) {
		$("#selectsiteaccess").change(
			function () {
				var siteId = $("#selectsiteaccess option:selected").val();
				var lang = '<%=strsesLanguage%>';
				var urlParams2 = '&reqpage=assignrights&language1='+lang;
				var urlParams = "siteId="+siteId+urlParams2;
				if(siteId!='-1'){
				$.ajax({
		            type: "post",
		            url: "AjaxMaster.jsp",
		            data: urlParams,
		            success: function(result){
		            	 $("#transferaccessto").html(jQuery.trim(result));
		            	 $("#transfer").attr('disabled','disabled');
		            },
					error: function(){
						alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
		            }
		          });
				}
				else{
					$("#transfer").attr('disabled','disabled');
				}
			}
		);

		$("#transferaccessto").change(
				function () {
					var siteId = $("#transferaccessto option:selected").val();
					if(siteId!='-1')
						$("#transfer").removeAttr('disabled');		
				}
			);
		$("#transfer").attr('disabled','disabled');
		
	});

//JQUERY DROPDOWN FILLING IMPLEMENTAION ENDS

	function MM_openBrWindow(theURL,winName,features) 
	{ 
	window.open(theURL,winName,features);
	}

	function checkdata(){
		var primarysite = document.frm.Site.value;
		var user = document.frm.userName.value;
		var assignsite = document.frm.AssignSite.value; 
		if(primarysite=='-1'){
			alert('<%=dbLabelBean.getLabel("alert.master.pleaseselecttheunit",strsesLanguage)%>');
			document.frm.Site.focus();
			return false;
		}
		if(user=='-1'){
			alert('<%=dbLabelBean.getLabel("alert.accessrights.pleaseselectusername",strsesLanguage)%>');
			document.frm.userName.focus();
			return false;
		}
		if(assignsite=='-1'){
			alert('<%=dbLabelBean.getLabel("alert.accessrights.pleaseselectaccessunit",strsesLanguage)%>');
			document.frm.AssignSite.focus();
			return false;
		}
		return true;
	}
	
	function showSiteAccess(){
		var res = checkdata();
		if(res==true){
			var primarysite = document.frm.Site.value;
			var user = document.frm.userName.value;
			var assignsite = document.frm.AssignSite.value; 
			document.frm.action = 'M_userRights.jsp?Site='+primarysite+'&userName='+user+'&AssignSite='+assignsite;
			document.frm.submit();
			return true;
		}else{
			return false;
		}
	}

	function forwardDelete(fromunit,userid,tounit,strUserId,strSiteId,strUnitHead)
	{
		if(confirm('<%=dbLabelBean.getLabel("alert.master.areyousurewanttodeletethisrecord",strsesLanguage)%>'))
		   {
			 window.location.href="M_deleteUserRole.jsp?strUserId="+strUserId+"&strSiteId="+strSiteId+"&frompage=userrights&fromunit="+fromunit+"&seluser="+userid+"&tounit="+tounit+"&unithead="+strUnitHead;
		   }
		else
	      {
		     return false;
	      }
 	}

	function fun_transfer(){

		var x=false;
		for (i = 9; i < document.frm.length; i++){
			if(document.frm[i].checked)
				x=true;
		}
		if(document.frm.length==14)
			x=false;
		
		if(x==false){
			alert('<%=dbLabelBean.getLabel("label.user.pleaseselectatleast",strsesLanguage)%>');
			return false;
		}

		document.frm.action="M_userRightsAdd_Post.jsp?actionflag=transfer";
		document.frm.submit();
	}
	
</script>

</head>
<body>
<%
String strSql = "",sSqlStr="",strSiteId="",strSiteName="";
String strUserDivName="";
ResultSet rs = null;
int col=8,colwidth=100/8;
String loadFlag=request.getParameter("flag")==null?"":request.getParameter("flag");
String strSite = request.getParameter("Site")==null?"-1":request.getParameter("Site");
String struserName = request.getParameter("userName")==null?"-1":request.getParameter("userName");
String strAssignSite = request.getParameter("AssignSite")==null?"-1":request.getParameter("AssignSite");

String strMessage = URLDecoder.decode((request.getParameter("Message")==null)?"":request.getParameter("Message"), "UTF-8");

strSql="SELECT SHOW_APP_LVL_3 FROM M_DIVISION MD INNER JOIN	M_USERINFO MU ON MU.DIV_ID=MD.DIV_ID WHERE SITE_ID="+strAssignSite;
rs = dbConBean.executeQuery(strSql);
if(rs.next())
{
	strUserDivName = rs.getString("SHOW_APP_LVL_3");
}
//System.out.println("loadFlag-->"+loadFlag);
//System.out.println("strSite-->"+strSite);
//System.out.println("struserName-->"+struserName);
//System.out.println("strAssignSite-->"+strAssignSite);
if(loadFlag.equals("2")){%>
	<script>
		getUsers('<%=strSite%>','<%=struserName%>');
	</script>
<%}
%>
<form name = "frm" method ="post" action="M_userRightsAdd_Post.jsp">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="35" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.accessrights.accessrightstouser",strsesLanguage)%> &nbsp;<%=strMessage %></li>
    </ul>
    </td>
    <td align="right" valign="bottom" class="bodyline-top">
	 <table align="right" border="0" cellspacing="0" cellpadding="0">
		<tr align="right">
		<td>
		<ul id="list-nav">
		<li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%></a></li>
		</ul>
			</td>
		</tr>
	 </table>
    </td>
   </tr>
</table>
<br>
  <table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	<tr class="formhead">
	  <td width="6%"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>
      <td width="23%" >
      <select name="Site" id="SelectUnit" class="textBoxCss" onchange="getUsers(this.value,'-1');" style="width:100%;">
		    <option value="-1" ><%=dbLabelBean.getLabel("label.report.selectunit",strsesLanguage)%></option>
		    <%  
				//strSql = "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE  APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY SITE_NAME ";
                sSqlStr	="SELECT DISTINCT ISNULL(SITE_ID,'-') AS SITE_ID, RTRIM(ISNULL(SITE_NAME,'-')) AS SITE_NAME FROM M_SITE WHERE STATUS_ID=10 AND (isnull(CLOSED_UNIT_FLAG,'')<>'y') ORDER BY 2 ";
                rs       =   dbConBean.executeQuery(sSqlStr);    						 
      	        while(rs.next())
                {
                 strSiteId	=	rs.getString("SITE_ID");       
              	 strSiteName	=	rs.getString("SITE_NAME"); 
			%>
		         <option value="<%=strSiteId%>" > <%=strSiteName%> </option>
		    <%  
		        }
         	    rs.close();
			%>
      </select>
      <script>
		 if(<%=strSite%>!='-1'){
			 document.frm.Site.value='<%=strSite%>';
		 }
	 </script>
      </td>
      <td width="9%" ><%=dbLabelBean.getLabel("label.mail.username",strsesLanguage)%></td>
      <td width="23%" >
      <Select id="userName" name="userName" class="textBoxCss" style="width:100%;">
			<option value="-1"><%=dbLabelBean.getLabel("label.pageaccesspermission.selectuser",strsesLanguage) %></option>
	 </select>
	 <script>
		 if(<%=struserName%>!='-1'){
			 document.frm.userName.value='<%=struserName%>';
		 }
	 </script>
      </td>
      <td width="9%" ><%=dbLabelBean.getLabel("label.accessrights.accessunit",strsesLanguage)%></td>
      <td width="23%" >
      <select name="AssignSite" class="textBoxCss"  style="width:100%;">
		    <option value="-1" ><%=dbLabelBean.getLabel("label.report.selectunit",strsesLanguage)%></option>
		    <%  
                sSqlStr	="SELECT DISTINCT ISNULL(SITE_ID,'-') AS SITE_ID, RTRIM(ISNULL(SITE_NAME,'-')) AS SITE_NAME FROM M_SITE WHERE STATUS_ID=10 AND (isnull(CLOSED_UNIT_FLAG,'')<>'y') ORDER BY 2 ";
                rs       =   dbConBean.executeQuery(sSqlStr);    						 
      	        while(rs.next())
                {
                 strSiteId	=	rs.getString("SITE_ID");       
              	 strSiteName	=	rs.getString("SITE_NAME"); 
			%>
		         <option value="<%=strSiteId%>" > <%=strSiteName%> </option>
		    <%  
		        }
         	    rs.close();
			%>
      </select>
      <script>
		 if(<%=strAssignSite%>!='-1'){
			 document.frm.AssignSite.value='<%=strAssignSite%>';
		 }
	 </script>
      </td>
	  <td width="5%"><input type="button" value=" <%=dbLabelBean.getLabel("button.search.go",strsesLanguage)%> " class="formButton" onclick="return showSiteAccess();"></td>
	</tr>
	</table>
<%if(loadFlag.equals("2")){	%>
	<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	<%if(strUserDivName.equalsIgnoreCase("Y") && SuserRole.equalsIgnoreCase("AD")) {
		col=9;
		colwidth=100/9;
	} %>
     <tr>
      <td class="dataLabel" colspan=<%=col %>><b><%=dbLabelBean.getLabel("label.master.grantaccess",strsesLanguage)%></b></td>	
     </tr>
     <tr align="center" > 
   		<td class="formhead" width="5%"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
   		<td class="formhead" width="<%=colwidth+4%>%"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>
   		<td class="formhead" width="<%=colwidth+3%>%"><%=dbLabelBean.getLabel("label.mail.username",strsesLanguage)%></td>
        <td class="formhead" width="<%=colwidth-4%>%"><%=dbLabelBean.getLabel("label.master.localadmin",strsesLanguage)%></td>
		<td class="formhead" width="<%=colwidth-3%>%"><%=dbLabelBean.getLabel("label.requestdetails.unithead",strsesLanguage)%></td> 
		<td class="formhead" width="<%=colwidth%>%"><%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage)%></td>
		<%if(strUserDivName.equalsIgnoreCase("Y") && SuserRole.equalsIgnoreCase("AD")) {%>
			<td class="formhead" width="<%=colwidth-1%>%"><%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage)%></td>  
		<%} %>
		<td class="formhead" width="<%=colwidth%>%"><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage)%></td>
		<td class="formhead" width="<%=colwidth%>%"><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage)%></td>
		<td class="formhead" width="<%=colwidth-4%>%"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td> 
    </tr>
	<tr class="formhead">
	<td class="formtr1" style="text-align: center" colspan="1">#</td>
	<td class="formtr1" style="text-align: center" colspan="1">#</td>
	<td class="formtr1" style="text-align: center">#</td>
	<td class="formtr1" style="text-align: center">
	 <input type="checkbox" name="LocalAdmin" value="y">
	</td>
	<td class="formtr1"  style="text-align: center">
	 <input type="checkbox" name="UnitHead" value="1">
	</td>
	<td class="formtr1"  style="text-align: center">
	 <input type="checkbox" name="billApprover" value="1">
	</td>
	 <%if(strUserDivName.equalsIgnoreCase("Y") && SuserRole.equalsIgnoreCase("AD")) {%>
		<td class="formtr1" style="text-align: center">
			<input type="checkbox" name="branchManager" value="Y">
		</td>
	<%} %>
	<td class="formtr1"  style="text-align: center">
	 <input type="checkbox" name="approvallevel1" value="Y">
	</td>
	<td class="formtr1"  style="text-align: center">
	 <input type="checkbox" name="approvallevel2" value="Y">
	</td>
	<td class="formtr1"  style="text-align: center;">
	<input type="submit" name="Submit" value="   <%=dbLabelBean.getLabel("label.master.add",strsesLanguage)%>   " class="formButton" onClick="return checkdata();">
	</td> 
	</tr>
  
  <%

 strSql="SELECT  MU.site_id as SiteId,isnull(dbo.sitename(MU.site_id), '') as SiteName,MU.USERID as UserId,DBO.user_name(MU.USERID) AS UserName,"+
		" case when uma.role_id='LA' then 'Y' else 'N' end as LocalAdmin,"+
		" case when uma.unit_head=1 then 'Y' else 'N' end as UnitHead, "+
		" case when approver_id is null then 'N' else 'Y' end as BillingApprover,"+
		" case when mbm.userid is null then 'N' else 'Y' end as BoardMember,"+
		" case when uma.approval_lvl1<>'' AND uma.approval_lvl1<>'N' then 'Y' else 'N' end as ApprovalLevel1,"+
		" case when uma.approval_lvl2<>'' AND uma.approval_lvl2<>'N' then 'Y' else 'N' end as ApprovalLevel2"+
		" FROM M_USERINFO MU INNER JOIN	user_multiple_access  (NOLOCK) uma ON	MU.USERID=UMA.USERID"+
		" left join m_billing_approver  (NOLOCK) mba on mba.approver_id = uma.userid and uma.site_id = mba.site_id"+ 
		" left join m_board_member  (NOLOCK) mbm on mbm.site_id=uma.site_id and uma.userid=mbm.userid and mbm.status_id=10"+
		" WHERE     (uma.SITE_ID ="+strAssignSite+") and (uma.status_id = 10)"+  
		" union all  "+
		" SELECT MU.site_id as SiteId,isnull(dbo.sitename(MU.site_id), '') as SiteName,MU.USERID as UserId,DBO.user_name(MU.USERID) AS UserName,'N','N','Y','N','N','N'"+ 
		" FROM  m_billing_approver  (NOLOCK) mba "+
		" INNER JOIN M_USERINFO MU ON	MU.USERID=mba.APPROVER_ID"+
		" WHERE (MBA.SITE_ID ="+strAssignSite+") and not exists (SELECT 1 FROM user_multiple_access (NOLOCK)"+
		" WHERE site_id= mba.site_id and userid = mba.approver_id and (status_id = 10))"+
		" union all "+
		" SELECT MU.site_id as SiteId,isnull(dbo.sitename(MU.site_id), '') as SiteName,MU.USERID as UserId,DBO.user_name(MU.USERID) AS UserName,'N','N','N','Y','N','N'"+  
		" FROM m_board_member  (NOLOCK) mbm"+
		" INNER JOIN M_USERINFO MU ON	MU.USERID=mbm.USERID"+
		" WHERE(mbm.SITE_ID="+strAssignSite+") and not exists (SELECT 1 FROM user_multiple_access (NOLOCK)"+
		" WHERE site_id= mbm.site_id and userid = mbm.userid and (status_id = 10))"+
		" and not exists (SELECT 1 FROM m_billing_approver (NOLOCK)"+ 
		" where site_id = mbm.site_id and approver_id=mbm.userid)"+
		" and mbm.status_id=10";
	  
	  //System.out.println("strSql---show-->"+strSql);
	  rs=null;
	  String siteid="",userid="",site="",user="",localadmin="",unithead="",billingapprover="",boardmember="",applvl1="",applvl2="";
	  int sno=0;
	  boolean recfound=false;
	  rs       =   dbConBean.executeQuery(strSql);    						 
      while(rs.next())
      {
    	  recfound=true;
    	  siteid=rs.getString("SiteId");
    	  userid=rs.getString("UserId");
    	  site=rs.getString("SiteName");
    	  user=rs.getString("UserName");
    	  localadmin=rs.getString("LocalAdmin");
    	  unithead=rs.getString("UnitHead");
    	  billingapprover=rs.getString("BillingApprover");
    	  boardmember=rs.getString("BoardMember");
    	  applvl1=rs.getString("ApprovalLevel1");
    	  applvl2=rs.getString("ApprovalLevel2");
    	  if(localadmin.equals("N"))
    		  localadmin="-";
    	  if(unithead.equals("N"))
    		  unithead="-";
    	  if(billingapprover.equals("N"))
    		  billingapprover="-";
    	  if(boardmember.equals("N"))
    		  boardmember="-";
    	  if(applvl1.equals("N"))
    		  applvl1="-";
    	  if(applvl2.equals("N"))
    		  applvl2="-";
     %>	  
    	 <tr>
    	 <td class="formtr1"  style="text-align: left;"><%=++sno %></td>
    	 <td class="formtr1"  style="text-align: left;"><%=site %></td>
    	 <td class="formtr1"  style="text-align: left;"><%=user %></td>
    	 <td class="formtr1"  style="text-align: center"><%=localadmin %></td>
    	 <td class="formtr1"  style="text-align: center"><%=unithead %></td>
    	 <td class="formtr1"  style="text-align: center"><%=billingapprover %></td>
    	 <%if(strUserDivName.equalsIgnoreCase("Y") && SuserRole.equalsIgnoreCase("AD")) { %>
    	 <td class="formtr1"  style="text-align: center"><%=boardmember %></td>
    	 <%} %>
    	 <td class="formtr1"  style="text-align: center"><%=applvl1 %></td>
    	 <td class="formtr1"  style="text-align: center"><%=applvl2 %></td>
    	 <td class="formtr1"  width="11%" style="text-align: center;">
    	 <input type=button  size="12" value=" <%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage)%> "  class="formButton" onClick="return forwardDelete(<%=strSite %>,<%=struserName %>,<%=strAssignSite %>,<%=userid%>,<%=strAssignSite%>,'<%=unithead %>');" ></td>
    	 </tr> 
     <% } 
     if(!recfound){ %>
     <tr>
     <td class="formtr1" colspan="<%=col+1 %>"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage) %></td>
     </tr>
     <%} %>
<%-- </table>
  
  <table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	<%if(strUserDivName.equalsIgnoreCase("Y") && SuserRole.equalsIgnoreCase("AD")) {
		col=9;
		colwidth=100/9;
	} %> --%>  
      <tr>
      <td class="dataLabel" colspan=<%=col %>><b><%=dbLabelBean.getLabel("label.accessrights.userrights",strsesLanguage)%></b></td>	
     </tr>
     <tr align="center" > 
     	 <td class="formhead" width="4%"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
   		 <td class="formhead" width="<%=colwidth+4%>%">Access <%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>
   		 <td class="formhead" width="<%=colwidth+3%>%"><%=dbLabelBean.getLabel("label.mail.username",strsesLanguage)%></td>
         <td class="formhead" width="<%=colwidth-3%>%"><%=dbLabelBean.getLabel("label.master.localadmin",strsesLanguage)%></td>
		 <td class="formhead" width="<%=colwidth-3%>%"><%=dbLabelBean.getLabel("label.requestdetails.unithead",strsesLanguage)%></td> 
		 <td class="formhead" width="<%=colwidth%>%"><%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage)%></td>
		 <%if(strUserDivName.equalsIgnoreCase("Y") && SuserRole.equalsIgnoreCase("AD")) {%>
		 <td class="formhead" width="<%=colwidth-1%>%"><%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage)%></td>  
		 <%} %>
		 <td class="formhead" width="<%=colwidth%>%"><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage)%></td>
		 <td class="formhead" width="<%=colwidth%>%"><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage)%></td>
		 <td class="formhead" width="<%=colwidth-4%>%"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td> 
    </tr>
    
    <%
     recfound=false;
	 strSql="SELECT  uma.site_id as SiteId,isnull(dbo.sitename(uma.site_id), '') as SiteName,uma.USERID as UserId,DBO.user_name(uma.USERID) AS UserName,"+
			" case when uma.role_id='LA' then 'Y' else 'N' end as LocalAdmin,"+
			" case when uma.unit_head=1 then 'Y' else 'N' end as UnitHead, "+
			" case when approver_id is null then 'N' else 'Y' end as BillingApprover,"+
			" case when mbm.userid is null then 'N' else 'Y' end as BoardMember,"+
			" case when uma.approval_lvl1<>'' AND uma.approval_lvl1<>'N' then 'Y' else 'N' end as ApprovalLevel1,"+
			" case when uma.approval_lvl2<>'' AND uma.approval_lvl2<>'N' then 'Y' else 'N' end as ApprovalLevel2"+
			" FROM user_multiple_access  (NOLOCK) uma "+
			" left join m_billing_approver  (NOLOCK) mba on mba.approver_id = uma.userid and uma.site_id = mba.site_id "+
			" left join m_board_member  (NOLOCK) mbm on mbm.site_id=uma.site_id and uma.userid=mbm.userid and mbm.status_id=10"+
			" WHERE     (uma.userid ="+struserName+") and (uma.status_id = 10)"+  
			" union all  "+
			" SELECT mba.site_id,isnull(dbo.sitename(mba.site_id), '') as sitename,mba.approver_id,dbo.user_name(mba.approver_id),'N','N','Y','N','N','N'"+ 
			" FROM m_billing_approver  (NOLOCK) mba "+
			" WHERE (approver_id ="+struserName+") and not exists (SELECT 1 FROM user_multiple_access (NOLOCK)"+
			" WHERE site_id= mba.site_id and userid = mba.approver_id and (status_id = 10))"+
			" union all "+
			" SELECT mbm.site_id,isnull(dbo.sitename(mbm.site_id), ''),mbm.userid,dbo.user_name(mbm.userid),'N','N','N','Y','N','N'"+  
			" FROM m_board_member  (NOLOCK) mbm"+
			" WHERE(userid="+struserName+") and not exists (SELECT 1 FROM user_multiple_access (NOLOCK)"+
			" WHERE site_id= mbm.site_id and userid = mbm.userid and (status_id = 10))"+
			" and not exists (SELECT 1 FROM m_billing_approver (NOLOCK) "+
			" where site_id = mbm.site_id and approver_id=mbm.userid and status_id=10)"+
			" and status_id=10";
	  //System.out.println("strSql---show-->"+strSql);
	  rs=null;
	  rs       =   dbConBean.executeQuery(strSql);  
	  sno=0;
      while(rs.next())
      {
    	  recfound=true;
    	  siteid=rs.getString("SiteId");
    	  site=rs.getString("SiteName").trim();
    	  userid=rs.getString("UserId");
    	  user=rs.getString("UserName");
    	  localadmin=rs.getString("LocalAdmin");
    	  unithead=rs.getString("UnitHead");
    	  billingapprover=rs.getString("BillingApprover");
    	  boardmember=rs.getString("BoardMember");
    	  applvl1=rs.getString("ApprovalLevel1");
    	  applvl2=rs.getString("ApprovalLevel2");
    	  if(localadmin.equals("N"))
    		  localadmin="-";
    	  if(unithead.equals("N"))
    		  unithead="-";
    	  if(billingapprover.equals("N"))
    		  billingapprover="-";
    	  if(boardmember.equals("N"))
    		  boardmember="-";
    	  if(applvl1.equals("N"))
    		  applvl1="-";
    	  if(applvl2.equals("N"))
    		  applvl2="-";
     %>	
    <tr>
    	 <td class="formtr1"  style="text-align: left;"><%=++sno %>
    	 <input type=checkbox name="chk<%=sno%>" value="<%=siteid%>;<%=userid%>"></td>
    	 <td class="formtr1"  style="text-align: left;"><%=site %></td>
    	 <td class="formtr1"  style="text-align: left;"><%=user %></td>
    	 <td class="formtr1"  style="text-align: center"><%=localadmin %></td>
    	 <td class="formtr1"  style="text-align: center"><%=unithead %></td>
    	 <td class="formtr1"  style="text-align: center"><%=billingapprover %></td>
    	 <%if(strUserDivName.equalsIgnoreCase("Y") && SuserRole.equalsIgnoreCase("AD")) { %>
    	 <td class="formtr1"  style="text-align: center"><%=boardmember %></td>
    	 <%} %>
    	 <td class="formtr1"  style="text-align: center"><%=applvl1 %></td>
    	 <td class="formtr1"  style="text-align: center"><%=applvl2 %></td>
    	 <td class="formtr1"  width="11%" style="text-align: center;">
    	 <input type=button  size="12" value=" <%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage)%> "  class="formButton" onClick="return forwardDelete(<%=strSite %>,<%=struserName %>,<%=strAssignSite %>,<%=userid%>,<%=siteid%>,'<%=unithead %>');" ></td>
    	 </tr>
    <%} 
     if(!recfound){ %>
     <tr>
     <td class="formtr1" colspan="<%=col+1 %>"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage) %></td>
     </tr>
     <%} %>
     
     <%if(recfound){ %>
     <tr>
      <td class="dataLabel" colspan=<%=col %>><b><%=dbLabelBean.getLabel("label.accessrights.transferaccess",strsesLanguage)%></b></td>	
     </tr>
     <tr>
     <td class="formhead" colspan="2"><%=dbLabelBean.getLabel("label.accessrights.selectsiteaccess",strsesLanguage)%></td>
     <td colspan="2" class="formhead">
      <select name="accesstosite" id="selectsiteaccess" class="textBoxCss">
		    <option value="-1" ><%=dbLabelBean.getLabel("label.report.selectunit",strsesLanguage)%></option>
		    <%  
                sSqlStr	="SELECT DISTINCT ISNULL(SITE_ID,'-') AS SITE_ID, RTRIM(ISNULL(SITE_NAME,'-')) AS SITE_NAME FROM M_SITE WHERE STATUS_ID=10 AND (isnull(CLOSED_UNIT_FLAG,'')<>'y') ORDER BY 2 ";
                rs       =   dbConBean.executeQuery(sSqlStr);    						 
      	        while(rs.next())
                {
                 strSiteId	=	rs.getString("SITE_ID");       
              	 strSiteName	=	rs.getString("SITE_NAME"); 
			%>
		         <option value="<%=strSiteId%>" > <%=strSiteName%> </option>
		    <%  
		        }
         	    rs.close();
			%>
      </select>
      </td>
      <td colspan="2" class="formhead"><%=dbLabelBean.getLabel("label.accessrights.transferaccessto",strsesLanguage)%></td>
      <td colspan="2" class="formhead">
	      <Select id="transferaccessto" name="transeruser" class="textBoxCss">
				<option value="-1"><%=dbLabelBean.getLabel("label.pageaccesspermission.selectuser",strsesLanguage) %></option>
		  </select>
      </td>
      <td colspan="<%=col-1 %>" class="formhead" align="center">
      <input type="button" id="transfer" name="Submit" value="<%=dbLabelBean.getLabel("button.accessrights.transfer",strsesLanguage)%>"  class="formButton" onclick="return fun_transfer();">
      </td>
     </tr>
     <%} %>
     
  </table>
  <input type=hidden name="count" value="<%=sno%>">
<%} %>
<input type="hidden" name="flag" value="2">
</form>
</body>
</html>