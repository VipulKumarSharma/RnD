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
		
		Modified By       : Manoj Chand
		Modification      : Add check for Currency Exchange Rate 
		Modification Date : 07 feb 2011
		
		Modified By       : Manoj Chand
		Modification      : Add check for no. of total tour days can not be more than journey days. 
		Modification Date : 07 march 2011
		
		Modified By       : Manoj Chand 
		Modification Date : 07 Sept 2011
		
		Modified By			: Manoj Chand
		Date of Modification	: 23 Sept 2011
		Modification			; Hide the self billing radio button
		
		Modification			:modify workflow as per selected site
		Date of modification  :12 Oct 2011
		Modified By     		:Manoj Chand
		 
		Modification			:change caption for checking pricing through alternate source
		Date of modification    :18 Oct 2011
		Modified By     		:Manoj Chand
		
		Modification			:Resolved desiging related issues between budged details and buying tickets from no-mata soruce.
		Date of modification    :24 Nov 2011
		Modified By     		:Manoj Chand
		
		Modification			:screen design going distract for the site to which Ticket Price from Alternate Source is enable.
		Date of Modification	:11 jan 2012
		Modified By				:Manoj Chand
		
		Modification			:set default value of local price to blank, not zero
		Date of Modification	:21 Feb 2012
		Modified By				:Manoj Chand
		
		Modification			:Resolve safari browser issue as request was not submit to workflow
		Date of Modification	:20 Mar 2012
		Modified By				:Manoj Chand
		
		*Modification				:Multilingual functionality added
		*Modified by				:Manoj Chand
		*Date of Modification		:24 May 2012
		
		*Modified By					:Manoj Chand
		*Date of Modification			:03 July 2011
		*Modification					:change query to remove closed unit from unit dropdown
		
		*Modification				:Travel fare currency and fare amount controls added for smp division
		 *Modified by				:Manoj Chand
		 *Date of Modification		:29 Nov 2012
		 
		 *Modified By	        :MANOJ CHAND
		 *Date of Modification   :07 Feb 2013
		 *Description			:IE Compatibility Issue resolved.
		 
		 *Modified By	        :MANOJ CHAND
		 *Date of Modification  :17 Apr 2013
		 *Description			:add status_id=10 condition existing query 
		 
		 *Modified By	        :MANOJ CHAND
		 *Date of Modification  :29 Apr 2013
		 *Description			:showing Pending tes request submission in easy count alert while submitting request in workflow.
		 
		 *Modified By			:Manoj Chand
		 *Date of Modification	:22 Oct 2013
		 *Modification			:javascript validation to stop from typing --,'  symbol is added.
		 *******************************************************/
	%>
	
	<html>
	<%@ page import="java.sql.*"  pageEncoding="UTF-8" %>
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
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
	<script language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
	<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	
	<script type="text/javascript">
	//$.noConflict();
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
		 fun_calculate_GrandTotalUSD();
		 //startBlink(); 
		 var chm=document.forms[0].checkMsg.value;
		 //alert("hello "+chm);
		 if (chm=="ExpenceCheck")
		  {
			  alert('<%=dbLabelBean.getLabel("alert.createrequest.couldnotsubmittoworkflow",strsesLanguage)%>');
		  }
	 }

	//code added by manoj chand on 14 dec 2012 to blink the add multiple currency message.
	/* function doBlink() {
			var blink = document.all.tags("BLINK");
			for (var i=0; i<blink.length; i++)
				blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : ""; 
		}

		function startBlink() {
			if (document.all)
				setInterval("doBlink()",800);
		}*/
	 
	 </script>
	 <body onload="checkMsg();">

	<%
	request.setCharacterEncoding("UTF-8");
	 		//Global Variables declared and initialized

	 		String strSql = null; // String for Sql String
	 		ResultSet rs, rs1, rs2,rs3 = null; // Object for ResultSet
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
	 		String strAppLvl3flg = "";
	 		
	 		 /* String strtempexperday=request.getParameter("entitlement")==null?"0":request.getParameter("entitlement");
	 		  String strtemptourday=request.getParameter("tourDays")==null?"0":request.getParameter("tourDays");
	 		
	 		 System.out.println("strtempexperday---->"+strtempexperday);
	 		 System.out.println("strtemptourday---->"+strtemptourday);*/
	 		  
	 		strBillingSiteNew = request.getParameter("billingSMGSite") == null
	 				? "-2"
	 				: request.getParameter("billingSMGSite");

	 		strInterimId = request.getParameter("interimId") == null
	 				? ""
	 				: request.getParameter("interimId");

	 		strTravelReqId = request.getParameter("travelReqId"); // for hidden field
	 		strTravelId = request.getParameter("travelId"); // for hidden field
	 		strTravelReqNo = request.getParameter("travelReqNo"); // for hidden field
	 		//modified by manoj
	 		strTravllerSiteId = request.getParameter("travellerSiteId")==null?strSiteIdSS:request.getParameter("travellerSiteId"); // for hidden field
	 		strTravellerId = request.getParameter("travellerId"); // for hidden field
	 		strMessage = request.getParameter("message");
	 		if (strMessage != null && strMessage.equals("save")) {
	 			strMessage = dbLabelBean.getLabel("message.global.savedsuccessfully",strsesLanguage);
	 		} else if (strMessage != null && strMessage.equals("notSave")) {
	 			strMessage = dbLabelBean.getLabel("message.global.couldnotsave",strsesLanguage);
	 		}

	 		else {
	 			strMessage = "";
	 		}
	 		// Code added by Sanjeet Kumar on 20-july-2007 for giving a proper information incase site not uploaded
	 		//SpolicyPath variable used on 07 jan 2013 for getting company policy path
	 		//String Path = application.getInitParameter("companyPolicyPath");
	 		File UploadFile = new File(SpolicyPath + "/" + strSiteFullName + "/"
	 				+ strSiteFullName + ".html");
	 		
	 		
	 		
	 		
	 		String strforPriceDesicion = "";
           	String strSHOW_BUD_INPUT = "";
           	//change manoj
           	strSql = "Select isnull(INT_LOCAL_AGENT,'') as INT_LOCAL_AGENT , SHOW_BUD_INPUT  From m_site where site_id="
           			+ strTravllerSiteId + " and status_id=10 ";
           	rs = dbConBean.executeQuery(strSql);

           	while (rs.next()) {
           		strforPriceDesicion = rs.getString("INT_LOCAL_AGENT");
           		strSHOW_BUD_INPUT = rs.getString("SHOW_BUD_INPUT");

           	}
           	rs.close();
           	//added by manoj chand on 16 oct 2012 to get site base currency
           	String strBaseCur="INR";
           	strSql = "SELECT ISNULL(CURRENCY,'') AS BASE_CUR FROM dbo.M_SITE ms WHERE ms.STATUS_ID=10 AND ms.SITE_ID="+strTravllerSiteId;
           	//System.out.println("strSql--basecur-->"+strSql);
           	rs = dbConBean.executeQuery(strSql);
           	if(rs.next()) {
           		strBaseCur = rs.getString("BASE_CUR");
           	}
           	rs.close();
           	
           	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
    		String formattedDate = df.format(new Date());
    		
    		//query added by manoj chand on 26 nov 2012 to get difference in return date and forward date of journey
    		int intDays=0;
    		strSql = "SELECT CASE WHEN TRJDI.TRAVEL_DATE IS NULL OR YEAR(TRJDI.TRAVEL_DATE)=1900"+
    			     " THEN 0 ELSE DATEDIFF(DAY,TDI.TRAVEL_DATE,TRJDI.TRAVEL_DATE)+1"+
				     " END RETURN_FLAG  FROM T_TRAVEL_DETAIL_INT TDI"+
				     " LEFT JOIN  T_RET_JOURNEY_DETAILS_INT TRJDI ON TRJDI.TRAVEL_ID = TDI.TRAVEL_ID"+
				     " WHERE TDI.TRAVEL_ID='"+strTravelId+"' AND TDI.STATUS_ID=10";
           	rs = dbConBean.executeQuery(strSql);
           	if(rs.next()) {
           		intDays = rs.getInt("RETURN_FLAG");
           	}
           	rs.close();
    		
           	//code added by manoj chand on 26 nov to check whether traveller belongs to smp division or not
           	rs=null;
           	strSql="SELECT SHOW_APP_LVL_3 FROM M_DIVISION MD INNER JOIN	M_USERINFO MU ON MU.DIV_ID=MD.DIV_ID WHERE USERID="+strTravellerId;
			rs       =   dbConBean.executeQuery(strSql);  
			if(rs.next())
			{
				strAppLvl3flg=rs.getString("SHOW_APP_LVL_3");
			}
			rs.close();
           	
	 	%>
	
	<script language="javascript">
