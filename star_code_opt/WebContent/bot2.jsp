  <%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:
 *Date of Creation 		:
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:
 *Modification 			:Added stars presentaion on login page on 24 nov 2009 
 *Reason of Modification:6:Change the page redirection to approval page if is there any pendin requsition to approver on 10-12-2009 by shiv sharma   
 *Date of Modification  : Vijay Singh 
 *Modified By	        :12/04/2007
 *Editor				:Editplus
 Modification:			:Modified by vaibhav on jul 5 2010 to change the mail address of help desk
 Modification:			:Modified by varun kumar on feb 8 2011 exchange rate alert to admin.
 
 *Modification Date		:30-march-2011
 *Modification			:pending email alert to admin.
 *Modified By			:Manoj Chand
 
 *Modification Date		:04-August-2011
 *Modification			:fetch path of STAR.properties file from web.xml 
 *Modified By			:Manoj Chand
 
 *Modification Date		:06 June 2012
 *Modification			:implement multilingual functionality in footer page 
 *Modified By			:Manoj Chand
 
 *Modification Date		:28 Sept 2012
 *Modification			:Correct the message coming on mouseover on STARS Presentation link. 
 *Modified By			:Manoj Chand
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
<!-- next line added by vaibhav on jul 5 2010 -->
<%@ page  language="java"  import="java.io.*,java.util.*,src.connection.PropertiesLoader" %>

<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<script type="text/javascript" language="JavaScript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"/>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript1.2" src="ScriptLibrary/main.js?buildstamp=2_0_0"type="text/javascript"></SCRIPT>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>


<script type="text/javascript">

$(document).ready(function(){
	
	$('span#lastVisit').hover(function () {
    	   var elm = $(this);
   		   var offset = elm.offset();	
   		   var bottom = $(window).height() - elm.height();
   		   bottom = offset.top - bottom;
    	   $('div.lastlogintooltip').css({"top" : parseInt(4), "left" : parseInt(190), "display" : "block"});
       }, 
       function () {
    	   $('div.lastlogintooltip').css("display","none");
    });
	
	$('span#version').hover(function () {
    	   var elm = $(this);
   		   var offset = elm.offset();	
   		   var bottom = $(window).height() - elm.height();
   		   bottom = offset.top - bottom;
       	   var right = $(window).width() - elm.width();
       	   right = offset.left - right;
       	   var left = 370;
       	   if($('span#lastVisit').length == 0){
       			left = 130;
       	   }
    	   $('div.versiontooltip').css({"top" : parseInt(4), "left" : left, "display" : "block"});
       }, 
       function () {
    	   $('div.versiontooltip').css("display","none");
    });
	
	$('#smgSlogan').hover(function () {
    	   var elm = $(this);
   		   var offset = elm.offset();	
   		   var bottom = $(window).height() - elm.height();
   		   bottom = offset.top - bottom;
       	   var right = $(window).width() - elm.width();
       	   right = offset.left - right;
    	   $('div.proudtobetooltip').css({"top" : parseInt(4),"left" : parseInt(offset.left+230), "display" : "block"});
       }, 
       function () {
    	   $('div.proudtobetooltip').css("display","none");
    });
	
	$('#browsers').hover(function () {
    	   var elm = $(this);
   		   var offset = elm.offset();	
   		   var bottom = $(window).height() - elm.height();
   		   bottom = offset.top - bottom;
       	   var right = $(window).width() - elm.width();
       	   right = offset.left - right;
    	   $('div.browserstooltip').css({"top" : parseInt(4), "right" : parseInt(bottom+210), "display" : "block"});
       }, 
       function () {
    	   $('div.browserstooltip').css("display","none");
  	});
	
	$('#mindUrl').hover(function () {
    	   var elm = $(this);
   		   var offset = elm.offset();	
   		   var bottom = $(window).height() - elm.height();
   		   bottom = offset.top - bottom;
       	   var right = $(window).width() - elm.width();
       	   right = offset.left - right;
    	   $('div.mindtooltip').css({"top" : parseInt(4), "right" : parseInt(bottom+30), "display" : "block"});
       }, 
       function () {
    	   $('div.mindtooltip').css("display","none");
    });
});

function closeall() 
  {
  
        window.location.href="sessionExpired.jsp?userid="+document.frm.userid.value;      
      //  window.location.href="sessionExpired.jsp?userid=";      
 }


