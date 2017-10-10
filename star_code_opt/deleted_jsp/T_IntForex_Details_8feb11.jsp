	<%
		/***************************************************
		 *The information contained here in is confidential and 
		 * proprietary to MIND and forms the part of the MIND 
		 *Author				:SACHIN GUPTA
		 *Date of Creation 		:12 September 2006
		 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved 
		 *Project	  			:STAR
		 *Operating environment    :Tomcat, sql server 2000 
		 *Description 			 :This is first jsp file  for create the Forex Details
		 *Modification 			 1 :Change the Billing Instruction(add three radio for self,SMG, and other SMG). Add two new entry for travel Cheque and      										one new entry for Other Currency. 
		                                 2.added on for checking  starting Spaces on 05-Jul-07
								  3.Sanjeet Kumar on 20-July-2006 to display appropriate message incase policy not uploaded.
								  4.Change code for showing billing site and its users  for adding in workflow if user selects billing site other than his    
									  own site by Shiv Sharma on  5th Nov
								 5  Query changed for showing user who are in approver level 1,2 or global apporver  by shiv sharma on 31- dec-2007
								 6  Added code for changing Expenditure validation Criteria  on  28-Apr-08  by shiv Sharma  
								 7: code added by shiv on 3/4/2009
								 8: code added for making user selection not mandetory for all site for which he has access  on 09-06-2009 
								 9:Change code for price analysis with mata and local travel agent on 23-Nov-09 byb shiv sharma 
												  
		 *Reason of Modification:  1. change suggested by MATA
								                  2. If one field of Hotel Charges is filled then      second field  is also mandotary.
								                 
		 *Date of Modification  :      1. 2 Nov 2006 
								                   2. 12-Mar-2007
		 *Modified By	                   1 . SACHIN GUPTA
								                   2. Vijay Kumar Singh
		 *Editor				:Editplus
		 :Modified by vaibhav on Aug 20 2010to show only authorised approver in case if billing site is     different. 
		:Modified by vaibhav on 30 sep 2010 to add constraint on per day expense.
		:Modified by Pankaj Dubey on 11 Nov 2010 to add 5 new fields to record budgetory figures.

		 *******************************************************/
	%>
	<html>
	<%-- Import Statements  --%>
	<%@ include  file="importStatement.jsp" %>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>  
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<script>
	 window.history.forward(1);
	function MM_openBrWin(theURL,winName,features)
	 { 
			   window.open(theURL,winName,features);
	 }
	
	 function getSiteID(frm)
	{ 
	     //a=document.frm.billingSMGSite.value;  
		 
		//document.frm.action="T_IntForex_Details.jsp?billingSMGSite="+a+"";
		document.frm.action="T_IntForex_Details.jsp";
		frm.refreshFlag.value="Y";
		frm.billingSMGUser.value="-1";
	    document.frm.submit();
	 }
	 
	 // added by shiv on 31 oct 2009 for showing MATA price comparision  
	  function showdiv(flag){
	 	 if(flag=='n') 
			{
			//alert("On select of No means you will Enter your price for travel ticket for comparion with MATA");
	 		document.getElementById("showdiv").style.display = "";
	 		
			}else{ 
			//alert("On select of yes mean you want travel ticket from MATA without price comparion");
			document.getElementById("showdiv").style.display = "none";
			} 
		
	 }
	// Function added by vaibhav on 30 sep 2010 to add constraint on per day expense.
	 
	 function checkMsg(){
		 var chm=document.forms[0].checkMsg.value;
		// alert("hello "+chm);
		 if (chm=="ExpenceCheck")
		  {
			  alert("Could not Submit to Workflow, As per corporate guidelines the per day amount should not be more than USD 350 (or equivalent amount in other currency). Kindly change the amount accordingly.");
		  }
	 }
	 
	 
	 </script>
	 <body onload="checkMsg();">
	 
	<%
	 		//Global Variables declared and initialized

	 		String strSql = null; // String for Sql String
	 		ResultSet rs, rs1, rs2 = null; // Object for ResultSet
	 		String strTravelReqId = "";
	 		String strTravelId = "";
	 		String strTravelReqNo = "";
	 		String strTravllerSiteId = "";
	 		String strTravellerId = "";
	 		String strMessage = "";
	 		String strStar = "*";
	 		String strInterimId = "";

	 		String strFlag = "";

	 		String strBillingSiteNew = "";
	 		strBillingSiteNew = request.getParameter("billingSMGSite") == null
	 				? "-2"
	 				: request.getParameter("billingSMGSite");

	 		strInterimId = request.getParameter("interimId") == null
	 				? ""
	 				: request.getParameter("interimId");

	 		strTravelReqId = request.getParameter("travelReqId"); // for hidden field
	 		strTravelId = request.getParameter("travelId"); // for hidden field
	 		strTravelReqNo = request.getParameter("travelReqNo"); // for hidden field
	 		strTravllerSiteId = request.getParameter("travellerSiteId"); // for hidden field
	 		strTravellerId = request.getParameter("travellerId"); // for hidden field
	 		strMessage = request.getParameter("message");

	 		if (strMessage != null && strMessage.equals("save")) {
	 			strMessage = "Saved Successfully";
	 		} else if (strMessage != null && strMessage.equals("notSave")) {
	 			strMessage = "Could Not Be Saved";
	 		}

	 		else {
	 			strMessage = "";
	 		}
	 		// Code added by Sanjeet Kumar on 20-july-2007 for giving a proper information incase site not uploaded
	 		String Path = application.getInitParameter("companyPolicyPath");
	 		File UploadFile = new File(Path + "/" + strSiteFullName + "/"
	 				+ strSiteFullName + ".html");
	 		
	 		
	 		
	 		
	 		String strforPriceDesicion = "";
           	String strSHOW_BUD_INPUT = "";
           	strSql = "Select isnull(INT_LOCAL_AGENT,'') as INT_LOCAL_AGENT , SHOW_BUD_INPUT  From m_site where site_id="
           			+ strSiteIdSS + " and status_id=10 ";
           	rs = dbConBean.executeQuery(strSql);

           	while (rs.next()) {
           		strforPriceDesicion = rs.getString("INT_LOCAL_AGENT");
           		strSHOW_BUD_INPUT = rs.getString("SHOW_BUD_INPUT");

           	}
           	rs.close();
           	
           	
	 	%>
	
	<script language="javascript">
	
	function checkData(f1,actionFlag) 
	{

		if(!f1.billing[2].checked){  
		
		//if (document.frm.billingSMGSite.value!='<%=strSiteIdSS%>')
		     var tt = document.frm.BillingSiteFlag.value;
		 
		    
		    if(document.frm.billingSMGSite.value!='<%=strSiteIdSS%>' && tt!='1' )
	         {
				 
			     if(document.frm.billingSMGUser.value=="-1")
				  {
					//alert("hi  "+document.frm.billingSMGUser.value);
					alert("Please Select Approver from Billing Unit" );
					document.frm.billingSMGUser.focus();
			         return false;
				  }
				} 
		}
		
	    f1.whatAction.value=actionFlag;
	   
	     
		if(f1.billing[2].checked)
		{  
			if(f1.billClient.value=="")
			{
				alert("Please fill the details of client");
				f1.billClient.focus();
				return false;
			}
	         
	 	}
	
		
		var k = 9;
		k=document.frm.elements.length;     
		if(f1.billing[0].checked)
		{		
			k=5;
		}
	    //for( i=0;i<document.frm.elements.length;i++)   
		//22-02-2007
		
		for( i=0;i<22;i++)         
		{ 
			  
			     //alert(  "no is"+i);     
			 			// alert(document.frm.elements[i].name);   
			 		  //alert(document.frm.elements[i].name+"i is>>"+i);           		
			 		 
	       /// added code for changing Expenditure validation Criteria  on  28-Apr-08  by shiv Sharma 
	       
		   if ((document.frm.elements[9].value!=0 || document.frm.elements[9].value==''))    
	      		{

								if(document.frm.elements[i].name=='entitlement')
								{
									//alert(document.frm.elements[i].name);
									var str = document.frm.elements[i].value;
									if(str=="") 
									{
										//alert("Please fill the expenditure per day");
									  if(i!=12){ 
										alert("Please fill 0 if not required in the expenditure per day");
										document.frm.elements[i].focus();
										return false;
										}
									}
								}
								
								
								if(document.frm.elements[i].name=='tourDays' )
								{
									var str1=document.frm.elements[i].value;
									//alert("str1==inside="+str1);
									if(str1=="")
									{
										//alert("Please fill the total tour days");
										
									  if(i!=13 ){ 
										alert("Please fill 0 if not required in the total tour days");
										document.frm.elements[i].focus();
										return false;
										}
									}
								}
	
								if(document.frm.elements[i].name=='totalForex' )
								{
									var str1=document.frm.elements[i].value;
									if(str1=="")
									{
										//alert("Please fill the total tour days");
										//document.frm.elements[i].focus();
										//return false;
									}
								}
								if(document.frm.elements[i].name=='contingencies' )
								{
									var str1=document.frm.elements[i].value;
									if(str1!="0" && str1!="")
									{
										if(document.frm.expRemarks.value=="")
										{
										  alert("Please fill the Remarks for Contingencies/Any Other Expenditure");
										  document.frm.expRemarks.focus();
										  return false;
										}
									}
								}
								/*if(document.frm.elements[i].name=='specifyAmount1' )
								{
									var str1=document.frm.elements[i].value;
									if(str1==""||str1=="0")
									{
										alert("Please fill the Specify Amount");
										document.frm.elements[i].focus();
										return false;
									}
								}*/
				}
			  
		}
	// add by sachin 3/15/2007 start
		var str = document.frm.elements[12].value;
		var str1 = document.frm.elements[13].value;
		
	 /*
		if(str!="" && str!="0")
		{
			if(str1=="")
			{
				alert("Please fill the total tour days");
				document.frm.elements[13].focus();
				return false;
			}
		}
	 
	   	if(str1!=""&& str1!="0")
		{
			  
			if(str=="")
			{	
				alert("Please fill the expenditure per day");
				document.frm.elements[12].focus();
				return false;
			}
		}

		*/
	// add by sachin 3/15/2007 end  
	
	//added by shiv on 06-Jul-07 for display message if 
	
		if ((f1.contingencies[0].value != '0' && f1.contingencies[0].value != "" )  || (f1.contingencies[1].value != '0' && f1.contingencies[1].value != "")){
			if (f1.expRemarks.value == "") {
				alert("Please specify the reason for contingencies or any other expenditure");
				f1.expRemarks.focus();
				return false;
			}
		}
	
	
  // alert(document.frm.matapricecomp.value);
   
   if(document.frm.matapricecomp.value=='y'){
	   if(f1.tkflyes[0].checked){ 
	     //alert("YES");
	   }
	    if(f1.tkflyes[1].checked) 
	    {  
	   	   //currency localprice pricingRemarks
			if(f1.airline.value!=""){
			
				if(f1.currency.value=="-1"){  
				
					alert("Pleast Select the Currency");  
					f1.currency.focus(); 
					return false;
				}
				if(f1.localprice.value==""){  
				
					alert("Pleast Enter the Local Price");  
					f1.localprice.focus(); 
					return false;
				}
				if(f1.pricingRemarks.value==""){
				
					alert("Pleast Enter the Remarks");  
					f1.pricingRemarks.focus(); 
					return false;
				}
		   }		
		}	
	   
	  } 	  
	  //zeroChecking(f1.travelCheque); 
		/*if(f1.travelCheque.value=="") 
		{
			 alert("Please fill the value of Traveler's Cheque");
			f1.travelCheque.focus();
			return false; 
		}
		*/
		
		if(actionFlag == "saveProceed")
		{  var text=document.frm.approverlist.value;
		   //alert(text);
		   if(text!=''){
		   text="Currently "+text;   
		    	    }

var budValidations = '<%=strSHOW_BUD_INPUT%>';
	if(budValidations == 'Y'){
		// Script added by Pankaj on 11 nov 2010 to force user filling YTM fields or appropriate remarks. (STARTS)
			var YtmBud = document.getElementById('YtmBud').value;
			var YtmAct = document.getElementById('YtmAct').value;
			var EstExp = document.getElementById('EstExp').value;
			var budgetRemarks = document.getElementById('budgetRemarks').value;
			
			if(((YtmBud == '' || YtmAct == '' || EstExp == '') && budgetRemarks == '')){
				alert('Please enter the remarks for not entering the Budget Actual Details.');
				if(YtmBud == ''){
					document.getElementById('YtmBud').focus();
				}else if(YtmAct == ''){
					document.getElementById('YtmAct').focus();
				}else if(EstExp == ''){
					document.getElementById('EstExp').focus();
				}
				return false;
			}/*if(YtmBud == '' || YtmAct == '' || EstExp == ''){
				alert('Please enter the remarks for not entering the Budget Actual Details.');
				if(YtmBud == ''){
					document.getElementById('YtmBud').focus();
				}else if(YtmAct == ''){
					document.getElementById('YtmAct').focus();
				}else if(EstExp == ''){
					document.getElementById('EstExp').focus();
				}
				return false;
			}*/
			// Script added by Pankaj on 11 nov 2010 to force user filling YTM fields or appropriate remarks. (ENDS)
			
		}
			
			if(confirm(text+"Are you Sure you want to Submit This Request to Workflow?"))  {
				f1.saveProceed.disabled=true;  //code added by shiv on 3/4/2009
				f1.submit();
			 // return true;
		    }
		    else
		    {
		       return false;
		    }
		}	
		
		//return true;
	}

	function backPage(frm)
	{
	   document.frm.action="T_IntPassport_Details.jsp";
	   document.frm.submit();
	}
	
	
	function billingOnClick(f1)
	{
	
		if(f1.billing[0].checked)
		{
			f1.billClient.value="";
			f1.billingSMGSite.disabled=true;
			f1.billClient.disabled=true;
			f1.billingSMGUser.disabled = true;        //billing SMG user combo disabled  					
			f1.elements[6].readOnly = true;
			f1.elements[7].readOnly = true;
			f1.elements[8].readOnly = true;
			check1();
		}
		if(f1.billing[1].checked)
		{
			f1.billingSMGSite.disabled=false;
		    f1.billClient.value="";
			f1.billClient.disabled=true;
	        f1.billingSMGUser.disabled = false;        //billing SMG user combo disabled  			
			f1.elements[6].readOnly = false;
			f1.elements[7].readOnly = false;
			f1.elements[8].readOnly = false;
	
		}
		if(f1.billing[2].checked)
		{
			f1.billingSMGSite.disabled=true;
			f1.billClient.disabled=false;
			f1.billingSMGUser.disabled = true;        //billing SMG user combo disabled  			
			f1.billClient.focus();
			f1.elements[6].readOnly = false;
			f1.elements[7].readOnly = false;
			f1.elements[8].readOnly = false;
		}
	}
	function check1()
	{
		var flag=0;
		var flag1=0;
		var flag2=0;
		var arrEntitlement = new Array(100);
		var arrTotalTourDays= new Array(100);
		var totalEntitleMent=0;
		var totalTourDays = 0;
	 
	    for( i=0;i<document.frm.elements.length;i++)
		{
			if(document.frm.elements[i].name=='entitlement'  )
			{
				arrEntitlement[flag]=document.frm.elements[i].value;
				if(arrEntitlement[flag]=="")
				{
					arrEntitlement[flag]=0;
				}
				totalEntitleMent=totalEntitleMent+parseFloat(arrEntitlement[flag]);
				flag++;
			}
			if(document.frm.elements[i].name=='tourDays' )
			{
				arrTotalTourDays[flag1]=document.frm.elements[i].value;
				if(arrTotalTourDays[flag1]=="")
				{
					arrTotalTourDays[flag1]=0;
				}
				totalTourDays=totalTourDays+parseInt(arrTotalTourDays[flag1]);
				flag1++;
			}
			if(document.frm.elements[i].name=='totalForex' || document.frm.elements[i].name=='contingencies')
			{
				flag2++;
			}
			
		}	
	
		var i=0;
		var k=0;
	    var tempTotal=0;
		for(j=0;j<flag2;j++)
		{
			inner : while(i<document.frm.elements.length)
			{
				if(document.frm.elements[i].name=='totalForex' )
				{
					document.frm.elements[i].value=parseFloat(arrEntitlement[j])*parseInt(arrTotalTourDays[j]);
					tempTotal=tempTotal+parseFloat(document.frm.elements[i].value);
					break inner;
				}
				if(document.frm.elements[i].name=='contingencies' )
				{
				    if(document.frm.elements[i].value=="")
	                   document.frm.elements[i].value=0; 
					tempTotal=tempTotal+parseFloat(document.frm.elements[i].value);
					break inner;
				}
	
				i++;
				k=i;			
			}
			i=++k;
		}
		document.frm.grandTotalForex.value=tempTotal;
	}
	
	
	
	
	function test1(obj, length, str)
	{
		charactercheck(obj,str);
		limitlength(obj, length);
		//zeroChecking(obj);
		spaceChecking(obj);//added on for checking  starting Spaces on 05-Jul-07 
		check1();
		
	}
	</script>
	<%
		String strApproverid = "";
		String ApproverText = "";
		String strname1 = "";
		String strname2 = "";

		strSql = "select top 1 approver_id  from T_approvers  where travel_id ="
				+ strTravelId
				+ " and travel_type='i' and status_id=10 order by order_id ";

		rs = dbConBean.executeQuery(strSql);
		while (rs.next()) {
			strApproverid = rs.getString(1);

			strSql = "select dbo.user_name(" + strApproverid
					+ "),dbo.user_name(dbo.finalooo(" + strApproverid
					+ ",getdate(),'i'))";

			rs1 = dbConBean1.executeQuery(strSql);

			while (rs1.next()) {

				strname2 = rs1.getString(1);
				strname1 = rs1.getString(2).trim();
				if (!strname1.equals("-")) {
					ApproverText = ApproverText + strname2
							+ " has delegated his approval Authority to "
							+ strname1 + ".\n ";

				}

			}
		}

		rs.close();

		String strBillingSite = "";
		String strBillingClient = "";
		String strTotalAmount = "";
		String strTACurrency = "";
		String strTravellerCheque = "";
		String strTravellerCheque1 = "";
		String strTravellerCheque2 = "";
		String strTCCurrency = "";
		String strTCCurrency1 = "";
		String strTCCurrency2 = "";
		String strExpRemarks = "";
		String strCashBreakupRemarks = "";
		String strExpId = "";
		String strEntPerDay = "";
		String strTotalTourDays = "";
		String strTotalExpId = "";

		String strTicketProvider = "";
		String strAirLineName = "";

		// below 5 fields added by Pankaj on 11 Nov 10
		String dbl_YTM_BUDGET = "";
		String dbl_YTD_ACTUAL = "";
		String dbl_AVAIL_BUDGET = "";
		String dbl_EST_EXP = "";
		String str_EXP_REMARKS = "";

		String strCurreny = "";
		String strAmount = "";
		String strRemarks = "";

		// set the billing site  as originator site
		strBillingSite = strSiteIdSS;

		//Get the Data from this travel id
		strSql = "SELECT BILLING_SITE,BILLING_CLIENT,RTRIM(LTRIM(convert(decimal(20,0),TOTAL_AMOUNT))) AS TOTAL_AMOUNT, RTRIM(LTRIM(TA_CURRENCY)) AS TA_CURRENCY, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE))) AS TRAVELLER_CHEQUE, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE1))) AS TRAVELLER_CHEQUE1, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE2))) AS TRAVELLER_CHEQUE2, RTRIM(LTRIM(TC_CURRENCY)) AS TC_CURRENCY,RTRIM(LTRIM(TC_CURRENCY1)) AS TC_CURRENCY1,RTRIM(LTRIM(TC_CURRENCY2)) AS TC_CURRENCY2, EXPENDITURE_REMARKS, CASH_BREAKUP_REMARKS, TRAVEL_REQ_ID, SITE_ID,TK_PROVIDER_FLAG,TK_AIRLINE_NAME,TK_CURRENCY,TK_AMOUNT,TK_REMARKS , "
				+ " YTM_BUDGET , YTD_ACTUAL , AVAIL_BUDGET , EST_EXP , EXP_REMARKS"
				+ " FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="
				+ strTravelId + " AND APPLICATION_ID=1 AND STATUS_ID=10";

		rs = dbConBean.executeQuery(strSql);
		if (rs.next()) {
			strBillingSite = rs.getString("BILLING_SITE");
			strBillingClient = rs.getString("BILLING_CLIENT");
			strTotalAmount = rs.getString("TOTAL_AMOUNT");
			strTACurrency = rs.getString("TA_CURRENCY");
			strTravellerCheque = rs.getString("TRAVELLER_CHEQUE");
			strTravellerCheque1 = rs.getString("TRAVELLER_CHEQUE1");
			strTravellerCheque2 = rs.getString("TRAVELLER_CHEQUE2");

			strTCCurrency = rs.getString("TC_CURRENCY");
			strTCCurrency1 = rs.getString("TC_CURRENCY1");
			strTCCurrency2 = rs.getString("TC_CURRENCY2");
			strExpRemarks = rs.getString("EXPENDITURE_REMARKS");
			strCashBreakupRemarks = rs.getString("CASH_BREAKUP_REMARKS");
			strTravelReqId = rs.getString("TRAVEL_REQ_ID");
			strTravllerSiteId = rs.getString("SITE_ID");

			strTicketProvider = rs.getString("TK_PROVIDER_FLAG");
			strAirLineName = rs.getString("TK_AIRLINE_NAME");
			strCurreny = rs.getString("TK_CURRENCY");
			strAmount = rs.getString("TK_AMOUNT");
			strRemarks = rs.getString("TK_REMARKS");

			dbl_YTM_BUDGET = rs.getString("YTM_BUDGET");
			dbl_YTD_ACTUAL = rs.getString("YTD_ACTUAL");
			dbl_AVAIL_BUDGET = rs.getString("AVAIL_BUDGET");
			dbl_EST_EXP = rs.getString("EST_EXP");
			str_EXP_REMARKS = rs.getString("EXP_REMARKS");

			if(dbl_YTM_BUDGET.equalsIgnoreCase("0.0"))
				dbl_YTM_BUDGET = "";
			if(dbl_YTD_ACTUAL.equalsIgnoreCase("0.0"))
				dbl_YTD_ACTUAL = "";
			if(dbl_AVAIL_BUDGET.equalsIgnoreCase("0.0"))
				dbl_AVAIL_BUDGET = "";
			if(dbl_EST_EXP.equalsIgnoreCase("0.0"))
				dbl_EST_EXP = "";
			
			if (strAmount.equals(".00")) {
				strAmount = "";
			}

			//TK_PROVIDER_FLAG,TK_AIRLINE_NAME,TK_CURRENCY,TK_AMOUNT,TK_REMARKS

			if (strBillingClient == null)
				strBillingClient = "";
			if (strTotalAmount == null)
				strTotalAmount = "";
			if (strTravellerCheque == null)
				strTravellerCheque = "";
			if (strTravellerCheque1 == null)
				strTravellerCheque1 = "";
			if (strTravellerCheque2 == null)
				strTravellerCheque2 = "";
			if (strExpRemarks == null)
				strExpRemarks = "";
			if (strCashBreakupRemarks == null)
				strCashBreakupRemarks = "";
			if (strTACurrency == null || strTACurrency.equals(""))
				strTACurrency = "USD";

			if (strTCCurrency == null || strTCCurrency.equals(""))
				strTCCurrency = "USD";
			if (strTCCurrency1 == null || strTCCurrency1.equals(""))
				strTCCurrency1 = "USD";
			if (strTCCurrency2 == null || strTCCurrency2.equals(""))
				strTCCurrency2 = "USD";

			if (strTotalAmount != null && strTotalAmount.trim().equals("0")) {
				strTotalAmount = "";
			}
			if (strCurreny == null || strCurreny.equals(""))
				strCurreny = "USD";

		}
		rs.close();

		//For get the spcify amount and breakup currency
		String strCashAmount1 = "";
		String strCashCurrency1 = "USD";
		String strCashAmount2 = "";
		String strCashCurrency2 = "USD";
		String strCashAmount3 = "";
		String strCashCurrency3 = "USD";
		String strOtherCashAmount = "";
		String strOtherCashCurrency = "";
		String strlinkshowflag = "No";
		String strcolspan = "";

		String strOtherCurrencyFlag = ""; // variable for finding the other currency or not  

		strSql = "SELECT RTRIM(LTRIM(convert(decimal(20,0),CASH_AMOUNT))) AS CASH_AMOUNT ,RTRIM(LTRIM(CASH_CURRENCY)) AS CASH_CURRENCY,OTHER_CURRENCY_FLAG FROM T_CASH_BREAKUP_INT WHERE TRAVEL_ID="
				+ strTravelId + " AND APPLICATION_ID=1";
		rs = dbConBean.executeQuery(strSql);
		while (rs.next()) {
			if (rs.getRow() == 1) {
				strCashAmount1 = rs.getString("CASH_AMOUNT");
				strCashCurrency1 = rs.getString("CASH_CURRENCY");
				strOtherCurrencyFlag = rs.getString("OTHER_CURRENCY_FLAG");
				if (strOtherCurrencyFlag != null
						&& strOtherCurrencyFlag.equals("y")) {
					strOtherCashAmount = strCashAmount1;
					strOtherCashCurrency = strCashCurrency1;
					strCashAmount1 = "";
					strCashCurrency1 = "USD";

				}

			}
			if (rs.getRow() == 2) {
				strCashAmount2 = rs.getString("CASH_AMOUNT");
				strCashCurrency2 = rs.getString("CASH_CURRENCY");
				strOtherCurrencyFlag = rs.getString("OTHER_CURRENCY_FLAG");
				if (strOtherCurrencyFlag != null
						&& strOtherCurrencyFlag.equals("y")) {
					strOtherCashAmount = strCashAmount2;
					strOtherCashCurrency = strCashCurrency2;
					strCashAmount2 = "";
					strCashCurrency2 = "USD";
				}
			}
			if (rs.getRow() == 3) {
				strCashAmount3 = rs.getString("CASH_AMOUNT");
				strCashCurrency3 = rs.getString("CASH_CURRENCY");
				strOtherCurrencyFlag = rs.getString("OTHER_CURRENCY_FLAG");
				if (strOtherCurrencyFlag != null
						&& strOtherCurrencyFlag.equals("y")) {
					strOtherCashAmount = strCashAmount3;
					strOtherCashCurrency = strCashCurrency3;
					strCashAmount3 = "";
					strCashCurrency3 = "USD";
				}
			}

			if (rs.getRow() == 4) {
				strOtherCashAmount = rs.getString("CASH_AMOUNT");
				strOtherCashCurrency = rs.getString("CASH_CURRENCY");
				strOtherCurrencyFlag = rs.getString("OTHER_CURRENCY_FLAG");
			}

		}
		rs.close();

		String strPageRefresh = request.getParameter("refreshFlag") == null
				? ""
				: request.getParameter("refreshFlag");

		if (strPageRefresh.equalsIgnoreCase("y")) {
			strBillingSite = request.getParameter("billingSMGSite");

		}
		// code added for making user selection not mandetory for all site for which he has access  on 09-06-2009 ----- 
		if (strBillingSite == null) {
		} else {
			strSql = "SELECT  1 AS yes FROM USER_SITE_ACCESS WHERE  (USERID = "
					+ strTravellerId
					+ ") AND (SITE_ID = "
					+ strBillingSite
					+ ")";

			rs = dbConBean.executeQuery(strSql);
			while (rs.next()) {
				strFlag = rs.getString(1);
			}
			rs.close();
		}
	%>  
	
	
	<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td width="85%" height="36" class="bodyline-top"><img src="images/headerTIT4.png?buildstamp=2_0_0"  /></td>
	    <td width="15%" align="center" class="bodyline-top"><img src="images/BigIcon.gif?buildstamp=2_0_0" width="46" height="31" /></td>
	  </tr>   
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px; padding-top:0px;">
	  <td><div align="center"><img src="images\newTabs\3.gif?buildstamp=2_0_0" width="486" height="43" /></div></td>
	  <tr>
	    <td align="center" style="padding-top:5px;">
	    <form  name="frm" action="T_IntForex_Details_Post.jsp" >                         <!--Form Start-->
	    
	   <input type="hidden" name="BillingSiteFlag" value="<%=strFlag%>" /> <!-- added on 09-06-2009 -->	 	
		<input type ="hidden" name=approverlist value="<%=ApproverText%>">  	
		<input type="hidden" name="checkMsg" value='<%=request.getParameter("message")%>' />
		  <table width="85%" border="0" cellpadding="0" cellspacing="0">
	        <tr>
	          <td background="images/index_01.png?buildstamp=2_0_0"></td>
	          <td height="29" align="left" background="images/headerBG.png?buildstamp=2_0_0"><img src="images/formTitIcon.png?buildstamp=2_0_0" width="30" height="29" align="absmiddle" /><span class="formTit">Foreign Exchange</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Company Policy" onClick="<%// code by sanjeet kumar on 16-july-2007 for giving proper information if site not uploaded.
			if (UploadFile.exists()) {%> MM_openBrWin('Companies_Policies/<%=strSiteFullName%>/<%=strSiteFullName%>.html','','scrollbars=yes,resizable=yes,width=700,height=300')<%;
			} else {%> MM_openBrWin('Companies_Policies/notexist.html','','scrollbars=yes,resizable=yes,width=700,height=300')<%;
			}%>"><img src="images/IconPolicy.png?buildstamp=2_0_0" width="69" height="16" border="0" /></a><span class="formTit" style="text-align:right">
			  <a href="#" onClick="MM_openBrWin('helpinternational travel.html#100a','','scrollbars=yes,resizable=yes,width=700,height=300')">
				  <img src="images/help.png?buildstamp=2_0_0" width="44" height="16" border="0">
			  </a>
			  </td>
	          <td background="images/index_03.png?buildstamp=2_0_0"></td>
	         </tr>
	         
	         
	         <%
	         	         	         	String sSqlStr = "";
	         	         	         	sSqlStr = "SELECT    M_SITE.SITE_NAME, dbo.CONVERTDATE(usa.C_DATE) AS c_date "
	         	         	         			+ " FROM USER_SITE_ACCESS AS usa INNER JOIN "
	         	         	         			+ " M_SITE ON usa.SITE_ID = M_SITE.SITE_ID WHERE  (usa.USERID = "
	         	         	         			+ strTravellerId + ")";

	         	         	         	rs = dbConBean.executeQuery(sSqlStr);
	         	         	         	if (rs.next()) {
	         	         	         		strlinkshowflag = "yes";
	         	         	         		strcolspan = "1";
	         	         	         	} else {
	         	         	         		strcolspan = "2";
	         	         	         		strlinkshowflag = "No";
	         	         	         	}
	         	         	         	rs.close();
	         	         	         %>
	         
	         
	         <tr>
	           <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
	           <td valign="top"> 
			     <table width="100%" border="0" cellspacing="0" cellpadding="0">   
	               <tr>
	                 <td height="25" colspan="2" valign="bottom" bgcolor="#FDF9FA" class="formfirstfield">Foreign Exchange Details <%=strMessage%> </td>  
	               </tr>
	               <tr>
				     <td height="30" colspan="<%=strcolspan%>" align="left" bgcolor="#FDF9FA" class="formtxt">Fields marked with an asterisk (<span class="starcolour">*</span>) are required. &nbsp; &nbsp;&nbsp;&nbsp;</td>
				     <%
				     	if (strlinkshowflag.equals("yes")) {
				     %>
				    
				     <td align="right" align="left" bgcolor="#FDF9FA" class="formtxt"><a href="#"    onclick="window.open('M_Myaccessunit.jsp?userId=<%=strTravellerId%>','SEARCH','scrollbars=yes,resizable=yes,width=500,height=240')";>Show My Accessible Unit(s)</a> &nbsp; &nbsp;&nbsp;</td> 
				     <%
 				     	}
 				     %>
				      
	               </tr> 
	               <tr>
	               <td height="34" colspan="2" valign="top" bgcolor="#FDF9FA" class="forminnerbrdff">
					   <table width="104%" border="0" cellpadding="0" cellspacing="0">
	                     <tr>
	                       <td height="30" colspan="4"><span class="label1">Billing Instructions</span><span class="starcolour">*</span></td>
	                     </tr>
	                     <tr> 
	                       <td height="30" colspan="6" class="label2" >In case of chargeable to <strong>self</strong>, the request will directly go to <strong>MATA </strong></td>
	                      </tr>
	                     <tr>
	                       <td ><span class="label2">Chargeable to </span></td>
	                       <!--CHARGABLE TO CLIENT-->                       
	                       <td ><input name="billing" type="radio" value="self" checked="checked"   onClick="billingOnClick(this.form)"/>
	                        <span class="label2">Self</span></td>
						   <td ><input name="billing" type="radio" value="SMG" checked="checked"   onClick="billingOnClick(this.form)"/>
	                        <span class="label2">SMG</span> </td>
						   <td >
						     <select name="billingSMGSite" class="textBoxCss" onchange="getSiteID(this.form)">        <!--Expenditure Currency-->
	<%
		//For Population of Currency Combo for the particular site
		strSql = "SELECT SITE_ID,DBO.SITENAME(SITE_ID) AS SITE_NAME FROM M_SITE WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2";

		rs = dbConBean.executeQuery(strSql);
		while (rs.next()) {
	%>
	                             <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
									<%
										}
										rs.close();
									%>
	                         </select>
	                         
							 <%
	                         							 	if (strBillingSite != null && !strBillingSite.equals("-1")
	                         							 			&& !strBillingSite.equals("0")) {
	                         							 %>
								 <script language="javascript"> 
							
									document.frm.billingSMGSite.value="<%=strBillingSite%>";
								 </script>					  
							 <%
					  							 	} else if (strBillingSite != null
					  							 			&& (strBillingSite.equals("-1") || strBillingSite
					  							 					.equals("0"))) {
					  							 %>
								 <script language="javascript">
							
									document.frm.billingSMGSite.value="<%=strSiteIdSS%>";
								 </script>					  
	
	                         <%
					  		                         	} else if (strBillingSite == null) {
					  		                         %>
								<script language="javascript">      
								
									document.frm.billingSMGSite.value="<%=strSiteIdSS%>";
								 </script>					  
							 <%
					  							 	}
					  							 %>		 		   </td>
	                       <td >
						     <input name="billing" type="radio" value="outSideSMG" checked onClick="billingOnClick(this.form)" />
						    <span class="label2">NON SMG</span> </td>                     
	
	                       <td height="30" align="left">           <!--BILLING CLIENT -->
						     <input name="billClient" type="text" class="textBoxCss" value="" onKeyUp="return test1(this, 30, 'c')"  size="34"/>
	                         <span class="formtxt2"><br>
	                             (If NON-Samvardhana group,<br>Enter the Name of the client)</span>	
							<%
									if (strBillingSite != null && strBillingSite.equals("-1")) {
								%>
							<script> 
							document.frm.billClient.value="<%=strBillingClient%>";
							</script>
	
											<%
													}
												%>
		
							</td>
	                     </tr>
						 
						  <tr> 
						    <td class="label2" colspan=2>Select  user  of billing Unit for approval  </td> <td></td><td>
							  <select name="billingSMGUser" class="textBoxCss"  <%//=strCombostate%> >      
							    <option  value="-1"'> Select user from Billing Unit </option> 
						<%-- Commented by vaibhav on Aug 20 2010
						 <% // query changed for showing user who are in approver level 1,2 or global apporver  by shiv sharma on 31- dec-2007
						        if(strBillingSite!=null && !strBillingSite.equals("0") && !strBillingSite.equals("-1") && !strBillingSite.equals(strSiteIdSS) && !strFlag.equals("1"))
								{
									   strSql =   "select userid, dbo.user_name(userid) As UserName from M_userInfo where site_id="+strBillingSite+" and status_id=10  and   ISNULL(APPROVER_LEVEL,0) <> 3  order by 2";
									  
									   rs       =   dbConBean.executeQuery(strSql);  
									   while(rs.next())
									   {
						 				  %>
										 <option value="<%=rs.getString("UserId")%>"><%=rs.getString("UserName")%></option>
						 				  <%
										}
										rs.close();
							
									}
	
								if(strBillingSite!=null  &&!strBillingSite.equals(strSiteIdSS)  && !strFlag.equals("1")   ) 
									{			 //new code added for showing approver   approver level 3    
								  strSql =   "select userid, dbo.user_name(userid) As UserName from M_userInfo where  status_id=10  and   ISNULL(APPROVER_LEVEL,0) = 3  order by 2";
									    
									   rs       =   dbConBean.executeQuery(strSql);  
									   while(rs.next())
									   {
											%>
										 <option value="<%=rs.getString("UserId")%>"><%=rs.getString("UserName")%></option>
											<%
										}
										rs.close();
								    }  
							%>
							--%>
							<%
								//code added by vaibhav on Aug 20 2010
								if (strBillingSite != null && !strBillingSite.equals("0")
										&& !strBillingSite.equals("-1")
										&& !strBillingSite.equals(strSiteIdSS)
										&& !strFlag.equals("1")) {
									strSql = "SELECT  1 "
											+ "FROM M_BILLING_APPROVER BA inner join M_userInfo UI on UI.userid = BA.approver_id "
											+ "WHERE BA.SITE_ID= " + strBillingSite
											+ " and status_id =10";

									rs = dbConBean.executeQuery(strSql);

									if (!rs.next()) {
										rs.close();
										strSql = "select distinct userid, dbo.user_name(userid) As UserName from M_userInfo "
												+ "where (site_id="
												+ strBillingSite
												+ " and status_id=10 and  ISNULL(APPROVER_LEVEL,0) in (1,2) )"
												+ "or (status_id=10 and  ISNULL(APPROVER_LEVEL,0) in (3) )"
												+ "order by 2";

										rs = dbConBean.executeQuery(strSql);
										while (rs.next()) {
							%>
											<option value="<%=rs.getString("UserId")%>"><%=rs.getString("UserName")%></option>
											<%
												}
														rs.close();
													} else {
														strSql = "SELECT distinct APPROVER_ID as userid, dbo.user_name(APPROVER_ID) As UserName "
																+ "FROM M_BILLING_APPROVER BA inner join M_userInfo UI on UI.userid = BA.approver_id "
																+ "WHERE BA.SITE_ID= "
																+ strBillingSite
																+ " and status_id =10";

														rs = dbConBean.executeQuery(strSql);
														while (rs.next()) {
											%>
											<option value="<%=rs.getString("UserId")%>"><%=rs.getString("UserName")%></option>
											<%
												}
														rs.close();
													}
												}
											%>
							</select>
							 <%
							 	if (!strPageRefresh.equalsIgnoreCase("Y")
							 			&& strBillingSite != null
							 			&& !(strBillingSite.equals("-1") || strBillingSite
							 					.equals("0"))) {
							 %>
								 <script language="javascript">
								    ///alert("tests");
								    ///alert("billing usr==="+'<%=strBillingClient%>');
									document.frm.billingSMGUser.value="<%=strBillingClient%>";
								 </script>					  
							  <%
					  							  	}
					  							  %>	
	
						  </td>
								<%
									if (strBillingSite != null && strBillingSite.equals("0")) {
								%>
								<script language= "JavaScript">
											document.frm.billing[0].checked = true;
						                    document.frm.billingSMGSite.disabled = true;        //SMG site combo disabled  
											document.frm.billClient.disabled = true;        //outSide SMG text field disabled  			
											document.frm.billingSMGUser.disabled = true;        //billing SMG user combo disabled  			
								</script>
	                      <%
	                      	} else if (strBillingSite != null && !strBillingSite.equals("-1")
	                      			&& !strBillingSite.equals("0")) {
	                      %>
								<script language= "JavaScript">
										document.frm.billing[1].checked = true;
								        document.frm.billingSMGSite.disabled = false;            //SMG site combo enabled   
										document.frm.billClient.disabled = true;	            //outSide SMG text field disabled 			
										document.frm.billingSMGUser.disabled = false;        //billing SMG user combo disabled  				
								</script>
						  <%
						  	} else if (strBillingSite != null && strBillingSite.equals("-1")) {
						  %>
								<script language= "JavaScript">
										document.frm.billing[2].checked = true;
								        document.frm.billingSMGSite.disabled = true;            //SMG site combo enabled   
										document.frm.billClient.disabled = false;           //outSide SMG text field disabled 		      
										document.frm.billingSMGUser.disabled = true;        //billing SMG user combo disabled  				
								</script>
						  <%
						  	//}  else if (strBillingClient != null && !"".equals(strBillingClient) ) {
						  %>
								<!--<script language= "JavaScript">
										document.frm.billingTo[2].checked = true;
								</script>-->
						  <%
						  	} else {
						  %>
								<script language= "JavaScript">
										document.frm.billing[1].checked = true;
								        document.frm.billingSMGSite.disabled = false;            //SMG site combo enabled   
										document.frm.billClient.disabled = true;             //outSide SMG text field disabled
								</script>
						  <%
						  	}
						  %>
							   
							</tr>		
	                   </table>				 </td>
	               </tr>
	               <tr>
	                 <td width="60%" height="34" valign="top" bgcolor="#FCF5F6" class="forminnerbrdff">
					   <table border="0" cellpadding="0" cellspacing="0">
	                     <tr>
	                       <td width="126" height="38" align="left" class="label1">Expenditure Head<span class="starcolour"></span></td>
	                       <!--EXPENDITURE HEAD-->
	                       <td width="100" height="38" align="center" valign="bottom" class="label2">Currency Preference <span class="starcolour"></span></td>
	                       <td width="70" align="center" valign="bottom" class="label2">Expenditure<br/> 
	                        Per Day </td>
	                       <td width="82" align="center" valign="bottom" class="label2">Total Tour Days<span class="starcolour"></span> </td>
	                       <td width="63" height="38" align="center" valign="bottom" class="label2">Total Forex </td>
	                     </tr>
	                     <tr>
	                       <td align="left" class="label2" >Daily Allowances<span class="starcolour"><%=strStar%></span></td><!--Daily Allowences -->
	                       <td height="30" align="center" valign="top">
						     <select name="expCurrency" class="textBoxCss">        <!--Expenditure Currency-->
								<%
									//For Population of Currency Combo for the particular site
									strSql = "Select Currency, Currency from m_currency where status_id=10";
									rs = dbConBean.executeQuery(strSql);
									while (rs.next()) {
								%>
	                             <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>  
								<%
  									}
  									rs.close();
  								%>
	                         </select>
							 <script language="javascript">
	                            document.frm.expCurrency.value="<%=strTACurrency%>";
	                         </script>					   </td>
								<%
									strSql = "SELECT RTRIM(LTRIM(EXP_ID)) AS EXP_ID,RTRIM(LTRIM(convert(decimal(20,0),ENT_PER_DAY))) AS ENT_PER_DAY, RTRIM(LTRIM(TOTAL_TOUR_DAYS))AS TOTAL_TOUR_DAYS, LTRIM(RTRIM(convert(decimal(20,0),TOTAL_EXP_ID))) AS TOTAL_EXP_ID FROM T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID="
											+ strTravelId + " AND EXP_ID=1 AND APPLICATION_ID=1";
									rs = dbConBean.executeQuery(strSql);
									if (rs.next()) {
										strEntPerDay = rs.getString("ENT_PER_DAY");
										strTotalTourDays = rs.getString("TOTAL_TOUR_DAYS");
										strTotalExpId = rs.getString("TOTAL_EXP_ID");
										/*if(strEntPerDay !=null && strEntPerDay.trim().equals("0"))
										{
										   strEntPerDay = "";
										}
										if(strTotalTourDays !=null && strTotalTourDays.trim().equals("0"))
										{
										   strTotalTourDays = "";
										}
										if(strTotalExpId !=null && strTotalExpId.trim().equals("0"))
										{
										   strTotalExpId = "";
										}*/
									}
									rs.close();
								%>
	                       <td height="30" align="center" valign="top" class="label2">
						     <input name="entitlement" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n')"  value="<%=strEntPerDay%>" size="4" align="right" />					   </td>
	                       <td height="30" align="center" valign="top" class="label2">
						     <input name="tourDays" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 3, 'n')"  value="<%=strTotalTourDays%>" size="4" align="right" />					   </td>
	                       <td height="30" align="center" valign="top" class="label2">
						     <input name="totalForex" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n')"  value="<%=strTotalExpId%>" size="4" align="right" />					   </td>
	                     </tr>
	                     <tr>
							<%
								strSql = "SELECT RTRIM(LTRIM(EXP_ID)) AS EXP_ID,RTRIM(LTRIM(convert(decimal(20,0),ENT_PER_DAY))) AS ENT_PER_DAY, RTRIM(LTRIM(TOTAL_TOUR_DAYS))AS TOTAL_TOUR_DAYS, LTRIM(RTRIM(convert(decimal(20,0),TOTAL_EXP_ID))) AS TOTAL_EXP_ID FROM T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID="
										+ strTravelId + " AND EXP_ID=2 AND APPLICATION_ID=1";
								rs = dbConBean.executeQuery(strSql);
								if (rs.next()) {
									strEntPerDay = rs.getString("ENT_PER_DAY");
									strTotalTourDays = rs.getString("TOTAL_TOUR_DAYS");
									strTotalExpId = rs.getString("TOTAL_EXP_ID");

									if (strEntPerDay != null && strEntPerDay.trim().equals("0")) {
										strEntPerDay = "";
									}
									if (strTotalTourDays != null
											&& strTotalTourDays.trim().equals("0")) {
										strTotalTourDays = "";
									}
									if (strTotalExpId != null && strTotalExpId.trim().equals("0")) {
										strTotalExpId = "";
									}
								}
								rs.close();
							%>
	
	                       <td align="left" class="label2" > Hotel Charges</td><!--Hotel Charges -->
	                       <td height="30" align="center" valign="top">&nbsp;</td>
	                       <td height="30" align="center" valign="top" class="label2">
						      <input name="entitlement" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n')"  value="<%=strEntPerDay%>" size="4" align="right"/>					   </td>
						    
	                       
	                        <!-- 
							 <input name="entitlement" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n')"  value="<%=strEntPerDay%>" size="4" align="right"/>					   </td>
	                          22-20-2007 -->    
								
	                              <td height="30" align="center" valign="top" class="label2">
						     <input name="tourDays" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 3, 'n')"  value="<%=strTotalTourDays%>" size="4" align="right"/>					   </td> 
	                         
	                           <!--
	                       <td height="30" align="center" valign="top" class="label2">
						     <input name="tourDays1" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 3, 'n')"   size="4" align="right"/>					   </td>
	                              -->
	                       <td height="30" align="center" valign="top" class="label2">
						     <input name="totalForex" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n')"  value="<%=strTotalExpId%>" size="4" align="right" />					   </td>
	                     </tr>
	                     <tr>
	<%
		strSql = "SELECT RTRIM(LTRIM(EXP_ID)) AS EXP_ID, LTRIM(RTRIM(convert(decimal(20,0),TOTAL_EXP_ID))) AS TOTAL_EXP_ID FROM T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID="
				+ strTravelId + " AND EXP_ID=3 AND APPLICATION_ID=1";
		rs = dbConBean.executeQuery(strSql);
		if (rs.next()) {
			strTotalExpId = rs.getString("TOTAL_EXP_ID");
			if (strTotalExpId != null && strTotalExpId.trim().equals("0")) {
				strTotalExpId = "";
			}
		}
		rs.close();
	%>
	                       <td align="left" class="label2" >Contingencies</td><!--Contingencies -->
	                       <td height="30" align="center" valign="top">&nbsp;</td>
	                       <td height="30" align="center" valign="top" class="label2">&nbsp;</td>
	                       <td height="30" align="center" valign="top" class="label2">&nbsp;</td>
	                       <td height="30" align="center" valign="top" class="label2">
						     <input name="contingencies" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n')"  value="<%=strTotalExpId%>" size="4" />					   </td>
	                     </tr>
	                     <tr>
	<%
		strSql = "SELECT RTRIM(LTRIM(EXP_ID)) AS EXP_ID, LTRIM(RTRIM(convert(decimal(20,0),TOTAL_EXP_ID))) AS TOTAL_EXP_ID FROM T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID="
				+ strTravelId + " AND EXP_ID=4 AND APPLICATION_ID=1";
		rs = dbConBean.executeQuery(strSql);
		if (rs.next()) {
			strTotalExpId = rs.getString("TOTAL_EXP_ID");
			if (strTotalExpId != null && strTotalExpId.trim().equals("0")) {
				strTotalExpId = "";
			}
		}
		rs.close();
	%>
	                       <td height="30" colspan="2" align="left" class="label2" >Any Other Expenditure</td><!--Any Other Expenditure -->
	                       <td height="30" colspan="2" align="center" valign="top" class="label2">&nbsp;</td>
	                       <td height="30" align="center" valign="top" class="label2">
						     <input name="contingencies" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n')"  value="<%=strTotalExpId%>" size="4"/>					   </td>
	                     </tr>
	
	                     <tr>
	                       <td align="left" class="starcolour" >&nbsp;</td>
	                       <td height="30" align="center" valign="top">&nbsp;</td>
	                       <td height="30" align="center" valign="top" class="label2">&nbsp;</td>
	                       <td height="30" align="right" class="label2"><span class="starcolour">Total</span></td>  <!--Total Amount-->
	                       <td height="30" align="center" valign="top" class="label2">
						     <input name="grandTotalForex" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n')" value="<%=strTotalAmount%>"  size="4" />					   </td>
	                     </tr>
	                     <tr>
	                       <td class="formfirstfield" >&nbsp;</td>
	                       <td align="center">&nbsp;</td>
	                       <td align="center" class="label2">&nbsp;</td>
	                       <td align="center" class="label2">&nbsp;</td>
	                       <td align="center" class="label2">&nbsp;</td>
	                     </tr>
	                  </table>
					 </td>
	<!--Added by sachin 3/15/2007 start-->
					  <%
					  	if (strBillingSite != null && strBillingSite.equals("0")) {
					  %>
								<script language= "JavaScript">
									document.frm.elements[6].readOnly = true;
									document.frm.elements[7].readOnly = true;
									document.frm.elements[8].readOnly = true;
								</script>
	                      <%
	                      	} else if (strBillingSite != null && !strBillingSite.equals("-1")
	                      			&& !strBillingSite.equals("0")) {
	                      %>
								<script language= "JavaScript">
									document.frm.elements[6].readOnly = false;
									document.frm.elements[7].readOnly = false;
									document.frm.elements[8].readOnly = false;
								</script>
						  <%
						  	} else if (strBillingSite != null && strBillingSite.equals("-1")) {
						  %>
								<script language= "JavaScript">
									document.frm.elements[6].readOnly = false;
									document.frm.elements[7].readOnly = false;
									document.frm.elements[8].readOnly = false;
								</script>
						  <%
						  	//}  else if (strBillingClient != null && !"".equals(strBillingClient) ) {
						  %>
								<!--<script language= "JavaScript">
										document.frm.billingTo[2].checked = true;
								</script>-->
						  <%
						  	} else {
						  %>
								<script language= "JavaScript">
									document.frm.elements[6].readOnly = false;
									document.frm.elements[7].readOnly = false;
									document.frm.elements[8].readOnly = false; 
								</script>
						  <%
						  	}
						  %>
	<!--Added by sachin 3/15/2007 end-->
					
	
	
	                 <td width="40%" valign="top" bgcolor="#FCF5F6" class="forminnerbrdff">
					   <table width="100%" border="0" cellpadding="0" cellspacing="0">
	                     <tr>
	                       <td height="38" valign="bottom" class="label2">Remarks</td>
	                     </tr>
	                     <tr>
	                       <td height="95" valign="top" >
						     <textarea name="expRemarks" cols="30" rows="5" class="textBoxCss" onKeyUp="return test1(this, 100, 'all')" ><%=strExpRemarks%></textarea><!-- Expenditure Remark -->					   </td>
	                     </tr>
	                     <tr>
	                       <td ><span class="formtxt2">Please Specify the reason for Contingencies/Any Other Expenditure.</span></td>
	                     </tr>
	                  </table>				 </td>
	               </tr>
	               <tr>
				     <td height="34" colspan="2" valign="top" bgcolor="#FDF9FA" class="forminnerbrdff">
					   <table width="100%" border="0" cellpadding="0" cellspacing="0"> 
					     <tr>
	                       <td height="30" colspan="2" align="left" bgcolor="#FDF9FA" class="label2" valign="bottom"><span class="label1">Kindly put your currency denomination details</span><span class="starcolour"></span></td>
	                       <%
	                       	if (strforPriceDesicion.equalsIgnoreCase("y")) {
	                       %>
	                       
	                       
	                       <td height="30" colspan="2" align="left" bgcolor="#FDF9FA" class="label2">Would you be checking the ticket pricing from alternate service provider as well? <input type="radio" name="tkflyes" onclick="showdiv('y')" checked="checked" value="y" > No <input type="radio" name="tkflyes" onclick="showdiv('n')" value="n"> Yes  </td>
	                         
						       <%
	                         						       	}
	                         						       	String strText = "display:none";

	                         						       	if (strforPriceDesicion.equalsIgnoreCase("y")) {
	                         						       		if (strTicketProvider.equals("n")) {

	                         						       			strText = "";
	                         						       %>
	                    	  <script language= "JavaScript">
	                    		document.frm.tkflyes[0].checked = false;
								document.frm.tkflyes[1].checked = true;
								//document.getElementById("showdiv").style.display =""; 
							</script>
							<%
								} else {
										strText = "display:none";
							%>
							  	  <script language= "JavaScript">   
		                    		document.frm.tkflyes[0].checked = true;
									document.frm.tkflyes[1].checked = false;
									//document.getElementsByName("showdiv").style.display ="none";  
								  </script>
								<%
									}
									}
	                      		if (strSHOW_BUD_INPUT.equalsIgnoreCase("Y")) {
								%>
	                      <td height="30" colspan="2" align="left" bgcolor="#FDF9FA" class="label2" valign="bottom"><span class="label1">Budget Actual Details</span><span class="starcolour">*</span></td>
	                      <%} %>
	                     </tr>
	                     <tr>
	                       <td colspan="2" width="50%" valign="top">  
						     <p>
						       <textarea name="cashBreakupRemarks" cols="60" rows="7" class="textBoxCss" onKeyUp="return test1(this, 300, 'all')"><%=strCashBreakupRemarks%></textarea> 
						       <!-- CASH BREAKUP REMARKS -->					   
						       <br>
						         <span class="formtxt2">(Currency, Cash, Travellers Cheque, Total)<br>
				              </span></p>
						    
						     </td>

					<script>
						function showDiff(){
							var YtmBud = document.frm.YtmBud.value;
							var YtmAct = document.frm.YtmAct.value;
							if(isNaN(parseFloat(YtmBud) - parseFloat(YtmAct)))
								document.frm.AvailBud.value = '0.0';
							else
								document.frm.AvailBud.value = parseFloat(YtmBud) - parseFloat(YtmAct); 
						}
					</script>

					<td valign="top"><%
						if (strSHOW_BUD_INPUT.equalsIgnoreCase("Y")) {
					%>
								<table width="100%" cellspacing="0" cellpadding="0">
									<tr>
										<td bgcolor="#FDF9FA" class="label2">YTM Budget</td>
										<td><input type="text" name="YtmBud" size="10"
											onChange="check1();showDiff();" onKeyUp="return test1(this, 15, 'n')"
											class="textBoxCss" maxlength="15"> <script
											language="javascript">
                      		   document.frm.YtmBud.value="<%=dbl_YTM_BUDGET%>";
                     		 </script></td>
										<td bgcolor="#FDF9FA" class="label2">YTD Actual</td>
										<td><input type="text" name="YtmAct" size="10"
											onChange="check1();showDiff();" onKeyUp="return test1(this, 15, 'n')"
											class="textBoxCss" maxlength="15"> <script
											language="javascript">
                      		   document.frm.YtmAct.value="<%=dbl_YTD_ACTUAL%>";
                     		 </script></td>
									</tr>
									<tr>
										<td bgcolor="#FDF9FA" class="label2" nowrap="true">Available
										Budget</td>
										<td><input type="text" name="AvailBud" size="10"
											onChange="" onKeyUp=""
											class="textBoxCss" maxlength="15" readonly="readonly"> <script
											language="javascript">
                      		   document.frm.AvailBud.value="<%=dbl_AVAIL_BUDGET%>";
                     		 </script></td>
										<td bgcolor="#FDF9FA" class="label2" nowrap="true">Estimated
										Expenditure</td>
										<td><input type="text" name="EstExp" size="10"
											onChange="check1();" onKeyUp="return test1(this, 15, 'n')"
											class="textBoxCss" maxlength="15"> <script
											language="javascript">
                      		   document.frm.EstExp.value="<%=dbl_EST_EXP%>";
                     		 </script></td>
									</tr>
									<tr>
										<td bgcolor="#FDF9FA" class="label2">Remarks</td>
										<td colspan="3"><textarea name="budgetRemarks" cols="55"
											rows="2" class="textBoxCss"
											onKeyUp="return test1(this, 100, 'all')"><%=str_EXP_REMARKS.trim()%></textarea>
										</td>
									</tr>

								</table>
								<%}%>
					<br>
						     <%
						     	// System.out.println(strforPriceDesicion);
						     	// strforPriceDesicion = "y";
						     	if (strforPriceDesicion.equalsIgnoreCase("y")) {
						     %>
							       <div id="showdiv" style="<%=strText%>"><!--
						   <div id="showdiv">    
						      --><table width="80%" border="0" cellpadding="0" cellspacing="0" >  
								<TR>
									<TD bgcolor="#FDF9FA" class="label2">Airline</TD>  
									<TD bgcolor="#FDF9FA" class="label2">Currency</TD>
									<TD bgcolor="#FDF9FA" class="label2">Local Price</TD>
									<TD bgcolor="#FDF9FA" class="label2">Remarks</TD>  
								</TR>
								<TR>  
									<TD bgcolor="#FDF9FA" valign="top">
									<input type="text" name="airline" size="8"  class="textBoxCss"  maxlength="30">
									 <script language="javascript">
	                         		   document.frm.airline.value="<%=strAirLineName.trim()%>";
	                        		 </script>
									
									 </TD>
									<TD bgcolor="#FDF9FA" valign="top"> 
									<select name="currency" class="textBoxCss">        Expenditure Currency
								<%
 										//For Population of Currency Combo for the particular site
 											strSql = "Select Currency, Currency from m_currency where status_id=10";
 											rs = dbConBean.executeQuery(strSql);
 											while (rs.next()) {
 									%>
	                             <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>  
								<%
  									}
  										rs.close();
  								%>
	                         </select>
							 <script language="javascript">
	                            document.frm.currency.value="<%=strCurreny.trim()%>"; 
	                         </script>	
	                         	
									</TD>
									<TD bgcolor="#FDF9FA" valign="top"> 
									<input type="text" name="localprice" size="8" class="textBoxCss2" onKeyUp="return test1(this, 10, 'n')"   >
									
									 <script language="javascript">
	                         		   document.frm.localprice.value="<%=strAmount.trim()%>";
	                        		 </script>
									
									
									</TD>
									<TD bgcolor="#FDF9FA" valign="top">    
									<textarea name="pricingRemarks" cols="26" rows="3" class="textBoxCss" 
									onKeyUp="return test1(this, 100, 'all')"  ><%=strRemarks.trim()%></textarea> 
									</TD>
								</TR>
								</TABLE>
						      </div>
						  <%
						  	}
						  %>
						      
						      
						    </td>
	                     </tr>
	                   </table>				 
					   </td>
	                </tr>
	               
	               <tr>
	                 <td colspan="2" align="left" bgcolor="#FDF9FA" class="newformbot"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                   <tr>
	                    <td align="left" bgcolor="#FDF9FA" class="newformbot">
						<!-- code added by Sanjeet on 27-July-2007  -->
					   <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=I&whichPage=T_IntForex_Details.jsp&targetFrame=no','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')" title="Add Attachments"><img src="images/AttachFile.gif?buildstamp=2_0_0" width="94" height="24" border="0" /></a>				 </td>
	                 <td align="right" bgcolor="#FDF9FA" class="newformbot">
					   <input name="back" type="button" class="formButton" onClick="return onClick=backPage(frm)" value="Back"/> 
			           <input name="saveExit" type="submit" class="formButton" onClick="return checkData(this.form,'saveExit');" value="Save &amp; Exit"/> 
	                   <input name="save" type="submit" class="formButton" onClick="return checkData(this.form,'save');" value="Save"/> 
	                   <input name="saveProceed" type="submit" class="formButton" onClick="return checkData(this.form,'saveProceed');" value="Submit To WorkFlow"/>				 </td>
	                   <input type="hidden" name="matapricecomp" value="<%=strforPriceDesicion%>" />
	                     </tr>
	                 </table></td>
	                </tr>
	            </table>	      </td>
	          <td width="15" background="images/index_03.png?buildstamp=2_0_0"></td>
	        </tr>
	        <tr>
	          <td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
	          <td height="20" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
	          <td width="15" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
	        </tr>
	      </table>
	      <input type="hidden" name="travelId" value="<%=strTravelId%>"/> <!--  HIDDEN FIELD  -->
	      <input type="hidden" name="travelReqId" value="<%=strTravelReqId%>"/> <!--  HIDDEN FIELD  -->
	      <input type="hidden" name="travelReqNo" value="<%=strTravelReqNo%>"/> <!--  HIDDEN FIELD  -->
		  <input type="hidden" name="travellerSiteId" value="<%=strTravllerSiteId%>"/> <!--  HIDDEN FIELD  -->
	      <input type="hidden" name="travellerId" value="<%=strTravellerId%>"/> <!--  HIDDEN FIELD  -->
	      <input type="hidden" name="whatAction"/> <!--  HIDDEN FIELD  -->
		  <INPUT TYPE = "hidden" name = "interimId" value = "<%=strInterimId%>" />
		  <INPUT TYPE = "hidden" name = "refreshFlag" value = "n" />
		</form><!--Form End-->
		</td>
	  </tr>  
	</table>
	 </body>