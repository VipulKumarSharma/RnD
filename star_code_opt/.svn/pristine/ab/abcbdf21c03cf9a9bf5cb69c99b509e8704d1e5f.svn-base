	
	<% 
	
	   
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Himanshu Jain
	 *Date of Creation 		:07 SEPTEMBER 2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is jsp file  displays the search results for the Travel Requisition in the STAR Database
	 *Modification 			:1. new code added for dsiplay date of travel Journey  
	                         2. Qurey changed by shiv for showing requisition of both sites where site or billing site is equal logged in user's site.
							  	on 24-Oct-07   
							 3.  Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on  21-Feb-08 ;  
							 4: Added by shiv for showing Group Travel_DOM in case of group travel inspite of traveller Name on 02-Jul-08
							 5: code added for search Criteria on 01-Oct-2008 by Shiv Sharma  
							 6:Query Changed for changing search  Criteria on 14-Oct-2008 by Shiv Sharma
							 7.Query Cahnged for changing serach Criteria(approver can see the request which was approved by some on else  on behalf of him ) on 19-march-2009 by Shiv Sharma  
							 8:. improved code added for search Criteria on 31-Aug-09 by Shiv Sharma 
	
	 *Reason of Modification: 1.bug
	 *Date of Modification  : 1.17-May-07
	 *Revision History	    : 1. Shiv Sharma
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:13 feb 2011
	 *Modification			:Search Record display in this page.
	
	 *Editor				:Editplus
	 
	 *Modified by			:Manoj Chand
	 *Date of Modification	:01 Feb 2013
	 *Modification			:showing requested value in comma separated way if multiple currency exist in the request.
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :12 Feb 2013
	 *Description			:IE Compatibility Issue resolved.
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :01 Oct 2013
	 *Description			:Cancel request link added and call appropriate web service
	 *******************************************************/
	%>
	<%@ include file="importStatement.jsp"%>
	<html>
	<head>
	<%@ page pageEncoding="UTF-8" %>
	<%-- include remove cache  --%>
	<%@ include file="cacheInc.inc"%>
	<%-- include header  --%>
	<%@ include file="headerIncl.inc"%>
	
	<%-- include page with all application session variables --%>
	<%@ include file="application.jsp"%>
	<%-- include page styles  --%>
	<%-- <%@ include  file="systemStyle.jsp" %> --%>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page"
		class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" 
		class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<script language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
	<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	
	<%
	Connection objCon					=		null;	
	CallableStatement objCstmt			=		null;			// Object for Callable Statement
	request.setCharacterEncoding("UTF-8");
	objCon = dbConBean1.getConnection(); 	
	String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");
// 	String strTravelType = (String)session.getAttribute("strTravelType"); // variable to reconize wheather domestic or international
// 	if(strTravelType.equals("I"))
// 	{
// 	strTravelType="INT";
// 	}
// 	if(strTravelType.equals("D"))
// 	{
// 	strTravelType="DOM";
// 	}
	
	// Variables declared and initialized
	Connection con,con_1	=		null;			    // Object for connection
	ResultSet rs,rs_1,rs1		=		null;			  // Object for ResultSet
	String strApproverRole=""; // for approver if chairman
	String	sSqlStr=""; // For sql Statements
	
	%>
	<script>
	function closeDivRequest()
	{
		document.getElementById("waitingData").style.display="none";
	}

	function openWaitingProcess()
	{
			var dv = document.getElementById("waitingData");
			if(dv != null)
			{
				var xpos = screen.availHeight/2+90;
				var ypos = screen.availWidth/2-450;   
				dv.style.position="absolute";       		
				dv.style.left=(xpos+10)+"px";
				dv.style.top=(ypos)+"px";
				document.getElementById("waitingData").style.display="";
			}
	}
	</script>
	</head>
	<body>
	<script type="text/javascript" language="JavaScript1.2"
		src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
		<div id="waitingData" style="display: none;z-index: 1;"> 	  
		 	<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
		 	<br>      
		 	<center><font color="#000080" class="pageHead">
		 	<%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage)%> </font></center>    
		</div>
		<script>
		openWaitingProcess();
		</script>
	<%
	  int iCls = 0;
	  String strStyleCls = "";
	  String strGroupTravelFlag="";
	  String strTravelAgencyTypeId="";
	  String strRadValue	="";
	  strRadValue=request.getParameter("rad");//==null?"TRAVEL_REQ_NO":"dbo.USER_NAME(TD.C_UserId)";
	
	
	  String strRequstionNo       =  request.getParameter("reqno"); 
	  String  strOrigenation      =  request.getParameter("originatedby"); 
	  String strDeptdate          =  request.getParameter("deptdate"); 
	  String strDestination       =  request.getParameter("destination"); 
	  
	  
	  String strUnitNo            =  request.getParameter("SelectUnit"); 
	  String strTravler           =  request.getParameter("username"); 
	  String strCreateFromdate    =  request.getParameter("fromdate");
	  String strCreateTodate      =  request.getParameter("todate");
	  String strStatus1           =  request.getParameter("status");
	  String strPendingApprover   =  request.getParameter("papprover");
	  String strApproveFromdate   =  request.getParameter("fromdate1");
	  String strApproveTodate     =  request.getParameter("todate1");
	  String strTravelType 		  =  request.getParameter("travelType"); // variable to reconize wheather domestic or international
	  // Added on 15 April, 2015 by Sandeep Malik
	  String searchType			  =	 request.getParameter("searchType"); // variable identify the search type either Quick or Advance
	  String keyWordSearchVal	  =	 request.getParameter("keyWordParamVal"); // variable hold the value of keyword field for search
	  
	  String requestAppFlag	  =	 request.getParameter("requestAppFlag");
		
	  //System.out.println("search type : "+searchType);
	  
	  if(searchType != null && searchType.equalsIgnoreCase("quick")){
		  strCreateFromdate    =  request.getParameter("Qfromdate");
		  strCreateTodate      =  request.getParameter("Qtodate");
		  strUnitNo            =  request.getParameter("QSelectUnit"); 
	  }
	  
