	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				        :Shiv sharma 
	 *Date of Creation 	    :02-Feb-08 
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			        :STARS
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 		     	:This is first jsp file  for create the Group  Travel Requsition
	 *Modification 	    	    :added code for changing Expenditure validation Criteria  on  28-Apr-08  by shiv Sharma 
	                            Added a travel type on domestic group travel  development on 02-Jul-08 by shiv sharma       
								Added a text for showing to user that no traveler is exist in his traveler list on 15 jul 2009
							             
	 *Reason of Modification:
	 *Date of Modification  :
	 *Modified By	  :		Vaibhav on jun 23 2010 to run page properly when compatibility setting not checked
	 *Editor				:Editplus
	 
	 *Modified By       : Manoj Chand
	 *Modification      : Add check for Currency Exchange Rate 
	 *Modification Date : 07 feb 2011
	 
	 *Modified By       : Manoj Chand
	 *Modification      : Add link for intermediate journey and accomodation required in international group/guest request
	 *Modification Date : 23 sep 2011
	 
	 *Modification				:Show a message when transit house is selected  
	 *Modified by				:Manoj Chand
	 *Date of Modification		:24 Apr 2012
	 
	 *Modification				:Multilingual functionality added
	 *Modified by				:Manoj Chand
	 *Date of Modification		:24 May 2012
	 
	 *Modification				:Adding Cost centre combobox for smp site.
	 *Modified by				:Manoj Chand
	 *Date of Modification		:03 August 2012
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :01 Feb 2013
	 *Description			:IE Compatibility Issue resolved
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :04 June 2013
	 *Description			:Change in query which fill the site combobox.
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :12 July 2013
	 *Description			:display alert in case selected site does not contains workflow according to user workflow number.
	 
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
	<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	</head>
	<!-- all include files with sesstion variables -->
	<%-- Import Statements  --%>
	
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>

	
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
	<%@ include file="M_InsertProfile.jsp"  %>
	
	<!-- script used in files  -->
	<link href="style/jquery-ui-1.9.2.css?buildstamp=2_0_0" rel="stylesheet" type="text/css"/>
	<script language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
<!-- 	<SCRIPT language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></SCRIPT>  -->
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="ScriptLibrary/popcalendar.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="ScriptLibrary/popcalender1.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></SCRIPT>
	<script type="text/javascript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script> 
    <script type="text/javascript" src="ScriptLibrary/jquery-ui-1.9.2.js?buildstamp=2_0_0"></script> 
    <script type="text/javascript" src="ScriptLibrary/jquery-ui-autocomplete.js?buildstamp=2_0_0"></script>
    <style>
	    td.viewDetailLink a {
			padding:0; 
			font-family:Verdana, Arial, Helvetica, sans-serif; 
			font-size: 10px; 
			font-weight:normal; 
			color:#d62234;
		}
    </style>
    
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
	
	$(function() {
		// set placeholder on page load
		if ($.browser.msie && $.browser.version <= 9) {
			$('[placeholder]').focus(function() {
				var input = $(this);
				if (input.val() == input.attr('placeholder')) {
					input.val('');
					input.css('color', '#000000');
				} else {
					input.css('color', '#000000');
				}
			}).focus();
			$('[placeholder]').blur(function() {
				var input = $(this);
				if (input.val() == '' || input.val() == input.attr('placeholder')) {
					input.css('color', '#7a7a7a');
					input.val(input.attr('placeholder'));
				} else {
					input.css('color', '#000000');
				}
			}).blur();
	
			$('[placeholder]').parents('form').submit(function() {
				$(this).find('[placeholder]').each(function() {
					var input = $(this);
					if (input.val() == input.attr('placeholder')) {
						input.val('');
					}
				});
			});
		}
	});
	
	$("select#cancelledTravelReq").live("change", function() {
		var cancelledReqId = $("select#cancelledTravelReq option:selected").val();
		var userId = '<%=Suser_id%>';
			
		if(cancelledReqId != "0") {
			$("table#canReqDetailTbl").remove();
			$('<table width="73px" border="0" align="left" cellspacing="0" cellpadding="0" id="canReqDetailTbl" style="margin-top:4px;"><tr><td class="viewDetailLink"><a href="#" onClick="viewCancelledReqDetail('+cancelledReqId+', '+userId+')">View Detail</a></td></tr></table>').insertBefore('table#linkCanReqTbl');
		} else {
			$("table#canReqDetailTbl").remove();
		}
	});
	
	function viewCancelledReqDetail(cancelledReqId, userId) {
		window.open("Group_T_TravelRequisitionDetails.jsp?purchaseRequisitionId="+cancelledReqId+"&traveller_Id="+userId+"&travelType=I","LinkedCancelledRequest", "scrollbars=yes,resizable=yes,width=975,height=550");
	}
	
		// code added  on 07-Jun-07 by shiv for changing date selector open   
	         function button_onclick(obj) 
		    {
			             popUpCalendar(obj,obj,"dd/mm/yyyy");
			}

	         function button_onclick1(obj) {
		         if(checkStayType() == 'Y')
			        popUpCalendar1(obj,obj,"dd/mm/yyyy");
		         else
			         alert('<%=dbLabelBean.getLabel("alert.global.staytype",strsesLanguage)%>');
			  }

function checkStayType(){
	//alert(document.frm.transit.value);
	if(document.frm.hotel.value == '0')
		return 'N';
	else
		return 'Y';
}
			 
	        // code added  on 07-Jun-07 by shiv for changing date selector close
	
