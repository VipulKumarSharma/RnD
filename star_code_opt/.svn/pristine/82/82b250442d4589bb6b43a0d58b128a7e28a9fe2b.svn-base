
<%
	/**********************************************************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Abhinav Ratnawat
	 *Date of Creation		:11 September 2006
	 *Copyright Notice		:Copyright(C)2000 MIND.All rights reserved 
	 *Project	  			:STAR
	 *Operating environment	:Tomcat, sql server 2000 
	 *Description 			                :This is first jsp file  for updating the SITE in the STAR Database
	 *Modification 			               :1.  Change the Billing Instruction(add three radio for self,SMG, and other SMG) and Add currency combo. 
	 2. Code added for preventing starting spaces on 05-Jul-07 by shiv 
	 *Reason of Modification:        1. change suggested by MATA
	 2.	Travel Allowance is mandatory field and  if one field of Hotel Charges is filled then  second field  is also mandotary.
	 3.code changed by shiv on 12-Jul-07
	 4.Code added by Sanjeet on 20-July-07 to give appropriate message if page     not uploaded.
	 5.Change code for showing billing site and its users  for adding in workflow if user selects billing site other than his    
	 own site by Shiv Sharma on  5th Nov. 
	 6. Change code  for showing user who are in approver level 1,2 or global apporver  by shiv sharma on 31- dec-2007
	 7. added code for changing Expenditure validation Criteria  on  28-Apr-08  by shiv Sharma 
	 8: code added for making user selection not mandetory for all site for which he has access for billing purpose  on 09-06-2009
	 9:Change code for price analysis with mata and local travel agent on 23-Nov-09 byb shiv sharma 
	
	 *Date of Modification  :         1.  2 Nov 2006 
	 2. 12-Mar 2007 
	 *Modified By	                      :1. SACHIN GUPTA
	 2.Vijay Kumar Singh
	
	 *Editor				                   :Editplus
	 :Modified by vaibhav on Aug 20 2010to show only authorised approver in case if billing site is     different.
	 :Modified by Pankaj Dubey on 11 Nov 2010 to add 5 new fields to record budgetory figures.
	 *Modified By			: Manoj Chand
	 *Date of Modification	: 23 Sept 2011
	 *Modification			; Hide the self billing radio button
	 
	 *Modification			:modify workflow as per selected site
	 *Date of modification  :12 Oct 2011
	 *Modified By     		:Manoj Chand
	 
	 *Modification			:change caption for checking pricing through alternate source
	 *Date of modification  :18 Oct 2011
	 *Modified By     		:Manoj Chand
	 
	 *Modification			:screen design going distract for the site to which Ticket Price from Alternate Source is enable.
	 *Date of modification  :12 jan 2012
	 *Modified By     		:Manoj Chand
	 
	 *Modification			:adding check for airline in ticket for non-MATA source
	 *Date of modification  :21 Feb 2012
	 *Modified By     		:Manoj Chand
	 
	 *Modification				:Multilingual functionality added
	 *Modified by				:Manoj Chand
	 *Date of Modification		:24 May 2012
	 
	 *Modified By					:Manoj Chand
	 *Date of Modification			:03 July 2011
	 *Modification					:change query to remove closed unit from unit dropdown
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :12 Feb 2013
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
	 *******************************************************************************************************/
%>
<%@ page buffer="5kb" language="java"
	import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8"%>
<HTML>
<HEAD>
<%-- include remove cache  --%>
<%@ include file="cacheInc.inc"%>
<%-- include header  --%>
<%@ include file="headerIncl.inc"%>
<%-- include page with all application session variables --%>
<%@ include file="application.jsp"%>
<%-- include page styles  --%>
<%--<%@ include  file="systemStyle.jsp" %>--%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page"
	class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page"
	class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<TITLE>Domestic Travel Section Detailed</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css"></link>
</HEAD>

<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
<script language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>

<%
String strSiteId="";
String strTravel_Id = "";
//added by manoj chand on 26 nov 2012 to get smp site flag
String strSMPSiteflag=request.getParameter("smpsiteflag")==null?"":request.getParameter("smpsiteflag");
//System.out.println("strSMPSiteflag--->"+strSMPSiteflag);
strSiteId=request.getParameter("site")==null?strSiteIdSS:request.getParameter("site");
strTravel_Id = request.getParameter("travelId");

String strSHOW_BUD_INPUT = "N";
String strSql123 = "SELECT SHOW_BUD_INPUT FROM M_SITE WHERE site_id = "+strSiteId+" ";
ResultSet rs123 = dbConBean.executeQuery(strSql123);
while (rs123.next()) {
	strSHOW_BUD_INPUT = rs123.getString(1);
}
rs123.close();


//added by manoj chand on 16 oct 2012 to get site base currency
	rs123=null;	
	String strBaseCur="INR";
	strSql123 = "SELECT ISNULL(CURRENCY,'') AS BASE_CUR FROM dbo.M_SITE ms WHERE ms.STATUS_ID=10 AND ms.SITE_ID="+strSiteId;
	rs123 = dbConBean.executeQuery(strSql123);
	if(rs123.next()) {
		strBaseCur = rs123.getString("BASE_CUR");
	}
	rs123.close();
	
	//query added by manoj chand on 26 nov 2012 to get difference in return date and forward date of journey
	int intDays=0;
	rs123=null;
	strSql123 = "SELECT CASE WHEN TRJDI.TRAVEL_DATE IS NULL OR YEAR(TRJDI.TRAVEL_DATE)=1900"+
		     " THEN 0 ELSE DATEDIFF(DAY,TDD.TRAVEL_DATE,TRJDI.TRAVEL_DATE)+1"+
		     " END RETURN_FLAG  FROM T_TRAVEL_DETAIL_DOM TDD"+ 
		     " LEFT JOIN  T_RET_JOURNEY_DETAILS_DOM TRJDI ON TRJDI.TRAVEL_ID = TDD.TRAVEL_ID"+
		     " WHERE TDD.TRAVEL_ID='"+strTravel_Id+"'  AND TDD.STATUS_ID=10";
		rs123 = dbConBean.executeQuery(strSql123);
		if(rs123.next()) {
			intDays = rs123.getInt("RETURN_FLAG");
		}
		rs123.close();
	
	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	String formattedDate = df.format(new Date());
%>

<script>
	window.history.forward(1);
	function MM_openBrWin(theURL,winName,features)
	 { 
			   window.open(theURL,winName,features);
	 }
	
	//added new fby shiv on 01-Nov-07
	  function getSiteID(frm)
	{ 
	   document.frm.action="T_TravelDetail_Dom_Forex.jsp";
		frm.refreshFlag.value="Y";
		frm.billingSMGUser.value="-1";
	    document.frm.submit();
	 }
	 
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

