//function restricts  the no of character  more than from the define length. e.g.  in text field , you can give a maximum limit for the character When you will use onKeyup event. 
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:
 *Date of Creation 		:
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is a Java Script Validation file.
 *Modification 			:1.Restricting the entry of quotes(', ", \) in the fields 
 *Reason of Modification:1.Generating error on retrieving from database
                                        2. check for & ' " ; % in Sitename  added by shiv on 9/25/2007       
										3 Email checking for multiple mail id added by shivsharma  on 25-Mar-08
 *Date of Modification  :1.16-Apr-2007  
 *Modification By		:Samir
 *Revision History		:
 *Editor				:Editplus
 *
 *Modified By			: Manoj Chand
 *Date of Modification	: 08 June 2012
 *Modification			: donot allow special characters while entering password
 *
 *Modified By			: Manoj Chand
 *Date of Modification	: 24 Oct 2013
 *Modification			: validation rule for --,<,>',& are implemented.
 *******************************************************/

function test()
{
	alert("test successfull");
}
function limitlength(obj, length)
{
	//alert("123");
    var maxlength=length;
    if (obj.value.length>maxlength)
        obj.value=obj.value.substring(0, maxlength);
}

//function for restirct the special character or numeric value or character value(Only character and spaces are allowed)
function charactercheck(val, type) 
{
   if(type=='c')                                    //c for charcter only
   {
	   mikExp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;\\0\\1\\2\\3\\4\\5\\6\\7\\8\\9]/;
	   //alert(mikExp);
   }
   else if(type=='n')                                // n for number only
   {
	   mikExp =	/[$\\@\\\#%\^\&\ \*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z]/;
	   //alert(mikExp);
   }
   else if(type=='n.')                                // n for number only
   {
	   mikExp =	/[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\|\,\'\"\?\/\>\<\!\-\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z]/;
   }
   else if(type=='cn')                              // cn for character and no only
   {
	   mikExp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;]/;
	    //alert(mikExp);
   }
   else if(type=='cn,')                              // cn for character and no only
   {
	   mikExp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\'\"\?\/\>\<\!\-\:\;]/;
	    //alert(mikExp);
   }
   else if(type=='cn:')                              // cn for character and no only
   {
	   mikExp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\;]/;
	    //alert(mikExp);
   }
   else if(type=='phone')
   {
        mikExp =	/[$\\@\\\#%\^\&\*\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z]/;
		//alert("in phone");
   }
   /*
   else if(type=='pwd')
   {
        mikExp = /[=\'\-]/;
		//alert("in pwd");
   }*/
	// @ Samir 16-Apr-2007 Restricting Quotes to be entered in the Password field
	else if(type=='pwd')
   {
		//commented by manoj chand on 08 june 2012
        mikExp = /[=\'\"\\\-]/;
		//mikExp=/[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\>\<\!\-\:\;]/;
   }
   else if(type=='an')
   {												// an for alphanumeric only // change by samir on 4/16/2007
        
		mikExp = /[\'\"\;\\\>\<\&]/;
		//alert("in an");
   }
    else if(type=='sitename')      //check for & ' " ; % in Sitename  added by shiv on 9/25/2007   
   {												
        
		mikExp = /[\&\'\"\;\%]/;
		//alert("in an");
   }
   else if(type == 'txt'){
	   mikExp = /[\'\<\>\&]/;
   }
   else if(type=='cur')                                    //c for charcter and currency related symbol only
   {
       mikExp = /[$\\@\\\#%\^\&\*\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;\\0\\1\\2\\3\\4\\5\\6\\7\\8\\9]/;
   }
   else if(type == 'xml'){
	   mikExp = /[\'\&]/;
   }
   else
   {
	   mikExp = /[\`\'\<\>\&]/;
   }
	   

   var strPass = val.value;
   var strLength = strPass.length; 
   //var lchar = val.value.charAt((strLength) - 1);
   //alert("length is=="+strLength); 
   if(strLength > 0)
   {
	   for(var i=0; i<strLength; i++)
	   {
		   //alert("inside for ");
		   var lchar = val.value.charAt(i); 
		   if(lchar.search(mikExp) != -1) 
           {
              var tst = val.value.substring(0, i);
			  var last = val.value.substring(i+1,strLength);
              val.value = tst+last;
			  i--;
		   }

	   }
   }
   /*if(lchar.search(mikExp) != -1) 
   {
      var tst = val.value.substring(0, (strLength) - 1);
      val.value = tst;
   }*/
}

//function for checking the starting zero, spaces and tab character (all leading zero will be remove)
function zeroChecking(val)
{
   var strPass = val.value;
   var strLength = strPass.length; 
   var flag = "y";
   var count = 0;
   if(strLength > 0)
   {
	   for(var i=0; i<strLength; i++)
	   {
		   var lchar = strPass.charAt(i); 
		   if((lchar == "0" || lchar==" " || lchar=="\t") && flag=="y")
		   {
			  count++;
		   }
		   if(lchar!="0" || lchar!=" ")
			   flag="n";
	   }
	   if(count > 0)
	   {
		  //var tst = val.value.substring(0, i);
		  var last = val.value.substring(count,strLength);
          val.value = last;
	   }
	   
   } 
}
//function for checking the starting spaces (all leading spaces will be remove)
function spaceChecking(val)
{
   var strPass = val.value;
   var strLength = strPass.length; 
   var flag = "y";
   var count = 0;
   if(strLength > 0)
   {
	   for(var i=0; i<strLength; i++)
	   {
		   var lchar = strPass.charAt(i); 
		   if(lchar==" " && flag=="y")
		   {
			  count++;
		   }
		   if(lchar!=" ")
			   flag="n";
	   }
	   if(count > 0)
	   {
		  //var tst = val.value.substring(0, i);
		  var last = val.value.substring(count,strLength);
          val.value = last;
	   }
	   
   } 
}




//function for restirct the japnees character(note this function allow only the characters those exist in the mikExp variable)
function restrictChar(val, type) 
{
   if(type=='noJapChar')                                    //
   {
	   mikExp = /[$\\@\\\#%\^\&\*\ \(\)\[\]\+\_\{\}\`\~\=\.\|\,\'\"\?\/\>\<\!\-\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z\\0\\1\\2\\3\\4\\5\\6\\7\\8\\9]/;
	   //alert(mikExp);
   }
   else if(type=='c')                                    //
   {
	   mikExp = /[\ \\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z]/;
	   //alert(mikExp);
   }
   else if(type=='userName')                                    //
   {
	   mikExp = /[$\\@\\\#%\^\&\*\ \(\)\[\]\+\_\{\}\`\~\=\.\|\,\"\?\/\>\<\!\-\:\;\\a\\b\\c\\d\\e\\f\\g\\h\\i\\j\\k\\l\\m\\n\\o\\p\\q\\r\\s\\t\\u\\v\\w\\x\\y\\z\\A\\B\\C\\D\\E\\F\\G\\H\\I\\J\\K\\L\\M\\N\\O\\P\\Q\\R\\S\\T\\U\\V\\W\\X\\Y\\Z\\0\\1\\2\\3\\4\\5\\6\\7\\8\\9]/;
	   //alert(mikExp);
   }
   else
   {
	   mikExp = /[\`]/;
	  // alert("nothing");
   }

   var strPass = val.value;
   var strLength = strPass.length; 
 
   if(strLength > 0)
   {
	   for(var i=0; i<strLength; i++)
	   {	  
		   var lchar = val.value.charAt(i); 
           //alert(val.value);
		   
		   if(lchar == '')
		   {
		      ch = '';
		   }
		   else
		   {
		     var ch = lchar.search(mikExp);
		   }
			
		   if(ch == '-1')
		   {
		      var tst = val.value.substring(0, i);
			  var last = val.value.substring(i+1,strLength);
			 // alert("i=="+i);
			  val.value = tst+last;
			  i--;
		   }

	   }
   } 
}

//fuction for trim the value
function TrimString(txtObj)
{
   txtObj.value = txtObj.value.replace(/^\s+/,""); //Left trim        
   txtObj.value = txtObj.value.replace(/\s+$/,""); //Right trim
}









function check_alph_only(obj)
{
  var  str = obj.value;
  var     s_regexp	=	new RegExp("[*,&,%,$,#,@,!,~,?,<,>,>,:,;,=,',-,1,2,3,4,5,6,7,8,9,0]");
  var     desc		=	s_regexp.test(str);
  if(desc==true)	
  {
     alert(" valid");       
	 return true;
  }
  else
  {
	  alert("not valid");
	  obj.value="";
	  obj.focus();
	  return false;
  }
}






//*************Email Validation*********************
function echeck(str)                             // note here str is the value of email text field
{
		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
		if (str.indexOf(at)==-1){
		   alert("Invalid E-mail ID")
		   return false
		}

		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   alert("Invalid E-mail ID")
		   return false
		}

		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    alert("Invalid E-mail ID")
		    return false
		}

		 if (str.indexOf(at,(lat+1))!=-1){
		    alert("Invalid E-mail ID")
		    return false
		 }

		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    alert("Invalid E-mail ID")
		    return false
		 }

		 if (str.indexOf(dot,(lat+2))==-1){
		    alert("Invalid E-mail ID")
		    return false
		 }
		
		 if (str.indexOf(" ")!=-1){
		    alert("Invalid E-mail ID")
		    return false
		 }

 		 return true					
	}



/////=======email checking for multiple mail id added by shivsharma  on 25-Mar-08


function echeckMultple(str)                             // note here str is the value of email text field
{
		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
		var msg="Invalid E-mail ID! \nFor Multiple E-mail ID use ; as a Separator";
		if (str.indexOf(at)==-1){
		   alert(msg)
		   return false
		}

		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   alert(msg)
		   return false
		}

		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    alert(msg)
		    return false
		}

		 if (str.indexOf(at,(lat+1))!=-1){
		    alert(msg)
		    return false
		 }

		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    alert(msg)
		    return false
		 }

		 if (str.indexOf(dot,(lat+2))==-1){
		    alert(msg)
		    return false
		 }
		
		 if (str.indexOf(" ")!=-1){
		    alert(msg)
		    return false
		 }

 		 return true					
	}

///====================///







//***************Phone Validation********************

// Declaring required variables
var digits = "0123456789";
// non-digit characters which are allowed in phone numbers
var phoneNumberDelimiters = "()- ";
// characters which are allowed in international phone numbers
// (a leading + is OK)
var validWorldPhoneChars = phoneNumberDelimiters + "+";
// Minimum no of digits in an international phone no.
var minDigitsInIPhoneNumber = 10;

function isInteger(s)
{   var i;
    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag)
{   var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++)
    {   
        // Check that current character isn't whitespace.
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function checkInternationalPhone(strPhone){
s=stripCharsInBag(strPhone,validWorldPhoneChars);
return (isInteger(s) && s.length >= minDigitsInIPhoneNumber);
}

function ValidatePhoneNo(obj){
	var Phone=obj;
	
	if ((Phone.value==null)||(Phone.value=="")){
		alert("Please Enter your Phone Number")
		Phone.focus()
		return false
	}
	if (checkInternationalPhone(Phone.value)==false){
		alert("Please Enter a Valid Phone Number")
		Phone.value=""
		Phone.focus()
		return false
	}
	return true
 }

//************************Money Validation**********************************

function moneyFormat(textObj) {
   var newValue = textObj.value;
   var decAmount = "";
   var dolAmount = "";
   var decFlag = false;
   var aChar = "";
   // ignore all but digits and decimal points.
   for(i=0; i < newValue.length; i++) {
      aChar = newValue.substring(i,i+1);
      if(aChar >= "0" && aChar <= "9") {
         if(decFlag) {
            decAmount = "" + decAmount + aChar;
         }
         else {
            dolAmount = "" + dolAmount + aChar;
         }
      }
      if(aChar == ".") {
         if(decFlag) {
            dolAmount = "";
            break;
         }
         decFlag=true;
      }
   }
   // Ensure that at least a zero appears for the dollar amount.

   if(dolAmount == "") {
      dolAmount = "0";
   }
   // Strip leading zeros.
   if(dolAmount.length > 1) {
      while(dolAmount.length > 1 && dolAmount.substring(0,1) == "0") {
         dolAmount = dolAmount.substring(1,dolAmount.length);
      }
   }
   // Round the decimal amount.
   if(decAmount.length > 2) {
      if(decAmount.substring(2,3) > "4") {
         decAmount = parseInt(decAmount.substring(0,2)) + 1;
         if(decAmount < 10) {
            decAmount = "0" + decAmount;
         }
         else {
            decAmount = "" + decAmount;
         }
      }
      else {
         decAmount = decAmount.substring(0,2);
      }
      if (decAmount == 100) {
         decAmount = "00";
         dolAmount = parseInt(dolAmount) + 1;
      }
   }
   // Pad right side of decAmount
   if(decAmount.length == 1) {
      decAmount = decAmount + "0";
   }
   if(decAmount.length == 0) {
      decAmount = decAmount + "00";
   }
   // Check for negative values and reset textObj
   if(newValue.substring(0,1) != '-' ||
         (dolAmount == "0" && decAmount == "00")) {
      textObj.value = dolAmount + "." + decAmount;

   }
   else{
      textObj.value = '-' + dolAmount + "." + decAmount;
   }
}

// Function for check the date codition is second date should be grater or equal to the first date
function checkDate(form1,firstDate,secondDate,firstDateObject,secondDateObject,message1,message2)
{
	//Second date should be equal or greater from the first date
	//get today date info
	var todayDate=firstDate;                //today date
	//alert("firstDate is=="+todayDate);
	var dDate=secondDate;
	//alert("dob is"+DOB);

	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);

    //get departure date information
	var f=dDate.substr(6,4);
	var year1=parseInt(f,10);

	var b=dDate.substr(3,2);
	var month1=parseInt(b,10);

	var h=dDate.substr(0,2);
	var day1=parseInt(h,10);
	if(year>year1)
	{
		 alert(message1);
		 secondDateObject.value="";
		 secondDateObject.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month>month1))
	{
		 alert(message1);
		 secondDateObject.value="";
		 secondDateObject.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day>day1))
	{		
		 alert(message1);
		 secondDateObject.value="";
		 secondDateObject.focus();
		 return false;
	}//end of elseif
}


//////my funtion


function checkDateme(form1,firstDate,secondDate,firstDateObject,secondDateObject,message1,message2)
{
	//Second date should be equal or greater from the first date
	//get today date info
	var todayDate=firstDate;                //today date
	//alert("firstDate is=="+todayDate);
	var dDate=secondDate;
	//alert("dob is"+DOB);

	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);

    //get departure date information
	var f=dDate.substr(6,4);
	var year1=parseInt(f,10);

	var b=dDate.substr(3,2);
	var month1=parseInt(b,10);

	var h=dDate.substr(0,2);
	var day1=parseInt(h,10);
	
	if(year>year1)
	{
		 alert(message1);
		 firstDateObject.value="";
		 secondDateObject.value="";
		 firstDateObject.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month>month1))
	{
		  alert(message1);
		 firstDateObject.value="";
		 secondDateObject.value="";
		 firstDateObject.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day>day1))
	{		
		 alert(message1);
		 firstDateObject.value="";
		 secondDateObject.value="";
		 //firstDateObject.focus();
		 return false;
	}//end of elseif
}




///new

function checkDateme1(form1,firstDate,secondDate,firstDateObject,secondDateObject,message1,message2)
{
	//Second date should be equal or greater from the first date
	//get today date info
	var todayDate=firstDate;                //today date
	//alert("firstDate is=="+todayDate);
	var dDate=secondDate;
	//alert("dob is"+DOB);

	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);

    //get departure date information
	var f=dDate.substr(6,4);
	var year1=parseInt(f,10);

	var b=dDate.substr(3,2);
	var month1=parseInt(b,10);

	var h=dDate.substr(0,2);
	var day1=parseInt(h,10);
	
	if(year>year1)
	{
		 alert(message1);
		 firstDateObject.value="";
		 //commented by manoj chand on 22 May 2013 
		 //secondDateObject.value="";
		 firstDateObject.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month>month1))
	{
		  alert(message1);
		 firstDateObject.value="";
		//commented by manoj chand on 22 May 2013 
		 //secondDateObject.value="";
		 firstDateObject.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day>day1))
	{		
		 alert(message1);
		 firstDateObject.value="";
		//commented by manoj chand on 22 May 2013 
		 //secondDateObject.value="";
		 firstDateObject.focus();
		 return false;
	}//end of elseif
}


//new
///



////my function




// Function for check the date codition is second date should be grater than the first date
function checkDateGrater(form1,firstDate,secondDate,firstDateObject,secondDateObject,message1,message2)
{
	//Second date should be equal or greater from the first date
	//get today date info
	var todayDate=firstDate;                //today date
	//alert("firstDate is=="+todayDate);
	var dDate=secondDate;
	//alert("dob is"+DOB);

	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);

    //get departure date information
	var f=dDate.substr(6,4);
	var year1=parseInt(f,10);

	var b=dDate.substr(3,2);
	var month1=parseInt(b,10);

	var h=dDate.substr(0,2);
	var day1=parseInt(h,10);
	
	if(year>year1)
	{
		 alert(message1);
		 secondDateObject.value="";
		 secondDateObject.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month>month1))
	{
		 alert(message1);
		 secondDateObject.value="";
		 secondDateObject.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day>=day1))
	{		
		 alert(message1);
		 secondDateObject.value="";
		 secondDateObject.focus();
		 return false;
	}//end of elseif
}


//code for disable the backspace button(but allow text correction) and F11 Key
if (typeof window.event != 'undefined')
     document.onkeydown = function()
                          {
							 if(event.keyCode == 122)
							 {
								event.cancelBubble = true;
								event.keyCode = 0;
								return false;
							 }
                             if (event.srcElement.tagName.toUpperCase() != 'INPUT' && event.srcElement.tagName.toUpperCase() !='TEXTAREA')
                                return (event.keyCode != 8);
                           }
   else
     document.onkeypress = function(e)
                           {
                             if (e.target.nodeName.toUpperCase() != 'INPUT' && e.target.nodeName.toUpperCase() != 'TEXTAREA')
                               return (e.keyCode != 8);
                           }

//added by manoj chand on 10 Dec 2012 to restrict two decimal
function upToTwoDecimal(val)
{
   var m = val.value;
   var strLength = m.length;
   var loc = m.indexOf(".");
   if(loc == '-1')
   {
   }
   else
   {
  	  var a = m.substring(0,loc+1);
	  if((loc+1) < strLength)
	  {
	    var b = m.substring(loc+1,strLength);
		if(b.length > 2)
		{
		  b = b.substring(0,2);
		  val.value = a+b;
		}
	  }  
   }
   
   // restrict more than one dot(.)
    var intFlag = 0;
    for(var i=0; i<strLength; i++)
	{	  
		var lchar = val.value.charAt(i);
		   
		  if(lchar == '.')
		   {
		      intFlag++;
		   }
			
		   if(intFlag > 1)
		   {
		      var tst = val.value.substring(0, i);
			  val.value = tst;
			  break;
		   }

		   if(lchar == '\\')
		   {
		      var tst = val.value.substring(0, i);
			  val.value = tst;
			  break;
		   }
	   }
}
//function for restrict two consecutives hyphens
function upToTwoHyphen(val)
{
	var m = val.value;
	var strLength = m.length;
	var intFlag = 0;
    for(var i=0; i<strLength; i++)
	{	  
		var lchar = val.value.charAt(i); 
		  if(lchar == '-'){
			  i++;
			  var lnchar=val.value.charAt(i);
			  if(lchar==lnchar){
				  
				  var tst = val.value.substring(0, i);
				  val.value = tst;
				  break;
			  }
		  }
	}
	
}
