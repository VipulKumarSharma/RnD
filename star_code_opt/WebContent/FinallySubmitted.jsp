<%@page import="org.apache.log4j.Level"%>
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:15 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is finally Sumited past of travel Reqution
 *Modification 			: 1.Not Needed Hence commented
 *Reason of Modification: 1. Optimizing code
                                          2.Added for group travel flag on14-Mar-08 by shiv sharma     

 *Date of Modification  :   1.11-May-2007
 *Modification By		    :   1.Gaurav Aggarwal
 *Editor				        :    Editplus
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>

<%@page import="java.util.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.log4j.Logger"%>
<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%@page import="src.dao.T_QuicktravelRequestDaoImpl" %>
<%-- include page styles  --%>
<%--<%@ include  file="systemStyle.jsp" %>--%>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="mailDaoImpl" scope="page" class="src.dao.MailDaoImpl"/>
<%

DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
Calendar cal = Calendar.getInstance();


  request.setCharacterEncoding("UTF-8");
  String strTravelReqId           =  "";
  String strTravelId			  =  "";
  String strTravelReqNo           =  "";  
  String strTravllerSiteId        =  "";
  String strTravellerId           =  "";
  String strRad	=	"";
  String	ReqTyp	=	"";
  String	strComment	=	"";
  String strReq	=	"";
  String strGroupflag="";
  String submitflag	 ="";	
  
  strTravelReqId                  =  request.getParameter("travelReqId");    
  strTravelId                     =  request.getParameter("travelId");     
  strTravelReqNo                  =  URLDecoder.decode((request.getParameter("travelReqNo")==null ? "":request.getParameter("travelReqNo")), "UTF-8");  
  strTravllerSiteId               =  request.getParameter("travellerSiteId");
  strTravellerId                  =  request.getParameter("travellerId");    
  ReqTyp						  =	 request.getParameter("ReqTyp");
  
  
  //added by shiv on 28 may 2009 for stoping mail send when page referesh ..are pressing back button of bro  
  submitflag = (String)session.getAttribute("strSetFlage"); 
		  
  String isMATA_GmbH = new T_QuicktravelRequestDaoImpl().getSiteTravelAgency(strTravelId,ReqTyp);
    

  ///added for group travel flag on14-Mar-08 by shiv sharma     
  strGroupflag						=	request.getParameter("strGroupflag");
  if(strGroupflag==null)
  {
	  strGroupflag ="no";
  }
  


  strRad	=	"ORIGIN";
  strComment	=	"";
  if(ReqTyp.equalsIgnoreCase("I"))
  {
strReq	=	"International Travel";
  }
  else
  {
strReq	=	"Domestic Travel";
  }
  
  Logger logger=Logger.getLogger(this.getClass().getName()); 		
  logger.setLevel(Level.ALL);
	
  logger.info("Finally Submitted Start " +dateFormat.format(cal.getTime()));	
  logger.info("isMATA_GmbH-->" +isMATA_GmbH);
  logger.info("submitflag-->" +submitflag);	
  logger.info("Finally Submitted Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
		  

%>
<script language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></script>
<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">
<form name="test">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  
        <td  colspan="3" valign="middle" >
		  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding-top:px10;">
            <tr>           </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="36" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="85%" height="36" class="bodyline-top"><img src="images/FinallySubmitted.png?buildstamp=2_0_0" width="311" height="26" /></td>
        <td width="15%" align="center" class="bodyline-top"><img src="images/pass.gif?buildstamp=2_0_0" width="46" height="31" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="200" align="center" ><div align="center" style="padding-top:10px;">
      <table width="50%" border="0" cellpadding="0" cellspacing="0" >
        <tr>
          <td background="images/index_01.png?buildstamp=2_0_0"></td>
          <td height="29" align="left" background="images/headerBG.png?buildstamp=2_0_0">&nbsp;</td>
        </tr>
        <tr>
          <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
          <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="60" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF" class="formfirstfield"><%=dbLabelBean.getLabel("message.createrequest.finallysubmit",strsesLanguage)%> 
				<% 
				String travelRequestDetail_DOM = "T_TravelRequisitionDetails_D.jsp";
				String travelRequestDetail_INT = "T_TravelRequisitionDetails.jsp";
				if(isMATA_GmbH != null && isMATA_GmbH.equals("2")){
					travelRequestDetail_INT = "T_TravelRequisitionDetails_INT_GmbH.jsp";
					travelRequestDetail_DOM = "T_TravelRequisitionDetails_INT_GmbH.jsp";
				}
				
				String travelRequestDetail_Group_INT = "Group_T_TravelRequisitionDetails.jsp";
				String travelRequestDetail_Group_DOM = "Group_T_TravelRequisitionDetails_D.jsp";
				if(isMATA_GmbH != null && isMATA_GmbH.equals("2")){
					travelRequestDetail_Group_INT = "Group_T_TravelRequisitionDetails_GmbH.jsp";
					travelRequestDetail_Group_DOM = "Group_T_TravelRequisitionDetails_GmbH.jsp";
				}
				
				if (strGroupflag.equals("yes") && ReqTyp.equals("I") ) {	%>
				  	<a href="#"  onClick="MM_openBrWindow('<%=travelRequestDetail_Group_INT %>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=I&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=975,height=500')"><%=strTravelReqNo%></a></td>
               <%}	else if (ReqTyp != null && ReqTyp.equals("I") ) {	%>
				<a href="#"  onClick="MM_openBrWindow('<%=travelRequestDetail_INT %>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=I&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=975,height=500')"><%=strTravelReqNo%></a></td>
			<% } else if 	(strGroupflag.equals("yes") && ReqTyp.equals("D") ) { %>
				<a href="#"  onClick="MM_openBrWindow('<%= travelRequestDetail_Group_DOM%>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D&travelType=D','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550')"><%=strTravelReqNo%></a></td>
				<% } else if 	(ReqTyp != null && ReqTyp.equals("D") ) { %>
				<a href="#"  onClick="MM_openBrWindow('<%=travelRequestDetail_DOM %>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D&travelType=D','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550')"><%=strTravelReqNo%></a></td>
		<% } %>
			  </tr>
              <!--@Gaurav 11-May-2007 Not Needed Hence commented<tr>
                <td height="20" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="formfirstfield"><a href="T_TravelRequisitionList.jsp?travel_type=INT" class="menu">Home</a></span></td>
              </tr>-->
              <tr>
                <td width="56%" align="left" bgcolor="#FFFFFF" class="newformbot">&nbsp;</td>
                <td width="44%" align="right" bgcolor="#FFFFFF" class="newformbot">&nbsp;</td>
              </tr>
          </table></td>
          <td width="15" background="images/index_03.png?buildstamp=2_0_0"></td>
        </tr>
        <tr>
          <td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
          <td height="20" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
          <td width="15" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
        </tr>
      </table>
    </div></td>
  </tr>
  
</table>
<%
String strSql = "";
//logger.info("submitflag if block start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
  if(submitflag!=null && submitflag.equals("1") ){
	  //logger.info("submitflag inner if block start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
			  
	  //mailDaoImpl.sendRequisitionMailOnOriginating(strTravelId, strReq, Suser_id, strsesLanguage, strCurrentYear);	  
	%>
<%--  		<jsp:include page="T_requisitionMailOnOriginating.jsp" flush="true" > --%>
<%-- 			<jsp:param name="purchaseRequisitionId" value="<%=strTravelId%>"/> --%>
<%-- 			<jsp:param name="ReqTyp" value="<%=strReq%>"/> --%>
<%-- 			<jsp:param name="rad" value="<%=strRad%>"/> --%>
<%-- 			<jsp:param name="COMMENTS" value="<%=strComment%>"/> --%>
<%-- 			<jsp:param name="purchaseId" value="<%=strTravelId%>"/> --%>
			 
<%-- 		</jsp:include>  --%>
    <%
    
    session.removeAttribute("strSetFlage");
    //logger.info("submitflag inner if block end for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
  }
  //logger.info("submitflag if block End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
%>

<%
// 9 March 2007 sachin
//------------- Start Added by Sachin Gupta on 4/24/2007 for one UnitHead for multiple site---------------
//String strSql = "SELECT ISNULL(ROLE_ID,'OR') AS ROLE_ID, ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD FROM M_USERINFO WHERE USERID="+strTravellerId;
 strSql = "SELECT ISNULL(ROLE_ID,'OR') AS ROLE_ID FROM M_USERINFO WHERE USERID="+strTravellerId;
ResultSet rs = null;
String strRoleId = "";
String strIsTravellerUnitHead = "";
rs = dbConBean.executeQuery(strSql);
if(rs.next())
{
  strRoleId = rs.getString("ROLE_ID");
  //strIsTravellerUnitHead = rs.getString("UNIT_HEAD");
}
rs.close();
//System.out.println("strTravllerSiteId==07-Mar-08=="+strTravllerSiteId);
if(strTravllerSiteId != null)
{
   strSql = "SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD   FROM USER_MULTIPLE_ACCESS where userid="+strTravellerId+" and site_id="+strTravllerSiteId+" and status_id=10 and unit_head=1";
   //System.out.println("strSql==unithead=="+strSql);
   	rs = dbConBean.executeQuery(strSql);
	if(rs.next())
	{
		strIsTravellerUnitHead			=	rs.getString(1).trim();			
	}
	rs.close();
}
//System.out.println("strIsTravellerUnitHead=====07-Mar-08=="+strIsTravellerUnitHead);
//------------- End Added by Sachin Gupta on 4/24/2007 for one UnitHead for multiple site---------------


if(strRoleId.trim().equalsIgnoreCase("CHAIRMAN"))
{

	//System.out.println("strTravllerSiteId"+strTravllerSiteId);
%>

	<jsp:include page="T_MailToHRandAC.jsp" flush="true" >
		<jsp:param name="purchaseRequisitionId" value="<%=strTravelId%>"/>
		<jsp:param name="ReqTyp" value="<%=strReq%>"/>
		<jsp:param name="COMMENTS" value="<%=strComment%>"/>
		<jsp:param name="RoleId" value="HR&AC"/>
		<jsp:param name="mailSubject" value="label.mail.intimationmailofchairman"/>
		<jsp:param name="mailMessage" value=""/>
		<jsp:param name="strTravellerSiteId" value="<%=strTravllerSiteId%>"/>
	</jsp:include>

<%
}
else if(strIsTravellerUnitHead.trim().equals("1"))
{
	//System.out.println("HR Block");
		//System.out.println("strTravllerSiteId"+strTravllerSiteId);
%>
<jsp:include page="T_MailToHRandAC.jsp" flush="true" >
		<jsp:param name="purchaseRequisitionId" value="<%=strTravelId%>"/>
		<jsp:param name="ReqTyp" value="<%=strReq%>"/>
		<jsp:param name="COMMENTS" value="<%=strComment%>"/>
		<jsp:param name="RoleId" value="HR&AC"/>
		<jsp:param name="mailSubject" value="label.mail.intimationmailofunithead"/>
		<jsp:param name="mailMessage" value=""/>
	<jsp:param name="strTravellerSiteId" value="<%=strTravllerSiteId%>"/>
</jsp:include>
<%
}
logger.info("Finally Submitted End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
logger.info("---------------**********---------------**********---------------**********---------------");
%>

</form>


