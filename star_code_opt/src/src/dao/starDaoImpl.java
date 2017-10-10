package src.dao;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.text.ParseException;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import org.apache.commons.lang.StringUtils;

import src.beans.UserBean;
import src.beans.Approver;
import src.beans.UserBeans;
import src.beans.WorkflowApprovalMatrix;
import src.connection.DbConnectionBean;
import src.connection.DbUtilityMethods;

public class starDaoImpl {
	
	private DbConnectionBean dbConnectionBean;
	
	public starDaoImpl(){
		dbConnectionBean = new DbConnectionBean();
	}

	public boolean insertMataGmbH_WorkflowMatrixData(String siteId, String[] travelType, int[] workflowCode
			, int[] approverLevel_1, int[] approverLevel_2, int[] defaultWorkflow, int[] billingApprover
			, String userId, String ipAdd ){

		boolean result = true;
		
		ResultSet rs = null;
		CallableStatement cStmt = null;
		Connection conn = null;
		
		try{
			conn = null;
			conn = dbConnectionBean.getConnection();
			conn.setAutoCommit(false);
			cStmt = conn.prepareCall("{call PROC_M_WORKFLOW_MATRIX(?,?,?,?,?,?,?,?,?,?,?)}");
			for(int i=0; i<travelType.length; i++ ){
				int index = 1;
				cStmt.setInt(index++, Integer.valueOf(siteId.trim()));
				cStmt.setString(index++, travelType[i]);
				cStmt.setInt(index++, workflowCode[i]);
				cStmt.setInt(index++, approverLevel_1[i]);
				cStmt.setInt(index++, approverLevel_2[i]);
				cStmt.setInt(index++, defaultWorkflow[i]);
				cStmt.setInt(index++, billingApprover[i]);
				cStmt.setInt(index++, Integer.valueOf(userId.trim()));
				cStmt.setString(index++, ipAdd);
				cStmt.setString(index++, "INSERT");
				cStmt.setInt(index++, 0);
				cStmt.addBatch();
			}
			int[] rowNo = cStmt.executeBatch();
			
			for(int updateRes : rowNo){
				if(updateRes != 1){
					result = false;
				}
			}
			
			if(result){
				conn.commit();
			}else{
				conn.rollback();
			}
			
		}catch(Exception e){
			try {
				conn.rollback();
			} catch (SQLException e1) {
				System.out.println("Error occured while doing transaction rollback in starDaoImpl...");
				e1.printStackTrace();
			}
			e.printStackTrace();
			System.out.println("Error occured while Inserting Approval Workflow matrix data in starDaoImpl...");
		}finally{
			//closeResources(rs,cStmt,conn);
		}
		return result;
	}
	
