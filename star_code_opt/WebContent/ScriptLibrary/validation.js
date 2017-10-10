
function check(field,msg)
{

for (i = 0; i < field.length; i++)
	{
	if (field[i].type == 'checkbox')
		{
			if (field[i].checked == true)
			return true;
		}
	}
alert(msg);
return false; 
}

function checkAll(field,str)
{
	if(str.checked==true)
	{  
		for (i = 0; i < field.length; i++)
			if (field[i].type == 'checkbox')
		{
		field[i].checked = true ;
		}
	}
	else
	{
for (i = 0; i < field.length; i++)		
	field[i].checked = false ;
	}
}

   function blank_field(proj,str,str1,msg)
{
	var version=str;
	if(version=='')
	{
		alert(msg);
		str1.focus();
		return false;
	}//end of if
			else
			{
			return true;
			}

}//end of function





   function chk_radio(proj,str,str1,rdr,msg)
{
	var version=str;
	var radio=rdr;	
	if((version=='')&&(radio==true))
	{
		alert(msg);
		str1.focus();
		return false;
	}//end of if
			else
			{
			return true;
			}

}//end of function



   function chk_radios(str,str1,rdr,msg)
{
	var version=str;
	var radio=rdr;	
	if((version=='')&&(radio==true))
	{
		alert(msg);
		str1.focus();
		return false;
	}//end of if
			else
			{
			return true;
			}

}//end of function



 function chk_radiobutt(proj,str,strr,rdr,msg,str1,strr1,rdr1,msg1)
{
	var version=str;
	var version1=str1;
	var radio=rdr;	
	var radio1=rdr1;

	if((version=='')&&(radio==true))
	{
		alert(msg);
		strr.focus();
		return false;
	}
		else if((version1=='')&&(radio1==true))
			{
			alert(msg1);
			strr1.focus();
			return false;

			}

else
	{
return true;
	}

}//end of function




 function chk_radiobutts(str,strr,rdr,msg,str1,strr1,rdr1,msg1)
{
	var version=str;
	var version1=str1;
	var radio=rdr;	
	var radio1=rdr1;

	if((version=='')&&(radio==true))
	{
		alert(msg);
		strr.focus();
		return false;
	}
		else if((version1=='')&&(radio1==true))
			{
			alert(msg1);
			strr1.focus();
			return false;

			}

else
	{
return true;
	}

}//end of function




//this function when focus is not rquired
function blank_field_focus(proj,str,str1,msg)
{
	var version=str;
	if(version=='')
	{
		alert(msg);
		return false;
	}//end of if
			else
			{
			return true;
			}

}//end of function

   function blank_fields(str,str1,msg)
{
	var version=str;
	if(version=='')
	{
		alert(msg);
		str1.focus();
		return false;
	}//end of if
			else
			{
			return true;
			}

}//end of function



   function blank_fields1(str,str1,msg)
{
	var version=str;
	if(version=='-1')
	{
		alert(msg);
		str1.focus();
		return false;
	}//end of if
			else
			{
			return true;
			}

}//end of function


//this function when focus is not rquired
function blank_fields_focus(str,str1,msg)
{
	var version=str;
	if(version=='')
	{
		alert(msg);
		return false;
	}//end of if
			else
			{
			return true;
			}

}//end of function


function num_check(str,str1,msg,msg1)
{
	var version=str;
	if(version=="")
	{
		alert(msg);
		str1.focus();
		return false;
	}//end of if
	else if(isNaN(version)==true)
	{
		alert(msg1);
		str1.focus();
		return false;
	}//end of elseif
	var     s_regexp	=	new RegExp("[*,^,$,#,@,~,<,>,>,+,^,]");
			
			var     desc		=	s_regexp.test(str);
			
			
	if(desc==true)	
		{
			alert(msg1);
		str1.focus();
			return false;
			}
else
	return true;

}//end of function




function char_chk(proj,str,str1,msg)

{

var     s_regexp	=	new RegExp("[*,&,^,%,$,#,@,!,~,?,<,>,>,:,;,=,',-]");

			
var     desc		=	s_regexp.test(str);


if(desc==true)	
		{
			alert(msg);
		str1.focus();
			return false;
			}
else
	return true;

}



function char_chknew(str,str1,msg)

{

var     s_regexp	=	new RegExp("[*,&,^,%,$,#,@,!,~,?,<,>,>,:,;,=,]");

			
var     desc		=	s_regexp.test(str);


if(desc==true)	
		{
			alert(msg);
		str1.focus();
			return false;
			}
else
	return true;

}
//for ie
function check_spl_char(proj,str,str1,msg)

