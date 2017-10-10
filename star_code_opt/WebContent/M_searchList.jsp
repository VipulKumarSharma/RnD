<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:24 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp file  for showing user information to the administrator from  M_USERINFO in the STAR Database *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 16 Apr 2012
 *Modification			: add two new column 1. approval level 2. workflow name in list.
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 06 July 2012
 *Modification			: showing default approver in search active user list.
 *******************************************************/
%>

<%@ page pageEncoding="UTF-8" %>
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
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script type="text/javascript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script>
<script type="text/javascript" language="text/javaScript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<script type="text/javascript" language="text/javaScript" src="ScriptLibrary/jquery.quicksearch.js?buildstamp=2_0_0"></script>

<style type="text/css">
.formtr6 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	BACKGROUND: #f7f7f7;
	COLOR: #373737;
	line-height: 21px;
}

.formtr5 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	BACKGROUND: #f2f2f2;
	COLOR: #373737;
	font-weight: normal;
	line-height: 21px;
}

div.quicksearch {
	font-size: 8pt;
	font-weight: bold;
	color: #000000;
	font-family: 'Arial, Sans-Serif';
}

div.quicksearch input {
	width: 100px;
	height: 18px;
	background: #ffffff;
	color: #666666;
	font-family: 'Arial, Sans-Serif';
	font-size: 9pt;
	border-bottom: #888888 1px solid;
	border-left: #888888 1px solid;
	border-right: #888888 1px solid;
	border-top: #888888 1px solid;
}
</style>

<%
// Variables declared and initialized
ResultSet rs 			=		null;			  // Object for ResultSet

String	sSqlStr         =       "";                         // For sql Statements
int iCls                =       0;
String strStyleCls      =       "";
String dataFlag		= "false" ;
%>

<!--Java Script-->
<script language=JavaScript >
function deleteConfirm()
{

if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage)%>'))
	return true;
else
	return false;
}
</script>

<script language="JavaScript">

 
function MM_openBrWindow(theURL,winName,features) 
{ 
window.open(theURL,winName,features);
}

function exportToExcel(intable){
	var dataFlag = document.getElementById("loadFlag").value;		
	
	if(dataFlag == "true"){ 
		intable = document.getElementById(intable);
		
	    this.table = intable.cloneNode(true);
	    this.table.setAttribute("border","1");
	    var cform = document.createElement("form");
	    cform.style.display = "none";
	    cform.setAttribute("method","POST");
	    cform.setAttribute("action","exporttoexcel.jsp");
	    cform.setAttribute("name","ExcelForm");
	    cform.setAttribute("id","ExcelForm");
	    cform.setAttribute("enctype","MULTIPART/FORM-DATA");
	    cform.encoding="multipart/form-data";
	    var ta = document.createElement("textarea");
	    ta.name = "ExcelTable";
	    var tabletext = this.table.outerHTML;
	    ta.defaultValue = tabletext;
	    ta.value = tabletext;
	    cform.appendChild(ta);
	    intable.parentNode.appendChild(cform);
	    cform.submit();
	    //clean up
	    ta.defaultValue = null;
	    ta = null;
	    tabletext = null;
	    this.table = null;
	}
	else {
		alert('<%=dbLabelBean.getLabel("alert.report.nodataforexporttoexcel",strsesLanguage) %>');
	}
}

function openWaitingProcess() {
	
	var height 	= $(document).height();
	var width 	= $(document).width();
	
    var bcgDiv 	= document.getElementById("divBackground");
    var dv = document.getElementById("waitingData");
    
    bcgDiv.style.height=height;
    bcgDiv.style.width=width;
    bcgDiv.style.display="block";
	
	if(dv != null)
	{
		var xpos = screen.width * 0.32;
		var ypos = screen.height * 0.26;   
		
		dv.style.position="absolute";       		
		dv.style.left=(xpos)+"px";
		dv.style.top=(ypos)+"px";
		document.getElementById("waitingData").style.display="";
		document.getElementById("waitingData").style.visibility="";	
	}
}

