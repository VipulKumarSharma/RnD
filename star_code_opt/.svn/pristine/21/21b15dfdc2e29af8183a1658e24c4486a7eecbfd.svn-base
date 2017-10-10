<%
/***************************************************
**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	 : STARS ****** 
**** Operating environment :Tomcat 6.0, sql server 2008 ******
**** Description : To display hold request history
**** Create Date : 21 Mar 2013
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

<%
// Variables declared and initialized
Connection objCon		=		null;			    // Object for connection
Statement objStmt,stmt		=		null;			   // Object for Statement
ResultSet objRs,rs			=		null;			  // Object for ResultSet
CallableStatement objCstmt		=		null;			// Object for Callable Statement

objCon=dbConBean.getConnection();

String	strSql,strSql1,sSqlStr	=	""; // For sql Statements
		
String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");
%>

</head>
<body>
<form name="frm" method="post">
<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="70%" height="35" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.administration.holdrequesthistory",strsesLanguage)%></li>
    </ul></td>
    <td width="30%" height="35" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
		<ul id="list-nav">
			<li><a href="M_HoldRequestList.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage) %></a></li>
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
    <td width="15%"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage) %></td>
	<td width="15%"><%=dbLabelBean.getLabel("label.administration.holdedby",strsesLanguage) %></td>
    <td width="10%"><%=dbLabelBean.getLabel("label.administration.holddate",strsesLanguage) %></td>
	<td width="10%"><%=dbLabelBean.getLabel("label.administration.unholddate",strsesLanguage) %></td>
	<td width="45%"><%=dbLabelBean.getLabel("label.administration.holdcomments",strsesLanguage) %></td>
		
   </tr>
  <%
  String strTravelid="",strTravelType="",strHoldedBy="",strHoldComments="",strCdate="",strUdate="";
  String strRequisitionId="",strNewReqNo="",strName="",strAmount="",strOriginatedBy="",strOriginatedOn="";
  String strGroupTravelFlag="",strTravellerID="",strTravelReqId="",strStyleCls="",strTravelAgencyTypeId="";
  String urlpage="",strDetailPageUrl="",strRecFlag="No";
  int iCls = 0,intSerialNo=0;
  strSql="SELECT TRAVEL_ID,TRAVEL_TYPE,DBO.user_name(C_USERID) as CREATEDBY,DBO.CONVERTDATEDMY1(thr.C_DATE) as C_DATE"+
	     " ,DBO.CONVERTDATEDMY1(thr.U_DATE) as U_DATE,LTRIM(RTRIM(COMMENTS)) as COMMENTS from dbo.T_HOLD_REQUEST thr WHERE thr.STATUS_ID=30 order by thr.C_DATE desc";
  //System.out.println("strSql---->"+strSql);
  objStmt	 = objCon.createStatement(); 
  objRs		 = objStmt.executeQuery(strSql);
  while(objRs.next())
  {
	  strRecFlag="Yes";
	  strTravelid=objRs.getString("TRAVEL_ID");
	  strTravelType=objRs.getString("TRAVEL_TYPE");
	  strHoldedBy=objRs.getString("CREATEDBY");
	  strCdate=objRs.getString("C_DATE");
	  strUdate=objRs.getString("U_DATE");
	  strHoldComments=objRs.getString("COMMENTS");
	  
	  if(strTravelType.equalsIgnoreCase("D")){
		  strSql1="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER,t.TRAVELLER_ID, t.travel_req_id, t.Group_Travel_Flag as Group_Travel_Flag FROM,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id T_TRAVEL_DETAIL_DOM t WHERE t.travel_id='"+strTravelid+"' and T.STATUS_ID=10";
	  }
	  else{
		  strSql1="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER,t.TRAVELLER_ID, t.travel_req_id, t.Group_Travel_Flag as Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_INT t WHERE t.travel_id='"+strTravelid+"' and T.STATUS_ID=10";
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
	  	strTravellerID						=	rs.getString(4);
	  	strTravelReqId         		        =   rs.getString(5); 
	  	strGroupTravelFlag                  =   rs.getString(6); 
	  	strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
	  	
	  	if (iCls%2 == 0) { 
	  		strStyleCls="formtr2";
	      } else { 
	  		strStyleCls="formtr1";
	      } 

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
	  				strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
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
	  				strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
				}
			  strName="Group/Guest Travel";
		  }else 
			{
			  urlpage="T_TravelDetail_Dom.jsp";
			  strDetailPageUrl="T_TravelRequisitionDetails_D.jsp";
			  if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
	  				strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
				}
		  }
	  }
	  	  iCls++;
	  %>
	    
	  <tr valign="top" class="<%=strStyleCls%>"> 
	    <td align="center"><%=++intSerialNo%></td>
		<td class="listdata" align="center">
			<a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strRequisitionId%>&traveller_Id=<%=strTravellerID%>&travelType=<%=strTravelType%>','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550')">
				<%=strNewReqNo%>
			</a>
		</td>
	  	<td class="listdata" align="center"><%=strHoldedBy%></td>
	  	<td class="listdata" align="center"><%=strCdate%></td>
	  	<td class="listdata" align="center"><%=strUdate%></td>
	    <td class="listdata" align="center"><%=strHoldComments%></td>
	</tr>
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
