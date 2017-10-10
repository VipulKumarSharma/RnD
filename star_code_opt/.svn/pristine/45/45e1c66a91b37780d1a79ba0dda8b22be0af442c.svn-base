	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Rohit Ganjoo
	 *Date of Creation 		:07/09/2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is the jsp file is for report generation
	 *Modification 			: Change Database Query
	 *Reason of Modification: 1.Database query is not working properly & the report is order by TRAVEL_REQ_NO 
	                          2. Added A New Code For Showing Duration And Travel Type For Reports  
							  3.  Query modified for extracting   "TRAVEL_DATE"  for showing in reports, Added new code   for showing travaller Name         in reports  
							  4. Under a requisition movement report ignoring a check of status id so that originator name can be visible even he is deactivated by Gaurav Aggarwal on 06-Jun-2007
							  5 .Correct  the spelling of  Traveler Name on 21-May-08 Shiv sharma    
							  6 :Added for showing group traval in case of  group travel_dom  on 18-Jun-08 by shiv sharma 
							  7 :Add a code for Expired requisions on  8/25/2008 by shiv sharma 
	 *Date of Modification  : 1.14-Mar-2007
	                                       2.15-May-07 
										   3.16-May-07
	 *Modified By	        : 1.Vijay Kumar Singh
	                                  2.shiv sharma 
									  3.shiv sharma 
	 *Revision History	: 
	 *Editor				:Editplus
	 
	 *Modification			:1. Add Cancel action code to this report for admin user.
	 						 2. Add a progress images
	 *Modification Date		:12-jan-2011
	 *Modified by			:Manoj Chand
	 
	 *Modification			:1. modify the design of cancel window
	 *Modification Date		:18-jan-2011
	 *Modified by			:Manoj Chand
	 
	 *Modification			:Making group/guest in traveller name field as hyperlink to show traveller name and designation
	 *Modification Date		:06-jan-2012
	 *Modified by			:Manoj Chand
	 
	 *Modified By			:Manoj Chand
	 *Modification			:Increase popup window width
	 *Date of Modification  :04 jan 2013
	 
	 *Modified By			:Manoj Chand
	 *Modification			:To display the justification when cursor move on requisition number.
	 *Date of Modification  :21 Aug 2013
	 *******************************************************/
	
	
	%>
	<%@ page  pageEncoding="UTF-8"%>
	<%@ include  file="importStatement.jsp" %>
	
	<HTML>
	<HEAD>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
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
	<style>
	 	a.reportLink:link {
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:10px;
		font-weight:normal;
		color:#d62234;
		}
		
		a.reportLink:visited {
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:10px;
		font-weight:normal;
		color:#0000a0;
		}
		
		a.reportLink:active {
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:10px;
		font-weight:normal;
		color:#0000a0;
		}
		
		a.reportLink:hover {
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:10px;
		font-weight:normal;
		color:#0000a0;
		}
	 </style>
	</HEAD> 
	
	<script language=JavaScript >
	
	function check()
	{
	     for (i = 0; i < document.frm.length; i++)
		{
		if ( document.frm[i].checked == true)
			return true;
		}
	alert('<%=dbLabelBean.getLabel("alert.approverequest.errormessage",strsesLanguage) %>');
	return false; 
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


	function closeDivRequest()
	{
		document.getElementById("waitingData").style.visibility="hidden";	
	}
	
	function openWaitingProcess()
	{
			var dv = document.getElementById("waitingData");
			if(dv != null)
			{
				var xpos = screen.availHeight/2+90;
				var ypos = screen.availWidth/2-350;   
				
				dv.style.position="absolute";       		
				dv.style.left=(xpos+10)+"px";
				dv.style.top=(ypos)+"px";
				
				document.getElementById("waitingData").style.visibility="";
			}
	}


//added by manoj chand on 06 jan 2012 to open window for showing traveller names for group/guest request.
	
	function showTravellerName(strTrvType,strTrvId, strTrvRequestNo)
	{
		if(strTrvType=='I')
			strTrvType="INT";
		else
			strTrvType="DOM";
		var url = 'T_ShowTravellerFromGroupReqs.jsp?traveltype='+strTrvType+'&strTravelId='+strTrvId+'&strTravelRequestNo='+strTrvRequestNo;
		window.open(url,'DefaultApprovers','scrollbars=yes,resizable=no,width=400,height=350');
	}
	
	
	</script>
	
	<%
	
/*
String url=request.getRequestURL().toString();
System.out.println("Pankaj = "+url);
	*/
	
	//added by manoj on 12jan2011 to retrieve all the request parameters.
	String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");
	Map params = request.getParameterMap();
    Iterator itr = params.keySet().iterator();
    String finalUrl="";
    while ( itr.hasNext() )
      {
        String key = (String) itr.next();
        String value = ((String[]) params.get( key ))[ 0 ];
        finalUrl += key+"="+value+"&";
      }
   // System.out.println("finalUrl 1= "+finalUrl);
    finalUrl = finalUrl.substring(0 ,  (finalUrl.length()-1) );
    //System.out.println("finalUrl 2= "+finalUrl);
	
	
	 // Variables declared and initialized
	String strUserId		=	null;
	//Connection con,con1		=	null;			    // Object for connection
	//Statement stmt,stmt1	=	null;		       // Object for Statement
	ResultSet rs,rs1,rsnew		=	null;			  // Object for ResultSet
	//Create Connection   
	//Class.forName(Sdbdriver);
	//con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
	//con1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
	/**int loadFlag=Integer.parseInt(request.getParameter("flag"));
	if(loadFlag==1)
	{
		strUserId="99999";
	}
	else
	{
		strUserId=Suser_id;
	}**/
	
	
	// added new code by shiv for expired mail 8/19/2008
	
	boolean reportDataFlag = false;
	int intSerialNo=1;
	String	strSql=""; // For sql Statements
	String	strTravelReqId	    =	"";
	String	strTravelId	        =	"";
	String  strTravellerId		=   "";
	String	strRequisitionNo	=	"";
	String	strSiteId	        =	"";
	String	strApproverName		=	"";
	String	strSiteName			=	"";
	String	strDivName	        =	"";
	String	strJustification	=	"";
	int	intApproveStatus	=	0;
	String	strOrderId	=	"";
	int iCls = 0;
	String strStyleCls = "";
	int flag = 0;
	String strImage="";
	int count=0;
	String strApproverRole	=	"";
	String strCheck			=	request.getParameter("chkData");
	String strTravelType	=	request.getParameter("travelType");
	String strFrom			=	request.getParameter("from");
	String strTo			=	request.getParameter("to");
	String strtraveltype=	"";
	
	 
	
	//String strSelectUnit			=	request.getParameter("SelectUnit");
	//String strSelectUnit			=	request.getParameter("SelectUnit");
	String strSelectUnit			=	request.getParameter("SelectUnit")==null?"0":request.getParameter("SelectUnit");
	String	strFileName		=	"T_TravelRequisitionDetails.jsp";
	if(isMATA_GmbH != null && isMATA_GmbH.equals("true")){
		strFileName = "T_TravelRequisitionDetails_INT_GmbH.jsp";
	}
	 
	//code added by shiv on 15-May-07 open  
	               if(strTravelType.equals("I"))
							   {
								 strtraveltype=dbLabelBean.getLabel("label.report.international",strsesLanguage);
								 if(ssflage.equals("3")){
									 strtraveltype = "Intercont";
								 }
							   }
					 if(strTravelType.equals("D"))
							  {
							 strtraveltype=dbLabelBean.getLabel("label.report.domestic",strsesLanguage);
								 if(ssflage.equals("3")){
									 strtraveltype = "Domestic/Europe";
								 }
							  }
	 
	
	// for showing all or site id report 
	String strUnitHidden="";
	String strAppendQuery="";
	
	try{
	strUnitHidden = request.getParameter("UnitHidden");
	//System.out.println("strUnitHidden=======>>>>="+strUnitHidden);
	}catch(Exception e)
	{
	}
	String strTimePeriod="";
	String strtraveldate		    ="";
	String strSitenameforreport		="";
	String strGroupTravelFlag       =""; 
	String strTravelAgencyTypeId = "";
	String strTravelName            ="";  
	String strFilterSign            ="";
	
	String req_startus_type         ="";
	
	String strReq_startus=  request.getParameter("REQ_STATUS");
	
	
	
	if(strReq_startus==null){
		strReq_startus="NON_EXP";
	}
	// Add a code for Expired requisions on  8/25/2008 by shiv sharma 
	
	if(strReq_startus.equals("NON_EXP"))
	   {
		  strFilterSign=">=";
		  req_startus_type=dbLabelBean.getLabel("label.report.requisitionmovement",strsesLanguage);
	  }
	 if (strReq_startus.equals("EXP")) 
	  {
	 	  strFilterSign="<";
		  req_startus_type=dbLabelBean.getLabel("label.report.expiredrequisitionmovement",strsesLanguage);
	  }
	
	if(strReq_startus.equals("TEMP"))
	   {
	    
	   req_startus_type=dbLabelBean.getLabel("label.report.temporaryrequisition",strsesLanguage);
	   strFilterSign="=";
	   }
	
	//System.out.println("-------strUnitHidden--"+strUnitHidden+"---------strSelectUnit = "+strSelectUnit);
	 
	
	strUnitHidden=strSelectUnit;
	 
	if(strUnitHidden.equals("0"))
	{
		strAppendQuery="";
	}
	else
	{
		strAppendQuery="AND TM.SITE_ID="+strUnitHidden;
	}
	/////new code added by shiv on 15-May-07OPEN 
	 if(strCheck.equals("1")) 
	  {
		  strTimePeriod="" ;
	  }
	  else
	  {
	  	  strTimePeriod= "("+dbLabelBean.getLabel("label.report.between",strsesLanguage) +strFrom+ " - "+strTo +")";
	  }
	
	 ///>>
	
	 if(strUnitHidden.equals("0")) 
					{
					 strSitenameforreport=dbLabelBean.getLabel("label.report.forallunits",strsesLanguage) ;
					 }
		else
			        {
		             strSql="select isnull(dbo.sitename("+strUnitHidden+"),'') as sitename from M_site where status_id=10" ;  
		              rs1 = dbConBean.executeQuery(strSql);
							while(rs1.next())
							{
	                               strSitenameforreport=rs1.getString("sitename");  
						    }
							rs1.close();
						 strSitenameforreport= " In " + strSitenameforreport  ;   
	
			       } 
	 ///>>
	
	/////new code added by shiv on 15-May-07 CLOSE
	
	%>
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	
	<form  name="frm" action="RequisitionMovementReport_mailpost.jsp" onsubmit="return check(0);">
	<body>
	
	<!-- added by manoj on 13jan2011 -->
	<div id="waitingData" style="visibility:hidden;"> 	  
	    
	 	<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
	 	<br>      
	 	<font color="#000080" class="pageHead"><center><%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage) %> </center></font>    
	</div>
	<script language="javaScript">  
	openWaitingProcess();
	</script>
	
	<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	<!-- new code added on 15-May-07  by shiv open    -->
	 <table width="100%" border="0" cellspacing="0" cellpadding="10">
		<tr>
			<td width="77%" height="50" class="bodyline-top">
			<ul class="pagebullet">
				<li class="pageHead"><b> <%=req_startus_type%>  <%=dbLabelBean.getLabel("label.report.reportfor",strsesLanguage) %>  <%= strtraveltype%> <%=dbLabelBean.getLabel("label.report.travelrequisitions",strsesLanguage) %>  <%= strSitenameforreport%> <%= strTimePeriod%></b></li>
			</ul>
			</td>
		</tr>
	</table>
	<!-- new code added on 15-May-07  by shiv close    -->
	
	<br>
	<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">	
	 <tr align="center" class="formhead">
	   <td class="colorPink" colspan="19"><%=dbLabelBean.getLabel("label.report.movecursortorequisition",strsesLanguage) %></td> 
	 </tr>
	 <tr align="center" class="formhead">
	   <td class="colorPink" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
	   
	   <%
	   if(SuserRole.equals("AD"))
		  {
	   %>
	   <td class="colorPink" nowrap="nowrap"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage) %></td>
	   
	   <%} %>
	   
	   
	   
	      <td class="colorPink"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage) %> </td>   
			 <td class="colorPink" align="left" width="10%"><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage) %></td><!-- Correct  the spelling of  Traveler Name on 21-May-08 Shiv sharma    -->
		  <td class="colorPink"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %> </td>
	      <td class="colorPink"> 1 </td>
	      <td class="colorPink"> 2 </td>
	      <td class="colorPink"> 3 </td>
	      <td class="colorPink"> 4 </td>
	      <td class="colorPink"> 5 </td>
	      <td class="colorPink"> 6 </td>
	      <td class="colorPink"> 7 </td>
	      <td class="colorPink"> 8 </td>
	      <td class="colorPink"> 9</td>
	      <td class="colorPink"> 10 </td>
		  <td class="colorPink"> 11</td>
	  	  <td class="colorPink"> 12</td>
		  <%
		  // Add a code for showing mail send header in table for Expired requisions on  8/25/2008 by shiv sharma 
		  if(strFilterSign.equals("<") && SuserRole.equals("AD"))
		  {
		  %>
		  <td class="colorPink" size="8%"><%=dbLabelBean.getLabel("label.report.mailsenton",strsesLanguage) %></td>
	      <td class="colorPink" ><%=dbLabelBean.getLabel("label.report.sendmail",strsesLanguage) %></td>
	  	  <%}
		  %>
		  
		  
	  </tr>
	
	<%
	//Query for Finding the role of approver
	strSql  = "SELECT LTRIM(RTRIM(ROLE_ID)) FROM M_USERINFO WHERE USERID='"+Suser_id+"'AND STATUS_ID='10'";
	//stmt = con.createStatement();
	
	
	rs = dbConBean.executeQuery(strSql);
	if(rs.next())
	{
	    strApproverRole = rs.getString(1);
	 
	}
	rs.close();
	
	//remove from query in date selection CONVERT(VARCHAR(10),C_DATETIME,103)
	//if(strApproverRole!=null && strApproverRole.equals("CHAIRMAN") || strUnitHidden.equals("0"))
	if(strUnitHidden.equals("0")) //// selection  for all site 
	  {               
			  if(strCheck.equals("1")) 
			  {           
			    if(strTravelType.equals("I"))
				{     
			 
				/*@ Vijay Kumar Singh Date 14-Mar-2007
				 * Select all groups in requisitionmovement report order by TRAVEL_REQ_NO */
			      //// Followoing Query modified by shiv on 16-May-07  added  "TRAVEL_DATE"   
			      if (strFilterSign.equals("="))
					  {
					  strSql="SELECT DISTINCT T_TRAVEL_DETAIL_INT.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_INT.TRAVEL_ID,T_TRAVEL_DETAIL_INT.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_INT.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_INT.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_INT.TRAVEL_DATE),'') AS TRAVEL_DATE,T_TRAVEL_DETAIL_INT.GROUP_TRAVEL_FLAG,ISNULL(T_TRAVEL_DETAIL_INT.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_INT.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_INT.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_INT.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE TRAVEL_STATUS_ID='1' AND T_TRAVEL_STATUS.TRAVEL_TYPE='I' AND T_TRAVEL_DETAIL_INT.STATUS_ID='10' AND	(T_TRAVEL_DETAIL_INT.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_INT.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) order by TRAVEL_REQ_NO";
				  	  }
					  else{
					  
					  strSql="SELECT DISTINCT T_TRAVEL_DETAIL_INT.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_INT.TRAVEL_ID,T_TRAVEL_DETAIL_INT.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_INT.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_INT.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_INT.TRAVEL_DATE),'') AS TRAVEL_DATE,T_TRAVEL_DETAIL_INT.GROUP_TRAVEL_FLAG,ISNULL(T_TRAVEL_DETAIL_INT.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_INT.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON   T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_INT.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_INT.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE dbo.TRAVEL_FINAL_APPROVAL_STATUS(T_TRAVEL_DETAIL_INT.TRAVEL_ID,'I',T_TRAVEL_DETAIL_INT.TRAVELLER_ID)='NOT APPROVED BY ALL'AND TRAVEL_STATUS_ID='2' AND T_TRAVEL_STATUS.TRAVEL_TYPE='I' AND T_TRAVEL_DETAIL_INT.STATUS_ID='10' and T_TRAVEL_DETAIL_INT.TRAVEL_DATE "+strFilterSign+" (getdate()-1)  AND	(T_TRAVEL_DETAIL_INT.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_INT.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) order by TRAVEL_REQ_NO";
				  }
			
			      
				    }
			    else
				{ 
			    	 		
			      if (strFilterSign.equals("="))
					  {
					  strSql="SELECT DISTINCT T_TRAVEL_DETAIL_DOM.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_DOM.TRAVEL_ID,T_TRAVEL_DETAIL_DOM.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_DOM.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_DOM.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_DOM.TRAVEL_DATE),'') AS TRAVEL_DATE ,T_TRAVEL_DETAIL_DOM.GROUP_TRAVEL_FLAG,ISNULL(T_TRAVEL_DETAIL_DOM.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_DOM.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_DOM INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_DOM.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_DOM.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE  TRAVEL_STATUS_ID='1' AND T_TRAVEL_STATUS.TRAVEL_TYPE='D' AND T_TRAVEL_DETAIL_DOM.STATUS_ID='10'  AND	(T_TRAVEL_DETAIL_DOM.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_DOM.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) order by TRAVEL_REQ_NO ";
				  }else{
					  strSql="SELECT DISTINCT T_TRAVEL_DETAIL_DOM.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_DOM.TRAVEL_ID,T_TRAVEL_DETAIL_DOM.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_DOM.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_DOM.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_DOM.TRAVEL_DATE),'') AS TRAVEL_DATE ,T_TRAVEL_DETAIL_DOM.GROUP_TRAVEL_FLAG,ISNULL(T_TRAVEL_DETAIL_DOM.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_DOM.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_DOM INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_DOM.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_DOM.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE dbo.TRAVEL_FINAL_APPROVAL_STATUS(T_TRAVEL_DETAIL_DOM.TRAVEL_ID,'D',T_TRAVEL_DETAIL_DOM.TRAVELLER_ID)='NOT APPROVED BY ALL'AND TRAVEL_STATUS_ID='2' AND T_TRAVEL_STATUS.TRAVEL_TYPE='D' AND T_TRAVEL_DETAIL_DOM.STATUS_ID='10' and T_TRAVEL_DETAIL_DOM.TRAVEL_DATE "+strFilterSign+"(getdate()-1)  AND	(T_TRAVEL_DETAIL_DOM.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_DOM.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) order by TRAVEL_REQ_NO ";
				  }
				  	 
				 
				
				/**********************************************Modification End ****************************************/
				}
			  }
			  else
			  {       
			    if(strTravelType.equals("I"))
				{       
				  //System.out.println(" chairman selected int"); 
				   if (strFilterSign.equals("="))
					{
					  strSql="SET DATEFORMAT DMY SELECT DISTINCT T_TRAVEL_DETAIL_INT.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_INT.TRAVEL_ID,T_TRAVEL_DETAIL_INT.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_INT.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_INT.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_INT.TRAVEL_DATE),'') AS TRAVEL_DATE,T_TRAVEL_DETAIL_INT.GROUP_TRAVEL_FLAG,ISNULL(T_TRAVEL_DETAIL_INT.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_INT.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_INT.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_INT.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE  TRAVEL_STATUS_ID='1' AND T_TRAVEL_STATUS.TRAVEL_TYPE='I' AND T_TRAVEL_DETAIL_INT.STATUS_ID='10'  AND	(T_TRAVEL_DETAIL_INT.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_INT.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) AND CAST(FLOOR(CAST(T_TRAVEL_DETAIL_INT.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' ";
				  }
			      else{ 
				  	  strSql="SET DATEFORMAT DMY SELECT  DISTINCT T_TRAVEL_DETAIL_INT.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_INT.TRAVEL_ID,T_TRAVEL_DETAIL_INT.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_INT.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_INT.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_INT.TRAVEL_DATE),'') AS TRAVEL_DATE,T_TRAVEL_DETAIL_INT.GROUP_TRAVEL_FLAG,ISNULL(T_TRAVEL_DETAIL_INT.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_INT.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_INT.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_INT.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE dbo.TRAVEL_FINAL_APPROVAL_STATUS(T_TRAVEL_DETAIL_INT.TRAVEL_ID,'I',T_TRAVEL_DETAIL_INT.TRAVELLER_ID)='NOT APPROVED BY ALL'AND TRAVEL_STATUS_ID='2' AND T_TRAVEL_STATUS.TRAVEL_TYPE='I' AND T_TRAVEL_DETAIL_INT.STATUS_ID='10' and T_TRAVEL_DETAIL_INT.TRAVEL_DATE "+strFilterSign+" (getdate()-1)  AND	(T_TRAVEL_DETAIL_INT.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_INT.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) AND CAST(FLOOR(CAST(T_TRAVEL_DETAIL_INT.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' ";
				  }
				  //System.out.print("3" +strSql);
				  
			    }
				else
				{        //out.println(" chairman selected dom"); 
					  
				if (strFilterSign.equals("="))
					{
					  strSql="SET DATEFORMAT DMY SELECT DISTINCT T_TRAVEL_DETAIL_DOM.TRAVEL_REQ_ID, T_TRAVEL_DETAIL_DOM.TRAVEL_ID,T_TRAVEL_DETAIL_DOM.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_DOM.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_DOM.SITE_ID)AS SITE,dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_DOM.TRAVEL_DATE),T_TRAVEL_DETAIL_DOM.GROUP_TRAVEL_FLAG,ISNULL(T_TRAVEL_DETAIL_DOM.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_DOM.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_DOM INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID  AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_DOM.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_DOM.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE TRAVEL_STATUS_ID='1'AND T_TRAVEL_DETAIL_DOM.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_TRAVEL_STATUS.TRAVEL_TYPE='D' AND T_TRAVEL_DETAIL_DOM.STATUS_ID='10'  AND	(T_TRAVEL_DETAIL_DOM.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_DOM.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN'))   AND CAST(FLOOR(CAST(T_TRAVEL_DETAIL_DOM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' "; 
				  }
				  else{
			      		strSql="SET DATEFORMAT DMY SELECT DISTINCT T_TRAVEL_DETAIL_DOM.TRAVEL_REQ_ID, T_TRAVEL_DETAIL_DOM.TRAVEL_ID,T_TRAVEL_DETAIL_DOM.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_DOM.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_DOM.SITE_ID)AS SITE,dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_DOM.TRAVEL_DATE),T_TRAVEL_DETAIL_DOM.GROUP_TRAVEL_FLAG,ISNULL(T_TRAVEL_DETAIL_DOM.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_DOM.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_DOM INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_DOM.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_DOM.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE dbo.TRAVEL_FINAL_APPROVAL_STATUS(T_TRAVEL_DETAIL_DOM.TRAVEL_ID,'D',T_TRAVEL_DETAIL_DOM.TRAVELLER_ID)='NOT APPROVED BY ALL' AND TRAVEL_STATUS_ID='2' AND T_TRAVEL_STATUS.TRAVEL_TYPE='D' AND T_TRAVEL_DETAIL_DOM.STATUS_ID='10'  AND	(T_TRAVEL_DETAIL_DOM.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_DOM.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) and  T_TRAVEL_DETAIL_DOM.TRAVEL_DATE "+strFilterSign+" (getdate()-1) AND CAST(FLOOR(CAST(T_TRAVEL_DETAIL_DOM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' ";
				  }
				  //System.out.print("4"+strSql);
			      
				}
			  }
			  
	  }
	else
	 {
				  if(strCheck.equals("1")) 
				  {                   
				    if(strTravelType.equals("I"))
					{           
				    	//System.out.println(" default All int");     
					   
				      
					  if (strFilterSign.equals("="))
						  {
						    strSql="SELECT DISTINCT T_TRAVEL_DETAIL_INT.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_INT.TRAVEL_ID,T_TRAVEL_DETAIL_INT.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_INT.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_INT.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_INT.TRAVEL_DATE),'') AS TRAVEL_DATE,T_TRAVEL_DETAIL_INT.GROUP_TRAVEL_FLAG,ISNULL(T_TRAVEL_DETAIL_INT.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_INT.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID  AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_INT.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_INT.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE TRAVEL_STATUS_ID='1' AND T_TRAVEL_STATUS.TRAVEL_TYPE='I' AND T_TRAVEL_DETAIL_INT.STATUS_ID='10'  AND	(T_TRAVEL_DETAIL_INT.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_INT.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) AND T_TRAVEL_DETAIL_INT.SITE_ID='"+strUnitHidden+"' ";
					      }
					  else{ 
					  		strSql="SELECT DISTINCT T_TRAVEL_DETAIL_INT.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_INT.TRAVEL_ID,T_TRAVEL_DETAIL_INT.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_INT.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_INT.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_INT.TRAVEL_DATE),'') AS TRAVEL_DATE,T_TRAVEL_DETAIL_INT.GROUP_TRAVEL_FLAG,ISNULL(T_TRAVEL_DETAIL_INT.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_INT.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_INT.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_INT.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE dbo.TRAVEL_FINAL_APPROVAL_STATUS(T_TRAVEL_DETAIL_INT.TRAVEL_ID,'I',T_TRAVEL_DETAIL_INT.TRAVELLER_ID)='NOT APPROVED BY ALL'AND TRAVEL_STATUS_ID='2' AND T_TRAVEL_STATUS.TRAVEL_TYPE='I' AND T_TRAVEL_DETAIL_INT.STATUS_ID='10'  AND (T_TRAVEL_DETAIL_INT.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_INT.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) and T_TRAVEL_DETAIL_INT.TRAVEL_DATE "+strFilterSign+" (getdate()-1) AND T_TRAVEL_DETAIL_INT.SITE_ID='"+strUnitHidden+"' ";
					      }
					   
					}
					else
					{              
						//System.out.println(" default All dom"); 
					    if (strFilterSign.equals("="))
						  {
						  strSql="SELECT DISTINCT T_TRAVEL_DETAIL_DOM.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_DOM.TRAVEL_ID,T_TRAVEL_DETAIL_DOM.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_DOM.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_DOM.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_DOM.TRAVEL_DATE),'') AS TRAVEL_DATE ,T_TRAVEL_DETAIL_DOM.GROUP_TRAVEL_FLAG,T_TRAVEL_DETAIL_DOM.REASON_FOR_TRAVEL,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_DOM.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_DOM INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_DOM.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_DOM.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE TRAVEL_STATUS_ID='1' AND T_TRAVEL_STATUS.TRAVEL_TYPE='D' AND T_TRAVEL_DETAIL_DOM.STATUS_ID='10'  AND	(T_TRAVEL_DETAIL_DOM.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_DOM.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN'))  AND T_TRAVEL_DETAIL_DOM.SITE_ID='"+strUnitHidden+"' ";
					      }
					    else
					    { 
					  		strSql="SELECT DISTINCT T_TRAVEL_DETAIL_DOM.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_DOM.TRAVEL_ID,T_TRAVEL_DETAIL_DOM.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_DOM.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_DOM.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_DOM.TRAVEL_DATE),'') AS TRAVEL_DATE ,T_TRAVEL_DETAIL_DOM.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_DOM.SITE_ID) as travel_agency_id,T_TRAVEL_DETAIL_DOM.REASON_FOR_TRAVEL FROM T_TRAVEL_DETAIL_DOM INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID  INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_DOM.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_DOM.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE dbo.TRAVEL_FINAL_APPROVAL_STATUS(T_TRAVEL_DETAIL_DOM.TRAVEL_ID,'D',T_TRAVEL_DETAIL_DOM.TRAVELLER_ID)='NOT APPROVED BY ALL'AND TRAVEL_STATUS_ID='2' AND T_TRAVEL_STATUS.TRAVEL_TYPE='D' AND T_TRAVEL_DETAIL_DOM.STATUS_ID='10'  AND	(T_TRAVEL_DETAIL_DOM.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_DOM.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) and T_TRAVEL_DETAIL_DOM.TRAVEL_DATE "+strFilterSign+" (getdate()-1) AND T_TRAVEL_DETAIL_DOM.SITE_ID='"+strUnitHidden+"' ";
					      } 
					}
				  }
				  else
				  {
				    if(strTravelType.equals("I"))
					{       
				    	//System.out.println(" default selected int");     
				      if (strFilterSign.equals("="))
						{
						  strSql="SET DATEFORMAT DMY SELECT DISTINCT T_TRAVEL_DETAIL_INT.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_INT.TRAVEL_ID,T_TRAVEL_DETAIL_INT.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_INT.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_INT.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_INT.TRAVEL_DATE),'') AS TRAVEL_DATE,T_TRAVEL_DETAIL_INT.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_INT.SITE_ID) as travel_agency_id,T_TRAVEL_DETAIL_INT.REASON_FOR_TRAVEL FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_INT.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_INT.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE TRAVEL_STATUS_ID='1' AND T_TRAVEL_STATUS.TRAVEL_TYPE='I' AND T_TRAVEL_DETAIL_INT.STATUS_ID='10'  AND CAST(FLOOR(CAST(T_TRAVEL_DETAIL_INT.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"'  AND	(T_TRAVEL_DETAIL_INT.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_INT.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) AND T_TRAVEL_DETAIL_INT.SITE_ID='"+strUnitHidden+"' "; 
					  }
					  else{  
					  strSql="SET DATEFORMAT DMY SELECT DISTINCT T_TRAVEL_DETAIL_INT.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_INT.TRAVEL_ID,T_TRAVEL_DETAIL_INT.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_INT.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_INT.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_INT.TRAVEL_DATE),'') AS TRAVEL_DATE,T_TRAVEL_DETAIL_INT.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_INT.SITE_ID) as travel_agency_id,T_TRAVEL_DETAIL_INT.REASON_FOR_TRAVEL FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_INT.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_INT.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE dbo.TRAVEL_FINAL_APPROVAL_STATUS(T_TRAVEL_DETAIL_INT.TRAVEL_ID,'I',T_TRAVEL_DETAIL_INT.TRAVELLER_ID)='NOT APPROVED BY ALL'AND TRAVEL_STATUS_ID='2' AND T_TRAVEL_STATUS.TRAVEL_TYPE='I' AND T_TRAVEL_DETAIL_INT.STATUS_ID='10' and T_TRAVEL_DETAIL_INT.TRAVEL_DATE "+strFilterSign+" (getdate()-1) AND CAST(FLOOR(CAST(T_TRAVEL_DETAIL_INT.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"'  AND	(T_TRAVEL_DETAIL_INT.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_INT.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) AND T_TRAVEL_DETAIL_INT.SITE_ID='"+strUnitHidden+"' ";
					  }
					  //System.out.print("7"+strSql); 
					}
					else
					{           
						//System.out.println(" default selected dom");  
					if (strFilterSign.equals("="))
						{
						strSql="SET DATEFORMAT DMY SELECT DISTINCT T_TRAVEL_DETAIL_DOM.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_DOM.TRAVEL_ID,T_TRAVEL_DETAIL_DOM.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_DOM.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_DOM.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_DOM.TRAVEL_DATE),'') as TRAVEL_DATE ,T_TRAVEL_DETAIL_DOM.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_DOM.SITE_ID) as travel_agency_id,T_TRAVEL_DETAIL_DOM.REASON_FOR_TRAVEL FROM T_TRAVEL_DETAIL_DOM INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_DOM.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_DOM.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE TRAVEL_STATUS_ID='1' AND T_TRAVEL_STATUS.TRAVEL_TYPE='D' AND T_TRAVEL_DETAIL_DOM.STATUS_ID='10'  AND	(T_TRAVEL_DETAIL_DOM.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_DOM.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN'))  AND CAST(FLOOR(CAST(T_TRAVEL_DETAIL_DOM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"'  AND T_TRAVEL_DETAIL_DOM.SITE_ID='"+strUnitHidden+"'";
					  }
					  else{
				 	  strSql="SET DATEFORMAT DMY SELECT DISTINCT T_TRAVEL_DETAIL_DOM.TRAVEL_REQ_ID,T_TRAVEL_DETAIL_DOM.TRAVEL_ID,T_TRAVEL_DETAIL_DOM.TRAVELLER_ID,TRAVEL_REQ_NO,T_TRAVEL_DETAIL_DOM.SITE_ID,dbo.SITENAME(T_TRAVEL_DETAIL_DOM.SITE_ID)AS SITE,ISNULL(dbo.CONVERTDATEDMY1(T_TRAVEL_DETAIL_DOM.TRAVEL_DATE),'') as TRAVEL_DATE ,T_TRAVEL_DETAIL_DOM.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_DOM.SITE_ID) as travel_agency_id,T_TRAVEL_DETAIL_DOM.REASON_FOR_TRAVEL FROM T_TRAVEL_DETAIL_DOM INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID INNER JOIN T_APPROVERS ON  T_APPROVERS.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND T_APPROVERS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE INNER JOIN	 VW_AUTH_REPORT_SITE_ACCESS AUS ON  T_TRAVEL_DETAIL_DOM.SITE_ID = CASE WHEN (AUS.ROLE_ID IN ('AD', 'CORP','SM', 'CHAIRMAN') OR AUS.APPROVER_LEVEL=3) AND AUS.USERID="+Suser_id+" THEN T_TRAVEL_DETAIL_DOM.SITE_ID ELSE AUS.SITE_ID END AND AUS.USERID="+Suser_id+" WHERE dbo.TRAVEL_FINAL_APPROVAL_STATUS(T_TRAVEL_DETAIL_DOM.TRAVEL_ID,'D',T_TRAVEL_DETAIL_DOM.TRAVELLER_ID)='NOT APPROVED BY ALL'AND TRAVEL_STATUS_ID='2' AND T_TRAVEL_STATUS.TRAVEL_TYPE='D' AND T_TRAVEL_DETAIL_DOM.STATUS_ID='10'  AND	(T_TRAVEL_DETAIL_DOM.C_USERID='"+Suser_id+"'  OR T_TRAVEL_DETAIL_DOM.TRAVELLER_ID='"+Suser_id+"'  OR T_APPROVERS.APPROVER_ID='"+Suser_id+"' OR T_APPROVERS.ORIGINAL_APPROVER='"+Suser_id+"' OR AUS.ROLE_ID IN ('AD', 'LA', 'CORP','SM', 'CHAIRMAN')) and T_TRAVEL_DETAIL_DOM.TRAVEL_DATE "+strFilterSign+" (getdate()-1)  AND CAST(FLOOR(CAST(T_TRAVEL_DETAIL_DOM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"'  AND T_TRAVEL_DETAIL_DOM.SITE_ID='"+strUnitHidden+"'";
					  }
					  //System.out.print("8"+strSql);
					}
				  }
	  }
	rs = dbConBean.executeQuery(strSql);
	while(rs.next())
	{	reportDataFlag 	= true;
	
	  String strSendDate        ="";
	  flag=1;
	  strTravelReqId		    =	rs.getString(1);
	  strTravelId		        =	rs.getString(2);
	  strTravellerId			=	rs.getString(3);
	  strRequisitionNo			=	rs.getString(4);
	  strSiteId					=	rs.getString(5);
	  strSiteName				=	rs.getString(6);
	  strtraveldate				=	rs.getString(7);///added  by shiv on 16-May-07 for extracting departure date 
	  
	    //Showing group travel for internatinal /domestice  Travel  
		//if(strTravelType.equals("I"))
			   {
			    //  Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on  21-Feb-08 ;  
	                 strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
	                 strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
					     if(strGroupTravelFlag==null) 
							{
						     strGroupTravelFlag="N";
				 		     }
	             //============================close   
		}
	
	  if (iCls%2 == 0) { 
		strStyleCls="formtr1";
	  } else { 
		strStyleCls="formtr2";
	  } 
	  iCls++;
	/*
	  if(strTravelType.equals("D"))
	  {
	    strFileName	=	"T_TravelRequisitionDetails_D.jsp";
		strSql="Select isnull(Firstname,''),isnull(lastname,'')  from M_USERINFO WHERE userid='"+strTravellerId+"'"; 
								  	rs1 = dbConBean1.executeQuery(strSql);
									while(rs1.next())
										{
											strTravelName= rs1.getString(1) +" "+rs1.getString(2);
										}
										rs1.close();
	  }
	  */
	strJustification = rs.getString("REASON_FOR_TRAVEL");
	%>
	
						  
			<!-- added new code on 16-May-07 by shiv for finding travaller Name for showing in reports  open -->
		       <% // strSql="Select isnull(Firstname,''),isnull(lastname,'')  from M_USERINFO WHERE userid='"+strTravellerId+"' and status_id=30"; 
			         // added a code for showing group travel    in case of group travel requsition 
	                       if (strTravelType.equals("I"))
							{
	                 		 	if((strGroupTravelFlag.trim().equalsIgnoreCase("Y")) )   
	                     		 {		
	                     	 		 strTravelName="Group/Guest Travel";  
									 strFileName ="Group_T_TravelRequisitionDetails.jsp";
									 if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
		  									strFileName = "Group_T_TravelRequisitionDetails_GmbH.jsp";
		  									strTravelName="Guest Travel";  
		  								}
	                        	 }
								else 
								{	
			         		       strSql="Select isnull(Firstname,''),isnull(lastname,'')  from M_USERINFO WHERE userid='"+strTravellerId+"'"; 
								  	rs1 = dbConBean1.executeQuery(strSql);
									while(rs1.next())
										{
											strTravelName= rs1.getString(1) +" "+rs1.getString(2);
										}
										rs1.close();
	  								   strFileName ="T_TravelRequisitionDetails.jsp";
	  								 if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
		  									strFileName = "T_TravelRequisitionDetails_INT_GmbH.jsp";
		  								}
	                            }
							}	 
							else // added for showing group traval in case of  group travel_dom  on 18-Jun-08
		                        {
								if((strGroupTravelFlag.trim().equalsIgnoreCase("Y")) )   
	                     		 {		
	                     	 		 strTravelName="Group/Guest Travel";  
									 strFileName ="Group_T_TravelRequisitionDetails_D.jsp";
									 if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
		  									strFileName = "Group_T_TravelRequisitionDetails_GmbH.jsp";
		  									strTravelName="Guest Travel";  
		  								}
	                        	 }
								else 
								{	
			         		       strSql="Select isnull(Firstname,''),isnull(lastname,'')  from M_USERINFO WHERE userid='"+strTravellerId+"'"; 
								  	rs1 = dbConBean1.executeQuery(strSql);
									while(rs1.next())
										{
											strTravelName= rs1.getString(1) +" "+rs1.getString(2);
										}
										rs1.close();
	  								   strFileName ="T_TravelRequisitionDetails_D.jsp";
	  								 if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
	  									strFileName = "T_TravelRequisitionDetails_INT_GmbH.jsp";
	  								}
	                            }
							}
	                     /////============================ 
	
						 /// FINDING THE LAST SEND DATE FOR SENDING REMINDER FOR EXPIRED REQUSITION  
						 
						if (strFilterSign.equals("<"))
						{	 
	
		               		strSql="SELECT ISNULL((MAIL_SEND_DATE),'-') FROM   VW_Req_mailBox WHERE   (REQ_NUMBER ='"+strRequisitionNo.trim()+"') AND (RTRIM(MAIL_SUBJECT)  like '%has been Expired%') AND MAIL_ID=(SELECT MAX(MAIL_ID)FROM VW_Req_mailBox WHERE  (REQ_NUMBER = '"+strRequisitionNo.trim()+"') AND (RTRIM(MAIL_SUBJECT)  like '%has been Expired%')) ORDER BY MAIL_ID";
		 		            rsnew = dbConBean1.executeQuery(strSql);
		                  	if(rsnew.next())
		                        {
		                  	  strSendDate=rsnew.getString(1); 
		                     }
		  			           rsnew.close();
		  			         
						}
	           		 
	 %>
	
	
	
	
	  <tr align="center" class="<%=strStyleCls%>" valign="top">
	    <td class="frmfielsDIS">&nbsp; &nbsp;  <%=intSerialNo++%></td>
		
	
	
	<%	if(SuserRole.equals("AD"))
	{
	   %>
	<td class="frmfielsDIS" align="center">
<a href="javascript:MM_openBrWindow('T_Travel_Requisition_Cancel_new.jsp?purchaseRequisitionId=<%=strTravelId%>&<%=finalUrl%>&whichPage=RequisitionMovementReport_Post.jsp&targetFrame=yes','CANCEL','scrollbars=yes,resizable=no,width=900,height=260');" class="reportLink"><%=dbLabelBean.getLabel("link.approverequest.cancel",strsesLanguage) %></a> |
<a href="javascript:MM_openBrWindow('T_Travel_Requisition_Hold_new.jsp?purchaseRequisitionId=<%=strTravelId%>&<%=finalUrl%>&whichPage=RequisitionMovementReport_Post.jsp&targetFrame=yes','CANCEL','scrollbars=yes,resizable=no,width=765,height=275');" class="reportLink"><%=dbLabelBean.getLabel("link.approverequest.hold",strsesLanguage) %></a>     
	 </td>
	<%} %>
	
	
	
	    <td class="frmfielsDIS">
	      <a href="javascript:MM_openBrWindow('<%=strFileName%>?purchaseRequisitionId=<%=strTravelId%>&err=0&traveller_Id=<%=strTravellerId%>&travelType=<%=strTravelType %>','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550');" class="reportLink" title="<%=strJustification%>"><%=strRequisitionNo%></a>
		  <FONT SIZE="1" COLOR="red"> </FONT>  
	    </td>
	      <!-- @Gaurav on 06-Jun-2007 Under a requisition movement report ignoring a check of status id so that originator name can be visible even he is deactivated -->
		
	
			 <td class="frmfielsDIS">
			 <!--Added by Manoj Chand on 06 Jan 2012-  introduced hyperlink to show travellers for group travel request. -->
				<%
				if(strTravelName.equalsIgnoreCase("Group/Guest Travel") || strTravelName.equalsIgnoreCase("Guest Travel")){
				%>
				<a href="javascript:showTravellerName('<%=strTravelType.trim() %>',<%=strTravelId%>, '<%=strRequisitionNo.replaceAll("/","~")%>');" class="reportLink"><%=strTravelName%></a>	
				<%
				}else
					out.print(strTravelName);
			 
			 %>
			 
			  </td> 
			 <td class="frmfielsDIS"  align="center"> <%=strtraveldate%></td>   
			  <!-- added new code on 16-May-07 by shiv for finding travaller Name for showing in reports  close   -->
				  
	     
	<%
		strSql="SELECT dbo.USER_NAME(APPROVER_ID) as APPROVER_NAME ,ORDER_ID,APPROVE_STATUS FROM T_APPROVERS WHERE TRAVEL_ID ='"+strTravelId+"'AND TRAVELLER_ID ='"+strTravellerId+"' AND TRAVEL_TYPE='"+strTravelType+"' AND STATUS_ID='10' ORDER BY ORDER_ID ";
			
		rs1 = dbConBean1.executeQuery(strSql);
		while(rs1.next())
		{
			count++;
			strApproverName=rs1.getString(1);
			intApproveStatus=rs1.getInt(3);
	%>
	       <td class="frmfielsDIS"><%=strApproverName%><br>
	<%
		   if(intApproveStatus==10)
		   {
	%>
			   <img src="images/tick2.gif?buildstamp=2_0_0" alt="<%=dbLabelBean.getLabel("label.reports.approved",strsesLanguage)%>"></td>
	<%
		   }
	  	   else
		   {
			   if(flag==1)
			   {
				  strImage="mark";
				  flag=0;
				}
				else
				{
				  strImage="cross";
				}
	%>
				<img src="images/<%=strImage%>.gif?buildstamp=2_0_0" alt="<%=dbLabelBean.getLabel("label.search.pending",strsesLanguage)%>"></td>
	<%
			}
	
		}   // end of inner while loop
		for(int i=count;i<12;i++)
		{
	%>
		  <td>&nbsp;</td>
		
	<%
		}
		count=0;
	%>
	 
		
		<%
		// Add a code for showing mail send button for Expired requsions on  8/25/2008 by shiv sharma 
		  if(strFilterSign.equals("<") && SuserRole.equals("AD"))
		  {
			  if(!strSendDate.equals("-") && !strSendDate.equals(""))
			  {
	    	  %>
		      <td class="frmfielsDIS" align="center"  bgcolor="#CCFFCC"><%=strSendDate%></td>
			  <%}else
			   {
			  %>
			  <td class="frmfielsDIS" size="8%" align="center"><%=strSendDate%></td>
			  <%
	
			   }
				  %>
		 <td class="colorPink" >
		 <input class="<%=strStyleCls%>" type=checkbox name="chk<%=intSerialNo%>" value="<%=strTravelId%>;<%=strTravellerId%>"></td>
		 <%
		  }
	    %>
	    </tr>
	 
	<%
	} // end of outer while loop	
	rs.close();
	dbConBean.close();
	dbConBean1.close();
	
	if(!reportDataFlag) {
%>		<tr class="formtr1">
			<td colspan="17" style="text-align: center;font-weight: bold;color:red;">
				<%=dbLabelBean.getLabel("label.global.norecordfound",strsesLanguage)%>
			</td>							
		</tr>
<% 	} 	
	// Add a code for showing mail send button for Expired requsions on  8/25/2008 by shiv sharma 
	if(strFilterSign.equals("<") && SuserRole.equals("AD")) {
	%>
	  <tr align="center" class="formbottom">
	     <td colspan="19" class="rep-txt">
	
		 <input type="button" name="CheckAll" value="<%=dbLabelBean.getLabel("button.approverequest.checkall",strsesLanguage) %>" onClick="checkAll(document.frm)" class="formButton" >
	  	 <input type="button" name="UnCheckAll" value="<%=dbLabelBean.getLabel("button.approverequest.uncheckall",strsesLanguage) %>" onClick="uncheckAll(document.frm)" class="formButton" >
		 <input type="Submit" value="<%=dbLabelBean.getLabel("label.report.sendmail",strsesLanguage) %>" class="formButton"  >
	
		 </td>
	  </tr>
	<%
	}
		  %>
	
	  <tr align="center" class="formbottom">
	     <td colspan="19" class="rep-txt">
	       <blink>
	       <img src="images/mark.gif?buildstamp=2_0_0" alt="<%=dbLabelBean.getLabel("label.search.pending",strsesLanguage)%>" ></blink> <%=dbLabelBean.getLabel("label.report.denotespresentstatuspresentapprover",strsesLanguage) %> 
		 </td>
	  </tr>
	</table>
	<input type=hidden name=count value="<%=intSerialNo-1%>">
	
	<input type=hidden name=strCheck_forMail value="<%=strCheck%>">
	<input type=hidden name=strTravelType_forMail value="<%=strTravelType%>">
	<input type=hidden name=strFrom_forMail value="<%=strFrom%>">
	<input type=hidden name=strTo_forMail value="<%=strTo%>">
	<input type=hidden name=strUnitHidden_forMail value="<%=strUnitHidden%>">
	<input type=hidden name=strReq_startus_forMail value="<%=strReq_startus%>">
	 <input type=hidden name="final_url" value="<%=finalUrl%>">
	 
	 
	<script language="javaScript">
	 closeDivRequest();
	</script>
	
	</body> 
	</form>
	
	</html>
	     