function updateLanguage(welcomeMsg,tostars,logindateandtime,starspresentation,mytask,home,helpdesk,logout){

	//alert("HAHAHA "+welcomeMsg);
	document.getElementById('footerWelcome').innerHTML = welcomeMsg;
	document.getElementById('footerToStars').innerHTML = tostars;
	document.getElementById('logindateandtime').innerHTML = logindateandtime;
	document.getElementById('starspresentation').innerHTML = starspresentation;
	document.getElementById('mytask').title = mytask;
	document.getElementById('home').title = home;
	document.getElementById('helpdesk').title = helpdesk;
	document.getElementById('logout').title = logout;
}

</script>    <!--   --> 
</head>
<%try{
	Connection con	=		null;			    // Object for connection
	Statement stmt	=		null;			   // Object for Statement
	ResultSet rs	=		null;			  // Object for ResultSet
	String	strSqlStr	=	""; // For sql Statements
	String strCheckAlert		="";
	String strApproverRole 		= "";
	String strSql				= "";	
	String strAllReqFlag 		= "no";
	String strOutOFOfficestatus	="";
	String s1="";
	String s2="";
	String strShowAlertFlag		=""; 

	String strIPAddress = "127.1.1.1";   
	strIPAddress = request.getRemoteAddr();   
	strIPAddress = " ["+strIPAddress+"]";
	//varriable added by vaibhav
	String help_desk_mail = "";
	String returnedInt = "0";
	String returnedDom = "0";
	String rejectedInt = "0";
	String rejectedDom = "0";	
	
	String strReleaseVersion="";
	
	String strLangValue		= request.getParameter("language")==null?strsesLanguage:request.getParameter("language");
	
	String domain 		= hs.getValue("domain") == null ? "" : (String)hs.getValue("domain");
	String userFirstName= hs.getValue("sUserFirstName") == null ? "" : (String)hs.getValue("sUserFirstName");
	String userLastName	= hs.getValue("sUserLastName") == null ? "" : (String) " "+hs.getValue("sUserLastName");
	String userName		= userLastName + ", " + userFirstName;
	
	String lastLoginTime 	= hs.getValue("lastLoginTime") == null ? "" : (String) hs.getValue("lastLoginTime");
	String lastLoginDuration= hs.getValue("lastLoginDuration") == null ? "" : (String) hs.getValue("lastLoginDuration");
	
	String lastLoginDurationTooltip = "";
	String lastLoginDurationLabel 	= null;
	
	if(!"".equalsIgnoreCase(lastLoginTime)) {
		lastLoginDurationTooltip 	= "Welcome "+ userName +" ("+domain.toUpperCase()+"), You have last visited on : " + lastLoginTime;
		lastLoginDurationLabel		= "Last visited : " + lastLoginDuration;
	}
	
	hs.putValue("sesLanguage",strLangValue);
	strSql="select dbo.user_name(dbo.FinalOOO("+Suser_id+",getdate(),'I'))";
	
	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) 
		{
			if (!rs.getString(1).equals("-")){
				 s1="1";
			}else {
				 s1="0";
			} 
		}
	 rs.close();
	
	strSql="select dbo.user_name(dbo.FinalOOO("+Suser_id+",getdate(),'D'))";
	rs = dbConBean.executeQuery(strSql);
			if (rs.next()) 
			{ 
				if (!rs.getString(1).equals("-")){
						 s2="1";
					} 
				else {
					s2="0";
				}
			}
			rs.close();
	
			if(s1=="1" || s2=="1")
			{
			strOutOFOfficestatus=dbLabelBean.getLabel("message.footer.currentlyoutofoffice",strLangValue);
			strShowAlertFlag="yes";
			}
			
	
	////////
	strSql="SELECT TOP 1 VER_REL_LOG_ID,ISNULL(RELEASE_VERSION,'') AS  RELEASE_VERSION FROM VERSION_RELEASE_LOG ORDER BY VER_REL_LOG_ID DESC";
	rs = dbConBean.executeQuery(strSql);  
	while(rs.next())
	{
		strReleaseVersion=rs.getString("RELEASE_VERSION"); 

	}
	rs.close();
			
	/////////
	strSql="SELECT COUNT(*) AS RETURNEDINT FROM T_TRAVEL_DETAIL_INT T, T_JOURNEY_DETAILS_INT J, T_TRAVEL_STATUS S WHERE T.TRAVEL_ID = J.TRAVEL_ID AND  T.TRAVEL_ID = S.TRAVEL_ID AND T.C_USERID = "+Suser_id+" AND S.TRAVEL_STATUS_ID = 3 AND S.TRAVEL_TYPE = 'I' AND J.JOURNEY_ORDER = 1 AND T.STATUS_ID = 10";
	
	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) {
		returnedInt = rs.getString("RETURNEDINT");
	}	
	rs.close();
	
	/////////
	strSql="SELECT COUNT(*) AS REJECTEDINT FROM T_TRAVEL_DETAIL_INT T, T_JOURNEY_DETAILS_INT J, T_TRAVEL_STATUS S WHERE T.TRAVEL_ID = J.TRAVEL_ID AND T.TRAVEL_ID = S.TRAVEL_ID AND T.C_USERID = "+Suser_id+" AND S.TRAVEL_STATUS_ID = 4 AND S.TRAVEL_TYPE = 'I' AND J.JOURNEY_ORDER = 1 AND T.STATUS_ID=10";
	
	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) {
		rejectedInt = rs.getString("REJECTEDINT");
	}	
	rs.close();
	
	//////////
	strSql="SELECT COUNT(*) AS RETURNEDDOM FROM T_TRAVEL_DETAIL_DOM T, T_JOURNEY_DETAILS_DOM J, T_TRAVEL_STATUS S WHERE T.TRAVEL_ID = J.TRAVEL_ID AND  T.TRAVEL_ID = S.TRAVEL_ID AND T.C_USERID = "+Suser_id+" AND S.TRAVEL_STATUS_ID = 3 AND S.TRAVEL_TYPE = 'D' AND J.JOURNEY_ORDER = 1 AND T.STATUS_ID = 10";
	
	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) {
		returnedDom = rs.getString("RETURNEDDOM");
	}	
	rs.close();
	
	//////////
	/////////
	strSql="SELECT COUNT(*) AS REJECTEDDOM FROM T_TRAVEL_DETAIL_DOM T, T_JOURNEY_DETAILS_DOM J, T_TRAVEL_STATUS S WHERE T.TRAVEL_ID = J.TRAVEL_ID AND T.TRAVEL_ID = S.TRAVEL_ID AND T.C_USERID = "+Suser_id+" AND S.TRAVEL_STATUS_ID = 4 AND S.TRAVEL_TYPE = 'D' AND J.JOURNEY_ORDER = 1 AND T.STATUS_ID = 10";
	
	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) {
		rejectedDom = rs.getString("REJECTEDDOM");
	}	
	rs.close();
	%>
	
	<%
	//if(strShowAlertFlag.equals("yes")){ 
	%>
