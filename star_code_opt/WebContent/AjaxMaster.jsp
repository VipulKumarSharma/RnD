 <%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				             :Shiv sharma 
 *Date of Creation 	         :
 *Copyright Notice 		     :Copyright(C)2000 MIND.All rights reserved
 *Project	  			     :STARS
 *Operating environment      :Tomcat, sql server 2000 
 *Description 		     	 : This is Ajax master used for calculate age  of traveler 
 *Modification 	    	     :
 *Editor			         :Editplus
 
 
 *Modification				 :Add if condition to populate combobox in hand over page
 *Modified By				 :Manoj Chand
 *Date of Modification		 :02 Feb 2011
 
 *Modification				 :Add if condition to check currency exchage rate
 *Modified By				 :Manoj Chand
 *Date of Modification		 :07 Feb 2011
 
 *Modification				 :Getting forget username and password 
 *Modified By				 :Manoj Chand
 *Date of Modification		 :01 Mar 2011
 
 *Modified By      			 :Manoj Chand
 *Modification      		 :Add if condition to create check for no. of total tour days 
 							  should not be greater than todate+fromdate +1 
 *Modification Date 		 :04 march 2011
 
 *Modified By				 :Manoj Chand
 *Modification				 :modify sql query for total no. of tour days
 *Modified Date				 :08 march 2011
 
 *Modified By				 :Manoj Chand
 *Modification				 :Add if condition to display alert when selected approver is in default workflow.
 *Modified Date				 :24 march 2011
 
 *Modified By				 :Manoj Chand
 *Modification				 :ADD IF BLOCK TO PROVIDE DELETION OF USER COMMENTS
 *Modified Date				 :12 DEC 2011
 
 *Modified By				 :Kaveri Garg
 *Modification				 :ADD IF BLOCK TO PROVIDE CHECKING FOR ITS REFERENCE IN REQUEST BEFORE DELETING A COST CENTRE.
 *Modified Date				 :21 AUG 2012
 
 *Modified By				 :Kaveri Garg
 *Modification				 :ADD IF BLOCK TO PROVIDE VALUES IN COMBOBOX ON SELECTION OF UNIT IN MARK OUT OF OFFICE PAGE.
 *Modified Date				 :09 NOV 2012
 
 *Modified By				 :Manoj Chand
 *Date of Modification		 :17 Jan 2013
 *Modification				 :if block added to provide alert for duplicate user.
 
 *Modified By				 :Manoj Chand
 *Date of Modification		 :23 Jan 2013
 *Modification				 :if block added to provide alert if user already have some request in movements while changing his workflow number by STARS Admin or Local Admin.
 
 *Modified By				 :Manoj Chand
 *Date of Modification		 :05 Feb 2013
 *Modification				 :if block added to test web service url working or not.
 
 *Modified By				 :Manoj Chand
 *Date of Modification 		 :26-04-2013
 *Modification				 :To get count of request for which tes is not submitted in EASY.
 
 *Modified By	      		  :	 MANOJ CHAND
 *Date of Modification 		  :	 08 August 2013
 *Description				  :	 To populate user based on site in Access Rights
 
 *Modified By	      		  :	 MANOJ CHAND
 *Date of Modification 		  :	 26 August 2013
 *Description				  :	 to check whether the given user have reviewer or not.
 
 *Modified By	      		  :	 MANOJ CHAND
 *Date of Modification 		  :	 19 September 2013
 *Description				  :	 add code to populate user combobox on change of unit in out of office page.
 *******************************************************/
%>


 <jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
 <jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods"></jsp:useBean>
 <jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
 <jsp:useBean id="roleBean" scope="page" class="src.connection.Roles_Resource" />
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.Date,java.text.*,javax.mail.*,javax.mail.internet.*,javax.activation.*,java.util.*,java.text.*,wsclient.*,src.connection.PropertiesLoader;" %>

 <% 
  response.setHeader("Pragma","no-cache");
  response.setDateHeader("Expires",0);
  response.setHeader("Cache-Control","no-cache");
%>
 <%
  response.setContentType("text/xml; charset=UTF-8");  
  String  strSql ="";
  String strAge="";
  String strXmlDoc="";
  String  rootopen ="<root>";
  String rootclose ="</root>";

   String userAge = request.getParameter("userAge");

   //Added By manoj begin
    String strSiteId = (request.getParameter("siteId")==null)?"":request.getParameter("siteId");
	String  strTravelType=(request.getParameter("travel_type")==null)?"":request.getParameter("travel_type");
	String  strUserid=(request.getParameter("userid")==null)?"":request.getParameter("userid");
	String  strreqpage=(request.getParameter("reqpage")==null)?"":request.getParameter("reqpage");
	
	String strCur=(request.getParameter("currency")==null)?"":request.getParameter("currency");
	String strFlag=(request.getParameter("strFlag")==null)?"":request.getParameter("strFlag");
	//System.out.println("strCur--->"+strCur);
	//System.out.println("strFlag--->"+strFlag);
	//added by manoj on 24 feb 2011
	String strEmailflag=(request.getParameter("strflag")==null)?"":request.getParameter("strflag");
	String strEmail=(request.getParameter("emailflag")==null)?"":request.getParameter("emailflag");
	
	String strunameFlag=(request.getParameter("strflagID")==null?"":request.getParameter("strflagID"));
	String struName=(request.getParameter("uNameflag")==null?"":request.getParameter("uNameflag"));
	String strFlag1 =request.getParameter("strFlag1")==null?"":request.getParameter("strFlag1");
   //end

