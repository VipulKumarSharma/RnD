
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

	//initialize airport name from database 
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
		$.widget( "custom.catcomplete", $.ui.autocomplete, {
			_resizeMenu: function() {
				  this.menu.element.outerWidth( 350 );
			},
			_renderMenu: function( ul, items ) {
				var that = this,
				currentCategory = "";
				$.each( items, function( index, item ) {
					if(item.category != undefined ){
						if (item.category != currentCategory ) {
							var groupItem = {"label":item.category,"value":item.category,"category":item.category};
							$("<li></li>")
							.data("item.autocomplete", groupItem)
							.append("<a style='font-weight: bold'>" + groupItem.category + "</a>")
							.appendTo(ul);
							currentCategory = item.category;
						}
						item.label = item.label.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex($(elId).val()) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>");
						$("<li></li>")
						.data("item.autocomplete", item)
						.append("<a style='margin-left:15px;'>" + item.label + "</a>")
						.appendTo(ul);
					}else{
						item.label = item.label.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex($(elId).val()) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>");
						$("<li></li>")
						.data("item.autocomplete", item)
						.append("<a style='margin-left:5px;'>" + item.label + "</a>")
						.appendTo(ul);
					}
				});
			}
		});
		
		var travelType = 'I';
		if($('input#rd_Dom').is(':checked')) {
			travelType = 'D';
		}	
	   	$(elId).catcomplete({
	   	 	minLength: 3,
	   		delay: 500,
			source : function(request, response) {
	        	airPortName = "";            	
	            $.ajax({
	            	 type: "get",
					 url: "AutoCompleteServlet",
					 data: { term: $(elId).val(), airPortName: $(elId).val(), tempFlag:  "airMode", field: "tempFlag",travelType:travelType},
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
	
	// set date 
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


	function initializeRentCarDate(elId, startDatePlcHldr, endDatePlcHldr) {
		var elIdIndex = $(elId).closest('body').find('.validDateRentCar').index(elId);	 		
		var setDate = new Date();
		var dt = 0;
		var flag = false; 		
		$('.validDateRentCar').each(function(index) {			
			var dateVal = $(this).val();	
			var dateValParts = dateVal.split("/");
			if((parseInt(index) < parseInt(elIdIndex)) && dateVal != "" && (dateVal != startDatePlcHldr && dateVal != endDatePlcHldr)) {
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
				$('.validDateRentCar').each(function(thisIndex) {	
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

	function initializeBahnCardValidityDate(elId) {
		var setDate = new Date();
		$(elId).datepick({
			dateFormat: 'dd/mm/yyyy',
			minDate: new Date(setDate),		
			onSelect: function(dateText, inst) { $(this).css('color', '#000000'); },
			onClose: function(dateText, inst) {
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
		var userAge = $(obj).parents("table#groupGuestDetailTblInner").find("#ageGroup");
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
	    	resetPlaceHolder();
			return true;	 
		}
	    XMLHttpRequestObject.send(null);    
	}
	

	//Declaring valid date character, minimum year and maximum year
	var dtCh= "/";
	var minYear=1900;
	var maxYear=2100;

	function isInteger(s) {
		var i;
	    for (i = 0; i < s.length; i++) {   
	        // Check that current character is number.
	        var c = s.charAt(i);
	        if (((c < "0") || (c > "9"))) return false;
	    }// All characters are numbers.
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
		
		if(year>year1) {
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
	
	function test2(obj, length, str) {		
		if(obj.name == 'projectNo') {
			 upToTwoHyphen(obj);
		}
		if(obj.name == 'reasonForTravel') {
			 upToTwoHyphen(obj);
		}	
		if(obj.name == '"fNameGroup"') {
			 upToTwoHyphen(obj);
		}			
		if(obj.name == 'lNameGroup') {
			 upToTwoHyphen(obj);
		}
		if(obj.name == 'mobileNoGroup') {
			 upToTwoHyphen(obj);
		}
		if(obj.name == 'frequentFlyerGroup') {
			 upToTwoHyphen(obj);
		}
		if(obj.name == 'passportNoGroup') {
			 upToTwoHyphen(obj);
		}
		if(obj.name == 'nationalityGroup') {
			 upToTwoHyphen(obj);
		}
		if(obj.name == 'placeOfIssueGroup') {
			 upToTwoHyphen(obj);
		}
		if(obj.name =='depCityFlt') {
			 upToTwoHyphen(obj);
		}
		if(obj.name =='arrCityFlt') {
			 upToTwoHyphen(obj);
		}
		if(obj.name =='remarksFlt') {
			 upToTwoHyphen(obj);
		}
		if(obj.name =='depCityTrn') {
			upToTwoHyphen(obj);
		}
		if(obj.name =='arrCityTrn') {
			upToTwoHyphen(obj);
		}
		if(obj.name =='remarksTrn') {
			upToTwoHyphen(obj);
		}		
		if(obj.name =='startCity') {
			upToTwoHyphen(obj);
		}
		if(obj.name =='startMobileNo') {
			upToTwoHyphen(obj);
		}
		if(obj.name =='endCity') {
			upToTwoHyphen(obj);
		}
		if(obj.name =='endMobileNo') {
			upToTwoHyphen(obj);
		}
		if(obj.name =='remarksCar') {
			upToTwoHyphen(obj);
		}
		if(obj.name == 'place') {
			upToTwoHyphen(obj);
		}
		if(obj.name == 'otherComment') {
			upToTwoHyphen(obj);
		}
		
		charactercheckGmbH(obj,str);
		limitlength(obj, length);	
		spaceChecking(obj);	
			
	}
	
	function charactercheckGmbH(e,t){
		if(t=="c"){
			mikExp=/[^a-z\+\-\_\,\?\s]+$/i;
		}else if(t=="n"){
			mikExp=/[$\\@\\\#%\^\&\ \*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z]/
		}else if(t=="n."){
			mikExp=/[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\|\,\'\"\?\/\>\<\!\-\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z]/
		}else if(t=="cn"){
			mikExp=/[^a-z\d\+\-\_\,\;\^\&\*\@\#\$\!\:\`\~\=\.\|\?\(\)\[\]\{\}\/\\\s]+$/i;
		}else if(t=="cn,"){
			mikExp=/[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\'\"\?\/\>\<\!\-\:\;]/
		}else if(t=="sector"){
			mikExp=/[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\'\"\?\/\>\<\!\:\;\\0\\1\\2\\3\\4\\5\\6\\7\\8\\9]/
		}else if(t=="cn:"){
			mikExp=/[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\;]/
		}else if(t=="phone"){
			mikExp=/[$\\@\\\#%\^\&\*\?\[\]\_\{\}\`\~\=\.\|\,\'\"\/\>\<\!\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z]/
		}else if(t=="pwd"){
			mikExp=/[=\'\"\\\-]/
		}else if(t=="an"){
			mikExp=/[\'\"\;\\\>\<\&]/
		}else if(t=="sitename"){
			mikExp=/[\&\'\"\;\%]/
		}else if(t=="txt"){
			mikExp=/[\'\<\>\&]/
		}else if(t=="cur"){
			mikExp=/[$\\@\\\#%\^\&\*\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;\\0\\1\\2\\3\\4\\5\\6\\7\\8\\9]/
		}else if(t=="xml"){
			mikExp=/[\'\&]/
		}else{
			mikExp=/[\`\'\<\>\&]/
		}
		var n=e.value;
		var r=n.length;
		if(r>0){
			for(var i=0;i<r;i++){
				var s=e.value.charAt(i);
				if(s.search(mikExp)!=-1){
					var o=e.value.substring(0,i);
					var u=e.value.substring(i+1,r);e.value=o+u;i--}
				}
			}
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


	function resetPlaceHolder(){
		if ($.browser.msie	&& $.browser.version <= 9) {
			$('[placeholder]').focus(function() {
				var input = $(this);
				if (input.val() == input.attr('placeholder')) {
					input.val('');
					input.css('color','#000000');
				}
			});
			$('[placeholder]').blur(function() {
				var input = $(this);
				if (input.val() == '' || input.val() == input.attr('placeholder')) {
					input.css('color','#7a7a7a');
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
	
	function resetRentaCarData(elem, value){

		var startMobileNoTD = $('td.startMobileNoTdInput');
		var startMobileNoInput = document.getElementsByName('startMobileNo');
		var endMobileNoTD =  $('td.endMobileNoTdInput');
		var endMobileNoInput = document.getElementsByName('endMobileNo');
		
		var startRoutingTD =  $('td.startRoutingTdInput');
		var startRoutingInput = document.getElementsByName('startRouting');
		var endRoutingTD =  $('td.endRoutingTdInput');
		var endRoutingInput = document.getElementsByName('endRouting');

		var startTime = document.getElementsByName('startTime');
		var startLocation = document.getElementsByName('startLocation');
		var endTime = document.getElementsByName('endTime');
		var endLocation = document.getElementsByName('endLocation');
		
		if(value == '27' || value == '29'){
			if(startRoutingTD != undefined && startRoutingTD.length > 0){
				for(var i=0; i<startRoutingTD.length; i++){
					if(hasClass(startRoutingTD[i],'hide')){
						$(startRoutingInput[i]).val("");
						$(startRoutingTD[i]).removeClass("hide");
						$(startRoutingTD[i]).addClass("show");
						$(startRoutingInput[i]).removeClass("hide");
						$(startRoutingInput[i]).addClass("textBoxCss show");
						$(startRoutingInput[i]).val("Routing");
						$(startRoutingInput[i]).attr('style','color:rgb(122, 122, 122)');
					}
					
					if(hasClass(endRoutingTD[i],'hide')){
						$(endRoutingInput[i]).val("");
						$(endRoutingTD[i]).removeClass("hide");
						$(endRoutingTD[i]).addClass("show");
						$(endRoutingInput[i]).removeClass("hide");
						$(endRoutingInput[i]).addClass("textBoxCss show");
						$(endRoutingInput[i]).val("Routing");
						$(endRoutingInput[i]).attr('style','color:rgb(122, 122, 122)');
					}
					
					if(startLocation[i].value == '4'){
						if(hasClass(startMobileNoTD[i],'show')){
							$(startMobileNoInput[i]).val("");
							$(startMobileNoTD[i]).removeClass("show");
							$(startMobileNoTD[i]).addClass("hide");
							$(startMobileNoInput[i]).removeClass("show");
							$(startMobileNoInput[i]).addClass("textBoxCss hide");
						}
					}
					
					if(endLocation[i].value == '4'){
						if(hasClass(endMobileNoTD[i],'show')){
							$(endMobileNoInput[i]).val("");
							$(endMobileNoTD[i]).removeClass("show");
							$(endMobileNoTD[i]).addClass("hide");
							$(endMobileNoInput[i]).removeClass("show");
							$(endMobileNoInput[i]).addClass("textBoxCss hide");
						}	
					}
				}
			}
			
			
		}else if(value == '26'){
			if(startRoutingTD != undefined && startRoutingTD.length > 0){
				for(var i=0; i<startRoutingTD.length; i++){
					if(hasClass(startRoutingTD[i],'show')){
						$(startRoutingInput[i]).val("");
						$(startRoutingTD[i]).removeClass("show");
						$(startRoutingTD[i]).addClass("hide");
						$(startRoutingInput[i]).removeClass("show");
						$(startRoutingInput[i]).addClass("textBoxCss hide");
					}
					
					if(hasClass(endRoutingTD[i],'show')){
						$(endRoutingInput[i]).val("");
						$(endRoutingTD[i]).removeClass("show");
						$(endRoutingTD[i]).addClass("hide");
						$(endRoutingInput[i]).removeClass("show");
						$(endRoutingInput[i]).addClass("textBoxCss hide");
					}
					
					if(startLocation[i].value == '4'){
						if(hasClass(startMobileNoTD[i],'hide')){
							$(startMobileNoInput[i]).val("");
							$(startMobileNoTD[i]).removeClass("hide");
							$(startMobileNoTD[i]).addClass("show");
							$(startMobileNoInput[i]).removeClass("hide");
							$(startMobileNoInput[i]).addClass("textBoxCss show");
							$(startMobileNoInput[i]).val("Mobile Number");
							$(startMobileNoInput[i]).attr('style','color:rgb(122, 122, 122)');
						}						
					}
					
					if(endLocation[i].value == '4'){
						if(hasClass(endMobileNoTD[i],'hide')){
							$(endMobileNoInput[i]).val("");
							$(endMobileNoTD[i]).removeClass("hide");
							$(endMobileNoTD[i]).addClass("show");
							$(endMobileNoInput[i]).removeClass("hide");
							$(endMobileNoInput[i]).addClass("textBoxCss show");
							$(endMobileNoInput[i]).val("Mobile Number");
							$(endMobileNoInput[i]).attr('style','color:rgb(122, 122, 122)');
						}
					}
				}
			}
			
			
		} else {
			if(startRoutingTD != undefined && startRoutingTD.length > 0){
				for(var i=0; i<startRoutingTD.length; i++){
					if(hasClass(startRoutingTD[i],'show')){
						$(startRoutingInput[i]).val("");
						$(startRoutingTD[i]).removeClass("show");
						$(startRoutingTD[i]).addClass("hide");
						$(startRoutingInput[i]).removeClass("show");
						$(startRoutingInput[i]).addClass("textBoxCss hide");
					}
					
					if(hasClass(endRoutingTD[i],'show')){
						$(endRoutingInput[i]).val("");
						$(endRoutingTD[i]).removeClass("show");
						$(endRoutingTD[i]).addClass("hide");
						$(endRoutingInput[i]).removeClass("show");
						$(endRoutingInput[i]).addClass("textBoxCss hide");
					}
					
					if(startLocation[i].value == '4'){
						if(hasClass(startMobileNoTD[i],'show')){
							$(startMobileNoInput[i]).val("");
							$(startMobileNoTD[i]).removeClass("show");
							$(startMobileNoTD[i]).addClass("hide");
							$(startMobileNoInput[i]).removeClass("show");
							$(startMobileNoInput[i]).addClass("textBoxCss hide");
						}
					}
					
					if(endLocation[i].value == '4'){
						if(hasClass(endMobileNoTD[i],'show')){
							$(endMobileNoInput[i]).val("");
							$(endMobileNoTD[i]).removeClass("show");
							$(endMobileNoTD[i]).addClass("hide");
							$(endMobileNoInput[i]).removeClass("show");
							$(endMobileNoInput[i]).addClass("textBoxCss hide");
						}	
					}
				}
			}		
		}
		
		for(var i=0; i<startLocation.length; i++) {
			if(startLocation[i].value == '1') {
				if(startTime != undefined && startTime.length > 0) {
					if(startTime[i].value == '-1'){
						startTime[i].value = '102';
					}
				}
			} else {
				if(startTime != undefined && startTime.length > 0) {
					if(startTime[i].value == '102'){
						startTime[i].value = '-1';
					}
				}
			}
			
			if(endLocation[i].value == '1') {
				if(endTime != undefined && endTime.length > 0) {
					if(endTime[i].value == '-1'){
						endTime[i].value = '102';
					}
				}
			} else {
				if(endTime != undefined && endTime.length > 0) {
					if(endTime[i].value == '102'){
						endTime[i].value = '-1';
					}
				}
			}
		}
		
		if(value != '28' && value != '29'){
			$("table#gpsCategoryTable").show();	
			$("label#gpsRequiredYes").removeClass("active");
			$("label#gpsRequiredNo").addClass("active");
			$("input#gpsRequired_Y").attr('checked', false);
			$("input#gpsRequired_N").attr('checked', true);
		} else {
			$("table#gpsCategoryTable").hide();		
		}
	}

	function hasClass(element, cls) {
		return (' ' + element.className + ' ').indexOf(' ' + cls + ' ') > -1;
	}

	function rentCarLocationOnChange(x, value, type){
		
		getTimeListForCarLocation(x, value, type);
		//var masterLabel = $(x).parents("table.journyDetailRentCarInner2Tbl tr.rentCarDataRowInner").prev("tr.rentCarLabelRowInner");
		var masterInput = $(x).parents("table.journyDetailRentCarInner2Tbl tr.rentCarDataRowInner");

		var carCategory =document.getElementById("carClass");
		
		var startMobileNoTdInput = masterInput.find("#startMobileNoTdInput");		
		var startMobileNo = masterInput.find("#startMobileNo");

		var endMobileNoTdInput = masterInput.find("#endMobileNoTdInput");		
		var endMobileNo = masterInput.find("#endMobileNo");
		
		var startTime = masterInput.find('#startTime');
		var endTime = masterInput.find('#endTime');

		if(type == 'START'){
			if(value == '4' && carCategory.value == '26'){
				$(startMobileNoTdInput).removeClass('hide');
				$(startMobileNo).removeClass('hide');
				$(startMobileNoTdInput).addClass('show');				
				$(startMobileNo).addClass('textBoxCss show');
			}else{
				$(startMobileNoTdInput).removeClass('show');				
				$(startMobileNo).removeClass('show');
				$(startMobileNoTdInput).addClass('hide');				
				$(startMobileNo).addClass('hide');
			}
			
			if(value == '1'){
				$(startTime).val('102');
			}else{
				$(startTime).val('-1');
			}
		}else if(type == 'END'){
			if(value == '4' && carCategory.value == '26'){
				$(endMobileNoTdInput).removeClass('hide');
				$(endMobileNo).removeClass('hide');
				$(endMobileNoTdInput).addClass('show');
				$(endMobileNo).addClass('textBoxCss show');
				
			}else{
				$(endMobileNoTdInput).removeClass('show');
				$(endMobileNo).removeClass('show');
				$(endMobileNoTdInput).addClass('hide');
				$(endMobileNo).addClass('hide');
			}
			if(value == '1'){
				$(endTime).val('102');
			}else{
				$(endTime).val('-1');
			}
		}
	}	

	function getTimeListForCarLocation(x, value, type) {
		var masterInput = $(x).parents("table.journyDetailRentCarInner2Tbl tr.rentCarDataRowInner");
		var startTime = masterInput.find('#startTime');
		var endTime = masterInput.find('#endTime');
		var language1 = $("#language1").val();
		
		$.ajax({
			type: "get",
			url: "QuickTravelRequestGMBHServlet",
			data: 'carLocation='+value+'&language1='+language1+'&reqpage=quickTravelRequestGmbhCarTimeList',
			cache: false,
			dataType : 'json',
			success : function(result) {
				if(result != null) {
					if(type == 'START'){
						$(startTime).html('');
						$(startTime).get(0).options.add(new Option());
		             	$(startTime).html(result.carTimeListHtml);
					} else if (type == 'END') {
						$(endTime).html('');
						$(endTime).get(0).options.add(new Option());
		             	$(endTime).html(result.carTimeListHtml);
					}
				}
			}
		});
	}
	
	
	
	function setDomInEditMode(){
		var workFlowCode = "0";
		var val = $('input#rd_Dom:checked').val();
		var siteId = $("select#siteNameCombo option:selected").val();
		if(siteId != null && siteId == "S") {
			siteId = '0';
		}
		
		if($('input:radio#fltRequired_Y').is(':checked')) {
			workFlowCode = "1";				
		} else {
			workFlowCode = "0";
		}
		
		$("select.grpMealPrefCombo").removeClass("show");
		$("select.grpMealPrefCombo").addClass("hide");		
		$("img.btDelTravellerDom").removeClass("hide");
		$("img.btDelTravellerDom").addClass("show");		
		$("tr.passportDetailRow").removeClass("show");
		$("tr.passportDetailRow").addClass("hide");	
		$("table.hrTbl").css("width", "81.5%");
		
		$("#bt_Add_Traveller").removeClass("bt-Add-Int");		
		$("#bt_Add_Traveller").addClass("bt-Add-Dom");
		$("#bt_Add_Flt").removeClass("bt-Add-Int");
		$("#bt_Add_Flt").addClass("bt-Add-Dom");
		$("#bt_Add_Trn").removeClass("bt-Add-Int");
		$("#bt_Add_Trn").addClass("bt-Add-Dom");
		$("#bt_Add_RentCar").removeClass("bt-Add-Int");
		$("#bt_Add_RentCar").addClass("bt-Add-Dom");
		$("#bt_Add_Accomo").removeClass("bt-Add-Int");
		$("#bt_Add_Accomo").addClass("bt-Add-Dom");
		$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Dom");
		$("#bt-Save").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-Save").addClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Dom");
		
		//set placeholder on page load
		resetPlaceHolder();	
		populateWorkFlowApproverList(siteId, userIdGlobal, val, workFlowCode);
	}
	
	function setIntInEditMode(){
		var workFlowCode = "1";
		var val = $('input#rd_Int:checked').val();
		var siteId = $("select#siteNameCombo option:selected").val();
		if(siteId != null && siteId == "S") {
			siteId = '0';
		}
				
		$("select.grpMealPrefCombo").removeClass("hide");
		$("select.grpMealPrefCombo").addClass("show");		
		$("img.btDelTravellerDom").removeClass("show");
		$("img.btDelTravellerDom").addClass("hide");
		$("tr.passportDetailRow").removeClass("hide");
		$("tr.passportDetailRow").addClass("show");
		$("table.hrTbl").css("width", "99%");
		
		$("#bt_Add_Traveller").removeClass("bt-Add-Dom");		
		$("#bt_Add_Traveller").addClass("bt-Add-Int");
		$("#bt_Add_Flt").removeClass("bt-Add-Dom");
		$("#bt_Add_Flt").addClass("bt-Add-Int");
		$("#bt_Add_Trn").removeClass("bt-Add-Dom");
		$("#bt_Add_Trn").addClass("bt-Add-Int");
		$("#bt_Add_RentCar").removeClass("bt-Add-Dom");
		$("#bt_Add_RentCar").addClass("bt-Add-Int");
		$("#bt_Add_Accomo").removeClass("bt-Add-Dom");
		$("#bt_Add_Accomo").addClass("bt-Add-Int");
		$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Int");
		$("#bt-Save").removeClass("bt-SubmitToWorkflow-Dom");
		$("#bt-Save").addClass("bt-SubmitToWorkflow-Int");
		$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Int");;
		
		//set placeholder on page load
		resetPlaceHolder();		
		populateWorkFlowApproverList(siteId, userIdGlobal, val, workFlowCode);
	}
	
	function setDomOnClickMode(){
		var workFlowCode = "0";
		var val = $('input#rd_Dom:checked').val();
		var siteId = $("select#siteNameCombo option:selected").val();
		if(siteId != null && siteId == "S") {
			siteId = '0';
		}		
		
		$("select.grpMealPrefCombo").removeClass("show");
		$("select.grpMealPrefCombo").addClass("hide");		
		$("img.btDelTravellerDom").removeClass("hide");
		$("img.btDelTravellerDom").addClass("show");		
		$("tr.passportDetailRow").removeClass("show");
		$("tr.passportDetailRow").addClass("hide");	
		$("table.hrTbl").css("width", "81.5%");
		
		if($('input:radio#fltRequired_Y').is(':checked')) {
			$("label#fltRequiredNo").removeClass("active");
			$("label#fltRequiredYes").addClass("active");
			$("input:radio#fltRequired_Y").attr('checked', true);
			$("input:radio#fltRequired_N").attr('checked', false);
			$("tr#flightDetailDiv").removeClass("hide");
			$("tr#flightDetailDiv").addClass("show");		
			workFlowCode = "1";
		} else {
			$("label#fltRequiredYes").removeClass("active");
			$("label#fltRequiredNo").addClass("active");
			$("input:radio#fltRequired_Y").attr('checked', false);
			$("input:radio#fltRequired_N").attr('checked', true);
			$("tr#flightDetailDiv").removeClass("show");
			$("tr#flightDetailDiv").addClass("hide");
			workFlowCode = "0";
		}	

		if(siteIdGlobal != null && siteIdGlobal != ""){
			if($('input:radio#trnRequired_Y').is(':checked')) {
				$("label#trnRequiredNo").removeClass("active");
				$("label#trnRequiredYes").addClass("active");				
				$("input:radio#trnRequired_Y").attr('checked', true);
				$("input:radio#trnRequired_N").attr('checked', false);
				$("tr#trainDetailDiv").removeClass("hide");
				$("tr#trainDetailDiv").addClass("show");
			} else {
				$("label#trnRequiredYes").removeClass("active");
				$("label#trnRequiredNo").addClass("active");
				$("input:radio#trnRequired_Y").attr('checked', false);
				$("input:radio#trnRequired_N").attr('checked', true);
				$("tr#trainDetailDiv").removeClass("show");
				$("tr#trainDetailDiv").addClass("hide");
			}	
		} else {
			// Added by Gurmeet Singh on 31-07-2015 to disable Train Details Radio Buttons [Start]
			$("label#trnRequiredYes").addClass("disable");
			$("label#trnRequiredNo").addClass("disable");
			$("input:radio#trnRequired_Y").attr('checked', false);
			$("input:radio#trnRequired_N").attr('checked', true);
			$("input:radio#trnRequired_Y").prop('disabled', true);
			$("input:radio#trnRequired_N").prop('disabled', true);
			$("tr#trainDetailDiv").removeClass("show");
			$("tr#trainDetailDiv").addClass("hide");
			// Added by Gurmeet Singh on 31-07-2015 to disable Train Details Radio Buttons [End]
		}


		if($('input:radio#bhnRequired_Y').is(':checked')) {
			$("label#bhnRequiredNo").removeClass("active");
			$("label#bhnRequiredYes").addClass("active");				
			$("input:radio#bhnRequired_Y").attr('checked', true);
			$("input:radio#bhnRequired_N").attr('checked', false);
			$("tr#bahnCardDetailDiv").removeClass("hide");
			$("tr#bahnCardDetailDiv").addClass("show");
		} else {
			$("label#bhnRequiredYes").removeClass("active");
			$("label#bhnRequiredNo").addClass("active");
			$("input:radio#bhnRequired_Y").attr('checked', false);
			$("input:radio#bhnRequired_N").attr('checked', true);
			$("tr#bahnCardDetailDiv").removeClass("show");
			$("tr#bahnCardDetailDiv").addClass("hide");

		}	

		$("label#bhnTktRequiredYes").addClass("active");
		$("label#bhnTktRequiredNo").removeClass("active");
		$("input:radio#bhnTktRequired_Y").attr('checked', true);
		$("input:radio#bhnTktRequired_N").attr('checked', false);

		if($('input:radio#sparzugRequired_Y').is(':checked')) {
			$("label#sparzugRequiredNo").removeClass("active");
			$("label#sparzugRequiredYes").addClass("active");				
			$("input:radio#sparzugRequired_Y").attr('checked', true);
			$("input:radio#sparzugRequired_N").attr('checked', false);
		} else if($('input:radio#sparzugRequired_N').is(':checked')) {
			$("label#sparzugRequiredYes").removeClass("active");
			$("label#sparzugRequiredNo").addClass("active");
			$("input:radio#sparzugRequired_Y").attr('checked', false);
			$("input:radio#sparzugRequired_N").attr('checked', true);
		} else {
			$("label#sparzugRequiredYes").removeClass("active");
			$("label#sparzugRequiredNo").removeClass("active");
			$("input:radio#sparzugRequired_Y").attr('checked', false);
			$("input:radio#sparzugRequired_N").attr('checked', false);
		}

		if(siteIdGlobal != null && siteIdGlobal != ""){
			if($('input:radio#rentCarRequired_Y').is(':checked')) {
				$("label#rentCarRequiredNo").removeClass("active");
				$("label#rentCarRequiredYes").addClass("active");				
				$("input:radio#rentCarRequired_Y").attr('checked', true);
				$("input:radio#rentCarRequired_N").attr('checked', false);
				$("tr#rentCarDetailDiv").removeClass("hide");
				$("tr#rentCarDetailDiv").addClass("show");
			} else {
				$("label#rentCarRequiredYes").removeClass("active");
				$("label#rentCarRequiredNo").addClass("active");
				$("input:radio#rentCarRequired_Y").attr('checked', false);
				$("input:radio#rentCarRequired_N").attr('checked', true);
				$("tr#rentCarDetailDiv").removeClass("show");
				$("tr#rentCarDetailDiv").addClass("hide");
			}
		} else {
			// Added by Gurmeet Singh on 31-07-2015 to disable Rent a Car Radio Buttons [Start]
			$("label#rentCarRequiredYes").addClass("disable");
			$("label#rentCarRequiredNo").addClass("disable");
			$("input:radio#rentCarRequired_Y").attr('checked', false);
			$("input:radio#rentCarRequired_N").attr('checked', true);
			$("input:radio#rentCarRequired_Y").prop('disabled', true);
			$("input:radio#rentCarRequired_N").prop('disabled', true);
			$("tr#rentCarDetailDiv").removeClass("show");
			$("tr#rentCarDetailDiv").addClass("hide");
			// Added by Gurmeet Singh on 31-07-2015 to disable Rent a Car Radio Buttons [End]
		}

		if($('input:radio#gpsRequired_Y').is(':checked')) {
			$("label#gpsRequiredNo").removeClass("active");
			$("label#gpsRequiredYes").addClass("active");				
			$("input:radio#gpsRequired_Y").attr('checked', true);
			$("input:radio#gpsRequired_N").attr('checked', false);
		} else {
			$("label#gpsRequiredYes").removeClass("active");
			$("label#gpsRequiredNo").addClass("active");
			$("input:radio#gpsRequired_Y").attr('checked', false);
			$("input:radio#gpsRequired_N").attr('checked', true);

		}

		$('input:radio#accomodationRequired_N').attr('checked', true);			
		$("select#accomStayType").find('option').eq(0).prop('selected', true);	

		if(siteIdGlobal != null && siteIdGlobal != ""){
			if($('input:radio#accomodationRequired_Y').is(':checked')) {
				$("label#accomodationRequiredNo").removeClass("active");
				$("label#accomodationRequiredYes").addClass("active");
				$("input:radio#accomodationRequired_Y").attr('checked', true);
				$("input:radio#accomodationRequired_N").attr('checked', false);
				$("input#accomodationRequired").val("Accommodation Required");
				$("tr#accomodationDetail").removeClass("hide");	
				$("tr#accomodationDetail").addClass("show");
				$("select#accomStayType").find('option').eq(0).prop('selected', true);				
				$("input#accomPlace").prop('disabled', false);				
				$("input#checkInDate").prop('disabled', false);
				$("input#checkOutDate").prop('disabled', false);
				$("textarea#otherComment").prop('disabled', false);

			} else if($('input:radio#accomodationRequired_N').is(':checked')) {
				$("label#accomodationRequiredYes").removeClass("active");
				$("label#accomodationRequiredNo").addClass("active");
				$("input:radio#accomodationRequired_Y").attr('checked', false);
				$("input:radio#accomodationRequired_N").attr('checked', true);
				$("input#accomodationRequired").val("Accommodation Not Required");
				$("tr#accomodationDetail").removeClass("show");	
				$("tr#accomodationDetail").addClass("hide");
				$("select#accomStayType").find('option').eq(0).prop('selected', true);				
				$("input#accomPlace").prop('disabled', true);				
				$("input#checkInDate").prop('disabled', true);
				$("input#checkOutDate").prop('disabled', true);		
				$("textarea#otherComment").prop('disabled', false);				
			}
		} else {
			// Added by Gurmeet Singh on 31-07-2015 to disable Accommodation Radio Buttons [Start]
			$("label#accomodationRequiredYes").addClass("disable");
			$("label#accomodationRequiredNo").addClass("disable");
			$("input:radio#accomodationRequired_Y").attr('checked', false);
			$("input:radio#accomodationRequired_N").attr('checked', true);
			$("input:radio#accomodationRequired_Y").prop('disabled', true);
			$("input:radio#accomodationRequired_N").prop('disabled', true);
			$("tr#accomodationDetail").removeClass("show");	
			$("tr#accomodationDetail").addClass("hide");
			$("select#accomStayType").find('option').eq(0).prop('selected', true);
			$("input#accomPlace").prop('disabled', true);
			$("input#checkInDate").prop('disabled', true);
			$("input#checkOutDate").prop('disabled', true);		
			$("textarea#otherComment").prop('disabled', false);	
			// Added by Gurmeet Singh on 31-07-2015 to disable Accommodation Radio Buttons [End]
		}
		
		$("label#changeableRequiredYes").addClass("active");
		$("label#changeableRequiredNo").removeClass("active");
		$("input:radio#changeableRequired_Y").attr('checked', true);
		$("input:radio#changeableRequired_N").attr('checked', false);

		$("label#refundableRequiredYes").removeClass("active");
		$("label#refundableRequiredNo").addClass("active");
		$("input:radio#refundableRequired_Y").attr('checked', false);
		$("input:radio#refundableRequired_N").attr('checked', true);

		$("#bt_Add_Traveller").removeClass("bt-Add-Int");		
		$("#bt_Add_Traveller").addClass("bt-Add-Dom");
		$("#bt_Add_Flt").removeClass("bt-Add-Int");
		$("#bt_Add_Flt").addClass("bt-Add-Dom");
		$("#bt_Add_Trn").removeClass("bt-Add-Int");
		$("#bt_Add_Trn").addClass("bt-Add-Dom");
		$("#bt_Add_RentCar").removeClass("bt-Add-Int");
		$("#bt_Add_RentCar").addClass("bt-Add-Dom");
		$("#bt_Add_Accomo").removeClass("bt-Add-Int");
		$("#bt_Add_Accomo").addClass("bt-Add-Dom");
		$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Dom");
		$("#bt-Save").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-Save").addClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Dom");
		
		//set placeholder on page load
		resetPlaceHolder();		
		populateBillingUnitListData(siteId, userIdGlobal, val); 
		populateWorkFlowApproverList(siteId, userIdGlobal, val, workFlowCode);
	}
	
	function setIntOnClickMode(){
		var workFlowCode = "1";
		var val = $('input#rd_Int:checked').val(); 
		var siteId = $("select#siteNameCombo option:selected").val();
		if(siteId != null && siteId == "S") {
			siteId = '0';
		}
		
		$("select.grpMealPrefCombo").removeClass("hide");
		$("select.grpMealPrefCombo").addClass("show");		
		$("img.btDelTravellerDom").removeClass("show");
		$("img.btDelTravellerDom").addClass("hide");
		$("tr.passportDetailRow").removeClass("hide");
		$("tr.passportDetailRow").addClass("show");
		$("table.hrTbl").css("width", "99%");
		
		if($('input:radio#fltRequired_Y').is(':checked')) {
			$("label#fltRequiredNo").removeClass("active");
			$("label#fltRequiredYes").addClass("active");
			$("input:radio#fltRequired_Y").attr('checked', true);
			$("input:radio#fltRequired_N").attr('checked', false);
			$("tr#flightDetailDiv").removeClass("hide");
			$("tr#flightDetailDiv").addClass("show");
		} else {
			$("label#fltRequiredYes").removeClass("active");
			$("label#fltRequiredNo").addClass("active");
			$("input:radio#fltRequired_Y").attr('checked', false);
			$("input:radio#fltRequired_N").attr('checked', true);
			$("tr#flightDetailDiv").removeClass("show");
			$("tr#flightDetailDiv").addClass("hide");
		}	

		if(siteIdGlobal != null && siteIdGlobal != ""){
			if($('input:radio#trnRequired_Y').is(':checked')) {
				$("label#trnRequiredNo").removeClass("active");
				$("label#trnRequiredYes").addClass("active");				
				$("input:radio#trnRequired_Y").attr('checked', true);
				$("input:radio#trnRequired_N").attr('checked', false);
				$("tr#trainDetailDiv").removeClass("hide");
				$("tr#trainDetailDiv").addClass("show");
			} else {
				$("label#trnRequiredYes").removeClass("active");
				$("label#trnRequiredNo").addClass("active");
				$("input:radio#trnRequired_Y").attr('checked', false);
				$("input:radio#trnRequired_N").attr('checked', true);
				$("tr#trainDetailDiv").removeClass("show");
				$("tr#trainDetailDiv").addClass("hide");
			}
		} else {
			// Added by Gurmeet Singh on 31-07-2015 to disable Train Details Radio Buttons [Start]
			$("label#trnRequiredYes").addClass("disable");
			$("label#trnRequiredNo").addClass("disable");
			$("input:radio#trnRequired_Y").attr('checked', false);
			$("input:radio#trnRequired_N").attr('checked', true);
			$("input:radio#trnRequired_Y").prop('disabled', true);
			$("input:radio#trnRequired_N").prop('disabled', true);
			$("tr#trainDetailDiv").removeClass("show");
			$("tr#trainDetailDiv").addClass("hide");
			// Added by Gurmeet Singh on 31-07-2015 to disable Train Details Radio Buttons [End]
		}


		if($('input:radio#bhnRequired_Y').is(':checked')) {
			$("label#bhnRequiredNo").removeClass("active");
			$("label#bhnRequiredYes").addClass("active");				
			$("input:radio#bhnRequired_Y").attr('checked', true);
			$("input:radio#bhnRequired_N").attr('checked', false);
			$("tr#bahnCardDetailDiv").removeClass("hide");
			$("tr#bahnCardDetailDiv").addClass("show");
		} else {
			$("label#bhnRequiredYes").removeClass("active");
			$("label#bhnRequiredNo").addClass("active");
			$("input:radio#bhnRequired_Y").attr('checked', false);
			$("input:radio#bhnRequired_N").attr('checked', true);
			$("tr#bahnCardDetailDiv").removeClass("show");
			$("tr#bahnCardDetailDiv").addClass("hide");

		}	

		$("label#bhnTktRequiredYes").addClass("active");
		$("label#bhnTktRequiredNo").removeClass("active");
		$("input:radio#bhnTktRequired_Y").attr('checked', true);
		$("input:radio#bhnTktRequired_N").attr('checked', false);

		if($('input:radio#sparzugRequired_Y').is(':checked')) {
			$("label#sparzugRequiredNo").removeClass("active");
			$("label#sparzugRequiredYes").addClass("active");				
			$("input:radio#sparzugRequired_Y").attr('checked', true);
			$("input:radio#sparzugRequired_N").attr('checked', false);
		} else if($('input:radio#sparzugRequired_N').is(':checked')) {
			$("label#sparzugRequiredYes").removeClass("active");
			$("label#sparzugRequiredNo").addClass("active");
			$("input:radio#sparzugRequired_Y").attr('checked', false);
			$("input:radio#sparzugRequired_N").attr('checked', true);
		} else {
			$("label#sparzugRequiredYes").removeClass("active");
			$("label#sparzugRequiredNo").removeClass("active");
			$("input:radio#sparzugRequired_Y").attr('checked', false);
			$("input:radio#sparzugRequired_N").attr('checked', false);
		}

		if(siteIdGlobal != null && siteIdGlobal != ""){
			if($('input:radio#rentCarRequired_Y').is(':checked')) {
				$("label#rentCarRequiredNo").removeClass("active");
				$("label#rentCarRequiredYes").addClass("active");				
				$("input:radio#rentCarRequired_Y").attr('checked', true);
				$("input:radio#rentCarRequired_N").attr('checked', false);
				$("tr#rentCarDetailDiv").removeClass("hide");
				$("tr#rentCarDetailDiv").addClass("show");
			} else {
				$("label#rentCarRequiredYes").removeClass("active");
				$("label#rentCarRequiredNo").addClass("active");
				$("input:radio#rentCarRequired_Y").attr('checked', false);
				$("input:radio#rentCarRequired_N").attr('checked', true);
				$("tr#rentCarDetailDiv").removeClass("show");
				$("tr#rentCarDetailDiv").addClass("hide");
			}
		} else {
			// Added by Gurmeet Singh on 31-07-2015 to disable Rent a Car Radio Buttons [Start]
			$("label#rentCarRequiredYes").addClass("disable");
			$("label#rentCarRequiredNo").addClass("disable");
			$("input:radio#rentCarRequired_Y").attr('checked', false);
			$("input:radio#rentCarRequired_N").attr('checked', true);
			$("input:radio#rentCarRequired_Y").prop('disabled', true);
			$("input:radio#rentCarRequired_N").prop('disabled', true);
			$("tr#rentCarDetailDiv").removeClass("show");
			$("tr#rentCarDetailDiv").addClass("hide");
			// Added by Gurmeet Singh on 31-07-2015 to disable Rent a Car Radio Buttons [End]
		}		

		if($('input:radio#gpsRequired_Y').is(':checked')) {
			$("label#gpsRequiredNo").removeClass("active");
			$("label#gpsRequiredYes").addClass("active");				
			$("input:radio#gpsRequired_Y").attr('checked', true);
			$("input:radio#gpsRequired_N").attr('checked', false);
		} else {
			$("label#gpsRequiredYes").removeClass("active");
			$("label#gpsRequiredNo").addClass("active");
			$("input:radio#gpsRequired_Y").attr('checked', false);
			$("input:radio#gpsRequired_N").attr('checked', true);

		}

		$('input:radio#accomodationRequired_N').attr('checked', true);			
		$("select#accomStayType").find('option').eq(0).prop('selected', true);	

		if(siteIdGlobal != null && siteIdGlobal != ""){
			if($('input:radio#accomodationRequired_Y').is(':checked')) {
				$("label#accomodationRequiredNo").removeClass("active");
				$("label#accomodationRequiredYes").addClass("active");
				$("input:radio#accomodationRequired_Y").attr('checked', true);
				$("input:radio#accomodationRequired_N").attr('checked', false);
				$("input#accomodationRequired").val("Accommodation Required");
				$("tr#accomodationDetail").removeClass("hide");	
				$("tr#accomodationDetail").addClass("show");
				$("select#accomStayType").find('option').eq(0).prop('selected', true);
				$("input#accomPlace").prop('disabled', false);
				$("input#checkInDate").prop('disabled', false);
				$("input#checkOutDate").prop('disabled', false);
				$("textarea#otherComment").prop('disabled', false);

			} else if($('input:radio#accomodationRequired_N').is(':checked')) {
				$("label#accomodationRequiredYes").removeClass("active");
				$("label#accomodationRequiredNo").addClass("active");
				$("input:radio#accomodationRequired_Y").attr('checked', false);
				$("input:radio#accomodationRequired_N").attr('checked', true);
				$("input#accomodationRequired").val("Accommodation Not Required");
				$("tr#accomodationDetail").removeClass("show");	
				$("tr#accomodationDetail").addClass("hide");
				$("select#accomStayType").find('option').eq(0).prop('selected', true);
				$("input#accomPlace").prop('disabled', true);
				$("input#checkInDate").prop('disabled', true);
				$("input#checkOutDate").prop('disabled', true);		
				$("textarea#otherComment").prop('disabled', false);				
			}
		} else {
			// Added by Gurmeet Singh on 31-07-2015 to disable Accommodation Radio Buttons [Start]
			$("label#accomodationRequiredYes").addClass("disable");
			$("label#accomodationRequiredNo").addClass("disable");
			$("input:radio#accomodationRequired_Y").attr('checked', false);
			$("input:radio#accomodationRequired_N").attr('checked', true);
			$("input:radio#accomodationRequired_Y").prop('disabled', true);
			$("input:radio#accomodationRequired_N").prop('disabled', true);
			$("tr#accomodationDetail").removeClass("show");	
			$("tr#accomodationDetail").addClass("hide");
			$("select#accomStayType").find('option').eq(0).prop('selected', true);
			$("input#accomPlace").prop('disabled', true);
			$("input#checkInDate").prop('disabled', true);
			$("input#checkOutDate").prop('disabled', true);		
			$("textarea#otherComment").prop('disabled', false);	
			// Added by Gurmeet Singh on 31-07-2015 to disable Accommodation Radio Buttons [End]
		}
		
		$("label#changeableRequiredYes").addClass("active");
		$("label#changeableRequiredNo").removeClass("active");
		$("input:radio#changeableRequired_Y").attr('checked', true);
		$("input:radio#changeableRequired_N").attr('checked', false);

		$("label#refundableRequiredYes").removeClass("active");
		$("label#refundableRequiredNo").addClass("active");
		$("input:radio#refundableRequired_Y").attr('checked', false);
		$("input:radio#refundableRequired_N").attr('checked', true);
		
		$("#bt_Add_Traveller").removeClass("bt-Add-Dom");		
		$("#bt_Add_Traveller").addClass("bt-Add-Int");
		$("#bt_Add_Flt").removeClass("bt-Add-Dom");
		$("#bt_Add_Flt").addClass("bt-Add-Int");
		$("#bt_Add_Trn").removeClass("bt-Add-Dom");
		$("#bt_Add_Trn").addClass("bt-Add-Int");
		$("#bt_Add_RentCar").removeClass("bt-Add-Dom");
		$("#bt_Add_RentCar").addClass("bt-Add-Int");
		$("#bt_Add_Accomo").removeClass("bt-Add-Dom");
		$("#bt_Add_Accomo").addClass("bt-Add-Int");
		$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Int");
		$("#bt-Save").removeClass("bt-SubmitToWorkflow-Dom");
		$("#bt-Save").addClass("bt-SubmitToWorkflow-Int");
		$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Int");
		
		//set placeholder on page load
		resetPlaceHolder();			
		populateBillingUnitListData(siteId, userIdGlobal, val);
		populateWorkFlowApproverList(siteId, userIdGlobal, val, workFlowCode);
		
	}
	
	function setDomInCheckedMode(){	
		var workFlowCode = "0";
		var val = $('input#rd_Dom:checked').val();
		var siteId = $("select#siteNameCombo option:selected").val();
		if(siteId != null && siteId == "S") {
			siteId = '0';
		}
		
		$("select.grpMealPrefCombo").removeClass("show");
		$("select.grpMealPrefCombo").addClass("hide");		
		$("img.btDelTravellerDom").removeClass("hide");
		$("img.btDelTravellerDom").addClass("show");		
		$("tr.passportDetailRow").removeClass("show");
		$("tr.passportDetailRow").addClass("hide");
		$("table.hrTbl").css("width", "81.5%");
		
		if($('input:radio#fltRequired_Y').is(':checked')) {
			$("label#fltRequiredNo").removeClass("active");
			$("label#fltRequiredYes").addClass("active");
			$("input:radio#fltRequired_Y").attr('checked', true);
			$("input:radio#fltRequired_N").attr('checked', false);
			$("tr#flightDetailDiv").removeClass("hide");
			$("tr#flightDetailDiv").addClass("show");
			workFlowCode = "1";
		} else {
			$("label#fltRequiredYes").removeClass("active");
			$("label#fltRequiredNo").addClass("active");
			$("input:radio#fltRequired_Y").attr('checked', false);
			$("input:radio#fltRequired_N").attr('checked', true);
			$("tr#flightDetailDiv").removeClass("show");
			$("tr#flightDetailDiv").addClass("hide");
			workFlowCode = "0";
		}	

		if(siteIdGlobal != null && siteIdGlobal != ""){			
			if($('input:radio#trnRequired_Y').is(':checked')) {
				$("label#trnRequiredNo").removeClass("active");
				$("label#trnRequiredYes").addClass("active");				
				$("input:radio#trnRequired_Y").attr('checked', true);
				$("input:radio#trnRequired_N").attr('checked', false);
				$("tr#trainDetailDiv").removeClass("hide");
				$("tr#trainDetailDiv").addClass("show");
			} else {
				$("label#trnRequiredYes").removeClass("active");
				$("label#trnRequiredNo").addClass("active");
				$("input:radio#trnRequired_Y").attr('checked', false);
				$("input:radio#trnRequired_N").attr('checked', true);
				$("tr#trainDetailDiv").removeClass("show");
				$("tr#trainDetailDiv").addClass("hide");
			}
		} else {
			// Added by Gurmeet Singh on 31-07-2015 to disable Train Details Radio Buttons [Start]
			$("label#trnRequiredYes").addClass("disable");
			$("label#trnRequiredNo").addClass("disable");
			$("input:radio#trnRequired_Y").attr('checked', false);
			$("input:radio#trnRequired_N").attr('checked', true);
			$("input:radio#trnRequired_Y").prop('disabled', true);
			$("input:radio#trnRequired_N").prop('disabled', true);
			$("tr#trainDetailDiv").removeClass("show");
			$("tr#trainDetailDiv").addClass("hide");
			// Added by Gurmeet Singh on 31-07-2015 to disable Train Details Radio Buttons [End]
		}		

		if($('input:radio#bhnRequired_Y').is(':checked')) {
			$("label#bhnRequiredNo").removeClass("active");
			$("label#bhnRequiredYes").addClass("active");				
			$("input:radio#bhnRequired_Y").attr('checked', true);
			$("input:radio#bhnRequired_N").attr('checked', false);
			$("tr#bahnCardDetailDiv").removeClass("hide");
			$("tr#bahnCardDetailDiv").addClass("show");
		} else {
			$("label#bhnRequiredYes").removeClass("active");
			$("label#bhnRequiredNo").addClass("active");
			$("input:radio#bhnRequired_Y").attr('checked', false);
			$("input:radio#bhnRequired_N").attr('checked', true);
			$("tr#bahnCardDetailDiv").removeClass("show");
			$("tr#bahnCardDetailDiv").addClass("hide");

		}	

		$("label#bhnTktRequiredYes").addClass("active");
		$("label#bhnTktRequiredNo").removeClass("active");
		$("input:radio#bhnTktRequired_Y").attr('checked', true);
		$("input:radio#bhnTktRequired_N").attr('checked', false);


		if($('input:radio#sparzugRequired_Y').is(':checked')) {
			$("label#sparzugRequiredNo").removeClass("active");
			$("label#sparzugRequiredYes").addClass("active");				
			$("input:radio#sparzugRequired_Y").attr('checked', true);
			$("input:radio#sparzugRequired_N").attr('checked', false);
		} else if($('input:radio#sparzugRequired_N').is(':checked')) {
			$("label#sparzugRequiredYes").removeClass("active");
			$("label#sparzugRequiredNo").addClass("active");
			$("input:radio#sparzugRequired_Y").attr('checked', false);
			$("input:radio#sparzugRequired_N").attr('checked', true);
		} else {
			$("label#sparzugRequiredYes").removeClass("active");
			$("label#sparzugRequiredNo").removeClass("active");
			$("input:radio#sparzugRequired_Y").attr('checked', false);
			$("input:radio#sparzugRequired_N").attr('checked', false);
		}

		if(siteIdGlobal != null && siteIdGlobal != ""){
			if($('input:radio#rentCarRequired_Y').is(':checked')) {
				$("label#rentCarRequiredNo").removeClass("active");
				$("label#rentCarRequiredYes").addClass("active");				
				$("input:radio#rentCarRequired_Y").attr('checked', true);
				$("input:radio#rentCarRequired_N").attr('checked', false);
				$("tr#rentCarDetailDiv").removeClass("hide");
				$("tr#rentCarDetailDiv").addClass("show");
			} else {
				$("label#rentCarRequiredYes").removeClass("active");
				$("label#rentCarRequiredNo").addClass("active");
				$("input:radio#rentCarRequired_Y").attr('checked', false);
				$("input:radio#rentCarRequired_N").attr('checked', true);
				$("tr#rentCarDetailDiv").removeClass("show");
				$("tr#rentCarDetailDiv").addClass("hide");
			}
		} else {
			// Added by Gurmeet Singh on 31-07-2015 to disable Rent a Car Radio Buttons [Start]
			$("label#rentCarRequiredYes").addClass("disable");
			$("label#rentCarRequiredNo").addClass("disable");
			$("input:radio#rentCarRequired_Y").attr('checked', false);
			$("input:radio#rentCarRequired_N").attr('checked', true);
			$("input:radio#rentCarRequired_Y").prop('disabled', true);
			$("input:radio#rentCarRequired_N").prop('disabled', true);
			$("tr#rentCarDetailDiv").removeClass("show");
			$("tr#rentCarDetailDiv").addClass("hide");
			// Added by Gurmeet Singh on 31-07-2015 to disable Rent a Car Radio Buttons [End]
		}		

		if($('input:radio#gpsRequired_Y').is(':checked')) {
			$("label#gpsRequiredNo").removeClass("active");
			$("label#gpsRequiredYes").addClass("active");				
			$("input:radio#gpsRequired_Y").attr('checked', true);
			$("input:radio#gpsRequired_N").attr('checked', false);
		} else {
			$("label#gpsRequiredYes").removeClass("active");
			$("label#gpsRequiredNo").addClass("active");
			$("input:radio#gpsRequired_Y").attr('checked', false);
			$("input:radio#gpsRequired_N").attr('checked', true);

		}

		$('input:radio#accomodationRequired_N').attr('checked', true);			
		$("select#accomStayType").find('option').eq(0).prop('selected', true);		

		if(siteIdGlobal != null && siteIdGlobal != ""){
			if($('input:radio#accomodationRequired_Y').is(':checked')) {
				$("label#accomodationRequiredNo").removeClass("active");
				$("label#accomodationRequiredYes").addClass("active");
				$("input:radio#accomodationRequired_Y").attr('checked', true);
				$("input:radio#accomodationRequired_N").attr('checked', false);
				$("input#accomodationRequired").val("Accommodation Required");
				$("tr#accomodationDetail").removeClass("hide");	
				$("tr#accomodationDetail").addClass("show");
				$("select#accomStayType").find('option').eq(0).prop('selected', true);
				$("input#accomPlace").prop('disabled', false);
				$("input#checkInDate").prop('disabled', false);
				$("input#checkOutDate").prop('disabled', false);
				$("textarea#otherComment").prop('disabled', false);

			} else if($('input:radio#accomodationRequired_N').is(':checked')) {
				$("label#accomodationRequiredYes").removeClass("active");
				$("label#accomodationRequiredNo").addClass("active");
				$("input:radio#accomodationRequired_Y").attr('checked', false);
				$("input:radio#accomodationRequired_N").attr('checked', true);
				$("input#accomodationRequired").val("Accommodation Not Required");
				$("tr#accomodationDetail").removeClass("show");	
				$("tr#accomodationDetail").addClass("hide");
				$("select#accomStayType").find('option').eq(0).prop('selected', true);
				$("input#accomPlace").prop('disabled', true);
				$("input#checkInDate").prop('disabled', true);
				$("input#checkOutDate").prop('disabled', true);		
				$("textarea#otherComment").prop('disabled', false);				
			}
		} else {
			// Added by Gurmeet Singh on 31-07-2015 to disable Accommodation Radio Buttons [Start]
			$("label#accomodationRequiredYes").addClass("disable");
			$("label#accomodationRequiredNo").addClass("disable");
			$("input:radio#accomodationRequired_Y").attr('checked', false);
			$("input:radio#accomodationRequired_N").attr('checked', true);
			$("input:radio#accomodationRequired_Y").prop('disabled', true);
			$("input:radio#accomodationRequired_N").prop('disabled', true);
			$("tr#accomodationDetail").removeClass("show");	
			$("tr#accomodationDetail").addClass("hide");
			$("select#accomStayType").find('option').eq(0).prop('selected', true);
			$("input#accomPlace").prop('disabled', true);
			$("input#checkInDate").prop('disabled', true);
			$("input#checkOutDate").prop('disabled', true);		
			$("textarea#otherComment").prop('disabled', false);	
			// Added by Gurmeet Singh on 31-07-2015 to disable Accommodation Radio Buttons [End]
		}
		
		$("label#changeableRequiredYes").addClass("active");
		$("label#changeableRequiredNo").removeClass("active");
		$("input:radio#changeableRequired_Y").attr('checked', true);
		$("input:radio#changeableRequired_N").attr('checked', false);

		$("label#refundableRequiredYes").removeClass("active");
		$("label#refundableRequiredNo").addClass("active");
		$("input:radio#refundableRequired_Y").attr('checked', false);
		$("input:radio#refundableRequired_N").attr('checked', true);

		$("#bt_Add_Traveller").removeClass("bt-Add-Int");		
		$("#bt_Add_Traveller").addClass("bt-Add-Dom");
		$("#bt_Add_Flt").removeClass("bt-Add-Int");
		$("#bt_Add_Flt").addClass("bt-Add-Dom");
		$("#bt_Add_Trn").removeClass("bt-Add-Int");
		$("#bt_Add_Trn").addClass("bt-Add-Dom");
		$("#bt_Add_RentCar").removeClass("bt-Add-Int");
		$("#bt_Add_RentCar").addClass("bt-Add-Dom");
		$("#bt_Add_Accomo").removeClass("bt-Add-Int");
		$("#bt_Add_Accomo").addClass("bt-Add-Dom");
		$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Dom");
		$("#bt-Save").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-Save").addClass("bt-SubmitToWorkflow-Dom");
		$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Int");
		$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Dom");
		
		//set placeholder on page load
		resetPlaceHolder();			
		populateBillingUnitListData(siteId, userIdGlobal, val); 
		populateWorkFlowApproverList(siteId, userIdGlobal, val, workFlowCode);
	}
	
	function clearPersonalDetails() {
		$("#travellerSiteId").val('');
		$("#travellerUserId").val('');
		$("#siteName").val('');
		$("#firstName").val('');
		$("#lastName").val('');
		$("#designation").val('');
		$("#projectNo").val('');
		$("#costCenter").val('');
		$("#costCenterName").val('');		
	}	
	
	function clearApproversDetails() {
		$("#firstApprover").val('');
		$("#secondApprover").val('');
	}
	
	function resetGuestInfo() {
		var master = $("table#groupGuestDetailTbl");
		var dataRow = master.find("tbody tr.groupGuestDetailDataRow");
		
		dataRow.find("#grpUserID").val("");				
		dataRow.find("#fNameGroup").val("First Names as per passport");
		dataRow.find("#fNameGroup").attr('style','color:rgb(122, 122, 122)');
		dataRow.find("#lNameGroup").val("Last Names as per passport");
		dataRow.find("#lNameGroup").attr('style','color:rgb(122, 122, 122)');
		dataRow.find("#dobGroup").val("Date of Birth");
		dataRow.find("#dobGroup").attr('style','color:rgb(122, 122, 122)');
		dataRow.find("select#genderGroup").val('-1');
		dataRow.find("#mobileNoGroup").val("Contact No.");
		dataRow.find("#mobileNoGroup").attr('style','color:rgb(122, 122, 122)');
		dataRow.find("#frequentFlyerGroup").val("Frequent Flyer");
		dataRow.find("#frequentFlyerGroup").attr('style','color:rgb(122, 122, 122)');	
		dataRow.find("select#specialMealGroup").val('-1');		
		dataRow.find("#passportNoGroup").val("Passport Number");
		dataRow.find("#passportNoGroup").attr('style','color:rgb(122, 122, 122)');
		dataRow.find("#nationalityGroup").val("Nationality as per passport");
		dataRow.find("#nationalityGroup").attr('style','color:rgb(122, 122, 122)');
		dataRow.find("#placeOfIssueGroup").val("Place of Issue");	
		dataRow.find("#placeOfIssueGroup").attr('style','color:rgb(122, 122, 122)');
		dataRow.find("#dateOfIssueGroup").val("Date of Issue");	
		dataRow.find("#dateOfIssueGroup").attr('style','color:rgb(122, 122, 122)');
		dataRow.find("#dateOfExpiryGroup").val("Date of Expiry");	
		dataRow.find("#dateOfExpiryGroup").attr('style','color:rgb(122, 122, 122)');
		dataRow.find("select#visaGroup").val("2");
	}
	
	// GPS required[Yes] button click event
	$('input:radio#gpsRequired_Y').click(function() {	
		$(this).attr('checked', true);
		$("label#gpsRequiredNo").removeClass("active");
		$("label#gpsRequiredYes").addClass("active");				
		$("input:radio#gpsRequired_Y").attr('checked', true);
		$("input:radio#gpsRequired_N").attr('checked', false);
	});

	// GPS required[No] button click event
	$('input:radio#gpsRequired_N').click(function() {
		$(this).attr('checked', true);
		$("label#gpsRequiredYes").removeClass("active");
		$("label#gpsRequiredNo").addClass("active");
		$("input:radio#gpsRequired_Y").attr('checked', false);
		$("input:radio#gpsRequired_N").attr('checked', true);
	});
	

	$(document).ready(function() {
		
		// flight required[Yes] button click event
		$('input:radio#fltRequired_Y').click(function() {	
			$(this).attr('checked', true);
			$("label#fltRequiredNo").removeClass("active");
			$("label#fltRequiredYes").addClass("active");
			$("input:radio#fltRequired_Y").attr('checked', true);
			$("input:radio#fltRequired_N").attr('checked', false);
			$("tr#flightDetailDiv").removeClass("hide");
			$("tr#flightDetailDiv").addClass("show");

			//Get Approver(s) List
			var val = "";
			var workFlowCode = "1";
			var siteId = $("select#siteNameCombo option:selected").val();

			if($('input#rd_Dom').is(':checked')) {
				$('input#rd_Int').attr('checked', false);
				$('input#rd_Dom').val("D");
				val = $('input#rd_Dom:checked').val();
			} else if($('input#rd_Int').is(':checked')) {
				$('input#rd_Dom').attr('checked', false);
				$('input#rd_Int').val("I");
				val = $('input#rd_Int:checked').val();
			}

			populateWorkFlowApproverList(siteId, userIdGlobal, val, workFlowCode);

			setTravellerPreference(true, false, false);

		});

		// flight required[No] button click event
		$('input:radio#fltRequired_N').click(function() {
			$(this).attr('checked', true);
			var checkItnrFlagFlt = false;
			if($("label#fltRequiredYes").hasClass('active')){

				var depCityFlt = document.getElementsByName("depCityFlt");
				var arrCityFlt = document.getElementsByName("arrCityFlt");
				var depDateFlt = document.getElementsByName("depDateFlt");

				for(var i = 0, len = depCityFlt.length; i < len; i++) {
					if((depCityFlt[i].value != '' && depCityFlt[i].value != 'Departure City') || (arrCityFlt[i].value != '' && arrCityFlt[i].value != 'Arrival City')
							|| (depDateFlt[i].value != '' && depDateFlt[i].value != 'Departure Date')) {			
						checkItnrFlagFlt = true;
						break;
					}
				}		        

				var result = false;
				if(checkItnrFlagFlt){
					result = confirm('Do you want to remove flight detail.');
				} else {
					$("label#fltRequiredYes").removeClass("active");
					$("label#fltRequiredNo").addClass("active");
					$("input:radio#fltRequired_Y").attr('checked', false);
					$("input:radio#fltRequired_N").attr('checked', true);
					$("tr#flightDetailDiv").removeClass("show");
					$("tr#flightDetailDiv").addClass("hide");
				}

				if(result){
					deleteFlightDetails();

					$("label#fltRequiredYes").removeClass("active");
					$("label#fltRequiredNo").addClass("active");
					$("input:radio#fltRequired_Y").attr('checked', false);
					$("input:radio#fltRequired_N").attr('checked', true);
					$("tr#flightDetailDiv").removeClass("show");
					$("tr#flightDetailDiv").addClass("hide");

					//Remove intermediate rows and clear Forward & Return leg details
					$(".itineraryDataRowFlt").remove();
					$('#intermediateLableFlt').addClass('hide');

					$("input#depCityFltTBFwd").val('Departure City');
					$("input#depCityFltTBFwd").attr('style','color:rgb(122, 122, 122)');
					$("input#arrCityFltTBFwd").val("Arrival City");
					$("input#arrCityFltTBFwd").attr('style','color:rgb(122, 122, 122)');
					$("input#depDateFltTBFwd").val("Departure Date");
					$("input#depDateFltTBFwd").attr('style','color:rgb(122, 122, 122)');
					$("select#preferTimeModeFltSBFwd").val("2");
					$("select#preferTimeFltSBFwd").val("13");
					$("select#departClassFltSBFwd").val("24");
					$("select#seatPreffredFltSBFwd").val("21");

					$("input#depCityFltTBRet").val('Departure City');
					$("input#depCityFltTBRet").attr('style','color:rgb(122, 122, 122)');
					$("input#arrCityFltTBRet").val("Arrival City");
					$("input#arrCityFltTBRet").attr('style','color:rgb(122, 122, 122)');
					$("input#depDateFltTBRet").val("Departure Date");
					$("input#depDateFltTBRet").attr('style','color:rgb(122, 122, 122)');
					$("select#preferTimeModeFltSBRet").val("1");
					$("select#preferTimeFltSBRet").val("22");
					$("select#departClassFltSBRet").val("24");
					$("select#seatPreffredFltSBRet").val("21");
					$("#remarksFlt").val("Remarks");
					$("#remarksFlt").attr('style','color:rgb(122, 122, 122)');

					$("label#changeableRequiredYes").addClass("active");
					$("label#changeableRequiredNo").removeClass("active");
					$("input:radio#changeableRequired_Y").attr('checked', true);
					$("input:radio#changeableRequired_N").attr('checked', false);

					$("label#refundableRequiredYes").removeClass("active");
					$("label#refundableRequiredNo").addClass("active");
					$("input:radio#refundableRequired_Y").attr('checked', false);
					$("input:radio#refundableRequired_N").attr('checked', true);

					$("select#baggageFlt").val("0");
				}
			}

			//Get Approver(s) List
			var val = "";
			var workFlowCode = "0";
			var siteId = $("select#siteNameCombo option:selected").val();

			if($('input#rd_Dom').is(':checked')) {
				$('input#rd_Int').attr('checked', false);
				$('input#rd_Dom').val("D");
				val = $('input#rd_Dom:checked').val(); 
				workFlowCode = "0";
			} else if($('input#rd_Int').is(':checked')) {
				$('input#rd_Dom').attr('checked', false);
				$('input#rd_Int').val("I");
				val = $('input#rd_Int:checked').val(); 
				workFlowCode = "1";
			}

			populateWorkFlowApproverList(siteId, userIdGlobal, val, workFlowCode);
		});

		// Train required[Yes] button click event
		$('input:radio#trnRequired_Y').click(function() {
			$(this).attr('checked', true);
			$("label#trnRequiredNo").removeClass("active");
			$("label#trnRequiredYes").addClass("active");				
			$("input:radio#trnRequired_Y").attr('checked', true);
			$("input:radio#trnRequired_N").attr('checked', false);
			$("tr#trainDetailDiv").removeClass("hide");
			$("tr#trainDetailDiv").addClass("show");


			setTravellerPreference(false, true, false);
		});

		// Train required[No] button click event
		$('input:radio#trnRequired_N').click(function() {
			$(this).attr('checked', true);
			var checkItnrFlagTrn = false;
			if($("label#trnRequiredYes").hasClass('active')){

				var depCityTrn = document.getElementsByName("depCityTrn");
				var arrCityTrn = document.getElementsByName("arrCityTrn");
				var depDateTrn = document.getElementsByName("depDateTrn");

				for(var i = 0, len = depCityTrn.length; i < len; i++) {
					if((depCityTrn[i].value != '' && depCityTrn[i].value != 'Departure City') || (arrCityTrn[i].value != '' && arrCityTrn[i].value != 'Arrival City')
							|| (depDateTrn[i].value != '' && depDateTrn[i].value != 'Departure Date')) {			
						checkItnrFlagTrn = true;
						break;
					}
				}		        

				var result = false;
				if(checkItnrFlagTrn){
					result = confirm('Do you want to remove train detail.');
				} else{
					$("label#trnRequiredYes").removeClass("active");
					$("label#trnRequiredNo").addClass("active");
					$("input:radio#trnRequired_Y").attr('checked', false);
					$("input:radio#trnRequired_N").attr('checked', true);
					$("tr#trainDetailDiv").removeClass("show");
					$("tr#trainDetailDiv").addClass("hide");	
				}

				if(result){
					deleteTrainDetails();

					$("label#trnRequiredYes").removeClass("active");
					$("label#trnRequiredNo").addClass("active");
					$("input:radio#trnRequired_Y").attr('checked', false);
					$("input:radio#trnRequired_N").attr('checked', true);
					$("tr#trainDetailDiv").removeClass("show");
					$("tr#trainDetailDiv").addClass("hide");

					//Remove intermediate rows and clear Forward & Return leg details
					$(".itineraryDataRowTrn").remove();
					$('#intermediateLabelTrn').removeClass('show');
					$('#intermediateLabelTrn').addClass('hide');

					$("input#depCityTrnTBFwd").val('Departure City');
					$("input#depCityTrnTBFwd").attr('style','color:rgb(122, 122, 122)');
					$("input#arrCityTrnTBFwd").val("Arrival City");
					$("input#arrCityTrnTBFwd").attr('style','color:rgb(122, 122, 122)');
					$("input#depDateTrnTBFwd").val("Departure Date");
					$("input#depDateTrnTBFwd").attr('style','color:rgb(122, 122, 122)');
					$("select#preferTimeModeTrnSBFwd").val("2");
					$("select#preferTimeTrnSBFwd").val("13");
					$("select#departClassTrnSBFwd").val("23");
					$("select#seatPreffredTrnType1SBFwd").val("Aisle");
					$("select#seatPreffredTrnType2SBFwd").val("Grossraum");
					$("select#seatPreffredTrnType3SBFwd").val("Without Table");

					$("input#depCityTrnTBRet").val('Departure City');
					$("input#depCityTrnTBRet").attr('style','color:rgb(122, 122, 122)');
					$("input#arrCityTrnTBRet").val("Arrival City");
					$("input#arrCityTrnTBRet").attr('style','color:rgb(122, 122, 122)');
					$("input#depDateTrnTBRet").val("Departure Date");
					$("input#depDateTrnTBRet").attr('style','color:rgb(122, 122, 122)');
					$("select#preferTimeModeTrnSBRet").val("1");
					$("select#preferTimeTrnSBRet").val("22");
					$("select#departClassTrnSBRet").val("23");
					$("select#seatPreffredTrnType1SBRet").val("Aisle");
					$("select#seatPreffredTrnType2SBRet").val("Grossraum");
					$("select#seatPreffredTrnType3SBRet").val("Without Table");
					$("#remarksTrn").val("Remarks");
					$("#remarksTrn").attr('style','color:rgb(122, 122, 122)');

					$("label#bhnRequiredYes").removeClass("active");
					$("label#bhnRequiredNo").addClass("active");
					$("input:radio#bhnRequired_Y").attr('checked', false);
					$("input:radio#bhnRequired_N").attr('checked', true);
					$("tr#bahnCardDetailDiv").removeClass("show");
					$("tr#bahnCardDetailDiv").addClass("hide");
					$("input#bahnNo").val('');
					$("select#bahnCardDisc").val("25");
					$("select#bahnCardClass").val("2");
					$("label#bhnTktRequiredYes").addClass("active");
					$("label#bhnTktRequiredNo").removeClass("active");
					$("input:radio#bhnTktRequired_Y").attr('checked', true);
					$("input:radio#bhnTktRequired_N").attr('checked', false);

					$("label#sparzugRequiredYes").removeClass("active");
					$("label#sparzugRequiredNo").removeClass("active");
					$("input:radio#sparzugRequired_Y").attr('checked', false);
					$("input:radio#sparzugRequired_N").attr('checked', false);
				}
			}
		});
		// BahnCard required[Yes] button click event
		$('input:radio#bhnRequired_Y').click(function() {
			$(this).attr('checked', true);
			$("label#bhnRequiredNo").removeClass("active");
			$("label#bhnRequiredYes").addClass("active");				
			$("input:radio#bhnRequired_Y").attr('checked', true);
			$("input:radio#bhnRequired_N").attr('checked', false);
			$("tr#bahnCardDetailDiv").removeClass("hide");
			$("tr#bahnCardDetailDiv").addClass("show");


			setTravellerPreference(false, false, true);
		});
		// BahnCard required[No] button click event
		$('input:radio#bhnRequired_N').click(function() {
			$(this).attr('checked', true);
			var checkItnrFlagBahnCard = false;
			if($("label#bhnRequiredYes").hasClass('active')){

				var bahnCardNo = document.getElementById("bahnNo");
				var bahnCardValidDate = document.getElementById("bahnCardValidDate");

				if(bahnCardNo.value != '' || bahnCardValidDate.value != '') {
					checkItnrFlagBahnCard = true;
				}

				var result = false;				
				if(checkItnrFlagBahnCard){		        
					result = confirm('Do you want to remove Bahncard detail.');
				} else {
					$("label#bhnRequiredYes").removeClass("active");
					$("label#bhnRequiredNo").addClass("active");
					$("input:radio#bhnRequired_Y").attr('checked', false);
					$("input:radio#bhnRequired_N").attr('checked', true);
					$("tr#bahnCardDetailDiv").removeClass("show");
					$("tr#bahnCardDetailDiv").addClass("hide");
				}

				if(result){
					$("label#bhnRequiredYes").removeClass("active");
					$("label#bhnRequiredNo").addClass("active");
					$("input:radio#bhnRequired_Y").attr('checked', false);
					$("input:radio#bhnRequired_N").attr('checked', true);
					$("tr#bahnCardDetailDiv").removeClass("show");
					$("tr#bahnCardDetailDiv").addClass("hide");
					$("input#bahnNo").val('');
					$("select#bahnCardDisc").val("25");
					$("select#bahnCardClass").val("0");
					$("input#bahnCardValidDate").val('');
					$("label#bhnTktRequiredYes").addClass("active");
					$("label#bhnTktRequiredNo").removeClass("active");
					$("input:radio#bhnTktRequired_Y").attr('checked', true);
					$("input:radio#bhnTktRequired_N").attr('checked', false);
				}
			}
		});

		// BahnCard Online Ticket required[Yes] button click event
		$('input:radio#bhnTktRequired_Y').click(function() {
			$(this).attr('checked', true);
			$("label#bhnTktRequiredNo").removeClass("active");
			$("label#bhnTktRequiredYes").addClass("active");				
			$("input:radio#bhnTktRequired_Y").attr('checked', true);
			$("input:radio#bhnTktRequired_N").attr('checked', false);
		});

		// BahnCard Online Ticket required[No] button click event
		$('input:radio#bhnTktRequired_N').click(function() {
			$(this).attr('checked', true);
			$("label#bhnTktRequiredYes").removeClass("active");
			$("label#bhnTktRequiredNo").addClass("active");
			$("input:radio#bhnTktRequired_Y").attr('checked', false);
			$("input:radio#bhnTktRequired_N").attr('checked', true);
		});

		// Fares Sparpreis mit Zugbindung required[Yes] button click event
		$('input:radio#sparzugRequired_Y').click(function() {	
			$(this).attr('checked', true);
			$("label#sparzugRequiredNo").removeClass("active");
			$("label#sparzugRequiredYes").addClass("active");				
			$("input:radio#sparzugRequired_Y").attr('checked', true);
			$("input:radio#sparzugRequired_N").attr('checked', false);
		});

		// Fares Sparpreis mit Zugbindung required[No] button click event
		$('input:radio#sparzugRequired_N').click(function() {
			$(this).attr('checked', true);
			$("label#sparzugRequiredYes").removeClass("active");
			$("label#sparzugRequiredNo").addClass("active");
			$("input:radio#sparzugRequired_Y").attr('checked', false);
			$("input:radio#sparzugRequired_N").attr('checked', true);
		});

		// Rent Car required[Yes] button click event
		$('input:radio#rentCarRequired_Y').click(function() {
			$(this).attr('checked', true);
			$("label#rentCarRequiredNo").removeClass("active");
			$("label#rentCarRequiredYes").addClass("active");				
			$("input:radio#rentCarRequired_Y").attr('checked', true);
			$("input:radio#rentCarRequired_N").attr('checked', false);
			$("tr#rentCarDetailDiv").removeClass("hide");
			$("tr#rentCarDetailDiv").addClass("show");

			resetRentaCarData(document.getElementById('carClass'), document.getElementById('carClass').value);
		});

		// Rent Car required[No] button click event
		$('input:radio#rentCarRequired_N').click(function() {
			$(this).attr('checked', true);
			var checkItnrFlagCar = false;
			var rowCountCar = $("table#tblRentCar tbody tr.rentCarDataRow").length;

			if($("label#rentCarRequiredYes").hasClass('active')){

				var startDate = document.getElementsByName("startDate");
				var startCity = document.getElementsByName("startCity");
				var startMobileNo = document.getElementsByName("startMobileNo");
				var endDate = document.getElementsByName("endDate");
				var endCity = document.getElementsByName("endCity");
				var endMobileNo = document.getElementsByName("endMobileNo");

				for(var i = 0, len = rowCountCar; i < len; i++) {				
					if((startDate[i].value != '' && startDate[i].value != 'Start Date') || (startCity[i].value != '' && startCity[i].value != 'Start City') 
							|| (endDate[i].value != '' && endDate[i].value != 'End Date') || (endCity[i].value != '' && endCity[i].value != 'End City') 
							|| (startMobileNo[i].value != '' && startMobileNo[i].value != 'Mobile Number') || (endMobileNo[i].value != '' && endMobileNo[i].value != 'Mobile Number')) {
						checkItnrFlagCar = true;
						break;
					}
				}

				var result = false;				
				if(checkItnrFlagCar){
					result = confirm('Do you want to remove car reservation detail.');
				} else {
					$("label#rentCarRequiredYes").removeClass("active");
					$("label#rentCarRequiredNo").addClass("active");
					$("input:radio#rentCarRequired_Y").attr('checked', false);
					$("input:radio#rentCarRequired_N").attr('checked', true);
					$("tr#rentCarDetailDiv").removeClass("show");
					$("tr#rentCarDetailDiv").addClass("hide");
					$("select#carClass").find('option:first').prop('selected', 'selected');
					$("label#gpsRequiredYes").removeClass("active");
					$("label#gpsRequiredNo").addClass("active");
					$("input:radio#gpsRequired_Y").attr('checked', false);
					$("input:radio#gpsRequired_N").attr('checked', true);
					$("select#carCategory").val("2");
				}


				if(result){
					deleteCarDetailsAll();

					$("label#rentCarRequiredYes").removeClass("active");
					$("label#rentCarRequiredNo").addClass("active");
					$("input:radio#rentCarRequired_Y").attr('checked', false);
					$("input:radio#rentCarRequired_N").attr('checked', true);
					$("tr#rentCarDetailDiv").removeClass("show");
					$("tr#rentCarDetailDiv").addClass("hide");

					$("select#carClass").find('option:first').prop('selected', 'selected');
					$("input#startDate").val('Start Date');
					$("input#startDate").attr('style','color:rgb(122, 122, 122)');
					$("input#endDate").val('End Date');
					$("input#endDate").attr('style','color:rgb(122, 122, 122)');
					$("select#startTime").val("102");
					$("select#endTime").val("102");
					$("input#startCity").val('Start City');
					$("input#startCity").attr('style','color:rgb(122, 122, 122)');
					$("input#endCity").val('End City');
					$("input#endCity").attr('style','color:rgb(122, 122, 122)');
					$("select#startLocation").val("1");
					$("select#endLocation").val("1");
					$("input#startMobileNo").val('Mobile Number');
					$("input#startMobileNo").attr('style','color:rgb(122, 122, 122)');
					$("input#startMobileNo").addClass('hide');					
					$("input#endMobileNo").val('Mobile Number');
					$("input#endMobileNo").attr('style','color:rgb(122, 122, 122)');
					$("input#endMobileNo").addClass('hide');
					$("label#gpsRequiredYes").removeClass("active");
					$("label#gpsRequiredNo").addClass("active");
					$("input:radio#gpsRequired_Y").attr('checked', false);
					$("input:radio#gpsRequired_N").attr('checked', true);
					$("select#carCategory").val("2");
					$(".rentCarDataRow").each(function(index) {					    
						if(index != 0){
							$(this).remove();
						} else {					    	
							$("input#startDate").val('Start Date');
							$("input#startDate").attr('style','color:rgb(122, 122, 122)');
							$("input#endDate").val('End Date');
							$("input#endDate").attr('style','color:rgb(122, 122, 122)');
							$("select#startTime").val("102");
							$("select#endTime").val("102");
							$("input#startCity").val('Start City');
							$("input#startCity").attr('style','color:rgb(122, 122, 122)');
							$("input#endCity").val('End City');
							$("input#endCity").attr('style','color:rgb(122, 122, 122)');
							$("select#startLocation").val("1");
							$("select#endLocation").val("1");
							$("input#startMobileNo").val('Mobile Number');
							$("input#startMobileNo").attr('style','color:rgb(122, 122, 122)');
							$("#startMobileNoTdInput").addClass('hide');
							$("input#startMobileNo").addClass('hide');							
							$("input#endMobileNo").val('Mobile Number');
							$("input#endMobileNo").attr('style','color:rgb(122, 122, 122)');
							$("#endMobileNoTdInput").addClass('hide');
							$("input#endMobileNo").addClass('hide');
						}
					});
					$("select#carClass").find('option:first').prop('selected', 'selected');
					$("label#gpsRequiredYes").removeClass("active");
					$("label#gpsRequiredNo").addClass("active");
					$("input:radio#gpsRequired_Y").attr('checked', false);
					$("input:radio#gpsRequired_N").attr('checked', true);
					$("select#carCategory").val("2");
					$("#remarksCar").val("Remarks");
					$("#remarksCar").attr('style','color:rgb(122, 122, 122)');
				}
			}
		});		

		// accomodation required[Yes] button click event
		$('input:radio#accomodationRequired_Y').click(function() {	
			$(this).attr('checked', true);
			$("label#accomodationRequiredNo").removeClass("active");
			$("label#accomodationRequiredYes").addClass("active");
			$("input:radio#accomodationRequired_Y").attr('checked', true);
			$("input:radio#accomodationRequired_N").attr('checked', false);
			$("input#accomodationRequired").val("Accommodation Required");				
			$("tr#accomodationDetail").removeClass("hide");	
			$("tr#accomodationDetail").addClass("show");
			$("select#accomStayType").find('option').eq(0).prop('selected', true);
			$("input#accomPlace").prop('disabled', false);
			$("input#checkInDate").prop('disabled', false);
			$("input#checkOutDate").prop('disabled', false);
			$("textarea#otherComment").prop('disabled', false);
		});

		// accomodation required[No] button click event
		$('input:radio#accomodationRequired_N').click(function() {
			$(this).attr('checked', true);
			var checkItnrFlagAccom = false;
			if($("label#accomodationRequiredYes").hasClass('active')){


				var cityAddress = document.getElementsByName("place");
				var checkinDate = document.getElementsByName("checkin");
				var checkoutDate = document.getElementsByName("checkout");				

				for(var i = 0, len = cityAddress.length; i < len; i++) {
					if((cityAddress[i].value != '' && cityAddress[i].value != 'Place of Visit (City and Address)') 
							|| (checkinDate[i].value != '' && checkinDate[i].value != 'Check In Date') || (checkoutDate[i].value != '' && checkoutDate[i].value != 'Check Out Date')) {

						checkItnrFlagAccom = true;
						break;
					}
				}	

				var result = false;
				if(checkItnrFlagAccom){
					result = confirm('Do you want to remove accomodation detail.');
				} else {
					$("label#accomodationRequiredYes").removeClass("active");
					$("label#accomodationRequiredNo").addClass("active");
					$("input:radio#accomodationRequired_Y").attr('checked', false);
					$("input:radio#accomodationRequired_N").attr('checked', true);
					$("input#accomodationRequired").val("");
					$("tr#accomodationDetail").removeClass("show");	
					$("tr#accomodationDetail").addClass("hide");
				}		


				if(result){
					deleteAccomDetailsAll();

					$("label#accomodationRequiredYes").removeClass("active");
					$("label#accomodationRequiredNo").addClass("active");
					$("input:radio#accomodationRequired_Y").attr('checked', false);
					$("input:radio#accomodationRequired_N").attr('checked', true);
					$("input#accomodationRequired").val("");
					$("tr#accomodationDetail").removeClass("show");	
					$("tr#accomodationDetail").addClass("hide");

					$("select#accomStayType").find('option').eq(0).prop('selected', true);
					$("input#accomPlace").prop('disabled', true);
					$("input#checkInDate").prop('disabled', true);
					$("input#checkOutDate").prop('disabled', true);		
					$("textarea#otherComment").prop('disabled', false);
					$(".accomodationDataRow").each(function(index) {					    
						if(index != 0){
							$(this).remove();
						}else{
							$("select#accomStayType").val('1');
							$("#accomPlace").val("Place of Visit (City and Address)");
							$("#accomPlace").attr('style','color:rgb(122, 122, 122)');
							$("#checkInDate").val("Check In Date");
							$("#checkInDate").attr('style','color:rgb(122, 122, 122)');
							$("#checkOutDate").val("Check Out Date");
							$("#checkOutDate").attr('style','color:rgb(122, 122, 122)');							
						}
					});
					$("#otherComment").val("Remarks");
					$("#otherComment").attr('style','color:rgb(122, 122, 122)');
				}
			}
		});

		// changeable required[Yes] button click event
		$('input:radio#changeableRequired_Y').click(function() {
			$(this).attr('checked', true);
			$("label#changeableRequiredNo").removeClass("active");
			$("label#changeableRequiredYes").addClass("active");
			$("input:radio#changeableRequired_Y").attr('checked', true);
			$("input:radio#changeableRequired_N").attr('checked', false);
		});

		// changeable required[No] button click event
		$('input:radio#changeableRequired_N').click(function() {
			$(this).attr('checked', true);
			$("label#changeableRequiredYes").removeClass("active");
			$("label#changeableRequiredNo").addClass("active");
			$("input:radio#changeableRequired_Y").attr('checked', false);
			$("input:radio#changeableRequired_N").attr('checked', true);
		});

		// refundable required[Yes] button click event
		$('input:radio#refundableRequired_Y').click(function() {
			$(this).attr('checked', true);
			$("label#refundableRequiredNo").removeClass("active");
			$("label#refundableRequiredYes").addClass("active");	
			$("input:radio#refundableRequired_Y").attr('checked', true);
			$("input:radio#refundableRequired_N").attr('checked', false);
		});

		// refundable required[No] button click event
		$('input:radio#refundableRequired_N').click(function() {
			$(this).attr('checked', true);
			$("label#refundableRequiredYes").removeClass("active");
			$("label#refundableRequiredNo").addClass("active");
			$("input:radio#refundableRequired_Y").attr('checked', false);
			$("input:radio#refundableRequired_N").attr('checked', true);
		});
		
		// Itinerary Detail table Start
		$("#bt_Add_Flt").live("click",function() {
			var master = $("table#tblItineraryFltInter");

			// Get a new row based on the prototype row
			var prot = master.find(".prototypeRowItineraryFlt").clone();
			prot.find('#depCityFltTBIntrim').attr('name', 'depCityFlt');
			prot.find('#arrCityFltTBIntrim').attr('name', 'arrCityFlt');
			prot.find('#depDateFltTBIntrim').attr('name', 'depDateFlt');
			prot.find('#preferTimeModeFltSBIntrim').attr('name', 'preferTimeModeFlt');
			prot.find('#preferTimeFltSBIntrim').attr('name', 'preferTimeFlt');
			prot.find('#departClassFltSBIntrim').attr('name', 'departClassFlt');
			prot.find('#seatPreffredFltSBIntrim').attr('name', 'seatPreffredFlt');
			prot.attr("class", "");
			prot.addClass("itineraryDataRowFlt");
			$('#intermediateLableFlt').removeClass('hide');
			$('#intermediateLableFlt').addClass('show');
			$('.innerRowItineraryFlt').before(prot);
			//set placeholder on page load
			resetPlaceHolder();

			//setTravellerPreference(true, false, false);
		});

		// Remove button functionality
		$("table#tblItineraryFltInter #bt-Del-ItInr_Flt").live("click",function() {
			var rowCount = $("table#tblItineraryFltInter tbody tr.itineraryDataRowFlt").length;
			if (rowCount == 1) {
				$('#intermediateLableFlt').removeClass('show');
				$('#intermediateLableFlt').addClass('hide');
			}
			$(this).parents("table#tblItineraryFltInter tr").remove();

		});
		// Itinerary Detail table End

		// Itinerary Detail table Start
		$("#bt_Add_Trn").live("click",function() {
			var master = $("table#tblItineraryTrnInter");

			// Get a new row based on the prototype row
			var prot = master.find(".prototypeRowItineraryTrn").clone();
			prot.find('#depCityTrnTBIntrim').attr('name', 'depCityTrn');
			prot.find('#arrCityTrnTBIntrim').attr('name', 'arrCityTrn');
			prot.find('#depDateTrnTBIntrim').attr('name', 'depDateTrn');
			prot.find('#preferTimeModeTrnSBIntrim').attr('name', 'preferTimeModeTrn');
			prot.find('#preferTimeTrnSBIntrim').attr('name', 'preferTimeTrn');
			prot.find('#departClassTrnSBIntrim').attr('name', 'departClassTrn');
			prot.find('#seatPreffredTrnType1SBIntrim').attr('name', 'seatPreffredTrnType1');
			prot.find('#seatPreffredTrnType2SBIntrim').attr('name', 'seatPreffredTrnType2');
			prot.find('#seatPreffredTrnType3SBIntrim').attr('name', 'seatPreffredTrnType3');
			prot.attr("class", "");
			prot.addClass("itineraryDataRowTrn");
			$('#intermediateLabelTrn').removeClass('hide');
			$('#intermediateLabelTrn').addClass('show');
			$('.innerRowItineraryTrn').before(prot);
			//set placeholder on page load
			resetPlaceHolder();

			//setTravellerPreference(false, true, false);
		});

		// Remove button functionality
		$("table#tblItineraryTrnInter #bt-Del-ItInr_Trn")
		.live("click",function() {
			var rowCount = $("table#tblItineraryTrnInter tbody tr.itineraryDataRowTrn").length;
			if (rowCount == 1) {
				$('#intermediateLabelTrn').removeClass('show');
				$('#intermediateLabelTrn').addClass('hide');

			}
			$(this).parents("table#tblItineraryTrnInter tr").remove();
		});
		// Itinerary Detail table End

		// Accomodation Detail table Start
		$("#bt_Add_Accomo").live("click",function() {
			var master = $("table#tblAccomodation");

			// Get a new row based on the prototype row
			var prot = master.find(".prototypeRowAccomodation").clone();
			prot.find('#accomId').attr('name', 'accomId');
			prot.find('#accomStayType').attr('name', 'hotel');
			prot.find('#accomPlace').attr('name', 'place');
			prot.find('#checkInDate').attr('name', 'checkin');
			prot.find('#checkOutDate').attr('name', 'checkout');			
			prot.attr("class", "");
			prot.addClass("accomodationDataRow");
			$('.innerRowAccomodation').before(prot);
			//set placeholder on page load
			resetPlaceHolder();
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
				dataRow.find("#accomPlace").val("Place of Visit (City and Address)");
				dataRow.find("#accomPlace").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#checkInDate").val("Check In Date");
				dataRow.find("#checkInDate").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#checkOutDate").val("Check Out Date");
				dataRow.find("#checkOutDate").attr('style','color:rgb(122, 122, 122)');	
				$("#otherComment").val("Remarks");
				$("#otherComment").attr('style','color:rgb(122, 122, 122)');
			}
		});
		// Accomodation Detail table End

		// Rent a Car Detail table Start
		$("#bt_Add_RentCar").live("click",function() {
			var master = $("table#tblRentCar");

			// Get a new row based on the prototype row
			var prot = master.find(".prototypeRowRentCar").clone();
			prot.find('#travelCarId').attr('name', 'travelCarId');
			prot.find('#startDate').attr('name', 'startDate');
			prot.find('#startTime').attr('name', 'startTime');
			prot.find('#startCity').attr('name', 'startCity');
			prot.find('#startLocation').attr('name', 'startLocation');
			prot.find('#startMobileNo').attr('name', 'startMobileNo');
			prot.find('#startRouting').attr('name', 'startRouting');
			prot.find('#endDate').attr('name', 'endDate');
			prot.find('#endTime').attr('name', 'endTime');
			prot.find('#endCity').attr('name', 'endCity');
			prot.find('#endLocation').attr('name', 'endLocation');
			prot.find('#endMobileNo').attr('name', 'endMobileNo');
			prot.find('#endRouting').attr('name', 'endRouting');
			prot.find('#gpsRequired_Y').attr('name', 'gps');
			prot.find('#gpsRequired_N').attr('name', 'gps');
			prot.find('#carCategory').attr('name', 'carCategory');
			prot.attr("class", "");
			prot.addClass("rentCarDataRow");
			$('.innerRowRentCar').before(prot);
			//set placeholder on page load
			resetPlaceHolder();
		});

		// Remove button functionality
		$("table#tblRentCar #bt-Del-RentCar").live("click",function() {
			var master = $("table#tblRentCar");
			var dataRow = master.find("tbody tr.rentCarDataRow");
			var carClassRow = master.closest('tr').prevAll('tr#carClassRow');
			var gpsCategoryRow = master.closest('tr').nextAll('tr#gpsCategoryRow');
			var rowCountRentCar = $("table#tblRentCar tbody tr.rentCarDataRow").length;
			var travelCarId = $(this).parents("table#tblRentCar tr").find('input[name="travelCarId"]').val();			
			deleteCarDetailsById(travelCarId, rowCountRentCar);
			if(rowCountRentCar > 1) {
				$(this).parents("table#tblRentCar tr").remove();
			} else {
				dataRow.find("#travelCarId").val("");				
				dataRow.find("#startDate").val("Start Date");
				dataRow.find("#startDate").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("select#startTime").val('1');
				dataRow.find("#startCity").val("Start City");
				dataRow.find("#startCity").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("select#startLocation").val('1');
				dataRow.find("#startMobileNo").val("Mobile Number");
				dataRow.find("#startMobileNo").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("#endDate").val("End Date");
				dataRow.find("#endDate").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("select#endTime").val('1');
				dataRow.find("#endCity").val("End City");
				dataRow.find("#endCity").attr('style','color:rgb(122, 122, 122)');
				dataRow.find("select#endLocation").val('1');
				dataRow.find("#endMobileNo").val("Mobile Number");	
				dataRow.find("#endMobileNo").attr('style','color:rgb(122, 122, 122)');	
				gpsCategoryRow.find("label#gpsRequiredYes").removeClass("active");
				gpsCategoryRow.find("label#gpsRequiredNo").addClass("active");
				gpsCategoryRow.find("input:radio#gpsRequired_Y").attr('checked', false);
				gpsCategoryRow.find("input:radio#gpsRequired_N").attr('checked', true);
				gpsCategoryRow.find("select#carCategory").val("2");				
				carClassRow.find("select#carClass").find('option:first').prop('selected', 'selected');
				dataRow.find('#startMobileNoTdInput').addClass('hide');				
				dataRow.find('input#startMobileNo').addClass('hide');				
				dataRow.find('#endMobileNoTdInput').addClass('hide');
				dataRow.find('input#endMobileNo').addClass('hide');
			}


		});
		// Rent a Car Detail table End

		// Add Group/Guest Traveller Detail Start
		$("#bt_Add_Traveller").live("click",function() {
			var master = $("table#groupGuestDetailTbl");

			
			// Get a new row based on the prototype row
			var prot = master.find(".prototypeRowGroupGuestDetail").clone();
			prot.find('#grpUserID').attr('name', 'grpUserID');
			prot.find('#fNameGroup').attr('name', 'fNameGroup');
			prot.find('#lNameGroup').attr('name', 'lNameGroup');	
			prot.find('#dobGroup').attr('name', 'dobGroup');
			prot.find('#genderGroup').attr('name', 'genderGroup');
			prot.find('#mobileNoGroup').attr('name', 'mobileNoGroup');
			prot.find('#frequentFlyerGroup').attr('name', 'frequentFlyerGroup');		
			prot.find('#specialMealGroup').attr('name', 'specialMealGroup');
			prot.find('#passportNoGroup').attr('name', 'passportNoGroup');
			prot.find('#nationalityGroup').attr('name', 'nationalityGroup');
			prot.find('#placeOfIssueGroup').attr('name', 'placeOfIssueGroup');
			prot.find('#dateOfIssueGroup').attr('name', 'dateOfIssueGroup');
			prot.find('#dateOfExpiryGroup').attr('name', 'dateOfExpiryGroup');
			prot.find('#visaGroup').attr('name', 'visaGroup');
			prot.attr("class", "");
			prot.addClass("groupGuestDetailDataRow");
			$('.innerRowGroupGuestDetail').before(prot);
			//set placeholder on page load
			resetPlaceHolder();
		
			if($('input#rd_Dom').is(':checked')) {
				$("select.grpMealPrefCombo").removeClass("show");
				$("select.grpMealPrefCombo").addClass("hide");		
				$("img.btDelTravellerDom").removeClass("hide");
				$("img.btDelTravellerDom").addClass("show");		
				$("tr.passportDetailRow").removeClass("show");
				$("tr.passportDetailRow").addClass("hide");
				$("table.hrTbl").css("width", "81.5%");
			} else if($('input#rd_Int').is(':checked')) {
				$("select.grpMealPrefCombo").removeClass("hide");
				$("select.grpMealPrefCombo").addClass("show");		
				$("img.btDelTravellerDom").removeClass("show");
				$("img.btDelTravellerDom").addClass("hide");
				$("tr.passportDetailRow").removeClass("hide");
				$("tr.passportDetailRow").addClass("show");
				$("table.hrTbl").css("width", "99%");
			}
			
			var srNo = 1;
			$('table#groupGuestDetailTbl tbody > tr.groupGuestDetailDataRow').each(function() {				 
				$(this).find('#grpSrNoCount').text(srNo);
				 srNo++;
			});
			 
		}); //Add Group/Guest Traveller Detail End	
		
		
		
		// Remove Group/Guest Traveller Detail Domestic Start
		$("table#groupGuestDetailTbl #bt-Del-Traveller-Dom").live("click",function() {
			var checkGruoupGuestDetailFlagDom = false;
			var master = $("table#groupGuestDetailTbl");
			var dataRowDom = master.find("tbody tr.groupGuestDetailDataRow");
			var rowCountGroupGuestDom = $("table#groupGuestDetailTbl tbody tr.groupGuestDetailDataRow").length;
			var grpTravellerIdDom = $(this).parents("table#groupGuestDetailTbl tr").find('input[name="grpUserID"]').val();			
			
			var fNameGroupDom 				= $(this).parents("table#groupGuestDetailTbl tr").find("#fNameGroup").val();
			var lNameGroupDom				= $(this).parents("table#groupGuestDetailTbl tr").find("#lNameGroup").val();			
			var genderGroupDom 				= $(this).parents("table#groupGuestDetailTbl tr").find("select#genderGroup option:selected").val();
			var mobileNoGroupDom			= $(this).parents("table#groupGuestDetailTbl tr").find("#mobileNoGroup").val();
			var frequentFlyerGroupDom	 	= $(this).parents("table#groupGuestDetailTbl tr").find("#frequentFlyerGroup").val();
			
			if((fNameGroupDom != '' && fNameGroupDom != 'First Names as per passport') || (lNameGroupDom != '' && lNameGroupDom != 'Last Names as per passport')
					|| (mobileNoGroupDom != '' && mobileNoGroupDom != 'Contact No.') || (frequentFlyerGroupDom != '' && frequentFlyerGroupDom != 'Frequent Flyer')  
					|| genderGroupDom != '-1') {
				checkGruoupGuestDetailFlagDom = true;
			}
			
			var resultDom = false;
			if(checkGruoupGuestDetailFlagDom){
				resultDom = confirm('Are you sure you want to delete the record!');
			} else {
				if(rowCountGroupGuestDom > 1) {
					$(this).parents("table#groupGuestDetailTbl tbody tr.groupGuestDetailDataRow").remove();
				}
			}
							
			
			if(resultDom){
				deleteGroupGuestDetailsById(grpTravellerIdDom, rowCountGroupGuestDom);
				
				if(rowCountGroupGuestDom > 1) {
					$(this).parents("table#groupGuestDetailTbl tbody tr.groupGuestDetailDataRow").remove();
				} else {
					resetGuestInfo();
					dataRowDom.find("#bt-Del-Traveller-Dom").hide();
				}				
			}
			
			var srNo = 1;
			$('table#groupGuestDetailTbl tbody > tr.groupGuestDetailDataRow').each(function() {
				 $(this).find('#grpSrNoCount').text(srNo);	
				 srNo++;
			});
		}); //Remove Group/Guest Traveller Detail Domestic End
		
		// Remove Group/Guest Traveller Detail International Start
		$("table#groupGuestDetailTbl #bt-Del-Traveller-Int").live("click",function() {
			var checkGruoupGuestDetailFlagInt = false;
			var master = $("table#groupGuestDetailTbl");
			var dataRowInt = master.find("tbody tr.groupGuestDetailDataRow");
			var rowCountGroupGuestInt = $("table#groupGuestDetailTbl tbody tr.groupGuestDetailDataRow").length;
			var grpTravellerIdInt = $(this).parents("table#groupGuestDetailTbl tr").find('input[name="grpUserID"]').val();			
			
			var fNameGroupInt 				= $(this).parents("table#groupGuestDetailTbl tr").find("#fNameGroup").val();
			var lNameGroupInt				= $(this).parents("table#groupGuestDetailTbl tr").find("#lNameGroup").val();			
			var genderGroupInt 				= $(this).parents("table#groupGuestDetailTbl tr").find("select#genderGroup option:selected").val();
			var mobileNoGroupInt			= $(this).parents("table#groupGuestDetailTbl tr").find("#mobileNoGroup").val();
			var frequentFlyerGroupInt	 	= $(this).parents("table#groupGuestDetailTbl tr").find("#frequentFlyerGroup").val();
			var specialMealGroupInt		 	= $(this).parents("table#groupGuestDetailTbl tr").find("select#specialMealGroup option:selected").val();
			var passportNoGroupInt 			= $(this).parents("table#groupGuestDetailTbl tr").find("#passportNoGroup").val();
			var nationalityGroupInt 		= $(this).parents("table#groupGuestDetailTbl tr").find("#nationalityGroup").val();
			var placeOfIssueGroupInt 		= $(this).parents("table#groupGuestDetailTbl tr").find("#placeOfIssueGroup").val();
			var dateOfIssueGroupInt 		= $(this).parents("table#groupGuestDetailTbl tr").find("#dateOfIssueGroup").val();
			var dateOfExpiryGroupInt 		= $(this).parents("table#groupGuestDetailTbl tr").find("#dateOfExpiryGroup").val();			
			var dobGroupInt 				= $(this).parents("table#groupGuestDetailTbl tr").find("#dobGroup").val();
			
			if((fNameGroupInt != '' && fNameGroupInt != 'First Names as per passport') || (lNameGroupInt != '' && lNameGroupInt != 'Last Names as per passport')
					|| (mobileNoGroupInt != '' && mobileNoGroupInt != 'Contact No.') || (frequentFlyerGroupInt != '' && frequentFlyerGroupInt != 'Frequent Flyer') 
					|| (passportNoGroupInt != '' && passportNoGroupInt != 'Passport Number') || (nationalityGroupInt != '' && nationalityGroupInt != 'Nationality as per passport') 
					|| (placeOfIssueGroupInt != '' && placeOfIssueGroupInt != 'Place of Issue') || (dateOfIssueGroupInt != '' && dateOfIssueGroupInt != 'Date of Issue') 
					|| (dateOfExpiryGroupInt != '' && dateOfExpiryGroupInt != 'Date of Expiry') || (dobGroupInt != '' && dobGroupInt != 'Date of Birth')  
					|| genderGroupInt != '-1' || specialMealGroupInt != '-1') {
				checkGruoupGuestDetailFlagInt = true;
			}
			
			var resultInt = false;
			if(checkGruoupGuestDetailFlagInt){
				resultInt = confirm('Are you sure you want to delete the record!');
			} else {
				if(rowCountGroupGuestInt > 1) {
					$(this).parents("table#groupGuestDetailTbl tbody tr.groupGuestDetailDataRow").remove();
				}
			}
							
			
			if(resultInt){
				deleteGroupGuestDetailsById(grpTravellerIdInt, rowCountGroupGuestInt);
				
				if(rowCountGroupGuestInt > 1) {
					$(this).parents("table#groupGuestDetailTbl tbody tr.groupGuestDetailDataRow").remove();
				} else {			
					resetGuestInfo();
					dataRowInt.find("#bt-Del-Traveller-Int").hide();
					
				}				
			}
			
			var srNo = 1;
			$('table#groupGuestDetailTbl tbody > tr.groupGuestDetailDataRow').each(function() {
				 $(this).find('#grpSrNoCount').text(srNo);	
				 srNo++;
			});
		}); // Remove Group/Guest Traveller Detail International End
	});
	
	
	/**
	 * Set traveller Travel Preference
	 */
	function setTravellerPreference(isFlightChecked, isTrainChecked, isBahnChecked){

		var userId = userIdGlobal;
		var travelType = '';
		if($('input#rd_Dom').is(':checked')) {
			travelType = 'D';
		} else if($('input#rd_Int').is(':checked')) {
			travelType = 'I';
		}

		$.ajax({
			type: "POST",
			url: "QuickTravelRequestGMBHServlet",
			data: 'travelerId='+userId+'&workflow=TRAVELER_LAST_TRAVEL_DETAIL&travelType='+travelType,
			cache: false,
			dataType : 'json',
			success: function(result) {
				if(result!=null) {
					if(result != undefined && result.LAST__TRAVEL_DETAIL != undefined){
						if(isFlightChecked && result.LAST__TRAVEL_DETAIL.FLIGHT_SEAT_PREFERRED != undefined) {
							var seatName = result.LAST__TRAVEL_DETAIL.FLIGHT_SEAT_PREFERRED;
							
							var prefSeat_1Flt   = document.getElementById("seatPreffredFltSBFwd");
							if(prefSeat_1Flt.length >= 0) {
								$(prefSeat_1Flt).val(seatName);
							}
						}
						
						if(isFlightChecked && result.LAST__TRAVEL_DETAIL.RETURN_FLIGHT_SEAT_PREFERRED != undefined) {
							var retSeatName = result.LAST__TRAVEL_DETAIL.RETURN_FLIGHT_SEAT_PREFERRED;
							
							var prefSeat_2Flt   = document.getElementById("seatPreffredFltSBRet");
							if(prefSeat_2Flt.length >= 0) {
								$(prefSeat_2Flt).val(retSeatName);
							}
						}

						if(isTrainChecked && result.LAST__TRAVEL_DETAIL.TRAIN_SEAT_NAME != undefined) {
							var prefSeat_1Trn   = document.getElementById("seatPreffredTrnType1SBFwd");
							var prefSeat_2Trn   = document.getElementById("seatPreffredTrnType2SBFwd");
							var prefSeat_3Trn   = document.getElementById("seatPreffredTrnType3SBFwd");

							var seatName = result.LAST__TRAVEL_DETAIL.TRAIN_SEAT_NAME;
							var seatNameArr = seatName.split('-');

							if(prefSeat_1Trn.length >= 0) {
								$(prefSeat_1Trn).val(seatNameArr[0]);
							}
							
							if(prefSeat_2Trn.length >= 0) {
								$(prefSeat_2Trn).val(seatNameArr[1]);
							}
							
							if(prefSeat_3Trn.length >= 0) {
								$(prefSeat_3Trn).val(seatNameArr[2]);
							}
						}
						
						if(isTrainChecked && result.LAST__TRAVEL_DETAIL.RETURN_TRAIN_SEAT_NAME != undefined) {
							var retPrefSeat_1Trn   = document.getElementById("seatPreffredTrnType1SBRet");
							var retPrefSeat_2Trn   = document.getElementById("seatPreffredTrnType2SBRet");
							var retPrefSeat_3Trn   = document.getElementById("seatPreffredTrnType3SBRet");

							var retSeatName = result.LAST__TRAVEL_DETAIL.RETURN_TRAIN_SEAT_NAME;
							var retSeatNameArr = retSeatName.split('-');

							if(retPrefSeat_1Trn.length >= 0) {
								$(retPrefSeat_1Trn).val(retSeatNameArr[0]);
							}
							
							if(retPrefSeat_2Trn.length >= 0) {
								$(retPrefSeat_2Trn).val(retSeatNameArr[1]);
							}
							
							if(retPrefSeat_3Trn.length >= 0) {
								$(retPrefSeat_3Trn).val(retSeatNameArr[2]);
							}
						}

						if(isBahnChecked && result.LAST__TRAVEL_DETAIL.BAHN_CARD_NO != undefined) {
							var bahnCardNo   			= document.getElementById("bahnNo");
							var bahnCardDisc   			= document.getElementById("bahnCardDisc");
							var bahnCardClass   		= document.getElementById("bahnCardClass");
							var bahnCardValidDate   	= document.getElementById("bahnCardValidDate");
							var bahnCardTicketOnlineYes = document.getElementById("bhnTktRequired_Y");
							var bahnCardTicketOnlineNo  = document.getElementById("bhnTktRequired_N");

							if(result.LAST__TRAVEL_DETAIL.BAHN_CARD_NO != ''){
								$(bahnCardNo).val(result.LAST__TRAVEL_DETAIL.BAHN_CARD_NO);
								$(bahnCardDisc).val(result.LAST__TRAVEL_DETAIL.BAHN_CARD_DISCOUNT);
								$(bahnCardClass).val(result.LAST__TRAVEL_DETAIL.BAHN_CARD_CLASS);
								$(bahnCardValidDate).val(result.LAST__TRAVEL_DETAIL.BAHN_CARD_VALID_DATE);
							}

						}
					}

				}
			}
		});
	}
	
