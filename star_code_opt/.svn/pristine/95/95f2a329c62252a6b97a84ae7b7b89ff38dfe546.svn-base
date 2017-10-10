<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand
 *Date of Creation 		:31 jan 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:Page is used to show the approval statistics
 *Modified By			: Manoj Chand
 *Date of Modification	: 09 feb 2012
 *Modification 			: resolve issue related to - sign
 *Modified By			: Manoj Chand
 *Date of Modification	: 09 Apr 2012
 *Modification 			: change in query to show correct data.
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 17 May 2012
 *Modification 			: change in query to show correct data.
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 25 Sept 2013
 *Modification 			: change in query to show correct data.
 *************************************************************/
%>
<html>
<title></title>
<%-- Import Statements  --%>
<%@ include  file="importStatement.jsp" %>
	<%@ page pageEncoding="UTF-8" %>
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

<style type="text/css">
.reportHeading12
{
font-family:Verdana, Arial, Helvetica, sans-serif;
font-size:11px;
font-weight:bold;
color:#373737;
line-height:15px;
background-color:#dddddd;
padding-left:5px;
text-align:left;
}
</style>

<%
int intUserId  =0; /// to store integer value of userid
String  strUseridUserName="";
String strSql="";
ResultSet rs = null;
String strUserId = request.getParameter("userid")==null?"":request.getParameter("userid");
String strTravelType = (request.getParameter("travel_type")==null)?"":request.getParameter("travel_type");
String strSourceType= (request.getParameter("sourceType")==null)?"":request.getParameter("sourceType");
String strApproverName= (request.getParameter("approver")==null)?"":request.getParameter("approver");
String strCheckType= (request.getParameter("check")==null)?"":request.getParameter("check");
String strFromDate=request.getParameter("from")==null?"":request.getParameter("from");
String strToDate=request.getParameter("to")==null?"":request.getParameter("to");
String strSourceType1="æ",strAppend1="";
/*System.out.println("strUserId--->"+strUserId);
System.out.println("strTravelType--->"+strTravelType);
System.out.println("strSourceType--->"+strSourceType);
System.out.println("strCheckType--->"+strCheckType);*/

if(strSourceType.trim().equalsIgnoreCase("IPHONE")){
	//strSourceType="mobile -null";
	strSourceType1="mobile -null";
	
}
if(strSourceType.trim().equalsIgnoreCase("WEB")){
	strAppend1 = "(TA.APPROVED_DEVICE ='' OR TA.APPROVED_DEVICE IS NULL)";
}else{
	strAppend1="(TA.APPROVED_DEVICE LIKE '%"+strSourceType+"%' OR TA.APPROVED_DEVICE LIKE '%"+strSourceType1+"%')";
}

String strAppend="";
if(strCheckType.trim().equalsIgnoreCase("2")){
	strAppend=" AND CONVERT(VARCHAR(10),TA.APPROVE_DATE,20) BETWEEN CONVERT(VARCHAR(10),CONVERT(DATETIME,'"+strFromDate+"'),20) AND CONVERT(VARCHAR(10),CONVERT(DATETIME,'"+strToDate+"'),20)";	
}

