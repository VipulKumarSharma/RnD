package src.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

import src.beans.Accommodation;
import src.beans.AdvanceForex;
import src.beans.Approver;
import src.beans.BudgetActual;
import src.beans.Car;
import src.beans.Comment;
import src.beans.Fare;
import src.beans.Flight;
import src.beans.Passport;
import src.beans.RewardCard;
import src.beans.Train;
import src.beans.TravelDetails;
import src.beans.TravelFare;
import src.beans.TravelRequest;
import src.beans.User;
import src.beans.Visa;
import src.connection.DbConnectionBean;
import src.enumTypes.TravelRequestEnums;

public class T_QuicktravelRequestDaoImpl{

	private  DbConnectionBean dbConBean;
	private  ResultSet rs;
	static Logger logger = Logger.getLogger(T_QuicktravelRequestDaoImpl.class.getName());

	//Get flag to check both Approval Level(1 & 2) is mandatory or not
	public String getManadatoryAppFlag(String siteId){
		String strMandatatoryApvFlag = null;
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}

		String strSql="SELECT MANDATORY_APP_FLAG FROM dbo.M_SITE ms WHERE ms.STATUS_ID=10 and ms.SITE_ID="+siteId;
		rs = dbConBean.executeQuery(strSql);  
		try {
			if(rs.next()) {
				strMandatatoryApvFlag = rs.getString("MANDATORY_APP_FLAG");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return strMandatatoryApvFlag;
	}
	
	//Get flag to show Approval Level 3 (Board Member)
	public String getAppLvl3flgforBM(String siteId){
		String strAppLvl3flgforBM = null;
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}

		String strSql="SELECT SHOW_APP_LVL_3 FROM dbo.M_SITE ms WHERE ms.STATUS_ID=10 and ms.SITE_ID="+siteId;
		rs = dbConBean.executeQuery(strSql);  
		try {
			if(rs.next()) {
				strAppLvl3flgforBM = rs.getString("SHOW_APP_LVL_3");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return strAppLvl3flgforBM;
	}
	
	//Get flag to show Cost Centre
	public String getCostCentreFlag(String siteId){
		String strShowflag = null;
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}

		String strSql="SELECT 1 FROM M_COST_CENTRE WHERE SITE_ID="+siteId+" AND M_COST_CENTRE.STATUS_ID=10";
		rs = dbConBean.executeQuery(strSql);  
		try {
			if(rs.next()) {
				 strShowflag = "y";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return strShowflag;
	}
	
	//Get flag to show Total Travel Fare
	public String getMailToMataFlag(String siteId){
		String strShowflag = null;
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}

		String strSql="SELECT MAIL_TO_MATA FROM M_SITE WHERE SITE_ID="+siteId+" AND STATUS_ID=10";
		rs = dbConBean.executeQuery(strSql);  
		try {
			if(rs.next()) {
				 strShowflag = rs.getString("MAIL_TO_MATA")==null? "N":rs.getString("MAIL_TO_MATA").trim();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return strShowflag;
	}
		
	//Get Approval Level 3 flag to show "Cost Centre", "Total fare with Currency", and to check "Approval level 1 or 2" is mandatory or not  
	public String getAppLvl3Flag(String userId){
		String strAppLvl3flg = null;
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}

		String strSql="SELECT SHOW_APP_LVL_3 FROM M_DIVISION MD INNER JOIN	M_USERINFO MU ON MU.DIV_ID=MD.DIV_ID WHERE USERID="+userId;
		rs = dbConBean.executeQuery(strSql);  
		try {
			if(rs.next()) {
				strAppLvl3flg = rs.getString("SHOW_APP_LVL_3");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return strAppLvl3flg;
	}
	
	  
		public String getShowBudgetFlag(String siteId){
			String strSHOW_BUD_INPUT = null;
			if(dbConBean == null){
				dbConBean  = new DbConnectionBean();
			}

			String strSql="SELECT SHOW_BUD_INPUT FROM M_SITE WHERE site_id = "+siteId+"";
			rs = dbConBean.executeQuery(strSql);  
			try {
				if(rs.next()) {
					strSHOW_BUD_INPUT = rs.getString("SHOW_BUD_INPUT");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return strSHOW_BUD_INPUT;
		}
	
	//Get Unit Head flag to check "Approval level 1 or 2" is mandatory or not  
	public String getUnitHeadFlag(String userId, String siteId){
		String strUnit_Head = null;
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}

		String strSql="SELECT A.UNIT_HEAD FROM USER_MULTIPLE_ACCESS AS A INNER JOIN M_USERINFO AS B ON A.USERID = B.USERID WHERE (A.STATUS_ID = 10) AND (B.STATUS_ID = 10) AND (A.UNIT_HEAD = 1) AND A.USERID = "+userId+" AND A.SITE_ID = "+siteId+" ";
		rs = dbConBean.executeQuery(strSql);  
		try {
			if(rs.next()) {
				strUnit_Head = rs.getString("UNIT_HEAD");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return strUnit_Head;
	}

	//Get Base Currency
	public String getBaseCurrency(String siteId){
		String strBaseCur = null;
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}

		String strSql="SELECT ISNULL(CURRENCY,'') AS BASE_CUR FROM dbo.M_SITE ms WHERE ms.STATUS_ID=10 AND ms.SITE_ID="+siteId;
		rs = dbConBean.executeQuery(strSql);
		try {
			if(rs.next()) {
				strBaseCur = rs.getString("BASE_CUR");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return strBaseCur;
	}
	
	public String getPriceDesicionForDom(String siteId) {
		String strforPriceDesicionDom = null;
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}

		String strSql="Select isnull(DOM_LOCAL_AGENT,'') as DOM_LOCAL_AGENT From m_site where site_id="+ siteId + " and status_id=10";
		rs = dbConBean.executeQuery(strSql);
		try {
			while (rs.next()) {	
				strforPriceDesicionDom = rs.getString("DOM_LOCAL_AGENT");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return strforPriceDesicionDom;
	}
	
	
	public String getPriceDesicionForInt(String siteId) {
		String strforPriceDesicionInt = null;
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}

		String strSql="Select isnull(INT_LOCAL_AGENT,'') as INT_LOCAL_AGENT From m_site where site_id="+ siteId + " and status_id=10";
		rs = dbConBean.executeQuery(strSql);
		try {
			while (rs.next()) {	
				strforPriceDesicionInt = rs.getString("INT_LOCAL_AGENT");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return strforPriceDesicionInt;
	}

	//Get Domestic Travel Request Details
	public ResultSet getTravelRequestDetailDom(String strTravelId){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}

		String strSql = "SELECT LTRIM(RTRIM(TD.SITE_ID)) AS SITE_ID,LTRIM(RTRIM(TD.TRAVEL_REQ_ID)) as TRAVEL_REQ_ID,"
				+" LTRIM(RTRIM(TD.TRAVELLER_ID)) AS TRAVELLER_ID, LTRIM(RTRIM(TD.MEAL)) AS MEAL, MANAGER_ID, HOD_ID,"
				+" ISNULL(.DBO.CONVERTDATEDMY1(TD.TRAVEL_DATE),'') AS TRAVEL_DATE,LTRIM(RTRIM(TD.TRANSIT_TYPE)) "
				+" AS TRANSITTYPE,  ISNULL(TD.TRANSIT_BUDGET,'') AS BUDGET,LTRIM(RTRIM(BUDGET_CURRENCY)) "
				+" AS BUDGET_CURRENCY,TD.PLACE AS PLACE,  ISNULL(.DBO.CONVERTDATEDMY1(TD.CHECK_IN_DATE),'') AS CHECKINDATE,"
				+" ISNULL(.DBO.CONVERTDATEDMY1(TD.CHECK_OUT_DATE),'') AS CHECKOUTDATE,LTRIM(RTRIM(TD.REMARKS)) AS REMARKS,"
				+" ISNULL(TD.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,ISNULL(TD.REASON_FOR_SKIP,'') AS REASON_FOR_SKIP,"
				+" TD.BOARD_MEMBER_ID,TD.CC_ID, ISNULL(TD.IDENTITY_PROOFNO,'') AS IDENTITY_PROOFNO,"
				+" ISNULL(TD.IDENTITY_PROOF,'0') AS IDENTITY_PROOF, ISNULL(TD.PROJECTNO,'') AS PROJECTNO, "
				+" ISNULL(TD.FARE_CHANGEABLE_FLAG,'2') AS FARE_CHANGEABLE_FLAG, ISNULL(TD.FARE_REFUNDABLE_FLAG,'2') "
				+" AS FARE_REFUNDABLE_FLAG, ISNULL(TD.NO_OF_BAGGAGE,'0') AS NO_OF_BAGGAGE, ISNULL(TD.BAHNCARD_NUMBER,'') "
				+" AS BAHNCARD_NUMBER,ISNULL(.DBO.CONVERTDATEDMY1(BAHNCARD_VALID_DATE),'') AS BAHNCARD_VALID_DATE, ISNULL(TD.BAHNCARD_DISCOUNT,'25') AS BAHNCARD_DISCOUNT, "
				+" ISNULL(TD.BAHNCARD_CLASS,'2') AS BAHNCARD_CLASS, ISNULL(TD.ONLINE_TICKET,'2') AS ONLINE_TICKET, "
				+" TD.SPECIAL_TRAIN AS SPECIAL_TRAIN, ISNULL(TD.FLIGHT_REMARKS,'') AS FLIGHT_REMARKS, "
				+" ISNULL(TD.TRAIN_REMARKS,'') AS TRAIN_REMARKS, ISNULL(TD.CAR_REMARKS,'') AS CAR_REMARKS, TD.FARE_CURRENCY, TD.FARE_AMOUNT "
				+" FROM T_TRAVEL_DETAIL_DOM TD (NOLOCK) WHERE TRAVEL_ID="+strTravelId+" AND APPLICATION_ID=1 AND STATUS_ID=10";

		return rs = dbConBean.executeQuery(strSql);
	}

	//Get International Travel Request Details
	public ResultSet getTravelRequestDetailInt(String strTravelId){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}

		String strSql = "SELECT TRAVEL_REQ_ID,SITE_ID,TRAVELLER_ID,AGE,SEX,MEAL,VISA_REQUIRED,VISA_COMMENT, "
				+" DBO.CONVERTDATEDMY1(TRAVEL_DATE)AS TRAVEL_DATE, INSURANCE_REQUIRED,NOMINEE, RELATION, "
				+" INSURANCE_COMMENTS, HOTEL_REQUIRED,RTRIM(LTRIM(BUDGET_CURRENCY))AS BUDGET_CURRENCY , "
				+" ISNULL(HOTEL_BUDGET,'') AS HOTEL_BUDGET, REMARKS,  DBO.CONVERTDATEDMY1(CHECK_IN_DATE)AS CHECK_IN_DATE, "
				+" DBO.CONVERTDATEDMY1(CHECK_OUT_DATE)AS CHECK_OUT_DATE,   RTRIM(LTRIM(APPROVER_SELECTION)) AS APPROVER_SELECTION, "
				+" MANAGER_ID,HOD_ID,  LTRIM(RTRIM(ISNULL(CARD_TYPE,''))) AS CARD_TYPE,LTRIM(RTRIM(ISNULL(CARD_NUMBER1,''))) "
				+" AS CARD_NUMBER1,LTRIM(RTRIM(ISNULL(CARD_NUMBER2,''))) AS CARD_NUMBER2 ,LTRIM(RTRIM(ISNULL(CARD_NUMBER3,''))) "
				+" AS CARD_NUMBER3, LTRIM(RTRIM(ISNULL(CARD_NUMBER4,''))) AS CARD_NUMBER4 ,LTRIM(RTRIM(ISNULL(CVV_NUMBER,''))) "
				+" AS CVV_NUMBER,LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CARD_EXP_DATE),''))) AS CARD_EXP_DATE,"
				+" ISNULL(REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,ISNULL(REASON_FOR_SKIP,'') AS REASON_FOR_SKIP, ISNULL(PLACE,'') "
				+" AS  PLACE, ISNULL(CARD_HOLDER_NAME,'') AS CARD_HOLDER_NAME,BOARD_MEMBER_ID,CC_ID, ISNULL(PROJECTNO,'') AS PROJECTNO,"
				+" ISNULL(FARE_CHANGEABLE_FLAG,'2') AS FARE_CHANGEABLE_FLAG, ISNULL(FARE_REFUNDABLE_FLAG,'2') AS FARE_REFUNDABLE_FLAG, "
				+" ISNULL(NO_OF_BAGGAGE,'0') AS NO_OF_BAGGAGE, ISNULL(BAHNCARD_NUMBER,'') AS BAHNCARD_NUMBER,ISNULL(.DBO.CONVERTDATEDMY1(BAHNCARD_VALID_DATE),'') AS BAHNCARD_VALID_DATE, "
				+" ISNULL(BAHNCARD_DISCOUNT,'25') AS BAHNCARD_DISCOUNT, ISNULL(BAHNCARD_CLASS,'2') AS BAHNCARD_CLASS, "
				+" ISNULL(ONLINE_TICKET,'2') AS ONLINE_TICKET, SPECIAL_TRAIN AS SPECIAL_TRAIN, "
				+" ISNULL(FLIGHT_REMARKS,'') AS FLIGHT_REMARKS, ISNULL(TRAIN_REMARKS,'') AS TRAIN_REMARKS, ISNULL(CAR_REMARKS,'') AS CAR_REMARKS, FARE_CURRENCY, FARE_AMOUNT "
				+" FROM  T_TRAVEL_DETAIL_INT  (NOLOCK) WHERE TRAVEL_ID="+strTravelId+" AND APPLICATION_ID=1 AND STATUS_ID=10";

		return rs = dbConBean.executeQuery(strSql);
	}

	//Get Billing Information of Travel Request
	public ResultSet getBillingInformation(String strTravelId, String strTravelType){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		String strSql = null;
		if(strTravelType.equals("D")) {
			strSql = "SELECT BILLING_SITE,BILLING_CLIENT,RTRIM(LTRIM(convert(decimal(20,2),TOTAL_AMOUNT))) AS TOTAL_AMOUNT, RTRIM(LTRIM(TA_CURRENCY)) AS TA_CURRENCY, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE))) AS TRAVELLER_CHEQUE, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE1))) AS TRAVELLER_CHEQUE1, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE2))) AS TRAVELLER_CHEQUE2, RTRIM(LTRIM(TC_CURRENCY)) AS TC_CURRENCY,RTRIM(LTRIM(TC_CURRENCY1)) AS TC_CURRENCY1,RTRIM(LTRIM(TC_CURRENCY2)) AS TC_CURRENCY2, EXPENDITURE_REMARKS, CASH_BREAKUP_REMARKS, TRAVEL_REQ_ID, SITE_ID,TK_PROVIDER_FLAG,TK_AIRLINE_NAME,TK_CURRENCY,TK_AMOUNT,TK_REMARKS , "
					+ " YTM_BUDGET , YTD_ACTUAL , AVAIL_BUDGET , EST_EXP , EXP_REMARKS,FARE_CURRENCY,FARE_AMOUNT"
					+ " FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="
					+ strTravelId + " AND APPLICATION_ID=1 AND STATUS_ID=10";
		}
		else if(strTravelType.equals("I")) {
			strSql = "SELECT BILLING_SITE,BILLING_CLIENT,RTRIM(LTRIM(convert(decimal(20,2),TOTAL_AMOUNT))) AS TOTAL_AMOUNT, RTRIM(LTRIM(TA_CURRENCY)) AS TA_CURRENCY, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE))) AS TRAVELLER_CHEQUE, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE1))) AS TRAVELLER_CHEQUE1, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE2))) AS TRAVELLER_CHEQUE2, RTRIM(LTRIM(TC_CURRENCY)) AS TC_CURRENCY,RTRIM(LTRIM(TC_CURRENCY1)) AS TC_CURRENCY1,RTRIM(LTRIM(TC_CURRENCY2)) AS TC_CURRENCY2, EXPENDITURE_REMARKS, CASH_BREAKUP_REMARKS, TRAVEL_REQ_ID, SITE_ID,TK_PROVIDER_FLAG,TK_AIRLINE_NAME,TK_CURRENCY,TK_AMOUNT,TK_REMARKS , "
					+ " YTM_BUDGET , YTD_ACTUAL , AVAIL_BUDGET , EST_EXP , EXP_REMARKS,FARE_CURRENCY,FARE_AMOUNT"
					+ " FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="
					+ strTravelId + " AND APPLICATION_ID=1 AND STATUS_ID=10";
		}
		return rs = dbConBean.executeQuery(strSql);
	}

	//Get Traveller Information
	public ResultSet getTravellerInfo(String strUserId){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		String strSql	=  " SELECT USERID,SITE_ID,dbo.SITENAME(SITE_ID) AS SITENAME, FIRSTNAME, LASTNAME, ISNULL(MIDDLENAME ,'') AS MIDDLENAME, " +
				" LTRIM(RTRIM(EMAIL)) AS EMAIL, ISNULL(CONTACT_NUMBER,'') AS CONTACT_NUMBER, ISNULL(ADDRESS,'') AS ADDRESS, " +
				" ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(IDENTITY_ID,-1) AS IDENTITY_ID, ISNULL(IDENTITY_NO,'') AS IDENTITY_NO, " + 
				" LTRIM(RTRIM(ISNULL(PASSPORT_NO,''))) AS PASSPORT_NO, ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE, ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE, " +
				" ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE, ISNULL(dbo.DESIGNATIONNAME(DESIG_ID),'') AS DESIG,  ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB, " +
				" GENDER AS GENDER, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2, " +
				" ISNULL(FF_AIR_NAME3,'') AS FF_AIR_NAME3, ISNULL(FF_AIR_NAME4,'') AS FF_AIR_NAME4, ISNULL(FF_NUMBER,'') AS FF_NUMBER, ISNULL(FF_NUMBER1,'') AS FF_NUMBER1, " +
				" ISNULL(FF_NUMBER2,'') AS FF_NUMBER2, ISNULL(FF_NUMBER3,'') AS FF_NUMBER3, ISNULL(FF_NUMBER4,'') AS FF_NUMBER4,   ISNULL(HOTEL_NAME,'') AS HOTEL_NAME, " +
				" ISNULL(HOTEL_NAME1,'') AS HOTEL_NAME1, ISNULL(HOTEL_NAME2,'') AS HOTEL_NAME2,ISNULL(HOTEL_NAME3,'') AS HOTEL_NAME3, ISNULL(HOTEL_NAME4,'') AS HOTEL_NAME4, " +
				" ISNULL(HOTEL_NUMBER,'') AS HOTEL_NUMBER, ISNULL(HOTEL_NUMBER1,'') AS HOTEL_NUMBER1, ISNULL(HOTEL_NUMBER2,'') AS HOTEL_NUMBER2, " + 
				" ISNULL(HOTEL_NUMBER3,'') AS HOTEL_NUMBER3, ISNULL(HOTEL_NUMBER4,'') AS HOTEL_NUMBER4, ISNULL(NATIONALITY,'') AS NATIONALITY, "+
				" ISNULL(FULL_NAME,'') AS FULL_NAME, ISNULL(PASSPORT_F_NAME,'') AS PASSPORT_F_NAME, ISNULL(PASSPORT_L_NAME,'') AS PASSPORT_L_NAME, " +
				" DEPT_ID AS COST_CENTER, DBO.DEPARTMENTNAME(DEPT_ID) AS COST_CENTER_NAME, REPORT_TO AS MANAGER, DEPT_HEAD AS HOD, ISNULL(PASSPORT_ISSUE_COUNTRY,'0') AS PP_ISSUE_COUNTRY_ID FROM M_USERINFO WHERE USERID = '"+strUserId+"' AND APPLICATION_ID = 1 ";

		return rs = dbConBean.executeQuery(strSql);
	}
	
	//Get Special Meal List
	public Map<String, String> getSpecialMeal(String strTravelAgencyId){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Map<String, String> specialMeal = new LinkedHashMap<String, String>();
		 String strSql =   "SELECT MEAL_ID, MEAL_NAME FROM M_MEAL (NOLOCK) WHERE TRAVEL_AGENCY_ID = "+strTravelAgencyId+" AND STATUS_ID =10 ORDER BY MEAL_ID";
			rs       =   dbConBean.executeQuery(strSql);  
         try {
			while(rs.next()){
					specialMeal.put(rs.getString("MEAL_ID"), rs.getString("MEAL_NAME"));
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
         return specialMeal;
	}
	
	//Get Preferred Time List
	public Map<String, String> getPreferredTimeList(){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Map<String, String> preferredTimeList = new LinkedHashMap<String, String>();
		 String strSql =   "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY DISPLAY_ORDER ASC";
			rs       =   dbConBean.executeQuery(strSql);  
         try {
			while(rs.next()){
				preferredTimeList.put(rs.getString("TIME_ID"), rs.getString("PREFER_TIME"));
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
         return preferredTimeList;
	}
	
	//Get Flight Class List
	public Map<String, String> getFlightClassList(String strTravelAgencyId, String strUserId, String strTravelType, String strGroupTravelFlag){		
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Map<String, String> flightClassList = new LinkedHashMap<String, String>();
		
		String strSql ="", strSql2	= "";
		String strClassIds 		= "20, 21, 24";
		
		try {
		
			if(strTravelAgencyId != null && "2".equals(strTravelAgencyId) && "N".equals(strGroupTravelFlag)) {
				
				/*strSql2 = "SELECT CLASS_ID FROM M_USER_CLASS_PREFERENCE WHERE USERID ="+strUserId;
				
				rs     =   dbConBean.executeQuery(strSql2);				
				if(rs.next()) {
					strClassIds = rs.getString("CLASS_ID");
				 }
				rs.close();*/
				
				if(strClassIds != null && !"".equals(strClassIds) && "I".equalsIgnoreCase(strTravelType)) {
					
					strSql =   "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID=1 AND CLASS_ID IN ("+strClassIds+") AND TRAVEL_AGENCY_ID = "+strTravelAgencyId+" AND mmc.STATUS_ID=10 ORDER BY DISP_ORDER";
									
				} else {
					
					strSql =   "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID=1 AND CLASS_ID = 24 AND TRAVEL_AGENCY_ID = "+strTravelAgencyId+" AND mmc.STATUS_ID=10 ORDER BY DISP_ORDER";
				
				}
								 
			} else {
				
				strSql = "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID=1 AND TRAVEL_AGENCY_ID = "+strTravelAgencyId+" AND mmc.STATUS_ID=10 ORDER BY DISP_ORDER";
			
			}
		  
			rs  =   dbConBean.executeQuery(strSql);          
			while(rs.next()){
				flightClassList.put(rs.getString("CLASS_ID"), rs.getString("ELIGIBILITY"));
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
         return flightClassList;
	}
	
	//Get Flight Window List
	public Map<String, String> getFlightWindowList(String strTravelAgencyId){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Map<String, String> flightWindowList = new LinkedHashMap<String, String>();
		 String  strSql =   "SELECT  SEAT_ID, SEAT_NAME FROM  M_SEAT_PREFER (NOLOCK) WHERE (MODE_ID = 1) AND (TRAVEL_AGENCY_ID = "+strTravelAgencyId+") AND (STATUS_ID = 10) ORDER BY SEAT_ID";
			rs       =   dbConBean.executeQuery(strSql);  
         try {
			while(rs.next()){
				flightWindowList.put(rs.getString("SEAT_ID"), rs.getString("SEAT_NAME"));
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
         return flightWindowList;
	}
	
	//Get Train Window List
	public Map<String, String> getTrainWindowList(String strTravelAgencyId){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Map<String, String> trainWindowList = new LinkedHashMap<String, String>();
		 String  strSql =   "SELECT  SEAT_ID, SEAT_NAME FROM  M_SEAT_PREFER (NOLOCK) WHERE (MODE_ID = 2) AND (TRAVEL_AGENCY_ID = "+strTravelAgencyId+") AND (STATUS_ID = 10) ORDER BY SEAT_ID";
			rs       =   dbConBean.executeQuery(strSql);  
         try {
			while(rs.next()){
				trainWindowList.put(rs.getString("SEAT_ID"), rs.getString("SEAT_NAME"));
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
         return trainWindowList;
	}
	
	//Get Car Window List
	public Map<String, String> getCarWindowList(String strTravelAgencyId){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Map<String, String> carWindowList = new LinkedHashMap<String, String>();
		 String  strSql =   "SELECT  SEAT_ID, SEAT_NAME FROM  M_SEAT_PREFER (NOLOCK) WHERE (MODE_ID = 5) AND (TRAVEL_AGENCY_ID = "+strTravelAgencyId+") AND (STATUS_ID = 10) ORDER BY SEAT_ID";
			rs       =   dbConBean.executeQuery(strSql);  
         try {
			while(rs.next()){
				carWindowList.put(rs.getString("SEAT_ID"), rs.getString("SEAT_NAME"));
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
         return carWindowList;
	}
	
	//Get Train Class List
	public Map<String, String> getTrainClassList(String strTravelAgencyId){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Map<String, String> trainClassList = new LinkedHashMap<String, String>();
		 String strSql =   "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID=2 AND TRAVEL_AGENCY_ID = "+strTravelAgencyId+" AND mmc.STATUS_ID=10 ORDER BY DISP_ORDER";
			rs       =   dbConBean.executeQuery(strSql);  
         try {
			while(rs.next()){
				trainClassList.put(rs.getString("CLASS_ID"), rs.getString("ELIGIBILITY"));
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
         return trainClassList;
	}
	
	//Get Flight Class List
	public Map<String, String> getCarClassList(String strTravelAgencyId){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Map<String, String> carClassList = new LinkedHashMap<String, String>();
		 String strSql =   "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID=5 AND TRAVEL_AGENCY_ID = "+strTravelAgencyId+" AND mmc.STATUS_ID=10 ORDER BY DISP_ORDER";
			rs       =   dbConBean.executeQuery(strSql);  
         try {
			while(rs.next()){
				carClassList.put(rs.getString("CLASS_ID"), rs.getString("ELIGIBILITY"));
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
         return carClassList;
	}
	
	//Get Car Category List
	public Map<String, String> getCarCategoryList(String strCarClassType, String strTravelType, String strTravelAgencyId){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		if(strTravelType == null || "".equals(strTravelType)) {
			strTravelType = "D";
		}
		Map<String, String> carCategoryList = new LinkedHashMap<String, String>();
		String strSql =   "SELECT CAR_CATEGORY_ID, CATEGORY_NAME FROM M_CAR_CATEGORY WHERE CLASS_ID = "+strCarClassType+" AND TRAVEL_TYPE = '"+strTravelType+"' AND TRAVEL_AGENCY_ID = "+strTravelAgencyId+" AND STATUS_ID = 10";
			rs       =   dbConBean.executeQuery(strSql);  
         try {
			while(rs.next()){
				carCategoryList.put(rs.getString("CAR_CATEGORY_ID"), rs.getString("CATEGORY_NAME"));
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
         return carCategoryList;
	}
	
	//Get Currency List
	public Map<String, String> getCurrencyList(){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Map<String, String> currencyList = new LinkedHashMap<String, String>();
		 String strSql =   "Select Currency, CUR_CODE from m_currency (NOLOCK) where status_id=10";
			rs       =   dbConBean.executeQuery(strSql);  
         try {
			while(rs.next()){
				currencyList.put(rs.getString("CUR_CODE"), rs.getString("CUR_CODE"));
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
         return currencyList;
	}
	
	//Get Designation List
	public Map<String, String> getDesignationList(String strSiteId){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Map<String, String> designationList = new LinkedHashMap<String, String>();
		 String strSql =   "SELECT DESIG_ID, DESIG_NAME  FROM M_DESIGNATION where site_id="+strSiteId+" AND APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY DESIG_NAME";
			rs       =   dbConBean.executeQuery(strSql);  
         try {
			while(rs.next()){
				designationList.put(rs.getString("DESIG_ID"), rs.getString("DESIG_NAME"));
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
         return designationList;
	}
	
	//Get Mail Body for Mata-GmbH
	public String getMailBodyForMataGmbH(String travelId, String travelType, String travellerId){

		// Fetch entire request information
		logger.setLevel(Level.ALL);
		logger.info("[getMailBodyForMataGmbH] method body start ---->");
		TravelRequest requestInfo = getTravelRequestDetail(travelId,travelType,travellerId);
		User originator = requestInfo.getOriginator();
		User traveller = requestInfo.getTraveller();

		StringBuilder strMailMsg = new StringBuilder();
		strMailMsg.append("<html><head><title class='inputbox'>WELCOME TO STARS:  SAMVARDHANA MOTHERSON TRAVEL  APPROVAL SYSTEM </title> ")
		.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />")
		.append("<style type=\"text/css\">")
		.append("")
		.append(".bodyline-top{border-bottom:#A9A9A9 1px solid;}.bodyline-bottom{border-top:#A9A9A9 1px solid;}")
		.append(".reportHeading{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:13px;font-weight:bold;color:#ffffff;line-height:22px;background-color:#7a7a7a;padding-left:5px;text-align:left;}")
		.append(".reportSubHeading{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:12px;font-weight:bold;color:#000000;line-height:20px;background-color:#dddddd;padding-left:5px;text-align:left;}")
		.append(".reportCaption{width:auto;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#1d1d1d;line-height:20px;background-color:#f2f2f2;padding-left:5px;padding-right:5px;text-align:left;}")
		.append(".reportdata{width:auto;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight: normal;color:#373737;line-height:20px;background-color:#f7f7f7;padding-left:5px;padding-right:5px;text-align:left;}")
		.append(".reporttble{width: auto;max-width: 100%;border: #c7c7c5 1px solid;}</style></head>");

		String bodyLineTopStr = "border-bottom:#A9A9A9 1px solid;";
		String reportHeadingStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:13px;font-weight:bold;color:#ffffff;line-height:22px;background-color:#7a7a7a;padding-left:5px;text-align:left;\"";
		String reportSubHeadingStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:12px;font-weight:bold;color:#000000;line-height:20px;background-color:#dddddd;padding-left:5px;text-align:left;\"";
		String reportCaptionStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#1d1d1d;line-height:20px;background-color:#f2f2f2;padding-left:5px;padding-right:5px;text-align:left;\"";
		String reportdataStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight: normal;color:#373737;line-height:20px;background-color:#f7f7f7;padding-left:5px;padding-right:5px;text-align:left;\"";
		String reporttbleStr = "style=\"max-width: 100%;border: #c7c7c5 1px solid;\"";

		strMailMsg.append("<body style=\"margin:0;vertical-align: middle;\" align=\"left\">")
		.append("<table width=\"97%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"margin:0;\">")
		.append("<tr> <td height=\"45\" style=\""+bodyLineTopStr+"\"><ul style=\"margin:0;\"><li style=\"margin:0;\">");
		if(travelType.equalsIgnoreCase("D")){
			strMailMsg.append("<b>Domestic/Europe Journey Report</b>");
		}else{
			strMailMsg.append("<b>Intercont Journey Report</b>");
		}
		strMailMsg.append("</li></ul></td><td align=\"right\" valign=\"bottom\" style=\""+bodyLineTopStr+"\"></td></tr></table>");
		strMailMsg.append("<table style=\"padding-left:10px;margin:0;\" border=\"0\" cellpadding=\"5\" cellspacing=\"1\">");
		strMailMsg.append("<tr><td align=\"left\">")
		.append("<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
		.append("<tr><td height=\"0\" colspan=\"6\" align=\"left\" "+reportHeadingStr+">Request Information</td></tr>");

		strMailMsg.append("<tr>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Requisition Number</td>")
		.append("<td height=\"0\" "+reportdataStr+">"+requestInfo.getRequisitionNo()+"</td>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Originator</td>")
		.append("<td height=\"0\" "+reportdataStr+">"+originator.getFullName().toUpperCase()+"</td>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Originated On</td>")
		.append("<td height=\"0\" "+reportdataStr+" >"+requestInfo.getCreationDate()+"</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Division</td>")
		.append("<td height=\"0\" "+reportdataStr+">"+originator.getDivisionName().toUpperCase()+"</td>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Unit</td>")
		.append("<td height=\"0\" "+reportdataStr+">"+originator.getUnitName().toUpperCase()+"</td>")
		.append("<td height=\"0\" align=\"right\" "+reportCaptionStr+" >Department</td>")
		.append("<td height=\"0\" "+reportdataStr+" >"+originator.getDepartmentName().toUpperCase()+"</td>")
		.append("</tr>")
		.append("</table>")
		.append("</td>")
		.append("</tr>");

		// Personal Information Starts
		logger.info("[getMailBodyForMataGmbH] Personal Information block start ---->");
		strMailMsg.append("<tr><td> ")
		.append("<table align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\"> ")
		.append("<tr><td height=\"0\" colspan=\"8\" "+reportHeadingStr+">Personal Information</td></tr>")
		.append("<tr>")
		.append("<td "+reportCaptionStr+" >Unit</td><td "+reportdataStr+" >"+traveller.getUnitName()+"</td>")
		.append("<td "+reportCaptionStr+" >First Name</td><td "+reportdataStr+" >"+traveller.getFirstName()+"</td>")
		.append("<td "+reportCaptionStr+" >Last Name</td><td "+reportdataStr+" >"+traveller.getLastName()+"</td>")
		.append("<td "+reportCaptionStr+" >Designation</td><td "+reportdataStr+" >"+traveller.getDesignationName()+"</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<td "+reportCaptionStr+" >Contact No.</td><td "+reportdataStr+" >"+traveller.getContactNo()+"</td>")
		.append("<td "+reportCaptionStr+" >Cost Center</td><td "+reportdataStr+" >"+traveller.getCostCenterName()+"</td>")
		.append("<td "+reportCaptionStr+" >Project Number</td><td "+reportdataStr+" >"+requestInfo.getProjectNo()+"</td>")
		.append("<td "+reportCaptionStr+" >Gender</td><td "+reportdataStr+" >"+traveller.getGender()+"</td>")
		.append("</tr>");

		if(travelType.equalsIgnoreCase("I")){
			strMailMsg.append("<tr>")						
			.append("<td "+reportCaptionStr+" >Special Meal</td><td "+reportdataStr+">"+traveller.getMealPreferrence()+"</td>")
			.append("<td "+reportCaptionStr+" >Reason for travel</td><td "+reportdataStr+" colspan=\"5\">"+requestInfo.getReasonForTravel()+"</td>")
			.append("</tr>");
		} else {
			strMailMsg.append("<tr>")
			.append("<td "+reportCaptionStr+" >Reason for travel</td><td "+reportdataStr+" colspan=\"7\">"+requestInfo.getReasonForTravel()+"</td>")
			.append("</tr>");
		}
		strMailMsg.append("</table>")
		.append("</td></tr>");
		logger.info("[getMailBodyForMataGmbH] Personal Information block end.");

		// Reward card details
		logger.info("[getMailBodyForMataGmbH] Reward card details block start ---->");
		List<RewardCard> cardList = requestInfo.getRewardCardList();
		if(cardList != null && !cardList.isEmpty()){
			strMailMsg.append("<tr><td> ")
			.append("<table align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+">Rewards Card Details</td></tr>")
			.append("<tr><td "+reportCaptionStr+" >Airline Name</td><td "+reportCaptionStr+" >Number</td>")
			.append("<td "+reportCaptionStr+" >Hotel Chain</td><td "+reportCaptionStr+" >Number</td></tr>");

			for(RewardCard card : cardList){
				strMailMsg.append("<tr><td "+reportdataStr+" >"+card.getAirlineName()+"</td><td "+reportdataStr+" >"+card.getAirlineNo()+"</td>")
				.append("<td "+reportdataStr+" >"+card.getHotelChainName()+"</td><td "+reportdataStr+" >"+card.getHotelChainNo()+"</td></tr>");
			}
			strMailMsg.append("</table></td></tr>");
		}
		logger.info("[getMailBodyForMataGmbH] Reward card details block end.");

		// Flight Detail Block
		logger.info("[getMailBodyForMataGmbH] Flight Detail block start ---->");
		if(requestInfo.isFlightDetailExist()){
			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"8\" "+reportHeadingStr+">Flight Details</td></tr>")
			.append("<tr>")
			.append("<td "+reportCaptionStr+" ></td><td "+reportCaptionStr+" >Departure City</td>")
			.append("<td "+reportCaptionStr+" >Arrival City</td><td "+reportCaptionStr+" >Departure Date</td>")
			.append("<td "+reportCaptionStr+" >Preferred Time</td>")
			.append("<td "+reportCaptionStr+" >Class</td><td "+reportCaptionStr+" >Preferred seat</td>")
			.append("</tr>");

			List<Flight> flightList = requestInfo.getFlightDetailList();
			Flight detailFLT = null;
			for(int i=0; i<flightList.size(); i++){
				detailFLT = (Flight)flightList.get(i);

				if(!checkNullEmpty(detailFLT.getDepartureCity()) || !checkNullEmpty(detailFLT.getArrivalCity())) {							

					if(detailFLT.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())){
						strMailMsg.append("<tr><td "+reportCaptionStr+" >Outward Leg</td>");
					}
					if(detailFLT.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())){
						strMailMsg.append("<tr><td "+reportCaptionStr+" >Intermediate Leg</td>");
					}
					if(detailFLT.getJournyType().equals(TravelRequestEnums.JournyType.RETURNED.getId())){
						strMailMsg.append("<tr><td "+reportCaptionStr+" >Return Leg</td>");

					}
					strMailMsg.append("<td "+reportdataStr+" >"+detailFLT.getDepartureCity()+"</td><td "+reportdataStr+" >"+detailFLT.getArrivalCity()+"</td>")
					.append("<td "+reportdataStr+" >"+detailFLT.getDepartureDate()+"</td><td "+reportdataStr+" >"+detailFLT.getPreferredTimeType()+"&nbsp;"+detailFLT.getTiming()+"</td>")
					.append("<td "+reportdataStr+" >"+detailFLT.getTravelClass()+"</td>")
					.append("<td "+reportdataStr+" >"+detailFLT.getWindowSeatPreferrence()+"</td></tr>");
				}
			}
			if(!checkNullEmpty(detailFLT.getRemarks()) && !detailFLT.getRemarks().trim().equals("-")) {
				strMailMsg.append("<tr><td "+reportCaptionStr+">Remarks</td><td "+reportdataStr+" colspan=\"7\">"+detailFLT.getRemarks()+"</td></tr>");
			}
			strMailMsg.append("</table></td></tr>");

			// Flight Fares details
			logger.info("[getMailBodyForMataGmbH] Flight Fares Detail block start ---->");
			Fare flightFare = detailFLT.getFareDetail();
			if(flightFare != null){
				strMailMsg.append("<tr><td>")
				.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
				.append("<tr><td height=\"0\" colspan=\"6\" "+reportSubHeadingStr+">Fares</td></tr>")
				.append("<tr><td "+reportCaptionStr+" >Changeable against a fee</td>")
				.append("<td "+reportdataStr+">"+(!flightFare.isChangeableAgainstFee() ? "No" : "Yes")+"</td><td "+reportCaptionStr+" >Refundable against a fee</td>")
				.append("<td "+reportdataStr+">"+(!flightFare.isRefundableAgainstFee() ? "No" : "Yes")+"</td><td "+reportCaptionStr+" >Checked baggage</td>")
				.append("<td "+reportdataStr+">"+flightFare.getCheckedBaggageCount()+"</td></tr></table></td></tr>");
			}
			logger.info("[getMailBodyForMataGmbH] Flight Fares Detail block end.");
		}
		logger.info("[getMailBodyForMataGmbH] Flight Detail block end.");

		//Train Details
		logger.info("[getMailBodyForMataGmbH] Train Details block start ---->");
		if(requestInfo.isTrainDetailExist()){

			List<Train> trainList = requestInfo.getTrainDetailList();
			Train detailTRN = null;

			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"7\" "+reportHeadingStr+">Train Details</td></tr>")
			.append("<tr><td "+reportCaptionStr+" ></td>")
			.append("<td "+reportCaptionStr+" >Departure City</td>")
			.append("<td "+reportCaptionStr+" >Arrival City</td>")
			.append("<td "+reportCaptionStr+" >Departure Date</td>")
			.append("<td "+reportCaptionStr+" >Preferred Time</td>")
			.append("<td "+reportCaptionStr+" >Class</td>")
			.append("<td "+reportCaptionStr+" >Preferred seat</td></tr>");

			for(int i=0; i<trainList.size(); i++){
				detailTRN = (Train)trainList.get(i);

				if(!checkNullEmpty(detailTRN.getDepartureCity()) || checkNullEmpty(detailTRN.getArrivalCity())) {

					if(detailTRN.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())){
						strMailMsg.append("<tr><td "+reportCaptionStr+" >Outward Leg</td>");
					}
					if(detailTRN.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())){
						strMailMsg.append("<tr><td "+reportCaptionStr+" >Intermediate Leg</td>");
					}
					if(detailTRN.getJournyType().equals(TravelRequestEnums.JournyType.RETURNED.getId())){
						strMailMsg.append("<tr><td "+reportCaptionStr+" >Return Leg</td>");

					}
					strMailMsg.append("<td "+reportdataStr+" >"+detailTRN.getDepartureCity()+"</td><td "+reportdataStr+" >"+detailTRN.getArrivalCity()+"</td>")
					.append("<td "+reportdataStr+" >"+detailTRN.getDepartureDate()+"</td><td "+reportdataStr+" >"+detailTRN.getPreferredTimeType()+"&nbsp;"+detailTRN.getTiming()+"</td>")
					.append("<td "+reportdataStr+" >"+detailTRN.getTravelClass()+"</td><td "+reportdataStr+" >"+detailTRN.getSeatPreferrence_1()+"</td></tr>");
				}
			}
			if(!checkNullEmpty(detailTRN.getRemarks()) && !detailTRN.getRemarks().trim().equals("-")) {
				strMailMsg.append("<tr><td "+reportCaptionStr+">Remarks</td><td "+reportdataStr+" colspan=\"7\">"+detailTRN.getRemarks()+"</td></tr>");
			}
			strMailMsg.append("</table></td></tr>");

			// Train Fares detail
			logger.info("[getMailBodyForMataGmbH] Train Fares Detail block start ---->");
			Fare trainFare = detailTRN.getFareDetail();
			
			strMailMsg.append("<tr><td>")
			.append("<table align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">");
			
			if(trainFare != null) {
				strMailMsg.append("<tr><td height=\"0\" colspan=\"10\" "+reportSubHeadingStr+">Fares</td></tr>")
				.append("<tr>")	
				.append("<td "+reportCaptionStr+" >Bahncard No.</td><td "+reportdataStr+">"+trainFare.getBahnCardNo()+"</td>")				
				.append("<td "+reportCaptionStr+" >Discount</td><td "+reportdataStr+">"+trainFare.getDiscount()+"</td>")
				.append("<td "+reportCaptionStr+" >Class</td><td "+reportdataStr+">"+trainFare.getFareClass()+"</td>")
				.append("<td "+reportCaptionStr+" >Validity Date</td><td "+reportdataStr+">"+trainFare.getValidityDate()+"</td>")
				.append("<td "+reportCaptionStr+" >Online Ticket</td><td "+reportdataStr+">"+(!trainFare.isOnlineTicket() ? "No" : "Yes")+"</td>")
				.append("</tr>")
				.append("<tr>")				
				.append("<td "+reportCaptionStr+" >Sparpreis mit Zugbindung</td><td "+reportdataStr+" colspan=\"9\">"+(!detailTRN.isSpecialTrain() ? "No" : "Yes")+"</td>")
				.append("</tr>");
			} else {
				strMailMsg.append("<tr><td height=\"0\" colspan=\"2\" "+reportSubHeadingStr+">Fares</td></tr>")
				.append("<tr>")				
				.append("<td "+reportCaptionStr+" >Sparpreis mit Zugbindung</td><td "+reportdataStr+">"+(!detailTRN.isSpecialTrain() ? "No" : "Yes")+"</td>")
				.append("</tr>");
			}
			
			strMailMsg.append("</table></td></tr>");
			logger.info("[getMailBodyForMataGmbH] Train Fares Detail block end.");
		}
		logger.info("[getMailBodyForMataGmbH] Train Details block end.");

		//Rent A Car Section starts
		logger.info("[getMailBodyForMataGmbH] Rent A Car Section start ---->");
		if(requestInfo.isRentA_CarDetailExist()){
			Car car = null;
			String needGPS = "";
			String carCategory = "";
			String carClass = "";
			String carClassId = "";
			
			int setColSpan1 = 6; 
    		int setColSpan2 = 5; 
    		int setColSpan3 = 3; 
			
			List<Car> carList = requestInfo.getCarDetailList();
			carClass = carList.get(0).getCarClass();
			carClassId = carList.get(0).getCarClassId();
			
			if(carClassId != null && !"".equals(carClassId) && ("26".equals(carClassId) || "27".equals(carClassId) || "29".equals(carClassId))) {
	 			setColSpan1 = 6; 
        		setColSpan2 = 5; 
        		setColSpan3 = 3; 
	 		} else {
	 			setColSpan1 = 5; 
        		setColSpan2 = 4; 
        		setColSpan3 = 2; 
			} 
			
			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan="+setColSpan1+" "+reportHeadingStr+">Car Reservation&nbsp;-&nbsp;["+carClass+"]</td></tr>")
			.append("<tr><td "+reportCaptionStr+" ></td>")
			.append("<td "+reportCaptionStr+" >Date</td><td "+reportCaptionStr+" >Time</td>")
			.append("<td "+reportCaptionStr+" >City</td><td "+reportCaptionStr+" >Location</td>");
			
			if(carClassId != null && !"".equals(carClassId) && "26".equals(carClassId)) {
				strMailMsg.append("<td "+reportCaptionStr+" >Mobile Number</td>");
			} else if(carClassId != null && !"".equals(carClassId) && ("27".equals(carClassId) || "29".equals(carClassId))) {
				strMailMsg.append("<td "+reportCaptionStr+" >Routing</td>");
			}
			strMailMsg.append("</tr>");
			
			for(int i=0; i<carList.size(); i++){
				car = (Car)carList.get(i);

				strMailMsg.append("<tr><td "+reportCaptionStr+" >Start</td>")
				.append("<td "+reportdataStr+" >"+car.getStartDate()+"</td><td "+reportdataStr+" >"+car.getStartTime()+"</td>")
				.append("<td "+reportdataStr+" >"+car.getStartCity()+"</td><td "+reportdataStr+" >"+car.getStartLocation()+"</td>");

				if(carClassId != null && !"".equals(carClassId) && "26".equals(carClassId)) {
					strMailMsg.append("<td "+reportdataStr+" >"+car.getStartMobileNo()+"</td>");
				} else if(carClassId != null && !"".equals(carClassId) && ("27".equals(carClassId) || "29".equals(carClassId))) {
					strMailMsg.append("<td "+reportdataStr+" >"+car.getStartRouting()+"</td>");
				}				
				strMailMsg.append("</tr>");
				
				
				strMailMsg.append("<tr><td "+reportCaptionStr+" >End</td>")
				.append("<td "+reportdataStr+" >"+car.getEndDate()+"</td><td "+reportdataStr+" >"+car.getEndTime()+"</td>")
				.append("<td "+reportdataStr+" >"+car.getEndCity()+"</td><td "+reportdataStr+" >"+car.getEndLocation()+"</td>");

				if(carClassId != null && !"".equals(carClassId) && "26".equals(carClassId)) {
					strMailMsg.append("<td "+reportdataStr+" >"+car.getEndMobileNo()+"</td>");
				} else if(carClassId != null && !"".equals(carClassId) && ("27".equals(carClassId) || "29".equals(carClassId))) {
					strMailMsg.append("<td "+reportdataStr+" >"+car.getEndRouting()+"</td>");
				}
				strMailMsg.append("</tr>");
				
				needGPS = !car.isNeed_GPS() ? "No" : "Yes";
				carCategory = car.getCategory();
			}
			
			if(carClassId != null && !"".equals(carClassId) && ("26".equals(carClassId) || "27".equals(carClassId))) {
				strMailMsg.append("<tr><td height=\"0\" colspan="+setColSpan1+" "+reportSubHeadingStr+">Car Options</td></tr>")
				.append("<tr><td "+reportCaptionStr+" >Need GPS</td>")
				.append("<td "+reportdataStr+" >"+needGPS +"</td><td "+reportCaptionStr+" >Category</td>")
				.append("<td "+reportdataStr+" colspan="+setColSpan3+" >"+carCategory+"</td></tr>");
			}

			if(!checkNullEmpty(car.getRemarks()) && !car.getRemarks().trim().equals("-")) {
				strMailMsg.append("<tr><td "+reportCaptionStr+">Remarks</td><td "+reportdataStr+" colspan="+setColSpan2+">"+car.getRemarks()+"</td></tr>");
			}
			strMailMsg.append("</table></td></tr>");
		}
		logger.info("[getMailBodyForMataGmbH] Rent A Car Section end.");

		// Accommodation Detail Section Start
		logger.info("[getMailBodyForMataGmbH] Accommodation Detail Section start ---->");
		if(requestInfo.isAccomodationDetailExist()){
			List<Accommodation> accommodationList = requestInfo.getAccommodationList();
			Accommodation accommodation = null;

			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"5\" "+reportHeadingStr+">Accommodation</td></tr>")
			.append("<tr><td "+reportCaptionStr+" >##</td>")
			.append("<td "+reportCaptionStr+" >Place of Visit (City and Address)</td><td "+reportCaptionStr+" >Accommodation Type</td>")
			.append("<td "+reportCaptionStr+" >Check In Date</td><td "+reportCaptionStr+" >Check Out Date</td>")
			.append("</tr>");

			for(int i=0; i<accommodationList.size(); i++){
				accommodation = (Accommodation)accommodationList.get(i);

				strMailMsg.append("<tr><td "+reportdataStr+" >"+(i+1)+"</td>")
				.append("<td "+reportdataStr+" >"+accommodation.getPlaceOfVisit()+"</td><td "+reportdataStr+" >"+accommodation.getAccommodationType()+"</td>");
				strMailMsg.append("<td "+reportdataStr+" >"+accommodation.getCheckInDate()+"</td><td "+reportdataStr+" >"+accommodation.getCheckOutDate()+"</td></tr>");
			}
			if(!checkNullEmpty(accommodation.getRemarks()) && !accommodation.getRemarks().trim().equals("-")) {
				strMailMsg.append("<tr><td "+reportCaptionStr+" >Remarks</td><td "+reportdataStr+"  colspan=\"4\">"+accommodation.getRemarks()+"</td></tr>");
			}					
			strMailMsg.append("</table></td></tr>");
		}
		logger.info("[getMailBodyForMataGmbH] Accommodation Detail Section end.");

		// Passport Information Starts		
		logger.info("[getMailBodyForMataGmbH] Passport Information Section start ---->");
		if(travelType.equalsIgnoreCase("I")){
			Passport travellerPassportInfo = traveller.getPassport();

			strMailMsg.append("<tr><td>")
			.append("<table align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"6\" "+reportHeadingStr+">Passport Information</td></tr>")
			.append("<tr>")
			.append("<td "+reportCaptionStr+" >First Names</td><td "+reportdataStr+" >"+travellerPassportInfo.getFirstName()+"</td>")
			.append("<td "+reportCaptionStr+" >Last Names</td><td "+reportdataStr+" >"+travellerPassportInfo.getLastName()+"</td>")
			.append("<td "+reportCaptionStr+" >Date of birth</td><td "+reportdataStr+" >"+travellerPassportInfo.getDateOfBirth()+"</td>")
			.append("</tr>")
			.append("<tr>")
			.append("<td "+reportCaptionStr+" >Passport Number</td><td "+reportdataStr+" >"+travellerPassportInfo.getPassportNo()+"</td>")
			.append("<td "+reportCaptionStr+" >Nationality as per passport</td><td "+reportdataStr+" >"+travellerPassportInfo.getNationality()+"</td>")
			.append("<td "+reportCaptionStr+" >Place of Issue</td><td "+reportdataStr+" >"+travellerPassportInfo.getPlaceOfIssue()+"</td>")
			.append("</tr>")
			.append("<tr>")
			.append("<td "+reportCaptionStr+" >Date of issue</td><td "+reportdataStr+" >"+travellerPassportInfo.getDateOfIssue()+"</td>")
			.append("<td "+reportCaptionStr+" >Date of expiry</td><td "+reportdataStr+" >"+travellerPassportInfo.getDateOfExpiry()+"</td>")
			.append("<td "+reportCaptionStr+" >Visa Exists</td><td "+reportdataStr+" >"+(!travellerPassportInfo.isVisaExists() ? "No" : "Yes")+"</td>")
			.append("</tr>")
			.append("</table></td></tr>");
		}
		logger.info("[getMailBodyForMataGmbH] Passport Information Section end.");

		//Billing Instruction Section Start
		logger.info("[getMailBodyForMataGmbH] Billing Instruction Section start ---->");
		Approver billingApprover = requestInfo.getBillingApprover();
		if(billingApprover != null){
			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+" >Billing Instructions</td></tr>")

			.append("<tr><td height=\"0\" "+reportCaptionStr+" >Billing Client </td>")
			.append("<td height=\"0\" "+reportdataStr+" >"+billingApprover.getUnitName()+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Billing Approver</td>")
			.append("<td height=\"0\" "+reportdataStr+" >"+billingApprover.getName()+"</td></tr></tr></table></td></tr>");
		}
		logger.info("[getMailBodyForMataGmbH] Billing Instruction Section end.");

		// Approval Level Section Start -->
		logger.info("[getMailBodyForMataGmbH] Approval Level Section start ---->");
		List<Approver> approverLevelList = requestInfo.getApproverLevels();
		if(approverLevelList != null && !approverLevelList.isEmpty() && (approverLevelList.size() == 2)){
			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+" >Approvers</td></tr>")
			.append("<tr>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Approval Level 1 </td><td height=\"0\" "+reportdataStr+" >"+("-".equals(approverLevelList.get(0).getName()) ? "Not Applicable" : approverLevelList.get(0).getName())+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Approval Level 2 </td><td height=\"0\" "+reportdataStr+" >"+("-".equals(approverLevelList.get(1).getName()) ? "Not Applicable" : approverLevelList.get(1).getName())+"</td>")
			.append("</tr>");
			strMailMsg.append("</table></td></tr>");
		}
		logger.info("[getMailBodyForMataGmbH] Approval Level Section end.");

		// Approval List Section Start -->
		logger.info("[getMailBodyForMataGmbH] Approval List Section start ---->");
		List<Approver> approversList = requestInfo.getApprovers();
		Approver approverObj = null;
		if(approversList != null && !approversList.isEmpty()){
			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td colspan=\"5\" "+reportHeadingStr+" >Approvers List</td></tr>")
			.append("<tr><td  "+reportCaptionStr+" nowrap=\"nowrap\">S No.</td>")
			.append("<td  "+reportCaptionStr+">Name</td><td  "+reportCaptionStr+">Designation</td>")
			.append("<td  "+reportCaptionStr+">Status</td><td  "+reportCaptionStr+">Approval Date Time</td></tr>");

			for(int i=0; i<approversList.size(); i++){
				approverObj = (Approver)approversList.get(i);
				String apprvTime = (approverObj.getApproveTime() == null || approverObj.getApproveTime().trim().equals("")) ? "": "  "+approverObj.getApproveTime().trim();
				
				strMailMsg.append("<tr><td  "+reportdataStr+" style=\"text-align: center;\">"+(i+1)+"</td>")
				.append("<td  "+reportdataStr+">"+approverObj.getName()+"</td><td  "+reportdataStr+">"+approverObj.getDesignationName()+"</td>")
				.append("<td  "+reportdataStr+">"+("10".equals(approverObj.getApproveStatus()) ? "Approved" : "Pending")+"</td>")
				.append("<td   "+reportdataStr+">"+approverObj.getApproveDate().trim()+apprvTime+"</td></tr>");

			}
		}
		strMailMsg.append("</table></td></tr>");
		logger.info("[getMailBodyForMataGmbH] Approval List Section end.");
		
		logger.info("[getMailBodyForMataGmbH] Approval Comments List Section start ---->");
		List approversCommentList = getApproversComment(travelId, travelType, "APPROVE");
		if(approversCommentList != null){
			strMailMsg.append("<tr><td><table  "+reporttbleStr+"><tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+">Comments</td></tr>"
					+ "<tr><td "+reportCaptionStr+" >S No.</td>"
					+ "<td "+reportCaptionStr+" >Comments</td>"
					+ "<td "+reportCaptionStr+" >Posted By</td>"
					+ "<td "+reportCaptionStr+" >Posted On</td></tr>");
			if (approversCommentList != null && !approversCommentList.isEmpty()) {
				int iCls = 0;
				String strStyleCls = "";
				for (int i = 0; i < approversCommentList.size(); i++) {
					Comment comment = (Comment) approversCommentList.get(i);
					if (iCls % 2 == 0) {
						strStyleCls = "formtr2";
					} else {
						strStyleCls = "formtr1";
					}
					iCls++;

					strMailMsg.append("<tr><td "+reportdataStr+" >"+(i+1)+"</td>")
					.append("<td "+reportdataStr+" >"+comment.getComment()+"</td>")
					.append("<td "+reportdataStr+" >"+comment.getPostedByName()+"</td>")
					.append("<td "+reportdataStr+" >"+comment.getPostedOnDate()+"</td></tr>");
				}	
			
			}				
			strMailMsg.append("</table></td></tr>");
			logger.info("[getMailBodyForMataGmbH] Approval Comments List Section end.");
		}

		strMailMsg.append("</table><br/><br/><b>Best Regards,</b><br/>STARS Admin</body></html>");
		logger.info("[getMailBodyForMataGmbH] method body end.");
		return strMailMsg.toString();
	}
	
	//Get Travel Agency Id of Site
	public String getSiteTravelAgency(String travelId, String travelType){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		String travelAgencyId = null;
		String strSql =   "select (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id ";

		if(travelType.equalsIgnoreCase("I") || travelType.equalsIgnoreCase("INT")){
			strSql += " from T_TRAVEL_DETAIL_INT td";
		}else{
			strSql += " from T_TRAVEL_DETAIL_DOM td";
		}
		strSql += " where td.TRAVEL_ID = "+travelId;

		rs       =   dbConBean.executeQuery(strSql);  
		try {
			while(rs.next()){
				travelAgencyId = rs.getString("travel_agency_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return travelAgencyId;
	}
	
	//Get Group Request Detail
	public TravelRequest getTravelRequestDetail(String travelId, String travelType, String travellerId){

		TravelRequest requestInfo = null;
		User traveller = null;
		User originator = null;
		Passport travellerPasportInfo = null;

		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Connection conn = dbConBean.getConnection();
		CallableStatement stmt  = null;
		
		String flightRemarks			= null;
		String carRemarks				= null;
		String trainRemarks				= null;
		String accomodationRemarks		= null;
		Fare flightFare  				= null;
		Fare trainFare  				= null;
		Boolean isSpecialTrain			= null;

		ResultSet rsFlag = null,rsInformation = null,rsFlight = null,rsTrain = null
				,rsCar = null,rsAccomo = null,rsBillingInfo = null,rsApproverLevel = null,rsApproverList = null,groupUserInfoList=null,rsTravelFare = null;

		try{
			stmt = conn.prepareCall("{call SPG_MATAGMBH_TRAVEL_DETAIL(?,?,?,?,?)}");
			stmt.setString(1, travelId);
			stmt.setString(2, travelType);
			stmt.setString(3, travellerId);
			stmt.setInt(4, 2);
			stmt.registerOutParameter(5,java.sql.Types.INTEGER);

			boolean result = stmt.execute();
			int resultSetCount = 1;

			while(result){
				
				if(requestInfo == null)
					requestInfo = new TravelRequest();

				switch(resultSetCount){

				case 1: rsFlag = stmt.getResultSet();
				if(rsFlag.next()){
					requestInfo.setFlightDetailExist(rsFlag.getString("FLIGHT_TRAVEL_FLAG").equals("Y") ? true : false);
					requestInfo.setTrainDetailExist(rsFlag.getString("TRAIN_TRAVEL_FLAG").equals("Y") ? true : false);
					requestInfo.setRentA_CarDetailExist(rsFlag.getString("CAR_TRAVEL_FLAG").equals("Y") ? true : false);
					requestInfo.setAccomodationDetailExist(rsFlag.getString("ACCOMMODATION_TRAVEL_FLAG").equals("Y") ? true : false);
					requestInfo.setTravelFareDetailExist(rsFlag.getString("TRAVEL_FARE_FLAG").equals("Y") ? true : false);
				}
				break;

				case 2: rsInformation = stmt.getResultSet();
				// Request Information Starts
				if(rsInformation.next()){
					originator = new User();
					traveller = new User();

					requestInfo.setRequisitionNo(rsInformation.getString("TRAVEL_REQ_NO"));
					requestInfo.setOriginator(originator);
					requestInfo.setTraveller(traveller);

					originator.setFullName(rsInformation.getString("ORIGINATED_BY"));
					originator.setUnitName(rsInformation.getString("ORIG_UNIT"));
					originator.setDepartmentName(rsInformation.getString("ORIG_DEPT"));
					originator.setDivisionName(rsInformation.getString("ORIG_DIVISION"));
					originator.setDesignationName(rsInformation.getString("ORIG_DESIG"));


					requestInfo.setCreationDate(rsInformation.getString("C_DATETIME"));
					requestInfo.setDivisionName(rsInformation.getString("DIVISION"));
					if(rsInformation.getString("PROJECTNO")==null || rsInformation.getString("PROJECTNO").trim().equals("")) {
						requestInfo.setProjectNo("-");
					}else{
						requestInfo.setProjectNo(rsInformation.getString("PROJECTNO"));
					}
					requestInfo.setReasonForTravel(rsInformation.getString("REASON_FOR_TRAVEL"));
					
					if(rsInformation.getString("RESUBMIT_STATUS")!= null && !"".equals(rsInformation.getString("RESUBMIT_STATUS")))
					{
						if(rsInformation.getString("RESUBMIT_STATUS").equals("Y"))
							requestInfo.setReturnStatus("Resubmitted");
					}
					else
						requestInfo.setReturnStatus("");
					
					traveller.setUserName(rsInformation.getString("CURRENT_TRAVELLER"));
					traveller.setUnitName(rsInformation.getString("UNIT"));
					traveller.setDepartmentName(rsInformation.getString("DEPT"));
					traveller.setCostCenterName(rsInformation.getString("COSTCENTRE").toUpperCase());

					traveller.setFirstName(rsInformation.getString("FIRST_NAME"));
					traveller.setLastName(rsInformation.getString("LAST_NAME"));
					traveller.setDesignationName(rsInformation.getString("TRAVELLER_DESIG"));
					traveller.setContactNo(rsInformation.getString("CONTACT_NUMBER"));
					traveller.setGender(rsInformation.getString("GENDER"));
					traveller.setMealPreferrence(rsInformation.getString("MEAL_NAME"));
					
					travellerPasportInfo = new Passport();
					travellerPasportInfo.setFirstName(rsInformation.getString("PASSPORT_F_NAME"));
					travellerPasportInfo.setLastName(rsInformation.getString("PASSPORT_L_NAME"));
					travellerPasportInfo.setDateOfBirth(rsInformation.getString("DOB"));
					travellerPasportInfo.setPassportNo(rsInformation.getString("PASSPORT_NO"));
					travellerPasportInfo.setNationality(returnEmptyVal(rsInformation.getString("NATIONALITY")));
					travellerPasportInfo.setPlaceOfIssue(rsInformation.getString("PLACE_ISSUE"));
					travellerPasportInfo.setDateOfIssue(rsInformation.getString("DATE_ISSUE"));
					travellerPasportInfo.setDateOfExpiry(rsInformation.getString("EXPIRY_DATE"));
					travellerPasportInfo.setVisaExists(rsInformation.getString("VISA_REQUIRED").equals("2") ? false : true);

					traveller.setPassport(travellerPasportInfo);

					flightFare = new Fare();
					flightFare.setChangeableAgainstFee(rsInformation.getInt("FARE_CHANGEABLE_FLAG") == 2 ? false : true);
					flightFare.setRefundableAgainstFee(rsInformation.getInt("FARE_REFUNDABLE_FLAG") == 2 ? false : true);
					flightFare.setCheckedBaggageCount(rsInformation.getInt("NO_OF_BAGGAGE"));

					if(rsInformation.getString("BAHNCARD_NUMBER") != null && !"".equals(rsInformation.getString("BAHNCARD_NUMBER"))){
						trainFare = new Fare();

						trainFare.setBahnCardNo(rsInformation.getString("BAHNCARD_NUMBER"));
						trainFare.setDiscount("0".equals(rsInformation.getString("BAHNCARD_DISCOUNT")) ? "Bonus" : rsInformation.getString("BAHNCARD_DISCOUNT"));
						trainFare.setFareClass(rsInformation.getString("BAHNCARD_CLASS"));
						trainFare.setValidityDate(rsInformation.getString("BAHNCARD_VALID_DATE"));
						trainFare.setOnlineTicket(rsInformation.getInt("ONLINE_TICKET") == 2 ? false : true);
					}
					isSpecialTrain = "2".equals(rsInformation.getString("SPECIAL_TRAIN")) ? Boolean.FALSE : Boolean.TRUE;

					flightRemarks 		= rsInformation.getString("FLIGHT_REMARKS");
					carRemarks			= rsInformation.getString("CAR_REMARKS");
					trainRemarks 		= rsInformation.getString("TRAIN_REMARKS");
					accomodationRemarks = rsInformation.getString("ACCOMMODATION_REMARKS");

					if((rsInformation.getString("FF_AIR_NAME") != null && !"".equals(rsInformation.getString("FF_AIR_NAME"))) 
							|| (rsInformation.getString("FF_AIR_NAME1") != null && !"".equals(rsInformation.getString("FF_AIR_NAME1")))
							|| (rsInformation.getString("FF_AIR_NAME2") != null && !"".equals(rsInformation.getString("FF_AIR_NAME2")))
							|| (rsInformation.getString("FF_AIR_NAME3") != null && !"".equals(rsInformation.getString("FF_AIR_NAME3")))
							|| (rsInformation.getString("FF_AIR_NAME4") != null && !"".equals(rsInformation.getString("FF_AIR_NAME4")))
							|| (rsInformation.getString("HOTEL_NAME")   != null && !"".equals(rsInformation.getString("HOTEL_NAME")))
							|| (rsInformation.getString("HOTEL_NAME1")  != null && !"".equals(rsInformation.getString("HOTEL_NAME1")))
							|| (rsInformation.getString("HOTEL_NAME2")  != null && !"".equals(rsInformation.getString("HOTEL_NAME2")))
							|| (rsInformation.getString("HOTEL_NAME3")  != null && !"".equals(rsInformation.getString("HOTEL_NAME3")))
							|| (rsInformation.getString("HOTEL_NAME4")  != null && !"".equals(rsInformation.getString("HOTEL_NAME4")))) {
						
						// Reward card details
						List<RewardCard> rewardCardList = new ArrayList<RewardCard>();
						RewardCard card = null;

						if(!checkNullEmpty(rsInformation.getString("FF_AIR_NAME")) ||
								!checkNullEmpty(rsInformation.getString("HOTEL_NAME"))){
							card = new RewardCard(returnEmptyVal(rsInformation.getString("FF_AIR_NAME")), returnEmptyVal(rsInformation.getString("FF_NUMBER")), 
									returnEmptyVal(rsInformation.getString("HOTEL_NAME")), returnEmptyVal(rsInformation.getString("HOTEL_NUMBER")));
							rewardCardList.add(card);
						}
						if(!checkNullEmpty(rsInformation.getString("FF_AIR_NAME1")) ||
								!checkNullEmpty(rsInformation.getString("HOTEL_NAME1"))){
							card = new RewardCard(returnEmptyVal(rsInformation.getString("FF_AIR_NAME1")), returnEmptyVal(rsInformation.getString("FF_NUMBER1")), 
									returnEmptyVal(rsInformation.getString("HOTEL_NAME1")), returnEmptyVal(rsInformation.getString("HOTEL_NUMBER1")));
							rewardCardList.add(card);
						}
						if(!checkNullEmpty(rsInformation.getString("FF_AIR_NAME2")) ||
								!checkNullEmpty(rsInformation.getString("HOTEL_NAME2"))){
							card = new RewardCard(returnEmptyVal(rsInformation.getString("FF_AIR_NAME2")), returnEmptyVal(rsInformation.getString("FF_NUMBER2")), 
									returnEmptyVal(rsInformation.getString("HOTEL_NAME2")), returnEmptyVal(rsInformation.getString("HOTEL_NUMBER2")));
							rewardCardList.add(card);
						}
						if(!checkNullEmpty(rsInformation.getString("FF_AIR_NAME3")) ||
								!checkNullEmpty(rsInformation.getString("HOTEL_NAME3"))){
							card = new RewardCard(returnEmptyVal(rsInformation.getString("FF_AIR_NAME3")), returnEmptyVal(rsInformation.getString("FF_NUMBER3")), 
									returnEmptyVal(rsInformation.getString("HOTEL_NAME3")), returnEmptyVal(rsInformation.getString("HOTEL_NUMBER3")));
							rewardCardList.add(card);
						}
						if(!checkNullEmpty(rsInformation.getString("FF_AIR_NAME4")) ||
								!checkNullEmpty(rsInformation.getString("HOTEL_NAME4"))){
							card = new RewardCard(returnEmptyVal(rsInformation.getString("FF_AIR_NAME4")), returnEmptyVal(rsInformation.getString("FF_NUMBER4")), 
									returnEmptyVal(rsInformation.getString("HOTEL_NAME4")), returnEmptyVal(rsInformation.getString("HOTEL_NUMBER4")));
							rewardCardList.add(card);
						}
						requestInfo.setRewardCardList(rewardCardList);
					}
				}
				break;

				case 3: rsFlight = stmt.getResultSet();

				if(requestInfo.isFlightDetailExist()){

					List<Flight> flightDetailList = new ArrayList<Flight>();
					Flight flight = null;
					while(rsFlight.next()){
						flight = new Flight();

						if(!rsFlight.getString("TRAVEL_FROM").trim().equals("") || !rsFlight.getString("TRAVEL_TO").trim().equals("")) {							

							if(rsFlight.getString("JOURNEY") != null && "Forword".equals(rsFlight.getString("JOURNEY"))){
								flight.setJournyType(TravelRequestEnums.JournyType.FORWARD.getId());
							}
							if(rsFlight.getString("JOURNEY") != null && "Intermediate".equals(rsFlight.getString("JOURNEY"))){
								flight.setJournyType(TravelRequestEnums.JournyType.INTERMEDIATE.getId());
							}
							if(rsFlight.getString("JOURNEY") != null && "Return".equals(rsFlight.getString("JOURNEY"))){
								flight.setJournyType(TravelRequestEnums.JournyType.RETURNED.getId());

							}

							flight.setDepartureCity(rsFlight.getString("TRAVEL_FROM"));
							flight.setArrivalCity(rsFlight.getString("TRAVEL_TO"));
							flight.setDepartureDate(rsFlight.getString("TRAVEL_DATE"));
							flight.setPreferredTimeType("1".equals(rsFlight.getString("PREF_TIME_TYPE")) ? "Departure not Before" : "Arrival Until");
							flight.setTiming(rsFlight.getString("PREFERRED_TIME"));
							flight.setTravelClass(rsFlight.getString("TRAVEL_CLASS"));
							flight.setWindowSeatPreferrence(rsFlight.getString("SEAT_PREFFERED"));
							if(flightRemarks != null && !flightRemarks.equals("") && !flightRemarks.trim().equals("-")) {
								flight.setRemarks(flightRemarks);
							}
							flight.setFareDetail(flightFare);
							flightDetailList.add(flight);
						}
					}
					requestInfo.setFlightDetailList(flightDetailList);
				}
				break;

				case 4: rsTrain = stmt.getResultSet();
				//Train Details
				if(requestInfo.isTrainDetailExist()){

					List<Train> trainDetailList = new ArrayList<Train>();
					Train train = null;

					while(rsTrain.next()){
						if(!rsTrain.getString("TRAVEL_FROM").trim().equals("") || !rsTrain.getString("TRAVEL_TO").trim().equals("")) {
							train = new Train();

							if(rsTrain.getString("JOURNEY") != null && "Forword".equals(rsTrain.getString("JOURNEY"))){
								train.setJournyType(TravelRequestEnums.JournyType.FORWARD.getId());
							}
							if(rsTrain.getString("JOURNEY") != null && "Intermediate".equals(rsTrain.getString("JOURNEY"))){
								train.setJournyType(TravelRequestEnums.JournyType.INTERMEDIATE.getId());
							}
							if(rsTrain.getString("JOURNEY") != null && "Return".equals(rsTrain.getString("JOURNEY"))){
								train.setJournyType(TravelRequestEnums.JournyType.RETURNED.getId());
							}
							train.setDepartureCity(rsTrain.getString("TRAVEL_FROM"));
							train.setArrivalCity(rsTrain.getString("TRAVEL_TO"));
							train.setDepartureDate(rsTrain.getString("TRAVEL_DATE"));
							train.setPreferredTimeType("1".equals(rsTrain.getString("PREF_TIME_TYPE")) ? "Departure not Before" : "Arrival Until");
							train.setTravelClass(rsTrain.getString("TRAVEL_CLASS"));
							train.setTiming(rsTrain.getString("PREFERRED_TIME"));
							train.setSeatPreferrence_1(rsTrain.getString("SEAT_PREFFERED"));
							if(trainRemarks != null && !trainRemarks.equals("") && !trainRemarks.trim().equals("-")) {
								train.setRemarks(trainRemarks);
							}
							train.setFareDetail(trainFare);
							train.setSpecialTrain(isSpecialTrain);
							trainDetailList.add(train);
						}
					}
					requestInfo.setTrainDetailList(trainDetailList);
				}
				break;

				case 5: rsCar = stmt.getResultSet();
				//Rent A Car Section starts
				if(requestInfo.isRentA_CarDetailExist()){
					List<Car> carDetailList = new ArrayList<Car>();
					Car car = null;
					
					while(rsCar.next()){
						car = new Car();
						
						car.setStartDate(rsCar.getString("START_DATE"));
						car.setStartTime(rsCar.getString("START_TIME"));
						car.setStartCity(rsCar.getString("START_CITY"));
						car.setStartLocation(TravelRequestEnums.Locations.fromId(rsCar.getString("START_LOCATION")).getName());
						car.setStartMobileNo(("4".equals(rsCar.getString("START_LOCATION")) ? (!"".equals(rsCar.getString("START_MOBILENO")) ? rsCar.getString("START_MOBILENO") : "") : "-"));
						car.setStartRouting(rsCar.getString("START_ROUTING"));
						car.setEndDate(rsCar.getString("END_DATE"));
						car.setEndTime(rsCar.getString("END_TIME"));
						car.setEndCity(rsCar.getString("END_CITY"));
						car.setEndLocation(TravelRequestEnums.Locations.fromId(rsCar.getString("END_LOCATION")).getName());
						car.setEndMobileNo(("4".equals(rsCar.getString("END_LOCATION")) ? (!"".equals(rsCar.getString("END_MOBILENO")) ? rsCar.getString("END_MOBILENO") : "") : "-"));
						car.setEndRouting(rsCar.getString("END_ROUTING"));
						car.setNeed_GPS(rsCar.getInt("GPS") == 2 ? false : true);
						car.setCategory(TravelRequestEnums.CarCategories.fromId(rsCar.getString("CLASS")).getName());
						car.setCarClass(rsCar.getString("TRAVEL_CLASS"));
						car.setCarClassId(rsCar.getString("TRAVEL_CLASS_ID"));
						if(carRemarks != null && !carRemarks.equals("") && !carRemarks.trim().equals("-")) {
							car.setRemarks(carRemarks);
						}
						carDetailList.add(car);
					}
					requestInfo.setCarDetailList(carDetailList);
				}
				break;

				case 6: rsAccomo = stmt.getResultSet();
				// Accommodation Detail Section Start 
				if(requestInfo.isAccomodationDetailExist()){
					List<Accommodation> accommodationDetailList = new ArrayList<Accommodation>();
					Accommodation accommodation = null;

					while(rsAccomo.next()){
						accommodation = new Accommodation();

						accommodation.setPlaceOfVisit(rsAccomo.getString("PLACE"));
						accommodation.setAccommodationType((rsAccomo.getString("TRANSIT_TYPE") != null && TravelRequestEnums.AccomodationStayTypes.fromId(rsAccomo.getString("TRANSIT_TYPE")) != null) 
																? TravelRequestEnums.AccomodationStayTypes.fromId(rsAccomo.getString("TRANSIT_TYPE")).getName() : "");
						accommodation.setCheckInDate(rsAccomo.getString("CHECK_IN_DATE"));
						accommodation.setCheckOutDate(rsAccomo.getString("CHECK_OUT_DATE"));
						if(accomodationRemarks != null && !accomodationRemarks.equals("") && !accomodationRemarks.trim().equals("-")) {
							accommodation.setRemarks(accomodationRemarks);
						}	
						accommodationDetailList.add(accommodation);
					}
					requestInfo.setAccommodationList(accommodationDetailList);			
				}
				break;			
				
				case 7: rsTravelFare = stmt.getResultSet();
				//Travel Fare Detail Section Start
				if(requestInfo.isTravelFareDetailExist()){
					if(rsTravelFare.next()){
						TravelFare travelFare = new TravelFare();
						if(rsTravelFare.getString("FARE_CURRENCY") != null && !"".equals(rsTravelFare.getString("FARE_CURRENCY")) 
								&& rsTravelFare.getString("FARE_AMOUNT") != null && !"0".equals(rsTravelFare.getString("FARE_AMOUNT"))) {
							travelFare.setFareCurrency(rsTravelFare.getString("FARE_CURRENCY"));
							travelFare.setFareAmount(rsTravelFare.getString("FARE_AMOUNT"));
							requestInfo.setTravelFare(travelFare);
						}						
					}
				}
				break;
				
				case 8: rsBillingInfo = stmt.getResultSet();
				//Billing Instruction Section Start
				if(rsBillingInfo.next()){
					Approver billingApprover = new Approver();

					billingApprover.setUnitName(rsBillingInfo.getString("SITE_NAME"));
					billingApprover.setName(rsBillingInfo.getString("BILLING_CLIENT"));
					requestInfo.setBillingApprover(billingApprover);
				}
				break;

				case 9: rsApproverLevel = stmt.getResultSet();
				// Approval Level Section Start -->
				if(rsApproverLevel.next()){
					List<Approver> approveList = new ArrayList<Approver>();

					Approver approverLevel1 = new Approver();
					approverLevel1.setName(rsApproverLevel.getString("MANAGER_ID") == null ? "-" : rsApproverLevel.getString("MANAGER_ID"));
					approveList.add(approverLevel1);
					Approver approverLevel2 = new Approver();
					approverLevel2.setName(rsApproverLevel.getString("HOD_ID") == null ? "-" : rsApproverLevel.getString("HOD_ID"));
					approveList.add(approverLevel2);

					requestInfo.setApproverLevels(approveList);
					if(rsApproverLevel.getString("REASON_FOR_SKIP") != null && !rsApproverLevel.getString("REASON_FOR_SKIP").equals("") && !rsApproverLevel.getString("REASON_FOR_SKIP").trim().equals("-")) {
						requestInfo.setReasonOfSkipApprover(rsApproverLevel.getString("REASON_FOR_SKIP"));
					}
				}
				break;

				case 10: rsApproverList = stmt.getResultSet();
				// Approval List Section Start -->
				List<Approver> approveList = new ArrayList<Approver>();
				Approver approver = null;
				while(rsApproverList.next()){
					approver = new Approver();
					approver.setName(rsApproverList.getString("APPROVER_NAME"));
					approver.setDesignationName(rsApproverList.getString("DESIGN_DESC"));
					approver.setApproveStatus(rsApproverList.getString("APPROVE_STATUS"));
					approver.setApproveDate(rsApproverList.getString("APPROVE_DATE"));
					approver.setApproveTime(rsApproverList.getString("HHMM"));
					approver.setOriginalApprover(rsApproverList.getString("ORIGINAL_APPROVER"));
					approveList.add(approver);
				}
				requestInfo.setApprovers(approveList);
				break;

				case 11: groupUserInfoList = stmt.getResultSet();
				// Attached Group User List Section Start -->
				List<User> groupUserList = new ArrayList<User>();
				User groupUser = null;
				Passport passport = null;
				while(groupUserInfoList.next()){
					groupUser = new User();
					passport = new Passport();
					groupUser.setPassport(passport);

					groupUser.setUserName(groupUserInfoList.getString("CURRENT_TRAVELLER"));
					groupUser.setFirstName(groupUserInfoList.getString("FIRST_NAME"));
					groupUser.setLastName(groupUserInfoList.getString("LAST_NAME"));
					groupUser.setDesignationName(groupUserInfoList.getString("TRAVELLER_DESIG"));
					groupUser.setDateOfBirth(groupUserInfoList.getString("DOB"));
					groupUser.setGender(groupUserInfoList.getString("GENDER"));
					groupUser.setContactNo(groupUserInfoList.getString("MOBILE_NO"));
					groupUser.setFrequentFlyer(groupUserInfoList.getString("FREQUENT_FLYER"));
					groupUser.setMealPreferrence(groupUserInfoList.getString("MEAL_NAME"));					
					groupUser.setReturnJournyFlag("Y".equals(groupUserInfoList.getString("RETURN_TRAVEL")) ? true : false);

					passport.setPassportNo(groupUserInfoList.getString("PASSPORT_NO"));
					passport.setNationality(returnEmptyVal(groupUserInfoList.getString("NATIONALITY")));
					passport.setPlaceOfIssue(groupUserInfoList.getString("PLACE_ISSUE"));
					passport.setDateOfExpiry(groupUserInfoList.getString("EXPIRY_DATE"));
					passport.setDateOfIssue(groupUserInfoList.getString("DATE_ISSUE"));
					passport.setVisaExists("1".equals(groupUserInfoList.getString("VISA_REQUIRED")) ? true : false);

					groupUserList.add(groupUser);
				}
				requestInfo.setTravelerList(groupUserList);
				break;

				default:
					break;

				}
				if(resultSetCount <= 10)
					result = stmt.getMoreResults();

				resultSetCount++;
			}

		}catch(SQLException ex){
			ex.printStackTrace();
		}
		return requestInfo;
	}
	
	//Get Group/Guest Mail Body for Mata-GmbH
	public String getGroupMailBodyForMataGmbH(String travelId, String travelType, String travellerId){
		int rowSpan = 1;
		StringBuilder strMailMsg = new StringBuilder();
		
		// Fetch entire request information
		logger.setLevel(Level.ALL);
		logger.info("[getGroupMailBodyForMataGmbH] method body start ---->");
		TravelRequest requestInfo = getTravelRequestDetail(travelId,travelType,travellerId);
		User originator = requestInfo.getOriginator();
		User traveller = requestInfo.getTraveller();
		
		String bodyLineTopStr = "border-bottom:#A9A9A9 1px solid;";
		String reportHeadingStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:13px;font-weight:bold;color:#ffffff;line-height:22px;background-color:#7a7a7a;padding-left:5px;text-align:left;\"";
		String reportSubHeadingStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:12px;font-weight:bold;color:#000000;line-height:20px;background-color:#dddddd;padding-left:5px;text-align:left;\"";
		String reportCaptionStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#1d1d1d;line-height:20px;background-color:#f2f2f2;padding-left:5px;padding-right:5px;text-align:left;\"";
		String reportdataStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight: normal;color:#373737;line-height:20px;background-color:#f7f7f7;padding-left:5px;padding-right:5px;text-align:left;\"";
		String reporttbleStr = "style=\"max-width: 100%;border: #c7c7c5 1px solid;\"";

		strMailMsg.append("<html><head><title class='inputbox'>WELCOME TO STARS:  SAMVARDHANA MOTHERSON TRAVEL  APPROVAL SYSTEM </title> ")
		.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />")
		.append("<style type=\"text/css\">")
		.append("")
		.append(".bodyline-top{border-bottom:#A9A9A9 1px solid;}.bodyline-bottom{border-top:#A9A9A9 1px solid;}")
		.append(".reportHeading{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:13px;font-weight:bold;color:#ffffff;line-height:22px;background-color:#7a7a7a;padding-left:5px;text-align:left;}")
		.append(".reportSubHeading{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:12px;font-weight:bold;color:#000000;line-height:20px;background-color:#dddddd;padding-left:5px;text-align:left;}")
		.append(".reportCaption{width:auto;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#1d1d1d;line-height:20px;background-color:#f2f2f2;padding-left:5px;padding-right:5px;text-align:left;}")
		.append(".reportdata{width:auto;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight: normal;color:#373737;line-height:20px;background-color:#f7f7f7;padding-left:5px;padding-right:5px;text-align:left;}")
		.append(".reporttble{width: auto;max-width: 100%;border: #c7c7c5 1px solid;}</style></head>")
		.append("<body style=\"margin:0;vertical-align: middle;\" align=\"left\">")
		.append("<table width=\"97%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"margin:0;\">")
		.append("<tr> <td height=\"45\" style=\""+bodyLineTopStr+"\"><ul style=\"margin:0;\"><li style=\"margin:0;\">");
		if(travelType.equalsIgnoreCase("D")){
			strMailMsg.append("<b>Guest Domestic/Europe Journey Report</b>");
		}else{
			rowSpan = 2;
			strMailMsg.append("<b>Guest Intercont Journey Report</b>");
		}
		strMailMsg.append("</li></ul></td><td align=\"right\" valign=\"bottom\" style=\""+bodyLineTopStr+"\"></td></tr></table>")
		.append("<table style=\"padding-left:10px;margin:0;\" border=\"0\" cellpadding=\"5\" cellspacing=\"1\">")
		.append("<tr><td align=\"left\">")
		.append("<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
		.append("<tr><td height=\"0\" colspan=\"6\" align=\"left\" "+reportHeadingStr+">Basic Information of Originator</td></tr>");


		strMailMsg.append("<tr>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Requisition Number</td>")
		.append("<td height=\"0\" "+reportdataStr+">"+requestInfo.getRequisitionNo()+"</td>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Originator</td>")
		.append("<td height=\"0\" "+reportdataStr+">"+originator.getFullName().toUpperCase()+"</td>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Originated On</td>")
		.append("<td height=\"0\" "+reportdataStr+" >"+requestInfo.getCreationDate()+"</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Division</td>")
		.append("<td height=\"0\" "+reportdataStr+">"+requestInfo.getDivisionName()+"</td>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Unit</td>")
		.append("<td height=\"0\" "+reportdataStr+">"+originator.getUnitName()+"</td>")
		.append("<td height=\"0\" align=\"right\" "+reportCaptionStr+" >Department</td>")
		.append("<td height=\"0\" "+reportdataStr+" >"+originator.getDepartmentName()+"</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Designation</td>")
		.append("<td height=\"0\" "+reportdataStr+">"+originator.getDesignationName()+"</td>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Contact No.</td>")
		.append("<td height=\"0\" "+reportdataStr+">"+traveller.getContactNo()+"</td>")
		.append("<td height=\"0\" align=\"right\" "+reportCaptionStr+" >Cost Center</td>")
		.append("<td height=\"0\" "+reportdataStr+" >"+traveller.getCostCenterName().toUpperCase()+"</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Project Number</td>")
		.append("<td height=\"0\" "+reportdataStr+">"+requestInfo.getProjectNo().toUpperCase()+"</td>")
		.append("<td height=\"0\" "+reportCaptionStr+" >Reason For Travel</td>")
		.append("<td height=\"0\" colspan=\"3\""+reportdataStr+">"+requestInfo.getReasonForTravel()+"</td>")
		.append("</tr>")
		.append("</table>")
		.append("</td>")
		.append("</tr>");

		// Group/Guest Travelers Information Starts	
		logger.info("[getGroupMailBodyForMataGmbH] Group/Guest Travelers Information Section start ---->");
		strMailMsg.append("<tr><td> ")
		.append("<table align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\"> ")
		.append("<tr><td height=\"0\" colspan=\"8\" "+reportHeadingStr+">Guest Travellers Detail</td></tr>")
		.append("<tr>")
		.append("<td "+reportCaptionStr+" rowspan=\""+rowSpan+"\">S No.</td>")
		.append("<td "+reportCaptionStr+" >First Name</td><td "+reportCaptionStr+" >Last Name</td>")
		.append("<td "+reportCaptionStr+" >Gender</td><td "+reportCaptionStr+" >Contact No.</td>")
		.append("<td "+reportCaptionStr+" >Frequent Flyer</td>");
		
		if(travelType.equalsIgnoreCase("I")){
			strMailMsg.append("<td "+reportCaptionStr+" colspan=\"2\">Special Meal</td>");
		}
			strMailMsg.append("</tr>");
		
		if(travelType.equalsIgnoreCase("I")){
			strMailMsg.append("<tr><td "+reportCaptionStr+" >Passport No.</td><td "+reportCaptionStr+" >Nationality</td>")
			.append("<td "+reportCaptionStr+" >Place Of Issue</td><td "+reportCaptionStr+" >Date Of Issue</td><td "+reportCaptionStr+" >Date Of Expiry</td>")
			.append("<td "+reportCaptionStr+" >DOB</td><td "+reportCaptionStr+" >Visa Exists</td>")
			.append("</tr>");
		}
		
		int recordCount = 1;
		List<User> travellerList = requestInfo.getTravelerList();
		Passport passport = null;
		for(User traveler : travellerList){
			passport = traveler.getPassport();
			strMailMsg.append("<tr>")
			.append("<tr><td "+reportdataStr+" rowspan=\""+rowSpan+"\">"+recordCount+"</td>")
			.append("<td "+reportdataStr+" >"+traveler.getFirstName()+"</td><td "+reportdataStr+" >"+traveler.getLastName()+"</td>")
			.append("<td "+reportdataStr+" >"+traveler.getGender()+"</td>")
			.append("<td "+reportdataStr+" >"+traveler.getContactNo()+"</td><td "+reportdataStr+" >"+traveler.getFrequentFlyer()+"</td>");
			
			if(travelType.equalsIgnoreCase("I")){
				strMailMsg.append("<td "+reportdataStr+" colspan=\"2\">"+traveler.getMealPreferrence()+"</td>");
			}
				strMailMsg.append("</tr>");
			
			if(travelType.equalsIgnoreCase("I")){
				strMailMsg.append("<tr><td "+reportdataStr+" >"+passport.getPassportNo()+"</td><td "+reportdataStr+" >"+passport.getNationality()+"</td>")
				.append("<td "+reportdataStr+" >"+passport.getPlaceOfIssue()+"</td><td "+reportdataStr+" >"+passport.getDateOfIssue()+"</td><td "+reportdataStr+" >"+passport.getDateOfExpiry()+"</td>")
				.append("<td "+reportdataStr+" >"+traveler.getDateOfBirth()+"</td><td "+reportdataStr+" >"+(passport.isVisaExists() ? "Yes" : "No")+"</td>")
				.append("</tr>");
			}
			recordCount++;
		}
		strMailMsg.append("</table>").append("</td></tr>");
		logger.info("[getGroupMailBodyForMataGmbH] Group/Guest Travelers Information Section end.");

		// Flight Detail Block
		logger.info("[getGroupMailBodyForMataGmbH] Flight Detail block start ---->");
		if(requestInfo.isFlightDetailExist()){
			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"8\" "+reportHeadingStr+">Flight Details</td></tr>")
			.append("<tr>")
			.append("<td "+reportCaptionStr+" ></td><td "+reportCaptionStr+" >Departure City</td>")
			.append("<td "+reportCaptionStr+" >Arrival City</td><td "+reportCaptionStr+" >Departure Date</td>")
			.append("<td "+reportCaptionStr+" >Preferred Time</td>")
			.append("<td "+reportCaptionStr+" >Class</td><td "+reportCaptionStr+" >Preferred seat</td>")
			.append("</tr>");

			List<Flight> flightList = requestInfo.getFlightDetailList();
			Flight detailFLT = null;
			for(int i=0; i<flightList.size(); i++){
				detailFLT = (Flight)flightList.get(i);

				if(!checkNullEmpty(detailFLT.getDepartureCity()) || !checkNullEmpty(detailFLT.getArrivalCity())) {							

					if(detailFLT.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())){
						strMailMsg.append("<tr><td "+reportCaptionStr+" >Outward Leg</td>");
					}
					if(detailFLT.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())){
						strMailMsg.append("<tr><td "+reportCaptionStr+" >Intermediate Leg</td>");
					}
					if(detailFLT.getJournyType().equals(TravelRequestEnums.JournyType.RETURNED.getId())){
						strMailMsg.append("<tr><td "+reportCaptionStr+" >Return Leg</td>");

					}
					strMailMsg.append("<td "+reportdataStr+" >"+detailFLT.getDepartureCity()+"</td><td "+reportdataStr+" >"+detailFLT.getArrivalCity()+"</td>")
					.append("<td "+reportdataStr+" >"+detailFLT.getDepartureDate()+"</td><td "+reportdataStr+" >"+detailFLT.getPreferredTimeType()+"&nbsp;"+detailFLT.getTiming()+"</td>")
					.append("<td "+reportdataStr+" >"+detailFLT.getTravelClass()+"</td>")
					.append("<td "+reportdataStr+" >"+detailFLT.getWindowSeatPreferrence()+"</td></tr>");
				}
			}
			if(!checkNullEmpty(detailFLT.getRemarks()) && !detailFLT.getRemarks().trim().equals("-")) {
				strMailMsg.append("<tr><td "+reportCaptionStr+">Remarks</td><td "+reportdataStr+" colspan=\"7\">"+detailFLT.getRemarks()+"</td></tr>");
			}
			strMailMsg.append("</table></td></tr>");

			// Flight Fares details
			logger.info("[getGroupMailBodyForMataGmbH] Flight Fares Detail block start ---->");
			Fare flightFare = detailFLT.getFareDetail();
			if(flightFare != null){
				strMailMsg.append("<tr><td>")
				.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
				.append("<tr><td height=\"0\" colspan=\"6\" "+reportSubHeadingStr+">Fares</td></tr>")
				.append("<tr><td "+reportCaptionStr+" >Changeable against a fee</td>")
				.append("<td "+reportdataStr+">"+(!flightFare.isChangeableAgainstFee() ? "No" : "Yes")+"</td><td "+reportCaptionStr+" >Refundable against a fee</td>")
				.append("<td "+reportdataStr+">"+(!flightFare.isRefundableAgainstFee() ? "No" : "Yes")+"</td><td "+reportCaptionStr+" >Checked baggage</td>")
				.append("<td "+reportdataStr+">"+flightFare.getCheckedBaggageCount()+"</td></tr></table></td></tr>");
			}
			logger.info("[getGroupMailBodyForMataGmbH] Flight Fares Detail block end.");
		}
		logger.info("[getGroupMailBodyForMataGmbH] Flight Detail block end.");

		//Train Details
		logger.info("[getGroupMailBodyForMataGmbH] Train Details block start ---->");
		if(requestInfo.isTrainDetailExist()){

			List<Train> trainList = requestInfo.getTrainDetailList();
			Train detailTRN = null;

			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"7\" "+reportHeadingStr+">Train Details</td></tr>")
			.append("<tr><td "+reportCaptionStr+" ></td>")
			.append("<td "+reportCaptionStr+" >Departure City</td>")
			.append("<td "+reportCaptionStr+" >Arrival City</td>")
			.append("<td "+reportCaptionStr+" >Departure Date</td>")
			.append("<td "+reportCaptionStr+" >Preferred Time</td>")
			.append("<td "+reportCaptionStr+" >Class</td>")
			.append("<td "+reportCaptionStr+" >Preferred seat</td></tr>");

			for(int i=0; i<trainList.size(); i++){
				detailTRN = (Train)trainList.get(i);

				if(!checkNullEmpty(detailTRN.getDepartureCity()) || checkNullEmpty(detailTRN.getArrivalCity())) {

					if(detailTRN.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())){
						strMailMsg.append("<tr><td "+reportCaptionStr+" >Outward Leg</td>");
					}
					if(detailTRN.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())){
						strMailMsg.append("<tr><td "+reportCaptionStr+" >Intermediate Leg</td>");
					}
					if(detailTRN.getJournyType().equals(TravelRequestEnums.JournyType.RETURNED.getId())){
						strMailMsg.append("<tr><td "+reportCaptionStr+" >Return Leg</td>");

					}
					strMailMsg.append("<td "+reportdataStr+" >"+detailTRN.getDepartureCity()+"</td><td "+reportdataStr+" >"+detailTRN.getArrivalCity()+"</td>")
					.append("<td "+reportdataStr+" >"+detailTRN.getDepartureDate()+"</td><td "+reportdataStr+" >"+detailTRN.getPreferredTimeType()+"&nbsp;"+detailTRN.getTiming()+"</td>")
					.append("<td "+reportdataStr+" >"+detailTRN.getTravelClass()+"</td><td "+reportdataStr+" >"+detailTRN.getSeatPreferrence_1()+"</td></tr>");
				}
			}
			if(!checkNullEmpty(detailTRN.getRemarks()) && !detailTRN.getRemarks().trim().equals("-")) {
				strMailMsg.append("<tr><td "+reportCaptionStr+">Remarks</td><td "+reportdataStr+" colspan=\"7\">"+detailTRN.getRemarks()+"</td></tr>");
			}
			strMailMsg.append("</table></td></tr>");

			// Train Fares detail
			logger.info("[getGroupMailBodyForMataGmbH] Train Fares Detail block start ---->");
			Fare trainFare = detailTRN.getFareDetail();
			
			strMailMsg.append("<tr><td>")
			.append("<table align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">");
			
			if(trainFare != null) {
				strMailMsg.append("<tr><td height=\"0\" colspan=\"10\" "+reportSubHeadingStr+">Fares</td></tr>")
				.append("<tr>")	
				.append("<td "+reportCaptionStr+" >Bahncard No.</td><td "+reportdataStr+">"+trainFare.getBahnCardNo()+"</td>")				
				.append("<td "+reportCaptionStr+" >Discount</td><td "+reportdataStr+">"+trainFare.getDiscount()+"</td>")
				.append("<td "+reportCaptionStr+" >Class</td><td "+reportdataStr+">"+trainFare.getFareClass()+"</td>")
				.append("<td "+reportCaptionStr+" >Validity Date</td><td "+reportdataStr+">"+trainFare.getValidityDate()+"</td>")
				.append("<td "+reportCaptionStr+" >Online Ticket</td><td "+reportdataStr+">"+(!trainFare.isOnlineTicket() ? "No" : "Yes")+"</td>")
				.append("</tr>")
				.append("<tr>")				
				.append("<td "+reportCaptionStr+" >Sparpreis mit Zugbindung</td><td "+reportdataStr+" colspan=\"9\">"+(!detailTRN.isSpecialTrain() ? "No" : "Yes")+"</td>")
				.append("</tr>");
			} else {
				strMailMsg.append("<tr><td height=\"0\" colspan=\"2\" "+reportSubHeadingStr+">Fares</td></tr>")
				.append("<tr>")				
				.append("<td "+reportCaptionStr+" >Sparpreis mit Zugbindung</td><td "+reportdataStr+">"+(!detailTRN.isSpecialTrain() ? "No" : "Yes")+"</td>")
				.append("</tr>");
			}
			
			strMailMsg.append("</table></td></tr>");
			logger.info("[getGroupMailBodyForMataGmbH] Train Fares Detail block end.");
		}
		logger.info("[getGroupMailBodyForMataGmbH] Train Details block end.");

		//Rent A Car Section starts
		logger.info("[getGroupMailBodyForMataGmbH] Rent A Car Section start ---->");
		if(requestInfo.isRentA_CarDetailExist()){
			Car car = null;
			String needGPS = "";
			String carCategory = "";
			String carClass = "";
			String carClassId = "";
			
			int setColSpan1 = 6; 
    		int setColSpan2 = 5; 
    		int setColSpan3 = 3; 
			
			List<Car> carList = requestInfo.getCarDetailList();
			carClass = carList.get(0).getCarClass();
			carClassId = carList.get(0).getCarClassId();
			
			if(carClassId != null && !"".equals(carClassId) && ("26".equals(carClassId) || "27".equals(carClassId) || "29".equals(carClassId))) {
	 			setColSpan1 = 6; 
        		setColSpan2 = 5; 
        		setColSpan3 = 3; 
	 		} else {
	 			setColSpan1 = 5; 
        		setColSpan2 = 4; 
        		setColSpan3 = 2; 
			} 
			
			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan="+setColSpan1+" "+reportHeadingStr+">Car Reservation&nbsp;-&nbsp;["+carClass+"]</td></tr>")
			.append("<tr><td "+reportCaptionStr+" ></td>")
			.append("<td "+reportCaptionStr+" >Date</td><td "+reportCaptionStr+" >Time</td>")
			.append("<td "+reportCaptionStr+" >City</td><td "+reportCaptionStr+" >Location</td>");
			
			if(carClassId != null && !"".equals(carClassId) && "26".equals(carClassId)) {
				strMailMsg.append("<td "+reportCaptionStr+" >Mobile Number</td>");
			} else if(carClassId != null && !"".equals(carClassId) && ("27".equals(carClassId) || "29".equals(carClassId))) {
				strMailMsg.append("<td "+reportCaptionStr+" >Routing</td>");
			}
			strMailMsg.append("</tr>");
			
			for(int i=0; i<carList.size(); i++){
				car = (Car)carList.get(i);

				strMailMsg.append("<tr><td "+reportCaptionStr+" >Start</td>")
				.append("<td "+reportdataStr+" >"+car.getStartDate()+"</td><td "+reportdataStr+" >"+car.getStartTime()+"</td>")
				.append("<td "+reportdataStr+" >"+car.getStartCity()+"</td><td "+reportdataStr+" >"+car.getStartLocation()+"</td>");

				if(carClassId != null && !"".equals(carClassId) && "26".equals(carClassId)) {
					strMailMsg.append("<td "+reportdataStr+" >"+car.getStartMobileNo()+"</td>");
				} else if(carClassId != null && !"".equals(carClassId) && ("27".equals(carClassId) || "29".equals(carClassId))) {
					strMailMsg.append("<td "+reportdataStr+" >"+car.getStartRouting()+"</td>");
				}				
				strMailMsg.append("</tr>");
				
				
				strMailMsg.append("<tr><td "+reportCaptionStr+" >End</td>")
				.append("<td "+reportdataStr+" >"+car.getEndDate()+"</td><td "+reportdataStr+" >"+car.getEndTime()+"</td>")
				.append("<td "+reportdataStr+" >"+car.getEndCity()+"</td><td "+reportdataStr+" >"+car.getEndLocation()+"</td>");

				if(carClassId != null && !"".equals(carClassId) && "26".equals(carClassId)) {
					strMailMsg.append("<td "+reportdataStr+" >"+car.getEndMobileNo()+"</td>");
				} else if(carClassId != null && !"".equals(carClassId) && ("27".equals(carClassId) || "29".equals(carClassId))) {
					strMailMsg.append("<td "+reportdataStr+" >"+car.getEndRouting()+"</td>");
				}
				strMailMsg.append("</tr>");
				
				needGPS = !car.isNeed_GPS() ? "No" : "Yes";
				carCategory = car.getCategory();
			}
			
			if(carClassId != null && !"".equals(carClassId) && ("26".equals(carClassId) || "27".equals(carClassId))) {
				strMailMsg.append("<tr><td height=\"0\" colspan="+setColSpan1+" "+reportSubHeadingStr+">Car Options</td></tr>")
				.append("<tr><td "+reportCaptionStr+" >Need GPS</td>")
				.append("<td "+reportdataStr+" >"+needGPS +"</td><td "+reportCaptionStr+" >Category</td>")
				.append("<td "+reportdataStr+" colspan="+setColSpan3+" >"+carCategory+"</td></tr>");
			}

			if(!checkNullEmpty(car.getRemarks()) && !car.getRemarks().trim().equals("-")) {
				strMailMsg.append("<tr><td "+reportCaptionStr+">Remarks</td><td "+reportdataStr+" colspan="+setColSpan2+">"+car.getRemarks()+"</td></tr>");
			}
			strMailMsg.append("</table></td></tr>");
		}
		logger.info("[getGroupMailBodyForMataGmbH] Rent A Car Section end.");

		// Accommodation Detail Section Start
		logger.info("[getGroupMailBodyForMataGmbH] Accommodation Detail Section start ---->");
		if(requestInfo.isAccomodationDetailExist()){
			List<Accommodation> accommodationList = requestInfo.getAccommodationList();
			Accommodation accommodation = null;

			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"5\" "+reportHeadingStr+">Accommodation</td></tr>")
			.append("<tr><td "+reportCaptionStr+" >##</td>")
			.append("<td "+reportCaptionStr+" >Place of Visit (City and Address)</td><td "+reportCaptionStr+" >Accommodation Type</td>")
			.append("<td "+reportCaptionStr+" >Check In Date</td><td "+reportCaptionStr+" >Check Out Date</td>")
			.append("</tr>");

			for(int i=0; i<accommodationList.size(); i++){
				accommodation = (Accommodation)accommodationList.get(i);

				strMailMsg.append("<tr><td "+reportdataStr+" >"+(i+1)+"</td>")
				.append("<td "+reportdataStr+" >"+accommodation.getPlaceOfVisit()+"</td><td "+reportdataStr+" >"+accommodation.getAccommodationType()+"</td>");
				strMailMsg.append("<td "+reportdataStr+" >"+accommodation.getCheckInDate()+"</td><td "+reportdataStr+" >"+accommodation.getCheckOutDate()+"</td></tr>");
			}
			if(!checkNullEmpty(accommodation.getRemarks()) && !accommodation.getRemarks().trim().equals("-")) {
				strMailMsg.append("<tr><td "+reportCaptionStr+" >Remarks</td><td "+reportdataStr+"  colspan=\"4\">"+accommodation.getRemarks()+"</td></tr>");
			}					
			strMailMsg.append("</table></td></tr>");
		}
		logger.info("[getGroupMailBodyForMataGmbH] Accommodation Detail Section end.");

		//Billing Instruction Section Start
		logger.info("[getGroupMailBodyForMataGmbH] Billing Instruction Section start ---->");
		Approver billingApprover = requestInfo.getBillingApprover();
		if(billingApprover != null){
			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+" >Billing Instructions</td></tr>")
			.append("<tr><td height=\"0\" "+reportCaptionStr+" >Billing Client </td>")
			.append("<td height=\"0\" "+reportdataStr+" >"+billingApprover.getUnitName()+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Billing Approver</td>")
			.append("<td height=\"0\" "+reportdataStr+" >"+billingApprover.getName()+"</td></tr></tr></table></td></tr>");
		}
		logger.info("[getGroupMailBodyForMataGmbH] Billing Instruction Section end.");

		// Approval Level Section Start -->
		logger.info("[getGroupMailBodyForMataGmbH] Approval Level Section start ---->");
		List<Approver> approverLevelList = requestInfo.getApproverLevels();
		if(approverLevelList != null && !approverLevelList.isEmpty() && (approverLevelList.size() == 2)){
			strMailMsg.append("<tr><td>")
			.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+" >Approvers</td></tr>")
			.append("<tr>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Approval Level 1 </td><td height=\"0\" "+reportdataStr+" >"+("-".equals(approverLevelList.get(0).getName()) ? "Not Applicable" : approverLevelList.get(0).getName())+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Approval Level 2 </td><td height=\"0\" "+reportdataStr+" >"+("-".equals(approverLevelList.get(1).getName()) ? "Not Applicable" : approverLevelList.get(1).getName())+"</td>")
			.append("</tr>");
			strMailMsg.append("</table></td></tr>");
		}
		logger.info("[getGroupMailBodyForMataGmbH] Approval Level Section end.");


		// Approval List Section Start -->
		logger.info("[getGroupMailBodyForMataGmbH] Approval List Section start ---->");
		List<Approver> approverList = requestInfo.getApprovers();
		strMailMsg.append("<tr><td>")
		.append("<table  align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
		.append("<tr><td colspan=\"5\" "+reportHeadingStr+" >Approvers List</td></tr>")
		.append("<tr><td  "+reportCaptionStr+" nowrap=\"nowrap\">S No.</td>")
		.append("<td  "+reportCaptionStr+">Name</td><td  "+reportCaptionStr+">Designation</td>")
		.append("<td  "+reportCaptionStr+">Status</td><td  "+reportCaptionStr+">Approval Date Time</td></tr>");

		int approverRowCount = 1;
		if(approverList != null && !approverList.isEmpty()){
			for(Approver workflowApp : approverList){
				String apprvTime = (workflowApp.getApproveTime() == null || workflowApp.getApproveTime().trim().equals("")) ? "": "  "+workflowApp.getApproveTime().trim();
				
				strMailMsg.append("<tr><td  "+reportdataStr+" style=\"text-align: center;\">"+approverRowCount+"</td>")
				.append("<td  "+reportdataStr+">"+workflowApp.getName()+"</td><td  "+reportdataStr+">"+workflowApp.getDesignationName()+"</td>")
				.append("<td  "+reportdataStr+">"+("10".equals(workflowApp.getApproveStatus()) ? "Approved" : "Pending")+"</td>")
				.append("<td   "+reportdataStr+">"+workflowApp.getApproveDate().trim()+apprvTime+"</td></tr>");
				approverRowCount++;
			}
		}
		strMailMsg.append("</table></td></tr>");
		logger.info("[getGroupMailBodyForMataGmbH] Approval List Section end.");
		
		logger.info("[getGroupMailBodyForMataGmbH] Approval Comments List Section start ---->");
		List approversCommentList = getApproversComment(travelId, travelType, "APPROVE");
		if(approversCommentList != null){
			strMailMsg.append("<tr><td><table  "+reporttbleStr+"><tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+">Comments</td></tr>"
					+ "<tr><td "+reportCaptionStr+" >S No.</td>"
					+ "<td "+reportCaptionStr+" >Comments</td>"
					+ "<td "+reportCaptionStr+" >Posted By</td>"
					+ "<td "+reportCaptionStr+" >Posted On</td></tr>");
			if (approversCommentList != null && !approversCommentList.isEmpty()) {
				int iCls = 0;
				String strStyleCls = "";
				for (int i = 0; i < approversCommentList.size(); i++) {
					Comment comment = (Comment) approversCommentList.get(i);
					if (iCls % 2 == 0) {
						strStyleCls = "formtr2";
					} else {
						strStyleCls = "formtr1";
					}
					iCls++;

					strMailMsg.append("<tr><td "+reportdataStr+" >"+(i+1)+"</td>")
					.append("<td "+reportdataStr+" >"+comment.getComment()+"</td>")
					.append("<td "+reportdataStr+" >"+comment.getPostedByName()+"</td>")
					.append("<td "+reportdataStr+" >"+comment.getPostedOnDate()+"</td></tr>");
				}	
			
			}				
			strMailMsg.append("</table></td></tr>");	
		}
		logger.info("[getGroupMailBodyForMataGmbH] Approval Comments List Section end.");
		
		strMailMsg.append("</table><br/><br/><b>Best Regards,</b><br/>STARS Admin</body></html>");
		logger.info("[getGroupMailBodyForMataGmbH] method body end.");

		return strMailMsg.toString();
	}
	
	/**
	 * Return HTML String which a part of Mail Content for Approver Mail Body of MATA GmbH
	 * @author Sandeep Malik
	 * @param travelId
	 * @param travelType
	 * @param travellerId
	 * @return String Object (HTML String)
	 */
	public String customizeApproverMailBodyGmbh(String travelId, String travelType, String travellerId){
		logger.setLevel(Level.ALL);
		logger.info("[customizeApproverMailBodyGmbh] method body start ---->");
		
		StringBuilder mailBody = new StringBuilder();
		TravelRequest requestInfo = getTravelRequestDetail(travelId,travelType,travellerId);

		String tableStyleStr = "align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" style=\"max-width: 100%;border: #c7c7c5 1px solid;\" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\"";
		String tableHeadingStyle = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:13px;font-weight:bold;color:#ffffff;line-height:22px;background-color:#aa1220;padding-left:5px;text-align:left;\"";
		String tableSubHeadingStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:12px;font-weight:bold;color:#ffffff;line-height:20px;background-color:#ea394b;padding-left:5px;text-align:left;\"";
		String headerStyleStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#1d1d1d;line-height:20px;background-color:#f2f2f2;padding-left:5px;padding-right:5px;text-align:left;\"";
		String dataStyleStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight: normal;color:#373737;line-height:20px;background-color:#f7f7f7;padding-left:5px;padding-right:5px;text-align:left;\"";
		
		mailBody.append("<div><table><tr><td>\n" );
		logger.info("[customizeApproverMailBodyGmbh] Flight Details Section start ---->");
		if(requestInfo.isFlightDetailExist()){
			
			mailBody.append("<table "+tableStyleStr+" >"
					+ "<tr><td height=\"0\" colspan=\"8\" "+tableHeadingStyle+" >Flight Details</td></tr>"
					+ "<tr><td style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#1d1d1d;line-height:20px;background-color:#f2f2f2;padding-left:5px;padding-right:5px;text-align:left;\" ></td>"
					+ "<td "+headerStyleStr+" >Departure City</td>"
					+ "<td "+headerStyleStr+" >Arrival City</td><td "+headerStyleStr+" >Departure Date</td>"
					+ "<td "+headerStyleStr+" >Preferred Time</td><td "+headerStyleStr+" >Class</td><td "+headerStyleStr+" >Preferred seat</td></tr>");

			List<Flight> flightDetailList = requestInfo.getFlightDetailList();
			String remarksFlt = null;
			for(Flight flight : flightDetailList){
				if(!flight.getDepartureCity().trim().equals("") || !flight.getArrivalCity().trim().equals("")) {							

					if(flight.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())){
						mailBody.append("<tr><td "+headerStyleStr+" >Outward Leg</td>");
					}else if(flight.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())){
						mailBody.append("<tr><td "+headerStyleStr+" >Intermediate Leg</td>");
					}else {
						mailBody.append("<tr><td "+headerStyleStr+" >Return Leg</td>");
					}
					
					mailBody.append("<td "+dataStyleStr+" >"+flight.getDepartureCity()+"</td><td "+dataStyleStr+" >"+flight.getArrivalCity()+"</td>")
					.append("<td "+dataStyleStr+" >"+flight.getDepartureDate()+"</td><td "+dataStyleStr+" >"+flight.getPreferredTimeType()+"&nbsp;"+flight.getTiming()+"</td>")
					.append("<td "+dataStyleStr+" >"+flight.getTravelClass()+"</td>")
					.append("<td "+dataStyleStr+" >"+flight.getWindowSeatPreferrence()+"</td></tr>");

					remarksFlt = flight.getRemarks();
				}
			}
			if(remarksFlt != null && !remarksFlt.equals("") && !remarksFlt.trim().equals("-")) {
				mailBody.append("<tr><td "+headerStyleStr+">Remarks</td><td "+dataStyleStr+" colspan=\"7\">"+remarksFlt+"</td></tr>");
			}
			mailBody.append("</table></td></tr>");	
		}
		logger.info("[customizeApproverMailBodyGmbh] Flight Details Section end.");
		
		logger.info("[customizeApproverMailBodyGmbh] Train Details Section start ---->");
		if(requestInfo.isTrainDetailExist()){
			List<Train> trainList = requestInfo.getTrainDetailList();
			Train detailTRN = null;

			mailBody.append("<tr><td><table  "+tableStyleStr+"><tr><td height=\"0\" colspan=\"7\" "+tableHeadingStyle+">Train Details</td></tr>"
					+ "<tr><td "+headerStyleStr+" ></td><td "+headerStyleStr+" >Departure City</td>"
					+ "<td "+headerStyleStr+" >Arrival City</td>"
					+ "<td "+headerStyleStr+" >Departure Date</td>"
					+ "<td "+headerStyleStr+" >Preferred Time</td>"
					+ "<td "+headerStyleStr+" >Class</td>"
					+ "<td "+headerStyleStr+" >Preferred seat</td></tr>");
			for(int i=0; i<trainList.size(); i++){
				detailTRN = (Train)trainList.get(i);

				if(!checkNullEmpty(detailTRN.getDepartureCity()) || checkNullEmpty(detailTRN.getArrivalCity())) {

					if(detailTRN.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())){
						mailBody.append("<tr><td "+headerStyleStr+" >Outward Leg</td>");
					}
					if(detailTRN.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())){
						mailBody.append("<tr><td "+headerStyleStr+" >Intermediate Leg</td>");
					}
					if(detailTRN.getJournyType().equals(TravelRequestEnums.JournyType.RETURNED.getId())){
						mailBody.append("<tr><td "+headerStyleStr+" >Return Leg</td>");

					}
					mailBody.append("<td "+dataStyleStr+" >"+detailTRN.getDepartureCity()+"</td><td "+dataStyleStr+" >"+detailTRN.getArrivalCity()+"</td>")
					.append("<td "+dataStyleStr+" >"+detailTRN.getDepartureDate()+"</td><td "+dataStyleStr+" >"+detailTRN.getPreferredTimeType()+"&nbsp;"+detailTRN.getTiming()+"</td>")
					.append("<td "+dataStyleStr+" >"+detailTRN.getTravelClass()+"</td><td "+dataStyleStr+" >"+detailTRN.getSeatPreferrence_1()+"</td></tr>");
				}
			}
			if(!checkNullEmpty(detailTRN.getRemarks()) && !detailTRN.getRemarks().trim().equals("-")) {
				mailBody.append("<tr><td "+headerStyleStr+">Remarks</td><td "+dataStyleStr+" colspan=\"7\">"+detailTRN.getRemarks()+"</td></tr>");
			}
			mailBody.append("</table></td></tr>");	

		}
		logger.info("[customizeApproverMailBodyGmbh] Train Details Section end.");
		
		logger.info("[customizeApproverMailBodyGmbh] Car Details Section start ---->");
		if(requestInfo.isRentA_CarDetailExist()){
			Car car = null;
			String needGPS = "";
			String carCategory = "";
			String carClass = "";
			String carClassId = "";
			
			int setColSpan1 = 6; 
    		int setColSpan2 = 5; 
    		int setColSpan3 = 3; 
    		
			List<Car> carList = requestInfo.getCarDetailList();
			carClass = carList.get(0).getCarClass();
			carClassId = carList.get(0).getCarClassId();
			
			if(carClassId != null && !"".equals(carClassId) && ("26".equals(carClassId) || "27".equals(carClassId) || "29".equals(carClassId))) {
	 			setColSpan1 = 6; 
        		setColSpan2 = 5; 
        		setColSpan3 = 3; 
	 		} else {
	 			setColSpan1 = 5; 
        		setColSpan2 = 4; 
        		setColSpan3 = 2; 
			} 

			mailBody.append("<tr><td><table  "+tableStyleStr+">")
					.append("<tr><td height=\"0\" colspan="+setColSpan1+" "+tableHeadingStyle+">Car Reservation&nbsp;-&nbsp;["+carClass+"]</td></tr>")
					.append("<tr><td "+headerStyleStr+" ></td>")
					.append("<td "+headerStyleStr+" >Date</td><td "+headerStyleStr+" >Time</td>")
					.append("<td "+headerStyleStr+" >City</td><td "+headerStyleStr+" >Location</td>");
			
			if(carClassId != null && !"".equals(carClassId) && "26".equals(carClassId)) {
				mailBody.append("<td "+headerStyleStr+" >Mobile Number</td>");
			} else if(carClassId != null && !"".equals(carClassId) && ("27".equals(carClassId) || "29".equals(carClassId))) {
				mailBody.append("<td "+headerStyleStr+" >Routing</td>");
			}
			mailBody.append("</tr>");
			
			
			for(int i=0; i<carList.size(); i++){
				car = (Car)carList.get(i);

				mailBody.append("<tr><td "+headerStyleStr+" >Start</td>")
				.append("<td "+dataStyleStr+" >"+car.getStartDate()+"</td><td "+dataStyleStr+" >"+car.getStartTime()+"</td>")
				.append("<td "+dataStyleStr+" >"+car.getStartCity()+"</td><td "+dataStyleStr+" >"+car.getStartLocation()+"</td>");

				if(carClassId != null && !"".equals(carClassId) && "26".equals(carClassId)) {
					mailBody.append("<td "+dataStyleStr+" >"+car.getStartMobileNo()+"</td>");
				} else if(carClassId != null && !"".equals(carClassId) && ("27".equals(carClassId) || "29".equals(carClassId))) {
					mailBody.append("<td "+dataStyleStr+" >"+car.getStartRouting()+"</td>");
				}				
				mailBody.append("</tr>");
				
				mailBody.append("<tr><td "+headerStyleStr+" >End</td>")
				.append("<td "+dataStyleStr+" >"+car.getEndDate()+"</td><td "+dataStyleStr+" >"+car.getEndTime()+"</td>")
				.append("<td "+dataStyleStr+" >"+car.getEndCity()+"</td><td "+dataStyleStr+" >"+car.getEndLocation()+"</td>");

				if(carClassId != null && !"".equals(carClassId) && "26".equals(carClassId)) {
					mailBody.append("<td "+dataStyleStr+" >"+car.getEndMobileNo()+"</td>");
				} else if(carClassId != null && !"".equals(carClassId) && ("27".equals(carClassId) || "29".equals(carClassId))) {
					mailBody.append("<td "+dataStyleStr+" >"+car.getEndRouting()+"</td>");
				}
				mailBody.append("</tr>");
				
				needGPS = !car.isNeed_GPS() ? "No" : "Yes";
				carCategory = car.getCategory();
			}
			
			if(carClassId != null && !"".equals(carClassId) && ("26".equals(carClassId) || "27".equals(carClassId))) {
				mailBody.append("<tr><td height=\"0\" colspan="+setColSpan1+" "+tableSubHeadingStr+">Car Options</td></tr>")
				.append("<tr><td "+headerStyleStr+" >Need GPS</td>")
				.append("<td "+dataStyleStr+" >"+needGPS +"</td><td "+headerStyleStr+" >Category</td>")
				.append("<td "+dataStyleStr+" colspan="+setColSpan3+" >"+carCategory+"</td></tr>");
			}

			if(!checkNullEmpty(car.getRemarks()) && !car.getRemarks().trim().equals("-")) {
				mailBody.append("<tr><td "+headerStyleStr+">Remarks</td><td "+dataStyleStr+" colspan="+setColSpan2+">"+car.getRemarks()+"</td></tr>");
			}
			mailBody.append("</table></td></tr>");	
		}
		logger.info("[customizeApproverMailBodyGmbh] Car Details Section end.");
		
		logger.info("[customizeApproverMailBodyGmbh] Accomodation Details Section start ---->");
		if(requestInfo.isAccomodationDetailExist()){
			List<Accommodation> accommodationList = requestInfo.getAccommodationList();
			Accommodation accommodation = null;

			mailBody.append("<tr><td><table  "+tableStyleStr+"><tr><td height=\"0\" colspan=\"5\" "+tableHeadingStyle+">Accommodation</td></tr>"
					+ "<tr><td "+headerStyleStr+" >##</td>"
					+ "<td "+headerStyleStr+" >Place of Visit (City and Address)</td>"
					+ "<td "+headerStyleStr+" >Accommodation Type</td>"
					+ "<td "+headerStyleStr+" >Check In Date</td>"
					+ "<td "+headerStyleStr+" >Check Out Date</td></tr>");
			for(int i=0; i<accommodationList.size(); i++){
				accommodation = (Accommodation)accommodationList.get(i);

				mailBody.append("<tr><td "+dataStyleStr+" >"+(i+1)+"</td>")
				.append("<td "+dataStyleStr+" >"+accommodation.getPlaceOfVisit()+"</td><td "+dataStyleStr+" >"+accommodation.getAccommodationType()+"</td>");
				mailBody.append("<td "+dataStyleStr+" >"+accommodation.getCheckInDate()+"</td><td "+dataStyleStr+" >"+accommodation.getCheckOutDate()+"</td></tr>");
			}
			if(!checkNullEmpty(accommodation.getRemarks()) && !accommodation.getRemarks().trim().equals("-")) {
				mailBody.append("<tr><td "+headerStyleStr+" >Remarks</td><td "+dataStyleStr+"  colspan=\"4\">"+accommodation.getRemarks()+"</td></tr>");
			}					
			mailBody.append("</table></td></tr>");	
		}
		logger.info("[customizeApproverMailBodyGmbh] Accomodation Details Section end.");
		
		logger.info("[customizeApproverMailBodyGmbh] Approver Comments List Section start ---->");
		List approversCommentList = getApproversComment(travelId, travelType, "APPROVE");
		if(approversCommentList != null){
			mailBody.append("<tr><td><table  "+tableStyleStr+"><tr><td height=\"0\" colspan=\"4\" "+tableHeadingStyle+">Comments</td></tr>"
					+ "<tr><td "+headerStyleStr+" >S No.</td>"
					+ "<td "+headerStyleStr+" >Comments</td>"
					+ "<td "+headerStyleStr+" >Posted By</td>"
					+ "<td "+headerStyleStr+" >Posted On</td></tr>");
			if (approversCommentList != null && !approversCommentList.isEmpty()) {
				int iCls = 0;
				String strStyleCls = "";
				for (int i = 0; i < approversCommentList.size(); i++) {
					Comment comment = (Comment) approversCommentList.get(i);
					if (iCls % 2 == 0) {
						strStyleCls = "formtr2";
					} else {
						strStyleCls = "formtr1";
					}
					iCls++;

					mailBody.append("<tr><td "+dataStyleStr+" >"+(i+1)+"</td>")
					.append("<td "+dataStyleStr+" >"+comment.getComment()+"</td>")
					.append("<td "+dataStyleStr+" >"+comment.getPostedByName()+"</td>")
					.append("<td "+dataStyleStr+" >"+comment.getPostedOnDate()+"</td></tr>");
				}	
			
			}				
			mailBody.append("</table></td></tr>");	
		}
		logger.info("[customizeApproverMailBodyGmbh] Approver Comments List Section end.");
		
		mailBody.append("</td></tr></table></div>\n" );
		logger.info("[customizeApproverMailBodyGmbh] method body end.");
		return mailBody.toString();
	}
	
	
	/**
	 * Method check provided value is null or empty.
	 * @param obj
	 * @return boolean
	 */
	private boolean checkNullEmpty(Object obj){
		if(obj != null && obj instanceof String){
			if(!StringUtils.isEmpty((String)obj) && !"null".equals((String)obj)){
				return false;
			}
		}
		return true;
	}
	
	/**
	 * Method return EMPTY value for null or empty Object.
	 * @param obj
	 * @return boolean
	 */
	private String returnEmptyVal(Object obj){
		if(obj != null && obj instanceof String){
			if(!StringUtils.isEmpty((String)obj) && !"null".equals((String)obj)){
				return (String) obj;
			}
		}
		return StringUtils.EMPTY;
	}
	
	/**
	 * Method return List of Approvers on the basis of Approver Levels
	 * @param strUserId
	 * @param strSiteId
	 * @param approverLevelStr
	 * @return List<Approver>
	 */
	public List<Approver> getApproverByLevel(String strUserId, String strSiteId, String approverLevelStr){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Approver> approverList = null;
		Approver approver = null;
		StringBuilder sqlStr = null;
		if(approverLevelStr.equalsIgnoreCase("FIRST")){
			sqlStr = new StringBuilder("Select USERID, dbo.user_name(USERID) AS name FROM M_USERINFO (NOLOCK) WHERE ");
			sqlStr.append( "APPROVER_LEVEL=1 " );
			sqlStr.append("AND SITE_ID="+strSiteId+" AND USERID<>"+strUserId+" AND STATUS_ID=10 AND APPLICATION_ID=1 "
					+ "UNION SELECT UAM.USERID,dbo.user_name(UAM.USERID)AS PM  FROM USER_MULTIPLE_ACCESS UAM "
					+ "WHERE UAM.USERID<>"+strUserId+" AND SITE_ID="+strSiteId+" AND UAM.USERID<>"+strUserId+" ");
			sqlStr.append( "AND APPROVAL_LVL1='Y' ");
			sqlStr.append( "AND STATUS_ID=10 ORDER BY 2");
		}else if(approverLevelStr.equalsIgnoreCase("SECOND")){
			sqlStr = new StringBuilder("Select USERID, dbo.user_name(USERID) AS name FROM M_USERINFO (NOLOCK) WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") ");
			sqlStr.append( " or (APPROVER_LEVEL=3)) AND USERID<>"+strUserId+" AND STATUS_ID=10 AND APPLICATION_ID=1 " );
			sqlStr.append("UNION SELECT UAM.USERID,dbo.user_name(UAM.USERID)AS PM  FROM USER_MULTIPLE_ACCESS UAM "
					+ " WHERE UAM.USERID<>"+strUserId+" AND SITE_ID="+strSiteId+" "
					+ " AND APPROVAL_LVL2='Y' AND STATUS_ID=10 ORDER BY 2");
		}else{
			sqlStr = new StringBuilder("SELECT USERID, DBO.user_name(USERID) AS name FROM M_BOARD_MEMBER WHERE M_BOARD_MEMBER.USERID<>"+strUserId+"");
			sqlStr.append( " AND M_BOARD_MEMBER.SITE_ID="+strSiteId+" AND M_BOARD_MEMBER.STATUS_ID=10 " );
			
		}
		try {
			conn = dbConBean.getConnection();
			stmt = conn.prepareStatement(sqlStr.toString());
			rs = stmt.executeQuery();

			while(rs.next()){
				if(approverList == null)
					approverList = new ArrayList<Approver>();

				approver = new Approver();
				approver.setApproverId(Integer.valueOf(rs.getString("USERID")));
				approver.setName(rs.getString("name"));
				approverList.add(approver);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return approverList;
	}
	
	/**
	 * Method return comments which is given by approvers while taking action against a Travel Request.
	 * @param travelId
	 * @param traveltype
	 * @return List<Comment>
	 */
	public List<Comment> getApproversComment(String travelId, String traveltype, String commentType){
		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Comment> commentList = null;
		Comment comment = null;

		StringBuilder strSql =   new StringBuilder("	SELECT TRAVEL_ID, ");
		if(commentType != null && commentType.equals(TravelRequestEnums.ApproverCommentType.APPROVE.getName())){
			strSql.append("	case when left(rtrim(ltrim(COMMENTS)),8) <>'approved' then '<b><font color=blue>'+ COMMENTS + '</font></b>' else COMMENTS end ");
		}else{
			strSql.append("	COMMENTS ");
		}
		strSql.append("	  as COMMENTS, ")
		.append("	dbo.USER_NAME_MATA(POSTED_BY) AS POSTED_BY,DBO.CONVERTDATEDMY1(POSTED_ON) AS POSTED_ON_DATE, ")
		.append("	POSTED_BY  ");

		if(commentType != null && commentType.equals(TravelRequestEnums.ApproverCommentType.APPROVE.getName())){
			strSql.append("	,COMMENTS_ID FROM TRAVEL_REQ_COMMENTS ");
		}else{
			strSql.append("	,CANCEL_ID AS COMMENTS_ID FROM TRAVEL_REQ_CANCEL ");
		}
		strSql.append("	WHERE TRAVEL_ID=?  AND TRAVEL_TYPE=? ORDER BY POSTED_ON DESC ");

		try {
			conn = dbConBean.getConnection();
			stmt = conn.prepareStatement(strSql.toString());
			stmt.setString(1, travelId.trim());
			stmt.setString(2, traveltype.trim());
			rs = stmt.executeQuery();

			while(rs.next()){
				if(commentList == null)
					commentList = new ArrayList<Comment>();

				comment = new Comment();
				if(commentType != null && commentType.equals(TravelRequestEnums.ApproverCommentType.APPROVE.getName())){
					strSql.append("	TRAVEL_REQ_COMMENTS ");
				}else{
					strSql.append("	TRAVEL_REQ_CANCEL ");
				}
				comment.setCommentId(rs.getString("COMMENTS_ID"));
				comment.setComment(rs.getString("COMMENTS"));
				comment.setPostedByName(rs.getString("POSTED_BY"));
				comment.setPostedOnDate(rs.getString("POSTED_ON_DATE"));
				commentList.add(comment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return commentList;
	}
	
	/**
	 * Method return Traveler last Travel Request Detail
	 * @param travellerId
	 * @return TravelRequest Object
	 */
	public Map<String, Object> getTravellerLastTravelDetail(String travellerId, String travelType){

		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Map<String, Object> dataMap = null;
	
		try {
			conn = dbConBean.getConnection();
			/*stmt = conn.prepareStatement(strSql.toString());
			stmt.setString(1, travelType.trim());
			stmt.setString(2, travellerId.trim());
			stmt.setString(3, travelType.trim());
			stmt.setString(4, travellerId.trim());
			rs = stmt.executeQuery();*/
			
			stmt = conn.prepareCall("{call Proc_GetUserLastTravelPreference(?,?)}");
			stmt.setString(1, travelType.trim());
			stmt.setString(2, travellerId.trim());
			rs = stmt.executeQuery();

			if(rs.next()){
				
				dataMap = new HashMap<String, Object>();
				//dataMap.put("TRAVEL_ID", rs.getString("TRAVEL_ID"));
				dataMap.put("FLIGHT_SEAT_PREFERRED", rs.getString("FLIGHTSEATPREFERED"));
				dataMap.put("TRAIN_SEAT_PREFERRED", rs.getString("TRAINSEATPREFERED"));
				dataMap.put("RETURN_FLIGHT_SEAT_PREFERRED", rs.getString("RETURNFLIGHTSEATPREFERED"));
				dataMap.put("RETURN_TRAIN_SEAT_PREFERRED", rs.getString("RETURNTRAINSEATPREFERED"));
				dataMap.put("FLIGHT_SEAT_NAME", rs.getString("FLIGHTSEATNAME"));
				dataMap.put("TRAIN_SEAT_NAME", rs.getString("TRAINSEATNAME"));
				dataMap.put("RETURN_FLIGHT_SEAT_NAME", rs.getString("RETURNFLIGHTSEATNAME"));
				dataMap.put("RETURN_TRAIN_SEAT_NAME", rs.getString("RETURNTRAINSEATNAME"));
				dataMap.put("BAHN_CARD_NO", rs.getString("BAHNCARD_NUMBER"));
				dataMap.put("BAHN_CARD_DISCOUNT", rs.getString("BAHNCARD_DISCOUNT"));
				dataMap.put("BAHN_CARD_CLASS", rs.getString("BAHNCARD_CLASS"));
				dataMap.put("BAHN_CARD_VALID_DATE", rs.getString("BAHNCARD_VALID_DATE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dataMap;
}
	
	
	
	
	
	
	//Get Travel Request Detai lIndia
	public TravelRequest getTravelRequestDetailIndia(String travelId, String travelType, String travellerId){

		TravelRequest requestInfo = null;
		User traveller = null;
		User originator = null;
		Passport travellerPasportInfo = null;

		if(dbConBean == null){
			dbConBean  = new DbConnectionBean();
		}
		Connection conn = dbConBean.getConnection();
		CallableStatement stmt  = null;
		
		String flightRemarks			= null;
		String carRemarks				= null;
		String trainRemarks				= null;
		String accomodationRemarks		= null;
		Fare flightFare  				= null;
		Fare trainFare  				= null;
		Boolean isSpecialTrain			= null;

		ResultSet rsFlag = null,rsInformation = null,rsFlight = null,rsTrain = null, 
				rsCar = null,rsAccomo = null,rsBillingInfo = null,rsApproverLevel = null,rsApproverList = null,
				groupUserInfoList=null,rsAdvanceList=null,rsBudgetActual=null,rsTravelFare=null, rsVisaDetails=null;

		try{
			stmt = conn.prepareCall("{call SPG_MATAINDIA_TRAVEL_DETAIL(?,?,?,?,?)}");
			stmt.setString(1, travelId);
			stmt.setString(2, travelType);
			stmt.setString(3, travellerId);
			stmt.setInt(4, 2);
			stmt.registerOutParameter(5,java.sql.Types.INTEGER);

			boolean result = stmt.execute();
			int resultSetCount = 1;

			while(result){
				
				if(requestInfo == null)
					requestInfo = new TravelRequest();

				switch(resultSetCount){

				case 1: rsFlag = stmt.getResultSet();
				if(rsFlag.next()){
					requestInfo.setFlightDetailExist(rsFlag.getString("FLIGHT_TRAVEL_FLAG").equals("Y") ? true : false);
					requestInfo.setTrainDetailExist(rsFlag.getString("TRAIN_TRAVEL_FLAG").equals("Y") ? true : false);
					requestInfo.setRentA_CarDetailExist(rsFlag.getString("CAR_TRAVEL_FLAG").equals("Y") ? true : false);
					requestInfo.setAccomodationDetailExist(rsFlag.getString("ACCOMMODATION_TRAVEL_FLAG").equals("Y") ? true : false);
					requestInfo.setAdvanceDetailExist(rsFlag.getString("ADVANCE_FLAG").equals("Y") ? true : false);
					requestInfo.setBudgetActualDetailExist(rsFlag.getString("SHOW_BUD_FLAG").equals("Y") ? true : false);
					requestInfo.setTravelFareDetailExist(rsFlag.getString("SHOW_APP_LVL_3_FLAG").equals("Y") ? true : false);
					requestInfo.setGroupTravelExist(rsFlag.getString("GROUP_TRAVEL_FLAG").equals("Y") ? true : false);
					requestInfo.setVisaDetailExist(rsFlag.getString("TRAVEL_VISA_FLAG").equals("Y") ? true : false);
				}
				break;

				case 2: rsInformation = stmt.getResultSet();
				// Request Information Starts
				if(rsInformation.next()){
					originator = new User();
					traveller = new User();

					requestInfo.setRequisitionNo(rsInformation.getString("TRAVEL_REQ_NO"));
					requestInfo.setOriginator(originator);
					requestInfo.setTraveller(traveller);
					
					originator.setFullName(rsInformation.getString("ORIGINATED_BY"));
					originator.setUnitName(rsInformation.getString("ORIG_UNIT"));
					originator.setDepartmentName(rsInformation.getString("ORIG_DEPT"));
					originator.setDivisionName(rsInformation.getString("ORIG_DIVISION"));
					originator.setDesignationName(rsInformation.getString("ORIG_DESIG"));
					
					requestInfo.setCreationDate(rsInformation.getString("C_DATETIME"));
					requestInfo.setDivisionName(rsInformation.getString("DIVISION"));
					if(rsInformation.getString("PROJECTNO")==null || rsInformation.getString("PROJECTNO").trim().equals("")) {
						requestInfo.setProjectNo("-");
					}else{
						requestInfo.setProjectNo(rsInformation.getString("PROJECTNO"));
					}
					if(rsInformation.getString("REASON_FOR_TRAVEL") != null && !"".equals(rsInformation.getString("REASON_FOR_TRAVEL")))
						requestInfo.setReasonForTravel(rsInformation.getString("REASON_FOR_TRAVEL"));
					else
						requestInfo.setReasonForTravel("-");
					requestInfo.setLinkedTravelRequest(rsInformation.getString("LINK_TRAVEL_ID"));
					traveller.setUserName(rsInformation.getString("CURRENT_TRAVELLER"));
					traveller.setUnitName(rsInformation.getString("UNIT"));
					traveller.setDepartmentName(rsInformation.getString("DEPT"));
					traveller.setProofIdentityName(rsInformation.getString("IDENTITY_NAME"));
					traveller.setProofIdentityNumber(rsInformation.getString("IDENTITY_PROOFNO"));
					
					if(rsInformation.getString("COSTCENTRE")==null || rsInformation.getString("COSTCENTRE").trim().equals("-")) {
						traveller.setCostCenterName("Not Applicable");
					} else {
						traveller.setCostCenterName(rsInformation.getString("COSTCENTRE").toUpperCase());
					}
					
					if(rsInformation.getString("EXPENDITURE")!=null || !rsInformation.getString("EXPENDITURE").trim().equals("-"))
						requestInfo.setAdvanceForex(rsInformation.getString("EXPENDITURE"));
						
					traveller.setFirstName(rsInformation.getString("FIRST_NAME"));
					traveller.setLastName(rsInformation.getString("LAST_NAME"));
					traveller.setEmpCode(rsInformation.getString("EMP_CODE"));
					traveller.setDesignationName(rsInformation.getString("TRAVELLER_DESIG"));
					traveller.setContactNo(rsInformation.getString("CONTACT_NUMBER"));
					traveller.setGender(rsInformation.getString("GENDER"));
					traveller.setMealPreferrence(rsInformation.getString("MEAL_NAME"));
					traveller.setDateOfBirth(rsInformation.getString("DOB"));
					traveller.setPermanentAddress(rsInformation.getString("ADDRESS"));
					traveller.setCurrentAddress(rsInformation.getString("CURRENT_ADDRESS"));
					traveller.setEmail(rsInformation.getString("EMAIL"));
					if(!rsInformation.getString("TRAVELLER_ID").equals("-"))
						traveller.setUserId(Integer.parseInt(rsInformation.getString("TRAVELLER_ID")));
					
					travellerPasportInfo = new Passport();
					travellerPasportInfo.setFirstName(rsInformation.getString("PASSPORT_F_NAME"));
					travellerPasportInfo.setLastName(rsInformation.getString("PASSPORT_L_NAME"));
					travellerPasportInfo.setDateOfBirth(rsInformation.getString("DOB"));
					travellerPasportInfo.setPassportNo(rsInformation.getString("PASSPORT_NO"));
					travellerPasportInfo.setNationality(returnEmptyVal(rsInformation.getString("NATIONALITY")));
					travellerPasportInfo.setPlaceOfIssue(rsInformation.getString("PLACE_ISSUE"));
					travellerPasportInfo.setDateOfIssue(rsInformation.getString("DATE_ISSUE"));
					travellerPasportInfo.setDateOfExpiry(rsInformation.getString("EXPIRY_DATE"));
					
					if(rsInformation.getString("INSURANCE_REQUIRED").equals("2")){	
						travellerPasportInfo.setInsuranceReq(false);
						if(rsInformation.getString("INSURANCE_COMMENT") != null && !"".equals(rsInformation.getString("INSURANCE_COMMENT")))
							travellerPasportInfo.setInsuranceRemarks(rsInformation.getString("INSURANCE_COMMENT"));
						else
							travellerPasportInfo.setInsuranceRemarks("-");
					}
					if(rsInformation.getString("INSURANCE_REQUIRED").equals("1")){
						travellerPasportInfo.setInsuranceReq(true);
						if(rsInformation.getString("INSURANCE_NOMINEE") != null && !"".equals(rsInformation.getString("INSURANCE_NOMINEE")))
							travellerPasportInfo.setInsuranceNominee(rsInformation.getString("INSURANCE_NOMINEE"));
						else
							travellerPasportInfo.setInsuranceNominee("-");
						if(rsInformation.getString("INSURANCE_RELATION") != null && !"".equals(rsInformation.getString("INSURANCE_RELATION")))
							travellerPasportInfo.setInsuranceRelation(rsInformation.getString("INSURANCE_RELATION"));
						else
							travellerPasportInfo.setInsuranceRelation("-");
						
					}
						
					if(rsInformation.getString("VISA_REQUIRED") != null && rsInformation.getString("VISA_REQUIRED").equals("2")){	
						travellerPasportInfo.setVisaExists(false);
					}
					if(rsInformation.getString("VISA_REQUIRED") != null && rsInformation.getString("VISA_REQUIRED").equals("1")){
						travellerPasportInfo.setVisaExists(true);
					}
						
					traveller.setPassport(travellerPasportInfo);

					flightFare = new Fare();
					flightFare.setChangeableAgainstFee(rsInformation.getInt("FARE_CHANGEABLE_FLAG") == 2 ? false : true);
					flightFare.setRefundableAgainstFee(rsInformation.getInt("FARE_REFUNDABLE_FLAG") == 2 ? false : true);
					flightFare.setCheckedBaggageCount(rsInformation.getInt("NO_OF_BAGGAGE"));

					if(rsInformation.getString("BAHNCARD_NUMBER") != null && !"".equals(rsInformation.getString("BAHNCARD_NUMBER"))){
						trainFare = new Fare();

						trainFare.setBahnCardNo(rsInformation.getString("BAHNCARD_NUMBER"));
						trainFare.setDiscount("0".equals(rsInformation.getString("BAHNCARD_DISCOUNT")) ? "Bonus" : rsInformation.getString("BAHNCARD_DISCOUNT"));
						trainFare.setFareClass(rsInformation.getString("BAHNCARD_CLASS"));
						trainFare.setValidityDate(rsInformation.getString("BAHNCARD_VALID_DATE"));
						trainFare.setOnlineTicket(rsInformation.getInt("ONLINE_TICKET") == 2 ? false : true);
					}
					isSpecialTrain = "2".equals(rsInformation.getString("SPECIAL_TRAIN")) ? Boolean.FALSE : Boolean.TRUE;

					flightRemarks 		= rsInformation.getString("FLIGHT_REMARKS");
					carRemarks			= rsInformation.getString("CAR_REMARKS");
					trainRemarks 		= rsInformation.getString("TRAIN_REMARKS");
					accomodationRemarks = rsInformation.getString("ACCOMMODATION_REMARKS");

					if((rsInformation.getString("FF_AIR_NAME") != null && !"".equals(rsInformation.getString("FF_AIR_NAME"))) 
							|| (rsInformation.getString("FF_AIR_NAME1") != null && !"".equals(rsInformation.getString("FF_AIR_NAME1")))
							|| (rsInformation.getString("FF_AIR_NAME2") != null && !"".equals(rsInformation.getString("FF_AIR_NAME2")))
							|| (rsInformation.getString("FF_AIR_NAME3") != null && !"".equals(rsInformation.getString("FF_AIR_NAME3")))
							|| (rsInformation.getString("FF_AIR_NAME4") != null && !"".equals(rsInformation.getString("FF_AIR_NAME4")))
							|| (rsInformation.getString("HOTEL_NAME")   != null && !"".equals(rsInformation.getString("HOTEL_NAME")))
							|| (rsInformation.getString("HOTEL_NAME1")  != null && !"".equals(rsInformation.getString("HOTEL_NAME1")))
							|| (rsInformation.getString("HOTEL_NAME2")  != null && !"".equals(rsInformation.getString("HOTEL_NAME2")))
							|| (rsInformation.getString("HOTEL_NAME3")  != null && !"".equals(rsInformation.getString("HOTEL_NAME3")))
							|| (rsInformation.getString("HOTEL_NAME4")  != null && !"".equals(rsInformation.getString("HOTEL_NAME4")))) {
						
						// Reward card details
						List<RewardCard> rewardCardList = new ArrayList<RewardCard>();
						RewardCard card = null;

						if(!checkNullEmpty(rsInformation.getString("FF_AIR_NAME")) ||
								!checkNullEmpty(rsInformation.getString("HOTEL_NAME"))){
							card = new RewardCard(returnEmptyVal(rsInformation.getString("FF_AIR_NAME")), returnEmptyVal(rsInformation.getString("FF_NUMBER")), 
									returnEmptyVal(rsInformation.getString("HOTEL_NAME")), returnEmptyVal(rsInformation.getString("HOTEL_NUMBER")));
							rewardCardList.add(card);
						}
						if(!checkNullEmpty(rsInformation.getString("FF_AIR_NAME1")) ||
								!checkNullEmpty(rsInformation.getString("HOTEL_NAME1"))){
							card = new RewardCard(returnEmptyVal(rsInformation.getString("FF_AIR_NAME1")), returnEmptyVal(rsInformation.getString("FF_NUMBER1")), 
									returnEmptyVal(rsInformation.getString("HOTEL_NAME1")), returnEmptyVal(rsInformation.getString("HOTEL_NUMBER1")));
							rewardCardList.add(card);
						}
						if(!checkNullEmpty(rsInformation.getString("FF_AIR_NAME2")) ||
								!checkNullEmpty(rsInformation.getString("HOTEL_NAME2"))){
							card = new RewardCard(returnEmptyVal(rsInformation.getString("FF_AIR_NAME2")), returnEmptyVal(rsInformation.getString("FF_NUMBER2")), 
									returnEmptyVal(rsInformation.getString("HOTEL_NAME2")), returnEmptyVal(rsInformation.getString("HOTEL_NUMBER2")));
							rewardCardList.add(card);
						}
						if(!checkNullEmpty(rsInformation.getString("FF_AIR_NAME3")) ||
								!checkNullEmpty(rsInformation.getString("HOTEL_NAME3"))){
							card = new RewardCard(returnEmptyVal(rsInformation.getString("FF_AIR_NAME3")), returnEmptyVal(rsInformation.getString("FF_NUMBER3")), 
									returnEmptyVal(rsInformation.getString("HOTEL_NAME3")), returnEmptyVal(rsInformation.getString("HOTEL_NUMBER3")));
							rewardCardList.add(card);
						}
						if(!checkNullEmpty(rsInformation.getString("FF_AIR_NAME4")) ||
								!checkNullEmpty(rsInformation.getString("HOTEL_NAME4"))){
							card = new RewardCard(returnEmptyVal(rsInformation.getString("FF_AIR_NAME4")), returnEmptyVal(rsInformation.getString("FF_NUMBER4")), 
									returnEmptyVal(rsInformation.getString("HOTEL_NAME4")), returnEmptyVal(rsInformation.getString("HOTEL_NUMBER4")));
							rewardCardList.add(card);
						}
						requestInfo.setRewardCardList(rewardCardList);
					}
				}
				break;

				case 3: rsFlight = stmt.getResultSet();

				if(requestInfo.isFlightDetailExist()){

					List<Flight> flightDetailList = new ArrayList<Flight>();
					Flight flight = null;
					while(rsFlight.next()){
						flight = new Flight();

						if(!rsFlight.getString("TRAVEL_FROM").trim().equals("") || !rsFlight.getString("TRAVEL_TO").trim().equals("")) {							

							if(rsFlight.getString("JOURNEY") != null && "Onward".equals(rsFlight.getString("JOURNEY"))){
								flight.setJournyType(TravelRequestEnums.JournyType.FORWARD.getId());
							}
							if(rsFlight.getString("JOURNEY") != null && "Intermediate".equals(rsFlight.getString("JOURNEY"))){
								flight.setJournyType(TravelRequestEnums.JournyType.INTERMEDIATE.getId());
							}
							if(rsFlight.getString("JOURNEY") != null && "Return".equals(rsFlight.getString("JOURNEY"))){
								flight.setJournyType(TravelRequestEnums.JournyType.RETURNED.getId());

							}
							flight.setDepartureCity(rsFlight.getString("TRAVEL_FROM"));
							if(rsFlight.getString("TRAVEL_TO") != null && !"".equals(rsFlight.getString("TRAVEL_TO")))
								flight.setArrivalCity(rsFlight.getString("TRAVEL_TO"));
							else
								flight.setArrivalCity("-");
							flight.setDepartureDate(rsFlight.getString("TRAVEL_DATE"));
							flight.setPreferredTimeType("1".equals(rsFlight.getString("PREF_TIME_TYPE")) ? "Departure not Before" : "Arrival Until");
							flight.setTiming(rsFlight.getString("PREFERRED_TIME"));
							flight.setTravelClass(rsFlight.getString("TRAVEL_CLASS"));
							flight.setWindowSeatPreferrence(rsFlight.getString("SEAT_PREFFERED"));
							flight.setPrefAirline(rsFlight.getString("pref_airline").toUpperCase());
							if(flightRemarks != null && !flightRemarks.equals("") && !flightRemarks.trim().equals("-")) {
								flight.setRemarks(flightRemarks);
							}
							flight.setFareDetail(flightFare);
							flight.setRefundable(rsFlight.getString("TICKET_REFUNDABLE").trim().equals("N")?false:true);
							flightDetailList.add(flight);
						}
					}
					requestInfo.setFlightDetailList(flightDetailList);
				}
				break;

				case 4: rsTrain = stmt.getResultSet();
				//Train Details
				if(requestInfo.isTrainDetailExist()){

					List<Train> trainDetailList = new ArrayList<Train>();
					Train train = null;

					while(rsTrain.next()){
						if(!rsTrain.getString("TRAVEL_FROM").trim().equals("") || !rsTrain.getString("TRAVEL_TO").trim().equals("")) {
							train = new Train();

							if(rsTrain.getString("JOURNEY") != null && "Onward".equals(rsTrain.getString("JOURNEY"))){
								train.setJournyType(TravelRequestEnums.JournyType.FORWARD.getId());
							}
							if(rsTrain.getString("JOURNEY") != null && "Intermediate".equals(rsTrain.getString("JOURNEY"))){
								train.setJournyType(TravelRequestEnums.JournyType.INTERMEDIATE.getId());
							}
							if(rsTrain.getString("JOURNEY") != null && "Return".equals(rsTrain.getString("JOURNEY"))){
								train.setJournyType(TravelRequestEnums.JournyType.RETURNED.getId());
							}
							train.setDepartureCity(rsTrain.getString("TRAVEL_FROM"));
							if(rsTrain.getString("TRAVEL_TO") != null && !"".equals(rsTrain.getString("TRAVEL_TO")))
								train.setArrivalCity(rsTrain.getString("TRAVEL_TO"));
							else
								train.setArrivalCity("-");
							train.setDepartureDate(rsTrain.getString("TRAVEL_DATE"));
							train.setPreferredTimeType("1".equals(rsTrain.getString("PREF_TIME_TYPE")) ? "Departure not Before" : "Arrival Until");
							train.setTravelClass(rsTrain.getString("TRAVEL_CLASS"));
							train.setTiming(rsTrain.getString("PREFERRED_TIME"));
							train.setSeatPreferrence_1(rsTrain.getString("SEAT_PREFFERED"));
							train.setPrefTrain(rsTrain.getString("pref_airline").toUpperCase());
							train.setTatkaalTicket(rsTrain.getString("TATKAAL_FLAG").equals("Y")?true:false);
							if(trainRemarks != null && !trainRemarks.equals("") && !trainRemarks.trim().equals("-")) {
								train.setRemarks(trainRemarks);
							}
							train.setFareDetail(trainFare);
							train.setSpecialTrain(isSpecialTrain);
							trainDetailList.add(train);
						}
					}
					requestInfo.setTrainDetailList(trainDetailList);
				}
				break;

				case 5: rsCar = stmt.getResultSet();
				//Rent A Car Section starts
				if(requestInfo.isRentA_CarDetailExist()){
					List<Car> carDetailList = new ArrayList<Car>();
					Car car = null;
					
					while(rsCar.next()){
						if(!rsCar.getString("TRAVEL_FROM").trim().equals("") || !rsCar.getString("TRAVEL_TO").trim().equals("")) {
							car = new Car();

							if(rsCar.getString("JOURNEY") != null && "Onward".equals(rsCar.getString("JOURNEY"))){
								car.setJournyType(TravelRequestEnums.JournyType.FORWARD.getId());
							}
							if(rsCar.getString("JOURNEY") != null && "Intermediate".equals(rsCar.getString("JOURNEY"))){
								car.setJournyType(TravelRequestEnums.JournyType.INTERMEDIATE.getId());
							}
							if(rsCar.getString("JOURNEY") != null && "Return".equals(rsCar.getString("JOURNEY"))){
								car.setJournyType(TravelRequestEnums.JournyType.RETURNED.getId());
							}
							car.setStartCity(rsCar.getString("TRAVEL_FROM"));
							if(rsCar.getString("TRAVEL_TO") != null && !"".equals(rsCar.getString("TRAVEL_TO")))
								car.setEndCity(rsCar.getString("TRAVEL_TO"));
							else
								car.setEndCity("-");
							if(rsCar.getString("LOCATION")!= null && !"".equals(rsCar.getString("LOCATION")))
							{	
								TravelRequestEnums.LocationsMataIndia carLocation = TravelRequestEnums.LocationsMataIndia.fromId(rsCar.getString("LOCATION"));
								car.setStartLocation(carLocation != null?carLocation.getName() : "-");
							}
							car.setStartDate(rsCar.getString("START_DATE"));
							car.setPreferredTimeType("1".equals(rsCar.getString("PREF_TIME_TYPE")) ? "Departure not Before" : "Arrival Until");
							car.setTiming(rsCar.getString("PREFERRED_TIME"));
							car.setStartMobileNo(rsCar.getString("MOBILENO"));
							car.setPrefCar(rsCar.getString("CLASS").toUpperCase());
							car.setCarClass(rsCar.getString("TRAVEL_CLASS"));
							//car.setSeatPreferrence(rsCar.getString("SEAT_PREFFERED"));
							
							if(carRemarks != null && !carRemarks.equals("") && !carRemarks.trim().equals("-")) {
								car.setRemarks(carRemarks);
							}
							carDetailList.add(car);
						}
					}
					requestInfo.setCarDetailList(carDetailList);
				}
				break;

				case 6: rsAccomo = stmt.getResultSet();
				// Accommodation Detail Section Start 
				if(requestInfo.isAccomodationDetailExist()){
					List<Accommodation> accommodationDetailList = new ArrayList<Accommodation>();
					Accommodation accommodation = null;

					while(rsAccomo.next()){
						accommodation = new Accommodation();

						accommodation.setPlaceOfVisit(rsAccomo.getString("PLACE"));
						if(rsAccomo.getString("TRANSIT_TYPE") != null && !"".equals((rsAccomo.getString("TRANSIT_TYPE") != null)))
						{		
							if(rsAccomo.getString("TRANSIT_TYPE").equals("1"))
								accommodation.setAccommodationType("Hotel");
							else if(rsAccomo.getString("TRANSIT_TYPE").equals("2"))
								accommodation.setAccommodationType("Transit House");
								else 	
									accommodation.setAccommodationType("-");
						}
						accommodation.setCheckInDate(rsAccomo.getString("CHECK_IN_DATE"));
						accommodation.setCheckOutDate(rsAccomo.getString("CHECK_OUT_DATE"));
						accommodation.setCurrency(rsAccomo.getString("TRANSIT_TYPE").equals("2") ? "-" : rsAccomo.getString("BUDGET_CURRENCY"));
						accommodation.setBudget(rsAccomo.getString("TRANSIT_TYPE").equals("2") ? "-" : rsAccomo.getString("TRANSIT_BUDGET"));
						if(accomodationRemarks != null && !accomodationRemarks.equals("") && !accomodationRemarks.trim().equals("-")) {
							accommodation.setRemarks(accomodationRemarks);
						}	
						accommodationDetailList.add(accommodation);
					}
					requestInfo.setAccommodationList(accommodationDetailList);			
				}
				break;			

				case 7: rsAdvanceList = stmt.getResultSet();
				//Advance Forex List Start -->
				if(requestInfo.isAdvanceDetailExist()) {
					List <AdvanceForex> advanceForexList = null;
					AdvanceForex advanceForex = null;
					if(rsAdvanceList!=null) {
						advanceForexList = new ArrayList<AdvanceForex>();
						while(rsAdvanceList.next()){
							advanceForex = new AdvanceForex();
							advanceForex.setTravellerName(rsAdvanceList.getString("TRAVELLER_NAME"));
							advanceForex.setAdvCurrency(rsAdvanceList.getString("CURRENCY"));
							advanceForex.setExpensePerDay1(rsAdvanceList.getString("ENT_PER_DAY1"));
							advanceForex.setNumOfDays1(rsAdvanceList.getString("TOTAL_TOUR_DAYS1"));
							advanceForex.setTotalExpense1(rsAdvanceList.getString("TOTAL_EXP_ID1"));
							
							advanceForex.setExpensePerDay2(rsAdvanceList.getString("ENT_PER_DAY2"));
							advanceForex.setNumOfDays2(rsAdvanceList.getString("TOTAL_TOUR_DAYS2"));
							advanceForex.setTotalExpense2(rsAdvanceList.getString("TOTAL_EXP_ID2"));
							
							advanceForex.setContingencyExpense(rsAdvanceList.getString("TOTAL_EXP_ID3"));
							advanceForex.setOtherExpense(rsAdvanceList.getString("TOTAL_EXP_ID4"));
							advanceForex.setTotalExpenditure(rsAdvanceList.getString("TOTAL_EXP"));
							advanceForex.setExchangeRateINR(rsAdvanceList.getString("EXCHANGE_RATE"));
							advanceForex.setTotalAdvanceINR(rsAdvanceList.getString("TOTAL"));
							if(rsAdvanceList.getString("EXP_REMARK") != null && !"".equals(rsAdvanceList.getString("EXP_REMARK"))) {
								advanceForex.setAdvRemarks(rsAdvanceList.getString("EXP_REMARK"));
							} else {
								advanceForex.setAdvRemarks("-");
							}
							if(rsAdvanceList.getString("CASH_BREAKUP_REMARKS") != null && !"".equals(rsAdvanceList.getString("CASH_BREAKUP_REMARKS"))) {
								advanceForex.setCashBrkupRemarks(rsAdvanceList.getString("CASH_BREAKUP_REMARKS"));
							} else {
								advanceForex.setCashBrkupRemarks("-");
							}
							advanceForexList.add(advanceForex);
						}
					}	
					requestInfo.setAdvanceForexList(advanceForexList);
					//Advance Forex List End -->
				}
				break;
				
				
				case 8: rsBillingInfo = stmt.getResultSet();
				//Billing Instruction Section Start
				if(rsBillingInfo.next()){
					Approver billingApprover = new Approver();

					billingApprover.setUnitName(rsBillingInfo.getString("SITE_NAME"));
					billingApprover.setName(rsBillingInfo.getString("BILLING_CLIENT"));
					requestInfo.setBillingApprover(billingApprover);
				}
				break;

				case 9: rsApproverLevel = stmt.getResultSet();
				// Approval Level Section Start -->
				if(rsApproverLevel.next()){
					List<Approver> approveList = new ArrayList<Approver>();

					Approver approverLevel1 = new Approver();
					approverLevel1.setName(rsApproverLevel.getString("MANAGER_ID") == null ? "-" : rsApproverLevel.getString("MANAGER_ID"));
					approveList.add(approverLevel1);
					Approver approverLevel2 = new Approver();
					approverLevel2.setName(rsApproverLevel.getString("HOD_ID") == null ? "-" : rsApproverLevel.getString("HOD_ID"));
					approveList.add(approverLevel2);
					Approver approverLevel3 = new Approver();
					approverLevel3.setName(rsApproverLevel.getString("BOARD_MEMBER_ID") == null ? "-" : rsApproverLevel.getString("BOARD_MEMBER_ID"));
					approveList.add(approverLevel3);
					
					requestInfo.setApproverLevels(approveList);
					if(rsApproverLevel.getString("REASON_FOR_SKIP") != null && !rsApproverLevel.getString("REASON_FOR_SKIP").equals("") && !rsApproverLevel.getString("REASON_FOR_SKIP").trim().equals("-")) {
						requestInfo.setReasonOfSkipApprover(rsApproverLevel.getString("REASON_FOR_SKIP"));
					}
				}
				break;

				case 10: rsApproverList = stmt.getResultSet();
				// Approval List Section Start -->
				List<Approver> approveList = new ArrayList<Approver>();
				Approver approver = null;
				while(rsApproverList.next()){
					approver = new Approver();
					approver.setName(rsApproverList.getString("APPROVER_NAME"));
					approver.setDesignationName(rsApproverList.getString("DESIGN_DESC"));
					approver.setApproveStatus(rsApproverList.getString("APPROVE_STATUS"));
					approver.setApproveDate(rsApproverList.getString("APPROVE_DATE"));
					approver.setApproveTime(rsApproverList.getString("HHMM"));
					approver.setOriginalApprover(rsApproverList.getString("ORIGINAL_APPROVER"));
					approveList.add(approver);
				}
				requestInfo.setApprovers(approveList);
				break;

				case 11: groupUserInfoList = stmt.getResultSet();
				
				if(requestInfo.isGroupTravelExist()){
					// Attached Group User List Section Start -->
					List<User> groupUserList = new ArrayList<User>();
					User groupUser = null;
					Passport passport = null;
					while(groupUserInfoList.next()){
						groupUser = new User();
						passport = new Passport();
						groupUser.setPassport(passport);
	
						groupUser.setUserName(groupUserInfoList.getString("CURRENT_TRAVELLER"));
						groupUser.setFirstName(groupUserInfoList.getString("FIRST_NAME"));
						groupUser.setLastName(groupUserInfoList.getString("LAST_NAME"));
						groupUser.setDesignationName(groupUserInfoList.getString("TRAVELLER_DESIG"));
						groupUser.setDateOfBirth(groupUserInfoList.getString("DOB"));
						groupUser.setGender(groupUserInfoList.getString("GENDER"));
						groupUser.setContactNo(groupUserInfoList.getString("MOBILE_NO"));
						groupUser.setFrequentFlyer(groupUserInfoList.getString("FREQUENT_FLYER"));
						groupUser.setMealPreferrence(groupUserInfoList.getString("MEAL_NAME"));					
						groupUser.setReturnJournyFlag("Y".equals(groupUserInfoList.getString("RETURN_TRAVEL")) ? true : false);
						groupUser.setProofIdentityName(groupUserInfoList.getString("IDENTITY_NAME"));
						groupUser.setProofIdentityNumber(groupUserInfoList.getString("IDENTITY_NO"));
						groupUser.setAmountRequired(groupUserInfoList.getString("TOTAL_AMOUNT"));
						
						passport.setPassportNo(groupUserInfoList.getString("PASSPORT_NO"));
						passport.setNationality(returnEmptyVal(groupUserInfoList.getString("NATIONALITY")));
						passport.setPlaceOfIssue(groupUserInfoList.getString("PLACE_ISSUE"));
						passport.setDateOfExpiry(groupUserInfoList.getString("EXPIRY_DATE"));
						passport.setDateOfIssue(groupUserInfoList.getString("DATE_ISSUE"));
						passport.setVisaExists("1".equals(groupUserInfoList.getString("VISA_REQUIRED")) ? true : false);
						if("1".equals(groupUserInfoList.getString("ECNR")))
							passport.setEcr("Yes");
						else if("2".equals(groupUserInfoList.getString("ECNR")))
							passport.setEcr("No");
						else
							passport.setEcr("N/A");
						
						groupUser.setEmpCode(groupUserInfoList.getString("G_EMP_CODE"));
						groupUser.setEmail(groupUserInfoList.getString("G_EMAIL"));
						
						groupUserList.add(groupUser);
					}
					requestInfo.setTravelerList(groupUserList);
				}
				break;
				
				case 12: rsBudgetActual = stmt.getResultSet();
				//Budget Actual Detail Section Start
				if(requestInfo.isBudgetActualDetailExist()){
					if(rsBudgetActual.next()){
						BudgetActual budgetActual = new BudgetActual();
	
						budgetActual.setYtmBudget(rsBudgetActual.getString("YTM_BUDGET"));
						budgetActual.setYtdActual(rsBudgetActual.getString("YTD_ACTUAL"));
						budgetActual.setAvailBudget(rsBudgetActual.getString("AVAIL_BUDGET"));
						budgetActual.setEstExp(rsBudgetActual.getString("EST_EXP"));						
						budgetActual.setExpRemarks(rsBudgetActual.getString("EXP_REMARKS"));
						requestInfo.setBudgetActual(budgetActual);
					}
				}
				break;
				
				case 13: rsTravelFare = stmt.getResultSet();
				//Travel Fare Detail Section Start
				if(requestInfo.isTravelFareDetailExist()){
					if(rsTravelFare.next()){
						TravelFare travelFare = new TravelFare();
						if(rsTravelFare.getString("FARE_CURRENCY") != null && !"".equals(rsTravelFare.getString("FARE_CURRENCY")) 
								&& rsTravelFare.getString("FARE_AMOUNT") != null && !"0".equals(rsTravelFare.getString("FARE_AMOUNT"))) {
							travelFare.setFareCurrency(rsTravelFare.getString("FARE_CURRENCY"));
							travelFare.setFareAmount(rsTravelFare.getString("FARE_AMOUNT"));
							requestInfo.setTravelFare(travelFare);
						}						
					}
				}
				break;
				
				case 14: rsVisaDetails = stmt.getResultSet();
				// Visa Details Section Start
				if(requestInfo.isVisaDetailExist()){
					List<Visa> visaDetailList = new ArrayList<Visa>();
					Visa visa = null;
					
					while(rsVisaDetails.next()){
						visa = new Visa();
						
						visa.setCountry(rsVisaDetails.getString("VISA_COUNTRY"));
						visa.setValidFrom(rsVisaDetails.getString("VISA_VALID_FROM"));
						visa.setValidTo(rsVisaDetails.getString("VISA_VALID_TO"));
						visa.setVisaDuration(rsVisaDetails.getString("VISA_STAY_DURATION"));
						visa.setVisaComments(rsVisaDetails.getString("VISA_COMMENT"));
						visa.setVisaValidityFlag(rsVisaDetails.getString("VISA_VALIDITY_FLAG"));
						
						visaDetailList.add(visa);
					}
					requestInfo.setVisaDetailList(visaDetailList);
				}
				break;
				
				default:
					break;

				}
				if(resultSetCount <= 14){
					result = stmt.getMoreResults();
				
				}

				resultSetCount++;
			}

		}catch(SQLException ex){
			ex.printStackTrace();
		}
		return requestInfo;
}
		
		// Get Mail Body for Mata-India
		public String getMailBodyForMataIndia(String travelId, String travelType, String travellerId){
			
			// Fetch entire request information
			logger.setLevel(Level.ALL);
			logger.info("[getMailBodyForMataIndia] method body start ---->");
			TravelRequest requestInfo = getTravelRequestDetailIndia(travelId,travelType,travellerId);
			User originator = requestInfo.getOriginator();
			User traveller = requestInfo.getTraveller();

			StringBuilder strMailMsg = new StringBuilder();
			strMailMsg.append("<html><head><title class='inputbox'>WELCOME TO STARS:  SAMVARDHANA MOTHERSON TRAVEL  APPROVAL SYSTEM </title> ")
			.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />")
			.append("<style type=\"text/css\">")
			.append("")
			.append(".bodyline-top{border-bottom:#A9A9A9 1px solid;}.bodyline-bottom{border-top:#A9A9A9 1px solid;}")
			.append(".reportHeading{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:12px;font-weight:bold;color:#ffffff;line-height:22px;background-color:#7a7a7a;padding-left:5px;text-align:left;}")
			.append(".reportSubHeading{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#000000;line-height:20px;background-color:#dddddd;padding-left:5px;text-align:left;}")
			.append(".reportCaption{width:auto;max-width: 40%;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10px;font-weight:bold;color:#1d1d1d;line-height:20px;background-color:#f2f2f2;padding-left:5px;padding-right:5px;text-align:left;}")
			.append(".reportdata{width: auto;max-width: 40%;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10px;font-weight: normal;color:#373737;line-height:20px;background-color:#f7f7f7;padding-left:5px;padding-right:5px;text-align:left;}")
			.append(".reporttble{width: 99%;max-width: 100%;border: #c7c7c5 1px solid;}</style></head>");

			String bodyLineTopStr = "border-bottom:#A9A9A9 1px solid;";
			String reportHeadingStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:12px;font-weight:bold;color:#ffffff;line-height:22px;background-color:#7a7a7a;padding-left:5px;text-align:left;\"";
			String reportSubHeadingStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#000000;line-height:20px;background-color:#dddddd;padding-left:5px;text-align:left;\"";
			String reportCaptionStr = "style=\"width: auto;max-width: 40%;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10px;font-weight:bold;color:#1d1d1d;line-height:20px;background-color:#f2f2f2;padding-left:5px;padding-right:5px;text-align:left;\"";
			String reportdataStr = "style=\"width: auto;max-width: 40%;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10px;font-weight: normal;color:#373737;line-height:20px;background-color:#f7f7f7;padding-left:5px;padding-right:5px;text-align:left;\"";
			String reporttbleStr = "style=\"width: 99%; max-width: 100%;border: #c7c7c5 1px solid;\"";

			strMailMsg.append("<body style=\"margin:0;vertical-align: middle;\" align=\"left\">")
			.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"margin:0;\">")
			.append("<tr> <td height=\"45\" style=\""+bodyLineTopStr+"\"><ul style=\"margin:0;\"><li style=\"margin:0;\">");
			if(travelType.equalsIgnoreCase("D")){
				strMailMsg.append("<b>Domestic Journey Report</b>");
			}else{
				strMailMsg.append("<b>International Journey Report</b>");
			}
			strMailMsg.append("</li></ul></td><td align=\"right\" valign=\"bottom\" style=\""+bodyLineTopStr+"\"></td></tr></table>");
			strMailMsg.append("<table width=\"100%\" style=\"padding-left:10px;margin:0;\" border=\"0\" cellpadding=\"5\" cellspacing=\"1\">");
			strMailMsg.append("<tr><td align=\"left\">")
			.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"6\" align=\"left\" "+reportHeadingStr+">Request Information</td></tr>");

			strMailMsg.append("<tr>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Requisition Number</td>")
			.append("<td height=\"0\" "+reportdataStr+">"+requestInfo.getRequisitionNo()+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Originator</td>")
			.append("<td height=\"0\" "+reportdataStr+">"+originator.getFullName().toUpperCase()+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Originated On</td>")
			.append("<td height=\"0\" "+reportdataStr+" >"+requestInfo.getCreationDate()+"</td>")
			.append("</tr>")
			.append("<tr>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Division</td>")
			.append("<td height=\"0\" "+reportdataStr+">"+originator.getDivisionName().toUpperCase()+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Unit</td>")
			.append("<td height=\"0\" "+reportdataStr+">"+originator.getUnitName().toUpperCase()+"</td>")
			.append("<td height=\"0\" align=\"right\" "+reportCaptionStr+" >Department</td>")
			.append("<td height=\"0\" "+reportdataStr+" >"+originator.getDepartmentName().toUpperCase()+"</td>")
			.append("</tr>")
			.append("<tr>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Cost Centre</td>")
			.append("<td height=\"0\" colspan=\"2\" "+reportdataStr+">"+traveller.getCostCenterName()+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Reason For Travel</td>")
			.append("<td height=\"0\" colspan=\"2\" "+reportdataStr+" >"+requestInfo.getReasonForTravel()+"</td>")
			.append("</tr>")
			.append("</table>")
			.append("</td>")
			.append("</tr>");

			// Personal Detail Section Start
			logger.info("[getMailBodyForMataIndia] Personal Detail Section start ---->");
			strMailMsg.append("<tr><td>")
			.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\"> ")
			.append("<tr><td height=\"0\" colspan=\"8\" "+reportHeadingStr+">Traveller Information</td></tr>")
			.append("<tr>")
			.append("<td "+reportCaptionStr+" >Traveller Name</td><td "+reportdataStr+" >"+traveller.getUserName()+"</td>")
			.append("<td "+reportCaptionStr+" >Emp Code</td><td "+reportdataStr+" >"+traveller.getEmpCode()+"</td>")
			.append("<td "+reportCaptionStr+" >Designation</td><td "+reportdataStr+" >"+traveller.getDesignationName()+"</td>")
			.append("<td "+reportCaptionStr+" >Email-Id</td><td "+reportdataStr+" >"+traveller.getEmail()+"</td>")
			.append("</tr>")
			.append("<tr>")
			.append("<td "+reportCaptionStr+" >Contact No.</td><td "+reportdataStr+" >"+traveller.getContactNo()+"</td>")
			.append("<td "+reportCaptionStr+" >Date of Birth</td><td "+reportdataStr+" >"+traveller.getDateOfBirth()+"</td>")
			.append("<td "+reportCaptionStr+" >Gender</td><td "+reportdataStr+" >"+traveller.getGender()+"</td>")
			.append("<td "+reportCaptionStr+" >Meal Preference</td><td "+reportdataStr+" >"+traveller.getMealPreferrence()+"</td>")
			.append("</tr>")
			.append("<tr><td "+reportCaptionStr+" >Permanent Address</td><td "+reportdataStr+" colspan=\"7\">"+traveller.getPermanentAddress()+"</td><tr>")
			.append("<tr><td "+reportCaptionStr+" >Current Address</td><td "+reportdataStr+" colspan=\"7\">"+traveller.getCurrentAddress()+"</td></tr>")
			.append("</table>")
			.append("</td></tr>");
			logger.info("[getMailBodyForMataIndia] Personal Detail Section end.");
			// Personal Detail Section End
			
			// Itinerary Details Section Start
			logger.info("[getMailBodyForMataIndia] Itinerary Details Section start ---->");
			if (requestInfo.isFlightDetailExist() || requestInfo.isRentA_CarDetailExist() 
					||requestInfo.isTrainDetailExist() || requestInfo.isAccomodationDetailExist()) 
			{
				strMailMsg.append("<tr><td>")
				.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
				.append("<tr><td height=\"0\" colspan=\"10\" "+reportHeadingStr+">Itinerary Information</td></tr>");
				
				if (requestInfo.isFlightDetailExist() || requestInfo.isRentA_CarDetailExist() || requestInfo.isTrainDetailExist())
				{
					List travelDetailsList = new ArrayList();
					TravelDetails travelObj = new TravelDetails();
					String journytypeStr = null;
					String flightRemarks = "";
					String trainRemarks = "";
					String carRemarks = "";
					
					strMailMsg.append("<tr>")
					.append("<td "+reportCaptionStr+" >Journey</td>")
					.append("<td "+reportCaptionStr+" >Departure City</td>")
					.append("<td "+reportCaptionStr+" >Arrival City</td>")
					.append("<td "+reportCaptionStr+" >Departure Date</td>")
					.append("<td "+reportCaptionStr+" >Preferred Time</td>")
					.append("<td "+reportCaptionStr+" >Travel Mode</td>")
					.append("<td "+reportCaptionStr+" >Class</td>")
					.append("<td "+reportCaptionStr+" >Preferred Airline/Train/Cab</td>")
					.append("<td "+reportCaptionStr+" >Preferred Seat</td>")
					.append("<td "+reportCaptionStr+" >Other information</td>")
					.append("</tr>");
					
					// Flight Detail Section Start
					logger.info("[getMailBodyForMataIndia] Flight Details Section start ---->");
					if(requestInfo.isFlightDetailExist()){
					
						Flight flightObj = null;
						List flightList = requestInfo.getFlightDetailList();
						
						for (int i = 0; i < flightList.size(); i++) {
							flightObj = (Flight) flightList.get(i);
							travelObj = new TravelDetails();
							
							if (flightObj.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())) {
								journytypeStr = "Onward Journey";
							} else if (flightObj.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())) {
								journytypeStr = "Intermediate Journey";
							} else {
								journytypeStr = "Return Journey";
							}
							
							travelObj.setJourneyType(journytypeStr);
							travelObj.setDepartureCity(flightObj.getDepartureCity());
							travelObj.setArrivalCity(flightObj.getArrivalCity());
							travelObj.setDepartureDate(flightObj.getDepartureDate());
							travelObj.setPreferredTimeType(flightObj.getPreferredTimeType());
							travelObj.setPreferredTime(flightObj.getTiming());
							travelObj.setTravelMode("Flight");
							travelObj.setPreferredClass(flightObj.getTravelClass());
							travelObj.setPreferredCompany(flightObj.getPrefAirline());
							travelObj.setPreferredSeat(flightObj.getWindowSeatPreferrence());
							travelObj.setOtherInfo(" - ");
							travelDetailsList.add(travelObj);
							
							if (flightObj.getRemarks() != null && !flightObj.getRemarks().equals("") && !flightObj.getRemarks().trim().equals("-"))
								flightRemarks = flightObj.getRemarks();
						}	
					}
					logger.info("[getMailBodyForMataIndia] Flight Details Section end.");
					// Flight Detail Section End
					
					// Train Detail Section Start
					logger.info("[getMailBodyForMataIndia] Train Details Section start ---->");
					if (requestInfo.isTrainDetailExist()) {
						Train trainObj = null;
						List trainList = requestInfo.getTrainDetailList();
						
						for (int i = 0; i < trainList.size(); i++) {
							trainObj = (Train) trainList.get(i);
							travelObj = new TravelDetails();	
							if (trainObj.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())) {
								journytypeStr = "Onward Journey";
							} else if (trainObj.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())) {
								journytypeStr = "Intermediate Journey";
							} else {
								journytypeStr = "Return Journey";
							}
							
							travelObj.setJourneyType(journytypeStr);
							travelObj.setDepartureCity(trainObj.getDepartureCity());
							travelObj.setArrivalCity(trainObj.getArrivalCity());
							travelObj.setDepartureDate(trainObj.getDepartureDate());
							travelObj.setPreferredTimeType(trainObj.getPreferredTimeType());
							travelObj.setPreferredTime(trainObj.getTiming());
							travelObj.setTravelMode("Train");
							travelObj.setPreferredClass(trainObj.getTravelClass());
							travelObj.setPreferredCompany(trainObj.getPrefTrain());
							travelObj.setPreferredSeat(trainObj.getSeatPreferrence_1());
							travelObj.setOtherInfo("Tatkaal" + " - " + (journytypeStr.equals("Intermediate Journey") ? "NA" : (trainObj.isTatkaalTicket() ? "Yes" : "No")));
							travelDetailsList.add(travelObj);
							
							if (trainObj.getRemarks() != null && !trainObj.getRemarks().equals("") && !trainObj.getRemarks().trim().equals("-"))
								trainRemarks = trainObj.getRemarks();
						}	
					}
					logger.info("[getMailBodyForMataIndia] Train Details Section end.");
					// Train Detail Section End
					
					// Rent a Car Detail Section Start
					logger.info("[getMailBodyForMataIndia] Rent a Car Details Section start ---->");
					if (requestInfo.isRentA_CarDetailExist())
					{
						Car carObj = null;
						List carList = requestInfo.getCarDetailList();
						
						for (int i = 0; i < carList.size(); i++) {
							carObj = (Car) carList.get(i);
							travelObj = new TravelDetails();
								
							if (carObj.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())) {
								journytypeStr = "Onward Journey";
							} else if (carObj.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())) {
								journytypeStr = "Intermediate Journey";
							} else {
								journytypeStr = "Return Journey";
							}
							
							travelObj.setJourneyType(journytypeStr);
							travelObj.setDepartureCity(carObj.getStartCity());
							travelObj.setArrivalCity(carObj.getEndCity());
							travelObj.setDepartureDate(carObj.getStartDate());
							travelObj.setPreferredTimeType(carObj.getPreferredTimeType());
							travelObj.setPreferredTime(carObj.getTiming());
							travelObj.setTravelMode("Car");
							travelObj.setPreferredClass(carObj.getCarClass());
							travelObj.setPreferredCompany(carObj.getPrefCar());
							travelObj.setPreferredSeat(carObj.getStartLocation());
							travelObj.setOtherInfo("Mobile No." + " - " + carObj.getStartMobileNo());
							travelDetailsList.add(travelObj);
							
							if (carObj.getRemarks() != null	&& !carObj.getRemarks().equals("") && !carObj.getRemarks().trim().equals("-"))
								carRemarks = carObj.getRemarks();
						}	
					}	
					logger.info("[getMailBodyForMataIndia] Rent a Car Details Section end.");
					// Rent a Car Detail Section End
					
					Collections.sort(travelDetailsList);
					for(int listCounter = 0; listCounter < travelDetailsList.size(); listCounter++)
					{
						TravelDetails tempTravelObj = (TravelDetails) travelDetailsList.get(listCounter);
						
						if(listCounter == 0)
						{	tempTravelObj.setJourneyType("Onward Journey");
						}
						else if(listCounter == travelDetailsList.size()-1)
						{
							tempTravelObj.setJourneyType("Return Journey");
						}
						else
						{
							tempTravelObj.setJourneyType("Intermediate Journey");
						}
					}
					ListIterator<TravelDetails> travelDetailsListIterator = travelDetailsList.listIterator();
					while(travelDetailsListIterator.hasNext())
					{	
						TravelDetails iterTravelObj = (TravelDetails) travelDetailsListIterator.next();
						strMailMsg.append("<tr>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getJourneyType()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getDepartureCity()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getArrivalCity()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getDepartureDate()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getPreferredTimeType() + " "+ iterTravelObj.getPreferredTime()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getTravelMode()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getPreferredClass()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getPreferredCompany()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getPreferredSeat()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getOtherInfo()+"</td>")
						.append("</tr>");
					}
					
					if(!flightRemarks.equals("")) {
						strMailMsg.append("<tr>")
						.append("<td "+reportCaptionStr+" >Flight Remarks</td><td "+reportdataStr+" colspan=\"9\">"+flightRemarks+"</td>")
						.append("</tr>");
					}
					if(!trainRemarks.equals("")) {
						strMailMsg.append("<tr>")
						.append("<td "+reportCaptionStr+" >Train Remarks</td><td "+reportdataStr+" colspan=\"9\">"+trainRemarks+"</td>")
						.append("</tr>");
					}
					if(!carRemarks.equals("")) {
						strMailMsg.append("<tr>")
						.append("<td "+reportCaptionStr+" >Car Remarks</td><td "+reportdataStr+" colspan=\"9\">"+carRemarks+"</td>")
						.append("</tr>");
					}
				}
				
				// Accommodation Detail Section Start
				logger.info("[getMailBodyForMataIndia] Accomodation Details Section start ---->");
				if(requestInfo.isAccomodationDetailExist()){
					List<Accommodation> accommodationList = requestInfo.getAccommodationList();
					Accommodation accommodation = null;
					
					if (accommodationList != null && !accommodationList.isEmpty()) {
						strMailMsg.append("<tr><td height=\"0\" colspan=\"10\" "+reportSubHeadingStr+">Accommodation</td></tr>")
						.append("<tr><td "+reportCaptionStr+" >##</td>")
						.append("<td "+reportCaptionStr+" >Stay Type</td><td "+reportCaptionStr+" >Currency</td>")
						.append("<td "+reportCaptionStr+" >Budget</td>")
						.append("<td "+reportCaptionStr+" colspan=\"2\" >Check In Date</td>")
						.append("<td "+reportCaptionStr+" colspan=\"2\" >Check Out Date</td>")
						.append("<td "+reportCaptionStr+" colspan=\"2\" >Preferred Place</td>")
						.append("</tr>");
		
						for(int i=0; i<accommodationList.size(); i++){
							accommodation = (Accommodation)accommodationList.get(i);
		
							strMailMsg.append("<tr><td "+reportdataStr+" >"+(i+1)+"</td>")
							.append("<td "+reportdataStr+" >"+accommodation.getAccommodationType()+"</td>")
							.append("<td "+reportdataStr+" >"+accommodation.getCurrency()+"</td>")
							.append("<td "+reportdataStr+" >"+accommodation.getBudget()+"</td>")
							.append("<td "+reportdataStr+" colspan=\"2\" >"+accommodation.getCheckInDate()+"</td>")
							.append("<td "+reportdataStr+" colspan=\"2\" >"+accommodation.getCheckOutDate()+"</td>")
							.append("<td "+reportdataStr+" colspan=\"2\" >"+accommodation.getPlaceOfVisit()+"</td>")
							.append("</tr>");
						}
						if(!checkNullEmpty(accommodation.getRemarks()) && !accommodation.getRemarks().trim().equals("-")) {
							strMailMsg.append("<tr><td "+reportCaptionStr+" >Remarks</td><td "+reportdataStr+"  colspan=\"9\">"+accommodation.getRemarks()+"</td></tr>");
						}
					}
				}
				logger.info("[getMailBodyForMataIndia] Accomodation Details Section end.");
				// Accommodation Detail Section End
				strMailMsg.append("</table></td></tr>");
			}
			logger.info("[getMailBodyForMataIndia] Itinerary Details Section end.");
			// Itinerary Details Section End
			
			// Advance/Expense Detail Section Start
			logger.info("[getMailBodyForMataIndia] Advance/Expense Detail Section start ---->");
			if(travelType.equalsIgnoreCase("I") && requestInfo.isAdvanceDetailExist()) {
				List <AdvanceForex> advanceForexList = requestInfo.getAdvanceForexList();			
				if (advanceForexList != null && !advanceForexList.isEmpty() && advanceForexList.size() > 0) {
					strMailMsg.append("<tr><td>")
					.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\"> ");
					if(travelType.equalsIgnoreCase("D"))
						strMailMsg.append("<tr><td height=\"0\" colspan=\"10\" "+reportHeadingStr+">Advance Required</td><td height=\"0\" colspan=\"4\" "+reportHeadingStr+">" + requestInfo.getAdvanceForex() + "</td></tr>");
					if(travelType.equalsIgnoreCase("I"))
						strMailMsg.append("<tr><td height=\"0\" colspan=\"10\" "+reportHeadingStr+">Forex Details</td><td height=\"0\" colspan=\"5\" "+reportHeadingStr+">" + requestInfo.getAdvanceForex() + "</td></tr>");
					
					strMailMsg.append("<tr>")
					.append("<td "+reportCaptionStr+" rowspan=\"2\" nowrap=\"nowrap\">S No.</td>")
					.append("<td "+reportCaptionStr+" rowspan=\"2\" >Traveller Name</td><td "+reportCaptionStr+" rowspan=\"2\" >Currency</td>")
					.append("<td "+reportCaptionStr+" colspan=\"3\" >Daily Allowances</td><td "+reportCaptionStr+" colspan=\"3\" >Hotel Charges</td>")
					.append("<td "+reportCaptionStr+" rowspan=\"2\" >Contingencies<br>(C)</td><td "+reportCaptionStr+" rowspan=\"2\" >Others<br>(D)</td>")
					.append("<td "+reportCaptionStr+" rowspan=\"2\" >Total<br>(A+B+C+D)</td><td "+reportCaptionStr+" rowspan=\"2\" >Total Amount</td>")
					.append("<td "+reportCaptionStr+" rowspan=\"2\" >Remarks for Contigencies/Any other Expenditure</td>");
					if(travelType.equalsIgnoreCase("I"))
					strMailMsg.append("<td "+reportCaptionStr+" rowspan=\"2\" >Currency Denomination Details</td>");
					strMailMsg.append("</tr>");
	
					strMailMsg.append("<tr>")
					.append("<td "+reportCaptionStr+" nowrap=\"nowrap\">Exp/Day</td>")
					.append("<td "+reportCaptionStr+" >Day(s)</td><td "+reportCaptionStr+" >Total<br>(A)</td>")
					.append("<td "+reportCaptionStr+" nowrap=\"nowrap\">Exp/Day</td>")
					.append("<td "+reportCaptionStr+" >Day(s)</td><td "+reportCaptionStr+" >Total<br>(B)</td>")
					.append("</tr>");
						
					AdvanceForex advanceForex = null;
					for (int i = 0; i < advanceForexList.size(); i++) {
						advanceForex = (AdvanceForex) advanceForexList.get(i);
						strMailMsg.append("<tr>")
						.append("<td "+reportdataStr+" nowrap=\"nowrap\">"+ (i + 1) +"</td>")
						.append("<td "+reportdataStr+" >"+ advanceForex.getTravellerName() +"</td><td "+reportdataStr+" >"+ advanceForex.getAdvCurrency() +"</td>")
						.append("<td "+reportdataStr+" style=\"text-align: right;\">"+ advanceForex.getExpensePerDay1() +"</td><td "+reportdataStr+" style=\"text-align: right;\">"+ advanceForex.getNumOfDays1() +"</td>")
						.append("<td "+reportCaptionStr+" style=\"text-align: right;\">"+ advanceForex.getTotalExpense1() +"</td><td "+reportdataStr+" style=\"text-align: right;\">"+ advanceForex.getExpensePerDay2() +"</td>")
						.append("<td "+reportdataStr+" style=\"text-align: right;\">"+ advanceForex.getNumOfDays2() +"</td><td "+reportCaptionStr+" style=\"text-align: right;\">"+ advanceForex.getTotalExpense2() +"</td>")
						.append("<td "+reportCaptionStr+" style=\"text-align: right;\">"+ advanceForex.getContingencyExpense() +"</td><td "+reportCaptionStr+" style=\"text-align: right;\">"+ advanceForex.getOtherExpense() +"</td>")
						.append("<td "+reportCaptionStr+" style=\"text-align: right;\">"+ advanceForex.getTotalExpenditure() +"</td><td "+reportCaptionStr+" style=\"text-align: right;\">"+ advanceForex.getTotalAdvanceINR() +"</td>")
						.append("<td "+reportdataStr+" style=\"text-align: right;\">"+ advanceForex.getAdvRemarks() +"</td>");
						if(travelType.equalsIgnoreCase("I"))
						strMailMsg.append("<td "+reportdataStr+" style=\"text-align: right;\">"+ advanceForex.getCashBrkupRemarks() +"</td>");
						strMailMsg.append("</tr>");
					}
					strMailMsg.append("</table></td></tr>");
			
				}
			}
			logger.info("[getMailBodyForMataIndia] Advance/Expense Detail Section end.");
			// Advance/Expense Detail Section End
			
			// Total Travel Fare Section Start
			logger.info("[getMailBodyForMataIndia] Total Travel Fare Section start ---->");
			if(travelType.equalsIgnoreCase("I") && requestInfo.isTravelFareDetailExist()){
				TravelFare travelFare = requestInfo.getTravelFare();
				if(travelFare != null){
					strMailMsg.append("<tr><td>")
					.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
					.append("<tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+" >Total Travel Fare</td></tr>");
	
					strMailMsg.append("<tr><td height=\"0\" "+reportCaptionStr+" >Currency</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+travelFare.getFareCurrency()+"</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Total Fare</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+travelFare.getFareAmount()+"</td></tr>");					
									
					strMailMsg.append("</table></td></tr>");
				}
			}
			logger.info("[getMailBodyForMataIndia] Total Travel Fare Section end.");
			// Total Travel Fare Section End
			
			// Budget Actual Details Section Start
			logger.info("[getMailBodyForMataIndia] Budget Actual Details Section start ---->");
			if(requestInfo.isBudgetActualDetailExist()){
				BudgetActual budgetActual = requestInfo.getBudgetActual();
				if(budgetActual != null){
					strMailMsg.append("<tr><td>")
					.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
					.append("<tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+" >Budget Actual Details</td></tr>");
	
					strMailMsg.append("<tr><td height=\"0\" "+reportCaptionStr+" >YTM Budget</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+budgetActual.getYtmBudget()+"</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >YTD Actual</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+budgetActual.getYtdActual()+"</td></tr>");
					
					strMailMsg.append("<tr><td height=\"0\" "+reportCaptionStr+" >Available Budget</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+budgetActual.getAvailBudget()+"</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Estimate</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+budgetActual.getEstExp()+"</td></tr>");
					
					strMailMsg.append("<tr><td height=\"0\" "+reportCaptionStr+" >Remarks</td>")
					.append("<td height=\"0\" "+reportdataStr+" colspan=\"3\">"+budgetActual.getExpRemarks()+"</td></tr>");
									
					strMailMsg.append("</table></td></tr>");
				}
			}
			logger.info("[getMailBodyForMataIndia] Budget Actual Details Section end.");
			// Budget Actual Details Section End
			
			// Billing Instruction & Approver Level Section Start
			logger.info("[getMailBodyForMataIndia] Billing Instruction & Approver Level Section start ---->");
			Approver billingApprover = requestInfo.getBillingApprover();
			List<Approver> approverLevelList = requestInfo.getApproverLevels();
			
			if(billingApprover != null || (approverLevelList != null && !approverLevelList.isEmpty() && (approverLevelList.size() == 3))){
				strMailMsg.append("<tr><td>")
				.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
				.append("<tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+" >Billing Instructions and Approvers</td></tr>");
				
				// Billing Instruction Section Start	
				if(billingApprover != null){
					strMailMsg.append("<tr>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Billing Client</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+billingApprover.getUnitName()+"</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Billing Approver</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+billingApprover.getName()+"</td>")
					.append("</tr>");
				}
				// Billing Instruction Section End
	
				// Approval Level Section Start
				
				if(approverLevelList != null && !approverLevelList.isEmpty() && (approverLevelList.size() == 3)){
					strMailMsg.append("<tr>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Approval Level 1 </td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+("-".equals(approverLevelList.get(0).getName()) ? "Not Applicable" : approverLevelList.get(0).getName())+"</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Approval Level 2 </td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+("-".equals(approverLevelList.get(1).getName()) ? "Not Applicable" : approverLevelList.get(1).getName())+"</td>")
					.append("</tr>");
					
					if(!"-".equals(approverLevelList.get(2).getName())) {
						strMailMsg.append("<tr>")
						.append("<td height=\"0\" "+reportCaptionStr+" >Board Member</td>")
						.append("<td height=\"0\" colspan=\"3\" "+reportdataStr+" >"+("-".equals(approverLevelList.get(2).getName()) ? "Not Applicable" : approverLevelList.get(2).getName())+"</td>")
						.append("</tr>");
					}
					
				}
				// Approval Level Section End
				
				strMailMsg.append("</table></td></tr>");
			}
			logger.info("[getMailBodyForMataIndia] Billing Instruction & Approver Level Section end.");
			// Billing Instruction & Approver Level Section End
	
			// Proof of Identity Detail Section Start
			logger.info("[getMailBodyForMataIndia] Proof of Identity Detail Section start ---->");
			if(travelType.equalsIgnoreCase("D")){
				strMailMsg.append("<tr><td>")
				.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
				.append("<tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+">Identity Proof Details</td></tr>")
				.append("<tr>")
				.append("<td "+reportCaptionStr+" >Proof of Identity</td><td "+reportdataStr+" >"+traveller.getProofIdentityName()+"</td>")
				.append("<td "+reportCaptionStr+" >Identity Proof Number</td><td "+reportdataStr+" >"+traveller.getProofIdentityNumber()+"</td>")
				.append("</tr>")
				.append("</table></td></tr>");
			}
			logger.info("[getMailBodyForMataIndia] Proof of Identity Detail Section end.");
			// Proof of Identity Detail Section End
			
			// Passport/Visa/Insurance Detail Section Start
			
				// Passport Detail Section Start
				logger.info("[getMailBodyForMataIndia] Passport/Visa/Insurance Detail Section start ---->");
				if(travelType.equalsIgnoreCase("I")){
					logger.info("[getMailBodyForMataIndia] Passport/Visa Detail Section start ---->");
					Passport travellerPassportInfo = traveller.getPassport();
	
					strMailMsg.append("<tr><td>")
					.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
					.append("<tr><td height=\"0\" colspan=\"6\" "+reportHeadingStr+">Passport/ Visa/ Insurance Information</td></tr>")
					.append("<tr>")
					.append("<td "+reportCaptionStr+" >Passport Number</td><td "+reportdataStr+" >"+travellerPassportInfo.getPassportNo()+"</td>")
					.append("<td "+reportCaptionStr+" >Nationality</td><td "+reportdataStr+" >"+travellerPassportInfo.getNationality()+"</td>")
					.append("<td "+reportCaptionStr+" >Place of Issue</td><td "+reportdataStr+" >"+travellerPassportInfo.getPlaceOfIssue()+"</td>")
					.append("</tr>")
					.append("<tr>")
					.append("<td "+reportCaptionStr+" >Date of Issue</td><td "+reportdataStr+" >"+travellerPassportInfo.getDateOfIssue()+"</td>")
					.append("<td "+reportCaptionStr+" >Date of Expiry</td><td "+reportdataStr+" >"+travellerPassportInfo.getDateOfExpiry()+"</td>")
					.append("<td "+reportCaptionStr+" >Visa Required</td><td "+reportdataStr+" >"+(travellerPassportInfo.isVisaExists() ? "Yes": "No")+"</td>")
					.append("</tr>");
					
					logger.info("[getMailBodyForMataIndia] Passport/Visa Detail Section end.");
				
				// Passport Detail Section End
				
				// Insurance Detail Section Start
					logger.info("[getMailBodyForMataIndia] Insurance Detail Section start ---->");
					strMailMsg.append("<tr>");
					strMailMsg.append("<td "+reportCaptionStr+" >Travel Insurance Required</td><td "+reportdataStr+" >"+(travellerPassportInfo.isInsuranceReq() ? "Yes": "No")+"</td>");
					if(!travellerPassportInfo.isInsuranceReq())
						strMailMsg.append("<td "+reportCaptionStr+" >Insurance Comments</td><td "+reportdataStr+" colspan=\"3\">"+travellerPassportInfo.getInsuranceRemarks()+"</td>");
					else
					{
						strMailMsg.append("<td "+reportCaptionStr+" >Nominee</td><td "+reportdataStr+" >"+travellerPassportInfo.getInsuranceNominee()+"</td>")
						.append("<td "+reportCaptionStr+" >Relation</td><td "+reportdataStr+" >"+travellerPassportInfo.getInsuranceRelation()+"</td>");
					}
					strMailMsg.append("</tr>");
				// Insurance Detail Section End	
					logger.info("[getMailBodyForMataIndia] Insurance Detail Section end.");
					
				// Visa Detail Section Start	
					if (requestInfo.isVisaDetailExist()) {
						logger.info("[getMailBodyForMataIndia] Visa Detail Section start ---->");
						
						List<Visa> visaDetailList = requestInfo.getVisaDetailList();	
						if (visaDetailList != null && !visaDetailList.isEmpty() && visaDetailList.size() > 0) {
							String reportSubHeadingStrTmp = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#000000;line-height:16px;background-color:#dddddd;padding-left:5px;text-align:left;\" ";
							
							strMailMsg.append("<tr>");
							strMailMsg.append("<td colspan=\"6\" "+reportSubHeadingStrTmp+">Visa Details</td>");
							strMailMsg.append("</tr>");
							strMailMsg.append("<tr>");
							strMailMsg.append("<td "+reportCaptionStr+">Visa Country</td>");
							strMailMsg.append("<td "+reportCaptionStr+">Visa Valid From</td>");
							strMailMsg.append("<td "+reportCaptionStr+">Visa Valid To</td>");
							strMailMsg.append("<td "+reportCaptionStr+">Visa Duration</td>");
							strMailMsg.append("<td "+reportCaptionStr+">Visa Comments</td>");
							strMailMsg.append("<td "+reportCaptionStr+">Validity</td>");
							strMailMsg.append("</tr>");
							
							for(int i=0; i < visaDetailList.size(); i++) {
								Visa visa = (Visa) visaDetailList.get(i);
								
								strMailMsg.append("<tr>");
								strMailMsg.append("<td "+reportdataStr+">"+visa.getCountry().trim()+"</td>");
								strMailMsg.append("<td "+reportdataStr+">"+visa.getValidFrom().trim()+"</td>");
								strMailMsg.append("<td "+reportdataStr+">"+visa.getValidTo().trim()+"</td>");
								strMailMsg.append("<td "+reportdataStr+">"+visa.getVisaDuration().trim()+"</td>");
								strMailMsg.append("<td "+reportdataStr+">"+visa.getVisaComments().trim()+"</td>");
								if(visa.getVisaValidityFlag().trim().equalsIgnoreCase("Y")) {
									strMailMsg.append("<td "+reportdataStr+">Valid</td>");
								} else {
									strMailMsg.append("<td "+reportdataStr+">Invalid</td>");
								}
								strMailMsg.append("</tr>");
							}
							strMailMsg.append("</table></td></tr>");
						} else {
							strMailMsg.append("</table></td></tr>");
						}
						logger.info("[getMailBodyForMataIndia] Insurance Detail Section end.");
					} else {
						strMailMsg.append("</table></td></tr>");
					}
				// Visa Detail Section End
				}
			
				logger.info("[getMailBodyForMataIndia] Passport/Visa/Insurance Detail Section end.");
			// Passport/Visa/Insurance Detail Section End
			
			// Rewards Card Detail Section Start
				logger.info("[getMailBodyForMataIndia] Rewards Card Detail Section start ---->");
				List <RewardCard> rewardCardList = requestInfo.getRewardCardList();
				if (rewardCardList != null && !rewardCardList.isEmpty()) {
					strMailMsg.append("<tr><td>")
					.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
					.append("<tr><td height=\"0\" colspan=\"2\" "+reportHeadingStr+" >Frequent Flyer Details</td><td height=\"0\" colspan=\"2\" "+reportHeadingStr+" >Hotel Reward Card</td></tr>")
					.append("<tr>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Airline Names</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Number</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Hotel Chain</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Number</td>")
					.append("</tr>");
					
					for (int i = 0; i < rewardCardList.size(); i++) {
						RewardCard card = (RewardCard) rewardCardList.get(i);
						strMailMsg.append("<tr>")
						.append("<td height=\"0\" "+reportdataStr+" >"+card.getAirlineName()+"</td>")
						.append("<td height=\"0\" "+reportdataStr+" >"+card.getAirlineNo()+"</td>")
						.append("<td height=\"0\" "+reportdataStr+" >"+card.getHotelChainName()+"</td>")
						.append("<td height=\"0\" "+reportdataStr+" >"+card.getHotelChainNo()+"</td>")
						.append("</tr>");
					}
					strMailMsg.append("</table></td></tr>");
				}
				logger.info("[getMailBodyForMataIndia] Rewards Card Detail Section end.");
			// Rewards Card Detail Section End
			
			// Approvers List Section Start
			logger.info("[getMailBodyForMataIndia] Approvers List Section start ---->");
			List<Approver> approversList = requestInfo.getApprovers();
			Approver approverObj = null;
			if(approversList != null && !approversList.isEmpty()){
				strMailMsg.append("<tr><td>")
				.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
				.append("<tr><td colspan=\"5\" "+reportHeadingStr+" >Approvers List</td></tr>")
				.append("<tr><td  "+reportCaptionStr+" nowrap=\"nowrap\">S No.</td>")
				.append("<td "+reportCaptionStr+">Name</td><td "+reportCaptionStr+">Designation</td>")
				.append("<td "+reportCaptionStr+">Status</td><td "+reportCaptionStr+">Approval Date Time</td></tr>");

				for(int i=0; i<approversList.size(); i++){
					approverObj = (Approver)approversList.get(i);
					String apprvTime = (approverObj.getApproveTime() == null || approverObj.getApproveTime().trim().equals("")) ? "": "  "+approverObj.getApproveTime().trim();
					
					strMailMsg.append("<tr><td  "+reportdataStr+" style=\"text-align: center;\">"+(i+1)+"</td>")
					.append("<td "+reportdataStr+">"+approverObj.getName()+"</td><td "+reportdataStr+">"+approverObj.getDesignationName()+"</td>")
					.append("<td "+reportdataStr+">"+("10".equals(approverObj.getApproveStatus()) ? "Approved" : "Pending")+"</td>")
					.append("<td "+reportdataStr+">"+approverObj.getApproveDate().trim()+apprvTime+"</td></tr>");
				}
				strMailMsg.append("</table></td></tr>");
			}
			logger.info("[getMailBodyForMataIndia] Approvers List Section end.");
			// Approvers List Section End
			
			
			strMailMsg.append("</table><br/><br/><b>Best Regards,</b><br/>STARS Admin</body></html>");
			logger.info("[getMailBodyForMataIndia] method body end.");
			return strMailMsg.toString();
			
		}
			
		
		// Get Group/Guest Mail Body for Mata-India
		public String getGroupMailBodyForMataIndia(String travelId, String travelType, String travellerId){
			StringBuilder strMailMsg = new StringBuilder();
			
			// Fetch entire request information
			logger.setLevel(Level.ALL);
			logger.info("[getGroupMailBodyForMataIndia] method body start ---->");
			TravelRequest requestInfo = getTravelRequestDetailIndia(travelId,travelType,travellerId);
			User originator = requestInfo.getOriginator();
			User traveller = requestInfo.getTraveller();
			
			String bodyLineTopStr = "border-bottom:#A9A9A9 1px solid;";
			String reportHeadingStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:12px;font-weight:bold;color:#ffffff;line-height:22px;background-color:#7a7a7a;padding-left:5px;text-align:left;\"";
			String reportSubHeadingStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#000000;line-height:20px;background-color:#dddddd;padding-left:5px;text-align:left;\"";
			String reportCaptionStr = "style=\"width: auto;max-width: 40%;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10px;font-weight:bold;color:#1d1d1d;line-height:20px;background-color:#f2f2f2;padding-left:5px;padding-right:5px;text-align:left;\"";
			String reportdataStr = "style=\"width: auto;max-width: 40%;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10px;font-weight: normal;color:#373737;line-height:20px;background-color:#f7f7f7;padding-left:5px;padding-right:5px;text-align:left;\"";
			String reporttbleStr = "style=\"width: 99%;max-width: 100%;border: #c7c7c5 1px solid;\"";

			strMailMsg.append("<html><head><title class='inputbox'>WELCOME TO STARS:  SAMVARDHANA MOTHERSON TRAVEL  APPROVAL SYSTEM </title> ")
			.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />")
			.append("<style type=\"text/css\">")
			.append("")
			.append(".bodyline-top{border-bottom:#A9A9A9 1px solid;}.bodyline-bottom{border-top:#A9A9A9 1px solid;}")
			.append(".reportHeading{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:12px;font-weight:bold;color:#ffffff;line-height:22px;background-color:#7a7a7a;padding-left:5px;text-align:left;}")
			.append(".reportSubHeading{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#000000;line-height:20px;background-color:#dddddd;padding-left:5px;text-align:left;}")
			.append(".reportCaption{width: auto;max-width: 40%;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10px;font-weight:bold;color:#1d1d1d;line-height:20px;background-color:#f2f2f2;padding-left:5px;padding-right:5px;text-align:left;}")
			.append(".reportdata{width: auto;max-width: 40%;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10px;font-weight: normal;color:#373737;line-height:20px;background-color:#f7f7f7;padding-left:5px;padding-right:5px;text-align:left;}")
			.append(".reporttble{width: 99%;max-width: 100%;border: #c7c7c5 1px solid;}</style></head>")
			.append("<body style=\"margin:0;vertical-align: middle;\" align=\"left\">")
			.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"margin:0;\">")
			.append("<tr> <td height=\"45\" style=\""+bodyLineTopStr+"\"><ul style=\"margin:0;\"><li style=\"margin:0;\">");
			if(travelType.equals("D")){
				strMailMsg.append("<b>Domestic Journey Report (Group/Guest)</b>");
			}else{
				strMailMsg.append("<b>International Journey Report (Group/Guest)</b>");
			}
			strMailMsg.append("</li></ul></td><td align=\"right\" valign=\"bottom\" style=\""+bodyLineTopStr+"\"></td></tr></table>")
			.append("<table width=\"100%\" style=\"padding-left:10px;margin:0;\" border=\"0\" cellpadding=\"5\" cellspacing=\"1\">")
			.append("<tr><td align=\"left\">")
			.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td height=\"0\" colspan=\"6\" align=\"left\" "+reportHeadingStr+">Basic Information of Originator</td></tr>");

			
			if(traveller.getCostCenterName()==null || traveller.getCostCenterName().trim().equals("-")) {
				traveller.setCostCenterName("Not Applicable");
			}


			strMailMsg.append("<tr>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Requisition Number</td>")
			.append("<td height=\"0\" "+reportdataStr+">"+requestInfo.getRequisitionNo()+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Originator</td>")
			.append("<td height=\"0\" "+reportdataStr+">"+originator.getFullName().toUpperCase()+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Originated On</td>")
			.append("<td height=\"0\" "+reportdataStr+" >"+requestInfo.getCreationDate()+"</td>")
			.append("</tr>")
			.append("<tr>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Division</td>")
			.append("<td height=\"0\" "+reportdataStr+">"+requestInfo.getDivisionName()+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Unit</td>")
			.append("<td height=\"0\" "+reportdataStr+">"+originator.getUnitName()+"</td>")
			.append("<td height=\"0\" align=\"right\" "+reportCaptionStr+" >Department</td>")
			.append("<td height=\"0\" "+reportdataStr+" >"+originator.getDepartmentName()+"</td>")
			.append("</tr>")
			.append("<tr>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Designation</td>")
			.append("<td height=\"0\" "+reportdataStr+">"+originator.getDesignationName()+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Contact No.</td>")
			.append("<td height=\"0\" "+reportdataStr+">"+traveller.getContactNo()+"</td>")
			.append("<td height=\"0\" align=\"right\" "+reportCaptionStr+" >Email-Id</td>")
			.append("<td height=\"0\" "+reportdataStr+" >"+traveller.getEmail()+"</td>")
			.append("</tr>")
			.append("<tr>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Cost Centre</td>")
			.append("<td height=\"0\" "+reportdataStr+">"+traveller.getCostCenterName()+"</td>")
			.append("<td height=\"0\" "+reportCaptionStr+" >Reason For Travel</td>")
			.append("<td height=\"0\" colspan=\"3\""+reportdataStr+">"+requestInfo.getReasonForTravel()+"</td>")
			.append("</tr>")
			.append("</table>")
			.append("</td>")
			.append("</tr>");

			// Group/Guest Traveler Detail Section Start		
			logger.info("[getGroupMailBodyForMataIndia] Group/Guest Traveler Detail Section start ---->");
			strMailMsg.append("<tr><td>")
			.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\"> ");
			
			if(travelType.equalsIgnoreCase("D"))
				strMailMsg.append("<tr><td height=\"0\" colspan=\"12\" "+reportHeadingStr+">Guest Travellers Detail</td></tr>");
			if(travelType.equalsIgnoreCase("I"))
				strMailMsg.append("<tr><td height=\"0\" colspan=\"13\" "+reportHeadingStr+">Guest Travellers Detail</td></tr>");
			
			strMailMsg.append("<tr>")
			.append("<td "+reportCaptionStr+" >S No.</td>")
			.append("<td "+reportCaptionStr+" >First Name</td><td "+reportCaptionStr+" >Last Name</td>")
			.append("<td "+reportCaptionStr+" >Designation</td><td "+reportCaptionStr+" >Date of Birth</td>")
			.append("<td "+reportCaptionStr+" >Gender</td><td "+reportCaptionStr+" >Email-Id</td>")
			.append("<td "+reportCaptionStr+" >Employee Id</td><td "+reportCaptionStr+" >Meal Preference</td>")
			.append("<td "+reportCaptionStr+" >Total Amt Required</td>");
			
			if(travelType.equalsIgnoreCase("D")){
				strMailMsg.append("<td "+reportCaptionStr+" >Proof of Identity</td><td "+reportCaptionStr+" >Contact No.</td>")
				.append("</tr>");
			}
			if(travelType.equalsIgnoreCase("I")){
				strMailMsg.append("<td "+reportCaptionStr+" >Passport Number</td><td "+reportCaptionStr+" >Passport Valid upto</td>")
				.append("<td "+reportCaptionStr+" >ECR</td>")
				.append("</tr>");
			}
			
			int recordCount = 1;
			List<User> travellerList = requestInfo.getTravelerList();
			Passport passport = null;
			for(User traveler : travellerList){
				passport = traveler.getPassport();
				strMailMsg.append("<tr>")
				.append("<tr><td "+reportdataStr+" >"+recordCount+"</td>")
				.append("<td "+reportdataStr+" >"+traveler.getFirstName()+"</td><td "+reportdataStr+" >"+traveler.getLastName()+"</td>")
				.append("<td "+reportdataStr+" >"+traveler.getDesignationName()+"</td><td "+reportdataStr+" >"+traveler.getDateOfBirth()+"</td>")
				.append("<td "+reportdataStr+" >"+traveler.getGender()+"</td><td "+reportdataStr+" >"+traveler.getEmail()+"</td>")
				.append("<td "+reportdataStr+" >"+traveler.getEmpCode()+"</td><td "+reportdataStr+" >"+traveler.getMealPreferrence()+"</td>")
				.append("<td "+reportdataStr+" style=\"text-align: right;\">"+traveler.getAmountRequired()+"</td>");
				
				if(travelType.equalsIgnoreCase("D")){
					strMailMsg.append("<td "+reportdataStr+" >"+ traveler.getProofIdentityName() + " - " + traveler.getProofIdentityNumber() +"</td><td "+reportdataStr+" >"+ traveler.getContactNo() +"</td>")
					.append("</tr>");
				}
				
				if(travelType.equalsIgnoreCase("I")){
					strMailMsg.append("<td "+reportdataStr+" >"+passport.getPassportNo()+"</td><td "+reportdataStr+" >"+passport.getDateOfExpiry()+"</td>")
					.append("<td "+reportdataStr+" >"+ passport.getEcr() +"</td>")
					.append("</tr>");
				}
				recordCount++;
			}
			strMailMsg.append("</table>").append("</td></tr>");
			logger.info("[getGroupMailBodyForMataIndia] Group/Guest Traveler Detail Section end.");
			// Group/Guest Traveler Detail Section End
			
			// Itinerary Details Section Start
			logger.info("[getGroupMailBodyForMataIndia] Itinerary Details Section start ---->");
			if (requestInfo.isFlightDetailExist() || requestInfo.isRentA_CarDetailExist() 
					||requestInfo.isTrainDetailExist() || requestInfo.isAccomodationDetailExist()) 
			{
				strMailMsg.append("<tr><td>")
				.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
				.append("<tr><td height=\"0\" colspan=\"10\" "+reportHeadingStr+">Itinerary Information</td></tr>");
				
				if (requestInfo.isFlightDetailExist() || requestInfo.isRentA_CarDetailExist() || requestInfo.isTrainDetailExist())
				{
					List travelDetailsList = new ArrayList();
					TravelDetails travelObj = new TravelDetails();
					String journytypeStr = null;
					String flightRemarks = "";
					String trainRemarks = "";
					String carRemarks = "";
					
					strMailMsg.append("<tr>")
					.append("<td "+reportCaptionStr+" >Journey</td>")
					.append("<td "+reportCaptionStr+" >Departure City</td>")
					.append("<td "+reportCaptionStr+" >Arrival City</td>")
					.append("<td "+reportCaptionStr+" >Departure Date</td>")
					.append("<td "+reportCaptionStr+" >Preferred Time</td>")
					.append("<td "+reportCaptionStr+" >Travel Mode</td>")
					.append("<td "+reportCaptionStr+" >Class</td>")
					.append("<td "+reportCaptionStr+" >Preferred Airline/Train/Cab</td>")
					.append("<td "+reportCaptionStr+" >Preferred Seat</td>")
					.append("<td "+reportCaptionStr+" >Other information</td>");
					
					// Flight Detail Section Start
					logger.info("[getGroupMailBodyForMataIndia] Flight Details Section start ---->");
					if(requestInfo.isFlightDetailExist()){
					
						Flight flightObj = null;
						List flightList = requestInfo.getFlightDetailList();
						
						for (int i = 0; i < flightList.size(); i++) {
							flightObj = (Flight) flightList.get(i);
							travelObj = new TravelDetails();
							
							if (flightObj.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())) {
								journytypeStr = "Onward Journey";
							} else if (flightObj.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())) {
								journytypeStr = "Intermediate Journey";
							} else {
								journytypeStr = "Return Journey";
							}
							
							travelObj.setJourneyType(journytypeStr);
							travelObj.setDepartureCity(flightObj.getDepartureCity());
							travelObj.setArrivalCity(flightObj.getArrivalCity());
							travelObj.setDepartureDate(flightObj.getDepartureDate());
							travelObj.setPreferredTimeType(flightObj.getPreferredTimeType());
							travelObj.setPreferredTime(flightObj.getTiming());
							travelObj.setTravelMode("Flight");
							travelObj.setPreferredClass(flightObj.getTravelClass());
							travelObj.setPreferredCompany(flightObj.getPrefAirline());
							travelObj.setPreferredSeat(flightObj.getWindowSeatPreferrence());
							travelObj.setOtherInfo(" - ");
							travelDetailsList.add(travelObj);
							
							if (flightObj.getRemarks() != null && !flightObj.getRemarks().equals("") && !flightObj.getRemarks().trim().equals("-"))
								flightRemarks = flightObj.getRemarks();
						}	
					}
					logger.info("[getGroupMailBodyForMataIndia] Flight Details Section end.");
					// Flight Detail Section End
					
					// Train Detail Section Start
					logger.info("[getGroupMailBodyForMataIndia] Train Details Section start ---->");
					if (requestInfo.isTrainDetailExist()) {
						Train trainObj = null;
						List trainList = requestInfo.getTrainDetailList();
						
						for (int i = 0; i < trainList.size(); i++) {
							trainObj = (Train) trainList.get(i);
							travelObj = new TravelDetails();	
							if (trainObj.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())) {
								journytypeStr = "Onward Journey";
							} else if (trainObj.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())) {
								journytypeStr = "Intermediate Journey";
							} else {
								journytypeStr = "Return Journey";
							}
							
							travelObj.setJourneyType(journytypeStr);
							travelObj.setDepartureCity(trainObj.getDepartureCity());
							travelObj.setArrivalCity(trainObj.getArrivalCity());
							travelObj.setDepartureDate(trainObj.getDepartureDate());
							travelObj.setPreferredTimeType(trainObj.getPreferredTimeType());
							travelObj.setPreferredTime(trainObj.getTiming());
							travelObj.setTravelMode("Train");
							travelObj.setPreferredClass(trainObj.getTravelClass());
							travelObj.setPreferredCompany(trainObj.getPrefTrain());
							travelObj.setPreferredSeat(trainObj.getSeatPreferrence_1());
							travelObj.setOtherInfo("Tatkaal" + " - " + (journytypeStr.equals("Intermediate Journey") ? "NA" : (trainObj.isTatkaalTicket() ? "Yes" : "No")));
							travelDetailsList.add(travelObj);
							
							if (trainObj.getRemarks() != null && !trainObj.getRemarks().equals("") && !trainObj.getRemarks().trim().equals("-"))
								trainRemarks = trainObj.getRemarks();
						}	
					}
					logger.info("[getGroupMailBodyForMataIndia] Train Details Section end.");
					// Train Detail Section End
					
					// Rent a Car Detail Section Start
					logger.info("[getGroupMailBodyForMataIndia] Rent a Car Details Section start ---->");
					if (requestInfo.isRentA_CarDetailExist())
					{
						Car carObj = null;
						List carList = requestInfo.getCarDetailList();
						
						for (int i = 0; i < carList.size(); i++) {
							carObj = (Car) carList.get(i);
							travelObj = new TravelDetails();
								
							if (carObj.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())) {
								journytypeStr = "Onward Journey";
							} else if (carObj.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())) {
								journytypeStr = "Intermediate Journey";
							} else {
								journytypeStr = "Return Journey";
							}
							
							travelObj.setJourneyType(journytypeStr);
							travelObj.setDepartureCity(carObj.getStartCity());
							travelObj.setArrivalCity(carObj.getEndCity());
							travelObj.setDepartureDate(carObj.getStartDate());
							travelObj.setPreferredTimeType(carObj.getPreferredTimeType());
							travelObj.setPreferredTime(carObj.getTiming());
							travelObj.setTravelMode("Car");
							travelObj.setPreferredClass(carObj.getCarClass());
							travelObj.setPreferredCompany(carObj.getPrefCar());
							travelObj.setPreferredSeat(carObj.getStartLocation());
							travelObj.setOtherInfo("Mobile No." + " - " + carObj.getStartMobileNo());
							travelDetailsList.add(travelObj);
							
							if (carObj.getRemarks() != null	&& !carObj.getRemarks().equals("") && !carObj.getRemarks().trim().equals("-"))
								carRemarks = carObj.getRemarks();
						}	
					}	
					logger.info("[getGroupMailBodyForMataIndia] Rent a Car Details Section end.");
					// Rent a Car Detail Section End
					
					Collections.sort(travelDetailsList);
					for(int listCounter = 0; listCounter < travelDetailsList.size(); listCounter++)
					{
						TravelDetails tempTravelObj = (TravelDetails) travelDetailsList.get(listCounter);
						
						if(listCounter == 0)
						{	tempTravelObj.setJourneyType("Onward Journey");
						}
						else if(listCounter == travelDetailsList.size()-1)
						{
							tempTravelObj.setJourneyType("Return Journey");
						}
						else
						{
							tempTravelObj.setJourneyType("Intermediate Journey");
						}
					}
					ListIterator<TravelDetails> travelDetailsListIterator = travelDetailsList.listIterator();
					while(travelDetailsListIterator.hasNext())
					{	
						TravelDetails iterTravelObj = (TravelDetails) travelDetailsListIterator.next();
						strMailMsg.append("<tr>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getJourneyType()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getDepartureCity()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getArrivalCity()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getDepartureDate()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getPreferredTimeType() + " "+ iterTravelObj.getPreferredTime()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getTravelMode()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getPreferredClass()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getPreferredCompany()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getPreferredSeat()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getOtherInfo()+"</td>")
						.append("</tr>");
					}
					
					if(!flightRemarks.equals("")) {
						strMailMsg.append("<tr>")
						.append("<td "+reportCaptionStr+" >Flight Remarks</td><td "+reportdataStr+" colspan=\"9\">"+flightRemarks+"</td>")
						.append("</tr>");
					}
					if(!trainRemarks.equals("")) {
						strMailMsg.append("<tr>")
						.append("<td "+reportCaptionStr+" >Train Remarks</td><td "+reportdataStr+" colspan=\"9\">"+trainRemarks+"</td>")
						.append("</tr>");
					}
					if(!carRemarks.equals("")) {
						strMailMsg.append("<tr>")
						.append("<td "+reportCaptionStr+" >Car Remarks</td><td "+reportdataStr+" colspan=\"9\">"+carRemarks+"</td>")
						.append("</tr>");
					}
				}
				
				// Accommodation Detail Section Start
				logger.info("[getGroupMailBodyForMataIndia] Accommodation a Car Details Section start ---->");
				if(requestInfo.isAccomodationDetailExist()){
					List<Accommodation> accommodationList = requestInfo.getAccommodationList();
					Accommodation accommodation = null;
					
					if (accommodationList != null && !accommodationList.isEmpty()) {
						strMailMsg.append("<tr><td height=\"0\" colspan=\"10\" "+reportSubHeadingStr+">Accommodation</td></tr>")
						.append("<tr><td "+reportCaptionStr+" >##</td>")
						.append("<td "+reportCaptionStr+" >Stay Type</td><td "+reportCaptionStr+" >Currency</td>")
						.append("<td "+reportCaptionStr+" >Budget</td>")
						.append("<td "+reportCaptionStr+" colspan=\"2\" >Check In Date</td>")
						.append("<td "+reportCaptionStr+" colspan=\"2\" >Check Out Date</td>")
						.append("<td "+reportCaptionStr+" colspan=\"2\" >Preferred Place</td>")
						.append("</tr>");
		
						for(int i=0; i<accommodationList.size(); i++){
							accommodation = (Accommodation)accommodationList.get(i);
		
							strMailMsg.append("<tr><td "+reportdataStr+" >"+(i+1)+"</td>")
							.append("<td "+reportdataStr+" >"+accommodation.getAccommodationType()+"</td>")
							.append("<td "+reportdataStr+" >"+accommodation.getCurrency()+"</td>")
							.append("<td "+reportdataStr+" >"+accommodation.getBudget()+"</td>")
							.append("<td "+reportdataStr+" colspan=\"2\" >"+accommodation.getCheckInDate()+"</td>")
							.append("<td "+reportdataStr+" colspan=\"2\" >"+accommodation.getCheckOutDate()+"</td>")
							.append("<td "+reportdataStr+" colspan=\"2\" >"+accommodation.getPlaceOfVisit()+"</td>")
							.append("</tr>");
						}
						if(!checkNullEmpty(accommodation.getRemarks()) && !accommodation.getRemarks().trim().equals("-")) {
							strMailMsg.append("<tr><td "+reportCaptionStr+" >Remarks</td><td "+reportdataStr+"  colspan=\"9\">"+accommodation.getRemarks()+"</td></tr>");
						}
					}
				}
				logger.info("[getGroupMailBodyForMataIndia] Accommodation a Car Details Section end.");
				// Accommodation Detail Section End
				strMailMsg.append("</table></td></tr>");
			}
			logger.info("[getGroupMailBodyForMataIndia] Itinerary Details Section end.");
			// Itinerary Details Section End
			
			// Advance/Expense Detail Section Start
			logger.info("[getGroupMailBodyForMataIndia] Advance/Expense Detail Section start ---->");
			List <AdvanceForex> advanceForexList = requestInfo.getAdvanceForexList();
			if (advanceForexList != null && !advanceForexList.isEmpty() && advanceForexList.size() > 0) {
				strMailMsg.append("<tr><td>")
				.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\"> ");
				if(travelType.equalsIgnoreCase("D"))
					strMailMsg.append("<tr><td height=\"0\" colspan=\"14\" "+reportHeadingStr+">Advance Required</td></tr>");
				if(travelType.equalsIgnoreCase("I"))
					strMailMsg.append("<tr><td height=\"0\" colspan=\"14\" "+reportHeadingStr+">Forex Details</td></tr>");
				
				strMailMsg.append("<tr>")
				.append("<td "+reportCaptionStr+" rowspan=\"2\" nowrap=\"nowrap\">S No.</td>")
				.append("<td "+reportCaptionStr+" rowspan=\"2\" >Traveller Name</td><td "+reportCaptionStr+" rowspan=\"2\" >Currency</td>")
				.append("<td "+reportCaptionStr+" colspan=\"3\" >Daily Allowances</td><td "+reportCaptionStr+" colspan=\"3\" >Hotel Charges</td>")
				.append("<td "+reportCaptionStr+" rowspan=\"2\" >Contingencies<br>(C)</td><td "+reportCaptionStr+" rowspan=\"2\" >Others<br>(D)</td>")
				.append("<td "+reportCaptionStr+" rowspan=\"2\" >Total<br>(A+B+C+D)</td><td "+reportCaptionStr+" rowspan=\"2\" >Total Amount</td>")
				.append("<td "+reportCaptionStr+" rowspan=\"2\" >Remarks for Contigencies/Any other Expenditure</td>")
				.append("</tr>");

				strMailMsg.append("<tr>")
				.append("<td "+reportCaptionStr+" nowrap=\"nowrap\">Exp/Day</td>")
				.append("<td "+reportCaptionStr+" >Day(s)</td><td "+reportCaptionStr+" >Total<br>(A)</td>")
				.append("<td "+reportCaptionStr+" nowrap=\"nowrap\">Exp/Day</td>")
				.append("<td "+reportCaptionStr+" >Day(s)</td><td "+reportCaptionStr+" >Total<br>(B)</td>")
				.append("</tr>");
					
				AdvanceForex advanceForex = null;
				for (int i = 0; i < advanceForexList.size(); i++) {
					advanceForex = (AdvanceForex) advanceForexList.get(i);
					strMailMsg.append("<tr>")
					.append("<td "+reportdataStr+" nowrap=\"nowrap\">"+ (i + 1) +"</td>")
					.append("<td "+reportdataStr+" >"+ advanceForex.getTravellerName() +"</td><td "+reportdataStr+" >"+ advanceForex.getAdvCurrency() +"</td>")
					.append("<td "+reportdataStr+" style=\"text-align: right;\">"+ advanceForex.getExpensePerDay1() +"</td><td "+reportdataStr+" style=\"text-align: right;\">"+ advanceForex.getNumOfDays1() +"</td>")
					.append("<td "+reportCaptionStr+" style=\"text-align: right;\">"+ advanceForex.getTotalExpense1() +"</td><td "+reportdataStr+" style=\"text-align: right;\">"+ advanceForex.getExpensePerDay2() +"</td>")
					.append("<td "+reportdataStr+" style=\"text-align: right;\">"+ advanceForex.getNumOfDays2() +"</td><td "+reportCaptionStr+" style=\"text-align: right;\">"+ advanceForex.getTotalExpense2() +"</td>")
					.append("<td "+reportCaptionStr+" style=\"text-align: right;\">"+ advanceForex.getContingencyExpense() +"</td><td "+reportCaptionStr+" style=\"text-align: right;\">"+ advanceForex.getOtherExpense() +"</td>")
					.append("<td "+reportCaptionStr+" style=\"text-align: right;\">"+ advanceForex.getTotalExpenditure() +"</td><td "+reportCaptionStr+" style=\"text-align: right;\">"+ advanceForex.getTotalAdvanceINR() +"</td>")
					.append("<td "+reportdataStr+" style=\"text-align: right;\">"+ advanceForex.getAdvRemarks() +"</td>")
					.append("</tr>");
				}
				strMailMsg.append("</table></td></tr>");
			}
			logger.info("[getGroupMailBodyForMataIndia] Advance/Expense Detail Section end.");
			// Advance/Expense Detail Section End
			
			// Total Travel Fare Section Start
			logger.info("[getGroupMailBodyForMataIndia] Total Travel Fare Section start ---->");
			if(travelType.equalsIgnoreCase("I") && requestInfo.isTravelFareDetailExist()){
				TravelFare travelFare = requestInfo.getTravelFare();
				if(travelFare != null){
					strMailMsg.append("<tr><td>")
					.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
					.append("<tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+" >Total Travel Fare</td></tr>");
	
					strMailMsg.append("<tr><td height=\"0\" "+reportCaptionStr+" >Currency</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+travelFare.getFareCurrency()+"</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Total Fare</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+travelFare.getFareAmount()+"</td></tr>");					
									
					strMailMsg.append("</table></td></tr>");
				}
			}
			logger.info("[getGroupMailBodyForMataIndia] Total Travel Fare Section end.");
			// Total Travel Fare Section End
			
			// Budget Actual Details Section Start
			logger.info("[getGroupMailBodyForMataIndia] Budget Actual Details Section start ---->");
			if(requestInfo.isBudgetActualDetailExist()){
				BudgetActual budgetActual = requestInfo.getBudgetActual();
				if(budgetActual != null){
					strMailMsg.append("<tr><td>")
					.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
					.append("<tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+" >Budget Actual Details</td></tr>");
	
					strMailMsg.append("<tr><td height=\"0\" "+reportCaptionStr+" >YTM Budget</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+budgetActual.getYtmBudget()+"</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >YTD Actual</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+budgetActual.getYtdActual()+"</td></tr>");
					
					strMailMsg.append("<tr><td height=\"0\" "+reportCaptionStr+" >Available Budget</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+budgetActual.getAvailBudget()+"</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Estimate</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+budgetActual.getEstExp()+"</td></tr>");
					
					strMailMsg.append("<tr><td height=\"0\" "+reportCaptionStr+" >Remarks</td>")
					.append("<td height=\"0\" "+reportdataStr+" colspan=\"3\">"+budgetActual.getExpRemarks()+"</td></tr>");
									
					strMailMsg.append("</table></td></tr>");
				}
			}
			logger.info("[getGroupMailBodyForMataIndia] Budget Actual Details Section end.");
			// Budget Actual Details Section End
			
			// Billing Instruction & Approver Level Section Start
			logger.info("[getGroupMailBodyForMataIndia] Billing Instruction & Approver Level Section start ---->");
			Approver billingApprover = requestInfo.getBillingApprover();
			List<Approver> approverLevelList = requestInfo.getApproverLevels();
			
			if(billingApprover != null || (approverLevelList != null && !approverLevelList.isEmpty() && (approverLevelList.size() == 3))){
				strMailMsg.append("<tr><td>")
				.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
				.append("<tr><td height=\"0\" colspan=\"4\" "+reportHeadingStr+" >Billing Instructions and Approvers</td></tr>");
				
				// Billing Instruction Section Start	
				if(billingApprover != null){
					strMailMsg.append("<tr>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Billing Client</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+billingApprover.getUnitName()+"</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Billing Approver</td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+billingApprover.getName()+"</td>")
					.append("</tr>");
				}
				// Billing Instruction Section End
	
				// Approval Level Section Start
				
				if(approverLevelList != null && !approverLevelList.isEmpty() && (approverLevelList.size() == 3)){
					strMailMsg.append("<tr>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Approval Level 1 </td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+("-".equals(approverLevelList.get(0).getName()) ? "Not Applicable" : approverLevelList.get(0).getName())+"</td>")
					.append("<td height=\"0\" "+reportCaptionStr+" >Approval Level 2 </td>")
					.append("<td height=\"0\" "+reportdataStr+" >"+("-".equals(approverLevelList.get(1).getName()) ? "Not Applicable" : approverLevelList.get(1).getName())+"</td>")
					.append("</tr>");
					
					if(!"-".equals(approverLevelList.get(2).getName())) {
						strMailMsg.append("<tr>")
						.append("<td height=\"0\" "+reportCaptionStr+" >Board Member</td>")
						.append("<td height=\"0\" colspan=\"3\" "+reportdataStr+" >"+("-".equals(approverLevelList.get(2).getName()) ? "Not Applicable" : approverLevelList.get(2).getName())+"</td>")
						.append("</tr>");
					}
				}
				// Approval Level Section End
				
				strMailMsg.append("</table></td></tr>");
			}
			logger.info("[getGroupMailBodyForMataIndia] Billing Instruction & Approver Level Section end.");
			// Billing Instruction & Approver Level Section End

			// Approval List Section Start
			logger.info("[getGroupMailBodyForMataIndia] Approval List Section start ---->");
			List<Approver> approverList = requestInfo.getApprovers();
			strMailMsg.append("<tr><td>")
			.append("<table width=\"100%\" align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
			.append("<tr><td colspan=\"5\" "+reportHeadingStr+" >Approvers List</td></tr>")
			.append("<tr><td  "+reportCaptionStr+" nowrap=\"nowrap\">S No.</td>")
			.append("<td "+reportCaptionStr+">Name</td><td "+reportCaptionStr+">Designation</td>")
			.append("<td "+reportCaptionStr+">Status</td><td "+reportCaptionStr+">Approval Date Time</td></tr>");

			int approverRowCount = 1;
			if(approverList != null && !approverList.isEmpty()){
				for(Approver workflowApp : approverList){
					String apprvTime = (workflowApp.getApproveTime() == null || workflowApp.getApproveTime().trim().equals("")) ? "": "  "+workflowApp.getApproveTime().trim();
					
					strMailMsg.append("<tr><td  "+reportdataStr+" style=\"text-align: center;\">"+approverRowCount+"</td>")
					.append("<td "+reportdataStr+">"+workflowApp.getName()+"</td><td "+reportdataStr+">"+workflowApp.getDesignationName()+"</td>")
					.append("<td "+reportdataStr+">"+("10".equals(workflowApp.getApproveStatus()) ? "Approved" : "Pending")+"</td>")
					.append("<td "+reportdataStr+">"+workflowApp.getApproveDate().trim()+apprvTime+"</td></tr>");
					approverRowCount++;
				}
			}
			strMailMsg.append("</table></td></tr>");
			logger.info("[getGroupMailBodyForMataIndia] Approval List Section end.");
			// Approval List Section End
			
			strMailMsg.append("</table><br/><br/><b>Best Regards,</b><br/>STARS Admin</body></html>");
			logger.info("[getGroupMailBodyForMataIndia] method body end.");

			return strMailMsg.toString();
		}
		
		
		public String customizeApproverMailBodyIndia(String travelId, String travelType, String travellerId, String strGroupTravelFlag){
			
			logger.setLevel(Level.ALL);
			logger.info("[customizeApproverMailBodyIndia] method body start ---->");
			StringBuilder strMailMsg = new StringBuilder();
			TravelRequest requestInfo = getTravelRequestDetailIndia(travelId,travelType,travellerId);

			String reporttbleStr = "align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" style=\"width: 99%;max-width: 100%;border: #c7c7c5 1px solid;\" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\"";
			String reportHeadingStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:12px;font-weight:bold;color:#ffffff;line-height:22px;background-color:#aa1220;padding-left:5px;text-align:left;\"";
			String reportSubHeadingStr = "style=\"font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;font-weight:bold;color:#000000;line-height:20px;background-color:#dddddd;padding-left:5px;text-align:left;\"";
			String reportCaptionStr = "style=\"width: auto; max-width: 40%;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10px;font-weight:bold;color:#1d1d1d;line-height:20px;background-color:#f2f2f2;padding-left:5px;padding-right:5px;text-align:left;\"";
			String reportdataStr = "style=\"width: auto; max-width: 40%;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10px;font-weight: normal;color:#373737;line-height:20px;background-color:#f7f7f7;padding-left:5px;padding-right:5px;text-align:left;\"";

			strMailMsg.append("<div><table width=\"100%\">\n");
			
			if(strGroupTravelFlag!= null  &&  (strGroupTravelFlag.trim().equalsIgnoreCase("Y"))) {
				// Group/Guest Traveler Detail Section Start
				logger.info("[customizeApproverMailBodyIndia] Group/Guest Traveler Detail Section start ---->");
				strMailMsg.append("<tr><td>")
				.append("<table "+reporttbleStr+">");
				
				if(travelType.equalsIgnoreCase("D"))
					strMailMsg.append("<tr><td height=\"0\" colspan=\"10\" "+reportHeadingStr+">Guest Travellers Detail</td></tr>");
				if(travelType.equalsIgnoreCase("I"))
					strMailMsg.append("<tr><td height=\"0\" colspan=\"11\" "+reportHeadingStr+">Guest Travellers Detail</td></tr>");
				
				strMailMsg.append("<tr>")
				.append("<td "+reportCaptionStr+" >S No.</td>")
				.append("<td "+reportCaptionStr+" >First Name</td><td "+reportCaptionStr+" >Last Name</td>")
				.append("<td "+reportCaptionStr+" >Designation</td><td "+reportCaptionStr+" >Date of Birth</td>")
				.append("<td "+reportCaptionStr+" >Gender</td><td "+reportCaptionStr+" >Meal Preference</td>")
				.append("<td "+reportCaptionStr+" >Total Amt Required</td>");
				
				if(travelType.equalsIgnoreCase("D")){
					strMailMsg.append("<td "+reportCaptionStr+" >Proof of Identity</td><td "+reportCaptionStr+" >Contact No.</td>")
					.append("</tr>");
				}
				if(travelType.equalsIgnoreCase("I")){
					strMailMsg.append("<td "+reportCaptionStr+" >Passport Number</td><td "+reportCaptionStr+" >Passport Valid upto</td>")
					.append("<td "+reportCaptionStr+" >ECR</td>")
					.append("</tr>");
				}
				
				int recordCount = 1;
				List<User> travellerList = requestInfo.getTravelerList();
				Passport passport = null;
				for(User traveler : travellerList){
					passport = traveler.getPassport();
					strMailMsg.append("<tr>")
					.append("<tr><td "+reportdataStr+" >"+recordCount+"</td>")
					.append("<td "+reportdataStr+" >"+traveler.getFirstName()+"</td><td "+reportdataStr+" >"+traveler.getLastName()+"</td>")
					.append("<td "+reportdataStr+" >"+traveler.getDesignationName()+"</td><td "+reportdataStr+" >"+traveler.getDateOfBirth()+"</td>")
					.append("<td "+reportdataStr+" >"+traveler.getGender()+"</td><td "+reportdataStr+" >"+traveler.getMealPreferrence()+"</td>")
					.append("<td "+reportdataStr+" style=\"text-align: right;\">"+traveler.getAmountRequired()+"</td>");
					
					if(travelType.equalsIgnoreCase("D")){
						strMailMsg.append("<td "+reportdataStr+" >"+ traveler.getProofIdentityName() + " - " + traveler.getProofIdentityNumber() +"</td><td "+reportdataStr+" >"+ traveler.getContactNo() +"</td>")
						.append("</tr>");
					}
					
					if(travelType.equalsIgnoreCase("I")){
						strMailMsg.append("<td "+reportdataStr+" >"+passport.getPassportNo()+"</td><td "+reportdataStr+" >"+passport.getDateOfExpiry()+"</td>")
						.append("<td "+reportdataStr+" >"+ passport.getEcr() +"</td>")
						.append("</tr>");
					}
					recordCount++;
				}
				strMailMsg.append("</table>").append("</td></tr>");
				logger.info("[customizeApproverMailBodyIndia] Group/Guest Traveler Detail Section end.");
				// Group/Guest Traveler Detail Section End
			}
			
			// Itinerary Details Section Start
			logger.info("[customizeApproverMailBodyIndia] Itinerary Details Section start ---->");
			if (requestInfo.isFlightDetailExist() || requestInfo.isRentA_CarDetailExist() 
					||requestInfo.isTrainDetailExist() || requestInfo.isAccomodationDetailExist()) 
			{
				strMailMsg.append("<tr><td>")
				.append("<table align=\"left\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" "+reporttbleStr+" bordercolor=\"#c7c7c5\" style=\"border-collapse: collapse;margin:0;\">")
				.append("<tr><td height=\"0\" colspan=\"10\" "+reportHeadingStr+">Itinerary Information</td></tr>");
				
				if (requestInfo.isFlightDetailExist() || requestInfo.isRentA_CarDetailExist() || requestInfo.isTrainDetailExist())
				{
					List travelDetailsList = new ArrayList();
					TravelDetails travelObj = new TravelDetails();
					String journytypeStr = null;
					String flightRemarks = "";
					String trainRemarks = "";
					String carRemarks = "";
					
					strMailMsg.append("<tr>")
					.append("<td "+reportCaptionStr+" >Journey</td>")
					.append("<td "+reportCaptionStr+" >Departure City</td>")
					.append("<td "+reportCaptionStr+" >Arrival City</td>")
					.append("<td "+reportCaptionStr+" >Departure Date</td>")
					.append("<td "+reportCaptionStr+" >Preferred Time</td>")
					.append("<td "+reportCaptionStr+" >Travel Mode</td>")
					.append("<td "+reportCaptionStr+" >Class</td>")
					.append("<td "+reportCaptionStr+" >Preferred Airline/Train/Cab</td>")
					.append("<td "+reportCaptionStr+" >Preferred Seat</td>")
					.append("<td "+reportCaptionStr+" >Other information</td>");
					
					// Flight Detail Section Start
					logger.info("[customizeApproverMailBodyIndia] Flight Details Section start ---->");
					if(requestInfo.isFlightDetailExist()){
					
						Flight flightObj = null;
						List flightList = requestInfo.getFlightDetailList();
						
						for (int i = 0; i < flightList.size(); i++) {
							flightObj = (Flight) flightList.get(i);
							travelObj = new TravelDetails();
							
							if (flightObj.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())) {
								journytypeStr = "Onward Journey";
							} else if (flightObj.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())) {
								journytypeStr = "Intermediate Journey";
							} else {
								journytypeStr = "Return Journey";
							}
							
							travelObj.setJourneyType(journytypeStr);
							travelObj.setDepartureCity(flightObj.getDepartureCity());
							travelObj.setArrivalCity(flightObj.getArrivalCity());
							travelObj.setDepartureDate(flightObj.getDepartureDate());
							travelObj.setPreferredTimeType(flightObj.getPreferredTimeType());
							travelObj.setPreferredTime(flightObj.getTiming());
							travelObj.setTravelMode("Flight");
							travelObj.setPreferredClass(flightObj.getTravelClass());
							travelObj.setPreferredCompany(flightObj.getPrefAirline());
							travelObj.setPreferredSeat(flightObj.getWindowSeatPreferrence());
							travelObj.setOtherInfo(" - ");
							travelDetailsList.add(travelObj);
							
							if (flightObj.getRemarks() != null && !flightObj.getRemarks().equals("") && !flightObj.getRemarks().trim().equals("-"))
								flightRemarks = flightObj.getRemarks();
						}	
					}
					logger.info("[customizeApproverMailBodyIndia] Flight Details Section end.");
					// Flight Detail Section End
					
					// Train Detail Section Start
					logger.info("[customizeApproverMailBodyIndia] Train Details Section start ---->");
					if (requestInfo.isTrainDetailExist()) {
						Train trainObj = null;
						List trainList = requestInfo.getTrainDetailList();
						
						for (int i = 0; i < trainList.size(); i++) {
							trainObj = (Train) trainList.get(i);
							travelObj = new TravelDetails();	
							if (trainObj.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())) {
								journytypeStr = "Onward Journey";
							} else if (trainObj.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())) {
								journytypeStr = "Intermediate Journey";
							} else {
								journytypeStr = "Return Journey";
							}
							
							travelObj.setJourneyType(journytypeStr);
							travelObj.setDepartureCity(trainObj.getDepartureCity());
							travelObj.setArrivalCity(trainObj.getArrivalCity());
							travelObj.setDepartureDate(trainObj.getDepartureDate());
							travelObj.setPreferredTimeType(trainObj.getPreferredTimeType());
							travelObj.setPreferredTime(trainObj.getTiming());
							travelObj.setTravelMode("Train");
							travelObj.setPreferredClass(trainObj.getTravelClass());
							travelObj.setPreferredCompany(trainObj.getPrefTrain());
							travelObj.setPreferredSeat(trainObj.getSeatPreferrence_1());
							travelObj.setOtherInfo("Tatkaal" + " - " + (journytypeStr.equals("Intermediate Journey") ? "NA" : (trainObj.isTatkaalTicket() ? "Yes" : "No")));
							travelDetailsList.add(travelObj);
							
							if (trainObj.getRemarks() != null && !trainObj.getRemarks().equals("") && !trainObj.getRemarks().trim().equals("-"))
								trainRemarks = trainObj.getRemarks();
						}	
					}
					logger.info("[customizeApproverMailBodyIndia] Train Details Section end.");
					// Train Detail Section End
					
					// Rent a Car Detail Section Start
					logger.info("[customizeApproverMailBodyIndia] Rent a Car Details Section start ---->");
					if (requestInfo.isRentA_CarDetailExist())
					{
						Car carObj = null;
						List carList = requestInfo.getCarDetailList();
						
						for (int i = 0; i < carList.size(); i++) {
							carObj = (Car) carList.get(i);
							travelObj = new TravelDetails();
								
							if (carObj.getJournyType().equals(TravelRequestEnums.JournyType.FORWARD.getId())) {
								journytypeStr = "Onward Journey";
							} else if (carObj.getJournyType().equals(TravelRequestEnums.JournyType.INTERMEDIATE.getId())) {
								journytypeStr = "Intermediate Journey";
							} else {
								journytypeStr = "Return Journey";
							}
							
							travelObj.setJourneyType(journytypeStr);
							travelObj.setDepartureCity(carObj.getStartCity());
							travelObj.setArrivalCity(carObj.getEndCity());
							travelObj.setDepartureDate(carObj.getStartDate());
							travelObj.setPreferredTimeType(carObj.getPreferredTimeType());
							travelObj.setPreferredTime(carObj.getTiming());
							travelObj.setTravelMode("Car");
							travelObj.setPreferredClass(carObj.getCarClass());
							travelObj.setPreferredCompany(carObj.getPrefCar());
							travelObj.setPreferredSeat(carObj.getStartLocation());
							travelObj.setOtherInfo("Mobile No." + " - " + carObj.getStartMobileNo());
							travelDetailsList.add(travelObj);
							
							if (carObj.getRemarks() != null	&& !carObj.getRemarks().equals("") && !carObj.getRemarks().trim().equals("-"))
								carRemarks = carObj.getRemarks();
						}	
					}
					logger.info("[customizeApproverMailBodyIndia] Rent a Car Details Section end.");	
					// Rent a Car Detail Section End
					
					Collections.sort(travelDetailsList);
					for(int listCounter = 0; listCounter < travelDetailsList.size(); listCounter++)
					{
						TravelDetails tempTravelObj = (TravelDetails) travelDetailsList.get(listCounter);
						
						if(listCounter == 0)
						{	tempTravelObj.setJourneyType("Onward Journey");
						}
						else if(listCounter == travelDetailsList.size()-1)
						{
							tempTravelObj.setJourneyType("Return Journey");
						}
						else
						{
							tempTravelObj.setJourneyType("Intermediate Journey");
						}
					}
					ListIterator<TravelDetails> travelDetailsListIterator = travelDetailsList.listIterator();
					while(travelDetailsListIterator.hasNext())
					{	
						TravelDetails iterTravelObj = (TravelDetails) travelDetailsListIterator.next();
						strMailMsg.append("<tr>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getJourneyType()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getDepartureCity()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getArrivalCity()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getDepartureDate()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getPreferredTimeType() + " "+ iterTravelObj.getPreferredTime()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getTravelMode()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getPreferredClass()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getPreferredCompany()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getPreferredSeat()+"</td>")
						.append("<td "+reportdataStr+" >"+iterTravelObj.getOtherInfo()+"</td>")
						.append("</tr>");
					}
					
					if(!flightRemarks.equals("")) {
						strMailMsg.append("<tr>")
						.append("<td "+reportCaptionStr+" >Flight Remarks</td><td "+reportdataStr+" colspan=\"9\">"+flightRemarks+"</td>")
						.append("</tr>");
					}
					if(!trainRemarks.equals("")) {
						strMailMsg.append("<tr>")
						.append("<td "+reportCaptionStr+" >Train Remarks</td><td "+reportdataStr+" colspan=\"9\">"+trainRemarks+"</td>")
						.append("</tr>");
					}
					if(!carRemarks.equals("")) {
						strMailMsg.append("<tr>")
						.append("<td "+reportCaptionStr+" >Car Remarks</td><td "+reportdataStr+" colspan=\"9\">"+carRemarks+"</td>")
						.append("</tr>");
					}
				}
				
				// Accommodation Detail Section Start
				logger.info("[customizeApproverMailBodyIndia] Accommodation Details Section start ---->");
				if(requestInfo.isAccomodationDetailExist()){
					List<Accommodation> accommodationList = requestInfo.getAccommodationList();
					Accommodation accommodation = null;
					
					if (accommodationList != null && !accommodationList.isEmpty()) {
						strMailMsg.append("<tr><td height=\"0\" colspan=\"10\" "+reportSubHeadingStr+">Accommodation</td></tr>")
						.append("<tr><td "+reportCaptionStr+" >##</td>")
						.append("<td "+reportCaptionStr+" >Stay Type</td><td "+reportCaptionStr+" >Currency</td>")
						.append("<td "+reportCaptionStr+" >Budget</td>")
						.append("<td "+reportCaptionStr+" colspan=\"2\" >Check In Date</td>")
						.append("<td "+reportCaptionStr+" colspan=\"2\" >Check Out Date</td>")
						.append("<td "+reportCaptionStr+" colspan=\"2\" >Preferred Place</td>")
						.append("</tr>");
		
						for(int i=0; i<accommodationList.size(); i++){
							accommodation = (Accommodation)accommodationList.get(i);
		
							strMailMsg.append("<tr><td "+reportdataStr+" >"+(i+1)+"</td>")
							.append("<td "+reportdataStr+" >"+accommodation.getAccommodationType()+"</td>")
							.append("<td "+reportdataStr+" >"+accommodation.getCurrency()+"</td>")
							.append("<td "+reportdataStr+" >"+accommodation.getBudget()+"</td>")
							.append("<td "+reportdataStr+" colspan=\"2\" >"+accommodation.getCheckInDate()+"</td>")
							.append("<td "+reportdataStr+" colspan=\"2\" >"+accommodation.getCheckOutDate()+"</td>")
							.append("<td "+reportdataStr+" colspan=\"2\" >"+accommodation.getPlaceOfVisit()+"</td>")
							.append("</tr>");
						}
						if(!checkNullEmpty(accommodation.getRemarks()) && !accommodation.getRemarks().trim().equals("-")) {
							strMailMsg.append("<tr><td "+reportCaptionStr+" >Remarks</td><td "+reportdataStr+"  colspan=\"9\">"+accommodation.getRemarks()+"</td></tr>");
						}
					}
				}
				logger.info("[customizeApproverMailBodyIndia] Accommodation Details Section end.");
				// Accommodation Detail Section End
				strMailMsg.append("</table></td></tr>");
			}	
			logger.info("[customizeApproverMailBodyIndia] Itinerary Details Section end.");
			// Itinerary Details Section End
			
			strMailMsg.append("</table></div>\n" );
			logger.info("[customizeApproverMailBodyIndia] method body end.");
			return strMailMsg.toString();
		}
	
}
