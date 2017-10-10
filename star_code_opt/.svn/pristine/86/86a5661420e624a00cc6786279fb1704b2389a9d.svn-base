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

$(document).ready(function() {
	
	// visa required[Yes] button click event
	$('input:radio#visaRequired_Y').click(function() {		
		$("label#visaRequiredNo").removeClass("active");
		$("label#visaRequiredYes").addClass("active");
		$("input#visaRequired").val("Visa Required");
	});
	
	// visa required[No] button click event
	$('input:radio#visaRequired_N').click(function() {
	   	$("label#visaRequiredYes").removeClass("active");
	   	$("label#visaRequiredNo").addClass("active");
	   	$("input#visaRequired").val("Visa Not Required");
	});
	
	// insurance required[Yes] button click event
	$('input:radio#insuranceRequired_Y').click(function() {		
		$("label#insuranceRequiredNo").removeClass("active");
		$("label#insuranceRequiredYes").addClass("active");
		$("input#nominee").prop('disabled', false);
		$("input#relation").prop('disabled', false);
	});
	
	// insurance required[No] button click event
	$('input:radio#insuranceRequired_N').click(function() {
	   	$("label#insuranceRequiredYes").removeClass("active");
	   	$("label#insuranceRequiredNo").addClass("active");
	   	$("input#insuranceRequired").val("Insurance Not Required");
	   	$("input#nominee").val("");
		$("input#relation").val("");
		$("input#nominee").prop('disabled', true);
		$("input#relation").prop('disabled', true);
	});
	
	// accomodation required[Yes] button click event
	$('input:radio#accomodationRequired_Y').click(function() {		
		$("label#accomodationRequiredNo").removeClass("active");
		$("label#accomodationRequiredYes").addClass("active");
		$("input#accomodationRequired").val("Accommodation Required");				
		$("tr#accomodationDetail").show();
		$("select#accomStayType").find('option').eq(1).prop('selected', true);
		$("select#accomCurrency").find('option').eq(1).prop('selected', true);
		$("select#accomCurrency").prop('disabled', false);
		$("input#accomPlace").prop('disabled', false);
		$("input#accomBudget").prop('disabled', false);
		$("input#checkInDate").prop('disabled', false);
		$("input#checkOutDate").prop('disabled', false);
		$("textarea#otherComment").prop('disabled', false);
		
		if(accomRemarkVal != "" && accomRemarkVal != null && accomRemarkVal != 'Accommodation Not Required') {
			$("textarea#otherComment").val(accomRemarkVal);
			$("textarea#otherComment").css('color', '#000000');
		} else {
			$("textarea#otherComment").val("Remarks");
			$("textarea#otherComment").css('color', '#7a7a7a');
		}
		
		var itineraryBlockHeight =  $("#itineraryBlock").height();
	    $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
	    var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
	    $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
	});
	
	// accomodation required[No] button click event
	$('input:radio#accomodationRequired_N').click(function() {
	   	$("label#accomodationRequiredYes").removeClass("active");
	   	$("label#accomodationRequiredNo").addClass("active");
	   	$("input#accomodationRequired").val("Accommodation Not Required");
	   	$("tr#accomodationDetail").hide();
	   	$("select#accomStayType").find('option').eq(0).prop('selected', true);
		$("select#accomCurrency").find('option').eq(1).prop('selected', true);
		$("select#accomCurrency").prop('disabled', true);
		$("input#accomPlace").prop('disabled', true);
		$("input#accomBudget").prop('disabled', true);
		$("input#checkInDate").prop('disabled', true);
		$("input#checkOutDate").prop('disabled', true);		
		$("textarea#otherComment").prop('disabled', false);
		$("textarea#otherComment").val("Accommodation Not Required");
		$("textarea#otherComment").css('color', '#000000');
		
		var itineraryBlockHeight =  $("#itineraryBlock").height();
	    $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
	    var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
	    $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
	});
	
	// emigration required[Yes] button click event
	$('input:radio#emigrationRequired_Y').click(function() {		
		$("label#emigrationRequiredNo").removeClass("active");
		$("label#emigrationRequiredNA").removeClass("active");
		$("label#emigrationRequiredYes").addClass("active");
		$('input:radio#emigrationRequired_N').prop("checked", false);
		$('input:radio#emigrationRequired_NA').prop("checked", false);
		$('input:radio#emigrationRequired_Y').prop("checked", true);
		$('input:radio#emigrationRequired_Y').val("1");
		$("input#emigrationRequired").val("Emigration Clearance Required");		
	});
	
	// emigration required[No] button click event
	$('input:radio#emigrationRequired_N').click(function() {
	   	$("label#emigrationRequiredYes").removeClass("active");
	   	$("label#emigrationRequiredNA").removeClass("active");
	   	$("label#emigrationRequiredNo").addClass("active");
	   	$('input:radio#emigrationRequired_Y').prop("checked", false);
	   	$('input:radio#emigrationRequired_NA').prop("checked", false);
	   	$('input:radio#emigrationRequired_N').prop("checked", true);
		$('input:radio#emigrationRequired_N').val("2");
	   	$("input#emigrationRequired").val("Emigration Clearance Not Required");	   	
	});
	
	// emigration required[NA] button click event
	$('input:radio#emigrationRequired_NA').click(function() {
	   	$("label#emigrationRequiredYes").removeClass("active");
	   	$("label#emigrationRequiredNo").removeClass("active");
	   	$("label#emigrationRequiredNA").addClass("active");
	   	$('input:radio#emigrationRequired_Y').prop("checked", false);
	   	$('input:radio#emigrationRequired_N').prop("checked", false);
	   	$('input:radio#emigrationRequired_NA').prop("checked", true);
		$('input:radio#emigrationRequired_N').val("3");
	   	$("input#emigrationRequired").val("Emigration Clearance Not Applicable");	   	
	});
	
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
	
	// accomodation stay type change event
	var accomStayTypeSelected = $("select#accomStayType option:selected").val();	
	if(accomStayTypeSelected == "0") {		
		$("select#accomCurrency").find('option').eq(1).prop('selected', true);		
		$("select#accomCurrency").prop('disabled', true);
		$("input#accomPlace").prop('disabled', true);
		$("input#accomBudget").prop('disabled', true);
		$("input#checkInDate").prop('disabled', true);
		$("input#checkOutDate").prop('disabled', true);
		$("textarea#otherComment").val("Accommodation Not Required");
		$("textarea#otherComment").css('color', '#000000');
		$("tr#accomodationDetail").hide();
	} else {
		$("select#accomCurrency").val(accomBudgetCurrency);
		$("select#accomCurrency").prop('disabled', false);
		$("input#accomPlace").prop('disabled', false);
		$("input#accomBudget").prop('disabled', false);
		$("input#checkInDate").prop('disabled', false);
		$("input#checkOutDate").prop('disabled', false);
		$("textarea#otherComment").prop('disabled', false);
		$("tr#accomodationDetail").show();
		if(accomRemarkVal != "" && accomRemarkVal != null && accomRemarkVal != 'Accommodation Not Required') {
			$("textarea#otherComment").val(accomRemarkVal);
			$("textarea#otherComment").css('color', '#000000');
		} else {
			$("textarea#otherComment").val("Remarks");
			$("textarea#otherComment").css('color', '#7a7a7a');
		}
	}
	
	$("select#accomStayType").on("change", function (event) {
		accomStayTypeSelected = $(this).find("option:selected").val();
		if(accomStayTypeSelected != null && accomStayTypeSelected == "0") {
			$("label#accomodationRequiredYes").removeClass("active");
		   	$("label#accomodationRequiredNo").addClass("active");
		   	$("input#accomodationRequired").val("Accommodation Not Required");
		   	$("tr#accomodationDetail").hide();
			$("select#accomCurrency").find('option').eq(1).prop('selected', true);			
			$("select#accomCurrency").prop('disabled', true);
			$("input#accomPlace").prop('disabled', true);
			$("input#accomBudget").prop('disabled', true);
			$("input#checkInDate").prop('disabled', true);
			$("input#checkOutDate").prop('disabled', true);
			$("textarea#otherComment").val("Accommodation Not Required");
			$("textarea#otherComment").css('color', '#000000');
			document.getElementById('hidethis').style.display = 'none';
		} else {
			if(accomStayTypeSelected != null && accomStayTypeSelected == "1"){
				document.getElementById('hidethis').style.display = 'none'; 
			} else if(accomStayTypeSelected != null && accomStayTypeSelected == "2"){
				document.getElementById('hidethis').style.display = ''; 
			}
			
			$("select#accomCurrency").find('option').eq(1).prop('selected', true);
			$("select#accomCurrency").prop('disabled', false);
			$("input#accomPlace").prop('disabled', false);
			$("input#accomBudget").prop('disabled', false);
			$("input#checkInDate").prop('disabled', false);
			$("input#checkOutDate").prop('disabled', false);
			$("textarea#otherComment").prop('disabled', false);
			if(accomRemarkVal != "" && accomRemarkVal != null && accomRemarkVal != 'Accommodation Not Required') {
				$("textarea#otherComment").val(accomRemarkVal);
				$("textarea#otherComment").css('color', '#000000');
			} else {
				$("textarea#otherComment").val("Remarks");
				$("textarea#otherComment").css('color', '#7a7a7a');
			}
		}
		
		var itineraryBlockHeight =  $("#itineraryBlock").height();
	    $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
	    var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
	    $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
    });
	
});