<%
/***************************************************
**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	 : STARS ****** 
**** Operating environment :Tomcat 6.0, sql server 2008 ******
**** Description : To display hold request.
**** Create Date : 26 Feb 2013
**** Created By  : Manoj Chand
**********************************************************/
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
<%--<%@ include  file="systemStyle.jsp" %>--%>
<%-- include the beans --%>

<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<script language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script language=JavaScript >
function deleteConfirm()
{
if(confirm('<%=dbLabelBean.getLabel("alert.global.unhold",strsesLanguage)%>'))
	return true;
else
	return false;
}

function childwindowSubmit(){
	document.frm.action='M_HoldRequestList.jsp';
	document.frm.submit();
}
</script>

<%
// Variables declared and initialized
Connection objCon		=		null;			    // Object for connection
Statement objStmt,stmt		=		null;			   // Object for Statement
ResultSet objRs,rs			=		null;			  // Object for ResultSet
CallableStatement objCstmt		=		null;			// Object for Callable Statement

objCon=dbConBean.getConnection();
String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");
String	strSql,strSql1,sSqlStr	=	""; // For sql Statements
%>

</head>
<body>
<form name="frm" method="post">
<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="70%" height="35" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("submenu.administration.holdrequest",strsesLanguage)%></li>
    </ul></td>
    <td width="30%" height="35" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
		<ul id="list-nav">
			<li><a href="M_HoldRequestHistoryList.jsp"><%=dbLabelBean.getLabel("label.approverequest.history",strsesLanguage) %></a></li>
		</ul>
      </td>
      </tr>
    </table>
    
    </td>
  </tr>
