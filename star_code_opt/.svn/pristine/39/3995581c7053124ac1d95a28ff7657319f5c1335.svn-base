	<%
		/***************************************************
		 *The information contained here in is confidential and  
		 * proprietary to MIND and forms the part of the MIND 
		 *Author				                   :Shiv sharma  
		 *Date of Creation 			: 17-Feb-08
		 *Copyright Notice 			:Copyright(C)2000 MIND.All rights reserved
		 *Project	  				:STARS
		 *Operating environment		:Tomcat, sql server 2000 
		 *Description 		     	:This is  jsp file  for create the Group Travel Requsition
		 *Modification 	    		:1. Code commented by shiv on 07 jan 2009 for not showing travel mode as requested by MATA
									 2. Change text for  Non Sumi Motherson   to  Non samvardhana on 03-Sep-09  by shiv sharma  
									 3.//added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
										
		 *Reason of Modification    :
		 *Date of Modification      :
		 *Modified By	            :
		 *Editor				    :Editplus 
									:Modified by vaibhav on Aug 20 2010to show only authorised approver in case if billing site is     different. 
		 							:Modified by vaibhav on 30 sep 2010 to add constraint on per day expense.
		 							:Modified by Pankaj Dubey on 11 Nov 2010 to add 5 new fields to record budgetory figures.
		 *Modification 	  			:sorting the approver level 1 and 2
		 *Modified By	  			:Manoj
		 *Date of Modification 		:25 jan 2011		
		 
		 *Modification				:Showing alert if selected approver is in default approver list
		 *Modified by				:Manoj
		 *Date of Modification		:28 March 2011 
		 
		 *Modification				:modify desinging of page and create workflow according to the selected site 
		 *Modified by				:Manoj Chand
		 *Date of Modification		:03 Oct 2011
		 
		 *Modification				:Implement feature of buying ticket from Non-MATA source  
		 *Modified by				:Manoj Chand
		 *Date of Modification		:23 Nov 2011
		 
		 *Modification				:apply validation in non-mata source controls
		 *Date of Modification		:21 Feb 2012
		 *Modified By				:Manoj Chand
		 
		 *Modification				:Add Board Member dropdown for SMP  
		 *Modified by				:Manoj Chand
		 *Date of Modification		:28 Mar 2012
		 
		 *Modified By	  			:Manoj Chand
		 *Date of Modification 		: 04 Apr 2012
		 *Modification 	  			:add a check for unit head approval level 1 and 2 selection is not mandatory in SMP site
		 
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
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<%@ page import = "java.sql.*" pageEncoding="utf-8"%>
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Create Group/Guest Travel Request</title>
	
	<link href="style/jquery-ui-1.9.2.css?buildstamp=2_0_0" rel="stylesheet" type="text/css"/>
	<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	
	<script language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
	<script language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></script>
	<!-- <script language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></script> -->
	<script language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="ScriptLibrary/popcalendar.js?buildstamp=2_0_0"></script>
	
	<script language="JavaScript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
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
	<%
	request.setCharacterEncoding("UTF-8");
	//code added by Gurmeet Singh on 17 january 2014
	String strManagerSelected = "";
	String strHodSelected = "";
	String strBoardMemberSelected = "";
	
	String strSql1="";
	ResultSet rs12 = null;
	String strSiteId="";
	strSiteId=request.getParameter("site")==null?strSiteIdSS:request.getParameter("site");
	
	//System.out.println("strsiteid--int--->"+strSiteId);
	String strSHOW_BUD_INPUT = "N";
		String strforPriceDesicion = "";
	//change manoj
		//String strSql1 = "SELECT SHOW_BUD_INPUT FROM M_SITE WHERE site_id = "+strSiteId+" ";
		strSql1="Select isnull(INT_LOCAL_AGENT,'') as INT_LOCAL_AGENT , SHOW_BUD_INPUT  From m_site where site_id="
			+ strSiteId + " and status_id=10 ";
	
	
	//System.out.println("panakj ===================== "+strSql1);
	rs12 = dbConBean.executeQuery(strSql1);
	while (rs12.next()) {
		strforPriceDesicion = rs12.getString("INT_LOCAL_AGENT");
		//System.out.println("strforPriceDesicion------->"+strforPriceDesicion);
		strSHOW_BUD_INPUT = rs12.getString("SHOW_BUD_INPUT");
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
		//System.out.println("strAppLvl3flg-gr-->"+strAppLvl3flg);
	}
	rs12.close();
	//code added by manoj chand on 04 April 2012 to get unit head flag.
	rs12=null;
	String strUnit_Head="0";
	strSql1="SELECT A.UNIT_HEAD FROM USER_MULTIPLE_ACCESS AS A INNER JOIN M_USERINFO AS B ON A.USERID = B.USERID WHERE (A.STATUS_ID = 10) AND (B.STATUS_ID = 10) AND (A.UNIT_HEAD = 1) AND A.USERID = "+Suser_id+" AND A.SITE_ID = "+strSiteId+" ";
	//System.out.println("strSql1-gi-->"+strSql1);
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
	
	String strDeptDate=request.getParameter("depDate")==null?"":request.getParameter("depDate");
	%>
	
	
	<script  language=JavaScript >
	 window.history.forward(1);
	
	   function button_onclick(obj) 
		    {
			             popUpCalendar(obj,obj,"dd/mm/yyyy"); 
			}
	
	
	 //function for showing the default approver list
	function defaultApproverList(frm)
	{
		//var siteId = document.frm.site.value;
		//change manoj
		var siteId = '<%=strSiteId%>';
		var url = 'T_DefaultApproverList.jsp?traveltype=INT&siteId='+siteId;
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
		//alert("lnjklasfkl");
			   document.frm.action="Group_T_IntTrv_Details.jsp";
	     	   document.frm.submit();
			}
	function getSiteID(frm)
	       { 
	        //alert(document.frm.billingSMGSite.value);
		    document.frm.action="Group_itinerary_details.jsp";
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
				if(obj1=='RetdepCity')
				{
					obj = document.frm.RetdepCity;
				}
				if(obj1=='RetarrCity')
				{
					 obj = document.frm.RetarrCity;
				}
				if(obj1=='RetnameOfAirline')
				{
					 obj = document.frm.RetnameOfAirline;
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
				//check1();
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
	        
			///alert(">>>"+fieldcheck+"<<<<");
			// if no user to return then these fielde not required to check  
	        if(fieldcheck=='required'){ 
	        
					if(f1.RetdepCity.value=="")
					{
						alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
						f1.RetdepCity.focus();
						return false;
					}
					if(f1.RetarrCity.value=="")
					{
						alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
						f1.RetarrCity.focus(); 
						return false;
					}
					if(f1.RetdepDate.value=="")
					{
						alert('<%=dbLabelBean.getLabel("alert.global.departuredate",strsesLanguage)%>');
						f1.RetdepDate.focus();
						return false;
					}
			     	if(f1.RetnameOfAirline.value=="")
					{
						alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>');
						f1.RetnameOfAirline.focus();
						return false;
					}
			 
			      var todayDate  =  f1.todayDate.value;   
			      var depDate    =  f1.RetdepDate.value; 
			      var flag1 = checkDate10(f1,todayDate,depDate,f1.todayDate,f1.RetdepDate,'<%=dbLabelBean.getLabel("alert.global.departuredateofreturnjourneynotsmallerthantodyadate",strsesLanguage)%> ','no');
			      if(flag1 == false)
			  	   return flag1;
			      var flag2 = checkDate10(f1,'<%=strDeptDate%>',depDate,'',f1.RetdepDate,'<%=dbLabelBean.getLabel("alert.global.departuredateofreturnjourneynotsmallerthandeptdateoffwdjourney",strsesLanguage)%> ','no');
			      if(flag2 == false)
			  	   return flag2;
	  	   
          }else {
                  f1.RetdepCity.value="";
		          f1.RetarrCity.value="";
		          f1.RetdepDate.value="";
		          f1.RetnameOfAirline.value="";  
		          
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
			
	      //code added by manoj chand on 28 March 2012 to validate at least one level approver is selected for SMP SITE.
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
	        }//end of else block
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
			 //change manoj
		if (document.frm.billingSMGSite.value!='<%=strSiteId%>' && tt!='1')
				{  	
			      if(!f1.billing[1].checked)
					  {
					
					     
	        				if(document.frm.billingSMGUser.value=="-1" )
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
					    //.getAttribute('alt') is added by manoj chand on 20/06/2013 in place of .alt to resolve problem of 'delegate authority' related alert coming in mozilla browser. 
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
					// script added by Pankaj on 11 nov 2010 to force user filling YTM fields or appropriate remarks. (STARTS)
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
					// script added by Pankaj on 11 nov 2010 to force user filling YTM fields or appropriate remarks. (ENDS)
				  	  
		  	  
		  	    	  	
		  	    if (finallist!='')  {
			    finallist="Currently "+finallist;
			    }
		                 
		               
			             if(confirm(finallist+'<%=dbLabelBean.getLabel("alert.global.submittoworkflow",strsesLanguage)%>'))
		                          {
									 f1.saveProceed.disabled=true;//added on  by shiv 
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
				//JQUERY DROPDOWN FILLING IMPLEMENTAION STARTS
				//$.noConflict();
				//change manoj
				if(flag=='first')
				{
				jQuery(document).ready(function($) {
							var managerId = $("#firstapprover option:selected").val();
							var urlParams2 = '<%="&SITE_ID="+strSiteId+"&sp_role="+SSstrSplRole+"&reqpage=approver1&traveltype=I"%>';
							var urlParams = "managerId="+managerId+urlParams2;
							//alert(urlParams);
							$.ajax({
					            type: "post",
					            url: "AjaxMaster.jsp",
					            data: urlParams,
					            success: function(result){
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
				};
				//JQUERY DROPDOWN FILLING IMPLEMENTAION ENDS


	//JQUERY DROPDOWN FILLING IMPLEMENTAION STARTS
				//$.noConflict();
				//change manoj
				if(flag=='second')
				{
					
				jQuery(document).ready(function($) {
							var managerId = $("#secondapprover option:selected").val();
							var urlParams2 = '<%="&SITE_ID="+strSiteId+"&sp_role="+SSstrSplRole+"&reqpage=approver2&traveltype=I"%>';
							var urlParams = "managerId="+managerId+urlParams2;
							//alert(urlParams);
							$.ajax({
					            type: "post",
					            url: "AjaxMaster.jsp",
					            data: urlParams,
					            success: function(result){
					            	
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
				});

				}//end if

				
				//JQUERY DROPDOWN FILLING IMPLEMENTAION ENDS


				
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
			//function added by vaibhav on 30 sep 2010 to add constraint on per day expense.
			function checkMsg(){
				 var chm=document.forms[0].checkMsg.value;
				// alert("hello "+chm);
				 if (chm=="ExpenceCheck")
				  {
					  alert('<%=dbLabelBean.getLabel("alert.createrequest.couldnotsubmittoworkflow",strsesLanguage)%>');
				  }

				  
			 }

			 // added by manoj chand on 22 nov 2011 for showing MATA price comparision  
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

			
	</script>
	<%
		String strSql = null; // String for Sql String
		ResultSet rs, rs1, rs2 = null; // Object for ResultSet

		String strTravelReqId = "";
		String strTravelId = "";
		String strTravelReqNo = "";
		String strPreferTime = "";
		String strTravelMode = "";
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

		String strSeatRetPreffered = "";
		String strRemarks = "";
		//added by manoj on 22 nov 
		String strTicketProvider = "";
		String strAirLineName = "";
		String strCurreny = "USD";
		String strAmount = "";
		String strTkRemarks="";
		// below 5 fields added by Pankaj on 11 Nov 10
		String dbl_YTM_BUDGET = "";
		String dbl_YTD_ACTUAL = "";
		String dbl_AVAIL_BUDGET = "";
		String dbl_EST_EXP = "";
		String str_EXP_REMARKS = "";

		Connection objCon = null; //Object for Connection 
		CallableStatement objCstmt = null;

		String strRetDepDate = "";
		String strRetPreferTime = "";
		String strRetTravelMode = "";
		String strRetTravelClass = "";
		String strDepRetCity = "";
		String strArrRetCity = "";
		String strNameOfRetAirline = "";
		String strPageFlage = "";

		String strFieldcheck = "";

		//ADDED BY MANOJ ON 23 MAY 2011
		String strUpFlag=request.getParameter("UpFlag")==null?"":request.getParameter("UpFlag");
		
		//System.out.println("strUpFlag---details--->"+strUpFlag);
		
		//end
		strMessage = request.getParameter("message") == null ? "" : request
				.getParameter("message");
		strRefreshFlag = request.getParameter("refreshFlag") == null ? "2"
				: request.getParameter("refreshFlag");
		//strBillingSite = request.getParameter("billingSMGSite") == null ? strSiteIdSS	: request.getParameter("billingSMGSite");
		//change by manoj 
		strBillingSite = request.getParameter("billingSMGSite") == null ? strSiteId	: request.getParameter("billingSMGSite");
		
		
		strBillingClient = request.getParameter("billingSMGUser") == null ? "-1"
				: request.getParameter("billingSMGUser");
		strReasonForSkip = request.getParameter("reasonForSkip") == null ? ""
				: request.getParameter("reasonForSkip");
		strReasonForTravel = request.getParameter("reasonForTravel") == null ? ""
				: request.getParameter("reasonForTravel");
		strRetDepDate = request.getParameter("RetdepDate") == null ? ""
				: request.getParameter("RetdepDate");
		strRetPreferTime = request.getParameter("RetpreferTime") == null ? "2"
				: request.getParameter("RetpreferTime");
		strRetTravelMode = request.getParameter("RettravelMode") == null ? "1"
				: request.getParameter("RettravelMode");
		strRetTravelClass = request.getParameter("RettravelClass") == null ? "1"
				: request.getParameter("RettravelClass");
		strManager = request.getParameter("manager") == null ? "S"
				: request.getParameter("manager");
		strHod = request.getParameter("hod") == null ? "S" : request
				.getParameter("hod");
		//added by manoj chand on 28 march 2012 to get board member
		strBoardMember					=  request.getParameter("boardmember");
		
		strDepRetCity = request.getParameter("RetdepCity") == null ? ""
				: request.getParameter("RetdepCity");
		strArrRetCity = request.getParameter("RetarrCity") == null ? ""
				: request.getParameter("RetarrCity");
		strNameOfRetAirline = request.getParameter("RetnameOfAirline") == null ? ""
				: request.getParameter("RetnameOfAirline");
		strCashBreakupRemarks = ""; //request.getParameter("expRemarks")==null ?"" :request.getParameter("expRemarks");
		strRemarks = request.getParameter("Remarks") == null ? "" : request
				.getParameter("Remarks");
		String strTravellerId = request.getParameter("travellerId");

		//System.out.println("strTravellerId==============="+strTravellerId);

		if (strPreferTime == null)
			strPreferTime = "1";

		if (strTravelMode == null)
			strTravelMode = "1";

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

		strPageFlage = request.getParameter("pageFlag") == null ? ""
				: request.getParameter("pageFlag"); // for hidden field

		out.println("<BR>");

		if (strPageFlage != null && strPageFlage.equalsIgnoreCase("yes")) {

			String[] strUsertoReturn = request
					.getParameterValues("userids");
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

			objCon = dbConBean.getConnection();
			objCstmt = objCon
					.prepareCall("{?=call PROC_GROUP_RETURN_JOURNEY(?,?)}");
			objCstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			objCstmt.setString(2, strtext.trim());
			objCstmt.setInt(3, Integer.parseInt(strTravelId.trim()));
			int intSuccess10 = objCstmt.executeUpdate();
			objCstmt.close();

		}
		// code that find approver whi are out of office  

		String strApproverid = "";
		String ApproverText = "";
		String strname1 = "";
		String strname2 = "";
		String strFlag = "";
		String strtextbox = "";
		String strusercount = "";

		//code to find default approver who is oou of office 
//change manoj
		strSql = "SELECT  top 1 APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE  (SITE_ID = "
				+ strSiteId
				+ ") AND (STATUS_ID = 10) AND (TRV_TYPE = 'i') AND sp_role="
				+ SSstrSplRole + " order by order_id";
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
					ApproverText = ApproverText
							+ strname2
							+ " "+dbLabelBean.getLabel("alert.createrequest.hasdelegatedhisauthorityto",strsesLanguage)+" "
							+ strname1 + ".\n ";
				}

			}
			rs1.close();
		}
		
		//ADDED BY MANOJ ON 20 MAY 2011
		rs.close();
		// 	code to find default approver who is oou of office  close()  

		Date currentDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String strCurrentDate = (sdf.format(currentDate)).trim();
		
		String groupGuestItenaryDetailLabel = "";
		if(ssflage.equals("3")){
			groupGuestItenaryDetailLabel = "label.global.guestitinerarydetails";
		}else{
			groupGuestItenaryDetailLabel = "label.global.groupguestitinerarydetails";
		}
	%>
	
	<body onload="checkMsg();">  
	
 	<%
 	//SpolicyPath variable used on 07 jan 2013 for getting company policy path
  	//	 		String Path = application.getInitParameter("companyPolicyPath");
  		 		File UploadFile = new File(SpolicyPath + "/" + strSiteFullName + "/"
  		 				+ strSiteFullName + ".html");
  		 	%>
	
	<form name="frm" action="Group_itinerary_detailsPost.jsp" style="margin-top:-20px; padding-top:0px;">
	
 
	
	<input type ="hidden" name=approverlist value="<%=ApproverText%>"/> 
	<input type="hidden" name="checkMsg" value='<%=request.getParameter("message")%>' />
	
	<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center"> 
	  <tr>
	    <td background="images/tophdbg.gif?buildstamp=2_0_0"><img src="images/group-travel-request.png?buildstamp=2_0_0" alt="<%=dbLabelBean.getLabel(groupGuestItenaryDetailLabel,strsesLanguage)%>" width="237" height="35" /></td>
	    <td width="15%" background="images/tophdbg.gif?buildstamp=2_0_0"><img src="images/BigIcon.gif?buildstamp=2_0_0" alt="" width="46" height="31" /></td>
	  </tr>
	</table>
	<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" >
	<tr><td height="9px"></td></tr>
	  <tr>
	    <td>
	    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">  
	      
	      <tr>
	        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr>
	            <td valign="top" background="images/index_01.png?buildstamp=2_0_0"><img src="images/index_01.png?buildstamp=2_0_0" alt="" width="14" height="426" /></td>
	            <td width="100%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	              <tr>
	              <%
	              	String showmgs = "";

	              	if (strMessage.trim().equals("save")) {
	              		showmgs = "<font color=#CC3333>"+dbLabelBean.getLabel("message.global.infosavesuccessfully",strsesLanguage);
	              	} else if (strMessage.trim().equals("ExpenceCheck")) {
	              		showmgs = "";
	              	} else {
	              		showmgs = "<font color=#CC3333>" + strMessage + "</font>";
	              	}
	              %>
	                <td><img src="images/formTitIcon.png?buildstamp=2_0_0" alt="" width="30" height="29" /></td>
	                <td width="70%" background="images/tophd-bg.gif?buildstamp=2_0_0" class="formTit"><%=dbLabelBean.getLabel(groupGuestItenaryDetailLabel,strsesLanguage)%> &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;<%=showmgs%> </td> 
	                <td width="30%" background="images/tophd-bg.gif?buildstamp=2_0_0" align="right"><a href="#" title="Company Policy" onClick="<%if (UploadFile.exists()) {%> MM_openBrWin('Companies_Policies/<%=strSiteFullName%>/<%=strSiteFullName%>.html','','scrollbars=yes,resizable=yes,width=700,height=300')
					<%;
			} else {%> MM_openBrWin('Companies_Policies/notexist.html','','scrollbars=yes,resizable=yes,width=700,height=300')<%;
			}%>" ><img src="images/IconPolicy.png?buildstamp=2_0_0" width="69" height="16" border="0" /></a><span class="formTit" style="text-align:right">
				&nbsp;<!-- <a href="#" onClick="MM_openBrWin('helpinternational travel.html#300a','','scrollbars=yes,resizable=yes,width=700,height=300')">
				  <img src="images/help.png?buildstamp=2_0_0" width="44" height="16" border="0" > -->
	             </td>
	              </tr>
	            </table>
	              <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                  <td height="20" bgcolor="#FFFFFF"> 
					  <table cellspacing=0 cellpadding=0 width="100%" border=0>   
	                    
	                     <tr> 
					   	<td class=formfirstfield    align=left bgcolor=#FFFFFF colspan=2 height="20">           
					       <%=dbLabelBean.getLabel("label.global.returningtravelersdetails",strsesLanguage)%> 	  
					      </td>
						 
	                	 
	                </tr> 
	                
	                
	                 <tr>    
					    
					  <td>           
					  
					  <table width="98%" border="1" cellpadding="0" cellspacing="1" bordercolor="#F0F0F0" align="center" style="border-collapse: collapse;">        <tr> 
					                <td width="5%" height="15" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%> </strong></div></td>
					                <td width="13%" class="label3"><div align="left"><strong>&nbsp;<%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage)%> </strong></div></td>
					                <td width="13%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></strong></div></td>
					                <td width="10%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%></strong></div></td>
					                <td width="15%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.age",strsesLanguage)%></strong></div></td>
					                <td width="10%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></strong></div></td>
					                <td width="10%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.mealpref",strsesLanguage)%></strong></div></td>
					                <td width="10%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage)%></strong></div></td>
					               <!--  <td width="10%" class="label2"><div align="center"><strong>Total Forex</strong></div></td>  -->
					                <!-- <td width="11%" class="label2"><div align="center"><strong>Action</strong></div></td> -->
					              </tr>
					              <tr>
					                <td height="15" class=label3>&nbsp;</td>
					                <td class="label3">&nbsp;</td>
					                <td class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.createrequest.passportnumber",strsesLanguage)%> </strong></div></td>
					                <td class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%> </strong></div></td>
					                <td class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%></strong></div></td>
					                <td class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%></strong></div></td>
					                <td class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.visarequired",strsesLanguage)%></strong></div></td>
					                 <td class="label3"></td>
					               <!--  <td class="label2"><div align="center"><strong>ECR</strong></div></td>  --> 
					               <!--  <td class="label2">&nbsp;</td>  -->
					           </tr>
					      <%
					      	String strTACurrency = "USD";
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
					      	String strNationality_list = "";
					      	String strDateofIssue_list = "";
					      	String strPlacesofIssue_list = "";
					      	String strDateofExpiry_list = "";
					      	String strECNR_list = "";
					      	String strVisaReqiured_list = "";
					      	String strVisaReq = "";
					      	String strSex = "";
					      	String strCurrency = "";
					      	String strGender = "";
					      	String strEcnr = "";
					    	String strTotalFareCur="";
					    	String strTotalFareAmt="0";
					      	int intSerialNo = 1;

					      	{
					      		//setting flag  whern request is not new        

					      		strSql = "SELECT  G_USERID,Site_id,FIRST_NAME,LAST_NAME, dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG, ISNULL(dbo.CONVERTDATEDMY1(DOB),'-') AS DOB,AGE,GENDER, "
					      				+ " ISNULL(dbo.MEAL_NAME(MAEL_ID),'-') AS  MEALNAME,TOTAL_AMOUNT,  PASSPORT_NO,  ISNULL(NATIONALITY ,'') AS NATIONALITY,  ISNULL(dbo.CONVERTDATEDMY1(DATE_OF_ISSUE),'-') AS DATE_OF_ISSUE, PLACE_OF_ISSUE, "
					      				+ " ISNULL(dbo.CONVERTDATEDMY1(EXPIRY_DATE),'-') AS EXPIRY_DATE,  ECNR,  VISA_REQUIRED "
					      				+ "  FROM     T_GROUP_USERINFO  WHERE  travel_type='i' and Return_travel ='y' and (TRAVEL_ID = "
					      				+ strTravelId
					      				+ " )  and STATUS_ID=10 order by  FIRST_NAME";

					      		rs = dbConBean.executeQuery(strSql);
					      		//  while(rs.next())

					      		if (rs.next()) {
					      			do {
					      				strG_userid = rs.getString("G_USERID");
					      				//Site_ID                            =rs.getString("Site_id");
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
					      				strPassortNo_list = rs.getString("PASSPORT_NO");
					      				strNationality_list = rs.getString("NATIONALITY");
					      				strDateofIssue_list = rs.getString("DATE_OF_ISSUE");
					      				strPlacesofIssue_list = rs.getString("PLACE_OF_ISSUE");
					      				strDateofExpiry_list = rs.getString("EXPIRY_DATE");
					      				strECNR_list = rs.getString("ECNR");

					      				if (strECNR_list != null) {
					      					if (strECNR_list.trim().equals("1")) {
					      						strEcnr = "Yes";
					      					} else if (strECNR_list.trim().equals("2")) {
					      						strEcnr = "No";
					      					} else if (strECNR_list.trim().equals("3")) {
					      						strEcnr = "N/A";
					      					}
					      				}
					      				strVisaReqiured_list = rs.getString("VISA_REQUIRED");

					      				if (strVisaReqiured_list != null
					      						&& strVisaReqiured_list.equals("1")) {
					      					strVisaReqiured_list = "Yes";

					      				} else if (strVisaReqiured_list != null
					      						&& strVisaReqiured_list.equals("2"))
					      					strVisaReqiured_list = "No";

					      				//finding currency  id from  T_TRAVEL_EXPENDITURE_INT table fro each user
					      				strSql = "SELECT currency FROM  T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID = "
					      						+ strTravelId;
					      				//+" and G_userid="+strG_userid;	       
					      				rs1 = dbConBean1.executeQuery(strSql);
					      				while (rs1.next()) {
					      					strCurrency = rs1.getString(1);
					      				}
					      				rs1.close();
					      				// strCurrency_list		     =rs.getString("CURRENCY");
					      %>
											  		<tr>
											                <td height="25" class="label5"><div align="center"><%=intSerialNo%>.</div></td>
											                <td class="label5"><div align="left"> &nbsp;<%=strFirstName_List%>  <%=strLastName_List%> </div></td>
											                <td class="label5"><div align="center"><%=strDesigantion_List%><br />
															
											                 <%=strPassortNo_list%></div></td>
											                <td class="label5"><div align="center"><%=strDateOfBirth_List%><br />
											                  <%=strDateofIssue_list%></div></td>
											                <td class="label5"><div align="center"><%=strAge_List%><br />
											                <%=strDateofExpiry_list%></div></td>
											                <td class="label5"><div align="center"><%=strSex%><br />
											                  <%=strPlacesofIssue_list%></div></td>
											                <td class="label5"><div align="center"><%=strMealPref_list%><br />
											                 <%=strVisaReqiured_list%></div></td>  
											                  <td class="label5" style="vertical-align: top;"><div align="center"><%=strNationality_list%></div></td>  
													</tr>
											               
			                           <%       							intSerialNo++;
             																	}
					      														while (rs.next());
             																	} else {
             																	strusercount = "0";
             																	}

             																	rs.close();

             																	if (intSerialNo > 1) {
             																	strFieldcheck = "required";
             																} else {
             																strtextbox = "disabled";
             															}

             														}
             												%>
  	    
	                	</table>   
	  				        
	  				   
					</td>     
					 <!-- need to work here close  -->  
					</tr>
	                
	                
	                
	                
	                
	              <!-- close -->  
	              </table> 
	 
				  <%	
 	 				  	//show detail for journey for given travel detalis 
 	 				  	//System.out.println("strRefreshFlag--->"+strRefreshFlag);
 	 				  	if (!strRefreshFlag.equals("1")) {
 	 				  		try {
//change by manoj on 22 nov to fetch TK_PROVIDER_FLAG
 	 				  			strSql = "SELECT     t1.TRAVEL_ID, t2.site_id as site_id , t1.Return_FROM AS Return_FROM, t1.Return_TO AS Return_TO, dbo.CONVERTDATEDMY1(t1.TRAVEL_DATE) AS TRAVEL_DATE,  t1.TRAVEL_MODE AS TRAVEL_MODE, t1.MODE_NAME AS MODE_NAME, t1.TRAVEL_CLASS AS TRAVEL_CLASS, t1.TIMINGS AS TIMINGS,  t2.REASON_FOR_TRAVEL AS REASON_FOR_TRAVEL, t2.REASON_FOR_SKIP AS REASON_FOR_SKIP, ISNULL(t2.BILLING_SITE, '-1') AS BILLING_SITE,               ISNULL(t2.BILLING_CLIENT, '-1') AS BILLING_CLIENT, ISNULL(t2.MANAGER_ID,0) AS MANAGER_ID, ISNULL(t2.HOD_ID,0)  AS HOD_ID, isnull(t2.CASH_BREAKUP_REMARKS,'') as  CASH_BREAKUP_REMARKS,isnull(t1.SEAT_PREFFERED,'1') as SEAT_PREFFERED,t2.REMARKS as  REMARKS , t2.YTM_BUDGET, t2.YTD_ACTUAL, t2.AVAIL_BUDGET, t2.EST_EXP, t2.EXP_REMARKS,t2.TK_PROVIDER_FLAG,t2.TK_AIRLINE_NAME,t2.TK_CURRENCY,t2.TK_AMOUNT,t2.TK_REMARKS,t2.BOARD_MEMBER_ID,t2.FARE_CURRENCY,t2.FARE_AMOUNT  FROM   T_RET_JOURNEY_DETAILS_INT t1 INNER JOIN T_TRAVEL_DETAIL_INT t2 ON t1.TRAVEL_ID = t2.TRAVEL_ID WHERE  (t1.TRAVEL_ID = "
 	 				  					+ strTravelId
 	 				  					+ ") AND (t1.APPLICATION_ID = 1) AND  (t2.STATUS_ID = 10) ";
 	 				  	//System.out.println(strSql);
 	 				  			String strSite_id = "";
 	 				  			rs = dbConBean.executeQuery(strSql);

 	 				  			while (rs.next()) {
 	 				  				strSite_id = rs.getString("site_id");
 	 				  				strDepRetCity = rs.getString("Return_FROM");
 	 				  				strArrRetCity = rs.getString("Return_TO");
 	 				  				strRetDepDate = rs.getString("TRAVEL_DATE");
 	 				  				strRetTravelMode = rs.getString("TRAVEL_MODE");
 	 				  				strNameOfRetAirline = rs.getString("MODE_NAME");
 	 				  				strRetTravelClass = rs.getString("TRAVEL_CLASS");
 	 				  				strRetPreferTime = rs.getString("TIMINGS");

 	 				  				strReasonForTravel = rs.getString("REASON_FOR_TRAVEL")
 	 				  						.trim();
 	 				  				strReasonForSkip = rs.getString("REASON_FOR_SKIP");

 	 				  				if (strRetPreferTime.equals("")) {
 	 				  					strRetPreferTime = "2";
 	 				  				}
 	 				  				if (strRetTravelMode.equals("0")) {
 	 				  					strRetTravelMode = "1";
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
 	 				  				strSeatRetPreffered = rs.getString("SEAT_PREFFERED");

 	 				  				strRemarks = rs.getString("REMARKS");

 	 				  				dbl_YTM_BUDGET = rs.getString("YTM_BUDGET");
 	 				  				dbl_YTD_ACTUAL = rs.getString("YTD_ACTUAL");
 	 				  				dbl_AVAIL_BUDGET = rs.getString("AVAIL_BUDGET");
 	 				  				dbl_EST_EXP = rs.getString("EST_EXP");
 	 				  				str_EXP_REMARKS = rs.getString("EXP_REMARKS");
 	 				  		strTicketProvider=rs.getString("TK_PROVIDER_FLAG");
 	 				  		strAirLineName = rs.getString("TK_AIRLINE_NAME");
 	 						strCurreny = rs.getString("TK_CURRENCY");
 	 						strAmount = rs.getString("TK_AMOUNT");
 	 						strTkRemarks=rs.getString("TK_REMARKS");
 	 						strBoardMember		=	rs.getString("BOARD_MEMBER_ID");
 	 						strTotalFareCur=rs.getString("FARE_CURRENCY");
 	 						strTotalFareAmt=rs.getString("FARE_AMOUNT");
 	 						
 	 						if(strBoardMember==null || strBoardMember.equals("0")){
 	 							strBoardMember="B";
 	 						}
 	 						
 	 						if (strCurreny == null || strCurreny.equals(""))
 	 							strCurreny = "USD";
 	 						
	 	 				  			if(dbl_YTM_BUDGET.equalsIgnoreCase("0.0"))
	 	 								dbl_YTM_BUDGET = "";
	 	 							if(dbl_YTD_ACTUAL.equalsIgnoreCase("0.0"))
	 	 								dbl_YTD_ACTUAL = "";
	 	 							if(dbl_AVAIL_BUDGET.equalsIgnoreCase("0.0"))
	 	 								dbl_AVAIL_BUDGET = "";
	 	 							if(dbl_EST_EXP.equalsIgnoreCase("0.0"))
	 	 								dbl_EST_EXP = "";
 	 							
 	 							
 	 				  				if (strBillingSite.equals("-1")) {
 	 				  					strBillingSite = strSite_id;
 	 				  				}
//change manoj 2
 	 				  				if (strBillingSite == strSiteId) {
 	 				  					strBillingClient = "-1";
 	 				  					strBillingClientOurSide = "";
 	 				  					ischecked = "";
 	 				  				} else if (strBillingSite.equals("0")) {
 	 				  					strBillingSite = strSiteId;
 	 				  					strBillingClientOurSide = strBillingClient;
 	 				  					strBillingClient = "-1";
 	 				  					strComboState = "disabled";
 	 				  					ischecked = "checked";
 	 				  				}

 	 				  				if (strBillingClient.equals("")) {
 	 				  					strBillingClient = "-1";
 	 				  				}

 	 				  			}

 	 				  			rs.close();
 	 				  		} catch (Exception e) {

 	 				  			System.out.println("error in page Group_itinary_details.jsp================= "+ e);
 	 				  		}
 	 				  	} //END OF  refresh flage 
 	 				// and USER_SITE_ACCESS.STATUS_ID=10 condition added by manoj chand on 17 apr 2013 in existing query
 	 				  	if (strBillingSite == null) {
 	 				  	} else {
 	 				  		strSql = "SELECT  1 AS yes FROM USER_SITE_ACCESS WHERE "
 	 				  				+ "  USERID =(SELECT  TRAVELLER_ID  FROM  T_TRAVEL_DETAIL_INT "
 	 				  				+ " WHERE  TRAVEL_ID = " + strTravelId
 	 				  				+ ")AND (SITE_ID = " + strBillingSite + ") and USER_SITE_ACCESS.STATUS_ID=10";
 	 				  		rs = dbConBean.executeQuery(strSql);
 	 				  		while (rs.next()) {
 	 				  			strFlag = rs.getString(1);
 	 				  		}
 	 				  		rs.close();
 	 				  	}
 	 				  %>
	  <!--  added new for handeling billing site  -->
	  <input type="hidden" name="BillingSiteFlag" value="<%=strFlag%>" />
	    
	 <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-style:solid;border-color:#F0F0F0;border-collapse: collapse;">
	  <tr>
	    <td bgcolor="#FFFFFF">
	             <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" >
	             
	                  <tr>  
	                      <td height="25">   
	                      	 <table width="100%" border="0" cellpadding="1" cellspacing="1"> 
	                      	   <tr>
	                      	       <td > 
	                      	        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style: none;"> 
			                     	         <tr>
								                  <td height="20" class="label1"><%=dbLabelBean.getLabel("label.global.returnjourney",strsesLanguage)%><span class=starcolour>*</span> 
								                  </td>
								                </tr>
	                      	        	
			                      	     	   <tr>
				                      	     	      <td width="16%" class="label2"><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%><span  
									                      class=starcolour></span> </td>
									                  <td width="16%" class="label2"><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%><span 
									                      class=starcolour></span> </td>
									                  <td width="16%" class="label2"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%></td>
									                  <td width="10%" class="label2"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%></td> 
			                      	     	  </tr>
			                      	     	  
			                      	     	  <tr>
		                    					      <td height="25"> 
								                        <input type="text" name="RetdepCity" class="textBoxCss"   value="<%=strDepRetCity%>" onFocus="initializeAirPortName(this);" onKeyUp="return test1('RetdepCity', 30, 'c')" maxlength="30"  <%=strtextbox%> />         <!--   -->             </td>
															 	<script language="javascript">
									                              document.frm.RetdepCity.value="<%=strDepRetCity%>";
									                          </script>	
								                      <td class="label2">
										              <input type="text" name="RetarrCity" class="textBoxCss"   value="<%=strArrRetCity%>" onFocus="initializeAirPortName(this);"   onKeyUp="return test1('RetarrCity', 30, 'c')" maxlength="30" <%=strtextbox%>/></td>
										  						 <script language="javascript">
										                              document.frm.RetarrCity.value="<%=strArrRetCity%>";
										                        </script>	
								                      <td class="label2">
								                          <table width="60%" border="0" cellspacing="0" cellpadding="0">
									                          <tr>
		                        							    <td><!--Reaching Date at Destination-->
																	<input name="RetdepDate" <%=strtextbox%> type="text" class="textBoxCss" id="test2" size="6" value="<%=strRetDepDate%>" onfocus="javascript:vDateType='DD/MM/YYYY'" 	onkeyup="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter');" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" /> 
																	 <a onmouseover="window.status='Date Picker';return true;"  onmouseout="window.status='';return true;"                 onclick="button_onclick(document.frm.RetdepDate);" >
																	       <img height=15 alt=Calender src="images/calender.png?buildstamp=2_0_0"  width="18"/></a>	
																   	</td>
		                          								</tr>
		                        							</table>
		                        					 </td>
														<script language="javascript">
								                              document.frm.RetdepDate.value="<%=strRetDepDate%>";
								                        </script>	
						                        
											          <td>  
														<select name="retpreferTime" class="textBoxCss" <%=strtextbox%> >
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
										                            document.frm.retpreferTime.value="<%=strRetPreferTime%>";
										                        </script>		    
										               </td>
	                                           </tr>
	                                            <tr> 
								                      <td width="21%"   class="label2"><!-- Mode1 --></td>
								                      <td width="21%" class="label2"><%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%></td> 
								                      <td width="18%" class="label2"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%></td>
								                      <td width="16%" class="label2"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%></td> 
				  		                       </tr> 
				  		                       <tr>
						                      <td height="25"><!-- Code commented by shiv on 07 jan 2009 for not showing travel mode as requested by MATA    -->
					                           </td>
					                      <td class="label2">
										  <input type="text" name="RetnameOfAirline"  <%=strtextbox%> class="textBoxCss"   value="<%=strNameOfRetAirline%>"  onkeyup="return test1('RetnameOfAirline', 30, 'cn')" maxlength="30" /></td>
					
										   <script language="javascript">
					                              document.frm.RetnameOfAirline.value="<%=strNameOfRetAirline%>";
					                        </script>	
					                      <td class="label2">
										  <select name="rettravelClass" class="textBoxCss" <%=strtextbox%> >  
										  					  <%
  										  					  	//For Population of Travel Class Combo For Departure
  										  					  	if (strTravelMode.equals("2"))
  										  					  		strSql = "SELECT TRAIN_ID, ELIGIBILITY FROM M_TRAIN_CLASS WHERE STATUS_ID=10";
  										  					  	else
  										  					  		strSql = "SELECT AIR_ID, ELIGIBILITY FROM M_AIRLINE_CLASS WHERE STATUS_ID=10";

  										  					  	rs = dbConBean.executeQuery(strSql);
  										  					  	while (rs.next()) {
  										  					  %>
															 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																	<%
																		}
																		rs.close();
																	%></select>
											</td>
					                      
											<script language="javascript">
											 
											 var class1='<%=strRetTravelClass%>';

											 document.frm.rettravelClass.value="<%=strRetTravelClass%>"; 
											   
					                        </script>	 		
					                      <td>    
					                 	  <select name="retseatpreference" class="textBoxCss"  <%=strtextbox%>>  
										  					  <%
  										  					  	//For Population of Travel Class Combo For Departure  

  										  					  	strSql = "SELECT  seat_id, Seat_Name FROM  M_SEAT_PREFER (NOLOCK) WHERE (MODE_ID = 1) AND (TRAVEL_AGENCY_ID = 1) AND (STATUS_ID = 10) ORDER BY SEAT_ID";

  										  					  	rs = dbConBean.executeQuery(strSql);
  										  					  	while (rs.next()) {
  										  					  %>
															 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																	<%
																		}
																		rs.close();
																	%></select> 
													</td>
					                      
											<script language="javascript">
											
					                           var seat='<%=strSeatRetPreffered%>';
					                               
											   if(seat=='' || seat==0){
					                               //document.frm.retseatpreference.value="";  
					                            }else{
					                            document.frm.retseatpreference.value="<%=strSeatRetPreffered%>";
					                            }
					                        </script>
					                      
					                      </tr> 
	                    
	                      	     </table>
	                      	    </td>
	                      	   </tr>
	                      	   
	                      	   
	                      	    <%
 	                      	    	if (strusercount == "0") {
 	                      	    %>
	                  			    <tr>
	                  			        <td class="label2"><%=dbLabelBean.getLabel("label.global.notravelerforreturnjourney",strsesLanguage)%> </td>
		                 		   </tr>
		                 		<%
		                 			}
		                 		%> 
		                 	 </table>  
	                       </td> 
	                       </tr> 
	                       
	                       
	                       </table>
	                       </td></tr>
	                     
<!-- start from here -->
 <!-- added by manoj chand on 27 nov 2012 to add Total Travel Fare -->
 <%if(strAppLvl3flg.equalsIgnoreCase("Y")){ %>
<tr>
<td>

 <table width="98%" border="0" align="center" cellpadding="1" cellspacing="1" >
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
</td>
</tr>
<!-- end here -->
<%} %>	                       
	                  <tr>
	                  <td height="25"  style="border-style:solid;border-color:#F0F0F0;"> 
					    <table width="98%" border="0" cellspacing="0" cellpadding="0" align=center>
	                    <tr>
	                      <td height="20" class="label1"><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel",strsesLanguage)%><span class="starcolour">*</span></td>
	                      <td class="label6"><strong><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage)%> </strong></td>
	                      <td class="label6"><strong><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage)%> </strong></td>  
	                      
	                      <!-- added by Manoj Chand on 27 March 2012 to add board member combobox for smp sites -->
	<% if(strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>
						<td class="label6"><strong><%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage)%></strong></td> 
	<%}else{ %>
						<td class="label6"><a href="#" onclick="return defaultApproverList(this.form);"> <%=dbLabelBean.getLabel("link.global.viewallapprovers",strsesLanguage)%> </a></td>
	<%} %>
	                    </tr>
	                    
	                    <tr>
	                      <td height="20" class="label2">					  </td>
	                      <td class="label2"><span class="label2"> <select name="manager" id="firstapprover" class="textBoxCss" onchange="skipDisabled(this.form,'first');">  
					               <%
  					               	// MODIFICATION END   <!--MANAGER COMBO-->
  					               %>
									    <option value="S"><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel1",strsesLanguage)%></option> 
											<%
 								//change manoj	
 								//query commented by manoj chand on 03 June 2013
 									//strSql = "Select dbo.user_name(dbo.finalooo(USERID,getdate(),'I')),USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId + " AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 3";
									//query added by manoj chand on 03 June 2013 to display other side user in approval level 1
									strSql="Select dbo.user_name(dbo.finalooo(USERID,getdate(),'I')),USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId+"  AND STATUS_ID=10 AND APPLICATION_ID=1"+
									"UNION SELECT dbo.user_name(dbo.finalooo(UAM.USERID,getdate(),'I')),UAM.USERID,dbo.user_name(UAM.USERID)AS PM FROM USER_MULTIPLE_ACCESS UAM WHERE SITE_ID="+strSiteId+" AND APPROVAL_LVL1='Y' AND STATUS_ID=10 ORDER BY 3";		
 									//System.out.println("strSql --int--1->"+strSql);										
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
                 strSql="SELECT TOP 1 MANAGER_ID, HOD_ID, BOARD_MEMBER_ID FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND TRAVEL_TYPE='I' AND T_TRAVEL_STATUS.TRAVEL_STATUS_ID = 10 WHERE TRAVELLER_ID = "+Suser_id+" ORDER BY C_DATETIME DESC";
                 rs       =   dbConBean.executeQuery(strSql); 
                 if(rs.next())
                 {
                	 strManagerSelected = rs.getString("MANAGER_ID");
                	 strHodSelected = rs.getString("HOD_ID");
                	 strBoardMemberSelected = rs.getString("BOARD_MEMBER_ID");
              }
                 rs.close();
                
                 if (strManager != null && !strManager.equals("") && !strManager.equalsIgnoreCase("S")){%>
  	                  <script language="javascript">
	                  	document.frm.manager.value="<%=strManager%>";
	                  </script>
                 <% } 
                 else if (strManagerSelected == null || strManagerSelected.equals("")){%>
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
        	 	
        	 	    </td>
	                      <td class="label2"> <select name="hod" id="secondapprover" class="textBoxCss" onchange="skipDisabled(this.form,'second');">    
					<%
    						// MODIFICATION END
    					%>
												   <!--HOD COMBO--> 
					     <option value="S"><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel2",strsesLanguage)%></option>
						
						
										<%
										//change manoj
										//query commented by manoj chand on 03 June 2013
										//strSql = "Select dbo.user_name(dbo.finalooo(USERID,getdate(),'I')),USERID, dbo.user_name(USERID)AS HOD FROM M_USERINFO WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") or (APPROVER_LEVEL=3)) AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 3";
										//query added by manoj chand on 03 June 2013 to display other side user in approval level 2
										strSql="Select dbo.user_name(dbo.finalooo(USERID,getdate(),'I')),USERID, dbo.user_name(USERID)AS HOD FROM M_USERINFO WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") or (APPROVER_LEVEL=3)) AND STATUS_ID=10 AND APPLICATION_ID=1"+ 
										" UNION SELECT dbo.user_name(dbo.finalooo(UAM.USERID,getdate(),'I')),UAM.USERID,dbo.user_name(UAM.USERID)AS PM FROM USER_MULTIPLE_ACCESS UAM WHERE SITE_ID="+strSiteId+" AND APPROVAL_LVL2='Y' AND STATUS_ID=10 ORDER BY 3";
										//System.out.println("strSql --int--2->"+strSql);					
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
                 		</td>
	                  	<% if(strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>
	                  	<td>
	                  	
	                  	<select name="boardmember" id="thirdapprover" class="textBoxCss" onChange="skipDisabled(this.form,'third');">
							<option value="B"><%=dbLabelBean.getLabel("label.createrequest.selectboardmember",strsesLanguage)%></option> 
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
                  <%if(strBoardMember !=null && !strBoardMember.equals("") && !strBoardMember.equalsIgnoreCase("B")) {%>
	                  <script language="javascript">
	                    document.frm.boardmember.value="<%=strBoardMember%>";
	                  </script>
	                <%} 
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
              		</td> 
        		 <% } }else{ %>
	                      <td>&nbsp;</td>
	                      <%} %>    
	                    </tr>
	                 
	                    <tr>
	                      <td height="16" colspan="2" class="label6"><strong><%=dbLabelBean.getLabel("label.global.reasonforskipping",strsesLanguage)%> </strong></td>    
	                       
	                      <td class="label6" colspan="1"><strong><%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)%></strong> <span class=starcolour>*</span></td> 
	                       
	                       <% if(strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>
	                       <td class="label6"><a href="#" onclick="return defaultApproverList(this.form);"><%=dbLabelBean.getLabel("link.global.viewallapprovers",strsesLanguage)%></a></td>
	                       <%} %>
	                       
	                    </tr> 
	                    <tr>
	                      <td height="20" colspan="2" valign="top" class="label2" height="68">
						     <textarea name="reasonForSkip" cols="63" rows="4" class="textBoxCss" onkeyup="return test1('reasonForSkip', 200, 'all')"></textarea>	
						  </td>
	
						   <script language="javascript"> 
	                          document.frm.reasonForSkip.value="<%=strReasonForSkip%>";   
	                      </script> 
	                      
	                      <td colspan="2" class="label2" valign="top" align="left" height="68" ><textarea name="reasonForTravel" cols="63" rows="4"  class="textBoxCss"  onkeyup="return test1('reasonForTravel', 200, 'all')"></textarea>
	                      </td>
						    <script language="javascript">
	                       document.frm.reasonForTravel.value="<%=strReasonForTravel%>";
	                     </script>
	                      </tr>
	                  </table>
	                  </td> 
	                </tr>
	                
	              </table></td>
	  </tr>
	  <tr>
	    <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">  
	    </table>      </td>
	  </tr>
	  
	   <%	
	  	   	String sSqlStr = "";
	  	   	String strlinkshowflag = "";
	  	   	String strcolspan = "";

	  	   	sSqlStr = "SELECT  usa.USERID,   M_SITE.SITE_NAME, dbo.CONVERTDATE(usa.C_DATE) AS c_date "
	  	   			+ " FROM USER_SITE_ACCESS AS usa INNER JOIN "
	  	   			+ " M_SITE ON usa.SITE_ID = M_SITE.SITE_ID WHERE (usa.USERID in( select traveller_id from t_travel_detail_int where travel_id="
	  	   			+ strTravelId + " ))";

	  	   	//System.out.println("strlinkshowflag=======group========"+sSqlStr);  

	  	   	rs = dbConBean.executeQuery(sSqlStr);
	  	   	if (rs.next()) {
	  	   		strTravellerId = rs.getString(1);
	  	   		strlinkshowflag = "yes";
	  	   		//strcolspan = "1";
	  	   	strcolspan = "2";
	  	   	} else {
	  	   		//strcolspan = "2";
	  	   	strcolspan = "3";
	  	   		strlinkshowflag = "No";
	  	   	}
	  	   	rs.close();
	  	   %>
	  <tr>
	    <td bgcolor="#FFFFFF">
	    <table cellspacing="0" cellpadding="0" width="100%" border="0">
	      <tr>
	        <td class="formfirstfield" valign="bottom" align="left"   
	                		bgcolor="#FFFFFF" colspan="1" height="20"><%=dbLabelBean.getLabel("label.global.billinginstructions",strsesLanguage)%><span class="starcolour">*</span></td>
	            
	                  <td  class="label2"  valign="bottom" align="right"  
	               		  colspan="1" height="20">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	               		  
	               		   </td>   
	            
	      </tr>
	      
	 <!-- <tr> 
	        <td class="formtxt" align="left" bgcolor="#FFFFFF" colspan="2"   height="10"><strong>&nbsp; </strong></td>
	      </tr> -->       
	    </table></td>
	  </tr>
	  <tr> 
	    <td bgcolor="#FFFFFF"> 
	    <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#F0F0F0" style="border-collapse: collapse;"> 
	    
	    
	        
	      <tr>
	        <td width="50%" style="border-style: solid;border-color: #F0F0F0;">
	        <table width="100%" border="0" cellspacing="0" cellpadding="0">      
	          <tr>
	            <td class="label2" colspan="3" height="15">&nbsp;&nbsp;&nbsp;<strong><%=dbLabelBean.getLabel("label.global.chargeableto",strsesLanguage)%> </strong></td>
	            </tr>
	              <tr>
	              <td width="10%" align="center"><input name="billing" type="radio" value="<%=dbLabelBean.getLabel("label.global.smg",strsesLanguage)%>"     checked  onclick="billingOnClick(this.form)" /></td>
	              <td class="label2" align="left" width="22%"><%=dbLabelBean.getLabel("label.global.smg",strsesLanguage)%></td>
	                <td width="68%"> 
	              	     <select name="billingSMGSite" class="textBoxCss"  onchange="getSiteID(this.form)"  <%=strComboState%> >  
						
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
	                         </select>
	                 </td>
					             <script language="javascript">
									document.frm.billingSMGSite.value="<%=strBillingSite%>";
								 </script>		
	              </tr>
	              <tr>
	            <td class="label2" colspan="<%=strcolspan%>" >&nbsp;</td>    

				    <%
    				    	if (strlinkshowflag.equals("yes")) {
    				    %>  
	            <td class="label2"><a href="#"   onclick="window.open('M_Myaccessunit.jsp?userId=<%=strTravellerId%>','SEARCH','scrollbars=yes,resizable=yes,width=500,height=240')";><%=dbLabelBean.getLabel("link.global.showmyaccessibleunits",strsesLanguage)%></a></td>

			    <%
			    	}
			    %>  
	            
	          </tr>
	          
	            <tr>
	            <td class="label2" height="30" colspan="2" width="32%" align="left">&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.selectuserofbillingunitforapproval",strsesLanguage)%></td>
	            <td width="68%"> 
	              <span class="label2">  
	              <select name="billingSMGUser" class="textBoxCss"  <%=strComboState%> >      
							    <option  value="-1"'> <%=dbLabelBean.getLabel("label.createrequest.userfrombillingunit",strsesLanguage)%> </option> 
						 					<%
							
								//Added by vaibhav on 20 Aug 2010
								//change manoj
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
	          </tr>
	          
	          <tr>
	                <td width="10%" align="center"><input name="billing" type="radio" value="outSideSMG"      <%=ischecked%>  onclick="billingOnClick(this.form)"/></td>
	                <td class="label2" align="left" width="22%"><%=dbLabelBean.getLabel("label.global.nonsmg",strsesLanguage)%></td>
	                <td width="68%"><span class="label2">  
	                     <input name="billClient" type="text" class="textBoxCss"  onkeyup="return test1('billClient', 30, 'c')"  size="34"  value='<%=strBillingClientOurSide%>' /> <!--     -->
	                </span></td>
	              </tr>
	          <tr>
	          <td colspan="2">&nbsp;</td>
	          <td class="label2"><div align="left"><%=dbLabelBean.getLabel("label.global.ifnonsamvardhanagroupenterthenameofclient",strsesLanguage)%></div></td>
	          </tr>    
	          
	          </table>    
	          </td>
	          <td width="50%" valign="top" style="border-style: solid;border-color: #F0F0F0;">
	          <table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr>
	          <td colspan="3">&nbsp;</td>
	          </tr>
	          <tr>
	          					<td width="4%">&nbsp;</td>
	                  	 		 <td class="label2"><%=dbLabelBean.getLabel("label.global.kindlyputyourcurrencydenominationdetails",strsesLanguage)%></td> 
								 <td width="5%" class="label2">&nbsp;</td>  
	                      </tr>
	                      <tr> 
	                      		<td width="2%">&nbsp;</td>
	                    	     <td class="label2"><textarea name="expRemarks" cols="63" rows="4" class="textBoxCss"  onkeyup="return test1('expRemarks', 300, 'all')"><%=strCashBreakupRemarks%></textarea> 
	                    	  	 </td>         
	                    	  	 <td width="5%">&nbsp;</td>
	                      </tr>
	                       <tr>
	                       			<td width="2%">&nbsp;</td>
	                    	 		 <td class="label2"><%=dbLabelBean.getLabel("label.createrequest.currencycashtravelercheque",strsesLanguage)%> </td>
									 <td class="label2">&nbsp;</td>   
	                      </tr>
	          </table>
	          
	          
	          </td>
	          </tr>
	                                  
	          </table>
	          </td></tr>
	                
        
	          </table>
	      <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" style="border-style:solid;border-color:#F0F0F0;border-collapse: collapse; ">     
	      <!-- <tr>
	            <td class="label2" align="right">&nbsp;</td>  
	            <td>&nbsp;</td> 
	            <td class="label2"> <font color="red" > </font>
	            
	            </td>  
	                
	          </tr>   -->    

<% 
//added by manoj start on 20 may 2011
	        	//query to find if itenary details are not saved
	        	String strTravel_From = "";
 	            	String strTravel_to = "";
 	            	String strFieldStatus = "";
if(strUpFlag.equalsIgnoreCase("UpdateRecord")){
 	            	
				//int IntTravel_id=Integer.parseInt(strTravelId);
 	            	strSql = "select isnull(TRAVEL_FROM,'') as TRAVEL_FROM,isnull(TRAVEL_TO,'') as TRAVEL_TO  from T_journey_details_int where travel_id='"+strTravelId+"'";
				//System.out.println("strSql------>"+strSql);
 	            	rs = dbConBean.executeQuery(strSql);
//rs.close();
 	            	if (rs.next()) {

 	            		/*strTravel_From = rs.getString(1);
 	            		strTravel_to = rs.getString(2);*/
 	            		strTravel_From = rs.getString("TRAVEL_FROM");
 	            		strTravel_to = rs.getString("TRAVEL_TO");		
 	            	}

 	            	//added by manoj on 20 may 2011
 	            	rs.close();
 	            	
 	            	if (strTravel_From.equals("") || strTravel_to.equals("")) {
 	            		strFieldStatus = "blank";
 	            	} else {
 	            	%> 
 	     			<% strFieldStatus = "filled";
 	            	}
}
 	            	%>

				 <script language="javascript">
					 //document.frm.Remarks.value="<%=strRemarks%>";
				 </script>
				 
