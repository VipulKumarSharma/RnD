		<%
			/***************************************************
			 *The information contained here in is confidential and 
			 * proprietary to MIND and forms the part of the MIND 
			 *Author				                   :Shiv sharma 
			 *Date of Creation 					: 17-Feb-08
			 *Copyright Notice 					:Copyright(C)2000 MIND.All rights reserved 
			 *Project	  								:STARS
			 *Operating environment			:Tomcat, sql server 2000 
			 *Description 		     				:This is  jsp file  for create the Group Travel Requsition
			 *Modification 	    					:code added by shiv  
													:Change text for  Non Sumi Motherson   to  Non samvardhana on 03-Sep-09  by shiv sharma
													:added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
			 *Reason of Modification:
			 *Date of Modification  : 
			 *Modified By	  :			
			 *Editor				:Editplus

			 :Modified by vaibhav on Aug 20 2010to show only authorised approver in case if billing site is     different. 
			 *Modified by Pankaj Dubey on 11 Nov 2010 to add 5 new fields to record budgetory figures.
			 
			 *Modified By	  :Manoj Chand
			 *Date of Modification : 25 jan 2011
			 *Modification 	  :sorting the approver level 1 and 2
			 
			 *Modified By	  :Manoj Chand
			 *Date of Modification : 25 march 2011
			 *Modification 	  :Adding alert for approvers if they are in default approvers.
			 
			 *Modified By	  :Manoj Chand
			 *Date of Modification : 07 Oct 2011
			 *Modification 	  :work in designing of page and remove remarks textarea
			 
			 *Modified By	  :Manoj Chand
			 *Date of Modification : 22 Nov 2011
			 *Modification 	  :Implement feature for buying ticket from non-mata source
			 
			 *Modified By	  :Manoj Chand
			 *Date of Modification : 21 Feb 2012
			 *Modification 	  :Adding validation for buying ticket from non-MATA source
			 
			 *Modified By	  :Manoj Chand
			 *Date of Modification : 29 Mar 2012
			 *Modification 	  :Adding Dropdown for Board Member for SMP site.
			 
			 *Modified By	  :Manoj Chand
			 *Date of Modification : 04 Apr 2012
			 *Modification 	  :add a check for unit head approval level 1 and 2 selection is not mandatory in SMP site.
			 
			 *Modification				:Multilingual functionality added
			 *Modified by				:Manoj Chand
			 *Date of Modification		:24 May 2012
			 
			 *Modified By					:Manoj Chand
			 *Date of Modification			:03 July 2011
			 *Modification					:change query to remove closed unit from unit dropdown
			 
			 *Modified By	        	:MANOJ CHAND
			 *Date of Modification  		:19 OCT 2012
			 *Description				:IMPLEMENT SITE WISE FLAG TO SHOW BOARD MEMBER IN SMP
			 
			 *Modified By	        	:MANOJ CHAND
			 *Date of Modification  	:29 NOV 2012
			 *Description				:IMPLEMENT TOTAL TRAVEL FARE FOR SMP SITE
			 
			 *Modified By	        	:MANOJ CHAND
			 *Date of Modification  	:24 JAN 2013
			 *Description				:ADD BUS/CAR/VAN IN MODE AND FETCH MODE VALUES FROM TABLE M_TRAVEL_MODE.
			 
			 *Modified By	        :MANOJ CHAND
			 *Date of Modification  :31 Jan 2013
			 *Description			:IE Compatibility Issue resolved
			 
			 *Modified By	        :MANOJ CHAND
			 *Date of Modification  :17 Apr 2013
			 *Description			:add status_id=10 condition existing query 
			 
			 *Modified By			:Manoj Chand
			 *Date of Modification	:03 June 2013
			 *Modification			:Provision to display other site user in approval level 1 or 2.
			 
			 *Modified By			:Manoj Chand
			 *Date of Modification	:20 June 2013
			 *Modification			:Resolve issue related to alert of delegate autority is coming while submitting group/guest travel request in mozilla,chome and safari.
			 
			 *Modified By			:Manoj Chand
			 *Date of Modification	:24 July 2013
			 *Modification			:Mandatory selection of approval level 1 and 2 for mssl site.
			 
			 *Modified By			:Manoj Chand
			 *Date of Modification	:22 Oct 2013
			 *Modification			:javascript validation to stop from typing --,'  symbol is added.
			 *******************************************************/
		%>
		<%@ include  file="application.jsp" %>
		<%@ page pageEncoding="UTF-8"%>
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml"> 
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Create Group/Guest Travel Request</title>
		<link href="style/jquery-ui-1.9.2.css?buildstamp=2_0_0" rel="stylesheet" type="text/css"/>
		<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
		</head>
		<%-- include remove cache  --%>
		<%@ include  file="cacheInc.inc" %>
		<%-- include header  --%>
		<%@ include  file="headerIncl.inc" %>
		<%-- include page with all application session variables --%>

		<!--Create the DbConnectionBean object for createConnection-->
		<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
		<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
		<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>	
		<!-- script used in files  -->
		<%@ include file="M_InsertProfile.jsp"  %>
		<script language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></script>
		<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
		<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
		<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
		<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
		<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
		<SCRIPT language="JavaScript" src="ScriptLibrary/popcalendar.js?buildstamp=2_0_0"></SCRIPT>
		<SCRIPT language="JavaScript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></SCRIPT>
		<script type="text/javascript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script> 
    	<script type="text/javascript" src="ScriptLibrary/jquery-ui-1.9.2.js?buildstamp=2_0_0"></script> 
    	<script type="text/javascript" src="ScriptLibrary/jquery-ui-autocomplete.js?buildstamp=2_0_0"></script>
    	
		<script language=JavaScript>
    
	 // initialize airport name from database 
		function initializeAirPortName(elId) {
			var timer;
	   		var typingTimer;              
	   	   	var doneTypingInterval = 200; 
	   	   	
	   	   	$(elId).keyup(function() { 
	   	   		if (timer) { 
	   	   			timer.abort();
	   	   		} 
	   	   	    clearTimeout(typingTimer);
	   	   	    if ($(elId).val) {
	   	   	        typingTimer = setTimeout(function() {
	   	   	        	timer = doneTyping(elId);	
	   	   	        }, doneTypingInterval);
	   	   	    }
	   	   	});	   	
		}
	   	
	   	function doneTyping(elId) {
	   	   	$(elId).autocomplete({
	   	   		delay: 500,
				source : function(request, response) {
	            	airPortName = "";            	
		            $.ajax({
		            	 type: "get",
						 url: "AutoCompleteServlet",
						 data: { term: $(elId).val(), airPortName: $(elId).val(), tempFlag:  "airMode", field: "tempFlag"},
		                 dataType: "json",
		                    success : function(data) {response(data);}
		            	});
			    	}
				});
	   	   	}
	   	</script>
   	
   <%
   request.setCharacterEncoding("UTF-8");
		//code added by Gurmeet Singh on 17 january 2014
		String strManagerSelected = "";
		String strHodSelected = "";
		String strBoardMemberSelected = "";
   			String strSql1="";
   			String strSiteId="";
			strSiteId=request.getParameter("site")==null?strSiteIdSS:request.getParameter("site");
			//System.out.println("strsiteid--itinerary---->"+strSiteId);
			String strSHOW_BUD_INPUT = "N";
			//change by manoj 
			strSql1 = "SELECT SHOW_BUD_INPUT FROM M_SITE WHERE site_id = "+strSiteId+" ";
			//System.out.println("panakj ===================== "+strSql1);
			ResultSet rs12 = dbConBean.executeQuery(strSql1);
			while (rs12.next()) {
				strSHOW_BUD_INPUT = rs12.getString(1);
			}
			rs12.close();
			
			rs12=null;
			String strAppLvl3flg = "";
			String strAppLvl3flgforBM = "";
			String strMandatatoryApvFlag = "";
			//code added by manoj chand on 28 march 2012 to CHECK WHETHER DIVISION OF USER IS SMP OR NOT.
			strSql1="SELECT SHOW_APP_LVL_3 FROM M_DIVISION MD INNER JOIN	M_USERINFO MU ON MU.DIV_ID=MD.DIV_ID WHERE USERID="+Suser_id;
			//System.out.println("strSql --->"+strSql);
			rs12       =   dbConBean.executeQuery(strSql1);  
			if(rs12.next())
			{
				strAppLvl3flg=rs12.getString("SHOW_APP_LVL_3");
				//System.out.println("strAppLvl3flg-grDOM-->"+strAppLvl3flg);
			}
			rs12.close();
			
			rs12=null;
			//code added by manoj chand on 04 April 2012 to get unit head flag.
			String strUnit_Head="0";
			strSql1="SELECT A.UNIT_HEAD FROM USER_MULTIPLE_ACCESS AS A INNER JOIN M_USERINFO AS B ON A.USERID = B.USERID WHERE (A.STATUS_ID = 10) AND (B.STATUS_ID = 10) AND (A.UNIT_HEAD = 1) AND A.USERID = "+Suser_id+" AND A.SITE_ID = "+strSiteId+" ";
			//System.out.println("strSql1--->"+strSql1);
			rs12= dbConBean.executeQuery(strSql1); 
			if (rs12.next()) {
				strUnit_Head = rs12.getString("UNIT_HEAD");	
			}
			rs12.close();
			
			//code added by manoj chand on 19 oct 2012 to CHECK WHETHER site OF USER IS SMP OR NOT.
			strSql1="SELECT SHOW_APP_LVL_3,MANDATORY_APP_FLAG FROM dbo.M_SITE ms WHERE ms.STATUS_ID=10 and ms.SITE_ID="+strSiteId;
			rs12       =   dbConBean.executeQuery(strSql1);  
			if(rs12.next())
			{
				strAppLvl3flgforBM=rs12.getString("SHOW_APP_LVL_3");
				strMandatatoryApvFlag=rs12.getString("MANDATORY_APP_FLAG");
			}
			rs12.close();
			
			//added by Gurmeet Singh on 24 jul 2015 to get site base currency
			String strBaseCur="INR";		  	
		  	strSql1 = "SELECT ISNULL(CURRENCY,'') AS BASE_CUR FROM dbo.M_SITE ms WHERE ms.STATUS_ID=10 AND ms.SITE_ID="+strSiteId;
		  	rs12 = dbConBean.executeQuery(strSql1);
			if(rs12.next()) {
				strBaseCur = rs12.getString("BASE_CUR");
			}
			rs12.close();
			
			String strDeptDate=request.getParameter("fwddepDate")==null?"":request.getParameter("fwddepDate");		
	%>
		<script  language=JavaScript >
		   window.history.forward(1);  
		
		
			function getUserID2()
				{
					document.frm.action="Group_itinerary_details_DOM.jsp";
					document.frm.refreshFlag.value="1"; 
				    document.frm.travelClass.value="1"; 
				
					document.frm.submit();
				}
		
		   function button_onclick(obj) 
			    {
				             popUpCalendar(obj,obj,"dd/mm/yyyy"); 
				}
		
		
	 //function for showing the default approver list
	function defaultApproverList(frm)
	{
		//var siteId = document.frm.site.value;
		//change by manoj
		var siteId = '<%=strSiteId%>';
		var url = 'T_DefaultApproverList.jsp?traveltype=DOM&siteId='+siteId;
		window.open(url,'DefaultApprovers','scrollbars=yes,resizable=no,width=550,height=350');
	}
	
	function MM_openBrWin(theURL,winName,features)
	 { 
			   window.open(theURL,winName,features);
	 }

