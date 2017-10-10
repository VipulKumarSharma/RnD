	
	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:SACHIN GUPTA
	 *Date of Creation 		:24 August 2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This jsp file  for showing user information to the administrator from  M_USERINFO in the STAR Database 
	 *Modification 		    :    1.Invisible Password information to super Admin 
	                             2.Code added by shiv on 03-Jul-07 for showing  action message on the top of page 
								 3.new code added for  showing popup for view password of resent password reset   on 27-Feb-08  by Shiv Sharma 
								 4:Added new functionality to search user on master active user list.on 19-May-08 by shiv Sharma
								 5:Added new waiting image for showing list on 18-Dec-09 by shiv sharma
								 6:Changing Search criterai for showing list on 18-Dec-09 by shiv sharma
								   
	  
	 *Reason of Modification:    1. Password Security Purpose 
	 *Date of Modification  :    1. 17 May 2007 
	 *Modified By			:    1. Sachin Gupta 
	 *Editor				:    Editplus
	 
	 *Modification  		:	 Add a separate TAB where Super Admin can see the list of deleted users of any site.
	 *Date of modification  :    04 Jan 2011
	 *Modified by			:	 Manoj Chand
	 *Editor				:	 Eclipse 3.5
	 
	 *Modified by			:	 Manoj Chand
	 *Modification  		:	 Change the height and width of search screen.
	 *Date of modification  :    04 Jan 2011
	 
	 *Modified By	        :	 MANOJ CHAND
	 *Date of Modification  :	 04 Feb 2013
	 *Description			:	 IE Compatibility Issue resolved
	 
	 *Modified By	        :	 MANOJ CHAND
	 *Date of Modification  :	 03 May 2013
	 *Description			:	 AD SYNC implemented
	 
	 *Modified By	        :	 MANOJ CHAND
	 *Date of Modification  :	 08 August 2013
	 *Description			:	 Access Rights button provided.
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :22 October 2013
	 *Description			:charactercheck function is added.
	 *******************************************************/
	%>
	
	<%@ page pageEncoding="UTF-8" %>
	<%@page import="java.net.URLDecoder"%>
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
	<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
	
	 
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	
	<!-- new code added for  showing popup for view password of resent password reset   on 27-Feb-08-->
	<head>
	<script language="javascript" src="ScriptLibrary/shortcut.js?buildstamp=2_0_0"></script>
	<script language="javascript">
	  shortcut.add("Alt+F7",function() {
	         	window.open("userResetpasswordmail.jsp",'SEARCH','scrollbars=no,resizable=no,width=600,height=300');
	}
	);
	
	
	function submitname()
	{ 	 
			 document.forms["frm"].searchFlag.value ="true";
	         document.frm.action="M_userList.jsp";
	         openWaitingProcess();
	         frm.submit();
	}
