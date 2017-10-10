	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				        :Shiv Sharma 
	 *Date of Creation 		:26-Jun-08
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			        :STARS
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			    :This is the jsp file  for show the Domestiic Group Travel Requisition Details for MATA role
	 *Modification 		        :new code for showing unit head  name for mata page only on  2 jan 2009
	                            :Making approver comment bold  if he change the comment on 03-04-2009 by shiv sharma  
	 *Editor					:Editplus
	 
	 *Modified by			:Manoj Chand
	 *Date of Modification	:01 Feb 2013
	 *Modification			:showing requested value in comma separated way if multiple currency exist in the request.
	 *******************************************************/
	%>
	<%@ page pageEncoding="UTF-8" %>
	<%@ include  file="importStatement.jsp" %>
	<html>
	<head>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include page styles  --%>
	<%-- <%@ include  file="systemStyle.jsp" %> --%>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="JavaScript1.2" src="scripts/div.js?buildstamp=2_0_0"></script>
	<jsp:useBean id="dbmethod" scope="page" class="src.connection.DbUtilityMethods" />
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<style>
	.linkedReq {
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:10px;
	font-weight:bold;
	color:#d62234;
	}
	</style>
	<script type="text/javascript">
	function openModificationDetails(travelId,flagValue,travelType)
	{
	  //alert("travel id is==========="+travelId);
	  var mainLocation = 'T_Travel_Version_Details_INT.jsp?travelId='+travelId+'&flag='+flagValue;
	  if(travelId != null && travelId!='')
	  {
		  window.open(mainLocation,'Version','scrollbars=yes,resizable=yes,width=775,height=550');
	  }
	}
	</script>
	
	<style type="text/css">
	<!--
	.style2 {font-size: 10px; font-weight: bold; color: #FF7D00;}
	-->
	</style>
	<%
	//Global Variables declared and initialized
	String strSql                   =  null;              
	ResultSet rs,rs1,rs2            =  null;   
	// variables from userinfo table start
	String strUsername				="";
	String strPassportNo			="";
	String strDateIssue				="";
	String strPlaceIssue			="";
	String strExpiryDate			=""; 
	String strAddress				="";
	String strContactNo				="";
	String strCurrentAddress	=	"";
	String strDateofBirth			="";
	String strCompanyName			="";
	String strEcnr					="";
	String strDesignationName		="";
	String strTotal_Currency		="";
	String strSiteId                =  "";
	String strSiteName              =  "";
	String strUserId                =  "";
	String strDivId                 =  "";
	String strDeptId                =  "";
	String strDesigName             =  "";
	String strAge                   =  "";
	String strAge1                  =  "";                 
	String strSex                   =  "";
	String strMessage               =  "";
	String strUserNameId            =  "";  
	String strSiteNameId            =  "";
	String strDesigNameId           =  "";   
	String strMealId                =  ""; 
	String strDepCity               =  "";                              
	String strDepDate               =  "";                              
	String strArrCity               =  "";
	String strCurrency			="";
	String strRetrunDepCity			=  "";
	String strRetrunArrCity			=  "";
	String strReturnDate            =  "";                                 
	String strNameOfAirline1        =  "";
	String strNameOfAirline2        =  "";
	String strInsuranceRequired     =  "";
	String strNominee               =  ""; 
	String strRelation              =  ""; 
	String strInsuranceComment      =  "";
	String strHotelRequired         =  "";
	String strBudgetCurrency        =  "";
	String strHotelBudget           =  "";
	String strRemarks               =  "";
	String strCheckInDate           =  "";
	String strCheckOutDate          =  "";
	String strPlace                 =  "";
	String strTravelMode1           =  "";
	String strTravelMode2           =  "";
	String strTravelClass1          =  "";
	String strTravelClass2          =  "";
	String strManager               =  ""; 
	String strHod                   =  ""; 
	String strSelectManagerRadio    =  ""; 
	String strPreferTime1           =  "";
	String strPreferTime2           =  "";
	String strTravelReqId           =  "";
	String strTravelId				=  "";
	String strTravelReqNo           =  "";  
	String strJTravelDate			="";
	String strELIGIBILITY			=""; // for journey
	String strELIGIBILITY2			=""; // for return journey
	
	
	// start Variable Declaration for Forex Details
	String strTotal_Amount = "";
	String strBilling_Client="";
	
	String strCashAmount            =  "";
	String strCashCurrency          =  "";
	Vector vecCash                  =  new Vector(); 
	Vector vecTC                    =  new Vector(); 
	
	String strCashBreakUpRemark     =  "";
	String strCancelledReqId	=  "0";
	
	//for domestice group travel 
	String strIdentityProofName ="";
	String  strIdentityProof			 ="";
	strTravelId = request.getParameter("purchaseRequisitionId"); //getting travel id from the previous page
	String strTravellerId  =   request.getParameter("traveller_Id");
	
	//CODE STARTS
	
	String strCARD_TYPE  ="";
	
	//23022007
	String strCARD_HOLDER_NAME ="";
	String strReasonForTravel = "";
	//23022007
	String strCARD_NUMBER1 ="";
	String strCARD_NUMBER2 ="";
	String strCARD_NUMBER3 ="";
	String strCARD_NUMBER4 ="";
	String strCVV_NUMBER ="";
	String strCARD_EXP_DATE ="";
	String strCreditCardNumber="";
	String strApproverRole="";
	String strOriginatorName="";
	
	String strCUserId = "";
	
	String strReasonForSkip  = "";
	String strEmpcode="";
	String strBilling_site=""; ///added new  on 02-Nov-07 by shiv Sharma 
	String strEmail="";
	String strTicketRefund="";
	
	//CODE ENDS
	
	//strSql = "SELECT   TRAVEL_REQ_NO, ISNULL(TRAVEL_REQ_ID, '-') AS TRAVEL_REQ_ID, ISNULL(RTRIM(.DBO.USER_NAME(C_USERID)), 'NA') AS ORIGINATED_BY, ISNULL(dbo.SITENAME_FROM_USERID(C_USERID), '-') AS UNIT, ISNULL(TRAVELLER_ID, '-') AS TRAVELLER_ID, ISNULL(SEX, '-')   AS SEX,  MANAGER_ID, HOD_ID, ISNULL(CONVERT(decimal(20, 0), TOTAL_AMOUNT), '0') AS TOTAL_AMOUNT, ISNULL(TA_CURRENCY, '-') AS TA_CURRENCY, BILLING_SITE, BILLING_CLIENT,  ISNULL(.DBO.TRAVEL_MODE(TRAVEL_ID, 'D'), '-') AS TRAVEL_MODE, ISNULL(REASON_FOR_SKIP, '-') AS REASON_FOR_SKIP,   ISNULL(REASON_FOR_TRAVEL, '') AS REASON_FOR_TRAVEL,C_USERID  FROM   T_TRAVEL_DETAIL_DOM  WHERE TRAVEL_ID="+strTravelId+" AND APPLICATION_ID=1 AND STATUS_ID=10";
	//change by manoj chand on 01 feb 2013 to get expenditure details in multiple currency if taken.
	strSql = "SELECT   TRAVEL_REQ_NO, ISNULL(T_TRAVEL_DETAIL_DOM.TRAVEL_REQ_ID, '-') AS TRAVEL_REQ_ID, ISNULL(RTRIM(.DBO.USER_NAME(C_USERID)), 'NA') AS ORIGINATED_BY, ISNULL(dbo.SITENAME_FROM_USERID(C_USERID), '-') AS UNIT, ISNULL(TRAVELLER_ID, '-') AS TRAVELLER_ID, ISNULL(SEX, '-')   AS SEX,  MANAGER_ID, HOD_ID, dbo.FN_GET_EXPENDITURE('"+strTravelId+"','D') AS Expenditure, BILLING_SITE, BILLING_CLIENT,  ISNULL(.DBO.TRAVEL_MODE(T_TRAVEL_DETAIL_DOM.TRAVEL_ID, 'D'), '-') AS TRAVEL_MODE, ISNULL(REASON_FOR_SKIP, '-') AS REASON_FOR_SKIP,   ISNULL(REASON_FOR_TRAVEL, '') AS REASON_FOR_TRAVEL,C_USERID, T_TRAVEL_STATUS.LINKED_TRAVEL_ID  FROM   T_TRAVEL_DETAIL_DOM  INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_STATUS.TRAVEL_ID=T_TRAVEL_DETAIL_DOM.TRAVEL_ID AND T_TRAVEL_STATUS.TRAVEL_TYPE='D' WHERE T_TRAVEL_DETAIL_DOM.TRAVEL_ID="+strTravelId+" AND T_TRAVEL_DETAIL_DOM.APPLICATION_ID=1 AND T_TRAVEL_DETAIL_DOM.STATUS_ID=10";
	
	rs       =   dbConBean.executeQuery(strSql);  
	if(rs.next())
	{   
		 
		    strTravelReqNo       = rs.getString("TRAVEL_REQ_NO"); 
	        strTravelReqId       = rs.getString("TRAVEL_REQ_ID");
			strOriginatorName    = rs.getString("ORIGINATED_BY");
			strSiteName            = rs.getString("UNIT");
			strUserId            = rs.getString("TRAVELLER_ID");
			strSex               = rs.getString("SEX");
	     	if(strSex.equals("1")){
			strSex="Male";
			}
			else	{
			strSex="Female";
			}
	 		strManager		= rs.getString("MANAGER_ID");
			strHod			= rs.getString("HOD_ID");
			strTotal_Amount = rs.getString("Expenditure");
			//strTotal_Currency = rs.getString("TA_CURRENCY");
			/*if(strTotal_Amount != null && strTotal_Amount.equals("0"))	{
				strTotal_Amount   = "-";
	            strTotal_Currency = ""; 
			}*/
			strBilling_site=rs.getString("BILLING_SITE");
			strBilling_Client=rs.getString("BILLING_CLIENT");
			strReasonForSkip     = rs.getString("REASON_FOR_SKIP");
			strReasonForTravel  = rs.getString("REASON_FOR_TRAVEL");
			strCUserId                 = rs.getString("C_USERID"); 
			strCancelledReqId = rs.getString("LINKED_TRAVEL_ID");
	}
	rs.close();
	
	if (strBilling_site!=null && !strBilling_site.equals("0") && !strBilling_site.equals(strTravelId) && !strBilling_site.equals("-1"))  
	///normal case  when user site is biling site  
	{
			if(strBilling_Client ==null){
				strBilling_Client ="--";
	  		  }
		     else{  //Query changed  on 20-May-08 by shiv  for showing billing Site
						int intBilling_Client =Integer.parseInt(strBilling_Client);   //changes on 20-May-08 by shiv sharma 
				        strSql = "select site_name from m_site where site_id=(select billing_site from t_travel_detail_DOM where TRAVEL_ID="+strTravelId+")";
	  			         rs       =   dbConBean.executeQuery(strSql);  
			 	        while(rs.next())  {
	                  				strBilling_Client = rs.getString("site_name");
				          }
				        rs.close();
			  }
	}
	//code added
	//Code starts  if strBilling client is null,means the site is paying for it 
	//code changed for showing billing site on 02-Nov-07 by shiv  
	
	if((strBilling_Client==null) || (strBilling_Client.equals("")) || strBilling_Client.equals("-") || strBilling_Client.equals("-1"))
	{
		strSql = "select site_name from m_site where site_id=(select billing_site from t_travel_detail_DOM where TRAVEL_ID="+strTravelId+")";
		rs       =   dbConBean.executeQuery(strSql);  
		while(rs.next())
		{
			strBilling_Client = rs.getString("site_name");
		}
		rs.close();
	}
	
	if(strBilling_Client == null){
	    strBilling_Client  =  "-";
	}
	 //Code ends if strBilling client is null,means the site is paying for it 
	
	//getting value from m_userinfo closed
	 
	strSql = "select ISNULL(dbo.user_name(USERID), '-') AS USERNAME, ISNULL(CONTACT_NUMBER, '-') AS Mobile_NO, ISNULL(dbo.CONVERTDATEDMY1(DOB), '-')   AS DOB, ISNULL(dbo.SITENAME(SITE_ID), '-') AS COMPANYNAME, ISNULL(dbo.DESIG_FROM_USERID(USERID), '-') AS DESIGNAME,   ISNULL(EMP_CODE, '') AS EMP_CODE, EMAIL from m_userinfo  where userid ='"+strUserId+"'";  // on the basis of traveller id 
	
	rs       =   dbConBean.executeQuery(strSql);  
	if(rs.next())
	{
	strUsername = rs.getString("USERNAME");
	// code startto convert first and last letter in uppercase
	int s = strUsername.indexOf(" ",0);
	String FirstLetter = strUsername.substring(0,1).toUpperCase() + strUsername.substring(1,s);
	String LastLetter = strUsername.substring(s+1,s+2).toUpperCase() +strUsername.substring(s+2,strUsername.length()) ;
	strUsername = FirstLetter+" "+LastLetter;
	// code ends to convert first and last letter in uppercase
	
	 strContactNo = rs.getString("Mobile_NO");
	 strDateofBirth = rs.getString("DOB");
	 strCompanyName = rs.getString("COMPANYNAME");
	 strDesignationName = rs.getString("DESIGNAME");
	 strEmpcode= rs.getString("EMP_CODE"); //Adding employee code  3/1/2007
	 strEmail= rs.getString("EMAIL");
	}
	rs.close();
	
	%>
	
	</head>
	
	<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	  <div align="center">
	  <table width="600" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td height="45" class="bodyline-top">
	        <ul class="pagebullet">
	          <li class="pageHead"><b><%=dbLabelBean.getLabel("label.requestdetails.domesticjourneyreportgroupguest",strsesLanguage) %></b></li>
		    </ul>      </td>
	      <td align="right" valign="bottom" class="bodyline-top">
	<table  align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
       <td>
     <ul id="list-nav">
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
     </ul>
       </td>
      </tr>
    </table>
	</td>
	    </tr>
	  </table>
	  <table width="600" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td align="center">
	        <table width="600" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" class="reporttbl">
	          <tr>
	            <td colspan="11" bgcolor="#000000" class="reportheading2"><%=dbLabelBean.getLabel("label.global.basicinformation",strsesLanguage) %> </td>
		      </tr>
	          <tr>
			    <td width="85" class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.originator",strsesLanguage) %></td>
		        <td width="96" class="reportdata"><%=strOriginatorName.toUpperCase()%> </td>            
		        <td width="69" class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></td>
			    <td width="34" class="reportdata"><%=strSiteName.toUpperCase()%></td>            
	            <td width="56" class="reportLBL"><%=dbLabelBean.getLabel("label.global.mobileno",strsesLanguage) %> </td>
		        <td width="30" class="reportdata"><%=strContactNo%></td>
			    <td width="47" class="reportLBL"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></td>
			  <!--   <td width="26" class="reportdata"> <%//=strSex.toUpperCase()%> </td> -->
				<!-- <td class="reportLBL"> </td> -->
			    <td  colspan="2"  class="reportdata"><%=strDesignationName.toUpperCase()%></td>
		      </tr>
	          <tr>
	           <td class="reportLBL"><%=dbLabelBean.getLabel("label.mylinks.employeecode",strsesLanguage) %></td>
			    <td class="reportdata"><%=strEmpcode%></td> 
			    <td class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.dob",strsesLanguage) %></td>
			    <td class="reportdata"><%=strDateofBirth%></td>
			    <td colspan="1" class="reportLBL" > <%=dbLabelBean.getLabel("label.global.gender",strsesLanguage) %></td>
			    <td class="reportdata"><%=strSex.toUpperCase()%> </td>
			    <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage) %> </td>
			    <td colspan="2" class="reportdata"><%=strTravelReqNo%></td>
		      </tr>
			  <tr><!-- Adding Employee code on 3/1/2007  -->
	            <td colspan="1" class="reportLBL" ><%=dbLabelBean.getLabel("label.global.emailid",strsesLanguage) %></td>
			    <td  colspan="4" class="reportdata"><font size=1><%=strEmail%></font></td>
				<td class="reportLBL"></td>
			    <td class="reportLBL"></td>
				<!-- Code change for showing Email ID of traveller in reports that appear to MATA on 4th jan 2008   -->
			    <td colspan="1" class="reportLBL" ></td>
			    <td  colspan="4" class="reportdata"></td>
			  </tr>
			  <tr>
			      <td colspan="4" class="reportheading2"><%=dbLabelBean.getLabel("label.requestdetails.travelersinformationforwardjourney",strsesLanguage) %></td> 
			      <td colspan="7" class="reportheading2" style="text-align: right; padding-right:5px; font-size: xx-small;">
			        <%if(strCancelledReqId != null && !"0".equals(strCancelledReqId)) { %>
			        	<a href="#" class="linkedReq" onClick="MM_openBrWindow('Group_T_TravelRequisitionDetails_D.jsp?purchaseRequisitionId=<%=strCancelledReqId%>&traveller_Id=<%=strTravellerId%>&travelType=D','LinkedCancelledRequest<%=strCancelledReqId %>','scrollbars=yes,resizable=yes,width=975,height=550')"><%=dbLabelBean.getLabel("label.global.linkedcancelledtravelrequest",strsesLanguage) %></a>
			        <% } else {%>
			             &nbsp;&nbsp;
			        <%} %>
			      </td>
			  </tr>
			  <tr>
			     <td colspan="11" class="reportLBL">
	              <table width="100%" border="0" cellspacing="0" cellpadding="3">
				    <tr>
	                  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.requestdetails.dob",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.mealpreference",strsesLanguage) %></td>				  
					  <td class="reportheading3">&nbsp;</td>
					 </tr>
					
									<%
											 strSql = " select rtrim(first_name)+' '+rtrim(last_name) as Name, dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,ISNULL(dbo.CONVERTDATEDMY1(DOB),'-')AS DOB,case when GENDER='2' then 'FEMALE' else 'MALE'  end  as  GENDER, ISNULL(dbo.MEAL_NAME(MAEL_ID),'-') AS  MEALNAME  from t_group_userinfo where travel_id="+strTravelId+" and status_id=10 and travel_type='D' ";	 
											 
										   int intSNo = 0;
										   rs = dbConBean.executeQuery(strSql);
										  while(rs.next()) 
										  {  
									%>
									                    <tr>
															<td height="0" class="reportdata" ><%= ++intSNo%></td>
															<td height="0" class="reportdata" ><%= rs.getString(1).toUpperCase() %></td>
															<td height="0" class="reportdata" ><%= rs.getString(2).toUpperCase() %></td>
															<td height="0" class="reportdata" ><%= rs.getString(3).toUpperCase() %></td>
															<td height="0" class="reportdata" ><%= rs.getString(4).toUpperCase() %></td>
															<td height="0" class="reportdata" ><%= rs.getString(5).toUpperCase() %></td>
															<td height="0" class="reportdata" ><%//= rs.getString(6).toUpperCase() %></td>						
									                      </tr>
									<%
										  } 
										  rs.close();						
									%>
									
					</table> 
				 </td>	
			   </tr>
			         <!-- 3/1/2007 --> 
	          
	          <tr>
	            <td colspan="11" class="reportheading2"><%=dbLabelBean.getLabel("label.mata.itineraryinformationforwardjourney",strsesLanguage) %> </td> 
	          </tr>
	          <tr>
	            <td colspan="11" class="reportLBL"> 
	              <table width="100%" border="0" cellspacing="0" cellpadding="3">
	                <tr>
	                  <td class="reportheading3"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.mode",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %> </td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage) %> </td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %></td>
					   <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage) %></td> 
				    </tr>
	                <%
						///	query changed  by shiv on 26-Oct-07 for  preferred  time on 26-Oct-07 
						
						     strSql = " SELECT  TRAVEL_FROM, TRAVEL_TO, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE), '-') AS TRAVEL_DATE, ISNULL(RTRIM(LTRIM(dbo.TRAVEL_MODE_NAME(TRAVEL_MODE))), '-') AS TRAVEL_MODE,  ISNULL(RTRIM(LTRIM(dbo.TRAVEL_CLASS_NAME(TRAVEL_MODE, TRAVEL_CLASS))), '-') AS TRAVEL_CLASS,  ISNULL(RTRIM(LTRIM(dbo.PREFER_TIME_DESC(TIMINGS))), '-') AS TIMINGS, ISNULL(MODE_NAME, '-') AS MODE_NAME,isnull(M_SEAT_PREFER.Seat_Name,'')AS  Seat_Name,TICKET_REFUNDABLE  FROM         T_JOURNEY_DETAILS_DOM left outer JOIN  M_SEAT_PREFER ON  T_JOURNEY_DETAILS_DOM.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_JOURNEY_DETAILS_DOM.TRAVEL_ID ="+strTravelId+" AND T_JOURNEY_DETAILS_DOM.STATUS_ID=10 ORDER BY 3";
						
							 String strVisaReq = "";      
						  	 String strVisaCom = ""; 
						  	 rs = dbConBean.executeQuery(strSql);
							 while(rs.next()) 
							 {  
						 %>
						                <tr align="left">
						                  <td class="reportdata" ><%= rs.getString(1).toUpperCase() %></td> 
						                  <td class="reportdata" ><%= rs.getString(2).toUpperCase() %></td>
						                  <td class="reportdata" ><%= rs.getString(3) %></td>
						 				   <td class="reportdata"> <%= rs.getString(4).toUpperCase() %> </td>
										  <td class="reportdata"><%= rs.getString(5).toUpperCase() %></td>
										  <td class="reportdata"> <%= rs.getString(6).toUpperCase() %> </td>
										  <td class="reportdata"> <%= rs.getString(7).toUpperCase() %></td>
						 
						                  <td class="reportdata"> <%=  rs.getString(8).toUpperCase() %>   </td> 
						                  <% strTicketRefund   =rs.getString("TICKET_REFUNDABLE");
						                     if(strTicketRefund.equals("y"))
						                        {
						                    	 strTicketRefund ="Yes";
						                     }else{
						                    	 strTicketRefund ="No";
						                     } 
						                  %>
						                  <td class="reportdata"><%= strTicketRefund %> </td>
									    </tr>
						  <%
							 } 
							 rs.close();						
						
						// SET THE RETURN TRAVEL DETAIL
							
						
					%>
					
					
				
					   
				<tr>
				      <td class="reportheading3"><%=dbLabelBean.getLabel("label.requestdetails.purposeofjourney",strsesLanguage) %> </td> 
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.createrequest.tatkaalrequired",strsesLanguage) %>  </td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.createrequest.couponticketrequired",strsesLanguage) %> </td>
					  <td class="reportheading3">&nbsp;</td>
					  <td class="reportheading3">&nbsp;</td>
					  <td class="reportheading3">&nbsp; </td>
					  <td class="reportheading3">&nbsp; </td>
					  <td class="reportheading3">&nbsp;</td>
					  <td class="reportheading3">&nbsp;</td>
					  
			    </tr>
	
					 <%
					     strSql = " SELECT  REASON_FOR_TRAVEL,  case when FORWARD_TATKAAL='y'  then 'YES'   else 'No'   end, case when FORWARD_COUPAN ='y'  then 'Yes' else 'No'  end  FROM   T_TRAVEL_DETAIL_DOM where TRAVEL_ID ="+strTravelId+"AND STATUS_ID=10";
						 rs = dbConBean.executeQuery(strSql);
						 while(rs.next()) 
						 {  
					 %>
					                <tr align="left"> 
					                  <td class="reportdata" ><%= rs.getString(1).toUpperCase() %></td>
					                  <td class="reportdata" ><%= rs.getString(2).toUpperCase() %></td>
					                  <td class="reportdata" ><%= rs.getString(3) %></td>
					  
									<td class="reportdata"> <%//= rs.getString(4).toUpperCase() %> </td>
									  <td class="reportdata"><%//= rs.getString(5).toUpperCase() %></td>
									  <td class="reportdata"> <%//= rs.getString(6).toUpperCase() %> </td>
									  <td class="reportdata"> <%//= rs.getString(7).toUpperCase() %></td>
					 
					                  <td class="reportdata"> <%//= strVisaRequired.toUpperCase() %> </td>
					                  <td class="reportdata"> <%//= strVisaRequired.toUpperCase() %> </td>
								    </tr>
					  <%
						 } 
						 rs.close();						
					%>
					              </table> 
					              
					   </td>
			   </tr>
			   <!-- -code need to be added -->
			   
			   <%
			     String  strReturndate1="";
			   
			    	strSql = " SELECT  Travel_date  FROM  T_RET_JOURNEY_DETAILS_DOM  WHERE TRAVEL_ID ="+strTravelId+" AND STATUS_ID=10 ";
					  rs = dbConBean.executeQuery(strSql);
					  
					  while(rs.next()){
						  strReturndate1  =rs.getString("Travel_date");
						  
					  }
					  rs.close();
			
			 	   
					  
			 if (!strReturndate1.equals("") && strReturndate1!=null && !strReturndate1.equals("-") && !strReturndate1.equals("1900-01-01 00:00:00.000"))   
				{    		  
		         %>			  	 
			   
			  
			    <tr>
			      <td colspan="11" class="reportheading2"><%=dbLabelBean.getLabel("label.requestdetails.travelersinformationreturnjourney",strsesLanguage) %> </td> 
			  </tr>
			   <tr>
			     <td colspan="11" class="reportLBL">
	              <table width="100%" border="0" cellspacing="0" cellpadding="3">
				    <tr>
	                  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %> </td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.requestdetails.dob",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.mealpreference",strsesLanguage) %></td>				  
					  <td class="reportheading3">&nbsp;</td>
					 </tr>
					
									<% 
											 strSql = " select rtrim(first_name)+' '+rtrim(last_name) as Name, dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID,ISNULL(dbo.CONVERTDATEDMY1(DOB),'-')AS DOB,case when GENDER='2' then 'FEMALE' else 'MALE'  end  as  GENDER, ISNULL(dbo.MEAL_NAME(MAEL_ID),'-') AS  MEALNAME  from t_group_userinfo where Return_travel='y' and travel_id="+strTravelId+" and status_id=10 and travel_type='D' ";	 
											 
										   int intSNo1 = 0; 
										   rs = dbConBean.executeQuery(strSql);
										  while(rs.next()) 
										  {  
									%>
									                    <tr>
															<td height="0" class="reportdata" ><%= ++intSNo1%></td> 
															<td height="0" class="reportdata" ><%= rs.getString(1).toUpperCase() %></td>
															<td height="0" class="reportdata" ><%= rs.getString(2).toUpperCase() %></td>
															<td height="0" class="reportdata" ><%= rs.getString(3).toUpperCase() %></td>
															<td height="0" class="reportdata" ><%= rs.getString(4).toUpperCase() %></td>
															<td height="0" class="reportdata" ><%= rs.getString(5).toUpperCase() %></td>
															<td height="0" class="reportdata" ><%//= rs.getString(6).toUpperCase() %></td>						
									                      </tr>
									<%
										  } 
										  rs.close();	 					
									%>
									
					</table> 
				 </td>	
			   </tr>
			   <%}
			
			   
			   
			   
			   
			   
					  
		   if (!strReturndate1.equals("") && strReturndate1!=null && !strReturndate1.equals("-") &&  !strReturndate1.equals("1900-01-01 00:00:00.000"))        
			  {   
				%>
			   <tr>
	              <td colspan="11" class="reportheading2"><%=dbLabelBean.getLabel("label.mata.itineraryinformationreturnjourney",strsesLanguage) %> </td> 
	           </tr>
	           
	           <tr>
	            <td colspan="11" class="reportLBL"> 
	              <table width="100%" border="0" cellspacing="0" cellpadding="3"> 
	                <tr>
	                  <td class="reportheading3"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %> </td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.mode",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %> </td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage) %> </td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %></td>
					   <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage) %></td>   
				    </tr>
	                <%
						///	query changed  by shiv on 26-Oct-07 for  preferred  time on 26-Oct-07    
						
						     strSql = " SELECT  Return_FROM, Return_TO, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE), '-') AS TRAVEL_DATE, ISNULL(RTRIM(LTRIM(dbo.TRAVEL_MODE_NAME(TRAVEL_MODE))), '-') AS TRAVEL_MODE,  ISNULL(RTRIM(LTRIM(dbo.TRAVEL_CLASS_NAME(TRAVEL_MODE, TRAVEL_CLASS))), '-') AS TRAVEL_CLASS,  ISNULL(RTRIM(LTRIM(dbo.PREFER_TIME_DESC(TIMINGS))), '-') AS TIMINGS, ISNULL(MODE_NAME, '-') AS MODE_NAME,isnull(M_SEAT_PREFER.Seat_Name,'')AS  Seat_Name,TICKET_REFUNDABLE  FROM   T_RET_JOURNEY_DETAILS_DOM left outer JOIN  M_SEAT_PREFER ON  T_RET_JOURNEY_DETAILS_DOM.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_RET_JOURNEY_DETAILS_DOM.TRAVEL_ID ="+strTravelId+" AND T_RET_JOURNEY_DETAILS_DOM.STATUS_ID=10 ";
						
					         		 
	                
						  	 rs = dbConBean.executeQuery(strSql);
							 while(rs.next()) 
							 {  
						 %>
						                <tr align="left">
						                  <td class="reportdata" ><%= rs.getString(1).toUpperCase() %></td> 
						                  <td class="reportdata" ><%= rs.getString(2).toUpperCase() %></td>
						                  <td class="reportdata" ><%= rs.getString(3) %></td>
						 				   <td class="reportdata"> <%= rs.getString(4).toUpperCase() %> </td>
										  <td class="reportdata"><%= rs.getString(5).toUpperCase() %></td>
										  <td class="reportdata"> <%= rs.getString(6).toUpperCase() %> </td>
										  <td class="reportdata"> <%= rs.getString(7).toUpperCase() %></td>
						 
						                  <td class="reportdata"> <%=  rs.getString(8).toUpperCase() %>   </td> 
						                  <% strTicketRefund   =rs.getString("TICKET_REFUNDABLE");
						                     if(strTicketRefund.equals("y"))
						                        {
						                    	 strTicketRefund ="Yes";
						                     }else{
						                    	 strTicketRefund ="No";
						                     } 
						                  %>
						                  <td class="reportdata"><%= strTicketRefund %> </td>
									    </tr>
						  <%
							 } 
							 rs.close();						
						
						// SET THE RETURN TRAVEL DETAIL
							
			  
					%>
					
					
				
					   
				<tr>
				      
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.createrequest.tatkaalrequired",strsesLanguage) %>  </td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.createrequest.couponticketrequired",strsesLanguage) %> </td>
					  <td class="reportheading3">&nbsp;</td>
					  <td class="reportheading3">&nbsp;</td>
					  <td class="reportheading3">&nbsp; </td>
					  <td class="reportheading3">&nbsp; </td>
					  <td class="reportheading3">&nbsp;</td>
					  <td class="reportheading3">&nbsp;</td>
					  <td class="reportheading3"> </td> 
					  
			    </tr>
	
					 <%
					     strSql = " SELECT   case when FORWARD_TATKAAL='y'  then 'YES'   else 'No'   end, case when FORWARD_COUPAN ='y'  then 'Yes' else 'No'  end  FROM   T_TRAVEL_DETAIL_DOM where TRAVEL_ID ="+strTravelId+"AND STATUS_ID=10";
						 rs = dbConBean.executeQuery(strSql);
						 while(rs.next()) 
						 {  
					 %>
					                <tr align="left"> 
					                  <td class="reportdata" ><%= rs.getString(1).toUpperCase() %></td>
					                  <td class="reportdata" ><%= rs.getString(2).toUpperCase() %></td>
					                  <td class="reportdata" ><%//= rs.getString(3) %></td>
					  
									<td class="reportdata"> <%//= rs.getString(4).toUpperCase() %> </td>
									  <td class="reportdata"><%//= rs.getString(5).toUpperCase() %></td>
									  <td class="reportdata"> <%//= rs.getString(6).toUpperCase() %> </td>
									  <td class="reportdata"> <%//= rs.getString(7).toUpperCase() %></td> 
					 
					                  <td class="reportdata"> <%//= strVisaRequired.toUpperCase() %> </td>
					                  <td class="reportdata"> <%//= strVisaRequired.toUpperCase() %> </td> 
								    </tr>
					  <%
						 } 
						 rs.close();						
					%>
					              </table> 
					              
					   </td>
			   </tr>
	           
	           <%}
		   %>
			<!-- code end  -->
				          
			  <tr>
		            <td colspan="11" class="reportheading2"><%=dbLabelBean.getLabel("label.requestdetails.identityproofdetailstravelers",strsesLanguage) %></td>
		      </tr>
	          <tr>
			     <td colspan="11" class="reportLBL">
	              <table width="100%" border="0" cellspacing="0" cellpadding="3">
				    <tr>
	                  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.identityname",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.identitynumber",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.mobileno",strsesLanguage) %></td>
					  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage) %></td>
					  <td class="reportheading3">&nbsp;</td>
					  <td class="reportheading3">&nbsp;</td>
					</tr>	
			   <%
	
	
			   //added code for showing currency on 06-Mar-08 by Shiv Sharma 
	
			/*strSql ="SELECT DISTINCT CURRENCY FROM  T_TRAVEL_EXPENDITURE_Dom WHERE  (TRAVEL_ID = "+strTravelId+")";
	
			  rs = dbConBean.executeQuery(strSql);
			   while(rs.next()) 
			  {  
				strCurrency= rs.getString(1);
			  }
	      rs.close();	*/	
	
			 //strSql = " select  RTRIM(FIRST_NAME) + ' ' + RTRIM(LAST_NAME) AS Name, IDENTITY_ID, IDENTITY_NO, MOBILE_NO, CASE WHEN CONVERT(decimal(20, 0), Total_Amount) = '0' THEN '-' ELSE CONVERT(varchar, CONVERT(bigint, Total_Amount)) END AS Total_Amount  from t_group_userinfo where travel_type='d' and travel_id="+strTravelId+" and status_id=10";
	      //CHANGED BY MANOJ CHAND ON 01 FEB 2013 TO SHOW EXPENDITURE DETAILS
	      strSql = " select  RTRIM(FIRST_NAME) + ' ' + RTRIM(LAST_NAME) AS Name, IDENTITY_ID, IDENTITY_NO, MOBILE_NO, dbo.FN_GET_EXPENDITURE_GROUP(travel_id,'D',G_USERID) from t_group_userinfo where travel_type='d' and travel_id="+strTravelId+" and status_id=10";
	//System.out.println("strSql-->"+strSql);
			  intSNo = 0;
			  rs = dbConBean.executeQuery(strSql);
			  while(rs.next()) 
			  {  
	%>
							<tr>
								<td height="0" class="reportdata" ><%= ++intSNo%></td>
								<td height="0" class="reportdata" ><%= rs.getString(1).toUpperCase() %></td>
	
		                <%
	                       	strIdentityProof = rs.getString("IDENTITY_ID");
					        if(dbmethod.checkforString(strIdentityProof)==1) 
								{
								strIdentityProofName=strIdentityProof;
							   }
						   else
							   {  
						 
						strSql="SELECT  ISNULL(IDENTITY_NAME,'') AS IDENTITY_NAME FROM m_IDENTITY_PROOF WHERE  IDENTITY_ID ="+strIdentityProof+" and STATUS_ID=10";
	
									rs1 = dbConBean1.executeQuery(strSql);
										while(rs1.next())
										{
											strIdentityProofName=rs1.getString("IDENTITY_NAME");
	                                 	}
							
							   }	
		%>
	
								<td height="0" class="reportdata" ><%=strIdentityProofName.toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(3).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(4).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%=strCurrency%>  <%= rs.getString(5).toUpperCase() %></td>
							<td height="0" class="reportdata" >&nbsp;</td>						
							<td height="0" class="reportdata" ><%//=strCurrency%> <%//= rs.getString(7).toUpperCase() %></td>						
						  </tr>
<%
		  } 
		  rs.close();						
