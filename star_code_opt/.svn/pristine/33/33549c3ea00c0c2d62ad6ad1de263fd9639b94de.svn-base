<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:13 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			    :This jsp is used 
 *Modification 			    : 1.
                                      2.  Added New Code For   Showing Duration  And Travel Type For Reports,
									  3.  code added  for showing site name in reports
									  4  code changed  & Functions(Monthwise_Total_Requests_Onesite, Monthwise_Total_Requests_Allsite ) Changed for              selection of record for monthly report on 02-Jul-07 by Shiv 
									  5. Query changed for changed the format of  C_DateTime  in selection criteria  by shiv   on 09-Jul-07


 *Reason of Modification: The Date is display yearly
                                          3.suggested by Anurag aggrawal
 *Date of Modification  : 1.14-Mar-2007
                                      2.  15-May-07 BY SHIV  
									  3. 16-May-07  By Shiv 

 *Revision History		:
 *Editor				:Editplus
*******************************************************/
%>

<%@ page import = "src.connection.DbConnectionBean" pageEncoding="UTF-8"%>
<%@ include file="importStatement.jsp" %>

<% DbConnectionBean bean = new DbConnectionBean(); %>
<%@ page import ="java.sql.*"%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<!--  errorPage="error.jsp"  -->
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
</HEAD>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>