if(strTravelType.equals("I"))
{
     strSql="SET DATEFORMAT DMY SELECT  'International' AS TRAVEL_TYPE,TI.TRAVEL_REQ_NO,dbo.user_name(TI.TRAVELLER_ID) as Traveller,"+
	   " ISNULL(Convert(varchar(10),TI.C_DATETIME,103),'-') AS C_DATETIME,"+
	   " ISNULL(convert(varchar(10),TA.APPROVE_DATE,103),'-') AS APPROVE_DATE,ISNULL(MAX(TRC.COMMENTS),'-') AS COMMENTS ,"+
       " MAX(POSTED_ON) AS POSTED_ON FROM T_APPROVERS TA  LEFT JOIN T_TRAVEL_DETAIL_INT TI  ON TI.TRAVEL_ID=TA.TRAVEL_ID"+ 
       " left JOIN TRAVEL_REQ_COMMENTS TRC ON TRC.TRAVEL_ID=TA.TRAVEL_ID"+ 
       " and TRC.TRAVEL_TYPE='I' AND TRC.POSTED_BY=TA.APPROVER_ID and convert(varchar(16),ta.APPROVE_DATE,20) =  convert(varchar(16),POSTED_ON ,20)"+
       " WHERE "+strAppend1+
       //"(TA.APPROVED_DEVICE LIKE '%"+strSourceType+"%' OR TA.APPROVED_DEVICE LIKE '%"+strSourceType1+"%')"+
       " AND TA.APPROVER_ID="+strUserId+" AND TA.TRAVEL_TYPE='I'"+
       " and convert(varchar(10),TA.APPROVE_DATE) <>'-' "+strAppend+
       " GROUP BY TI.TRAVEL_REQ_NO,TI.TRAVELLER_ID,TI.C_DATETIME,TA.APPROVE_DATE"+
       " order by convert(varchar(10),APPROVE_DATE,20)";	    
//System.out.println("strSql====i======>"+strSql);
}
else if(strTravelType.equals("D"))
{
	strSql="SET DATEFORMAT DMY SELECT 'Domestic' AS TRAVEL_TYPE,TD.TRAVEL_REQ_NO,dbo.user_name(TD.TRAVELLER_ID) as Traveller,"+
				" ISNULL(Convert(varchar(10),TD.C_DATETIME,103),'-') AS C_DATETIME, ISNULL(convert(varchar(10),TA.APPROVE_DATE,103),'-') AS APPROVE_DATE,"+
				" ISNULL(MAX(TRC.COMMENTS),'-') as COMMENTS ,MAX(POSTED_ON) AS POSTED_ON FROM T_TRAVEL_DETAIL_DOM TD  INNER JOIN T_APPROVERS TA"+  
				" ON TD.TRAVEL_ID=TA.TRAVEL_ID  left JOIN TRAVEL_REQ_COMMENTS TRC ON TRC.TRAVEL_ID=TA.TRAVEL_ID"+ 
				" and TRC.TRAVEL_TYPE='D' AND TRC.POSTED_BY=TA.APPROVER_ID"+
				" and convert(varchar(16),ta.APPROVE_DATE,20) = convert(varchar(16),POSTED_ON ,20) WHERE "+strAppend1+ 
				//"(TA.APPROVED_DEVICE LIKE '%"+strSourceType+"%' OR TA.APPROVED_DEVICE LIKE '%"+strSourceType1+"%') "+
				" AND TA.APPROVER_ID="+strUserId+" AND TA.TRAVEL_TYPE='D' and convert(varchar(10),TA.APPROVE_DATE) <>'-' "+strAppend+
				" GROUP BY TD.TRAVEL_REQ_NO,TD.TRAVELLER_ID,TD.C_DATETIME,TA.APPROVE_DATE"+
				" order by convert(varchar(10),APPROVE_DATE,20)";   
			   
//System.out.println("strSql====d======>"+strSql);
}
else{
	strSql="SET DATEFORMAT DMY "+ 
		" SELECT  'International' AS TRAVEL_TYPE,TI.TRAVEL_REQ_NO,dbo.user_name(TI.TRAVELLER_ID) as Traveller,"+
		" ISNULL(Convert(varchar(10),TI.C_DATETIME,103),'-') AS C_DATETIME,"+
		" ISNULL(convert(varchar(10),TA.APPROVE_DATE,103),'-') AS APPROVE_DATE,ISNULL(MAX(TRC.COMMENTS),'-') as COMMENTS ,MAX(POSTED_ON) AS POSTED_ON,ISNULL(convert(varchar(10),TA.APPROVE_DATE,20),'-') as APP_DATE "+
		" FROM T_APPROVERS TA  LEFT JOIN T_TRAVEL_DETAIL_INT TI  ON TI.TRAVEL_ID=TA.TRAVEL_ID"+ 
		" left JOIN TRAVEL_REQ_COMMENTS TRC ON TRC.TRAVEL_ID=TA.TRAVEL_ID and convert(varchar(16),ta.APPROVE_DATE,20) =  convert(varchar(16),POSTED_ON ,20)"+
		" and TRC.TRAVEL_TYPE='I' AND TRC.POSTED_BY=TA.APPROVER_ID"+
		" WHERE "+strAppend1+
		//"(TA.APPROVED_DEVICE LIKE '%"+strSourceType+"%' OR TA.APPROVED_DEVICE LIKE '%"+strSourceType1+"%')"+
		" AND TA.APPROVER_ID="+strUserId+" AND TA.TRAVEL_TYPE='I'"+
		" and convert(varchar(10),TA.APPROVE_DATE) <>'-' "+strAppend+""+
		" GROUP BY TI.TRAVEL_REQ_NO,TI.TRAVELLER_ID,TI.C_DATETIME,TA.APPROVE_DATE"+
		" UNION ALL "+
		" SELECT 'Domestic' AS TRAVEL_TYPE,TD.TRAVEL_REQ_NO,dbo.user_name(TD.TRAVELLER_ID) as Traveller,"+
		" ISNULL(Convert(varchar(10),TD.C_DATETIME,103),'-') AS C_DATETIME, ISNULL(convert(varchar(10),TA.APPROVE_DATE,103),'-') AS APPROVE_DATE,"+
		" ISNULL(MAX(TRC.COMMENTS),'-') as COMMENTS ,MAX(POSTED_ON) AS POSTED_ON,ISNULL(convert(varchar(10),TA.APPROVE_DATE,20),'-') as APP_DATE FROM T_TRAVEL_DETAIL_DOM TD  INNER JOIN T_APPROVERS TA"+  
		" ON TD.TRAVEL_ID=TA.TRAVEL_ID  left JOIN TRAVEL_REQ_COMMENTS TRC ON TRC.TRAVEL_ID=TA.TRAVEL_ID"+ 
		" and TRC.TRAVEL_TYPE='D' AND TRC.POSTED_BY=TA.APPROVER_ID"+
		" and convert(varchar(16),ta.APPROVE_DATE,20) = convert(varchar(16),POSTED_ON ,20) WHERE "+strAppend1+
		//"(TA.APPROVED_DEVICE LIKE '%"+strSourceType+"%' OR TA.APPROVED_DEVICE LIKE '%"+strSourceType1+"%') "+
		" AND TA.APPROVER_ID="+strUserId+" AND TA.TRAVEL_TYPE='D' and convert(varchar(10),TA.APPROVE_DATE) <>'-' "+strAppend+""+
		" GROUP BY TD.TRAVEL_REQ_NO,TD.TRAVELLER_ID,TD.C_DATETIME,TA.APPROVE_DATE ORDER BY APP_DATE";	
//System.out.println("strSql====all======>"+strSql); 
}
rs = dbConBean.executeQuery(strSql);