%>
				
			  </table>	
			</td>
		 </tr>
         
        
          
  <% 

			ResultSet rs3 = null;
			String strRoleinfo="";
			 strSql = "SELECT ROLE_ID FROM M_USERINFO WHERE USERID = "+ Suser_id+ " AND APPLICATION_ID =1 AND STATUS_ID=10";	
			
			rs3 = dbConBean1.executeQuery(strSql);
			while(rs3.next())
			{
			strRoleinfo=rs3.getString(1);
			  
			}
			rs3.close();
		
				
		 		if ((strCUserId.equals(Suser_id)) || strRoleinfo.trim().equals("MATA"))
				{
				%>
          <!--<tr>
            <td colspan="11" class="reportheading2">Credit Card Details </td>
          </tr>
          <tr>
            <td class="reportLBL">Card Type </td>-->
    
            <!--<td class="reportdata"><%=strCARD_TYPE%>&nbsp;</td>
            <td class="reportLBL">Card No.</td>
	        <td class="reportdata"><%=strCreditCardNumber%></td>
            <td class="reportLBL">Holder Name </td>
	        <td class="reportdata"> <%=strCARD_HOLDER_NAME%> </td>
	        <td colspan="2" class="reportLBL">Expiry Date</td>
		    <td colspan="3" class="reportdata"> <%=strCARD_EXP_DATE%>&nbsp; </td>
          </tr>-->
          <% } %>
          <tr>
            <td colspan="4" class="reportheading2"><%=dbLabelBean.getLabel("message.approverequest.approvedby",strsesLanguage) %> </td>
            <td colspan="7" class="reportheading2"><%=dbLabelBean.getLabel("label.global.expendituredetails",strsesLanguage) %> </td>
	      </tr>
          
          
  <%
	String strUnitHeadId = "";
	 strSql = "SELECT USERID  AS UNIT_HEAD_USERID FROM M_USERINFO WHERE UNIT_HEAD=1 AND SITE_ID IN (SELECT SITE_ID FROM M_USERINFO WHERE USERID="+strCUserId+" AND STATUS_ID=10)  AND APPLICATION_ID =1 AND STATUS_ID=10";	

	 rs3 = dbConBean1.executeQuery(strSql);
	 if(rs3.next())
	 {
		strUnitHeadId =rs3.getString("UNIT_HEAD_USERID");		
	 }
	 rs3.close();


