function CheckPassportInfo_ffno(f1) {
	var passportNo     	= f1.passport_No.value;
	var nationality     = f1.nationality.value;
	var dateOfIssue    	= f1.passport_issue_date.value;
	var expireDate      = f1.passport_expire_date.value;
	var placeOfIssue  	= f1.passport_issue_place.value;
	var dateOfBirth     = f1.passport_DOB.value;
	var address         = f1.passport_address.value;
	var currentAddress  = f1.current_address.value;
	var contactNo       = f1.passport_Contact_No.value;

	var flag = true;
	
	if(address == null || address == '') {
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
	} else if(address != null || address != '') {		
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('currentAddress' , currentAddress);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;		
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;		
	}
	
	if(currentAddress == null || currentAddress == '') {
		flag = checkPassportInfo1('currentAddress' , currentAddress);
		if(flag == false)
			return flag;
	} else if(currentAddress != null || currentAddress != '') {			
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;		
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;		
	}
	
	if(contactNo == null || contactNo == '') {
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
	} else if(contactNo != null || contactNo != '') {
		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('currentAddress' , currentAddress);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;	
	}
	
	if(dateOfBirth == null || dateOfBirth == '') {
		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;
	} else if(dateOfBirth != null || dateOfBirth != '') {
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('currentAddress' , currentAddress);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;		
	}
	
	if(passportNo == null || passportNo == '') {
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;
	} else if(passportNo != null || passportNo != '') {
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('currentAddress' , currentAddress);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;		
	}
	
	if(nationality == null || nationality == '') {
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;
	} else if(nationality != null || nationality != '') {
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('currentAddress' , currentAddress);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;		
	}
	
	if(placeOfIssue == null || placeOfIssue == '') {
		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;
	} else if(placeOfIssue != null || placeOfIssue != '') {
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('currentAddress' , currentAddress);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;
		
	}
    
	if(dateOfIssue == null || dateOfIssue == '') {
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;		
	} else if(dateOfIssue != null || dateOfIssue != '') {
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('currentAddress' , currentAddress);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;		

		flag = checkDateIssuedatecurntDate(f1);
		if(flag == false)
			return flag;
	}

	if(expireDate == null || expireDate == '') {
		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;
	} else if(expireDate != null || expireDate != '') {
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('currentAddress' , currentAddress);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;		

		flag = checkExdatecurntDate(f1);
		if(flag == false)
			return flag;
	}

	return true;
}

// sub sequent method for checkPassportInfo
function checkPassportInfo1(checkField , fieldValue) {
	if(checkField == 'contactNo') {
		if(fieldValue != null && fieldValue !='') {}
		else 	{
			alert("Please fill the Mobile Number.");
			showPersonalDetailRow();
			document.frm.passport_Contact_No.focus();
			return false;
		}
	}
	
	if(checkField == 'dateOfBirth') {
		if(fieldValue != null && fieldValue !='') {}
		else 	{
			alert("Please fill the date of birth.");
			showPersonalDetailRow();
			document.frm.passport_DOB.focus();
			return false;
		}
	}
	
	if(checkField == 'address') {
		if(fieldValue != null && fieldValue !='') {}
		else 	{
			alert("Please fill the Permanent Address.");
			showPersonalDetailRow();
			document.frm.passport_address.focus();
			return false;
		}
	}
	
	if(checkField == 'currentAddress') {
		if(fieldValue != null && fieldValue !='') {}
		else 	{
			alert("Please fill the Current Address.");
			showPersonalDetailRow();
			document.frm.current_address.focus();
			return false;
		}
	}
	
	if(checkField == 'passportNo') {
		if(fieldValue != null && fieldValue !='') {}
		else	{
			alert("Please fill the passport no.");
			showPersonalDetailRow();
            document.frm.passport_No.focus();
			return false;
		}
	}
	
	if(checkField == 'nationality') {
		if(fieldValue != null && fieldValue !='') {}
		else	{
			alert("Please fill the nationality.");
			showPersonalDetailRow();
            document.frm.nationality.focus();
			return false;
		}
	}
	
	if(checkField == 'placeOfIssue') {
		if(fieldValue != null && fieldValue !='') {}
		else 	{
			alert("Please fill the place of issue.");
			showPersonalDetailRow();
			document.frm.passport_issue_place.focus();
			return false;
		}
	}

	if(checkField == 'dateOfIssue') {
		if(fieldValue != null && fieldValue !='') {}
		else 	{
			alert("Please fill the date of issue.");
			showPersonalDetailRow();
			document.frm.passport_issue_date.focus();
			return false;
		}
	}	

	if(checkField == 'expireDate') {
		if(fieldValue != null && fieldValue !='') {}
		else 	{
			alert("Please fill the expiryDate.");
			showPersonalDetailRow();
			document.frm.passport_expire_date.focus();
			return false;
		}
	}	
	
	return true;
}