<script type="text/javascript">

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
};

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
	            	master.find('#exrate').val(res);
	            	var x=master.find('#totalforex').val();
	            	fun_calculate_TotalinBaseCurrency(master.find('#totalinr'),x,curPref,'<%=strBaseCur%>','<%=formattedDate%>');	
	            	var total=fun_calculate_GrandTotal();
	            	$('#grandTotalForexinr').val(total);
	            	fun_calculate_GrandTotalUSD();	            				             
	             }else{
	            	 alert('<%=dbLabelBean.getLabel("label.global.exchangeratefor",strsesLanguage)%>' +curPref.trim()+ '<%=dbLabelBean.getLabel("label.createrequest.isnotdefinedcontactstarsadmin",strsesLanguage)%>');
		             }
	            },
				error: function(){
					alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
		}
	});
			}else
			{
				master.find('#exrate').val('0.000000');
				master.find('#totalinr').val('0.00');
            	var total=fun_calculate_GrandTotal();
            	$('#grandTotalForexinr').val(total);
            	fun_calculate_GrandTotalUSD();	
			}
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
			if(cur_val==a && sno_val!=sno_num && cur_val!='-1'){
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

	function fun_calculate_GrandTotal(){
		var sum=0;
		$('table.mytable tbody > tr').each(function() {
			var a=$(this).find('#totalinr').val();
			if(a!=undefined){
			sum=parseFloat(sum)+parseFloat(a);
			}	
		});
		return sum.toFixed(2);
	}

	//added by manoj chand on 26 november 2012 to calculate Daily charges tour days
	function fun_calculate_DailyTourDays(){
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
	//added by manoj chand on 26 november 2012 to calculate Travel allowances tour days
	function fun_calculate_TravelTourDays(){
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

		var dailytd=fun_calculate_DailyTourDays();
		var traveltd=fun_calculate_TravelTourDays();
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
            	else if(dailytd!=undefined && dailytd!=0){
    				$('#grandtotalforexusd').val((res/dailytd).toFixed(2));
    			}else if(traveltd!=undefined && traveltd!=0){
               		$('#grandtotalforexusd').val((res/traveltd).toFixed(2));
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
	    }
				count++;
			});
		return flag;
	}


	
	function check1()
	{
		var total=fun_calculate_GrandTotal();
    	$('#grandTotalForexinr').val(total);
    	fun_calculate_GrandTotalUSD();
	}

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
		g.val(totalforexval);
		if(cur!=null && cur!=undefined && cur!='-1'){
		fun_calculate_TotalinBaseCurrency(y,totalforexval,cur,'<%=strBaseCur%>','<%=formattedDate%>');
		}
	}
	
	function fun_multiply(a,b){
		return parseFloat(a)*parseFloat(b);
	}

	//FUNCTION CREATED BY MANOJ CHAND ON 16 OCT 2012 TO CALCUATE INDIVIDUAL TOTAL IN BASE CURRENCY.
	function fun_calculate_TotalinBaseCurrency(obj,totalforex,cur_val,basecur_val,date_val)
	{
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
		if(obj.name=='expRemarks' || obj.name=='budgetRemarks' || obj.name=='pricingRemarks'){
			upToTwoHyphen(obj);
		}
		charactercheck(obj,str);
		limitlength(obj, length);
		spaceChecking(obj);//added for preventing starting spaces on 05-Jul-07 by shiv  
		calculate(obj);
		var total=fun_calculate_GrandTotal();
    	$('#grandTotalForexinr').val(total);
    	fun_calculate_GrandTotalUSD();
	}

	//function added by manoj chand on 26 apr 2013
	function checkTESRequestCount(){
		var var_travellerid = document.frm.travellerId.value;
		var var_travellersiteid = document.frm.travellerSiteId.value;
		var flag;
		var url = 'strFlag=checkTESRequestCount&travellerId='+var_travellerid+'&siteId='+var_travellersiteid;
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


	
	function checkData(f1,flag) 
	{
	 	if (!f1.billingTo[2].checked) 
			 {
	          	var tt = document.frm.BillingSiteFlag.value;
	          	if (document.frm.billingSMGSite.value!='<%=strSiteId%>'   && tt!='1')
				{
	  		        if(document.frm.billingSMGUser.value=="-1")
				       {
						alert('<%=dbLabelBean.getLabel("alert.global.approverfrombillingunit",strsesLanguage)%>');
					    document.frm.billingSMGUser.focus();
			            return false;
				       }
				 } 
			 }
		if (f1.billingTo[2].checked) 
		{
			if (f1.clientName.value == "") {
			alert('<%=dbLabelBean.getLabel("alert.global.clientname",strsesLanguage)%>');
			f1.clientName.focus();
			return false;
			}
		}
	
	   var k = 9;
	   
	    k=document.frm.elements.length;  
	    
		if(f1.billingTo[0].checked)
		{		
			k=5;
		}

		//added by manoj chand on 09 oct 2012 to check form values
		var fun_flag=checkValue();
		if(fun_flag==false){
			return false;
		}

	// add by sachin 3/15/2007 end
		/*if ((f1.contingencies[0].value != '0' && f1.contingencies[0].value != "" )  || (f1.contingencies[1].value != '0' && f1.contingencies[1].value != "")){
			if (f1.expRemarks.value == "") {
				alert('Please Specify the reason for Contingencies/Any Other Expenditure');
				f1.expRemarks.focus();
				return false;
			}
	
		}*/


   if(document.frm.matapricecomp.value=='y')
		{ 
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
 
	f1.flag1.value = flag; 
		 
		
	if(flag == "Proceed")
		{
		var var_res = checkTESRequestCount();
		if(var_res==false)
			return false;
		    //code to show for approver who are out of office add by shiv 
		    var text=document.frm.approverlist.value;
		   //alert(text);
		   if(text!=''){
		   text='<%=dbLabelBean.getLabel("label.createrequest.currently",strsesLanguage)%>'+' '+text;   
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
			
			
			
			if(confirm(text+'<%=dbLabelBean.getLabel("alert.global.submittoworkflow",strsesLanguage)%>'))
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
	
			return true;
	}
	
	
	
	function billingOnClick(f1)
	{
	
		if(f1.billingTo[0].checked)
		{
			f1.clientName.value="";
			f1.billingSMGSite.disabled=true;
			f1.clientName.disabled=true;
			f1.billingSMGUser.disabled = true;        //billing SMG user combo disabled  
			 
			f1.elements[6].readOnly = true;
			f1.elements[7].readOnly = true;
			f1.elements[8].readOnly = true;
			check1();
		}
		if(f1.billingTo[1].checked)
		{
			f1.billingSMGSite.disabled=false;
		    f1.clientName.value="";
			f1.clientName.disabled=true;
			  f1.billingSMGUser.disabled = false;        //billing SMG user combo disabled  			
			f1.elements[6].readOnly = false;
			f1.elements[7].readOnly = false;
			f1.elements[8].readOnly = false;
	
		}
		if(f1.billingTo[2].checked)
		{
			f1.billingSMGSite.disabled=true;
			f1.clientName.disabled=false;
			f1.billingSMGUser.disabled = true;        //billing SMG user combo disabled  
			f1.clientName.focus();
			f1.elements[6].readOnly = false;
			f1.elements[7].readOnly = false;
			f1.elements[8].readOnly = false;
		}
	}

/* added by manoj on 16 sept to close attachment window */
function childwindowSubmit(){
	
}
	
</script>
	
<style type="text/css">
	.mytable .prototype {
				display:none;
			}
</style>
<%
	String strTravel_Req_Id = "";
	String strTravellerId = "";
	String strTravellerSiteId = "";
	String strFlagSave = "";
	String strSql = "";
	String strBillingSite = "";
	String strBillingClient = "";

	String strTACurrency = "";

	String strTotalAmount = "";
	String strExpRemarks = "";
	String strEntPerDay = "";
	String strTotalTourDays = "";
	String strTotalExpId = "";
	String strBilling = "";
	String strTravelReqNo = "";
	String strInterimId = "";

	String strTicketProvider = "";
	String strAirLineName = "";
	String strCurreny = "";
	String strAmount = "";
	String strRemarks = "";
	//String strTotalExpinUSD="";

	ResultSet rs, rs1,rs3 = null;
	String[] strExpenditureFields = new String[4];

	int[] strENT_PER_DAY = null;
	int[] strTOTAL_TOUR_DAYS = null;
	int[] strTOTAL_EXP_ID = null;

	String strMessage = "";

	String strFlag = "";
	strMessage = request.getParameter("message");
	
	strTravel_Req_Id = request.getParameter("travelReqId");
	strTravelReqNo = request.getParameter("travelReqNo");
	strTravellerId = request.getParameter("travellerId");
	strTravellerSiteId = request.getParameter("travellerSiteId");
	strFlagSave = request.getParameter("flagSave");
	strInterimId = request.getParameter("interimId");

	// code to find the approver who are outof office 
	String strApproverid = "";
	String ApproverText = "";
	String strname1 = "";
	String strname2 = "";

	// below 5 fields added by Pankaj on 11 Nov 10
	String dbl_YTM_BUDGET = "";
	String dbl_YTD_ACTUAL = "";
	String dbl_AVAIL_BUDGET = "";
	String dbl_EST_EXP = "";
	String str_EXP_REMARKS = "";
	String strTotalFareCur="";
	String strTotalFareAmt="0";

	strSql = "select top 1 approver_id  from T_approvers  where travel_id ="
			+ strTravel_Id
			+ " and travel_type='d' and status_id=10 order by order_id ";
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
				ApproverText = ApproverText + strname2
						+" "+dbLabelBean.getLabel("alert.createrequest.hasdelegatedhisauthorityto",strsesLanguage)+" "
						+ strname1 + ".\n ";
			}

		}
	}

	rs.close();

	
	// Code added by Sanjeet Kumar on 20-july-2007 for giving a proper information incase site not uploaded
	//SpolicyPath variable used on 07 jan 2013 for getting company policy path
	//String Path = application.getInitParameter("companyPolicyPath");
	File UploadFile = new File(SpolicyPath + "/" + strSiteFullName + "/"+ strSiteFullName + ".html");

	// set the billing site  as originator site
	//change manoj
	strBillingSite = strSiteId;

	if (strMessage != null && strMessage.equals("save")) {
		strMessage = dbLabelBean.getLabel("message.global.savedsuccessfully",strsesLanguage);
	} else if (strMessage != null && strMessage.equals("notSave")) {
		strMessage = dbLabelBean.getLabel("message.global.couldnotsave",strsesLanguage);
	} else {
		strMessage = "";
	}

	if (strFlagSave != null && strFlagSave.equals("save")) {

		strSql = "SELECT BILLING_SITE,BILLING_CLIENT,ISNULL(RTRIM(LTRIM(CONVERT(DECIMAL(25,2),TOTAL_AMOUNT))),'') AS TOTAL_AMOUNT,  ISNULL(EXPENDITURE_REMARKS,''), LTRIM(RTRIM(TA_CURRENCY)),TK_PROVIDER_FLAG,TK_AIRLINE_NAME,TK_CURRENCY,TK_AMOUNT,TK_REMARKS , YTM_BUDGET, YTD_ACTUAL, AVAIL_BUDGET, EST_EXP, EXP_REMARKS,FARE_CURRENCY,FARE_AMOUNT FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="
				+ strTravel_Id
				+ " AND APPLICATION_ID=1 AND STATUS_ID=10";

		//System.out.println("strSql==save===" + strSql);
		rs = dbConBean.executeQuery(strSql);
		if (rs.next()) {
			strBillingSite = rs.getString(1);
			strBillingClient = rs.getString(2);
			strTotalAmount = rs.getString(3);
			strExpRemarks = rs.getString(4);
			strTACurrency = rs.getString(5);

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
			
			if (strAmount.equals("0")) {
				strAmount = "";
			}
			if (strCurreny == null || strCurreny.equals(""))
				strCurreny = "USD";

			if (strBillingClient == null)
				strBillingClient = "";

			if (strTACurrency == null || strTACurrency.equals(""))

				strTACurrency = "INR";

			if (strTotalAmount != null
					&& strTotalAmount.trim().equals("0")) {
				strTotalAmount = "";
			}
		}
		rs.close();
		//added by manoj chand on 16 oct to find total amount in USD
		/*if(!strTotalAmount.equals("")){
		strSql="SELECT DBO.[FN_CURRENCY_CONVERTOR]('"+strTotalAmount+"','"+strBaseCur+"','USD','"+formattedDate+"') AS FINAL_AMOUNT";
 		rs = dbConBean.executeQuery(strSql);
 		if(rs.next()){
 		strTotalExpinUSD=rs.getString("FINAL_AMOUNT");
 		}
		}	*/
	}
	//added by manoj chand on 16 oct 2012 to get base currency exchange rate
	String strExchRate="0.000000";
	if(strBaseCur!=null && !strBaseCur.equals("")){
		strSql="SELECT ISNULL(DBO.FN_GET_EXCHANGE_RATE ('"+strBaseCur+"','"+formattedDate+"'),'') AS EXCHANGE_RATE";
  		rs = dbConBean.executeQuery(strSql);
 		if(rs.next()){
 		strExchRate=rs.getString("EXCHANGE_RATE");
 		}
	}

	String strPageRefresh = request.getParameter("refreshFlag") == null
			? ""
			: request.getParameter("refreshFlag");
	if (strPageRefresh.equalsIgnoreCase("y")) {
		strBillingSite = request.getParameter("billingSMGSite");
		strTACurrency = request.getParameter("expCurrency");
	}

	//code added for making user selection not mandetory for all site for which he has access  on 09-06-2009 -----
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
<script language="JavaScript">
	function submitBack() {
		document.frm.action = "T_TravelDetail_Dom.jsp?travelId=<%=strTravel_Id%>&travelReqId=<%=strTravel_Req_Id%>&flag=save&travelReqNo=<%=strTravelReqNo%>&interimId=<%=strInterimId%>";
		document.frm.submit();
	}

	// Function added by manoj chand on 31 oct to add constraint on per day expense.
	 function checkMsg(){
		 fun_calculate_GrandTotalUSD();
		 //startBlink();
		 var chm=document.forms[0].checkMsg.value;
		 if (chm=="ExpenceCheck")
		  {
			  alert('<%=dbLabelBean.getLabel("alert.createrequest.couldnotsubmittoworkflow",strsesLanguage)%>');
		  }
	 }
	</script>

<body onload="checkMsg();">
<form name="frm" method="post"
	action="T_TravelDetail_Dom_Forex_Post.jsp"><input type="hidden"
	name="BillingSiteFlag" value="<%=strFlag%>" /> <input type="hidden"
	name=approverlist value="<%=ApproverText%>">



<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="36" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="85%" height="36" class="bodyline-top"><img
					src="images/PageHeadingDomestic2.png?buildstamp=2_0_0" width="311" height="26" /></td>
				<td width="15%" align="center" class="bodyline-top"><img
					src="images/BigIcon.gif?buildstamp=2_0_0" width="46" height="31" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center" style="padding-top: 5px;">

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<div align="center"><img src="images\newTabs\5.png?buildstamp=2_0_0" /></div>
				</td>
			</tr>
		</table>
<!-- table width increase by manoj chand on 12 jan 2012 -->
		<table width="90%" border="0" cellpadding="0" cellspacing="0"
			style="margin-top: -18px; padding-top: 0px;">
			<tr>
				<td background="images/index_01.png?buildstamp=2_0_0"></td>
				<td height="29" align="left" background="images/headerBG.png?buildstamp=2_0_0"><img
					src="images/formTitIcon.png?buildstamp=2_0_0" width="30" height="29"
					align="absmiddle" /><span class="formTit"><%=dbLabelBean.getLabel("label.global.costrecoverydetails",strsesLanguage)%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="#" title="Company Policy"
					onClick="<%// code by sanjeet kumar on 20-july-2007 for giving proper information if site not uploaded.
			if (UploadFile.exists()) {%> MM_openBrWin('Companies_Policies/<%=strSiteFullName%>/<%=strSiteFullName%>.html','','scrollbars=yes,resizable=yes,width=700,height=300')<%;
			} else {%> MM_openBrWin('Companies_Policies/notexist.html','','scrollbars=yes,resizable=yes,width=700,height=300')<%;
			}%>"><img
					src="images/IconPolicy.png?buildstamp=2_0_0" width="69" height="16" border="0" /></a><span
					class="formTit" style="text-align: right"> <a href="#"
					onClick="MM_openBrWin('helpdomestictravel.html#200a','','scrollbars=yes,resizable=yes,width=700,height=300')">
				<img src="images/help.png?buildstamp=2_0_0" width="44" height="16" border="0">
				</a></td>
				<br>
				<td background="images/index_03.png?buildstamp=2_0_0"></td>
			</tr>


			<%
				String sSqlStr = "";
				String strlinkshowflag = "";
				String strcolspan = "";
				
				sSqlStr = "SELECT    M_SITE.SITE_NAME, dbo.CONVERTDATE(usa.C_DATE) AS c_date "
						+ " FROM USER_SITE_ACCESS AS usa INNER JOIN "
						+ " M_SITE ON usa.SITE_ID = M_SITE.SITE_ID WHERE  (usa.USERID = "
						+ strTravellerId + ")";
//System.out.println(sSqlStr);
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
						<td height="25" colspan="2" valign="bottom" bgcolor="#FFFFFF"
							class="formfirstfield"><%=dbLabelBean.getLabel("label.global.costrecoverydetails",strsesLanguage)%> <%=strMessage%>
						</td>
					</tr>
					<tr>
						<td height="30" colspan="<%=strcolspan%>" bgcolor="#FFFFFF"
							class="formtxt"><%=dbLabelBean.getLabel("label.global.fieldsmarkedwithanasterisk",strsesLanguage)%>(<span
							class="starcolour">*</span>) <%=dbLabelBean.getLabel("label.global.arerequired",strsesLanguage)%>&nbsp;
						&nbsp;&nbsp;&nbsp;</td>
						<%
							if (strlinkshowflag.equals("yes")) {
						%>
						<td align="right" align="left" bgcolor="#FFFFFF" class="formtxt"><a
							href="#"
							onclick="window.open('M_Myaccessunit.jsp?userId=<%=strTravellerId%>','SEARCH','scrollbars=yes,resizable=yes,width=500,height=240')";><%=dbLabelBean.getLabel("link.global.showmyaccessibleunits",strsesLanguage)%></a> &nbsp; &nbsp;&nbsp;</td>
						<%
							}
						%>
					</tr>
					<tr>
						<!-- code changed by shiv on 12-Jul-07  -->
						<td height="34" colspan="2" valign="top" bgcolor="#FFFFFF"
							class="forminnerbrdff">
						<table width="104%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td height="30" colspan="6"><span class="label1"><%=dbLabelBean.getLabel("label.global.billinginstructions",strsesLanguage)%></span><span class="starcolour">*</span></td>
							</tr>
							
							<tr>
								<td><span class="label2"><%=dbLabelBean.getLabel("label.global.chargeableto",strsesLanguage)%></span></td>
						<td>
						<input name="billingTo" type="radio" value="self"
									checked="checked" onClick="billingOnClick(this.form)" style="visibility: hidden;"/><span
									class="label2" style="visibility: hidden;"><%=dbLabelBean.getLabel("label.createrequest.self",strsesLanguage)%></span></td>
								<td align="center"><input name="billingTo" type="radio" value="SMG"
									checked="checked" onClick="billingOnClick(this.form)" /> <span
									class="label2"><%=dbLabelBean.getLabel("label.global.smg",strsesLanguage)%></span></td>
								<td><select name="billingSMGSite" class="textBoxCss"
									onchange="getSiteID(this.form)">
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
								</select> <%
 	if (strBillingSite != null && !strBillingSite.equals("-1")
 			&& !strBillingSite.equals("0")) {
 %>
								<script language="javascript">
								document.frm.billingSMGSite.value="<%=strBillingSite%>";
							 </script> <%
 	} else if (strBillingSite != null
 			&& (strBillingSite.equals("-1") || strBillingSite
 					.equals("0"))) {
 %>
								<script language="javascript">
								//change manoj
									document.frm.billingSMGSite.value="<%=strSiteId%>";
								 </script> <%
 	} else if (strBillingSite == null) {
 %> <script
									language="javascript">
	//change manoj
									document.frm.billingSMGSite.value="<%=strSiteId%>";
								 </script> <%
 	}
 %>
								</td>
								<td height="30" align="center"><input name="billingTo"
									type="radio" value="outSideSMG"
									onClick="billingOnClick(this.form)" /> <span class="label2"><%=dbLabelBean.getLabel("label.global.nonsmg",strsesLanguage)%></span></td>
								<td height="20" align="left"><input name="clientName" type="text"
									class="textBoxCss" onKeyUp="return test1(this, 30, 'c')"
									size="30" value="" /> <br>
								<span class="formtxt2"><%=dbLabelBean.getLabel("label.global.ifnonsamvardhanagroupenterthenameofclient",strsesLanguage)%> </span> <%
 	if (strBillingSite != null && strBillingSite.equals("-1")) {
 %> <script> 
							document.frm.clientName.value="<%=strBillingClient%>";
							</script> <%
 	}
 %>
								</td>
							</tr>

							<tr>

								<td class="label2" colspan=3><%=dbLabelBean.getLabel("label.createrequest.selectuserofbillingunitforapproval",strsesLanguage)%></td>
								
								<td colspan="3"><select name="billingSMGUser" class="textBoxCss"
									<%//=strCombostate%>>
									<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.userfrombillingunit",strsesLanguage)%></option>
									<%-- Commented by vaibhav on 20 Aug 2010
										// query changed for showing user who are in approver level 1,2 or global apporver  by shiv sharma on 31- dec-2007

										if (strBillingSite != null && !strBillingSite.equals("0")
												&& !strBillingSite.equals("-1")
												&& !strBillingSite.equals(strSiteIdSS)
												&& !strFlag.equals("1")) {

											strSql = "select userid, dbo.user_name(userid) As UserName from M_userInfo where site_id="
													+ strBillingSite
													+ " and status_id=10   and  ISNULL(APPROVER_LEVEL,0) <> 3 order by 2";

											rs = dbConBean.executeQuery(strSql);
											while (rs.next()) {
									%>
									<option value="<%=rs.getString("UserId")%>"><%=rs.getString("UserName")%></option>
									<%
										}
											rs.close();
										}

										///  added new for showing Global approver   

										if (strBillingSite != null && !strBillingSite.equals(strSiteIdSS)
												&& !strFlag.equals("1")) {

											strSql = "select userid, dbo.user_name(userid) As UserName from M_userInfo where  status_id=10   and  ISNULL(APPROVER_LEVEL,0) = 3 order by 2";

											rs = dbConBean.executeQuery(strSql);
											while (rs.next()) {
									%>
									<option value="<%=rs.getString("UserId")%>"><%=rs.getString("UserName")%></option>
									<%
										}
											rs.close();
										}
									--%>
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
								</select></td>
								<%
									if (!strPageRefresh.equalsIgnoreCase("Y")
											&& strBillingSite != null
											&& !(strBillingSite.equals("-1") || strBillingSite
													.equals("0"))) {
								%>
								<script language="javascript">
								    //alert("tests");
								    //alert("billing usr==="+'<%=strBillingClient%>');
									document.frm.billingSMGUser.value="<%=strBillingClient%>";
								 </script>
								<%
									}
								%>

								<%
									if (strBillingSite != null && strBillingSite.equals("0")) {
								%>
								<script language="JavaScript">
											document.frm.billingTo[0].checked = true;
						                    document.frm.billingSMGSite.disabled = true;        //SMG site combo disabled  
											document.frm.clientName.disabled = true;        //outSide SMG text field disabled  
											document.frm.billingSMGUser.disabled = true;        //billing SMG user combo disabled  	
								</script>
								<%
									} else if (strBillingSite != null && !strBillingSite.equals("-1")
											&& !strBillingSite.equals("0")) {
								%>
								<script language="JavaScript">
										document.frm.billingTo[1].checked = true;
								        document.frm.billingSMGSite.disabled = false;            //SMG site combo enabled   
										document.frm.clientName.disabled = true;             //outSide SMG text field disabled 
										document.frm.billingSMGUser.disabled = false;        //billing SMG user combo disabled  	
								</script>
								<%
									} else if (strBillingSite != null && strBillingSite.equals("-1")) {
								%>
								<script language="JavaScript">
										document.frm.billingTo[2].checked = true;
								        document.frm.billingSMGSite.disabled = true;            //SMG site combo enabled   
										document.frm.clientName.disabled = false;           //outSide SMG text field disabled 	
									    document.frm.billingSMGUser.disabled = true;        //billing SMG user combo disabled 
								</script>

								<%
									} else {
								%>
								<script language="JavaScript">
										document.frm.billingTo[1].checked = true;
								        document.frm.billingSMGSite.disabled = false;            //SMG site combo enabled   
										document.frm.clientName.disabled = true;             //outSide SMG text field disable
								</script>
								<%
									}
								%>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="100%" colspan="2" height="34" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff">
						<table class="mytable" width="100%" border="1" cellpadding="2" cellspacing="0" style="border-style:solid;border-color:#F0F0F0;border-collapse: collapse;">
						<thead>
	                     <tr>
	                       <td colspan="12" height="30" align="left"><span style="FONT-WEIGHT: bold; FONT-SIZE: 12px; COLOR: #353436; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif"><%=dbLabelBean.getLabel("label.requestdetails.forexdetails",strsesLanguage) %></span>&nbsp;&nbsp;<span style="FONT-SIZE: 11px; COLOR: BLUE; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; font-weight: bold;font-style: italic;"><%=dbLabelBean.getLabel("label.createrequest.toaddmultiplecurrencies",strsesLanguage) %></span></td>
	                     </tr>
	                     <!-- added by manoj chand on 07 oct 2012 to add expenditure in multiple currency -->
	                     <tr>
	                     <td class="label3" rowspan="2" nowrap="nowrap"><b><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></b></td>
	                     <td class="label3" rowspan="2"><b><%=dbLabelBean.getLabel("label.global.currencypreference",strsesLanguage)%></b></td>
	                     <td class="label3" colspan="2" nowrap="nowrap"><b><%=dbLabelBean.getLabel("label.global.travelallowance",strsesLanguage)%></b></td>
	                     <td class="label3" colspan="2"><b><%=dbLabelBean.getLabel("label.global.dailycharges",strsesLanguage)%></b></td>
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
								int i = 0;
							String strTemp="";
								strSql = "SELECT  EXP_ID, EXP_HEAD FROM M_EXPENDITURE WHERE TRAVEL_TYPE = 'D' AND STATUS_ID = 10 ORDER BY 1";
								rs = dbConBean.executeQuery(strSql);
								while (rs.next()) {
									//added by manoj chand on 25 june 2012 to display various allowances in multilingual form
									strTemp=rs.getString(2);
									if(strTemp.trim().equalsIgnoreCase("Travel Allowance")){
										strExpenditureFields[i++]=dbLabelBean.getLabel("label.global.travelallowance",strsesLanguage);
									}
									else if(strTemp.trim().equalsIgnoreCase("Daily Charges")){
										strExpenditureFields[i++]=dbLabelBean.getLabel("label.global.dailycharges",strsesLanguage);
									}
									else if(strTemp.trim().equalsIgnoreCase("Contingencies")){
										strExpenditureFields[i++]=dbLabelBean.getLabel("label.global.contigencies",strsesLanguage);
									}
									else if(strTemp.trim().equalsIgnoreCase("Any Other Expenditure")){
										strExpenditureFields[i++]=dbLabelBean.getLabel("label.createrequest.anyotherexpenditure",strsesLanguage);
									}else{
										strExpenditureFields[i++] = strTemp;
									}
									//strExpenditureFields[i++] = rs.getString(2);
								}
								rs.close();
							%>
<%
//added by manoj chand on 09 oct to show save foreign exchange

	String strTACurrency2="-1",strRec="no",strEntPerDay2="",strTotalTourDays2="",strTotalExpId2="",strTotalForex="",strExchangeRate="",strTotalinBase="";
	int count=0,sno=0;
	CallableStatement objCstmt	    =  null;
	Connection objCon               =  dbConBean.getConnection(); 
	objCstmt             =  objCon.prepareCall("{?=call SPG_GET_TRAVEL_EXPENDITURE_DETAILS(?,?,?)}");        
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setString(2,strTravel_Id);
	objCstmt.setString(3,"D");
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
	strTotalinBase=rs3.getString("TOTAL");
%>
							<tr id="rowid<%=count %>">
							<td align="center" class="label5" ><span class="spn"><%=++sno %></span></td>
							<td height="30" align="left" valign="top" class="label5">
							<select	name="expCurrency" id="expCurrency" class="textBoxCss" onchange="fun_exchangerate(this);">
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
								</select> <script language="javascript">
								document.getElementsByName("expCurrency")[<%=count%>].value="<%=strTACurrency2%>";  
	                         </script>
	                         </td>
							<td height="30" align="left" valign="top" class="label5">
								<input name="entitlement"  id="entitlement1" type="text" class="textBoxCss2" value="<%=strEntPerDay%>" size="4" maxlength="7"
								onKeyUp="return test1(this, 10, 'n')" onChange="check1();"	align="right" />
							</td>
								
							<td height="30" align="left" valign="top" class="label5">
							<input name="tourDays" id="tourDays1" type="text" class="textBoxCss2" value="<%=strTotalTourDays%>" maxlength="3"
							size="1" align="right"	onKeyUp="return test1(this, 3, 'n')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label5">
								<input name="entitlement2"  id="entitlement2" type="text" class="textBoxCss2" value="<%=strEntPerDay2%>" size="4" maxlength="7"
								onKeyUp="return test1(this, 10, 'n')" onChange="check1();"	align="right" />
							</td>
								
							<td height="30" align="left" valign="top" class="label5">
							<input name="tourDays2" id="tourDays2" type="text" class="textBoxCss2" value="<%=strTotalTourDays2%>" maxlength="3"
							size="1" align="right"	onKeyUp="return test1(this, 3, 'n')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label5">
							<input name="contingencies" id="contingencies1" type="text" class="textBoxCss2"	value="<%=strTotalExpId%>" maxlength="8"
							size="6" align="right"	onKeyUp="return test1(this, 20, 'n.')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label5">
							<input name="contingencies2" id="contingencies2" type="text" class="textBoxCss2"	value="<%=strTotalExpId2%>" maxlength="8"
							size="6" align="right"	onKeyUp="return test1(this, 20, 'n.')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label5">
							<input name="totalForex" id="totalforex" type="text" class="textBoxCss2" value="<%=strTotalForex%>" 
							size="6" align="right" onKeyUp="return test1(this, 20, 'n.')" onChange="check1();" />
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
							<select	name="expCurrency" id="expCurrency" class="textBoxCss" onchange="fun_exchangerate(this);">
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
								<script language="javascript">
							 		        document.frm.expCurrency.value="<%=strBaseCur%>";
	                         </script>
	                         </td>
							<td height="30" align="left" valign="top" class="label5">
								<input name="entitlement"  id="entitlement1" type="text" class="textBoxCss2" value="0" size="4" maxlength="7"
								onKeyUp="return test1(this, 10, 'n')" onChange="check1();"	align="right" />
							</td>
								
							<td height="30" align="left" valign="top" class="label5">
							<input name="tourDays" id="tourDays1" type="text" class="textBoxCss2" value="0" maxlength="3"
							size="1" align="right"	onKeyUp="return test1(this, 3, 'n')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label5">
								<input name="entitlement2"  id="entitlement2" type="text" class="textBoxCss2" value="0" size="4" maxlength="7"
								onKeyUp="return test1(this, 10, 'n')" onChange="check1();"	align="right" />
							</td>
								
							<td height="30" align="left" valign="top" class="label5">
							<input name="tourDays2" id="tourDays2" type="text" class="textBoxCss2" value="0" maxlength="3"
							size="1" align="right"	onKeyUp="return test1(this, 3, 'n')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label5">
							<input name="contingencies" id="contingencies1" type="text" class="textBoxCss2"	value="0" maxlength="8"
							size="6" align="right"	onKeyUp="return test1(this, 20, 'n.')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label5">
							<input name="contingencies2" id="contingencies2" type="text" class="textBoxCss2"	value="0" maxlength="8"
							size="6" align="right"	onKeyUp="return test1(this, 20, 'n.')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label5">
							<input name="totalForex" id="totalforex" type="text" class="textBoxCss2" value="0.00" 
							size="6" align="right" onKeyUp="return test1(this, 20, 'n.')" onChange="check1();" />
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
							<select	name="expCurrency" id="expCurrency" class="textBoxCss" onchange="fun_exchangerate(this);">
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
								<input name="entitlement"  id="entitlement1" type="text" class="textBoxCss2" value="0" size="4" maxlength="7" 
								onKeyUp="return test1(this, 10, 'n')" onChange="check1();"	align="right" />
							</td>
								
							<td height="30" align="left" valign="top" class="label5">
							<input name="tourDays" id="tourDays1" type="text" class="textBoxCss2" value="0" maxlength="3"
							size="1" align="right"	onKeyUp="return test1(this, 3, 'n')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label5">
								<input name="entitlement2"  id="entitlement2" type="text" class="textBoxCss2" value="0" size="4" maxlength="7" 
								onKeyUp="return test1(this, 10, 'n')" onChange="check1();"	align="right" />
							</td>
								
							<td height="30" align="left" valign="top" class="label5">
							<input name="tourDays2" id="tourDays2" type="text" class="textBoxCss2" value="0" maxlength="3" 
							size="1" align="right"	onKeyUp="return test1(this, 3, 'n')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label2">
							<input name="contingencies" id="contingencies1" type="text" class="textBoxCss2"	value="0" maxlength="8"
							size="6" align="right"	onKeyUp="return test1(this, 20, 'n.')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label5">
							<input name="contingencies2" id="contingencies2" type="text" class="textBoxCss2"	value="0" maxlength="8"
							size="6" align="right"	onKeyUp="return test1(this, 20, 'n.')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label5">
							<input name="totalForex" id="totalforex" type="text" class="textBoxCss2" value="0.00" 
							size="6" align="right" onKeyUp="return test1(this, 20, 'n.')" onChange="check1();" />
							</td>
							<td height="30" align="left" valign="top" class="label5">
						     <input name="exRate" id="exrate" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n.')"  value="0.000000" size="6" align="right" disabled="disabled" />
						   </td>
						   <td height="30" align="left" valign="top" class="label5">
						     <input name="totalInr" id="totalinr" type="text" class="textBoxCss2" onChange="check1();" onKeyUp="return test1(this, 20, 'n.')"  value="0.00" size="8" align="right" />
						   </td>
						   <td height="30" align="left" valign="top" class="label5">
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
	                <td colspan="12" valign="top" bgcolor="#FFFFFF" class="" style="border-style: solid;border-color:#F0F0F0;border-collapse: collapse; ">
					   <table width="100%" border="0" cellpadding="0" cellspacing="0">
	                     <tr>
	                       <td height="20" valign="bottom" class="label2" colspan="2"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%> / <%=dbLabelBean.getLabel("alert.global.reasonforcontigencies",strsesLanguage)%></td>
	                       <%if(strSMPSiteflag.equalsIgnoreCase("Y")){ %>
	                       <td height="20" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage) %></td>
	                       <td height="20" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.createrequest.totalfare",strsesLanguage) %></td>
	                       <%} %>
	                     </tr>
	                     <tr>
	                       <td height="30" valign="top" >
						     <textarea name="expRemarks" cols="85" rows="3" class="textBoxCss" onKeyUp="return test1(this, 100, 'all')" ><%=strExpRemarks%></textarea>
						   </td>
						   <%if(strSMPSiteflag.equalsIgnoreCase("Y")){ %>
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
					</tr>
					<% 
					if (strSHOW_BUD_INPUT.equalsIgnoreCase("Y")) {
					%>
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
					<tr>
					<td colspan="2" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff">

						<table width="100%" cellspacing="0" cellpadding="0"
							bgcolor="#FFFFFF" border="0">
							<tr>
								<td class="label1" colspan="4"><%=dbLabelBean.getLabel("label.global.budgetactualdetails",strsesLanguage)%><span class="starcolour">*</span></td>
								<td class="label2" ><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
							</tr>
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
								<td rowspan="2" valign="top"><textarea name="budgetRemarks"
									cols="58" rows="3" class="textBoxCss"
									onKeyUp="return test1(this, 100, 'all')"><%=str_EXP_REMARKS.trim()%></textarea>
								</td>
							</tr>
							<tr>
								<td bgcolor="#FFFFFF" class="label2" nowrap="nowrap"><%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage)%></td>
								<td><input type="text" name="AvailBud" size="10"
									onChange="" onKeyUp=""
									class="textBoxCss" maxlength="15" readonly="readonly"> <script
									language="javascript">
                     		   document.frm.AvailBud.value="<%=dbl_AVAIL_BUDGET%>";
                    		 </script></td>
								<td bgcolor="#FFFFFF" class="label2" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.estimatedexpenditure",strsesLanguage)%></td>
								<td><input type="text" name="EstExp" size="10"
									onChange="check1();" onKeyUp="return test1(this, 15, 'n')"
									class="textBoxCss" maxlength="15"> <script
									language="javascript">
                     		   document.frm.EstExp.value="<%=dbl_EST_EXP%>";
                    		 </script></td>
							</tr>
						</table>
						</td>
					</tr>
					<%}%>
					<!--Added by sachin 3/15/2007 start-->
					<%
						if (strBillingSite != null && strBillingSite.equals("0")) {
					%>
					<script language="JavaScript">
									document.frm.elements[6].readOnly = true;
									document.frm.elements[7].readOnly = true;
									document.frm.elements[8].readOnly = true;
								</script>
					<%
						} else if (strBillingSite != null && !strBillingSite.equals("-1")
								&& !strBillingSite.equals("0")) {
					%>
					<script language="JavaScript">
									document.frm.elements[6].readOnly = false;
									document.frm.elements[7].readOnly = false;
									document.frm.elements[8].readOnly = false;
								</script>
					<%
						} else if (strBillingSite != null && strBillingSite.equals("-1")) {
					%>
					<script language="JavaScript">
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
					<script language="JavaScript">
									document.frm.elements[6].readOnly = false;
									document.frm.elements[7].readOnly = false;
									document.frm.elements[8].readOnly = false;
								</script>
					<%
						}
					%>
					<!--Added by sachin 3/15/2007 end-->

					<!-- -adde by shiv on 31 oct 2009            -->


					<%
					//change manoj
						String strforPriceDesicion = "";
						strSql = "Select isnull(DOM_LOCAL_AGENT,'') as DOM_LOCAL_AGENT From m_site where site_id="
								+ strSiteId + " and status_id=10 ";
						rs = dbConBean.executeQuery(strSql);

						while (rs.next()) {
							strforPriceDesicion = rs.getString("DOM_LOCAL_AGENT");

						}
						rs.close();
					%>


					<tr>
						<td colspan="2">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td colspan="1" width="48%" bgcolor="#FFFFFF">&nbsp;</td>
								<%
									if (strforPriceDesicion.equalsIgnoreCase("y")) {
								%>
					<!-- change caption for checking pricing through alternate source on 18 Oct 2011 by manoj chand -->
								<td colspan="1" width="52%" bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.proposetobuyticketsfromnonmatasource",strsesLanguage)%> &nbsp;&nbsp;&nbsp;<input type="radio" name="tkflyes"
									onclick="showdiv('y')" checked="checked" value="y" /> <%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %> <input
									type="radio" name="tkflyes" onclick="showdiv('n')" value="n" />	<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage) %>
									<br><i><%=dbLabelBean.getLabel("label.global.nonmatasource",strsesLanguage) %></i>
								</td>
								<%
									}
								%>

							</tr>


							<%
								String strText = "display:none";
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
							<tr>
								<td colspan="1" width="48%" bgcolor="#FFFFFF" height="70">&nbsp;
								</td>
								<td bgcolor="#FFFFFF">
								<%
									if (strforPriceDesicion.equalsIgnoreCase("y")) {
								%>
								<div id="showdiv" style="<%=strText%>">

								<table width="80%" border="0" cellpadding="0" cellspacing="1">
									<TR>
										<TD bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.airline",strsesLanguage) %></TD>
										<TD bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage) %></TD>
										<TD bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.global.localprice",strsesLanguage) %></TD>
										<TD bgcolor="#FFFFFF" class="label2"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %></TD>
									</TR>
									<TR>
										<TD bgcolor="#FFFFFF" valign="top"><input type="text"
											name="airline" size="8" maxlength="50" class="textBoxCss"
											onKeyUp="return test1(this, 50, 'cn')"></TD>
										<script language="javascript">
	                         		   document.frm.airline.value="<%=strAirLineName.trim()%>";
	                        		 </script>
										<TD bgcolor="#FFFFFF" valign="top"><select
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
	                         </script></TD>
										<TD bgcolor="#FFFFFF" valign="top"><input type="text"
											name="localprice" size="8"
											onKeyUp="return test1(this, 10, 'n')" class="textBoxCss2"
											align="right"></TD>

										<script language="javascript"> 
	                         		   document.frm.localprice.value="<%=strAmount.trim()%>";
	                        	 </script>

										<TD bgcolor="#FFFFFF" valign="top"><textarea
											name="pricingRemarks" cols="28" rows="3" class="textBoxCss"
											class="textBoxCss" onKeyUp="return test1(this, 300, 'all')"><%=strRemarks.trim()%></textarea>
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



					<td colspan="2" align="left" bgcolor="#FFFFFF" class="newformbot">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="bottom" bgcolor="#FFFFFF" class="newformbot"></td>

							<td align="left" bgcolor="#FFFFFF" class="newformbot"><a
								href="#"
								onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravel_Id%>&err=0&travel_type=D&whichPage=T_TravelDetail_Dom_Forex.jsp&targetFrame=no','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')"
								title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>"><img src="images/AttachFile.gif?buildstamp=2_0_0"
								width="94" height="24" border="0" /></a></td>
							<td align="right" bgcolor="#FFFFFF" class="newformbot"><input
								type="button" class="formButton" name="back" value="<%=dbLabelBean.getLabel("button.global.back",strsesLanguage)%>"
								onClick="submitBack();"> <input type="submit"
								class="formButton" name="saveExit" value="<%=dbLabelBean.getLabel("button.global.saveandexit",strsesLanguage)%>"
								onClick="return checkData(this.form,'Exit');" /> <input
								type="submit" class="formButton" name="save" value="<%=dbLabelBean.getLabel("button.global.save",strsesLanguage)%>"
								onClick="return checkData(this.form,'Save')" /> <input
								type="submit" class="formButton" name="saveProceed"
								value="<%=dbLabelBean.getLabel("button.global.submittoworkflow",strsesLanguage)%>"
								onClick="return checkData(this.form,'Proceed');" /></td>


							<input type="hidden" name="matapricecomp"
								value="<%=strforPriceDesicion%>" />

						</tr>



						<tr>
					</table>
					</td>
					</tr>
				</table>
				</td>
				<td width="15" background="images/index_03.png?buildstamp=2_0_0"></td>
			</tr>


			<tr>
				<td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img
					src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
				<td height="20" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
				<td width="15" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
			</tr>
		</table>
		</td>
	</tr>