//added by manoj on 24 march
 String SiteId = (request.getParameter("SITE_ID")==null)?"":request.getParameter("SITE_ID");
	String  strsprole=(request.getParameter("sp_role")==null)?"":request.getParameter("sp_role");
	String  traveltype=(request.getParameter("traveltype")==null)?"":request.getParameter("traveltype");
	String  reqpage=(request.getParameter("reqpage")==null)?"":request.getParameter("reqpage");
	String strmanagerid=(request.getParameter("managerId")==null)?"":request.getParameter("managerId");
 //added by manoj on 05 sept 2011
 	String strmenu=request.getParameter("menu")==null?"":request.getParameter("menu");
 	String strmbl_os_id=request.getParameter("mbl_os_id")==null?"":request.getParameter("mbl_os_id");
 	String strfile_name=request.getParameter("file_name")==null?"":request.getParameter("file_name");
 	String strSuserid=request.getParameter("Suserid")==null?"":request.getParameter("Suserid");
 //added by manoj on 12 Dec 2011 to implement delete comments
 	String strTrvReqID=request.getParameter("trvReqId")==null?"":request.getParameter("trvReqId");
 	String strCommentId=request.getParameter("CommentId")==null?"":request.getParameter("CommentId");
 	String strActionFlag=request.getParameter("reqFlag")==null?"":request.getParameter("reqFlag");

 //added by kaveri garg on 21 august 2012 for deleteing cost centre.
 	String strFlagcc=request.getParameter("flag")==null?"":request.getParameter("flag");
 	String strCcCodecc=request.getParameter("cc_code")==null?"":request.getParameter("cc_code");
 	String strSiteIdcc=request.getParameter("site_id")==null?"":request.getParameter("site_id");