<%
// Creating the connection 
	  
	Connection con= null;
	// for showing all or site id report 
	String strUnitHidden="";  String strSelectUnit="";
	String strAppendQuery="";
	strUnitHidden = request.getParameter("UnitHidden");

	 //added by shiv on 3/8/2007 
    strSelectUnit = request.getParameter("SelectUnit");
	strUnitHidden=strSelectUnit;

	if(strUnitHidden.equals("0"))
	{
	strAppendQuery="";
	}
	else
	{
	strAppendQuery="AND TM.SITE_ID="+strUnitHidden;
	}
	int iCls = 0;
	String strStyleCls = "";
	int hiddenFlag=0; // for strHidden 
	int iCount=1;
	String sqlStrQuarterly="";
	String sqlStrHalfYearly="";
	ArrayList quartelyreport = new ArrayList();
	ArrayList yearlyyreport = new ArrayList();
	String Arrray1[] = new String[20];
	//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	//con = DriverManager.getConnection("jdbc:odbc:star","sa","");
	//Statement stmt = con.createStatement();
	//con.setAutoCommit(true);
	String [] arrMonths = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
	String strchkData	= request.getParameter("chkData"); // to get monthly ,quartely,yearly
	String strPieHidden = request.getParameter("PieHidden"); // PieHidden value to view Pie Report or Simple
	if(strPieHidden.equals("Manual"))
	{
	hiddenFlag =1;
	}
	
	int maxLimit=0;
	//System.out.println(strchkData);
	String strCategory = request.getParameter("Category"); // to get category both,domestic,international
	//System.out.println("category>> "+ strCategory);
	
	String strfromDate = request.getParameter("from"); // get date from
	// to store old date 
	String Reportto = request.getParameter("reportType");
	String  strTo      =request.getParameter("to");
	String yearlyvalue="";
	//String yearlyvalue = request.getParameter("yearlyvalue");
	
	String strYearly=request.getParameter("Yearly");           

	//add by shiv on 29-Jun-07 for adding  year range for Showing Report 
	String strYearlyFrom=request.getParameter("Yearlynew");  
    String strYearlyTo=request.getParameter("Yearlynext"); 
	yearlyvalue=strYearly;
    //

	String strdisplaydate                 ="";
	String HeadingDisplay               ="";
    String strReportType                 ="";
	String strSql	                           =""; 
	String strSitename                     ="";
	
	int s = Integer.parseInt(strYearly);
	s=s+1;
    String yearlyvalue1			= new String(new Integer(s).toString());
	
    /// 
	String strLastYearforReport="";
	int ss = Integer.parseInt(strYearlyTo);
	ss=ss+1;
	strLastYearforReport	= new String(new Integer(ss).toString());
	////
			   if(strYearly.equals("-1"))
				{
				  strYearly=strYearlyFrom;  
				}
  
   ///code added by shiv on 16-May-07 for showing site name in reports open 
	           if(strUnitHidden.equals("0")) 
				{
				 strSitename=dbLabelBean.getLabel("label.report.forallunits",strsesLanguage);
				 }
	            else
		              {
						 strSql="select isnull(dbo.sitename("+strUnitHidden+"),'') as sitename from M_site where status_id=10" ;  
						 ResultSet rs4 = dbConBean.executeQuery(strSql);
								while(rs4.next())
								{
									   strSitename=rs4.getString("sitename");  
								}
								rs4.close();
						   strSitename= " IN " + strSitename  ;   
		            }  
     
   	///code added by shiv on 16-May-07 for showing site name in reports close 

   /// code added by shiv on  15-May-07 open 

			if(strCategory.equals("3")) 	// International
							{
								strReportType=dbLabelBean.getLabel("label.report.international",strsesLanguage);
								if(ssflage.equals("3")){
									strReportType = "Intercont";
								 }
							}
			if(strCategory.equals("2")) 	// International
							{
								strReportType=dbLabelBean.getLabel("label.report.domestic",strsesLanguage);
								if(ssflage.equals("3")){
									strReportType = "Domestic/Europe";
								 }
							}

			if(strchkData.equals("1"))
							{
							  strdisplaydate=" ( "+dbLabelBean.getLabel("label.report.between",strsesLanguage) +strfromDate +" - "+strTo+") ";

							 }
			else if(strchkData.equals("2"))
							{
								  strdisplaydate=" ("+dbLabelBean.getLabel("label.report.quarterlyreportfor",strsesLanguage) +yearlyvalue +" - "+yearlyvalue1+") ";
							}
			 else if(strchkData.equals("3"))
							{
								 strdisplaydate=" ("+dbLabelBean.getLabel("label.report.halfyearlyreportfor",strsesLanguage)  +yearlyvalue +" - "+yearlyvalue1+") ";
							}
			 else if(strchkData.equals("4"))
							{
								  strdisplaydate="("+dbLabelBean.getLabel("label.report.yearlyreportfor",strsesLanguage)  +strYearlyFrom +" - "+strLastYearforReport +") ";
								  // code changed by shiv on 29-Jun-07 for  Showing  Selected   Year for Report  
							}
			///code added by shiv on  15-May-07 close 
	
	%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="70%" height="45" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"> <b> <%=dbLabelBean.getLabel("label.report.travelreportfor",strsesLanguage) %>  <%= strReportType%>  <%=dbLabelBean.getLabel("label.report.travelrequisitions",strsesLanguage) %>  <%=strSitename %>  <%=strdisplaydate%>      </b></li>
           </ul></td>
                <!--	<td width="23%" align="right" valign="bottom" class="bodyline-top">
				  <table width="39%" align="right" border="0" cellspacing="0" cellpadding="0">
				  <tr align="right">
					 <td width="48%" align="right"><a href="#" onClick="javascript:top.window.close();"><img src="images/IconClose.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
					<td width="48%" align="right"><a href="#" onClick="window.print();"><img src="images/IconPrint.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
				  </tr>
				</table>
				</td> -->
			  </tr>
