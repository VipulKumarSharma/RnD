
<!-- Header -->
<%
/***************************************************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY			:	Rohit Ganjoo
*Date				:   02/09/2006
*Description		:	Transfer Mechanism Main Screen for Domestic Travel
*Project			:   STAR
*Modification		:	Report is not display correct in case of MATA.
						1.@Sanjeet Kumar on 27-July-2007 for solving the attachment problem.
						2.  Query Added by Shiv Sharma so  Mata persone can see only the requsition which is on recive option and can transfer only these        requstion on 31-Mar-08   
		
*Modification Date	:	09/04/2007
*Modified By		:	Vijay Singh

*Modified By			: Manoj Chand
*Modification Date		: 12 may 2011
*Modification			: change in handover history part of this jsp page like showing requisition no. and handover to.

*Modified by			:Manoj Chand
*Date of Modification	:01 Feb 2013
*Modification			:showing requested value in comma separated way if multiple currency exist in the request.

*Modified By	        :MANOJ CHAND
*Date of Modification   :07 Feb 2013
*Description			:IE Compatibility Issue resolved.
*****************************************************************************************/
%>

<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" %>
<HTML>
<HEAD>
<%@ page pageEncoding="UTF-8" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%--<%@ include  file="systemStyle.jsp" %>--%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<%
// Variables declared and initialized

String strTravelType		=  "";
String strTravelTypeFlag	=  ""; 
strTravelType   =  request.getParameter("travel_type"); 
if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelType = "I";
}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelType = "D";
}
strTravelType = "D";

//System.out.println("strTravelTypeFlag dom"+strTravelType);
ResultSet rs,rs1	=	null;			  // Object for ResultSet

int intSerialNo				=  1;
String	strSql				=  ""; // For sql Statements
String	strTravelId	    	=  "";
String	strTravelRequestNo 	=  "";
String	strTravellerId   	=  "";
String	strTraveller	    =  "";
String	strOriginatorName	=  "";
String	strOriginatedDate 	=  "";
String	strNextApprover 	=  "";
String  strFrom             =  "";
String  strTo               =  "";
String  strTravelDate       =  "";
String	strSiteName			=  "";
String	strDivName			=  "";
int iCls				    =  0;
String strStyleCls			=  "";
String strTitle				=  "";
String strButtonDisabled	=  "";
String strTravelAmount		=  "";
String strProcessType		= (request.getParameter("pType")==null)?"ALL":request.getParameter("pType");
String strMATA  = "MATA";

String strGroupTravelFlag="";
String strTravelAgencyTypeId="";
%>


<script language=JavaScript >
function childwindowSubmit(){
	document.frm.action='T_transferMain_D.jsp';
	document.frm.submit();
}
function checkAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = true ;
}

function uncheckAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = false ;
}

function check()
{
	var aa=document.frm.delName.value;
if(aa=='')
	{
alert('<%=dbLabelBean.getLabel("alert.handover.selectthenameofauthoritytohandover",strsesLanguage)%>');
document.frm.delName.focus();
return false;
	}


var a=document.frm.reasons.value;
if(a=='')
	{
alert('<%=dbLabelBean.getLabel("alert.handover.selectreasonsfortransfer",strsesLanguage)%>');
document.frm.reasons.focus();
return false;
	}

for (i = 0; i < document.frm.length; i++)
	{
	if ( document.frm[i].checked == true)
		return true;
	}
alert('<%=dbLabelBean.getLabel("alert.approverequest.errormessage",strsesLanguage)%>');
return false; 
}

</script>
</HEAD>

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40" class="bodyline-top">
	<ul class="pagebullet">
	<% if(ssflage.equals("3")){%>
      <li class="pageHead"> <b><%=dbLabelBean.getLabel("label.handover.domesticeuroperequest",strsesLanguage)%></b></li>
      <%}else{ %>
       <li class="pageHead"> <b><%=dbLabelBean.getLabel("label.handover.domesticrequest",strsesLanguage)%></b></li>
       <%} %>    </ul></td>
     <td align="right" valign="bottom" class="bodyline-top">
	   <table align="right" border="0" cellspacing="0" cellpadding="0">
    <tr align="right">
       <td >
      <ul id="list-nav">    
