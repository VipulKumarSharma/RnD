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

 *******************************************************/
%>

 
 <jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.Date,java.text.*,javax.mail.*,javax.mail.internet.*,javax.activation.*,java.util.*,java.text.*" 
%>

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
   //end
   /*
   if (userAge.equals("")){
      userAge="getdate()";
   }

*/
   //userAge="10/10/2005";

 

        if(userAge != null  &&  !userAge.equals("") ) {
          strSql = "SET DATEFORMAT  DMY SELECT dbo.CALAGE_YYMMDD('"+userAge+"',GETDATE())";

		   
             ResultSet rs = dbConBean.executeQuery(strSql);

	         while(rs.next())
				{
                strAge =rs.getString(1);  
				}
   			rs.close();
   		System.out.println("-------------user Age----------"+strAge);
		strXmlDoc="<message>"+strAge+"</message>";

	 
		//System.out.println("strXmlDoc----------->"+strXmlDoc);
	    response.getWriter().write(strXmlDoc);
	 } 
	 else {	
		 //nothing to show
		// response.setStatus(HttpServletResponse.SC_NO_CONTENT);
				
		 } 
        
        
        //Added on 31 jan 2011 by manoj
      	if (!strSiteId.equals("-1") && strSiteId != null && strreqpage.equalsIgnoreCase("abc"))
       	{
       		System.out.println("-----------here----------");
       		response.setContentType("text/html; charset=UTF-8");
       		strXmlDoc="<option value=\"\">Select</option>";
       		strSql="SELECT dbo.user_name(dbo.finalooo(USERID,getdate(),'"+strTravelType+"')),USERID,.DBO.USER_NAME(USERID) FROM M_USERINFO WHERE STATUS_ID=10 AND SITE_ID='"+strSiteId+"' and userid != '" + strUserid +"' ORDER BY 3";
       		// System.out.println("strSql-----/--->"+strSql);
       		ResultSet rs = dbConBean.executeQuery(strSql);
       		String strTrimName  ="",strVal ="",strAlt="";
       		while (rs.next())
       		{
       			strAlt = rs.getString(1);
       			strVal = rs.getString(2);
       			strTrimName = rs.getString(3);
       			if(strTrimName.length() > 30)
       				strTrimName = strTrimName.substring(0,30)+"..";
       			strXmlDoc +="";
      %>
      			<option alt="<%=strAlt%>"  value="<%=strVal%>"><%=strTrimName%></option> 
      <%
       		}
       		rs.close();
       		//strXmlDoc = "<option>" + strAge + "</option>";
       		//strXmlDoc = "<option value=2>jgkdj</option>";
      		//System.out.println(strXmlDoc); 		
       		response.getWriter().write(strXmlDoc);
       	}
     %>
        
	 