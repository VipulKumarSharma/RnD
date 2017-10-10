<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:16 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			         :STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			   :This jsp file  for showing the deactive user information to the administrator from  M_USERINFO in the STAR 
 *Modification 		       :1. Added Employee  Code
				            2. Invisible Password information to super Admin 
						    3. code  added to check the click of Edit link, if it is from deactivated user list. 
							4: Added new functionality to search user on master deactive user list.on 19-May-08 by shiv Sharma
							5: Changing Search criterai for showing list on 18-Dec-09 by shiv sharma
 *Reason of Modification:1. 3/1/2007 
				            2. Password Security Purpose 
				             3. shiv sharma  
 *Date of Modification  :1. 
						             2. 17 May 2007 
 *Modified By			     :1. Shiv Sharma
						              2. Sachin Gupta 
						              3  shiv sharma 
 *Editor				:Editplus
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :01 Feb 2013
 *Description			:IE Compatibility Issue resolved
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :22 October 2013
 *Description			:charactercheck function is added.
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
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
// Variables declared and initialized
ResultSet rs			=		null;		// Object for ResultSet
ResultSet rs1			=		null;	

String	sSqlStr         =       "";                         // For sql Statements
int iCls                =       0;
String strStyleCls      =       "";
String strMessage       =    (request.getParameter("message")==null)?"":request.getParameter("message"); 

String strUsername=request.getParameter("username")==null?"":request.getParameter("username");

String strUsersitenew	 ="";		


%>

<!--Java Script-->
<script language=JavaScript >
function activeConfirm()
{

if(confirm('<%=dbLabelBean.getLabel("alert.master.areyousureyouwanttoactivetherecord",strsesLanguage)%>'))
	return true;
else
	return false;
}
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


function submitname()
  {
	// alert("sdsd");/*
    
            document.frm.action="M_deactiveUserList.jsp";
           frm.submit();
   
   
}
//charactercheck function is added by manoj chand on 22 oct 2013
function test1(obj1, length, str)
{	
	var obj;
	if(obj1=='username')
	{
		obj = document.frm.username;
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
 <base target="middle"> 
</head>
<form  name=frm method="post">
 <body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="38" class="bodyline-top">
	    <ul class="pagebullet"><li class="pageHead"><%=dbLabelBean.getLabel("label.user.starsdeactiveusers",strsesLanguage)%></li><font color="red"><%=strMessage%></font>
	    </ul>
	  </td>
      <td align="right" valign="bottom" class="bodyline-top">
   	    <table align="right" border="0" cellspacing="0" cellpadding="0">
          <tr align="right">
			<td>
			<ul id="list-nav">
			<li><a href="M_userList.jsp"><%=dbLabelBean.getLabel("label.user.activated",strsesLanguage)%></a></li>
			<li><a href="M_UserRegisterByAdmin.jsp?flag=new&closeFlag=inside"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage)%></a></li>
			
			
           <%
//New Check for local administrator
			if(!(SuserRoleOther.trim().equals("LA")))
				{
				  %>
					 <li><a href="M_userDeisgList.jsp"><%=dbLabelBean.getLabel("label.master.assignrole",strsesLanguage)%></a></li>
				  <%
				}
           %>
        	<li><a href="#" onClick="MM_openBrWindow('M_searchInitial.jsp','USER','scrollbars=yes,width=975,height=600,resizable=yes')"><%=dbLabelBean.getLabel("button.global.search",strsesLanguage)%></a></li>
            <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%></a></li>
            </ul>
			</td>
          </tr>
        </table>
	  </td> 
    </tr>
  </table>

  <br>
  <table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <tr> 
      <td width="5%" colspan=14  class="formhead">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;<%=dbLabelBean.getLabel("label.master.searchbyusername",strsesLanguage) %> &nbsp;
	    <input type="text" name="username" size="20"  class="textBoxCss"  onKeyUp="return test1('username', 100, 'cn')" >&nbsp; &nbsp;
		<input type=button value="  <%=dbLabelBean.getLabel("button.global.search",strsesLanguage) %>  " onclick="return submitname();"   class="formButton"> </td></td>
		
		<script language=JavaScript >   
          document.frm.username.value="<%=strUsername%>";   
		</script>
  </tr>
  <tr> 
    <td width="5%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.division",strsesLanguage)%></td>
    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>
    <td width="4%" class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.department",strsesLanguage)%></td>

  <td width="4%" class="formhead"><%=dbLabelBean.getLabel("label.master.empcode",strsesLanguage)%></td> 


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

    <td width="9%" class="formhead"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage)%></td>
    <td width="9%" class="formhead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
  </tr>