<%
  if(SuserRole!=null && SuserRole.equals("MATA") )
  {}
  else
  {		 
%>
     
      <li><a href="#" onClick="MM_openBrWindow('T_MyReturns_D.jsp?flag=1&travel_type=D','REQUISITIONSAPPROVED','scrollbars=yes,resizable=yes,width=800,height=550');"><%=dbLabelBean.getLabel("button.approverequest.requisitionsreturned",strsesLanguage) %></a></li>
      <%}%>
      <li><a href="#" onClick="MM_openBrWindow('MyApproved_D.jsp?flag=1&travel_type=D','REQUISITIONSAPPROVED','scrollbars=yes,resizable=yes,width=800,height=550');"><%=dbLabelBean.getLabel("button.approverequest.requisitionsapproved",strsesLanguage) %></a></li>
      <li><a href="#" onClick="MM_openBrWindow('T_searchTravelRequisitions.jsp?travel_type=D','SEARCH','scrollbars=yes,resizable=yes,top=110,left=0,width=1017,height=565');"><%=dbLabelBean.getLabel("button.global.search",strsesLanguage) %></a></li>
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      </ul>
      </td>
   	  </tr>
  </table>
    </td>
  </tr>
</table>

<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
    <form method=post name="frm" action="T_purchaseReqTransferPost.jsp" onsubmit="return check(0);">
     <input type="hidden" name="pType" value="<%=strProcessType.trim()%>">
	 <input type="hidden" name="travel_type" value="D">
	 <%
	 if((strProcessType.equals("ALL")))
     {
	%>		 
  <tr class="formhead"> 
    <td class="listhead" width="1%" align="center"><img src="images/tick2.gif?buildstamp=2_0_0" border=0></td>
	<td class="listhead" width="3%" align="center">#</td>	
 	<td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.approverequest.viewandapprove",strsesLanguage) %></td>
    <td class="listhead" width="11%" align="center"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage) %></td>
	<td class="listhead" width="9%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %></td>
	<td class="listhead" width="9%" align="center"><%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage) %></td>
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.departuredateofforwadjouney",strsesLanguage) %> </td><!-- 2/26/2007 -->
	<td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.mail.amountrequested",strsesLanguage) %></td>
	<td class="listhead" width="8%" align="center"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage) %></td>
	<td class="listhead" width="9%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage) %></td>
	<td class="listhead" width="8%" align="center"><%=dbLabelBean.getLabel("label.approverequest.nextwith",strsesLanguage) %></td>	
	<td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage) %></td> 
  </tr>
     

<%

String strApproverRole =  "";

//Query for Finding the role of approver
strSql  = "SELECT DISTINCT TA.ROLE FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+" AND TS.TRAVEL_STATUS_ID=2 AND TA.TRAVEL_TYPE='D'  AND ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID  AND TRAVEL_TYPE='D'  AND APPROVE_STATUS=0 AND STATUS_ID=10)";
//System.out.println("strSql 1"+strSql);
rs = dbConBean.executeQuery(strSql);         //get the result set
if(rs.next())
{
    strApproverRole = rs.getString(1);
}
rs.close();
//@ Vijay Singh 03/04/2007 Change logic 

	strSql="SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT,TD.GROUP_TRAVEL_FLAG  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2         AND TA.TRAVEL_TYPE='D'          AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+" AND  ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D'  AND APPROVE_STATUS=0 AND STATUS_ID=10)";


