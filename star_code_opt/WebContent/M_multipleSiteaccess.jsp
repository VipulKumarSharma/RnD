	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:SHIV SHARMA 
	 *Date of Creation 		:10 JUN 2009
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is first jsp file  for Add & SHOW UNIT FOR USER THOSE HAVE MULTIPLE UNIT ACCESS  
	 *Modification 			:
	 *Reason of Modification: 
	 *Date of Modification  :
	 *Modified By			:
	 *Revision History		:
	 *Editor				:Editplus
	 *******************************************************/ 
	%>
	<%@ page pageEncoding="UTF-8" %>
	<%

	String strUserid=request.getParameter("userId"); 
	String strFlag =request.getParameter("flag"); 
	
	%>
	<%@ include  file="importStatement.jsp" %>
	<html>
	<head>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %> 
	<%-- include page styles  --%> 
	<%-- <%@ include  file="systemStyle.jsp" %> --%>
	
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<script>
		 
	function goback()
	{
	    history.go(-1);
	}
		
	function showunits() 
	  {
	 
       var unit=document.frm.unitList.value;          	
       var var2='<%=strUserid%>';  
       if(unit!=''){
       var url="M_multipleSiteaccess_post.jsp?unit="+unit+"&userid="+var2+"&action=add";        
        document.frm.action=url; 
  	    document.frm.submit();
  	    }else{
  	     alert('<%=dbLabelBean.getLabel("alert.master.pleaseselectunittoadd",strsesLanguage)%>');  
  	    }
  	  
	}
	
	function deleteunits()
	 {
	   var unit=document.frm.unitList2.value;  	
       if(unit!='')
       {
		       var var2='<%=strUserid%>'; 
		       var url="M_multipleSiteaccess_post.jsp?unit="+unit+"&userid="+var2+"&action=del";      
		        document.frm.action=url;
		  	    document.frm.submit();
       }else{
         alert('<%=dbLabelBean.getLabel("alert.master.pleaseselectunittodelete",strsesLanguage)%>');
         
       }
      
	}

	function saveEntries(){
			 if(confirm('<%=dbLabelBean.getLabel("alert.master.areyousureyouwanttosavetheselectedunits",strsesLanguage)%>') ) 
              {		 var var2='<%=strUserid%>';
			 		 var url="SaveList.jsp?userid="+var2+"&action=save";       
					 document.frm.action=url;
					 document.frm.submit();
			 }else{
					 var var2='<%=strUserid%>';
					 var url="SaveList.jsp?userid="+var2+"&action=remove";        
					 document.frm.action=url;
					 document.frm.submit();
			 } 
	}
	
	function CloseEntries(){
	  
	   if(confirm('<%=dbLabelBean.getLabel("alert.master.areyousureyouwanttocloseanyunsaveddatamaybelost",strsesLanguage)%>') )
	   {  
		 var var2='<%=strUserid%>'; 
		 var url="SaveList.jsp?userid="+var2+"&action=remove";       
		 document.frm.action=url;
		 document.frm.submit();
		 javascript:top.window.close();
		 }
		 else{
		 
		 
		 }
		 
	}
	
	function cleartempList(){
		 var var2='<%=strUserid%>';
		 var url="SaveList.jsp?userid="+var2+"&action=removetemp";       
		 document.frm.action=url;
		 document.frm.submit();
	
	}
 	</script>
	</head>
	<% 
	// Variables declared and initialized
	
	String strTravelType   =  "";
	String strWhichPage    =  "";
	String strTargetFrame  =  "";
	String strTargetFlag   =  "";
	
	
	
	// Variables declared and initialized
	Connection con	=	null;			    // Object for connection
	Statement stmt	=	null;			   // Object for Statement
	ResultSet rs	=	null;			  // Object for ResultSet
	//Create Connection
	Class.forName(Sdbdriver);
	con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
	
	String	sSqlStr                             =   ""; // For sql Statements
	String strRequisitionId                		=	"";
	
	int iCls = 0;
	String strStyleCls                          =   "";
	String	strNewReqNo		    				= 	"";
	String	strName								=	"";
	String	strAmount							=	"";
	String	strCurrency							=	"";
	String	strOriginatedBy		     			=	"";
	String	strOriginatedOn			    		=	"";
	String	strTravel_From						=	"";
	String	strTravel_To						=	"";
	String strGroupTravelFlag				=""; 
	%>
		
	<body>  
	<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="77%" height="38" class="bodyline-top"> 
		<ul class="pagebullet">
	      <li class="pageHead"><b><%=dbLabelBean.getLabel("label.master.addunitaccess",strsesLanguage)%> </b></li>   
	    </ul></td>
	      <td width="23%" align="right" valign="bottom" class="bodyline-top">
		  <table width="39%" align="right" border="0" cellspacing="0" cellpadding="0">
	        <tr align="right">
	        <td width="48%" align="right" valign="bottom">
	        <ul id="list-nav">
	        <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%></a></li>
	        </ul>
	        </td>
	      </tr>
	    </table> 
		</td>
	  </tr>
	</table>
	
	 <form name=frm  action="M_multipleSiteaccess_post.jsp" method=post>  
	  <input type=hidden name=purchaseRequisitionId value="<%=strRequisitionId%>"> 
	  <input type="hidden" name=travel_type value="<%=strTravelType%>"/>      
	  <input type="hidden" name=whichPage value="<%=strWhichPage%>"/>      
	  <input type="hidden" name=targetFrame value="<%=strTargetFlag%>"/>          
 
 		<%
			String  strSiteName			="";
			String straddedBy   		="";
			String 	strsiteid   		="";
			String  strSiteName1   		="";
			String userName		   		="";	
			
			 Connection objCon					=  null;     
		     CallableStatement objCstmt			=  null;  
		     objCon               				=  dbConBean.getConnection(); 
		     
			if(strFlag!=null && strFlag.equals("yes")){
				  objCstmt  =  objCon.prepareCall("{?=call PROC_USER_SITE_ACCESS_ACTION(?,?)}");  
				  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			      objCstmt.setString(2, "removetemp"); 
			      objCstmt.setString(3, strUserid);        
			      int iSuccess1   =  objCstmt.executeUpdate();  
			      objCstmt.close();	
			}
			
			String strSql="SELECT FIRSTNAME + ' ' + LASTNAME AS USERNAME FROM  M_USERINFO WHERE (USERID = "+strUserid+")";   
	  		rs = dbConBean.executeQuery(strSql); 
 			while(rs.next()){
				userName=rs.getString("USERNAME");
			}
			rs.close();
	%> 

	
	<table width="75%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">  
		<tr width="100%" class="formhead">   
		 <td colspan=4 align="left" valign="top"><%=dbLabelBean.getLabel("label.master.selectavailableunitstoprovideaccessto",strsesLanguage)%> <b><%=userName %></b> </td>  
		</tr>
		
		<tr width="100%" class="formhead">
		 <td class="listhead" width="15%" align="left" valign="top"><%=dbLabelBean.getLabel("label.master.availableunits",strsesLanguage)%> </td>    
		 <td width="2%" ></td> 
		 <td class="listhead" width="15%" align="left" valign="top"><%=dbLabelBean.getLabel("label.master.accessibleunitsto",strsesLanguage)%> <%=userName %> </td>
		</tr>
		 
		<tr class="formhead">
			<td class="listhead" width="15%" align="left" valign="top"> 
			
			<select name="unitList" class="textBoxCss" multiple size="20"   >    
			  <%
			   strSql="SELECT  SITE_ID, SITE_NAME  FROM  M_SITE WHERE (STATUS_ID = 10) AND SITE_ID NOT IN "+ 
				            " (SELECT     M_SITE_1.SITE_ID FROM  USER_SITE_ACCESS AS USA INNER JOIN "+
				            " M_SITE AS M_SITE_1 ON USA.SITE_ID = M_SITE_1.SITE_ID WHERE  (USA.STATUS_ID = 10) and  USA.USERID = "+strUserid+") order by SITE_NAME";
			   
			  rs = dbConBean.executeQuery(strSql);
			  while(rs.next())
			   {
				  strsiteid      =rs.getString("Site_id"); 
				  strSiteName1  =rs.getString("Site_name");   	  
				 %>
				  <option  value=<%=strsiteid%> > <%=strSiteName1%> </option>     
               <%
			  }
			  
			  rs.close();
			  %>
       	 </select>
			</td>
			
			<td width="2%" ><input type="Button" value="    >    " onclick="showunits();" ><br><br>
			<br> 
			<input type="Button" value="    <    " onclick="deleteunits();" >
			 </td>   
			
			<td class="listhead" width="15%" align="left" valign="top">
			
			<select name="unitList2" class="textBoxCss" multiple size="20" >   
			
			  <%
			    // strSql="select Site_id,Site_name from M_site where status_id=60"; 
			  	String strCdate="";  
			  
				sSqlStr="SELECT   M_SITE.SITE_ID AS SITE_ID,M_SITE.SITE_NAME AS SITE_NAME,dbo.CONVERTDATE(USA.C_DATE) as C_DATE  FROM USER_SITE_ACCESS AS USA INNER JOIN "+ 
	              " M_SITE ON USA.SITE_ID = M_SITE.SITE_ID WHERE     (USA.STATUS_ID = 10) and (USA.USERID = "+strUserid+") order by SITE_NAME";   
			  
			      rs = dbConBean.executeQuery(sSqlStr);
			  
			  ///System.out.println("strSql==>>"+strSql);  
			  
			  while(rs.next())
			   {
				  
				  strsiteid      =rs.getString("SITE_ID");  
				  strSiteName1   =rs.getString("SITE_NAME");   
				  strCdate		 =rs.getString("C_DATE");    	
				 %>
				  <option  value=<%=strsiteid%>  > <%=strSiteName1%> - <%=strCdate%> </option>          
               <%
			  }
			  
			rs.close();
			
			
			  sSqlStr="SELECT   M_SITE.SITE_ID AS SITE_ID,M_SITE.SITE_NAME AS SITE_NAME  FROM USER_SITE_ACCESS AS USA INNER JOIN "+ 
              		  " M_SITE ON USA.SITE_ID = M_SITE.SITE_ID WHERE     (USA.STATUS_ID = 15) and (USA.USERID = "+strUserid+") order by SITE_NAME";   
			
 		      		
		  
			  		rs = dbConBean.executeQuery(sSqlStr);
			  		
				 	 while(rs.next())
						   {
							  
							  strsiteid      =rs.getString("SITE_ID");  
							  strSiteName1  =rs.getString("SITE_NAME");   	  
							 %>
							  <option  value=<%=strsiteid%> style="background-color:yellow" > <%=strSiteName1%> </option>       
				             <%
						  }
			  %>
			   
           		<option  value="1" > &nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; </option>   
			 
			 </select>
			
			
			</td>
		  </tr>
		  <tr class="formhead"> 
				 <td colspan=4 align="center" valign="top"><input type="button" value=" <%=dbLabelBean.getLabel("button.global.save",strsesLanguage)%> " onclick="saveEntries();" > &nbsp; &nbsp; &nbsp; <input type="button" value=" <%=dbLabelBean.getLabel("button.global.close",strsesLanguage)%> " onclick="CloseEntries();" ></td>       
		  </tr>
	 
	  </table>
	
	<!-- END MODIFICATION-->
	
	
	
	</form>
	  
	</body>
	</html>
	
