	$(function() {		
		// set placeholder on page load
		if ($.browser.msie && $.browser.version <= 9) {
			$('[placeholder]').focus(function() {
				var input = $(this);
				if (input.val() == input.attr('placeholder')) {
					input.val('');
					input.css('color', '#000000');
				}
			});
			$('[placeholder]').blur(function() {
				var input = $(this);
				if (input.val() == '' || input.val() == input.attr('placeholder')) {
					input.css('color', '#7a7a7a');
					input.val(input.attr('placeholder'));
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
   	
   	// set date 
   	function initializeDate(elId) {
		$(elId).datepick({
		    dateFormat: 'dd/mm/yyyy',
		    changeMonth: true,
		    changeYear: true,
		    yearRange: "-100:+30", // magic!
		    onSelect: function(dateText, inst) { $(this).css('color', '#000000'); }
		}).click(function () { $(elId).focus(); });	
	}
   	
   	function initializeDOBDate(elId) {
		$(elId).datepick({
		    dateFormat: 'dd/mm/yyyy',
		    changeMonth: true,
		    changeYear: true,
		    yearRange: "-100:+30", // magic!
		    onSelect: function(dateText, inst) { $(this).css('color', '#000000'); },
		    onClose: function(dateText, inst) { FindAge(elId); }
		}).click(function () { $(elId).focus(); });	
	}
   	
 	function initializeJourneyDateFlt(elId, datePlcHldr) {
 		var elIdIndex = $(elId).closest('body').find('.validDateFlt').index(elId);	
 		var setDate = new Date();
 		var dt = 0;
 		var flag = false; 		
 		$('.validDateFlt').each(function(index) {			
 			var dateVal = $(this).val();	
 			var dateValParts = dateVal.split("/");
 			if((parseInt(index) < parseInt(elIdIndex)) && dateVal != "" && dateVal != datePlcHldr) {	
 				flag = true;
 				dt = new Date(Number(dateValParts[2]), Number(dateValParts[1]) - 1, Number(dateValParts[0]));
 			}
 		}); 	

 		if(flag) {
 			setDate = new Date();
 			setDate = dt;	
 		} 	

 		$(elId).datepick({			
 			dateFormat: 'dd/mm/yyyy',
 			minDate: new Date(setDate),		
 			onSelect: function(dateText, inst) { $(this).css('color', '#000000'); },
 			onClose: function(dateText, inst) {
 				var elIdVal = $(elId).val();
 				var elIdValParts = elIdVal.split("/");
 				var elIdDate = new Date(Number(elIdValParts[2]), Number(elIdValParts[1]) - 1, Number(elIdValParts[0]));		    			    	
 				$('.validDateFlt').each(function(thisIndex) {	
 					var thisVal = $(this).val();
 					var thisValParts = thisVal.split("/");
 					var thisDate = new Date(Number(thisValParts[2]), Number(thisValParts[1]) - 1, Number(thisValParts[0]));		    		
 					if(parseInt(thisIndex) > parseInt(elIdIndex) && thisDate < elIdDate) {
 						$(this).val(elIdVal);
 					}
 				});			    	
 				$(elId).datepick("destroy");
 			}
 		}).click(function () { $(elId).focus(); });		
 	}

 	function initializeJourneyDateTrn(elId, datePlcHldr) {
 		var elIdIndex = $(elId).closest('body').find('.validDateTrn').index(elId);	
 		var setDate = new Date();
 		var dt = 0;
 		var flag = false; 		
 		$('.validDateTrn').each(function(index) {			
 			var dateVal = $(this).val();	
 			var dateValParts = dateVal.split("/");
 			if((parseInt(index) < parseInt(elIdIndex)) && dateVal != "" && dateVal != datePlcHldr) {	
 				flag = true;
 				dt = new Date(Number(dateValParts[2]), Number(dateValParts[1]) - 1, Number(dateValParts[0]));
 			}
 		}); 	

 		if(flag) {
 			setDate = new Date();
 			setDate = dt;	
 		} 		

 		$(elId).datepick({
 			dateFormat: 'dd/mm/yyyy',
 			minDate: new Date(setDate),		
 			onSelect: function(dateText, inst) { $(this).css('color', '#000000'); },
 			onClose: function(dateText, inst) {
 				var elIdVal = $(elId).val();
 				var elIdValParts = elIdVal.split("/");
 				var elIdDate = new Date(Number(elIdValParts[2]), Number(elIdValParts[1]) - 1, Number(elIdValParts[0]));		    			    	
 				$('.validDateTrn').each(function(thisIndex) {	
 					var thisVal = $(this).val();
 					var thisValParts = thisVal.split("/");
 					var thisDate = new Date(Number(thisValParts[2]), Number(thisValParts[1]) - 1, Number(thisValParts[0]));		    		
 					if(parseInt(thisIndex) > parseInt(elIdIndex) && thisDate < elIdDate) {
 						$(this).val(elIdVal);
 					}
 				});			    	
 				$(elId).datepick("destroy");
 			}
 		}).click(function () { $(elId).focus(); });		
 	}


 	function initializeJourneyDateCar(elId, datePlcHldr) {
 		var elIdIndex = $(elId).closest('body').find('.validDateCar').index(elId);	
 		var setDate = new Date();
 		var dt = 0;
 		var flag = false; 		
 		$('.validDateCar').each(function(index) {			
 			var dateVal = $(this).val();	
 			var dateValParts = dateVal.split("/");
 			if((parseInt(index) < parseInt(elIdIndex)) && dateVal != "" && dateVal != datePlcHldr) {	
 				flag = true;
 				dt = new Date(Number(dateValParts[2]), Number(dateValParts[1]) - 1, Number(dateValParts[0]));
 			}
 		}); 	

 		if(flag) {
 			setDate = new Date();
 			setDate = dt;	
 		} 		

 		$(elId).datepick({
 			dateFormat: 'dd/mm/yyyy',
 			minDate: new Date(setDate),		
 			onSelect: function(dateText, inst) { $(this).css('color', '#000000'); },
 			onClose: function(dateText, inst) {
 				var elIdVal = $(elId).val();
 				var elIdValParts = elIdVal.split("/");
 				var elIdDate = new Date(Number(elIdValParts[2]), Number(elIdValParts[1]) - 1, Number(elIdValParts[0]));		    			    	
 				$('.validDateCar').each(function(thisIndex) {	
 					var thisVal = $(this).val();
 					var thisValParts = thisVal.split("/");
 					var thisDate = new Date(Number(thisValParts[2]), Number(thisValParts[1]) - 1, Number(thisValParts[0]));		    		
 					if(parseInt(thisIndex) > parseInt(elIdIndex) && thisDate < elIdDate) {
 						$(this).val(elIdVal);
 					}
 				});			    	
 				$(elId).datepick("destroy");
 			}
 		}).click(function () { $(elId).focus(); });		
 	}

 	function initializeAccommoDate(elId, chkinDatePlcHldr, chkoutDatePlcHldr) {
 		var elIdIndex = $(elId).closest('body').find('.validDateAccom').index(elId);
 		var setDate = new Date();
 		var dt = 0;
 		var flag = false; 		
 		$('.validDateAccom').each(function(index) {			
 			var dateVal = $(this).val();	
 			var dateValParts = dateVal.split("/");
 			if((parseInt(index) < parseInt(elIdIndex)) && dateVal != "" && (dateVal != chkinDatePlcHldr || dateVal != chkoutDatePlcHldr)) {
 				flag = true;
 				dt = new Date(Number(dateValParts[2]), Number(dateValParts[1]) - 1, Number(dateValParts[0]));
 			}
 		}); 

 		if(flag) {
 			setDate = new Date();
 			setDate = dt;	
 		} 				

 		$(elId).datepick({
 			dateFormat: 'dd/mm/yyyy',
 			minDate: new Date(setDate),	
 			onSelect: function(dateText, inst) { $(this).css('color', '#000000'); },
 			onClose: function(dateText, inst) {		    	
 				var elIdVal = $(elId).val();
 				var elIdValParts = elIdVal.split("/");
 				var elIdDate = new Date(Number(elIdValParts[2]), Number(elIdValParts[1]) - 1, Number(elIdValParts[0]));		    			    	
 				$('.validDateAccom').each(function(thisIndex) {	
 					var thisVal = $(this).val();
 					var thisValParts = thisVal.split("/");
 					var thisDate = new Date(Number(thisValParts[2]), Number(thisValParts[1]) - 1, Number(thisValParts[0]));		    		
 					if(parseInt(thisIndex) > parseInt(elIdIndex) && thisDate < elIdDate) {
 						$(this).val(elIdVal);
 					}
 				});			    	
 				$(elId).datepick("destroy");
 			}
 		}).click(function () { $(elId).focus(); });		
 	}
 	
 	var XMLHttpRequestObject = false;
 	function ajaxObject() {
 		if(window.XMLHttpRequest) {  
 		  XMLHttpRequestObject = new XMLHttpRequest();
 		} else if(window.ActiveXObject) {
 		  try {
 			XMLHttpRequestObject = new ActiveXObject("MSXML2.XMLHttp");
 		  } catch(e) {
 			try {
 			  XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
 			} catch(e) {
 			  XMLHttpRequestObject = false;
 			}
 		  }  
 		}
 	}
 	
 	function FindAge(obj) {
		ajaxObject(); 	        
	    var userDob = $(obj);	
		var userAge = $("#age");
		if (userDob.val()!='' && userDob.val()!='Date of Birth')  {				
			var url = "AjaxMaster.jsp?userAge="+userDob.val();		   
			XMLHttpRequestObject.open("Post",url,true);
			XMLHttpRequestObject.onreadystatechange =   function() { 
				if(XMLHttpRequestObject.readyState == 4) { 
					if(XMLHttpRequestObject.status == 200) {
						var message = XMLHttpRequestObject.responseXML;
						var optValue = message.getElementsByTagName("message")[0];
						if (optValue.firstChild.data<0) {
							userDob.val("Date of Birth");
							userAge.val("Age");
							userDob.css('color', '#7a7a7a');
							userAge.css('color', '#7a7a7a');
						}  else {
							userAge.val(optValue.firstChild.data);
							userAge.css('color', '#000000');
						}
					}
				} else {
				}
			}
	    } else {
	    	userAge.val("");
	    	setPlaceholder();
			return true;	 
		}
	    XMLHttpRequestObject.send(null);    
	}
	
 	function openWaitingProcess() {
		$("body").css("overflow", "hidden");
		var height 	= $(document).height();
		var width 	= $(document).width();
		
	    var bcgDiv 	= document.getElementById("divBackground");
	    var dv = document.getElementById("waitingData");
	    
	    bcgDiv.style.height=height;
	    bcgDiv.style.width=width;
	    bcgDiv.style.display="block";
		
		if(dv != null)
		{
			var xpos = screen.width * 0.47;
			var ypos = screen.height * 0.22;   
			
			dv.style.position="absolute";       		
			dv.style.left=(xpos)+"px";
			dv.style.top=(ypos)+"px";
			document.getElementById("waitingData").style.display="";
			document.getElementById("waitingData").style.visibility="";	
		}
	}
	
	function closeDivRequest() {
		$("body").css("overflow", "auto");
		document.getElementById("divBackground").style.display="none";
	}
	
	function setDomEditMode() {
		if($("label.Int").length > 0) {
			$("label.Int").addClass("Disable");
			$("label.Int").hide();
		}
		if($("input#rd_Int").length > 0) {
			$("input#rd_Int").attr('checked', false);				
			$('input#rd_Int').prop('disabled', true);
			$('input#rd_Int').hide();
		}
		
		$("input#rd_Dom").attr('checked', true);		
		$("input#rd_Dom").val("D");			
		$("label.Dom").removeClass("Disable");			
		$('input#rd_Dom').prop('disabled', false);
		
		$("tr#passportDetail").hide();
		$("tr#identityProofDetailInt").hide();
		$("tr#identityProofDetail").show();
		
		$("tr#travellerDetailIntTr").hide();			
		$("tr#travellerDetailDomTr").show();
		
		$("tr#trainDetailBlock").show();			
		$("tr#carDetailBlock").show();
		
		$("#bt_Add-Flight").removeClass("bt-Add-Int");
		$("#bt_Add-Flight").addClass("bt-Add-Dom");
		$("#bt_Add-Train").removeClass("bt-Add-Int");
		$("#bt_Add-Train").addClass("bt-Add-Dom");
		$("#bt_Add-Car").removeClass("bt-Add-Int");
		$("#bt_Add-Car").addClass("bt-Add-Dom");
		$("#bt_Add_Accomo").removeClass("bt-Add-Accom-Int");
		$("#bt_Add_Accomo").addClass("bt-Add-Accom-Dom");
		$("#bt_Add-Traveller").removeClass("bt-Add-Trv-Int");
		$("#bt_Add-Traveller").addClass("bt-Add-Trv-Dom");
		$("#bt_Update-Traveller").removeClass("bt-Add-Trv-Int");
		$("#bt_Update-Traveller").addClass("bt-Add-Trv-Dom");
		$("#bt_Add-Curr").removeClass("bt-Add-Curr-Int");
		$("#bt_Add-Curr").addClass("bt-Add-Curr-Dom");
		$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Dom");
		$("#bt-Save").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-Save").addClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Dom");
		
		var val = $('input#rd_Dom:checked').val();
		var userId = userIdGlobal;
		var siteId = $("select#siteName option:selected").val();
		defaultApproverList(siteId, userId, val);
		populateCancelledRequest(userId, val);
		showBuyTktFrmNonMATA();
		skipDisabled(frm,'abcd');
		showNote();
		setPlaceholder();
	}
	
	function setIntEditMode() {
		if($("label.Dom").length > 0) {
			$("label.Dom").addClass("Disable");
			$("label.Dom").hide();
		}
		if($("input#rd_Dom").length > 0) {
			$("input#rd_Dom").attr('checked', false);				
			$('input#rd_Dom').prop('disabled', true);
			$('input#rd_Dom').hide();
		}
		
		$("input#rd_Int").attr('checked', true);
		$("input#rd_Int").val("I");
		$("label.Int").removeClass("Disable");
		$("input#rd_Int").prop('disabled', false);
		
		$("tr#identityProofDetail").hide();
		$("tr#passportDetail").show();
		$("tr#identityProofDetailInt").show();
		
		$("tr#travellerDetailDomTr").hide();
		$("tr#travellerDetailIntTr").show();
		
		$("tr#trainDetailBlock").hide();			
		$("tr#carDetailBlock").hide();
		
		$("td#cancelledTravelReqTd").removeClass("show");
		$("td#cancelledTravelReqTd").addClass("hide");
		$("#bt_Add-Flight").removeClass("bt-Add-Dom");
		$("#bt_Add-Flight").addClass("bt-Add-Int");
		$("#bt_Add-Train").removeClass("bt-Add-Dom");
		$("#bt_Add-Train").addClass("bt-Add-Int");
		$("#bt_Add-Car").removeClass("bt-Add-Dom");
		$("#bt_Add-Car").addClass("bt-Add-Int");
		$("#bt_Add_Accomo").removeClass("bt-Add-Accom-Dom");
		$("#bt_Add_Accomo").addClass("bt-Add-Accom-Int");
		$("#bt_Add-Traveller").removeClass("bt-Add-Trv-Dom");
		$("#bt_Add-Traveller").addClass("bt-Add-Trv-Int");
		$("#bt_Update-Traveller").removeClass("bt-Add-Trv-Dom");
		$("#bt_Update-Traveller").addClass("bt-Add-Trv-Int");
		$("#bt_Add-Curr").removeClass("bt-Add-Curr-Dom");
		$("#bt_Add-Curr").addClass("bt-Add-Curr-Int");
		$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Int");
		$("#bt-Save").removeClass("bt-SubmitToWorkflow-Dom");
		$("#bt-Save").addClass("bt-SubmitToWorkflow-Int");
		$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Int");
		
		var val = $('input#rd_Int:checked').val();
		var userId = userIdGlobal;
		var siteId = $("select#siteName option:selected").val();
		defaultApproverList(siteId, userId, val);
		populateCancelledRequest(userId, val);
		showBuyTktFrmNonMATA();	
		skipDisabled(frm,'abcd');
		showNote();
		setPlaceholder();
	}
	
	function setDomOnClickMode() {	
		
		$("tr#passportDetail").hide();
		$("tr#identityProofDetailInt").hide();
		$("tr#identityProofDetail").show();
		
		$("tr#travellerDetailIntTr").hide();			
		$("tr#travellerDetailDomTr").show();
					
		$("tr#trainDetailBlock").show();			
		$("tr#carDetailBlock").show();
		
		$('input:radio#trainRequired_N').click();
		$('input:radio#carRequired_N').click();
		
		$("table#tblAccomodation tbody tr.accomodationDataRow").each(function() {		
			$(this).find("select#accomCurrency").val(baseCurrencyVal);
		});
		
		$("#bt_Add-Flight").removeClass("bt-Add-Int");
		$("#bt_Add-Flight").addClass("bt-Add-Dom");
		$("#bt_Add-Train").removeClass("bt-Add-Int");
		$("#bt_Add-Train").addClass("bt-Add-Dom");
		$("#bt_Add-Car").removeClass("bt-Add-Int");
		$("#bt_Add-Car").addClass("bt-Add-Dom");
		$("#bt_Add_Accomo").removeClass("bt-Add-Accom-Int");
		$("#bt_Add_Accomo").addClass("bt-Add-Accom-Dom");
		$("#bt_Add-Traveller").removeClass("bt-Add-Trv-Int");
		$("#bt_Add-Traveller").addClass("bt-Add-Trv-Dom");
		$("#bt_Update-Traveller").removeClass("bt-Add-Trv-Int");
		$("#bt_Update-Traveller").addClass("bt-Add-Trv-Dom");
		$("#bt_Add-Curr").removeClass("bt-Add-Curr-Int");
		$("#bt_Add-Curr").addClass("bt-Add-Curr-Dom");
		$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Dom");
		$("#bt-Save").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-Save").addClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Dom");
		
		var val = $('input#rd_Dom:checked').val();		
		var userId = userIdGlobal;
		var siteId = $("select#siteName option:selected").val();
		populateApproverLevelData(siteId, userId, val); 
		defaultApproverList(siteId, userId, val);
		populateCancelledRequest(userId, val);
    	showBuyTktFrmNonMATA();    	
	}
	
	
	function setIntOnClickMode() {
				
		$("tr#travellerDetailDomTr").hide();
		$("tr#travellerDetailIntTr").show();	
		
		$("tr#identityProofDetail").hide();
		$("tr#passportDetail").show();
		$("tr#identityProofDetailInt").show();
		
		$("tr#trainDetailBlock").hide();			
		$("tr#carDetailBlock").hide();
		
		$('input:radio#trainRequired_N').click();
		$('input:radio#carRequired_N').click();
		
		$("table#tblAccomodation tbody tr.accomodationDataRow").each(function() {		
			$(this).find("select#accomCurrency").val("USD");
		});
		
		$("td#cancelledTravelReqTd").removeClass("show");
		$("td#cancelledTravelReqTd").addClass("hide");
		$("#bt_Add-Flight").removeClass("bt-Add-Dom");
		$("#bt_Add-Flight").addClass("bt-Add-Int");
		$("#bt_Add-Train").removeClass("bt-Add-Dom");
		$("#bt_Add-Train").addClass("bt-Add-Int");
		$("#bt_Add-Car").removeClass("bt-Add-Dom");
		$("#bt_Add-Car").addClass("bt-Add-Int");
		$("#bt_Add_Accomo").removeClass("bt-Add-Accom-Dom");
		$("#bt_Add_Accomo").addClass("bt-Add-Accom-Int");
		$("#bt_Add-Traveller").removeClass("bt-Add-Trv-Dom");
		$("#bt_Add-Traveller").addClass("bt-Add-Trv-Int");
		$("#bt_Update-Traveller").removeClass("bt-Add-Trv-Dom");
		$("#bt_Update-Traveller").addClass("bt-Add-Trv-Int");
		$("#bt_Add-Curr").removeClass("bt-Add-Curr-Dom");
		$("#bt_Add-Curr").addClass("bt-Add-Curr-Int");
		$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Int");
		$("#bt-Save").removeClass("bt-SubmitToWorkflow-Dom");
		$("#bt-Save").addClass("bt-SubmitToWorkflow-Int");
		$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Int");
		
		var val = $('input#rd_Int:checked').val();    	
		var userId = userIdGlobal;
		var siteId = $("select#siteName option:selected").val();
		populateApproverLevelData(siteId, userId, val); 
		defaultApproverList(siteId, userId, val);
		populateCancelledRequest(userId, val);
    	showBuyTktFrmNonMATA();
	}
	
	function setIsDomChecked() {
		$('input#rd_Int').attr('checked', false);
    	$('input#rd_Dom').val("D");
    	var val = $('input#rd_Dom:checked').val(); 
    	
    	$("tr#travellerDetailIntTr").hide();			
		$("tr#travellerDetailDomTr").show();
    	
    	$("tr#passportDetail").hide();
    	$("tr#identityProofDetailInt").hide();
		$("tr#identityProofDetail").show();
		
    	$("tr#trainDetailBlock").show();			
		$("tr#carDetailBlock").show();
		
		$('input:radio#trainRequired_N').click();
		$('input:radio#carRequired_N').click();
		
		$("label#accomodationRequiredYes").removeClass("disable");
		$("label#accomodationRequiredYes").removeClass("active");
		$("label#accomodationRequiredNo").removeClass("disable");
 	   	$("label#accomodationRequiredNo").addClass("active");
 	    $('input:radio#accomodationRequired_Y').attr('checked', false);
		$('input:radio#accomodationRequired_N').attr('checked', true);
		$('input:radio#accomodationRequired_Y').attr('disabled', false);
		$('input:radio#accomodationRequired_N').attr('disabled', false);
		$("tr#accomodationDetail").hide();
		
		if($('input:radio#flightRequired_Y').is(':checked')) {
			$("label#flightRequiredNo").removeClass("active");
			$("label#flightRequiredYes").addClass("active");	 		
			$("tr#flightDetail").show();			
		 } else if($('input:radio#flightRequired_N').is(':checked')) {
			$("label#flightRequiredYes").removeClass("active");
			$("label#flightRequiredNo").addClass("active");	 	   	
			$("tr#flightDetail").hide();	 	    
		 }		
		
		if($('input:radio#trainRequired_Y').is(':checked')) {
			$("label#trainRequiredNo").removeClass("active");
			$("label#trainRequiredYes").addClass("active");	 		
			$("tr#trainDetail").show();			
		 } else if($('input:radio#trainRequired_N').is(':checked')) {
			$("label#trainRequiredYes").removeClass("active");
			$("label#trainRequiredNo").addClass("active");	 	   	
			$("tr#trainDetail").hide();	 	    
		 }
		
		if($('input:radio#carRequired_Y').is(':checked')) {
			$("label#carRequiredNo").removeClass("active");
			$("label#carRequiredYes").addClass("active");	 		
			$("tr#carDetail").show();			
		 } else if($('input:radio#carRequired_N').is(':checked')) {
			$("label#carRequiredYes").removeClass("active");
			$("label#carRequiredNo").addClass("active");	 	   	
			$("tr#carDetail").hide();	 	    
		 }
		
		$("table#tblAccomodation tbody tr.accomodationDataRow").each(function() {		
			$(this).find("select#accomCurrency").val(baseCurrencyVal);
	    });
		
    	 var userId = userIdGlobal;
		 var siteId = $("select#siteName option:selected").val();
		 populateApproverLevelData(siteId, userId, val); 
		 defaultApproverList(siteId, userId, val);
		 populateCancelledRequest(userId, val);
	     showBuyTktFrmNonMATA();
	}

	function showBuyTktFrmNonMATA() {
		var showBuyTktFrmNonMATA = false;		
		
		var matapricecomp = "";		
		if($('input#rd_Dom').is(':checked')) {		
			matapricecomp = $("#matapricecompdom").val();			
		} else if($('input#rd_Int').is(':checked')) {		
			matapricecomp = $("#matapricecompint").val();		
		}
		
		var matapricecomp1 = matapricecomp;
		var matapricecomp2 = "y";
		
		if(matapricecomp1.toLowerCase() === matapricecomp2.toLowerCase()) {
			showBuyTktFrmNonMATA = true;
		} else {
			showBuyTktFrmNonMATA = false;
		}
		
		if(showBuyTktFrmNonMATA) {
			$("tr#ticketsDetailRow").removeClass("hide");
			$("tr#ticketsDetailRow").addClass("show");
		} else {
			$("tr#ticketsDetailRow").removeClass("show");
			$("tr#ticketsDetailRow").addClass("hide");		
		}	
	}
	
	function setApproverBlockHeight() {
		var itineraryBlockHeight =  $("#itineraryBlock").height();
        $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
        var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
        $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
	}
	
	
	// Calculate day difference between two date
	function diffDays(date1, date2) {	
		var d1 = date1.split('/');
		var convertedDate1 = new Date(parseInt(d1[2], 10),     // year
	            parseInt(d1[1], 10) - 1, // month, starts with 0
	            parseInt(d1[0], 10));    // day

	    var d2 = date2.split('/');
		var convertedDate2 = new Date(parseInt(d2[2], 10),     // year
	            parseInt(d2[1], 10) - 1, // month, starts with 0
	            parseInt(d2[0], 10));    // day
	            
	  var ndays;
	  var tv1 = convertedDate1.valueOf();  // msec since 1970
	  var tv2 = convertedDate2.valueOf();
	  ndays = (tv2 - tv1) / 1000 / 86400;
	  ndays = Math.round(ndays - 0.5);
	  return ndays+1;
	}
	
	function test2(obj, length, str) {	
		
		if(obj.name == 'firstName') {
			 upToTwoHyphen(obj);
		}			
		if(obj.name == 'lastName') {
			 upToTwoHyphen(obj);
		}
		if(obj.name == 'identityProofno') {
			 upToTwoHyphen(obj);
		}
		if(obj.name == 'passportNo') {
			 upToTwoHyphen(obj);
		}
		if(obj.name == 'passportNationality') {
			 upToTwoHyphen(obj);
		}
		if(obj.name == 'passportIssuePlace') {
			 upToTwoHyphen(obj);
		}		
		if(obj.name == 'reasonForSkip') {		
			 upToTwoHyphen(obj);
		}	
		if(obj.name == 'reasonForTravel') {
			 upToTwoHyphen(obj);
		}	
		if(obj.name == 'otherComment') {
			 upToTwoHyphen(obj);
		}	
		if(obj.name == 'budget') {
			zeroChecking(obj);
		}	
		if(obj.name == 'expRemarks') {
			upToTwoHyphen(obj);
		}
		if(obj.name == 'budgetRemarks') {
			upToTwoHyphen(obj);
		}
		if(obj.name == 'pricingRemarks') {
			upToTwoHyphen(obj);
		}
		
		if(obj.name == 'emailId') {
			upToTwoHyphen(obj);
		}
		if(obj.name == 'empId') {
			upToTwoHyphen(obj);
		}
		if(obj.name == 'emailIdInt') {
			upToTwoHyphen(obj);
		}
		if(obj.name == 'empIdInt') {
			upToTwoHyphen(obj);
		}
			charactercheck(obj,str);
			limitlength(obj, length);	
			spaceChecking(obj);	
	}

	function test3(obj, length, str) {	
		
		    charactercheck(obj,str);
			limitlength(obj, length);	
			spaceChecking(obj);	
	}


	function setPlaceholder() {	
		
		if($.browser.msie && $.browser.version <= 9) {
	    	$('[placeholder]').focus(function() {
	            var input = $(this);
	            if (input.val() == input.attr('placeholder')) {	            	
	                input.val('');
	                input.css('color', '#000000');
	            }
	        });
	        
	        $('[placeholder]').blur(function() {
	        	var input = $(this);	        	          
	            if (input.val() == '' || input.val() == input.attr('placeholder')) {	            	
	                input.css('color', '#7a7a7a');
	                input.val(input.attr('placeholder'));
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
	}

	// Declaring valid date character, minimum year and maximum year
	var dtCh= "/";
	var minYear=1900;
	var maxYear=2100;

	function isInteger(s) {
		var i;
	    for (i = 0; i < s.length; i++) {   
	        // Check that current character is number.
	        var c = s.charAt(i);
	        if (((c < "0") || (c > "9"))) return false;
	    }
	    // All characters are numbers.
	    return true;
	}

	function stripCharsInBag(s, bag) {
		var i;
	    var returnString = "";
	    // Search through string's characters one by one.
	    // If character is not in bag, append to returnString.
	    for (i = 0; i < s.length; i++) {   
	        var c = s.charAt(i);
	        if (bag.indexOf(c) == -1) returnString += c;
	    }
	    return returnString;
	}

	function daysInFebruary (year) {
		// February has 29 days in any year evenly divisible by four,
	    // EXCEPT for centurial years which are not also divisible by 400.
	    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
	}

	function DaysArray(n) {
		for (var i = 1; i <= n; i++) {
			this[i] = 31;
			if (i==4 || i==6 || i==9 || i==11) {this[i] = 30;}
			if (i==2) {this[i] = 29;}
	   } 
	   return this;
	}

	function isDate(dtStr) {
		var daysInMonth = DaysArray(12);
		var pos1=dtStr.indexOf(dtCh);
		var pos2=dtStr.indexOf(dtCh,pos1+1);
		var strDay=dtStr.substring(0,pos1);
		var strMonth=dtStr.substring(pos1+1,pos2);
		var strYear=dtStr.substring(pos2+1);
		strYr=strYear;
		if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1);
		if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1);
		for (var i = 1; i <= 3; i++) {
			if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1);
		}
		month=parseInt(strMonth);
		day=parseInt(strDay);
		year=parseInt(strYr);
		if (pos1==-1 || pos2==-1) {
			alert("The date format should be : dd/mm/yyyy");
			return false;
		}
		if (strMonth.length<1 || month<1 || month>12) {
			alert("Please enter a valid month");
			return false;
		}
		if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]) {
			alert("Please enter a valid day");
			return false;
		}
		if (strYear.length != 4 || year==0 || year<minYear || year>maxYear) {
			alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear);
			return false;
		}
		if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false) {
			alert("Please enter a valid date");
			return false;
		}
	return true;
	}

	function isDateValid(dtStr) {
		var daysInMonth = DaysArray(12);
		var pos1=dtStr.indexOf(dtCh);
		var pos2=dtStr.indexOf(dtCh,pos1+1);
		var strDay=dtStr.substring(0,pos1);
		var strMonth=dtStr.substring(pos1+1,pos2);
		var strYear=dtStr.substring(pos2+1);
		strYr=strYear;
		if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1);
		if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1);
		for (var i = 1; i <= 3; i++) {
			if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1);
		}
		month=parseInt(strMonth);
		day=parseInt(strDay);
		year=parseInt(strYr);
		if (pos1==-1 || pos2==-1) {
			return false;
		}
		if (strMonth.length<1 || month<1 || month>12) {
			return false;
		}
		if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]) {
			return false;
		}
		if (strYear.length != 4 || year==0 || year<minYear || year>maxYear) {
			return false;
		}
		if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false) {
			return false;
		}
	return true;
	}

	// Checking the date of departure and arrival date from the current date(second date should not be the smalle from the first date
	function validateDate(form1,firstDate,secondDate,firstDateName,secondDateName,message1,message2) {
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
		
		if(year>year1) 	{
			 alert(message1);
			 secondDateName.value="";		
			 return false;
		}//end of if
		
		if((year==year1)&&(month>month1)) {
			 alert(message1);
			 secondDateName.value="";		
			 return false;
		}
		
		if((year==year1)&&(month==month1)&&(day>day1)) {		
			 alert(message1);
			 secondDateName.value="";
			 return false;
		}//end of elseif
		
		return true;
	}
	
	function stayTypeChangeEvent(obj) {			
			showNote();			
	}
	
	function showNote() {
		var showNoteFlag = false;
		$("table#tblAccomodation tbody tr.accomodationDataRow").each(function() {
			 var accomStayTypeVal = $(this).find("select#accomStayType").val();
			 
			 if(accomStayTypeVal != null && accomStayTypeVal == "2"){
				  showNoteFlag = true;
			  }
         });
		
		if(!showNoteFlag){
			document.getElementById('hidethis').style.display = 'none'; 
		} else if(showNoteFlag){
			document.getElementById('hidethis').style.display = ''; 
		}
	}

