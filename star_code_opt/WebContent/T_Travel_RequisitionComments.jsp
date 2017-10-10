<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:05 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for add Comment with the travel requisition in TRAVEL_COMMENT Table of the STAR Database
 *Modification 			:1.Add the cancellation comments 
                                 2. Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on 04-Mar-08 ;  
								 3: added  for showing group travel in case of group travel instead of traveller name by shi sharma on 02-Jul-08
 *Reason of Modification: 
 *Date of Modification  : 23/Mar/2007
 *Modified By			:VIJAY SINGH
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			:Manoj Chand
 *Date of Modification	:04 July 2011
 *Modification			:add winclose() function to close the window and refreshing parent window.
 
 *Modified By			:Manoj Chand
 *Date of Modification	:19 Jan 2012
 *Modification			:add validation on comments and provide feature for delete comments.
 
 *Modified By			:Manoj Chand
 *Date of Modification	:18 Jun 2012
 *Modification			:resolve jquery error coming on comment page while deleting
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

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></SCRIPT>

<script>
function CheckDataSave()
{
	var a=document.frm.comments.value;
	if(a=="")
	{
		alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterthecomments",strsesLanguage) %>');
		document.frm.comments.focus();
		return false;
	}
	else
	{
		if(confirm('<%=dbLabelBean.getLabel("message.createrequest.areyousuretopostcomments",strsesLanguage) %>'))
			document.frm.submit();
		else
			return false;
	}
}
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

function winclose(){
	window.opener.childwindowSubmit();
	window.close();
}




//Function added by manoj chand on 02 Dec 2011 to delete comments
function deleteComments(commentId,reqId,trvType,whichPage)
{

var p_commentId=commentId;
var p_reqId=reqId;
var p_trvType=trvType;
var p_whichPage=whichPage;

//resolve jquery error by manoj chand on 18 june 2012
jQuery.noConflict();
jQuery(document).ready(function($) {
	
			var urlParams = "trvReqId="+p_reqId+"&CommentId="+p_commentId+"&reqFlag=comment"+"&traveltype="+p_trvType;
			if(confirm('<%=dbLabelBean.getLabel("message.createrequest.areyousuretodeletecomment",strsesLanguage) %>')){
			$.ajax({
	            type: "post",
	            url: "AjaxMaster.jsp",
	            data: urlParams,
	            success: function(result){
	            var res=jQuery.trim(result);
	            if(res=='y')
           	 		refreshPage(p_reqId,p_trvType,p_whichPage);
	            },
				error: function(){
					alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage) %>');
	            }
	          });
			}else{
			}
	
});

}


function refreshPage(reqId,trvType,whichpage){
	window.location.href="T_Travel_RequisitionComments.jsp?purchaseRequisitionId="+reqId+"&travel_type="+trvType+"&whichPage="+whichpage;
}
//end of delete comments functions
function test1(obj1, length, str)
{	
	var obj;
	
	if(obj1=='comments')
	{
		obj = document.frm.comments;
		upToTwoHyphen(obj);
	}
	charactercheck(obj,str);
    limitlength(obj, length);
	spaceChecking(obj);
  }
</script>




<%
// Variables declared and initialized

String strTravelType   =  "";
String strWhichPage    =  "";
String strTargetFrame  =  "";
String strTargetFlag   =  "";
strTravelType   =  request.getParameter("travel_type");
//System.out.println("Vijay.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+strTravelType);
strWhichPage    =  request.getParameter("whichPage"); 
//System.out.println("which page is=========="+strWhichPage);

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
//System.out.println("--------------------testing testing --------------"+strRequisitionId);
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
String strGroupTravelFlag					=	"";
String strReqStatus							=	"";
String strButtonStatus						=	"enabled";
String strOriginator						=	"";
String strApproveStatus						=	"";
String strTkProviderFlag					=	"";
String strTravelAgencyTypeId	="";

//Added By Gurmeet Singh
String strUserAccessCheckFlag = "";
strUserAccessCheckFlag = securityUtilityBean.validateAuthCommentsTravelReq(strRequisitionId, strTravelType, Suser_id);

