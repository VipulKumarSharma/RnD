
<html>
 <head>
<script>
//function for checking the passport detail
function checkPassportInfoGmbH(f1)
{
	var passportNo    	= f1.passport_No.value;
	var dateOfIssue   	= f1.passport_issue_date.value;
	var expireDate    	= f1.passport_expire_date.value;
	var ffNo          	= f1.passport_flight_No.value;   
	var placeOfIssue  	= f1.passport_issue_place.value;
	var dateOfBirth   	= f1.passport_DOB.value;
	var contactNo     	= f1.passport_Contact_No.value;
	var pp_issu_Country	= f1.pp_issu_Country.value;
	
	var flag = true;
	
	//when passport no is filled
	if(passportNo != null && passportNo != '')
	{
		flag = checkPassportInfo1('pp_issu_Country' , pp_issu_Country);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
	}
	
	if(pp_issu_Country != null && pp_issu_Country != '0')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
	}
	
    // when date of issue is filled 
	if(dateOfIssue != null && dateOfIssue != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('pp_issu_Country' , pp_issu_Country);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
	}
	
	//when expire date is filled
	if(expireDate != null && expireDate != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('pp_issu_Country' , pp_issu_Country);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;

		flag = checkExdatecurntDate(f1)
		if(flag == false)
			return flag;
	}
    //when placeOfIssue is filled
	if(placeOfIssue != null && placeOfIssue != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('pp_issu_Country' , pp_issu_Country);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
	}
	return true;
}

function checkPassportInfo(f1)
{
	var passportNo    	= f1.passport_No.value;
	var dateOfIssue   	= f1.passport_issue_date.value;
	var expireDate    	= f1.passport_expire_date.value;
	var ffNo          	= f1.passport_flight_No.value;   
	var placeOfIssue  	= f1.passport_issue_place.value;
	var dateOfBirth   	= f1.passport_DOB.value;
	var address       	= f1.passport_address.value;
	var contactNo     	= f1.passport_Contact_No.value;
	var pp_issu_Country	= f1.pp_issu_Country.value;
	
	var flag = true;
	//alert(passportNo+"------"+dateOfIssue+"-------"+"-------"+expireDate+"--------"+ffNo+"---------"+placeOfIssue+"-----"+dateOfBirth+"-------"+address+"---------"+contactNo);
	//when passport no is filled
	if(passportNo != null && passportNo != '')
	{
		flag = checkPassportInfo1('pp_issu_Country' , pp_issu_Country);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;

		/*flag = checkPassportInfo1('ffNo' , ffNo);
		if(flag == false)
			return flag;*/

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
	}
	
	if(pp_issu_Country != null && pp_issu_Country != '0')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;

		/*flag = checkPassportInfo1('ffNo' , ffNo);
		if(flag == false)
			return flag;*/

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
	}
	
    // when date of issue is filled 
	if(dateOfIssue != null && dateOfIssue != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('pp_issu_Country' , pp_issu_Country);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;

		/*flag = checkPassportInfo1('ffNo' , ffNo);
		if(flag == false)
			return flag;*/

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
	 
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;

	}

	
	//when expire date is filled
	if(expireDate != null && expireDate != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('pp_issu_Country' , pp_issu_Country);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		/*flag = checkPassportInfo1('ffNo' , ffNo);
		if(flag == false)
			return flag;*/

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;

		

		flag = checkExdatecurntDate(f1)
		if(flag == false)
			return flag;
	}
	//when ffNo is filled
	/*if(ffNo != null && ffNo != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		
		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
	}*/
    //when placeOfIssue is filled
	if(placeOfIssue != null && placeOfIssue != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('pp_issu_Country' , pp_issu_Country);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;

		/*flag = checkPassportInfo1('ffNo' , ffNo);
		if(flag == false)
			return flag;			*/

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;

		
	}
	return true;
}



