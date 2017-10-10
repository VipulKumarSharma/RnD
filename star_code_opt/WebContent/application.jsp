<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:25 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			: 
 *Reason of Modification: 1: added code for seting flage to set visio corp user on 01-Sep-09
						  2://added new to flag to configure dynamic workflow of SMR sites 
 *Date of Modification  :1.02-May-2007 
 *Modification By		:1.Gaurav Aggarwal
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			: Manoj Chand
 *Modification			: Gender added in session object
 *Date of Modification	: 07 August 2012
 
 *Modified By			: Manoj Chand
 *Modification			: Remove nullpointer exception comes by Ssid.equals() method when Ssid=null
 *Date of Modification	: 18 Jan 2013
 *******************************************************/
%>


<%@ include  file="importStatement.jsp" %> 
<%

			HttpSession hs							=		request.getSession(false);

			//Object to store session data
			String Sdbuser							=		null;
			String Sdbpwd							=		null;
			String Sdburl							=		null;
			String Sdbdriver						=		null;
			//String Sdate_format					=		null;
			String Ssmtp_server						=		null;
			//String Sno_of_rows					=		null;
			//String Sdefault_currency				=		null;
			//String Spo_percentage					=		null;
			//String Ssanction_percentage			=		null;
			//String Sattachment_size				=		null;
			//String Sdecimal						=		null;
			//String Sfinancial_year_start_date		=		null;
			//String Sfinancial_year_end_date		=		null;
			//String Ssanction_capex_limit			=		null;
			//String Ssanction_revex_limit			=		null;
			String Sfile_path						=		null;
			//String Serror_mail_receipent			=		null;
			String Suser							=		null;
			String SsCss1							=		null;
			String SsCss2							=		null;
			String Suser_id							=		null;
			String	 Ssid							=		null;
			String SuserRole						=		null;
			String sUserFirstName					=		null;
			String sUserLastName					=		null;
			String strDivIdSS						=		null;
			String strSiteIdSS						=		null;
			String strDeptIdSS						=		null;
			String strDesigIdSS						=		null;
			//String strFMDesigId						=		null;
			String strLoginDateTime					=		null;
			String strDesigShortName				=		null;
			String strDepartShortName				=		null;
			String strCurrentYear					=		null;
			String Sfile_path1						=		null;
			String SmailUrl							=		null;
			String strUserPass						=		null;
			String strDesigFullName                 =       null;
			String strSiteFullName                  =       null;
			//new
			String SuserRoleOther                   =       null;   //for find the local administrator(LA)
			String SpolicyPath                      =       null;
			String SglobalApproverRole				=       null;
			String ssflage							=       null;   //added new to identify visio corp user 
			String SSstrSplRole						=       null;    
			String strsesLanguage					=	"";
			//
			String sGender="";

			//Retireve Session Data	
			Ssid								=		(String)hs.getValue("sid");
			
			
			Sdbuser								=		(String)hs.getValue("dbuser"); 
			Sdbpwd								=		(String)hs.getValue("dbpwd");
			Sdburl								=		(String)hs.getValue("dburl");
			Sdbdriver							=		(String)hs.getValue("dbdriver");
			//Sdate_format						=		(String)hs.getValue("date_format");
			Ssmtp_server						=		(String)hs.getValue("smtp_server");
			//Sno_of_rows							=		(String)hs.getValue("no_of_rows");
			//Sdefault_currency					=		(String)hs.getValue("default_currency");
			//Spo_percentage						=		(String)hs.getValue("po_percentage");
			//Ssanction_percentage				=		(String)hs.getValue("sanction_percentage");
			//Sattachment_size					=		(String)hs.getValue("attachment_size	");
			//Sdecimal							=		(String)hs.getValue("decimal");
			//Sfinancial_year_start_date		    =		(String)hs.getValue("financial_year_start_date");
			//Sfinancial_year_end_date			=		(String)hs.getValue("financial_year_end_date");
			//Ssanction_capex_limit				=		(String)hs.getValue("sanction_capex_limit");
			//Ssanction_revex_limit				=		(String)hs.getValue("sanction_revex_limit");
			//Sfile_path							=		(String)hs.getValue("file_path");
			//Serror_mail_receipent				=		(String)hs.getValue("error_mail_receipent");
			Suser								=		(String)hs.getValue("user");
            SsCss1								=		(String)hs.getValue("sCss1");
			SsCss2								=		(String)hs.getValue("sCss2");
			Suser_id							=		(String)hs.getValue("user_id");
			SuserRole							=		(String)hs.getValue("userRole");
			//System.out.println("Suser_id==============="+Suser_id);  
			// System.out.println("SuserRole==============="+SuserRole);  

			SuserRoleOther                      =		(String)hs.getValue("userRoleOther");//for find the local administrator(LA)    
			//SpolicyPath                         =       (String)hs.getValue("policy_path");
			//changed by manoj chand to fetch company policy path from external star.properties file
			SpolicyPath                         =       (String)hs.getValue("companyPolicyPath");
			
			SglobalApproverRole                 =       (String)hs.getValue("golbalApproverRole");       
			//		System.out.println("SglobalApproverRole==="+SglobalApproverRole);
			// System.out.println("SpolicyPath==============="+SpolicyPath);  
			
			sUserFirstName						=		(String)hs.getValue("sUserFirstName");
			sUserLastName						=		(String)hs.getValue("sUserLastName");
			strDivIdSS							=		(String)hs.getValue("strDivId");
			strSiteIdSS	 						=		(String)hs.getValue("strSiteId");
			//System.out.println("strSiteIdSS==============="+strSiteIdSS);
			strDeptIdSS							=		(String)hs.getValue("strDeptId");
			strDesigIdSS						=		(String)hs.getValue("strDesigId");
			//strFMDesigId						=		(String)hs.getValue("fm_desig_id");
			strLoginDateTime					=		(String)hs.getValue("strLoginDateTime");
			strDesigShortName					=		(String)hs.getValue("strDesigShortName");
               
            strDesigFullName	 				=		(String)hs.getValue("strDesigFullName");
			strSiteFullName                     =       (String)hs.getValue("strSiteFullName");     
			strDepartShortName					=		(String)hs.getValue("strDepartShortName");
			strCurrentYear						=		(String)hs.getValue("strCurrentYear");
			//Sfile_path1							=		(String)hs.getValue("file_path1");
			SmailUrl							=		(String)hs.getValue("mailUrl");
			strUserPass							=		(String)hs.getValue("strUserPass");
			
			

            // added flage for identifing visio corp user on 12 aug  2009 
			ssflage							    =		(String)hs.getValue("ssflage");
            
			// added NEW FOR SMR FRANCE FOR WORKFLOW CONFIGURATION on 12 aug  2009
			
			 SSstrSplRole							    =		(String)hs.getValue("SSstrSplRole");
			//added by manoj chand on 22 may 2012
			 strsesLanguage								=		(String)hs.getValue("sesLanguage");
			//System.out.println("strsesLanguage--application.jsp--->"+strsesLanguage);
			sGender=(String)hs.getValue("sGender");
			// Session Check

			String sessionid	=	hs.getId();
			//System.out.println("hs.isNew()="+hs.isNew()+"=Inside Application.jsp==="+hs+"=Ssid="+Ssid+"=sessionid="+sessionid+"==request.getRequestedSessionId()=="+request.getRequestedSessionId());
			
			
           	
			String strMailCreatedate=""; 

             Date currentDateformail = new Date();
			
			SimpleDateFormat sdfformail = new SimpleDateFormat("dd MMM yyyy  kk:mm");//@ Vijay 30-Mar-2007 Change date format 
			String strCurrentDateformail = (sdfformail.format(currentDateformail)).trim();
		  

          //System.out.println("-------------3/19/2007---------------"+strCurrentDate1);

		  strMailCreatedate=strCurrentDateformail;  
  
 


try
	{		
	//changed by manoj chand on 18 Jan 2012 remove nullpointer exception comes by Ssid.equals() method when Ssid=null
	if(!sessionid.equals(Ssid))
	{			
%>
			<jsp:forward page="sessionExpired.jsp">
				<jsp:param name="flag" value="n"/>
			</jsp:forward>
<%		}						  
	}
	catch ( Exception e)
	{
		e.printStackTrace();
		System.out.println("in catch"+e);
%>
		<jsp:forward page="sessionExpired.jsp">
			<jsp:param name="flag" value="n"/>
		</jsp:forward>
<%	
	}
%>