// function added to open adsyncdata page.
	function showadusersync(){
		window.open("M_ADUserSync.jsp",'ADUSERSYNC','resizable=no,scrollbars=no,top=20,left=0,width=1007,height=535');
	}
	//charactercheck function is added by manoj chand on 22 oct 2013
	function test1(obj1, length, str)
	{	
		var obj;
		if(obj1=='username')
		{
			obj = document.frm.username;
			upToTwoHyphen(obj);
		}
		
		charactercheckSearch(obj,str);
		spaceChecking(obj);		
	}
	
	function charactercheckSearch(e,t){
		if(t=="cn") {
		mikExp=/[$\\#%\^\&\*\[\]\+\{\}\`\~\=\|\,\'\"\?\/\>\<\!\:\;]/;
		}

		var n=e.value;
		var r=n.length;
		if(r>0){
			for(var i=0;i<r;i++){
				var s=e.value.charAt(i);
				if(s.search(mikExp)!=-1){
					var o=e.value.substring(0,i);
					var u=e.value.substring(i+1,r);
					e.value=o+u;
					i--;
				}
			}
		}
	}	
	 
	</script>
	
	
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	<%
	// Variables declared and initialized
	ResultSet rs			=		null;			  // Object for ResultSet
	ResultSet rs1			=		null;			  // Object for ResultSet
	
	String	sSqlStr         =       "";                         // For sql Statements
	int iCls                =       0;
	String strStyleCls      =       "";
	String strUserIdnew           = ""; 
	String strUsersitenew          = "";
	
	// code added by shiv on 03-Jul-07 for showing  action message on the top of page
	String strMessage=null;
	String strMessage1 = URLDecoder.decode((request.getParameter("strMessage")==null) ? "" : request.getParameter("strMessage"), "UTF-8");
	//System.out.println("strMessage1--->"+strMessage1);
	
	
	//String strAlfabet=request.getParameter("alfabet")==null?"":request.getParameter("alfabet");
	String strUsername=request.getParameter("username")==null?"":request.getParameter("username").trim();
	
	String strSearchFlag = (request.getParameter("searchFlag")==null)?"false":request.getParameter("searchFlag");
	 
	
	// System.out.println("strSearchFlag==="+strSearchFlag);
	
	
	
	if(strMessage==null)
	{
	strMessage=dbLabelBean.getLabel("label.master.starsactiveusers",strsesLanguage);
	}
	
	%>
	
	<!--Java Script-->
	
	<script language=JavaScript >
	function fun_start(){
		var msg='<%=strMessage1%>';
		if(msg!=''){
			alert(msg);
		}
	}
	
	
	function deleteConfirm()
	{
	
	if(confirm('<%=dbLabelBean.getLabel("alert.master.areyousurewanttodeactivate",strsesLanguage)%>')) 
		return true;
	else
		return false;
	}
	</script>
	
	<script language="JavaScript">
	function closeDivRequest()
	{
		document.getElementById("waitingData").style.visibility="hidden";	
	}
	function resetPassword(userId,email)
	{
		if(confirm('<%=dbLabelBean.getLabel("alert.master.areyousurewanttoresetpassword",strsesLanguage)%>'))
		{
	MM_openBrWindow('reset_password_mail.jsp?lang=<%=strsesLanguage%>&userId='+userId+'&email='+email,'SEARCH','scrollbars=yes,resizable=yes,width=300,height=250'); 
			return true;
		}
		else
			return false;
	}
	function MM_openBrWindow(theURL,winName,features) 
	{ 
	window.open(theURL,winName,features);
	}
	function openWaitingProcess() {
		var dv = document.getElementById("waitingData");
		if(dv != null)
		{
			var xpos = screen.width * 0.475;
			var ypos = screen.height * 0.30;   
			
			dv.style.position="absolute";       		
			dv.style.left=(xpos)+"px";
			dv.style.top=(ypos)+"px";
			document.getElementById("waitingData").style.display="";
			document.getElementById("waitingData").style.visibility="";	
		}
	}

	//added by manoj chand on 07 may 2013 to add sid where blank
	function addSID(userId,domain,winuserid)
	{
		
		if(confirm('<%=dbLabelBean.getLabel("alert.user.doyouwandtoaddsid",strsesLanguage)%>'))
		{
			var result=fn_updatesid(domain,winuserid);
			//alert('result-->'+result);
			if(result=='0'){
				alert('SID added successfully');
				var ids='id'+userId;
				var spnid='spn'+userId;
				document.getElementById(ids).style.display='none';
				document.getElementById(spnid).style.display='none';
			}else if(result=='1'){
				alert('SID Update Failed');
			}
			else if(result=='2'){
				alert('No Record Found In AD');
			}
			else{
				alert('Error occured in database operation');
			}
		}
		else
			return false;
	}
	//added by manoj chand on 07 may 2013 to add sid where blank
	function fn_updatesid(var_domain,var_winuserid){
		 var res="";
		var urlParams = "strFlag=UpdateSID&domain="+var_domain+"&winuserid="+var_winuserid;
		jQuery.ajax({ 
            type: "post",
            url: "AjaxMaster.jsp",
            data: urlParams,
            async:false,
            success: function(result){
            res = result.trim();
            },
			error: function(){
				alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
            }
          });

        return res;
	}
	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g,"");
	};

	
	</script>
	 <base target="middle"> 
	</head>
	<form name="frm">  
	<body onload="fun_start();">
	<input type="hidden" name="searchFlag" value="">
	
	<div id="waitingData" style="display:none;"> 	    
		<center>
			<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
			<br>   
			<font color="#606060" style="font-size:14px;font-weight:bold;font-family:Verdana, Arial, Helvetica, sans-serif;">   
			<span id="pleaseWait">Please Wait  
			</span>
			</font>  
		</center>
	</div>
	
	<script language="javaScript">  
		openWaitingProcess();
	</script>
	<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td height="38" class="bodyline-top">
		    <ul class="pagebullet">
		    	<li class="pageHead"><%=strMessage%></li> 
		    </ul>
		  </td>
	      <td align="right" valign="bottom" class="bodyline-top">
	   	    <table border="0" cellspacing="0" cellpadding="0">
	          <tr>
	          <td align="right">
	<ul id="list-nav">
			<li><a href="#" onClick="MM_openBrWindow('requisitionAttachment_Policy.jsp','POLICY','scrollbars=yes,resizable=no,width=750,height=550')"><%=dbLabelBean.getLabel("label.master.uploadpolicy",strsesLanguage)%></a></li>
	<%
	/*try
	{*/
	//New Check for local administrator
		if(!(SuserRoleOther.trim().equals("LA")))
		{
			 
	%>
				<li><a href="M_UnitHeadList.jsp"><%=dbLabelBean.getLabel("label.requestdetails.unithead",strsesLanguage)%></a></li>
				<li><a href="M_localAdminUserList.jsp"><%=dbLabelBean.getLabel("label.master.localadmin",strsesLanguage)%></a></li>
	<%
		}
	%>
				
				<li><a href="M_deactiveUserList.jsp"><%=dbLabelBean.getLabel("label.master.deactivated",strsesLanguage)%></a></li>
				<li><a href="M_deletedUserList.jsp"><%=dbLabelBean.getLabel("label.master.deleted",strsesLanguage)%></a></li>
	            <li><a href="M_UserRegisterByAdmin.jsp?flag=new&closeFlag=inside"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage)%></a></li>
	<%
	//New Check for local administrator
		if(!(SuserRoleOther.trim().equals("LA")))
		{
		
	%>
	            <li><a href="M_userDeisgList.jsp"><%=dbLabelBean.getLabel("label.master.assignrole",strsesLanguage)%></a></li>
	            <!-- <li><a href="M_userRights.jsp">Assign Rights</a></li> -->
	<%
		}
	%>
	        	<li><a href="#" onClick="MM_openBrWindow('M_searchInitial.jsp','USER','scrollbars=yes,width=1000,height=600,resizable=no')"><%=dbLabelBean.getLabel("button.global.search",strsesLanguage)%></a></li>
	            <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%></a></li>
	            </ul>
	            </td>
	          </tr>
	        </table>
		  </td> 
	    </tr>
	  </table>
	
	  <br>
	  <table id="searchButtonTable" width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	   <tr>
	    <td height="1" align="left"  class="formhead">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;<%=dbLabelBean.getLabel("label.global.search",strsesLanguage)%> &nbsp;
			<input type="text" name="username" size="20"  class="textBoxCss"  onKeyUp="return test1('username', 100, 'cn')" >&nbsp; &nbsp;
					<script language=JavaScript >   
                            document.frm.username.value="<%=strUsername%>";  
					</script>
 
				<input type=button value="  <%=dbLabelBean.getLabel("button.global.search",strsesLanguage)%>  " onclick="return submitname();"   class="formButton">
				<%
					if(SuserRole.trim().equals("AD"))
						{
				%>
				 			&nbsp;&nbsp;&nbsp;&nbsp; <input type=button value="  <%=dbLabelBean.getLabel("label.user.adusersync",strsesLanguage)%>  " onclick="return showadusersync();" class="formButton">
				 <%} %> 
			</td>  
	  </tr>
	  </table>	  
	  <table id="searchResultTable" width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">	   
	  <%if(strSearchFlag.equals("true")){ %>
	  <tr> 
	    <td width="5%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
	<%
	//New Check for local administrator
		if(SuserRole.trim().equals("AD"))
		{
	%>
		<td width="5%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.master.userid",strsesLanguage)%></td>
	<%
		}
	%>
	    <td width="9%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.requestdetails.division",strsesLanguage)%></td>
	    <td width="7%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>
	    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.department",strsesLanguage)%></td>
		<td width="11%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.master.empcode",strsesLanguage)%></td><!--  3/1/2007   -->
	    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.name",strsesLanguage)%></td>
		<td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></td>
	    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.mail.username",strsesLanguage)%></td>
	<%
	//New Check for local administrator
		if(SuserRole.trim().equals("AD"))
		{
	%>
		<!--Changed on 17 May by Sachin start-->
	    <!--<td width="9%" class="formhead">Pin</td>-->
		<!--Changed on 17 May by Sachin end-->
	<%
		}
	%>
	    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.mylinks.email",strsesLanguage)%></td>
	    <td width="9%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.master.role",strsesLanguage)%></td>
		<td width="9%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.master.approverlevel",strsesLanguage)%></td>
	    <td width="9%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage)%></td>
	    <td width="9%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.relievingdate",strsesLanguage)%></td>
	    <td width="9%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
	  </tr>
	
	<%
	    session.removeAttribute("userSiteList");
		int iSno                              = 1;
		String strUserId                 = "";
		String sDivName					 = "";
		String sSiteName				 = "";
		String sDeptName				 = "";
		String sName					 = "";
		String sCreatedDate				 = "";
		String sUsername				 = "";
		String sEmail					 = "";
		String sRole					 = "";
		String sPswd					 = "";	
		String sUserid					 = "";
		String sDesigid					 = "";
		String strChkBudAgainstUser		 = "";                                                                                              
		String sUserPin					 = "";
		String sApproverLevel			 = "";
		String sEmpcode                 ="";
		String url								="";	
		String strtext					="";
		String strWinuserId = "";
		String strDomainName = "";
		String strSid = "";
		String sRelievingDate	= "";
		// Customer funded projects and item wise booking
		//Sql to get the the item list and sanction_dtl_id from sanction_detail
	
		//New Check for Super administrator
		
	    sSqlStr="SELECT USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,dbo.SITEDETAILS(SITE_ID) AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,RTRIM(dbo.USER_NAME(USERID)) AS UNAME,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,PIN AS PIN1, LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL,LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE, ISNULL(.DBO.CONVERTDATEDMY1(DISABLEDTIME),'-') AS DISABLEDTIME FROM M_USERINFO WHERE STATUS_ID=10 AND APPLICATION_ID=1  ORDER BY 1,2,3,4 ";
		
	
	//New Check for local administrator
		if((SuserRoleOther.trim().equals("LA")))
		{
			 /*sSqlStr="SELECT USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,dbo.SITEDETAILS(SITE_ID) AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,RTRIM(dbo.USER_NAME(USERID)) AS UNAME,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,PIN AS PIN1, LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL,LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE FROM M_USERINFO WHERE STATUS_ID=10  AND APPLICATION_ID=1  ORDER BY 1,2,3,4 ";
	        original*/
	
	          
	
	
			//// this query will not produce result   bcoz---------------- status_id is  30------------------------------------- 
		      sSqlStr="SELECT   USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,dbo.SITEDETAILS(SITE_ID) AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,RTRIM(dbo.USER_NAME(USERID)) AS UNAME,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,PIN AS PIN1, LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL,LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE, ISNULL(.DBO.CONVERTDATEDMY1(DISABLEDTIME),'-') AS DISABLEDTIME FROM M_USERINFO WHERE STATUS_ID=80 AND SITE_ID="+strSiteIdSS+" AND APPLICATION_ID=1  ORDER BY 1,2,3,4,5 ";
	  		//// this query will not produce result   bcoz---------------- status_id is  30------------------------------------- 
	
	        url="M_UpdateProfile.jsp"; 
	   }
	   else
	   {
		   if(strUsername.equals(""))  
		   {
			   strtext="";      
		   }else{
			   strtext="and (USERNAME like N'"+strUsername+"%' OR dbo.DIVISIONNAME(DIV_ID) like N'"+strUsername+"%' OR dbo.SITEDETAILS(SITE_ID) like N'"+strUsername+"%' OR dbo.DEPARTMENTNAME(DEPT_ID) like N'"+strUsername+"%' OR dbo.USER_NAME(USERID) like N'%"+strUsername+"%' OR EMAIL like N'%"+strUsername+"%' OR ROLE_ID = N'"+strUsername+"' OR EMP_CODE = N'"+strUsername+"')";      
		   }
		    sSqlStr="SELECT USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,ISNULL(dbo.SITEDETAILS(SITE_ID),'') AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,ISNULL(RTRIM(dbo.USER_NAME(USERID)),'') AS UNAME,ISNULL(dbo.CONVERTDATE(C_DATE),'') AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,ISNULL(dbo.DESIGNATIONNAME(DESIG_ID),'')  AS DESIG_ID,PIN AS PIN1, LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL,LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE,ISNULL(WIN_USER_ID,'') as WIN_USER_ID,ISNULL(DOMAIN_NAME,'') as DOMAIN_NAME,OBJECTSID, ISNULL(.DBO.CONVERTDATEDMY1(DISABLEDTIME),'-') AS DISABLEDTIME  FROM M_USERINFO WHERE STATUS_ID=10 AND APPLICATION_ID=1  "+strtext+" ORDER BY USERNAME";
			url="Admin_User_Profile_Edit.jsp";
			//System.out.println("sSqlStr--->"+sSqlStr);
	   }
	  	rs   = dbConBean.executeQuery(sSqlStr);//stmt.executeQuery(sSqlStr);
		while(rs.next())
		{
			//System.out.println("**********************************************************");
			strUserId           = rs.getString(1);  
			sDivName			= rs.getString(2);
			sSiteName			= rs.getString(3);
			sDeptName			= rs.getString(4);
			sName				= rs.getString(5);
			sCreatedDate		= rs.getString(6);
			sUsername			= rs.getString(7);
			sEmail				= rs.getString(8);
			sRole				= rs.getString(9);
			sPswd				= rs.getString(10);
	
			//System.out.println("before decrypt ="+ sPswd);
	        sPswd               = dbUtilityBean.decryptFromDecimalToString(sPswd); 
			//System.out.println("after decrypt===="+sPswd);
	
			sUserid				= rs.getString(11);
			sDesigid			= rs.getString(12);
	    	sUserPin			= rs.getString(13);
	
			sApproverLevel      = rs.getString(14); 
			sApproverLevel      = dbUtilityBean.getApproverLevelNameFromNo(sApproverLevel);     //Get the label name correspond to the no
			if(sApproverLevel.equalsIgnoreCase("None"))
				sApproverLevel=dbLabelBean.getLabel("label.master.none",strsesLanguage);
			if(sApproverLevel.equalsIgnoreCase("Approver Level 1"))
				sApproverLevel=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage);
			if(sApproverLevel.equalsIgnoreCase("Approver Level 2"))
				sApproverLevel=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage);
			if(sApproverLevel.equalsIgnoreCase("Global Approver"))
				sApproverLevel=dbLabelBean.getLabel("label.global.globalapprover",strsesLanguage);
	        sEmpcode      = rs.getString("EMP_CODE");  
	        strWinuserId      = rs.getString("WIN_USER_ID");
	        strDomainName      = rs.getString("DOMAIN_NAME");
	        strSid      = rs.getString("OBJECTSID");
	        sRelievingDate = rs.getString("DISABLEDTIME");
	        //System.out.println("strWinuserId--->"+strWinuserId+"    strDomainName---->"+strDomainName+"   strSid--->"+strSid);
	        if(strSid==null)
	        	strSid="";
	
	    	if (iCls%2 == 0) 
	     	{ 
		    	strStyleCls="formtr2";
	        } 
			else
			{ 
		    	strStyleCls="formtr1";
	        } 
	        iCls++;
	%>
	
	<tr class="<%=strStyleCls%>"> 
	    <td class="<%=strStyleCls%>" width="5%"><%=iSno%></td>
	<%
	//New Check for local administrator
		if(SuserRole.trim().equals("AD"))
		{
	%>
		<td class="<%=strStyleCls%>" width="5%"><%=strUserId%> </td>
	<%
		}
	%>
	    <td  class="<%=strStyleCls%>" width="9%"><%=sDivName%></td>
	    <td class="<%=strStyleCls%>" width="7%"><%=sSiteName%></td>
		<td class="<%=strStyleCls%>" width="9%"><%=sDeptName%></td>
	
	     <td class="<%=strStyleCls%>" width="11%"><%=sEmpcode%></td><!-- 3/1/2007 Adding Employee Code -->
	
	
	    <td class="<%=strStyleCls%>" width="9%"><%=sName%></td>
	    <td class="<%=strStyleCls%>" width="9%"><%=sDesigid%></td>
	    <td class="<%=strStyleCls%>" width="9%"><%=sUsername%></td>
	<%
	//New Check for local administrator
		if(SuserRole.trim().equals("AD"))
		{
	%>
		<!--Changed on 17 May by Sachin start-->
	    <!--<td class="<%//=strStyleCls%>" width="9%"><%//=sPswd%></td>-->
		<!--Changed on 17 May by Sachin end-->
	<%
		}
	%>
	    <td class="<%=strStyleCls%>" width="9%"><%=sEmail%></td> 
	    <td class="<%=strStyleCls%>" width="9%"><%=sRole%></td>
	
		<td class="<%=strStyleCls%>" width="9%"><%=sApproverLevel%></td>
	
	    <td class="<%=strStyleCls%>" width="9%"><%=sCreatedDate%></td>
	     
		<td class="<%=strStyleCls%>" width="9%"><%=sRelievingDate%></td>
	
	    <td class="<%=strStyleCls%> rep-txt" width="9%" align="center" nowrap="nowrap">   
			  <!--  Admin_User_Profile_Edit orignal <a href="M_UpdateProfile.jsp?userId=<%=strUserId%>&flag=0"> -->   
		<a href="<%=url%>?userId=<%=strUserId%>&flag=0"><%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage)%></a> | <a href="M_userDelete.jsp?userId=<%=strUserId%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.master.deactive",strsesLanguage)%></a> | <br><a href="M_ApproverLevelSelection.jsp?userId=<%=strUserId%>&nextPage=activeUserList"><%=dbLabelBean.getLabel("label.master.approverlevel",strsesLanguage)%></a> | <br><a href="#" onClick="resetPassword('<%=strUserId%>','<%=sEmail%>')"><%=dbLabelBean.getLabel("link.master.resetpassword",strsesLanguage)%></a>
		| <br><a href="#" onclick="window.open('M_multipleSiteaccess.jsp?flag=yes&userId=<%=strUserId%>','SEARCH','top=150,left=170,scrollbars=yes,resizable=no,width=630,height=440')";><%=dbLabelBean.getLabel("link.master.multipleunits",strsesLanguage)%></a>   
		<%
		//added by manoj chand on 07 may 2013 to display ADD SID link
		if(SuserRole.trim().equals("AD") && !strDomainName.equals("") && !strWinuserId.equals("") && strSid.equals(""))
		{
		 %>
		 <span id="spn<%=strUserId%>">|</span> <br><a href="#" id="id<%=strUserId%>" onClick="addSID('<%=strUserId%>','<%=strDomainName.trim()%>','<%=strWinuserId.trim() %>')">AD SID</a>
		 <%} %>
		</td>
	  </tr>
	<%
			iSno++;				
		}
		//rs.close();
		//dbConBean.close();    //Close Connection
	/*}
	catch(Exception e)
	{
		Date dd = new Date();
	    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy hh:mm:ss zzz");		   
		String strLog = sdf.format(dd)+"::  Error in M_userList.jsp ====\n"+e;
		dbUtilityBean.appendToLog(strLog);		   
	}*/
		
	%>
	<% ///////////////NEW CODE ADDES BY SHIV ON  11 -April -2007  open 
	
	 if((SuserRoleOther.trim().equals("LA")))
	 {
	 
	 }
	             /*
				 sSqlStr="select site_id from user_multiple_access where status_id=10  and userid in (SELECT userid FROM m_userrole where userid="+Suser_id+" and status_id=10)";
	
				 */
	           
	          sSqlStr="SELECT distinct site_id FROM m_userrole where userid="+Suser_id+" and status_id=10";
			//  System.out.println("---------------------------"+sSqlStr);
	
	
	 
	
	    rs1   = dbConBean1.executeQuery(sSqlStr);
		
		while(rs1.next())
		{
			//strUserIdnew           = rs1.getString(1).trim();  
			strUsersitenew          = rs1.getString(1).trim(); 
			 
	
			//System.out.println("strUsersitenew");
	
			  sSqlStr="SELECT USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,dbo.SITEDETAILS(SITE_ID) AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,RTRIM(dbo.USER_NAME(USERID)) AS UNAME,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,ISNULL(dbo.DESIGNATIONNAME(DESIG_ID),'') AS DESIG_ID,PIN AS PIN1, LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL,LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE, ISNULL(.DBO.CONVERTDATEDMY1(DISABLEDTIME),'-') AS DISABLEDTIME FROM M_USERINFO WHERE STATUS_ID=10 AND SITE_ID="+strUsersitenew+" AND APPLICATION_ID=1 and  USERNAME like N'"+strUsername+"%'  ORDER BY USERNAME";
	   
	  		// System.out.println("--------asasasa--121221-----"+sSqlStr);
	          
	         rs   = dbConBean.executeQuery(sSqlStr);//stmt.executeQuery(sSqlStr);
		while(rs.next())
		{
			strUserId           = rs.getString(1);  
			sDivName			= rs.getString(2);
			sSiteName			= rs.getString(3);
			sDeptName			= rs.getString(4);
			sName				= rs.getString(5);
			sCreatedDate		= rs.getString(6);
			sUsername			= rs.getString(7);
			sEmail				= rs.getString(8);
			sRole				= rs.getString(9);
			sPswd				= rs.getString(10);
	
			//System.out.println("before decrypt ="+ sPswd);
	        sPswd               = dbUtilityBean.decryptFromDecimalToString(sPswd); 
			//System.out.println("after decrypt===="+sPswd);
	
			sUserid				= rs.getString(11);
			sDesigid			= rs.getString(12);
	    	sUserPin			= rs.getString(13);
	
			sApproverLevel      = rs.getString(14); 
			sApproverLevel      = dbUtilityBean.getApproverLevelNameFromNo(sApproverLevel);     //Get the label name correspond to the no  
	        sEmpcode      = rs.getString("EMP_CODE"); 
	        sRelievingDate = rs.getString("DISABLEDTIME");
	
	    	if (iCls%2 == 0) 
	     	{ 
		    	strStyleCls="formtr2";
	        } 
			else
			{ 
		    	strStyleCls="formtr1";
	        } 
	        iCls++;
	%>
	
		<tr class="<%=strStyleCls%>"> 
	    <td class="<%=strStyleCls%>" width="5%"><%=iSno%></td>
	    
	<%
	//New Check for local administrator
		if(SuserRole.trim().equals("AD"))
		{
	%>
		<td class="<%=strStyleCls%>" width="5%"><%=strUserId%></td>
	<%
		}
	%>
	    <td  class="<%=strStyleCls%>" width="9%"><%=sDivName%></td>
	    <td class="<%=strStyleCls%>" width="7%"><%=sSiteName%></td>
		<td class="<%=strStyleCls%>" width="9%"><%=sDeptName%></td>
	
	     <td class="<%=strStyleCls%>" width="11%"><%=sEmpcode%></td><!-- 3/1/2007 Adding Employee Code -->
	
	
	    <td class="<%=strStyleCls%>" width="9%"><%=sName%></td>
	    <td class="<%=strStyleCls%>" width="9%"><%=sDesigid%></td>
	    <td class="<%=strStyleCls%>" width="9%"><%=sUsername%></td>
	<%
	//New Check for local administrator
		if(SuserRole.trim().equals("AD"))
		{
	%>
	<!--Changed on 17 May by Sachin start-->
	    <!--<td class="<%=strStyleCls%>" width="9%"><%=sPswd%></td>-->
	<!--Changed on 17 May by Sachin end-->
	<%
		}
	%>
	    <td class="<%=strStyleCls%>" width="9%"><%=sEmail%></td>
	    <td class="<%=strStyleCls%>" width="9%"><%=sRole%></td>
	
		<td class="<%=strStyleCls%>" width="9%"><%=sApproverLevel%></td>
	
	    <td class="<%=strStyleCls%>" width="9%"><%=sCreatedDate%></td>
	    
	    <td class="<%=strStyleCls%>" width="9%"><%=sRelievingDate%></td>
	
	    <td class="<%=strStyleCls%> rep-txt" width="9%" align="center" nowrap="nowrap">
			  <!--  Admin_User_Profile_Edit orignal <a href="M_UpdateProfile.jsp?userId=<%=strUserId%>&flag=0"> -->
		<a href="M_UpdateProfile.jsp?userId=<%=strUserId%>&flag=0"><%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage)%></a> | <a href="M_userDelete.jsp?userId=<%=strUserId%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.master.deactive",strsesLanguage)%></a> |<br> <a href="M_ApproverLevelSelection.jsp?userId=<%=strUserId%>&nextPage=activeUserList"><%=dbLabelBean.getLabel("label.master.approverlevel",strsesLanguage)%></a> |<br> <a href="#" onClick="resetPassword('<%=strUserId%>','<%=sEmail%>')"><%=dbLabelBean.getLabel("link.master.resetpassword",strsesLanguage)%></a>
	
		</td>
	  </tr> 
			   
	
	<%
		iSno++;	
		}
	
	}rs.close();
	dbConBean.close();
	rs1.close();
	dbConBean1.close();
 %>
	 <tr>
	    <td height="1" colspan="2" align="center" class="bodyline-bottom">   </td>   
     </tr>
	 
	 
	  <tr class="<%=strStyleCls%>">
	    <td height="1"  align="center"   colspan="15" class="<%=strStyleCls%>">&nbsp; </td>
	  </tr>
	<%} %>
	</table>
	<script language="javaScript">
		closeDivRequest();
		
		$(function(){
			var tbWidth = $('table#searchResultTable').width();
			$('table#searchButtonTable').css({'width':""+tbWidth+"", 'border-bottom': 'solid 0px #ffffff'});
		});
	</script>
	</body>
	</form>
	</html>