// 	  if(strTravelType != null && !strTravelType.equals("")) {
// 		  if(strTravelType.equals("I")) {
// 			strTravelType="INT";
// 		  } else if(strTravelType.equals("D")) {
// 				strTravelType="DOM";
// 		  } 
// 	  }
	 
		
	
/*	 System.out.println("strRequstionNo=======123=========="+strRequstionNo); 
	 System.out.println("strDeptdate==========123======="+strDeptdate);
	 System.out.println("strOrigenation================="+strOrigenation);
	 System.out.println("strDestination================="+strDestination);
	  
	 System.out.println("strUnitNo=======123=========="+strUnitNo); 
	 System.out.println("strTravler==========123======="+strTravler);
	 System.out.println("strCreateFromdate================="+strCreateFromdate);
	 System.out.println("strCreateTodate================="+strCreateTodate);
	 System.out.println("strStatus1=======123=========="+strStatus1); 
	 System.out.println("strPendingApprover==========123======="+strPendingApprover);
	 System.out.println("strFromdate================="+strApproveFromdate);
	 System.out.println("strTodate================="+strApproveTodate);
	*/
	  
	int countflag = 0; 
	 //Code added by shiv sharma on 01-oct-2008  
	  if (strRadValue==null)
	  	{
		  strRadValue="TRAVEL_REQ_NO"; 
	  }
	  if (strRadValue.equals("1")){
		  strRadValue="TRAVEL_REQ_NO"; 
	  }
	  else  {
	  strRadValue="dbo.USER_NAME(TD.C_UserId)"; 
	  }
	  
	 if(request.getParameter("rad")!=null)
	  {
		  String strStatus				=	request.getParameter("status"); //CSS
		  String strAppendQuery			=	"";
		  String strRadio				=	strRadValue; //request.getParameter("rad");
		  String strSearchCriteria		=	request.getParameter("criteria");//==null?"":request.getParameter("criteria");
		  String strAppendQueryDOM="";
		  String strAppendQueryINT="";
	
		  String strQycondition="";
		  
		// Qurey changed by shiv for showing requisition of both sites where site or billing site is equal logged in user's site.  on 24-Oct-07    
	  //out.println("======strTravelType======="+strTravelType);  
		
 if(strTravelType.equals("INT")){
	   	  strQycondition=" where ( " +
							 " TRAVEL_REQ_NO like case when TRAVEL_REQ_NO <>'' then '%"+strRequstionNo+"%' else '%%' end  "+
							 "   and dbo.USER_NAME(TD.C_UserId) like case when  dbo.USER_NAME(TD.C_UserId) <>'' then '%"+strOrigenation+"%' else '%%' end "+
							 "   and  (dbo.TRAVEL_TO(TD.TRAVEL_ID,'I')) like case when (dbo.TRAVEL_TO(TD.TRAVEL_ID,'I'))  <>'' then '%"+strDestination+"%'  else '%%' end  "+
							 "   and   dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE)    like case when  dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE)  <>'' then '%"+strDeptdate+"%' else '%%' end  "+
							  "	) and  ";  
	   	strAppendQueryINT=  strQycondition + " (td.SITE_ID ="+ strSiteIdSS +"  OR  TD.BILLING_SITE ='"+strSiteIdSS+"') AND  TD.APPLICATION_ID = 1 AND TD.STATUS_ID = 10  AND TS.TRAVEL_TYPE = 'I' AND TS.TRAVEL_STATUS_ID != 1";
	       }else{
	    	   strQycondition=" where ( " +
				 " TRAVEL_REQ_NO like case when TRAVEL_REQ_NO <>'' then '%"+strRequstionNo+"%' else '%%' end  "+
				 "   and dbo.USER_NAME(TD.C_UserId) like case when  dbo.USER_NAME(TD.C_UserId) <>'' then '%"+strOrigenation+"%' else '%%' end "+
				 "   and  (dbo.TRAVEL_TO(TD.TRAVEL_ID,'D')) like case when (dbo.TRAVEL_TO(TD.TRAVEL_ID,'D'))  <>'' then '%"+strDestination+"%'  else '%%' end  "+
				 "   and  dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE)    like case when  dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE)  <>'' then '%"+strDeptdate+"%' else '%%' end  "+
				  "	) and  ";  
	    	   
	    	   strAppendQueryDOM=strQycondition + " (TD.SITE_ID ="+ strSiteIdSS +" OR TD.BILLING_SITE ='"+strSiteIdSS+"' ) AND TD.APPLICATION_ID = 1 AND TD.STATUS_ID = 10 AND TS.TRAVEL_TYPE = 'D' AND TS.TRAVEL_STATUS_ID != 1";
	    	   
	       } 
	 
	    	
	
	%>
	
	<%
	
		//System.out.println("strAppendQueryINT=============="+strAppendQueryINT);
	// Code for Chairman starts irrespective of his site he will be able to see all site
	
	 
	try {
		
					//Query for Finding the role of approver
					
					String strSql = "SELECT ROLE_ID FROM M_USERINFO WHERE USERID = "+ Suser_id+ " AND APPLICATION_ID =1 AND STATUS_ID=10";
					rs_1 = dbConBean.executeQuery(strSql); //get the result set
					if (rs_1.next()) 
					{
					strApproverRole = rs_1.getString(1);
					}
					rs_1.close();
					
	}
	catch(Exception e)
	{
		System.out.println("Error in T_TravelReqSearchResultsAll.jsp======="+e);
	}
	
	
	if (strApproverRole !=null && strApproverRole.trim().equals("CHAIRMAN")){
	
		
	//	Query Changed for changing search  Criteria on 14-Oct-2008 by Shiv Sharma	
	if(strTravelType.equals("INT")){
	
		strAppendQueryINT=   strQycondition+ " TD.APPLICATION_ID = 1 AND TD.STATUS_ID = 10   AND TS.TRAVEL_TYPE = 'I' AND TS.TRAVEL_STATUS_ID != 1";
	}
	else
	{
		strAppendQueryDOM=   strQycondition + " TD.APPLICATION_ID = 1 AND TD.STATUS_ID = 10   AND TS.TRAVEL_TYPE = 'D' AND TS.TRAVEL_STATUS_ID != 1";
	}
	
	}
	
	// code for chairman ends
	
	//CODE FOR MATA STARTS
	
	if (strApproverRole !=null && strApproverRole.trim().equals("MATA")){
	
	if(strTravelType.equals("INT")){
	    //Query Changed for changing search  Criteria on 14-Oct-2008 by Shiv Sharma 
		strAppendQueryINT=strQycondition+"  TD.APPLICATION_ID = 1  AND TS.TRAVEL_TYPE = 'I' AND TS.TRAVEL_STATUS_ID != 1";
	}
	else
	{   //Query Changed for changing search  Criteria on 14-Oct-2008 by Shiv Sharma
		strAppendQueryDOM=strQycondition  +"   TD.APPLICATION_ID = 1 AND TD.STATUS_ID = 10   AND TS.TRAVEL_TYPE = 'D' AND TS.TRAVEL_STATUS_ID != 1";
	}
	
	}
	
	// CODE FOR MATA ENDS
	%>
	
	<SCRIPT LANGUAGE="JavaScript">
				function write1()
				{
				var txt='';
				txt=  document.getElementById("main").innerHTML	;
				document.frm.va.value='';
				document.frm.va.value=txt;
				}
				//$.noConflict();
				/*jQuery(document).ready(function($) {

					var dv = document.getElementById("waitingData");
					if(dv != null)
					{
						var xpos = screen.availHeight/2+90;
						var ypos = screen.availWidth/2-350;   
						
						dv.style.position="absolute";       		
						dv.style.left=(xpos+10)+"px";
						dv.style.top=(ypos)+"px";
					}
				});*/
				
	//function created by manoj chand on 01-oct-2013 to call erp or mata can cancel request web service
	function fun_callwebservice(erpwsurl,matawsurl,cid,reqno,travelid,siteid,traveltype){
		document.getElementById("waitingData").style.display="";
	 	var Params='requestnumber='+reqno+'&erpurl='+erpwsurl+'&mataurl='+matawsurl+'&cid='+cid+'&actionflag=cancancelrequest&travel_id='+travelid+'&site_id='+siteid;
        var urlParams=Params;
		$.ajax({
	            type: "post",
	            url: "CancelTrip",
	            data: urlParams,
	            success: function(result){
				var res = jQuery.trim(result);
				if(res == 'yes'){
					if(confirm('<%=dbLabelBean.getLabel("alert.search.areyousure",strsesLanguage)%>')){
						var finalresult = fun_callwebservice1(erpwsurl,matawsurl,cid,reqno,travelid,siteid,traveltype);
						if(finalresult == 'TT'){
							alert('<%=dbLabelBean.getLabel("alert.search.requesthasbeencancelled",strsesLanguage)%>');
							top.main_11.frm.submit();
						}else if(finalresult == 'Error'){
							alert('Error!');
						}else{
							alert(finalresult);
						}
					}
				}else{
					alert(res);
				}
            },
            complete: function(){
            	document.getElementById("waitingData").style.display="none";
            	},
			error: function(){
				alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
            }
          });
	}		
	//function created by manoj chand on 01-oct-2013 to call erp or mata cancel request web service 
	function fun_callwebservice1(erpwsurl,matawsurl,cid,reqno,travelid,siteid,traveltype){
		document.getElementById("waitingData").style.display="";
		var flag = '';
	 	var Params='requestnumber='+reqno+'&erpurl='+erpwsurl+'&mataurl='+matawsurl+'&cid='+cid+'&actionflag=cancelrequest&travel_id='+travelid+'&site_id='+siteid+'&travel_type='+traveltype;
        var urlParams=Params;
		$.ajax({
	            type: "post",
	            url: "CancelTrip",
	            data: urlParams,
	            async: false,
	            success: function(result){
				var res = jQuery.trim(result);
				flag = res;
            },
            complete: function(){
            	document.getElementById("waitingData").style.display="none";
            	},
			error: function(){
				alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
            }
          });
        return flag;
	}		

	</script>
	<% 
	if(requestAppFlag != null && !requestAppFlag.equals("")) {
	%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="40" class="bodyline-top">
		<ul class="pagebullet">
	      <li class="pageHead"><%=dbLabelBean.getLabel("label.search.searchtravelrequisitions",strsesLanguage)%></li>
	    </ul></td>
	    <td align="right" valign="bottom" class="bodyline-top">
		<table align="right" border="0" cellspacing="0" cellpadding="0">
	  <tr align ="right">
	  <td>
	     <ul id="list-nav">
	      <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
	     </ul>
	       </td>
	  </tr>
	  </table>
	</td>
	</tr>
	</table>
	<%	
	}
	%>
	<form method=post action="issue_exlWrite.jsp" name="frm">
		
	<table width="99%" align="center" border="0" cellspacing="1" border=0
		cellpadding="5" class="formborder">
		<tr align="right" class="formhead" height="16">
			<td colspan="12" align="right"><input type=submit
				value='<%=dbLabelBean.getLabel("button.search.exporttoexcel",strsesLanguage)%>' class="formButton" onClick="write1();">
			<input type=button Value="<%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%>" class="formButton"
				onClick="window.print();"></td>
		</tr>
	</table>
<% 
	if(requestAppFlag != null && !requestAppFlag.equals("")) {
	%>
	<div id="dv" style="width:99%; left:5px; top:90px; bottom:5px; height:80%; border-color:red; position: absolute; overflow: auto;" >
	<%} else { %>
	<div id="dv" style="width:99%; left:5px; top:31px; bottom:5px; height:88%; border-color:red; position: absolute; overflow: auto;" >
	<%} %>
	<span id=main>
	
	<table width="100%" align="left" border="0" cellpadding="5" 
		cellspacing="1" class="formborder">  
	<%-- 	<tr align="right" class="formhead" height="16" style="POSITION:relative; height:15px;top:expression(this.offsetParent.scrollTop);">
			<td colspan="10" align="right"><input type=submit
				value='Export to Excel File' class="formButton" onClick="write1();">
			<input type=button Value="Print" class="formButton"
				onClick="window.print();"></td>
		</tr>
	--%>
<!-- 	<tr align="center" class="formhead" style="POSITION:relative; top:expression(this.offsetParent.scrollTop);">     -->
	<tr align="center" class="formhead"> 
		<td width="4%" align="left" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
		<td width="13%" align="left"><%=dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)%></td>
		<td width="10%" align="left"><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td>
		<td width="13%" align="left"><%=dbLabelBean.getLabel("label.search.originatorname",strsesLanguage)%></td>
		<td width="13%" align="left"><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage)%></td>
		<td width="12%" align="left"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%></td>
		<!-- 2/26/2007 -->
		<td width="10%" align="left"><%=dbLabelBean.getLabel("label.global.travelfrom",strsesLanguage)%></td>
		<td width="8%" align="left"><%=dbLabelBean.getLabel("label.global.travelto",strsesLanguage)%></td>
		<td width="10%" align="left"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%></td>
		<!--	<td width="23%" align="center">TCHEQUE</TD> -->
		<td width="6%" align="left"><%=dbLabelBean.getLabel("label.requestdetails.status",strsesLanguage)%></td>
	</tr>

		<%
					int iSno=1;
					String OriginatorName		="";
					String sRequisitionNo		="";
					String NAME					="";
					String TRAVEL_DATE			="";
					//Date TRAVEL_DATE			=null;
					String DERPARTMENT_NAME	 	="";
					String DIVISIONNAME			="";
					String SITENAME				="";
					String TRAVELFROM			="";
					String TRAVELTO				="";
					String TOTALAMOUNT			="";
					String TACURRENCY			="";
					String TCHEQUE				="";
					String TCURRENCY			="";
					String APPROVEDBY			="";
					String APPROVE_STATUS		="";
					String Traveller_id			="";
					String TRAVEL_REQ_ID		="";
					String ORIGINATED_BY		="";
					//System.out.println("5");
					String TRAVEL_ID			="";
					String C_DATETIME			="";
					String strPageUrl           ="";
	
					//System.out.println("strAppendQueryINT======"+strAppendQueryINT);
					//Query Changed for changing search  Criteria on 14-Oct-2008 by Shiv Sharma
					//Query Cahnged for changing serach Criteria(approver can see the request which was approved by some on else  on behalf of him ) on 19-mar-2009 by Shiv Sharma  
				/*	if(strTravelType.equals("INT"))
					{
						sSqlStr= "SELECT  distinct dbo.USER_NAME(TD.C_UserId)as Originator_Name, "+ 
	 					" TD.TRAVEL_REQ_ID,TD.TRAVEL_ID,TD.TRAVELLER_ID,TD.TRAVEL_REQ_NO, "+
						" ISNULL(RTRIM(.DBO.USER_NAME(TD.C_USERID)),'NA') AS ORIGINATED_BY,"+
						" ISNULL(dbo.CONVERTDATEDMY1(TD.C_DATETIME),'-') AS C_DATETIME,"+ 
						" ISNULL(dbo.DIVNAME_FROM_USERID(TD.C_USERID),'-') AS DIVISION,"+ 
						" ISNULL(dbo.SITENAME_FROM_USERID(TD.C_USERID),'-') AS UNIT, "+
						" ISNULL(dbo.DEPTNAME_FROM_USERID(TD.C_USERID),'-') AS DEPT, "+
						" ISNULL(RTRIM(.DBO.USER_NAME(TD.TRAVELLER_ID)),'NA') AS CURRENT_TRAVELLER,"+  
						" ISNULL(dbo.TRAVEL_FROM(TD.TRAVEL_ID,'I'),'-') AS TRAVEL_FROM, "+
						" ISNULL(dbo.TRAVEL_TO(TD.TRAVEL_ID,'I'),'-') AS TRAVEL_TO,"+
						" ISNULL(TD.TOTAL_AMOUNT,'0.00') AS TOTAL_AMOUNT , ISNULL(TD.TA_CURRENCY,'-' ) AS TA_CURRENCY, "+
						" ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-') AS TRAVEL_DATE, TD.GROUP_TRAVEL_FLAG  "+
						" FROM T_TRAVEL_DETAIL_INT TD (NOLOCK) INNER JOIN  T_TRAVEL_MST TM (NOLOCK) ON "+ 
						" TD.TRAVEL_REQ_ID =TM.TRAVEL_REQ_ID INNER JOIN  T_TRAVEL_STATUS (NOLOCK) TS ON TD.TRAVEL_ID = TS.TRAVEL_ID "+
	 					" INNER JOIN  T_APPROVERS TA (NOLOCK) ON TD.TRAVEL_ID = TA.TRAVEL_ID "+
						 ""+strAppendQueryINT+" and (ta.APPROVER_ID = "+Suser_id+"  or TD.C_UserId =  "+Suser_id+" or Ta.ORIGINAL_APPROVER="+Suser_id+")"; 
					
	
					}
					else
					{   //Query Changed for changing search  Criteria on 14-Oct-2008 by Shiv Sharma
						sSqlStr= " SELECT distinct dbo.USER_NAME(TD.C_UserId)as Originator_Name,"+
						" TD.TRAVEL_REQ_ID,TD.TRAVEL_ID,TD.TRAVELLER_ID,TD.TRAVEL_REQ_NO, "+
						" ISNULL(RTRIM(.DBO.USER_NAME(TD.C_USERID)),'NA') AS ORIGINATED_BY,"+ 
						" ISNULL(dbo.CONVERTDATEDMY1(TD.C_DATETIME),'-') AS C_DATETIME, "+ 
						" ISNULL(dbo.DIVNAME_FROM_USERID(TD.C_USERID),'-') AS DIVISION, "+
						" ISNULL(dbo.SITENAME_FROM_USERID(TD.C_USERID),'-') AS UNIT,"+
						" ISNULL(dbo.DEPTNAME_FROM_USERID(TD.C_USERID),'-') AS DEPT,"+
						" ISNULL(RTRIM(.DBO.USER_NAME(TD.TRAVELLER_ID)),'NA') AS CURRENT_TRAVELLER,"+
						" ISNULL(dbo.TRAVEL_FROM(TD.TRAVEL_ID,'D'),'-') AS TRAVEL_FROM, "+
						" ISNULL(dbo.TRAVEL_TO(TD.TRAVEL_ID,'D'),'-') AS TRAVEL_TO,ISNULL(TD.TOTAL_AMOUNT,'0.00') AS TOTAL_AMOUNT ,"+ 
						" ISNULL(TD.TA_CURRENCY,'-' ) AS TA_CURRENCY, ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-') AS TRAVEL_DATE,"+
						" TD.GROUP_TRAVEL_FLAG 	FROM T_TRAVEL_DETAIL_DOM TD (NOLOCK) INNER JOIN "+
						" T_TRAVEL_MST TM  (NOLOCK)   ON TD.TRAVEL_REQ_ID =TM.TRAVEL_REQ_ID INNER JOIN "+
						" T_TRAVEL_STATUS TS  (NOLOCK) ON TD.TRAVEL_ID = TS.TRAVEL_ID  INNER JOIN "+
						" T_APPROVERS TA (NOLOCK) ON TD.TRAVEL_ID = TA.TRAVEL_ID  "+ strAppendQueryDOM+" and (ta.APPROVER_ID =  "+Suser_id+"  or TD.C_UserId =  "+Suser_id+" or Ta.ORIGINAL_APPROVER="+Suser_id+")"; 
					
					}*/
					
					//System.out.println("strApproveFromdate--->"+strApproveFromdate);
					
					
				/*	System.out.println("strUnitNo--->"+strUnitNo);
					System.out.println("strOrigenation--->"+strOrigenation);
					System.out.println("strTravler--->"+strTravler);
					System.out.println("strDeptdate--->"+strDeptdate);
					System.out.println("strRequstionNo--->"+strRequstionNo);
					System.out.println("strDestination--->"+strDestination);
					System.out.println("strCreateFromdate--->"+strCreateFromdate);
					System.out.println("strCreateTodate--->"+strCreateTodate);
					System.out.println("strPendingApprover--->"+strPendingApprover);
					System.out.println("strStatus1--->"+strStatus1);
					System.out.println("strApproveFromdate--->"+strApproveFromdate);
					System.out.println("strApproveTodate--->"+strApproveTodate);
					System.out.println("strTravelType--->"+strTravelType);
					System.out.println("Integer.parseInt(Suser_id)--->"+Integer.parseInt(Suser_id));*/
					String strERPWS_URL = "",strMATAWS_URL="",strCID="",strSiteId="";
					//rs = dbConBean.executeQuery(sSqlStr);
					objCstmt=objCon.prepareCall("{call SEARCH_TRAVEL_REQUEST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					//System.out.println("sSqlStr OklkklOOOOOOOOOO=111==>>"+strDestination);
					objCstmt.setString(1,strUnitNo);
					objCstmt.setString(2,strOrigenation);
					objCstmt.setString(3,strTravler);
					objCstmt.setString(4,strDeptdate);
					objCstmt.setString(5,strRequstionNo);
					objCstmt.setString(6,strDestination);
					objCstmt.setString(7,strCreateFromdate);
					objCstmt.setString(8,strCreateTodate);
					objCstmt.setString(9,strPendingApprover);
					objCstmt.setString(10,strStatus1);
					objCstmt.setString(11,strApproveFromdate);
					objCstmt.setString(12,strApproveTodate);
					//objCstmt.setString(13,strTravelType);
					objCstmt.setString(13,strTravelType);
					objCstmt.setInt(14,Integer.parseInt(Suser_id));
					objCstmt.setString(15,keyWordSearchVal);
					objCstmt.setString(16,requestAppFlag);
					rs=objCstmt.executeQuery();
					
					while(rs.next())
					{					
						 countflag=1;
						 OriginatorName					=	rs.getString("Originator_Name");
						 TRAVEL_REQ_ID					=	rs.getString("TRAVEL_REQ_ID");
						 TRAVEL_ID						=	rs.getString("TRAVEL_ID");
						 Traveller_id					=	rs.getString("TRAVELLER_ID");
						 sRequisitionNo					=	rs.getString("TRAVEL_REQ_NO");
						 ORIGINATED_BY					=	rs.getString("ORIGINATED_BY");
						 C_DATETIME						=	rs.getString("C_DATETIME");
						 DIVISIONNAME					=	rs.getString("DIVISION");
						 SITENAME						=	rs.getString("UNIT");
						 DERPARTMENT_NAME				=	rs.getString("DEPT_name");
						 NAME							=	rs.getString("CURRENT_TRAVELLER");
						 TRAVELFROM						=	rs.getString("TRAVEL_FROM");
						 TRAVELTO						=	rs.getString("TRAVEL_TO");
						 TOTALAMOUNT					=	rs.getString("TOTAL_AMOUNT");
						 //TACURRENCY						=	rs.getString("TA_CURRENCY");
						 String  tRAVEL_DATE			=	rs.getString("TRAVEL_DATE");
						 strTravelType					=   rs.getString("TRAVEL_TYPE");
							
						 TRAVEL_DATE=tRAVEL_DATE;  //  code added by shiv on 17-May-07
	
						 //System.out.println("sssssssssssssssssss");
	  
						 
	   
		            //  Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on  21-Feb-08 ;      
		                 if(strTravelType.equals("INT"))
					         {
									strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
									strTravelAgencyTypeId	 =	rs.getString("travel_agency_id");
									if(strGroupTravelFlag==null) 
									{
										strGroupTravelFlag="N";
									}
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
									{		
										NAME="Group/Guest Travel ";
										strPageUrl = "Group_T_TravelRequisitionDetails.jsp";
										if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
											strPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
											}
	  							    }
									else {
										strPageUrl = "T_TravelRequisitionDetails.jsp";
										if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
											strPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
										}
									}
							}  
		 	            else //// Added by shiv for showing Group Travel_DOM in case of group travel inspite of traveller Name on 02-Jul-08 ;      
					     {
									strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
									strTravelAgencyTypeId	 =	rs.getString("travel_agency_id");
									if(strGroupTravelFlag==null) 
									{
										strGroupTravelFlag="N";
									}
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
									{		
										NAME="Group/Guest Travel ";
										strPageUrl = "Group_T_TravelRequisitionDetails_D.jsp";
										if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
											strPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
											}
	  							    }
									else {
										strPageUrl = "T_TravelRequisitionDetails_D.jsp";
										if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
											strPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
										}
									}
							}  
					    strCID = rs.getString("CID");
						strERPWS_URL = rs.getString("ERP_WS_URL");
						strMATAWS_URL = rs.getString("MATA_WS_URL");
						strSiteId = rs.getString("SITE_ID");
				
				if (iCls % 2 == 0) {
					strStyleCls = "formtr2";
				} else {
					strStyleCls = "formtr1";
				}
	
				iCls++;
		%>
		<tr valign=top class="<%=strStyleCls%>">
			<!-- T_TravelRequisitionDetails.jsp -->
			<td width="4%" class="rep-head"><%=iSno%><br>
			<td width="13%" class="rep-txt">
			<%
			if (strTravelType.equals("INT")) {
			%> <a href="#"
				onClick="MM_openBrWindow('<%=strPageUrl%>?purchaseRequisitionId=<%=TRAVEL_ID%>&traveller_Id=<%=Traveller_id%>&travelType=I','SEARCH1','scrollbars=yes,resizable=yes,width=975,height=550')">
			<%=sRequisitionNo%></a> <%
	 }
	 %>
			<%
			if (strTravelType.equals("DOM")) {
			%> <a href="#"
				onClick="MM_openBrWindow('<%=strPageUrl%>?purchaseRequisitionId=<%=TRAVEL_ID%>&traveller_Id=<%=Traveller_id%>&travelType=D','SEARCH1','scrollbars=yes,resizable=yes,width=975,height=550')">
			<%=sRequisitionNo%></a> <%
	 }
	 %>
			</td>
			<td width="10%" class="rep-txt"><%=SITENAME%></td>
			<td width="13%" class="rep-txt"><%=OriginatorName%></td>
			<td width="13%" class="rep-txt"><%=NAME%></td>
			<td width="12%" class="rep-txt"><%=TRAVEL_DATE%></td>
			
			
			<td width="10%" class="rep-txt"><%=TRAVELFROM%></td>
			<td width="8%" class="rep-txt"><%=TRAVELTO%></td>
			<td width="10%" class="rep-txt"><%=TOTALAMOUNT%></td>
			<%
			if (strTravelType.equals("INT")) {
			%>
			<td class="listdata" width="7%" align="center"><a href="#"
				onClick="MM_openBrWindow('T_TravelRequisitionWorkFlowDiagram.jsp?travelRequisitionId=<%=TRAVEL_ID%>&strTravellerId=<%=Traveller_id%>&strTravelRequestNo=<%=sRequisitionNo%>&travelType=I','SEARCH1','scrollbars=yes,resizable=yes,width=775,height=250')"><%=dbLabelBean.getLabel("link.search.approvers",strsesLanguage)%></a>
			<%
				//added by manoj chand on 18 sep 2013 to display cancel trip link
				//if(strStatus1.equals("-1") || strStatus1.equals("10")){
					/*	String strSql=null;
						strSql =" SELECT CM.CID,CM.ERP_WS_URL,CM.MATA_WS_URL FROM T_TRAVEL_STATUS TTS"+ 
								" INNER JOIN T_TRAVEL_DETAIL_INT TTDI"+
								" ON TTS.TRAVEL_ID=TTDI.TRAVEL_ID AND TTS.TRAVEL_TYPE='I'"+
								" INNER JOIN M_SITE SM ON TTDI.SITE_ID=SM.SITE_ID AND SM.STATUS_ID=10"+
								" LEFT OUTER JOIN M_COMPANY CM ON SM.COMPANY_ID=CM.CID AND CM.STATUS_ID=10"+ 
								" WHERE TTS.TRAVEL_STATUS_ID=10 AND TTS.STATUS_ID=10"+
								" AND TTS.TES_FLAG='N' AND TTDI.TRAVEL_ID='"+TRAVEL_ID+"'"+
								" AND DATEDIFF(DD,TTDI.TRAVEL_DATE,GETDATE())>0"+  
								" AND (CM.ERP_WS_URL<>'' AND CM.ERP_WS_URL <>'temp' and cm.ERP_WS_URL is not null)";
					System.out.println("strSql--i-->"+strSql);
					String strERPWS_URL = "",strMATAWS_URL="",strCID="";
					rs_1 = dbConBean.executeQuery(strSql);
					if(rs_1.next()){
						strCID = rs_1.getString("CID");
						strERPWS_URL = rs_1.getString("ERP_WS_URL");
						strMATAWS_URL = rs_1.getString("MATA_WS_URL");
					}*/
					//System.out.println("strERPWS_URL--->"+strERPWS_URL);
					//System.out.println("strMATAWS_URL--->"+strMATAWS_URL);
					if((strERPWS_URL!=null && !strERPWS_URL.equals("")) && (strMATAWS_URL!=null && !strMATAWS_URL.equals(""))){
					%>
					<a href="#"	onClick="fun_callwebservice('<%=strERPWS_URL %>','<%=strMATAWS_URL %>','<%=strCID %>','<%=sRequisitionNo %>','<%=TRAVEL_ID %>','<%=strSiteId %>','I')">Cancel</a>
				<%	}
				//}%>
				</td>
			<%}
			%>
			<%
			if (strTravelType.equals("DOM")) { //System.out.println("in else of approver window");
			%>
			<td class="listdata" width="13%" align="center"><a href="#"
				onClick="MM_openBrWindow('T_TravelRequisitionWorkFlowDiagram.jsp?travelRequisitionId=<%=TRAVEL_ID%>&strTravellerId=<%=Traveller_id%>&strTravelRequestNo=<%=sRequisitionNo%>&travelType=D','SEARCH1','scrollbars=yes,resizable=yes,width=775,height=250')"><%=dbLabelBean.getLabel("link.search.approvers",strsesLanguage)%></a>
			
			<%
				//added by manoj chand on 18 sep 2013 to display cancel trip link
				/*if(strStatus1.equals("-1") || strStatus1.equals("10")){
					String strSql=null;
					strSql =" SELECT CM.CID,CM.ERP_WS_URL,CM.MATA_WS_URL FROM T_TRAVEL_STATUS TTS"+ 
							" INNER JOIN T_TRAVEL_DETAIL_DOM TTDD"+
							" ON TTS.TRAVEL_ID=TTDD.TRAVEL_ID AND TTS.TRAVEL_TYPE='D'"+
							" INNER JOIN M_SITE SM ON TTDD.SITE_ID=SM.SITE_ID AND SM.STATUS_ID=10"+
							" LEFT OUTER JOIN M_COMPANY CM ON SM.COMPANY_ID=CM.CID AND CM.STATUS_ID=10"+ 
							" WHERE TTS.TRAVEL_STATUS_ID=10 AND TTS.STATUS_ID=10"+
							" AND TTS.TES_FLAG='N' AND TTDD.TRAVEL_ID='"+TRAVEL_ID+"'"+
							" AND DATEDIFF(DD,TTDD.TRAVEL_DATE,GETDATE())>0  "+
								" AND (CM.ERP_WS_URL<>'' AND CM.ERP_WS_URL <>'temp' and cm.ERP_WS_URL is not null)";
					System.out.println("strSql--d-->"+strSql);
					String strERPWS_URL = "",strMATAWS_URL="",strCID="";
					rs_1 = dbConBean.executeQuery(strSql);
					if(rs_1.next()){
						strCID = rs_1.getString("CID");
						strERPWS_URL = rs_1.getString("ERP_WS_URL");
						strMATAWS_URL = rs_1.getString("MATA_WS_URL");
					}*/
					//System.out.println("strERPWS_URL--->"+strERPWS_URL);
					//System.out.println("strMATAWS_URL--->"+strMATAWS_URL);
					if((strERPWS_URL!=null && !strERPWS_URL.equals("")) && (strMATAWS_URL!=null && !strMATAWS_URL.equals(""))){
					%>
					<a href="#"	onClick="fun_callwebservice('<%=strERPWS_URL %>','<%=strMATAWS_URL %>','<%=strCID %>','<%=sRequisitionNo %>','<%=TRAVEL_ID %>','<%=strSiteId %>','D')">Cancel</a>
				<%	}
				//}%>
				</td>
				
			<%}	%>
			</tr>
			<%
					iSno++;
					}
					rs.close();
					if(countflag == 0){%>
					<tr class="formtr2">
					<td colspan="10"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage) %>
					</td>
					</tr>
					</table>
				<%	}
				}
	//System.out.println("---------------end-----------------");
				dbConBean.close(); //Close All Connection
				%>
	
	
	   </span>
	</div>
	<input type=hidden name=va>
	
	<input type=hidden name=flag value="<%=strRadValue%>" >
	 
	 </form>
	 <script>
	 closeDivRequest();
	 </script>
	
	</body>
	</html>