{

var valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_><=|!#$%^&*.?\"{}[]`:.;,!@$%^&*() "
var ok = "yes";
var temp;
for (var i=0; i<str.length; i++) {
temp = "" + str.substring(i, i+1);
if (valid.indexOf(temp) == "-1") ok = "no";
}
if (ok == "no") {
alert(msg);
str1.focus();
str1.select();
	return false;

   }
   else
	return true;

}
//for netscape
function check_spl_character(str,str1,msg)

{

var valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_><=|!#$%^&*.?\"{}[]`:.;,!@$%^&*() "
var ok = "yes";
var temp;
for (var i=0; i<str.length; i++) {
temp = "" + str.substring(i, i+1);
if (valid.indexOf(temp) == "-1") ok = "no";
}
if (ok == "no") {
alert(msg);
str1.focus();
str1.select();
	return false;

   }
   else
	return true;
}

function char_allowed(str,str1,msg)
{
var valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_>-<=#$@()  "
var ok = "yes";
var temp;
for (var i=0; i<str.length; i++) {
temp = "" + str.substring(i, i+1);
if (valid.indexOf(temp) == "-1") ok = "no";
}
if (ok == "no") {
alert(msg);
str1.focus();
str1.select();
return false;

   }
   else
	return true;
}


function emailvalidate(str,msg,msg1,msg2,msg3)
{
	var errmsg=" ";
	var version=str;
//	var version1=str1;
	if(version=="")
	{
		alert(msg);
		version1.focus();
		return false;
	}//END OF IF
	if (version.indexOf("@")==-1) 
	{
		alert(msg1);
		errors=1;
		version1.focus();
		return false;
	}//end of if
	else
	{
		var l=version.indexOf("@",0);
		var t=version.substring(l+1,version.length)

		if(t.indexOf("@",0)>=0)
		{
			 alert(msg1+msg3);
//			 errors=1;
			 version1.focus();
			 return false;
		}//end of if
	}//end of else
 
	if  (version.indexOf(".")==-1)
	{
		alert(msg1);
		errors=1;
		version1.focus();
		return false;
	}//end of if
	else
	{
		var m=version.indexOf(".",0);
		var t1=version.substring(m+1,version);
		 

		if((t1.indexOf(".",0)==0)||(t1.indexOf("@",0)==0))
		{
		    alert(msg1+msg2);
		    errors=1;
		    version1.focus();
		    return false;
		}//end of if
		if(t1=="")
		{
			  alert(msg1+msg2);
			 errors=1;
			 version1.focus();
			 return false;
		}//end of if
 
	}//end of else
	return true;
}//end of function

//this function when focus is not required
function emailvalidate_focus(proj,str,str1,msg,msg1,msg2,msg3)
{
	var errmsg=" ";
	var version=str;
	var version1=str1;
	if(version=="")
	{
		alert(msg);
		return false;
	}//END OF IF
	if (version.indexOf("@")==-1) 
	{
		alert(msg1);
		errors=1;
		return false;
	}//end of if
	else
	{
		var l=version.indexOf("@",0);
		var t=version.substring(l+1,version.length)

		if(t.indexOf("@",0)>=0)
		{
			 alert(msg1+msg3);
			 errors=1;
			 return false;
		}//end of if
	}//end of else
 
	if  (version.indexOf(".")==-1)
	{
		alert(msg1);
		errors=1;
		return false;
	}//end of if
	else
	{
		var m=version.indexOf(".",0);
		var t1=version.substring(m+1,version);
		 

		if((t1.indexOf(".",0)==0)||(t1.indexOf("@",0)==0))
		{
		    alert(msg1+msg2);
		    errors=1;
		    return false;
		}//end of if
		if(t1=="")
		{
			  alert(msg1+msg2);
			 errors=1;
			 return false;
		}//end of if
 
	}//end of else

	return true;
}//end of function