String strUnitHeadApproval  = "";
String strChairmanApproval  = "";
if(strBilling_Client != null && strBilling_Client.equals("self"))
{
	strUnitHeadApproval  = "Not Applicable";
	strChairmanApproval  = "Not Applicable";
}
else
{
	strUnitHeadApproval  = "Approved";
	strChairmanApproval  = "Approved";
}


	//new code for showing unit head  name for mata page only on  2 jan 2009    
	String unitheadName=""; 
			strSql  = "SELECT dbo.user_name(TA.APPROVER_ID)as unit_head  FROM  " +
			  "T_APPROVERS TA INNER JOIN  USER_MULTIPLE_ACCESS UMASS   " + 
			  " ON TA.APPROVER_ID = UMASS.USERID AND TA.SITE_ID = UMASS.SITE_ID WHERE (TA.TRAVEL_TYPE = 'd') " + 
			  " AND (TA.TRAVEL_ID = "+strTravelId+") AND (UMASS.UNIT_HEAD = '1')";

	         
				 rs1                          = dbConBean1.executeQuery(strSql);
				 while(rs1.next())
				 {
					 unitheadName =	"by "+rs1.getString("unit_head");
						 
				 }
				 rs1.close();

%>
          <tr>
            <td class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.unithead",strsesLanguage) %> </td>
		    <td class="reportdata"><%=strUnitHeadApproval%> <%=unitheadName%></td>
		    <td class="reportLBL">&nbsp;</td>
		    <td class="reportdata"><%//=strUnitHeadApproval%></td>
		    <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage) %> </td>
		    <td colspan="2" class="reportdata" width="20%"><%=strTotal_Amount%></td>
		    <td class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.billing",strsesLanguage) %> </td>
		    <td colspan="3" class="reportdata"><%=strBilling_Client%></td>
	      </tr>
          <tr> <td class="reportLBL">&nbsp; </td>
		    <td class="reportdata"> &nbsp;</td>
		    <td class="reportLBL">&nbsp; </td>
			<td class="reportdata">&nbsp; </td>
		     
            
		    <td colspan="2" class="reportLBL"> &nbsp; </td>
		    <td colspan="3" class="reportdata"><%=strCashBreakUpRemark%></td>
	      </tr> 	
		   <!--<tr>
            <td colspan="11" class="reportheading2">Remarks</td>            
	      </tr>
		   <tr>		    
		    <td colspan="11" class="reportdata"><%=strRemarks%></td>-->
	    </table>
        <br>      </td>
    </tr>
  </table>
     
    
  </div>