//change by manoj chand on 20 march 2012 to resolve safari issue request not submitted.	
function checkCurrPreference(){
			var curPref=document.forms[0].expCurrency.value;
			var urlParams = "strFlag=CheckCurrencyId&currency="+curPref;
			jQuery.ajax({
	            type: "post",
	            url: "AjaxMaster.jsp",
	            data: urlParams,
	            async:false,
	            success: function(result){
	            var res = result.trim();
	            if(res == 'N'){
		             alert('<%=dbLabelBean.getLabel("label.global.exchangeratefor",strsesLanguage)%>' +curPref.trim()+ '<%=dbLabelBean.getLabel("label.createrequest.isnotdefinedcontactstarsadmin",strsesLanguage)%>');
		             return false;
	             }else{
	            	
	            		var a = checkData(this.form,'saveProceed');
	            		if(a == false)
	            			return false;
		             }
	            },
				error: function(){
					alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
	            }
	          });
	}

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
};

//function added by manoj chand on 26 apr 2013
function checkTESRequestCount(){
	var var_travellerid = '<%=strTravellerId%>';
	var var_siteid = '<%=strTravllerSiteId%>';
	var flag;
	var url = 'strFlag=checkTESRequestCount&travellerId='+var_travellerid+'&siteId='+var_siteid;
	$.ajax({
        type: "post",
        url: "AjaxMaster.jsp",
        data: url,
        async:false,
        success: function(result){
        var res = result.trim();
        var narr=res.split("#");
        //alert(narr[0]+' - '+narr[1]+' - '+narr[2] );
        var diff = narr[2]-narr[1];
        if(narr[0] == 'Y') {
        	if(narr[1] < narr[2]) {
          	  	 alert('<%=dbLabelBean.getLabel("alert.createrequest.pleasesubmityourlast",strsesLanguage)%> '+narr[1]+' <%=dbLabelBean.getLabel("alert.createrequest.pendingtravelexpensestmt",strsesLanguage)%> '+diff+' <%=dbLabelBean.getLabel("alert.createrequest.moretravelrequest",strsesLanguage)%>');
          	  	 flag=true;
	       	 } else {
	       		 flag=true;
	       	 }
         } else if(narr[0] == 'N') {
         	if(narr[1] == narr[2] && narr[2] != 0) {
         		alert('<%=dbLabelBean.getLabel("alert.createrequest.pleasesubmityourlast",strsesLanguage)%> '+narr[1]+' <%=dbLabelBean.getLabel("alert.createrequest.pendingtravelexpenses",strsesLanguage)%>');
         	  	flag=false;
	       	 } else {
	       		 flag=true;
	       	 }
         } else if(narr[0] == 'A') {
             flag=true;
         } else {
        	 flag=true;
          }
         },
		error: function(){
			alert('Error...');
        }
      });
    return flag;
}


function checkDateDiff(obj){
	
	var reqNum = '<%=strTravelId%>';
	var objval= obj.value;
	var url = 'strFlag1=CheckNumOfDaysDiff&reqId='+reqNum+'&hoteldays='+objval;
	$.ajax({
        type: "post",
        url: "AjaxMaster.jsp",
        data: url,
        success: function(result){
        var res = result.trim();
        if(res == 'false'){
        		alert('<%=dbLabelBean.getLabel("alert.global.numberoftourdayscannotbemorethanjourneydays",strsesLanguage)%>');
        		obj.value='';
        		obj.focus();
             	return false;
         }
        },
		error: function(){
			alert('<%=dbLabelBean.getLabel("alert.createrequest.errorincalculatingdays",strsesLanguage)%>');
        }
      });
}
//added by manoj chand on 11 oct 2012 to check for duplicate currency.
function fun_check_duplicate_currency(checkbox_obj,sno_num){
	cur_val=$(checkbox_obj).val();
	var var_flag=true;
	$('table.mytable tbody > tr').each(function() {
		var hd_val=$(this).find('#hd').val();
		var sno_val=$(this).find('.spn').text();
		if(hd_val=='v'){
		var a=$(this).find('#expCurrency').val();
		if(cur_val!='-1' && cur_val==a && sno_val!=sno_num){
			var msg='<%=dbLabelBean.getLabel("alert.createrequest.isalreadyused.",strsesLanguage)%>';
			alert(cur_val+' '+msg);
			$(checkbox_obj).val('-1');
			var_flag=false;
			return false;
		}
		}
	});
	return var_flag;
}

//function added by manoj chand on 08 oct 2012 to get exchange rate based on currency
function fun_exchangerate(x){
	var master = $(x).parents("table.mytable tr");
	var sno_val=master.find('.spn').text();
	var res_cur=fun_check_duplicate_currency(x,sno_val);
	if(res_cur==false){
		return false;
	}
				var curPref = x.value;
				if(curPref!='-1'){
				var urlParams = "strFlag=curexchangerate&currency="+curPref+"&seldate=<%=formattedDate%>";
				jQuery.ajax({
		            type: "post",
		            url: "AjaxMaster.jsp",
		            data: urlParams,
		            async:false,
		            success: function(result){
		            var res = result.trim();
		            if(res != ''){
			            if(res=='0.000000'){
				            res='';
				            alert('<%=dbLabelBean.getLabel("label.global.exchangeratefor",strsesLanguage)%> '+curPref.trim()+' <%=dbLabelBean.getLabel("label.createrequest.isnotdefinedcontactstarsadmin",strsesLanguage)%>');
			            }
		            	master.find('#exrate').val(res);
		            	var x=master.find('#totalforex').val();
		            	fun_calculate_TotalinBaseCurrency(master.find('#totalinr'),x,curPref,'<%=strBaseCur%>','<%=formattedDate%>');	
		            	var total=fun_calculate_GrandTotal();
		            	$('#grandTotalForexinr').val(total);
		            	fun_calculate_GrandTotalUSD();	            				             
		             }else{
		            	 alert('<%=dbLabelBean.getLabel("label.global.exchangeratefor",strsesLanguage)%> '+curPref.trim()+' <%=dbLabelBean.getLabel("label.createrequest.isnotdefinedcontactstarsadmin",strsesLanguage)%>');
			             }
		            },
					error: function(){
						alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
		            }
		          });
	}else{
		master.find('#exrate').val('0.000000');
		master.find('#totalinr').val('0.00');
		var total=fun_calculate_GrandTotal();
    	$('#grandTotalForexinr').val(total);
    	fun_calculate_GrandTotalUSD();	 	
	}
}