function emailvalidatenew(str,str1,msg,msg1,msg2,msg3)
{
	var errmsg=" ";
	var version=str;
	var version1=str1;
	if(version=="")
	{
		alert(msg);
		version1.focus();
		return false;
	}//END OF IF
	if (version.indexOf("@")==-1) 
	{
		alert(msg1);
		errors=1;
		version1.focus();
		return false;
	}//end of if
	else
	{
		var l=version.indexOf("@",0);
		var t=version.substring(l+1,version.length)

		if(t.indexOf("@",0)>=0)
		{
			 alert(msg1+msg3);
			 errors=1;
			 version1.focus();
			 return false;
		}//end of if
	}//end of else
 
	if  (version.indexOf(".")==-1)
	{
		alert(msg1);
		errors=1;
		version1.focus();
		return false;
	}//end of if
	else
	{
		var m=version.indexOf(".",0);
		var t1=version.substring(m+1,version);
		 

		if((t1.indexOf(".",0)==0)||(t1.indexOf("@",0)==0))
		{
		    alert(msg1+msg2);
		    errors=1;
		    version1.focus();
		    return false;
		}//end of if
		if(t1=="")
		{
			  alert(msg1+msg2);
			 errors=1;
			 version1.focus();
			 return false;
		}//end of if
 
	}//end of else
	return true;
}//end of function

//this function when focus is not required
function emailvalidatenew_focus(str,str1,msg,msg1,msg2,msg3)
{
	var errmsg=" ";
	var version=str;
	var version1=str1;
	if(version=="")
	{
		alert(msg);
		return false;
	}//END OF IF
	if (version.indexOf("@")==-1) 
	{
		alert(msg1);
		errors=1;
		return false;
	}//end of if
	else
	{
		var l=version.indexOf("@",0);
		var t=version.substring(l+1,version.length)

		if(t.indexOf("@",0)>=0)
		{
			 alert(msg1+msg3);
			 errors=1;
			 return false;
		}//end of if
	}//end of else
 
	if  (version.indexOf(".")==-1)
	{
		alert(msg1);
		errors=1;
		return false;
	}//end of if
	else
	{
		var m=version.indexOf(".",0);
		var t1=version.substring(m+1,version);
		 

		if((t1.indexOf(".",0)==0)||(t1.indexOf("@",0)==0))
		{
		    alert(msg1+msg2);
		    errors=1;
		    return false;
		}//end of if
		if(t1=="")
		{
			  alert(msg1+msg2);
			 errors=1;
			 return false;
		}//end of if
 
	}//end of else
	return true;
}//end of function



 function confirmPassword(proj,str,str1,str2,msg)
{
	var version=str;
	var version1=str1;
	var version2=str2;

	if(version!=version1)
	{
		alert(msg);
		version2.focus();
		return false;
	}//end of if
	else
	return true;

}//end of function

 function confirmPasswordnew(str,str1,str2,msg)
{
	var version=str;
	var version1=str1;
	var version2=str2;

	if(version!=version1)
	{
		alert(msg);
		version2.focus();
		return false;
	}//end of if
	else
	return true;

}//end of function

function callDelete(proj,msg,url_delete)
{
		
	var s=confirm(msg);
	if(s==true)
	{
	proj.action=url_delete;
	proj.submit();
	}
}

function check_length(proj,str,str1,msg)
{
	var version=str;
	if(version.length<'8')
	{
		alert(msg);
		str1.focus();
		return false;
	}//end of if
			else
			{
			return true;
			}

}//end of function

function submitQuestion(proj,url_postquestion)
{
	
	
	proj.action=url_postquestion;
	proj.submit();
	
}

function check_lengthnew(str,str1,msg)
{
	var version=str;
	if(version.length<'8')
	{
		alert(msg);
		str1.focus();
		return false;
	}//end of if
			else
			{
			return true;
			}

}//end of function

function check_checkbox(str)
{
	var a= str.name;
	var b= str.value;
	var s=1;
	while(s<=b)
	{
		if(str.checked)
		{
		if (eval('document.frm_newform.'+a+'_'+s).type == 'checkbox')		
		eval('document.frm_newform.'+a+'_'+s).checked=true;
		}
		else
		{
			
			eval('document.frm_newform.'+a+'_'+s).checked=false;
		}
		s++
	}

}
function dynamic_func(str,k,dyn,fix,str1,msg)
{
	
	for(var n=0;n<k;n++)
{
	for(var nn=0;nn<(dyn*k)+fix;nn++)
	{
		var a=str1+n;
		if(str.elements[nn].name==a)
		{
			if(str.elements[nn].checked==true)
			{
				if(str.elements[nn+2].value==0)
				{
				alert(msg);
				str.elements[nn+2].focus();
						return false;
				}
			
			}
		}
	}
}
}


function check_Number(str,str1,msg)
{

if(isNaN(str)==true)
	{
alert(msg);
str1.focus();
return false;
	}
}


function check_Numb(str,strr,str1,msg)
{

var version=strr;
if((isNaN(str)==true)&&(version!='235'))
	{
alert(msg);
str1.focus();
return false;
	}
}
function checkCheckbox(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = true ;
}
function uncheckCheckbox(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = false ;
}