<!-- 	 <body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0"  onunload="closeall();"  marginheight="0"   onLoad="MM_openBrWindow('mainAlert.jsp','SEARCH','scrollbars=yes,resizable=yes,width=410,height=200')">   -->
	<%
	//}else{
	%>
	 <body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0"  onunload="closeall();"  marginheight="0"   >  
	<%
	//}
	%>		
 <!-- <body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"> -->   
<!-- <body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"> -->

<div class="lastlogintooltip" style="display: none;">
	<%=lastLoginDurationTooltip%>
</div>
<div class="versiontooltip" style="display: none;">
	<%=dbLabelBean.getLabel("label.global.applicationversion",strLangValue) %>: <%=strReleaseVersion %>
</div>
<div class="proudtobetooltip" style="display: none;">
	<%=dbLabelBean.getLabel("label.global.smgslogan",strLangValue) %>
</div>
<div class="browserstooltip" style="display: none;">
	<%=dbLabelBean.getLabel("label.global.bestviewon",strLangValue) %>
</div>
<div class="mindtooltip" style="display: none;">
	<%=dbLabelBean.getLabel("label.global.visitmindurl",strLangValue) %>
</div>

<DIV id="TipLayer" width="700" height="200" style="visibility:hidden;position:absolute;z-index:1000;top:-100"></DIV> 
<SCRIPT language="JavaScript1.2" src="ScriptLibrary/style.js?buildstamp=2_0_0" type="text/javascript"></SCRIPT>

<div class="loginPageFooter" style="height: 30px;">
   	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-size: 11px;"> 
      	<tr> 
          	<td width="30%" align="left" nowrap="nowrap" class="loginPageFooterText">
          	
          	<% if(lastLoginDurationLabel != null) {%>
          		<span id="lastVisit">
          			<%=lastLoginDurationLabel%>
          		</span> |
          	<% } %>	
          		<span id="version">
          			&nbsp;<%=dbLabelBean.getLabel("label.global.applicationversion",strLangValue) %>: <%=strReleaseVersion %>
          		</span>
          	</td>
          	
          	<td width="30%" align="center" nowrap="nowrap">
          		<img id="smgSlogan" src="images/smg-tagline.png?buildstamp=2_0_0">
          	</td>
          	
          	<td width="30%" align="right" nowrap="nowrap" class="loginPageFooterText">
          		<span id="browsers">
          			Best view on
					<img id="mindLink" src="images/ie11.png?buildstamp=2_0_0" style="vertical-align: middle;"> 8+ 
				</span>
				| © 2017 
				<a id="mindUrl" href="http://www.mind-infotech.com/" target="_blank" class="loginPageFooterText" style="text-decoration: none;">MIND</a>
          	</td>
      	</tr>
  	</table>
