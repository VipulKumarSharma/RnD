<%/************************************************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Abhinav Ratnawat
 *Date of Creation 		:11 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:
 *Modification 	    	:1.Change the display fuctionality.
                                 2. Added  Prefered time for immediate destination  journey on  26-Oct-07 By Shiv Sharma    
                                    
 *Reason of Modification: change suggested by MATA
 *Date of Modification  :14 Nov 2006 
 *Modified By	        :SACHIN GUPTA                       
 *Editor				:Editplus
 
 *Date of Modification  :07 Oct 2011
 *Modified By			:Manoj Chand
 *Modification			:modify the designing of this page.
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :03 Dec 2012
 *Description			:Correct the order of intermediate destination.
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :01 Feb 2013
 *Description			:IE Compatibility Issue resolved
 *********************************************************************************************/
%>
<%@ include  file="importStatement.jsp" %> 
<%@ page buffer="5kb" language="java"
	import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*,java.text.*" pageEncoding="UTF-8"%>
<HTML>
<HEAD>

<%-- include remove cache  --%>
<%@ include file="cacheInc.inc"%>
<%-- include header  --%>
<%@ include file="headerIncl.inc"%>
<%-- include page with all application session variables --%>
<%@ include file="application.jsp"%>
<%-- include page styles  --%>
<%--<%@ include  file="systemStyle.jsp" %>--%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<%		request.setCharacterEncoding("UTF-8");	
			ResultSet rs 			= null;
			String strSql 			= null;
			String strMode			= "";
			String strDCity			= "";	
			String strACity			= "";
			String strDDate			= "";
			String strAirline		= "";
			String strInterimId		= "";

			String strAcualTravelId = "";
			String strUpdateFlag    = "";
			String strPreferTimeIntermediate="";

			strAcualTravelId        =  request.getParameter("actualTravelId");
			if(strAcualTravelId != null && !strAcualTravelId.equals("null") && !strAcualTravelId.equals("") && !strAcualTravelId.equals("new"))
			{
				strUpdateFlag = "yes";     
			}
			else
				strUpdateFlag = "no"; 
 				
			strDCity				=	request.getParameter("strDeptCity")== null ? "" :request.getParameter("strDeptCity");
			strACity				=	request.getParameter("strArrCity") == null ? "" :request.getParameter("strArrCity");
			strDDate				=	request.getParameter("strDeptDate")== null ? "" :request.getParameter("strDeptDate");
			strAirline				=	request.getParameter("strAirlineName") == null ? "" : request.getParameter("strAirlineName");
			strMode 			    =   request.getParameter("strMode") == null? "1":request.getParameter("strMode");
			strInterimId			=	request.getParameter("interimTravelId") == null ? "":  request.getParameter("interimTravelId") ;

		 // get the current date for checking the departureDate 
		  java.util.Date currentDate = new java.util.Date();
		  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		  String strCurrentDate = (sdf.format(currentDate)).trim();

          ///Added prefered time  in intermmidiate  journey     ----by shiv sharma 25-Oct-07   
		   strPreferTimeIntermediate          =   request.getParameter("preferTimeInterMediate")==null?"1":request.getParameter("preferTimeInterMediate");
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<SCRIPT language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
 
<script>
function MM_openBrWin(theURL,winName,features)
 { 
		   window.open(theURL,winName,features);
 }
 </script>