<%
//close here
		//dbConBean.close();
		if (strSHOW_BUD_INPUT.equalsIgnoreCase("Y")) {				
%>

		<tr>
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
		
			<td colspan="3" valign="top">
			<table width="100%" cellspacing="0" cellpadding="0"
				bgcolor="#FFFBFF" border="0">
				<tr>
					<td class="label1" colspan="4"><%=dbLabelBean.getLabel("label.global.budgetactualdetails",strsesLanguage)%><span class="starcolour">*</span></td>
					<td class="label2"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
				</tr>
				<tr>
					<td bgcolor="#FFFBFF" class="label2"><%=dbLabelBean.getLabel("label.global.ytmbudget",strsesLanguage)%></td>
					<td><input type="text" id="YtmBud" name="YtmBud" size="10"
						onchange="showDiff()"
						onkeyup="return test1('YtmBud', 15, 'n')"
						class="textBoxCss" maxlength="15"/>
						<script	language="javascript">
          		   document.frm.YtmBud.value="<%=dbl_YTM_BUDGET%>";
         		   </script>
         		 </td>
					<td bgcolor="#FFFBFF" class="label2"><%=dbLabelBean.getLabel("label.global.ytdactual",strsesLanguage)%></td>
					<td><input type="text" id="YtmAct" name="YtmAct" size="10"
						onchange="showDiff()"
						onkeyup="return test1('YtmAct', 15, 'n')"
						class="textBoxCss" maxlength="15"/>
						<script	language="javascript">
          		   document.frm.YtmAct.value="<%=dbl_YTD_ACTUAL%>";
         		 </script></td>
					<td rowspan="2" valign="top"><textarea id="budgetRemarks"
						name="budgetRemarks" cols="58" rows="3"
						class="textBoxCss"
						onkeyup="return test1('budgetRemarks', 100, 'all')"><%=str_EXP_REMARKS.trim()%></textarea>
					</td>
				</tr>
				<tr>
					<td bgcolor="#FFFBFF" class="label2" nowrap="nowrap"><%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage)%></td>
					<td><input type="text"  name="AvailBud" size="10"
						onkeyup=""
						class="textBoxCss" maxlength="15" readonly="readonly"/><script
						language="javascript">
          		   document.frm.AvailBud.value="<%=dbl_AVAIL_BUDGET%>";
         		 </script></td>
					<td bgcolor="#FFFBFF" class="label2" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.estimatedexpenditure",strsesLanguage)%></td>
					<td><input type="text" id="EstExp" name="EstExp" size="10"
						onkeyup="return test1('EstExp', 15, 'n')"
						class="textBoxCss" maxlength="15"/><script
						language="javascript">
          		   document.frm.EstExp.value="<%=dbl_EST_EXP%>";
         		 </script></td>
				</tr>
				
				
				
				<tr>
				<td colspan="5">&nbsp;</td>
				</tr>
				
			</table>
			</td>
		</tr>