</div>

<%-- <table width="100%" border="0" cellspacing="0" cellpadding="0" > 
  <tr>
  	<td height="2"><img src="images/spacerline.gif?buildstamp=2_0_0" width="100%" height="1" /></td>  
  </tr>
  <tr>
    <td>
      <form name=frm >
      <table width="100%" border="0" cellspacing="1" cellpadding="1" style="background-color: #45423e;"> 
        <tr> 
            <td width="450px" class="footerTxt1" style="padding-left:3px" >
            	<span id="footerWelcome"> <%=dbLabelBean.getLabel("label.footer.welcome",strLangValue)%></span><span>&nbsp;<%=sUserFirstName.trim()%>&nbsp;<%=sUserLastName.trim()%></span>
            	<span id="footerToStars"><%=dbLabelBean.getLabel("label.footer.tostars",strLangValue)%></span><br> 
                <span id="logindateandtime"><%=dbLabelBean.getLabel("label.footer.loggedtime",strLangValue)%></span><%=strLoginDateTime%>
             </td>
              <td width="450px">
              <%if(!returnedInt.equals("0") || !rejectedInt.equals("0") || !returnedDom.equals("0") || !rejectedDom.equals("0")){%>
              	<table border="0" cellspacing="0" cellpadding="1">
              		<%if((!returnedInt.equals("0") || !rejectedInt.equals("0")) && returnedDom.equals("0") && rejectedDom.equals("0")){%>
              		<tr>
              			<td class="footerTxt3"><%=dbLabelBean.getLabel("label.global.youhave",strLangValue)%></td>
              			<td class="footerTxt3">
              				<%if(!returnedInt.equals("0")) {%>
              				<a href="T_TravelRequisitionList.jsp?requestType=ret-header" target=middle>(<%=returnedInt %>)</a>&nbsp;<%=dbLabelBean.getLabel("label.global.returned",strLangValue)%>
              				<%}
              				if(!rejectedInt.equals("0")) {
              				if(!returnedInt.equals("0")) {%>,<%} %>
              				<a href="T_TravelRequisitionList.jsp?requestType=rej-header" target=middle>(<%=rejectedInt %>)</a>&nbsp;<%=dbLabelBean.getLabel("label.global.rejected",strLangValue)%>
              				<%}
              				if(!returnedInt.equals("0") || !rejectedInt.equals("0")) {%> 
              				<%=dbLabelBean.getLabel("label.report.international",strLangValue)%> <%=dbLabelBean.getLabel("label.global.requests",strLangValue)%>
              				<%} %>
              			</td>
              		</tr>
              		<%} else if((!returnedDom.equals("0") || !rejectedDom.equals("0")) && returnedInt.equals("0") && rejectedInt.equals("0")) {%>
              		<tr>
              			<td class="footerTxt3"><%=dbLabelBean.getLabel("label.global.youhave",strLangValue)%></td>
              			<td class="footerTxt3">
              				<%if(!returnedDom.equals("0")) {%>
              				<a href="T_TravelRequisitionList_D.jsp?requestType=ret-header" target=middle>(<%=returnedDom %>)</a>&nbsp;<%=dbLabelBean.getLabel("label.global.returned",strLangValue)%>
              				<%}
              				if(!rejectedDom.equals("0")) {
              				if(!returnedDom.equals("0")) {%>,<%} %>
              				<a href="T_TravelRequisitionList_D.jsp?requestType=rej-header" target=middle>(<%=rejectedDom %>)</a>&nbsp;<%=dbLabelBean.getLabel("label.global.rejected",strLangValue)%>
              				<%} 
              				if(!returnedDom.equals("0") || !rejectedDom.equals("0")) {%>              				
              				<%=dbLabelBean.getLabel("label.report.domestic",strLangValue)%> <%=dbLabelBean.getLabel("label.global.requests",strLangValue)%>
              				<%} %>
              			</td>
              		</tr>
              		<%} else {%>
              		<tr>
              			<td rowspan="2" class="footerTxt3"><%=dbLabelBean.getLabel("label.global.youhave",strLangValue)%>&nbsp;|</td>
              			<td class="footerTxt3">
              				<%if(!returnedInt.equals("0")) {%>
              				<a href="T_TravelRequisitionList.jsp?requestType=ret-header" target=middle>(<%=returnedInt %>)</a>&nbsp;<%=dbLabelBean.getLabel("label.global.returned",strLangValue)%>
              				<%} 
              				if(!rejectedInt.equals("0")) {
              				if(!returnedInt.equals("0")) {%>,<%} %>
              				<a href="T_TravelRequisitionList.jsp?requestType=rej-header" target=middle>(<%=rejectedInt %>)</a>&nbsp;<%=dbLabelBean.getLabel("label.global.rejected",strLangValue)%>
              				<%} 
              				if(!returnedInt.equals("0") || !rejectedInt.equals("0")) {%> 
              				<%=dbLabelBean.getLabel("label.report.international",strLangValue)%> <%=dbLabelBean.getLabel("label.global.requests",strLangValue)%>
              				<%} %>
              			</td>
              		</tr>
              		<tr>
              			<td class="footerTxt3">
              				<%if(!returnedDom.equals("0")) {%>
              				<a href="T_TravelRequisitionList_D.jsp?requestType=ret-header" target=middle>(<%=returnedDom %>)</a>&nbsp;<%=dbLabelBean.getLabel("label.global.returned",strLangValue)%>
              				<%} %>
              				<%if(!rejectedDom.equals("0")) {%>
              				<%if(!returnedDom.equals("0")) {%>,<%} %>
              				<a href="T_TravelRequisitionList_D.jsp?requestType=rej-header" target=middle>(<%=rejectedDom %>)</a>&nbsp;<%=dbLabelBean.getLabel("label.global.rejected",strLangValue)%>
              				<%} 
              				if(!returnedDom.equals("0") || !rejectedDom.equals("0")) {%>              				
              				<%=dbLabelBean.getLabel("label.report.domestic",strLangValue)%> <%=dbLabelBean.getLabel("label.global.requests",strLangValue)%>
              				<%} %>
              			</td>
              		</tr>
              		<%} %>
              	</table>  
              	<%} %>            	
              </td>
              <td width="145px" align="center" valign="middle" class="footerTxt3">
              	<%=dbLabelBean.getLabel("label.global.version",strLangValue) %>: <%=strReleaseVersion %>
              </td>
              <td width="80px" align="center" valign="top">
              	<img src="images/SMG-footerlogo.png?buildstamp=2_0_0" class="smgLogo"/>
              </td> 
        
         <%
								if(SuserRole.trim().equals("AD")) {
								  strSqlStr="SELECT * FROM M_CURRENCY LEFT OUTER JOIN EXCHANGE_RATE ON M_CURRENCY.CUR_ID = EXCHANGE_RATE.CUR_ID WHERE RATE_MONTH = MONTH(DATEADD(MM,1,GETDATE())) AND RATE_YEAR = YEAR(DATEADD(MM,1,GETDATE())) AND CONVERSION_RATE<=0 AND M_CURRENCY.STATUS_ID =10";
								  ResultSet objRs3 = null;
								  objRs3 = dbConBean.executeQuery(strSqlStr); 
								  if(objRs3.next()) {
								%>
								 <script language="javaScript">									
									 window.open('ExchangeRateAlert.jsp','ExchangeRateAlert','scrollbars=yes, resizable=no,top=0,left=0,width=550,height=164');								
								</script>
								<%}
									objRs3.close();
								}
							
								if(SuserRole.trim().equals("AD")) {
									String Emailcount="";
									strSqlStr="select count(1) as mail_Count from req_mailbox (nolock) where error_success='new' and DATEDIFF(mi, mail_created_date , getdate()) > 15 ";
									ResultSet objRs4 = null;
									objRs4=dbConBean.executeQuery(strSqlStr);
									if(objRs4.next()) {
										Emailcount= objRs4.getString("mail_Count");
										if(!Emailcount.equalsIgnoreCase("0")) {
										%>
										<script language="javaScript">
											window.open('EmailAlert.jsp','EmailAlert','scrollbars=yes, resizable=no,top=0,left=0,width=550,height=164');
									   </script>
									   <input type="hidden" name="countEmail" value="<%=Emailcount %>" />
									   
									   <%
									   }
									}
									objRs4.close();
								}
							%>
			 <input type=hidden name="userid" value="<%=Suser_id%>" />   
			     
        </tr> 
      </table>
      
      </form>
    </td>
  </tr>
</table> --%>
</body>
 <%
}catch(Exception e){
		e.printStackTrace();
	} %>

</HTML>