</table>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <tr align="center" class="formhead"> 
	<td width="5%"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
    <td width="12%"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage) %></td>
	<td width="12%"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage) %></td>
    <td width="12%"><%=dbLabelBean.getLabel("label.global.travelfrom",strsesLanguage) %></td>
	<td width="12%"><%=dbLabelBean.getLabel("label.global.travelto",strsesLanguage) %></td>
	<td width="15%"><%=dbLabelBean.getLabel("label.mail.amountrequested",strsesLanguage) %></td>
	<td width="12%"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage) %></td>
	<td width="10%"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage) %></td>
	<td width="10%"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage) %></td>
		
   </tr>
  <%
  String strTravelid="",strTravelType="";
  String strRequisitionId="",strNewReqNo="",strName="",strAmount="",strOriginatedBy="",strOriginatedOn="";
  String strTravel_From="",strTravel_To="",strPurchaseComments="",strImagePrint="",strGroupTravelFlag="",strTravelAgencyTypeId="";
  String strStyleCls = "",strAttachment="",strFinalApprovalStatus="",strTravellerID="",strTravelReqId="";
  String urlpage="",strDetailPageUrl="",strRecFlag="No";
  int iCls = 0,intSerialNo=0;
  strSql="SELECT LTRIM(RTRIM(TRAVEL_ID)) AS TRAVEL_ID,LTRIM(RTRIM(TRAVEL_TYPE)) AS TRAVEL_TYPE FROM T_HOLD_REQUEST THR WHERE STATUS_ID=10 order by THR.C_DATE desc";
  //System.out.println("strSql---->"+strSql);
  objStmt	 = objCon.createStatement(); 
  objRs		 = objStmt.executeQuery(strSql);
  while(objRs.next())
  {
	  strRecFlag="Yes";
	  strTravelid=objRs.getString("TRAVEL_ID");
	  strTravelType=objRs.getString("TRAVEL_TYPE");
	  if(strTravelType.equalsIgnoreCase("D")){
		  strSql1="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER,dbo.FN_GET_EXPENDITURE(t.travel_id,'D') AS Expenditure,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,ISNULL(DBO.CONVERTDATEDMY1(t.C_DATETIME),'-') AS C_DATE,j.travel_from,j.travel_to,DBO.TRAVEL_COMMENT(t.travel_id,'D'),DBO.REQUISITIONATTACHMENT(t.travel_id,'D'),RTRIM(DBO.TRAVEL_FINAL_APPROVAL_STATUS(t.TRAVELLER_ID,'I',t.TRAVELLER_ID)),t.TRAVELLER_ID, t.travel_req_id, t.Group_Travel_Flag as Group_Travel_Flag,  (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_DOM t,T_JOURNEY_DETAILS_DOM j,T_TRAVEL_STATUS S WHERE t.travel_id='"+strTravelid+"' and j.travel_id='"+strTravelid+"' and    S.TRAVEL_ID='"+strTravelid+"' and  s.TRAVEL_STATUS_ID=5 AND S.TRAVEL_TYPE='D' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10  ORDER BY T.C_DATETIME DESC";
	  }
	  else{
		  strSql1="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER,dbo.FN_GET_EXPENDITURE(t.travel_id,'I') AS Expenditure,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,ISNULL(DBO.CONVERTDATEDMY1(t.C_DATETIME),'-') AS C_DATE,j.travel_from,j.travel_to,DBO.TRAVEL_COMMENT(t.travel_id,'I'),DBO.REQUISITIONATTACHMENT(t.travel_id,'I'),RTRIM(DBO.TRAVEL_FINAL_APPROVAL_STATUS(t.TRAVELLER_ID,'I',t.TRAVELLER_ID)),t.TRAVELLER_ID,t.travel_req_id,GROUP_TRAVEL_FLAG , (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id   FROM T_TRAVEL_DETAIL_INT t,T_JOURNEY_DETAILS_INT j,T_TRAVEL_STATUS S WHERE t.travel_id='"+strTravelid+"' and j.travel_id='"+strTravelid+"' and    S.TRAVEL_ID='"+strTravelid+"' and  s.TRAVEL_STATUS_ID=5 AND S.TRAVEL_TYPE='I' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10  ORDER BY T.C_DATETIME DESC";
	  }
	  //System.out.println("strSql1---->"+strSql1);
	  stmt=null;
	  rs=null;
	  stmt = objCon.createStatement(); 
	  rs = stmt.executeQuery(strSql1);
	  if(rs.next())
	  {
	  	do
	  	{
	  	strRequisitionId					=	rs.getString(1);
	  	strNewReqNo					    	= 	rs.getString(2);
	  	strName								=	rs.getString(3);
	  	strAmount							=	rs.getString("Expenditure");
	  	strOriginatedBy			    		=	rs.getString("ORIGINATOR");
	  	strOriginatedOn				    	=	rs.getString("C_DATE");	
	  	strTravel_From						=	rs.getString("travel_from");
	  	strTravel_To				    	=	rs.getString("travel_to");
	  	
	  	strPurchaseComments			=	rs.getString(9);
	  	if(!strPurchaseComments.trim().equals("0"))
	  	{
	  		strImagePrint="<img src=images/group1.gif border=0 alt="+dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)+" >";
	  	}
	  	else
	  	{
	  		strImagePrint="";
	  	}
	  	strAttachment					=	rs.getString(10);
	  	if(strAttachment.equals("0"))
	  	{
	  		strAttachment="";
	  	}
	  	else
	  	{
	  		strAttachment="<img src=images/clip123.gif border=0 alt="+dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage)+" >";
	  	}

	  	if (iCls%2 == 0) { 
	  		strStyleCls="formtr2";
	      } else { 
	  		strStyleCls="formtr1";
	      } 

	  	strFinalApprovalStatus			=	rs.getString(11);
	  	strTravellerID					=	rs.getString(12);
	  	strTravelReqId                  =   rs.getString(13); 
	  	strGroupTravelFlag                  =   rs.getString("GROUP_TRAVEL_FLAG"); 
	  	 strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
	  								
	  if(strGroupTravelFlag==null) 
	  		{
	  	strGroupTravelFlag="N";
	   	}
	    
	  if(strTravelType.equalsIgnoreCase("I")){
	  	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
	  		{
	  		    urlpage ="Group_T_IntTrv_Details.jsp";
		  		strDetailPageUrl = "Group_T_TravelRequisitionDetails.jsp";
		  		if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
		  			strDetailPageUrl="Group_T_TravelRequisitionDetails_GmbH.jsp";
				}
		  		strName="Group/Guest Travel ";  
	  	}
	  	else
	  		{
	  			urlpage ="T_IntTrv_Details.jsp";
	  			strDetailPageUrl = "T_TravelRequisitionDetails.jsp";
	  			if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
	  				strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
				}
	  	}
	  }else{
		  if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
			{
			  urlpage="Group_T_TravelDetail_Dom.jsp";
			  strDetailPageUrl="Group_T_TravelRequisitionDetails_D.jsp";
			  if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
		  			strDetailPageUrl="Group_T_TravelRequisitionDetails_GmbH.jsp";
				}
			  strName="Group/Guest Travel";
		  }else 
			{
			  urlpage="T_TravelDetail_Dom.jsp";
			  strDetailPageUrl="T_TravelRequisitionDetails_D.jsp";
			  if(isMATA_GmbH != null && isMATA_GmbH.equals("true")){
	  				strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
				}
		  }
	  }

	  	  iCls++;
	  %>
	    
	  <tr valign="top" class="<%=strStyleCls%>"> 
	      <td align="center"><%=++intSerialNo%></td>
		<td class="listdata" align="center"><a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strRequisitionId%>&traveller_Id=<%=strTravellerID%>&travelType=<%=strTravelType %>','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550')"><%=strNewReqNo%></a></td>
	  	<td class="listdata" align="center"><%=strName%></td>
	  	<td class="listdata" align="center"><%=strTravel_From%></td>
	  	<td class="listdata" align="center"><%=strTravel_To%></td>
	  	<td class="listdata" align="center"><%=strAmount%></td>
	    <td class="listdata" align="center"><%=strOriginatedBy%></td>
	  	<td class="listdata" align="center"><%=strOriginatedOn%></td>
	  	<td class="listhead" align="center">
	  	<a href="T_TravelRequisitionUnhold.jsp?travelId=<%=strRequisitionId%>&travelReqId=<%=strTravelReqId%>&travelType=<%=strTravelType %>" onClick="return  deleteConfirm();" title="<%=dbLabelBean.getLabel("label.administration.unhold",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.administration.unhold",strsesLanguage) %></a>
	    </td></tr>
	  	  <%
	  	}
	  	  while(rs.next());
  }
	  rs.close();
	  stmt.close();
  }
  if(strRecFlag.equals("No")){%>
  <tr valign="top" class="formtr2">
  <td class="listdata" colspan="9"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage) %></td>
  </tr> 
 <% }
objRs.close();
objStmt.close();
dbConBean.close();	//CLOSE ALL THE CONNECTIONS
%>
</table>
<br>
</form>
</body>
</html>