function checkDateIssuedatecurntDate(form1) {	
	var todayDate=form1.todayDate.value;	
	var IssueDate=form1.passport_issue_date.value;	

	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);
	
	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);
	

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);
	

    //get date of birth info
	var f=IssueDate.substr(6,4);
	var year1=parseInt(f,10);
	

	var b=IssueDate.substr(3,2);
	var month1=parseInt(b,10);
	

	var h=IssueDate.substr(0,2);
	var day1=parseInt(h,10);


	if(year1>year)
	{
		 alert("Your Passport Issue Date cannot be greater than Current Date");
		 showPersonalDetailRow();
		 form1.passport_issue_date.value="";
		 form1.passport_issue_date.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month1>month))
	{
		alert("Your Passport Issue Date cannot be greater than Current Date");
		 showPersonalDetailRow();
		 form1.passport_issue_date.value="";
		 form1.passport_issue_date.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day1>day))
	{		
		alert("Your Passport Issue Date cannot be greater than Current Date");
		 showPersonalDetailRow();
		 form1.passport_issue_date.value="";
		 form1.passport_issue_date.focus();
		 return false;
	}//end of elseif

	return true;

}

function checkDOB(form1) {
	//get today date info
	var todayDate=form1.todayDate.value;		
	var DOB=form1.passport_DOB.value;	

	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);
  
	var f=DOB.substr(6,4);
	var year1=parseInt(f,10);

	var b=DOB.substr(3,2);
	var month1=parseInt(b,10);

	var h=DOB.substr(0,2);
	var day1=parseInt(h,10);
	
	if(year<year1)	{
		 alert(" Date of Birth cannot be greater than today's Date!");
		 showPersonalDetailRow();
		 form1.passport_DOB.value="";		 
		 form1.passport_DOB.focus();
		 return false;
	}
	
	if((year==year1)&&(month<month1))	{
		 alert(" Date of Birth cannot be greater than today's Date!");
		 showPersonalDetailRow();
		 form1.passport_DOB.value="";		 
		 form1.passport_DOB.focus();
		 return false;
	}
	
	if((year==year1)&&(month==month1)&&(day<day1))	{		
		 alert(" Date of Birth cannot be greater than today's Date!");
		 showPersonalDetailRow();
		 form1.passport_DOB.value="";		 
		 form1.passport_DOB.focus();
		 return false;
	}

	//checking for issue date
	var issueDate   = form1.passport_issue_date.value;
	var expireDate  = form1.passport_expire_date.value;
	if((issueDate != null && issueDate != '') || (expireDate != null && expireDate != ''))	{
		
		//get issue date info
		var d=issueDate.substr(6,4);
    	var year2=parseInt(d,10);
	    var a =issueDate.substr(3,2);
    	var month2=parseInt(a,10);
    	var c =issueDate.substr(0,2);
    	var day2=parseInt(c,10);
		if(year2<year1) {
	 	 alert("Birth Date cannot be greater than Issue Date!");
	 	 showPersonalDetailRow();
		 form1.passport_DOB.value="";		 
		 form1.passport_DOB.focus();
		 return false;
    	}
	
     	if((year2==year1)&&(month2<month1))  	{
		 alert("Birth Date cannot be greater than Issue Date!");
		 showPersonalDetailRow();
		 form1.passport_DOB.value="";		 
		 form1.passport_DOB.focus();
		 return false;
     	}
	
    	if((year2==year1)&&(month2==month1)&&(day2<=day1))  	{		
		 alert("Birth Date cannot be greater or equal to the Issue Date!");
		 showPersonalDetailRow();
		 form1.passport_DOB.value  = "";		 
		 form1.passport_DOB.focus();
		 return false;
    	}
	
		//get the expire date data		
		var d           = expireDate.substr(6,4);
     	var year3       = parseInt(d,10);
    	var a           = expireDate.substr(3,2);
     	var month3      = parseInt(a,10);
    	var c           = expireDate.substr(0,2);
     	var day3        = parseInt(c,10);
		if(year3<year2)   	{
		 alert("Expiry Date cannot be smaller than Issue Date!");
		 showPersonalDetailRow();
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
    	}
	
    	if((year3==year2)&&(month3<month2)) 	{
		 alert("Expiry Date cannot be smaller than Issue Date!");
		 showPersonalDetailRow();
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
    	}
	
    	if((year3==year2)&&(month3==month2)&&(day3<day2))   	{		
		 alert("Expiry Date cannot be smaller than Issue Date!");
		 showPersonalDetailRow();
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
     	}		

		if((year3==year2)&&(month3==month2)&&(day3==day2))  	{		
		 alert("Expiry Date cannot be equals to Issue Date!");
		 showPersonalDetailRow();
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
     	}		
	}
	
	return true;
}

