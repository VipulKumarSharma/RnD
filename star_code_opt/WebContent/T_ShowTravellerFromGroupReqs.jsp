<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Pankaj Dubey
 *Date of Creation 		:26-Dec-2011
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:Page is used to show the travellers details for group travels.
  *******************************************************/
%>
<%@ page pageEncoding="UTF-8"%>
<html>
<title>Req. No.: <%=request.getParameter("strTravelRequestNo")==null?"":request.getParameter("strTravelRequestNo").replaceAll("~","/")%></title>
<%-- Import Statements  --%>
<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbUtilBean" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%
int intUserId  =0; /// to store integer value of userid
String  strUseridUserName="";
String strSql="";
ResultSet rs = null;
//String strUserId = request.getParameter("userid");
//ArrayList ApproverList = new ArrayList();
//String strSiteId = (request.getParameter("siteId")==null)?"-1":request.getParameter("siteId"); 
String strTravelType = (request.getParameter("traveltype")==null)?"":request.getParameter("traveltype"); 
String reportFlag	= request.getParameter("reportFlag")==null?"false":request.getParameter("reportFlag").trim();

//Added By Gurmeet Singh
String strTravelTypeCheck = "";
if(strTravelType.equals("INT"))
{
	strTravelTypeCheck = "I";
} else if(strTravelType.equals("DOM"))
{
	strTravelTypeCheck = "D";
}
	
String strUserAccessCheckFlag = "";
strUserAccessCheckFlag = securityUtilityBean.validateAuthTravelDetails(request.getParameter("strTravelId"), strTravelTypeCheck, Suser_id);		
	
	
if(reportFlag.equalsIgnoreCase("false") &&  (strUserAccessCheckFlag.equals("420"))){	
	dbConBean.close();  
	securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_ShowTravellerFromGroupReqs.jsp", "Unauthorized Access");
	response.sendRedirect("UnauthorizedAccess.jsp");		
} else {

//added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
if(strTravelType.equals("INT"))
{
	//strSql ="SELECT LTRIM(RTRIM(dbo.USER_NAME(APPROVER_ID))) AS APPROVER_NAME, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND  sp_role="+SSstrSplRole+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";
	strSql =" select rtrim(first_name)+' '+rtrim(last_name) as Name, dbo.CONVERTDATEDMY1(DOB) as DOB, dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID "+
	" from t_group_userinfo where travel_id="+request.getParameter("strTravelId")+" and travel_type='i'  "+
	" and status_id=10 ";
}
else if(strTravelType.equals("DOM"))
{
	//strSql ="SELECT LTRIM(RTRIM(dbo.USER_NAME(APPROVER_ID))) AS APPROVER_NAME, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='D' AND sp_role="+SSstrSplRole+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";
	strSql =" select rtrim(first_name)+' '+rtrim(last_name) as Name, dbo.CONVERTDATEDMY1(DOB) as DOB, dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID "+
	" from t_group_userinfo where travel_id="+request.getParameter("strTravelId")+" and travel_type='d'  "+
	" and status_id=10 ";
}
rs = dbConBean.executeQuery(strSql);
//System.out.println("strSql=====here list======>"+strSql);


%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="38" class="bodyline-top"><ul class="pagebullet">
            <span class="pageHead"> <b><%=dbLabelBean.getLabel("label.approverrequest.listoftravelers",strsesLanguage) %> </b></span> 
        </ul></td>
        <td valign="bottom" class="bodyline-top"><table align="right" border="0" cellspacing="0" cellpadding="0">
            <tr align="right">
              <td  align="right" valign="bottom">&nbsp;</td>  <!-- 27/02/2007 -->
                <td align="right">
            <ul id="list-nav">
            <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
            </ul>
            </td>
             
            </tr>
        </table></td>
      </tr>
      <tr align="center">
        <td colspan="2"><table width="98%" align="center" border="0" cellpadding="5" cellspacing="1"  class="formborder">
            <form method=post name=frm action="T_MyReturns.jsp" onSubmit="return checkForm();">
              <input type="hidden" name="flag" value="2">
              <%--<tr>
                <td colspan="2" align="Left" class="formhead">List </td>
              </tr> --%>
              <tr align="center">
                <td width="2%"  align="center" class="formHead" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
                <td width="43%" align="center" class="formHead" ><%=dbLabelBean.getLabel("label.requestdetails.name",strsesLanguage) %></td>
                <td width="20%" align="center" class="formHead" ><%=dbLabelBean.getLabel("label.requestdetails.dob",strsesLanguage) %></td>
                <td width="35%" align="center" class="formHead" ><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></td>
              </tr>
              <%
				//Iterator itr =  ApproverList.iterator();
              int couter = 0; 
             // if(rs != null){
    
              while(rs.next())
              {
              	//ApproverList.add(rs.getString(1));
              	couter ++;
			%>
			  <tr>
			  	<td width="2%"  align="center" class="formtr33"><%=couter%></td>
                <td width="43%" align="center" class="formtr33"><%=(rs.getString("Name") != null ? rs.getString("Name").trim() : "")%></td>
                <td width="20%" align="center" class="formtr33"><%=(rs.getString("DOB") != null ? rs.getString("DOB").trim() : "")%></td>
                <td width="35%" align="center" class="formtr33"><%=(rs.getString("DESIG_ID") != null ? rs.getString("DESIG_ID").trim() : "")%></td>
              </tr>
			<%
				
	           }
              
              if(couter ==0){
           %>
                 <tr>
   				  	<td width="2%" colspan="4" align=center class="formtr33"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage)%></td>
   	    	      </tr>
           <%
              }
              //}
              rs.close();			
			%>
              <input type="hidden" name=travel_type value=""/>
            </form>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>

<%

dbConBean.close();
}
%>
