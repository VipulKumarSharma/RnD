

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.PageOrientation;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCell;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;


import src.connection.DbConnectionBean;
import src.dao.starDaoImpl;

/**
 * Servlet implementation class ExportBookingStatusReport
 */
public class ExportBookingStatusReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExportBookingStatusReport() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		//response.setContentType("application/vnd.ms-excel");//msword
		
		Date currentDate = new Date();
		DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		String currntDateStr = format.format(currentDate);
		Boolean dataExistsFlag = false;
		
		try {
			String action = request.getParameter("action");
			String siteId = request.getParameter("siteId") == null ? "0" : request.getParameter("siteId");
			String reqNo = request.getParameter("reqNo") == null ? "" : request.getParameter("reqNo");
			String travelDateStr = (request.getParameter("date") != null && !"".equals(request.getParameter("date"))) ?dateFormatter(request.getParameter("date"),"dd/MM/yyyy","yyyy-MM-dd") : dateFormatter(currntDateStr,"dd/MM/yyyy","yyyy-MM-dd") ;
			String travelType = request.getParameter("travelType") == null ? "I" : request.getParameter("travelType");
			String travellerId = request.getParameter("travellerId") == null ? "0" : request.getParameter("travellerId");
			String bookingStatus = (request.getParameter("status") == null || "".equals(request.getParameter("status"))) ? "0" : request.getParameter("status");
			String bookedBy = (request.getParameter("bookedBy") == null || "".equals(request.getParameter("bookedBy"))) ? "0" : request.getParameter("bookedBy");
			String reportType = (request.getParameter("reportType") == null || "".equals(request.getParameter("reportType"))) ? "IBR" : request.getParameter("reportType");
			String selectedReportType = (request.getParameter("selectedReportType") == null || "".equals(request.getParameter("selectedReportType"))) ? "" : request.getParameter("selectedReportType");
			HttpSession hs = request.getSession();
			String travelAgency =  (hs.getValue("isMataGmbHSite") == null && "true".equals(hs.getValue("isMataGmbHSite"))) ? "2" : "1";
			String loginUser = hs.getValue("user_id") == null ? "1" : (String)hs.getValue("user_id");
			
			String travelStatus = (request.getParameter("travelStatus") == null || "".equals(request.getParameter("travelStatus"))) ? "10" : request.getParameter("travelStatus");
			
			starDaoImpl starDaoImpl = new starDaoImpl(); 
			
			if(action.equals("exportToExcel")) {
				HashMap<String,Object> dataList = starDaoImpl.getBookingReportExcel(siteId, reqNo, travelDateStr, travelType, travellerId, bookingStatus,bookedBy, travelAgency, loginUser, reportType,travelStatus);
				
				try {
					 
				ArrayList<String> colList =	(ArrayList<String>)dataList.get("colName");
				ResultSet colValue =	(ResultSet)dataList.get("colValue");
				
		            int counter = 1;
		 
		            WorkbookSettings wbSettings = new WorkbookSettings();
					wbSettings.setLocale(new Locale("en", "EN"));
					
					String fileName = "";
					if(selectedReportType.trim().equals("") || selectedReportType == null) {
						fileName = "Booking Status Report";
					} else {
						fileName = selectedReportType;
					}
					response.setContentType("application/vnd.ms-excel");
				   	response.setHeader("Content-Disposition", "attachment; filename="+fileName+"_"+currntDateStr+".xls");
				   	
				   	WritableWorkbook workbook = Workbook.createWorkbook(response.getOutputStream());

					workbook.createSheet(fileName, 0);
					
					WritableSheet excelSheet = workbook.getSheet(0);
					excelSheet.setPageSetup(PageOrientation.LANDSCAPE);
		
		            //Set Header		 
		            String Header[] = new String[colValue.getMetaData().getColumnCount()];
		           Iterator itr = colList.iterator();
		           int count=0;
		           while(itr.hasNext())
		           {
		        	   Header[count] = itr.next().toString();
		        	   count++;
		           }
		          
		 
		            WritableFont wfobjHD = new WritableFont(WritableFont.TAHOMA, 10, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
		            WritableFont wfobjHD1 = new WritableFont(WritableFont.TAHOMA, 20, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
		    		WritableCellFormat cfobjHD = new WritableCellFormat(wfobjHD);
		    		WritableCellFormat cfobjHD1 = new WritableCellFormat(wfobjHD1);
		    		cfobjHD.setBackground(Colour.GREY_25_PERCENT);		    		
		    		cfobjHD.setBorder(Border.ALL,BorderLineStyle.THIN);
		    		cfobjHD.setWrap(false);
		    		cfobjHD.setShrinkToFit(false);
		    		cfobjHD.setAlignment(jxl.format.Alignment.CENTRE);
		    		
		    		cfobjHD1.setBackground(Colour.WHITE);
		    		cfobjHD1.setBorder(Border.ALL,BorderLineStyle.THIN);
		    		cfobjHD1.setWrap(false);
		    		cfobjHD1.setShrinkToFit(false);
		    		cfobjHD1.setAlignment(jxl.format.Alignment.CENTRE);
		    		
		    		int size=0;
		            // Write the Header to the excel file
		    		
	    		 for(int i=0;i<colList.size();i++)
		    		 {
		    			 Label label1 = new Label(i, 0, selectedReportType, cfobjHD1);
		                 excelSheet.addCell(label1);
		                 WritableCell cell = excelSheet.getWritableCell(i, 0);
			             cell.setCellFormat(cfobjHD1);	
		             }
		    		 
		    		
		    		 Label titleLabel = new Label(0, 0, selectedReportType, cfobjHD1);
		    		 excelSheet.addCell(titleLabel);
		    		 excelSheet.mergeCells(0, 0, (colList.size()-1), 0);
		    		 
		    		 WritableCell titleCell = excelSheet.getWritableCell(0, 0);
		    		 titleCell.setCellFormat(cfobjHD1);
		    		 
		    		 int fontPointSize = 12;
		    		 int rowHeight = (int) ((1.5d * fontPointSize) * 20);
		    		 excelSheet.setRowView(0, rowHeight, false);
		    		 
		    		
		    		
		    		
		            for (int i = 0; i < Header.length; i++) {
		            	if(i == 0) {
		            		size = Header[i].length()+7;
		            	} else {
		            		size = Header[i].length()+10;
		            	}
		            	
		            	
		            	excelSheet.setColumnView(i, size);		            	
		                Label label = new Label(i, 1, Header[i], cfobjHD);
		                excelSheet.addCell(label);
		                WritableCell cell = excelSheet.getWritableCell(i, 0);
		                cell.setCellFormat(cfobjHD);		                
		            }
		 
		            WritableFont wfobjCL = new WritableFont(WritableFont.TAHOMA, 10, WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE, Colour.BLACK);	    		
	            	
		            int i=0;
		            while(colValue.next()){
		            	dataExistsFlag	= true;
		            	counter++;
		            	ResultSet data = null;
			            data = colValue;
			            Label label;
			            
			            WritableCellFormat cfobjCL= new WritableCellFormat(wfobjCL);
			    	    cfobjCL.setBorder(Border.ALL,BorderLineStyle.THIN);
		            	cfobjCL.setWrap(false);
		            	cfobjCL.setAlignment(jxl.format.Alignment.CENTRE);		            	
			                
			            if((i%2)==0) {
			            	cfobjCL.setBackground(Colour.LIGHT_GREEN);
			            } else { 
			            	cfobjCL.setBackground(Colour.LIGHT_TURQUOISE);
			            } 
			            
			            i++;
			            Iterator itr1 = colList.iterator();
			            int counterForLabel=0;
				           while(itr1.hasNext())
				           {
				        	    label = new Label(counterForLabel, counter, data.getString(itr1.next().toString()), cfobjCL);
				                excelSheet.addCell(label);
				                counterForLabel++;
				           }
		            }
		            if(dataExistsFlag){
		            	 workbook.write();
				         workbook.close();
		            } else {
		            	travelDateStr = dateFormatter(travelDateStr,"yyyy-MM-dd","dd/MM/yyyy");
		            	response.sendRedirect("BookingStatusReport.jsp?etx_dataExistsFlag=false&etx_date="+travelDateStr+"&etx_siteId="+siteId+"&etx_travellerId="+travellerId+"&etx_travelType="+travelType+"&etx_reqNo="+reqNo+"&etx_status="+bookingStatus+"&etx_bookedBy="+bookedBy+"&etx_reportType="+reportType+"&etx_selectedReportType="+selectedReportType+"&etx_travelStatus="+travelStatus);
		            }
		           
		 
		        } catch (Exception e) {
		        	System.out.println(e);
		        	e.printStackTrace();
		        }
				
			}			
		} catch (ParseException e) {
			e.printStackTrace();
		}	catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	private String dateFormatter(String dateStr, String fromPattern, String toPattern) throws ParseException{
		if(dateStr != null && !"".equals(dateStr) && !dateStr.trim().startsWith("1900") && !dateStr.trim().endsWith("1900")){
			String formattedDate = null;
			DateFormat srcDf = new SimpleDateFormat(fromPattern);
			Date date = srcDf.parse(dateStr);
			DateFormat destDf = new SimpleDateFormat(toPattern);
			formattedDate = destDf.format(date);
			return formattedDate;
		}else{
			return "";
		}
	}
	
	/*private ArrayList<HashMap<String, String>> getBookinglist(String siteId, String reqNo, String travelDateStr, String travelType
			, String travellerId, String bookingStatus, String bookedBy, String travelAgency, String loginUser, String reportType) throws SQLException, ParseException{
		CallableStatement cStmt = null;
		ResultSet rs=null;
		DbConnectionBean objCon=new DbConnectionBean();
		Connection con=objCon.getConnection();
		
		HashMap<String,String> dataMap = new HashMap<String,String>();	
		ArrayList<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();

		int index = 1;
		cStmt = con.prepareCall("{call PROC_TRAVEL_BOOKING_DETAIL(?,?,?,?,?,?,?,?,?,?)}");
		cStmt.setString(index++, siteId.trim());
		cStmt.setString(index++, reqNo.trim());
		cStmt.setString(index++, travelDateStr.trim());
		cStmt.setString(index++, travelType.trim());
		cStmt.setString(index++, travellerId.trim());
		cStmt.setString(index++, bookingStatus.trim());
		cStmt.setString(index++, bookedBy.trim());
		cStmt.setString(index++, travelAgency.trim());
		cStmt.setString(index++, loginUser.trim());
		cStmt.setInt(index++, 0);
		boolean result = cStmt.execute();
		rs = cStmt.getResultSet();

		int recordCount = 1;
		while(rs.next()){
			dataMap = new HashMap<String,String>();	
			dataMap.put("S_NO", String.valueOf(recordCount));
			dataMap.put("TRAVEL_REQ_ID", rs.getString("travel_req_no"));			
			dataMap.put("TRAVELLER_NAME", rs.getString("travellerName"));
			dataMap.put("SITE_NAME", rs.getString("site_Name").trim());
			dataMap.put("SECTORS", rs.getString("sector"));
			
			dataMap.put("CLS", rs.getString("travel_class"));
			if(rs.getString("departure_date") != null){
				dataMap.put("D_O_D",  dateFormatter(rs.getString("departure_date").toString(), "yyyy-MM-dd", "dd/MM/yyyy"));
			}
			dataMap.put("DEP_TIME", rs.getString("departure_time"));
			if(rs.getString("arrival_date") != null){
				dataMap.put("D_O_A", dateFormatter(rs.getString("arrival_date").toString(), "yyyy-MM-dd", "dd/MM/yyyy"));
			}
			dataMap.put("ARR_TIME", rs.getString("arrival_time"));
			dataMap.put("AIRLINE", rs.getString("airline_name"));
			dataMap.put("FOREX", rs.getString("forex_detail"));
			dataMap.put("VISA", rs.getString("is_visa_required"));
			dataMap.put("ACC", rs.getString("accommodation"));
			dataMap.put("INS", rs.getString("insurance"));			
			dataMap.put("BKG_STATUS", getBookingStatus(rs.getString("booking_status_id")));
			dataMap.put("REQ_STATUS", rs.getString("travel_status"));
			dataMap.put("REMARK", rs.getString("remarks"));
			dataMap.put("BKG_BY", getBookingBy(rs.getString("booked_by")));			
			dataMap.put("TICKET_COST", rs.getString("ticket_cost"));
			dataMap.put("VISA_COST", rs.getString("visa_cost"));
			dataMap.put("INS_COST", rs.getString("insurance_cost"));
			dataMap.put("OTHER_COST", rs.getString("other_cost"));			
			dataMap.put("TOTAL_COST", rs.getString("total_cost"));
					
			dataList.add(dataMap);
			
			recordCount++;
		}
		return dataList;
	}
	
	private HashMap<String,Object> getBookinglist1(String siteId, String reqNo, String travelDateStr, String travelType
			, String travellerId, String bookingStatus, String bookedBy, String travelAgency, String loginUser, String reportType) throws SQLException, ParseException{
		CallableStatement cStmt = null;
		ResultSet rs=null;
		DbConnectionBean objCon=new DbConnectionBean();
		Connection con=objCon.getConnection();
		
		HashMap<String,Object> dataMap = new HashMap<String,Object>();	
		ArrayList<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
		ArrayList columList = new ArrayList();

		int index = 1;
		cStmt = con.prepareCall("{call PROC_TRAVEL_BOOKING_REPORT(?,?,?,?,?,?,?,?,?,?,?)}");
		cStmt.setString(index++, siteId.trim());
		cStmt.setString(index++, reqNo.trim());
		cStmt.setString(index++, travelDateStr.trim());
		cStmt.setString(index++, travelType.trim());
		cStmt.setString(index++, travellerId.trim());
		cStmt.setString(index++, bookingStatus.trim());
		cStmt.setString(index++, bookedBy.trim());
		cStmt.setString(index++, travelAgency.trim());
		cStmt.setString(index++, reportType.trim());
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
		dataMap.put("colNameCount",columCount);
		dataMap.put("colValue",rs);
		int recordCount = 1;
		while(rs.next()){
			dataMap = new HashMap<String,String>();	
			dataMap.put("S_NO", String.valueOf(recordCount));
			dataMap.put("TRAVEL_REQ_ID", rs.getString("travel_req_no"));			
			dataMap.put("TRAVELLER_NAME", rs.getString("travellerName"));
			dataMap.put("SITE_NAME", rs.getString("site_Name").trim());
			dataMap.put("SECTORS", rs.getString("sector"));
			
			dataMap.put("CLS", rs.getString("travel_class"));
			if(rs.getString("departure_date") != null){
				dataMap.put("D_O_D",  dateFormatter(rs.getString("departure_date").toString(), "yyyy-MM-dd", "dd/MM/yyyy"));
			}
			dataMap.put("DEP_TIME", rs.getString("departure_time"));
			if(rs.getString("arrival_date") != null){
				dataMap.put("D_O_A", dateFormatter(rs.getString("arrival_date").toString(), "yyyy-MM-dd", "dd/MM/yyyy"));
			}
			dataMap.put("ARR_TIME", rs.getString("arrival_time"));
			dataMap.put("AIRLINE", rs.getString("airline_name"));
			dataMap.put("FOREX", rs.getString("forex_detail"));
			dataMap.put("VISA", rs.getString("is_visa_required"));
			dataMap.put("ACC", rs.getString("accommodation"));
			dataMap.put("INS", rs.getString("insurance"));			
			dataMap.put("BKG_STATUS", getBookingStatus(rs.getString("booking_status_id")));
			dataMap.put("REQ_STATUS", rs.getString("travel_status"));
			dataMap.put("REMARK", rs.getString("remarks"));
			dataMap.put("BKG_BY", getBookingBy(rs.getString("booked_by")));			
			dataMap.put("TICKET_COST", rs.getString("ticket_cost"));
			dataMap.put("VISA_COST", rs.getString("visa_cost"));
			dataMap.put("INS_COST", rs.getString("insurance_cost"));
			dataMap.put("OTHER_COST", rs.getString("other_cost"));			
			dataMap.put("TOTAL_COST", rs.getString("total_cost"));
					
			dataList.add(dataMap);
			
			recordCount++;
		}
		return dataMap;
	}*/
	
	private String getBookingBy(String userId) throws SQLException {
		Statement stmt=null;
		ResultSet rs=null;
		DbConnectionBean objCon=new DbConnectionBean();
		Connection con=objCon.getConnection();

		String strBookingBy = "NA";
		String sqlStr = "SELECT USERID, FIRSTNAME+' '+LASTNAME AS NAME FROM M_USERINFO WHERE USERID = "+userId+" AND ROLE_ID = 'MATA' AND STATUS_ID = 10";
		stmt		= con.createStatement(); 
		rs			= stmt.executeQuery(sqlStr);		
		if(rs.next()){
			strBookingBy = rs.getString("NAME");
		}
		return strBookingBy;
	}
	
	
	private String getBookingStatus(String bookingStatusId) throws SQLException {
		Statement stmt=null;
		ResultSet rs=null;
		DbConnectionBean objCon=new DbConnectionBean();
		Connection con=objCon.getConnection();

		String strBookingStatus = "Unattended";
		String sqlStr = "SELECT BOOKING_STATUS_ID, BOOKING_STATUS FROM M_BOOKING_STATUS WHERE BOOKING_STATUS_ID = "+bookingStatusId+" AND STATUS_ID = 10";
		stmt		= con.createStatement(); 
		rs			= stmt.executeQuery(sqlStr);		
		if(rs.next()){
			strBookingStatus = rs.getString("BOOKING_STATUS");
		}
		return strBookingStatus;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