if(SuserRole!=null && SuserRole.equals("MATA") )
		 {		
	
       /// Query Commented by shiv on 28-Mar-08 for not showing recived requisition 
		  /*		
		strSql ="SELECT DISTINCT TD.TRAVEL_ID, TD.TRAVELLER_ID, TD.TRAVEL_REQ_NO,ISNULL(RTRIM(.DBO.USER_NAME(TD.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TD.C_DATETIME),'-') AS C_DATE, ISNULL(RTRIM(.DBO.USER_NAME(TD.C_USERID)),'NA') AS CREATED_BY, ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TD.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT,dbo.TRAVEL_COMMENT(TD.TRAVEL_ID,'D') AS COMMENT,ta.approver_id  FROM T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD,T_APPROVERS TA WHERE TD.TRAVEL_ID=TS.TRAVEL_ID  AND TD.TRAVEL_ID=TA.TRAVEL_ID AND TD.STATUS_ID=10  AND TS.TRAVEL_STATUS_ID=10 AND TS.TRAVEL_TYPE='D'  and ta.travel_type='D'  and ta.approve_status=10 and ta.approver_id="+Suser_id;
		*/

      /// Query Added by Shiv Sharma so  Mata persone can see only the requsition which is on recive option and can transfer only these       
      //   requstion on 31-Mar-08     

         
		strSql="SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT,dbo.TRAVEL_COMMENT(TD.TRAVEL_ID,'D') AS COMMENT,TD.GROUP_TRAVEL_FLAG FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2         AND TA.TRAVEL_TYPE='D'          AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+" AND  ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D'  AND APPROVE_STATUS=0 AND STATUS_ID=10)";
		
		}
		//End Modification
/*else
{
	  strSql="SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2         AND TA.TRAVEL_TYPE='D'              AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.SITE_ID="+strSiteIdSS+" AND  TA.APPROVER_ID="+Suser_id+"  AND ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D'  AND APPROVE_STATUS=0 AND STATUS_ID=10)";
}*/

String strColor="";




rs = dbConBean.executeQuery(strSql);
String strFinalApprovalStatus="";
String strAttachment="0";
if(rs.next())
{
	
	do
	{

	strTravelId     		=	rs.getString(1);
	strTravellerId          =	rs.getString(2);
	strTravelRequestNo		=	rs.getString(3);
	strTraveller        	= 	rs.getString(4);	
	strOriginatorName		=	rs.getString(5);
	strOriginatedDate		=	rs.getString(6);	
	strNextApprover 		=	rs.getString(7);	
	strAttachment			=	rs.getString(8);


  //added code for show traveller name as group travel  in case of group travel on 18-Jun-08 by shiv sharna   
	 	strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
	 	
								if(strGroupTravelFlag==null) 
								{
									strGroupTravelFlag="N";
								}
								if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
								{		
									strTraveller="Group/Guest Travel ";
									//strPageUrl = "Group_T_TravelRequisitionDetails_D.jsp";
  							    }
								else {
									//strPageUrl = "T_TravelRequisitionDetails_D.jsp";
								}

    strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),dbo.FN_GET_EXPENDITURE('"+strTravelId+"','D') AS Expenditure,ISNULL(dbo.TRAVEL_FROM("+strTravelId+",'D'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'D'),'-') AS TRAVEL_TO, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id  FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID="+strTravelId;   
    rs1 = dbConBean1.executeQuery(strSql);
	if(rs1.next())
	{
		strTravelDate       =   rs1.getString(1);
		strTravelAmount     =   rs1.getString(2);
		strFrom             =   rs1.getString(3);
		strTo               =   rs1.getString(4);	
		strTravelAgencyTypeId			=	rs1.getString("travel_agency_id");
		
	}
	if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
		strTraveller ="Guest Travel";
	}
	
	rs1.close();
	
	if(strAttachment.equals("0"))
	{
		strAttachment="";
	}
	else
	{
		strAttachment="<img src=images/clip123.gif border=0>";
	}

	strColor	=   "";
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 
    iCls++;

%>

  <tr VALIGN="TOP" class="<%=strStyleCls%>"> 
   <td width="3%" align="Left" bgColor="<%=strColor%>"><input class="<%=strStyleCls%>" type=checkbox name="chk<%=intSerialNo%>" value="<%=strTravelId%>;<%=strTravellerId%>"></td>
    <input class="colorpink" type=hidden name="transType<%=intSerialNo%>" value="REQS">
    <td class="listhead" width="3%" align="Left"><%=intSerialNo%><!-- @Sanjeet started here --> <a href="#" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=D&&whichPage=T_transferMain_D.jsp','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strAttachment%></a> </td>
	<!-- code end -->