<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">
<script language="JavaScript">

		function SubmitForm() {
			document.frm.action = "InterimJourney_Dom.jsp";
			document.frm.submit();
		}

		function checkData(f1) 
		{
			
			if (document.frm.strDeptCity.value == ""){
				alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage) %>');
				document.frm.strDeptCity.focus();
				return false;
			}

			if (document.frm.strArrCity.value == ""){
				alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage) %>');
				document.frm.strArrCity.focus();
				return false;
			}

			if (document.frm.strDeptDate.value == ""){
				alert('<%=dbLabelBean.getLabel("alert.global.departuredate",strsesLanguage) %>');
				document.frm.strDeptDate.focus();
				return false;
			}

			if (document.frm.strAirlineName.value == ""){
				alert('<%=dbLabelBean.getLabel("alert.global.preferredairlinetraincab",strsesLanguage) %>');
				document.frm.strAirlineName.focus();
				return false;
			}



			    var todayDate  =  document.frm.todayDate.value;               // for current page
				var depDate    =  document.frm.strDeptDate.value;				// for current page
				var openerPageDepDate = window.opener.frm.departDate.value;       //parent page departure date
				var openerPageReturnDate = window.opener.frm.returnDate.value;	  //parent page return date	
													
				var flag = checkDate(f1,todayDate,depDate,document.frm.todayDate,document.frm.strDeptDate,'<%=dbLabelBean.getLabel("alert.global.departuredatecannotsmallerthantodaydate",strsesLanguage) %> ','<%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %>');
				if(flag == false) 
				{
				  return flag;
				}
				
				if(openerPageDepDate != null && openerPageDepDate != "")
				{
					flag = checkDate(f1,openerPageDepDate,depDate,document.frm.strDeptDate,document.frm.strDeptDate,'<%=dbLabelBean.getLabel("message.createrequest.group.intermediatedeparturedatecannotbesmaller",strsesLanguage) %>','<%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %>');
					if(flag == false) {
					  return flag;
					}
				}
				if(openerPageReturnDate != null && openerPageReturnDate != "")
				{
					var flag = checkDate(f1,depDate,openerPageReturnDate,document.frm.strDeptDate,document.frm.strDeptDate,'<%=dbLabelBean.getLabel("message.createrequest.group.intermediatedeparturedatecannotbegreater",strsesLanguage) %>','<%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %>');
					if(flag == false) {
					  return flag;
					}
				}
			return true;
		}


		function test1(obj1, length, str)
		{	
			var obj;

			if(obj1=='strDeptCity')
			{
				obj = document.frm.strDeptCity;
			}

			if(obj1=='strArrCity')
			{
				obj = document.frm.strArrCity;
			}

			if(obj1=='strAirlineName')
			{
				obj = document.frm.strAirlineName;
			}

			charactercheck(obj,str);
			limitlength(obj, length);
			//zeroChecking(obj); //function for checking leading zero and spaces
			spaceChecking(obj);
		}

	function closeWindow(frm){
		
		 if(document.frm.strDeptCity.value!='' || document.frm.strArrCity.value!='' || document.frm.strDeptDate.value!=''  || document.frm.strAirlineName.value!='')
	           	{ alert('<%=dbLabelBean.getLabel("alert.createrequest.fillallfields_pressadd",strsesLanguage) %>'); 
                  checkData(frm); 
				 return false;
		             }
               
			window.opener.setId("<%= strInterimId%>");  
			window.opener.frm.action = "T_TravelDetail_Dom.jsp";
			window.opener.frm.submit();
			window.close();							
		}

function funConf()
{
if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage) %>'))
	{
		return true;
	}
	else
	{
		return false;
	}
}

