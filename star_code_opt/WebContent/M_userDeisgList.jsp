<%
/***************************************************
 *The information contained here in is confidential and 
 **** proprietary to MIND and forms the part of the MIND ****** 
 *Author			  : Abhinav Ratnawat
 *Date of Creation : 25 August 2006
**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	  : STARS ****** 
**** Operating environment :Tomcat, sql server 2000 ******
**** Description : This is first jsp file  for listing all the  USER related information from the STAR database ******
*Modification 	 :	Add the unit in the list
*Reason of Modification: change suggested by MATA
*Date of Modification  :22 Nov 2006 
*Modified By	        :SACHIN GUPTA
**** Editor					:Editplus ******

*Modified By	        :MANOJ CHAND
*Date of Modification   :04 Feb 2013
*Description			:IE Compatibility Issue resolved
**********************************************************/
%>


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
<%--<%@ include  file="systemStyle.jsp" %>--%>
<%@ page import="java.sql.*" %>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<%@ page import = "src.connection.DbConnectionBean" pageEncoding="UTF-8" %>
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<%
DbConnectionBean bean = new DbConnectionBean(); 
DbConnectionBean beanDb = new DbConnectionBean();
String	sSqlStr=""; // For sql Statements
//Object to store sanction id
int iCls 					= 0;
String strStyleCls 			= "";
int iSno					= 1;
String sSqlStrUnitInfo 		= "";
String unitInfoIdFlag 		= "0";
String userNameFlag 		= "";
String unitInfoIdFlagUpdate = "";
String userNameFlagupdate 	= "";
String dataFlag				= request.getParameter("dataFlag")==null ? "false" : request.getParameter("dataFlag").trim();

unitInfoIdFlag				=	(request.getParameter("unitInfoId")==null || request.getParameter("unitInfoId").equals("0") )?"0":request.getParameter("unitInfoId").toString().trim();	//get the condition on which the search is to be made
userNameFlag				=	(request.getParameter("userName1")==null || request.getParameter("userName1").equals("0") )?"":request.getParameter("userName1").toString().trim();	//get the condition on which the search is to be made


String updatedflagCheck          =   (request.getParameter("updatedflag")==null || request.getParameter("updatedflag").equals("0") )?"0":request.getParameter("updatedflag").toString().trim();
//out.println("flag="+updatedflagCheck);
if(!updatedflagCheck.equals("0")){
//	out.println("in  get session=");
unitInfoIdFlag				=	session.getAttribute("updateFlagUnitId").toString();	//get the condition on which the search is to be made
userNameFlag				=	session.getAttribute("updateFlagName").toString().trim();	//get the condition on which the search is to be made
}
if(!unitInfoIdFlag.equals("0"))
{
//	out.println("in  set session=");
	session.setAttribute("updateFlagUnitId", unitInfoIdFlag);
	session.setAttribute("updateFlagName", userNameFlag);
}
/* out.println("unit-->>>>>--------"+unitInfoIdFlag); */
//out.println("chkbox-->>>>>--------"+request.getParameter("chk1"));

%>

	<script type="text/javascript" language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
	<script type="text/javascript" language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	
	<script type="text/javascript" language="JavaScript" src="jsGrid/js/jquery-1.10.2.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/js/jquery-ui.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/js/jquery.validate.min.1.9.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/js/json2.js?buildstamp=2_0_0"></script>
	<script type="text/javascript" language="JavaScript" src="jsGrid/js/jquery-ui-sliderAccess.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/js/jquery-ui-timepicker-addon.js?buildstamp=2_0_0"></script>
 
	<script type="text/javascript" language="JavaScript" src="jsGrid/js/jsgrid.js?buildstamp=2_0_0"></script>
    
	<script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.core.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.load-indicator.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.load-strategies.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.sort-strategies.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.field.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.field.text.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.field.number.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.field.select.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.field.checkbox.js?buildstamp=2_0_0"></script>
    <script type="text/javascript" language="JavaScript" src="jsGrid/src/jsgrid.field.control.js?buildstamp=2_0_0"></script>
<script language="JavaScript">

$( document ).ready(function() {
	var dataFlag = '<%=dataFlag%>';
	
	if(dataFlag == 'true') {
		$('#dataDiv').show();
		
	} else {
		$('#dataDiv').hide();
	}
	
	$("#updateId").click(function(){
		$("#updatedflag").val("1");
	//	location.reload(false);
		}); 
	$("#go").click(function(){
		if(document.getElementById("unitInfoId").value==0){
		  alert("Please select unit.");
		  return false;
		}
		}); 
	
	var Row = document.getElementById("rowId");
	if(Row!=null){
	var Cells = Row.getElementsByTagName("td");
	if(Cells[0].innerText=='Data not found');{
		$("#updateId").hide(); 
	}
	}
	  
	var rowCount = $('#tbID tr').length;
	if((rowCount===2)){
		$("#updateId").hide(); 
	} 
	$("#unitInfoId").val(<%=unitInfoIdFlag%>); 
});