$(document).ready(function () {
	  if($("table#detailTable").find('tbody:first tr').length > 0) {
		  $("#detailTable tbody tr").quicksearch({
	             labelText: '<%=dbLabelBean.getLabel("label.global.search",strsesLanguage)%> : ',
	             attached: '#searchTd',
	             position: 'append',
	             delay: 100,             
	             loaderText: '',
	             onAfter: function() {
	                 if ($("#detailTable tbody tr:visible").length != 0) {
	                     $("#detailTable").trigger("update");
	                     $("#detailTable").trigger("appendCache");
	                     $("#detailTable tfoot tr").hide();
	                     $("#loader").hide();
	                 }
	                 else {
	                     $("#detailTable tfoot tr").show();
	                 }
	             }
	  		});
	  }
});

 </script>
 <base target="middle"> 
</head>
  
 

<%
String	strSqlStr	=""; // For sql Statements
String	strSiteId		=	null;	//object to stote id
String	strName		 = "";		//object to store name
String	strEmail	 = "";		//object o store the email id of the user
String	strRole		 = "";		//object to store the role of the user
String	strDesigid	 = "";		//object to store the designation of the user.
String  strFlag		=	"";		//object to store the search type
int		iSno		 = 1;		//object for storing count
String	strSearch	=	"";		//object for storing search criterion
String	strUsernm	=	"";		//object for storing username
String  strPin		=	"";		//object for storing password
int		intBreak	=	0;
String	strBreak	=	"";
String	strAfterBreak	=	"";
String sUserid="";
String sUsId="";
String  strId2="";
String  departmentid="";
String	username	="";
String	strAppLevel	="";
String	strWorkflowName	="";
String strDefaultApprover="";
String strDeptName="";
String strEmpCode="";
String strWinUserId		= "" ;
String strDomainName	= "" ;
String strApprL1		= "" ;
String strApprL2		= "" ;


	// Customer funded projects and item wise booking
	//Sql to get the the item list and sanction_dtl_id from sanction_detail
strSiteId				=	(request.getParameter("unit")==null || request.getParameter("unit").equals("") )?"-1":request.getParameter("unit").trim();	//get the condition on which the search is to be made
// out.println("strId ==>>>  unit-->>>>>--------"+strId);


departmentid				=	(request.getParameter("department")==null || request.getParameter("department").equals(""))?"-1":request.getParameter("department").trim();	//get the condition on which the search is to be made
  //out.println("strId1==>>> departmentid--------"+departmentid);

username				=	(request.getParameter("username")==null)?"":request.getParameter("username").trim();	//get the condition on which the search is to be made
// out.println("strId2 ==>>>  username----------"+strId2);
strFlag				=	(request.getParameter("flag")==null)?"":request.getParameter("flag");	//get the condition on which the search is to 
//System.out.println("strFlag ==>> "+strFlag);

//ISNULL(.DBO.ROLEDESC(ROLE_ID),'-') AS ROLE  noted it migthe be used for role description

%>
<body style="overflow-y:hidden">

<div id = "divBackground" style="position: absolute; z-index: 99; height: 100%; width: 100%; top: 0; left:0; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;display:none">
	<div id="waitingData" style="display: none;"> 	    
	<center>
		<img src="images/loader-circle.gif?buildstamp=2_0_0" width="50" height="50"/> 
		<br><br>
		<font color="#ffffff" style="font-size:14px;font-weight:bold;font-family:Verdana, Arial, Helvetica, sans-serif;">   
		<span id="pleaseWait">Please Wait...<br/>while data is loading</span>
		</font>  
	</center>
	</div>
</div>
<script>
	openWaitingProcess();
</script>
<form method="post" name="searchListFrm" action="M_searchList.jsp">


<table width="100%" align="" border="0" cellpadding="0" cellspacing="0" style="border-bottom: 1px solid lightgray;border-top: 1px solid lightgray;">
	<tr align="right" width="100%">
		<td class="formtr2" width="43%" style="padding-left: 1px;">
			<input type=button id="etex" value='<%=dbLabelBean.getLabel("label.report.exporttoexcel",strsesLanguage)%>' class="formButton-green" 
				style="font-size: 10px;" onClick="exportToExcel('detailTable');">
		</td>
		<td class="formtr2" width="42%" align="center">		
			<font color="#009f50" size="2" style="font-weight: bold;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;User Details List</font>
		</td>
		<td class="formtr2" width="16%" id="searchTd" align="right"></td>
	</tr>