<%
	int iSno                         = 1;
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
	String sEmpcode="";
	String url								="";	 
	String strtext					="";

	// Customer funded projects and item wise booking
	//Sql to get the the item list and sanction_dtl_id from sanction_detail
  
	

//New Check for local administrator
	if((SuserRoleOther.trim().equals("LA")))
	{
	 
       ////--------------------this query will not show the result--------------  status_id=80
		sSqlStr="SELECT USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,dbo.SITEDETAILS(SITE_ID) AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,RTRIM(dbo.USER_NAME(USERID)) AS UNAME,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,PIN AS PIN1, LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL ,LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE FROM M_USERINFO WHERE STATUS_ID=80 AND SITE_ID="+strSiteIdSS+" AND APPLICATION_ID=1  ORDER BY 1,2,3,4 ";
		 url="M_UpdateProfile.jsp";
		 // System.out.println(">>>>>>>>>123>>>>>>>>>>>"+sSqlStr);  
	
	}
	else
	{
		
		if(strUsername.equals(""))  
		   {
			   strtext="";      
		   }else{
			   strtext="and (USERNAME like N'"+strUsername+"%' OR dbo.DIVISIONNAME(DIV_ID) like N'"+strUsername+"%' OR dbo.SITEDETAILS(SITE_ID) like N'"+strUsername+"%' OR dbo.DEPARTMENTNAME(DEPT_ID) like N'"+strUsername+"%' OR dbo.USER_NAME(USERID) like N'%"+strUsername+"%' OR EMAIL like N'%"+strUsername+"%' OR ROLE_ID = N'"+strUsername+"' OR EMP_CODE = N'"+strUsername+"')";      
		   }
		 sSqlStr="SELECT USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,dbo.SITEDETAILS(SITE_ID) AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,RTRIM(dbo.USER_NAME(USERID)) AS UNAME,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,PIN AS PIN1, LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL, LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE FROM M_USERINFO WHERE STATUS_ID=30 AND APPLICATION_ID=1 "+strtext+"   ORDER BY USERNAME";
	     
		// url="Admin_User_Profile_Edit.jsp";
		  url="M_UpdateProfile.jsp";

		 //System.out.println(">>>>>>>>>>2345>>>>>>>>>>"+sSqlStr);  

	}
	
//


 rs1   = dbConBean1.executeQuery(sSqlStr);

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
		if(sApproverLevel.equalsIgnoreCase("None"))
			sApproverLevel=dbLabelBean.getLabel("label.master.none",strsesLanguage);
		if(sApproverLevel.equalsIgnoreCase("Approver Level 1"))
			sApproverLevel=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage);
		if(sApproverLevel.equalsIgnoreCase("Approver Level 2"))
			sApproverLevel=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage);
		if(sApproverLevel.equalsIgnoreCase("Global Approver"))
			sApproverLevel=dbLabelBean.getLabel("label.global.globalapprover",strsesLanguage);
		sEmpcode    =rs.getString("EMP_CODE"); 
		 

 
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
    <td  class="<%=strStyleCls%>" width="9%"><%=sDivName%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sSiteName%></td>
	<td class="<%=strStyleCls%>" width="4%"><%=sDeptName%></td>
	
     <td class="<%=strStyleCls%>" width="4%"><%=sEmpcode%></td>
      
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

    <td class="<%=strStyleCls%>" width="9%" align="center" nowrap="nowrap">
	<%//Vijay 09/04/2007 Added the Edit link%> <!-- Added a flag Deactiveflag by shiv on 24-May-07 -->
	  <a href="M_UpdateProfile.jsp?userId=<%=strUserId%>&flag=0&Deactiveflag=1"><%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage)%></a> | <br>
	<a href="M_userActive.jsp?userId=<%=strUserId%>" onClick="return  activeConfirm();"><%=dbLabelBean.getLabel("link.user.active",strsesLanguage)%></a> | <br>
	<a href="M_userPermanentDelete.jsp?userId=<%=strUserId%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage)%></a>
	</td>
  </tr>