function MM_openBrWindow(theURL,winName,features) 
{	window.open(theURL,winName,features);
}
 </script>
 <base target="middle"> 
</head>
<form name = "frm" method ="post"  action="RoleAssignment.jsp">
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.user.assignroletouser",strsesLanguage)%></li>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	 <table align="right" border="0" cellspacing="0" cellpadding="0">
		<tr align="right">
		<td>
		<ul id="list-nav">
		<li><a href="#" class="rtlinks" onClick="MM_openBrWindow('M_searchInitial.jsp','USER','scrollbars=yes,width=975,height=600,resizable=yes')"><%=dbLabelBean.getLabel("button.global.search",strsesLanguage)%></a></li>
		<li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%></a></li>
		</ul>
			</td>
		</tr>
	 </table>
    </td>
   </tr>
</table>
 <!--  <input type="hidden" name="updatedflag" id="updatedflag" value="1"> -->
<br>
  <table id="tbID" width="80%" align="center" border="0" cellpadding="5" cellspacing="0" class="formborder" style="margin-bottom: 5px;">
  <tr class="formhead">
  
	  <td width="20%" style="text-align: right;" >
	  	User <%=dbLabelBean.getLabel("label.requestdetails.name",strsesLanguage)%>
	  </td>
	  
	  <td width="20%" > 
	  	<input type="text" id="userName1" style="width: 99%" name="userName1" value="<%=userNameFlag %>" class="textBoxCss"> 
	  </td>
	  
	  <td width="8%" style="text-align: right;">
	   	<%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%>
	  </td>
	  
	  <td width="20%" colspan="2"> 
	  	<select id="unitInfoId"  name="unitInfoId" style="width: 100%;" value="<%=unitInfoIdFlag%>"  class="textBoxCss">
	  		<option value="0">Select Unit</option>
	   <%	
	 //  out.println("SuserRoleOther="+SuserRoleOther);
	  // System.out.println("SuserRoleOther="+SuserRoleOther);
	  	   sSqlStrUnitInfo = "SELECT DISTINCT ISNULL(SITE_ID,'-') AS SITE_ID, RTRIM(ISNULL(SITE_NAME,'-')) AS SITE_NAME FROM M_SITE WHERE STATUS_ID=10 AND (isnull(CLOSED_UNIT_FLAG,'')<>'y') ORDER BY 2 ";
		
		   ResultSet rsUnitInfo = beanDb.executeQuery(sSqlStrUnitInfo); 
		   while (rsUnitInfo.next()) 
		   { 
	%>		<option VALUE = <%=  rsUnitInfo.getString(1)%>> <%= rsUnitInfo.getString(2) %> </option>
	<%	   }
		   rsUnitInfo.close();
	%>
	   	</select> 
	   </td>
	   
	   <td width="5%" ></td>
	   
	   <td width="8%" align="center" valign="middle">
	   <input type="submit" id="go" name="Submit" value="Search" class="formbutton" style="width: 100%;text-align:center;">
	     <input type="hidden" name="flag" > 
	   </td>
	  <td width="17%" ></td>
  </tr>
  </table>
<div id="dataDiv">  
  <table id="tbID" width="80%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder" style="margin-bottom: 8px;">
	<tr class="formhead" id="headerRow"> 
      <td width="2%" nowrap="nowrap" style="text-align: center;">Action</td>
      <td width="20%" style="text-align: center;"><%=dbLabelBean.getLabel("label.requestdetails.name",strsesLanguage)%></td>
      <td width="15%" style="text-align: center;"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>
      <td width="20%" style="text-align: center;"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></td>
      <td width="5%" style="text-align: center;"><%=dbLabelBean.getLabel("label.master.role",strsesLanguage)%></td>
      <td width="10%" style="text-align: center;"><%=dbLabelBean.getLabel("label.master.assignrole",strsesLanguage)%></td>
	  <td width="5%" nowrap="nowrap" style="text-align: center;"><%=dbLabelBean.getLabel("label.user.boss",strsesLanguage)%></td>
	  <td width="10%" style="text-align: center;"><%=dbLabelBean.getLabel("label.user.assignboss",strsesLanguage)%></td>
	  
    </tr>