<%
    if(SuserRole!=null && SuserRole.equals("MATA") )
    	
    {
%><!--@ Vijay 02/04/2007 Change the file from T_reqFrame_MATA.jsp to MATA_Report_DOM.jsp -->
	  <td class="listdata" width="5%" align="center">
		<% if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){%>
			<a href="#" onClick="MM_openBrWindow('T_TravelRequisitionDetails_INT_GmbH.jsp?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travelType=D','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a> 
		<%}else{ %>
			<a href="#" onClick="MM_openBrWindow('MATA_Report_DOM.jsp?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a>
		<%} %>
	  </td>
<%  }
	else
	{
%>	
	<td class="listdata" width="5%" align="center">
		<a href="#" onClick="MM_openBrWindow('T_reqFrame.jsp?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a> 
	</td>
<% /**************************End Modification**************************/
	}
%>
    <td class="listdata" width="11%" align="center"><%=strTraveller%></td>
    <td class="listdata" width="9%" align="center"><%=strFrom%></td>
    <td class="listdata" width="9%" align="center"><%=strTo%></td>
    <td class="listdata" width="10%" align="center"><%=strTravelDate%></td>
	<td class="listdata" width="8%" align="center"><%=strTravelAmount%></td>
    <td class="listdata" width="10%" align="center">&nbsp;<%=strOriginatedDate%></td>
	<td class="listdata" width="9%" align="center"><%=strOriginatorName%></td>
	<td class="listdata" width="9%" align="center"><B><%=strNextApprover%></B></td> 
    <td class="listhead" width="13%" align="center">
      <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=D&whichPage=T_transferMain_D.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>"><%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%></a>  | <a href="#" title="<%=dbLabelBean.getLabel("label.global.addcomments",strsesLanguage)%>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=D&whichPage=T_transferMain_D.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><!--<img src="images/group1.gif?buildstamp=2_0_0" border=0>-->
      <%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%></a> 
	</td>
  </tr>
   <%
  intSerialNo++;
	}
				while(rs.next());				
				}
				else
	{
				strButtonDisabled="disabled";

%>
<tr> 
    <td colspan="12" class="formtr1"><%=dbLabelBean.getLabel("label.handover.notravelrequisitionavailabefortransfer",strsesLanguage) %></td>
  </tr>
    <%
}
rs.close();
//dbConBean.close();
 }
%>
</table>
<br><br>
   
<%
int iSno=intSerialNo;
%>
<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
<input type=hidden name="count" value="<%=iSno-1%>">
  <tr valign="top" class="listhead"> 


<% if(SuserRole!=null &&  !SuserRole.equals("MATA") ){ 
	
	//System.out.println("If user role is not  mata in transfer main_d.jsp");
	%>
				
				<td class="formtr3" colspan="10" align="Left"><center>
			<%=dbLabelBean.getLabel("label.handover.selectdelegate",strsesLanguage) %>
			<Select name="delName" class="textBoxCSS">
			<option value=""><%=dbLabelBean.getLabel("label.handover.select",strsesLanguage) %></option>
			<%
			strSql="SELECT USERID,.DBO.USER_NAME(USERID) FROM M_USERINFO WHERE STATUS_ID=10 AND SITE_ID='"+strSiteIdSS+"' and userid != '" + Suser_id +"' and dbo.FINALOOO(USERID,getdate(), 'd') is null ORDER BY 2";
			
			rs = dbConBean.executeQuery(strSql);
			while(rs.next())
			{
			%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
			<%
			}
			rs.close();
			%>
			</select>

			

<% } %>