</table>

<div id="dv" style="width:100%; left:1px; height:96%; position: absolute; overflow: auto;overflow-x: auto;">
	<table class="formborder" width="100%" border="0" cellpadding="2" cellspacing="1" align="" id="detailTable">
	<!-- <span id="main"> --> 
		<thead id="tableHead">
			<tr> 
			   	<th width="4%"  class="formhead" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></th>  
				<th width="17%" class="formhead" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.requestdetails.name",strsesLanguage)%></th>
				<th width="15%" class="formhead" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></th>
				<th width="15%" class="formhead" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.requestdetails.department",strsesLanguage)%></th>
				<th width="10%" class="formhead" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.master.empcode",strsesLanguage)%></th>
				<th width="21%" class="formhead" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.mylinks.email",strsesLanguage)%></th>
				<th width="5%"  class="formhead" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.master.role",strsesLanguage)%></th>
				<th width="14%" class="formhead" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.mail.username",strsesLanguage)%></th>
				
				<th width="14%" class="formhead" align="center" nowrap="nowrap">Windows User Id</th>
				<th width="10%" class="formhead" align="center" nowrap="nowrap">Domain Name</th>
				
				<th width="10%" class="formhead" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.master.approverlevel",strsesLanguage)%></th>
				
				<th width="14%" class="formhead" align="center" nowrap="nowrap">Approver Level 1</th>
				<th width="14%" class="formhead" align="center" nowrap="nowrap">Approver Level 2</th>
				
				<th width="8%" class="formhead" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.user.workflow",strsesLanguage)%></th>
				<th width="8%" class="formhead" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.user.defaultapprover",strsesLanguage)%></th>
			 </tr>
		</thead>

<%

String strAppend = "";

if(strFlag .equals("yes"))
{

	if(!strSiteId.equals("-1") && !departmentid.equals("-1") && !username.equals(""))
	{
		strAppend = "SITE_ID="+strSiteId+"  AND dept_id="+departmentid+"  AND  USERNAME like N'"+username +"%'  AND";
	}
	else if(!strSiteId.equals("-1") && !departmentid.equals("-1") && username.equals(""))
	{
		strAppend = "SITE_ID="+strSiteId+"  AND  dept_id="+departmentid+"  AND";
	}
	else if(!strSiteId.equals("-1") && departmentid.equals("-1") && !username.equals(""))
	{
		strAppend = "SITE_ID="+strSiteId+"  AND  USERNAME like N'"+username +"%'  AND";
	}
	else if(!strSiteId.equals("-1") && departmentid.equals("-1") && username.equals(""))
	{
		strAppend = "SITE_ID="+strSiteId+" AND";
	}
	else if(strSiteId.equals("-1") && departmentid.equals("-1") && !username.equals(""))
	{
		strAppend = "USERNAME like N'"+username +"%'  AND";
	}
	else
	{
		strAppend = "SITE_ID=-1 AND ";
	}
}
else
{
	strAppend = "SITE_ID=-1 AND ";

}