$(document).ready(function() {
	
	// flight required[Yes] button click event
	$('input:radio#flightRequired_Y').click(function() {		
		$("label#flightRequiredNo").removeClass("active");
		$("label#flightRequiredYes").addClass("active");
		$('input:radio#flightRequired_N').prop("checked", false);
		$('input:radio#flightRequired_Y').prop("checked", true);
		$("tr#flightDetail").show();
	});
	
	// flight required[No] button click event
	$('input:radio#flightRequired_N').click(function() {
		$(this).attr('checked', true);
		var checkItnrFlagFlt = false;		
		if($("label#flightRequiredYes").hasClass('active')) {
			
			var depCityFlt 		= document.getElementsByName("depCityFlt");
			var arrCityFlt 		= document.getElementsByName("arrCityFlt");
			var depDateFlt 		= document.getElementsByName("depDateFlt");
			var prefAirlineFlt 	= document.getElementsByName("nameOfAirlineFlt");
			
			for(var i = 0, len = depCityFlt.length; i < len; i++) {
				if((depCityFlt[i].value != '' && depCityFlt[i].value != 'Departure City') || (arrCityFlt[i].value != '' && arrCityFlt[i].value != 'Arrival City')
						|| (depDateFlt[i].value != '' && depDateFlt[i].value != 'Departure Date') || (prefAirlineFlt[i].value != '' && prefAirlineFlt[i].value != 'Preferred Airline')) {			
					checkItnrFlagFlt = true;
					break;
				}
			}	
			
			var result = false;
			if(checkItnrFlagFlt){
				result = confirm('Do you want to remove flight detail.');
			} else {
				resetFlightDetail();
			}
			
			if(result){
				deleteTravelDetails("1");
				resetFlightDetail();
			}			
		}
	});
	
	//Reset Flight Detail on "No" button click
	function resetFlightDetail() {
		$("label#flightRequiredYes").removeClass("active");
	   	$("label#flightRequiredNo").addClass("active");
	   	$('input:radio#flightRequired_Y').prop("checked", false);
		$('input:radio#flightRequired_N').prop("checked", true);
	   	$("tr#flightDetail").hide();

		//Remove intermediate rows and clear Forward & Return leg details
		$(".itineraryDataRowFlightIntrmi").remove();
		$('#intJrnyTitleRowFlight').addClass('hide');

		$("input#depCityFltTBFwd").val('Departure City');
		$("input#depCityFltTBFwd").attr('style','color:rgb(122, 122, 122)');
		$("input#arrCityFltTBFwd").val("Arrival City");
		$("input#arrCityFltTBFwd").attr('style','color:rgb(122, 122, 122)');
		$("input#depDateFltTBFwd").val("Departure Date");
		$("input#depDateFltTBFwd").attr('style','color:rgb(122, 122, 122)');
		$("input#nameOfAirlineFltTBFwd").val("Preferred Airline");
		$("input#nameOfAirlineFltTBFwd").attr('style','color:rgb(122, 122, 122)');
		$("select#preferTimeModeFltSBFwd").val("2");
		$("select#preferTimeFltSBFwd").val("-1");
		$("select#departClassFltSBFwd").val("1");
		$("select#seatPreffredFltSBFwd").val("1");
		$("select#ticketRefundFltSBFwd").val("y");
		
		$("input#depCityFltTBRet").val('Departure City');
		$("input#depCityFltTBRet").attr('style','color:rgb(122, 122, 122)');
		$("input#arrCityFltTBRet").val("Arrival City");
		$("input#arrCityFltTBRet").attr('style','color:rgb(122, 122, 122)');
		$("input#depDateFltTBRet").val("Departure Date");
		$("input#depDateFltTBRet").attr('style','color:rgb(122, 122, 122)');
		$("input#nameOfAirlineFltTBRet").val("Preferred Airline");
		$("input#nameOfAirlineFltTBRet").attr('style','color:rgb(122, 122, 122)');
		$("select#preferTimeModeFltSBRet").val("1");
		$("select#preferTimeFltSBRet").val("-1");
		$("select#departClassFltSBRet").val("1");
		$("select#seatPreffredFltSBRet").val("1");
		$("select#ticketRefundFltSBRet").val("y");
		
		$("#remarksFlt").val("Remarks");
		$("#remarksFlt").attr('style','color:rgb(122, 122, 122)');
	}
	
	// train required[Yes] button click event
	$('input:radio#trainRequired_Y').click(function() {		
		$("label#trainRequiredNo").removeClass("active");
		$("label#trainRequiredYes").addClass("active");
		$('input:radio#trainRequired_N').prop("checked", false);
		$('input:radio#trainRequired_Y').prop("checked", true);
		$("tr#trainDetail").show();
	});
	
	// train required[No] button click event
	$('input:radio#trainRequired_N').click(function() {
		$(this).attr('checked', true);
		var checkItnrFlagTrn = false;		
		if($("label#trainRequiredYes").hasClass('active')) {
			
			var depCityTrn 		= document.getElementsByName("depCityTrn");
			var arrCityTrn 		= document.getElementsByName("arrCityTrn");
			var depDateTrn 		= document.getElementsByName("depDateTrn");
			var prefAirlineTrn 	= document.getElementsByName("nameOfAirlineTrn");
			
			for(var i = 0, len = depCityTrn.length; i < len; i++) {
				if((depCityTrn[i].value != '' && depCityTrn[i].value != 'Departure City') || (arrCityTrn[i].value != '' && arrCityTrn[i].value != 'Arrival City')
						|| (depDateTrn[i].value != '' && depDateTrn[i].value != 'Departure Date') || (prefAirlineTrn[i].value != '' && prefAirlineTrn[i].value != 'Preferred Train')) {			
					checkItnrFlagTrn = true;
					break;
				}
			}	
			
			var result = false;
			if(checkItnrFlagTrn){
				result = confirm('Do you want to remove train detail.');
			} else {
				resetTrainDetail();
			}
			
			if(result){
				deleteTravelDetails("2");
				resetTrainDetail();
			}			
		}
	});
	
	//Reset Train Detail on "No" button click
	function resetTrainDetail() {
		$("label#trainRequiredYes").removeClass("active");
	   	$("label#trainRequiredNo").addClass("active");
	   	$('input:radio#trainRequired_Y').prop("checked", false);
		$('input:radio#trainRequired_N').prop("checked", true);
	   	$("tr#trainDetail").hide();

		//Remove intermediate rows and clear Forward & Return leg details
		$(".itineraryDataRowTrainIntrmi").remove();
		$('#intJrnyTitleRowTrain').addClass('hide');

		$("input#depCityTrnTBFwd").val('Departure City');
		$("input#depCityTrnTBFwd").attr('style','color:rgb(122, 122, 122)');
		$("input#arrCityTrnTBFwd").val("Arrival City");
		$("input#arrCityTrnTBFwd").attr('style','color:rgb(122, 122, 122)');
		$("input#depDateTrnTBFwd").val("Departure Date");
		$("input#depDateTrnTBFwd").attr('style','color:rgb(122, 122, 122)');
		$("input#nameOfAirlineTrnTBFwd").val("Preferred Train");
		$("input#nameOfAirlineTrnTBFwd").attr('style','color:rgb(122, 122, 122)');
		$("select#preferTimeModeTrnSBFwd").val("2");
		$("select#preferTimeTrnSBFwd").val("-1");
		$("select#departClassTrnSBFwd").val("5");
		$("select#seatPreffredTrnSBFwd").val("3");
		$("select#tatkaalTicketTrnSBFwd").val("0");
		
		$("input#depCityTrnTBRet").val('Departure City');
		$("input#depCityTrnTBRet").attr('style','color:rgb(122, 122, 122)');
		$("input#arrCityTrnTBRet").val("Arrival City");
		$("input#arrCityTrnTBRet").attr('style','color:rgb(122, 122, 122)');
		$("input#depDateTrnTBRet").val("Departure Date");
		$("input#depDateTrnTBRet").attr('style','color:rgb(122, 122, 122)');
		$("input#nameOfAirlineTrnTBRet").val("Preferred Train");
		$("input#nameOfAirlineTrnTBRet").attr('style','color:rgb(122, 122, 122)');
		$("select#preferTimeModeTrnSBRet").val("1");
		$("select#preferTimeTrnSBRet").val("-1");
		$("select#departClassTrnSBRet").val("5");
		$("select#seatPreffredTrnSBRet").val("3");
		$("select#tatkaalTicketTrnSBRet").val("0");
		
		$("#remarksTrn").val("Remarks");
		$("#remarksTrn").attr('style','color:rgb(122, 122, 122)');
	}
	
	
	// car required[Yes] button click event
	$('input:radio#carRequired_Y').click(function() {		
		$("label#carRequiredNo").removeClass("active");
		$("label#carRequiredYes").addClass("active");
		$('input:radio#carRequired_N').prop("checked", false);
		$('input:radio#carRequired_Y').prop("checked", true);
		$("tr#carDetail").show();
	});
	
	// car required[No] button click event
	$('input:radio#carRequired_N').click(function() {
		$(this).attr('checked', true);
		var checkItnrFlagCar = false;		
		if($("label#carRequiredYes").hasClass('active')) {
			
			var depCityCar 		= document.getElementsByName("depCityCar");
			var arrCityCar 		= document.getElementsByName("arrCityCar");
			var depDateCar 		= document.getElementsByName("depDateCar");
			var mobileNumberCar	= document.getElementsByName("mobileNumberCar");
			
			for(var i = 0, len = depCityCar.length; i < len; i++) {
				if((depCityCar[i].value != '' && depCityCar[i].value != 'Departure City') || (arrCityCar[i].value != '' && arrCityCar[i].value != 'Arrival City')
						|| (depDateCar[i].value != '' && depDateCar[i].value != 'Departure Date') || (mobileNumberCar[i].value != '' && mobileNumberCar[i].value != 'Mobile Number')) {			
					checkItnrFlagCar = true;
					break;
				}
			}	
			
			var result = false;
			if(checkItnrFlagCar){
				result = confirm('Do you want to remove car detail.');
			} else {
				resetCarDetail();
			}
			
			if(result){
				deleteCarDetailsAll();
				resetCarDetail();
			}			
		}
	});
	
	//Reset Car Detail on "No" button click
	function resetCarDetail() {
		$("label#carRequiredYes").removeClass("active");
	   	$("label#carRequiredNo").addClass("active");
	   	$('input:radio#carRequired_Y').prop("checked", false);
		$('input:radio#carRequired_N').prop("checked", true);
	   	$("tr#carDetail").hide();

		//Remove intermediate rows and clear Forward & Return leg details
		$(".itineraryDataRowCarIntrmi").remove();
		$('#intJrnyTitleRowCar').addClass('hide');

		$("input#depCityCarTBFwd").val('Departure City');
		$("input#depCityCarTBFwd").attr('style','color:rgb(122, 122, 122)');
		$("input#arrCityCarTBFwd").val("Arrival City");
		$("input#arrCityCarTBFwd").attr('style','color:rgb(122, 122, 122)');
		$("input#depDateCarTBFwd").val("Departure Date");
		$("input#depDateCarTBFwd").attr('style','color:rgb(122, 122, 122)');
		$("input#mobileNumberCarTBFwd").val("Mobile Number");
		$("input#mobileNumberCarTBFwd").attr('style','color:rgb(122, 122, 122)');
		$("select#preferTimeModeCarSBFwd").val("2");
		$("select#preferTimeCarSBFwd").val("-1");
		$("select#locationCarSBFwd").val("1");
		
		$("input#depCityCarTBRet").val('Departure City');
		$("input#depCityCarTBRet").attr('style','color:rgb(122, 122, 122)');
		$("input#arrCityCarTBRet").val("Arrival City");
		$("input#arrCityCarTBRet").attr('style','color:rgb(122, 122, 122)');
		$("input#depDateCarTBRet").val("Departure Date");
		$("input#depDateCarTBRet").attr('style','color:rgb(122, 122, 122)');
		$("input#mobileNumberCarTBRet").val("Mobile Number");
		$("input#mobileNumberCarTBRet").attr('style','color:rgb(122, 122, 122)');
		$("select#preferTimeModeCarSBRet").val("1");
		$("select#preferTimeCarSBRet").val("-1");
		$("select#locationCarSBRet").val("1");
		
		$("#remarksCar").val("Remarks");
		$("#remarksCar").attr('style','color:rgb(122, 122, 122)');
	}
	
	// accomodation required[Yes] button click event
	$('input:radio#accomodationRequired_Y').click(function() {		
		$("label#accomodationRequiredNo").removeClass("active");
		$("label#accomodationRequiredYes").addClass("active");
		$('input:radio#accomodationRequired_N').prop("checked", false);
		$('input:radio#accomodationRequired_Y').prop("checked", true);
		$("tr#accomodationDetail").show();
		$("select#accomStayType").val("1");
		
		if($('input#rd_Dom').is(':checked')) {
			$("select#accomCurrency").val(baseCurrencyVal);
		} else if($('input#rd_Int').is(':checked')) {
			$("select#accomCurrency").val("USD");
		}
		
		$("select#accomCurrency").prop('disabled', false);
		$("input#accomPlace").prop('disabled', false);
		$("input#accomBudget").prop('disabled', false);
		$("input#checkInDate").prop('disabled', false);
		$("input#checkOutDate").prop('disabled', false);
		$("textarea#otherComment").prop('disabled', false);
		$("textarea#otherComment").val("Remarks");
		$("textarea#otherComment").css('color', '#7a7a7a');
		showNote();
	});
	
	// accomodation required[No] button click event
	$('input:radio#accomodationRequired_N').click(function() {
		$(this).attr('checked', true);
		var checkItnrFlagAccom = false;
		if($("label#accomodationRequiredYes").hasClass('active')) {
			
			var budget 			= document.getElementsByName("budget");
			var checkinDate 	= document.getElementsByName("checkin");
			var checkoutDate 	= document.getElementsByName("checkout");
			var cityAddress 	= document.getElementsByName("place");
			
			for(var i = 0, len = budget.length; i < len; i++) {
				if((budget[i].value != '' && budget[i].value != 'Budget') || (cityAddress[i].value != '' && cityAddress[i].value != 'Preferred Place') 
						|| (checkinDate[i].value != '' && checkinDate[i].value != 'Check In Date') || (checkoutDate[i].value != '' && checkoutDate[i].value != 'Check Out Date')) {

					checkItnrFlagAccom = true;
					break;
				}
			}
			
			var result = false;
			if(checkItnrFlagAccom){
				result = confirm('Do you want to remove accomodation detail.');
			} else {
				resetAccommodationDetail();
			}
			
			if(result){
				deleteAccomDetailsAll();
				resetAccommodationDetail();
			}
		}
	});
	
	//Reset Accommodation Detail on "No" button click
	function resetAccommodationDetail() {
		$("label#accomodationRequiredYes").removeClass("active");
		$("label#accomodationRequiredNo").addClass("active");
		$("input:radio#accomodationRequired_Y").attr('checked', false);
		$("input:radio#accomodationRequired_N").attr('checked', true);
		$("tr#accomodationDetail").hide();		
		
		$(".accomodationDataRow").each(function(index) {					    
			if(index != 0){
				$(this).remove();
			}else{
				$("select#accomStayType").val('1');
				
				if($('input#rd_Dom').is(':checked')) {
					$("select#accomCurrency").val(baseCurrencyVal);
				} else if($('input#rd_Int').is(':checked')) {
					$("select#accomCurrency").val('USD');
				}
				
				$("#accomBudget").val("Budget");
				$("#accomBudget").val("Budget");
				$("#accomBudget").attr('style','color:rgb(122, 122, 122)');
				$("#checkInDate").val("Check In Date");
				$("#checkInDate").attr('style','color:rgb(122, 122, 122)');
				$("#checkOutDate").val("Check Out Date");
				$("#checkOutDate").attr('style','color:rgb(122, 122, 122)');
				$("#accomPlace").val("Preferred Place");
				$("#accomPlace").attr('style','color:rgb(122, 122, 122)');
			}
		});
		$("#otherComment").val("Remarks");
		$("#otherComment").attr('style','color:rgb(122, 122, 122)');
	}
	
	// Non-MATA required[Yes] button click event
	$('input:radio#tkflyes_Y').click(function() {		
		$("label#tkflyNo").removeClass("active");
		$("label#tkflyYes").addClass("active");
		$('input:radio#tkflyes_N').prop("checked", false);
		$('input:radio#tkflyes_Y').prop("checked", true);
		$('input:radio#tkflyes_Y').val("n");
		$('tr#nonMataDetailRow').removeClass("hide");
		$('tr#nonMataDetailRow').addClass("show");				
	});
	
	// Non-MATA required[No] button click event
	$('input:radio#tkflyes_N').click(function() {
	   	$("label#tkflyYes").removeClass("active");
	   	$("label#tkflyNo").addClass("active");
	   	$('input:radio#tkflyes_Y').prop("checked", false);
	   	$('input:radio#tkflyes_N').prop("checked", true);
		$('input:radio#tkflyes_N').val("y");
		$('tr#nonMataDetailRow').removeClass("show");
		$('tr#nonMataDetailRow').addClass("hide");		
	});
	
	// Add Flight Itinerary Detail table Start
	$("#bt_Add-Flight").live("click",function() {	
		var master = $("table#tblItineraryFlight");		
		// Get a new row based on the prototype row
		var prot = master.find(".prototypeRowItineraryFlight").clone();
		
		prot.find('#depCityFltTBInt').attr('name', 'depCityFlt');
		prot.find('#arrCityFltTBInt').attr('name', 'arrCityFlt');
		prot.find('#depDateFltTBInt').attr('name', 'depDateFlt');
		prot.find('#preferTimeModeFltSBInt').attr('name', 'preferTimeModeFlt');
		prot.find('#preferTimeFltSBInt').attr('name', 'preferTimeFlt');
		prot.find('#departClassFltSBInt').attr('name', 'departClassFlt');	
		prot.find('#nameOfAirlineFltTBInt').attr('name', 'nameOfAirlineFlt');
		prot.find('#seatPreffredFltSBInt').attr('name', 'seatPreffredFlt');
		prot.find('#ticketRefundFltSBInt').attr('name', 'ticketRefundFlt');
		prot.attr("class", ""); 
		prot.addClass("itineraryDataRowFlight itineraryDataRowFlightIntrmi");
		$('.innerRowItineraryFlight').before(prot);
		
		var rowCount = $("table#tblItineraryFlight tbody tr.itineraryDataRowFlight").length;
		if(rowCount > 2 && $("tr#intJrnyTitleRowFlight").hasClass("hide")){
			$("tr#intJrnyTitleRowFlight").removeClass("hide");
			$("tr#intJrnyTitleRowFlight").addClass("show");
		}
		//set placeholder on page load
		setPlaceholder();
		
		$("input[name='tourDays']").val("0");
	    $("input[name='tourDays2']").val("0");
	    $("input[name='totalForex']").val("0.00");
		$("input[name='totalInr']").val("0.00");
		$("input[name='grandTotalForex']").val("0.00");
		$("input[name='grandTotalForexUSD']").val("0.00");
	});

	// Remove button functionality
	$("table#tblItineraryFlight #bt-Del-ItInr-Flight").live("click", function() {
		var rowCount = $("table#tblItineraryFlight tbody tr.itineraryDataRowFlight").length;
		$(this).parents("table#tblItineraryFlight tr").remove();
		
		if(rowCount == 3 && $("tr#intJrnyTitleRowFlight").hasClass("show")){
			$("tr#intJrnyTitleRowFlight").removeClass("show");
			$("tr#intJrnyTitleRowFlight").addClass("hide");
		}
	});
	// Add Flight Itinerary Detail table End

	// Add Train Itinerary Detail table Start
	$("#bt_Add-Train").live("click",function() {	
		var master = $("table#tblItineraryTrain");		
		// Get a new row based on the prototype row
		var prot = master.find(".prototypeRowItineraryTrain").clone();
		
		prot.find('#depCityTrnTBInt').attr('name', 'depCityTrn');
		prot.find('#arrCityTrnTBInt').attr('name', 'arrCityTrn');
		prot.find('#depDateTrnTBInt').attr('name', 'depDateTrn');
		prot.find('#preferTimeModeTrnSBInt').attr('name', 'preferTimeModeTrn');
		prot.find('#preferTimeTrnSBInt').attr('name', 'preferTimeTrn');
		prot.find('#departClassTrnSBInt').attr('name', 'departClassTrn');	
		prot.find('#nameOfAirlineTrnTBInt').attr('name', 'nameOfAirlineTrn');
		prot.find('#seatPreffredTrnSBInt').attr('name', 'seatPreffredTrn');
		prot.attr("class", ""); 
		prot.addClass("itineraryDataRowTrain itineraryDataRowTrainIntrmi");
		$('.innerRowItineraryTrain').before(prot);
		
		var rowCount = $("table#tblItineraryTrain tbody tr.itineraryDataRowTrain").length;
		if(rowCount > 2 && $("tr#intJrnyTitleRowTrain").hasClass("hide")){
			$("tr#intJrnyTitleRowTrain").removeClass("hide");
			$("tr#intJrnyTitleRowTrain").addClass("show");
		}
		//set placeholder on page load
		setPlaceholder();
		
		$("input[name='tourDays']").val("0");
	    $("input[name='tourDays2']").val("0");
	    $("input[name='totalForex']").val("0.00");
		$("input[name='totalInr']").val("0.00");
		$("input[name='grandTotalForex']").val("0.00");
		$("input[name='grandTotalForexUSD']").val("0.00");
	});

	// Remove button functionality
	$("table#tblItineraryTrain #bt-Del-ItInr-Train").live("click", function() {
		var rowCount = $("table#tblItineraryTrain tbody tr.itineraryDataRowTrain").length;
		$(this).parents("table#tblItineraryTrain tr").remove();
		
		if(rowCount == 3 && $("tr#intJrnyTitleRowTrain").hasClass("show")){
			$("tr#intJrnyTitleRowTrain").removeClass("show");
			$("tr#intJrnyTitleRowTrain").addClass("hide");
		}
	});
	// Add Train Itinerary Detail table End

	// Add Car Itinerary Detail table Start
	$("#bt_Add-Car").live("click",function() {	
		var master = $("table#tblItineraryCar");		
		// Get a new row based on the prototype row
		var prot = master.find(".prototypeRowItineraryCar").clone();
		
		prot.find('#travelCarIdInt').attr('name', 'travelCarId');
		prot.find('#depCityCarTBInt').attr('name', 'depCityCar');
		prot.find('#arrCityCarTBInt').attr('name', 'arrCityCar');
		prot.find('#depDateCarTBInt').attr('name', 'depDateCar');
		prot.find('#preferTimeModeCarSBInt').attr('name', 'preferTimeModeCar');
		prot.find('#preferTimeCarSBInt').attr('name', 'preferTimeCar');
		prot.find('#locationCarSBInt').attr('name', 'locationCar');	
		prot.find('#mobileNumberCarTBInt').attr('name', 'mobileNumberCar');
		prot.attr("class", ""); 
		prot.addClass("itineraryDataRowCar itineraryDataRowCarIntrmi");
		$('.innerRowItineraryCar').before(prot);
		
		var rowCount = $("table#tblItineraryCar tbody tr.itineraryDataRowCar").length;
		if(rowCount > 2 && $("tr#intJrnyTitleRowCar").hasClass("hide")){
			$("tr#intJrnyTitleRowCar").removeClass("hide");
			$("tr#intJrnyTitleRowCar").addClass("show");
		}
		//set placeholder on page load
		setPlaceholder();
		
		$("input[name='tourDays']").val("0");
	    $("input[name='tourDays2']").val("0");
	    $("input[name='totalForex']").val("0.00");
		$("input[name='totalInr']").val("0.00");
		$("input[name='grandTotalForex']").val("0.00");
		$("input[name='grandTotalForexUSD']").val("0.00");
	});

	// Remove button functionality
	$("table#tblItineraryCar #bt-Del-ItInr-Car").live("click", function() {
		var rowCount = $("table#tblItineraryCar tbody tr.itineraryDataRowCar").length;
		var travelCarId = $(this).parents("table#tblItineraryCar tbody tr").find('input[name="travelCarId"]').val();
		deleteCarDetailsById(travelCarId);
		$(this).parents("table#tblItineraryCar tr").remove();
		
		if(rowCount == 3 && $("tr#intJrnyTitleRowCar").hasClass("show")){
			$("tr#intJrnyTitleRowCar").removeClass("show");
			$("tr#intJrnyTitleRowCar").addClass("hide");
		}
	});
	// Add Car Itinerary Detail table End
	
	// Accomodation Detail table Start
	$("#bt_Add_Accomo").live("click",function() {
		var master = $("table#tblAccomodation");

		// Get a new row based on the prototype row
		var prot = master.find(".prototypeRowAccomodation").clone();
		
		if($('input#rd_Dom').is(':checked')) {
			prot.find("select#accomCurrency").val(baseCurrencyVal);
		} else if($('input#rd_Int').is(':checked')) {
			prot.find("select#accomCurrency").val('USD');
		}
		
		prot.find('#accomId').attr('name', 'accomId');
		prot.find('#accomStayType').attr('name', 'hotel');
		prot.find('#accomCurrency').attr('name', 'currency');
		prot.find('#accomBudget').attr('name', 'budget');		
		prot.find('#checkInDate').attr('name', 'checkin');
		prot.find('#checkOutDate').attr('name', 'checkout');
		prot.find('#accomPlace').attr('name', 'place');
		prot.attr("class", "");
		prot.addClass("accomodationDataRow");
		$('.innerRowAccomodation').before(prot);
		//set placeholder on page load
		setPlaceholder();
	});

	// Remove button functionality
	$("table#tblAccomodation #bt-Del-Accomodation").live("click",function() {
		var master = $("table#tblAccomodation");
		var dataRow = master.find("tbody tr.accomodationDataRow");
		var rowCountAccom = $("table#tblAccomodation tbody tr.accomodationDataRow").length;
		var accomId = $(this).parents("table#tblAccomodation tr").find('input[name="accomId"]').val();
		deleteAccomDetailsById(accomId, rowCountAccom);
		if(rowCountAccom > 1) {
			$(this).parents("table#tblAccomodation tr").remove();
		} else {
			dataRow.find("#accomId").val("");
			dataRow.find("select#accomStayType").val('1');
			
			if($('input#rd_Dom').is(':checked')) {
				dataRow.find("select#accomCurrency").val(baseCurrencyVal);
			} else if($('input#rd_Int').is(':checked')) {
				dataRow.find("select#accomCurrency").val('USD');
			}
			
			dataRow.find("#accomBudget").val("Budget");
			dataRow.find("#accomBudget").attr('style','color:rgb(122, 122, 122)');			
			dataRow.find("#checkInDate").val("Check In Date");
			dataRow.find("#checkInDate").attr('style','color:rgb(122, 122, 122)');
			dataRow.find("#checkOutDate").val("Check Out Date");
			dataRow.find("#checkOutDate").attr('style','color:rgb(122, 122, 122)');	
			dataRow.find("#accomPlace").val("Preferred Place");
			dataRow.find("#accomPlace").attr('style','color:rgb(122, 122, 122)');
			$("#otherComment").val("Remarks");
			$("#otherComment").attr('style','color:rgb(122, 122, 122)');
		}
	});
	// Accomodation Detail table End
	
});