function checkExdatecurntDate(form1) {
	var todayDate=form1.todayDate.value;	
	var ExpiryDate=form1.passport_expire_date.value;	
	
	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);	

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);	

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);
  
	var f=ExpiryDate.substr(6,4);
	var year1=parseInt(f,10);	

	var b=ExpiryDate.substr(3,2);
	var month1=parseInt(b,10);	

	var h=ExpiryDate.substr(0,2);
	var day1=parseInt(h,10);
	
	if(year>year1)	{
		 alert(" Your Passport Date has Expired \n Kindly renew your Passport");
		 showPersonalDetailRow();
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
	}
	
	if((year==year1)&&(month>month1))	{
		alert(" Your Passport Date has Expired \n Kindly renew your Passport");
		 showPersonalDetailRow();
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
	}
	
	if((year==year1)&&(month==month1)&&(day>day1))	{		
		 alert(" Your Passport Date has Expired \n Kindly renew your Passport");
		 showPersonalDetailRow();
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
	}
	return true;
	}


function CheckFFDetail(frm) {
	 var airLineName=frm.airLineName.value;
     var passport_flight_No=frm.passport_flight_No.value;

	 var airLineName1=frm.airLineName1.value;
     var passport_flight_No1=frm.passport_flight_No1.value;

     var airLineName2=frm.airLineName2.value;
     var passport_flight_No2=frm.passport_flight_No2.value;
	 
	 if(airLineName!='') {
	   if (passport_flight_No=='')  {
			alert('Please enter Air line Number');
			showPersonalDetailRow();
			frm.passport_flight_No.focus(); 
			return false;
	   }
 	 }
	 
	 if(passport_flight_No!='') {
		   if (airLineName=='' )   {
			   alert('Please enter Air line Name');
			   showPersonalDetailRow();
			   frm.airLineName.focus(); 
			   return false;
		 }
	 }

	 if(airLineName1!='') {
	   if (passport_flight_No1=='') {
			alert('Please enter Air line Number');
			showPersonalDetailRow();
			frm.passport_flight_No1.focus(); 
			return false;
	   }
 	 }
	 
	 if(passport_flight_No1!='') {
		   if (airLineName1=='' ) {
			   alert('Please enter Air line Name');
			   showPersonalDetailRow();
			   frm.airLineName1.focus(); 
			   return false;
		   }	  
	 }

	 if(airLineName2!='') {
	   if (passport_flight_No2=='') {
			alert('Please enter Air line Number');
			showPersonalDetailRow();
			 frm.passport_flight_No2.focus(); 
			return false;
	   }
 	 } 
	 
	 if(passport_flight_No2!='') {
		   if (airLineName2=='' ) {
			   alert('Please enter Air line Name');
			   showPersonalDetailRow();
			   frm.airLineName2.focus(); 
			   return false;
		   }
	 } 

	  return true;
}
