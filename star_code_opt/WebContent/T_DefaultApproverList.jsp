<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta
 *Date of Creation 		:18 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for showing Default Approvers of the site
 *Modification 			:1 added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from 			
						    M_default_approvers on 26-Oct-09 by shiv sharma  
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modification				:fetch traveller id from request and change in queries to find default approver of traveller workflow.
 *Modified by				:Manoj Chand
 *Date of Modification		:17 Apr 2012
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification   :07 Feb 2013
 *Description			:IE Compatibility Issue resolved.
 *******************************************************/
%>
<html>
<%@ page pageEncoding="UTF-8" %>
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
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<%
int intUserId  =0; /// to store integer value of userid
String  strUseridUserName="";
String strSql="";
ResultSet rs = null;
//String strUserId = request.getParameter("userid");
ArrayList ApproverList = new ArrayList();
String strSiteId = (request.getParameter("siteId")==null)?"-1":request.getParameter("siteId"); 
String strTravelType = (request.getParameter("traveltype")==null)?"":request.getParameter("traveltype");

//traveller id fetch by manoj chand on 17 april 2012 to show default approver of traveller workflow.
String strTraveller= (request.getParameter("traveller")==null)?"":request.getParameter("traveller");
String strWorkFlowName;
strWorkFlowName=SSstrSplRole;

if(strTraveller.trim().equalsIgnoreCase(""))
	strTraveller=Suser_id;

//CODE ADDED BY MANOJ CHAND ON 17 APRIL 2012 TO FETCH WORKFLOW NAME OF TRAVELLER
strSql="SELECT SP_ROLE FROM M_USERINFO WHERE M_USERINFO.USERID="+strTraveller+" AND M_USERINFO.STATUS_ID=10";
 rs = dbConBean.executeQuery(strSql);
	if(rs.next()){  
		strWorkFlowName= rs.getString("SP_ROLE");	 		
	 }
rs.close();


//added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
if(strTravelType.equals("INT"))
{
	strSql ="SELECT LTRIM(RTRIM(dbo.USER_NAME(APPROVER_ID))) AS APPROVER_NAME, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND  sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";
	//System.out.println("strSql --int --->"+strSql);
}
else if(strTravelType.equals("DOM"))
{
	strSql ="SELECT LTRIM(RTRIM(dbo.USER_NAME(APPROVER_ID))) AS APPROVER_NAME, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='D' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";
	//System.out.println("strSql --dom --->"+strSql);
}
rs = dbConBean.executeQuery(strSql);
//System.out.println("strSql======"+strSql);
while(rs.next())
{
	ApproverList.add(rs.getString("APPROVER_NAME"));
}
rs.close();


if(ApproverList.size() == 0)
{
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table height="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="45" valign="bottom" class="bodyline-top"><table align="right" border="0" cellspacing="0" cellpadding="0">
          <tr align="right">
            <td  align="right" valign="bottom">&nbsp;</td>
                <td  align="right" valign="bottom">
                 <td>
          <ul id="list-nav">
          <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
          <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
          </ul>
                 </td>
                </tr>
        </table></td>
        </tr>
      <tr>
        <td height="0"><table width="100%" align="center" border="0" cellpadding="10" cellspacing="1"  class="formborder">
		 <tr>
                <td align="Left" class="formhead"></td>
              </tr>
			  <tr>
                <td align=center class="formtr3"><%=dbLabelBean.getLabel("message.createrequest.youhavenotdefinedapprovers",strsesLanguage) %>
				</td>
              </tr>
		  </table></td>
      </tr>
    </table></td>
  </tr>
</table>
<%
}
else
{
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="45" class="bodyline-top"><ul class="pagebullet">
            <li class="pageHead"> <b><%=dbLabelBean.getLabel("label.global.listofdefaultapprovers",strsesLanguage) %></b></li>
        </ul></td>
        <td valign="bottom" class="bodyline-top"><table align="right" border="0" cellspacing="0" cellpadding="0">
            <tr align="right">
              <td  align="right" valign="bottom">&nbsp;</td>  <!-- 27/02/2007 -->
              <td  align="right" valign="bottom">
                <td>
          <ul id="list-nav">
          <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
          <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
          </ul>
                </td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td colspan="2"><table width="100%" align="center" border="0" cellpadding="5" cellspacing="1"  class="formborder">
            <form method=post name=frm action="T_MyReturns.jsp" onSubmit="return checkForm();">
              <input type="hidden" name="flag" value="2">
              <tr>
                <td colspan="2" align="Left" class="formhead"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage) %></td>
              </tr>
              <%
				Iterator itr =  ApproverList.iterator();
				while(itr.hasNext())
				{ 
			%>
			  <tr>
                <td width="2%" align=center class="formtr3"><img src="images/arrow_3red_hl.gif?buildstamp=2_0_0" width="9" height="9"></td>
                <td width="98%" align=left class="formtr33"><%=itr.next()%></td>
              </tr>
			<%
				}				
			%>
              <input type="hidden" name=travel_type value=""/>
            </form>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>

<%
}
dbConBean.close();
%>
