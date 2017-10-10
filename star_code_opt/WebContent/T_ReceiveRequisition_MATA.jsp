	<%
	/***************************************************
	*Copyright (C) 2000 MIND 
	*All rights reserved.
	*The information contained here in is confidential and 
	*proprietary to MIND and forms the part of the MIND 
	*CREATED BY		:	Vijay Singh
	*Date			:   30/Mar/2007
	*Description	:	first Screen for APPROVAL
	*Modified By	:	****************
	*Project		: 	STAR
	
	*Modified By			:Manoj Chand
	*Date of Modification	:21 feb 2012
	*Modification			:Resolve scripting error coming while approving request by mata final. 
	**********************************************************/
	%>
	
	
	<html>
	<head>
	<%@ page pageEncoding="UTF-8" %>
	<%@ include file="importStatement.jsp" %>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<%-- include page styles  --%>
	<%-- <%@ include  file="systemStyle.jsp" %> --%>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
		<SCRIPT language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></SCRIPT>
	 <jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	 
	<Script>
	function isLegal(txt) {
	var invalids = "~";
	for(i=0; i<invalids.length; i++) {
	if(txt.indexOf(invalids.charAt(i)) >= 0 ) {
	return false;
	}
	        }
	return true;
	}
	</Script>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	function typeData()
	{
	document.frm.COMMENTS.value='<%=dbLabelBean.getLabel("label.mata.receivedby",strsesLanguage) %> <%=sUserFirstName%> <%=sUserLastName%>';
	}
	
	function typeData1()
	{
	document.frm.COMMENTS.value='<%=dbLabelBean.getLabel("label.mata.confirmedby",strsesLanguage) %> <%=sUserFirstName%> <%=sUserLastName%>';
	}
	
	function typeData2()
	{
	document.frm.COMMENTS.value='<%=dbLabelBean.getLabel("message.approverequest.rejectedby",strsesLanguage) %> <%=sUserFirstName%> <%=sUserLastName%>';
	}
	
	function submitConfirm()
	{
		var com=document.frm.COMMENTS.value;
		if(isLegal(com)) {
		}
		else {
		alert('<%=dbLabelBean.getLabel("alert.approverequest.invalidcharactermsg",strsesLanguage) %>');
		return false;
		
		}
		
		var var1 =document.frm.flagforMataIntial.value;
		if(var1=='yes'){
			//change in these if condition to resolve scripting error by manoj chand on 21 feb 2012
			if(document.frm.MATAAirlineIN!=undefined && document.frm.MATAAirlineIN.value=='' ){
			alert('<%=dbLabelBean.getLabel("alert.global.airlinename",strsesLanguage) %>');
			document.frm.MATAAirlineIN.focus();
			return false;
			}
			
			if(document.frm.MATApriceIN!=undefined && document.frm.MATApriceIN.value=='' ){
			alert('<%=dbLabelBean.getLabel("label.mata.pleaseenteryourprice",strsesLanguage) %>');
			document.frm.MATApriceIN.focus();
			return false;
			}
			if(document.frm.MATARemaraksIN!=undefined && document.frm.MATARemaraksIN.value=='' ){
			alert('<%=dbLabelBean.getLabel("alert.approverrequest.yourremarks",strsesLanguage) %>');
			document.frm.MATARemaraksIN.focus(); 
			return false;
			}
		}	
	
	
	var com=document.frm.COMMENTS.value;
			if(com=='')
			{
			alert('<%=dbLabelBean.getLabel("alert.approverequest.yourcomments",strsesLanguage) %>');
			document.frm.COMMENTS.focus();
			return false;
			}
			else
			{
			if(confirm('<%=dbLabelBean.getLabel("alert.approverequest.onsubmitmessage",strsesLanguage) %>'))
				return true;
			else
				return false;
			}
			
	}
	
	//-->
	
	
		function test1(obj1, length, str)
			{ 
			var obj;
		 	if(obj1=='COMMENTS')
		 	{
		 		obj = document.frm.COMMENTS;
		 		upToTwoHyphen(obj);
		 	}
			charactercheck(obj,str);
			limitlength(obj, length);
			//zeroChecking(obj);
			spaceChecking(obj);//added for preventing starting spaces on 05-Jul-07 by shiv  
		
	}
	
	
	
	</SCRIPT>
	
	<script>
	function MM_openBrWindow(theURL,winName,features) 
	{ 
	window.open(theURL,winName,features);
	}
	 function CheckData()
	 {
		 if(document.frm1.TRANSCOMMENTS.value=="")
		 {
			 alert('<%=dbLabelBean.getLabel("alert.approverequest.yourcomments",strsesLanguage) %>');		
			 document.frm1.TRANSCOMMENTS.focus();
			 return false;
		 }
		 else if(document.frm1.delName.value=="")
		 {
			 alert('<%=dbLabelBean.getLabel("alert.approverequest.delegate",strsesLanguage) %>');		 
			 document.frm1.delName.focus();
			 return false;
		 }
		 else
		{
			if(confirm('<%=dbLabelBean.getLabel("alert.approverequest.onsubmittransfermessage",strsesLanguage) %>'))
			return true;
			else
			return false;
		}
	}

	 
	</script>
	
	</head>
	 <body onLoad="typeData();"> 
	
	<%
	String strTravelId		= request.getParameter("purchaseRequisitionId");
	String strTravellerId	= request.getParameter("traveller_Id");
	String strTravelType    = request.getParameter("travel_type");
	
	// Variables declared and initialized
	Connection con				=		null;			    // Object for connection
	Statement stmt				=		null;			   // Object for Statement
	ResultSet rs				=		null;			  // Object for ResultSet
	
	//Create Connection
	Class.forName(Sdbdriver);
	con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
	String	 sSqlStr	=	""; // For sql Statements
	String strTransFlag				=	"";
	String strDisabled				=	"";
	String strApproveLabel			=	dbLabelBean.getLabel("label.createrequest.receive",strsesLanguage);
	
	
	sSqlStr="SELECT  DISTINCT ISNULL(RTRIM(TRANSFLAG),' ') FROM T_APPROVERS WHERE ORDER_ID=(SELECT MIN(ORDER_ID) FROM T_APPROVERS WHERE APPROVE_STATUS=0 AND STATUS_ID=10 AND TRAVEL_TYPE='"+strTravelType+"' AND TRAVEL_ID='"+strTravelId+"' AND TRAVELLER_ID='"+strTravellerId+"') AND TRAVEL_TYPE='"+strTravelType+"'AND TRAVEL_ID='"+strTravelId+"'AND TRAVELLER_ID='"+strTravellerId+"'";
	
		stmt = con.createStatement(); 
		rs = stmt.executeQuery(sSqlStr);
		if(rs.next())
		{
				strTransFlag	 =	rs.getString(1);
		}
		rs.close();
		stmt.close();
	
		if(strTransFlag.equals("Y"))
		{
			strDisabled="disabled"; 
			strApproveLabel=dbLabelBean.getLabel("message.approverequest.returnthisrequest",strsesLanguage);
		}
	
	%>
	 <!--For Section 1 First half @ Vijay 03/04/2007 change the size of table--> 
	<table width="70%" align="center" style="margin:0 auto;" border="0" cellpadding="5" cellspacing="1" class="formborder">
	  <form method=post action="T_ConfirmRequisitions_MATA_Post.jsp" name=frm target=_parent>
	  <input type=hidden name="purchaseRequisitionId" value="<%=strTravelId%>">
	  <input type=hidden name="traveller_Id" value="<%=strTravellerId%>">
	  <input type=hidden name="travel_type" value="<%=strTravelType%>">
	  
	  </tr> 
	     
	 <%
	    String strAirlineName 			="";	
	    String strLocaPrice 			="";
	    String strRemaprks				="";
	    String strCurrency				="";
	    String strflagforPricedes		="no";
	    String  strRowcount				="";
	    String strProviderflage			="";
	    
	    if(strTravelType.equalsIgnoreCase("I"))
	    {
	    	  	sSqlStr="SELECT   TK_AIRLINE_NAME, TK_CURRENCY as currceny, (convert(varchar(20), TK_AMOUNT)) as amount ,TK_REMARKS,TK_PROVIDER_FLAG "+
	  			" FROM  T_TRAVEL_DETAIL_INT	  WHERE     (TRAVEL_ID = "+strTravelId+") "; 
	    }else{
	    	
	     	sSqlStr="SELECT   TK_AIRLINE_NAME, TK_CURRENCY as currceny, (convert(varchar(20), TK_AMOUNT)) as amount ,TK_REMARKS,TK_PROVIDER_FLAG "+
  			" FROM  T_TRAVEL_DETAIL_DOM	  WHERE     (TRAVEL_ID = "+strTravelId+") "; 
	    } 	  	
	  	
	  	stmt = con.createStatement(); 
		rs = stmt.executeQuery(sSqlStr);
		
		  while(rs.next())
		  { 
			  strAirlineName 	=rs.getString("TK_AIRLINE_NAME").trim(); 
			  strCurrency	 	=rs.getString("currceny"); 
			  strLocaPrice 		=rs.getString("amount") ;
			  strRemaprks 		=rs.getString("TK_REMARKS");  
			  strProviderflage  =rs.getString("TK_PROVIDER_FLAG");  
		  }rs.close();
		  
		  if(strAirlineName.equals("")){
			  strCurrency=""; 
			  strLocaPrice="";
		  }
		  
		 // System.out.println("sSqlStr==1="+sSqlStr); 
		  
		  
		  
		  if(!strProviderflage.equalsIgnoreCase("y")) 
		  {  
			  strflagforPricedes="yes";  	  
		  	 //code to find MATA IS APProving first time or 2 time open 
		 	 sSqlStr=" select count(*)  from T_approvers  "+
			 		 " where travel_id="+strTravelId+" and travel_type='"+strTravelType+"' "+ 
			 		 " and role='MATA' and approve_status='0' "; 
		  	
		  	stmt = con.createStatement(); 
			rs = stmt.executeQuery(sSqlStr);
			
			  while(rs.next())
			  { 
				strRowcount =rs.getString(1); 
				  
			  }rs.close();
			 //close 
		 
	
		 
		 
	  %>
	  
	    <tr align="left" valign="top"  >       
		   	 <td   valign="middle" align="center" colspan=3 class="formtr2" > 
		   	 <link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">
		   	 	  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="reporttbl">
			        <tr>
			          <td height="0" colspan="4" align="left" class="reportheading2" ><%=dbLabelBean.getLabel("label.requestdetails.pricedetails",strsesLanguage) %> </td>
			        </tr>
			        <tr>  
			          <td width="18%" align="left" class="reportheading2" ># </td> 
			          <td width="25%" align="left" class="reportheading2"><%=dbLabelBean.getLabel("label.global.airlinename",strsesLanguage) %> </td>
			          <td width="25%" align="left" class="reportheading2" ><%=dbLabelBean.getLabel("label.requestdetails.price",strsesLanguage) %></td>
			          <td width="50%" align="left" class="reportheading2" ><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %></td>  
			          
			        </tr> 
			        <tr>
			          <td  height="0" class="reportLBL"  > <%=dbLabelBean.getLabel("label.mata.localpricedetails",strsesLanguage) %>  </td>
			          <td  height="0" class="reportdata"><%=strAirlineName %> </td>
			          <td  height="0" class="reportdata" ><%=strCurrency%>&nbsp;<%=strLocaPrice %></td>  
			          <td  height="0" class="reportdata"><%=strRemaprks %> </td> 
			        </tr>
			        
			        
			        <%if(strRowcount.equals("2")){
			        	%>
			       
			        
			        
					<tr>
			          <td height="0" class="reportLBL"  > <%=dbLabelBean.getLabel("label.mata.matapricedetail",strsesLanguage) %> </td>      
			          <td height="0" class="reportdata"  size="5" ><input type="text" name="MATAAirlineIN"  onKeyUp="return test1(this, 30, 'cn')" class="textBoxCss"/> </td>
			          <td height="0" class="reportdata" valign="top" >  <%=strCurrency%> &nbsp;<input type="hidden" name="currncey" value="<%=strCurrency%>"> 
			          <input type="text" width="50%" name="MATApriceIN" size="10" onKeyUp="return test1(this, 10, 'n')" class="textBoxCss"/>
					         
			          </td> 
			          <td height="0" class="reportdata" width="40%" > 
			          <input type="text" size="35" name="MATARemaraksIN" onKeyUp="return test1(this, 100, 'cn')" class="textBoxCss" /> </td>   
			          </tr>
			         <tr><td colspan="4">&nbsp;</td>
			         <input type="hidden" name="MATAApproval" value="initial" /> 
			          
			          </tr> 
			         <%}
			        
			        %>
			        
			        <%if(strRowcount.equals("1")){
			        	
			        	String strIntialAirline 	=		""; 
			        	String strIntialCurrency 	=		"";
			        	String strIntialPrice	 	=		"";
			        	String strIntialremarks		=		"";
			        	
			        	String strFinalAirline 		=		""; 
			        	String strFinaCurrency 		=		"";
			        	String strFinaPrice	 		=		""; 
			        	String strFinaremarks       =		""; 
			        	
			        	 if(strTravelType.equalsIgnoreCase("I"))
			     	    {
			        	 sSqlStr="SELECT TRAVEL_ID, TK_AIRLINE_NAME_MATA, TK_CURRENCY, TK_AMOUNT_MATA, TK_REMARKS_MATA "+
			        		" FROM      T_TRAVEL_DETAIL_INT "+
			        		" WHERE     (TRAVEL_ID = "+strTravelId+")  "; 
			     	    }else{
			     	    	sSqlStr="SELECT TRAVEL_ID, TK_AIRLINE_NAME_MATA, TK_CURRENCY, TK_AMOUNT_MATA, TK_REMARKS_MATA "+
				        		" FROM  T_TRAVEL_DETAIL_DOM "+
				        		 " WHERE  (TRAVEL_ID = "+strTravelId+")  "; 
			     	    	
			     	    } 
			        	 
			        	// System.out.println("sSqlStr===2"+sSqlStr); 
			  	
					  	stmt = con.createStatement(); 
						rs = stmt.executeQuery(sSqlStr);
						
						  while(rs.next())
						  { 
							strIntialAirline 	=rs.getString("TK_AIRLINE_NAME_MATA"); 
							strIntialCurrency 	=rs.getString("TK_CURRENCY"); 
							strIntialPrice	 	=rs.getString("TK_AMOUNT_MATA"); 
							strIntialremarks	=rs.getString("TK_REMARKS_MATA"); 
							  
						  }rs.close();
				 //close 
			        	%>
			       
			        <tr>
			          <td height="0" class="reportLBL"  > <%=dbLabelBean.getLabel("label.requestdetails.mataprice",strsesLanguage) %> </td>        
			          <td height="0" class="reportdata" class="textBoxCss" size="5" ><%=strIntialAirline.trim() %></td>
			          <td height="0" class="reportdata" valign="top" >  <%=strIntialCurrency%> &nbsp;<%=strIntialPrice.trim()%></td> 
			           <td height="0" class="reportdata" valign="top"  width="40%">  <%=strIntialremarks.trim() %>
			          </td> 
			       
			         
			          
			          </tr>  
			        <%
			        
			        
			        if(strTravelType.equalsIgnoreCase("I"))
		     	    {
		        	 sSqlStr="SELECT TK_AIRLINE_NAME_FINAL,TK_CURRENCY, TK_AMOUNT_FINAL, TK_REMARKS_FINAL "+
	 		        		" FROM      T_TRAVEL_DETAIL_INT "+
			        		" WHERE     (TRAVEL_ID = "+strTravelId+")  "; 
		     	    }else{
		     	    	sSqlStr="SELECT TK_AIRLINE_NAME_FINAL,TK_CURRENCY,TK_AMOUNT_FINAL," + 
			     	    		" TK_REMARKS_FINAL "+ 
			        		" FROM  T_TRAVEL_DETAIL_DOM "+
			        		 " WHERE  (TRAVEL_ID = "+strTravelId+")  "; 
		     	    	
		     	    } 
		  	
				  	stmt = con.createStatement(); 
					rs = stmt.executeQuery(sSqlStr);
					
					  while(rs.next())
					  { 
						strFinalAirline 	=rs.getString("TK_AIRLINE_NAME_FINAL"); 
						strFinaCurrency 	=rs.getString("TK_CURRENCY"); 
						strFinaPrice	 	=rs.getString("TK_AMOUNT_FINAL");  
						strFinaremarks		=rs.getString("TK_REMARKS_FINAL"); 
						  
					  }rs.close();
			 //close 
			        %>
			        <tr>
			          <td height="0" class="reportLBL"  ><%=dbLabelBean.getLabel("label.requestdetails.finalprice",strsesLanguage) %> </td>          
			          <td height="0" class="reportdata" class="textBoxCss" size="5" ><%=strFinalAirline%> </td>
			          <td height="0" class="reportdata" valign="top" >  <%=strFinaCurrency%> - <%=strFinaPrice%> </td>
			          <td height="0" class="reportdata" valign="top" width="40%" >
			          
			          <%=strFinaremarks%> 
					          
			          </td> 
			          
			         
 			           
			          </tr>   
			          
					 
			         <%}
			        
			        %> 
			           
			          
			          
			        </table>
		   	 
		   	 
		   	 
			
			</td>
	 </tr>
	  
	  <%
		  }
	  %>
	  
	  <tr align="left" valign="top" >
	    <td class="formtr2"  valign="top" align="left" width="30%">
	    <input type=radio name=rad value="RECEIVED" checked onClick="typeData();"> <%=strApproveLabel%> 
		</td>
	    <td class="formtr1" align="center" width="40%"><textarea cols=53 class="textBoxCss" rows=3 NAME=COMMENTS onKeyUp="test1('COMMENTS',500,'txt');"></textarea></td>  
		<td class="formtr2" align="left" width="30%"> 
	<%/* Commented field is not allow
		if(strTransFlag.equals("Y"))
		{
		}
		else
		{
	*/%>
		<!-- <input type=radio name=rad value="CONFIRM" checked onClick="typeData1();" <%=strDisabled%>> Confirm   -->
	<%
	//	}
	%>
		 </td> 
	 </tr>
	
	    <tr align="left" valign="top" colorPink>
	    <td class="formbottom" valign="middle" align="center" colspan=3>
		<input class="formbutton" type=button name=close value="<%=dbLabelBean.getLabel("button.approverequest.closewindow",strsesLanguage) %>" onClick="javascript:top.window.close();">
		<input class="formbutton" type=button name=sub value="<%=dbLabelBean.getLabel("button.approverequest.requestmoreinfo",strsesLanguage) %>" onClick="MM_openBrWindow('reqRequestMoreInfo.jsp?strTravelId=<%=strTravelId%>&ReqTyp=<%=strTravelType%>','REQUESTMOREINFO','scrollbars=yes,resizable=yes,width=775,height=250')">
		<input class="formbutton" type=Submit name=sub value="<%=dbLabelBean.getLabel("button.approverequest.submit",strsesLanguage) %>" onClick="return  submitConfirm();"></td>
		<input type="hidden" name="flagforMataIntial" value="<%=strflagforPricedes%>" /> 
	 </tr>
	 
	 

	</table> 
	
	 
	<br>
	</form>
	 
	
	
	
	</body>
	</html>