//code added by manoj chand on 14 dec 2012 to blink the add multiple currency message.
/*function doBlink() {
	var blink = document.all.tags("BLINK");
	for (var i=0; i<blink.length; i++)
		blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : ""; 
}

function startBlink() {
	if (document.all)
		setInterval("doBlink()",800);
}
window.onload = startBlink;	*/
	
	///code used for display  age of users using Ajax 
	
	 var XMLHttpRequestObject = false;
				function ajaxObject()
				{
					if(window.XMLHttpRequest)
					{  
					  XMLHttpRequestObject = new XMLHttpRequest();
					  //XMLHttpRequestObject.overrideMimeType("text/xml");  
					}
					else if(window.ActiveXObject)
					{
					  try
					  {
					    XMLHttpRequestObject = new ActiveXObject("MSXML2.XMLHttp");
					  }catch(e)
					  {
					    try
					    {
					      XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
					    }
					    catch(e)
					    {
					      XMLHttpRequestObject = false;
					    }
					  }  
					}
				}
			
	//var url = "AjaxMaster.jsp?userAge="; // The server-side script
	 
	function FindAge(frm) {
	   ajaxObject(); 
	        
	    var userAge = document.getElementById("passport_DOB").value;
	
		//alert(userAge);
	
	    if (userAge!='' && userAge!='dd/mm/yyyy')
	
		  {
			   //alert("hi==");
			  var url = "AjaxMaster.jsp?userAge="+userAge;	
	      // XMLHttpRequestObject.open("GET", url, true);
				XMLHttpRequestObject.open("Post",url,true);
				XMLHttpRequestObject.onreadystatechange =   function()
				    {    
				   	    if(XMLHttpRequestObject.readyState == 4)
				  	        {   	  
				   	        if(XMLHttpRequestObject.status == 200)
				   	               {
				   	                // var xmlDocument = XMLHttpRequestObject.responseXML;
									var message = XMLHttpRequestObject.responseXML;//.getElementsByTagName("message");
				   	                  //alert("xmlDoc==="+message.xml);
									    var optValue = message.getElementsByTagName("message")[0];
										  if (optValue.firstChild.data<0)
									      {
											    // alert("Please fill the correct Date of birth.");
				                                          //frm.age.value="";
	                                         	     document.frm.passport_DOB.value ="";
													 	  //frm.passport_DOB.focus();
												  document.frm.age.value ="";
	
										  }
										  
										  else{
								         document.frm.age.value=optValue.firstChild.data;
										  }
								   }
				   	        }
				   			 else{			 	   			 
				 			   }
				   	
					}
	    }
		else
		{
		return true;	 
		}
	    XMLHttpRequestObject.send(null);
	}
	
	function MM_openBrWin(theURL,winName,features)
	 { 
			   window.open(theURL,winName,features);
	 }
	
	//added by manoj
	
	function checkCurrPreference(flag){
				var x=flag;
				var curPref = $("#expCurrency option:selected").val();
				var urlParams = "strFlag=CheckCurrencyId&currency="+curPref;
				$.ajax({
		            type: "post",
		            url: "AjaxMaster.jsp",
		            data: urlParams,
		            success: function(result){
		            var res = result.trim();
		            if(res == 'N'){
			             alert('<%=dbLabelBean.getLabel("label.global.exchangeratefor",strsesLanguage)%> '+curPref.trim()+' <%=dbLabelBean.getLabel("label.createrequest.isnotdefinedcontactstarsadmin",strsesLanguage)%>');
			             return false;
		             }else{
		            	 	NextPage(this.form,x);
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
					if(e.val()!= undefined && jQuery.trim(e.val())!='' && jQuery.trim(e.val())!='0' && jQuery.trim(e.val())!='0.00' && document.frm.expRemarks.value==''){
						alert('<%=dbLabelBean.getLabel("alert.global.remarksforcontingenciesorotherexpenditure",strsesLanguage)%>');
						document.frm.expRemarks.focus();
						flag=false;
						return false;
					}
					if(f.val()!= undefined && jQuery.trim(f.val())!='' && jQuery.trim(f.val())!='0' && jQuery.trim(f.val())!='0.00' && document.frm.expRemarks.value==''){
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



	
	function NextPage(frm,flag)
			{
				var var2=save(frm,'next');
				if(var2==false){
					return false;
				} 
					 
				 if (flag==2){
		            alert('<%=dbLabelBean.getLabel("alert.createrequest.clickaddtravelerbutton",strsesLanguage)%>'); 
					return false;
				  }
			
			  		if(document.frm.firstName.value!='' || document.frm.lastName.value!=''){
				        if(confirm('<%=dbLabelBean.getLabel("alert.global.proceed",strsesLanguage)%>\n'+'<%=dbLabelBean.getLabel("label.createrequest.addupdate",strsesLanguage)%>'))
							{
				                 document.frm.action="Group_itinerary_details.jsp";
				                 document.frm.submit();
							}
							else{
						      return;
							}
				    }/*else{
				    	   document.frm.action="Group_itinerary_details.jsp?UpFlag=abc";
				    	   alert('3--->'+document.frm.action);
				           document.frm.submit();
				     }*/
			  		//alert('2--->'+document.frm.action);
	     	  document.frm.submit();
			}
	
	function ExitPage(frm)
			{ 
			    if(document.frm.firstName.value!='' || document.frm.lastName.value!=''){
						if(confirm('<%=dbLabelBean.getLabel("alert.global.exit",strsesLanguage)%>'))
						{
			             document.frm.action="T_TravelRequisitionList.jsp?travel_type=INT";
					    document.frm.submit();
						}
						else
						{
					      return false;
						}
			    }else
					{	 document.frm.action="T_TravelRequisitionList.jsp?travel_type=INT";
		                 document.frm.submit();
		   			}
			}
			
	function checkDate(form1,firstDate,secondDate,firstDateName,secondDateName,message1,message2)
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
			
	function save(f1,var_save){
	f1 = document.forms[0];
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
				alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>');
				f1.nameOfAirline .focus();
				return false;
			}
			
//added by manoj chand on 20 sep 2011 to add validation
		if(f1.hotel.value == "1" || f1.hotel.value=="2")
		{
		if(f1.place.value == "")
		{
			alert('<%=dbLabelBean.getLabel("alert.global.preferredplace",strsesLanguage)%>');
			f1.place.focus();
			return false;
		} 		
		if(f1.checkin.value == "")
		{
			alert('<%=dbLabelBean.getLabel("alert.global.checkindate",strsesLanguage)%>');
			f1.checkin.focus();
			return false;
		}
		if(f1.checkout.value == "")
		{
			alert('<%=dbLabelBean.getLabel("alert.global.checkoutdate",strsesLanguage)%>');
			f1.checkout.focus();
			return false;
		}
		if(f1.hotel.value == "1")
		{
			if(f1.budget.value=="" || f1.budget.value=="0")
			{
			  alert('<%=dbLabelBean.getLabel("alert.global.budget",strsesLanguage)%>');
			  f1.budget.focus();
			  return false;
			}
		}
	}
 
 	if(f1.hotel.value == "0")
	  {
	 
		if (f1.otherComment.value=='')
		  {  
			alert('<%=dbLabelBean.getLabel("alert.global.enterremarksifaccomodationnotrequired",strsesLanguage)%>');
		      f1.otherComment.focus();
		     return false;
		  }

	}

	var todayDate  =  f1.todayDate.value;  
    var depDate    =  f1.depDate.value;
    //var returnDate =  f1.returnDate.value;
    var flag = checkDate(f1,todayDate,depDate,f1.todayDate,f1.depDate,'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
    if(flag == false)
  	  return flag;
	/*if(returnDate != null && returnDate != '')
	{
 	  flag = checkDate(f1,todayDate,returnDate,f1.todayDate,f1.returnDate,'Departure Date of Return Journey can not be smaller than the Today\'s Date ','no');
      if(flag == false)
  	    return flag; 
	  flag = checkDate(f1,depDate,returnDate,f1.depDate,f1.returnDate,'Departure Date of Return Journey can not be smaller than the Departure Date of Forward Journey','no');
      if(flag == false)
  	    return flag; 
	}*/

    if(f1.hotel.value == "1" || f1.hotel.value=="2")
    { 
		var checkInDate   = f1.checkin.value;
		var checkOutDate  = f1.checkout.value;
		flag =  checkDate(f1,todayDate,checkInDate,f1.todayDate,f1.checkin,'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthantodaydate",strsesLanguage)%> ','no');
		if(flag == false)
		  return flag; 
		flag =  checkDate(f1,todayDate,checkOutDate,f1.todayDate,f1.checkout,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotsmallerthantodaydate",strsesLanguage)%> ','no');
		if(flag == false)
		  return flag; 
		flag =  checkDate(f1,checkInDate,checkOutDate,f1.checkin,f1.checkout,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotsmallerthancheckindate",strsesLanguage)%>','no');
		if(flag == false)
		  return flag; 
		flag =  checkDate(f1,depDate,checkInDate,f1.depDate,f1.checkin,'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthandeparturedate",strsesLanguage)%>','no');
		if(flag == false)
		  return flag; 
		//flag =  checkDate(f1,checkOutDate,returnDate,f1.returnDate,f1.checkout,'CheckOut Date can not be grater than the Departure Date ','no');
		//if(flag == false)
		  //return flag; 
	}
		
  
	      var flag1 = checkDate(f1,todayDate,depDate,f1.todayDate,f1.depDate,'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
	      if(flag1 == false){
	  	   return flag1;
	  	   }else{     
	  	   			  document.frm.whatAction.value ="itenupdate";
	  	   			  document.frm.saveflag.value=var_save;
	  	   			  if(var_save=='save'){
	  	              document.frm.submit();
	  	   			  }
	  	   }
	  
	}
	
	
	
	function deleteConfirm()
	{
			if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage)%>'))
				return true;
			else
			   return false;
	}
	
	 function getDivisonID()
		{
		//added by manoj chand on 03 august 2012
		 if(document.frm.costcentre!=null || document.frm.costcentre!=undefined){
			  document.frm.costcentre.value="0";
			  }
		   
		   document.frm.action="Group_T_IntTrv_Details.jsp";  
		   document.frm.designation.value="-1";
		   document.frm.submit();
	    }
	
	function check1()
	   {
		var total=fun_calculate_GrandTotal();
    	$('#grandTotalForexinr').val(total);
	}

	
	//function added by manoj chand on 12 oct 2012
	function test3(obj, length, str)
	{
		if(str=='n.'){
			upToTwoDecimal(obj);
			}
		charactercheck(obj,str);
		limitlength(obj, length);
		spaceChecking(obj);
		calculate(obj);
		var total=fun_calculate_GrandTotal();
    	$('#grandTotalForexinr').val(total);
	}
	
	function test1(obj1, length, str)
	 {	
	     	var obj;
			if(obj1=='firstName')
				{
				obj = document.frm.firstName;
				}	
			if(obj1=='lastName')
				{
				obj = document.frm.lastName;
				}
			if(obj1=='passportNo')
				{
					obj = document.frm.passportNo;
					upToTwoHyphen(obj);
				}
			if(obj1=='nationality')
			{
				obj = document.frm.nationality;
			}
			if(obj1=='passport_issue_place')
				{
					obj = document.frm.passport_issue_place;
				}
			if(obj1=='age') 
				{
					obj = document.frm.age;
				}
				
	
				if(obj1=='expRemarks')
				{
					obj = document.frm.expRemarks;
					upToTwoHyphen(obj);
				}
				// data checks for itenary details--by shiv 
				
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
				if(obj1=='nameOfAirline')
				{
					 obj = document.frm.nameOfAirline;
				}
				if(obj1=='place')
				{
					 obj = document.frm.place;
				}
				if(obj1=='budget')
				{
					 obj = document.frm.budget;
					 zeroChecking(obj);
				}  
				if(obj1=='otherComment')
				{
					 obj = document.frm.otherComment;
					 upToTwoHyphen(obj);
				}
	             charactercheck(obj,str);
	        	limitlength(obj, length);
		        //zeroChecking(obj); //function for checking leading zero and spaces
		        spaceChecking(obj);
	 }

	
	function  checkData(frm,whatAction,smpflag,showflag)
	{
			 if(frm.site.value == '-1')
				{
					alert('<%=dbLabelBean.getLabel("alert.global.unitname",strsesLanguage)%>'); 
		            frm.site.focus();
					return false;
				}
//added by manoj chand on 03 august 2012 to show alert for costcentre
				if(smpflag=='Y' && showflag=='y'){
					if(frm.costcentre.value=='0'){
					alert('<%=dbLabelBean.getLabel("alert.global.costcentre",strsesLanguage)%>');
		            frm.costcentre.focus();
					return false;
					}
				}
				
			if(frm.firstName.value == '')
				{
					alert('<%=dbLabelBean.getLabel("alert.global.firstname",strsesLanguage)%>');
		            frm.firstName.focus();
					return false;
				}

	        // if(frm.lastName.value == '')
			//	{
			//		alert("Please fill the Last Name.");
		    //      frm.lastName.focus();
			//		return false;
			//	} 
		   if(frm.designation.value == '-1')
				{
					alert('<%=dbLabelBean.getLabel("alert.global.designation",strsesLanguage)%>');
		            frm.designation.focus();
					return false;
				}
				
			if(frm.passport_DOB.value == '' || frm.passport_DOB.value == 'dd/mm/yyyy')
				{
			       alert('<%=dbLabelBean.getLabel("alert.global.dob",strsesLanguage)%>');
				   frm.passport_DOB.focus();
				   return false;  
				} 
	
				 if(frm.Gender.value == '-1')
				{
					alert('<%=dbLabelBean.getLabel("alert.global.gender",strsesLanguage)%>');
		            frm.Gender.focus();
					return false;
				}
				
			if(frm.passportNo.value == '')
				{
			       alert('<%=dbLabelBean.getLabel("alert.global.passportnumber",strsesLanguage)%>');
				   frm.passportNo.focus();
				   return false;  
				}
			if(frm.age.value == '')
				{
			      // alert("Please fill the Age of traveler.");
				   frm.age.focus();
				   return false;  
				}
				
			if(frm.age.value <0)
				{
			       alert('<%=dbLabelBean.getLabel("alert.global.correctdob",strsesLanguage)%>');
				   frm.age.value="";
				  //frm.passport_DOB.focus();
				   return false;  
				}
			
	
			 var flag_DOB =  checkDOB(frm);
				 
			 if (flag_DOB==false){
							return false;
				}
	
		   	 var flag_passpt = CheckPassportInfo_Group(frm);
	 		 
					if (flag_passpt==false)
						     {
								return false;
							}
	            if (flag_passpt==true && flag_DOB==true)
						     {
									//var flag =gridCheck();
									//change by manoj chand on 12 oct 2012
									var flag=checkValue(); 
									 if(flag==true) 	 {
									 document.frm.submit(); 
									}
								if (flag==false){ 
									  return false;
								   }
						    }
					if(whatAction=="update") {
			                    document.frm.whatAction.value ="update" ;
							}
	}
	
	function ageClear()
	{
	 
	  document.frm.age.value ="" ;
	}
	
	//function added by manoj chand on 21 feb 2012 to replace multiple spaces with single space
	function removeSpaces(str) {
		str = str.replace(/\s{2,}/g,' ');
	 	return str;
	}
	
	</script>
	<style type="text/css">
	.mytable .prototype {
				display:none;
			}
	</style>
	<%
	request.setCharacterEncoding("UTF-8");
	//Global Variables declared and initialized
	int intSerialNo=1; 
	
	String strSql                                           =  null;              // String for Sql String
	ResultSet rs,rs1,rs2,rs3                              =  null;              // Object for ResultSet
	String DOB											   ="";
	String strDOfIssue								   ="";
	String strDOExpiry								   ="";
	String strEntPerDay							   ="";
	String strTotalTourDays                        ="";
	String strTotalExpId                               ="";
	String strTotalAmount							   ="0.00";
	
	//request  releated variables 
	String strTravelReqId							  =  "";
	String strTravelId				                      =  "";
	String strTravelReqNo                          =  "";  
	
	String strTACurrency                           ="USD";
	String	strG_userid						          ="";
	String	strFirstName_List		              ="";
	String	strLastName_List				     ="";
	String	strDesigantion_List			    ="";
	String   strDateOfBirth_List			    ="";
	String	strAge_List							="";
	String	strGender_List					="";
	String   strMealPref_list					="";
	String	strTotalForex_list				="";
	String   strPassortNo_list				="";
	String   strNationality_list				="";
	String	strDateofIssue_list				="";
	String	strPlacesofIssue_list         ="";
	String	strDateofExpiry_list			   ="";
	String	strECNR_list					   ="";
	String	strVisaReqiured_list		    ="";
	String strVisaReq                            ="";
	String strSex=""; 
	String strCurrency                         =""; 
	String strGender						   	   ="";
	String strEcnr                                ="";
	String strFlag                                 ="";
	String strDisable                            ="enabled";
	String strButtonstate                      ="enabled";   
	String strComboDisable					="disabled";
	
	String strButtonCaption                 =dbLabelBean.getLabel("label.global.addtraveler",strsesLanguage);
	
	String strwhatAction					   ="";
	String strCurrency_list                   ="";	
	String strExpRemark                     ="";
	
	String strButtonstate1						="enabled";
	String strReturnTravel						=""; 
	String 	strchecked							="";
	String strTexttoShow						="";
	String strTexttoShowtraveler				="";
	String strCostCentre="";
	String strShowflag="n";
	String strCancelledReqId			="0";
	String strShowCancelledRegflag		="n";
	
	String strMessage  	                            = (request.getParameter("strMessage")==null)?"":request.getParameter("strMessage");
	String strG_userID  							= (request.getParameter("G_userId")==null)?"":request.getParameter("G_userId");
	String Site_ID 									= (request.getParameter("site")==null)?"-1":request.getParameter("site");
	String strFirstname				                =(request.getParameter("firstName")==null)?"":request.getParameter("firstName");  
	String strLastname				                = (request.getParameter("lastName")==null)?"":request.getParameter("lastName");
	String strDesig_ID 				                = (request.getParameter("designation")==null)?"-1" :request.getParameter("designation");
	String strDOB 				                    = (request.getParameter("passport_DOB")==null)?"" :request.getParameter("passport_DOB");
	String strMeal 							        = (request.getParameter("meal")==null)?"6" :request.getParameter("meal");//putting default as veg 
	String strPassportNo 		                    = (request.getParameter("passportNo")==null)?"" :request.getParameter("passportNo");
	String strNationality 		                    = (request.getParameter("nationality")==null)?"" :request.getParameter("nationality");
	String strPassport_issue_date		    		= (request.getParameter("passport_issue_date")==null)?"" :request.getParameter("passport_issue_date");
	String strPassport_expire_date		    		= (request.getParameter("passport_expire_date")==null)?"" :request.getParameter("passport_expire_date");
	String strPassport_issue_place		    		= (request.getParameter("passport_issue_place")==null)?"" :request.getParameter("passport_issue_place");
	String strVisa									= (request.getParameter("visa")==null)?"2" :request.getParameter("visa");
	String strEcr									= (request.getParameter("ECR")==null)?"2" :request.getParameter("ECR");
	String strAge									= (request.getParameter("age")==null)?"" :request.getParameter("age");
	strGender									    = (request.getParameter("Gender")==null)?"-1" :request.getParameter("Gender");
	strTACurrency									= (request.getParameter("expCurrency")==null)?"USD" :request.getParameter("expCurrency");
	strTravelId                                     =  request.getParameter("travelId")==null ?"" :request.getParameter("travelId") ;        // for hidden field
	strTravelReqId                                  =  request.getParameter("travelReqId") ==null ?"" :request.getParameter("travelReqId");    // for hidden field
	strTravelReqNo                                  =  request.getParameter("travelReqNo")==null ?"" :request.getParameter("travelReqNo") ;    // for hidden field
	strwhatAction                                   =  request.getParameter("action")==null ?"" :request.getParameter("action") ;    // for hidden field
	String 	strDepCity=	request.getParameter("depCity")==null?"":request.getParameter("depCity");
	String 	strArrCity= request.getParameter("arrCity")==null?"":request.getParameter("arrCity");
	String  strDepDate= request.getParameter("depDate")==null?"":request.getParameter("depDate");
	String  strPreferTime= request.getParameter("preferTime")==null?"2":request.getParameter("preferTime");
	String  strNameOfAirline = request.getParameter("nameOfAirline")==null?"":request.getParameter("nameOfAirline");
	String  strTravelMode = "";
	String  strTravelClass = request.getParameter("travelClass")==null?"":request.getParameter("travelClass");
	String  strSeatPreffered  = request.getParameter("seatpreference")==null?"":request.getParameter("seatpreference");
	
	
//added by manoj chand on 20 sept 2011 to add accomodation required

String strHotelRequired             =  request.getParameter("hotel") == null ? "0" : request.getParameter("hotel");
String strHotelBudget               =  request.getParameter("budget")==null ? "":request.getParameter("budget");
String strBudgetCurrency            =  request.getParameter("currency")==null ? "USD":request.getParameter("currency");
String strCheckin					=  request.getParameter("checkin") == null ? "" : request.getParameter("checkin");
String strCheckout					=  request.getParameter("checkout") == null ? "" : request.getParameter("checkout");
String strPlace			            =  request.getParameter("place")==null?"":request.getParameter("place");
String strRemarks                   =  request.getParameter("otherComment")==null?"":request.getParameter("otherComment"); 	 
String strIntermiId					=	request.getParameter("interimId")== null ? "" : request.getParameter("interimId");	
String strGroupinterimflag			= 	request.getParameter("groupflag")==null ? "":request.getParameter("groupflag");
String strUserids					=	request.getParameter("userids")==null?"":request.getParameter("userids");
strCostCentre					=  request.getParameter("costcentre")==null?"0":request.getParameter("costcentre");
String strAppLvl3flg = "";
String strTotalExpinUSD="";
//Added By Gurmeet Singh
String strUserAccessCheckFlag = "";	

//code added by manoj chand on 03 august 2012 to CHECK WHETHER DIVISION OF USER IS SMP OR NOT.
strSql="SELECT SHOW_APP_LVL_3 FROM M_DIVISION MD INNER JOIN	M_USERINFO MU ON MU.DIV_ID=MD.DIV_ID WHERE USERID="+Suser_id;
//System.out.println("strSql --->"+strSql);
rs       =   dbConBean.executeQuery(strSql);  
if(rs.next())
{
	strAppLvl3flg=rs.getString("SHOW_APP_LVL_3");
}
rs.close();

rs=null;
strSql = " SELECT 1 FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+
		" WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =6 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+Suser_id+" OR TD.C_USERID="+Suser_id+") "+ 
		" AND (CONVERT(DATE,TD.C_DATETIME) BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE()) OR  TD.TRAVEL_DATE BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE())) AND TD.Group_Travel_Flag='Y' "+  
		" UNION "+  
		" SELECT 1 FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+   
		" INNER JOIN (SELECT TRAVEL_ID,TJDI.JOURNEY_ORDER,TRAVEL_DATE FROM T_JOURNEY_DETAILS_INT TJDI WHERE STATUS_ID=10 "+
		" UNION "+
		" SELECT TRAVEL_ID,9999,TRAVEL_DATE FROM T_RET_JOURNEY_DETAILS_INT WHERE YEAR(TRAVEL_DATE)<>1900 AND TRAVEL_DATE IS NOT NULL)DRV ON TD.TRAVEL_ID=DRV.TRAVEL_ID "+
		" WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =10 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+Suser_id+" OR TD.C_USERID="+Suser_id+") AND TD.Group_Travel_Flag='Y' "+  
		" GROUP BY TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID HAVING CONVERT(DATE,GETDATE()) BETWEEN MIN(DRV.TRAVEL_DATE) AND MAX(DRV.TRAVEL_DATE) ";

rs = dbConBean.executeQuery(strSql);
if(rs.next()) {	
strShowCancelledRegflag = "y";
}
rs.close();


	rs=null;
	 if(strTravelId!=null && !strTravelId.equals("")  && !strTravelId.equals("new"))
	 { 
		    strSql = "SELECT     T1.TRAVEL_REQ_ID AS TRAVEL_REQ_ID, T2.SITE_ID as SITE_ID  FROM    T_TRAVEL_STATUS T1 INNER JOIN T_GROUP_USERINFO T2 ON T1.TRAVEL_ID = T2.TRAVEL_ID   WHERE     (T1.STATUS_ID = 10) AND (T1.TRAVEL_TYPE = 'i') AND (T2.TRAVEL_TYPE='I') AND (T1.TRAVEL_ID = "+strTravelId+")";	
    	    rs       =   dbConBean.executeQuery(strSql);  
			while(rs.next()){
			strTravelReqId=rs.getString("TRAVEL_REQ_ID");
			Site_ID=rs.getString("SITE_ID");
			}
			rs.close();
			
			rs=null;
			strSql="SELECT CC_ID FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="+strTravelId+" AND STATUS_ID=10";
			rs       =   dbConBean.executeQuery(strSql);  
			if(rs.next()){
			strCostCentre=rs.getString("CC_ID");
			if(strCostCentre==null)
				strCostCentre="0";
			}
			rs.close();
	 }
		
	//when user click on update Button ======================  
	if(strTravelId!=null && !strTravelId.equals("") && strG_userID!=null &&  !strG_userID.equals("")  && !strTravelId.equals("new") )
	 {
		strUserAccessCheckFlag = securityUtilityBean.validateAuthEditTravelReq(strTravelId, "I", Suser_id);
		if(strUserAccessCheckFlag.equals("420")){
			dbConBean.close();
			dbConBean1.close();
			securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "Group_T_IntTrv_Details.jsp", "Unauthorized Access");
			response.sendRedirect("UnauthorizedAccess.jsp");
			return;
		} else {
		
		
		   strButtonCaption =dbLabelBean.getLabel("label.createrequest.updatedetails",strsesLanguage); 
	       strSql="SELECT SITE_ID, FIRST_NAME, LAST_NAME, DESIG_ID, PASSPORT_NO,ISNULL(NATIONALITY ,'') AS NATIONALITY, dbo.CONVERTDATEDMY1(DATE_OF_ISSUE) AS DATE_OF_ISSUE, PLACE_OF_ISSUE, dbo.CONVERTDATEDMY1(EXPIRY_DATE) AS EXPIRY_DATE, AGE, ECNR,  dbo.CONVERTDATEDMY1(DOB) AS DOB,   VISA_REQUIRED, GENDER, MAEL_ID,RTRIM(LTRIM(convert(decimal(20,2),TOTAL_AMOUNT))) AS TOTAL_AMOUNT,isnull(EXP_REMARKS,'') as  EXP_REMARKS FROM    T_GROUP_USERINFO   WHERE  (STATUS_ID = 10) AND (G_USERID = "+strG_userID+") AND (TRAVEL_TYPE = 'i') AND (TRAVEL_ID = "+strTravelId+")";
		   rs    =  dbConBean.executeQuery(strSql);  
	
		   while(rs.next())
			   {
					  Site_ID                                         =rs.getString("SITE_ID"); 
					  strFirstname                                =rs.getString("FIRST_NAME"); 
					   strLastname							       =rs.getString("LAST_NAME"); 
					   strDesig_ID							       =rs.getString("DESIG_ID"); 
					   strPassportNo							   =rs.getString("PASSPORT_NO");
					   strNationality 							   =rs.getString("NATIONALITY");
					   strPassport_issue_date             =rs.getString("DATE_OF_ISSUE"); 
					   strPassport_issue_place            =rs.getString("PLACE_OF_ISSUE"); 
					   strPassport_expire_date            =rs.getString("EXPIRY_DATE"); 
					   strAge                                          =rs.getString("AGE"); 
						strEcr										   =rs.getString("ECNR"); 
					   strDOB							               =rs.getString("DOB"); 
						strVisa                                        =rs.getString("VISA_REQUIRED"); 
					   strGender								       =rs.getString("GENDER"); 
	                   strMeal								            =rs.getString("MAEL_ID"); 
					   strTotalAmount						       =rs.getString("TOTAL_AMOUNT"); 
					   strExpRemark						       =rs.getString("EXP_REMARKS").trim(); 
	 
			}
			rs.close();
		}	
	 }
	if(strTravelId == null)
	{
	   Site_ID = strSiteIdSS;	
	}
	else if(strTravelId.equals(""))
	{
	   Site_ID = strSiteIdSS;	
	}
	
	
	    Date currentDate = new Date();
	  	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	  	String strCurrentDate = (sdf.format(currentDate)).trim();
	  	
	  //added by manoj chand on 03 august 2012 to get cost centre id
	  	rs=null;
	  	strSql =   "SELECT 1 FROM M_COST_CENTRE WHERE SITE_ID="+Site_ID+" AND M_COST_CENTRE.STATUS_ID=10";
	  	rs       =   dbConBean.executeQuery(strSql);
	  	if(rs.next()){
	  		strShowflag="y";
	  	}
	  	rs.close();
	  	//System.out.println("strAppLvl3flg---gr--->"+strAppLvl3flg);
	  	//System.out.println("strShowflag---gr--->"+strShowflag);
	  	
	  	//added by manoj chand on 16 oct 2012 to get site base currency
		String strBaseCur="INR";
	  	String strExchRate="0.000000";
		strSql = "SELECT ISNULL(CURRENCY,'') AS BASE_CUR FROM dbo.M_SITE ms WHERE ms.STATUS_ID=10 AND ms.SITE_ID="+Site_ID;
		rs = dbConBean.executeQuery(strSql);
		if(rs.next()) {
			strBaseCur = rs.getString("BASE_CUR");
		}
		rs.close();
		
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		String formattedDate = df.format(new Date());

		//added by manoj chand on 16 oct to find total amount in USD
		if(strTravelId!=null && !strTravelId.equals("") && strG_userID!=null &&  !strG_userID.equals("")  && !strTravelId.equals("new") )
		{
		if(strTotalAmount!=null && !strTotalAmount.equals("") && !strTotalAmount.equals("0")){
		strSql="SELECT DBO.[FN_CURRENCY_CONVERTOR]('"+strTotalAmount+"','"+strBaseCur+"','USD','"+formattedDate+"') AS FINAL_AMOUNT";
 		rs = dbConBean.executeQuery(strSql);
 		if(rs.next()){
 		strTotalExpinUSD=rs.getString("FINAL_AMOUNT");
 		}
		}
	 	}
		
		if(strBaseCur!=null && !strBaseCur.equals("")){
			strSql="SELECT ISNULL(DBO.FN_GET_EXCHANGE_RATE ('"+strBaseCur+"','"+formattedDate+"'),'') AS EXCHANGE_RATE";
      		rs = dbConBean.executeQuery(strSql);
     		if(rs.next()){
     		strExchRate=rs.getString("EXCHANGE_RATE");
     		}
		}
	%>
	<script>

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
					}
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

	function fun_calculate_GrandTotalUSD(){

		var grandtotal=$('#grandTotalForexinr').val();
		var urlParams = "strFlag=GrandTotalinUSD&totalexp="+grandtotal+"&basecur=<%=strBaseCur%>&seldate=<%=formattedDate%>";
		jQuery.ajax({
            type: "post",
            url: "AjaxMaster.jsp",
            data: urlParams,
            async:false,
            success: function(result){
            var res = result.trim();
            if(res != ''){
            	$('#grandtotalforexusd').val(res);	            				             
             }
            },
			error: function(){
				alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
            }
          });
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
		
		if(a=='' || a=='.')
			a=0;
		if(b=='' || b=='.')
			b=0;
		if(c=='' || c=='.')
			c=0;
		if(d=='' || d=='.')
			d=0;
		if(e=='' || e=='.')
			e=0;
		if(f=='' || f=='.')
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
	
	</script>
	
	              
	
	
	<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" >
	  <tr>
	    <td background="images/tophdbg.gif?buildstamp=2_0_0"><img src="images/group-travel-request.png?buildstamp=2_0_0" alt="Group Travel Request" width="237" height="35" /></td>
	    <td width="15%" background="images/tophdbg.gif?buildstamp=2_0_0"><img src="images/BigIcon.gif?buildstamp=2_0_0" alt="" width="46" height="31" /></td>
	  </tr>
	</table>
	<% 
	  //SpolicyPath variable used on 07 jan 2013 for getting company policy path
      //String Path	=application.getInitParameter("companyPolicyPath");
      File UploadFile=new File(SpolicyPath+"/"+strSiteFullName+"/"+strSiteFullName+".html");			   
	%>
	
	
	<%  
	//code added by Manoj Chand on 12 July 2013 for checking workflow for selected site is available or not.
	String strButtonState3="";
        if(!Site_ID.equals("0"))
		  {   
				  strSql="SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS  (NOLOCK) WHERE SITE_ID="+Site_ID+" AND TRV_TYPE='I' AND   sp_role="+SSstrSplRole+" and STATUS_ID=10 AND APPLICATION_ID=1";
		          rs  =  dbConBean.executeQuery(strSql);  
				   if(!rs.next())
                         {  
					   strButtonState3="disabled";  
					       %>
							   <script language="javascript">
								alert('<%=dbLabelBean.getLabel("alert.global.cannotproceed",strsesLanguage)%>');
								</script> 
				           <%
	           		    }
	                   rs.close();	 
          }
  %>
	
	
	
	
	<form name="frm" action="Group_T_IntTrv_DetailsPost.jsp" style="margin-top:-20px; padding-top:0px;">
	<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" >
	  <tr>
	    <td>
	    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">  
	    <tr><td> &nbsp;&nbsp;&nbsp;</td></tr>    
	      <tr><td height="10px"></td></tr>
	      <tr>
	        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">   
	          <tr>
	            <td valign="top" background="images/index_01.png?buildstamp=2_0_0"><img src="images/index_01.png?buildstamp=2_0_0" alt="" width="14" height="426" /></td>
	            <td width="100%" valign="top">
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	              <tr>
	                <td><img src="images/formTitIcon.png?buildstamp=2_0_0" alt="" width="30" height="29" /></td>
	                <td width="70%" background="images/tophd-bg.gif?buildstamp=2_0_0" class="formTit"><%=dbLabelBean.getLabel("label.createrequest.creategroupguesttravelrequest",strsesLanguage)%> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<font color="#CC3333" ><%=strMessage%></font></td>
	                <td width="30%" background="images/tophd-bg.gif?buildstamp=2_0_0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<a href="#" title="Company Policy" onClick="<% 
				  if(UploadFile.exists()) {
				  	%> MM_openBrWin('Companies_Policies/<%=strSiteFullName%>/<%=strSiteFullName%>.html','','scrollbars=yes,resizable=yes,width=700,height=300')
					<%; } else{%> MM_openBrWin('Companies_Policies/notexist.html','','scrollbars=yes,resizable=yes,width=700,height=300')<%;} %>" ><img src="images/IconPolicy.png?buildstamp=2_0_0" width="69" height="16" border="0" /></a><span class="formTit" style="text-align:right">
				<!-- <a href="#" onClick="MM_openBrWin('helpinternational travel.html#300a','','scrollbars=yes,resizable=yes,width=700,height=300')">
				  <img src="images/help.png?buildstamp=2_0_0" width="44" height="16" border="0" >
	            </a> --></td>
	              </tr>
	            </table>
	              <table width="100%" border="0" cellspacing="0" cellpadding="0">           
	                <tr>
	                  <td height="40" bgcolor="#FFFFFF">
					  <table cellspacing=0 cellpadding=0 width="100%" border="0">
					  <%
					  		String groupGuestReqFromUnitLabel = "";
					  		if(ssflage.equals("3")){
					  			groupGuestReqFromUnitLabel = "label.createrequest.guestrequisitionfromunit";
					  		}else{
					  			groupGuestReqFromUnitLabel = "label.createrequest.groupguestrequisitionfromunit";
					  		}
					  		
					  %>
					    <tr>
						  <td height="25" colspan=2 class="label1">&nbsp;&nbsp;&nbsp;&nbsp; <%=dbLabelBean.getLabel(groupGuestReqFromUnitLabel,strsesLanguage)%> &nbsp; &nbsp; &nbsp; 
						    <select name="site" id="siteId" class="textBoxCss"   onchange="getDivisonID();"  <%//=strDisable%> >
	                          <option value="-1" selected><%=dbLabelBean.getLabel("label.createrequest.selectunit",strsesLanguage) %></option>
							  <%
	                          /// getting a site from  	USER_MULTIPLE_ACCESS if user ahs miltiple access 					
							   strSql = "select distinct site_id, dbo.sitename(site_id) as Site_Name  from USER_MULTIPLE_ACCESS where userid="+Suser_id+" and status_id=10 and (UNIT_HEAD=1 or ROLE_ID='LA') order by 2";
						 
	                           rs       =   dbConBean.executeQuery(strSql);  
							   while(rs.next())
	                          {
							   %>       
	                            <option value="<%=rs.getString("Site_Id")%>"><%=rs.getString("Site_Name")%></option>
								<%
	                     	  }
	                          rs.close();	 
	                           /// getting a site from M_Site if user dose not have access of other site 
	                           
							  strSql =   "select Site_id, Site_Name from M_Site where status_id=10 and application_id=1 and Site_id="+strSiteIdSS+" and Site_id Not IN (select distinct site_id from USER_MULTIPLE_ACCESS where userid="+Suser_id+" and status_id=10 and (UNIT_HEAD=1 or ROLE_ID='LA')) order by 2";	
							  rs       =   dbConBean.executeQuery(strSql);  
	                          while(rs.next())
	                          {
								%>
	                             <option value="<%=rs.getString("Site_Id")%>"><%=rs.getString("Site_Name")%></option> 
								<%  
							  }
	                          rs.close();	
							  // End of Code
	                            %>
	                          </select>
	                          
	                      <!-- added by manoj chand on 01 aug 2012 to show cost centre for SMP division -->
		                    <% if(strAppLvl3flg.trim().equalsIgnoreCase("Y") && strShowflag.equalsIgnoreCase("y")) {
		                    %>
		                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= dbLabelBean.getLabel("label.createrequest.costcentre",strsesLanguage) %><span class="starcolour">*</span>  
		                    &nbsp;&nbsp;&nbsp;<span class="label2">
                          <select name="costcentre"  class="textBoxCss">
                          <option value="0"><%=dbLabelBean.getLabel("label.createrequest.selectcostcentre",strsesLanguage) %></option>
<% 								
                             strSql =   "SELECT CC_ID,CC_CODE+' - '+CC_DESC+'' AS CC_CODE FROM M_COST_CENTRE WHERE SITE_ID="+Site_ID+" AND M_COST_CENTRE.STATUS_ID=10 ORDER BY CC_CODE";
                             rs       =   dbConBean.executeQuery(strSql);  
                             while(rs.next())
                             {
%>
                              <option value="<%=rs.getString("CC_ID")%>"><%=rs.getString("CC_CODE")%></option>
<%
                         	 }
                             rs.close();	  
%>
                          </select>
                          <script language="javascript">
                            document.frm.costcentre.value="<%=strCostCentre%>";
                          </script>
                        </span>                     
		                    <%}  %>
	                          </td> 
	  						 <script language="javascript">
								document.frm.site.value ="<%=Site_ID%>"; 
							</script>
							  <td height="25" colSpan=2   align="left" ></td>         
		                    </tr>
	                        <tr>
	                		<td class=formfirstfield valign=bottom align="left"	bgcolor=#FFFFFF colspan=1 height=25><%=dbLabelBean.getLabel("label.global.basicinformation",strsesLanguage) %> &nbsp;<font style="font-family: Verdana, Arial, Helvetica, sans-serif;color: #373737; font-size:10px;; font-weight: normal;"><%=dbLabelBean.getLabel("label.global.fieldsmarkedwithanasterisk",strsesLanguage) %> (<span class=starcolour>*</span>) <%=dbLabelBean.getLabel("label.global.arerequired",strsesLanguage) %></font> </td>
	                		
	                  </tr>
	                  
	              </table>
				  <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-style:solid;border-color:#F0F0F0;border-collapse: collapse;">
	             <tr>
	               <td bgcolor="#FFFFFF">
	               <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" >
		          <tr>
	                  <td height="25" class="label1"><%=dbLabelBean.getLabel("label.global.personaladdress",strsesLanguage)%></td>
	                </tr>
	                <tr>
	                  <td height="25">
					  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                      <td width="16%" class="label2"><%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage)%><SPAN   class=starcolour>*</SPAN> </td>
	                      <td width="16%" class="label2"><%=dbLabelBean.getLabel("label.global.lastname",strsesLanguage)%><SPAN   class=starcolour></SPAN> </td>
	                      <td width="18%" class="label2"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%><SPAN   class=starcolour>*</SPAN> </td>
	                      <td width="16%" class="label2">&nbsp;<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%><SPAN  class=starcolour>*</SPAN> </td>
	                      <td width="14%" class="label2"><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%><SPAN   class=starcolour>*</SPAN> </td>
	                      <td width="20%" class="label2"><%=dbLabelBean.getLabel("label.global.mealpref",strsesLanguage)%><SPAN   class=starcolour></SPAN> </td>
	                    </tr>
	                    <tr>
	                      <td height="10">
	                        <input type="text" name="firstName" id="fNameId" class="textBoxCss"  onFocus="initializeGuestName(this);" onKeyUp="return test1('firstName', 30, 'c')" maxlength="30"/></td>
	                       <td class="label2">
						   <script  language="javascript">
						   document.frm.firstName.value="<%=strFirstname%>";
						   </script>
						   <input type="text" name="lastName" id="lNameId" class="textBoxCss"  onKeyUp="return test1('lastName', 30, 'c')" maxlength="30" /></td>
	                      <td class="label2" height="10">
						  <script  language="javascript">
						   document.frm.lastName.value="<%=strLastname%>";
						   </script>
						  <select name="designation" id="desigId" class="textBoxCss">
						   <option value="-1"> <%=dbLabelBean.getLabel("label.global.selectdesignation",strsesLanguage)%> </option>
						   <%		
						   			String desigId = "";						   			
					   			  	strSql = "SELECT DESIG_ID,DESIG_NAME  FROM M_DESIGNATION where site_id="+Site_ID+" AND APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY DESIG_NAME";
								 
	                                 rs       =   dbConBean.executeQuery(strSql);  
	                                 while(rs.next())
	                                    {%>
										 <option value="<%=rs.getString("DESIG_ID")%>"><%=rs.getString("DESIG_NAME")%></option> 
									<%
										if(rs.getString("DESIG_NAME") != null && rs.getString("DESIG_NAME").trim().equalsIgnoreCase("guest")){
											desigId = rs.getString("DESIG_ID");											
										}
	                                 }
	                              rs.close();
							%>
			
						  </td>
						  <%if(!desigId.equals("") && strDesig_ID != null && !strDesig_ID.equals("") && strDesig_ID.equals("-1")) {%>
						  <script  language="javascript">
						   document.frm.designation.value="<%=desigId%>";
						   </script>
						   <%} else if(strDesig_ID != null && !strDesig_ID.equals("") && !strDesig_ID.equals("-1")) { %>
						   <script  language="javascript">
						   document.frm.designation.value="<%=strDesig_ID%>";
						   </script>
						   <% } else {%>
						   <script  language="javascript">
						   document.frm.designation.value="-1";
						   </script>
						   <% }%>
						   
	                      <td class="label2" height="10">
						  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                          <tr>
								<td height="10"> <!--Reaching Date at Destination-->
							<!--  Modified by vaibhav on jun 23 2010
							<input name="passport_DOB" type="text" class="textBoxCss" id="test2" size="6" value="<%=DOB%>" onFocus="javascript:vDateType='DD/MM/YYYY'"  -->
						    &nbsp;<input name="passport_DOB" type="text" class="textBoxCss" id="passport_DOB" size="6" value="<%=DOB%>" onFocus="javascript:vDateType='DD/MM/YYYY'" 
							onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter');" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter');"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);FindAge();" 
							placeholder="dd/mm/yyyy" /> 
	
							 <a  onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"                 onclick="button_onclick(document.frm.passport_DOB);" >
					       <IMG   height=15 alt=Calender src="images/calender.png?buildstamp=2_0_0"  width=18  onKeyUp="FindAge();"  onclick="ageClear();" onfocus="FindAge();" ></a> 
	
						<!-- 	<a href="javascript:show_calendar('frm.passport_DOB','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
							<img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"  onKeyUp="FindAge();"  onclick="ageClear();" onfocus="FindAge();" ></a>		
							 -->
							
							</td>
	                        <script  language="javascript">
						   document.frm.passport_DOB.value="<%=strDOB%>";
						   </script>
	                          </tr>
	                        </table></td>
	                      <td height="10">
	                        <select name="Gender" id="genderId" class="textBoxCss">
							<option value='-1'  ><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></option>
	                          <option value='1'  ><%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%></option>
	                          <option value='2'><%=dbLabelBean.getLabel("label.global.female",strsesLanguage)%></option>
	                        </select>     </td>
						    <script  language="javascript">
						            document.frm.Gender.value="<%=strGender%>";
						        </script>
	                      <td height="10" class="label2">
						  <select name="meal" id="mealId" class="textBoxCss">
						  <%    //For Population of Meal Combo 
	                             strSql =   "SELECT MEAL_ID, MEAL_NAME FROM M_MEAL (NOLOCK) WHERE TRAVEL_AGENCY_ID = 1 AND STATUS_ID =10 ORDER BY MEAL_ID";
	                             rs       =   dbConBean.executeQuery(strSql);  
	                             while(rs.next())
	                             {
												%>
													 <option value="<%=rs.getString("MEAL_ID")%>"><%=rs.getString("MEAL_NAME")%></option>
												<%
	                         	 }
	                             rs.close();	  
							%>
							</td>
							 <script  language="javascript">
						   document.frm.meal.value="<%=strMeal%>";
						   </script>
	                    </tr>
	                  </table></td>
	                </tr>
	                <!-- <tr>
	                  <td class="label1">&nbsp;</td>
	                </tr> -->
	                <!-- <tr>
	                  <td class="label1">&nbsp;</td>
	                </tr> -->
	                <tr>
	                  <td height="25" class="label1"><%=dbLabelBean.getLabel("label.createrequest.passportinformation",strsesLanguage)%> <SPAN   class=starcolour>*</SPAN></td>
	                </tr>
	                <tr>
	                  <td height="25"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                      <td width="16%"   class="label2"><%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%><SPAN   class=starcolour></SPAN></td>
	                      <td width="12%" class="label2"><%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%> </td>
	                      <td width="12%" class="label2"><%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%> </td>
	                      <td width="12%" class="label2">&nbsp; &nbsp;  &nbsp;<%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage)%> </td>
	                      <td width="12%" class="label2">&nbsp; &nbsp;  &nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%></td>
	                      <td width="20%" class="label2">&nbsp; &nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.age",strsesLanguage)%></td>
	                      <td width="20%" class="label2"><%=dbLabelBean.getLabel("label.global.visarequired",strsesLanguage)%></td>
	                    </tr>
	                    <tr>
	                      <td><input type="text" name="passportNo" id="passportNoId" class="textBoxCss"   onkeyup="return test1('passportNo',49, 'all')" maxlength="49"/>                      </td>
						   <script  language="javascript">
						   document.frm.passportNo.value="<%=strPassportNo%>";
						   </script>
	                      <td class="label2">                           <!-- strDOfIssue -->
						   <input name="passport_issue_date" id="passportIssueDtId" type="text" class="textBoxCss" size="7" value="<%=strPassport_issue_date %>"    onFocus="javascript:vDateType='DD/MM/YYYY'" 
							onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" placeholder="dd/mm/yyyy" />
							
							 <a  onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"                 onclick="button_onclick(document.frm.passport_issue_date);" >
					       <IMG   height=15 alt=Calender src="images/calender.png?buildstamp=2_0_0"  width=18    ></a> 
	
						<!-- 	<a href="javascript:show_calendar('frm.passport_issue_date','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle">		</a>	 -->
	
						 <script  language="javascript">
						   document.frm.passport_issue_date.value="<%=strPassport_issue_date%>";
						   </script>
	
						  </td>
	                      <td class="label2"> 
	                                                                                                        <!-- strDOExpiry -->
						   <input name="passport_expire_date" id="passportExpireDtId" type="text" class="textBoxCss" id="test2" size="7" value="<%=strPassport_expire_date%>" onFocus="javascript:vDateType='DD/MM/YYYY'" 
							onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" placeholder="dd/mm/yyyy"/> 
	
							 <a  onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"                 onclick="button_onclick(document.frm.passport_expire_date);" >
					       <IMG   height="15" alt=Calender src="images/calender.png?buildstamp=2_0_0"  width="18"    ></a> 
	
	                          <!-- 
							<a href="javascript:show_calendar('frm.passport_expire_date','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">	<img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>	 -->
	
							 <script  language="javascript">
						   document.frm.passport_expire_date.value="<%=strPassport_expire_date%>";
						   </script>
							<td class="label2">&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" name="nationality" id="nationality" class="textBoxCss" value="<%=strNationality %>"  onkeyup="return test1('nationality',49, 'c')" maxlength="99"/></td>
	                      <td class="label2">&nbsp;&nbsp;&nbsp;&nbsp; 
						  &nbsp;<input name="passport_issue_place" id="passportIssuePlaceId" type="text" class="textBoxCss" size="15"    onKeyUp="return test1('passport_issue_place', 49, 'c')"  maxlength="49"  onfocus="FindAge();" /></td><!--   -->
	
						   <script  language="javascript">
						   document.frm.passport_issue_place.value="<%=strPassport_issue_place%>";
						   </script>
	                       <td>&nbsp;&nbsp;&nbsp;&nbsp;<input name="age" id="ageId" type="text" class="textBoxCss" size="22"      readonly onfocus="FindAge();" /></td>
	
						  <script  language="javascript">
						   document.frm.age.value="<%=strAge%>";
						   </script>
	                      <td height="25" class="label2">
							 <%=dbLabelBean.getLabel("label.global.yes",strsesLanguage) %>&nbsp;<input name="visa" type="radio" value="1" /> &nbsp;&nbsp;&nbsp;
	                         <%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %>&nbsp;<input name="visa" type="radio"  checked="checked" value="2" /></td>
							 <script language ="javascript">
						//window.document.frm.ecnrradio.value= '<%//=passport_ECNR%>'
						var flag1   = '<%=strVisa%>';
						if(flag1 == 1)
						    {
							  document.frm.visa[0].checked=true;
						    }
						else
						    {
							document.frm.visa[1].checked=true;
						    }
						</script>
	                    </tr>
	                    
	                  </table></td>
	                </tr>
	                <tr>
	                  <td height="25"><table width="45%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                      <td width="58%" height="25" class="label2"><strong><%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",strsesLanguage)%></strong><SPAN   class=starcolour>*</SPAN></td>
	                      <td width="5%" class="label2"><div align="center"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%></div></td>
	                      <td width="3%">
	                        <input name="ECR" type="radio" value="1" />
	                      </td>
	                      <td width="5%">&nbsp;</td>
	                      <td width="5%" class="label2"><div align="center"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%></div></td>
	                      <td width="3%">
	                      	<input name="ECR" type="radio" checked="checked"  value="2" />
	                      </td>
	                      <td width="5%">&nbsp;</td>
	                      <td width="5%" class="label2"><div align="center"><%=dbLabelBean.getLabel("label.global.na",strsesLanguage)%></div></td>
	                      <td width="3%">
	                      	<input name="ECR" type="radio" value="3" />
	                      </td>					  
	                    </tr>
	                    <script language ="javascript">
                            var flag1   = '<%=strEcr%>';
							if(flag1 == 1)
							{
								document.frm.ECR[0].checked=true;								
							}
							else if(flag1 == 2)
							{
								document.frm.ECR[1].checked=true;								
							} 
							else if(flag1 == 3)
							{
								document.frm.ECR[2].checked=true;								
							}
					
						</script>
	                  </table></td>
	                </tr>
	              </table></td>
	  </tr>
	  
	  <tr>
	    <td bgcolor="#FFFFFF" style="border-style: solid;border-color: #F0F0F0;border-collapse: collapse;">
	    <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" >
	
	       <tr>
	                       <td height="25" align="left"><span style="FONT-WEIGHT: bold; FONT-SIZE: 12px; COLOR: #353436; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif"><%=dbLabelBean.getLabel("label.requestdetails.forexdetails",strsesLanguage)%></span>&nbsp;&nbsp;<span style="FONT-SIZE: 11px; COLOR: BLUE; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; font-weight: bold;font-style: italic;"><%=dbLabelBean.getLabel("label.createrequest.toaddmultiplecurrencies",strsesLanguage) %></span></td>
	                     </tr>
	     <!--     <tr>
	          <td height="25" class="label1"><%=dbLabelBean.getLabel("label.requestdetails.forexdetails",strsesLanguage)%></td>
	        </tr> -->
	          <tr>
	          <td height="25">
	          <table class="mytable" width="100%" border="1" cellspacing="0" cellpadding="2" style="border-style:solid;border-color:#F0F0F0;border-collapse: collapse;">
	          
	            <thead>
	             <!-- added by manoj chand on 07 oct 2012 to add expenditure in multiple currency -->
	                     <tr>
	                     <td class="label3" rowspan="2" nowrap="nowrap"><b><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></b></td>
	                     <td class="label3" rowspan="2"><b><%=dbLabelBean.getLabel("label.global.currencypreference",strsesLanguage)%></b></td>
	                     <td class="label3" colspan="2"><b><%=dbLabelBean.getLabel("label.global.dailyallowances",strsesLanguage)%></b></td>
	                     <td class="label3" colspan="2"><b><%=dbLabelBean.getLabel("label.global.hotelcharges",strsesLanguage)%></b></td>
	                     <td class="label3" rowspan="2"><b><%=dbLabelBean.getLabel("label.global.contigencies",strsesLanguage) %></b></td>
	                     <td class="label3" rowspan="2"><b><%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage) %></b></td>
	                     <td class="label3" rowspan="2"><b><%=dbLabelBean.getLabel("label.global.total",strsesLanguage) %></b></td>
	                     <td class="label3" rowspan="2" align="center"><b><%=dbLabelBean.getLabel("label.requisition.exchrate",strsesLanguage) %><br />(<%=dbLabelBean.getLabel("label.requisition.inr",strsesLanguage) %>)</b></td>
	                     <td class="label3" rowspan="2" align="center"><b><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage) %><br />(<%=strBaseCur %>)</b></td>
	                     <td class="label3" rowspan="2"><b><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage) %></b></td>
	                     </tr>
	                     <tr>
	                     <td class="label3"><b><%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage) %></b></td>
	                     <td class="label3"><b><%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage) %></b></td>
	                     <td class="label3"><b><%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage) %></b></td>
	                     <td class="label3"><b><%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage) %></b></td>
	                     
	                     </tr>
	                    </thead>

	            
	           
				<%
				//code to diabled combo if any active user  exit in T_group_usrinfo 
					 if(strTravelId!=null && !strTravelId.equals("") && !strTravelId.equals("new"))
					   	{ 
					   	  strSql = "SELECT G_USERID FROM T_GROUP_USERINFO WHERE travel_type='i' and (TRAVEL_ID = "+strTravelId+") AND (STATUS_ID = 10)";
	
	               	   	   rs      =   dbConBean.executeQuery(strSql);  
						     if (rs.next())
						      {  strComboDisable="disabled";
							     
						      } 
							  else {
								    strComboDisable="";
								 
							  }
							  rs.close();
	                      }
					else{
	                          strComboDisable="";
							 
						}
	
						 
				   if (strComboDisable.equals("disabled"))
						 {
					 			strSql = "SELECT distinct currency   FROM  T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID = "+strTravelId+"";	
								rs = dbConBean.executeQuery(strSql);
								while(rs.next()) 
								{  
									strTACurrency = rs.getString(1);		
								 } 
								rs.close();				
								 
						 }
						
				%>
	<%
	//added by manoj chand on 12 oct 2012 to show forex details on edit user
	String strRec="no";
	int count=0;
	if(strTravelId!=null && !strTravelId.equals("") && strG_userID!=null &&  !strG_userID.equals("")  )
	{
		String strTACurrency2="USD",strEntPerDay2="",strTotalTourDays2="",strTotalExpId2="",strTotalForex="",strExchangeRate="",strTotalinBase="";
		int sno=0;
		CallableStatement objCstmt	    =  null;
		Connection objCon               =  dbConBean.getConnection(); 
		objCstmt             =  objCon.prepareCall("{?=call SPG_GET_TRAVEL_EXPENDITURE_DETAILS(?,?,?)}");        
		objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		objCstmt.setString(2,strTravelId);
		objCstmt.setString(3,"I");
		objCstmt.setString(4,strG_userID);
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
			<td align="center" class="label5" height="20"><span class="spn"><%=++sno %></span></td>
	              <td class="label5" align="left" valign="top" height="20">
	                <select name="expCurrency" id="expCurrency" class="textBoxCss" onchange="fun_exchangerate(this);"  <%//=strComboDisable%> >
	                 <option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
	                 <%  
					  strSql =   "Select RTRIM(Currency), RTRIM(Currency) from m_currency where status_id=10";
	                     	   rs       =   dbConBean.executeQuery(strSql);  
				              while(rs.next())
	                           {   
								%>
	                                <option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%></option>  
									<%
	                           }
	                           rs.close();
	                      %>
	                </select>
	                           <script language="javascript">
	                           document.getElementsByName("expCurrency")[<%=count%>].value="<%=strTACurrency2%>";
	                         </script>
	               </td>
	              <td class="label5" height="20" valign="top" align="left">
	                <input name="entitlement" id="entitlement1" type="text" class="textBoxCss2" size="4"  maxlength="7" onchange="check1();"    value="<%=strEntPerDay %>" onkeyup="return test3(this, 10, 'n');"   align="right" />
	              </td>
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="tourDays" id="tourDays1" type="text" class="textBoxCss2" size="1"  maxlength="3" onchange="check1();" value="<%=strTotalTourDays %>"  onkeyup="return test3(this, 3, 'n');"  align="right"/>
	              </td>
	                <td class="label5" height="20" valign="top" align="left">
	                <input name="entitlement2" id="entitlement2" type="text" class="textBoxCss2" size="4"  maxlength="7" onchange="check1();"    value="<%=strEntPerDay2 %>" onkeyup="return test3(this, 10, 'n');"   align="right" />
	              </td>
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="tourDays2" id="tourDays2" type="text" class="textBoxCss2" size="1"  maxlength="3" onchange="check1();" value="<%=strTotalTourDays2 %>"  onkeyup="return test3(this, 3, 'n');"  align="right"/>
	              </td>
	              <td class="label52" align="left" height="20" valign="top">
	                <input name="contingencies" id="contingencies1" type="text"    onchange="check1();" class="textBoxCss2" size="6" maxlength="8" value="<%=strTotalExpId %>" onkeyup="return test3(this, 10, 'n.');"  />
	              </td>
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="contingencies2" id="contingencies2" type="text"    onchange="check1();" class="textBoxCss2" size="6" maxlength="8" value="<%=strTotalExpId2 %>" onkeyup="return test3(this, 10, 'n.');"  />
	              </td>
	              
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="totalForex" id="totalforex" type="text" class="textBoxCss2" size="6"   onchange="check1();" onkeyup="return test3(this, 20, 'n.');"  value="<%=strTotalForex %>" align="right" />
	              </td>
	               <td height="20" align="left" valign="top" class="label5" height="30" valign="top">
					<input name="exRate" id="exrate" type="text" class="textBoxCss2" onchange="check1();" onkeyup="return test3(this, 20, 'n.');"  value="<%=strExchangeRate %>" size="6" align="right" disabled="disabled" />
				   </td>
				  <td height="20" align="left" valign="top" class="label5">
				     <input name="totalInr" id="totalinr" type="text" class="textBoxCss2" onchange="check1();" onkeyup="return test3(this, 20, 'n.');"  value="<%=strTotalinBase %>" size="8" align="right" />
				  </td>
					<td height="20" align="left" valign="top" class="label5">
					<input type="button" id="btnadd" style="display: none;" value="  <%=dbLabelBean.getLabel("label.global.add",strsesLanguage) %>  " class="formButton"/>
					<input type="button" id="removebtn" class="remove formButton" value="<%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %>"/>
					<input name="hd" id="hd" type="hidden" value="v"/>
					</td>
						  
	             </tr>
	<%
count++;
}
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
	              <td align="center" class="label5" height="20"><span class="spn">1</span></td>
	              <td class="label5" align="left" valign="top" height="20">
	                <select name="expCurrency" id="expCurrency" class="textBoxCss" onchange="fun_exchangerate(this);"  <%//=strComboDisable%> >
	                 <option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
	                 <%   strComboDisable="";
					  if (strComboDisable.equals("disabled"))
						 {
					 			strSql = "SELECT distinct RTRIM(currency) ,RTRIM(currency)  FROM  T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID = "+strTravelId+"";
					 			rs=null;
								rs = dbConBean.executeQuery(strSql);
								while(rs.next()) 
								{
									%>
	                                <option value="<%=rs.getString(1)%>">    <%=rs.getString(2)%>    </option>  
									<%
	                            }
						 }
						 else
							 {
	                             strSql =   "Select RTRIM(Currency), RTRIM(Currency) from m_currency where status_id=10";
	                     	   rs       =   dbConBean.executeQuery(strSql);  
				              while(rs.next())
	                           {   
								%>
	                                <option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%></option>  
									<%
	                           }
	                           rs.close();	  
							  	
							 }
	                      %>
	                </select>
	                           <script language="javascript">
							 		        document.frm.expCurrency.value="<%=strBaseCur%>";
	                         </script>
	              </td>
	              <td class="label5" height="20" valign="top" align="left">
	                <input name="entitlement" id="entitlement1" type="text" class="textBoxCss2" size="4"  maxlength="7" onchange="check1();"    value="0" onkeyup="return test3(this, 10, 'n');"   align="right" />
	              </td>
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="tourDays" id="tourDays1" type="text" class="textBoxCss2" size="1"  maxlength="3" onchange="check1();" value="0"  onkeyup="return test3(this, 3, 'n');"  align="right"/>
	              </td>
	                <td class="label5" height="20" valign="top" align="left">
	                <input name="entitlement2" id="entitlement2" type="text" class="textBoxCss2" size="4"  maxlength="7" onchange="check1();"    value="0" onkeyup="return test3(this, 10, 'n');"   align="right" />
	              </td>
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="tourDays2" id="tourDays2" type="text" class="textBoxCss2" size="1"  maxlength="3" onchange="check1();" value="0"  onkeyup="return test3(this, 3, 'n');"  align="right"/>
	              </td>
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="contingencies" id="contingencies1" type="text"    onchange="check1();" class="textBoxCss2" size="6" maxlength="8" value="0" onkeyup="return test3(this, 10, 'n.');"  />
	              </td>
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="contingencies2" id="contingencies2" type="text"    onchange="check1();" class="textBoxCss2" size="6" maxlength="8" value="0" onkeyup="return test3(this, 10, 'n.');"  />
	              </td>
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="totalForex" id="totalforex" type="text" class="textBoxCss2" size="6"   onchange="check1();" onkeyup="return test3(this, 20, 'n.');"  value="0.00" align="right" />
	              </td>
	               <td height="20" align="left" valign="top" class="label5" height="30" valign="top">
					<input name="exRate" id="exrate" type="text" class="textBoxCss2" onchange="check1();" onkeyup="return test3(this, 20, 'n.');"  value="<%=strExchRate %>" size="6" align="right" disabled="disabled" />
				   </td>
				  <td height="20" align="left" valign="top" class="label5">
				     <input name="totalInr" id="totalinr" type="text" class="textBoxCss2" onchange="check1();" onkeyup="return test3(this, 20, 'n.');"  value="0.00" size="8" align="right" />
				  </td>
				  <td  height="20" align="left" valign="top" class="label5">
				   	<input type="button" id="btnadd" value="  <%=dbLabelBean.getLabel("label.global.add",strsesLanguage) %>  " class="formButton"/>
					<input type="button" id="removebtn" style="display: none;" class="remove formButton" value="<%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %>"/>
					<input name="hd" id="hd" type="hidden" value="v"/>
				   </td>
	            </tr>
	      <%         
				  if(strTravelId!=null && !strTravelId.equals("") && strG_userID!=null &&  !strG_userID.equals("")  )
					    	{ 
								   strSql =   "SELECT     RTRIM(LTRIM(EXP_ID)) AS EXP_ID, LTRIM(RTRIM(CONVERT(decimal(20, 0), TOTAL_EXP_ID))) AS TOTAL_EXP_ID, G_userid  FROM    T_TRAVEL_EXPENDITURE_INT WHERE     (TRAVEL_ID = "+strTravelId+") AND (EXP_ID = 3) AND (APPLICATION_ID = 1) AND (G_userid = "+strG_userID+")";
	
								   rs       =   dbConBean.executeQuery(strSql);  
								   if(rs.next())
								   {                       
									   strTotalExpId             =  rs.getString("TOTAL_EXP_ID");
									   if(strTotalExpId !=null && strTotalExpId.trim().equals("0"))
									   {
										   strTotalExpId = "";
									   }
								   }
								   rs.close();
	
							}

				  if(strTravelId!=null && !strTravelId.equals("") && strG_userID!=null &&  !strG_userID.equals("")  )
					    	{ 
								   strSql =   "SELECT     RTRIM(LTRIM(EXP_ID)) AS EXP_ID, LTRIM(RTRIM(CONVERT(decimal(20, 0), TOTAL_EXP_ID))) AS TOTAL_EXP_ID, G_userid FROM   T_TRAVEL_EXPENDITURE_INT WHERE     (TRAVEL_ID = "+strTravelId+") AND (EXP_ID = 4) AND (APPLICATION_ID = 1) AND (G_userid = "+strG_userID+")";
								   rs       =   dbConBean.executeQuery(strSql);  
								   if(rs.next())
								   {                       
									   strTotalExpId             =  rs.getString("TOTAL_EXP_ID");
									   if(strTotalExpId !=null && strTotalExpId.trim().equals("0"))
									   {
										   strTotalExpId = "";
									   }
								   }
								   rs.close();
	
							}
	        
	}%>
	              
	    <!--blank row created to add multiple time -->
	              <tr class="prototype">
	              <td align="center" class="label5" height="20"><span class="spn"></span></td>
	              <td class="label5" align="left" height="20" valign="top">
	                <select name="expCurrency" id="expCurrency" class="textBoxCss"  onchange="fun_exchangerate(this);"  <%//=strComboDisable%> >
	                 <option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
	                 <%  
	                 strComboDisable="";
					  if (strComboDisable.equals("disabled"))
						 {
					 			strSql = "SELECT distinct RTRIM(currency) ,RTRIM(currency)  FROM  T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID = "+strTravelId+"";	
								rs = dbConBean.executeQuery(strSql);
								while(rs.next()) 
								{
									%>
	                                <option value="<%=rs.getString(1)%>">    <%=rs.getString(2)%>    </option>  
									<%
	                            }
						 }
						 else
							 {
	                             strSql =   "Select RTRIM(Currency), RTRIM(Currency) from m_currency where status_id=10";
	                     	   rs       =   dbConBean.executeQuery(strSql);  
				              while(rs.next())
	                           {   
								%>
	                                <option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%></option>  
									<%
	                           }
	                           rs.close();	  
							  	
							 }
	                      %>
	                </select>
	                           <script language="javascript">
							 		        document.frm.expCurrency.value="<%=strTACurrency%>";
	                         </script>
	              </td>
					
	              <td class="label5" height="v" valign="top" align="left">
	                <input name="entitlement" id="entitlement1" type="text" class="textBoxCss2" size="4"  maxlength="7" onchange="check1();"    value="0" onkeyup="return test3(this,10,'n');"   align="right" />
	              </td>
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="tourDays" id="tourDays1" type="text" class="textBoxCss2" size="1"  maxlength="3" onchange="check1();" value="0"  onkeyup="return test3(this,3,'n');"  align="right"/>
	              </td>
	                <td class="label5" height="20" valign="top" align="left">
	                <input name="entitlement2" id="entitlement2" type="text" class="textBoxCss2" size="4"  maxlength="7" onchange="check1();"    value="0" onkeyup="return test3(this,10,'n');"   align="right" />
	              </td>
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="tourDays2" id="tourDays2" type="text" class="textBoxCss2" size="1"  maxlength="3" onchange="check1();" value="0"  onkeyup="return test3(this,3,'n');"  align="right"/>
	              </td>
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="contingencies" id="contingencies1" type="text"    onchange="check1();" class="textBoxCss2" size="6" maxlength="8" value="0" onkeyup="return test3(this,10,'n.');"  />
	              </td>
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="contingencies2" id="contingencies2" type="text"    onchange="check1();" class="textBoxCss2" size="6" maxlength="8" value="0" onkeyup="return test3(this,10,'n.');"  />
	              </td>
	              
	              <td class="label5" align="left" height="20" valign="top">
	                <input name="totalForex" id="totalforex" type="text" class="textBoxCss2" size="6"   onchange="check1();" onkeyup="return test3(this,20,'n.');"  value="0.00" align="right" />
	              </td>
	               <td height="20" align="left" valign="top" class="label5">
					<input name="exRate" id="exrate" type="text" class="textBoxCss2" onchange="check1();" onkeyup="return test3(this, 20, 'n.');"  value="0.000000" size="6" align="right" disabled="disabled" />
				   </td>
				  <td height="20" align="left" valign="top" class="label5">
				     <input name="totalInr" id="totalinr" type="text" class="textBoxCss2" onchange="check1();" onkeyup="return test3(this, 20, 'n.');"  value="0.00" size="8" align="right" />
				  </td>
				  <td height="20" align="left" valign="top" class="label5">
					 <input type="button" id="btnadd" value="  <%=dbLabelBean.getLabel("label.global.add",strsesLanguage) %>  " class="formButton"/>
					 <input type="button" id="removebtn" style="display: none;" class="remove formButton" value="<%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %>"/>
					 <input name="hd" id="hd" type="hidden" value="h"/>
				  </td>
	            </tr>
	              <tr class="inner">
	               <td colspan="10" align="right" class="label5"><font color="black" style="font-weight: bold" size="1"><%=strBaseCur %></font></td>
	                    <td class="label5"><input name="grandTotalForex" id="grandTotalForexinr" type="text" class="textBoxCss2" onchange="check1();" onkeyup="return test3(this, 20, 'n');"  value="<%=strTotalAmount%>" size="8" align="right" /></td>
	                    <td class="label5">&nbsp;</td>
	              </tr> 
	               <tr>
	                  <td colspan="12" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff" style="border-style: solid;border-color: #F0F0F0;">
					   <table width="100%" border="0" cellpadding="0" cellspacing="0">
	                     <tr>
	                       <td height="20" colspan="1" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%> / <%=dbLabelBean.getLabel("alert.global.reasonforcontigencies",strsesLanguage)%></td>
	                     </tr>
	                     <tr>
	                       <td height="30" valign="top" >
						     <textarea name="expRemarks" cols="105" rows="3" class="textBoxCss" onkeyup="return test1('expRemarks', 100, 'all')" ><%=strExpRemark%></textarea>
						   </td>
						   <td valign="top" class="label2">
				              <div align="center">
					                <input type="button" name="Submit" value="<%=strButtonCaption%>" <%=strButtonState3 %> class="formButton" onclick="checkData(frm,'','<%=strAppLvl3flg %>','<%=strShowflag %>');" /><!-- onclick="checkData(frm);"  -->
				              </div>
						   </td>
	                     </tr>

	                     </table>
	                    </td>
	                </tr>
	          </table>
	          </td>
	        </tr>
	       </table>
	      </td>
	  </tr>
	  
	  <tr>
			     <td valign="top" bgcolor="#FFFFFF" style="border-style: solid;border-color: #F0F0F0;">
			     
	<table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" >
	<%
	
		String groupGuestTravellerLabel = "";
		if(ssflage.equals("3")){
			groupGuestTravellerLabel = "label.global.guesttravelerdetail";
		}else{
			groupGuestTravellerLabel = "label.global.groupguesttravelerdetail";
		}
	
	%>
	        <tr>
	          <td height="25" class="label1"><%=dbLabelBean.getLabel(groupGuestTravellerLabel,strsesLanguage)%></td> 
	        </tr>
	    
	
	        <tr> 
	          <td height="20">        
	          <table width="100%" border="1" cellpadding="1" cellspacing="1" bordercolor="#F0F0F0" style="border-collapse: collapse;">       
	              <tr>
	                <td width="6%" height="15" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%> </strong></div></td>
	                <td width="13%" class="label3"><div align="left"><strong>&nbsp;<%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage)%> </strong></div></td>
	                
	                <td width="15%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></strong></div></td>
	                <td width="10%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%></strong></div></td>
	                <td width="18%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.age",strsesLanguage)%></strong></div></td>
	                <td width="8%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></strong></div></td>
	                <td width="10%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.mealpref",strsesLanguage)%></strong></div></td>
	                <td width="10%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.totalforex",strsesLanguage)%></strong></div></td>
	                <td width="13%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage)%></strong></div></td>
	                <td width="13%" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></strong></div></td>
	              </tr>
	              <tr> 
	                <td height="15" class="label3">&nbsp;</td>
	                <td height="15" class="label3">&nbsp;</td>
	                <td height="15" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.createrequest.passportnumber",strsesLanguage)%> </strong></div></td>
	                <td height="15" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%> </strong></div></td>
	                <td height="15" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%></strong></div></td>
	                <td height="15" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%></strong></div></td>
	                <td height="15" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.visarequired",strsesLanguage)%></strong></div></td>
	                <td height="15" class="label3"><div align="center"><strong><%=dbLabelBean.getLabel("label.global.ecr",strsesLanguage)%></strong></div></td>
	                <td height="15" class="label3"></td>
	                <td height="15" class="label3">&nbsp;</td>
	              </tr>
	             <!--  <tr>
	                <td class="label2">&nbsp; </td>
	                <td class="label2">&nbsp;</td>
	                <td class="label2">&nbsp;</td>
	                <td class="label2">&nbsp;</td>
	                <td class="label2">&nbsp;</td>
	                <td class="label2">&nbsp;</td>
	                <td class="label2">&nbsp;</td>
	                <td class="label2">&nbsp;</td>
	                <td class="label2">&nbsp;</td>
	              </tr> -->
	  
	          <%            //  ISNULL(dbo.CONVERTDATEDMY1(EXPIRY_DATE),'-') AS EXPIRY_DATE
  
	if(strTravelId==null)   
	{
	  strTravelReqId = "new";
	  strTravelId    = "new";
	  strButtonstate ="2";
	  strComboDisable="";
	   
	
	}
	else if(strTravelId !=null && strTravelId.equals(""))
	{
	  strTravelReqId = "new";
	  strTravelId    = "new";
	  strButtonstate ="2";
	  //strComboDisable="";
	  
	}
	else if(strTravelId !=null && strTravelId.equals("new"))
	{
	  strTravelReqId = "new";
	  strTravelId    = "new"; 
	  strButtonstate ="2";
	 //strComboDisable="";  
	 }
	else {
		         //setting flag  whern request is not new    
				 strFlag="1"; 
		         
				  strSql="SELECT  G_USERID,Site_id,FIRST_NAME,LAST_NAME, dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG, " +
				         " ISNULL(dbo.CONVERTDATEDMY1(DOB),'-') AS DOB,AGE,GENDER, ISNULL(dbo.MEAL_NAME(MAEL_ID),'-') AS  MEALNAME, " +
				         " TOTAL_AMOUNT,  PASSPORT_NO, ISNULL(NATIONALITY ,'') AS NATIONALITY,  ISNULL(dbo.CONVERTDATEDMY1(DATE_OF_ISSUE),'-') AS DATE_OF_ISSUE, "+
				         " PLACE_OF_ISSUE,  ISNULL(dbo.CONVERTDATEDMY1(EXPIRY_DATE),'-') AS EXPIRY_DATE,  ECNR,  VISA_REQUIRED,isnull(Return_travel,'n') as Return_travel "+
 				         " FROM     T_GROUP_USERINFO  WHERE   (TRAVEL_ID = "+strTravelId+" ) and travel_type='i' and STATUS_ID=10 order by FIRST_NAME"; 

				  //System.out.println("strSql----------------------------------------------->"+strSql);
	               	   rs       =   dbConBean.executeQuery(strSql);  
				       while(rs.next())
	                           {    
									 strG_userid						=rs.getString("G_USERID");
									 Site_ID                            =rs.getString("Site_id");
									 strFirstName_List		       =rs.getString("FIRST_NAME");
									 strLastName_List				=rs.getString("LAST_NAME");
									 strDesigantion_List			=rs.getString("DESIG");
	                                strDateOfBirth_List			    =rs.getString("DOB");
									 strAge_List							=rs.getString("AGE");
									 strGender_List					=rs.getString("GENDER");
									 	if(strGender_List.equals("1"))
												{
															strSex="Male";
												}
												else
												{
													       strSex="Female";
												}
								     strMealPref_list					=rs.getString("MEALNAME");
									 strTotalForex_list				=rs.getString("TOTAL_AMOUNT");
									 strPassortNo_list				=rs.getString("PASSPORT_NO");
									 strNationality_list			=rs.getString("NATIONALITY");
									 strDateofIssue_list				=rs.getString("DATE_OF_ISSUE");
									 strPlacesofIssue_list         =rs.getString("PLACE_OF_ISSUE");
									 strDateofExpiry_list			=rs.getString("EXPIRY_DATE");  
									 strECNR_list						=rs.getString("ECNR");
	
									 if(strECNR_list!=null)
											{
												if(strECNR_list.trim().equals("1"))
												{
												strEcnr="Yes";
												}
												else if(strECNR_list.trim().equals("2"))
												{
												strEcnr="No";
												}
												else if(strECNR_list.trim().equals("3"))
												{
												strEcnr="N/A";
												}
											}
									 strVisaReqiured_list		     =rs.getString("VISA_REQUIRED");	
									 
									 strReturnTravel		     =rs.getString("Return_travel").trim();	 
									  
									 if(strReturnTravel.equalsIgnoreCase("y"))
									 {
										 strchecked ="checked";
									 }else{
										 strchecked =""; 
									 }
	
									 	 if(strVisaReqiured_list != null && strVisaReqiured_list.equals("1"))
											{
											   strVisaReqiured_list = "Yes";
												 
											 }
											 else if(strVisaReqiured_list != null && strVisaReqiured_list.equals("2"))
												strVisaReqiured_list = "No";
	
									  
										    //finding currency  id from  T_TRAVEL_EXPENDITURE_INT table fro each user
											strSql ="SELECT currency FROM  T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID = "+strTravelId;         
											   //+" and G_userid="+strG_userid;	       
									   rs1= dbConBean1.executeQuery(strSql);
									   while(rs1.next())   
													 {  
													strCurrency = rs1.getString(1);			
													} 
												rs1.close();			   
									 // strCurrency_list		     =rs.getString("CURRENCY"); 
									 //added by manoj on 03 sept to retain checkbox state
												if(strUserids.equalsIgnoreCase("false") && strReturnTravel.equalsIgnoreCase("y")){
													strchecked="";
												}else if(strUserids.equalsIgnoreCase("true") && strReturnTravel.equalsIgnoreCase("n")){
													strchecked="checked";
												}

									 
	                               %> 
	  				  <tr>   
	                <td height="25" class="label5"><div align="center"><%=intSerialNo%>. <input type="checkbox" name="userids" value=<%=strG_userid%>  <%=strchecked %> ><font color="#CC3300" size=1><b>#</b></font> </div></td> 
	                <td class="label5"><div align="left"> &nbsp;<%=strFirstName_List%>  <%=strLastName_List%> </div> 
	                
	                                    
	                 
	                
	                </td>  
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
	                <td class="label5"><div align="center"> <%=strBaseCur%> <%=strTotalForex_list%><br />
	                 <%=strEcnr%> </div></td> 
	                  <td class="label5" style="vertical-align: top;"><div align="center"> <%= strNationality_list%><br/> </div></td> 
	                <td class="label5">
						  
					  <div align="center"><!--  Added a travel type on domestic group travel  development on 02-Jul-08 by shiv sharma   -->
						   <a href="Group_T_IntTrv_Details.jsp?G_userId=<%=strG_userid%>&travelId=<%=strTravelId%>&action=update" onClick="return">  <%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage) %></a> | <a href="G_userDelete.jsp?G_userId=<%=strG_userid%>&travel_id=<%=strTravelId%>&travel_type=i" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage) %> </a></div></td>
					   </tr>
				
			<%		  			
				            intSerialNo++;    
	                       }
					rs.close();	 
					 
					      if(intSerialNo==1)  
						   {  
					       strButtonstate ="2"; 
					       strButtonstate1="disabled";  
						   } 
					     
	  
	}
	 if(intSerialNo==1)  
	   {  
        strButtonstate1="disabled";   
        strTexttoShow="";
        strTexttoShowtraveler="<font color=#CC3300>#</font>"+dbLabelBean.getLabel("message.createrequest.addtravelerinlist",strsesLanguage);
        
	   }else{
		   strTexttoShow="<font color=#CC3300>#</font>"+dbLabelBean.getLabel("message.createrequest.selectcheckboxforreturnjourney",strsesLanguage);    
	   }
	 
	     
	%>
	   	  
				  <input type="hidden" name="todayDate" value="<%=strCurrentDate%>"/> <!--  HIDDEN FIELD  -->
				  <input type="hidden" name="travelReqId" value="<%=strTravelReqId%>"/>
				  <input type="hidden" name="travelId" value="<%=strTravelId%>"/> <!--  HIDDEN FIELD  -->
				  <input type="hidden" name="travelReqNo" value="<%=strTravelReqNo%>"/> 
				  <input type="hidden" name="strFlag" value="<%=strFlag%>"/> 
				  <input type="hidden" name="G_userID" value="<%=strG_userID%>"/> 
				  <input type="hidden" name="pageFlag" value="yes"/>
			
				  <input type="hidden" name="whatAction" value ="<%=strwhatAction%>" > <!--  HIDDEN FIELD  value="<%=strwhatAction%>" -->
				  <input type="hidden" name="currencyflag" value ="<%=strComboDisable%>" > <!--  HIDDEN FIELD  value="<%=strwhatAction%>" -->
				  <input type="hidden" name="saveflag" value=""/>
 				  
	          </table> 
			 </td>
	     </tr>
	    	<tr>
					<td class="label2"><%=strTexttoShow%> 
					</td>
					</tr>   
	               
	       
 
	    </table>  
	   
	    </td>
	  </tr>
	 
	   
   		<%
   		 
   		
		//System.out.println("strTravelId--test ->"+strTravelId);
   		//System.out.println("strGroupinterimflag--test ->"+strGroupinterimflag);
   		
   		if(!strTravelId.equals("") && !strTravelId.equals("new") && strTravelId!=null && !strGroupinterimflag.equalsIgnoreCase("Y")){  
   		strSql ="SELECT t1.TRAVEL_ID, t2.site_id as site_id , t1.TRAVEL_FROM AS TRAVEL_FROM, t1.TRAVEL_TO AS TRAVEL_TO, "+
		   		" dbo.CONVERTDATEDMY1(t1.TRAVEL_DATE) AS TRAVEL_DATE,	t1.TRAVEL_MODE AS TRAVEL_MODE, t1.MODE_NAME AS MODE_NAME, "+ 
		   		" t1.TRAVEL_CLASS AS TRAVEL_CLASS,t1.TIMINGS AS TIMINGS,  t2.REASON_FOR_TRAVEL AS REASON_FOR_TRAVEL,"+ 
		   		" t2.REASON_FOR_SKIP AS REASON_FOR_SKIP"+
		   		" ,t2.HOTEL_REQUIRED,t2.PLACE,t2.HOTEL_BUDGET,t2.BUDGET_CURRENCY, "+
		   		" DBO.CONVERTDATEDMY1(t2.CHECK_IN_DATE) as CHECK_IN_DATE,DBO.CONVERTDATEDMY1(t2.CHECK_OUT_DATE) AS CHECK_OUT_DATE,t2.REMARKS"+
		   		", ISNULL(t2.BILLING_SITE, '-1') AS BILLING_SITE, "+           
		   		" ISNULL(t2.BILLING_CLIENT, '-1') AS BILLING_CLIENT, ISNULL(t2.MANAGER_ID,0) AS MANAGER_ID," + 
		   		" ISNULL(t2.HOD_ID,0)  AS HOD_ID,	isnull(t2.CASH_BREAKUP_REMARKS,'') as  CASH_BREAKUP_REMARKS,isnull(t1.SEAT_PREFFERED,'1') as SEAT_PREFFERED, TS.LINKED_TRAVEL_ID  FROM   "+
		   		" T_JOURNEY_DETAILS_INT t1 INNER JOIN T_TRAVEL_DETAIL_INT t2 ON t1.TRAVEL_ID = t2.TRAVEL_ID INNER JOIN T_TRAVEL_STATUS TS ON t2.TRAVEL_ID=TS.TRAVEL_ID AND TS.TRAVEL_TYPE='I' WHERE "+ 
		   		" (t1.TRAVEL_ID = "+strTravelId+") AND (t1.APPLICATION_ID = 1) AND (t1.STATUS_ID = 10) AND (t2.STATUS_ID = 10) AND T1.JOURNEY_ORDER=1 "; 
   		
		//System.out.println("strSql----group/international--->"+strSql);
   		
        String strSite_id="";
        rs       =   dbConBean.executeQuery(strSql);   

         while(rs.next())
         {  
			    strSite_id          =rs.getString("site_id");  
				strDepCity          =rs.getString("TRAVEL_FROM"); 
				strArrCity          =rs.getString("TRAVEL_TO"); 
				strDepDate          =rs.getString("TRAVEL_DATE"); 
				strTravelMode       =rs.getString("TRAVEL_MODE"); 
			    strNameOfAirline    =rs.getString("MODE_NAME"); 
			    strTravelClass    =rs.getString("TRAVEL_CLASS"); 
				strPreferTime        =rs.getString("TIMINGS"); 
				
				if(strTravelClass==null || strTravelClass.equals("") || strTravelClass.equals("0") ) {     
					strTravelClass="1";
				} 
			 	if (strPreferTime.equals(""))
			        { 
					strPreferTime="2";
				}
			 	//ADDED BY MANOJ CHAND ON 21 SEP 2011 TO FETCH ACCOMODATION DETAILS
			 		strHotelRequired=rs.getString("HOTEL_REQUIRED");
			 		if(strHotelRequired.trim().equalsIgnoreCase("")){
			 			strHotelRequired="0";
			 		}
			 		strPlace=rs.getString("PLACE");
			 		strHotelBudget=rs.getString("HOTEL_BUDGET");
			 		strBudgetCurrency=rs.getString("BUDGET_CURRENCY");
			 		if(strBudgetCurrency.trim().equalsIgnoreCase("")){
			 			strBudgetCurrency="USD";
			 		}
			 		strCheckin=rs.getString("CHECK_IN_DATE");
			 		strCheckout=rs.getString("CHECK_OUT_DATE");
			 		strRemarks=rs.getString("REMARKS");
			 	// END HERE
			 	
			      strSeatPreffered     =  rs.getString("SEAT_PREFFERED");
			      strCancelledReqId = rs.getString("LINKED_TRAVEL_ID");

          }
         rs.close();
   	} 
  		
		%>
	   </table>
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		            <tr>
			          <TD width="65%" class=formfirstfield vAlign=bottom align=left  
		                		bgColor=#FFFFFF colSpan=2 height=25><%=dbLabelBean.getLabel("label.global.itineraryinfo",strsesLanguage)%>  <%//=strMessage %> </TD>
		               <td width="520px" height="25" class="label1" align="right" style="padding-right:5px;">
	                  <%if(strShowCancelledRegflag.equalsIgnoreCase("y")){ %>
	                  <div style="width:480px; float: right;">
	                  	<table width="400px" border="0" cellspacing="0" cellpadding="0" align="right" id="linkCanReqTbl">
	                  		<tr>
	                  			<td width="175px">
	                  				<span class="label1"><%=dbLabelBean.getLabel("label.global.linkwithcancelledrequest",strsesLanguage)%>&nbsp;&nbsp;</span>
	                  			</td>
	                  			<td width="220px">
		                  			<select name="cancelledTravelReq" id="cancelledTravelReq" class="textBoxCss" style="width:100%;">
									<option value="0"><%=dbLabelBean.getLabel("label.global.selectcancelledrequest",strsesLanguage)%></option>
									<%
										strSql = " SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+
												" WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =6 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+Suser_id+" OR TD.C_USERID="+Suser_id+") "+ 
												" AND (CONVERT(DATE,TD.C_DATETIME) BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE()) OR  TD.TRAVEL_DATE BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE())) AND TD.Group_Travel_Flag='Y' "+  
												" UNION "+  
												" SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+   
												" INNER JOIN (SELECT TRAVEL_ID,TJDI.JOURNEY_ORDER,TRAVEL_DATE FROM T_JOURNEY_DETAILS_INT TJDI WHERE STATUS_ID=10 "+
												" UNION "+
												" SELECT TRAVEL_ID,9999,TRAVEL_DATE FROM T_RET_JOURNEY_DETAILS_INT WHERE YEAR(TRAVEL_DATE)<>1900 AND TRAVEL_DATE IS NOT NULL)DRV ON TD.TRAVEL_ID=DRV.TRAVEL_ID "+
												" WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =10 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+Suser_id+" OR TD.C_USERID="+Suser_id+") AND TD.Group_Travel_Flag='Y' "+  
												" GROUP BY TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID HAVING CONVERT(DATE,GETDATE()) BETWEEN MIN(DRV.TRAVEL_DATE) AND MAX(DRV.TRAVEL_DATE) ";
										
										rs = dbConBean.executeQuery(strSql);  
										
										while(rs.next()) {	
											if("6".equals(rs.getString("TRAVEL_STATUS_ID"))) {
										%> 
										  		<option value="<%=rs.getString("TRAVEL_ID")%>"><%=rs.getString("TRAVEL_REQ_NO")%>-(<%=dbLabelBean.getLabel("label.requestdetails.cancelled",strsesLanguage)%>)</option>
										<%
											} else if("10".equals(rs.getString("TRAVEL_STATUS_ID"))) {
										%> 
										  		<option value="<%=rs.getString("TRAVEL_ID")%>"><%=rs.getString("TRAVEL_REQ_NO")%>-(<%=dbLabelBean.getLabel("label.requestdetails.onair",strsesLanguage)%>)</option>
										<%		
											}
							             }
							              rs.close();
										%>
								</select>
	                  			</td>
	                  		</tr>
	                  	</table>							
							<script language="javascript">
							document.frm.cancelledTravelReq.value="<%=strCancelledReqId%>";
                            </script>
	                  </div>
							
						<% } %>
						</td>
		            </TR>
		            <tr>
		            <td colspan="7">
		            <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" style="border-style:solid;border-color:#F0F0F0;border-collapse: collapse;"> 
	                <tr class=formtxt>
	                <td colspan="7">
	                <table border="0" width="100%">
	                <tr>
	                	<td height="15"   class="label1"><%=dbLabelBean.getLabel("label.global.forwardjourney",strsesLanguage)%><span  class=starcolour>*</span></td>
	                </tr>
	                
	                <tr>
	                  <td height="25" colspan="2"> 
					  <table width="99%" border="0" cellspacing="0" cellpadding="0">   
	                    <tr>
	                      <td width="18%" class="label2"><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%><span class=starcolour></span></td>
	                      <td width="18%" class="label2">&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%> <span class=starcolour></span></td>
	                      <td width="13%" class="label2"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%></td>
	                      <td width="12%" class="label2"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%></td>
	                      <td width="17%" class="label2"><%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%></td>
	                      <td width="12%" class="label2"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%></td>
	                      <td width="10%" class="label2"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%></td>
	                      </tr> 
	                    <tr>
	                      <td height="25" width="18%"><input type="text" name="depCity" class="textBoxCss"   value="<%=strDepCity%>"  onFocus="initializeAirPortName(this);" onkeyup="return test1('depCity', 30, 'c')" maxlength="30" />
	                      </td>
	
							 <script language="javascript">
	                              document.frm.depCity.value="<%=strDepCity%>";
	                        </script>	
	                      <td class="label2" width="18%">&nbsp;&nbsp;<input type="text" name="arrCity" class="textBoxCss"   value="<%=strArrCity%>"  onFocus="initializeAirPortName(this);" onkeyup="return test1('arrCity', 30, 'c')" maxlength="30"/>
	                     </td>
	  						 <script language="javascript">
	                              document.frm.arrCity.value="<%=strArrCity%>";
	                        </script>	
	
	                      <td class="label2" width="13%"><!--Reaching Date at Destination--><input name="depDate" type="text" class="textBoxCss" id="test2" size="6" value="<%=strDepDate%>" onfocus="javascript:vDateType='DD/MM/YYYY'" 	onkeyup="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter');" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" /><a  onMouseOver="window.status='Date Picker';return true;" onmouseout="window.status='';return true;" onclick="button_onclick(document.frm.depDate);" >
	                            <img   height=15 alt=Calender src="images/calender.png?buildstamp=2_0_0"  width="18"    /></a><!-- <a href="javascript:show_calendar('frm.depDate','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
							<img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a> -->
							</td>
							<script language="javascript"> 
	                              document.frm.depDate.value="<%=strDepDate%>";
	                        </script>	
	                      <td width="12%"> 
	                       <select name="preferTime" class="textBoxCss">
							<%
	                        //For Population of Prefer Timing Combo 
	                             strSql =   "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY DISPLAY_ORDER ASC";
	                             rs       =   dbConBean.executeQuery(strSql);  
	                             while(rs.next())
	                             {
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
	                        var pftime='<%=strPreferTime%>';
	                          if(pftime==''){
	                            document.frm.preferTime.value="2"; 
	                            }else{
	                            document.frm.preferTime.value="<%=strPreferTime%>";
	                            }
	                        </script>
	                        </td>
	                        
	                        
	                        
	                      <td class="label2" width="17%"><input type="text" name="nameOfAirline" class="textBoxCss"   value="<%=strNameOfAirline %>"  onKeyUp="return test1('nameOfAirline', 30, 'cn')" maxlength="30" />
	                      </td>
	
						   <script language="javascript">
	                              document.frm.nameOfAirline.value="<%=strNameOfAirline%>"; 
	                        </script>	
	                      <td class="label2" width="12%">
						  <select name="travelClass" class="textBoxCss">
						  					  <%
	                     //For Population of Travel Class Combo For Departure
						       if(strTravelMode.equals("2"))
	                                  strSql =   "SELECT TRAIN_ID, ELIGIBILITY FROM M_TRAIN_CLASS WHERE STATUS_ID=10";
	                           else
							          strSql =   "SELECT AIR_ID, ELIGIBILITY FROM M_AIRLINE_CLASS WHERE STATUS_ID=10";
	                           
										   rs       =   dbConBean.executeQuery(strSql);  
										   while(rs.next()) 
										   {
													%>
											 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
													<%
										   }
										   rs.close();	  
									%></select>
									</td>
	                      
							<script language="javascript">                     
							
							var fclass='<%=strTravelClass%>';
							
							if(fclass==''){ 							 
							    }else{
							    document.frm.travelClass.value="<%=strTravelClass%>";  
							    } 
	                        </script>	 		
	                      <td width="10%"><select name="seatpreference" class="textBoxCss">  
						  					  <%                
	                     //For Population of Travel Class Combo For Departure  
						        
							          strSql =   "SELECT  seat_id, Seat_Name FROM  M_SEAT_PREFER (NOLOCK) WHERE  mode_id=1 AND (TRAVEL_AGENCY_ID = 1) and (STATUS_ID = 10) ORDER BY SEAT_ID";
	                           
										   rs       =   dbConBean.executeQuery(strSql);  
										   while(rs.next())
										   {
													%>
											 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
													<% 
										   }
										   rs.close();	
										   //dbConBean.close();
										   dbConBean1.close();
									%></select>
									</td>
	                      
							<script language="javascript">
							
	                           var seat='<%=strSeatPreffered%>';
							   if(seat==''){
	                               document.frm.seatpreference.value="1";   
	                            }else{
	                            document.frm.seatpreference.value="<%=strSeatPreffered%>";  
	                            }
	                        </script> <!-- end here  -->
	                     
	                      </tr>
	                  </table></td>
	                </tr>
	               <!--  <tr>
	                  <td class="label1">&nbsp;</td> 
	                </tr> -->
	               </table>
	                </td>    
	         </tr>
<!-- added by manoj chand -->
<script language="Javascript">

function fun_changecurr(){
	document.frm.place.focus();
}

function MM_openBrWindow()
{ 
 var var_depcity=document.frm.depCity.value;
 var var_arrcity=document.frm.arrCity.value;
 var var_depdate=document.frm.depDate.value;
 var var_preftime=document.frm.preferTime.value;
 var var_prefair=document.frm.nameOfAirline.value;
 var var_trvclass=document.frm.travelClass.value;
 var var_prefseat=document.frm.seatpreference.value;
 var var_hotel=document.frm.hotel.value;
 var var_currency=document.frm.currency.value;
 var var_place=document.frm.place.value;
 var var_budget=document.frm.budget.value;
 var var_checkin=document.frm.checkin.value;
 var var_checkout=document.frm.checkout.value;
 var var_otherComment=document.frm.otherComment.value;
 
 if(document.frm.userids!=undefined){
 var var_userids=document.frm.userids.checked;
 }else
	 var_userids='';
 

	
  var id =	document.frm.interimId.value;
  window.open('Group_InternationalInterimJourney.jsp?interimTravelId='+id+'&actualTravelId=<%=strTravelId%>&depCity='+var_depcity+'&arrCity='+var_arrcity+'&depDate='+var_depdate+'&preferTime='+var_preftime+'&nameOfAirline='+var_prefair+'&travelClass='+var_trvclass+'&seatpreference='+var_prefseat+'&hotel='+var_hotel+'&currency='+var_currency+'&place='+var_place+'&budget='+var_budget+'&checkin='+var_checkin+'&checkout='+var_checkout+'&otherComment='+var_otherComment+'&userids='+var_userids,'SEARCH','scrollbars=yes,resizable=yes,width=800,height=480');
}
function setId(id) 
{
	document.frm.interimId.value = id;
}
function transitOnClick(f1){
		var hotelValue = f1.hotel.value;
		if(hotelValue != null && hotelValue == '0')
		{
			document.getElementById('hidethis').style.display = 'none';
			f1.budget.value="";
			f1.budget.disabled=true;
			f1.currency.disabled=true;
			f1.checkin.disabled=true;
			f1.checkout.disabled=true;
			f1.place.disabled=true;
		}else
		{
			if(hotelValue != null && hotelValue == "1"){
				document.getElementById('hidethis').style.display = 'none'; 
			}
			if(hotelValue != null && hotelValue == "2"){
				document.getElementById('hidethis').style.display = ''; 
			}
			f1.budget.disabled=false;
			f1.place.disabled=false;
			f1.currency.disabled=false;
			f1.checkin.disabled=false;
			f1.checkout.disabled=false;
			f1.place.disabled=false;
			f1.place.focus();
		}	
	}
</script>
	          <tr>
	        	<td valign="top" width="42%" style="border-style: solid;border-color:#F0F0F0;">
	        	<table align="left" border="0"  width="100%" cellpadding="0" cellspacing="0">
	        	  <tr>
	                  <td valign="middle" height="20" class="linkLabel">
	                  &nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="MM_openBrWindow()"><%=dbLabelBean.getLabel("link.global.intermediatejourney",strsesLanguage)%></a>
	                  </td>
	                 </tr>
					 <tr>
					   <td height="30" colspan="4" valign="top" class="formtxt2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.interimflights",strsesLanguage)%></td>
                    </tr>
                </table>
	        	</td>
	        	<td valign="top" style="vertical-align: top" width="58%" style="border-style: solid;border-color:#F0F0F0;">
	        	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	        	<tr>
	        	<td colspan="4" class="label1" valign="middle" height="20" >&nbsp;<%=dbLabelBean.getLabel("label.global.accomodationrequired",strsesLanguage)%><span class="starcolour">*</span></td>
            	</tr>
            	<tr>
               <td  height="18" width="25%" valign="bottom" class="label2">&nbsp;<%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage)%></td>
               <td  height="18" width="25%" align="left" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%></td>
               <td  height="18" width="25%" align="left"   valign="bottom"  class="label2"><%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%></td>
               <td height="18" width="25%" align="left" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%></td>
            	</tr>
            	 
               <tr>
			   <td height="18" width="25%" valign="top">&nbsp;<select name="hotel" class="textBoxCss" onchange="return transitOnClick(this.form);" >
						<option value = "0"><%=dbLabelBean.getLabel("label.global.na",strsesLanguage)%></option>
						<option value="1"><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
						<option value = "2"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
					</select>&nbsp;&nbsp;
					<script language="javascript">
                			document.frm.hotel.value= "<%=strHotelRequired.trim()%>"; 
		        		</script> 
			   </td>
				
			   <td align="left" width="25%" valign="top" height="18"><select name="currency" class="textBoxCss" onchange="fun_changecurr();"><!--BUDGET CURRENCY-->