// sub sequent method for checkPassportInfo
function checkPassportInfo1(checkField , fieldValue)
{
	if(checkField == 'passportNo')
	{
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert('<%=dbLabelBean.getLabel("alert.global.passportnumber",strsesLanguage)%>');
            document.frm.passport_No.focus();
			return false;
		}
	}
	
	if(checkField == 'pp_issu_Country')
	{
		if(fieldValue != null && fieldValue !='0')
		{
		}
		else
		{
			alert("Please select passport issuing country.");
            document.frm.pp_issu_Country.focus();
			return false;
		}
	}
	
	if(checkField == 'dateOfIssue')
	{
		if(fieldValue != null && fieldValue !='' && fieldValue !='dd/mm/yyyy')
		{
		}
		else
		{
			alert('<%=dbLabelBean.getLabel("alert.createrequest.enterdateofissue",strsesLanguage)%>');
			document.frm.passport_issue_date.focus();
			return false;
		}
	}
	
	/*if(checkField == 'ffNo')
	{
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert("Please fill the frequent flyer no.");
			document.frm.passport_flight_No.focus();
			return false;
		}
	}*/
	if(checkField == 'nationality')
	{
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert('<%=dbLabelBean.getLabel("alert.global.nationality",strsesLanguage)%>');
			document.frm.nationality.focus();
			return false;
		}
	}
	
	if(checkField == 'placeOfIssue')
	{
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert('<%=dbLabelBean.getLabel("alert.createrequest.enterplaceofissue",strsesLanguage)%>');
			document.frm.passport_issue_place.focus();
			return false;
		}
	}
    if(checkField == 'dateOfBirth')
	{
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert('<%=dbLabelBean.getLabel("alert.global.dob",strsesLanguage)%>');
			document.frm.passport_DOB.focus();
			return false;
		}
	}

if(checkField == 'contactNo')
	{
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert('<%=dbLabelBean.getLabel("alert.global.mobilenumber",strsesLanguage)%>');
			document.frm.passport_Contact_No.focus();
			return false;
		}
	}

	if(checkField == 'address')
	{
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert('<%=dbLabelBean.getLabel("alert.createrequest.enterpermanentaddress",strsesLanguage)%>');
			document.frm.passport_address.focus();
			return false;
		}
	}
	

	if(checkField == 'expireDate')
	{
		if(fieldValue != null && fieldValue !='' && fieldValue !='dd/mm/yyyy')
		{
		}
		else
		{
			alert('<%=dbLabelBean.getLabel("alert.createrequest.enterexpirydate",strsesLanguage)%>');
			document.frm.passport_expire_date.focus();
			return false;
		}
	}
	return true;
}



