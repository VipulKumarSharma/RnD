/**
 * Servlet user insert record for sending mail for MATA GmbH
 * when approver approve request from it's mobile App.
 */


import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

import src.connection.DbConnectionBean;
import src.dao.T_QuicktravelRequestDaoImpl;

/**
 * Servlet implementation class ProcessTravelDetailMailMataGmbHServlet
 */
public class ProcessTravelDetailMailMataGmbHServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	private static final Calendar cal = Calendar.getInstance();
	
	/* Get actual class name to be printed on */
	static Logger logger = Logger.getLogger(ProcessTravelDetailMailMataGmbHServlet.class.getName());
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessTravelDetailMailMataGmbHServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	String travelId = request.getParameter("travelId");
    	String travelType = request.getParameter("travelType");
    	String travelStatus = request.getParameter("travelStatus");
    	String travelAgencyTypeId = request.getParameter("travelAgencyTypeId");
    	
    	String statusText = "";
    	
    	try {
			
			logger.setLevel(Level.ALL);
		    logger.info("sendRequisitionMailOnApproval [SMG_CONNECT] Start for Requisition Number-->"+travelId+ ", Travel Type-->"+travelType+ ", Travel Status-->"+travelStatus+ " at " +dateFormat.format(cal.getTime()));

	    	if(travelId == null || travelType == null) {
	    		logger.info("sendRequisitionMailOnApproval [SMG_CONNECT] [If Travel Id OR Travel Type NULL]-->"+travelId+ ", Travel Type-->"+travelType+ ", Travel Status-->"+travelStatus+ " at " +dateFormat.format(cal.getTime()));
	    		request.getRequestDispatcher("/ProcessMailCreationRequest.jsp").forward(request, response);
	    	} else {    			
	    		
	    		boolean processSuccessFlag = false;
	
	    		if(travelId != null && !travelId.equals("")
	    				&& travelType != null && !travelType.equals("")){
	
	    			DbConnectionBean dbConBean = null;
	    			String requisitionNumber = null;
	    			String travellerName = null;
	    			String travellerId = null;
	    			String mailCreatorId = null;
	    			String groupTravelFlag = null;
	    			String creatorMail = null;
	    			String travellerMail = null;
	    			String ccMail = null;
	    			String sSqlStr = null;
	    			String firstDepartureDate = null;
	
	    			if(dbConBean == null){
	    				dbConBean  = new DbConnectionBean();
	    			}
	    			try
	    			{
	    				Connection conn = dbConBean.getConnection();
	    				Statement stmt = null;
	    				ResultSet rs = null;
	    				
	    				if(travelType.equals("D")) {
	    					sSqlStr="SELECT T.TRAVEL_REQ_NO AS RNO,.DBO.USER_NAME(TA.TRAVELLER_ID) AS TRAVELLER_NAME ,T.C_USERID AS USER_ID,TA.APPROVER_ID,T.TRAVELLER_ID, ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG, DBO.USEREMAIL(T.C_USERID) AS CREATOREMAIL, DBO.USEREMAIL(T.TRAVELLER_ID) AS TRAVELLEREMAIL FROM T_TRAVEL_DETAIL_DOM T,T_APPROVERS TA WHERE T.TRAVEL_ID=TA.TRAVEL_ID  AND T.TRAVEL_ID="+travelId+" AND TRAVEL_TYPE='D' AND T.STATUS_ID=10 ";
	    				
	    				} else {
	    					sSqlStr="SELECT T.TRAVEL_REQ_NO AS RNO,.DBO.USER_NAME(TA.TRAVELLER_ID) AS TRAVELLER_NAME ,T.C_USERID AS USER_ID,TA.APPROVER_ID,T.TRAVELLER_ID, ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG, DBO.USEREMAIL(T.C_USERID) AS CREATOREMAIL, DBO.USEREMAIL(T.TRAVELLER_ID) AS TRAVELLEREMAIL FROM T_TRAVEL_DETAIL_INT T,T_APPROVERS TA WHERE T.TRAVEL_ID=TA.TRAVEL_ID AND T.TRAVEL_ID="+travelId+" AND TRAVEL_TYPE='I' AND T.STATUS_ID=10 ";
	    				}
	
	    				stmt= conn.createStatement(); 
	    				rs = stmt.executeQuery(sSqlStr);
	
	    				if(rs.next()) {
	    					requisitionNumber = rs.getString("RNO");
	    					travellerName = rs.getString("TRAVELLER_NAME");
	    					travellerId = rs.getString("TRAVELLER_ID");
	    					mailCreatorId = rs.getString("USER_ID");
	    					groupTravelFlag = rs.getString("GROUP_TRAVEL_FLAG");
	    					creatorMail	= rs.getString("CREATOREMAIL");	
	    					travellerMail = rs.getString("TRAVELLEREMAIL");	
	    					ccMail = creatorMail;
	    				}
	
	    				if(travellerId != null && requisitionNumber != null){
	
	    					if("I".equals(travelType) || "INT".equals(travelType)) {
	    						sSqlStr = "SELECT CONVERT(VARCHAR(10),MIN(TRAVEL_DATE),103) AS FIRST_JOURNY_DATE FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+travelId;
	    					} else if("D".equals(travelType) || "DOM".equals(travelType)) {
	    						sSqlStr = "SELECT CONVERT(VARCHAR(10),MIN(TRAVEL_DATE),103) AS FIRST_JOURNY_DATE FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+travelId;
	    					}
	
	    					stmt= conn.createStatement(); 
	    					rs = stmt.executeQuery(sSqlStr);
	
	    					if(rs.next()) {
	    						firstDepartureDate=rs.getString("FIRST_JOURNY_DATE");
	    					}
	
	
	    					if(travelStatus != null && !"-1".equals(travelStatus) && "P".equals(travelStatus)) {
	    						statusText = "";
	    					} else if(travelStatus != null && !"-1".equals(travelStatus) && "A".equals(travelStatus)) {
	    						statusText = " - Approved";
	    					}
	    					
	    					T_QuicktravelRequestDaoImpl dao = new T_QuicktravelRequestDaoImpl();
		
	    					String emailBody = "";
							String functionKey = "";
							String adminIDFlag = "";
							
							if(travelAgencyTypeId.equals("1")) {
								
								functionKey = "@MataindiaSite";
								adminIDFlag = "AND M_USERINFO.USERID=1129";
								if(groupTravelFlag!=null  &&  (groupTravelFlag.trim().equals("Y"))) {
									 emailBody = dao.getGroupMailBodyForMataIndia(travelId, travelType, travellerId);
								} else if(groupTravelFlag!=null  &&  (groupTravelFlag.trim().equals("N"))) {
									 emailBody = dao.getMailBodyForMataIndia(travelId, travelType, travellerId);
								}
							} else if(travelAgencyTypeId.equals("2")) {	
								
								functionKey = "@MataGmbHSite";
								if(groupTravelFlag!=null  &&  (groupTravelFlag.trim().equals("Y"))) {
									 emailBody = dao.getGroupMailBodyForMataGmbH(travelId, travelType, travellerId);
								} else if(groupTravelFlag!=null  &&  (groupTravelFlag.trim().equals("N"))) {
									 emailBody = dao.getMailBodyForMataGmbH(travelId, travelType, travellerId);
								}
							} 
							
							
							if("I".equals(travelType) || "INT".equals(travelType)) {
								
								sSqlStr = " select DBO.USEREMAIL(APPROVER_ID) MATAGMBH from T_TRAVEL_DETAIL_INT TDI "+ 
										" INNER JOIN T_APPROVERS TA ON TDI.TRAVEL_ID=TA.TRAVEL_ID AND "+
										" TA.TRAVEL_TYPE='"+travelType+"' WHERE TDI.TRAVEL_ID="+travelId+" AND TA.ROLE='MATA' UNION "+
										" select email AS MATAGMBH from m_userinfo "+ 
										" WHERE site_id in (select FUNCTION_VALUE from  functional_ctl where function_key='"+functionKey+"') and role_id ='MATA' and "+ 
										" exists(select 1 from T_TRAVEL_DETAIL_INT tdi inner join m_site s on tdi.SITE_ID = s.site_id "+ 
										" WHERE TRAVEL_ID="+travelId+" and TRAVEL_AGENCY_ID="+travelAgencyTypeId+") and M_USERINFO.STATUS_ID=10 " + adminIDFlag + " UNION "+
										" SELECT DBO.USEREMAIL(USERID) MATAGMBH FROM T_TRAVEL_DETAIL_INT TDI "+
										" INNER JOIN  USER_MULTIPLE_ACCESS UMA ON TDI.SITE_ID=UMA.SITE_ID "+
										" WHERE TDI.TRAVEL_ID="+travelId+" AND UMA.TRAVEL_COORDINATOR =1 AND UMA.STATUS_ID=10";			
								
							} else if("D".equals(travelType) || "DOM".equals(travelType)) {
								
								sSqlStr = " select DBO.USEREMAIL(APPROVER_ID) MATAGMBH from T_TRAVEL_DETAIL_DOM TDD "+
										" INNER JOIN T_APPROVERS TA ON TDD.TRAVEL_ID=TA.TRAVEL_ID AND "+
										" TA.TRAVEL_TYPE='"+travelType+"' WHERE TDD.TRAVEL_ID="+travelId+" AND TA.ROLE='MATA' UNION "+
										" select email AS MATAGMBH from m_userinfo "+ 
										" WHERE site_id in (select FUNCTION_VALUE from  functional_ctl where function_key='"+functionKey+"') and role_id ='MATA' and "+ 
										" exists(select 1 from T_TRAVEL_DETAIL_DOM tdd inner join m_site s on tdd.SITE_ID = s.site_id "+ 
										" WHERE TRAVEL_ID="+travelId+" and TRAVEL_AGENCY_ID="+travelAgencyTypeId+") and M_USERINFO.STATUS_ID=10 " + adminIDFlag + " UNION "+
										" SELECT DBO.USEREMAIL(USERID) MATAGMBH FROM T_TRAVEL_DETAIL_DOM TDD "+
										" INNER JOIN  USER_MULTIPLE_ACCESS UMA ON TDD.SITE_ID=UMA.SITE_ID "+
										" WHERE TDD.TRAVEL_ID="+travelId+" AND UMA.TRAVEL_COORDINATOR =1 AND UMA.STATUS_ID=10";			
								
							}
	
	    					stmt= conn.createStatement(); 
	    					rs = stmt.executeQuery(sSqlStr);
	
	    					List<String> emailIdsList = new ArrayList<String>();
	    					String emailId = "";
	    					String emailIds = "";
	    					
	    					while(rs.next()) {
	    						emailId=rs.getString("MATAGMBH");
	    						emailIdsList.add(emailId);
	    					}
	
	    					StringBuilder sb = new StringBuilder();
	    					int size = emailIdsList.size(); 
	    					if (size > 0) {
	    						sb.append(emailIdsList.get(0));
	    						for (int i = 1; i < size; ++i) {
	    							sb.append("; ").append(emailIdsList.get(i));
	    						}
	
	    						emailIds = sb.toString();
	    					}
	    					
	    					if(!travellerId.equals(mailCreatorId)) {
	    						ccMail = ccMail+";"+travellerMail;
	    					}
	    					
	    					String strFromMail="";
							String strMataGmbhSubject = "";
							
							if(travelAgencyTypeId.equals("1")) {
								strFromMail="administrator.stars@mind-infotech.com";
								if(groupTravelFlag!=null  &&  (groupTravelFlag.trim().equals("Y"))) {
									strMataGmbhSubject = "STARS"+statusText+" - ["+travellerName+"] - ["+firstDepartureDate+"] ["+requisitionNumber+"] [Group/Guest]";
								} else {
									strMataGmbhSubject = "STARS"+statusText+" - ["+travellerName+"] - ["+firstDepartureDate+"] ["+requisitionNumber+"]";
								}
							} else if(travelAgencyTypeId.equals("2")) {
								strFromMail=creatorMail;
								if(groupTravelFlag!=null  &&  (groupTravelFlag.trim().equals("Y"))) {
									strMataGmbhSubject = "STARS - ["+travellerName+"] - ["+firstDepartureDate+"] ["+requisitionNumber+"] [Guest]"+statusText;
								} else {
									strMataGmbhSubject = "STARS - ["+travellerName+"] - ["+firstDepartureDate+"] ["+requisitionNumber+"]"+statusText;
								}
							}
	    					
	    					logger.info("sendRequisitionMailOnApproval [SMG_CONNECT] [PROC_REQUISITION_MAIL_ADD] block Start for Requisition Number-->"+travelId+ ", Travel Type-->"+travelType+ ", Travel Status-->"+travelStatus+ " at " +dateFormat.format(cal.getTime()));
	    					
	    					logger.info("sendRequisitionMailOnApproval [SMG_CONNECT] [MAIL SUBJECT] is-->"+strMataGmbhSubject+ " for Requisition Number-->"+travelId+ " at " +dateFormat.format(cal.getTime()));
	    					 
	    					CallableStatement cstmt_mail  = null; 
	    					cstmt_mail = conn.prepareCall("{call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
	    					cstmt_mail.setString(1, travelId);
	    					cstmt_mail.setString(2, requisitionNumber);
	    					cstmt_mail.setString(3, emailIds);//Email Ids of MATA and Travel Coordinator.
	    					cstmt_mail.setString(4, strFromMail);//From Admin
	    					cstmt_mail.setString(5, ccMail);
	    					cstmt_mail.setString(6, strMataGmbhSubject);
	    					cstmt_mail.setString(7, emailBody);
	    					cstmt_mail.setString(8, "0");
	    					cstmt_mail.setString(9, "NEW");
	    					cstmt_mail.setString(10, mailCreatorId);
	    					cstmt_mail.setString(11, "New");
	    					cstmt_mail.setString(12, "User Submitting the Req");
	    					cstmt_mail.execute();
	    					cstmt_mail.close();
	    					conn.close();
	
	    					logger.info("sendRequisitionMailOnApproval [SMG_CONNECT] [PROC_REQUISITION_MAIL_ADD] block End for Requisition Number-->"+travelId+ ", Travel Type-->"+travelType+ ", Travel Status-->"+travelStatus+ " at " +dateFormat.format(cal.getTime()));
	    					
	    					processSuccessFlag = true;
	
	    				} else {
	    					logger.info("sendRequisitionMailOnApproval [SMG_CONNECT] [TRAVELLER_ID] or [Requisition_Number] is null while inserting MATA GmbH mail in req_mailbox table at " +dateFormat.format(cal.getTime()));
	    					System.out.println("Data Invalid=========");
	    					//request.setAttribute("message", "Mail creation request is failed.");
	    					//request.getRequestDispatcher("/ProcessMailCreationRequest.jsp").forward(request, response);
	    				}
	    			}
	    			catch(Exception e) {
	    				logger.info("sendRequisitionMailOnApproval [SMG_CONNECT] Error in inserting MATA GmbH mail in req_mailbox table at " +dateFormat.format(cal.getTime()));
	    				System.out.println("Error in inserting MATA GmbH mail in req_mailbox table=========");
	    				e.printStackTrace();
	    				//request.setAttribute("message", "Mail creation request is failed.");
	    				//request.getRequestDispatcher("/ProcessMailCreationRequest.jsp").forward(request, response);
	    			}
	    		}else{
	    			logger.info("sendRequisitionMailOnApproval [SMG_CONNECT] Travel Id or Travel Type is null while inserting MATA GmbH mail in req_mailbox table at " +dateFormat.format(cal.getTime()));
	    			System.out.println("Travel Id or Travel Type is null while inserting MATA GmbH mail in req_mailbox table=========");
	    			//request.setAttribute("message", "Mail creation request is failed because either Travel Id or Travel Type not provided.");
	    			//request.getRequestDispatcher("/ProcessMailCreationRequest.jsp").forward(request, response);
	    		}
	
	    		if(processSuccessFlag){
	    			//request.setAttribute("message", "Mail creation request is successfully completed.");
	    			request.getRequestDispatcher("/ProcessMailCreationRequest.jsp").forward(request, response);
	    		}   		 	
		}
    	
	  logger.info("sendRequisitionMailOnApproval [SMG_CONNECT] End for Requisition Number-->"+travelId+ ", Travel Type-->"+travelType+ ", Travel Status-->"+travelStatus+ " at " +dateFormat.format(cal.getTime()));
	 
	} catch(Exception e) {
		System.out.println("Error in sendRequisitionMailOnApproval [SMG_CONNECT] main try/catch block========="+ e);
    }	

}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