function isDigit(theDigit) 
{ 
	var digitArray = new Array('0','1','2','3','4','5','6','7','8','9'),j; 

	for (j = 0; j < digitArray.length; j++) 
	{
		if (theDigit == digitArray[j]) 
		return true 
	} 
	return false 
} 

function isPositiveInteger(theString) 
{ 
	var theData = new String(theString) 

	if (!isDigit(theData.charAt(0))) 
		if (!(theData.charAt(0)== '+')) 
			return false 

	for (var i = 1; i < theData.length; i++) 
		if (!isDigit(theData.charAt(i))) 
			return false 
	return true 
} 

function isDate(s,DateType) 
{
	var a1=s.split("/"); 
	var a2=s.split("-"); 
	var e=true; 
	var d,m,y
	if ((a1.length!=3) && (a2.length!=3)) 
	{ 
		e=false; 
	} 
	else 
	{
		if (a1.length==3) 
			var na=a1; 
		if (a2.length==3) 
			var na=a2; 
		if (isPositiveInteger(na[0]) && isPositiveInteger(na[1]) && isPositiveInteger(na[2])) 
		{ 

			if	  (DateType=='MM/DD/YYYY' )
			{
				d=na[1],m=na[0],y=na[2]; 
			}

			if	  (DateType=='YYYY/MM/DD' )
			{
				d=na[2],m=na[1],y=na[0]; 
			}

			if	  (DateType=='DD/MM/YYYY' )
			{
				d=na[0],m=na[1],y=na[2]; 
			}
			
			if (((e) && (y<1000)||y.length>4)) 
				e=false 
			if (e) 
			{ 
				v=new Date(m+"/"+d+"/"+y); 
				if (v.getMonth()!=m-1) 
				e=false; 
			} 
		} 
		else 
		{ 
			e=false; 
		} 
	} 
	return e 
} 

function checkDate(formname,v,DateType,msg) 
{ 
	var s=v.value;
	if(s.length<1)
		return false;
	if (!isDate(s,DateType))
	{
		alert(msg); 
		v.value='';
		v.focus();
	}
	return false; 
} 

/// my fun
function checkDateme(formname,v,DateType,msg) 
{ 
	var s=v.value;
	if(s.length<1)
		return false;
	if (!isDate(s,DateType))
	{
		alert(msg); 
		v.value='';
		//v.focus();
	}
	return false; 
} 
//my  fun

function checkMaxLengthTextArea1(field, maxlimit)
{
	if (field.value.length > maxlimit) // if too long...trim it!
	field.value = field.value.substring(0, maxlimit);
}//end of function

function checkMaxLengthTextArea2(field, maxlimit)
{
	if (field.value.length > maxlimit) // if too long...trim it!
	field.value = field.value.substring(0, maxlimit);
}//end of function

//check Data Function