if(strUserAccessCheckFlag.equals("420")){	
	dbConBean.close();  		
	securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_Travel_RequisitionComments.jsp", "Unauthorized Access");
	response.sendRedirect("UnauthorizedAccess.jsp");		
} else {

%>

</head>

<body onload="document.frm.comments.focus();">
<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="40%" height="40" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><b><%=dbLabelBean.getLabel("label.global.postcomments",strsesLanguage) %></b></li>
    </ul></td>
    <td width="100%" align="right" valign="bottom" class="bodyline-top">
	<table  align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
       <td>
     <ul id="list-nav">
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      <li><a href="#" onClick="javascript:window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
     </ul>
       </td>
      </tr>
    </table>
	</td>
  </tr>
</table>

 <form name=frm action="T_Travel_RequisitionComments_Post.jsp" method=post>
  <input type=hidden name=purchaseRequisitionId value="<%=strRequisitionId%>">
  <input type="hidden" name=travel_type value="<%=strTravelType%>"/>      
  <input type="hidden" name=whichPage value="<%=strWhichPage%>"/>      
  <input type="hidden" name=targetFrame value="<%=strTargetFlag%>"/>      
<table width="85%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
         
		  <tr class="formhead">
          <td width="14%" class="listdata"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage) %></td>
		  <td width="12%" class="listdata"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage) %></td>
		  <td width="12%" class="listdata" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.travelfrom",strsesLanguage) %></td>
		  <td width="12%" class="listdata"><%=dbLabelBean.getLabel("label.global.travelto",strsesLanguage) %></td>
		  <td width="15%" class="listdata"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage) %></td>
		  <td width="10%" class="listdata" nowrap="nowrap"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage) %></td>
		  <td width="10%" class="listdata" nowrap="nowrap"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage) %></td>
          </tr>
<%
if(strTravelType.equalsIgnoreCase("I"))
{
  sSqlStr="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER,dbo.FN_GET_EXPENDITURE(t.travel_id,'I') AS Expenditure,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,DBO.CONVERTDATEDMY1(t.C_DATETIME),j.travel_from,j.travel_to,t.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_INT t,T_JOURNEY_DETAILS_INT j,T_TRAVEL_STATUS S WHERE t.travel_id=j.travel_id and    T.TRAVEL_ID=S.TRAVEL_ID   AND S.TRAVEL_TYPE='I' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10 AND t.TRAVEL_ID="+strRequisitionId+"  ORDER BY T.C_DATETIME DESC";
}
else
{
 sSqlStr="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER,dbo.FN_GET_EXPENDITURE(t.travel_id,'D') AS Expenditure,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,DBO.CONVERTDATEDMY1(t.C_DATETIME),j.travel_from,j.travel_to,t.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id  FROM T_TRAVEL_DETAIL_DOM t,T_JOURNEY_DETAILS_DOM j,T_TRAVEL_STATUS S WHERE t.travel_id=j.travel_id and    T.TRAVEL_ID=S.TRAVEL_ID  AND S.TRAVEL_TYPE='D' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10 AND t.TRAVEL_ID="+strRequisitionId+"  ORDER BY T.C_DATETIME DESC";
}

stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
//Suser_id
	while(rs.next())
	  {
	strRequisitionId				=	rs.getString(1);
	strNewReqNo						= 	rs.getString(2);
	strName							=	rs.getString(3);
	strAmount						=	rs.getString("Expenditure");
	//strCurrency						=	rs.getString(5);
	strOriginatedBy					=	rs.getString("ORIGINATOR");
	strOriginatedOn					=	rs.getString(6);	
	strTravel_From					=	rs.getString("travel_from");
	strTravel_To					=	rs.getString("travel_to");
	strTravelAgencyTypeId			=	rs.getString("travel_agency_id");

//  Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on 20-Feb-08 ;  

	if(strTravelType.equalsIgnoreCase("I"))
             {
     	   strGroupTravelFlag     =   rs.getString("GROUP_TRAVEL_FLAG"); 
 
		    if(strGroupTravelFlag==null) 
				{
			    strGroupTravelFlag="N";
			 }
			 
			if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
				{
			 		strName="Group/Guest Travel ";  
			 		if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			 			strName ="Guest Travel";
					}
   			    }

  }else  ///  added  for showing group travel in case of group travel instead of traveller name by shi sharma on 02-Jul-08
		  {
	     	   strGroupTravelFlag     =   rs.getString("GROUP_TRAVEL_FLAG"); 
 
		    if(strGroupTravelFlag==null) 
				{
			    strGroupTravelFlag="N";
			 }
			 
			if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
				{
			 		strName="Group/Guest Travel ";  
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
			<td width="10%" class="listdata"><%=strNewReqNo%></td>
			<td width="10%" class="listdata">&nbsp;<%=strName%></td>
			<td width="10%" class="listdata">&nbsp;<%=strTravel_From%></td>
			<td width="10%" class="listdata">&nbsp;<%=strTravel_To%></td>
			<td width="20%" class="listdata"><%=strAmount%></td>
		<td width="10%" class="listdata"><%=strOriginatedBy%></td>
		<td width="10%" class="listdata"><%=strOriginatedOn%></td>

		  </tr>
	<%
	
		  }
		  rs.close();
		  stmt.close();
		    
		 // Added By Manoj Chand on 02 Dec 2011 to give provision for Delete comments
			sSqlStr="SELECT TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"'";
		 	//System.out.println("sql---comments--->"+sSqlStr);
		 	rs = dbConBean.executeQuery(sSqlStr);
		 	if(rs.next()){
		 		strReqStatus=rs.getString("TRAVEL_STATUS_ID");
		 	}
		 	rs.close();
		   
		 	if (strRequisitionId != null && !"".equals(strRequisitionId)) 
			{
		 		sSqlStr	=	"SELECT DISTINCT C_USER_ID FROM   T_APPROVERS WHERE  (TRAVEL_ID = "+strRequisitionId+") AND (TRAVEL_TYPE = '"+strTravelType+"' ) ";
				rs = dbConBean.executeQuery(sSqlStr);
				if(rs.next())
				{
					strOriginator	=	rs.getString(1);
						
				}
				rs.close();
			}
		 	if (strRequisitionId != null && !"".equals(strRequisitionId)) 
			{  
		 		//sSqlStr	=	"select approve_status from T_APPROVERS where T_APPROVERS.TRAVEL_ID='"+strRequisitionId+"' and T_APPROVERS.STATUS_ID=10 and T_APPROVERS.TRAVEL_TYPE='"+strTravelType+"' and T_APPROVERS.RECEIVED_DATE is not null and T_APPROVERS.APPROVER_ID="+Suser_id;
		 		sSqlStr	=	"select approve_status,approve_id from T_APPROVERS where T_APPROVERS.TRAVEL_ID='"+strRequisitionId+"' and T_APPROVERS.STATUS_ID=10 and T_APPROVERS.TRAVEL_TYPE='"+strTravelType+"' and T_APPROVERS.APPROVER_ID="+Suser_id+" order by T_APPROVERS.APPROVE_ID desc";
		 		//System.out.println("sSqlStr---approvestatus-->"+sSqlStr);
				rs = dbConBean.executeQuery(sSqlStr);
				if(rs.next())
				{
					strApproveStatus	=	rs.getString(1);
						
				}
				rs.close();
			}
		 	
		 	if (strRequisitionId != null && !"".equals(strRequisitionId)) 
			{  
		 		if(strTravelType.trim().equalsIgnoreCase("D"))
		 		sSqlStr	=	"select TK_PROVIDER_FLAG from T_TRAVEL_DETAIL_DOM where T_TRAVEL_DETAIL_DOM.TRAVEL_ID="+strRequisitionId;
		 		else
		 			sSqlStr	=	"select TK_PROVIDER_FLAG from T_TRAVEL_DETAIL_INT where T_TRAVEL_DETAIL_INT.TRAVEL_ID="+strRequisitionId;
		 		
		 		//System.out.println("strstql for tk_provider flag -->"+sSqlStr);
				rs = dbConBean.executeQuery(sSqlStr);
				if(rs.next())
				{
					strTkProviderFlag	=	rs.getString(1);
						
				}
				rs.close();
			}
		 	
		 	
		 	
		 	

		 	
		 	
		 	
		 //if block added by manoj chand on 02 dec 2011 to disable the save button
			  if(strReqStatus.equalsIgnoreCase("4") || strReqStatus.equalsIgnoreCase("10")){
				  //System.out.println("---------if -----");
				  strButtonStatus="disabled";
			  }
	  	//End here
	%>
   </table>    

<table width="85%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">

          <tr align="left" valign="top"> 
            <td width="50%" class="formtr2"><%=dbLabelBean.getLabel("label.comments.yourcomments",strsesLanguage) %></td>
            <td class="formtr1" colspan="2"> 
              <textarea name="comments" cols=50 rows=8 class="textBoxCss" onKeyUp="test1('comments',500,'txt');"></textarea>
            </td>
          </tr>

          <tr> 
            <td colspan="3" class="formbottom" align=center> 
			  <input type=hidden name=buttonData>
              <input type="button" name="save" value=" <%=dbLabelBean.getLabel("button.global.save",strsesLanguage) %>" <%=strButtonStatus %> class="formbutton" onClick="CheckDataSave();">
              <input type="reset" name="reset" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage) %>" class="formbutton" onClick="document.frm.comments.focus();">
            </td>
          </tr>
        
   </table>
	
        <table width="85%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
			<tr class="formhead">
				<td class="listhead" width="6%" align="left" valign="top" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
				<td class="listhead" width="24%" align="left" valign="top"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></td>
				<td class="listhead" width="24%" align="left" valign="top"><%=dbLabelBean.getLabel("label.global.postedby",strsesLanguage) %></td>
				<td class="listhead" width="24%"><%=dbLabelBean.getLabel("label.global.postedon",strsesLanguage) %></td>
				<%
				if(strReqStatus.equalsIgnoreCase("1") || strReqStatus.equalsIgnoreCase("3") || strReqStatus.equalsIgnoreCase("2"))
				{
				%>
 								<td class="listhead" width="24%"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage) %></td>
				<%} %>
			</tr>
		<%
		String strCommentId		=	null;
		String strComments		=	null;
		String strPostedBy		=	null;
		String strPostedOn		=	null;
	    String strCommentsId			=	"";
		 String strOriginatedUserId=	"";

		sSqlStr="SELECT TRAVEL_ID,COMMENTS,DBO.USER_NAME(POSTED_BY),DBO.CONVERTDATEDMY1(POSTED_ON), COMMENTS_ID,POSTED_BY FROM TRAVEL_REQ_COMMENTS WHERE TRAVEL_ID='"+strRequisitionId+"'  AND TRAVEL_TYPE='"+strTravelType+"' ORDER BY POSTED_ON DESC";
		//System.out.println("---->"+sSqlStr);
	 //stmt = con.createStatement(); 
	 rs = dbConBean.executeQuery(sSqlStr);
	 int intSno=1;
	 if(rs.next())
	 {
		do
		 {
			 strCommentId			=	rs.getString(1);
			 strComments			=	rs.getString(2);
			 strPostedBy			=	rs.getString(3);
			 strPostedOn			=	rs.getString(4);
			 strCommentsId			=	rs.getString(5);
			 strOriginatedUserId	=	rs.getString(6);
%>
<%
         	if (iCls%2 == 0) { 
        		strStyleCls="formtr2";
            } else { 
    		strStyleCls="formtr1";
            } 
	  iCls++;
%>
				<tr class="<%=strStyleCls%>">
				<td class="listdata" width="6%" align="left" valign="top"><%=intSno++%></td>
				<td class="listdata" width="24%" align="left" valign="top"><%=strComments%></td>
				<td class="listdata" width="24%" align="left" valign="top"><%=strPostedBy%></td>
				<td class="listdata" width="24%"><%=strPostedOn%></td>
<%
/*System.out.println("Suser_id-->"+Suser_id);
System.out.println("strOriginatedUserId- WHO CREATE COMMENTS->"+strOriginatedUserId);
System.out.println("strReqStatus-->"+strReqStatus);
System.out.println("strApproveStatus--------->"+strApproveStatus);
System.out.println("strOriginator-->"+strOriginator); 
System.out.println("strGroupTravelFlag---"+strGroupTravelFlag);*/
//conditons added by manoj chand on 19 jan 2012 to create validations
if(strGroupTravelFlag!=null && (strGroupTravelFlag.trim().equalsIgnoreCase("") || strGroupTravelFlag.trim().equalsIgnoreCase("N"))){
	

			if (Suser_id.trim().equals(strOriginator.trim())  && (strReqStatus.equalsIgnoreCase("1")))
			{
				//System.out.println("---for temporary request-------------0----------------");
%>
<td>
    			<a href="#" onClick="deleteComments('<%=strCommentsId%>','<%=strRequisitionId%>','<%=strTravelType %>','<%=strWhichPage %>')"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
    			</td>
<%
			}else if(Suser_id.trim().equals(strOriginatedUserId.trim()) && strOriginator.trim().equals(strOriginatedUserId.trim()) && strReqStatus.equalsIgnoreCase("3")){
				//System.out.println("---returned request-------------0.1----------------");
				%>
				<td>
    			<a href="#" onClick="deleteComments('<%=strCommentsId%>','<%=strRequisitionId%>','<%=strTravelType %>','<%=strWhichPage %>')"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
    			</td>
			<%}
			
			else if(Suser_id.trim().equals(strOriginator.trim()) && strReqStatus.equalsIgnoreCase("2") && strApproveStatus.trim().equals("") ){
				//System.out.println("---for submit to workflow-------------1----------------");
			%>
			<td>
			<a href="#" onclick="return false;" disabled><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
				</td>
			<%}else if(Suser_id.trim().equals(strOriginator.trim()) && strReqStatus.equalsIgnoreCase("2") && strApproveStatus.equals("0") && strTkProviderFlag.trim().equalsIgnoreCase("n") )
			{
				//System.out.println("---for submit to workflow-------------1.05----------------");
			%>
				<td>
			<a href="#" onclick="return false;" disabled><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
				</td>
			<%}
			else if(Suser_id.trim().equals(strOriginator.trim()) && strReqStatus.equalsIgnoreCase("2") && strApproveStatus.equals("0") && strTkProviderFlag.trim().equalsIgnoreCase("y") ){
				//System.out.println("---for submit to workflow-------------1.1----------------");
				%>
				<td>
    			<a href="#" onClick="deleteComments('<%=strCommentsId%>','<%=strRequisitionId%>','<%=strTravelType %>','<%=strWhichPage %>')"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
    			</td>
		<%	}
			else if(Suser_id.trim().equals(strOriginator.trim()) && strReqStatus.equalsIgnoreCase("2") && strApproveStatus.equals("10") )
			{//System.out.println("---for submit to workflow after approve by approver-------------1.2----------------");
			%> 
				<td>
				<a href="#" onclick="return false;" disabled><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>			
				</td>
		<%	}
			else if(Suser_id.trim().equals(strOriginatedUserId.trim()) && !strOriginator.trim().equalsIgnoreCase(strOriginatedUserId) && strReqStatus.equalsIgnoreCase("2") && strApproveStatus.equals("0"))
			{//System.out.println("---for submit to workflow after approve by approver-------------1.3----------------");
				%>
				<td>
    			<a href="#" onClick="deleteComments('<%=strCommentsId%>','<%=strRequisitionId%>','<%=strTravelType %>','<%=strWhichPage %>')"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
    			</td>
			<%}
			else if(Suser_id.trim().equals(strOriginatedUserId.trim()) && !strOriginator.trim().equalsIgnoreCase(strOriginatedUserId) && strReqStatus.equalsIgnoreCase("2") && strApproveStatus.equals("10"))
			{//System.out.println("---for submit to workflow after approve by approver-------------1.4----------------");
			%>
				<td>
				<a href="#" onclick="return false;" disabled><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>			
				</td>
			<%}
			else if(strReqStatus.trim().equalsIgnoreCase("4") || strReqStatus.trim().equalsIgnoreCase("10") || strReqStatus.trim().equalsIgnoreCase("6")){
				//System.out.println("---for rejected  / cancelled / approve by all----------------");
				%>
				
			<%}
			else
    		 {
				//System.out.println("---------------5---------------");
				%>
				<td>
				<a href="#" onclick="return false;" disabled><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>			
				</td>
<%			 }}
else if(strGroupTravelFlag!=null && strGroupTravelFlag.trim().equalsIgnoreCase("Y")){
	//System.out.println("---------------group--------------");
	
	if (Suser_id.trim().equals(strOriginatedUserId.trim()) && (strOriginator.trim().equals("") || strOriginator.trim().equals(Suser_id))  && strReqStatus.equalsIgnoreCase("1"))
	{
		//System.out.println("---for GROUP temporary request-------------G0----------------");
%>
<td>
		<a href="#" onClick="deleteComments('<%=strCommentsId%>','<%=strRequisitionId%>','<%=strTravelType %>','<%=strWhichPage %>')"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
		</td>
<%
	}else if(Suser_id.trim().equals(strOriginator.trim()) && strOriginator.trim().equals(strOriginatedUserId.trim()) && strReqStatus.equalsIgnoreCase("3"))
	{//System.out.println("---for GROUP RETURNED request-------------G00000----------------");
	%>
		<td>
		<a href="#" onClick="deleteComments('<%=strCommentsId%>','<%=strRequisitionId%>','<%=strTravelType %>','<%=strWhichPage %>')"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
		</td>
<%}
	
	else if(Suser_id.trim().equals(strOriginator.trim()) && strReqStatus.equalsIgnoreCase("2") && strApproveStatus.trim().equals("") ){
		//System.out.println("---for GROUP submit to workflow-------------G1----------------");
	%>
	<td>
	<a href="#" onclick="return false;" disabled><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
		</td>
	<%}
	else if(Suser_id.trim().equals(strOriginator.trim()) && strReqStatus.equalsIgnoreCase("2") && strApproveStatus.equals("0") && strTkProviderFlag.trim().equalsIgnoreCase("n") )
	{
		//System.out.println("---for GROUP submit to workflow-------------G1.05----------------");
	%>
		<td>
	<a href="#" onclick="return false;" disabled><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
		</td>
	<%}
	else if(Suser_id.trim().equals(strOriginator.trim()) && strReqStatus.equalsIgnoreCase("2") && strApproveStatus.equals("0") ){
		//System.out.println("---for GROUP submit to workflow-------------G1.1----------------");
		%>
		<td>
		<a href="#" onClick="deleteComments('<%=strCommentsId%>','<%=strRequisitionId%>','<%=strTravelType %>','<%=strWhichPage %>')"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
		</td>
<%	}
	else if(Suser_id.trim().equals(strOriginator.trim()) && strReqStatus.equalsIgnoreCase("2") && strApproveStatus.equals("10") )
	{//System.out.println("---for GROUP submit to workflow after approve by approver-------------G1.2----------------");
	%>
		<td>
				<a href="#" onclick="return false;" disabled><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>			
				</td>
<%	}
	else if(Suser_id.trim().equals(strOriginatedUserId.trim()) && !strOriginator.trim().equalsIgnoreCase(strOriginatedUserId) && strReqStatus.equalsIgnoreCase("2") && strApproveStatus.equals("0"))
	{//System.out.println("---for submit to workflow after approve by approver-------------G1.3----------------");
		%>
		<td>
		<a href="#" onClick="deleteComments('<%=strCommentsId%>','<%=strRequisitionId%>','<%=strTravelType %>','<%=strWhichPage %>')"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
		</td>
	<%}
	else if(Suser_id.trim().equals(strOriginatedUserId.trim()) && !strOriginator.trim().equalsIgnoreCase(strOriginatedUserId) && strReqStatus.equalsIgnoreCase("2") && strApproveStatus.equals("10"))
	{//System.out.println("---for submit to workflow after approve by approver-------------G1.4----------------");
	%>
		<td>
		<a href="#" onclick="return false;" disabled><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>			
		</td>
	<%}
	else if(strReqStatus.trim().equalsIgnoreCase("4") || strReqStatus.trim().equalsIgnoreCase("10") || strReqStatus.trim().equalsIgnoreCase("6")){
		//System.out.println("-----GROUP for  rejected  / cancelled / approve by all----------------");
		%>
		
	<%}
	else
	 {
		//System.out.println("------------GROUP---5---------------");
		%>
		<td>
		<a href="#" onclick="return false;" disabled><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>			
		</td>
<%			 }
	
	
	
	
	

}
				%>		
				
 		</tr>
<%
		 }while(rs.next());
	 }
	 rs.close();          // close the result set 
	  
