//function for checking the passport detail 
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:
 *Date of Creation 		:
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:
 *Modification 			:1. Added a function to validate DOB 
 *Reason of Modification:1. Functionality needed 
 *Date of Modification  :1. 18-May-2007 
 *Modification	By		:1. Shiv Sharma
 *Revision History		: 
 *Editor				:Editplus
 *******************************************************/
function checkPassportInfoGmbH(f1)
{
	var passportNo    	= f1.passportNo.value;
	var dateOfIssue   	= f1.dateOfIssue.value;
	var expireDate    	= f1.expireDate.value;
	var ffNo          	= f1.ffNo.value;
	var ffNo1         	= f1.ffNo1.value;
	var ffNo2         	= f1.ffNo2.value;
	var placeOfIssue  	= f1.placeOfIssue.value;
	var dateOfBirth   	= f1.dateOfBirth.value;
	var contactNo     	= f1.contactNo.value;
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
	var passportNo    	= f1.passportNo.value;
	var dateOfIssue   	= f1.dateOfIssue.value;
	var expireDate    	= f1.expireDate.value;
	var ffNo          	= f1.ffNo.value;
	var ffNo1         	= f1.ffNo1.value;
	var ffNo2         	= f1.ffNo2.value;
	var placeOfIssue  	= f1.placeOfIssue.value;
	var dateOfBirth   	= f1.dateOfBirth.value;
	var address       	= f1.address.value;
	var current_address	= f1.current_address.value;  
	var contactNo     	= f1.contactNo.value;
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
			return flag;

		flag = checkPassportInfo1('ffNo1' , ffNo1);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('ffNo2' , ffNo2);
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
    flag = checkPassportInfo1('current_address' , current_address);
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
		
		flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;
		
		flag = checkPassportInfo1('current_address' , current_address);
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
			return flag;

		flag = checkPassportInfo1('ffNo1' , ffNo1);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('ffNo2' , ffNo2);
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
		 flag = checkPassportInfo1('current_address' , current_address);
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
			return flag;

		flag = checkPassportInfo1('ffNo1' , ffNo1);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('ffNo2' , ffNo2);
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

		 flag = checkPassportInfo1('current_address' , current_address);
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
	}

	if(ffNo1 != null && ffNo1 != '')
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
	}

	if(ffNo2 != null && ffNo2 != '')
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
			return flag;
		
		flag = checkPassportInfo1('ffNo1' , ffNo1);
		if(flag == false)
			return flag;

		flag = checkPassportInfo1('ffNo2' , ffNo2);
		if(flag == false)
			return flag;*/


		flag = checkPassportInfo1('dateOfBirth' , dateOfBirth);
		if(flag == false)
			return flag;	
			
		flag = checkPassportInfo1('contactNo' , contactNo);
		if(flag == false)
			return flag;

      flag = checkPassportInfo1('address' , address);
		if(flag == false)
			return flag;

		 flag = checkPassportInfo1('current_address' , current_address);
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
			alert("Please fill the passport no.");
            document.frm.passportNo.focus();
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
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert("Please fill the date of issue.");
			document.frm.dateOfIssue.focus();
			return false;
		}
	}
	
	if(checkField == 'expireDate')
	{
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert("Please fill the passport expiry date.");
			document.frm.expireDate.focus();
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
			document.frm.ffNo.focus();
			return false;
		}
	}

	if(checkField == 'ffNo1')
	{
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert("Please fill the frequent flyer no.");
			document.frm.ffNo.focus();
			return false;
		}
	}

	if(checkField == 'ffNo2')
	{
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert("Please fill the frequent flyer no.");
			document.frm.ffNo.focus();
			return false;
		}
	}*/


	if(checkField == 'placeOfIssue')
	{
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert("Please fill the place of issue.");
			document.frm.placeOfIssue.focus();
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
			alert("Please fill the date of birth.");
			document.frm.dateOfBirth.focus();
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
			alert("Please fill the Mobile Number.");
			document.frm.contactNo.focus();
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
			alert("Please fill the  Permanent Address.");
			document.frm.address.focus();
			return false;
		}
	}


	if(checkField == 'current_address')
	{
		if(fieldValue != null && fieldValue !='')
		{
		}
		else
		{
			alert("Please fill the  Current Address.");
			document.frm.current_address.focus();
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
	var DOB=form1.dateOfBirth.value;
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
		 alert(" Date of Birth cannot be greater than today's Date!");
		 form1.dateOfBirth.value="";
		 form1.dateOfBirth.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month<month1))
	{
		 alert(" Date of Birth cannot be greater than today's Date!");
		 form1.dateOfBirth.value="";
		 form1.dateOfBirth.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day<day1))
	{		
		 alert(" Date of Birth cannot be greater than today's Date!");
		 form1.dateOfBirth.value="";
		 form1.dateOfBirth.focus();
		 return false;
	}//end of elseif

	//checking for issue date
	var issueDate   = form1.dateOfIssue.value;
	var expireDate  = form1.expireDate.value;
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
	 	 alert("Birth Date cannot be greater than Issue Date!");
		 form1.dateOfBirth.value="";
		 form1.dateOfBirth.focus();
		 return false;
    	}//end of if
	
     	if((year2==year1)&&(month2<month1))
     	{
		 alert("Birth Date cannot be greater than Issue Date!");
		 form1.dateOfBirth.value="";
		 form1.dateOfBirth.focus();
		 return false;
     	}//end of elseif
	
    	if((year2==year1)&&(month2==month1)&&(day2<=day1))
    	{		
		 alert("Birth Date cannot be greater or equal to Issue Date!");
		 form1.dateOfBirth.value  = "";
		 form1.dateOfBirth.focus();
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

		if((year3==year2)&&(month3==month2)&&(day3==day2))
    	{		
		 alert("Expiry Date cannot be equals to Issue Date!");
		 form1.expireDate.value="";
		 form1.expireDate.focus();
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



/// open added by shiv on 16-May-07 for checking DOB without checking passort detial.
function checkDOBOnly(form1)
{
	//get today date info
	var todayDate=form1.todayDate.value;
	//alert("today is=="+todayDate);
	var DOB=form1.dateOfBirth.value;
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
		 alert(" Date of Birth cannot be greater than today's Date!");
		 form1.dateOfBirth.value="";
		 form1.dateOfBirth.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month<month1))
	{
		 alert(" Date of Birth cannot be greater than today's Date!");
		 form1.dateOfBirth.value="";
		 form1.dateOfBirth.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day<day1))
	{		
		 alert(" Date of Birth cannot be greater than today's Date!");
		 form1.dateOfBirth.value="";
		 form1.dateOfBirth.focus();
		 return false;
	}//end of elseif

	//checking for issue date
	/*var issueDate   = form1.dateOfIssue.value;
	var expireDate  = form1.expireDate.value;
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
	 	 alert("Birth Date cannot be greater than Issue Date!");
		 form1.dateOfBirth.value="";
		 form1.dateOfBirth.focus();
		 return false;
    	}//end of if
	
     	if((year2==year1)&&(month2<month1))
     	{
		 alert("Birth Date cannot be greater than Issue Date!");
		 form1.dateOfBirth.value="";
		 form1.dateOfBirth.focus();
		 return false;
     	}//end of elseif
	
    	if((year2==year1)&&(month2==month1)&&(day2<=day1))
    	{		
		 alert("Birth Date cannot be greater or equal to Issue Date!");
		 form1.dateOfBirth.value  = "";
		 form1.dateOfBirth.focus();
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

		if((year3==year2)&&(month3==month2)&&(day3==day2))
    	{		
		 alert("Expiry Date cannot be equals to Issue Date!");
		 form1.expireDate.value="";
		 form1.expireDate.focus();
		 return false;
     	}//end of elseif			
	}
        */

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
/// close 