<%
                       strSql =   "Select Currency, Currency from m_currency (NOLOCK) where status_id=10";
         			   rs       =   dbConBean.executeQuery(strSql);  
					   while(rs.next())
                       {                       
%>
                          <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%
                       }
                       rs.close();
                       dbConBean.close();
%>						
                 </select>
				 <script language="javascript">
                       document.frm.currency.value="<%=strBudgetCurrency%>";
                 </script>
               </td>
               <td height="18" width="25%"  align="left" valign="top"><span class="label2"></span><span class="label2"><input name="place" type="text" value="<%=strPlace%>" size="13"  class="textBoxCss" onKeyUp="return test1('place',20, 'c')" maxlength="20"/></span></td>
               <td height="18" width="25%"  align="left" valign="top"><span class="label2">
               <input name="budget" type="text"  size="10"  class="textBoxCss" maxlength="10"  value="<%=strHotelBudget%>" onkeyup="return test1('budget',12, 'n')" />
			      </span></td>
             </tr>
             
              <!-- Transit house message added by manoj chand on 24 april 2012 -->
						 <tr id="hidethis" style="display: none;">
						 	<td colspan="4" height="15" class="formtxt2" ><span style="color: red;">&nbsp;<%=dbLabelBean.getLabel("label.global.smokingmessage",strsesLanguage)%></span></td>
						 </tr>
             
             <tr>                                                            
				  <td  width="25%"  class="label2">&nbsp;<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%></td>
				  <td  width="25%" align="left"  class="label2"><%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%></td>
				 <td  width="25%" colspan="2"  class="label2"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
			 </tr>
            	 <tr><td width="25%" height="18" valign="top">&nbsp;<input name="checkin" type="text" class="textBoxCss" id="test223" size="6" onfocus="javascript:vDateType='DD/MM/YYYY'"
									onkeyup="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onblur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onchange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"/><a 
									onmouseover="window.status='Date Picker';return true;"
									onmouseout="window.status='';return true;" onclick="button_onclick1(document.frm.checkin);">&nbsp;<img border="0" height="15px" width="18px" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></img></a>
					 <script language="javascript">
                        document.frm.checkin.value="<%=strCheckin%>";
                     </script>
				  </td>
				  
				  <td height="18" width="25%" align="left" valign="top"><input name="checkout" type="text" class="textBoxCss" id="test224" size="6" onFocus="javascript:vDateType='DD/MM/YYYY'"
									onkeyup="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onblur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onchange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"/>
									<a onmouseover="window.status='Date Picker';return true;"
									onmouseout="window.status='';return true;"
									onclick="button_onclick1(document.frm.checkout);"><img border="0" height="15px" width="18px" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="top"></img></a>
	                  <script language="javascript">
                       document.frm.checkout.value="<%=strCheckout%>";
                      </script>  				  </td>	
                      						
			      <td height="18" width="25%" colspan="2" class="label2"   >
			      <textarea  name="otherComment" cols="40" class="textBoxCss" onkeyup="return test1('otherComment', 200, 'all')" onblur="this.value=removeSpaces(this.value);"><%=strRemarks%></textarea>
			      </td>
			 </tr>
            	<!-- JAVA SCRIPT for setting the Accomodation detail enable or disable according the transit type -->
  		     <script language="javascript">
                  var aa ="<%=strHotelRequired.trim()%>";
				  if(aa != null && aa == "0")
				  {
					   //alert("hotel value no is=="+aa);
					   document.frm.budget.disabled=true;
					   document.frm.place.disabled=true;
					   document.frm.currency.disabled=true;
					   document.frm.checkin.disabled=true;
					   document.frm.checkout.disabled=true;
				  }
			 </script> 
            	 <tr>
               <td height="25" colspan="4" class="formtxt2">&nbsp;<%=dbLabelBean.getLabel("label.global.requirehotelthenspecifyhotelbudget",strsesLanguage)%></td>
             </tr>
            
	        	</table>
	        	</td>
	        	
	        	
	         </tr>
	 <!-- End here -->        
	   <% if(strButtonstate.equals("2")){ %>
	                      
	                    <tr>  
	                
	                       <td height="5"  colspan="9" class="label2"  align="right" ><font color="#CC3333" > <%=dbLabelBean.getLabel("label.global.addtravelerbeforproceedingtonext",strsesLanguage)%>    
	                       &nbsp;&nbsp;  
	        	           </td>         
	                </tr>
	                <%} %>
	         
		               <tr>  
	                	<td colspan="2" style="border-style: solid;border-color:#F0F0F0;">    
	               			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="newformbot" > 
	        	                 <tr height="8">  
	        	                      <td colspan="9">   
	    					              <div align="right"> 
	    					                 <input type="button" name="Submit4" style="height: 22px;" value="  <%=dbLabelBean.getLabel("label.global.exit",strsesLanguage)%>  "    class="formButton"  onClick="return ExitPage(this.form);"/>
						                    <input type="button" name="Submit5" style="height: 22px;" value="  <%=dbLabelBean.getLabel("button.global.save",strsesLanguage)%>  "   class="formButton" <%=strButtonstate1%>   onclick="return save(this.form,'save');"/>
										    <input type="button" name="Submit2" id="Submit2" style="height: 22px;" value="  <%=dbLabelBean.getLabel("button.global.next",strsesLanguage)%>  "   class="formButton"     <%=strButtonstate1%>   onclick="NextPage(this.form,'<%=strButtonstate%>');"  /> 
					            	      </div></td>  
	            				     
				               </tr>
	        		       </table>
	               	   </td>
	             </tr> 
	    </table>
	    </td>
	    </tr>
	   
	    </table>
	    </td>
	    </tr>
	    
	     
	    </table>
	    </td>
	    <td width="11" background="images/index_03.png?buildstamp=2_0_0"><img src="images/index_03.png?buildstamp=2_0_0" alt="" width="14" height="426" /></td>
	    </tr>
	    <tr>
    <td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
    <td height="20" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
    <td width="11" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
  </tr>
	    </table>
	    </td>
	    </tr>
	    </table>
	    </td>
	    </tr>
	    </table>
	     <input type ="hidden" name = "interimId"  value = "<%= strIntermiId %>" />
	    </form>
	    </html>
	    