</body>
<table width="600" align="center" border="0" cellpadding="2" cellspacing="0" bordercolor="#FFFFFF" class="reporttbl">
  <tr width="100%" class="formhead">
    <td colspan="11" bgcolor="#000000" class="reportheading2"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></td>
  </tr>	
  <tr class="reportLBL">
    <td class="reportLBL" width="2%" align="left" valign="top" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
	<td class="reportLBL" width="24%" align="left" valign="top"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></td>
	<td class="reportLBL" width="24%" align="left" valign="top"><%=dbLabelBean.getLabel("label.global.postedby",strsesLanguage) %></td>
	<td class="reportLBL" width="24%"><%=dbLabelBean.getLabel("label.global.postedon",strsesLanguage) %></td>
  </tr>
<%
		String strCommentId		      =	null;
		String strComments		      =	null;
		String strPostedBy		          =	null;
		String strPostedOn		          =	null;
	    String strCommentsId			  =	"";
		String strOriginatedUserId    =	"";
		String strStyleCls                  =   "";
		int iCls                                   =   0;  

		//Making approver comment bold  if he change the comment on 03-04-2009 by shiv sharma  
		strSql=" SELECT TRAVEL_ID,case when left(rtrim(ltrim(COMMENTS)),8) <>'approved' then '<b>'+ COMMENTS + '</b>' else COMMENTS end  as "+ 
			   " COMMENTS,DBO.USER_NAME(POSTED_BY),DBO.CONVERTDATEDMY1(POSTED_ON), COMMENTS_ID,POSTED_BY FROM TRAVEL_REQ_COMMENTS WHERE TRAVEL_ID='"+strTravelId+"'  AND TRAVEL_TYPE='D' ORDER BY POSTED_ON DESC";

	 
		
	 rs = dbConBean.executeQuery(strSql);
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
         	 if (iCls%2 == 0) { 
        		strStyleCls="formtr2";
             } else { 
    		 strStyleCls="formtr1";
             } 
      	     iCls++;
%>
				<tr class="<%=strStyleCls%>">
					<td class="reportdata" width="2%" align="left" valign="top"><%=intSno++%></td>
					<td class="reportdata" width="24%" align="left" valign="top"><%=strComments%></td>
					<td class="reportdata" width="24%" align="left" valign="top"><%=strPostedBy%></td>
					<td class="reportdata" width="24%"><%=strPostedOn%></td>
				</tr>
<%
		 }while(rs.next());
	 }
	 rs.close();          // close the result set 
	 dbConBean.close();   //close all connection
%>
</table>
<%
dbConBean1.close();
%>