</table> 
	<%

	int countMonthlyTokens=0; // for montly
	
	int monthTo=0;
	int yearTo=0;
	int dateTo=0;
	int monthFrom=0;
	int yearFrom=0;
	int dateFrom=0;
	int calMonth=0;

	 String strYearToymd="";
     String strYearFromymd="";

	String strfromOldDate="";
	String strToDate = request.getParameter("to");  // get Date to
	
	               if(strchkData.equals("1")) { 
						 monthTo =Integer.parseInt(strToDate.substring(3,5));
						 yearTo =Integer.parseInt(strToDate.substring(6,10));
						 dateTo =Integer.parseInt(strToDate.substring(0,2));
              
						 monthFrom =Integer.parseInt(strfromDate.substring(3,5));
						 yearFrom =Integer.parseInt(strfromDate.substring(6,10));
						 dateFrom =Integer.parseInt(strfromDate.substring(0,2));


						 calMonth= 0;
							if(yearTo >yearFrom){
								calMonth= ((yearTo-yearFrom-1)*12)+ 12-monthFrom + monthTo +1;
							}else if(yearTo == yearFrom){
								calMonth = monthTo-monthFrom+1;
							}
                  

				    }
	 
	String sqlStrMonthly="";
	

	// For Quarterly Report  variable defined 
	String strfromNewDate="";
	String strnewDate="";

	String strfromOldDateMar	= "01/04/"+yearlyvalue;  
	String strnewDateJun		="30/06/"+yearlyvalue;
	
	String strnewoldDateJuly	= "01/07/"+yearlyvalue;
	String strnewnewDateSept	= "30/09/"+yearlyvalue;
	
	String stroldDateOct		= "01/10/"+yearlyvalue;
	String strnewDateDec		= "31/12/"+yearlyvalue;
	
	/*int s = Integer.parseInt(yearlyvalue);
	s=s+1;
	String yearlyvalue1			= new String(new Integer(s).toString());
	*/

	String strnewDateJan		= "01/01/"+yearlyvalue1;
	String strnewDateMar		= "31/03/"+yearlyvalue1;
	// End Quartely 

	//start Half Yearly
	String strHalfFrm1 ="01/04/"+yearlyvalue; 
	String strFullFrm1 ="30/09/"+yearlyvalue; 
	String strHalfFrm2 ="01/10/"+yearlyvalue; 
	String strFullFrm2 ="31/03/"+yearlyvalue1; 
	//end Half Yearly

	// For Yearly
       yearlyvalue=strYearly;
	   s = Integer.parseInt(yearlyvalue);
	   s=s+1;
	   yearlyvalue1			= new String(new Integer(s).toString());

	String sqlStrYearly		="";
	String strYearlyFrm1	= "";
	String strYearlyTo1		= "";
	// End Yearly
	 
	if(strchkData.equals("2"))          	// Quarterly Block
	{
		//System.out.println("in 2");
				for(int i=0;i<=3;i++)
				{
					
						if(i==0){
						strfromOldDate=strfromOldDateMar;
						strnewDate=strnewDateJun;
						}
						if(i==1){			
						strfromOldDate=strnewoldDateJuly;
						strnewDate=strnewnewDateSept;
						}
						if(i==2){
						strfromOldDate=stroldDateOct;
						strnewDate =strnewDateDec;
						}
						if(i==3){
						strfromOldDate =strnewDateJan;
						strnewDate = strnewDateMar;
						}
					 
					if(strCategory.equals("3")) 	// International
					{
						HeadingDisplay=dbLabelBean.getLabel("label.report.international",strsesLanguage);  //query changed by shiv on 09-Jul-07
						if(ssflage.equals("3")){
							HeadingDisplay = "Intercont";
						 }
						sqlStrQuarterly="set dateformat dmy(SELECT COUNT(*)  as aa FROM T_TRAVEL_MST TM INNER JOIN T_TRAVEL_STATUS TS ON TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID INNER JOIN (SELECT MAX(ROLE_ID) AS ROLE_ID,USERID,SITE_ID,TES_CUTTOFF_DATE FROM  VW_AUTH_REPORT_SITE_ACCESS(NOLOCK) WHERE USERID="+Suser_id+" GROUP BY USERID,SITE_ID,TES_CUTTOFF_DATE) AUS ON TM.SITE_ID =AUS.SITE_ID AND AUS.USERID="+Suser_id+" WHERE  CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME)  BETWEEN '"+ strfromOldDate +"' AND '"+strnewDate +"'  AND TM.TRAVEL_TYPE = 'I' AND TS.TRAVEL_TYPE = 'I' AND TS.TRAVEL_STATUS_ID != 1 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1 "+ strAppendQuery +")";                               
		 			}
					if(strCategory.equals("2")) //Domestic
					{
					HeadingDisplay=dbLabelBean.getLabel("label.report.domestic",strsesLanguage); //query changed by shiv on 09-Jul-07
					if(ssflage.equals("3")){
						HeadingDisplay = "Domestic/Europe";
					 }
					sqlStrQuarterly = "set dateformat dmy(SELECT COUNT(*)  as aa FROM T_TRAVEL_MST TM INNER JOIN T_TRAVEL_STATUS TS ON TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID INNER JOIN (SELECT MAX(ROLE_ID) AS ROLE_ID,USERID,SITE_ID,TES_CUTTOFF_DATE FROM  VW_AUTH_REPORT_SITE_ACCESS(NOLOCK) WHERE USERID="+Suser_id+" GROUP BY USERID,SITE_ID,TES_CUTTOFF_DATE) AUS ON TM.SITE_ID =AUS.SITE_ID AND AUS.USERID="+Suser_id+" WHERE   CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME)   BETWEEN '"+ strfromOldDate +"' AND '"+strnewDate +"' AND TM.TRAVEL_TYPE = 'D' AND TS.TRAVEL_TYPE = 'D' AND TS.TRAVEL_STATUS_ID != 1 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1 "+ strAppendQuery +")";
					}

					ResultSet rs = dbConBean.executeQuery(sqlStrQuarterly);
						while(rs.next())
								{
								String one = rs.getString("aa");
								//System.out.println("himjain -->  "+one);
								quartelyreport.add(one);				
								//System.out.println("i" +quartelyreport.size());
								}
						//rs.close();
						//dbConBean.close();
					}
}


	if(strchkData.equals("3"))					// Half Yearly
		{
			//System.out.println("in 3");

		for(int i=0;i<2;i++)
				{
					if(i==0){
						strHalfFrm1=strHalfFrm1;
						strFullFrm1=strFullFrm1;
						}
					if(i==1){			
						strHalfFrm1=strHalfFrm2;
						strFullFrm1=strFullFrm2;
						}
				
					if(strCategory.equals("3")){			//International 
					HeadingDisplay=dbLabelBean.getLabel("label.report.international",strsesLanguage);  // query changed by shiv on 09-Jul-07
					if(ssflage.equals("3")){
						HeadingDisplay = "Intercont";
					 }
					sqlStrHalfYearly="set dateformat dmy(SELECT COUNT(*)  as aa FROM T_TRAVEL_MST TM INNER JOIN T_TRAVEL_STATUS TS ON TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID INNER JOIN (SELECT MAX(ROLE_ID) AS ROLE_ID,USERID,SITE_ID,TES_CUTTOFF_DATE FROM  VW_AUTH_REPORT_SITE_ACCESS(NOLOCK) WHERE USERID="+Suser_id+" GROUP BY USERID,SITE_ID,TES_CUTTOFF_DATE) AUS ON TM.SITE_ID =AUS.SITE_ID AND AUS.USERID="+Suser_id+" WHERE   CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME)  BETWEEN '"+ strHalfFrm1 +"' AND '"+strFullFrm1 +"' AND TM.TRAVEL_TYPE = 'I' AND TS.TRAVEL_TYPE = 'I' AND TS.TRAVEL_STATUS_ID != 1 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1 "+ strAppendQuery +")";
				
					}
					if(strCategory.equals("2"))				//Domestic
					{
					HeadingDisplay=dbLabelBean.getLabel("label.report.domestic",strsesLanguage);   //query changed by shiv on 09-Jul-07
					if(ssflage.equals("3")){
						HeadingDisplay = "Domestic/Europe";
					 }
					sqlStrHalfYearly="set dateformat dmy(SELECT COUNT(*)  as aa FROM T_TRAVEL_MST TM INNER JOIN T_TRAVEL_STATUS TS ON TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID INNER JOIN (SELECT MAX(ROLE_ID) AS ROLE_ID,USERID,SITE_ID,TES_CUTTOFF_DATE FROM  VW_AUTH_REPORT_SITE_ACCESS(NOLOCK) WHERE USERID="+Suser_id+" GROUP BY USERID,SITE_ID,TES_CUTTOFF_DATE) AUS ON TM.SITE_ID =AUS.SITE_ID AND AUS.USERID="+Suser_id+" WHERE   CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME)  BETWEEN '"+ strHalfFrm1 +"' AND '"+strFullFrm1 +"' AND TM.TRAVEL_TYPE = 'D' AND TS.TRAVEL_TYPE = 'D' AND TS.TRAVEL_STATUS_ID != 1 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1 "+ strAppendQuery +")";
					
					//sqlStrHalfYearly = "set dateformat dmy select count(travel_id) as aa from t_travel_detail_dom  where c_datetime between '"+ strHalfFrm1 +"' and '"+strFullFrm1 +"'and	APPLICATION_ID=1 and STATUS_ID <>1";
					}

					//System.out.println("sqlStrHalfYearly--> "+sqlStrHalfYearly);
					
					ResultSet rs1 = dbConBean.executeQuery(sqlStrHalfYearly);
						while(rs1.next())
								{
								String one = rs1.getString("aa");
								//System.out.println("himjain -->  "+one);
								quartelyreport.add(one);		
						
								}
								//rs1.close();
						}
						
						//dbConBean.close();
			}

         //strYearlyTo="2030";
		if(strchkData.equals("4"))		//Yearly
		{
             do  //Code Changed  for showing Report  for selected year  open by shiv on 29-Jun-07  
			    {
							   strYearlyFrm1	= "01/04/"+yearlyvalue; 
							   strYearlyTo1		= "31/03/"+yearlyvalue1;

							   String reportyear=new String(yearlyvalue+ "-"+yearlyvalue1);
							   yearlyyreport.add(reportyear);

								if(strCategory.equals("3")){	//International
								HeadingDisplay=dbLabelBean.getLabel("label.report.international",strsesLanguage); // query changed by shiv on 09-Jul-07
								if(ssflage.equals("3")){
									HeadingDisplay = "Intercont";
								 }
								sqlStrYearly="set dateformat dmy(SELECT COUNT(*)  as aa FROM T_TRAVEL_MST TM INNER JOIN T_TRAVEL_STATUS TS ON TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID INNER JOIN (SELECT MAX(ROLE_ID) AS ROLE_ID,USERID,SITE_ID,TES_CUTTOFF_DATE FROM  VW_AUTH_REPORT_SITE_ACCESS(NOLOCK) WHERE USERID="+Suser_id+" GROUP BY USERID,SITE_ID,TES_CUTTOFF_DATE) AUS ON TM.SITE_ID =AUS.SITE_ID AND AUS.USERID="+Suser_id+" WHERE   CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME)  BETWEEN '"+ strYearlyFrm1 +"' AND '"+strYearlyTo1 +"'  AND TM.TRAVEL_TYPE = 'I' AND TS.TRAVEL_TYPE = 'I' AND TS.TRAVEL_STATUS_ID != 1 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1 "+ strAppendQuery +")";
								//sqlStrYearly = "set dateformat dmy select count(travel_id) as aa from t_travel_detail_int  where c_datetime between '"+ strYearlyFrm1 +"' and '"+strYearlyTo1 +"' and	APPLICATION_ID=1  and STATUS_ID <>1";
								//System.out.println("sqlStrYearly>>1"+sqlStrYearly);
								}
								if(strCategory.equals("2"))		//Domestic
								{
								HeadingDisplay=dbLabelBean.getLabel("label.report.domestic",strsesLanguage);   //query changed by shiv on 09-Jul-07
								if(ssflage.equals("3")){
									HeadingDisplay = "Domestic/Europe";
								 }
								sqlStrYearly="set dateformat dmy(SELECT COUNT(*)  as aa FROM T_TRAVEL_MST TM INNER JOIN T_TRAVEL_STATUS TS ON TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID INNER JOIN (SELECT MAX(ROLE_ID) AS ROLE_ID,USERID,SITE_ID,TES_CUTTOFF_DATE FROM  VW_AUTH_REPORT_SITE_ACCESS(NOLOCK) WHERE USERID="+Suser_id+" GROUP BY USERID,SITE_ID,TES_CUTTOFF_DATE) AUS ON TM.SITE_ID =AUS.SITE_ID AND AUS.USERID="+Suser_id+" WHERE   CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME)  BETWEEN '"+ strYearlyFrm1 +"' AND '"+strYearlyTo1 +"'  AND TM.TRAVEL_TYPE = 'D' AND TS.TRAVEL_TYPE = 'D' AND TS.TRAVEL_STATUS_ID != 1 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1 "+ strAppendQuery +")";
								 
								}

								ResultSet rs2 = dbConBean.executeQuery(sqlStrYearly);
								while(rs2.next())
										{
											String one = rs2.getString("aa");				 
											quartelyreport.add(one);		
										}
									yearlyvalue= yearlyvalue1;
                            int intYearlyvalue=Integer.parseInt(yearlyvalue1);
						    intYearlyvalue++;
						    yearlyvalue1=Integer.toString(intYearlyvalue);
                 }
	             while(Integer.parseInt(yearlyvalue1)<=Integer.parseInt(strYearlyTo)+1);
								//rs2.close();
							dbConBean.close();
	}
					
			//Code Changed  for showing Report  for selected year  open by shiv on  02-July-07 

			 ///following code changing the date formate  from dd/mm/yyyy to yyyy/mm/dd 
			            
						//for To date 
				      String    strDayto          = strToDate.substring(0,2);   
					  String    strMonthTo      = strToDate.substring(3,5);
					  String    strYearto         =strToDate.substring(6,10);  
                       //for  Fromdate   
					  String     strDayfrom     =strfromDate.substring(0,2);   
					  String  strMonthfrom    =strfromDate.substring(3,5);
					  String strYearfrom         =strfromDate.substring(6,10);  
  					   
					   strToDate= strYearto+"/"+strMonthTo+"/"+strDayto;
  	                   strfromDate= strYearfrom+"/"+strMonthfrom+"/"+strDayfrom;

					  if(strchkData.equals("1")){ 			//Monthly
					   	if(strCategory.equals("3"))		//International
						  {
                         	 if(strUnitHidden.equals("0")) // code if user selectes all Site
							   {
                                    sqlStrMonthly ="set dateformat ymd SELECT 	DBO.Monthwise_Total_Requests_Allsite('"+strfromDate+"','"+strToDate+"','I') as Records";
									//System.out.println("query for month for all site inter national "+sqlStrMonthly );
							   }
							else  ////when a site is selected 
							{
								      HeadingDisplay=dbLabelBean.getLabel("label.report.international",strsesLanguage);
								      if(ssflage.equals("3")){
								    	  HeadingDisplay = "Intercont";
										 }
								    sqlStrMonthly ="set dateformat ymd SELECT  DBO.Monthwise_Total_Requests_Onesite('"+strfromDate+"','"+strToDate+"','"+strUnitHidden+"','I') as Records";
						           // System.out.println("query for month for selected site inter national "+sqlStrMonthly );
                                      
							}
						}
			
						if(strCategory.equals("2"))		//Domestic
						{	
							if(strUnitHidden.equals("0")) //Code if user selects all site  
							{
				                                sqlStrMonthly ="set dateformat ymd SELECT   DBO.Monthwise_Total_Requests_Allsite('"+strfromDate+"','"+strToDate+"','D') as Records";
							       // System.out.println("query for domestic month for all site  "+sqlStrMonthly );
							}
							else   ////when a site is selected 
							{
								  HeadingDisplay=dbLabelBean.getLabel("label.report.domestic",strsesLanguage);
								  if(ssflage.equals("3")){
									  HeadingDisplay = "Domestic/Europe";
									 }
				  	              sqlStrMonthly =" set dateformat ymd SELECT  DBO.Monthwise_Total_Requests_Onesite('"+strfromDate+"','"+strToDate+"','"+strUnitHidden+"','D') as Records";
							     //System.out.println("query for month for selcet site inter national "+sqlStrMonthly );
							}
						}
	                    //get a result set  					
						ResultSet rs3 = dbConBean1.executeQuery(sqlStrMonthly);
						while(rs3.next())
								{				
									String strMonthlyRecords = rs3.getString(1);
									StringTokenizer st = new StringTokenizer(strMonthlyRecords,",");
									countMonthlyTokens = st.countTokens();
								   while(st.hasMoreTokens())
									{
										quartelyreport.add(st.nextToken());	
									}
							
								}  
					}