//fuction for check date of birth from current date and passport issue date, and if issue date or expire date is filled then compare 
//issue date and expire date
function checkDOB(form1)
{
	//get today date info
	var todayDate=form1.todayDate.value;
	
	//alert("today is=="+todayDate);
	var DOB=form1.passport_DOB.value;
	//alert("dob is"+DOB);

	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);

    //get date of birth info
	var f=DOB.substr(6,4);
	var year1=parseInt(f,10);

	var b=DOB.substr(3,2);
	var month1=parseInt(b,10);

	var h=DOB.substr(0,2);
	var day1=parseInt(h,10);
	
	if(year<year1)
	{
		 alert('<%=dbLabelBean.getLabel("alert.global.dobcannotgreaterthantodaydate",strsesLanguage)%>');
		 form1.passport_DOB.value="";
		 form1.passport_DOB.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month<month1))
	{
		 alert('<%=dbLabelBean.getLabel("alert.global.dobcannotgreaterthantodaydate",strsesLanguage)%>');
		 form1.passport_DOB.value="";
		 form1.passport_DOB.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day<day1))
	{		
		 alert('<%=dbLabelBean.getLabel("alert.global.dobcannotgreaterthantodaydate",strsesLanguage)%>');
		 form1.passport_DOB.value="";
		 form1.passport_DOB.focus();
		 return false;
	}//end of elseif

	//checking for issue date
	var issueDate   = form1.passport_issue_date.value;
	var expireDate  = form1.passport_expire_date.value;
	if((issueDate != null && issueDate != '') || (expireDate != null && expireDate != ''))
	{
		//alert("33");
		//get issue date info
		var d=issueDate.substr(6,4);
    	var year2=parseInt(d,10);
	    var a =issueDate.substr(3,2);
    	var month2=parseInt(a,10);
    	var c =issueDate.substr(0,2);
    	var day2=parseInt(c,10);
		if(year2<year1)
    	{
	 	 alert('<%=dbLabelBean.getLabel("alert.createrequest.dateofbirthcannotbegreaterthanissuedate",strsesLanguage)%>');
		 form1.passport_DOB.value="";
		 form1.passport_DOB.focus();
		 return false;
    	}//end of if
	
     	if((year2==year1)&&(month2<month1))
     	{
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.dateofbirthcannotbegreaterthanissuedate",strsesLanguage)%>');
		 form1.passport_DOB.value="";
		 form1.passport_DOB.focus();
		 return false;
     	}//end of elseif
	
    	if((year2==year1)&&(month2==month1)&&(day2<=day1))
    	{		
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.dateofbirthcannotbegreaterorequalissuedate",strsesLanguage)%>');
		 form1.passport_DOB.value  = "";
		 form1.passport_DOB.focus();
		 return false;
    	}//end of elseif
	
		//get the expire date data
		
		var d           = expireDate.substr(6,4);
     	var year3       = parseInt(d,10);
    	var a           = expireDate.substr(3,2);
     	var month3      = parseInt(a,10);
    	var c           = expireDate.substr(0,2);
     	var day3        = parseInt(c,10);
		if(year3<year2)
    	{
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.expirydatecannotbesmallerthanissuedate",strsesLanguage)%>');
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
    	}//end of if
	
    	if((year3==year2)&&(month3<month2))
    	{
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.expirydatecannotbesmallerthanissuedate",strsesLanguage)%>');
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
    	}//end of elseif
	
    	if((year3==year2)&&(month3==month2)&&(day3<day2))
    	{		
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.expirydatecannotbesmallerthanissuedate",strsesLanguage)%>');
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
     	}//end of elseif			

		if((year3==year2)&&(month3==month2)&&(day3==day2))
    	{		
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.expirydatecannotbeequaltoissuedate",strsesLanguage)%>');
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
     	}//end of elseif			
	}


	//when expire date not equal null
    /*if(issueDate != null && issueDate != '')
	{
		//get issue date info
		var d=issueDate.substr(6,4);
    	var year2=parseInt(d,10);
	    var a =issueDate.substr(3,2);
    	var month2=parseInt(a,10);
    	var c =issueDate.substr(0,2);
    	var day2=parseInt(c,10);
		
		//get the expire date info
		var d           = returnDate.substr(6,4);
     	var year3       = parseInt(d,10);
    	var a           = returnDate.substr(3,2);
     	var month3      = parseInt(a,10);
    	var c           = returnDate.substr(0,2);
     	var day3        = parseInt(c,10);
		if(year3<year2)
    	{
		 alert("Expiry Date cannot be smaller than Issue Date!");
		 form1.expireDate.value="";
		 form1.expireDate.focus();
		 return false;
    	}//end of if
	
    	if((year3==year2)&&(month3<month2))
    	{
		 alert("Expiry Date cannot be smaller than Issue Date!");
		 form1.expireDate.value="";
		 form1.expireDate.focus();
		 return false;
    	}//end of elseif
	
    	if((year3==year2)&&(month3==month2)&&(day3<day2))
    	{		
		 alert("Expiry Date cannot be smaller than Issue Date!");
		 form1.expireDate.value="";
		 form1.expireDate.focus();
		 return false;
     	}//end of elseif	
	}*/
		
	return true;

}


function checkExdatecurntDate(form1)
{
	var todayDate=form1.todayDate.value;

	
	var ExpiryDate=form1.passport_expire_date.value;
	//alert("dob is"+DOB);
	
	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);
	

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);
	

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);
	

    //get date of birth info
	var f=ExpiryDate.substr(6,4);
	var year1=parseInt(f,10);
	

	var b=ExpiryDate.substr(3,2);
	var month1=parseInt(b,10);
	

	var h=ExpiryDate.substr(0,2);
	var day1=parseInt(h,10);
	
	if(year>year1)
	{
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.passportdateexpired",strsesLanguage)%>');
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month>month1))
	{
		alert('<%=dbLabelBean.getLabel("alert.createrequest.passportdateexpired",strsesLanguage)%>');
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day>day1))
	{		
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.passportdateexpired",strsesLanguage)%>');
		 form1.passport_expire_date.value="";
		 form1.passport_expire_date.focus();
		 return false;
	}//end of elseif

	return true;

	}

// To Check Date of Issue with current Date



function checkDateIssuedatecurntDate(form1)
{

	
	var todayDate=form1.todayDate.value;

	
	var IssueDate=form1.passport_issue_date.value;
	//alert("dob is"+DOB);
	

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
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.passportissuedatecannotgeaterthancurrentdate",strsesLanguage)%>');
		 form1.passport_issue_date.value="";
		 form1.passport_issue_date.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month1>month))
	{
		alert('<%=dbLabelBean.getLabel("alert.createrequest.passportissuedatecannotgeaterthancurrentdate",strsesLanguage)%>');
		 form1.passport_issue_date.value="";
		 form1.passport_issue_date.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day1>day))
	{		
		alert('<%=dbLabelBean.getLabel("alert.createrequest.passportissuedatecannotgeaterthancurrentdate",strsesLanguage)%>');
		 form1.passport_issue_date.value="";
		 form1.passport_issue_date.focus();
		 return false;
	}//end of elseif

	return true;

	}