	public Map<String, WorkflowApprovalMatrix> getMATA_GmbH_WorkflowMatrixData(String siteId){
		Map<String, WorkflowApprovalMatrix> dataMap = new HashMap<String, WorkflowApprovalMatrix>();
		WorkflowApprovalMatrix matrix = null;
		
		ResultSet rs = null;
		PreparedStatement stmt = null;
		Connection conn = null;
		
		StringBuilder strSql = new StringBuilder();
		strSql.append("	SELECT WORKFLOW_MATRIX_ID ,TRAVEL_TYPE, WORKFLOW_CODE, APPROVAL_LVL1, APPROVAL_LVL2, DEFAULT_WORKFLOW, BILLING_APPROVER ")
					.append("	FROM M_WORKFLOW_MATRIX WHERE STATUS_ID=10 ") 
					.append("	AND SITE_ID=? ");
		
		try{
			conn = null;
			conn = dbConnectionBean.getConnection();
			stmt = conn.prepareStatement(strSql.toString());
				int index = 1;
				stmt.setString(index++, siteId.trim());
				rs = stmt.executeQuery();
				
			while(rs.next()){
				matrix = new WorkflowApprovalMatrix();
				
				matrix.setTravelType(rs.getString("TRAVEL_TYPE"));
				matrix.setWorkFlowCode(rs.getInt("WORKFLOW_CODE"));
				matrix.setApproverLevel_1_Enable(rs.getBoolean("APPROVAL_LVL1"));
				matrix.setApproverLevel_2_Enable(rs.getBoolean("APPROVAL_LVL2"));
				matrix.setDefaultApproversEnable(rs.getBoolean("DEFAULT_WORKFLOW"));
				matrix.setBillingApproversEnable(rs.getBoolean("BILLING_APPROVER"));
				
				dataMap.put(matrix.getTravelType()+"-"+matrix.getWorkFlowCode(), matrix);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			//closeResources(rs,stmt,conn);
		}
		return dataMap;
	}
	
	public WorkflowApprovalMatrix getTravelApprovalMatrix(String siteId, String traveltype, String workflowCode){
		
		WorkflowApprovalMatrix matrix = null;
		ResultSet rs = null;
		PreparedStatement stmt = null;
		Connection conn = null;
		
		StringBuilder strSql = new StringBuilder();
		strSql.append("	SELECT WORKFLOW_MATRIX_ID ,TRAVEL_TYPE, WORKFLOW_CODE, APPROVAL_LVL1, APPROVAL_LVL2, DEFAULT_WORKFLOW, BILLING_APPROVER ")
			  .append("	FROM M_WORKFLOW_MATRIX WHERE STATUS_ID=10 ") 
			  .append("	AND SITE_ID=? AND TRAVEL_TYPE = ? AND WORKFLOW_CODE = ? ");		
		try{
			conn = null;
			conn = dbConnectionBean.getConnection();
			stmt = conn.prepareStatement(strSql.toString());
				int index = 1;
				stmt.setString(index++, siteId.trim());
				stmt.setString(index++, traveltype.trim());
				stmt.setString(index++, workflowCode.trim());
				rs = stmt.executeQuery();
				
			while(rs.next()){
				matrix = new WorkflowApprovalMatrix();
				matrix.setSiteId(siteId);
				matrix.setTravelType(rs.getString("TRAVEL_TYPE"));
				matrix.setWorkFlowCode(rs.getInt("WORKFLOW_CODE"));
				matrix.setApproverLevel_1_Enable(rs.getBoolean("APPROVAL_LVL1"));
				matrix.setApproverLevel_2_Enable(rs.getBoolean("APPROVAL_LVL2"));
				matrix.setDefaultApproversEnable(rs.getBoolean("DEFAULT_WORKFLOW"));
				matrix.setBillingApproversEnable(rs.getBoolean("BILLING_APPROVER"));
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			//closeResources(rs,stmt,conn);
		}
		return matrix;
	}
	
	/**
	 * Method return List of Approvers
	 * @param matrix
	 * @param travelerId
	 * @return List<Approver>
	 */
	public List<Approver> getApproverList(WorkflowApprovalMatrix matrix, String travelerId, String workflowCode){
		List<Approver> approvers = new ArrayList<Approver>();
		Approver approver = null;
		ResultSet rs = null;
		PreparedStatement stmt = null;
		Connection conn = null;

		String userWorkflowCode = null;

		if(matrix != null){
			try{
				conn = null;
				conn = dbConnectionBean.getConnection();
				StringBuilder strSql = new StringBuilder();

				String travelerRole = null;
				Boolean isTravelerUnitHead = null;

				// CHECK TRAVELER ROLE

				strSql.append("SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID, SP_ROLE FROM M_USERINFO (NOLOCK) WHERE USERID=?");
				int index = 1;
				stmt = conn.prepareStatement(strSql.toString());
				stmt.setString(index++, travelerId.trim());
				rs = stmt.executeQuery();
				if(rs.next()){
					travelerRole = rs.getString("ROLE_ID");
					userWorkflowCode = rs.getString("SP_ROLE");
				}

				// CHECK TRAVELLER IS UNIT HEAD	
				isTravelerUnitHead = isUserUnitHead(travelerId.trim(), matrix.getSiteId().trim());

				// FETCH DEFAULT APPROVERS LIST
				List<Approver> defaultApprovers = defaultApproversList(matrix.getSiteId(), matrix.getTravelType(), userWorkflowCode);

				if(travelerRole != null && travelerRole.equalsIgnoreCase("CHAIRMAN")) {

					for(Approver defApp : defaultApprovers){
						if(defApp.getApproverRole().equalsIgnoreCase("MATA")) {
							approvers.add(defApp);
						}
					}

				} else {

					// IF TRAVELLER ROLE IS NOT 'CHAIRMAN'
					strSql = new StringBuilder();
					strSql.append("	SELECT ISNULL(REPORT_TO,'') AS REPORT_TO_ID,ISNULL(DBO.USER_NAME_MATA(REPORT_TO),'-') AS APPROVER_LEVEL_1 ")
					.append("	,ISNULL(DBO.DISIGNATION_NAME_FROM_USERID(REPORT_TO),'-') AS APPROVER_LEVEL_1_DESG,ISNULL(DBO.USER_NAME_MATA(DEPT_HEAD),'-') AS APPROVER_LEVEL_2, ISNULL(DEPT_HEAD,'') AS DEPT_HEAD_ID ") 
					.append("	,ISNULL(DBO.DISIGNATION_NAME_FROM_USERID(DEPT_HEAD),'-') AS APPROVER_LEVEL_2_DESG,SP_ROLE FROM M_USERINFO WHERE STATUS_ID=10 AND USERID=?  ");	

					index = 1;
					stmt = conn.prepareStatement(strSql.toString());
					stmt.setString(index++, travelerId.trim());
					rs = stmt.executeQuery();
					while(rs.next()){
						if(matrix.isApproverLevel_1_Enable()){
							if(rs.getString("REPORT_TO_ID") != null && !"-".equals(rs.getString("APPROVER_LEVEL_1"))){
								approver = new Approver();
								approver.setApproverId(rs.getString("REPORT_TO_ID") != null ? rs.getInt("REPORT_TO_ID") : 0);
								approver.setName(rs.getString("APPROVER_LEVEL_1"));
								approver.setApproverLevel("One");
								approver.setApproverRole("WORKFLOW");
								approver.setDesignationName(rs.getString("APPROVER_LEVEL_1_DESG"));
								approvers.add(approver);
							}
						}

						if(matrix.isApproverLevel_2_Enable()){
							if(rs.getString("DEPT_HEAD_ID") != null && !"-".equals(rs.getString("APPROVER_LEVEL_2"))){
								approver = new Approver();
								approver.setApproverId(rs.getString("DEPT_HEAD_ID") != null ? rs.getInt("DEPT_HEAD_ID") : 0);
								approver.setName(rs.getString("APPROVER_LEVEL_2"));
								approver.setApproverLevel("Two");
								approver.setApproverRole("WORKFLOW");
								approver.setDesignationName(rs.getString("APPROVER_LEVEL_2_DESG"));
								approvers.add(approver);
							}
						}
					}

					if(matrix.isDefaultApproversEnable()){
						
						for(Approver defApp : defaultApprovers){

							//TWO UNIT HEADS BELONGING TO THE SAME SITE.
							Boolean isApproverHasMultipleAccess = isUserUnitHead(defApp.getApproverId().toString().trim(),matrix.getSiteId().trim());
							Approver tempApprover = null;
							/*if((isTravelerUnitHead != null && isTravelerUnitHead.equals(Boolean.TRUE)) && (isApproverHasMultipleAccess != null)) {								 

							}else{*/

								defApp.setApproverLevel("Default");
								defApp.setApproverRole("DEFAULT");
								approvers.add(defApp);
						//	}
						}
					}
				}
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				//closeResources(rs,stmt,conn);
			}
		}
		return approvers;
	}
	
	/**
	 * Method return List of Approvers
     * @author Sandeep Malik
	 * @param siteId
	 * @param travelerId
	 * @param traveltype
	 * @param workflowCode
	 * @return List<Approver>
	 */
	public List<Approver> getApproverList(String siteId, String travelerId, String traveltype, String workflowCode){
		List<Approver> approvers = new ArrayList<Approver>();
		Approver approver = null;
		ResultSet rs = null;
		PreparedStatement stmt = null;
		Connection conn = null;
		String userWorkflowCode = null;

		// GET SITE APPROVAL WORKFLOW MATRIX DETAILS
		WorkflowApprovalMatrix matrix = getTravelApprovalMatrix(siteId, traveltype, workflowCode);

		if(matrix != null){
			try{
				conn = null;
				conn = dbConnectionBean.getConnection();
				StringBuilder strSql = new StringBuilder();

				String travelerRole = null;
				Boolean isTravelerUnitHead = null;

				// CHECK TRAVELER ROLE

				strSql.append("SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID, SP_ROLE FROM M_USERINFO (NOLOCK) WHERE USERID=?");
				int index = 1;
				stmt = conn.prepareStatement(strSql.toString());
				stmt.setString(index++, travelerId.trim());
				rs = stmt.executeQuery();
				if(rs.next()){
					travelerRole = rs.getString("ROLE_ID");
					userWorkflowCode = rs.getString("SP_ROLE");
				}

				// CHECK TRAVELLER IS UNIT HEAD	
				isTravelerUnitHead = isUserUnitHead(travelerId.trim(), siteId.trim());

				// FETCH DEFAULT APPROVERS LIST
				List<Approver> defaultApprovers = defaultApproversList(siteId, traveltype, userWorkflowCode);

				if(travelerRole != null && travelerRole.equalsIgnoreCase("CHAIRMAN")) {

					for(Approver defApp : defaultApprovers){
						if(defApp.getApproverRole().equalsIgnoreCase("MATA")) {
							approvers.add(defApp);
						}
					}

				} else {

					// IF TRAVELLER ROLE IS NOT 'CHAIRMAN'
					strSql = new StringBuilder();
					strSql.append("	SELECT ISNULL(REPORT_TO,'') AS REPORT_TO_ID,ISNULL(DBO.USER_NAME_MATA(REPORT_TO),'-') AS APPROVER_LEVEL_1 ")
					.append("	,ISNULL(DBO.DISIGNATION_NAME_FROM_USERID(REPORT_TO),'-') AS APPROVER_LEVEL_1_DESG,ISNULL(DBO.USER_NAME_MATA(DEPT_HEAD),'-') AS APPROVER_LEVEL_2, ISNULL(DEPT_HEAD,'') AS DEPT_HEAD_ID ") 
					.append("	,ISNULL(DBO.DISIGNATION_NAME_FROM_USERID(DEPT_HEAD),'-') AS APPROVER_LEVEL_2_DESG,SP_ROLE FROM M_USERINFO WHERE STATUS_ID=10 AND USERID=?  ");	

					index = 1;
					stmt = conn.prepareStatement(strSql.toString());
					stmt.setString(index++, travelerId.trim());
					rs = stmt.executeQuery();
					while(rs.next()){
						if(matrix.isApproverLevel_1_Enable()){
							if(rs.getString("REPORT_TO_ID") != null && !"-".equals(rs.getString("APPROVER_LEVEL_1"))){
								approver = new Approver();
								approver.setApproverId(rs.getString("REPORT_TO_ID") != null ? rs.getInt("REPORT_TO_ID") : 0);
								approver.setName(rs.getString("APPROVER_LEVEL_1"));
								approver.setApproverLevel("One");
								approver.setApproverRole("WORKFLOW");
								approver.setDesignationName(rs.getString("APPROVER_LEVEL_1_DESG"));
								approvers.add(approver);
							}
						}

						if(matrix.isApproverLevel_2_Enable()){
							if(rs.getString("DEPT_HEAD_ID") != null && !"-".equals(rs.getString("APPROVER_LEVEL_2"))){
								approver = new Approver();
								approver.setApproverId(rs.getString("DEPT_HEAD_ID") != null ? rs.getInt("DEPT_HEAD_ID") : 0);
								approver.setName(rs.getString("APPROVER_LEVEL_2"));
								approver.setApproverLevel("Two");
								approver.setApproverRole("WORKFLOW");
								approver.setDesignationName(rs.getString("APPROVER_LEVEL_2_DESG"));
								if(!approvers.contains(approver))
									approvers.add(approver);
							}
						}
					}

					if(matrix.isDefaultApproversEnable()){
						
						for(Approver defApp : defaultApprovers){

							//TWO UNIT HEADS BELONGING TO THE SAME SITE.
							Boolean isApproverHasMultipleAccess = isUserUnitHead(defApp.getApproverId().toString().trim(), siteId.trim());
							Approver tempApprover = null;
							if((isTravelerUnitHead != null && isTravelerUnitHead.equals(Boolean.TRUE)) && (isApproverHasMultipleAccess != null)) {								 

							}else{
								if(approvers.contains(defApp)) {  
									//if(defApp.getApproverRole().equalsIgnoreCase("OR")) {
										tempApprover = approvers.get(approvers.indexOf(defApp));
										approvers.remove(tempApprover);
										tempApprover.setApproverLevel("Default");
										tempApprover.setApproverRole("DEFAULT");
										approvers.add(tempApprover);
									//}
								} else {
									if(!approvers.contains(defApp)){  
										defApp.setApproverLevel("Default");
										defApp.setApproverRole("DEFAULT");
										approvers.add(defApp);
									}
								}
							}
						}
					}
				}

				/*if(matrix.isBillingApproversEnable()){
					strSql = new StringBuilder();
					strSql.append("	SELECT APPROVER_ID, LTRIM(RTRIM(DBO.USER_NAME_MATA(APPROVER_ID))) AS APPROVER_NAME, ")
					.append("	LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID FROM M_BILLING_APPROVER ")
					.append("  (NOLOCK) WHERE SITE_ID=?" );	

					index = 1;
					stmt = conn.prepareStatement(strSql.toString());
					stmt.setString(index++, matrix.getSiteId());
					rs = stmt.executeQuery();
					while(rs.next()){
						approver = new Approver();
						approver.setApproverId(rs.getString("APPROVER_ID") != null ? rs.getInt("APPROVER_ID") : 0);
						approver.setName(rs.getString("APPROVER_NAME"));
						approver.setApproverLevel("Billing");
						approvers.add(approver);
					}
				}*/
				
				if(travelerId != null){
					for(int i=0; i<approvers.size(); i++){
						if(approvers.get(i).getApproverId().equals(Integer.valueOf(travelerId))){
							approvers.remove(i);
						}
					}
				}
				
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				//closeResources(rs,stmt,conn);
			}
		}
		return approvers;
	}
	
	/**
	 * Check USER is Unit Head
     * @author Sandeep Malik
	 * @param userId
	 * @param siteId
	 * @return Boolean
	 */
	public Boolean isUserUnitHead(String userId, String siteId){

		ResultSet rs = null;
		PreparedStatement stmt = null;
		Connection conn = null;
		Boolean result = null;

		try{
			conn = dbConnectionBean.getConnection();
			StringBuilder strSql = new StringBuilder();
			strSql.append("	SELECT UNIT_HEAD FROM USER_MULTIPLE_ACCESS (NOLOCK) where USERID=? ")
			.append("	AND SITE_ID=? AND UNIT_HEAD=1 AND STATUS_ID=10 ORDER BY UNIT_HEAD" );	

			int index = 1;
			stmt = conn.prepareStatement(strSql.toString());
			stmt.setString(index++, userId);
			stmt.setString(index++, siteId);
			rs = stmt.executeQuery();

			if(rs.next()){
				result = rs.getBoolean("UNIT_HEAD");
			}

		}catch(Exception ex){
			ex.printStackTrace();
		}finally{

		}
		return result;
	}
	
	/**
	 * Return List of DEFAUL Approvers
	 * @author Sandeep Malik
	 * @param siteId
	 * @param travelType
	 * @param userWorkFlowCode
	 * @return List<Approver>
	 */
	public List<Approver> defaultApproversList(String siteId, String travelType, String userWorkFlowCode){
		List<Approver> approvers = new ArrayList<Approver>();
		Approver approver = null;
		ResultSet rs = null;
		PreparedStatement stmt = null;
		Connection conn = null;

		try{
			conn = dbConnectionBean.getConnection();
			StringBuilder strSql = new StringBuilder();
			strSql = new StringBuilder();
			strSql.append("	SELECT LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE,ISNULL(DBO.DISIGNATION_NAME_FROM_USERID(APPROVER_ID),'-') ")
			.append("	AS DESIG_NAME ,LTRIM(RTRIM(DBO.USER_NAME_MATA(APPROVER_ID))) AS APPROVER_NAME, APPROVER_ID, SITE_ID, ORDER_ID ")
			.append("	FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID=? AND TRV_TYPE=? AND SP_ROLE=? AND STATUS_ID=10 AND APPLICATION_ID=1 ")
			.append("	ORDER BY ORDER_ID");

			int index = 1;
			stmt = conn.prepareStatement(strSql.toString());
			stmt.setString(index++, siteId.trim());
			stmt.setString(index++, travelType.trim());
			stmt.setString(index++, userWorkFlowCode.trim());
			rs = stmt.executeQuery();

			while(rs.next()){
				approver = new Approver();
				approver.setApproverId(rs.getString("APPROVER_ID") != null ? rs.getInt("APPROVER_ID") : 0);
				approver.setName(rs.getString("APPROVER_NAME"));
				approver.setApproverLevel("Default");
				approver.setApproverRole(rs.getString("USERROLE"));
				approver.setDesignationName(rs.getString("DESIG_NAME"));
				approvers.add(approver);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{

		}
		return approvers;
	}
	
	/**
	 * Method insert or associate Approver's with Travel Request.
	 * @author Sandeep Malik
	 * @since 18/08/2015
	 * @param approvers
	 * @param siteId
	 * @param travelerId
	 * @param travelId
	 * @param travelType
	 * @param loginUserId
	 * @param isTravelerRemoveFromApprovers
	 * @return boolean (If success : 'True' Else 'False')
	 */
	public boolean associateApproverWithRequest(List approvers, String siteId, String travelerId, String travelId,
			String travelType, String loginUserId , boolean isTravelerRemoveFromApprovers){

		final int APPROVE_STATUS = 0;
		int apporverOrderId = 0;
		boolean isOkToCommit = true;
		ResultSet rs = null;
		CallableStatement cStmt = null;
		PreparedStatement stmt = null;
		Connection conn = null;

		try{
			conn = null;
			conn = dbConnectionBean.getConnection();

			if(isTravelerRemoveFromApprovers){
				
				StringBuilder sqlStr = new StringBuilder();
				sqlStr.append("SELECT ISNULL(MUI.ROLE_ID,'OR') as ROLE_ID, TTDI.TRAVELLER_ID as TRAVELLER_ID FROM " );

				if(travelType != null && travelType.equals("D")) {
					sqlStr.append(" T_TRAVEL_DETAIL_DOM ");
				}else{
					sqlStr.append(" T_TRAVEL_DETAIL_INT ");
				}
				sqlStr.append("  AS TTDI (NOLOCK)  INNER JOIN M_USERINFO AS MUI (NOLOCK) ON TTDI.TRAVELLER_ID = MUI.USERID ")
				.append("	WHERE  TTDI.TRAVEL_ID = ?");

				stmt = conn.prepareStatement(sqlStr.toString());
				stmt.setString(1, travelId.trim());
				rs = stmt.executeQuery();

				String travellerId = null;
				if(rs.next()){
					travellerId = rs.getString("TRAVELLER_ID");
				}

				if(travellerId != null){
					for(int i=0; i<approvers.size(); i++){
						if(((Approver)approvers.get(i)).getApproverId() == Integer.valueOf(travellerId)){
							approvers.remove(i);
						}
					}
				}
			}

			conn = null;
			conn = dbConnectionBean.getConnection();
			conn.setAutoCommit(false);
			String strApproveId  =  new DbUtilityMethods().getNewGeneratedId("APPROVE_ID")+"";
			cStmt = conn.prepareCall("{call PROC_INSERT_T_APPROVERS(?,?,?,?,?,?,?,?,?,?)}"); 
			for(int i=0; i<approvers.size(); i++){
				Approver approver = (Approver) approvers.get(i);
				String strApproverOrderId  = ++apporverOrderId+"";
				cStmt.setString(1, strApproveId);    
				cStmt.setString(2, travelId);    
				cStmt.setString(3, siteId);  
				cStmt.setString(4, travelerId);
				cStmt.setString(5, travelType); 
				cStmt.setString(6, approver.getApproverId().toString());
				cStmt.setString(7, APPROVE_STATUS+"");
				cStmt.setString(8, strApproverOrderId);
				cStmt.setString(9, approver.getApproverRole());
				cStmt.setString(10, loginUserId);
				cStmt.addBatch();
			}

			int[] resultArr = cStmt.executeBatch();
			if(resultArr.length == approvers.size()){
				for(int status : resultArr){
					if(status != 1){
						isOkToCommit = false;
					}   
				}
			}else{
				isOkToCommit = false;
			}

			if(isOkToCommit){
				conn.commit();
			}else{
				conn.rollback();
			}
		}catch(SQLException e){
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally{
			//closeResources(rs,cStmt,conn);
		}
		return isOkToCommit;
	}
	
	/**
	 * Method check provided value is null or empty.
	 * @param obj
	 * @return boolean
	 */
	private boolean checkNullEmpty(Object obj){
		if(obj instanceof String){
			if(StringUtils.isEmpty((String)obj)){
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Method close all used resources such as Connection , Statement and ResultSet.
	 */
	private void closeResources(ResultSet rs, PreparedStatement stmt, Connection conn){
		try {
			if(rs != null){
				rs.close();
			}
			if(stmt != null){
				stmt.close();
			}
			if(conn != null){
				conn.close();
			}
		} catch (SQLException e) {
			System.out.println("Error occurred in closing DB connection ...");
			e.printStackTrace();
		}
	}
	
	public HashMap<String,Object> getBookingReportExcel(String siteId, String reqNo, String travelDateStr, String travelType
			, String travellerId, String bookingStatus, String bookedBy, String travelAgency, String loginUser, String reportType, String travelStatus) throws SQLException, ParseException{
		CallableStatement cStmt = null;
		ResultSet rs=null;
		DbConnectionBean objCon=new DbConnectionBean();
		Connection con=objCon.getConnection();

		HashMap<String,Object> dataMap = new HashMap<String,Object>();	
		ArrayList<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
		ArrayList columList = new ArrayList();

		int index = 1;
		cStmt = con.prepareCall("{call PROC_TRAVEL_BOOKING_REPORT(?,?,?,?,?,?,?,?,?,?,?,?)}");
		cStmt.setString(index++, siteId.trim());
		cStmt.setString(index++, reqNo.trim());
		cStmt.setString(index++, travelDateStr.trim());
		cStmt.setString(index++, travelType.trim());
		cStmt.setString(index++, travellerId.trim());
		cStmt.setString(index++, bookingStatus.trim());
		cStmt.setString(index++, bookedBy.trim());
		cStmt.setString(index++, travelAgency.trim());
		cStmt.setString(index++, reportType.trim());
		cStmt.setString(index++, travelStatus.trim());
		cStmt.setString(index++, loginUser.trim());
		cStmt.setInt(index++, 0);
		boolean result = cStmt.execute();
		rs = cStmt.getResultSet();

		ResultSetMetaData mdrs = rs.getMetaData();
		int columCount = mdrs.getColumnCount();
		for(int i=1;i<=columCount;i++){
			columList.add(mdrs.getColumnName(i));
		}
		
		dataMap.put("colName",columList);
	//	dataMap.put("colNameCount",columCount);
		dataMap.put("colValue",rs);
		
		return dataMap;
	}
	
	public ArrayList<ArrayList<String>> getGrpUserDetailsFromXML(String userDetailXML, String grpTravelFlag) throws Exception  {
		ArrayList<String> tktFlags 	= new ArrayList<String>();
		ArrayList<String> names 	= new ArrayList<String>();
		ArrayList<String> dobs 		= new ArrayList<String>();
		ArrayList<String> desigs 	= new ArrayList<String>();
		ArrayList<String> mobNos 	= new ArrayList<String>();
		ArrayList<String> forexes 	= new ArrayList<String>();
		ArrayList<String> grpUserIds= new ArrayList<String>();
		
		ArrayList<ArrayList<String>> userDetails = new ArrayList<ArrayList<String>>();
		
		JAXBContext jc = JAXBContext.newInstance(UserBeans.class);
		Unmarshaller unmarshaller = jc.createUnmarshaller();
		
		if (grpTravelFlag.equalsIgnoreCase("Y") && !userDetailXML.equals("")) {
			try {
				File file = new File("GroupUserDetails.xml");
				
				if(!file.exists()) {
					file.createNewFile();
				} else {
					PrintWriter writer = new PrintWriter(file);
					writer.print("");
					writer.close();
				}
				
				FileWriter fileWriter = new FileWriter(file.getName(),true);
		        BufferedWriter bufferWriter = new BufferedWriter(fileWriter);
		        bufferWriter.write(userDetailXML);
		        bufferWriter.close();
			
				UserBeans ubs = (UserBeans) unmarshaller.unmarshal(file);
				
				for(UserBean ub : ubs.getUserBeans()) {
					
					if(ub.getTktFlag().equals("") || ub.getTktFlag().trim().equals("-")) {
						tktFlags.add("N");
			        } else {
			        	tktFlags.add(ub.getTktFlag());
			        }
					
					if(ub.getName().equals("") || ub.getName().trim().equals("-")) {
			        	names.add("");
			        } else {
			        	names.add(ub.getName());
			        }
			       
			        if(ub.getDob().equals("") || ub.getDob().trim().equals("-")) {
			        	dobs.add("");
			        } else {
			        	if (ub.getDob().indexOf("-")>-1) {
				        	
			        		String[] parts	= (ub.getDob().trim()).split("-");
							String str 		= parts[2]+"/"+parts[1]+"/"+parts[0];
				        	dobs.add(str.trim());
				        	
			        	} else {
			        		dobs.add(ub.getDob());
			        	}
			        }
			        
			        if(ub.getDesig().equals("") || ub.getDesig().trim().equals("-")) {
			        	desigs.add("");
			        } else {
			        	desigs.add(ub.getDesig());
			        }
			        
			        if(ub.getMobileNo().equals("") || ub.getMobileNo().trim().equals("-")) {
			        	mobNos.add("");
			        } else {
			        	mobNos.add(ub.getMobileNo());
			        }
			        
			        if(ub.getForex().equals("")) {
			        	forexes.add("-");
			        } else {
			        	forexes.add(ub.getForex());
			        }
			        
			        if(ub.getGrpUserId().equals("") || ub.getGrpUserId().trim().equals("-")) {
			        	grpUserIds.add("");
			        } else {
			        	grpUserIds.add(ub.getGrpUserId());
			        }
			        
				}
				if (file.exists()) {
		             file.delete();
		        }
				
				userDetails.add(tktFlags);
				userDetails.add(names);
				userDetails.add(dobs);
				userDetails.add(desigs);
				userDetails.add(mobNos);
				userDetails.add(forexes);
				userDetails.add(grpUserIds);
				
			} catch (IOException e) {
				System.out.println("XML to Array Conversion Failed");
				e.printStackTrace();
			}
		}
		return userDetails;
	}
	
	public String getBrowserInfo(String browser) {
		String browserType = "";
		
		 if (browser.indexOf("rv") >0 && browser.indexOf("Trident") >0 && browser.indexOf("Chrome") ==-1 && browser.indexOf("Firefox") ==-1 && browser.indexOf("Safari") ==-1 && browser.indexOf("AppleWebKit") ==-1) {
			 browserType = "IE v"+browser.substring(browser.indexOf("rv")+3,browser.indexOf(")"));
		 }
		 if (browser.indexOf("Edge") >0 && browser.indexOf("Trident") ==-1 && browser.indexOf("Firefox") ==-1) {
			 browserType = "EDGE v"+browser.substring(browser.indexOf("Edge")+5);
		 }
		 if (browser.indexOf("Chrome") >0 && browser.indexOf("Trident") ==-1 &&browser.indexOf("Edge") ==-1 && browser.indexOf("Firefox") ==-1) {
			 browserType = "CHROME v"+browser.substring(browser.indexOf("Chrome")+7,browser.indexOf(" Safari"));
		 }
		 if (browser.indexOf("Firefox") >0 && browser.indexOf("Trident") ==-1 && browser.indexOf("Chrome") ==-1 && browser.indexOf("Safari") ==-1 && browser.indexOf("AppleWebKit") ==-1) {
			 browserType = "FIREFOX v"+browser.substring(browser.indexOf("Firefox")+8);
		 }
		 if (browserType.equals("")) {
			 String browsername 		= "";
			 String browserversion 		= "";
			 String subsString 			= "";
			 String browserSubString[] 	= { "MSIE", "Firefox", "Chrome", "Opera","Netscape", "Safari" };
   		 
			if (browser.contains("MSIE")) {
							subsString = browser.substring(browser.indexOf("MSIE"));
							String Info[] = (subsString.split(";")[0]).split(" ");
							browsername = Info[0];
							browserversion = Info[1];
			} else {
				for (int index = 1; index < browserSubString.length; index++) {
					if (browser.contains(browserSubString[index])) {
						subsString = browser.substring(browser.indexOf(browserSubString[index]));
						String Info[] = (subsString.split(" ")[0]).split("/");
						browsername = Info[0];

						if (browser.indexOf("Version") != -1) {
							browserversion = browser.substring(browser.indexOf("Version")).split(" ")[0].split(";")[0].split("/")[1];
						} else {
							browserversion = Info[1];
						}
						break;
					}
				}
				if (browsername.equals("")) {
					subsString = browser.substring(browser.indexOf("Windows NT"));
					browsername = subsString.split(";")[0];
					subsString = browser.substring(browser.indexOf("Trident"));
					browserversion = subsString.split(";")[0];
				}
			}
			browserType = browsername + " " + browserversion;
		 }
		 return browserType;
	}
	
	public void insertInfoInDbOnLogin(String user_Id,String ipAddress,String browser,String ssoFlag,String user){		
		
		int index					= 0 ;
    	CallableStatement cStmt		= null;
    	DbConnectionBean dbConBean 	= new DbConnectionBean();
    	Connection con  			= dbConBean.getConnection();
    	
    	try {
    		cStmt = con.prepareCall("{call PROC_LOGIN_INFO(?,?,?,?,?,?,?)}");
    	  	cStmt.setString(++index, user_Id);
    	  	cStmt.setString(++index, ipAddress.trim());
    	  	cStmt.setString(++index, "Y");
    	  	cStmt.setString(++index, "INSERT");
    	  	cStmt.setString(++index, browser.trim());
    	  	cStmt.setString(++index, ssoFlag.trim());
    	  	cStmt.setString(++index, user);
    	    
    	  	cStmt.execute();
    	  	cStmt.close();
    	  	con.close();
    	} catch (SQLException e) {
			System.out.println("ERROR: Login Info. not inserted on Login");
			e.printStackTrace();
		}
	  	
	}
	
	public void updateLogoutInfoOnSessionTimeOut(String user_Id,String ipAddress){		
		if(user_Id != null && ipAddress!=null) {
			int index					= 0 ;
			CallableStatement cStmt		= null;
			DbConnectionBean dbConBean 	= new DbConnectionBean();
			Connection con  			= dbConBean.getConnection();	
			
		  	try {
				cStmt = con.prepareCall("{call PROC_LOGIN_INFO(?,?,?,?,?,?,?)}");
				cStmt.setString(++index, user_Id);
			  	cStmt.setString(++index, ipAddress.trim());
			  	cStmt.setString(++index, "");
			  	cStmt.setString(++index, "UPDATE");
			  	cStmt.setString(++index, "");
			  	cStmt.setString(++index, "");
			  	cStmt.setString(++index, "");
			    
			  	cStmt.execute();
			  	cStmt.close();
			  	con.close();
			} catch (SQLException e) {
				System.out.println("ERROR: Logout info not updated on Session Timeout.");
				e.printStackTrace();
			}
		}
	}
}