function checkDate(form1,firstDate,secondDate,firstDateName,secondDateName,message1,message2)
{

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
</script>


</head>
<body> 
<form name="frm"  method="post" action="InterimJourney_Dom_Post.jsp">
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="77%" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.requestdetails.domesticintermediatedestinations",strsesLanguage) %></li>
    </ul></td>	
  </tr>
</table>
<div align="center">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      
      <td width="14" background="images/index_03.png?buildstamp=2_0_0"></td>
    </tr>
    
      </table> 
   <table border="0" width="98%"> 
   <!-- <tr>
      <td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
      <td height="20" colspan="2" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
      <td width="3" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
    </tr>   --> 
    <tr>
      <td height="20">&nbsp;</td>
      <td height="20" colspan="2"><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
          <td height="29" align="left" background="images/headerBG.png?buildstamp=2_0_0"><img src="images/formTitIcon.png?buildstamp=2_0_0" width="30" height="29" align="absmiddle" /><span class="formTit"><%=dbLabelBean.getLabel("label.global.intermediatedestinations",strsesLanguage)%></span></td>
        <td align="left" background="images/headerBG.png?buildstamp=2_0_0"><img src="images/help.png?buildstamp=2_0_0" width="44" height="16" border="0" align="right" onClick="MM_openBrWin('helpintrimjourneydomestic.html#100a','','scrollbars=YES,resizable=no,location=no,directories=no,toolbar=no,menubar=no,left=10,top=10,width=800,height=350,status=no,location=no')" /></td>
            <br>
            <td background="images/index_03.png?buildstamp=2_0_0"></td>
          </tr>
          <tr>
            <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
            <td colspan="2" valign="top" bgcolor="#ffffff">
			  <table width="100%" border="1" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="0" bgcolor="#ffffff">
				    <table width="98%" border="0" cellspacing="0" cellpadding="0">
                  <!--ITINERARY INFORMATION -->
                  <tr>
                    <td width="2%" align="left" valign="bottom" class="label1">&nbsp;</td>
                    <td width="27%" height="25" align="left" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %></td>
                    <td width="33%" height="25" align="left" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %></td>
                    <td width="19%" align="left" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %> </td> 
					<td width="19%" align="left" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %> </td><!--   25-02-2007 by shiv sharma  -->
                  </tr>
                  <tr>
                    <td align="left" valign="top">&nbsp;</td>
                    <td height="25" align="left" valign="top"><input name="strDeptCity" type="text" class="textBoxCss" size="22"  value = "<%= strDCity %>" onKeyUp="return test1('strDeptCity', 30, 'c')" maxlength="30" /></td>
                    <td align="left" valign="top"><span class="label2">
                      <input name="strArrCity" type="text" class="textBoxCss" size="22" value="<%=strACity %>" onKeyUp="return test1('strArrCity', 30, 'c')" maxlength="30" />
                    </span></td>
                    <td align="left" valign="top"><input name="strDeptDate" type="text" class="textBoxCss" id="test2" size="7" onFocus="javascript:vDateType='DD/MM/YYYY'"
				onkeyup="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
				onblur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
				onchange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" />
                        <a href="javascript:show_calendar('frm.strDeptDate','a','a','DD/MM/YYYY');"
				onmouseover="window.status='Date Picker';return true;"
				onmouseout="window.status='';return true;"><img src="images/calender.png?buildstamp=2_0_0"
				name="imageField" border="0" align="absmiddle" id="imageField" /></a>
             
                <script language="JavaScript" type="text/javascript">
					document.frm.strDeptDate.value = "<%= strDDate %>";
				  </script>				  </td>

				  <td align="left" valign="top" >   <!-- added for prefered time  on 26-Oct-07 by Shiv  Sharma  -->
				     <select name="preferTimeInterMediate"  class="textBoxCss">
 						<%
						 	 
								strSql =   "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY DISPLAY_ORDER ASC";
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
                            document.frm.preferTimeInterMediate.value="<%=strPreferTimeIntermediate%>";
                        </script>					  </td>
                     
				  
				   
                  </tr>
                  <tr>
                    <td align="left" valign="bottom" class="label1">&nbsp;</td>
                    <td height="20" align="left" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.mode",strsesLanguage) %></td></td>
                    <td height="20" align="left" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.preferredairlinetraincab",strsesLanguage) %></td></td>
                    <td height="20" align="left" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
                     <td height="20" align="left" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="label2">&nbsp;</td>
                    <td height="25" align="left" valign="top" class="label2"><select name="strMode"   class="textBoxCss" onChange="javascript:SubmitForm();">
                        <option  value ="1" selected="selected"><%=dbLabelBean.getLabel("label.global.air",strsesLanguage) %></option>
                        <option value="2"><%=dbLabelBean.getLabel("label.global.train",strsesLanguage) %></option>
                        <option value="3" ><%=dbLabelBean.getLabel("label.global.cab",strsesLanguage) %></option>
                    </select>
					</td>
					<script language = "JavaScript">
						document.frm.strMode.value = <%= strMode%>;
				    </script>
					<td height="25" align="left" valign="top" class="label2"><input name="strAirlineName" type="text" class="textBoxCss" size="22" value="<%= strAirline %>" onKeyUp="return test1('strAirlineName', 16, 'cn')" maxlength="30" /></td>
                    <td height="25" align="left" valign="top" class="label2"><select name="strClass" class="textBoxCss">
                        <% if (strMode.equals("1")) 
							strSql = "SELECT AIR_ID, ELIGIBILITY FROM M_AIRLINE_CLASS WHERE STATUS_ID=10";
							if (strMode.equals("2"))							
	                        strSql =   "SELECT TRAIN_ID, ELIGIBILITY FROM M_TRAIN_CLASS WHERE STATUS_ID=10";
							if (strMode.equals("3"))							
		                    strSql =   "SELECT CAB_ID, ELIGIBILITY FROM M_CAB_CLASS WHERE STATUS_ID=10";
							rs = dbConBean.executeQuery(strSql);
							while (rs.next()) {
						
						%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%
                           }
		                      rs.close();	  
						%>
                    </select></td>
                     <!-- added for showing seat prefference on 08 jan 2009 -->
                     
                    <td height="25" align="left" valign="top" class="label2">
                    <select name="strSeatPrefer" class="textBoxCss">
                        <% 	
                            strSql ="SELECT seat_id, Seat_Name	FROM M_SEAT_PREFER  WHERE  (Mode_id = "+strMode+") AND (TRAVEL_AGENCY_ID = 1) and   (STATUS_ID = 10) ORDER BY SEAT_ID"; 
                        
							rs = dbConBean.executeQuery(strSql);
							while (rs.next()) {
						
						%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%
                           }
		                      rs.close();	  
						%>
                    </select></td>
                    <script language = "JavaScript">
						//document.frm.strSeatPrefer.value = <%= strMode%>;
				    </script>
                    
                     
                    
                    
                    
                  </tr>

				  

                  <tr>
                    <td height="25" colspan="6" align="center" valign="top" class="label2"><input name="add" type="submit" class="formbutton"  value="<%=dbLabelBean.getLabel("label.global.add",strsesLanguage) %>" onclick ="return checkData(this.form);"/></td>
                    <br>
</tr>
				
                </table></td>
              </tr>
          </table></td>
          <td width="11" background="images/index_03.png?buildstamp=2_0_0"></td>
        </tr>
        <tr>
          <td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
          <td height="20" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
          <td width="11" height="20" background="images/index_05.png?buildstamp=2_0_0"></td>
        </tr>
      </table></td>
      <td height="20"></td>
    </tr>
    <tr>
      <td height="20">&nbsp;</td>
      <td height="20" colspan="2"><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
          <td height="29" align="left" background="images/headerBG.png?buildstamp=2_0_0"><img src="images/formTitIcon.png?buildstamp=2_0_0" width="30" height="29" align="absmiddle" /><span class="formTit"><%=dbLabelBean.getLabel("label.global.intermediatedestinationsdetails",strsesLanguage) %> </td>
          <td background="images/index_03.png?buildstamp=2_0_0"></td>
        </tr>
        <tr>
          <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
          <td valign="top" bgcolor="#ffffff"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="0" bgcolor="#ffffff"><table width="100%" border="0" cellspacing="1" cellpadding="3">
                    <tr class="formtr2">
                      <td class="formhead" nowrap="nowrap"><b><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></b></td>
                      <td class="formhead"><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %></td>
                      <td class="formhead"><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %> </td>
                      <td class="formhead"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %> </td> 
					  <td class="formhead"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %> </td> 
					  <!-- 25-02-2007 -->
					  <td class="formhead"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %> </td> 
                      <td class="formhead"><%=dbLabelBean.getLabel("label.global.mode",strsesLanguage) %></td>
                      <td class="formhead"><%=dbLabelBean.getLabel("label.global.preferredairlinetraincab",strsesLanguage) %> </td>
                      <td class="formhead"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %> </td>
                      <td class="formhead"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage) %> </td>
                    </tr>

			<% 
			//query changed by manoj chand on 03 dec 2012 to display intermediate details in ordering
			if(strUpdateFlag.equals("yes"))
			{
				strSql = "SELECT TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(TRAVEL_DATE)AS TRAVEL_DATE,DBO.TIMENAME(TIMINGS)AS TIMENAME, seat_name as SEAT_PREFFERED,.DBO.TRAVEL_MODE_NAME(TRAVEL_MODE) AS TRAVELMODENAME, MODE_NAME,.DBO.TRAVEL_CLASS_NAME(TRAVEL_MODE,TRAVEL_CLASS) AS TRAVELCLASSNAME ,JOURNEY_ORDER FROM T_JOURNEY_DETAILS_DOM left outer JOIN  M_SEAT_PREFER ON  T_JOURNEY_DETAILS_DOM.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_JOURNEY_DETAILS_DOM.JOURNEY_ORDER>1 AND  T_JOURNEY_DETAILS_DOM.TRAVEL_ID='"+strAcualTravelId+"' AND T_JOURNEY_DETAILS_DOM.STATUS_ID=10 AND T_JOURNEY_DETAILS_DOM.APPLICATION_ID = 1 ORDER BY year(travel_date),month(travel_date),day(travel_date)";
				  //System.out.println("query 1 is"+strSql);
			}
			else
			{
				strSql = "SELECT TRAVEL_FROM, TRAVEL_TO,TRAVEL_DATE,DBO.TIMENAME(TIMINGS)AS TIMENAME,seat_name as SEAT_PREFFERED,.DBO.TRAVEL_MODE_NAME(TRAVEL_MODE) AS TRAVELMODENAME, MODE_NAME,.DBO.TRAVEL_CLASS_NAME(TRAVEL_MODE,TRAVEL_CLASS) AS TRAVELCLASSNAME, INTERIM_ID,PARENT_ID FROM  T_INTERIM_JOURNEY left outer JOIN  M_SEAT_PREFER ON  T_INTERIM_JOURNEY.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_INTERIM_JOURNEY.PARENT_ID ='"+strInterimId+"' AND T_INTERIM_JOURNEY.APPLICATION_ID = 1 ORDER BY year(convert(datetime,TRAVEL_DATE,103)),month(convert(datetime,TRAVEL_DATE,103)),day(convert(datetime,TRAVEL_DATE,103))";
				 //System.out.println("query 2 is"+strSql);
			}
			int sno=0;
				rs = dbConBean.executeQuery(strSql);
				while (rs.next()) {
				%>
                    <tr class="formtr2">
                      <td width="2%" class="formtr1"><%=++sno %></td>
                      <td class="formtr1"><%= rs.getString("TRAVEL_FROM")%></td>
                      <td class="formtr1"><%= rs.getString("TRAVEL_TO")%></td>
                      <td class="formtr1"><%= rs.getString("TRAVEL_DATE")%></td>
					  <td class="formtr1"><%= rs.getString("TIMENAME")%></td>    <!-- added for prefered time BY Shiv Sharma on 26-Oct-07     -->                      
					   <td class="formtr1"><%= rs.getString("SEAT_PREFFERED")%></td>
                      <td class="formtr1"><%= rs.getString("TRAVELMODENAME")%></td>
                      <td class="formtr1"><%= rs.getString("MODE_NAME")%></td>
                      <td class="formtr1"><%= rs.getString("TRAVELCLASSNAME")%></td>
                      <td class="formtr1" onClick="return funConf();"> 
						<%
					if(strUpdateFlag.equals("yes"))
					{
							%>
							<A HREF="T_DeleteInterim_Dom.jsp?actualTravelId=<%=strAcualTravelId%>&journeyOrder=<%=rs.getString("JOURNEY_ORDER")%>&travelType=D"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %> </A>
            			    <%
					}
					else
					{
							%>
				   			 <A HREF="T_DeleteInterim_Dom.jsp?interimID=<%= rs.getString("INTERIM_ID") %>&travelID=<%=rs.getString("PARENT_ID")%>"> <%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %> </A>
							<%
					}
			%>

					  </td>
                    </tr>
				<% 
				 }
				 rs.close();
				%>
				
                </table></td>
              </tr>
              <tr>
                <td align="center" bgcolor="#ffffff" class="newformbot"><span class="label2">
                  <input name="add2" type="button" class="formbutton"  value="<%=dbLabelBean.getLabel("button.global.saveandclose",strsesLanguage) %>" onclick ="closeWindow();"/>
                </span></td>
              </tr>
          </table></td>
          <td width="11" background="images/index_03.png?buildstamp=2_0_0"></td>
        </tr>
        <tr>
          <td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
          <td height="20" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
          <td width="11" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
        </tr>
      </table></td>
      <td height="20"></td>
    </tr>
   </table>
<INPUT type = "hidden" name = "travel_id" value="<%= strInterimId%>"/>
<input type="hidden" name="todayDate" value="<%=strCurrentDate%>"/> <!--  HIDDEN FIELD  -->
<INPUT TYPE = "hidden" name = "interimTravelId" value = "<%= strInterimId %>" />

<INPUT TYPE = "hidden" name = "actualTravelId" value = "<%= strAcualTravelId %>" />

</div>
</form>
</body>
 
</html>