function CheckFFDetail(frm)
{
	 var airLineName=frm.airLineName.value;
     var passport_flight_No=frm.passport_flight_No.value;

	 var airLineName1=frm.airLineName1.value;
     var passport_flight_No1=frm.passport_flight_No1.value;

   var airLineName2=frm.airLineName2.value;
     var passport_flight_No2=frm.passport_flight_No2.value;
     var airLineName3=frm.airLineName3.value;
     var passport_flight_No3=frm.passport_flight_No3.value;
     var airLineName4=frm.airLineName4.value;
     var passport_flight_No4=frm.passport_flight_No4.value;
     var hotelChain=frm.hotelChain.value;
     var hotelChain1=frm.hotelChain1.value;
     var hotelChain2=frm.hotelChain2.value;
     var hotelChain3=frm.hotelChain3.value;
     var hotelChain4=frm.hotelChain4.value;
     var hotelNumber=frm.hotelNumber.value;
     var hotelNumber1=frm.hotelNumber1.value;
     var hotelNumber2=frm.hotelNumber2.value;
     var hotelNumber3=frm.hotelNumber3.value;
     var hotelNumber4=frm.hotelNumber4.value;
	  //var current_address=frm.current_address.value;
     
    
     
     if(airLineName!=''  ||  passport_flight_No!='')
	 {
	   if (airLineName=='' )
	   {alert('<%=dbLabelBean.getLabel("alert.global.airlinename",strsesLanguage)%>');
       frm.airLineName.focus(); 
	   return false;
	   }
	   if (passport_flight_No=='')
	   {
	   alert('<%=dbLabelBean.getLabel("alert.global.airlinenumber",strsesLanguage)%>');
       frm.passport_flight_No.focus(); 
	   return false;
	   }
 	 }
	 if(airLineName1!=''  ||  passport_flight_No1!='')
	 {
	   if (airLineName1=='' )
	   {alert('<%=dbLabelBean.getLabel("alert.global.airlinename",strsesLanguage)%>');
       frm.airLineName1.focus(); 
	   return false;
	   }
	   if (passport_flight_No1=='')
	   {
	   alert('<%=dbLabelBean.getLabel("alert.global.airlinenumber",strsesLanguage)%>');
       frm.passport_flight_No1.focus(); 
	   return false;
	   }
 	 }
	 if(airLineName2!=''  ||  passport_flight_No2!='')
	 {
	   if (airLineName2=='' )
	   {alert('<%=dbLabelBean.getLabel("alert.global.airlinename",strsesLanguage)%>');
       frm.airLineName2.focus(); 
	   return false;
	   }
	   if (passport_flight_No2=='')
	   {
	   alert('<%=dbLabelBean.getLabel("alert.global.airlinenumber",strsesLanguage)%>');
       frm.passport_flight_No2.focus(); 
	   return false;
	   }
 	 }
	 
	 if(airLineName3!=''  ||  passport_flight_No3!='')
	 {
	   if (airLineName3=='' )
	   {alert('<%=dbLabelBean.getLabel("alert.global.airlinename",strsesLanguage)%>');
       frm.airLineName3.focus(); 
	   return false;
	   }
	   if (passport_flight_No3=='')
	   {
	   alert('<%=dbLabelBean.getLabel("alert.global.airlinenumber",strsesLanguage)%>');
       frm.passport_flight_No3.focus(); 
	   return false;
	   }
 	 }
	 if(airLineName4!=''  ||  passport_flight_No4!='')
	 {
	   if (airLineName4=='' )
	   {alert('<%=dbLabelBean.getLabel("alert.global.airlinename",strsesLanguage)%>');
       frm.airLineName4.focus(); 
	   return false;
	   }
	   if (passport_flight_No4=='')
	   {
	   alert('<%=dbLabelBean.getLabel("alert.global.airlinenumber",strsesLanguage)%>');
       frm.passport_flight_No4.focus(); 
	   return false;
	   }
 	 }
	 if(hotelChain!=''  ||  hotelNumber!='')
	 {
	   if (hotelChain=='' )
	   {alert('Hotel Name is Required');
       frm.hotelChain.focus(); 
	   return false;
	   }
	   if (hotelNumber=='')
	   {
	   alert('Hotel Number is Required');
       frm.hotelNumber.focus(); 
	   return false;
	   }
 	 } 
	 
	 if(hotelChain1!=''  ||  hotelNumber1!='')
	 {
	   if (hotelChain1=='' )
	   {alert('Hotel Name is Required');
       frm.hotelChain1.focus(); 
	   return false;
	   }
	   if (hotelNumber1=='')
	   {
	   alert('Hotel Number is Required');
       frm.hotelNumber1.focus(); 
	   return false;
	   }
 	 } 
	 if(hotelChain2!=''  ||  hotelNumber2!='')
	 {
	   if (hotelChain2=='' )
	   {alert('Hotel Name is Required');
       frm.hotelChain2.focus(); 
	   return false;
	   }
	   if (hotelNumber2=='')
	   {
	   alert('Hotel Number is Required');
       frm.hotelNumber2.focus(); 
	   return false;
	   }
 	 } 
	 if(hotelChain3!=''  ||  hotelNumber3!='')
	 {
	   if (hotelChain3=='' )
	   {alert('Hotel Name is Required');
       frm.hotelChain3.focus(); 
	   return false;
	   }
	   if (hotelNumber3=='')
	   {
	   alert('Hotel Number is Required');
       frm.hotelNumber3.focus(); 
	   return false;
	   }
 	 } 
	 if(hotelChain4!=''  ||  hotelNumber4!='')
	 {
	   if (hotelChain4=='' )
	   {alert('Hotel Name is Required');
       frm.hotelChain4.focus(); 
	   return false;
	   }
	   if (hotelNumber4=='')
	   {
	   alert('Hotel Number is Required');
       frm.hotelNumber4.focus(); 
	   return false;
	   }
 	 } 
	 
}


