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
	 *******************************************************/
	%>
	
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-jp" />
	<title>Create Group/Guest Travel Request</title>
	<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	</head>
	<!-- all include files with sesstion variables -->
	<%-- Import Statements  --%>
	<%@ include  file="importStatement.jsp" %>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	
	<!-- script used in files  -->
	
	<script language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
		<SCRIPT language="JavaScript" src="ScriptLibrary/popcalendar.js?buildstamp=2_0_0"></SCRIPT>
	<script language=JavaScript>
		// code added  on 07-Jun-07 by shiv for changing date selector open   
	         function button_onclick(obj) 
		    {
			             popUpCalendar(obj,obj,"dd/mm/yyyy");
			}
		 
	        // code added  on 07-Jun-07 by shiv for changing date selector close
	
	
	
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
	
	    if (userAge!='')
	
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
	
	
	function NextPage(frm,flag)
			{
			
					var var2=save(frm);
			        //alert(var2); 
					 
					if(var2==false){
						return false;
					} 
					 
					 if (flag==2){
			            alert("Please Click Add traveler Button to Proceed."); 
			            
						return false;
					  }
			
			
			  		if(document.frm.firstName.value!='' || document.frm.lastName.value!=''){
				        if(confirm('Are you sure you want to Proceed, Any unsaved data may be lost.\nPress Add/Update traveler button to save details before proceeding.'))
							{
				                 document.frm.action="Group_itinerary_details.jsp";
				                 document.frm.submit();
							}
							else{
						      return false;
							}
				    }else{
				    	   document.frm.action="Group_itinerary_details.jsp";
				           document.frm.submit();
				     }
			
	     	  document.frm.submit();
			}
	function ExitPage(frm)
			{ 
	
	
	    if(document.frm.firstName.value!='' || document.frm.lastName.value!=''){
				if(confirm('Are you sure you want to exit, Any unsaved data may be lost !'))
				{
	             document.frm.action="T_TravelRequisitionList.jsp?travel_type=INT";
			    document.frm.submit();
				}
				else
				{
			      return false;
				}
	    }
	
	
	  else
				{	 document.frm.action="T_TravelRequisitionList.jsp?travel_type=INT";
	                 document.frm.submit();
	   }
			}
			
	function checkDate(form1,firstDate,secondDate,firstDateName,secondDateName,message1,message2)
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
			
			
			
	
	function save(f1){
	
	    if(f1.depCity.value=="")  
			{
				alert("Please enter the Departure City.");
				f1.depCity.focus();
				return false;
			}
			if(f1.arrCity.value=="")
			{
				alert("Please enter the Arrival City.");
				f1.arrCity.focus();  
				return false;
			}
			if(f1.depDate.value=="")
			{
				alert("Please enter the Departure Date.");
				f1.depDate.focus();
				return false;
			}
	     	if(f1.nameOfAirline.value=="")
			{
				alert("Please enter the Preferred Airlines.");
				f1.nameOfAirline .focus();
				return false;
			}
	 
	     //validation for date  departure date  
	      var todayDate  =  f1.todayDate.value;  
	      var depDate    =  f1.depDate.value;
	  
	      
	       var flag1 = checkDate(f1,todayDate,depDate,f1.todayDate,f1.depDate,'Departure Date of Journey can not be smaller than the Today\'s Date ','no');
	      if(flag1 == false){
	  	   return flag1;
	  	   }else{     
	  	   			  document.frm.whatAction.value ="itenupdate";    
	  	            document.frm.submit();    
	  	   
	  	   }
	  
	   
	
	}
	
	
	
	function deleteConfirm()
	{
			if(confirm('Are you sure you want to Delete the record !'))
				return true;
			else
			   return false;
	}
	
	 function getDivisonID()
		{
		   document.frm.action="Group_T_IntTrv_Details.jsp";  
		   document.frm.designation.value="-1";
		   document.frm.submit();
	    }
	
	function check1()
	   {
		  var flag=0;
		  var flag1=0;
		  var flag2=0;
		  var arrEntitlement = new Array(100);
		  var arrTotalTourDays= new Array(100);
		  var totalEntitleMent=0;
		  var totalTourDays = 0;
	  
		  for( i=0;i<document.frm.elements.length;i++)
		   {
			  if(document.frm.elements[i].name=='entitlement')
			   {
				    arrEntitlement[flag]=document.frm.elements[i].value;
				    if(arrEntitlement[flag]=="")
			       	{
					   arrEntitlement[flag]=0;
				   }
				  totalEntitleMent=totalEntitleMent+parseFloat(arrEntitlement[flag]);
				   flag++;
			   }
			if(document.frm.elements[i].name=='tourDays' )
			  {
			 	arrTotalTourDays[flag1]=document.frm.elements[i].value;
			  	if(arrTotalTourDays[flag1]=="")
				{
					arrTotalTourDays[flag1]=0;
				}
				totalTourDays=totalTourDays+parseInt(arrTotalTourDays[flag1]);
				flag1++;
			}
			if(document.frm.elements[i].name=='totalForex' || document.frm.elements[i].name=='contingencies')
			{
				flag2++;
			}
	
			
		}	
	
		var i=0;
		var k=0;
	    var tempTotal=0;
		for(j=0;j<flag2;j++)
		{
			inner : while(i<document.frm.elements.length)
			{
				if(document.frm.elements[i].name=='totalForex' )
				{
					document.frm.elements[i].value=parseFloat(arrEntitlement[j])*parseInt(arrTotalTourDays[j]);
					tempTotal=tempTotal+parseFloat(document.frm.elements[i].value);
					break inner;
				}
				if(document.frm.elements[i].name=='contingencies' )
				{
				    if(document.frm.elements[i].value=="")
	                   document.frm.elements[i].value=0; 
					tempTotal=tempTotal+parseFloat(document.frm.elements[i].value);
					break inner;
				}
	
				i++;
				k=i;			
			}
			i=++k;
		}
		document.frm.grandTotalForex.value=tempTotal; 
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
				
				
				
				
				
				
				
				
				
				
	             charactercheck(obj,str);
	        	limitlength(obj, length);
		        //zeroChecking(obj); //function for checking leading zero and spaces
		        spaceChecking(obj);
	 }
	
	function  checkData(frm,whatAction)
	{
			 if(frm.site.value == '-1')
				{
					alert("Please Select  the Unit Name."); 
		            frm.site.focus();
					return false;
				}
			if(frm.firstName.value == '')
				{
					alert("Please fill the First Name.");
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
					alert("Please Select the Desigantion.");
		            frm.designation.focus();
					return false;
				}
				
			if(frm.passport_DOB.value == '')
				{
			       alert("Please fill the Date of Birth.");
				   frm.passport_DOB.focus();
				   return false;  
				} 
	
				 if(frm.Gender.value == '-1')
				{
					alert("Please Select the Gender.");
		            frm.Gender.focus();
					return false;
				}
				
			if(frm.passportNo.value == '')
				{
			       alert("Please fill the Passport No.");
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
			       alert("Please fill the correct Date of birth.");
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
									var flag =gridCheck(); 
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
	
	
	function gridCheck()
		{
		   var j=17; 
		        k=25;
	       for( i=j;i<k;i++) 
	      {//alert(  "no is"+i);
	
		   if (i==21 || i==22)
			  {
	    			var str = document.frm.elements[21].value;
					var str1 = document.frm.elements[22].value;
					if(str!="" && str!="0")
					{
						if(str1=="" || str1=="0")
						{
							alert("Please fill the total tour days.");
							document.frm.elements[22].focus();
							return false;
						}
					}
				 
					if(str1!=""&& str1!="0")
					{
						  
						if(str=="" || str=="0")
						{	
							 	alert("Please fill the expenditure per day.");
							document.frm.elements[21].focus();
							return false;
						}
					}
	
		   }else{
	          /// added code for changing Expenditure validation Criteria  on  28-Apr-08  by shiv Sharma 
	    if ((document.frm.elements[17].value!=0 | document.frm.elements[17].value==''))     
								  {
								//alert(document.frm.elements[i].name);
								if(document.frm.elements[i].name=='entitlement')
								{
									//alert(document.frm.elements[i].name);
									var str = document.frm.elements[i].value;
									if(str=="")
									{
										//alert("Please fill the expenditure per day");
										alert("Please fill 0 if not required in the expenditure per day");
										document.frm.elements[i].focus();
										return false;
									}
								}
								if(document.frm.elements[i].name=='tourDays' )
								{
									var str1=document.frm.elements[i].value;
									if(str1=="")
									{
										//alert("Please fill the total tour days");
										alert("Please fill 0 if not required in the total tour days");
										document.frm.elements[i].focus();
										return false;
									}
								}
								if(document.frm.elements[i].name=='totalForex' )
								{
									var str1=document.frm.elements[i].value;
									if(str1=="")
									{
										//alert("Please fill the total tour days");
										//document.frm.elements[i].focus();
										//return false;
									}
								}
								if(document.frm.elements[i].name=='contingencies' )
								{
									var str1=document.frm.elements[i].value;
									if(str1!="0" && str1!="")
									{
										if(document.frm.expRemarks.value=="")
										{
										  alert("Please fill the Remarks for Contingencies/Any Other Expenditure");
										  document.frm.expRemarks.focus();
										  return false;
										}
									}
								}
	
								if(document.frm.elements[i].name=='remarks' )
								{ 
									var str1=document.frm.elements[i].value;
									if(str1!="0" && str1!="")
									{
										if(document.frm.expRemarks.value=="")
										{
										  alert("Please fill the Remarks for Contingencies/Any Other Expenditure");
										  document.frm.expRemarks.focus();
										  return false;
										}
									}
									 
								}
	
							   }
	
		  }
	
	 
	
		  }	
	
	
			if ((document.frm.contingencies[0].value != '0' && document.frm.contingencies[0].value != "" )  || (document.frm.contingencies[1].value != '0' && document.frm.contingencies[1].value != "")){
			if (document.frm.expRemarks.value == "") {
				alert("Please specify the reason for contingencies or any other expenditure");
				document.frm.expRemarks.focus();
				return false;
			}
		}
	
	return true;
	
	}
	
	 </script>
	
	<%
	//Global Variables declared and initialized
	
	int intSerialNo=1; 
	
	String strSql                                           =  null;              // String for Sql String
	ResultSet rs,rs1,rs2                              =  null;              // Object for ResultSet
	String DOB											   ="";
	String strDOfIssue								   ="";
	String strDOExpiry								   ="";
	String strEntPerDay							   ="";
	String strTotalTourDays                        ="";
	String strTotalExpId                               ="";
	String strTotalAmount							   ="";
	
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
	
	String strButtonCaption                 =" Add   Traveler";
	
	String strwhatAction					   ="";
	String strCurrency_list                   ="";	
	String strExpRemark                     ="";
	
	String strButtonstate1						="enabled";
	String strReturnTravel						=""; 
	String 	strchecked							="";
	String strTexttoShow						="";
	String strTexttoShowtraveler				="";
							 
	
	
	String strMessage  	                            = (request.getParameter("strMessage")==null)?"":request.getParameter("strMessage");
	String strG_userID  							= (request.getParameter("G_userId")==null)?"":request.getParameter("G_userId");
	String Site_ID 						                = (request.getParameter("site")==null)?"-1":request.getParameter("site");
	String strFirstname				                =(request.getParameter("firstName")==null)?"":request.getParameter("firstName");  
	String strLastname				                = (request.getParameter("lastName")==null)?"":request.getParameter("lastName");
	String strDesig_ID 				                = (request.getParameter("designation")==null)?"-1" :request.getParameter("designation");
	String strDOB 				                    = (request.getParameter("passport_DOB")==null)?"" :request.getParameter("passport_DOB");
	String strMeal 							            = (request.getParameter("meal")==null)?"1" :request.getParameter("meal");//putting default as veg 
	String strPassportNo 		                    = (request.getParameter("passportNo")==null)?"" :request.getParameter("passportNo");
	String strPassport_issue_date		    = (request.getParameter("passport_issue_date")==null)?"" :request.getParameter("passport_issue_date");
	String strPassport_expire_date		    = (request.getParameter("passport_expire_date")==null)?"" :request.getParameter("passport_expire_date");
	String strPassport_issue_place		    = (request.getParameter("passport_issue_place")==null)?"" :request.getParameter("passport_issue_place");
	String strVisa										= (request.getParameter("visa")==null)?"2" :request.getParameter("visa");
	String strEcr									    = (request.getParameter("ECR")==null)?"2" :request.getParameter("ECR");
	String strAge									    = (request.getParameter("age")==null)?"" :request.getParameter("age");
	 strGender									        = (request.getParameter("Gender")==null)?"-1" :request.getParameter("Gender");
	 strTACurrency									= (request.getParameter("expCurrency")==null)?"USD" :request.getParameter("expCurrency");
	                                        
	
	
	
	strTravelId                                           =  request.getParameter("travelId")==null ?"" :request.getParameter("travelId") ;        // for hidden field
	strTravelReqId                                    =  request.getParameter("travelReqId") ==null ?"" :request.getParameter("travelReqId");    // for hidden field
	strTravelReqNo                                  =  request.getParameter("travelReqNo")==null ?"" :request.getParameter("travelReqNo") ;    // for hidden field
	
	strwhatAction                                     =  request.getParameter("action")==null ?"" :request.getParameter("action") ;    // for hidden field
	
	 
	
	
	 if(strTravelId!=null && !strTravelId.equals("")  && !strTravelId.equals("new"))
	 { 
		    strSql = "SELECT     T1.TRAVEL_REQ_ID AS TRAVEL_REQ_ID, T2.SITE_ID as SITE_ID  FROM    T_TRAVEL_STATUS T1 INNER JOIN T_GROUP_USERINFO T2 ON T1.TRAVEL_ID = T2.TRAVEL_ID   WHERE     (T1.STATUS_ID = 10) AND (T1.TRAVEL_TYPE = 'i') AND (T1.TRAVEL_ID = "+strTravelId+")";	
	
			 rs       =   dbConBean.executeQuery(strSql);  
			while(rs.next()){
			strTravelReqId=rs.getString("TRAVEL_REQ_ID");
			Site_ID=rs.getString("SITE_ID");
			}
			rs.close();
	 }
		
	//when user click on update Button ======================  
	if(strTravelId!=null && !strTravelId.equals("") && strG_userID!=null &&  !strG_userID.equals("")  && !strTravelId.equals("new") )
	 { 
		   strButtonCaption ="Update details"; 
	       strSql="SELECT SITE_ID, FIRST_NAME, LAST_NAME, DESIG_ID, PASSPORT_NO, dbo.CONVERTDATEDMY1(DATE_OF_ISSUE) AS DATE_OF_ISSUE, PLACE_OF_ISSUE, dbo.CONVERTDATEDMY1(EXPIRY_DATE) AS EXPIRY_DATE, AGE, ECNR,  dbo.CONVERTDATEDMY1(DOB) AS DOB,   VISA_REQUIRED, GENDER, MAEL_ID, TOTAL_AMOUNT,isnull(EXP_REMARKS,'') as  EXP_REMARKS FROM    T_GROUP_USERINFO   WHERE  (STATUS_ID = 10) AND (G_USERID = "+strG_userID+") AND (TRAVEL_TYPE = 'i') AND (TRAVEL_ID = "+strTravelId+")";
	
		   rs    =  dbConBean.executeQuery(strSql);  
	
		   while(rs.next())
			   {
					  Site_ID                                         =rs.getString("SITE_ID"); 
					  strFirstname                                =rs.getString("FIRST_NAME"); 
					   strLastname							       =rs.getString("LAST_NAME"); 
					   strDesig_ID							       =rs.getString("DESIG_ID"); 
					   strPassportNo							   =rs.getString("PASSPORT_NO");
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
	%>
	
	<table width="92%" border="0" cellspacing="0" cellpadding="0" align="center" >
	  <tr>
	    <td background="images/tophdbg.gif?buildstamp=2_0_0"><img src="images/group-travel-request.png?buildstamp=2_0_0" alt="Group Travel Request" width="237" height="35" /></td>
	    <td width="15%" background="images/tophdbg.gif?buildstamp=2_0_0"><img src="images/BigIcon.gif?buildstamp=2_0_0" alt="" width="46" height="31" /></td>
	  </tr>
	</table>
	<% 
	   			  String Path	=application.getInitParameter("companyPolicyPath");
				  File UploadFile=new File(Path+"/"+strSiteFullName+"/"+strSiteFullName+".html");			   
	%>
	
	              
	<form name="frm" action="Group_T_IntTrv_DetailsPost.jsp" style="margin-top:-20px; padding-top:0px;">
	<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" >
	  <tr>
	    <td>
	    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">  
	    <tr><td> &nbsp;&nbsp;&nbsp;</td> 

	    </tr>    
	      
	      <tr>
	        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">   
	          <tr>
	            <td valign="top" background="images/index_01.png?buildstamp=2_0_0"><img src="images/index_01.png?buildstamp=2_0_0" alt="" width="14" height="426" /></td>
	            <td width="100%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	              <tr>
	                <td><img src="images/formTitIcon.png?buildstamp=2_0_0" alt="" width="30" height="29" /></td>
	                <td width="70%" background="images/tophd-bg.gif?buildstamp=2_0_0" class="formTit">Create Group/Guest Travel Request  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<font color="#CC3333" ><%=strMessage%></font></td>
	                <td width="30%" background="images/tophd-bg.gif?buildstamp=2_0_0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;<a href="#" title="Company Policy" onClick="<% 
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
	                  <td height="40" bgcolor="#FDF9FA">
					  <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
					    <tr>
						  <td height="25" colSpan=2 class="label1">&nbsp;&nbsp;&nbsp;&nbsp; Group/Guest Requisition from Unit &nbsp; &nbsp; &nbsp; 
						    <select name="site" class="textBoxCss"   onChange="getDivisonID();"  <%//=strDisable%> >
	                          <option value="-1" selected>Select Your Unit</option>
							  <%
	                          /// getting a site from  	USER_MULTIPLE_ACCESS if user ahs miltiple access 					
							   strSql = "select distinct site_id, dbo.sitename(site_id) as Site_Name  from USER_MULTIPLE_ACCESS where userid="+Suser_id+" and status_id=10  order by 2";
						 
	                           rs       =   dbConBean.executeQuery(strSql);  
							   while(rs.next())
	                          {
							   %>       
	                            <option value="<%=rs.getString("Site_Id")%>"><%=rs.getString("Site_Name")%></option>
								<%
	                     	  }
	                          rs.close();	 
	                           /// getting a site from M_Site if user dose not have access of other site 
	                           
							  strSql =   "select Site_id, Site_Name from M_Site where status_id=10 and application_id=1 and Site_id="+strSiteIdSS+" and Site_id Not IN (select distinct site_id from USER_MULTIPLE_ACCESS where userid="+Suser_id+" and status_id=10) order by 2";	
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
	                          </select>  </td> 
	  						 <script language="javascript">
								document.frm.site.value ="<%=Site_ID%>"; 
							</script>
							  <td height="25" colSpan=2   align="left" >         
		                    </tr>
	                        <TR>
	                		<TD class=formfirstfield vAlign=bottom align="left"	bgColor=#fdf9fa colSpan=1 height=25>Basic Information </td>
	                		
	                  </TR>
	                  <TR>
	                		<TD class=formtxt align=left bgColor=#fdf9fa colSpan=2 height=30> Fields marked with an asterisk (<SPAN class=starcolour>*</SPAN>) are required.</TD>
	  				    </TR>
	                  
	                  
	              	 
	              </table>
				  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	             <tr>
	               <td bgcolor="#FDF9FA"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" >
		          <tr>
	                  <td height="25" class="label1">Personal Information</td>
	                </tr>
	                <tr>
	                  <td height="25">
					  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                      <td width="16%" class="label2">First Name<SPAN   class=starcolour>*</SPAN> </td>
	                      <td width="16%" class="label2">Last Name<SPAN   class=starcolour></SPAN> </td>
	                      <td width="16%" class="label2">Designation<SPAN   class=starcolour>*</SPAN> </td>
	                      <td width="16%" class="label2">Date of Birth<SPAN  class=starcolour>*</SPAN> </td>
	                      <td width="10%" class="label2">Gender<SPAN   class=starcolour>*</SPAN> </td>
	                      <td width="26%" class="label2">Meal Pref.<SPAN   class=starcolour></SPAN> </td>
	                    </tr>
	                    <tr>
	                      <td>
	                        <input type="text" name="firstName" class="textBoxCss"   onKeyUp="return test1('firstName', 30, 'c')" maxlength="30"/></td>
	                       <td class="label2">
						   <script  language="javascript">
						   document.frm.firstName.value="<%=strFirstname%>";
						   </script>
						   <input type="text" name="lastName" class="textBoxCss"  onKeyUp="return test1('lastName', 30, 'c')" maxlength="30" /></td>
	                      <td class="label2">
						  <script  language="javascript">
						   document.frm.lastName.value="<%=strLastname%>";
						   </script>
						  <select name="designation" class="textBoxCss">
						   <option value="-1"> Select Your Designation </option>
						   <%
					   			  	strSql = "SELECT DESIG_ID,DESIG_NAME  FROM M_DESIGNATION where site_id="+Site_ID+" AND APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY DESIG_NAME";
								 
	                                 rs       =   dbConBean.executeQuery(strSql);  
	                                 while(rs.next())
	                                    {%>
										 <option value="<%=rs.getString("DESIG_ID")%>"><%=rs.getString("DESIG_NAME")%></option> 
									<%}
	                              rs.close();
							%>
			
						  </td>
						  <script  language="javascript">
						   document.frm.designation.value="<%=strDesig_ID%>";
						   </script>
	
	                      <td class="label2">
						  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                          <tr>
								<td> <!--Reaching Date at Destination-->
							<!--  Modified by vaibhav on jun 23 2010
							<input name="passport_DOB" type="text" class="textBoxCss" id="test2" size="6" value="<%=DOB%>" onFocus="javascript:vDateType='DD/MM/YYYY'"  -->
						    <input name="passport_DOB" type="text" class="textBoxCss" id="passport_DOB" size="6" value="<%=DOB%>" onFocus="javascript:vDateType='DD/MM/YYYY'" 
							onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter');" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter');"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);FindAge();" 
							/> 
	
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
	                      <td>
	                        <select name="Gender" class="textBoxCss">
							<option value='-1'  >Gender</option>
	                          <option value='1'  >Male</option>
	                          <option value='2'>Female</option>
	                        </select>     </td>
						    <script  language="javascript">
						            document.frm.Gender.value="<%=strGender%>";
						        </script>
	                      <td height="25" class="label2">
						  <select name="meal" class="textBoxCss">
						  <%    //For Population of Meal Combo 
	                             strSql =   "SELECT MEAL_ID, MEAL_NAME FROM M_MEAL";
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
	                  <td height="25" class="label1">Passport  Information <SPAN   class=starcolour>*</SPAN></td>
	                </tr>
	                <tr>
	                  <td height="25"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                      <td width="16%"   class="label2">Passport Number<SPAN   class=starcolour></SPAN></td>
	                      <td width="16%" class="label2">Date of Issue </td>
	                      <td width="16%" class="label2">Date of Expiry </td>
	                      <td width="16%" class="label2">&nbsp; &nbsp;  &nbsp;Place of Issue</td>
	                      <td width="20%" class="label2">&nbsp; &nbsp; Age</td>
	                      <td width="20%" class="label2">Visa Required</td>
	                    </tr>
	                    <tr>
	                      <td><input type="text" name="passportNo" class="textBoxCss"   onKeyUp="return test1('passportNo',49, 'all')" maxlength="49"/>                      </td>
						   <script  language="javascript">
						   document.frm.passportNo.value="<%=strPassportNo%>";
						   </script>
	                      <td class="label2">                           <!-- strDOfIssue -->
						   <input name="passport_issue_date" type="text" class="textBoxCss" size="7" value="<%=strPassport_issue_date %>"    onFocus="javascript:vDateType='DD/MM/YYYY'" 
							onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" />
							
							 <a  onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"                 onclick="button_onclick(document.frm.passport_issue_date);" >
					       <IMG   height=15 alt=Calender src="images/calender.png?buildstamp=2_0_0"  width=18    ></a> 
	
						<!-- 	<a href="javascript:show_calendar('frm.passport_issue_date','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle">		</a>	 -->
	
						 <script  language="javascript">
						   document.frm.passport_issue_date.value="<%=strPassport_issue_date%>";
						   </script>
	
						  </td>
	                      <td class="label2"> 
	                                                                                                        <!-- strDOExpiry -->
						   <input name="passport_expire_date" type="text" class="textBoxCss" id="test2" size="7" value="<%=strPassport_expire_date%>" onFocus="javascript:vDateType='DD/MM/YYYY'" 
							onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" /> 
	
							 <a  onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"                 onclick="button_onclick(document.frm.passport_expire_date);" >
					       <IMG   height="15" alt=Calender src="images/calender.png?buildstamp=2_0_0"  width="18"    ></a> 
	
	                          <!-- 
							<a href="javascript:show_calendar('frm.passport_expire_date','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">	<img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>	 -->
	
							 <script  language="javascript">
						   document.frm.passport_expire_date.value="<%=strPassport_expire_date%>";
						   </script>
	
	                      <td class="label2">&nbsp;&nbsp;&nbsp;&nbsp; 
						  <input name="passport_issue_place" type="text" class="textBoxCss" size="15"    onKeyUp="return test1('passport_issue_place', 49, 'c')"  maxlength="49"  onfocus="FindAge();" /></td><!--   -->
	
						   <script  language="javascript">
						   document.frm.passport_issue_place.value="<%=strPassport_issue_place%>";
						   </script>
	                       <td>&nbsp; &nbsp;<input name="age" type="text" class="textBoxCss" size="22"      readonly onfocus="FindAge();" /></td>
	
						  <script  language="javascript">
						   document.frm.age.value="<%=strAge%>";
						   </script>
	                      <td height="25" class="label2">
							 Yes &nbsp;<input name="visa" type="radio" value="1" /> &nbsp;&nbsp;&nbsp;
	                         No  &nbsp; <input name="visa" type="radio"  checked="checked" value="2" /></td>
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
	                    <tr>
	                      <td>&nbsp;</td>
	                      <td class="label2">&nbsp;</td>
	                      <td class="label2">&nbsp;</td>
	                      <td class="label2">&nbsp;</td>
	                      <td>&nbsp;</td>
	                      <td class="label2">&nbsp;</td>
	                    </tr>
	                  </table></td>
	                </tr>
	                <tr>
	                  <td height="25"><table width="39%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                      <td width="58%" height="25" class="label2"><strong>Emigration Clearance Required</strong><SPAN   class=starcolour>*</SPAN></td>
	                      <td width="10%" class="label2"><div align="center">Yes</div></td>
	                      <td width="3%">
	                        <input name="ECR" type="radio" value="1" />                      </td>
	                      <td width="10%" class="label2"><div align="center">No</div></td>
	                      <td width="3%"><input name="ECR" type="radio" checked="checked"  value="2" /></td>
	
						  <script language ="javascript">
	                                 	var flag1   = '<%=strEcr%>';
										if(flag1 == 1)
										{
											document.frm.ECR[0].checked=true;
										}
										else
										{
											document.frm.ECR[1].checked=true;
										}
					
						</script>
	                    </tr>
	                  </table></td>
	                </tr>
	              </table></td>
	  </tr>
	  
	  <tr>
	    <td bgcolor="#FCF5F6"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" >
	
	        <tr>
	          <td class="label1">&nbsp;</td>
	        </tr>
	        <tr>
	          <td height="25" class="label1">Foreign Exchange Details</td>
	        </tr>
	          <tr>
	          <td height="25"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	              <td width="17%" height="25" class="label2">Expenditure Head </td>
	              <td width="17%" class="label2"><div align="center">Currency Preferences </div></td>
	              <td width="17%" class="label2"><div align="center">Expenditure Per Day </div></td>
	              <td width="12%" class="label2"><div align="center">Total Tour Days </div></td>
	              <td width="12%" class="label2"><div align="center">Total Forex </div></td>
	              <td width="25%" class="label2"><div align="center">Remarks</div></td>
	            </tr>
	            <tr>
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
	
	              <td height="25" class="label2">Daily Allowances <SPAN   class=starcolour>*</SPAN></td>
	              <td class="label2"><div align="center">
	
	                <select name="expCurrency" class="textBoxCss"   <%//=strComboDisable%> >
	                 <%  
					  if (strComboDisable.equals("disabled"))
						 {
					 			strSql = "SELECT distinct currency ,currency  FROM  T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID = "+strTravelId+"";	
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
	                             strSql =   "Select Currency, Currency from m_currency where status_id=10";
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
					   </div>
	                           <script language="javascript">
							 		        document.frm.expCurrency.value="<%=strTACurrency%>";
	                         </script>	</td>
					<%   ///CODE THAT SHOWS EXPENDITURE OF USER  
					  if(strTravelId!=null && !strTravelId.equals("") && strG_userID!=null &&  !strG_userID.equals("")  )
					    	{ 
		              			   strSql =   "SELECT     RTRIM(LTRIM(EXP_ID)) AS EXP_ID, RTRIM(LTRIM(CONVERT(decimal(20, 0), ENT_PER_DAY))) AS ENT_PER_DAY, RTRIM(LTRIM(TOTAL_TOUR_DAYS))    AS TOTAL_TOUR_DAYS, LTRIM(RTRIM(CONVERT(decimal(20, 0), TOTAL_EXP_ID))) AS TOTAL_EXP_ID, G_userid FROM   T_TRAVEL_EXPENDITURE_INT  WHERE     (TRAVEL_ID = "+strTravelId+") AND (EXP_ID = 1) AND (APPLICATION_ID = 1) AND (G_userid = "+strG_userID+")";
	          			            rs       =   dbConBean.executeQuery(strSql);  
									if(rs.next())
									{                       
									   strEntPerDay              =  rs.getString("ENT_PER_DAY");
									   strTotalTourDays          =  rs.getString("TOTAL_TOUR_DAYS");
									   strTotalExpId             =  rs.getString("TOTAL_EXP_ID");
									 /*  if(strEntPerDay !=null && strEntPerDay.trim().equals("0"))
									   {
										   strEntPerDay = "";
									   }
									   if(strTotalTourDays !=null && strTotalTourDays.trim().equals("0"))
									   {
										   strTotalTourDays = "";
									   }
									   if(strTotalExpId !=null && strTotalExpId.trim().equals("0"))
									   {
										   strTotalExpId = "";
									   } 
									   */
									}  
						    rs.close();
	                }
	         
					%>
	
	
	
	              <td class="label2"><div align="center">
	                <input name="entitlement" type="text" class="textBoxCss2" size="15"  maxlength="9" onChange="check1();"    value="<%=strEntPerDay%>" onKeyUp="return charactercheck(this,'n')"   align="right" />
	              </div></td>
	              <td class="label2"><div align="center">
	                <input name="tourDays" type="text" class="textBoxCss2" size="15"  maxlength="4" onChange="check1();" value="<%=strTotalTourDays%>"  onKeyUp="return charactercheck(this,'n')"  align="right"/>
	              </div></td>
	              <td class="label2"><div align="center">
	                <input name="totalForex" type="text" class="textBoxCss2" size="15"   onChange="check1();" onKeyUp="return charactercheck(this,'n')"  value="<%=strTotalExpId%>" align="right" />
	              </div></td>
	              <td rowspan="5" valign="top" class="label2">
	                <div align="center">
	                  <textarea name="expRemarks" rows="4"   onKeyUp="return test1('expRemarks',100, 'all')" ><%=strExpRemark%></textarea>
	                  </div>
					  <br />
					  <div class="label2" align="center">Please Specify the reason for Contingencies/Any Other Expenditure</div>				  </td>
	            </tr>
	           <%      
	 		          if(strTravelId!=null && !strTravelId.equals("") && strG_userID!=null &&  !strG_userID.equals("")  )
					    	{ 
	                               strSql =   "SELECT     RTRIM(LTRIM(EXP_ID)) AS EXP_ID, RTRIM(LTRIM(CONVERT(decimal(20, 0), ENT_PER_DAY))) AS ENT_PER_DAY, RTRIM(LTRIM(TOTAL_TOUR_DAYS))  AS TOTAL_TOUR_DAYS, LTRIM(RTRIM(CONVERT(decimal(20, 0), TOTAL_EXP_ID))) AS TOTAL_EXP_ID, G_userid FROM   T_TRAVEL_EXPENDITURE_INT  WHERE     (TRAVEL_ID = "+strTravelId+") AND (EXP_ID = 2) AND (APPLICATION_ID = 1) AND (G_userid = "+strG_userID+")";
	         
								   rs       =   dbConBean.executeQuery(strSql);  
			    		           if(rs.next())
	                                    {                       
										   strEntPerDay              =  rs.getString("ENT_PER_DAY");
										   strTotalTourDays          =  rs.getString("TOTAL_TOUR_DAYS");
										   strTotalExpId             =  rs.getString("TOTAL_EXP_ID");
	                                       /*
										   if(strEntPerDay !=null && strEntPerDay.trim().equals("0"))
										   {
											   strEntPerDay = "";
										   }
										   if(strTotalTourDays !=null && strTotalTourDays.trim().equals("0"))
										   {
											   strTotalTourDays = "";
										   }
										   if(strTotalExpId !=null && strTotalExpId.trim().equals("0"))
										   {
											   strTotalExpId = "";
										   }*/
						              }
						   rs.close();
			             }
	        
	%>
	            <tr>
	              <td height="25" class="label2">Hotel Charges<SPAN   class=starcolour></SPAN> </td>
	              <td class="label2"><div align="center"></div></td>
	              <td class="label2"><div align="center">
	                <input name="entitlement" type="text" class="textBoxCss2"  maxlength="9" onChange="check1();"size="15"  value="<%=strEntPerDay%>"  onKeyUp="return charactercheck(this,'n')"  align="right"/>
	              </div></td>
	              <td class="label2"><div align="center">
	                <input name="tourDays" type="text" class="textBoxCss2"  maxlength="4"  onChange="check1();"size="15"   value="<%=strTotalTourDays%>" onKeyUp="return charactercheck(this,'n')"   align="right"/>
	              </div></td>
	              <td class="label2"><div align="center">
	                <input name="totalForex" type="text" class="textBoxCss2"   onChange="check1();" size="15" value="<%=strTotalExpId%>"  onKeyUp="return charactercheck(this,'n')" align="right" />
	              </div></td>
	              </tr>   <%         
				  
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
	        
	%>
	            <tr>
	              <td height="25" class="label2">Contingencies</td>
	              <td class="label2"><div align="center"></div></td>
	              <td class="label2"><div align="center"></div></td>
	              <td class="label2"><div align="center"></div></td>
	              <td class="label2"><div align="center">
	                <input name="contingencies" type="text"    onChange="check1();" class="textBoxCss2" size="15" value="<%=strTotalExpId%>" onKeyUp="return charactercheck(this,'n')"  />
	              </div></td>
	              </tr>
	
				   <%         
				  
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
	        
	%>
	            <tr>
	              <td height="25" class="label2">Any Other Expenditure </td>
	              <td class="label2"><div align="center"></div></td>
	              <td class="label2"><div align="center"></div></td>
	              <td class="label2"><div align="center"></div></td>
	              <td class="label2"><div align="center">
	                <input name="contingencies" type="text"      onChange="check1();"      class="textBoxCss2" size="15" value="<%=strTotalExpId%>" onKeyUp="return charactercheck(this,'n')" align="right"  />
	              </div></td>
	              </tr>
	            <tr>
	              <td height="25" class="label2">&nbsp;</td>
	              <td class="label2">&nbsp;</td>
	              <td class="label2">&nbsp;</td>
	              <td class="starcolour"><div align="right">Total&nbsp;</div></td>
	              <td class="label2"><div align="center">
	                <input name="grandTotalForex" type="text" class="textBoxCss2"    onChange="check1();"size="15" value="<%=strTotalAmount%>" onKeyUp="return charactercheck(this,'n')"  align="right" />
	              </div></td>
	              </tr>
	            <tr>
	              <td height="25" class="label2">&nbsp;</td>
	              <td class="label2">&nbsp;</td>
	              <td class="label2">&nbsp;</td>
	              <td class="starcolour">&nbsp;</td>
	              <td >&nbsp;</td>
	              <td valign="top" class="label2">
	              <div align="center">
	
				  <% ///System.out.println("strwhatAction======"+strwhatAction);  %>
	                <input type="button" name="Submit" value="<%=strButtonCaption%>"  class="formButton" onclick="checkData(frm);" /><!-- onclick="checkData(frm);"  -->
	              </div></td>
	            </tr>
	          </table></td>
	        </tr>
	      </table></td>
	  </tr>
	  
	  <tr>
			     <td valign="top" bgcolor="#FDF9FA">
			     
	<table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" >
	        <tr>
	          <td height="25" class="label1">Group/Guest  Travelers  Detail</td> 
	        </tr>
	    
	
	        <tr> 
	          <td height="25">        
	          <table width="100%" border="1" cellpadding="1" cellspacing="1" bordercolor="#F6E0E3">       
	              <tr>
	                <td width="6%" height="25" class="label2"><div align="center"><strong>S No. </strong></div></td>
	                <td width="13%" class="label2"><div align="left"><strong>&nbsp;Traveler Name </strong></div></td>
	                
	                <td width="15%" class="label2"><div align="center"><strong>Designation</strong></div></td>
	                <td width="10%" class="label2"><div align="center"><strong>Date of Birth</strong></div></td>
	                <td width="18%" class="label2"><div align="center"><strong>Age</strong></div></td>
	                <td width="8%" class="label2"><div align="center"><strong>Gender</strong></div></td>
	                <td width="10%" class="label2"><div align="center"><strong>Meal  Pref.</strong></div></td>
	                <td width="10%" class="label2"><div align="center"><strong>Total Forex</strong></div></td>
	                <td width="13%" class="label2"><div align="center"><strong>Action</strong></div></td>
	              </tr>
	              <tr> 
	                <td height="25" class="label2">&nbsp;</td>
	                <td class="label2">&nbsp;</td>

	                <td class="label2"><div align="center"><strong>Passport No </strong></div></td>
	                <td class="label2"><div align="center"><strong>Date of Issue </strong></div></td>
	                <td class="label2"><div align="center"><strong>Date of Expiry</strong></div></td>
	                <td class="label2"><div align="center"><strong>Place of Issue</strong></div></td>
	                <td class="label2"><div align="center"><strong>Visa Required</strong></div></td>
	                <td class="label2"><div align="center"><strong>ECR</strong></div></td>
	                <td class="label3">&nbsp;</td>
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
				         " TOTAL_AMOUNT,  PASSPORT_NO,  ISNULL(dbo.CONVERTDATEDMY1(DATE_OF_ISSUE),'-') AS DATE_OF_ISSUE, "+
				         " PLACE_OF_ISSUE,  ISNULL(dbo.CONVERTDATEDMY1(EXPIRY_DATE),'-') AS EXPIRY_DATE,  ECNR,  VISA_REQUIRED,isnull(Return_travel,'n') as Return_travel "+
 				         " FROM     T_GROUP_USERINFO  WHERE   (TRAVEL_ID = "+strTravelId+" ) and travel_type='i' and STATUS_ID=10 order by FIRST_NAME"; 
				  
				   
	
	                  
				 
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
												else
												{
												strEcnr="No";
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
	                               %> 
	  				  <tr>   
	                <td height="25" class="label2"><div align="center"><%=intSerialNo%>. <input type="checkbox" name="userids" value=<%=strG_userid%>  <%=strchecked %> ><font color="#CC3300" size=1><b>#</b></font> </div></td> 
	                <td class="label2"><div align="left"> &nbsp;<%=strFirstName_List%>  <%=strLastName_List%> </div> 
	                
	                                    
	                 
	                
	                </td>  
	                <td class="label2"><div align="center"><%=strDesigantion_List%><br /> 
					
	                 <%=strPassortNo_list%></div></td>
	                <td class="label2"><div align="center"><%=strDateOfBirth_List%><br />
	                  <%=strDateofIssue_list%></div></td>
	                <td class="label2"><div align="center"><%=strAge_List%><br />
	                <%=strDateofExpiry_list%></div></td>
	                <td class="label2"><div align="center"><%=strSex%><br />
	                  <%=strPlacesofIssue_list%></div></td>
	                <td class="label2"><div align="center"><%=strMealPref_list%><br />
	                 <%=strVisaReqiured_list%></div></td>
	                <td class="label2"><div align="center"> <%=strCurrency%> <%=strTotalForex_list%><br />
	                 <%=strEcnr%> </div></td> 
	                <td class="label2">
						  
					  <div align="center"><!--  Added a travel type on domestic group travel  development on 02-Jul-08 by shiv sharma   -->
						   <a href="Group_T_IntTrv_Details.jsp?G_userId=<%=strG_userid%>&travelId=<%=strTravelId%>&action=update" onClick="return">  EDIT</a> | <a href="G_userDelete.jsp?G_userId=<%=strG_userid%>&travel_id=<%=strTravelId%>&travel_type=i" onClick="return  deleteConfirm();">DELETE </a></div></td>
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
        strTexttoShowtraveler="<font color=#CC3300>#</font>Please add traveler in traveler list to proceed for next page";
        
	   }else{
		   strTexttoShow="<font color=#CC3300>#</font>Select the check box for opting return journey";    
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
   		String 	strDepCity="";
   		String 	strArrCity="";
   		String  strDepDate="";
   		String  strPreferTime=""; 
   		String  strNameOfAirline ="";
   		String  strTravelMode ="";
   		String  strTravelClass ="";
   		String  strSeatPreffered  ="";   
   		
   		
   		if(!strTravelId.equals("") && !strTravelId.equals("new") && strTravelId!=null ){  
   		strSql ="SELECT     t1.TRAVEL_ID, t2.site_id as site_id , t1.TRAVEL_FROM AS TRAVEL_FROM, t1.TRAVEL_TO AS TRAVEL_TO, "+
		   		" dbo.CONVERTDATEDMY1(t1.TRAVEL_DATE) AS TRAVEL_DATE,	t1.TRAVEL_MODE AS TRAVEL_MODE, t1.MODE_NAME AS MODE_NAME, "+ 
		   		" t1.TRAVEL_CLASS AS TRAVEL_CLASS,t1.TIMINGS AS TIMINGS,  t2.REASON_FOR_TRAVEL AS REASON_FOR_TRAVEL,"+ 
		   		" t2.REASON_FOR_SKIP AS REASON_FOR_SKIP, ISNULL(t2.BILLING_SITE, '-1') AS BILLING_SITE, "+           
		   		" ISNULL(t2.BILLING_CLIENT, '-1') AS BILLING_CLIENT, ISNULL(t2.MANAGER_ID,0) AS MANAGER_ID," + 
		   		" ISNULL(t2.HOD_ID,0)  AS HOD_ID,	isnull(t2.CASH_BREAKUP_REMARKS,'') as  CASH_BREAKUP_REMARKS,isnull(t1.SEAT_PREFFERED,'1') as SEAT_PREFFERED  FROM   "+
		   		" T_JOURNEY_DETAILS_INT t1 INNER JOIN T_TRAVEL_DETAIL_INT t2 ON t1.TRAVEL_ID = t2.TRAVEL_ID  WHERE "+ 
		   		" (t1.TRAVEL_ID = "+strTravelId+") AND (t1.APPLICATION_ID = 1) AND (t1.STATUS_ID = 10) AND (t2.STATUS_ID = 10) "; 
   		
		    
   		
        String strSite_id="";
        rs       =   dbConBean.executeQuery(strSql);   

         while(rs.next())
         {  
			    strSite_id         =rs.getString("site_id");  
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
					strPreferTime="1";
				}
			      strSeatPreffered     =  rs.getString("SEAT_PREFFERED");

          }
         rs.close();
   	} 
   		
		%>
	</table>   
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">  
		            <tr>
			          <TD class=formfirstfield vAlign=bottom align=left  
		                		bgColor=#fdf9fa colSpan=2 height=25>Itinerary Information  <%//=strMessage %> </TD>
		                		</TR>
		            <tr>
		            <td>  
		            
		            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FDF9FA" > 
	                <tr class=formtxt>
	                  <td height="25" class="label1">Forward Journey   
	                  <SPAN  class=starcolour>*</SPAN></td>
	                </tr>
	                
	                <tr>
	                  <td height="25"> 
					  <table width="99%" border="0" cellspacing="0" cellpadding="0">   
	                    <tr>
	                      <td width="16%" class="label2">&nbsp; &nbsp; &nbsp;Departure City <SPAN  
	                      class=starcolour></SPAN> </td>
	                      <td width="16%" class="label2">Arrival City <SPAN  
	                      class=starcolour></SPAN> </td>
	                      <td width="16%" class="label2">Departure Date</td>
	                      <td width="10%" class="label2">Preferred Time</td>
	                      </tr> 
	                    <tr>
	                      <td height="25">&nbsp; &nbsp; &nbsp;<input type="text" name="depCity" class="textBoxCss"   value="<%=strDepCity%>"  onKeyUp="return test1('depCity', 30, 'c')" maxlength="30" />         <!--   -->             </td>
	
							 <script language="javascript">
	                              document.frm.depCity.value="<%=strDepCity%>";
	                        </script>	
	                      <td class="label2"><input type="text" name="arrCity" class="textBoxCss"   value="<%=strArrCity%>"   onKeyUp="return test1('arrCity', 30, 'c')" maxlength="30"/></td>
	  						 <script language="javascript">
	                              document.frm.arrCity.value="<%=strArrCity%>";
	                        </script>	
	
	                      <td class="label2">
	                      <table width="60%" border="0" cellspacing="0" cellpadding="0">
	                          <tr>
	                            <td><!--Reaching Date at Destination-->
						<input name="depDate" type="text" class="textBoxCss" id="test2" size="6" value="<%=strDepDate%>" onFocus="javascript:vDateType='DD/MM/YYYY'" 	onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter');" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" /> 
	
						 <a  onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"                 onclick="button_onclick(document.frm.depDate);" >
					       <IMG   height=15 alt=Calender src="images/calender.png?buildstamp=2_0_0"  width="18"    ></a> 
							
							
							<!-- <a href="javascript:show_calendar('frm.depDate','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
							<img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a> -->		</td>
	                          </tr>
	                        </table></td> 
							<script language="javascript"> 
	                              document.frm.depDate.value="<%=strDepDate%>";
	                        </script>	
	                      <td> 
	                       <select name="preferTime" class="textBoxCss">
							<%
	                        //For Population of Prefer Timing Combo 
	                             strSql =   "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME WHERE STATUS_ID=10 AND APPLICATION_ID=1";
	                             rs       =   dbConBean.executeQuery(strSql);  
	                             while(rs.next())
	                             {
									%>
	                              <option value="<%=rs.getString("TIME_ID")%>"><%=rs.getString("PREFER_TIME")%></option>
									<%
	                         	 }
	                             rs.close();	  
							%>
	                        </select>
	                        <script language="javascript">
	                        var pftime='<%=strPreferTime%>';
	                          if(pftime==''){
	                            document.frm.preferTime.value="1"; 
	                            }else{
	                            document.frm.preferTime.value="<%=strPreferTime%>";
	                            }
	                        </script>		          </td>
	                      </tr>
	                  </table></td>
	                </tr>
	               <!--  <tr>
	                  <td class="label1">&nbsp;</td> 
	                </tr> -->
	                <tr>
	                  <td height="25"> 
					    <table width="100%" border="0" cellspacing="0" cellpadding="0">                
	                    <tr>
	                      <td width="20%"   class="label2"><!-- Mode1 --></td> 
	                      <td width="21%" class="label2">&nbsp;Preferred Airlines</td>  
	                      <td width="18%" class="label2">Class</td>
	                      <td width="16%" class="label2"> &nbsp; &nbsp; &nbsp; &nbsp; Preferred Seat</td>
	                      </tr>
	                    <tr>
	                      <td height="25"><!-- Code commented by shiv on 07 jan 2009 for not showing travel mode as requested by MATA    -->
	                              <!--   <select name="travelMode"  class="textBoxCss">
	                                          <option value="1" selected="selected">Air</option>
	                                          <option value="2">Train</option>
	                                            </select>
							<script language="javascript">
	                            //document.frm.travelMode.value="<%//=strTravelMode%>"; 
	                        </script>				                 
	                         --> </td>
	                      <td class="label2">&nbsp;<input type="text" name="nameOfAirline" class="textBoxCss"   value="<%=strNameOfAirline %>"  onKeyUp="return test1('nameOfAirline', 30, 'cn')" maxlength="30" /></td>
	
						   <script language="javascript">
	                              document.frm.nameOfAirline.value="<%=strNameOfAirline%>"; 
	                        </script>	
	                      <td class="label2">
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
	                      <td>  &nbsp; &nbsp; &nbsp; &nbsp;  
	                 	  <select name="seatpreference" class="textBoxCss">  
						  					  <%                
	                     //For Population of Travel Class Combo For Departure  
						        
							          strSql =   "SELECT  seat_id, Seat_Name FROM  M_SEAT_PREFER WHERE  mode_id=1 and (STATUS_ID = 10)";
	                           
										   rs       =   dbConBean.executeQuery(strSql);  
										   while(rs.next())
										   {
													%>
											 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
													<% 
										   }
										   rs.close();	
										   dbConBean.close();
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
	                        </script> 
	                      
	                      </tr> 
	                      <% if(strButtonstate.equals("2")){ %>
	                      
	                    <tr>  
	                
	                       <td height="5"  colspan="9" class="label2"  align="right" ><font color="#CC3333" > Kindly Add Traveler(s) Before Proceeding To Next    
	                       &nbsp;&nbsp;  
	        	           </td>         
	                </tr>
	                <%} %>
	              </table></td>        
	         </tr>
	       
	 
		               <tr>  
	                	<td>    
	               			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="newformbot" > 
	        	                 
	        	                
	        	                 
	        	                 <tr height="8">  
	        	                      <td colspan="9">   
	    					              <div align="right"> 
	    					                 <input type="button" name="Submit4" value="   Exit    "    class="formButton"  onClick="return ExitPage(this.form);"/>
						                    <input type="button" name="Submit5" value="   Save    "   class="formButton" <%=strButtonstate1%>   onClick="return save(this.form);"/>
										    <input type="button" name="Submit2" value="   Next    "   class="formButton"     <%=strButtonstate1%>    onClick="return NextPage(this.form,'<%=strButtonstate%>');" /> 
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
	    </tr>
	    </table>
	    </td>
	    </tr>
	    </table>
	    </td>
	    </tr>
	    </table>
	    </form>
	    </html>
	    
	