if(SuserRole != null && SuserRole.trim().equalsIgnoreCase("AD"))
	{
	//queries change by manoj chand on 13 april 2012 to fetch approval level and workflow name 
	//queries change by manoj chand on 06 JULY 2012 to fetch defaultapprover 
		//strSqlStr="SELECT RTRIM(dbo.USER_NAME(USERID)) AS UNAME,EMAIL,ISNULL(ROLE_ID,'-') AS ROLE,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,USERNAME,PIN,USERID FROM M_USERINFO WHERE  "+strAppend+"  STATUS_ID=10  AND APPLICATION_ID =1 ORDER BY FIRSTNAME ";
		strSqlStr="SELECT WIN_USER_ID, DOMAIN_NAME, RTRIM(dbo.USER_NAME(REPORT_TO)) AS APP1, RTRIM(dbo.USER_NAME(DEPT_HEAD)) AS APP2, RTRIM(dbo.USER_NAME(USERID)) AS UNAME,EMAIL,ISNULL(ROLE_ID,'-') AS ROLE,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,USERNAME,ISNULL(APPROVER_LEVEL,'0') AS APPROVER_LEVEL,ISNULL(SP_ROLE,'0') AS SP_ROLE,dbo.SITESOFDEFAULTAPPROVER(USERID) AS DEFAULTAPPROVER, ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE FROM M_USERINFO WHERE  "+strAppend+"  STATUS_ID=10  AND APPLICATION_ID =1 ORDER BY FIRSTNAME ";
   	}
	if(SuserRoleOther != null && SuserRoleOther.trim().equalsIgnoreCase("LA"))
	{
	//queries change by manoj chand on 13 april 2012 to fetch approval level and workflow name
	//queries change by manoj chand on 06 JULY 2012 to fetch defaultapprover
	   //strSqlStr="SELECT RTRIM(dbo.USER_NAME(USERID)) AS UNAME,EMAIL, ISNULL(ROLE_ID,'-') AS ROLE,.DBO.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,USERNAME FROM M_USERINFO                                               WHERE    "+strAppend+"    STATUS_ID=10 ";
	    strSqlStr="SELECT WIN_USER_ID, DOMAIN_NAME, RTRIM(dbo.USER_NAME(REPORT_TO)) AS APP1, RTRIM(dbo.USER_NAME(DEPT_HEAD)) AS APP2, RTRIM(dbo.USER_NAME(USERID)) AS UNAME,EMAIL,ISNULL(ROLE_ID,'-') AS ROLE,.DBO.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,USERNAME,ISNULL(APPROVER_LEVEL,'0') AS APPROVER_LEVEL,ISNULL(SP_ROLE,'0') AS SP_ROLE,dbo.SITESOFDEFAULTAPPROVER(USERID) AS DEFAULTAPPROVER, ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE FROM M_USERINFO WHERE    "+strAppend+"    STATUS_ID=10 ";
	}
	//System.out.println("8888888==="+strSqlStr);
    rs   = dbConBean1.executeQuery(strSqlStr);	 
    if(rs.next())
	{	dataFlag			= "true";
		do
		{
					strApprL1			= rs.getString("APP1");		
					strApprL2			= rs.getString("APP2");
					strWinUserId 		= rs.getString("WIN_USER_ID");
					strDomainName		= rs.getString("DOMAIN_NAME");
					strName		 		= rs.getString("UNAME");
					strEmail	 		= rs.getString("EMAIL");
					strRole		 		= rs.getString("ROLE");
					strDesigid	 		= rs.getString("DESIG_ID");
					strUsernm	 		= rs.getString("USERNAME");
					strAppLevel	 		= rs.getString("APPROVER_LEVEL");
					strWorkflowName		= rs.getString("SP_ROLE");
					strDeptName  		= rs.getString("DEPT");
					strEmpCode   		= rs.getString("EMP_CODE");
					strDefaultApprover 	= rs.getString("DEFAULTAPPROVER");
					
					if(strDefaultApprover==null || strDefaultApprover.equals(""))
						strDefaultApprover="-";
					if(strAppLevel.trim().equalsIgnoreCase("0"))
						strAppLevel=dbLabelBean.getLabel("label.master.none",strsesLanguage);
					else if(strAppLevel.trim().equalsIgnoreCase("1"))
						strAppLevel=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage);
					else if(strAppLevel.trim().equalsIgnoreCase("2"))
						strAppLevel=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage);
					else if(strAppLevel.trim().equalsIgnoreCase("3"))
						strAppLevel=dbLabelBean.getLabel("label.global.globalapprover",strsesLanguage);
					
					if(strWinUserId == null || strWinUserId.equals("")) {
						strWinUserId = "-" ;
					}
					if(strDomainName == null || strDomainName.equals("")) {
						strDomainName = "-" ;
					}
					if(strWorkflowName == null || strWorkflowName.equals("")) {
						strWorkflowName = "-" ;
					}
					if(strDeptName == null || strDeptName.equals("")) {
						strDeptName = "-" ;
					}
					if(strEmpCode == null || strEmpCode.equals("")) {
						strEmpCode = "-" ;
					}
					if(strDefaultApprover == null || strDefaultApprover.equals("")) {
						strDefaultApprover = "-" ;
					}
					if(strRole == null || strRole.equals("")) {
						strRole = "-" ;
					}
					if(strUsernm == null || strUsernm.equals("")) {
						strUsernm = "-" ;
					}
					if(strEmail == null || strEmail.equals("")) {
						strEmail = "-" ;
					}
					if(strName == null || strName.equals("")) {
						strName = "-" ;
					}
					if(strDesigid == null || strDesigid.equals("")) {
						strDesigid = "-" ;
					}
					if(strApprL1 == null || strApprL1.equals("")) {
						strApprL1 = "-" ;
					}
					if(strApprL2 == null || strApprL2.equals("")) {
						strApprL2 = "-" ;
					}
					
			if (iCls%2 == 0) 
			{ 
				strStyleCls="formtr6";
			} 
			else
			{ 
				strStyleCls="formtr5";
			} 
			iCls++;