<%

	String sDivName			= "";
	String sSiteName		= "";
	String strUnitName  	= "";
	String sRollID 			= "";	
	String sUserID 			= "";	
	String strBoss 			= "";
	String strNoRecordFlag	= "true";
	// Customer funded projects and item wise booking
	//Sql to get the the item list and sanction_dtl_id from sanction_detail
	sSqlStr="select [FIRSTNAME], [LASTNAME],EMP_CODE,DBO.SITENAME(M_USERINFO.SITE_ID) AS SITE_NAME,DESIG_NAME, ROLE_ID,[USERID],ISNULL(BOSS,'-') AS BOSS  FROM M_USERINFO LEFT OUTER  JOIN M_DESIGNATION  on M_USERINFO.DESIG_ID = M_DESIGNATION.DESIG_ID where  M_USERINFO.APPLICATION_ID =1 AND M_USERINFO.STATUS_ID=10 AND M_USERINFO.SITE_ID="+unitInfoIdFlag+" AND (USERNAME like N'"+userNameFlag+"%' OR dbo.USER_NAME(USERID) like N'%"+userNameFlag+"%' OR M_USERINFO.FIRSTNAME LIKE N'%"+userNameFlag+"%' OR M_USERINFO.LASTNAME LIKE N'%"+userNameFlag+"%') ORDER BY M_USERINFO.FIRSTNAME,M_USERINFO.MIDDLENAME,M_USERINFO.LASTNAME";
	//sSqlStr="select [FIRSTNAME], [LASTNAME],DBO.SITENAME(M_USERINFO.SITE_ID) AS SITE_NAME, DESIG_NAME, ROLE_ID,[USERID],ISNULL(BOSS,'-') AS BOSS  FROM M_USERINFO LEFT OUTER  JOIN M_DESIGNATION  on M_USERINFO.DESIG_ID = M_DESIGNATION.DESIG_ID  where  M_USERINFO.APPLICATION_ID =1 AND M_USERINFO.STATUS_ID=10";
	//System.out.println("sSqlStr ==>>>  --"+sSqlStr);
	if(!unitInfoIdFlag.equalsIgnoreCase("0"))
	{ 
	ResultSet	rs = bean.executeQuery(sSqlStr);
	if(rs!=null) {
		while(rs.next())
		{	
			strNoRecordFlag		= "false";
			sDivName			= rs.getString(1)+" "+ rs.getString(2)+"("+rs.getString(3)+")";
			strUnitName         = rs.getString(4);
			sSiteName			= rs.getString(5);
			sRollID				= rs.getString(6);
			sUserID				= rs.getString(7);
			strBoss             = rs.getString(8);
	
			if (iCls%2 == 0) { 
				strStyleCls="formtr2";
			} else { 
				strStyleCls="formtr1";
			} 
			iCls++;
			String comboName = 	"role"+iSno;
			String strUserID = "userID" +iSno;
			String comboBossName = "boss"+iSno;
	%>
	        <tr class="<%=strStyleCls%>"> 
				<td width="2%" nowrap="nowrap" align="center" ><input type="checkbox" value="0" name="chk<%=iSno%>" id="chk<%=iSno%>"/></td>
				<td width="20%" align="center"><%=sDivName%></td>
				<td width="15%" align="center"><%=strUnitName%></td>
				<td width="20%" align="center"><%=sSiteName%></td>
				<td width="5%" align="center"><%=sRollID%></td>
				<td width="10%" align="center">
				  <select name= <%= comboName %>  class="textBoxCss">	  
				    <option VALUE = "-1"><%=dbLabelBean.getLabel("label.user.selectyourrole",strsesLanguage)%>  </option>
	<%
				     ResultSet rsRoleInfo = beanDb.executeQuery(" Select LTRIM(RTRIM(ROLE_INFO)),LTRIM(RTRIM(ROLE_INFO)) from ROLEINFO "); 
				     while (rsRoleInfo.next()) 
				     { 
	%>				 
				  	    <option VALUE = <%=  rsRoleInfo.getString(1)%>> <%= rsRoleInfo.getString(2) %> </option>
	<%				   
					 }
					 rsRoleInfo.close();
	%>
				   </select>	
				 <input type=hidden name=<%= strUserID %> value = <%= sUserID %>> 
				 <input type="hidden" name="updatedflag" id="updatedflag" value="0">
				</td>
	
				<td width="5%" align="center"><%=strBoss%></td>
				<td width="10%" align="center">
					<select name=<%=comboBossName%> class="textBoxCss">
					  <option value = "-1"> <%=dbLabelBean.getLabel("label.user.selectboss",strsesLanguage)%>  </option>
					  <option value = "B"><%=dbLabelBean.getLabel("label.user.boss",strsesLanguage)%></option>	
					  <option value = "-"><%=dbLabelBean.getLabel("label.user.noboss",strsesLanguage)%></option>	
					</select>
				</td>
			</tr>
	<%
		iSno++;				
		}
	}
	if(strNoRecordFlag.equalsIgnoreCase("true")) {
	%>	 <tr class="formtr2" id="rowId"> 
			<td width="30%" style="color:red;text-align:center;font-size: 12px" colspan="8"><b>Data not found</b></td>
		</tr>	 
		
	<%}
	rs.close();
	bean.closeStmt();
	bean.closeCon();
	beanDb.close();
}
%>
 <%--  <input type=hidden name=<%= strUserID %> value = <%= sUserID %>>  --%>
	<input type="hidden" name="flagIndex" value = "<%=iSno %>">
	<!-- <tr>
		<td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
	</tr> -->