//Added by manoj chand on 10 oct 2012 to calculate total in USD from INR

	String strGrandTotalInr=request.getParameter("grandtotal_inr")==null?"0.0":request.getParameter("grandtotal_inr");
	String strTotalExp=request.getParameter("totalexp")==null?"0.0":request.getParameter("totalexp");
	String strSelCur=request.getParameter("selcurrency")==null?"":request.getParameter("selcurrency");
	String strBaseCur=request.getParameter("basecur")==null?"INR":request.getParameter("basecur");
	String strSelDate=request.getParameter("seldate")==null?"":request.getParameter("seldate");
 	

 	   //Added By KAVERI BEGIN FOR OUT OF OFFICE
    String strSiteIdooo = (request.getParameter("siteIdooo")==null)?"":request.getParameter("siteIdooo");
	String  strUseridooo=(request.getParameter("useridooo")==null)?"":request.getParameter("useridooo");
	String  strreqpageooo=(request.getParameter("reqpageooo")==null)?"":request.getParameter("reqpageooo");
	String strSuserRole= (request.getParameter("suserRole")==null)?"":request.getParameter("suserRole");
	String strlanguage1= (request.getParameter("language1")==null)?"":request.getParameter("language1");
	//Added by manoj chand on 17 dec 2012 to make alert for duplicate user registration. 
	String strDob=request.getParameter("dob")==null?"":request.getParameter("dob");
	String strFirstName=request.getParameter("firstname")==null?"":request.getParameter("firstname");
	String strLastName=request.getParameter("lastname")==null?"":request.getParameter("lastname");
	
    // END
	
        if(userAge != null  &&  !userAge.equals("") ) {
          	 strSql = "SET DATEFORMAT  DMY SELECT dbo.CALAGE_YYMMDD('"+userAge+"',GETDATE())";
             ResultSet rs = dbConBean.executeQuery(strSql);
	         while(rs.next())
				{
                strAge =rs.getString(1);  
				}
   			rs.close();
   		//System.out.println("-------------user Age----------"+strAge);
		strXmlDoc="<message>"+strAge+"</message>";
	    response.getWriter().write(strXmlDoc);
	 } 
	 else {	
		 //nothing to show
		// response.setStatus(HttpServletResponse.SC_NO_CONTENT);
				
		 } 
        
        
        //Added on 31 jan 2011 by manoj
      	if (!strSiteId.equals("-1") && strSiteId != null && strreqpage.equalsIgnoreCase("abc"))
       	{
       		response.setContentType("text/html; charset=UTF-8");
       		strSql="SELECT dbo.user_name(dbo.finalooo(USERID,getdate(),'"+strTravelType+"')),USERID,.DBO.USER_NAME(USERID) FROM M_USERINFO WHERE STATUS_ID=10 AND SITE_ID='"+strSiteId+"' and userid != '" + strUserid +"' ORDER BY 3";
       		ResultSet rs = dbConBean.executeQuery(strSql);
		%>
		<option value="">Select Delegate</option>
		<%
       		String strTrimName  ="",strVal ="",strAlt="";
       		while (rs.next())
       		{
       			strAlt = rs.getString(1);
       			strVal = rs.getString(2);
       			strTrimName = rs.getString(3);
       			if(strTrimName.length() > 30)
       				strTrimName = strTrimName.substring(0,30)+"..";       			
      %>
      			<option alt="<%=strAlt%>"  value="<%=strVal%>"><%=strTrimName%></option> 
      <%
       		}
       		rs.close();		
       		response.getWriter().write(strXmlDoc);
       	}
        //end if
        
        
        
       if(strCur != null && strFlag.equals("CheckCurrencyId")){
    	   
      		response.setContentType("text/html; charset=UTF-8");
      		//strSql="select * from exchange_rate where rate_year = year(getdate()) and rate_month=month(getdate()) and cur_id="+strCur;
      		strSql="select 1 from exchange_rate inner join m_currency on exchange_rate.cur_id=m_currency.cur_id where rate_year = year(getdate()) and rate_month=month(getdate())and currency='"+strCur.trim()+"' and exchange_rate.conversion_rate>0 and m_currency.status_id =10";
      		ResultSet rs = dbConBean.executeQuery(strSql);
      		String strflag="";
      		if(rs.next())
      			strflag="Y";
      		else
      			strflag="N";
         rs.close();
    		response.getWriter().write(strflag); 
     } 
     
     
        
        //added by manoj on 24 feb 2011
        if(strEmail!=null && strEmailflag.equals("CheckEmailId")){
        		
        	response.setContentType("text/html; charset=UTF-8");
        	strSql="SELECT USERNAME,SECRET_QUESTION FROM M_USERINFO WHERE EMAIL='"+strEmail.trim()+"'  AND STATUS_ID=10";
      		ResultSet rs = dbConBean.executeQuery(strSql);
      		String strflag="";
      		String struserName="";
      		String strsecret_question="";
      		if(rs.next()){
      			struserName=rs.getString("USERNAME");
      			strsecret_question=rs.getString("SECRET_QUESTION");
      			strflag=struserName+","+strsecret_question;
      		}
      		else
      		{
      			strSql="SELECT USERNAME,SECRET_QUESTION FROM M_USERINFO WHERE EMAIL='"+strEmail.trim()+"'  AND STATUS_ID=30";	
          		rs = dbConBean.executeQuery(strSql);
          		if(rs.next()){
          			strflag="D";
          		}else
      			strflag="N";
      		}
         	rs.close();
    		response.getWriter().write(strflag);
        }
        
        
        if(struName!=null && strunameFlag.equals("CheckUserId")){	
        	response.setContentType("text/html; charset=UTF-8");
        	strSql="SELECT EMAIL,SECRET_QUESTION FROM M_USERINFO WHERE USERNAME='"+struName.trim()+"'  AND STATUS_ID=10";
      		ResultSet rs = dbConBean.executeQuery(strSql);
      		String strflag="";
      		String stremailid="";
      		String strsecret_question="";
      		if(rs.next()){
      			stremailid=rs.getString("EMAIL");
      			strsecret_question=rs.getString("SECRET_QUESTION");
      			strflag=stremailid+","+strsecret_question;
      		}
      		else{
      			strSql="SELECT EMAIL,SECRET_QUESTION FROM M_USERINFO WHERE USERNAME='"+struName.trim()+"'  AND STATUS_ID=30";
          		rs = dbConBean.executeQuery(strSql);
      			if(rs.next()){
      				strflag="D";
      			}else
      			strflag="N";
      		}
         	rs.close();
    		response.getWriter().write(strflag);
        	
        }
        
        
        
        if(strFlag1.equals("CheckNumOfDaysDiff")){
        	
     		String strreqId = request.getParameter("reqId");
     		//String strSuppDailyAllDys= request.getParameter("dailyalldays")==null?"0":request.getParameter("dailyalldays");
     		String strSuppHotelDys= request.getParameter("hoteldays")==null?"0":request.getParameter("hoteldays");
     		
     		//if(strSuppDailyAllDys.equalsIgnoreCase(""))
     			//strSuppDailyAllDys ="0";
     		if(strSuppHotelDys.equalsIgnoreCase(""))
     			strSuppHotelDys ="0";
     		
     		String strRetVal ="";
     		
     		response.setContentType("text/html; charset=UTF-8");
        	
        	strSql="SELECT TDI.TRAVEL_DATE, CONVERT(VARCHAR(10), TRDI.TRAVEL_DATE, 103) AS RETURN_DATE, DATEDIFF(DD, TDI.TRAVEL_DATE, "+ 
        		"CASE WHEN TRDI.TRAVEL_DATE IS NULL OR YEAR(TRDI.TRAVEL_DATE) = 1900 THEN TDI.TRAVEL_DATE ELSE TRDI.TRAVEL_DATE END ) "+ 
                "+ 1 AS DIFF_IN_DATE "+
				"FROM         T_TRAVEL_DETAIL_INT AS TDI INNER JOIN "+
                "T_RET_JOURNEY_DETAILS_INT AS TRDI ON TRDI.TRAVEL_ID = TDI.TRAVEL_ID "+
				"WHERE     (TDI.TRAVEL_ID = '"+strreqId+"')"; 	
        		
        	String strreturnDate="";
      		ResultSet rs = dbConBean.executeQuery(strSql);
      		int int_DiffDays=0;
      		if(rs.next()){
      			 strreturnDate = rs.getString(2);
      			int_DiffDays = rs.getInt(3);
      			//System.out.println("int_DiffDays = "+int_DiffDays);
      		}
      		
      		/*
      		if(Integer.parseInt(strSuppDailyAllDys) <= int_DiffDays)
      			strRetVal = "true";
      		else
      			strRetVal = "false";
      		*/
      		if(!strreturnDate.equals("01/01/1900")){
      		if(Integer.parseInt(strSuppHotelDys) <= int_DiffDays)
      			strRetVal = "true";
      		else
      			strRetVal = "false";
      		}else{
      			strRetVal = "true";
      		}
      		
         rs.close();
         //System.out.println("strRetVal-2333-->"+strRetVal);  
         response.getWriter().write(strRetVal);
        }
        
       
        
        if (!strSiteId.equals("-1") && strSiteId != null && strreqpage.equalsIgnoreCase("approver1"))
        {
        	
        	response.setContentType("text/html; charset=UTF-8");
        	String sflag="n";
        if(traveltype.equals("I")){
        	strSql="SELECT APPROVER_ID, LTRIM(RTRIM(dbo.USER_NAME(APPROVER_ID))) AS APPROVER_NAME, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+SiteId+" AND TRV_TYPE='I' AND  sp_role="+strsprole+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 5";
        	//System.out.println("strSQL----int--->"+strSql);
        }else{
        	strSql="SELECT APPROVER_ID, LTRIM(RTRIM(dbo.USER_NAME(APPROVER_ID))) AS APPROVER_NAME, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+SiteId+" AND TRV_TYPE='D' AND sp_role="+strsprole+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 5";
        	//System.out.println("strSQL----dom--->"+strSql);
        }
        ResultSet rs = dbConBean.executeQuery(strSql);
        //System.out.println("user id------>"+strmanagerid);
        while(rs.next()){
        	String strapproverid=rs.getString("APPROVER_ID");
        	if(strmanagerid.equalsIgnoreCase(strapproverid))
        	{
        		sflag="y";
        	}
        }//end while
        rs.close();
        //System.out.println("value of sflag is ----->"+sflag);
        response.getWriter().write(sflag);
        	
        }
        
        if (!strSiteId.equals("-1") && strSiteId != null && strreqpage.equalsIgnoreCase("approver2"))
        {
        	
        	response.setContentType("text/html; charset=UTF-8");
        	String sflag="n";
        if(traveltype.equals("I")){
        	strSql="SELECT APPROVER_ID, LTRIM(RTRIM(dbo.USER_NAME(APPROVER_ID))) AS APPROVER_NAME, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+SiteId+" AND TRV_TYPE='I' AND  sp_role="+strsprole+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 5";
        }else{
        	strSql="SELECT APPROVER_ID, LTRIM(RTRIM(dbo.USER_NAME(APPROVER_ID))) AS APPROVER_NAME, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+SiteId+" AND TRV_TYPE='D' AND sp_role="+strsprole+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 5";
        }
        ResultSet rs = dbConBean.executeQuery(strSql);
        //System.out.println("user id------>"+strmanagerid);
        while(rs.next()){
        	String strapproverid=rs.getString("APPROVER_ID");
        	if(strmanagerid.equalsIgnoreCase(strapproverid))
        	{
        		sflag="y";
        	}
        }//end while
        rs.close();
        //System.out.println("value of sflag is ----->"+sflag);
        response.getWriter().write(sflag);
        	
        }
        
        
     /*   if(strmenu!=null && strmenu.equals("logDownload")){
        	response.setContentType("text/html; charset=UTF-8");
        	dbUtility.saveMobileDownloadInfo(strSuserid,strmbl_os_id,strfile_name,request.getRemoteAddr()) ;			
			
        }*/
        
       /* if(strmenu!=null && strmenu.equals("fileDownload")){
        	response.setContentType("text/pdf");
			response.setHeader("Content-Disposition","attachment;filename="+request.getParameter("fileName"));
			//ServletContext ctx = this.servlet.getServletContext();
			ServletContext ctx=getServletContext();
			String strfileName=request.getParameter("fileName")==null?"":request.getParameter("fileName");

			InputStream is = ctx.getResourceAsStream("/mobile/user_manual/"+strfileName);
		 
			int read=0;
			byte[] bytes = new byte[1024];
			OutputStream os=null;
			try{
				
			os = response.getOutputStream();
			
			while((read = is.read(bytes))!= -1){
				os.write(bytes, 0, read);
			}
			}catch(Exception ee){
				ee.printStackTrace();
			}
			
			os.flush();
			os.close();	
			//is.close();
			
			//return null;			
			
        }*/
     //ADD BY MANOJ CHAND ON 12 DEC 2011 TO DELETE COMMENTS   
        if(strTrvReqID!=null && !strTrvReqID.equals("") && strActionFlag.equalsIgnoreCase("comment")){
        	response.setContentType("text/html; charset=UTF-8");
        	String sflag="n";
        	int i=0;
       
        	strSql="DELETE FROM TRAVEL_REQ_COMMENTS WHERE TRAVEL_REQ_COMMENTS.COMMENTS_ID='"+strCommentId+"' and TRAVEL_REQ_COMMENTS.TRAVEL_ID='"+strTrvReqID+"' and TRAVEL_REQ_COMMENTS.TRAVEL_TYPE='"+traveltype+"'";
        	//System.out.println("strSql--125-->"+strSql);        	
        	i=dbConBean.executeUpdate(strSql);
	       	if(i>0){
	       		sflag="y";
	        response.getWriter().write(sflag);
	       	}else{
	       		response.getWriter().write(sflag);
	       	}
	       		
        }
        
        
        //ADDED BY KAVERI GARG TO DELETE COST CENTRE ON CHECK OF WHETHER IT'S REFERENCE EXIST IN SOME REQUESTS OR NOT
    	if(strFlagcc!=null && !strFlagcc.equals("") && strFlagcc.equalsIgnoreCase("delete"))
    	{
    		response.setContentType("text/html; charset=UTF-8");
            String res="0";
            int z=0;
      	    String sql1=("SELECT 1 FROM M_COST_CENTRE MCC INNER JOIN T_TRAVEL_DETAIL_DOM TDM ON TDM.CC_ID=MCC.CC_ID where CC_CODE='"+strCcCodecc+"' AND TDM.SITE_ID="+strSiteIdcc+" AND MCC.STATUS_ID=10 UNION ALL SELECT 1 FROM M_COST_CENTRE MCC INNER JOIN T_TRAVEL_DETAIL_INT TDM ON TDM.CC_ID=MCC.CC_ID where CC_CODE='"+strCcCodecc+"' AND TDM.SITE_ID="+strSiteIdcc+" AND MCC.STATUS_ID=10");
      	    ResultSet rs=dbConBean.executeQuery(sql1);
       		if(rs.next())
       		{
       			z=1;
       		}
       		//System.out.println("z-->"+z);
       		if(z==1)                                                        
       		{
	       	res="1";
	       	response.getWriter().write(res);
	       	}
       		else
	       	{
       			res="0";
	       		response.getWriter().write(res);
	       	}
    	}
    	
    	//Added on 09 Nov 2012 by Kaveri for out of office page.
      	if (!strSiteIdooo.equals("") && strSiteIdooo != null && strreqpageooo.equalsIgnoreCase("outofoffice1"))
       	{
       		response.setContentType("text/html; charset=UTF-8");
     	    if(strSuserRole.equals("AD")) {
	     	    	if(strSiteIdooo.equals("0"))
	     	    		strSql="SELECT  USERID, FIRSTNAME, LASTNAME,RTRIM(dbo.SITENAME(site_id)) as SITE  FROM   M_USERINFO WHERE STATUS_ID = 10 order by 2";
	     	    	else
						strSql="SELECT  USERID, FIRSTNAME, LASTNAME FROM M_USERINFO WHERE Site_ID="+strSiteIdooo+" and  (STATUS_ID = 10) order by 2";
	           }
			   else{
						strSql="SELECT  USERID, FIRSTNAME, LASTNAME FROM M_USERINFO WHERE Userid="+strUseridooo+" and  (STATUS_ID = 10) order by 2";
			   }
     	    %>
     	    <option value=-1><%=dbLabelBean.getLabel("label.outofoffice.selectperson",strlanguage1) %></option>
     	    <% 
     	    	ResultSet rs = dbConBean.executeQuery(strSql);
     	   		String strUseridf= "",strFNamef= "",strLNamef="", strTrimName="", strOriginalNameFrom="",strSiteName="";
     	   	 if(strSuserRole.equals("AD") && strSiteIdooo.equals("0")){
	     	   		while(rs.next())
					{
		             strUseridf=rs.getString("USERID");    
					 strFNamef=rs.getString("FIRSTNAME");  
					 strLNamef=rs.getString("LASTNAME");
				 	 strSiteName=rs.getString("SITE");
				 	 strTrimName=strFNamef+" "+strLNamef+" ("+strSiteName+")";
					 strOriginalNameFrom=strTrimName;
					 if(strTrimName.length() > 32)
		       				strTrimName = strTrimName.substring(0,32)+"..";
		            %>
					<option title="<%=strOriginalNameFrom%>" value="<%=strUseridf%>"><%=strTrimName%></option> 
					 <%
					 }
		        	rs.close();
     	   	 }else{
	        	while(rs.next())
				{
	             strUseridf=rs.getString("USERID");    
				 strFNamef=rs.getString("FIRSTNAME");  
				 strLNamef=rs.getString("LASTNAME");
				 strTrimName=strFNamef+" "+strLNamef;
				 strOriginalNameFrom=strTrimName;
				 if(strTrimName.length() > 30)
	       				strTrimName = strTrimName.substring(0,30)+"..";
	            %>
				<option title="<%=strOriginalNameFrom%>" value="<%=strUseridf%>"><%=strTrimName%></option> 
				 <%
				 }
	        	rs.close();
     	   	 }
	          	response.getWriter().write(strXmlDoc);
       	}
		
      //Added on 09 Nov 2012 by Kaveri for out of office page.
      //changed by manoj chand on 03 oct 2013 to display 32 character only.
      	if (!strSiteIdooo.equals("") && strSiteIdooo != null && strreqpageooo.equalsIgnoreCase("outofoffice2"))
       	{
       		response.setContentType("text/html; charset=UTF-8");
			strSql="SELECT  USERID, FIRSTNAME, LASTNAME FROM M_USERINFO WHERE Site_ID="+strSiteIdooo+" and  (STATUS_ID = 10) order by 2";
     	    %>
     	    <option value=-1><%=dbLabelBean.getLabel("label.outofoffice.selectperson",strlanguage1) %></option>
     	    <% 
     	    	ResultSet rs = dbConBean.executeQuery(strSql);
     	   		String strUseridf= "",strFNamef= "",strLNamef="", strTrimName="", strOriginalNameFrom="",strSiteName="";
	        	while(rs.next())
				{
	             strUseridf=rs.getString("USERID");    
				 strFNamef=rs.getString("FIRSTNAME");  
				 strLNamef=rs.getString("LASTNAME");
				 strTrimName=strFNamef+" "+strLNamef;
				 strOriginalNameFrom=strTrimName;
				 if(strTrimName.length() > 30)
	       				strTrimName = strTrimName.substring(0,30)+"..";
	            %>
				<option title="<%=strOriginalNameFrom%>" value="<%=strUseridf%>"><%=strTrimName%></option> 
				 <%
				 }
	        	rs.close();
	          	response.getWriter().write(strXmlDoc);
       	}
    	
      	if (!strSiteIdooo.equals("") && strSiteIdooo != null && strreqpageooo.equalsIgnoreCase("reqapprovebyperson"))
       	{
      		response.setContentType("text/html; charset=UTF-8");
      		if(strSiteIdooo.equals("0"))
 	    		strSql="SELECT  USERID, FIRSTNAME, LASTNAME,RTRIM(dbo.SITENAME(site_id)) as SITE  FROM   M_USERINFO WHERE STATUS_ID = 10 order by 2";
 	    	else
				strSql="SELECT  USERID, FIRSTNAME, LASTNAME FROM M_USERINFO WHERE Site_ID="+strSiteIdooo+" and  (STATUS_ID = 10) order by 2";
       		//System.out.println("strSql--->"+strSql);
      		ResultSet rs = dbConBean.executeQuery(strSql);
        	String strUseridt= "",strFName= "",strLName="", strTrimName="",strOriginalName="",strSiteName="";
        	%>
        	<option value=-1><%=dbLabelBean.getLabel("label.outofoffice.selectperson",strlanguage1) %></option>
        	<option value="0"><%=dbLabelBean.getLabel("label.search.all",strlanguage1) %></option>
        	<%
        	if(strSiteIdooo.equals("0")){
	     	   		while(rs.next())
					{
		             strUseridt=rs.getString("USERID");    
					 strFName=rs.getString("FIRSTNAME");  
					 strLName=rs.getString("LASTNAME");
				 	 strSiteName=rs.getString("SITE");
				 	 strTrimName=strFName+" "+strLName+" ("+strSiteName+")";
				 	 strOriginalName=strTrimName;
					 if(strTrimName.length() > 30)
		       				strTrimName = strTrimName.substring(0,30)+"..";
		            %>
					<option title="<%=strOriginalName%>" value="<%=strUseridt%>"><%=strTrimName%></option> 
					 <%
					 }
		        	rs.close();
     	   	 }else{
	        	while(rs.next())
				{
	             strUseridt=rs.getString("USERID");    
				 strFName=rs.getString("FIRSTNAME");  
				 strLName=rs.getString("LASTNAME");
				 strTrimName=strFName+" "+strLName;
				 strOriginalName=strTrimName;
				 if(strTrimName.length() > 30)
	       				strTrimName = strTrimName.substring(0,30)+"..";
	            %>
				<option title="<%=strOriginalName%>" value="<%=strUseridt%>"><%=strTrimName%></option> 
				 <%
				 }
	        	rs.close();
     	   	 }
       	}// complete out of office block. 
        //added by manoj chand on 07 oct 2012 to fetch exchange rate correspond to the given currency
    	if(!strCur.equals("") && strFlag.equals("curexchangerate")){
     	 //System.out.println("inside exchange rate block");
     	 String strExrate="0.000000";
     	 response.setContentType("text/html; charset=UTF-8");
     	 if(!strCur.equals("-1")){
      		strSql="SELECT DBO.FN_GET_EXCHANGE_RATE ('"+strCur+"','"+strSelDate+"') AS EXCHANGE_RATE";
      		ResultSet rs = dbConBean.executeQuery(strSql);
      		if(rs.next()){
      			strExrate=rs.getString("EXCHANGE_RATE")==null?"0.000000":rs.getString("EXCHANGE_RATE").trim();
      		}
         rs.close();
    		response.getWriter().write(strExrate);
     	 }else{
     		response.getWriter().write(strExrate);
     	 }
     } 
    	//added by manoj chand on 07 oct 2012 to fetch exchange rate correspond to the given currency
    	if(!strFlag.equals("") && strFlag.equals("GrandTotalinUSD")){
    		String strTotalExpinUSD="0.00";
      		response.setContentType("text/html; charset=UTF-8");
      		strSql="SELECT DBO.[FN_CURRENCY_CONVERTOR]('"+strTotalExp+"','"+strBaseCur+"','USD','"+strSelDate+"') AS FINAL_AMOUNT";
     		ResultSet rs = dbConBean.executeQuery(strSql);
     		if(rs.next()){
     		strTotalExpinUSD=rs.getString("FINAL_AMOUNT");
     		}
   			response.getWriter().write(strTotalExpinUSD); 
     }
    	//added by manoj chand on 07 oct 2012 to fetch exchange rate correspond to the given currency
    	if(!strFlag.equals("") && strFlag.equals("TotalinBaseCur")){
     	  String strTotalExpinBaseCur="0.00";
      		response.setContentType("text/html; charset=UTF-8");
      		strSql="SELECT DBO.[FN_CURRENCY_CONVERTOR]('"+strTotalExp+"','"+strSelCur+"','"+strBaseCur+"','"+strSelDate+"') AS FINAL_AMOUNT";
      		ResultSet rs = dbConBean.executeQuery(strSql);
      		if(rs.next()){
      		strTotalExpinBaseCur=rs.getString("FINAL_AMOUNT");
      		}
    		response.getWriter().write(strTotalExpinBaseCur); 
     } 
    	//added by manoj chand on 17 jan 2013 to make check for duplicate user registration.
        if(!strFlag.equals("") && strFlag.equals("CheckDuplicateUser")){
      		response.setContentType("text/html; charset=UTF-8");
      		strSql="SELECT RTRIM(dbo.SITENAME(SITE_ID)),RTRIM(mu.USERNAME) from dbo.M_USERINFO mu WHERE CONVERT(VARCHAR(10),DOB,103)='"+strDob+"' AND mu.FIRSTNAME='"+strFirstName+"' AND mu.LASTNAME='"+strLastName+"' AND mu.STATUS_ID <> 50";
      		ResultSet rs = dbConBean.executeQuery(strSql);
      		String strflag="",strsitename="",strusername="";
      		if(rs.next()){
      			strsitename=rs.getString(1);
      			strusername=rs.getString(2);
      			strflag=strsitename+"##"+strusername;
      		}
      		else{
      			strflag="N";
      		}
         	rs.close();
    		response.getWriter().write(strflag); 
     }
      //added by manoj chand on 23 jan 2013 to check whether user has some requests in movement before updating his workflow number.
        if(!strFlag.equals("") && strFlag.equals("CheckUserRequest")){
      		response.setContentType("text/html; charset=UTF-8");
      		strSql="SELECT CASE WHEN EXISTS(select * from T_TRAVEL_STATUS TTS INNER JOIN T_APPROVERS TA ON TTS.TRAVEL_ID=TA.TRAVEL_ID AND TTS.TRAVEL_TYPE=TA.TRAVEL_TYPE WHERE  TA.TRAVELLER_ID='"+strUserid+"' AND TTS.TRAVEL_STATUS_ID=2 AND TTS.STATUS_ID=10 AND TA.STATUS_ID=10) THEN 'Y' ELSE 'N' END AS REQSTATUS";
      		ResultSet rs = dbConBean.executeQuery(strSql);
      		String strflag="",strrequests="";
      		if(rs.next()){
      			strflag=rs.getString("REQSTATUS");
      		}
         	rs.close();
    		response.getWriter().write(strflag); 
     }
      //added by manoj chand on 05 feb 2013 to test web service.
        if(strFlag.equals("testWS")){
    			strXmlDoc="N";
    			String path=request.getParameter("path")==null?"":request.getParameter("path").trim();//travel id
    			WSClient ws = new WSClient();
    			//calling stars web service to test path
    			strXmlDoc = ws.testWSConnection(path);   			
    			//System.out.println("strXmlDoc>>>"+strXmlDoc);
    			response.setContentType("text/plain; charset=UTF-8");
    			response.getWriter().write(strXmlDoc);
    	}
        //added by manoj chand on 26 apr 2013 to get count of request for which tes is not submitted.
        if(strFlag.equals("checkTESRequestCount")){
        		strXmlDoc="N#0#0";
        		String strTravellerId=request.getParameter("travellerId")==null?"":request.getParameter("travellerId");
        		strSql="SELECT ISNULL(ERP_WS_URL,'') AS ERP_WS_URL from dbo.M_SITE ms INNER join dbo.M_COMPANY mc ON ms.COMPANY_ID=mc.CID WHERE ms.SITE_ID='"+strSiteId+"' and ms.STATUS_ID=10 and mc.STATUS_ID=10";
        		ResultSet rs = null;
        		rs = dbConBean.executeQuery(strSql);
          		String strErpUrl="";
          		if(rs.next()){
          			strErpUrl=rs.getString("ERP_WS_URL");
          		}
             	rs.close();
             	//System.out.println("strErpUrl--1 AM-->"+strSql);
             	if(!strErpUrl.equals("") && !strErpUrl.equals("temp"))
             	{
             		String strDateFrom = "2013-04-01";
             		String contextServerPath							=		PropertiesLoader.config.getProperty("serverPath");
             		FileInputStream propfile					    	=		new FileInputStream(contextServerPath+"STAR.properties");
             		if (propfile != null)
             		{
             			Properties starsprop = new Properties();
             			starsprop.load( propfile);
             			propfile.close();
             			strDateFrom =  starsprop.getProperty("date_from");
             		}	
             	/*	strSql="SELECT MS.TES_COUNT,COUNT(*) AS PEN_COUNT,CASE WHEN COUNT(1)<=MS.TES_COUNT THEN 'Y#'+CONVERT(VARCHAR(10),COUNT(*))+'#'+CONVERT(VARCHAR(10),MS.TES_COUNT) ELSE 'N#'+CONVERT(VARCHAR(10),COUNT(*))+'#'+CONVERT(VARCHAR(10),MS.TES_COUNT) END AS FLAG FROM (SELECT TTS.TRAVEL_ID,TTDI.SITE_ID,TTS.TRAVEL_TYPE"+ 
             			" FROM T_TRAVEL_STATUS TTS INNER JOIN T_TRAVEL_DETAIL_INT TTDI ON TTDI.TRAVEL_ID=TTS.TRAVEL_ID "+
             			" AND TTS.TRAVEL_TYPE='I' AND TTDI.STATUS_ID=10 WHERE TTDI.TRAVELLER_ID="+strTravellerId+" AND TTS.STATUS_ID=10"+ 
             			" AND TTS.TRAVEL_STATUS_ID IN (2,10) AND TTS.TES_FLAG='N' AND TTDI.Group_Travel_Flag='N' "+
             			" AND  CONVERT(VARCHAR(10),TTDI.C_DATETIME,20) BETWEEN '"+strDateFrom+"' AND CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,20)"+
             			" UNION ALL SELECT TTS.TRAVEL_ID,TTDD.SITE_ID,TTS.TRAVEL_TYPE FROM T_TRAVEL_STATUS TTS"+ 
             			" INNER JOIN T_TRAVEL_DETAIL_DOM TTDD ON TTDD.TRAVEL_ID=TTS.TRAVEL_ID AND TTS.TRAVEL_TYPE='D'"+ 
             			" AND TTDD.STATUS_ID=10 WHERE TTDD.TRAVELLER_ID="+strTravellerId+" AND TTS.STATUS_ID=10 AND TTS.TRAVEL_STATUS_ID IN (2,10)"+ 
             			" AND TTS.TES_FLAG='N' AND TTDD.Group_Travel_Flag='N' AND CONVERT(VARCHAR(10),TTDD.C_DATETIME,20) BETWEEN '"+strDateFrom+"' AND CONVERT(VARCHAR(10),CURRENT_TIMESTAMP,20)"+
						        " )DRV INNER JOIN M_SITE  MS ON MS.SITE_ID=DRV.SITE_ID"+ 
             			" WHERE DRV.SITE_ID="+strSiteId+"  GROUP BY MS.TES_COUNT ";*/
             			
             			//System.out.println("strErpUrl--2 AM-->"+strSql);
                //rs=null;
                //rs = dbConBean.executeQuery(strSql);
             		
             		Connection objCon =  dbConBean.getConnection();
             		CallableStatement cStmt = null;
               cStmt=objCon.prepareCall("{?=call SPG_CHK_PENDING_TES_COUNT(?,?)}");
               cStmt.registerOutParameter(1,java.sql.Types.INTEGER);
               cStmt.setString(2,strTravellerId);
               cStmt.setString(3,strSiteId);
               rs = cStmt.executeQuery();

               if(rs.next()){
             			strXmlDoc=rs.getString("FLAG");
             		}
             	}else{
             		strXmlDoc="A#0#0";
             	}
    			//System.out.println("strXmlDoc--->"+strXmlDoc);
    			response.setContentType("text/plain; charset=UTF-8");
    			response.getWriter().write(strXmlDoc);
    	}
      //added by manoj chand on 26 apr 2013 to update SID in m_userinfo by stars admin
        if(strFlag.equals("UpdateSID")){
        		String strDomain=request.getParameter("domain")==null?"":request.getParameter("domain");
        		String strWinuserid=request.getParameter("winuserid")==null?"":request.getParameter("winuserid");
        		int intStatus=5000;
        		try
        		{
        			Connection objCon =  dbConBean.getConnection();
        			CallableStatement cStmt = null;
        			cStmt=objCon.prepareCall("{?=call SPG_UPDATE_AD_SID(?,?,?)}");
        			cStmt.registerOutParameter(1,java.sql.Types.INTEGER);
        			cStmt.setString(2,strWinuserid.trim());
        			cStmt.setString(3,strDomain.trim());
        			cStmt.registerOutParameter(4,java.sql.Types.INTEGER);
        			cStmt.executeUpdate();
        			intStatus   =  cStmt.getInt(4);
        			//System.out.println("intStatus-ajaxmaster-->"+intStatus);
        			cStmt.close();
        			objCon.close();
        		}
        		catch(Exception e)	
        		{
        			System.out.println("Error in ajaxmaster.jsp========"+e);
        		}
    			response.setContentType("text/plain; charset=UTF-8");
    			response.getWriter().write(intStatus+"");
    	}
      
        //Added on 01 August 2013 by manoj chand
      	if (!strSiteId.equals("-1") && strSiteId != null && strreqpage.equalsIgnoreCase("assignrights"))
       	{
      		//System.out.println("strSiteId--accessrightts->"+strSiteId);
      		strXmlDoc="";
       		response.setContentType("text/html; charset=UTF-8");
       		strSql="SELECT USERID, dbo.user_name(USERID) as NAME FROM dbo.M_USERINFO mu WHERE mu.SITE_ID="+strSiteId+" and mu.STATUS_ID=10 ORDER BY NAME";
       		//System.out.println("strSql-->"+strSql);
       		ResultSet rs = dbConBean.executeQuery(strSql);
       		String strTrimName  ="",strUserID ="",strUserName="";
       	%>	
       	<option value=-1><%=dbLabelBean.getLabel("label.pageaccesspermission.selectuser",strlanguage1) %></option>
       	<%	while (rs.next())
       		{
       			strUserID = rs.getString(1);
       			strUserName = rs.getString(2);
       			strTrimName = strUserName;
       			if(strTrimName.length() > 30)
       				strTrimName = strTrimName.substring(0,30)+"..";
       			strXmlDoc +="";
      %>
      			<option alt="<%=strUserName%>"  value="<%=strUserID%>"><%=strTrimName.trim()%></option> 
      <%
       		}
       		rs.close();		
       		response.getWriter().write(strXmlDoc);
       	}
        //end if
      //Added on 26 August 2013 by manoj chand to check for reviewer exists for the given user or not.
      	if (!strSiteId.equals("") && !strSiteId.equals("-1") && strreqpage.equalsIgnoreCase("handoverrequest"))
       	{
      		String strHandoverUserid = request.getParameter("handoverfrom")==null?"":request.getParameter("handoverfrom");
      		strXmlDoc="N";
       		response.setContentType("text/html; charset=UTF-8");
    		String strMessage="";
    		strSql="SELECT VIEWTOUSER FROM VW_PAGE_ACCESS_PERMISSION WHERE VW_PAGE_ACCESS_PERMISSION.pendingWithUser='"+strHandoverUserid+"'"+
    				  " AND VW_PAGE_ACCESS_PERMISSION.SITE_ID='"+strSiteId+"' AND VW_PAGE_ACCESS_PERMISSION.status=10";
    		ResultSet rs = dbConBean.executeQuery(strSql);
    		if(rs.next()){
    			strXmlDoc="Y";
    		}
    		rs.close();	
       		response.getWriter().write(strXmlDoc);
       	}
       
      	//Added by Manoj Chand on 28 Oct 2013 to get flag for user role against the url.
        if(strreqpage.equalsIgnoreCase("RoleResourceCheck")){
			response.setContentType("text/plain; charset=UTF-8");
			String strURLToCheck=request.getParameter("pageUrl")==null?"":request.getParameter("pageUrl").toString().trim();
			String rolesExist=roleBean.getRolesList(strURLToCheck).toString().trim();
			String strReturnType="Y";
			HttpSession hs = request.getSession(false);
			String strUserRole = (String)hs.getValue("userRole");
			String strUserRole1= (String)hs.getValue("userRoleOther");
			if(rolesExist!=null && !rolesExist.equals("")){
				rolesExist=","+rolesExist+",";
				if(rolesExist.contains(","+strUserRole+",") || rolesExist.contains(","+strUserRole1+",")){	
					strReturnType="Y";
				}else{
					strReturnType="N";
				}
			}
			else{
				strReturnType="Y";
			}
			response.getWriter().write(strReturnType);
		}
        if(strFlag.equals("capchaCodeToServer")){
  	      String code = request.getParameter("code");
  	      int intInvalidCount=Integer.parseInt(session.getAttribute("loginFailureCount")==null?"0":session.getAttribute("loginFailureCount").toString());
  	      //System.out.println("intInvalidCount--ajax->"+intInvalidCount);
  	      HttpSession hs = request.getSession(true);
  	       if(intInvalidCount >= 3){
     	      hs.setAttribute("verificationCode",code);
  	       }else{
  	    	   hs.setAttribute("verificationCode",null);
  	       }
  		}
        
        //Added on 08 May 2014 by Gurmeet Singh for "Person Wise Destination Report" and "Travel Report" page.
        if (!strSiteIdooo.equals("") && strSiteIdooo != null && strreqpageooo.equalsIgnoreCase("showReportData"))
       	{
      		response.setContentType("text/html; charset=UTF-8");
      		if(strSiteIdooo.equals("0"))
 	    		strSql="SELECT  USERID, FIRSTNAME, LASTNAME,RTRIM(dbo.SITENAME(site_id)) as SITE  FROM   M_USERINFO WHERE STATUS_ID = 10 order by 2";
 	    	else
				strSql="SELECT  USERID, FIRSTNAME, LASTNAME FROM M_USERINFO WHERE Site_ID="+strSiteIdooo+" and  (STATUS_ID = 10) order by 2";
       		//System.out.println("strSql--->"+strSql);
      		ResultSet rs = dbConBean.executeQuery(strSql);
        	String strUseridt= "",strFName= "",strLName="", strTrimName="",strOriginalName="",strSiteName="";
        	%>
        	<option value="0"><%=dbLabelBean.getLabel("label.report.allperson",strlanguage1) %></option>
        	<%
        	if(strSiteIdooo.equals("0")){
	     	   		while(rs.next())
					{
		             strUseridt=rs.getString("USERID");    
					 strFName=rs.getString("FIRSTNAME");  
					 strLName=rs.getString("LASTNAME");
				 	 strSiteName=rs.getString("SITE");
				 	 strTrimName=strFName+" "+strLName+" ("+strSiteName+")";
				 	 strOriginalName=strTrimName;
					 if(strTrimName.length() > 30)
		       				strTrimName = strTrimName.substring(0,30)+"..";
		            %>
					<option title="<%=strOriginalName%>" value="<%=strUseridt%>"><%=strTrimName%></option> 
					 <%
					 }
		        	rs.close();
     	   	 }else{
	        	while(rs.next())
				{
	             strUseridt=rs.getString("USERID");    
				 strFName=rs.getString("FIRSTNAME");  
				 strLName=rs.getString("LASTNAME");
				 strTrimName=strFName+" "+strLName;
				 strOriginalName=strTrimName;
				 if(strTrimName.length() > 30)
	       				strTrimName = strTrimName.substring(0,30)+"..";
	            %>
				<option title="<%=strOriginalName%>" value="<%=strUseridt%>"><%=strTrimName%></option> 
				 <%
				 }
	        	rs.close();
     	   	 }
       	}// complete showReportData block.
       	
        //Added on 08 May 2014 by Gurmeet Singh for "Handover Request" page.
        if (!strSiteIdooo.equals("") && strSiteIdooo != null && strreqpageooo.equalsIgnoreCase("handoverReq"))
       	{
      		response.setContentType("text/html; charset=UTF-8");
      			strSql="SELECT  USERID, FIRSTNAME, LASTNAME FROM M_USERINFO WHERE Site_ID="+strSiteIdooo+" and  (STATUS_ID = 10) order by 2";
       		//System.out.println("strSql--->"+strSql);
      		ResultSet rs = dbConBean.executeQuery(strSql);
        	String strUseridt= "",strFName= "",strLName="", strTrimName="",strOriginalName="",strSiteName="";
        	%>
        	<option value="-1"><%=dbLabelBean.getLabel("label.outofoffice.selectperson",strlanguage1) %></option>
        	<%
        	while(rs.next())
				{
	             strUseridt=rs.getString("USERID");    
				 strFName=rs.getString("FIRSTNAME");  
				 strLName=rs.getString("LASTNAME");
				 strTrimName=strFName+" "+strLName;
				 strOriginalName=strTrimName;
				 if(strTrimName.length() > 30)
	       				strTrimName = strTrimName.substring(0,30)+"..";
	            %>
				<option title="<%=strOriginalName%>" value="<%=strUseridt%>"><%=strTrimName%></option> 
				 <%
				 }
	        	rs.close();     	   	 
       	}// complete handoverReq block 
       	
       	if (!strSiteId.equals("") && !strSiteId.equals("-1") && (strSiteId != null) && !strsprole.equals("") && (strsprole != null) && strreqpage.equalsIgnoreCase("checkWorkflowExistance"))
       	{	
       		response.setContentType("text/html; charset=UTF-8");
       		
       		strSql="SELECT�1 FROM�M_DEFAULT_APPROVERS�WHERE�SP_ROLE="+strsprole+"�AND�SITE_ID="+strSiteId+"�AND�STATUS_ID=10 and APPLICATION_ID=1";
       		ResultSet rs = dbConBean.executeQuery(strSql);
       		
       		String workflowFlag = "false";
       		
       		if(rs.next()){
       			workflowFlag = "true";
       		}
       		
       		response.getWriter().write(workflowFlag);
       	}
      dbConBean.close();
      %>