function checkData() 
	{

for (var e = 0; e < 5 ; e++){  
			str=new String(document.frm.elements[e].name);
			if (window.document.frm.elements[e].value == "")
			{
				alert("Please Enter "+str);
				window.document.frm.elements[e].focus();	
				window.document.frm.elements[e].select();	
				return false;
			}
		}
for(var e= 5; e < 9; e++){
			str=new String(document.frm.elements[e].name);
			if (document.frm.elements[e].value == -1)
			{
				alert("Please Select "+str);
				return false;
			}
	}



	if (document.frm.airLineName.value =='')
	{
		alert("please Inter Air Line Name");
		window.document.frm.airLineName.focus();
		window.document.frm.airLineName.select();
		return false;
	}



  
	if (document.frm.password.value != document.frm.cnfmPassword.value)
	{
		alert("Password are not same, Please retype");
		window.document.frm.password.focus();
		window.document.frm.password.select();
		return false;
	}








// Validation for EMail

var mail=document.frm.eMail.value;

	if(mail=='')
	{
	alert("This field cannot be blank");
		document.frm.eMail.focus();
		document.frm.eMail.select();
		return false;
	}
if (mail.indexOf("@")==-1) 
	{
		alert("This EMail address is invalid .\n\nPlease re-enter.");
			document.frm.eMail.focus();
		   document.frm.eMail.select();
		return false;
	}//end of if
else
{
	var l=mail.indexOf("@",0);
	var t=mail.substring(l+1,mail.length)

	if(t.indexOf("@",0)>=0)
	{
		 alert("This EMail address is invalid .Only one @ is allowed .\n\nPlease re-enter.");
		 document.frm.eMail.focus();
		document.frm.eMail.select();
return false;
	}//end of if

}//end of else

if  (mail.indexOf(".")==-1)
	{
		alert("This EMail address is invalid .\n\nPlease re-enter.");
		 document.frm.eMail.focus();
		document.frm.eMail.select();
		return false;
	}//end of if
else
{
	var m=mail.indexOf(".",0);
	var t1=mail.substring(m+1,mail);
	 

	if((t1.indexOf(".",0)==0)||(t1.indexOf("@",0)==0))
	{
		alert("There should be some alphabet after dot sign .\n\nPlease re-enter.");
		 document.frm.eMail.focus();
		document.frm.eMail.select();
		return false;
	}//end of if
	if(t1=="")
	{
		alert("This EMail address is invalid .\n\nPlease re-enter.");
		 document.frm.eMail.focus();
		document.frm.eMail.select();
		 return false;
	}//end of if
}//end of else


 



	if (window.document.frm.passport_No.value !="")
	{
		 flag = checkPassportDetails();	
		 return flag;
	}	
	
	else {
	var flag = true;
	if (window.document.frm.passport_issue_date.value != "" && window.document.frm.passport_expire_date.value != "") {
	flag = compareDate(window.document.frm.passport_expire_date.value,window.document.frm.passport_issue_date.value,"Issue Date can not be greate than Expire Date ");
	}

	if (window.document.frm.passport_DOB.value != ""  && flag ) {
	flag = compareDate( getCurrentDate(), window.document.frm.passport_DOB.value,"Date of Birth can not be greater than current date"); 		
	}
	return flag;
	}
	

	}
	


function checkPassportDetails() {
	var flag = true;
	if (window.document.frm.passport_ECNR.value == "")
	{
		alert("Please Enter ECNR No");
		window.document.frm.passport_ECNR.focus();
		window.document.frm.passport_ECNR.select();
		return false;	
	}

	if (window.document.frm.passport_issue_date.value == "")
	{
		alert("Please Enter passport issue date");
		window.document.frm.passport_issue_date.focus();
		window.document.frm.passport_issue_date.select();
		return false;	
	}

	if (window.document.frm.passport_flight_No.value == "")
	{
		alert("Please Enter passport frequently flight number");
		window.document.frm.passport_flight_No.focus();
		window.document.frm.passport_flight_No.select();
		return false;	
	}


		if (window.document.frm.passport_expire_date.value == "")
	{
		alert("Please Enter passport expiry date");
		window.document.frm.passport_expire_date.focus();
		window.document.frm.passport_expire_date.select();
		return false;	
	}

	
	if (window.document.frm.passport_DOB.value == "")
	{
		alert("Please Enter Date of Birth");
		window.document.frm.passport_DOB.focus();
		window.document.frm.passport_DOB.select();
		return false;	
	}

	if (window.document.frm.passport_issue_place.value == "")
	{
		alert("Please Enter issuing place");
		window.document.frm.passport_issue_place.focus();
		window.document.frm.passport_issue_place.select();
		return false;	
	}

	if (window.document.frm.passport_Contact_No.value == "")
	{
		alert("Please Enter contact no");
		window.document.frm.passport_Contact_No.focus();
		window.document.frm.passport_Contact_No.select();
		return false;	
	}

	if (window.document.frm.passport_address.value == "")
	{
		alert("Please Enter contact no");
		window.document.frm.passport_address.focus();
		window.document.frm.passport_address.select();
		return false;	
	}

	flag = compareDate(window.document.frm.passport_expire_date.value,window.document.frm.passport_issue_date.value,"Issue Date can not be greate than Expire Date ");
	if (flag)
	{
	flag = compareDate( getCurrentDate(), window.document.frm.passport_DOB.value,"Date of Birth can not be greater than current date"); 		
	}
	return flag;
}

function compareDate (txt1, txt2, msg1){
var date1 = txt1.split("/");
var date2 = txt2.split("/");


	if (date1[2] < date2[1]) {
		alert(msg1);
		return false;
	}
	else if (date1[1] < date2[1]) {
	alert(msg1);
	return false;
	}
	
	else if (date1[0] < date2[0]) {
	alert(msg1);
	return false;
	}
	return true;
}

function getCurrentDate() {
        mydt = new Date();
        yr = mydt.getFullYear();
        mt = mydt.getMonth()+1;
        dt = mydt.getDate();
        current = dt + "/" + mt+ "/" + yr;
		return current;
}