%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="35" class="bodyline-top"><ul class="pagebullet">
            <span class="pageHead"> <b><%=dbLabelBean.getLabel("label.report.approvedbymr",strsesLanguage) %></b>&nbsp;<%=strApproverName %></span> 
        </ul>
        </td>
        <td valign="bottom" class="bodyline-top"><table align="right" border="0" cellspacing="0" cellpadding="0">
            <tr align="right">
              <td  align="right" valign="bottom">&nbsp;</td>  <!-- 27/02/2007 -->
            <td align="right" >
      <ul id="list-nav">
      <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
      </ul>
      </td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td colspan="2">
        <table width="100%" align="left" border="0" cellpadding="2" cellspacing="1"  class="formborder">
              <tr>
                <td width="3%" height="2px" class="reportHeading12" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
                <td width="14%" class="reportHeading12"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage) %></td>
                <td width="16%" class="reportHeading12"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage) %></td>
                <td width="16%" class="reportHeading12"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage) %></td>
                <td width="13%" class="reportHeading12"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage) %></td>
                <td width="14%" class="reportHeading12"><%=dbLabelBean.getLabel("label.report.approvedon",strsesLanguage) %></td>
                <td width="25%" class="reportHeading12"><%=dbLabelBean.getLabel("label.report.approvalremarks",strsesLanguage) %></td>
              </tr>
              <%
		
              int counter = 0; 
              while(rs.next())
              {
              	counter++; 	
              	
			%>
			  <tr>
			  	<td width="3%" align="center" class="formtr33"><%=counter%></td>
                <td width="14%" align="left" class="formtr33"><%=rs.getString("TRAVEL_TYPE").trim()%></td>
                <td width="16%" align="left" class="formtr33"><%=rs.getString("TRAVEL_REQ_NO")%></td>
                <td width="16%" align="left" class="formtr33"><%=rs.getString("Traveller")%></td>
                <td width="11%" align="left" class="formtr33"><%=rs.getString("C_DATETIME")%></td>
                <td width="14%" align="left" class="formtr33"><%=rs.getString("APPROVE_DATE")%></td>
                <td width="26%" align="left" class="formtr33"><%=rs.getString("COMMENTS")%></td>
              </tr>
			<%
				
	           }
              
              if(counter ==0){
           %>
                 <tr>
   				  	<td width="2%" colspan="3" align="center" class="formtr33"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage) %></td>
   	    	      </tr>
           <%
              }
              //}
              rs.close();
              dbConBean.close();
			%>
              <input type="hidden" name=travel_type value=""/>
            </form>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>

<%

//dbConBean.close();
%>