//Code Changed  for showing Report  for selected year  close by shiv on 02-July-07 close
			
%>

<%
	if (iCls%2 == 0) { 
		strStyleCls="formtr1";
    } else { 
		strStyleCls="formtr2";
    } 
	  iCls++;
	%>
	
	<% if(strchkData.equals("2")) { 
		
		%>
	
	<table width="100%"  border="0" cellpadding="0" cellspacing="1" align="center" class="formborder">
	<tr class="formhead"> 
	 <td width="2%"  align="Left"><%=dbLabelBean.getLabel("label.report.quarterlyreportfor",strsesLanguage) %> <%=HeadingDisplay%>  <%=dbLabelBean.getLabel("label.report.travelrequisitions",strsesLanguage) %> </td>
	<TR>
	<TD>
	<table width="100%"  border="0" cellpadding="5" cellspacing="1" align="center" class="formborder">
	<tr class="formhead"> 
      <td width="8%"  align="center"># </td>

		<td  align="center"><%=dbLabelBean.getLabel("label.report.iquarter",strsesLanguage) %> <br> 
		  <%=dbLabelBean.getLabel("label.report.apr",strsesLanguage) %> <%=yearlyvalue %> <%=yearlyvalue %> - <%=dbLabelBean.getLabel("label.report.jun",strsesLanguage) %>  <%=yearlyvalue %> </td>
		<td  align="center"><%=dbLabelBean.getLabel("label.report.iiquarter",strsesLanguage) %> <br> 
		  <%=dbLabelBean.getLabel("label.report.jul",strsesLanguage) %> <%=yearlyvalue %> - <%=dbLabelBean.getLabel("label.report.sept",strsesLanguage) %> <%=yearlyvalue %> <%=yearlyvalue %> </td>
		<td  align="center"><%=dbLabelBean.getLabel("label.report.iiiquarter",strsesLanguage) %> <br> 
		  <%=dbLabelBean.getLabel("label.report.oct",strsesLanguage) %> <%=yearlyvalue %> <%=yearlyvalue %> - <%=dbLabelBean.getLabel("label.report.dec",strsesLanguage) %> <%=yearlyvalue %> </td>
		<td  align="center"><%=dbLabelBean.getLabel("label.report.ivquarter",strsesLanguage) %> <br> 
		  <%=dbLabelBean.getLabel("label.report.jan",strsesLanguage) %> <%=yearlyvalue1 %> - <%=dbLabelBean.getLabel("label.report.mar",strsesLanguage) %> <%=yearlyvalue1 %> </td>
		</tr>
		<tr class="<%=strStyleCls%>">
		<%		
			Iterator i = quartelyreport.iterator();
						 while (i.hasNext()) {
			
		%>	
				
		<td align="left"><%=dbLabelBean.getLabel("label.report.noofrequisitionscreated",strsesLanguage) %></td>
		<td align="center"><%=i.next().toString()%></td>
		<td align="center"><%=i.next().toString()%></td>
		<td align="center"><%=i.next().toString()%></td>
		<td align="center"><%=i.next().toString()%></td>
		</tr>
	<% }%>
	</table>
	</td>
	</tr>
	</td>
	</tr>
</table>
 <%}%>