<%} 
		
%>
<tr>
<td colspan="3" valign="top">
<table width="100%" cellspacing="0" cellpadding="0"	bgcolor="#FFFBFF" border="0">
<tr>
<%

	                       	if (strforPriceDesicion.equalsIgnoreCase("y"))
	                       	{
	                       %>
	                      
	                       <!-- add buy ticket from non-mata source on 23 Oct 2011 by manoj chand -->
	                       <td width="50%"></td>
	                       <td  height="30" width="50%" align="left" bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.proposetobuyticketsfromnonmatasource",strsesLanguage)%> &nbsp;&nbsp;&nbsp;<input type="radio" name="tkflyes" onclick="showdiv('y')" checked="checked" value="y" > <%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%> <input type="radio" name="tkflyes" onclick="showdiv('n')" value="n"> <%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
	                       <br><i><%=dbLabelBean.getLabel("label.global.nonmatasource",strsesLanguage)%></i>
	                         </td>
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
	                      	 %>
	                    </tr> 
				
				
				
	          
	          <%
	          	if (strforPriceDesicion.equalsIgnoreCase("y")) {
						     %>
						     <tr>
						     <td width="50%" ></td>
						     <td width="50%" align="left">
							       <div align="center" id="showdiv" style="<%=strText%>">
							       <table width="90%" border="0" cellpadding="0" cellspacing="0" >  
								<tr>
									<td bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.airline",strsesLanguage)%></td>  
									<td bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%></td>
									<td bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.localprice",strsesLanguage)%></td>
									<td bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>  
								</tr>
								<tr>  
									<td bgcolor="#FFFFFF" valign="top"><input type="text" name="airline" size="8"  class="textBoxCss" maxlength="30" onkeyup="return test1('airline', 50, 'cn')" />
									 <script language="javascript">
	                         		   document.frm.airline.value="<%=strAirLineName.trim()%>";
	                        		 </script>
									
									 </td>
									<td bgcolor="#FFFFFF" valign="top">
									<select name="currency" class="textBoxCss"><%=dbLabelBean.getLabel("label.global.expenditurecurrency",strsesLanguage)%>
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
	                         	
									</td>
									<td bgcolor="#FFFFFF" valign="top"> 
									<input type="text" name="localprice" size="8" class="textBoxCss2" onkeyup="return test1('localprice', 10, 'n')"   />
									
									 <script language="javascript">
	                         		   document.frm.localprice.value="<%=strAmount.trim()%>";
	                        		 </script>
									
									
									</td>
									<td bgcolor="#FFFFFF" valign="top">    
									<textarea name="pricingRemarks" cols="26" rows="3" class="textBoxCss" 
									onkeyup="return test1('pricingRemarks', 100, 'all')"  ><%=strTkRemarks.trim()%></textarea> 
									</td>
								</tr>
								</table>
						      </div>
						      
						      </td>
						      </tr>
						      </table></td></tr>
						      
						      
						  <%
						  	}
	          dbConBean.close();
						  %>







</table>




<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td class="label2"><a href="#"
						onclick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=I&whichPage=Group_itinerary_details.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')"
						title="Add Attachments"><img
						src="images/AttachFile.gif?buildstamp=2_0_0" width="94" height="24"
						border="0" /></a> <!-- <input type="submit" name="Submit" value="Attach File"  class="formButton" /> -->
					</td>
					<td colspan="2">
					<div align="right"><input type="submit"
						name="Submit2" style="height: 22px;width:46px;" value="<%=dbLabelBean.getLabel("button.global.back",strsesLanguage)%>" class="formButton"
						onclick="return BackPage(this.form);" /> <input
						type="submit" style="height: 22px;width:auto;" name="saveandexit" value="<%=dbLabelBean.getLabel("button.global.saveandexit",strsesLanguage)%>"
						class="formButton"
						onclick="return checkData(this.form,'saveandexit','<%=strFieldcheck%>');" />
					<input type="submit" style="height: 22px;width:50px;" name="save" value="<%=dbLabelBean.getLabel("button.global.save",strsesLanguage)%>"
						class="formButton"
						onclick="return checkData(this.form,'save','<%=strFieldcheck%>');" />
					<input type="submit" style="height: 22px;width:144px;" name="saveProceed"
						value="<%=dbLabelBean.getLabel("button.global.submittoworkflow",strsesLanguage)%>" class="formButton"
						onclick="return checkData(this.form,'saveProceed','<%=strFieldcheck%>');" />
						<input type="hidden" name="matapricecomp" value="<%=strforPriceDesicion%>" />
					</div>
					</td>
				</tr>


												</table></td>
	      </tr>
	    </table></td>
			<td width="11" background="images/index_03.png?buildstamp=2_0_0"><img src="images/index_03.png?buildstamp=2_0_0" alt="" width="14" height="426" /></td>
	  </tr> 
	  <tr>
	    <td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
	    <td height="20" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
	    <td width="11" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
	  </tr>
	</table>
	
		<input type="hidden" name="fieldstatus" value="<%=strFieldStatus.trim()%>" />    
	<script language="JavaScript">
	
	if(document.frm.fieldstatus.value=='blank'){
		document.frm.saveProceed.disabled=true;        
	  alert('<%=dbLabelBean.getLabel("message.createrequest.infonotsave",strsesLanguage) %>');      
	}else{ 
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
	<br />
	  <input type="hidden" name="todayDate" value="<%=strCurrentDate%>"/>
	   <input type="hidden" name="travelReqId" value="<%=strTravelReqId%>"/>
	   <input type="hidden" name="travelId" value="<%=strTravelId%>"/> <!--  HIDDEN FIELD  -->
	    <input type="hidden" name="travelReqNo" value="<%=strTravelReqNo%>"/> 
		<input type="hidden" name="refreshFlag" value=""/> 
		<input type="hidden" name="flag"/> 
		<input type="hidden" name="whatAction"/>
		<input type="hidden" name="hidsiteid" value="<%=strSiteId %>" />
		<input type="hidden" name="site" value="<%=strSiteId %>" />
		<input type="hidden" name="hidGrAppLvl3flg" value="<%=strAppLvl3flg %>" />
		<input type="hidden" name="hidAppLvl3showbmflg" value="<%=strAppLvl3flgforBM%>" />
		<input type="hidden" name="hiddeptDate" value="<%=strDeptDate%>"></input>
	              </td>
	          </tr>
	        </table>
	</form>
	</body>
	</html>