<% if(SuserRole!=null &&  SuserRole.equals("MATA") ){
	
	//System.out.println("If user role is mata in transfer main_d.jsp");
	%>
				
				<td class="formtr3" colspan="10" align="Left"><center>
			<%=dbLabelBean.getLabel("label.handover.selectdelegate",strsesLanguage) %>
			<Select name="delName" class="textBoxCSS">
			<option value=""><%=dbLabelBean.getLabel("label.handover.select",strsesLanguage) %></option>
			<%
			strSql="SELECT USERID,.DBO.USER_NAME(USERID) FROM M_USERINFO WHERE STATUS_ID=10 AND SITE_ID='"+strSiteIdSS+"' and userid != '" + Suser_id +"' and role_id = 'MATA' and dbo.FINALOOO(USERID,getdate(), 'd') is null	ORDER BY 2";
			//System.out.println(" AND SuserRole!= MATA " + SuserRole);
			rs = dbConBean.executeQuery(strSql);
			while(rs.next())
			{
			%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
			<%
			}
			rs.close();
			%>
			</select>

		
		<%	} %>
		
		<%=dbLabelBean.getLabel("label.handover.selectyourreasonfortransfer",strsesLanguage) %>
				<Select name="reasons" class="textBoxCSS">
				<option value=""><%=dbLabelBean.getLabel("label.handover.select",strsesLanguage) %></option>
			<%
			strSql="SELECT TRANSFER_REASON AS A, TRANSFER_REASON AS B FROM TRANSFER_REASONS  WHERE STATUS_ID=10 ORDER BY 1";
			rs = dbConBean.executeQuery(strSql);
			while(rs.next())
			{
			%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
			<%
			}
			rs.close();
			%>

</select>	
</td>
</tr>
	<tr class="formbottom">
	<td>
	<input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("button.handover.handover",strsesLanguage) %>" class="formbutton" <%=strButtonDisabled%> >
	<input type="button" name="CheckAll" value="<%=dbLabelBean.getLabel("button.approverequest.checkall",strsesLanguage) %>" 
	onClick="checkAll(document.frm)" class="formbutton" >
	<input type="button" name="UnCheckAll" value="<%=dbLabelBean.getLabel("button.approverequest.uncheckall",strsesLanguage) %>"
	onClick="uncheckAll(document.frm)" class="formbutton" > 
	</center></td>
  </tr>
</form>
<br>
</table>
<br><br>

<!--
  <tr> 
    <td colspan="12" class="colorPink" >&nbsp;</td>
  </tr>
-->

<%
Connection con	=	null;			    // Object for connection
Statement stmt	=	null;			   // Object for Statement
//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
strSql="SELECT TRAVEL_REQ_NO,OFFICER_ID,.DBO.USER_NAME(TRANSFER_TO),.DBO.CONVERTDATE(TRANSFER_STARTDATE),.DBO.CONVERTDATE(TRANSFER_ENDDATE),RTRIM(COMMENTS) FROM APP_REQ_JOBS_TRANSFER WHERE OFFICER_ID='"+Suser_id+"'AND TRAVEL_TYPE='D' ORDER BY 3 DESC";
//System.out.println("strSql2222"+strSql);
int iLoop=1;
stmt			 = con.createStatement(); 
rs				 = stmt.executeQuery(strSql);
String strRowColor="";
if(rs.next())
{
	%>
<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <tr>
    <td align="center" class="formtr3" colspan="5"><%=dbLabelBean.getLabel("label.handover.handoverhistory",strsesLanguage) %></td>
  </tr>
<tr class="formtr3">
    <td align="left" class="formtr3" width="3%">#</td>
    <td align="left" class="formtr3" width="15%"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage) %></td>
    <td align="left" class="formtr3" width="15%"><%=dbLabelBean.getLabel("label.handover.handoverto",strsesLanguage) %></td>
    <td align="left" class="formtr3" width="13%"><%=dbLabelBean.getLabel("label.handover.handoveron",strsesLanguage) %></td>
     <td align="left" class="formtr3" width="49%"><%=dbLabelBean.getLabel("label.handover.handoverreason",strsesLanguage) %></td>
  </tr>

<%
do
	{
%>
<%
	if (iCls%2 == 0) { 
		strStyleCls="formtr1";
    } else { 
		strStyleCls="formtr2";
    } 


	  iCls++;
%>
<tr class="<%=strStyleCls%>">
<td><%=iLoop++%></td>
<td><%=rs.getString(1)%></td>
<td><%=rs.getString(3)%></td>
<td><%=rs.getString(4)%></td>
<td><%=rs.getString(6)%></td>
</tr>


<%
	}
while(rs.next());

}
con.close();
%>
</table>
</body>
</HTML>