function fun_calculate_GrandTotal(){
	var sum=0;
	$('table.mytable tbody > tr').each(function() {
		var a=$(this).find('#totalinr').val();
		if(a!=undefined && a!=''){
		sum=parseFloat(sum)+parseFloat(a);
		}	
	});
	return sum.toFixed(2);
}
//added by manoj chand on 22 november 2012 to calculate hotel charges tour days
function fun_calculate_HotelTourDays(){
	var sum=0;
	$('table.mytable tbody > tr').each(function() {
		var hd_val=$(this).find('#hd').val();
		if(hd_val=='v'){
		var b=$(this).find('#entitlement2').val();	
		var a=$(this).find('#tourDays2').val();
		if(b!=undefined && b>0){
			if(a!=undefined && a!=''){
			sum=parseFloat(sum)+parseFloat(a);
			}
		}	
		}
	});
	return sum;
}
//added by manoj chand on 22 november 2012 to calculate daily allowances tour days
function fun_calculate_DailyTourDays(){
	var sum=0;
	$('table.mytable tbody > tr').each(function() {
		var hd_val=$(this).find('#hd').val();
		if(hd_val=='v'){
		var b=$(this).find('#entitlement1').val();
		var a=$(this).find('#tourDays1').val();
		if(b!=undefined && b>0){
			if(a!=undefined && a!=''){
			sum=parseFloat(sum)+parseFloat(a);
			}
		}	
		}
	});
	return sum;
}

function fun_calculate_GrandTotalUSD(){

	var hoteltd=fun_calculate_HotelTourDays();
	var dailytd=fun_calculate_DailyTourDays();
	var tourdays='<%=intDays%>';
	var grandtotal=$('#grandTotalForexinr').val();
	if(grandtotal==''){
		grandtotal='0.00';
		$('#grandTotalForexinr').val('0.00');
	}
	var urlParams = "strFlag=GrandTotalinUSD&totalexp="+grandtotal+"&basecur=<%=strBaseCur%>&seldate=<%=formattedDate%>";
	jQuery.ajax({
           type: "post",
           url: "AjaxMaster.jsp",
           data: urlParams,
           async:false,
           success: function(result){
           var res = result.trim();
           if(res != ''){
             if(tourdays!=0){
            	   $('#grandtotalforexusd').val((res/tourdays).toFixed(2));
               }
             else if(hoteltd!=undefined && hoteltd!=0){
				$('#grandtotalforexusd').val((res/hoteltd).toFixed(2));
			}else if(dailytd!=undefined && dailytd!=0){
           		$('#grandtotalforexusd').val((res/dailytd).toFixed(2));
			}else{
				$('#grandtotalforexusd').val(res);
			}

				            				             
            }
           },
		error: function(){
			alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
           }
         });
}