function childwindowSubmit(){
	
}

	
	
	function BackPage(frm)
			{
			   document.frm.action="Group_T_TravelDetail_Dom.jsp";
			 
	     	   document.frm.submit();
			}
	function getSiteID(frm)
	       { 
	        //alert(document.frm.billingSMGSite.value);
		    document.frm.action="Group_itinerary_details_DOM.jsp";
			document.frm.refreshFlag.value="1"; 
	       document.frm.submit();
	       }
	
	
		function test1(obj1, length, str)
		{ 	
				var obj;
				if(obj1=='budgetRemarks')
				{
					obj = document.frm.budgetRemarks;
					upToTwoHyphen(obj);
				}
				if(obj1=='YtmBud')
				{
					obj = document.frm.YtmBud;
				}
				if(obj1=='YtmAct')
				{
					obj = document.frm.YtmAct;
				}
				if(obj1=='AvailBud')
				{
					obj = document.frm.AvailBud;
				}
				if(obj1=='EstExp')
				{
					obj = document.frm.EstExp;
				}
				if(obj1=='depCity')
				{
					obj = document.frm.depCity;
				}
				if(obj1=='arrCity')
				{
					 obj = document.frm.arrCity;
				}
				if(obj1=='nameOfAirline')
				{
					 obj = document.frm.nameOfAirline;
				}
				if(obj1=='billClient')
				{
					 obj = document.frm.billClient;
				}  
					if(obj1=='reasonForSkip')
				{
					 obj = document.frm.reasonForSkip;
					 upToTwoHyphen(obj);
				}  
	
				if(obj1=='reasonForTravel')
				{
					 obj = document.frm.reasonForTravel;
					 upToTwoHyphen(obj);
				}
	
					if(obj1=='expRemarks')
				{
					 obj = document.frm.expRemarks;
					 upToTwoHyphen(obj);
				}
				
				if(obj1=='Remarks')
				{
					 obj = document.frm.Remarks; 
					 upToTwoHyphen(obj);
				}    
				if(obj1=='airline')
				{
					 obj = document.frm.airline; 
				}
				if(obj1=='localprice')
				{
					 obj = document.frm.localprice; 
				}
				if(obj1=='pricingRemarks')
				{
					 obj = document.frm.pricingRemarks;
					 upToTwoHyphen(obj); 
				}
				//added by manoj chand on 27 nov 2012 to implement  for fare amount
				if(obj1=='fareamount')
				{
					 obj = document.frm.TotalFareAmount;
				} 
				
				 
	  
				charactercheck(obj,str);
				limitlength(obj, length);
				//zeroChecking(obj); //function for checking leading zero and spaces
				spaceChecking(obj);
		} //end of function of tets1 
	
		//Checking the date of departure and arrival date from the current date(second date should not be the smalle from the first date  
		function checkDate10(form1,firstDate,secondDate,firstDateName,secondDateName,message1,message2)
		{
					//Second date should be equal or greater from the first date
					//get today date info
					var todayDate=firstDate;                //today date
					var dDate=secondDate;
		
					var d=todayDate.substr(6,4);
					var year=parseInt(d,10);
		
					var a =todayDate.substr(3,2);
					var month=parseInt(a,10);
		
					var c =todayDate.substr(0,2);
					var day=parseInt(c,10);
		
					//get Reaching Date at Destination information
					var f=dDate.substr(6,4);
					var year1=parseInt(f,10);
		
					var b=dDate.substr(3,2);
					var month1=parseInt(b,10);
		
					var h=dDate.substr(0,2);
					var day1=parseInt(h,10);
					//alert('34343year-->'+year+'\n'+'month-->'+month+'\nday-->'+day+'\nyear1-->'+year1+'\nmonth1--->'+month1+'\nday1--->'+day1);
					if(year>year1)
					{
						 alert(message1);
						 secondDateName.value="";
						 secondDateName.focus();
						 return false;
					}//end of if
					
					if((year==year1)&&(month>month1))
					{
						 alert(message1);
						 secondDateName.value="";
						 secondDateName.focus();
						 return false;
					}//end of elseif
					
					if((year==year1)&&(month==month1)&&(day>day1))
					{		
						 alert(message1);
						 secondDateName.value="";
						 secondDateName.focus();
						 return false;
					}//end of elseif
		}
			
	 function  checkData(f1,actionFlag,fieldcheck)
	    {
	        f1.whatAction.value=actionFlag;     
          // if no user to return then these fielde not required to check  
	       if(fieldcheck=='required')
	        {
						if(f1.depCity.value=="")
						{
							alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
							f1.depCity.focus();
							return false;
						}
						if(f1.arrCity.value=="")
						{
							alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
							f1.arrCity.focus(); 
							return false;
						}
						if(f1.depDate.value=="")
						{
							alert('<%=dbLabelBean.getLabel("alert.global.departuredate",strsesLanguage)%>');
							f1.depDate.focus();
							return false;
						}
				     	if(f1.nameOfAirline.value=="")
						{
							alert('<%=dbLabelBean.getLabel("alert.global.preferredairlinetraincab",strsesLanguage)%>');
							f1.nameOfAirline .focus();
							return false;
						}
				 
				     //validation for date  departure date 
				      var todayDate  =  f1.todayDate.value;  
				      var depDate    =  f1.depDate.value;
				      				      
				      var flag1 = checkDate10(f1,todayDate,depDate,f1.todayDate,f1.depDate,'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
				      if(flag1 == false)
				  	   return flag1;
				      var flag2 = checkDate10(f1,'<%=strDeptDate%>',depDate,'',f1.depDate,'<%=dbLabelBean.getLabel("alert.global.departuredateofreturnjourneynotsmallerthandeptdateoffwdjourney",strsesLanguage)%>','no');
				      if(flag2 == false)
				  	   return flag2;
				  	   
		  	 }else 
		  	   { 
		  	   f1.depCity.value="";
		  	   f1.arrCity.value="";
		  	   f1.depDate.value="";
		  	   f1.nameOfAirline.value="";
		  	 }  

	     //code added by manoj chand on 23 july 2013 to make mandatory selection of user for mssl unit.
			  var var_mand_flag = '<%=strMandatatoryApvFlag%>';
			  if(var_mand_flag=='Y'){
			  	if(f1.manager.value=='S' || f1.hod.value=='S'){
			  		alert('<%=dbLabelBean.getLabel("alert.createrequest.bothapprovallevelismandatory",strsesLanguage)%>');
			  		if(f1.manager.value=='S')
			  			frm.manager.focus();
			  		else
			  			frm.hod.focus();
			  		return false;
			  	}
			  	
			  }
			  else{
		  	          
	     //code added by manoj chand on 28 March 2012 to validate at least one level approver is selected.
	     //code added by manoj chand on 04 April 2012 this check will work only when travel is not equal to unit head.
			var divflag='<%=strAppLvl3flg%>';
			var unitHeadFlag='<%=strUnit_Head%>';
			if(divflag=='Y' && unitHeadFlag!='1'){
				if(f1.manager.value=='S' && f1.hod.value=='S'){
					alert('<%=dbLabelBean.getLabel("alert.global.approvallevel1or2",strsesLanguage)%>');
					frm.manager.focus();
					return false;
				}
			}
			
	     // validation for approvere skippig  --------------->
			if((f1.manager.value == 'S' || f1.manager.value == '') && (f1.hod.value == 'S' || f1.hod.value == '')) 
				{
				   //alert("Please select the Manager");
				   //alert("Please select the Approval Level 1 or Approval Level 2 or both");
				   if(f1.reasonForSkip.value == '')
				   {
						alert('<%=dbLabelBean.getLabel("alert.global.reasonforskippingapprovallevel1or2",strsesLanguage)%>');
					   //f1.manager.focus();
					   frm.reasonForSkip.focus();				
					   return false;  
				   }
				}
				else if((f1.manager.value == 'S' || f1.manager.value == '') && (f1.hod.value != 'S' || f1.hod.value != ''))  
				{
				   if(f1.reasonForSkip.value == '')
				   {
						alert('<%=dbLabelBean.getLabel("alert.global.reasonforskippingapprovallevel1",strsesLanguage)%>');
						frm.reasonForSkip.focus();				
						return false;  
				   }
				}
				else if((f1.manager.value != 'S' || f1.manager.value != '') && (f1.hod.value == 'S' || f1.hod.value == ''))
				{
				   if(f1.reasonForSkip.value == '')
				   {
						alert('<%=dbLabelBean.getLabel("alert.global.reasonforskippingapprovallevel2",strsesLanguage)%>');
						frm.reasonForSkip.focus();				
						return false;  
				   }
				}
			  }//else block

			
			//code added by manoj chand on 28 March 2012 to make mandator selection for board member
			var smpsitebmflag_val='<%=strAppLvl3flgforBM%>';
			if(smpsitebmflag_val=='y' && f1.boardmember!=undefined){
				if((f1.boardmember.value!=null && (f1.boardmember.value=='B' || f1.boardmember.value==''))){
					alert('<%=dbLabelBean.getLabel("alert.global.boardmember",strsesLanguage)%>');
					frm.boardmember.focus();
					return false;
				}
			}


			
			   // validation for reason for travel skippig  ------ ---------->   
				if(f1.reasonForTravel.value == "")
					{
						alert('<%=dbLabelBean.getLabel("alert.global.enterreasonfortravel",strsesLanguage)%>');
						f1.reasonForTravel.focus();
						return false;	
					}
	
	
	     
		
		 var tt = document.frm.BillingSiteFlag.value;
		 
		 
		//change by manoj 	 
		if (document.frm.billingSMGSite.value!='<%=strSiteId%>'  && tt!='1')  
				{  	
			      if(!f1.billing[1].checked)
					  {
	        				if(document.frm.billingSMGUser.value=="-1")
			 				 {
							alert('<%=dbLabelBean.getLabel("alert.global.approverfrombillingsite",strsesLanguage)%>');
							document.frm.billingSMGUser.focus();
							return false;
							 }
				  }
				}
	
	
		if(f1.billing[1].checked)
		{  
			if(f1.billClient.value=="")
			{
				alert('<%=dbLabelBean.getLabel("alert.global.detailsofclient",strsesLanguage)%>');
				f1.billClient.focus();
				return false;
			}
				
		}

		//added by manoj chand on 22 nov 2011
		  if(document.frm.matapricecomp.value=='y'){
			   if(f1.tkflyes[0].checked){ 
			     //alert("YES");
			   }
			    if(f1.tkflyes[1].checked) 
			    {  
			    	//if condition added by manoj chand on 21 feb 2012
			    	if(f1.airline.value==""){
				   		alert('<%=dbLabelBean.getLabel("alert.global.airline",strsesLanguage)%>');
				   		f1.airline.focus();
				   		return false;
				   	}
			   	   //currency localprice pricingRemarks
					if(f1.airline.value!=""){
					
						if(f1.currency.value=="-1"){  
						
							alert('<%=dbLabelBean.getLabel("alert.global.currency",strsesLanguage)%>');  
							f1.currency.focus(); 
							return false;
						}
						if(f1.localprice.value==""){  
						
							alert('<%=dbLabelBean.getLabel("alert.global.localprice",strsesLanguage)%>');  
							f1.localprice.focus(); 
							return false;
						}
						if(f1.pricingRemarks.value==""){
						
							alert('<%=dbLabelBean.getLabel("alert.global.remarks",strsesLanguage)%>');  
							f1.pricingRemarks.focus(); 
							return false;
						}
				   }		
				}	
			   
			  } 





		
		if(actionFlag == "saveProceed")
		         {
		          // code to find the all approver who are aout of office
		         var OOOuser 		=	eval("document.frm.manager")[eval("document.frm.manager").selectedIndex].getAttribute('alt');	
			     var Delegatuser	=	eval("document.frm.manager")[eval("document.frm.manager").selectedIndex].text;	
	  		  	 var ApproverList  ="";
	  		  	 var finallist	   ="";	
	  		  	 
	  		  	  if( f1.manager.value != 'S'){
		  		  	   
				   		if (OOOuser!='-'){			   	
					   	ApproverList=ApproverList+Delegatuser+' <%=dbLabelBean.getLabel("alert.createrequest.hasdelegatedhisauthorityto",strsesLanguage)%> '+OOOuser+"\n";
					   	finallist=ApproverList;
					    
				     	}
				     
				    }
				    
				  if (finallist==""){       		
				   		var OOOuserHod 	 =	eval("document.frm.hod")[eval("document.frm.hod").selectedIndex].getAttribute('alt');	
				  	    	var DelegatuserHod =	eval("document.frm.hod")[eval("document.frm.hod").selectedIndex].text;	
			  		  	if (f1.hod.value != 'S'){
			   	  			if (OOOuserHod!='-'){
				    			ApproverList=ApproverList+DelegatuserHod+' <%=dbLabelBean.getLabel("alert.createrequest.hasdelegatedhisauthorityto",strsesLanguage)%> '+OOOuserHod+"\n";
				    			finallist=ApproverList;
				    		 }
				  		}
				  		 
				  	}
				 if(finallist=="") {  		
				 		var text=document.frm.approverlist.value;
		  	    	
		  	    		finallist=text;
		  	    	 }
		  	    	 
		  	     // alert(finallist);
		  	     
		  	     
		  	     
		  	     
				 var budValidations = '<%=strSHOW_BUD_INPUT%>';
					if(budValidations == 'Y'){
						// Script added by Pankaj on 11 nov 2010 to force user filling YTM fields or appropriate remarks. (STARTS)
						var YtmBud = document.getElementById('YtmBud').value;
						var YtmAct = document.getElementById('YtmAct').value;
						var EstExp = document.getElementById('EstExp').value;
						var budgetRemarks = document.getElementById('budgetRemarks').value;
						
						if(((YtmBud == '' || YtmAct == '' || EstExp == '') && budgetRemarks == '')){
							alert('<%=dbLabelBean.getLabel("alert.global.enterremarksfornotenteringbudgetactualdetails",strsesLanguage)%>');
							if(YtmBud == ''){
								document.getElementById('YtmBud').focus();
							}else if(YtmAct == ''){
								document.getElementById('YtmAct').focus();
							}else if(EstExp == ''){
								document.getElementById('EstExp').focus();
							}
							return false;
						}
					}
						// Script added by Pankaj on 11 nov 2010 to force user filling YTM fields or appropriate remarks. (ENDS)
					 
					 
					 
					 
					 	  	
		  	    if (finallist!='')  {
			    finallist="Currently "+finallist;
			    }
			    
			    
		        		if(confirm(finallist+'<%=dbLabelBean.getLabel("alert.global.submittoworkflow",strsesLanguage)%>'))
							 {
									f1.saveProceed.disabled=true;  //code added by shiv  
									f1.submit();
			                        return true;
		                }
		                 else
		                           {
		                            return false;
		                 }
			
		           }	
	
	} ///  check data function close   

	function billingOnClick(f1)
	{
		//alert("asa") ;
		 if(f1.billing[0].checked)
		{
			f1.billingSMGSite.disabled=false;
		    f1.billClient.value="";
			f1.billClient.disabled=true;
	        f1.billingSMGUser.disabled = false;        //billing SMG user combo disabled  			
		}
	
		if(f1.billing[1].checked)
		{
			f1.billClient.value="";
			f1.billingSMGSite.disabled=true;
			f1.billClient.disabled=false;
			f1.billingSMGUser.disabled = true;        //billing SMG user combo disabled  					
	     	//check1();
		}
		
	 
	}
	
	    //function for  diadbale if both approver has selected ----------------->
			function skipDisabled(f2,flag)
			{
				if(flag=='first')
				{
				//JQUERY DROPDOWN FILLING IMPLEMENTAION STARTS
				//$.noConflict();
				jQuery(document).ready(function($) {
					
							var managerId = $("#firstapprover option:selected").val();
							//change by manoj 
							var urlParams2 = '<%="&SITE_ID="+strSiteId+"&sp_role="+SSstrSplRole+"&reqpage=approver1&traveltype=D"%>';
							var urlParams = "managerId="+managerId+urlParams2;
							//alert(urlParams);
							$.ajax({
					            type: "post",
					            url: "AjaxMaster.jsp",
					            data: urlParams,
					            success: function(result){
					            	 //$("#delName").html(result);
					            	var res = result.trim();
					                if(res == 'y'){
					                	alert('<%=dbLabelBean.getLabel("alert.global.approverindefaultworkflow",strsesLanguage)%>');
					                		//document.getElementById('firstapprover').value='S';
					                }


					            	 
					            },
								error: function(){
									alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
					            }
					          });
					
				});
			}//end if


				String.prototype.trim = function() {
					return this.replace(/^\s+|\s+$/g,"");
				}
				//JQUERY DROPDOWN FILLING IMPLEMENTAION ENDS

			if(flag=='second')
			{	
				//JQUERY DROPDOWN FILLING IMPLEMENTAION STARTS
				//$.noConflict();
				jQuery(document).ready(function($) {
					
							var managerId = $("#secondapprover option:selected").val();
							//change by manoj
							var urlParams2 = '<%="&SITE_ID="+strSiteId+"&sp_role="+SSstrSplRole+"&reqpage=approver2&traveltype=D"%>';
							var urlParams = "managerId="+managerId+urlParams2;
							//alert(urlParams);
							$.ajax({
					            type: "post",
					            url: "AjaxMaster.jsp",
					            data: urlParams,
					            success: function(result){
					            	 //$("#delName").html(result);
					            	var res = result.trim();
					                if(res == 'y'){
					                		alert('<%=dbLabelBean.getLabel("alert.global.approverindefaultworkflow",strsesLanguage)%>');
					                		//document.getElementById('secondapprover').value='S';
					                }


					            	 
					            },
								error: function(){
									alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
					            }
					          });
					//	}
				//	);
				});
			}//end if


  	  
			   if((f2.manager.value != 'S' && f2.manager.value != '')  
					&& (f2.hod.value != 'S' && f2.hod.value != ''))
				   {
					f2.reasonForSkip.disabled=true;
					f2.reasonForSkip.value="";
				}
	
			else if((f2.manager.value == 'S' || f2.manager.value == '') && 
					(f2.hod.value == 'S' || f2.hod.value == ''))
				{
					f2.reasonForSkip.disabled=false;
				}
			
				else if((f2.manager.value != 'S' || f2.manager.value != '') && 
					(f2.hod.value == 'S' || f2.hod.value == ''))
				{
					f2.reasonForSkip.disabled=false;
				}
		
				else if((f2.manager.value == 'S' || f2.manager.value == '') && 
					(f2.hod.value != 'S' || f2.hod.value != ''))
				{
					f2.reasonForSkip.disabled=false;
				}
	
			}

//added by manoj chand on 22 nov 2011 to show div of non-mata source
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

//function added by manoj chand on 31 oct to add constraint on per day expense.
	function checkMsg(){
		 var chm=document.forms[0].checkMsg.value;
		 if (chm=="ExpenceCheck")
		  {
			  alert('<%=dbLabelBean.getLabel("alert.createrequest.couldnotsubmittoworkflow",strsesLanguage)%>');
		  }	  
	 }		
	</script>
	<%
		String strSql = null; // String for Sql String
		ResultSet rs, rs1, rs2 = null; // Object for ResultSet

		String strTravelReqId = "";
		String strTravelId = "";
		String strTravelReqNo = "";
		String strPreferTime = "";
		String strretTravelMode = "";
		String strTravelClass = "";
		String strManager = "";
		String strHod = "";
		String strBoardMember="";
		//String strSiteId = "";
		String strDepDate = "";
		String strDepCity = "";
		String strArrCity = "";
		String strBillingSite = "";
		String strBillingClient = "";
		String strNameOfAirline = "";
		String strReasonForSkip = "";
		String strReasonForTravel = "";
		String strRefreshFlag = "1";
		String strComboState = "";
		String ischecked = "";
		String strCashBreakupRemarks = "";
		String strBillingClientOurSide = "";
		String strMessage = "";
		String strUsercount = "";

		String strForward_coupan = "";
		String strForward_tatkaal = "";
		String strtextbox = "";
		String strRemarks = "";
		
		// below 5 fields added by Pankaj on 11 Nov 10
		String dbl_YTM_BUDGET = "";
		String dbl_YTD_ACTUAL = "";
		String dbl_AVAIL_BUDGET = "";
		String dbl_EST_EXP = "";
		String str_EXP_REMARKS = "";
		
		//added by manoj on 22 nov 2011 to add another source to mata
		String strforPriceDesicion="";
		String strTicketProvider = "";
		String strAirLineName = "";
		String strCurreny = "USD";
		String strAmount = "";
		String strTkRemarks="";
		String strTotalFareCur="";
    	String strTotalFareAmt="0";
		

		String strSeatPreffered = request.getParameter("seatpreffered") == null ? ""
				: request.getParameter("seatpreffered");
		String strTicketRefund = request.getParameter("ticketrefund") == null ? ""
				: request.getParameter("ticketrefund");
		strMessage = request.getParameter("message") == null ? "" : request
				.getParameter("message");
		strRefreshFlag = request.getParameter("refreshFlag") == null ? "2"
				: request.getParameter("refreshFlag");

		//strBillingSite = request.getParameter("billingSMGSite") == null ? strSiteIdSS : request.getParameter("billingSMGSite");
		//change by manoj
		strBillingSite = request.getParameter("billingSMGSite") == null ? strSiteId : request.getParameter("billingSMGSite");
		strBillingClient = request.getParameter("billingSMGUser") == null ? "-1"
				: request.getParameter("billingSMGUser");
		strReasonForSkip = request.getParameter("reasonForSkip") == null ? ""
				: request.getParameter("reasonForSkip");
		strReasonForTravel = request.getParameter("reasonForTravel") == null ? ""
				: request.getParameter("reasonForTravel");
		strDepDate = request.getParameter("depDate") == null ? "" : request
				.getParameter("depDate");
		strPreferTime = request.getParameter("preferTime") == null ? "2"
				: request.getParameter("preferTime");
		strretTravelMode = request.getParameter("rettravelMode") == null ? "1"
				: request.getParameter("rettravelMode");
		strTravelClass = request.getParameter("travelClass") == null ? "1"
				: request.getParameter("travelClass");
		strManager = request.getParameter("manager") == null ? "S"
				: request.getParameter("manager");
		strHod = request.getParameter("hod") == null ? "S" : request
				.getParameter("hod");
		//added by manoj chand on 28 march 2012 to get board member
		strBoardMember					=  request.getParameter("boardmember");
		strDepCity = request.getParameter("depCity") == null ? "" : request
				.getParameter("depCity");
		strArrCity = request.getParameter("arrCity") == null ? "" : request
				.getParameter("arrCity");
		strNameOfAirline = request.getParameter("nameOfAirline") == null ? ""
				: request.getParameter("nameOfAirline");
		strCashBreakupRemarks = request.getParameter("expRemarks") == null ? ""
				: request.getParameter("expRemarks");
		
		//added by manoj to add accomodations in group domestic request.
		String strPlace					=	request.getParameter("place")== null ? "" : request.getParameter("place");	
		String strTransitType								=  request.getParameter("transit");
		String strBudget        							=  request.getParameter("budget");
		String strBudgetCurrency                           =  request.getParameter("currency");
		String strCheckIn									=  request.getParameter("checkin");
		String strCheckOut									=  request.getParameter("checkout");
		String strOtherComment								=  request.getParameter("others");
			
		

		if (strPreferTime == null)
			strPreferTime = "2";

		if (strretTravelMode == null)
			strretTravelMode = "1";

		if (strTravelClass == null)
			strTravelClass = "1";

		if (strManager == null)
			strManager = "S";
		//set Hod
		if (strHod == null)
			strHod = "S";
		if (strBoardMember == null)
			strBoardMember = "B";
		
		if (strDepCity == null)
			strDepCity = "";
		if (strDepDate == null)
			strDepDate = "";
		if (strArrCity == null)
			strArrCity = "";
		if (strNameOfAirline == null)
			strNameOfAirline = "";

		strTravelId = request.getParameter("travelId") == null ? ""
				: request.getParameter("travelId"); // for hidden field
		strTravelReqId = request.getParameter("travelReqId") == null ? ""
				: request.getParameter("travelReqId"); // for hidden field
		strTravelReqNo = request.getParameter("travelReqNo") == null ? ""
				: request.getParameter("travelReqNo"); // for hidden field

		out.println("<BR>");

		String strApproverid = "";
		String ApproverText = "";
		String strname1 = "";
		String strname2 = "";

		String strFlag = "";

		Connection objCon = null;
		CallableStatement objCstmt = null; // Object for Callable Statement 

		String strflagforretunuser = request
				.getParameter("flagforretunuser");

		String strTravellerId = request.getParameter("travellerId");

		//code to find default approver who is oou of office
		//added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma
		//change by manoj
		strSql = "SELECT top 1 APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE  (SITE_ID = "
				+ strSiteId
				+ ") AND (STATUS_ID = 10) AND (TRV_TYPE = 'd') AND sp_role="
				+ SSstrSplRole + " order by order_id";

		rs = dbConBean.executeQuery(strSql);

		while (rs.next()) {
			strApproverid = rs.getString(1);
			strSql = "select dbo.user_name(" + strApproverid
					+ "),dbo.user_name(dbo.finalooo(" + strApproverid
					+ ",getdate(),'d'))";

			rs1 = dbConBean1.executeQuery(strSql);

			while (rs1.next()) {

				strname2 = rs1.getString(1);
				strname1 = rs1.getString(2).trim();
				if (!strname1.equals("-")) {
					ApproverText = ApproverText
							+ strname2
							+ " "+dbLabelBean.getLabel("alert.createrequest.hasdelegatedhisauthorityto",strsesLanguage)+" "
							+ strname1 + ".\n ";
				}

			}
		}
		rs.close();

		
		
		Date currentDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String strCurrentDate = (sdf.format(currentDate)).trim();

		String[] strUsertoReturn = request.getParameterValues("userids");

		String strtext = "-1";
		int intTotleid = 0;
		String strUserids = "-1";

		if (strUsertoReturn != null) {

			intTotleid = strUsertoReturn.length;
			for (int i = 0; i < intTotleid; i++) {
				strUserids = strUsertoReturn[i];
				if (intTotleid > 1) {
					strtext = strtext + "," + strUserids.trim();
				} else {
					strtext = strUserids.trim();
				}
			}
		}

		if (strflagforretunuser == null) {
			strflagforretunuser = "0";
		}

		if (strflagforretunuser.equals("1")) {
			objCon = dbConBean.getConnection();
			objCstmt = objCon
					.prepareCall("{?=call PROC_GROUP_RETURN_JOURNEY(?,?)}");
			objCstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			objCstmt.setString(2, strtext.trim());
			objCstmt.setInt(3, Integer.parseInt(strTravelId.trim()));

			int intSuccess10 = objCstmt.executeUpdate();

			objCstmt.close();
		}
	%>
	
	<body style="overflow:scroll;" onload="checkMsg();">
	<%
		//SpolicyPath variable used on 07 jan 2013 for getting company policy path
		//String Path = application.getInitParameter("companyPolicyPath");
		File UploadFile = new File(SpolicyPath + "/" + strSiteFullName + "/"
				+ strSiteFullName + ".html");
	%>
	
	
	<form name="frm" action="Group_itinerary_details_DOM_Post.jsp" style="margin-top:-20px; padding-top:0px;">
	
	<input type ="hidden" name=approverlist value="<%=ApproverText%>"/> 
	<input type="hidden" name="checkMsg" value='<%=request.getParameter("message1")%>' />
	<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center"> 
	  <tr>
	  
	  <%
	
		String groupGuestDetailLabel = "";
		if(ssflage.equals("3")){
			groupGuestDetailLabel = "label.global.guesttravelerdetail";
		}else{
			groupGuestDetailLabel = "label.createrequest.grouptraveldetails";
		}
	
	%>
	    <td background="images/tophdbg.gif?buildstamp=2_0_0"><img src="images/group-travel-request.png?buildstamp=2_0_0" alt="<%=dbLabelBean.getLabel(groupGuestDetailLabel,strsesLanguage) %>" width="237" height="35" /></td>
	    <td width="15%" background="images/tophdbg.gif?buildstamp=2_0_0"><img src="images/BigIcon.gif?buildstamp=2_0_0" alt="" width="46" height="31" /></td>
	  </tr>
	</table>
	<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" >
	<tr><td height="9px"></td></tr>
	  <tr>
	    <td><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	     
	        <td><table width="100%" border="0" cellspacing="0" cellpadding="0"> 
	          <tr>
	            <td valign="top" background="images/index_01.png?buildstamp=2_0_0"><img src="images/index_01.png?buildstamp=2_0_0" alt="" width="14" height="426" /></td> 
	            <td width="100%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	              <tr>
	                <td><img src="images/formTitIcon.png?buildstamp=2_0_0" alt="" width="30" height="29" /></td>
	                
	                <%
	                	                	if (strMessage.equals("save")) {
	                	                		strMessage = dbLabelBean.getLabel("message.global.infosavesuccessfully",strsesLanguage);
	                	                	}
	                	                %>
	                <td width="70%" background="images/tophd-bg.gif?buildstamp=2_0_0" class="formTit">Group/Guest  Itinerary  Details&nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<font color="#CC3333" > <%=strMessage%></FONT> </td>   
	                <td width="30%" background="images/tophd-bg.gif?buildstamp=2_0_0" align="right"><a href="#" title="Company Policy" onClick="<%if (UploadFile.exists()) {%> MM_openBrWin('Companies_Policies/<%=strSiteFullName%>/<%=strSiteFullName%>.html','','scrollbars=yes,resizable=yes,width=700,height=300')
					<%;
			} else {%> MM_openBrWin('Companies_Policies/notexist.html','','scrollbars=yes,resizable=yes,width=700,height=300')<%;
			}%>" ><img src="images/IconPolicy.png?buildstamp=2_0_0" width="69" height="16" border="0" /></a><span class="formTit" style="text-align:right"></span>
				&nbsp;<!-- <a href="#" onClick="MM_openBrWin('helpinternational travel.html#300a','','scrollbars=yes,resizable=yes,width=700,height=300')">
				  <img src="images/help.png?buildstamp=2_0_0" width="44" height="16" border="0" > -->
	             </td>
	              </tr>
	            </table>
	              <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
	                  <tr>
	                 <td class=formfirstfield  align=left bgcolor=#FFFFFF colspan=2 height=20>
	                 <%=dbLabelBean.getLabel("label.global.returningtravelersdetails",strsesLanguage) %>      
	                  </td>
	                  </tr> 
	                
	                <tr> 
	                 
	                   <td height="40" bgcolor="#FFFFFF">           
	                   <table width="98%" border="1" cellpadding="1" cellspacing="1" align="center" style="border-style:solid;border-color:#F0F0F0; border-collapse: collapse;"> 
	                   
	                    <tr>
			                <td width="5%" height="16" class="label5"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %> </strong></div></td>
			                <td width="13%" class="label5"><div align="left"><strong>&nbsp;<%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage) %> </strong></div></td>
			                <td width="15%" class="label5"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></strong></div></td>
			                <td width="10%" class="label5"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage) %></strong></div></td>
			                <td width="18%" class="label5"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.age",strsesLanguage) %></strong></div></td>
			                <td width="8%" class="label5"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage) %></strong></div></td>
			                <td width="10%" class="label5"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.mealpref",strsesLanguage) %></strong></div></td>
			                <td width="10%" class="label5"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage) %></strong></div></td>
			                <!-- <td width="11%" class="label2"><div align="center"><strong>Action</strong></div></td>  -->
	                  </tr>
	                  <tr>  
			                <td height="16" class="label5">&nbsp;</td>      
			                <td class="label5">&nbsp;</td>
			                <td class="label5"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.identityname",strsesLanguage) %> </strong></div></td>
			                <td class="label5"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.identitynumber",strsesLanguage) %> </strong></div></td>
			                <td class="label5"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.mobileno",strsesLanguage) %></strong></div></td>
			                <td class="label5"><div align="center"><strong>&nbsp;</strong></div></td>
			                <td class="label5"><div align="center"><strong>&nbsp;</strong></div></td>
			                <td class="label5"><div align="center"><strong>&nbsp;</strong></div></td>
			               <!--  <td class="label2">&nbsp;</td> --> 
	                 </tr>  
	                   
	               
	                    <%
  	                   	               	                    	String strCurrency_list = "";
  	                   	               	                    	String strExpRemark = "";
  	                   	               	                    	String strCurrency = "";
  	                   	               	                    	String strTotalExpense = "";

  	                   	               	                    	//// domestice decration    
  	                   	               	                    	String strIdentityProofNo = "";

  	                   	               	                    	String strIdentityProof = "";

  	                   	               	                    	String strIdentityProof_list = "";
  	                   	               	                    	String strIdentityProofno_list = "";
  	                   	               	                    	String strPhoneno = "";
  	                   	               	                    	String strPhoneno_list = "";
  	                   	               	                    	String strG_userid = "";
  	                   	               	                    	String strFirstName_List = "";
  	                   	               	                    	String strLastName_List = "";
  	                   	               	                    	String strDesigantion_List = "";
  	                   	               	                    	String strDateOfBirth_List = "";
  	                   	               	                    	String strAge_List = "";

  	                   	               	                    	String strGender_List = "";
  	                   	               	                    	String strMealPref_list = "";
  	                   	               	                    	String strTotalForex_list = "";
  	                   	               	                    	String strPassortNo_list = "";
  	                   	               	                    	String strDateofIssue_list = "";
  	                   	               	                    	String strPlacesofIssue_list = "";
  	                   	               	                    	String strDateofExpiry_list = "";
  	                   	               	                    	String strECNR_list = "";
  	                   	               	                    	String strVisaReqiured_list = "";
  	                   	               	                    	String Site_ID = "";
  	                   	               	                    	String strSex = "";
  	                   	               	                    	String strButtonstate = "";
  	                   	               	                    	int intSerialNo = 1;
  	                   	               	                    	String strFieldcheck = "";

  	                   	               	                    	String strButtonstate1 = "";
  	                   	               	                    	strSql = " SELECT  G_USERID, SITE_ID, FIRST_NAME, LAST_NAME, dbo.DESIGNATIONNAME(DESIG_ID) as DESIG , "
  	                   	               	                    			+ " ISNULL(dbo.CONVERTDATEDMY1(DOB),'-') AS DOB,  AGE, GENDER,  ISNULL(dbo.MEAL_NAME(MAEL_ID),'-') AS  MEALNAME, "
  	                   	               	                    			+ " TOTAL_AMOUNT, IDENTITY_ID, IDENTITY_NO,isnull(MObile_no,'') as MOBILE_NO FROM  "
  	                   	               	                    			+ " T_GROUP_USERINFO where travel_type='d' and Return_travel='y' and  (TRAVEL_ID = "
  	                   	               	                    			+ strTravelId + " ) and status_id=10 order by 3";

  	                   	               	                    	rs = dbConBean.executeQuery(strSql);
  	                   	               	                    	while (rs.next()) {
  	                   	               	                    		strG_userid = rs.getString("G_USERID");
  	                   	               	                    		Site_ID = rs.getString("Site_id");
  	                   	               	                    		strFirstName_List = rs.getString("FIRST_NAME");
  	                   	               	                    		strLastName_List = rs.getString("LAST_NAME");
  	                   	               	                    		strDesigantion_List = rs.getString("DESIG");
  	                   	               	                    		strDateOfBirth_List = rs.getString("DOB");
  	                   	               	                    		strAge_List = rs.getString("AGE");
  	                   	               	                    		strGender_List = rs.getString("GENDER");

  	                   	               	                    		if (strGender_List.equals("1")) {
  	                   	               	                    			strSex = "Male";
  	                   	               	                    		} else {
  	                   	               	                    			strSex = "Female";
  	                   	               	                    		}
  	                   	               	                    		strMealPref_list = rs.getString("MEALNAME");
  	                   	               	                    		strTotalForex_list = rs.getString("TOTAL_AMOUNT");
  	                   	               	                    		strIdentityProof_list = rs.getString("IDENTITY_ID");
  	                   	               	                    		strIdentityProofno_list = rs.getString("IDENTITY_NO");
  	                   	               	                    		strPhoneno_list = rs.getString("MOBILE_NO");

  	                   	               	                    		strSql = "SELECT  IDENTITY_NAME FROM m_IDENTITY_PROOF WHERE  IDENTITY_ID="
  	                   	               	                    				+ strIdentityProof_list + " and STATUS_ID=10 ";

  	                   	               	                    		rs1 = dbConBean1.executeQuery(strSql);
  	                   	               	                    		while (rs1.next()) {
  	                   	               	                    			strIdentityProof_list = rs1.getString(1);
  	                   	               	                    		}
  	                   	               	                    		rs1.close();
  	                   	               	                    		//finding currency  id from  T_TRAVEL_EXPENDITURE_DOM table fro each user   
  	                   	               	                    		strSql = "SELECT distinct (select sum(total_exp_id) from T_TRAVEL_EXPENDITURE_DOM tted1 where tted1.travel_id=tted2.travel_id) as totalExpense , tted2.currency FROM  T_TRAVEL_EXPENDITURE_DOM tted2 where tted2.travel_id = "
  	                   	               	                    				+ strTravelId;
  	                   	               	                    		//+" and G_userid="+strG_userid;	       
  	                   	               	                    		rs1 = dbConBean1.executeQuery(strSql);
  	                   	               	                    		while (rs1.next()) {
  	                   	               	                    			strTotalExpense = rs1.getString(1);
  	                   	               	                    			strCurrency = rs1.getString(2);
  	                   	               	                    		}
  	                   	               	                    		rs1.close();
  	                   	               	                    		
  	                   	               	                    		
  	                   	               	                    		
  	                   	               	                    %>
	  				 			 <tr>
							                <td height="25" class="label5"><div align="center"><%=intSerialNo%>.</div></td>
							                <td class="label5"><div align="left"> &nbsp;<%=strFirstName_List%>  <%=strLastName_List%> </div></td>
							                <td class="label5"><div align="center"><%=strDesigantion_List%><br />
											
							                 <%=strIdentityProof_list%></div></td>
							                <td class="label5"><div align="center"><%=strDateOfBirth_List%><br />
							                  <%=strIdentityProofno_list%></div></td>
							                <td class="label5"><div align="center"><%=strAge_List%><br />
							                <%=strPhoneno_list%></div></td>
							                <td class="label5"><div align="center"><%=strSex%><br />
							                  <%=strPlacesofIssue_list%></div></td>
							                <td class="label5"><div align="center"><%=strMealPref_list%><br />
							                 <%=strVisaReqiured_list%></div></td>
							                <td class="label5"><div align="center"> <%=strBaseCur %> <%=strTotalForex_list%><br />
							                 </div></td> 
							                 <!--  
							                <td class="label2"> 
												  
											  <div align="center">
												   <a href="Group_T_TravelDetail_Dom.jsp?G_userId=<%=strG_userid%>&travelId=<%=strTravelId%>&action=update" onClick="return">  EDIT</a> | <a href="G_userDelete.jsp?G_userId=<%=strG_userid%>&travel_id=<%=strTravelId%>&travel_type=d" onClick="return  deleteConfirm();">DELETE </a></div></td>
												   --> 
					  		 </tr>
	               
					<%
	               						intSerialNo++;
	               						}
	               						rs.close();

	               						if (intSerialNo == 1) {
	               							strButtonstate = "2";
	               							strButtonstate1 = "disabled";
	               							strUsercount = "0";
	               						}
	               						if (intSerialNo > 1) {
	               							strFieldcheck = "required";
	               						} else {
	               							strtextbox = "disabled";
	               						}
	               					%>
	       
	                </table>    
	                    
	                     
					  </td>   
	                </tr>
	                   
	              </table>
	 
				  <%
	 				  	//show detail for journey for given travel detalis  

	 				  	if (!strRefreshFlag.equals("1")) {
	 				  		try { // Query changed on 09 jan 2009  
	 				  			//query changed by manoj on 22 nov 2011 to add t2.TK_PROVIDER_FLAG,t2.TK_AIRLINE_NAME,t2.TK_CURRENCY,t2.TK_AMOUNT fields
	 				  			strSql = "SELECT     t1.TRAVEL_ID, t2.site_id as site_id , t1.RETURN_FROM AS TRAVEL_FROM, t1.RETURN_TO AS TRAVEL_TO, "
	 				  					+ " dbo.CONVERTDATEDMY1(t1.TRAVEL_DATE) AS TRAVEL_DATE,  t1.TRAVEL_MODE AS TRAVEL_MODE, t1.MODE_NAME AS MODE_NAME,  "
	 				  					+ " t1.TRAVEL_CLASS AS TRAVEL_CLASS, t1.TIMINGS AS TIMINGS,  t2.REASON_FOR_TRAVEL AS REASON_FOR_TRAVEL, "
	 				  					+ " t2.REASON_FOR_SKIP AS REASON_FOR_SKIP, ISNULL(t2.BILLING_SITE, '-1') AS BILLING_SITE, "
	 				  					+ " ISNULL(t2.BILLING_CLIENT, '-1') AS BILLING_CLIENT, "
	 				  					+ " ISNULL(t2.MANAGER_ID,0) AS MANAGER_ID, ISNULL(t2.HOD_ID,0)  AS HOD_ID, isnull(t2.CASH_BREAKUP_REMARKS,'') as  CASH_BREAKUP_REMARKS, "
	 				  					+ " isnull(t2.Return_TATKAAL,'n') as FORWARD_TATKAAL, isnull(t2.Return_COUPAN,'n') as FORWARD_COUPAN, isnull(t1.SEAT_PREFFERED,'1') as   SEAT_PREFFERED ,"
	 				  					+ " isnull(t1.TICKET_REFUNDABLE, 'n') as TICKET_REFUNDABLE, t2.TRAVELLER_ID as TRAVELLER_ID "
	 				  					+ " ,t2.REMARKS AS REMARKS ,T2.YTM_BUDGET, T2.YTD_ACTUAL, T2.AVAIL_BUDGET, T2.EST_EXP, T2.EXP_REMARKS,t2.TK_PROVIDER_FLAG,t2.TK_AIRLINE_NAME,t2.TK_CURRENCY,t2.TK_AMOUNT,t2.TK_REMARKS,t2.BOARD_MEMBER_ID,t2.FARE_CURRENCY,t2.FARE_AMOUNT FROM  T_RET_JOURNEY_DETAILS_Dom t1 INNER JOIN T_TRAVEL_DETAIL_DOM t2 ON t1.TRAVEL_ID = t2.TRAVEL_ID  WHERE  (t1.TRAVEL_ID = "
	 				  					+ strTravelId
	 				  					+ ") "
	 				  					+ " AND (t1.APPLICATION_ID = 1) AND (t1.STATUS_ID = 10) AND (t2.STATUS_ID = 10) ";

	 				  			 //System.out.println("strSql======="+strSql); 

	 				  			String strSite_id = "";
	 				  			rs = dbConBean.executeQuery(strSql);
	 				  			while (rs.next()) {
	 				  				strSite_id = rs.getString("site_id").trim();
	 				  				strDepCity = rs.getString("TRAVEL_FROM").trim();
	 				  				strArrCity = rs.getString("TRAVEL_TO").trim();
	 				  				strDepDate = rs.getString("TRAVEL_DATE").trim();
	 				  				strretTravelMode = rs.getString("TRAVEL_MODE").trim();
	 				  				strNameOfAirline = rs.getString("MODE_NAME").trim();
	 				  				strTravelClass = rs.getString("TRAVEL_CLASS").trim();

	 				  				if (strTravelClass.equals("0")) {
	 				  					strTravelClass = "1";
	 				  				}
	 				  				strPreferTime = rs.getString("TIMINGS").trim();
	 				  				strReasonForTravel = rs.getString("REASON_FOR_TRAVEL")
	 				  						.trim();
	 				  				strReasonForSkip = rs.getString("REASON_FOR_SKIP")
	 				  						.trim();
	 				  				if (strPreferTime.equals("")) {
	 				  					strPreferTime = "2";
	 				  				}
	 				  				if (strretTravelMode.equals("0")) {
	 				  					strretTravelMode = "1";
	 				  				}
	 				  				strBillingSite = rs.getString("BILLING_SITE");
	 				  				strBillingClient = rs.getString("BILLING_CLIENT");
	 				  				strManager = rs.getString("MANAGER_ID");
	 				  				strHod = rs.getString("HOD_ID");
	 				  				if (strManager.equals("0") || strManager == null) {
	 				  					strManager = "S";
	 				  				}
	 				  				if (strHod.equals("0") || strHod == null) {
	 				  					strHod = "S";
	 				  				}
	 				  				strCashBreakupRemarks = rs
	 				  						.getString("CASH_BREAKUP_REMARKS");
	 				  				strForward_tatkaal = rs.getString("FORWARD_TATKAAL");
	 				  				strForward_coupan = rs.getString("FORWARD_COUPAN");
	 				  				//added new on 09 jan 2009 by shiv sharma  
	 				  				strSeatPreffered = rs.getString("SEAT_PREFFERED");
	 				  				strTicketRefund = rs.getString("TICKET_REFUNDABLE");
	 				  				strTravellerId = rs.getString("TRAVELLER_ID");
	 				  				strRemarks = rs.getString("REMARKS").trim();

	 				  				dbl_YTM_BUDGET = rs.getString("YTM_BUDGET");
	 				  				dbl_YTD_ACTUAL = rs.getString("YTD_ACTUAL");
	 				  				dbl_AVAIL_BUDGET = rs.getString("AVAIL_BUDGET");
	 				  				dbl_EST_EXP = rs.getString("EST_EXP");
	 				  				str_EXP_REMARKS = rs.getString("EXP_REMARKS");

	 				  				strTicketProvider=rs.getString("TK_PROVIDER_FLAG");
	 				  				strAirLineName=rs.getString("TK_AIRLINE_NAME");
	 				  				strCurreny=rs.getString("TK_CURRENCY");
	 				  				strAmount=rs.getString("TK_AMOUNT");
	 				  				strTkRemarks=rs.getString("TK_REMARKS");
	 				  				strBoardMember=rs.getString("BOARD_MEMBER_ID");
	 				  				strTotalFareCur=rs.getString("FARE_CURRENCY");
	 	 	 						strTotalFareAmt=rs.getString("FARE_AMOUNT");
	 	 	 						
	 				  				if (strBoardMember == null || strBoardMember.equals("0")) {
	 				  					strBoardMember = "B";
	 				  				}

	 				  				if (strAmount.equals(".00")) {
	 				  					strAmount = "";
	 				  				}
	 				  				if (strCurreny == null || strCurreny.equals(""))
	 				  					strCurreny = "USD";
	 				  				
	 				  				if (dbl_YTM_BUDGET.equalsIgnoreCase("0.0"))
	 				  					dbl_YTM_BUDGET = "";
	 				  				if (dbl_YTD_ACTUAL.equalsIgnoreCase("0.0"))
	 				  					dbl_YTD_ACTUAL = "";
	 				  				if (dbl_AVAIL_BUDGET.equalsIgnoreCase("0.0"))
	 				  					dbl_AVAIL_BUDGET = "";
	 				  				if (dbl_EST_EXP.equalsIgnoreCase("0.0"))
	 				  					dbl_EST_EXP = "";

	 				  				if (strBillingSite.equals("-1")) {
	 				  					strBillingSite = strSite_id;
	 				  				}
									//change by manoj
	 				  				if (strBillingSite == strSiteId) {
	 				  					strBillingClient = "-1";
	 				  					strBillingClientOurSide = "";
	 				  					ischecked = "";
	 				  				} else if (strBillingSite.equals("0")) {
	 				  					//change by manoj
	 				  					strBillingSite = strSiteId;
	 				  					strBillingClientOurSide = strBillingClient;
	 				  					strBillingClient = "-1";
	 				  					strComboState = "disabled";
	 				  					ischecked = "checked";
	 				  				}
	 				  				if (strBillingClient.equals("")) {
	 				  					strBillingClient = "-1";
	 				  				}

	 				  			}// close of while  loop
	 				  			rs.close();
	 				  		} catch (Exception e) {
	 				  			System.out
	 				  					.println("error in page Group_itinary_details_DOM.jsp================= "
	 				  							+ e);
	 				  		}
	 				  	} //END OF  refresh flage 

	 				  	//added new on 09-06-2009   for handelling billing site by shiv sharma 
						// and USER_SITE_ACCESS.STATUS_ID=10 condition added by manoj chand on 17 apr 2013 in existing query
	 				  	if (strBillingSite == null) {
	 				  	} else {

	 				  		strSql = "SELECT  1 AS yes FROM USER_SITE_ACCESS WHERE "
	 				  				+ "  USERID =(SELECT  TRAVELLER_ID  FROM  T_TRAVEL_DETAIL_DOM "
	 				  				+ " WHERE  TRAVEL_ID = " + strTravelId
	 				  				+ ")AND (SITE_ID = " + strBillingSite + ") and USER_SITE_ACCESS.STATUS_ID=10";

	 				  		rs = dbConBean.executeQuery(strSql);
	 				  		while (rs.next()) {
	 				  			strFlag = rs.getString(1);
	 				  		}
	 				  		rs.close();
	 				  	}
	 				  %>
	   <input type="hidden" name="BillingSiteFlag" value="<%=strFlag%>" />
	 <table width="100%" border="0" cellspacing="0" cellpadding="0">  
	     <tr>
	         <td bgcolor="#FFFFFF">  
			    	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">   
			    	      <!-- open -->
			    	      
			    	       <tr>
	                		  <td>   
	                		     <table width="100%" border="1" align="center" cellpadding="" cellspacing="0" style="border-style:solid;border-color:#F0F0F0;border-collapse: collapse;"> 
	                		     	<tr>  
	                		     	  <td> 
	                		     	      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0"> 
	                		     	               <tr>
				                		     			  <td height="25" class="label1"><%=dbLabelBean.getLabel("label.global.returnjourney",strsesLanguage) %><span  class=starcolour>*</span></td>  
								                   </tr> 
	                		     	               <tr>
				                		     			 <td width="16%" class="label2"><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %>   </td>  
							 	                         <td width="16%" class="label2"><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %>   </td>
								                     	 <td width="16%" class="label2"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %></td>
									                     <td width="10%" class="label2"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %></td>  
								                   </tr> 
								                   <tr>
						                         		<td height="25">
										                              <input type="text" name="depCity" class="textBoxCss" <%=strtextbox%>  value="<%=strDepCity.trim()%>" onFocus="initializeAirPortName(this);" onkeyup="return test1('depCity', 30, 'c')" maxlength="30" /> 
						            				                   <script language="javascript">
						                            					  document.frm.depCity.value="<%=strDepCity%>";
												                         </script>	            
						                                          </td>
										                 <td class="label2">
													                      <input type="text" name="arrCity"  <%=strtextbox%> class="textBoxCss"   value="<%=strArrCity.trim()%>" onFocus="initializeAirPortName(this);"  onkeyup="return test1('arrCity', 30, 'c')" maxlength="30"/>
													                   	  <script language="javascript">
													                              document.frm.arrCity.value="<%=strArrCity%>";
													                      </script>
													              </td> 
											              <td class="label2">
									                      				<table width="60%" border="0" cellspacing="0" cellpadding="0">  
															                          <tr>
												                    				        <td><!--Reaching Date at Destination-->
																								<input name="depDate" type="text"  <%=strtextbox%> class="textBoxCss" id="test2" size="7" value="<%=strDepDate%>" onFocus="javascript:vDateType='DD/MM/YYYY'" 	onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter');" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" /> 
															 									<a  onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"                 onclick="button_onclick(document.frm.depDate);" >
																						       <img   height=15 alt=Calender src="images/calender.png?buildstamp=2_0_0"  width="18"    /></a> 
																										<!-- <a href="javascript:show_calendar('frm.depDate','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
																										<img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a> -->	
																								 </td>
																				       </tr>
																				</table>
																				<script language="javascript">
						                              									document.frm.depDate.value="<%=strDepDate%>";
						                        								</script>	
																               </td>
												            <td>  <select name="preferTime" class="textBoxCss" <%=strtextbox%> >
																		<%
																			//For Population of Prefer Timing Combo 
																			strSql = "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY DISPLAY_ORDER ASC";
																			rs = dbConBean.executeQuery(strSql);
																			while (rs.next()) {
																				if(!rs.getString("TIME_ID").equals("") && !rs.getString("TIME_ID").equals("102")) {
																				%>
													                              <option value="<%=rs.getString("TIME_ID")%>"><%=rs.getString("PREFER_TIME")%></option>
																				<%
																				}
																			}
																			rs.close();
																			%>
											                        </select>
																	<script language="javascript">
											                            document.frm.preferTime.value="<%=strPreferTime%>";
											                        </script>	
					                        	               </td>
	                                            </tr>
	                                             <tr>
									                      <td width="21%"   class="label2"><%=dbLabelBean.getLabel("label.global.mode",strsesLanguage) %></td>
									                      <td width="21%" class="label2"><%=dbLabelBean.getLabel("label.global.preferredairlinetraincab",strsesLanguage)%></td>
									                      <td width="18%" class="label2"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%></td>
									                      <td width="16%" class="label2"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%></td> 
	                      						</tr>
	                      						<tr> 
							                      <td height="25">
												               <select name="rettravelMode" <%=strtextbox%> class="textBoxCss"   onChange="getUserID2();"><!-- -->
												                <%--ADDED BY MANOJ CHAND ON 24 JAN 2013 TO FETCH TRAVEL MODE FROM TABLE --%>
							                                       <%
							                                       rs=null;
							                                       strSql = "SELECT TRIP_ID,TRIP_TYPE FROM dbo.M_TRAVEL_MODE WHERE dbo.M_TRAVEL_MODE.STATUS_ID=10 AND dbo.M_TRAVEL_MODE.TRAVEL_AGENCY_ID = 1 AND dbo.M_TRAVEL_MODE.TRV_TYPE='D'";
																   rs = dbConBean.executeQuery(strSql);
																   while (rs.next()) {
																		%>
																		<option  value ="<%=rs.getString("TRIP_ID") %>"><%=rs.getString("TRIP_TYPE")%></option>
			                          									<%} rs.close(); %> 
							                                            </select>
													<script language="javascript">
							
								   						//alert('<%=strretTravelMode%>');
													         document.frm.rettravelMode.value="<%=strretTravelMode%>"; 
							                        </script>				                  </td> 
							                      <td class="label2">
												  <input type="text" name="nameOfAirline" class="textBoxCss" <%=strtextbox%>  value="<%=strNameOfAirline.trim()%>"  onkeyup="return test1('nameOfAirline', 30, 'cn')" maxlength="30" /></td>
							
												   <script language="javascript">
							                              document.frm.nameOfAirline.value="<%=strNameOfAirline%>";
							                        </script>	
							                      <td class="label2">
												  <select name="travelClass" class="textBoxCss"  <%=strtextbox%> >
												  					  <%
												  					  	//For Population of Travel Class Combo For Departure 
																		//change query by manoj chand on 24 jan 2013 to populate travel class combobox from one common class table rather than individual table
												  					  	strSql =   "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID='"+strretTravelMode+"' AND mmc.TRAVEL_AGENCY_ID = 1 AND mmc.STATUS_ID=10 ORDER BY CLASS_ID";
												  					  	rs = dbConBean.executeQuery(strSql);
												  					  	while (rs.next()) {
												  					  %>
																	 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																			<%
																				}
																				rs.close();
																			%>
															</td>
							                       
													<script language="javascript"> 
													  if('<%=strRefreshFlag%>'!='1')
							                            document.frm.travelClass.value="<%=strTravelClass%>";
							                        </script>			
							                      <td> 
							                      <select name="seatpreffered" class="textBoxCss"  <%=strtextbox%> >   
												  		 <%
   												  		 	//For Population of Travel Class Combo For Departure
   												  		 	strSql = "SELECT seat_id, Seat_Name FROM M_SEAT_PREFER  WHERE  (Mode_id = '"+strretTravelMode+"') AND (TRAVEL_AGENCY_ID = 1) AND (STATUS_ID = 10) ORDER BY SEAT_ID";

   												  		 	rs = dbConBean.executeQuery(strSql);
   												  		 	while (rs.next()) {
   												  		 %>
																	 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																			<%
																				}
																				rs.close();
																			%>
															
													 
							                      </select> 
							                      </td>
							                     
							                      <script> 
							                      
							                       
							                       var pfseat="<%=strSeatPreffered%>"; 
							                       
							                       //alert(">>1>"+pfseat+"<<");            
							                       if(pfseat==""){
							                      // document.frm.seatpreffered.value ='1'; 
							                       }else{
							                        //document.frm.seatpreffered.value ='<%=strSeatPreffered%>';
							                       } 
							                      </script>
	                       
	                                          </tr>
	                                          
	                                           
	                                           <%
	                		     		if (strUsercount == "0") {
	                		     	%>
	                		     	               <tr>
									                 <td width="21%"   class="label2"><%=dbLabelBean.getLabel("label.global.notravelerforreturnjourney",strsesLanguage)%> </td>   
	                      						  </tr>
	                      			<%
	                      				}
	                      			%>	 
	                                            
	                                            
	                                            
	                                             
								               
						                  </table>
						             </td>      
	                		     	
	                		     	</tr>
	                		     			  
	                		     </table>

	                		  </td>
	                 	   </tr>
	                 	   
	                 	 </table>
	                 	 <!-- close -->
	                 	  <!-- added by manoj chand on 27 nov 2012 to add Total Travel Fare -->
 <%if(strAppLvl3flg.equalsIgnoreCase("Y")){ %>
<table align="center" width="98%" border="1" cellspacing="0" cellpadding="0" bordercolor="#F0F0F0" style="border-top:none;border-collapse: collapse;">
	                     
	                <tr>  
	                  <td> 
 <table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" bordercolor="#F0F0F0" style="border-collapse: collapse;">
	        <tr>
	          <td width="21%" height="23" class="label1" colspan="1"><%=dbLabelBean.getLabel("label.createrequest.totaltravelfare",strsesLanguage)%><span class="starcolour">*</span></td>
	          <td width="8%" height="23" class="label2" colspan="1"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage) %></td>
	          <td width="15%" height="23">
	        <select	name="TotalFareCurrency" id="totalfarecurrency" class="textBoxCss">
				<option value=""><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
						<%
						rs=null;
							strSql = "Select rtrim(Currency), rtrim(Currency) from m_currency where status_id=10";
							rs = dbConBean.executeQuery(strSql);
							while (rs.next()) {
						%>
						<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
						<%
							}
							rs.close();
						%>
				</select>
				<script>
					document.getElementById("totalfarecurrency").value="<%=strTotalFareCur%>";
				</script>
	        </td>
	          <td width="9%" height="23" class="label2" colspan="1"><%=dbLabelBean.getLabel("label.createrequest.totalfare",strsesLanguage) %></td>
	          <td height="23" valign="middle" class="label2" width="">
	       	<input name="TotalFareAmount" id="totalfareamount" type="text" size="10"  class="textBoxCss" maxlength="10"  value="<%=strTotalFareAmt %>" onkeyup="return test1('fareamount',12, 'n')" />
	       </td>
	           
	        </tr>
	     
	          </table>	   
