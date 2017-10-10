<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:07 Nov 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for Cancel the Requisition
 *Modification 			:added a code for showing Group travel  in case of group travel  inspite of traveler name on 06-Mar-08 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script>
function CheckDataNext()
{
	document.frm.buttonData.value=1;
	document.frm.submit();
}

function CheckDataCriteria()
{
	window.location.href="sanctionCriteria.jsp";
}
function goback()
{
    history.go(-1);
}

function submitParent()
{
  window.opener.location = window.opener.location;
  window.close();
}

</script>
</head>
<%
// Variables declared and initialized

String strTravelType   =  "";
String strWhichPage    =  "";
String strTargetFrame  =  "";
String strTargetFlag   =  "";
strTravelType   =  request.getParameter("travel_type"); 
strWhichPage    =  request.getParameter("whichPage"); 


if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelType = "I";
}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelType = "D";
}

if(strWhichPage == null)
   strWhichPage = "#";

strTargetFlag    =  request.getParameter("targetFrame"); 
if(strTargetFlag !=null && strTargetFlag.equals("yes"))
{
     strTargetFrame="middle";  
}
else
   	strTargetFrame = "";


// Variables declared and initialized
Connection con	=	null;			    // Object for connection
Statement stmt	=	null;			   // Object for Statement
ResultSet rs	=	null;			  // Object for ResultSet
//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);

String	sSqlStr                             =   ""; // For sql Statements
String strRequisitionId                		=	"";
strRequisitionId                        	=	request.getParameter("purchaseRequisitionId");
int iCls = 0;
String strStyleCls                          =   "";
String	strNewReqNo		    				= 	"";
String	strName								=	"";
String	strAmount							=	"";
String	strCurrency							=	"";
String	strOriginatedBy		     			=	"";
String	strOriginatedOn			    		=	"";
String	strTravel_From						=	"";
String	strTravel_To						=	"";
String strGroupTravelFlag				="";
String strTravelAgencyTypeId	="";
//Added By Gurmeet Singh
String strUserAccessCheckFlag = "";
strUserAccessCheckFlag = securityUtilityBean.validateAuthCancelTravelReq(strRequisitionId, strTravelType, Suser_id);
if(strUserAccessCheckFlag.equals("420")){
	dbConBean.close();  
	securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_Travel_Requisition_Cancel.jsp", "Unauthorized Access");
	response.sendRedirect("UnauthorizedAccess.jsp");
	return;
} else {

%>
<script type="text/javascript">
	   function CheckDataSave()
	   {
	   	var a=document.frm.comments.value;
	   	if(a=="")
	   	{ 
	   		alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterthecomments",strsesLanguage)%>');
	   		document.frm.comments.focus();
	   		return false;
	   	}
	   	else
	   	{
	   		if(confirm('<%=dbLabelBean.getLabel("alert.cancelrequest.cancelrecord",strsesLanguage)%>'))
	   		{	document.frm.submit();
	   			var ParentPage = '<%=strWhichPage%>';
	   		  	if (ParentPage == 'T_searchTravelRequisitions.jsp')
	   			{	window.opener.$('#goBtn').trigger('click');
	   				top.window.close();
	   			}
	   		  	else
	   		  	{ 	top.window.close();
		   		  	window.opener.location.reload();
	   		  	}	
	   		}
	   		else
	   			return false;
	   	}
	   }
	   function closeWindow(){
	     	var ParentPage = '<%=strWhichPage%>';
	     	if (ParentPage == 'T_searchTravelRequisitions.jsp')
	   	{	window.opener.$('#goBtn').trigger('click');
	   	}
	   	top.window.close();
	   }
   </script>
</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="50" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><b><%=dbLabelBean.getLabel("label.report.cancelrequest",strsesLanguage)%></b></li>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
       <td>
     <ul id="list-nav">
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      <%if(strWhichPage.equalsIgnoreCase("T_searchTravelRequisitions.jsp")){ 
      %>
      <li><a href="" onClick="javascript:closeWindow();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
     <%}else{
   	 %>
   	 <li><a href="<%=strWhichPage%>" target="<%=strTargetFrame%>" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
     <%} %>
     </ul>
       </td>
       </tr>
    </table>
	</td>
  </tr>
</table>

 <form name=frm action="T_Travel_Requisition_Cancel_Post.jsp" method=post>
  <input type=hidden name=purchaseRequisitionId value="<%=strRequisitionId%>">
  <input type="hidden" name=travel_type value="<%=strTravelType%>"/>      
  <input type="hidden" name=whichPage value="<%=strWhichPage%>"/>      
  <input type="hidden" name=targetFrame value="<%=strTargetFlag%>"/>      
<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
         
		  <tr class="formhead">
          <td width="175px" align="center" class="listdata"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage) %></td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage) %></td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.global.travelfrom",strsesLanguage) %></td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.global.travelto",strsesLanguage) %></td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage) %>  </td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage) %></td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage) %></td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage) %></td>
          </tr>