</table>







<input type="hidden" name="travelId" value="<%=strTravel_Id%>" /> <!--  HIDDEN FIELD  -->
<input type="hidden" name="travelReqId" value="<%=strTravel_Req_Id%>" />
<!--  HIDDEN FIELD  --> <input type="hidden" name="travellerId"
	value="<%=strTravellerId%>" /> <!--  HIDDEN FIELD  --> <input
	type="hidden" name="travellerSiteId" value="<%=strTravellerSiteId%>" />
<!--  HIDDEN FIELD  --> <input type="hidden" name="flag1" value="" /><!--  hidden field -->
<input type="hidden" name="interimId" value="<%=strInterimId%>"><!--  HIDDEN FIELD  -->
<input type="hidden" name="hiddsiteid" value="<%=strSiteId %>" />
<input type="hidden" name="site" value="<%=strSiteId %>" />

<input type="hidden" name="basecur" value="<%=strBaseCur %>"/>
<INPUT TYPE="hidden" name="refreshFlag" value="n" />
<input type="hidden" name="travelreqno" value="<%=strTravelReqNo %>"/>
<input type="hidden" name="checkMsg" value='<%=request.getParameter("message")%>' />
<input type="hidden" name="flagSave" value="<%=strFlagSave %>" />
<input type="hidden" name="hdsmpsiteflag" value="<%=strSMPSiteflag %>"/>
</form>
</body>
</html>