//check ffno and airline name

//Mukesh Mishra
function CheckFFDetail(frm)
{
	
	 var airLineName=frm.airLineName.value;
     var passport_flight_No=frm.ffNo.value;

	 var airLineName1=frm.airLineName1.value;
     var passport_flight_No1=frm.ffNo1.value;

   var airLineName2=frm.airLineName2.value;
     var passport_flight_No2=frm.ffNo2.value;
    var airLineName3=frm.airLineName3.value;
    var passport_flight_No3=frm.ffNo3.value;
    var airLineName4=frm.airLineName4.value;
    var passport_flight_No4=frm.ffNo4.value;

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

     if(airLineName!=''  ||  passport_flight_No!='')
	 {
	   if (airLineName=='' )
	   {alert('Please enter Air line Name');
       frm.airLineName.focus(); 
	   return false;
	   }
	   if (passport_flight_No=='')
	   {
	   alert('Please enter Air line Number');
       frm.ffNo.focus(); 
	   return false;
	   }
 	 }
	 if(airLineName1!=''  ||  passport_flight_No1!='')
	 {
	   if (airLineName1=='' )
	   {alert('Please enter Air line Name');
       frm.airLineName1.focus(); 
	   return false;
	   }
	   if (passport_flight_No1=='')
	   {
	   alert('Please enter Air line Number');
       frm.ffNo1.focus(); 
	   return false;
	   }
 	 }
	 if(airLineName2!=''  ||  passport_flight_No2!='')
	 {
	   if (airLineName2=='' )
	   {alert('Please enter Air line Name');
       frm.airLineName2.focus(); 
	   return false;
	   }
	   if (passport_flight_No2=='')
	   {
	   alert('Please enter Air line Number');
       frm.ffNo2.focus(); 
	   return false;
	   }
 	 }
	 if(airLineName3!=''  ||  passport_flight_No3!='')
	 {
	   if (airLineName3=='' )
	   {alert('Please enter Air line Name');
       frm.airLineName3.focus(); 
	   return false;
	   }
	   if (passport_flight_No3=='')
	   {
	   alert('Please enter Air line Number');
       frm.ffNo3.focus(); 
	   return false;
	   }
 	 }
	 if(airLineName4!=''  ||  passport_flight_No4!='')
	 {
	   if (airLineName4=='' )
	   {alert('Please enter Air line Name');
       frm.airLineName4.focus(); 
	   return false;
	   }
	   if (passport_flight_No4=='')
	   {
	   alert('Please enter Air line Number');
       frm.ffNo4.focus(); 
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