<%
if(strTravelType.equalsIgnoreCase("I"))
{
  sSqlStr="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER, ISNULL(CONVERT(decimal(20,0),t.TOTAL_AMOUNT),'0') AS  TOTAL_AMOUNT, ISNULL(t.TA_CURRENCY,'-') AS TA_CURRENCY,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,DBO.CONVERTDATEDMY1(t.C_DATETIME),j.travel_from,j.travel_to,t.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_INT t,T_JOURNEY_DETAILS_INT j,T_TRAVEL_STATUS S WHERE t.travel_id=j.travel_id and    T.TRAVEL_ID=S.TRAVEL_ID   AND S.TRAVEL_TYPE='I' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10 AND t.TRAVEL_ID="+strRequisitionId+"  ORDER BY T.C_DATETIME DESC";
}
else
{

 sSqlStr="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER, ISNULL(CONVERT(decimal(20,0),t.TOTAL_AMOUNT),'0') AS  TOTAL_AMOUNT, ISNULL(t.TA_CURRENCY,'-') AS TA_CURRENCY,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,DBO.CONVERTDATEDMY1(t.C_DATETIME),j.travel_from,j.travel_to,t.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id  FROM T_TRAVEL_DETAIL_DOM t,T_JOURNEY_DETAILS_DOM j,T_TRAVEL_STATUS S WHERE t.travel_id=j.travel_id and  T.TRAVEL_ID=S.TRAVEL_ID  AND S.TRAVEL_TYPE='D' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10 AND t.TRAVEL_ID="+strRequisitionId+"  ORDER BY T.C_DATETIME DESC";

}

stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
//Suser_id
	while(rs.next())
	  {
	strRequisitionId				=	rs.getString(1);
	strNewReqNo						= 	rs.getString(2);
	strName							=	rs.getString(3);
	strAmount						=	rs.getString(4);
	strCurrency						=	rs.getString(5);
	strOriginatedBy					=	rs.getString(6);
	strOriginatedOn					=	rs.getString(7);	
	strTravel_From					=	rs.getString(8);
	strTravel_To					=	rs.getString(9);
	strTravelAgencyTypeId			=	rs.getString("travel_agency_id");

	///added a code for showing Group travele  in case of group travel  inspite of traveler name on 06-Mar-08 
	
	if(strTravelType.equalsIgnoreCase("I"))
    {
		                        strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
								
								if(strGroupTravelFlag==null) 
								{
									strGroupTravelFlag="N";
								}
								if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
								{		
							    strName="Group/Guest Travel"; 
							    if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
						 			strName ="Guest Travel";
								}
									
  							    }
								
     }else   ///  added  for showing group travel in case of group travel instead of traveler name on 18-Jun-08 by shiv sharma 
		  {
		     strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
								
								if(strGroupTravelFlag==null) 
								{
									strGroupTravelFlag="N";
								}
								if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
								{		
							    strName="Group/Guest Travel"; 
							    if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
						 			strName ="Guest Travel";
								}
									
  							    }
								
	 }

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
			<td width="175px" align="center" class="listdata"><%=strNewReqNo%></td>
			<td align="center" class="listdata">&nbsp;<%=strName%></td>
			<td align="center" class="listdata">&nbsp;<%=strTravel_From%></td>
			<td align="center" class="listdata">&nbsp;<%=strTravel_To%></td>
			<td align="center" class="listdata"><%=strAmount%></td>
			<td align="center" class="listdata"><%=strCurrency%></td>
			<td align="center" class="listdata"><%=strOriginatedBy%></td>
			<td align="center" class="listdata"><%=strOriginatedOn%></td>

		  </tr>
	<%
	
		  }
		  rs.close();
		  stmt.close();
	%>
   </table>    

<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">

          <tr valign="middle"> 
            <td width="175px" class="formtr2" text-align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<%=dbLabelBean.getLabel("label.comments.yourcomments",strsesLanguage) %></td>
            <td class="formtr1" colspan="6"> 
              <textarea name="comments" cols=107 rows=3 class="textBoxCss"></textarea>
            </td>
          </tr>

          <tr> 
            <td colspan="7" class="formbottom" align=center> 
			  <input type=hidden name=buttonData>
              <input type="button" name="save" value=" <%=dbLabelBean.getLabel("label.requestdetails.cancelrequisition",strsesLanguage) %>" class="formbutton" onClick="CheckDataSave();">
              <input type="reset" name="reset" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage) %>" class="formbutton">
            </td>
          </tr>
        
   </table>		
</form>
  <%} %>
</body>
</html>