</table>
</div>

<center>
 <input type="submit" name="Submit" id="updateId" class="formButton" value="<%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)%>" >
</center>
<%
Connection objCon, objCon1 =  null; 
objCon = dbConBean.getConnection(); 
objCon1	= dbConBean1.getConnection();
CallableStatement proc, proc1 = null;	

String strIpAddress = request.getRemoteAddr();
int icount = Integer.parseInt((request.getParameter("flagIndex")==null )?"1":request.getParameter("flagIndex").trim());
//out.println("icount"+icount);
int  iuserID = 0;
for (int i =1 ; i < icount ; i++) 
{
	
	String index = new Integer(i).toString();
	String strRoleID = request.getParameter("role"+index) == null ? "" :request.getParameter("role"+index).trim();
	String strBossSave   = request.getParameter("boss"+index) == null ?"" :request.getParameter("boss"+index).trim();
	//out.println("strRoleID="+strRoleID+"strBossSave="+strBossSave);
	if (!(strRoleID.equals("-1")))
	{
		iuserID = Integer.parseInt(request.getParameter("userID" +index));
		try 
		{
			String sql = " update M_USERINFO set ROLE_ID=N'"+strRoleID+"',ORG_ROLE=N'"+strRoleID+"',U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"'  where USERID=' " +iuserID+ " ' AND STATUS_ID=10 AND APPLICATION_ID=1  "  ;
		//	out.println(sql);
			//String sqlAudit = " update AUDIT_M_USERINFO set ROLE_ID=N'"+strRoleID+"',ORG_ROLE=N'"+strRoleID+"',U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"' where USERID=' " +iuserID+ " '  "  ; 
			dbConBean.executeUpdate(sql);	
			//dbConBean.executeUpdate(sqlAudit);
			
			proc = objCon.prepareCall("{?=call PROC_TRANSFER_USERINFO_TO_AUDIT_USERINFO(?)}");
			proc.registerOutParameter(1,java.sql.Types.INTEGER);
			proc.setString(2,String.valueOf(iuserID));
			proc.execute();	
			proc.close();
			
		}
		catch (Exception e) 
		{
			System.out.println("Error in RoleAssignment.jsp==ROLE==== "+e);
			e.printStackTrace();
		} 
		
	}
	if (!(strBossSave.equals("-1")))
	{
		iuserID = Integer.parseInt(request.getParameter("userID" +index));
		try 
		{
			String sql = " update M_USERINFO set BOSS='"+strBossSave+"',U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"'  where USERID=' " +iuserID+ " ' AND STATUS_ID=10 AND APPLICATION_ID=1  "  ;
			//out.println(sql);
			//String sqlAudit = " update AUDIT_M_USERINFO set BOSS='"+strBoss+"',U_USER_ID='"+Suser_id+"',U_DATE=GETDATE(),IP_ADDRESS='"+strIpAddress+"'  where USERID=' " +iuserID+ " '  "  ; 
			dbConBean.executeUpdate(sql);	
			//dbConBean.executeUpdate(sqlAudit);
			
			proc1 = objCon1.prepareCall("{?=call PROC_TRANSFER_USERINFO_TO_AUDIT_USERINFO(?)}");
			proc1.registerOutParameter(1,java.sql.Types.INTEGER);
			proc1.setString(2,String.valueOf(iuserID));
			proc1.execute();
			proc1.close();
			
		}
		catch (Exception e) 
		{
			System.out.println("Error in RoleAssignment.jsp==BOSS==== "+e);
			e.printStackTrace();
		} 

	}
	
}

objCon.close();
objCon1.close();
%>
</body>
</form>
</html>