<%
		iSno++;				
	}
//	rs.close();
//	dbConBean.close();    //Close Connection
	
%>

<%

/////////////new code for showing local admin user with multiple site open 

 /*sSqlStr="SELECT SITE_ID FROM USER_MULTIPLE_ACCESS WHERE STATUS_ID=10  AND USERID IN (SELECT USERID FROM M_USERROLE WHERE USERID="+Suser_id+" AND STATUS_ID=10) AND SITE_ID IN(SELECT SITE_ID FROM M_USERROLE WHERE USERID="+Suser_id+" AND STATUS_ID=10)";
*/
 
 sSqlStr="SELECT distinct site_id FROM m_userrole where userid="+Suser_id+" and status_id=10";

 rs1   = dbConBean1.executeQuery(sSqlStr);

 while(rs1.next())
	{
		strUsersitenew          = rs1.getString(1).trim(); 
          
sSqlStr="SELECT USERID, dbo.DIVISIONNAME(DIV_ID) AS DIV,dbo.SITEDETAILS(SITE_ID) AS SITE,ISNULL(dbo.DEPARTMENTNAME(DEPT_ID),'-') AS DEPT,RTRIM(dbo.USER_NAME(USERID)) AS UNAME,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,USERNAME ,EMAIL,ISNULL(ROLE_ID,'') AS ROLE,PIN,USERID,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,PIN AS PIN1, LTRIM(RTRIM(ISNULL(APPROVER_LEVEL,'0'))) AS APPROVER_LEVEL ,LTRIM(RTRIM(ISNULL(EMP_CODE,'-'))) AS EMP_CODE FROM M_USERINFO WHERE STATUS_ID=30 AND SITE_ID="+strUsersitenew+" AND APPLICATION_ID=1  and  USERNAME like '"+strUsername+"%'  ORDER BY USERNAME";

 
   

   rs   = dbConBean.executeQuery(sSqlStr);
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
		sEmpcode    =rs.getString("EMP_CODE"); 
		 

 
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
    <td  class="<%=strStyleCls%>" width="9%"><%=sDivName%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sSiteName%></td>
	<td class="<%=strStyleCls%>" width="4%"><%=sDeptName%></td>
	
     <td class="<%=strStyleCls%>" width="4%"><%=sEmpcode%></td>
      
    <td class="<%=strStyleCls%>" width="9%"><%=sName%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sDesigid%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sUsername%></td>
<%
//New Check for local administrator
	if(SuserRole.trim().equals("AD"))
	{
%>
    <td class="<%=strStyleCls%>" width="9%"><%=sPswd%></td>
<%
	}
%>
    <td class="<%=strStyleCls%>" width="9%"><%=sEmail%></td>
    <td class="<%=strStyleCls%>" width="9%"><%=sRole%></td>

	<td class="<%=strStyleCls%>" width="9%"><%=sApproverLevel%></td>

    <td class="<%=strStyleCls%>" width="9%"><%=sCreatedDate%></td>

    <td class="<%=strStyleCls%>" width="9%" align="center">
	<%//Vijay 09/04/2007 Added the Edit link%>
	 <a href="M_UpdateProfile.jsp?userId=<%=strUserId%>&flag=0&Deactiveflag=1"><%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage)%></a>| <!-- Added a flag Deactiveflag by shiv on 24-May-07 -->
	<a href="M_userActive.jsp?userId=<%=strUserId%>" onClick="return  activeConfirm();"><%=dbLabelBean.getLabel("link.user.active",strsesLanguage)%></a> |
	<a href="M_userPermanentDelete.jsp?userId=<%=strUserId%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage)%></a>
	</td>
  </tr>
<%
		iSno++;				
	}
	}
	rs.close();
dbConBean.close();
rs1.close();
dbConBean1.close();
/////////////new code for showing local admin user with multiple site close


%>
 <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr>
</table>
</body>

</form>
</html>