%>
</table>


<!--@ 23/Mar/2007 Vijay Display the Cancellation  Comments in report -->



<table width="85%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	<tr width="100%" class="formhead">
	 <td colspan=4 align="left" valign="top"><%=dbLabelBean.getLabel("label.global.cancellationcomment",strsesLanguage) %> </td>
	</tr>
	<tr class="formhead">
		<td class="listhead" width="2%" align="left" valign="top" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
		<td class="listhead" width="24%" align="left" valign="top"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></td>
		<td class="listhead" width="24%" align="left" valign="top"><%=dbLabelBean.getLabel("label.global.postedby",strsesLanguage) %></td>
		<td class="listhead" width="24%"><%=dbLabelBean.getLabel("label.global.postedon",strsesLanguage) %></td>
  </tr>

<% String strTravelId=request.getParameter("purchaseRequisitionId");
	if(strTravelType.equals("I")){
	

	sSqlStr="SELECT TRAVEL_ID,COMMENTS,DBO.USER_NAME(POSTED_BY),DBO.CONVERTDATEDMY1(POSTED_ON), CANCEL_ID,POSTED_BY FROM TRAVEL_REQ_CANCEL WHERE TRAVEL_ID='"+strTravelId+"'  AND TRAVEL_TYPE='I' ORDER BY POSTED_ON DESC";
    rs = dbConBean.executeQuery(sSqlStr);
	
}
else{
	sSqlStr="SELECT TRAVEL_ID,COMMENTS,DBO.USER_NAME(POSTED_BY),DBO.CONVERTDATEDMY1(POSTED_ON), CANCEL_ID,POSTED_BY FROM TRAVEL_REQ_CANCEL WHERE TRAVEL_ID='"+strTravelId+"'  AND TRAVEL_TYPE='D' ORDER BY POSTED_ON DESC";
	 rs = dbConBean.executeQuery(sSqlStr);
}    
intSno=1; 
	 if(rs.next())
	 {
					strCommentId		=	rs.getString(1);
					strComments			=	rs.getString(2);
					strPostedBy			=	rs.getString(3);
					strPostedOn			=	rs.getString(4);
					strCommentsId		=	rs.getString(5);
					strOriginatedUserId	=	rs.getString(6);
%>
<%
         		if (iCls%2 == 0) { 
        				strStyleCls="formtr2";
				} else { 
    				strStyleCls="formtr1";
				} 
				iCls++;
%>
				<tr class="<%=strStyleCls%>">
					<td class="listdata" width="2%" align="left" valign="top"><%=intSno++%></td>
					<td class="listdata" width="24%" align="left" valign="top"><%=strComments%></td>
					<td class="listdata" width="24%" align="left" valign="top"><%=strPostedBy%></td>
					<td class="listdata" width="24%"><%=strPostedOn%></td>
				</tr>
<%
		 
	}	 
	 rs.close();          // close the result set 
	 dbConBean.close();   //close all connection
}%>
</table>


<!-- END MODIFICATION-->



</form>
  
</body>
</html>