<% if(strchkData.equals("3")) { %>

	<table width="100%"  border="0" cellpadding="0" cellspacing="1" align="center" class="formborder">
	<tr class="formhead"> 
	 <td width="2%" height="25"  align="Left"><%=dbLabelBean.getLabel("label.report.halfyearlyreportfor",strsesLanguage) %> <%=HeadingDisplay%> <%=dbLabelBean.getLabel("label.report.travelrequisitions",strsesLanguage) %> </td>
	<TR>
	<TD>
	<table width="100%"  border="0" cellpadding="5" cellspacing="1" align="center" class="formborder">
	<tr class="formhead"> 
      <td width="9%"  align="center"># </td>

		<td  align="center"><%=dbLabelBean.getLabel("label.report.ihalfyear",strsesLanguage) %> <br> 
		  <%=dbLabelBean.getLabel("label.report.apr",strsesLanguage) %> <%=yearlyvalue %> - <%=dbLabelBean.getLabel("label.report.sept",strsesLanguage) %> <%=yearlyvalue %>  </td>
		<td  align="center"><%=dbLabelBean.getLabel("label.report.iihalfyear",strsesLanguage) %> <br> 
		  <%=dbLabelBean.getLabel("label.report.oct",strsesLanguage) %> <%=yearlyvalue %> - <%=dbLabelBean.getLabel("label.report.mar",strsesLanguage) %> <%=yearlyvalue1 %> </td>
		</tr>
		<tr class="<%=strStyleCls%>">
		<%		
			Iterator i = quartelyreport.iterator();
						 while (i.hasNext()) {
		%>	
				
		<td align="left"><%=dbLabelBean.getLabel("label.report.noofrequisitionscreated",strsesLanguage) %></td>
		<td align="center"><%=i.next().toString()%></td>
		<td align="center"><%=i.next().toString()%></td>
		</tr>
	<% }%>
	</table>
	</td>
	</tr>
	</td>
	</tr>
</table>
 <% } %>

 <% if(strchkData.equals("4")) { 
	 /*@ Vijay Kumar Singh Date 14-Mar-2007
   	  * Display the Sassion according to date */

	 int yearly=Integer.parseInt(yearlyvalue)+1;
	 String year=""+yearly;
 %>

	<table width="100%"  border="0" cellpadding="0" cellspacing="1" align="center" class="formborder">
	<tr class="formhead"> 
		 <td> <%=dbLabelBean.getLabel("label.report.yearlyreportfor",strsesLanguage) %> <%=HeadingDisplay%> <%=dbLabelBean.getLabel("label.report.travelrequisitions",strsesLanguage) %><td></tr>
		 
         
	<TR>
	<TD>
	<table width="100%"  border="0" cellpadding="5" cellspacing="1" align="center" class="formborder">
	<tr class="formhead"> 
      <td width="9%"  align="center"># </td>
                    
		<%
			Iterator i = yearlyyreport.iterator();
						 while (i.hasNext()) {
							 					 %>
			                       <td  align="center">  <%=dbLabelBean.getLabel("label.report.year",strsesLanguage) %> <%= i.next().toString()  %> 
								 <%
						 }
			%>
		 
		<tr class="<%=strStyleCls%>">
			<td align="left"><%=dbLabelBean.getLabel("label.report.noofrequisitionscreated",strsesLanguage) %></td></td>
		<%		
			i = quartelyreport.iterator();
						 while (i.hasNext()) {
		%>	
				
		 
		<td align="center"><%=i.next().toString()%></td>
		
	<% }%>
		</tr>
	</table>
	</td>
	</tr>
	</td>
	</tr>
</table>
 <% } %>

  <% if(strchkData.equals("1")) { // monthly starts %>  

	<table width="100%"  border="0" cellpadding="0" cellspacing="0" align="left">
	
	<TR>
	<TD>
	<table width="100%"  border="0" cellpadding="5" cellspacing="1" align="left" class="formborder">
	<tr class="formhead"> 
      <td  align="left"> <%=dbLabelBean.getLabel("label.report.monthlyreportfor",strsesLanguage) %> <%=HeadingDisplay%> <%=dbLabelBean.getLabel("label.report.travelrequisitions",strsesLanguage) %></td>
	  </tr>
	</table>	</TD>
	</TR>
	<TR>
	<TD><table width="100%"  border="0" cellpadding="5" cellspacing="1" align="center" class="formborder">
      <tr class="formhead">
        <td width="76"  align="center"><br>
          # </td>
        <% int iMonth = monthFrom-1;
		   int iYear = yearFrom;
		   int loopcount = 0;
			while(loopcount < calMonth){
				out.println("<TD align=center>"+arrMonths[iMonth]+"'"+iYear+"</TD>");
				if(iMonth==11){
					iMonth=0;
					iYear++;
				}else{
					iMonth++;
				}
			loopcount++;
		};%>
      </tr>
      <tr class="<%=strStyleCls%>">
        <td align="left" width="76"><%=dbLabelBean.getLabel("label.report.noofrequisitionscreated",strsesLanguage) %></td>
        <%		
			Iterator i = quartelyreport.iterator();
				while (i.hasNext()) {
					String himanshu = i.next().toString();
				
		%>
        <td align="center"><%=himanshu%></td>
        <% } %>
      </tr>
    </table></TD>
	</TR>
</TABLE>

   <% }  // monthly block closes
%>
      
      
      