//add new row on add button click
	$(document).ready(function() {
		// Add button functionality
		$("table.mytable #btnadd").live("click",function() {
			var master = $(this).parents("table.mytable");
			//to set sno.
			var id = 1;
			 $('table.mytable tbody > tr').each(function() {
						  var a=$(this).find('#hd').val();
						  if(a=='v'){
							  id++;
						  }
					  });
			//end here
			var ptr = $(this).parents("table.mytable tr");
			ptr.find("#btnadd").hide();
			ptr.find("#removebtn").show();
			// Get a new row based on the prototype row
			var prot = master.find(".prototype").clone();
			prot.find("#hd").val('v');
			prot.attr("class", ""); 
			prot.find(".spn").text(id);
			$('.inner').before(prot);
		});
		
		// Remove button functionality
		$("table.mytable #removebtn").live("click", function() {
			$(this).parents("table.mytable tr").remove();
			var id = 1;
			 $('table.mytable tbody > tr').each(function() {
						  var a=$(this).find('#hd').val();
						  if(a=='v'){
							  $(this).find('.spn').text(id);
							  id++;
							  var total=fun_calculate_GrandTotal();
						      $('#grandTotalForexinr').val(total);
						      fun_calculate_GrandTotalUSD();
						  }
					  });
			});
	});

	function showaddbutton(count){
		var x="table.mytable #rowid"+count;
		var rowobj=$(x);
		rowobj.find("#btnadd").show();
		rowobj.find("#removebtn").hide();
	}
	
	function checkValue(){
		var child = $('table.mytable tbody > tr').length;
		var flag=true;
		var count=0;
	    $('table.mytable tbody > tr').each(function() {
	       var hd_val=$(this).find('#hd').val();
		   if(hd_val=='v'){
		        var cur=$(this).find("#expCurrency");
			    var a=$(this).find("#entitlement1");
				var b=$(this).find('#tourDays1');
				var c=$(this).find('#entitlement2');
				var d=$(this).find('#tourDays2');
				var e=$(this).find('#contingencies1');
				var f=$(this).find('#contingencies2');
				var g=$(this).find('#totalforex');
				var x=$(this).find('#exrate');
				var y=$(this).find('#totalinr');
				var cont1=jQuery.trim(e.val());
				var cont2=jQuery.trim(f.val());
				if(cont1=='0.00'){
					cont1='0';
				}
				if(cont2=='0.00'){
					cont2='0';
				}

				if(cur.val()!=undefined && cur.val()=='-1'){
					alert('<%=dbLabelBean.getLabel("alert.global.currency",strsesLanguage)%>');
					cur.focus();
					flag=false;
					return false;
				}
				if(a.val()!= undefined && jQuery.trim(a.val())==''){
					alert('<%=dbLabelBean.getLabel("alert.global.enter0ifnotrequiredinexpenditureperday",strsesLanguage)%>');
					a.focus();
					flag=false; 
					return false;
				}
				if(b.val()!= undefined && jQuery.trim(b.val())==''){
					alert('<%=dbLabelBean.getLabel("alert.global.enter0ifnotrequiredintotaltourdays",strsesLanguage)%>');
					b.focus();
					flag=false;
					return false;
				}
				if(c.val()!= undefined && jQuery.trim(c.val())==''){
					alert('<%=dbLabelBean.getLabel("alert.global.enter0ifnotrequiredinexpenditureperday",strsesLanguage)%>');
					c.focus();
					flag=false;
					return false;
				}
				if(d.val()!= undefined && jQuery.trim(d.val())==''){
					alert('<%=dbLabelBean.getLabel("alert.global.enter0ifnotrequiredintotaltourdays",strsesLanguage)%>');
					d.focus();
					flag=false;
					return false;
				}
				if(e.val()!= undefined && cont1!='' && cont1!='0' && document.frm.expRemarks.value==''){
					alert('<%=dbLabelBean.getLabel("alert.global.remarksforcontingenciesorotherexpenditure",strsesLanguage)%>');
					document.frm.expRemarks.focus();
					flag=false;
					return false;
				}
				if(f.val()!= undefined && cont2!='' && cont2!='0' && document.frm.expRemarks.value==''){
					alert('<%=dbLabelBean.getLabel("alert.global.remarksforcontingenciesorotherexpenditure",strsesLanguage)%>');
					document.frm.expRemarks.focus();
					flag=false;
					return false;
				}
				if(x.val()!=undefined && jQuery.trim(x.val())==''){
					alert('<%=dbLabelBean.getLabel("alert.createrequest.exchangeratecannotbeblank",strsesLanguage)%>');
					flag=false;
					return false;
				}
	    }
				count++;
			});
		return flag;
	}


	
	function checkData(f1,actionFlag) 
		{
		f1= document.forms[0];
		
		//debugger;
		if(!f1.billing[2].checked){  
			
		//if (document.frm.billingSMGSite.value!='<%=strSiteIdSS%>')
		     var tt = document.frm.BillingSiteFlag.value;
		 
		    //change manoj
		    if(document.frm.billingSMGSite.value!='<%=strTravllerSiteId%>' && tt!='1' )
	         {
		    	
			     if(document.frm.billingSMGUser.value=="-1")
				  {
					//alert("hi  "+document.frm.billingSMGUser.value);
					alert('<%=dbLabelBean.getLabel("alert.global.approverfrombillingunit",strsesLanguage)%>' );
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
				alert('<%=dbLabelBean.getLabel("alert.global.detailsofclient",strsesLanguage)%>');
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
	//added by manoj chand on 09 oct 2012 to check form values
	var fun_flag=checkValue();
	if(fun_flag==false){
		return false;
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
	
	/*	if ((f1.contingencies[0].value != '0' && f1.contingencies[0].value != "" )  || (f1.contingencies[1].value != '0' && f1.contingencies[1].value != "")){
			if (f1.expRemarks.value == "") {
				alert('Please Specify the reason for Contingencies/Any Other Expenditure');
				f1.expRemarks.focus();
				return false;
			}
		}*/
	
   //alert(document.frm.matapricecomp.value);
   
   if(document.frm.matapricecomp.value=='y'){
	   if(f1.tkflyes[0].checked){ 
	     //alert("YES");
	   }
	  
	    if(f1.tkflyes[1].checked) 
	    {
	   	if(f1.airline.value==""){
	   		alert('<%=dbLabelBean.getLabel("alert.global.airline",strsesLanguage)%>');
	   		f1.airline.focus();
	   		return false;
	   	}
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
	  //zeroChecking(f1.travelCheque); 
		/*if(f1.travelCheque.value=="") 
		{
			 alert("Please fill the value of Traveler's Cheque");
			f1.travelCheque.focus();
			return false; 
		}
		*/
		
		if(actionFlag == "saveProceed")
		{
		  var var_res = checkTESRequestCount();
		  if(var_res==false)
			  return false;
			
		  var text=document.frm.approverlist.value;
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
				alert('<%=dbLabelBean.getLabel("alert.global.enterremarksfornotenteringbudgetactualdetails",strsesLanguage)%>');
				
				if(YtmBud == ''){
					document.getElementById('YtmBud').focus();
				}else if(YtmAct == ''){
					document.getElementById('YtmAct').focus();
				}else if(EstExp == ''){
					document.getElementById('EstExp').focus();
				}
				//document.getElementById('expRemarks1').focus();	//added by manoj
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

	
			
			
			if(confirm(text+'<%=dbLabelBean.getLabel("alert.global.submittoworkflow",strsesLanguage)%>'))  {
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
		var total=fun_calculate_GrandTotal();
    	$('#grandTotalForexinr').val(total);
    	fun_calculate_GrandTotalUSD();
	}

	//function created by manoj chand on 12 oct 2012 to calculate total of expenditure.
	function calculate(obj){
		var master = $(obj).parents("table.mytable tr");
		var cur=master.find('#expCurrency').val();
		var a=master.find('#entitlement1').val();
		var b=master.find('#tourDays1').val();
		var c=master.find('#entitlement2').val();
		var d=master.find('#tourDays2').val();
		var e=master.find('#contingencies1').val();
		var f=master.find('#contingencies2').val();
		var g=master.find('#totalforex');
		var x=master.find('#exrate').val();
		var y=master.find('#totalinr');
		if(a=='')
			a=0;
		if(b=='')
			b=0;
		if(c=='')
			c=0;
		if(d=='')
			d=0;
		if(e=='')
			e=0;
		if(f=='')
			f=0;
		if(g=='')
			g=0;
		if(x=='')
			x=0;
		if(y=='')
			y=0;

		var totalforexval=fun_multiply(a,b)+fun_multiply(c,d)+parseFloat(e)+parseFloat(f);
		g.val(totalforexval.toFixed(2));
		if(cur!=null && cur!=undefined && cur!='-1'){
		fun_calculate_TotalinBaseCurrency(y,totalforexval,cur,'<%=strBaseCur%>','<%=formattedDate%>');
		}
	}
	
	function fun_multiply(a,b){
		return parseFloat(a)*parseFloat(b);
	}

	//FUNCTION CREATED BY MANOJ CHAND ON 16 OCT 2012 TO CALCUATE INDIVIDUAL TOTAL IN BASE CURRENCY.
	function fun_calculate_TotalinBaseCurrency(obj,totalforex,cur_val,basecur_val,date_val){
		
		var urlParams = "strFlag=TotalinBaseCur&totalexp="+totalforex+"&selcurrency="+cur_val+"&basecur="+basecur_val+"&seldate="+date_val;
		jQuery.ajax({
	            type: "post",
	            url: "AjaxMaster.jsp",
	            data: urlParams,
	            async:false,
	            success: function(result){
	            var res = result.trim();
	            if(res != ''){
	            	obj.val(res);	            				             
	             }
	            },
				error: function(){
					alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
	            }
	          });
	}
	
	function test1(obj, length, str)
	{
		if(str=='n.'){
			upToTwoDecimal(obj);
			}
		if(obj.name == 'expRemarks' || obj.name == 'cashBreakupRemarks' || obj.name == 'budgetRemarks' || obj.name == 'pricingRemarks'){
			upToTwoHyphen(obj);
		}
		charactercheck(obj,str);
		limitlength(obj, length);
		spaceChecking(obj);//added on for checking  starting Spaces on 05-Jul-07
		calculate(obj);
		var total=fun_calculate_GrandTotal();
    	$('#grandTotalForexinr').val(total);
    	fun_calculate_GrandTotalUSD();
	}

	//added by manoj on 06 sept refresh page on close button from attachment page.
	function childwindowSubmit(){
		//document.frm.action='T_IntForex_Details.jsp';
		//document.frm.submit();
	}
	</script>
	<style type="text/css">
	.mytable .prototype {
				display:none;
			}
	</style>
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
							+ " "+dbLabelBean.getLabel("alert.createrequest.hasdelegatedhisauthorityto",strsesLanguage)+" " 
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
		//String strTotalExpinUSD="";
		String strTotalFareAmt="0";
		String strTotalFareCur="";

		// set the billing site  as originator site
		//change manoj
		strBillingSite = strTravllerSiteId;

		//Get the Data from this travel id
		strSql = "SELECT BILLING_SITE,BILLING_CLIENT,RTRIM(LTRIM(convert(decimal(20,2),TOTAL_AMOUNT))) AS TOTAL_AMOUNT, RTRIM(LTRIM(TA_CURRENCY)) AS TA_CURRENCY, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE))) AS TRAVELLER_CHEQUE, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE1))) AS TRAVELLER_CHEQUE1, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE2))) AS TRAVELLER_CHEQUE2, RTRIM(LTRIM(TC_CURRENCY)) AS TC_CURRENCY,RTRIM(LTRIM(TC_CURRENCY1)) AS TC_CURRENCY1,RTRIM(LTRIM(TC_CURRENCY2)) AS TC_CURRENCY2, EXPENDITURE_REMARKS, CASH_BREAKUP_REMARKS, TRAVEL_REQ_ID, SITE_ID,TK_PROVIDER_FLAG,TK_AIRLINE_NAME,TK_CURRENCY,TK_AMOUNT,TK_REMARKS , "
				+ " YTM_BUDGET , YTD_ACTUAL , AVAIL_BUDGET , EST_EXP , EXP_REMARKS,FARE_CURRENCY,FARE_AMOUNT"
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
			strTotalFareCur=rs.getString("FARE_CURRENCY");
			strTotalFareAmt=rs.getString("FARE_AMOUNT");

			if(dbl_YTM_BUDGET.equalsIgnoreCase("0.0"))
				dbl_YTM_BUDGET = "";
			if(dbl_YTD_ACTUAL.equalsIgnoreCase("0.0"))
				dbl_YTD_ACTUAL = "";
			if(dbl_AVAIL_BUDGET.equalsIgnoreCase("0.0"))
				dbl_AVAIL_BUDGET = "";
			if(dbl_EST_EXP.equalsIgnoreCase("0.0"))
				dbl_EST_EXP = "";
			
			//changed by manoj chand on 21 feb 2012 to set strAmount blank when it is  zero 
			if (strAmount.equals("0")) {
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

		//added by manoj chand on 16 oct to find total amount in USD
		/*if(!strTotalAmount.equals("")){
		strSql="SELECT DBO.[FN_CURRENCY_CONVERTOR]('"+strTotalAmount+"','"+strBaseCur+"','USD','"+formattedDate+"') AS FINAL_AMOUNT";
 		rs = dbConBean.executeQuery(strSql);
 		if(rs.next()){
 		strTotalExpinUSD=rs.getString("FINAL_AMOUNT");
 		}
		}*/
		String strExchRate="0.000000";
		if(strBaseCur!=null && !strBaseCur.equals("")){
			strSql="SELECT ISNULL(DBO.FN_GET_EXCHANGE_RATE ('"+strBaseCur+"','"+formattedDate+"'),'') AS EXCHANGE_RATE";
      		rs = dbConBean.executeQuery(strSql);
     		if(rs.next()){
     		strExchRate=rs.getString("EXCHANGE_RATE");
     		}
		}
		
		
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
		// and USER_SITE_ACCESS.STATUS_ID=10 condition added by manoj chand on 17 apr 2013 in existing query
		if (strBillingSite == null) {
		} else {
			strSql = "SELECT  1 AS yes FROM USER_SITE_ACCESS WHERE  (USERID = "
					+ strTravellerId
					+ ") AND (SITE_ID = "
					+ strBillingSite
					+ ") and USER_SITE_ACCESS.STATUS_ID=10";

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
	  <td><div align="center"><img src="images\newTabs\3.png?buildstamp=2_0_0" width="486" height="43" /></div></td>
	  <tr>
	    <td align="center" style="padding-top:5px;">
	    <form  name="frm" action="T_IntForex_Details_Post.jsp">                         <!--Form Start-->
	    
	   <input type="hidden" name="BillingSiteFlag" value="<%=strFlag%>" /> <!-- added on 09-06-2009 -->	 	
		<input type ="hidden" name=approverlist value="<%=ApproverText%>">  	
		<input type="hidden" name="checkMsg" value='<%=request.getParameter("message")%>' />
		  <table width="90%" border="0" cellpadding="0" cellspacing="0">
	        <tr>
	          <td background="images/index_01.png?buildstamp=2_0_0"></td>
	          <td height="29" align="left" background="images/headerBG.png?buildstamp=2_0_0"><img src="images/formTitIcon.png?buildstamp=2_0_0" width="30" height="29" align="absmiddle" /><span class="formTit"><%=dbLabelBean.getLabel("label.global.foreignexchange",strsesLanguage)%></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Company Policy" onClick="<%// code by sanjeet kumar on 16-july-2007 for giving proper information if site not uploaded.
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
	                 <td height="25" colspan="2" valign="bottom" bgcolor="#FFFFFF" class="formfirstfield"><%=dbLabelBean.getLabel("label.global.foreignexchangedetails",strsesLanguage)%> <%=strMessage%> </td>  
	               </tr>
	               <tr>
				     <td height="30" colspan="<%=strcolspan%>" align="left" bgcolor="#FFFFFF" class="formtxt"><%=dbLabelBean.getLabel("label.global.fieldsmarkedwithanasterisk",strsesLanguage)%> (<span class="starcolour">*</span>) <%=dbLabelBean.getLabel("label.global.arerequired",strsesLanguage)%> &nbsp; &nbsp;&nbsp;&nbsp;</td>
				     <%
				     	if (strlinkshowflag.equals("yes")) {
				     %>
				    
				     <td align="right" align="left" bgcolor="#FFFFFF" class="formtxt"><a href="#"    onclick="window.open('M_Myaccessunit.jsp?userId=<%=strTravellerId%>','SEARCH','scrollbars=yes,resizable=yes,width=500,height=240')";><%=dbLabelBean.getLabel("link.global.showmyaccessibleunits",strsesLanguage)%></a> &nbsp; &nbsp;&nbsp;</td> 
				     <%
 				     	}
 				     %>
				      
	               </tr> 
	               <tr>
	               <td height="34" colspan="2" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff">
					   <table width="104%" border="0" cellpadding="0" cellspacing="0">
	                     <tr>
	                       <td height="30" colspan="6"><span class="label1"><%=dbLabelBean.getLabel("label.global.billinginstructions",strsesLanguage)%></span><span class="starcolour">*</span></td>
	                     </tr>
<!--	                     <tr> -->
<!--	                       <td height="30" colspan="6" class="label2" style="visibility: hidden;" >In case of chargeable to <strong>self</strong>, the request will directly go to <strong>MATA </strong></td>
	                      </tr>-->
	                     <tr>
	                       <td ><span class="label2"><%=dbLabelBean.getLabel("label.global.chargeableto",strsesLanguage)%> </span></td>
	                       <!--CHARGABLE TO CLIENT-->                       
	                       <td ><input name="billing" type="radio" value="self" checked="checked"   onClick="billingOnClick(this.form)" style="visibility: hidden;" />
	                        <span class="label2" style="visibility: hidden;">Self</span></td>
						   <td><input name="billing" type="radio" value="SMG" checked="checked"   onClick="billingOnClick(this.form)"/>
	                        <span class="label2"><%=dbLabelBean.getLabel("label.global.smg",strsesLanguage)%></span> </td>
						   <td>
						     <select name="billingSMGSite" class="textBoxCss" onchange="getSiteID(this.form)">        <!--Expenditure Currency-->
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
							//change manoj
									document.frm.billingSMGSite.value="<%=strTravllerSiteId%>";
								 </script>					  
	
	                         <%
					  		                         	} else if (strBillingSite == null) {
					  		                         %>
								<script language="javascript">      
								//change manoj
									document.frm.billingSMGSite.value="<%=strTravllerSiteId%>";
								 </script>					  
							 <%
					  							 	}
					  							 %>		 		   </td>
	                       <td align="center">
						     <input name="billing" type="radio" value="outSideSMG" checked onClick="billingOnClick(this.form)" />
						    <span class="label2"><%=dbLabelBean.getLabel("label.global.nonsmg",strsesLanguage)%></span> </td>                     
	
	                       <td height="30" align="left">           <!--BILLING CLIENT -->
						     <input name="billClient" type="text" class="textBoxCss" value="" onKeyUp="return test1(this, 30, 'c')"  size="34"/>
	                         <span class="formtxt2"><br>
	                             <%=dbLabelBean.getLabel("label.global.ifnonsamvardhanagroupenterthenameofclient",strsesLanguage)%>&nbsp;</span>	
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
						    <td class="label2" colspan=3><%=dbLabelBean.getLabel("label.createrequest.selectuserofbillingunitforapproval",strsesLanguage)%>  </td>
						     
						     <td colspan="3">
							  <select name="billingSMGUser" class="textBoxCss"  <%//=strCombostate%> >      
							    <option  value="-1"> <%=dbLabelBean.getLabel("label.createrequest.userfrombillingunit",strsesLanguage)%> </option> 
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
							//System.out.println("strBillingSite--------->"+strBillingSite);
							//System.out.println("strSiteIdSS----->"+strSiteIdSS);
								//code added by vaibhav on Aug 20 2010
								//change manoj
								if (strBillingSite != null && !strBillingSite.equals("0")
										&& !strBillingSite.equals("-1")
										&& !strBillingSite.equals(strTravllerSiteId)
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
	                 <td width="100%" colspan="2" height="34" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff">
					   <table class="mytable" border="1" cellpadding="2" cellspacing="0" width="100%" style="border-style:solid;border-color:#F0F0F0;border-collapse:collapse;">
					   <thead>
	                     <tr>
	                       <td colspan="12" height="30" align="left"><span style="FONT-WEIGHT: bold; FONT-SIZE: 12px; COLOR: #353436; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif"><%=dbLabelBean.getLabel("label.requestdetails.forexdetails",strsesLanguage) %></span>&nbsp;&nbsp;<span style="FONT-SIZE: 11px; COLOR: BLUE; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; font-weight: bold;font-style: italic;"><%=dbLabelBean.getLabel("label.createrequest.toaddmultiplecurrencies",strsesLanguage) %></span></td>
	                     </tr>
	                     <!-- added by manoj chand on 07 oct 2012 to add expenditure in multiple currency -->
	                     <tr>
	                     <td class="label3" rowspan="2" nowrap="nowrap"><b><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></b></td>
	                     <td class="label3" rowspan="2"><b><%=dbLabelBean.getLabel("label.global.currencypreference",strsesLanguage)%></b></td>
	                     <td class="label3" colspan="2"><b><%=dbLabelBean.getLabel("label.global.dailyallowances",strsesLanguage)%></b></td>
	                     <td class="label3" colspan="2"><b><%=dbLabelBean.getLabel("label.global.hotelcharges",strsesLanguage)%></b></td>
	                     <td class="label3" rowspan="2"><b><%=dbLabelBean.getLabel("label.global.contigencies",strsesLanguage) %></b></td>
	                     <td class="label3" rowspan="2"><b><%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage) %></b></td>
	                     <td class="label3" rowspan="2"><b><%=dbLabelBean.getLabel("label.global.total",strsesLanguage) %></b></td>
	                     <td class="label3" rowspan="2" align="center"><b><%=dbLabelBean.getLabel("label.requisition.exchrate",strsesLanguage) %><br>(<%=dbLabelBean.getLabel("label.requisition.inr",strsesLanguage) %>)</b></td>
	                     <td class="label3" rowspan="2" align="center"><b><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage) %><br>(<%=strBaseCur %>)</b></td>
	                     <td class="label3" rowspan="2"><b><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage) %></b></td>
	                     </tr>
	                     <tr>
	                     <td class="label3"><b><%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage) %></b></td>
	                     <td class="label3"><b><%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage) %></b></td>
	                     <td class="label3"><b><%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage) %></b></td>
	                     <td class="label3"><b><%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage) %></b></td>
	                     </tr>
	                    </thead>
	                    <tbody> 
<%
String strTACurrency2="USD",strRec="no",strEntPerDay2="",strTotalTourDays2="",strTotalExpId2="",strTotalForex="",strExchangeRate="",strTotalinBase="";
int count=0,sno=0;
CallableStatement objCstmt	    =  null;
Connection objCon               =  dbConBean.getConnection(); 
objCstmt             =  objCon.prepareCall("{?=call SPG_GET_TRAVEL_EXPENDITURE_DETAILS(?,?,?)}");        
objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
objCstmt.setString(2,strTravelId);
objCstmt.setString(3,"I");
objCstmt.setString(4,"0");
rs3 = objCstmt.executeQuery();
while (rs3.next()) 
{
strRec="yes";
strTACurrency2=rs3.getString("CURRENCY");
strEntPerDay=rs3.getString("ENT_PER_DAY1");
strTotalTourDays=rs3.getString("TOTAL_TOUR_DAYS1");
strEntPerDay2=rs3.getString("ENT_PER_DAY2");
strTotalTourDays2=rs3.getString("TOTAL_TOUR_DAYS2");
strTotalExpId=rs3.getString("TOTAL_EXP_ID3");
strTotalExpId2=rs3.getString("TOTAL_EXP_ID4");
strTotalForex=rs3.getString("TOTAL_EXP");
strExchangeRate=rs3.getString("EXCHANGE_RATE");
if(strExchangeRate.equals("0.000000"))
	strExchangeRate="";
strTotalinBase=rs3.getString("TOTAL");
%>
 <tr id="rowid<%=count %>">
	                       <td align="center" class="label5" ><span class="spn"><%=++sno %></span></td>
	                       <td height="30" align="left" valign="top" class="label5">
						     <select name="expCurrency" id="expCurrency" class="textBoxCss" onchange="fun_exchangerate(this);">        <!--Expenditure Currency-->
						     <option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
								<%
									strSql = "Select rtrim(Currency), rtrim(Currency) from m_currency where status_id=10";
									rs = dbConBean.executeQuery(strSql);
									while (rs.next()) {
								%>
	                             <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>  
								<%}
  									rs.close();
  								%>
	                         </select>
								 <script language="javascript">
		                            document.getElementsByName("expCurrency")[<%=count%>].value="<%=strTACurrency2%>";
		                         </script>
	                         </td>
							<td height="30" align="left" valign="top" class="label5">
						     <input name="entitlement" id="entitlement1" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n')"  value="<%=strEntPerDay%>" size="4" maxlength="7" align="right" />
						   </td>
	                       <td height="30" align="left" valign="top" class="label5">
						     <input name="tourDays" id="tourDays1" type="text" class="textBoxCss2" onblur="checkDateDiff(this);" onChange="check1();" onKeyUp="return test1(this, 3, 'n')"  value="<%=strTotalTourDays%>" size="1" maxlength="3" align="right" />
						   </td>
						   <td height="30" align="left" valign="top" class="label5">
						     <input name="entitlement2" id="entitlement2" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n')"  value="<%=strEntPerDay2%>" size="4" maxlength="7" align="right" />
						   </td>
	                       <td height="30" align="left" valign="top" class="label5">
						     <input name="tourDays2" id="tourDays2" type="text" class="textBoxCss2" onblur="checkDateDiff(this);" onChange="check1();" onKeyUp="return test1(this, 3, 'n')"  value="<%=strTotalTourDays2%>" size="1" maxlength="3" align="right" />
						   </td>
	                     <td align="left" valign="top" class="label5">  
						     <input name="contingencies" id="contingencies1" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n.')"  value="<%=strTotalExpId%>" size="6" maxlength="8" />
						 </td>
	                     <td height="30" align="left" valign="top" class="label5">
						     <input name="contingencies2" id="contingencies2" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n.')"  value="<%=strTotalExpId2%>" size="6" maxlength="8" />
						   </td>
						   <td height="30" align="left" valign="top" class="label5">
						     <input name="totalForex" id="totalforex" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n.')"  value="<%=strTotalForex%>" size="6" align="right" />
						   </td>
						   <td height="30" align="left" valign="top" class="label5">
						     <input name="exRate" id="exrate" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n.')"  value="<%=strExchangeRate %>" size="6" align="right" disabled="disabled" />
						   </td>
						   <td height="30" align="left" valign="top" class="label5">
						     <input name="totalInr" id="totalinr" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n.')"  value="<%=strTotalinBase %>" size="8" align="right" />
						   </td>
						   
						   <td height="30" align="left" valign="top" class="label5">
						   <input type="button" id="btnadd" style="display: none;" value="  <%=dbLabelBean.getLabel("label.global.add",strsesLanguage) %>  " class="formButton">
						   <input type="button" id="removebtn" class="remove formButton" value="<%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %>"><input name="hd" id="hd" type="hidden" value="v">
						  </td>  
	                     </tr>
	                     
<%
count++;
}
if(strRec.equals("yes")){%>
	<script type="text/javascript">
		showaddbutton('<%=count-1%>');
	</script>
 <tr style="display: none;">
<%}else{%>
	 <tr>
<%}
if(strRec.equals("no")){
%>
	                       <td align="center" class="label5" ><span class="spn">1</span></td>
	                       <td height="30" align="left" valign="top" class="label5">
						     <select name="expCurrency" id="expCurrency" class="textBoxCss" onchange="fun_exchangerate(this);">        <!--Expenditure Currency-->
						     <option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
								<%
									//For Population of Currency Combo for the particular site
									strSql = "Select rtrim(Currency), rtrim(Currency) from m_currency where status_id=10";
									rs = dbConBean.executeQuery(strSql);
									while (rs.next()) {
								%>
	                             <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>  
								<%}
  									rs.close();
  								%>
	                         </select>
								 <script language="javascript">
							 		        document.frm.expCurrency.value="<%=strBaseCur%>";
	                         </script>
	                         </td>

	                       <td height="30" align="left" valign="top" class="label5">
						     <input name="entitlement" id="entitlement1" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n')"  value="0" size="4" maxlength="7" align="right" />
						   </td>
	                       <td height="30" align="left" valign="top" class="label5">
						     <input name="tourDays" id="tourDays1" type="text" class="textBoxCss2" onblur="checkDateDiff(this);" onChange="check1();" onKeyUp="return test1(this, 3, 'n')"  value="0" size="1" maxlength="3" align="right" />
						   </td>
						   <td height="30" align="left" valign="top" class="label5">
						     <input name="entitlement2" id="entitlement2" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n')"  value="0" size="4" maxlength="7" align="right" />
						   </td>
	                       <td height="30" align="left" valign="top" class="label5">
						     <input name="tourDays2" id="tourDays2" type="text" class="textBoxCss2" onblur="checkDateDiff(this);" onChange="check1();" onKeyUp="return test1(this, 3, 'n')"  value="0" size="1" maxlength="3" align="right" />
						   </td>
	                       <td align="left" valign="top" class="label5">  
						     <input name="contingencies" id="contingencies1" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n.')"  value="0" size="6" maxlength="8" />
						   </td>
	                       <td height="30" align="left" valign="top" class="label5">
						     <input name="contingencies2" id="contingencies2" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n.')"  value="0" size="6" maxlength="8" />
						   </td>
						   <td height="30" align="left" valign="top" class="label5">
						     <input name="totalForex" id="totalforex" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n.')"  value="0" size="6" align="right" />
						   </td>
						   <td height="30" align="left" valign="top" class="label5">
						     <input name="exRate" id="exrate" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n.')"  value="<%=strExchRate %>" size="6" align="right" disabled="disabled" />
						   </td>
						   <td height="30" align="left" valign="top" class="label5">
						     <input name="totalInr" id="totalinr" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n.')"  value="0.00" size="8" align="right" />
						   </td>
						   <td  height="30" align="left" valign="top" class="label5">
						   	<input type="button" id="btnadd" value="  <%=dbLabelBean.getLabel("label.global.add",strsesLanguage) %>  " class="formButton">
						   	<input type="button" id="removebtn" style="display: none;" class="remove formButton" value="<%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %>">
						   	<input name="hd" id="hd" type="hidden" value="v">
						   </td>
	                     </tr>
<%} %>	                     
	             <!--blank row created to add multiple time -->
	                     <tr class="prototype">
	                       <td align="center" class="label5" ><span class="spn"></span></td>
	                       <td height="30" align="left" valign="top" class="label5">
						     <select name="expCurrency" id="expCurrency" class="textBoxCss" onchange="fun_exchangerate(this);">
						     <option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
								<%
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
	                         </td>
						   <td height="30" align="left" valign="top" class="label5">
						     <input name="entitlement" id="entitlement1" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n')"  value="0" size="4" maxlength="7" align="right" />
						   </td>
	                       <td height="30" align="left" valign="top" class="label5">
						     <input name="tourDays" id="tourDays1" type="text" class="textBoxCss2" onblur="checkDateDiff(this);" onChange="check1();" onKeyUp="return test1(this, 3, 'n')"  value="0" size="1" maxlength="3" align="right" />
						   </td>
						   <td height="30" align="left" valign="top" class="label5">
						     <input name="entitlement2" id="entitlement2" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n')"  value="0" size="4" maxlength="7" align="right" />
						   </td>
	                       <td height="30" align="left" valign="top" class="label5">
						     <input name="tourDays2" id="tourDays2" type="text" class="textBoxCss2" onblur="checkDateDiff(this);" onChange="check1();" onKeyUp="return test1(this, 3, 'n')"  value="0" size="1" maxlength="3" align="right" />
						   </td>
						   <td align="left" valign="top" class="label5">  
						     <input name="contingencies" id="contingencies1" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n.')"  value="0" size="6" maxlength="8" />
						 </td>
                         <td height="30" align="left" valign="top" class="label5">
						     <input name="contingencies2" id="contingencies2" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 10, 'n.')"  value="0" size="6" maxlength="8" />
	                     </td>
						 <td height="30" align="left" valign="top" class="label5">
						     <input name="totalForex" id="totalforex" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n.')"  value="0" size="6" align="right" />
						 </td>
						 <td height="30" align="left" valign="top" class="label5">
						     <input name="exRate" id="exrate" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n.')"  value="0.000000" size="6" align="right" disabled="disabled" />
						  </td>
						  <td height="30" align="left" valign="top" class="label5">
						     <input name="totalInr" id="totalinr" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n.')"  value="0.00" size="8" align="right" />
						  </td>	
						  <td height="30" align="left" valign="top" class="label2">
						  <input type="button" id="btnadd" value="  <%=dbLabelBean.getLabel("label.global.add",strsesLanguage) %>  " class="formButton">
						  <input type="button" id="removebtn" style="display: none;" class="remove formButton" value="<%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %>">
						  <input name="hd" id="hd" type="hidden" value="h">
						  </td>
	                     </tr>
	                     <tr class="inner">
	                    <td colspan="10" align="right" class="label5"><font color="black" style="font-weight: bold" size="1"><%=strBaseCur %></font></td>
	                    <td class="label5"><input name="grandTotalForex" id="grandTotalForexinr" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n')"  value="<%=strTotalAmount%>" size="8" align="right" /></td>
	                    <td class="label5">&nbsp;</td>
	                    </tr>
	                    <tr>
	                    <td colspan="9" align="right" class="label3"><font color="red"><%=dbLabelBean.getLabel("label.createrequest.aspercorporateguidelines",strsesLanguage) %></font></td>
	                    <td colspan="1" align="right" class="label5"><font color="red" style="font-weight: bold" size="1"><%=dbLabelBean.getLabel("label.createrequest.usdperday",strsesLanguage) %></font></td>
	                    <td class="label5">
	                    <input name="grandTotalForexUSD" id="grandtotalforexusd" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n')" value=""  size="8" />
	                    </td>
	                    <td class="label5">&nbsp;</td>
	                    </tr>
	                    <tr>
	                    
	                    <td colspan="12" valign="top" bgcolor="#FFFFFF" style="border-style: solid;border-color:#F0F0F0;border-collapse: collapse; ">
					   <table width="100%" border="0" cellpadding="0" cellspacing="0">
	                     <tr>
	                       <td height="20" valign="bottom" class="label2" colspan="2"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%> / <%=dbLabelBean.getLabel("alert.global.reasonforcontigencies",strsesLanguage)%></td>
	                       <%if(strAppLvl3flg.equalsIgnoreCase("Y")){ %>
	                       <td height="20" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage) %></td>
	                       <td height="20" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.createrequest.totalfare",strsesLanguage) %></td>
	                       <%} %>
	                     </tr>
	                     <tr>
	                       <td height="30" valign="top" >
						     <textarea name="expRemarks" cols="75" rows="3" class="textBoxCss" onKeyUp="return test1(this, 100, 'all')" ><%=strExpRemarks%></textarea>
						     </td>
						     <%if(strAppLvl3flg.equalsIgnoreCase("Y")){ %>
						   <td height="20" valign="top" class="label2" nowrap="nowrap"><b><%=dbLabelBean.getLabel("label.createrequest.totaltravelfare",strsesLanguage) %></b></td>
	                       <td height="20" valign="top" class="label2">
		                       <select	name="TotalFareCurrency" id="totalfarecurrency" class="textBoxCss">
								<option value=""><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
										<%
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
	                       <td height="20" valign="top" class="label2"><input name="TotalFareAmount" id="totalfareamount" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n')" value="<%=strTotalFareAmt %>"  size="6" /></td>
	                       <%} %>
	                     </tr>

	                  </table>
	                    </td>
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
					
	
	
	                 
	               </tr>
	               <tr>
				     <td height="34" colspan="2" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff">
					   <table width="100%" border="0" cellpadding="0" cellspacing="0"> 
					     <tr>
	                       <td height="20" width="50%" colspan="2" align="left" bgcolor="#FFFFFF" class="label2" valign="middle"><span class="label1"><%=dbLabelBean.getLabel("label.global.kindlyputyourcurrencydenominationdetails",strsesLanguage)%></span><span class="starcolour"></span></td>
	                       <%	String strText = "display:none";
	                       //strSHOW_BUD_INPUT="Y";
	                      		if (strSHOW_BUD_INPUT.equalsIgnoreCase("Y")) {
								%>
	                      <td height="20"  colspan="2" align="left" bgcolor="#FFFFFF" class="label2" valign="middle"><span class="label1"><%=dbLabelBean.getLabel("label.global.budgetactualdetails",strsesLanguage) %></span><span class="starcolour">*</span></td>
	                      <%} %>
	                     </tr>
	                     <tr>
	                       <td colspan="2" width="50%" valign="top">  
						     <p>
						       <textarea name="cashBreakupRemarks" cols="76" rows="4" class="textBoxCss" onKeyUp="return test1(this, 300, 'all')"><%=strCashBreakupRemarks%></textarea> 
						       <!-- CASH BREAKUP REMARKS -->					   
						       <br>
						         <span class="formtxt2"><%=dbLabelBean.getLabel("label.createrequest.currencycashtravelercheque",strsesLanguage)%><br>
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
<!-- adding colspan=2 by manoj chand on 11 jan 2012 to prevent distraction of page -->
					<td valign="top" align="left" colspan="2"><%
						if (strSHOW_BUD_INPUT.equalsIgnoreCase("Y")) {
					%>
								<table width="100%" cellspacing="0" cellpadding="0">
									<tr>
										<td bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.ytmbudget",strsesLanguage)%></td>
										<td><input type="text" name="YtmBud" size="10"
											onChange="check1();showDiff();" onKeyUp="return test1(this, 15, 'n')"
											class="textBoxCss" maxlength="15"> <script
											language="javascript">
                      		   document.frm.YtmBud.value="<%=dbl_YTM_BUDGET%>";
                     		 </script></td>
										<td bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.ytdactual",strsesLanguage)%></td>
										<td><input type="text" name="YtmAct" size="10"
											onChange="check1();showDiff();" onKeyUp="return test1(this, 15, 'n')"
											class="textBoxCss" maxlength="15"> <script
											language="javascript">
                      		   document.frm.YtmAct.value="<%=dbl_YTD_ACTUAL%>";
                     		 </script></td>
									</tr>
									<tr>
										<td bgcolor="#FFFFFF" class="label2" nowrap="true"><%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage)%></td>
										<td><input type="text" name="AvailBud" size="10"
											onChange="" onKeyUp=""
											class="textBoxCss" maxlength="15" readonly="readonly"> <script
											language="javascript">
                      		   document.frm.AvailBud.value="<%=dbl_AVAIL_BUDGET%>";
                     		 </script></td>
										<td bgcolor="#FFFFFF" class="label2" nowrap="true"><%=dbLabelBean.getLabel("label.global.estimatedexpenditure",strsesLanguage)%></td>
										<td><input type="text" name="EstExp" size="10"
											onChange="check1();" onKeyUp="return test1(this, 15, 'n')"
											class="textBoxCss" maxlength="15"> <script
											language="javascript">
                      		   document.frm.EstExp.value="<%=dbl_EST_EXP%>";
                     		 </script></td>
									</tr>
									<tr>
										<td bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
										<td colspan="3"><textarea name="budgetRemarks" cols="50"
											rows="2" class="textBoxCss"
											onKeyUp="return test1(this, 100, 'all')"><%=str_EXP_REMARKS.trim()%></textarea>
										</td>
									</tr>

								</table>
								<%}%>
				
				
					
					
					
					
					
					
					
					
					<%
					//strforPriceDesicion="y";
	                       	if (strforPriceDesicion.equalsIgnoreCase("y")) {
	                       %>
	                   <table width="100%" border="0"><tr>    
	                       <!-- change caption for checking pricing through alternate source on 18 Oct 2011 by manoj chand -->
	                       <td height="30" colspan="2" align="left" bgcolor="#FFFFFF" class="label2" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.proposetobuyticketsfromnonmatasource",strsesLanguage)%> &nbsp;<input type="radio" name="tkflyes" onclick="showdiv('y')" checked="checked" value="y" > <%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%> <input type="radio" name="tkflyes" onclick="showdiv('n')" value="n"> <%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
	                       <br><i><%=dbLabelBean.getLabel("label.global.nonmatasource",strsesLanguage)%></i>
	                         </td>
	                         <!-- tr and table tag added by manoj chand on 11 jan 2012 to resolve page designing issue coming for site
	                         that have alternate from mata source disabled -->
	                         </tr>

								</table>
	                       <%
	                         						       	}
					
	                         						       //	String strText = "display:none";

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
									}%>
					
					
					
						     <%
						     	// System.out.println(strforPriceDesicion);
						     	// strforPriceDesicion = "y";
						     	if (strforPriceDesicion.equalsIgnoreCase("y")) {
						     %>
							       <div id="showdiv" style="<%=strText%>"><!--
						   <div id="showdiv">    
						      --><table width="90%" border="0" cellpadding="0" cellspacing="0" >  
								<TR>
									<TD bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.airline",strsesLanguage)%></TD>  
									<TD bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%></TD>
									<TD bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.localprice",strsesLanguage)%></TD>
									<TD bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></TD>  
								</TR>
								<TR>  
									<TD bgcolor="#FFFFFF" valign="top"><input type="text" name="airline" size="8"  class="textBoxCss" onkeyup="return test1(this, 50, 'cn')" maxlength="30">
									 <script language="javascript">
	                         		   document.frm.airline.value="<%=strAirLineName.trim()%>";
	                        		 </script>
									
									 </TD>
									<TD bgcolor="#FFFFFF" valign="top">
									<select name="currency" class="textBoxCss">        <%=dbLabelBean.getLabel("label.global.expenditurecurrency",strsesLanguage)%>
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
									<TD bgcolor="#FFFFFF" valign="top"> 
									<input type="text" name="localprice" size="8" class="textBoxCss2" onKeyUp="return test1(this, 10, 'n')"   >
									
									 <script language="javascript">
	                         		   document.frm.localprice.value="<%=strAmount.trim()%>";
	                        		 </script>
									
									
									</TD>
									<TD bgcolor="#FFFFFF" valign="top">    
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
	                 <td colspan="2" align="left" bgcolor="#FFFFFF" class="newformbot"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                   <tr>
	                    <td align="left" bgcolor="#FFFFFF" class="newformbot">
						<!-- code added by Sanjeet on 27-July-2007  -->
					   <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=I&whichPage=T_IntForex_Details.jsp&targetFrame=no','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>"><img src="images/AttachFile.gif?buildstamp=2_0_0" width="94" height="24" border="0" /></a>				 </td>
	                 <td align="right" bgcolor="#FFFFFF" class="newformbot" nowrap="nowrap">
					   <input name="back" type="button" class="formButton" onClick="return onClick=backPage(frm)" value="<%=dbLabelBean.getLabel("button.global.back",strsesLanguage).trim()%>"/> 
			           <input name="saveExit" type="submit" class="formButton" onClick="return checkData(this.form,'saveExit');" value="<%=dbLabelBean.getLabel("button.global.saveandexit",strsesLanguage).trim()%>"/> 
	                   <input name="save" type="submit" class="formButton" onClick="return checkData(this.form,'save');" value="<%=dbLabelBean.getLabel("button.global.save",strsesLanguage).trim()%>"/> 
	                   <input name="saveProceed"  id="saveProceed" type="button" class="formButton" onClick="return checkData(this.form,'saveProceed')" value="<%=dbLabelBean.getLabel("button.global.submittoworkflow",strsesLanguage).trim()%>"/>
	  <input type="hidden" name="matapricecomp" value="<%=strforPriceDesicion%>" />                 
	                   </td>
	                   
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
		  <input type="hidden" name="basecur" value="<%=strBaseCur %>"/>
		</form><!--Form End-->
		</td>
	  </tr>  
	</table>
	 </body>