</td></tr></table>
<!-- end here -->
<%} %>	   	                 	 
	                 	 
	                 	 
	                 	 
			    	     
			<!-- start from here -->
           	     
  
	    		        <table align="center" width="98%" border="1" cellspacing="0" cellpadding="0" style="border-style:solid;border-color:#F0F0F0;border-collapse: collapse;">
	                     
	                <tr>  
	                  <td>  
					    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                 
	                    <tr>
	                      <td height="20" class="label1"><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel",strsesLanguage)%> <span class="starcolour">*</span></td>
	                      <td class="label6"><strong><%=dbLabelBean.getLabel("label.global.reasonforskipping",strsesLanguage)%> <span class=starcolour>*</span> </strong>	  
						 </td>
	                      <td class="label6"><strong><%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)%> <span  class=starcolour>*</span></strong> &nbsp;</td>
	                      
	                    </tr>
        
	                    <tr>
	                      <td class="label6"> <strong><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage)%></strong>
	                       <select name="manager" id="firstapprover" class="textBoxCss" onchange="skipDisabled(this.form,'first');">  
					               <%
  					               	// MODIFICATION END   <!--MANAGER COMBO-->
  					               %>
									    <option value="S"><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel1",strsesLanguage)%></option> 
											<%
 												//For Population of Manager Class Combo for the particular site
 												//AND USERID NOT IN(SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND STATUS_ID=10)
 												//ADD APPROVERS WHO HAS APPROVER LEVEL 2 
 												/*strSql = "Select dbo.user_name(dbo.finalooo(USERID,getdate(),'d')),USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO WHERE APPROVER_LEVEL=1 AND SITE_ID="
 														+ strSiteIdSS
 														+ " AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2";*/
 										        //added or change by manoj
 										       //query commented by manoj chand on 03 June 2013 
 										       /* strSql = "Select dbo.user_name(dbo.finalooo(USERID,getdate(),'d')),USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO WHERE APPROVER_LEVEL=1 AND SITE_ID="
 														+ strSiteId
 														+ " AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 3";*/
 					/*strSql = "Select dbo.user_name(dbo.finalooo(USERID,getdate(),'d')),USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO WHERE APPROVER_LEVEL=1 AND SITE_ID="
 	 														+ strSiteIdSS
 	 														+ " AND STATUS_ID=10 AND APPLICATION_ID=1 and userid not in ((SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteIdSS+" AND TRV_TYPE='D' AND  sp_role="+SSstrSplRole+" AND STATUS_ID=10 AND APPLICATION_ID=1))ORDER BY 3";*/										
 				//System.out.println("strSql aproverlevel 1--->"+strSql);
 	 								//query added by manoj chand on 03 June 2013 to display other side user in approval level 1				
 	 											strSql="Select dbo.user_name(dbo.finalooo(USERID,getdate(),'d')),USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1"+
														" UNION SELECT dbo.user_name(dbo.finalooo(UAM.USERID,getdate(),'d')),UAM.USERID,dbo.user_name(UAM.USERID)AS PM FROM USER_MULTIPLE_ACCESS UAM WHERE SITE_ID="+strSiteId+" AND APPROVAL_LVL1='Y' AND STATUS_ID=10 ORDER BY 3";				
 	 														
 												rs = dbConBean.executeQuery(strSql);
 												while (rs.next()) {
 											%>
										 <option alt="<%=rs.getString(1)%>" value="<%=rs.getString(2)%>"><%=rs.getString(3)%></option>
									<%
										}
										rs.close();
									%>
	                  </select>
	                  <%
	                  
	                  strSql="SELECT TOP 1 MANAGER_ID, HOD_ID, BOARD_MEMBER_ID FROM T_TRAVEL_DETAIL_DOM INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND TRAVEL_TYPE='D' AND T_TRAVEL_STATUS.TRAVEL_STATUS_ID = 10 WHERE TRAVELLER_ID = "+Suser_id+" ORDER BY C_DATETIME DESC";
		                 rs       =   dbConBean.executeQuery(strSql); 
		                 if(rs.next())
		                 {
		                	 strManagerSelected = rs.getString("MANAGER_ID");
		                	 strHodSelected = rs.getString("HOD_ID");
		                	 strBoardMemberSelected = rs.getString("BOARD_MEMBER_ID");
		               	}
		                 rs.close();
		                 
		               if (strManager != null && !strManager.equals("") && !strManager.equalsIgnoreCase("S")) { %>
		                  <script language="javascript">
		                            document.frm.manager.value="<%=strManager%>";
		                  </script>
	                  <%} 
	                  	else if(strManagerSelected == null || strManagerSelected.equals("")) { %>
	                	  <script language="javascript">
	                	  document.frm.manager.value="<%=strManager%>";
	            		  </script>
                  		<% } 
                  		else { %>
	                 	 <script language="javascript">
	                 	var firstApprover = document.getElementById("firstapprover");
	                 	var firstAppVal;
	                    var i;
	                    for (i = 0; i < firstApprover.length; i++) {
	                    	firstAppVal = firstApprover.options[i].value;	                    	
	                    	if(firstAppVal == <%=strManagerSelected%>){	                    		
	                    		document.frm.manager.value="<%=strManagerSelected%>"; 
	                    		break;
	                    	} else if(firstAppVal != <%=strManagerSelected%>){                    		
	                    		document.frm.manager.value="S";
	                    	} 
	                    }                	   
	            		 </script> 
            			
            			<% } %>  		
						 &nbsp; &nbsp;<br></br><strong><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage)%> </strong> <select name="hod" id="secondapprover" class="textBoxCss" onchange="skipDisabled(this.form,'second');">    
					<%
    						// MODIFICATION END
    					%>
												   <!--HOD COMBO -->   
					     <option value="S"><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel2",strsesLanguage)%></option>
						<%
							//For Population of HOD Class Combo for the particular site
							//ADD APPROVERS WHO HAS APPROVER LEVEL 2  
						/*	strSql = "Select dbo.user_name(dbo.finalooo(USERID,getdate(),'d')),USERID, dbo.user_name(USERID)AS HOD FROM M_USERINFO WHERE APPROVER_LEVEL=2 AND SITE_ID="
									+ strSiteIdSS
									+ " AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2";
						System.out.println("strSQL--GROUP1-->"+strSql);
							rs = dbConBean.executeQuery(strSql);

							while (rs.next()) {*/
						%> 
						<%--<option alt="<%=rs.getString(1)%>" value="<%=rs.getString(2)%>"><%=rs.getString(3)%></option> --%>
										<%
											/*}
											rs.close();

											//ADD GLOBAL APPROVER		
											strSql = "Select dbo.user_name(dbo.finalooo(USERID,getdate(),'d')),USERID, dbo.user_name(USERID)AS HOD FROM M_USERINFO WHERE APPROVER_LEVEL=3 AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2";
											System.out.println("strSQL--GROUP2-->"+strSql);*/
											//change by manoj
											//query commented by manoj chand on 03 June 2013
											//strSql = "Select dbo.user_name(dbo.finalooo(USERID,getdate(),'d')),USERID, dbo.user_name(USERID)AS HOD FROM M_USERINFO WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+ strSiteId+") or (APPROVER_LEVEL=3)) AND STATUS_ID=10 AND APPLICATION_ID=1  ORDER BY 3";
					//System.out.println("approver level 2----->"+strSql);
					//query added by manoj chand on 03 June 2013 to display other side user in approval level 2
					strSql="Select dbo.user_name(dbo.finalooo(USERID,getdate(),'d')),USERID, dbo.user_name(USERID)AS HOD FROM M_USERINFO WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") or (APPROVER_LEVEL=3)) AND STATUS_ID=10 AND APPLICATION_ID=1"+  
					" UNION SELECT dbo.user_name(dbo.finalooo(UAM.USERID,getdate(),'d')),UAM.USERID,dbo.user_name(UAM.USERID)AS PM FROM USER_MULTIPLE_ACCESS UAM WHERE SITE_ID="+strSiteId+" AND APPROVAL_LVL2='Y' AND STATUS_ID=10 ORDER BY 3";
											rs = dbConBean.executeQuery(strSql);
											while (rs.next()) {
										%>
														<option  alt="<%=rs.getString(1)%>" value="<%=rs.getString(2)%>"><%=rs.getString(3)%></option>
												<%
													}

													rs.close();
												%>
	                  </select>
	                  <%
	                  	if (strHod != null && !strHod.equals("") && !strHod.equalsIgnoreCase("S")) {%>
						  <script language="javascript">
	                       document.frm.hod.value="<%=strHod%>";
	                  </script>
                	 <%} 
                  	else if(strHodSelected == null || strHodSelected.equals("")) { %>
                	  <script language="javascript">
                	  	document.frm.hod.value="<%=strHod%>";
            		  </script>
                	<% } 
                 		else { %>
	                 	<script language="javascript">
	                 	var secondApprover = document.getElementById("secondapprover");
	                 	var secondAppVal;
	                    var i;
	                    for (i = 0; i < secondApprover.length; i++) {
	                    	secondAppVal = secondApprover.options[i].value;	                    	
	                    	if(secondAppVal == <%=strHodSelected%>){	                    		
	                    		 document.frm.hod.value="<%=strHodSelected%>"; 
	                    		break;
	                    	} else if(secondAppVal != <%=strHodSelected%>){                    		
	                    		document.frm.hod.value="S";
	                    	} 
	                    }
	                	   
	            		 </script> 
           			<% } %> 
	                  
	                  <% if(strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>
	                  <!-- ADDED BY MANOJ CHAND ON 28 MARCH 2012 TO CREATE BOARD MEMBER DROPDOWN -->
	                  <br /><br /><strong><%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage)%></strong>&nbsp;&nbsp;&nbsp;
	                  <select name="boardmember" id="thirdapprover" class="textBoxCss" onChange="skipDisabled(this.form,'third');">
							<option value="B"><%=dbLabelBean.getLabel("label.createrequest.selectboardmember",strsesLanguage)%></option>
							<option value="-2"><%=dbLabelBean.getLabel("label.global.notapplicable",strsesLanguage)%></option> 
						<%  //For Population of Board Members for SMP DIVISION 
						       strSql = "SELECT USERID, DBO.user_name(USERID) AS BM FROM M_BOARD_MEMBER WHERE M_BOARD_MEMBER.SITE_ID="+strSiteId+" AND M_BOARD_MEMBER.STATUS_ID=10";
						       rs       =   dbConBean.executeQuery(strSql);  
						       while(rs.next())
						                       {
						%>
						       <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
						<%
						                       }
						                       rs.close();	  
						
						%>
                  </select>
	                  <%
	                  	if (strBoardMember != null && !strBoardMember.equals("") && !strBoardMember.equalsIgnoreCase("B")) { %>
						  <script language="javascript">
		                       document.frm.boardmember.value="<%=strBoardMember%>";
		                  </script>
	                  <% } 
	                  	else if(strBoardMemberSelected == null || strBoardMemberSelected.equals("")){%>
	                  		<script language="javascript">
		                       document.frm.boardmember.value="<%=strBoardMember%>";
		                    </script>
	                  	<%}
	                  	else { %>
		        		 <script language="javascript">
		        			var thirdApprover = document.getElementById("thirdapprover");
		        			var thirdAppVal;
		                    var i;
		                    for (i = 0; i < thirdApprover.length; i++) {
		                    	thirdAppVal = thirdApprover.options[i].value;	                    	
		                    	if(thirdAppVal == <%=strBoardMemberSelected%>){	                    		
		                    		document.frm.boardmember.value="<%=strBoardMemberSelected%>";
		                    		break;
		                    	} else if(thirdAppVal != <%=strBoardMemberSelected%>){                    		
		                    		document.frm.boardmember.value="B";
		                    	} 
		                    }
		        			   
		        		 </script>
	        			<%} 
	                  }//end here
	                  %>
	                  
	                </td> 
	                      <td class="label2"  ><textarea name="reasonForSkip" cols="28" rows="4" class="textBoxCss" onkeyup="return test1('reasonForSkip', 200, 'all')"></textarea>
	                      <script language="javascript">
	                       document.frm.reasonForSkip.value="<%=strReasonForSkip%>";
	                  </script>	</td>
	                      <td class="label2"   ><textarea name="reasonForTravel" cols="28" rows="4" class="textBoxCss" onkeyup="return test1('reasonForTravel', 200, 'all')"></textarea></td>
	                      <script language="javascript">
	                       document.frm.reasonForTravel.value="<%=strReasonForTravel%>";
	                  </script>
	                       <td class="label2"  valign="top" ><br></br> <a href="#" onclick="return defaultApproverList(this.form);"><%=dbLabelBean.getLabel("link.global.viewallapprovers",strsesLanguage)%></a></td>
	                    </tr>
	                        
	                         <tr >               
	                         <td colspan="4">              
	                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                              <tr >
	                              <td class="label2"><strong> <%=dbLabelBean.getLabel("label.createrequest.tatkaalrequired",strsesLanguage)%> &nbsp; &nbsp; &nbsp;<input name="forTatkaalRequired" type="radio" value="y" /> <%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%> <input name="forTatkaalRequired" type="radio" value="n" /> <%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>  </strong></td> 
	                              <td class="label2" ><strong> <%=dbLabelBean.getLabel("label.createrequest.couponticketrequired",strsesLanguage)%> <input name="forCoupanRequired" type="radio" value="y" /><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%> <input name="forCoupanRequired" type="radio" value="n" /><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%> </strong></td>               
	                              <td class="label2"><strong><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%> <input name="ticketrefund" type="radio" value="y" /><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%> <input name="ticketrefund" type="radio" value="n" /><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%> </strong></td>
	                                 </tr>
	                                 
	                                 <Script>
								            var aa ="<%=strForward_tatkaal%>";
											if(aa != null && aa =="y")	{
								    		document.frm.forTatkaalRequired[0].checked=true;
								   			document.frm.forTatkaalRequired[1].checked=false;							   
											}else{
									   		document.frm.forTatkaalRequired[0].checked=false; 
								   			document.frm.forTatkaalRequired[1].checked=true;							   
											}
	
		                           </script>
		                           <Script>
					                      var aa ="<%=strForward_coupan%>";// 
											 if(aa != null && aa =="y")
											{
											    document.frm.forCoupanRequired[0].checked=true;
											   document.frm.forCoupanRequired[1].checked=false;							   
											}else{
												   document.frm.forCoupanRequired[0].checked=false;
											   document.frm.forCoupanRequired[1].checked=true;							   
											}
	                       		</script>
	                        
	                            <Script>
					                      var aa ="<%=strTicketRefund%>";//strticketrefundable
											 if(aa != null && aa =="y")
											{
											    document.frm.ticketrefund[0].checked=true;
											   document.frm.ticketrefund[1].checked=false;							   
											}else{
												   document.frm.ticketrefund[0].checked=false;
											   document.frm.ticketrefund[1].checked=true;							   
											}
	
	                       </script>
	                      
	                                 
	                                </table>
	                      
	                    </tr>  
	                    
	                    
	                    
	                    
	                  </table></td>      
	                    </tr>
	                 <!--    <tr>
	                      <td height="25" colspan="1" valign="top" class="label2">
										  </td>
					
	                     
						   <td colspan="1" class="label2"></td>
	
					   <td class="label2 " > 
			&nbsp;</td>
					    <td class="label2">
						&nbsp;</td>
	                </tr>
	                <tr>
	                  <td height="25"> </td>
	                </tr> -->
	              </table></td>
	  </tr>
	  
	   <%
	  	   	String sSqlStr = "";
	  	   	String strlinkshowflag = "";
	  	   	String strcolspan = "";

	  	   	sSqlStr = "SELECT  usa.USERID,   M_SITE.SITE_NAME, dbo.CONVERTDATE(usa.C_DATE) AS c_date "
	  	   			+ " FROM USER_SITE_ACCESS AS usa INNER JOIN "
	  	   			+ " M_SITE ON usa.SITE_ID = M_SITE.SITE_ID WHERE (usa.USERID in( select traveller_id from t_travel_detail_DOM where travel_id="
	  	   			+ strTravelId + " ))";

	  	   	rs = dbConBean.executeQuery(sSqlStr);
	  	   	if (rs.next()) {
	  	   		strTravellerId = rs.getString(1);
	  	   		strlinkshowflag = "yes";
	  	   		strcolspan = "1";
	  	   	} else {
	  	   		strcolspan = "2";
	  	   		strlinkshowflag = "No";
	  	   	}
	  	   	rs.close();
	  	   %>
	   <tr>
	    <td bgcolor="#FFFFFF">
		<table cellspacing="0" cellpadding="0" width="100%" border="0"> 
	      <tr>
	        <td class="formfirstfield" valign="bottom" align="left" 
	                		bgcolor="#FFFFFF" colspan="1" height="20"><%=dbLabelBean.getLabel("label.global.billinginstructions",strsesLanguage)%><span class="starcolour">*</span>  
	           		</td>
	                 <td class="label2"   align="right"	  colspan="1" height="20"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>	
	      </tr>
	      <BR>
	    </table></td>
	  </tr>
	  <tr>
	    <td bgcolor="#FFFFFF"><table width="98%" border="1" align="center" cellpadding="0" cellspacing="0" style="border-style:solid;border-color:#F0F0F0;border-collapse: collapse;">
	      <tr>
	        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">  
	        
	          <tr> 
	            <td class="label2" width="28%"><strong><%=dbLabelBean.getLabel("label.global.chargeableto",strsesLanguage)%> </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="billing" type="radio" value="<%=dbLabelBean.getLabel("label.global.smg",strsesLanguage)%>"     checked  onclick="billingOnClick(this.form)" />&nbsp;<%=dbLabelBean.getLabel("label.global.smg",strsesLanguage)%></td>
	            
	                 
	                <td width="30%"> 
	              	     <select name="billingSMGSite" class="textBoxCss"  onchange="getSiteID(this.form)"   <%=strComboState%> >  
						 <!--Expenditure Currency-->
							<%
								//For Population of Currency Combo for the particular site
								strSql = "SELECT SITE_ID,DBO.SITENAME(SITE_ID) AS SITE_NAME FROM M_SITE WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND (M_SITE.CLOSED_UNIT_FLAG is null or M_SITE.CLOSED_UNIT_FLAG='') ORDER BY 2";

								rs = dbConBean.executeQuery(strSql);
								while (rs.next()) {
							%>
								<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
								<%
									}
									rs.close();
								%>
								<script language="javascript">
									document.frm.billingSMGSite.value="<%=strBillingSite%>";
								 </script>
	                         </select>
	                 </td>
					             		
	             
	            <td width="42%"><table width="" border="0" cellspacing="0" cellpadding="0"> 
	              <tr>
	                <td>
					<input name="billing" type="radio" value="outSideSMG"      <%=ischecked%>  onclick="billingOnClick(this.form)"  />                </td>
	                <td class="label2"><%=dbLabelBean.getLabel("label.global.nonsmg",strsesLanguage)%>&nbsp;</td>
	                <td class="label2">
	                     <input name="billClient" type="text" class="textBoxCss"  onkeyup="return test1('billClient', 30, 'c')"  size="34"  value='<%=strBillingClientOurSide%>'></input>
	                </td>
	              </tr>
	            </table></td>
	          </tr>
	          <tr>
	            <td class="label2"  colspan="<%=strcolspan%>">&nbsp;</td>

				   <%
				   	if (strlinkshowflag.equals("yes")) {
				   %> 
	            <td class="label2"><a href="#"   onclick="window.open('M_Myaccessunit.jsp?userId=<%=strTravellerId%>','SEARCH','scrollbars=yes,resizable=yes,width=500,height=240')";><%=dbLabelBean.getLabel("link.global.showmyaccessibleunits",strsesLanguage)%></a></td>

					<%
						}
					%>
	            <td class="label2" valign="middle" height="22"><div align="left">&nbsp;<%=dbLabelBean.getLabel("label.global.ifnonsamvardhanagroup",strsesLanguage) %><%=dbLabelBean.getLabel("label.createrequest.enternameofclient",strsesLanguage) %> </div></td>
	          </tr>
	          <tr>
	            <td class="label2"><%=dbLabelBean.getLabel("label.createrequest.selectuserofbillingunitforapproval",strsesLanguage)%></td> 
	            <td> <span class="label2">
	              <select name="billingSMGUser" class="textBoxCss"  <%=strComboState%> >      
							    <option  value="-1"'> <%=dbLabelBean.getLabel("label.createrequest.userfrombillingunit",strsesLanguage)%> </option>  
							<%
								//code added by vaibhav
								//change by manoj
								if (strBillingSite != null && !strBillingSite.equals("0")
										&& !strBillingSite.equals("-1")
										&& !strBillingSite.equals(strSiteId)
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
	            </span></td>
	
				   <script language="javascript">
	            					document.frm.billingSMGUser.value="<%=strBillingClient%>";
				 	</script>	
				 <td class="label2" align="left"> 
					 <table cellspacing="0" cellpadding="0">
					 <tr><td>
					 	&nbsp;
					 </td><td>
					 	&nbsp;
					 </td></tr>
					 </table>
		          </td> 	
	            </tr>
	           <tr>
	            <td class="label2">&nbsp;</td>       
	            <td>&nbsp;</td> 
	              <td>&nbsp;</td>
	          </tr>
	          
	          <%
	          String strText = "display:none";
	        //added by manoj chand on 22 nov 2011 to fetch  Dom_local_agent
              		strSql = "Select isnull(DOM_LOCAL_AGENT,'') as DOM_LOCAL_AGENT From m_site where site_id="+ strSiteId + " and status_id=10 ";
				rs1 = dbConBean.executeQuery(strSql);

				while (rs1.next()) {
					strforPriceDesicion = rs1.getString("DOM_LOCAL_AGENT");
				}
				rs1.close();
	          
	          %>
	          
	          
	          

	          <tr> 
	          <%
	          if (strSHOW_BUD_INPUT.equalsIgnoreCase("Y")) { %>
	          
	            <td class="label2" colspan="3">
	            
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
	            
	            <table width="100%" cellspacing="5" cellpadding="0"
							bgcolor="#FFFBFF" border="0">
							<tr>
								<td class="label1" colspan="4"><strong><%=dbLabelBean.getLabel("label.global.budgetactualdetails",strsesLanguage)%><span class="starcolour">*</span></strong></td>
								<td class="label2" ><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
							</tr>
							<tr>
								<td bgcolor="#FFFBFF" class="label2"><%=dbLabelBean.getLabel("label.global.ytmbudget",strsesLanguage)%></td>
								<td><input type="text" name="YtmBud" size="10"
									onChange="showDiff();" onKeyUp="return test1('YtmBud', 15, 'n')"
									class="textBoxCss" maxlength="15"> <script
									language="javascript">
                     		   document.frm.YtmBud.value="<%=dbl_YTM_BUDGET%>";
                    		 </script></td>
								<td bgcolor="#FFFBFF" class="label2"><%=dbLabelBean.getLabel("label.global.ytdactual",strsesLanguage)%></td>
								<td><input type="text" name="YtmAct" size="10"
									onChange="showDiff();" onKeyUp="return test1('YtmAct', 15, 'n')"
									class="textBoxCss" maxlength="15"> <script
									language="javascript">
                     		   document.frm.YtmAct.value="<%=dbl_YTD_ACTUAL%>";
                    		 </script></td>
								<td rowspan="2" valign="top"><textarea name="budgetRemarks"
									cols="58" rows="3" class="textBoxCss"
									onKeyUp="return test1('budgetRemarks', 100, 'all')"><%=str_EXP_REMARKS.trim()%></textarea>
								</td>
							</tr>
							<tr>
								<td bgcolor="#FFFBFF" class="label2" nowrap="nowrap"><%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage)%></td>
								<td><input type="text" name="AvailBud" size="10"
									onchange="" onkeyup=""
									class="textBoxCss" maxlength="15" readonly="readonly"/> <script
									language="javascript">
                     		   document.frm.AvailBud.value="<%=dbl_AVAIL_BUDGET%>";
                    		 </script></td>
								<td bgcolor="#FFFBFF" class="label2" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.estimatedexpenditure",strsesLanguage)%></td>
								<td><input type="text" name="EstExp" size="10"
									onChange="" onKeyUp="return test1('EstExp', 15, 'n')"
									class="textBoxCss" maxlength="15"> <script
									language="javascript">
                     		   document.frm.EstExp.value="<%=dbl_EST_EXP%>";
                    		 </script></td>
							</tr>
						</table>
	            
	            
	            
	            
	            </td> 
	            <%} %>
	            
	          </tr>
	          
	          
	          
	           <!--  ADDED BY MANOJ CHAND ON 22 NOV 2011 TO ADD ANOTHER RESOURCE FROM MATA -->
	         <tr>
						<td class="label2" colspan="3">
						<table width="100%" cellspacing="2" cellpadding="0"	bgcolor="#FFFBFF" border="0">
							<tr>
								<td colspan="1" width="50%" bgcolor="#FFFFFF">&nbsp;</td>
								<%
									if (strforPriceDesicion.equalsIgnoreCase("y")) {
								%>
					<!-- change caption for checking pricing through alternate source on 18 Oct 2011 by manoj chand -->
								<td colspan="2" width="50%" bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.proposetobuyticketsfromnonmatasource",strsesLanguage)%> &nbsp;&nbsp;&nbsp;<input type="radio" name="tkflyes"
									onclick="showdiv('y')" checked="checked" value="y" /> <%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%> <input
									type="radio" name="tkflyes" onclick="showdiv('n')" value="n" />	<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
									<br><i><%=dbLabelBean.getLabel("label.global.nonmatasource",strsesLanguage)%></i>
									
					<!-- start -->			
								<%
								//String strText = "display:none";
								//System.out.println("strTicketProvider=====dom========="+strTicketProvider);

								if (strforPriceDesicion.equalsIgnoreCase("y")) {

									if (strTicketProvider.equalsIgnoreCase("n")) {

										strText = "";
							%>
							<script language="JavaScript">
                    	  // alert("in no11 option22 "); 
							document.frm.tkflyes[0].checked = false;
							document.frm.tkflyes[1].checked = true;
							//document.getElementById("showdiv").style.display =""; 
						</script>
							<%
								} else {
										strText = "display:none";
							%>

							<script language="JavaScript">     
	                    	// alert("in yes option 222"); 
	                    	 
								document.frm.tkflyes[0].checked = true;
								document.frm.tkflyes[1].checked = false;	
								//document.getElementsByName("showdiv").style.display ="none";  
								
								
							</script>
							<%
								}
								}
							%>
								
					<!-- end -->				
	
									<%
									if (strforPriceDesicion.equalsIgnoreCase("y")) {
								%>
								<div id="showdiv" style="<%=strText%>">

								<table width="62%" border="0" cellpadding="0" cellspacing="1">
									<tr>
										<td bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.airline",strsesLanguage)%></td>
										<td bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%></td>
										<td bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.localprice",strsesLanguage)%></td>
										<td bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
									</tr>
									<tr>
										<td bgcolor="#FFFFFF" valign="top"><input type="text"
											name="airline" size="8" maxlength="50" class="textBoxCss"
											onKeyUp="return test1('airline', 50, 'cn')"></td>
										<script language="javascript">
	                         		   document.frm.airline.value="<%=strAirLineName.trim()%>";
	                        		 </script>
										<td bgcolor="#FFFFFF" valign="top"><select
											name="currency" class="textBoxCss">


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
										</select> <script language="javascript">
	                            document.frm.currency.value="<%=strCurreny.trim()%>"; 
	                         </script></td>
										<td bgcolor="#FFFFFF" valign="top"><input type="text"
											name="localprice" size="8"
											onkeyup="return test1('localprice', 10, 'n')" class="textBoxCss2"
											align="right"></td>

										<script language="javascript"> 
	                         		   document.frm.localprice.value="<%=strAmount.trim()%>";
	                        	 </script>

										<td bgcolor="#FFFFFF" valign="top"><textarea
											name="pricingRemarks" cols="28" rows="3" class="textBoxCss"
											class="textBoxCss" onkeyup="return test1('pricingRemarks', 300, 'all')"><%=strTkRemarks.trim()%></textarea>
										</td>
									</tr>
								</table>
								</div>

								<%
									}
								%>							
								</td>
								<%
									}
								%>

							</tr>


							
							

						</table>
						</td>
					</tr>
	         
	          <!-- End Here -->

	          <%
	          	          	//query to find if itenary details are not saved

	          	          	String strTravel_From = "";
	          	          	String strTravel_to = "";
	          	          	String strFieldStatus = "";

	          	          	strSql = "select isnull(Travel_from,'') as Travel_from,isnull(travel_to,'') as travel_to  from T_journey_details_DOM where travel_id='"
	          	          			+ strTravelId + "'";

	          	          	rs = dbConBean.executeQuery(strSql);

	          	          	if (rs.next()) {

	          	          		strTravel_From = rs.getString(1);
	          	          		strTravel_to = rs.getString(2);
	          	          	}

	          	          	if (strTravel_From.equals("") || strTravel_From.equals("")) {
	          	          		strFieldStatus = "blank";
	          	          	} else {

	          	          		strFieldStatus = "filled";
	          	          	}

	          	          	// System.out.println("strFieldStatus====="+strFieldStatus); 
	          	          	dbConBean.close();
	          	          %> 
	         
	         
	          <tr> 
	            <td class="label2" > 
				<a href="#" onclick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=D&whichPage=Group_itinerary_details_DOM.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage) %>"><img src="images/AttachFile.gif?buildstamp=2_0_0" width="94" height="24" border="0" /></a>
				<!-- <input type="submit" name="Submit" value="Attach File"  class="formButton" /> -->
				</td>
	            <td colspan="2"><div align="right">
	              <input type="submit" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.back",strsesLanguage)%>"  class="formButton" style="height: 22px;width:46px;" onclick="return BackPage(this.form);" /> 
	              <input type="submit" name="saveandexit" value="<%=dbLabelBean.getLabel("button.global.saveandexit",strsesLanguage)%>" style="height: 22px;width:auto;" class="formButton" onclick="return checkData(this.form,'saveandexit','<%=strFieldcheck%>');"/> 
	              <input type="submit" name="save" value="<%=dbLabelBean.getLabel("button.global.save",strsesLanguage)%>"  class="formButton" style="height: 22px;width:50px;" onclick="return checkData(this.form,'save','<%=strFieldcheck%>');"  /> <!--  -->
	              <input type="submit" name="saveProceed" value="<%=dbLabelBean.getLabel("button.global.submittoworkflow",strsesLanguage)%>" style="height: 22px;width:144px;"  class="formButton"  onclick="return checkData(this.form,'saveProceed','<%=strFieldcheck%>');"/>
	              <input type="hidden" name="matapricecomp"	value="<%=strforPriceDesicion%>" />
	            </div></td>
	            </tr>
	        </table></td>
	      </tr>
		<!-- <tr>
	            <td class="label2">&nbsp;</td>
	            <td>&nbsp;</td>
	            <td class="label2">&nbsp;</td>
	          </tr> -->    
	    </table></td>
	  </tr> 
	</table>
	
		<input type="hidden" name="fieldstatus" value="<%=strFieldStatus.trim()%>" >    
	<script language="JavaScript">
	
	if(document.frm.fieldstatus.value=='blank'){       
	   document.frm.saveProceed.disabled=true;           
	  alert('<%=dbLabelBean.getLabel("message.deatailsofforwardjouneynotsaved",strsesLanguage)%>');      
	} 
	else{ 
	 document.frm.saveProceed.disabled="";         
	}
	
	$(document).ready(function() {
		var manager = document.frm.manager.value;
		var hod = document.frm.hod.value;	
		
		if((manager != "S" && manager != "") && (hod != "S" && hod != "")) {
			document.frm.reasonForSkip.disabled=true;
			document.frm.reasonForSkip.value="";
		} else if((manager == "S" || manager == "") && (hod == "S" || hod == "")) {
			document.frm.reasonForSkip.disabled=false;
		} else if((manager != "S" || manager != "") && (hod == "S" || hod == "")) {
			document.frm.reasonForSkip.disabled=false;
		} else if((manager == "S" || manager == "") && (hod != "S" || hod != "")) {
			document.frm.reasonForSkip.disabled=false;
		}
	});
	</script> 
	<BR>
	  <input type="hidden" name="todayDate" value="<%=strCurrentDate%>"/>
	   <input type="hidden" name="travelReqId" value="<%=strTravelReqId%>"/>
	   <input type="hidden" name="travelId" value="<%=strTravelId%>"/> <!--  HIDDEN FIELD  -->
	    <input type="hidden" name="travelReqNo" value="<%=strTravelReqNo%>"/> 
		<input type="hidden" name="refreshFlag" value=""/> 
		<input type="hidden" name="flag">
		<input type="hidden" name="whatAction"/>
		<input type="hidden" name="hiddsiteid" value="<%=strSiteId %>" />
		<input type="hidden" name="site" value="<%=strSiteId %>" />
		<input type="hidden" name="hidGrAppLvl3flg" value="<%=strAppLvl3flg %>" />
		<input type="hidden" name="hidAppLvl3showbmflg" value="<%=strAppLvl3flgforBM%>" />
		<input type="hidden" name="hiddeptDate" value="<%=strDeptDate%>"></input>
	              </td><td width="11" background="images/index_03.png?buildstamp=2_0_0"><img src="images/index_03.png?buildstamp=2_0_0" alt="" width="14" height="426" /></td>
	          </tr>
	          <tr>
			    <td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
			    <td height="20" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
			    <td width="11" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
			  </tr>
	        </table></td>
	      </tr>
	    </table> 
	  </tr>
	</table>
	
	</form>
	</body>
	</html>
