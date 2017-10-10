<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand
 *Date of Creation 		:13-Aug-2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:Page is used to show the workflow to local admin
  *******************************************************/
%>
<%@ page pageEncoding="UTF-8"%>
<html>
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

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%
String columnName ="";
String columnValue="";
String strTravelType="";
String strWorkflow="";
String strSiteId=request.getParameter("siteid");
//System.out.println("strSiteId---m_disp-->"+strSiteId);
int intUserId  =0;
String  strUseridUserName="";
CallableStatement cstmt=null;
ResultSet rs = null;
Connection con=dbConBean.getConnection();
try{
cstmt=  con.prepareCall("{?=call PROC_APPROVER_LIST(?)}");
cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
cstmt.setInt(2,Integer.parseInt(strSiteId));
rs = cstmt.executeQuery();
ResultSetMetaData rsmd = rs.getMetaData();
int numColumns = rsmd.getColumnCount();
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="38" class="bodyline-top"><ul class="pagebullet">
            <span class="pageHead"> <b>Workflow Details</b></span> 
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
      <tr>
        <td colspan="2">
        <table width="100%" align="center" border="0" cellpadding="2" cellspacing="1">
            <form>
              
              <tr class="formhead">
              <%
              for (int i=2; i<numColumns+1; i++) {
                  columnName = rsmd.getColumnName(i);
                  if(columnName.trim().equalsIgnoreCase("TRV_TYPE"))
                	  columnName="Workflow";
              %>
                <td width="2%" align=center><%=columnName.trim() %></td>
                <%} %>
              </tr>

			<%
			int count=0;
			int x=0;
			while(rs.next()){
				strWorkflow=rs.getString("WORKFLOW");
          	  	if(strWorkflow.contains("WORKFLOW") && (count%2)==0){
          	  	
          	  	%>
					<tr class="formtr2" style="font-weight: bold;">
						<td colspan="<%=numColumns %>">&nbsp;<%=strWorkflow %></td>
					</tr>
				<%}%>
				<tr class="formtr1">
				<%for (int i=2; i<numColumns+1; i++) {
	                  columnValue = rs.getString(i);
	                  if(columnValue.trim().equalsIgnoreCase("D"))
	                	  columnValue="Domestic";
	                  if(columnValue.trim().equalsIgnoreCase("I"))
	                	  columnValue="International";
			%>
			<td width="2%" align=center><%=columnValue%></td>
			<%}%>
				</tr>	
			<%
			count++;
			} %>
			
            </form>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>

<%
}catch(Exception e){
	e.printStackTrace();
}
dbConBean.close();
%>