<script type="text/javascript">
	var fNameVal ="";
	var fNameFlag = false;	
	var selectedDesigId = $("select#desigId option:selected").val();
	
	
	// initialize Guest name from database 
	function initializeGuestName(elId) {
		var timerGuestList;
   		var typingTimerGuestList;              
   	   	var getGuestListInterval = 200; 
   	   	
   	   	$(elId).keyup(function() { 
   	   		if (timerGuestList) { 
   	   			timerGuestList.abort();
   	   		} 
   	   	    clearTimeout(typingTimerGuestList);
   	   	    if ($(elId).val()) {
   	   	        typingTimerGuestList = setTimeout(function() {
   	   	        	timerGuestList = getGuestList(elId);	
   	   	        }, getGuestListInterval);
   	   	    }
   	   	});	   	
	}
   	
   	function getGuestList(elId) {
   		var siteId = $("select#siteId option:selected").val();
   		var cUserId = '<%=Suser_id%>';
   		
   	   	$(elId).autocomplete({
   	    	minLength: 3,
   	   		delay: 500,
			source : function(request, response) {
				//fName = "";            	
	            $.ajax({
	            	 type: "get",
					 url: "AutoCompleteGroupGuestDetailServlet",
					 data: { fName: $(elId).val(), siteId: siteId, cUserId:  cUserId, travelType:  "I", flag:"getGuestList" },
	                 dataType: "json",
	                 success: function( data ) {                                           
	                        response( $.map( data, function( item ) {
	                            return {                                    
	                                    label: item.TRAVELLER,
	                                    value: item.GUSERID	                                                                                                        
	                                   }
	                        }));
	                    }					 
	            	});
		    	},
		    	select: function (event, ui) {
		    		
		    			fNameFlag = true;
		    			fNameVal = $("#fNameId").val(); 		    		
		    			var rdata = ui.item.value;    		
	    			  	getGuestDetail(rdata);
		    	},
		        focus: function (event, ui) {
		        	
		        	event.preventDefault(); // Prevent the default focus behavior.	
		        	fNameFlag = true;
	    			fNameVal = $("#fNameId").val(); 		    		
	    			var rdata = ui.item.value;    		
    			  	getGuestDetail(rdata);
		        }
			});
   	   	}
   	
   	function getGuestDetail(gUserId) {   		
   		var flag="getGuestDetail";
   		var siteId = $("select#siteId option:selected").val();
   		var cUserId = '<%=Suser_id%>';
   		var travelType = "I";
   		
   	 	var urlParams="flag="+flag+"&siteId="+siteId+"&cUserId="+cUserId+"&gUserId="+gUserId+"&travelType="+travelType;
   	   $.ajax({
   	           type: "get",
   	           url: "AutoCompleteGroupGuestDetailServlet",
   	           data: urlParams,
   	           dataType : 'json',
   	           success: function(result) {
   	        	clearGuestDetails();
   				if(result!=null) {   					
	   					$("#fNameId").val(result.FIRSTNAME);
	   					$("#lNameId").val(result.LASTNAME);
	   					$("#passport_DOB").val(result.DOB);
	   					FindAge();
	   					$("#passportNoId").val(result.PASSPORTNO);
	   					$("#nationality").val(result.NATIONALITY);
	   					$("#passportIssueDtId").val(result.DATEISSUE);
	   					$("#passportExpireDtId").val(result.EXPIRYDATE);
	   					$("#passportIssuePlaceId").val(result.PLACEISSUE);
	   					
	   					var designId = result.DESIGNATION;
	   					$("select#desigId").val(designId);
	   					
	   					var genderId = result.GENDER;
	   					$("select#genderId").val(genderId);
	   					
	   					var mealId = result.MEALPREF;
	   					$("select#mealId").val(mealId);
	   					
	   					var visaReq = result.VISA;				
	   					if(visaReq == 1) {
						    document.frm.visa[0].checked=true;
					    } else {
							document.frm.visa[1].checked=true;
					    }
	   		
	   					var ecnrReq = result.ECNR;
	   					if(ecnrReq == 1) {
							document.frm.ECR[0].checked=true;								
						} else if(ecnrReq == 2) {
							document.frm.ECR[1].checked=true;								
						} else if(ecnrReq == 3) {
							document.frm.ECR[2].checked=true;								
						} 
	   					$("#passport_DOB").css('color', '#000000');
	   					$("#passportIssueDtId").css('color', '#000000');
	   					$("#passportExpireDtId").css('color', '#000000');
   				 	}
   	        	}
   	     });
   	}
   	
   	
   	  
   
   	
   	$('#fNameId').on("change keyup", function() {
   		if($(this).val() == ""){
   			clearGuestDetails();
   		} else if(fNameFlag && $(this).val()!=fNameVal){
   			clearGuestDetails();   
   		}
   	});
   	
   	function clearGuestDetails() {  		
		$("#lNameId").val("");
		$("#passport_DOB").val("");
		$("#passportNoId").val("");
		$("#nationality").val("");
		$("#passportIssueDtId").val("");
		$("#passportExpireDtId").val("");
		$("#passportIssuePlaceId").val("");
		$("select#genderId").val("-1");
		$("select#mealId").val("6");
		$("select#desigId").val(selectedDesigId);
		document.frm.ECR[1].checked=true;
		document.frm.visa[1].checked=true;
		
		if ($("#passport_DOB").val() == '' || $("#passport_DOB").val() == $("#passport_DOB").attr('placeholder')) {
			$("#passport_DOB").css('color', '#7a7a7a');
			$("#passport_DOB").val($("#passport_DOB").attr('placeholder'));
		}
		if ($("#passportIssueDtId").val() == '' || $("#passportIssueDtId").val() == $("#passportIssueDtId").attr('placeholder')) {
			$("#passportIssueDtId").css('color', '#7a7a7a');
			$("#passportIssueDtId").val($("#passportIssueDtId").attr('placeholder'));
		}
		if ($("#passportExpireDtId").val() == '' || $("#passportExpireDtId").val() == $("#passportExpireDtId").attr('placeholder')) {
			$("#passportExpireDtId").css('color', '#7a7a7a');
			$("#passportExpireDtId").val($("#passportExpireDtId").attr('placeholder'));
		}
		
		ageClear();
   	}
   	
	jQuery(document).ready(function($) {
   		$("select#cancelledTravelReq").change();
   	});
</script>    
	