function CheckPassportInfo_ffno(f1)
{
	var passportNo     = f1.passport_No.value;
	var dateOfIssue    = f1.passport_issue_date.value;
	var expireDate      = f1.passport_expire_date.value;
	var placeOfIssue  = f1.passport_issue_place.value;
	var dateOfBirth     = f1.passport_DOB.value;
	var address          = f1.passport_address.value;
	var contactNo       = f1.passport_Contact_No.value;

	var flag = true;
	if(passportNo != null && passportNo != '')
	{
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
	}
    // when date of issue is filled 
	if(dateOfIssue != null && dateOfIssue != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;

		flag = checkDateIssuedatecurntDate(f1)
		if(flag == false)
			return flag;
	}

	
	//when expire date is filled
	if(expireDate != null && expireDate != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;

		flag = checkExdatecurntDate(f1)
		if(flag == false)
			return flag;
	}

    //when placeOfIssue is filled
	if(placeOfIssue != null && placeOfIssue != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
	 
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
		
	}
	return true;
}


///// added on 29 -01-2009   by shiv 
function CheckPassportInfo_Group(f1)
{
	var passportNo     = f1.passportNo.value;
	var dateOfIssue    = f1.passport_issue_date.value;
	var expireDate      = f1.passport_expire_date.value;
	var placeOfIssue  = f1.passport_issue_place.value;
	var nationality    = f1.nationality.value;
	var dateOfBirth     = f1.passport_DOB.value;

	
	//var address          = f1.passport_address.value;
	//var contactNo       = f1.passport_Contact_No.value;

	var flag = true;
	if(passportNo != null && passportNo != '')
	{
		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		/*
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
			*/
	}
    // when date of issue is filled 
	if(dateOfIssue != null && dateOfIssue != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
	      /*	
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
			*/

		flag = checkDateIssuedatecurntDate(f1)
		if(flag == false)
			return flag;
	}

	
	//when expire date is filled
	if(expireDate != null && expireDate != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;			

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		/*
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
   */
		flag = checkExdatecurntDate(f1)
		if(flag == false)
			return flag;
	}
	
	//when placeOfIssue is filled
	if(nationality != null && nationality != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;		

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('placeOfIssue' , placeOfIssue);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		/*
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
	 
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
			*/
		
	}

    //when placeOfIssue is filled
	if(placeOfIssue != null && placeOfIssue != '')
	{
		flag = checkPassportInfo1('passportNo' , passportNo);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfIssue' , dateOfIssue);
		if(flag == false)
			return flag;		

		flag = checkPassportInfo1('expireDate' , expireDate);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('nationality' , nationality);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
		/*
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
	 
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;
			*/
		
	}
	return true;
}
//////
</script>
</head>
</html>
