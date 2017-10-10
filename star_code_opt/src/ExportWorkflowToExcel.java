/*
 * Project   : STARS
 * Created By: Manoj Chand
 * Date of Creation : 09 July 2012
 * Description : this servlet Create Excel for workflow data
 * Modification: Change cellvalue to WORKFLOW NUMBER FROM WORKFLOW NAME ON 14 AUGUST 2012 BY MANOJ CHAND
 * 
 * Modified By	: Manoj Chand
 * Modification : Create Database connection from stars.properties located outside STARS application.
 * Modification Date: 03 Jan 2013
 * */


import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Locale;
import java.util.Properties;
import src.connection.LabelRepository;
import src.connection.PropertiesLoader;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.CellView;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.PageOrientation;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;
import jxl.write.Number;

public class ExportWorkflowToExcel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private WritableCellFormat timesBoldUnderline;
	private WritableCellFormat times;

    public ExportWorkflowToExcel() {
        super();
    }
    
    
    ResultSet rs;
	String strSql="";
	String strSiteId="";
	String strTravelType="";
	String strFileName="";
	String strUploadedOn="";
	byte[] FileBytes  = null;
	String contentType = ""; // set the content type
	String dbdriver		=null;
	String dburl		=null;
	String dbuser		=null;
	String dbpswd		=null;
	String user			=null;		// To hold the user
	String password		=null;		// To hold the password
	Connection conn		=null;
	Statement stmt		=null;
	Properties starsprop	=null;
	String strSiteName ="";
	String strLang="en_US";
	LabelRepository obj_Label=null;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		strSiteId=request.getParameter("site_id");
		strSiteName=request.getParameter("site_name")==null?"":request.getParameter("site_name");
		strLang=request.getParameter("lang")==null?"en_US":request.getParameter("lang");
		//System.out.println("strLang-->"+strLang);
		obj_Label=new LabelRepository();

		//change by manoj chand on 03 jan 2013 to fetch connection from Outside STARS.PROPERTIES FILE
		 dbdriver 	    = PropertiesLoader.config.getProperty("dbdriver")==null?"":PropertiesLoader.config.getProperty("dbdriver");
		 dburl 		    = PropertiesLoader.config.getProperty("dburl")==null?"":PropertiesLoader.config.getProperty("dburl");
		 dbuser 		= PropertiesLoader.config.getProperty("dbuser")==null?"":PropertiesLoader.config.getProperty("dbuser");
		 dbpswd 		= PropertiesLoader.config.getProperty("dbpwd")==null?"":PropertiesLoader.config.getProperty("dbpwd"); 

		   
		   try {
			Class.forName(dbdriver);
			conn = DriverManager.getConnection(dburl,dbuser,dbpswd);
			conn.setAutoCommit(true);
	        stmt = conn.createStatement();
	        generateExcel(request, response, strSiteId);
		} catch (ClassNotFoundException e2) {
			
			e2.printStackTrace();
		}
	    catch (SQLException e2) {
			e2.printStackTrace();
		}
	}

	public void generateExcel(HttpServletRequest request, HttpServletResponse response, String strSiteid) throws ServletException, IOException {
		
		String strSql = "EXEC  PROC_WORKFLOW_EXPORT '"+strSiteid.trim()+"'";
		try{
			WorkbookSettings wbSettings = new WorkbookSettings();
			wbSettings.setLocale(new Locale("en", "EN"));
			
			response.setContentType("application/vnd.ms-excel");
		   	response.setHeader("Content-Disposition", "attachment; filename="+strSiteName.trim()+"_Workflow.xls");

		   	WritableWorkbook workbook = Workbook.createWorkbook(response.getOutputStream());

			workbook.createSheet(strSiteName.trim(), 0);
			
			WritableSheet excelSheet = workbook.getSheet(0);
			createLabel(request, excelSheet, strSql);
			workbook.write();
			workbook.close();
			
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	
	private void createLabel(HttpServletRequest request,  WritableSheet sheet, String strSql) throws WriteException {
		
		WritableFont times10pt = new WritableFont(WritableFont.TIMES, 10);
		times = new WritableCellFormat(times10pt);
		times.setWrap(false);
		times.setBorder(Border.ALL,BorderLineStyle.THIN);
		times.setShrinkToFit(false);
		
		sheet.setPageSetup(PageOrientation.LANDSCAPE);
		
		WritableFont times10ptBoldUnderline = new WritableFont(WritableFont.TIMES, 10, WritableFont.BOLD, false);
		timesBoldUnderline = new WritableCellFormat(times10ptBoldUnderline);
		// Lets automatically wrap the cells
		timesBoldUnderline.setWrap(false);
		
		CellView cv = new CellView();
		cv.setFormat(times);
		cv.setFormat(timesBoldUnderline);
		try{
			String strCellValue="";
			ResultSetMetaData rsmt = null;
			stmt=conn.createStatement();
			rs = stmt.executeQuery(strSql);
			int colNo=0;
			rsmt = rs.getMetaData();
			int totalColCnt = rsmt.getColumnCount();
			for(int prjCnt = 0; prjCnt < totalColCnt; prjCnt++){
				
				if(prjCnt==0)
					prjCnt=2;
				
				strCellValue=rs.getMetaData().getColumnLabel(prjCnt+1);
				if(strCellValue.equalsIgnoreCase("S_NO"))
					strCellValue=obj_Label.getLabel("label.global.sno", strLang);
				if(strCellValue.equalsIgnoreCase("Name"))
					strCellValue=obj_Label.getLabel("label.requestdetails.name", strLang);
				if(strCellValue.equalsIgnoreCase("Designation"))
					strCellValue=obj_Label.getLabel("label.global.designation", strLang);
				else if(strCellValue.equalsIgnoreCase("APP_ROLE"))
					strCellValue="Workflow Number";
				else if(strCellValue.equalsIgnoreCase("TRAVEL_TYPE"))
					strCellValue=obj_Label.getLabel("label.report.traveltype", strLang);
				addCaption(sheet, prjCnt-2, 0, strCellValue);
			}
			
			int rowCnt=1;
			String val="";
			String strColor="";
			int x=0;
			while(rs.next()){
				for(int prjCnt = 0; prjCnt < totalColCnt; prjCnt++){
					
					if(prjCnt==0)
						prjCnt=2;
					
					String strType=rs.getString(2);
					if(strType.equalsIgnoreCase("D"))
						strColor="DOM";
					else if(strType.equalsIgnoreCase("I")){
						if(x==0)
							x=1;
						strColor="INT";
					}
					if(x==1){
						//addText(sheet, colNo,rowCnt, "","");
						//addText(sheet, colNo+1, rowCnt, "INTERNATIONAL WORKFLOW","");
						//addText(sheet, colNo+2, rowCnt, "","");
						//addText(sheet, colNo+3, rowCnt, "","");
						//addText(sheet, colNo+4, rowCnt, "","");
						rowCnt=rowCnt+1;
					x=2;	
					}
					
					
					val=rs.getString(prjCnt+1);
					if ((rsmt.getColumnTypeName(prjCnt+1).equals("float"))||(rsmt.getColumnTypeName(prjCnt+1).equals("int"))){
						addNumbers(sheet, colNo, rowCnt, val,strColor);
						}
					else{
						addText(sheet, colNo, rowCnt, val,strColor);
					}
					
					colNo=colNo+1;
				}
				colNo=0;
				rowCnt=rowCnt+1;
			}
			rs.close();
			stmt.close();
			conn.close();
		}catch(java.lang.Exception e){
			System.out.println("in catch:::"+e);
			addText(sheet, 1, 2, e.toString(),"");
		}
	}
	int size=0;
	private void addCaption(WritableSheet sheet, int column, int row, String s) throws RowsExceededException, WriteException {
		Label label;
		WritableFont wfobj=new WritableFont(WritableFont.TIMES, 11, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,Colour.BLACK);
		WritableCellFormat cfobj=new WritableCellFormat(wfobj);
		cfobj.setBackground(Colour.GREY_25_PERCENT);
		cfobj.setBorder(Border.ALL,BorderLineStyle.THIN);
		if(s.equalsIgnoreCase(obj_Label.getLabel("label.global.sno", strLang)))
			size=6;
		else if(s.equalsIgnoreCase(obj_Label.getLabel("label.requestdetails.name", strLang)))
			size=30;
		else if(s.equalsIgnoreCase(obj_Label.getLabel("label.global.designation", strLang)))
			size=40;
		else if(s.equalsIgnoreCase(obj_Label.getLabel("label.report.traveltype", strLang)))
			size=s.length()+7;
		else
		size=s.length()+3;
		sheet.setColumnView(column, size);
		label = new Label(column, row, s, cfobj);
		sheet.addCell(label);
	}
	
	private void addText(WritableSheet sheet, int column, int row, String s,String color) throws WriteException, RowsExceededException {
		Label label;
		WritableFont wfobj=new WritableFont(WritableFont.TIMES, 10, WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE,Colour.BLACK);
		WritableCellFormat cfobj=new WritableCellFormat(wfobj);
		if(color.equalsIgnoreCase("DOM"))
			cfobj.setBackground(Colour.LIGHT_GREEN);
		else if(color.equalsIgnoreCase("INT"))
			cfobj.setBackground(Colour.LAVENDER);
		
		cfobj.setBorder(Border.ALL,BorderLineStyle.THIN);
		cfobj.setWrap(false);
		
		if(s.equals("D") || s.equals("I")){
			cfobj.setAlignment(jxl.format.Alignment.CENTRE);
			label = new Label(column, row, s, cfobj);
		}else{
			label = new Label(column, row, s, cfobj);
		}
		sheet.addCell(label);
	}
	
	private void addNumbers(WritableSheet sheet, int column, int row, String s,String color) throws WriteException, RowsExceededException {
		WritableFont wfobj=new WritableFont(WritableFont.TIMES, 10, WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE,Colour.BLACK);
		WritableCellFormat cfobj=new WritableCellFormat(wfobj);
		//cfobj.setBackground(Colour.WHITE);
		if(color.equalsIgnoreCase("DOM"))
			cfobj.setBackground(Colour.LIGHT_GREEN);
		else if(color.equalsIgnoreCase("INT"))
			cfobj.setBackground(Colour.LAVENDER);
		cfobj.setBorder(Border.ALL,BorderLineStyle.THIN);
		cfobj.setWrap(false);
		cfobj.setAlignment(jxl.format.Alignment.CENTRE);
		Number number = new Number(column, row, Float.parseFloat(s),cfobj);
		sheet.addCell(number); 
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