%>
		<tbody>
			<tr class="<%=strStyleCls%>"> 
				<td class="<%=strStyleCls%>" width="4%"  align="center" nowrap="nowrap"><b><%=iSno%>.</b></td>
				<td  class="<%=strStyleCls%>"width="17%" align="center" nowrap="nowrap"><%=strName.trim()%></td>
				<td class="<%=strStyleCls%>" width="15%" align="center" nowrap="nowrap"><%=strDesigid.trim()%></td>
				<td class="<%=strStyleCls%>" width="15%" align="center" nowrap="nowrap"><%=strDeptName.trim()%></td>
				<td class="<%=strStyleCls%>" width="15%" align="center" nowrap="nowrap"><%=strEmpCode.trim()%></td>				
				<td class="<%=strStyleCls%>" width="21%" align="center" nowrap="nowrap"><%=strEmail.trim()%></td>
				<td class="<%=strStyleCls%>" width="5%" align="center" nowrap="nowrap"><%=strRole.trim()%></td>
				<td class="<%=strStyleCls%>" width="14%" align="center" nowrap="nowrap"><%=strUsernm.trim()%></td>
				
				<td class="<%=strStyleCls%>" width="14%" align="center" nowrap="nowrap"><%=strWinUserId.trim()%></td>
				<td class="<%=strStyleCls%>" width="10%" align="center" nowrap="nowrap"><%=strDomainName.trim()%></td>
				
				<!-- ADDED BY MANOJ CHAND ON 13 Apr 2012 to display approver level and workflow name -->
				<td class="<%=strStyleCls%>" width="10%" align="center" nowrap="nowrap"><%=strAppLevel.trim()%></td>
				
				<td class="<%=strStyleCls%>" width="14%" align="center" nowrap="nowrap"><%=strApprL1.trim()%></td>
				<td class="<%=strStyleCls%>" width="14%" align="center" nowrap="nowrap"><%=strApprL2.trim()%></td>
				
				<td class="<%=strStyleCls%>" width="8%" align="center" nowrap="nowrap"><%=strWorkflowName.trim()%></td>
				<td class="<%=strStyleCls%>" width="8%" align="center"><%=strDefaultApprover.trim()%></td>
			</tr>
			<%
		iSno++;				
	} while(rs.next());
} else {		
%>			<tr align="center"> 
			    <td colspan="15" class="formtr2" align="center" style="text-align: center">
			    	<font style="font-weight: bold;color: red;"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage)%></font>
			    </td>
			</tr>
<%
}
   rs.close();
   dbConBean1.close();
 %> 
 		</tbody>
 		<!-- </span>  -->
		<tfoot class="formtr1" style="text-align: center;font-weight: bold;color:red;">
        	<tr style='display:none;'>
	            <td colspan="15" class="formtr2" align="center" style="text-align: center">
			    	<font style="font-weight: bold;color: red;"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage)%></font>
			    </td>
          	</tr>
		</tfoot> 
	</table>
</div>
	<input type="hidden" id="loadFlag" value="<%=dataFlag%>" />
	<input type="hidden" name="va" />
</form>

<script type="text/javascript">
	$("#divBackground").css('display','none');
</script>

</body>
</html>
