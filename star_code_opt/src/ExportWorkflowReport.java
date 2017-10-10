
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import jxl.write.WriteException;
import src.connection.DbConnectionBean;


public class ExportWorkflowReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ExportWorkflowReport() {
        super();
    }

	@SuppressWarnings("rawtypes")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String currentDate	= new SimpleDateFormat("ddMMyyyy").format(new Date());
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/vnd.ms-excel");
	   	response.setHeader("Content-Disposition", "attachment; filename=STARS_WorkFlow_Report_"+currentDate+".xls");
	   	
		WorkbookSettings wbSettings = new WorkbookSettings();
		wbSettings.setSuppressWarnings(true);
		wbSettings.setLocale(new Locale("en", "EN"));
	   	WritableWorkbook workbook = Workbook.createWorkbook(response.getOutputStream());
	   	
	   	WritableFont wfobjRN = new WritableFont(WritableFont.TAHOMA, 10, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE, Colour.GREY_80_PERCENT);
		WritableFont wfobjHD = new WritableFont(WritableFont.TAHOMA, 10, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE, Colour.GREY_80_PERCENT);
        WritableFont wfobjHD1 = new WritableFont(WritableFont.TAHOMA, 20, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE, Colour.GREY_80_PERCENT);
        WritableFont wfobjHD2 = new WritableFont(WritableFont.TAHOMA, 13, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE, Colour.GREY_80_PERCENT);
        WritableFont wfobjCL = new WritableFont(WritableFont.TAHOMA, 10, WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE, Colour.GREY_80_PERCENT);
        
        WritableCellFormat cfobjRN = new WritableCellFormat(wfobjRN);
        WritableCellFormat cfobjHD = new WritableCellFormat(wfobjHD);
		WritableCellFormat cfobjHD1 = new WritableCellFormat(wfobjHD1);
		WritableCellFormat cfobjHD2 = new WritableCellFormat(wfobjHD2);
		
		try {
			cfobjRN.setBackground(Colour.ICE_BLUE);
			cfobjRN.setBorder(Border.NONE,BorderLineStyle.NONE);
			cfobjRN.setWrap(false);
			cfobjRN.setShrinkToFit(false);
			cfobjRN.setAlignment(jxl.format.Alignment.CENTRE);
			
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
			
			cfobjHD2.setBackground(Colour.ICE_BLUE);
			cfobjHD2.setBorder(Border.ALL,BorderLineStyle.THIN);
			cfobjHD2.setWrap(false);
			cfobjHD2.setShrinkToFit(false);
			cfobjHD2.setAlignment(jxl.format.Alignment.CENTRE);
		} catch (WriteException e1) {
			e1.printStackTrace();
		}		    		
		
	   	int excelSheetCounter 	= 0;
	   	DbConnectionBean objCon	= null;
	 	Connection con 			= null;
	 	Statement stmt 			= null;
	 	CallableStatement cStmt = null;
		ResultSet rs,colValue1,colValue2,colValue3,colValue4 = null;
		
		try {
			objCon 			= new DbConnectionBean();
			con 			= objCon.getConnection();
			stmt			= con.createStatement();
			
			String siteIds 	= request.getParameter("siteIds");
			siteIds			= siteIds.substring(1,siteIds.length());
			String[] siteIDs= siteIds.split("_");
			String tbl2Head = "WorkFlow Approval Level Matrix";
			String tbl3Head = "Domestic Approval WorkFlow";
			String tbl4Head = "Intercont Approval WorkFlow";
			
			
			for(String s:siteIDs) {
				int index=1,tblCount = 0;
				int headLoc = 3, dataLoc = 4;
				boolean result 	= false;
				String unitName = "";
				String siteAgId = "";
				
				rs 	= stmt.executeQuery("SELECT SITE_NAME AS SITE_NAME,TRAVEL_AGENCY_ID AS TRAVEL_AGENCY_ID FROM M_SITE WHERE STATUS_ID=10 AND SITE_ID="+s);
				if(rs.next()) {
					unitName 	= rs.getString("SITE_NAME").trim();
					siteAgId	= rs.getString("TRAVEL_AGENCY_ID").trim();
				}
				unitName = unitName.replaceAll("/", "-");
				
				workbook.createSheet(unitName, excelSheetCounter);
				WritableSheet excelSheet = workbook.getSheet(excelSheetCounter);
				excelSheet.setPageSetup(PageOrientation.LANDSCAPE);
				++excelSheetCounter;
				
				cStmt = con.prepareCall("{call PROC_WORKFLOW_DETAIL_REPORT(?,?,?)}");
				cStmt.setString(index++, s.trim());
				cStmt.setInt(index++,1);
				cStmt.setInt(index++, 0);
				result = cStmt.execute();
				colValue1 = cStmt.getResultSet();
				
				if(result){
					ArrayList<String> colList 	= new ArrayList<String>();
					for(int i=1;i<=colValue1.getMetaData().getColumnCount();i++) {
						if(i==1){
						} else {
							colList.add(colValue1.getMetaData().getColumnName(i));
						}
						
					}
					
					//Set Header
					String Header[] = new String[colValue1.getMetaData().getColumnCount()-1];
		            Iterator itr = colList.iterator();
		            int count=0;
		            while(itr.hasNext()) {
		            	Header[count] = itr.next().toString();
		        	    count++;
		            }
			           
					// Write the Header to the excel file
					int size=0;
		    		String headerName = "["+unitName+"] Userwise Workflow List" ;
		    		
		    		int fontPointSize = 12;
		    		int rowHeight = (int) ((1.5d * fontPointSize) * 20);
		    		excelSheet.setRowView(0, rowHeight, false);
		    		
		    		String WfNo = null;
		    		boolean changeWFNoFlag = false;
		    		int j=0,r1=4,r2=4,noOfRec=0;
		            while(colValue1.next()){
		            	if(j==0){
		            		++tblCount;
		            		
		            		Label titleLabel = new Label(0, 2, headerName, cfobjHD2);
				    		excelSheet.addCell(titleLabel);
				    		excelSheet.mergeCells(0, 2, (colList.size()-1), 2);
				    		
		            		for (int i = 0; i < Header.length; i++) {
				    			if(i == 0) {
				            		size = Header[i].length()+7;
				            	} else {
				            		size = Header[i].length()+10;
				            	}
				            	
				            	excelSheet.setColumnView(i, size);		
				                
				            	Label label = new Label(i, headLoc, Header[i], cfobjHD);
				                excelSheet.addCell(label);
				                WritableCell cell = excelSheet.getWritableCell(i, 0);
				                cell.setCellFormat(cfobjRN);		                
					        }
		            	}
		    		
		            	ResultSet data = null;
			            data = colValue1;
			            Label label = null;
			            
		            	String tmpWfNo = null;
		            	int counterForLabel=0;
			            Iterator itr1 = colList.iterator();
			            
				        while(itr1.hasNext()) {
				        	WritableCellFormat cfobjCL= new WritableCellFormat(wfobjCL);
				    	    cfobjCL.setBorder(Border.ALL,BorderLineStyle.THIN);
			            	cfobjCL.setWrap(false);
			            	cfobjCL.setBackground(Colour.VERY_LIGHT_YELLOW);
			            	
			            	if(counterForLabel==0 || counterForLabel==1 || counterForLabel==4){
			            		cfobjCL.setAlignment(jxl.format.Alignment.CENTRE);
			            	}else{
			            		cfobjCL.setAlignment(jxl.format.Alignment.LEFT);
			            	}
			            	
				        	String rowData = data.getString(itr1.next().toString());
				        	if(counterForLabel==0){
				        		tmpWfNo = rowData;
				        	}
				        		
			        	    label = new Label(counterForLabel, dataLoc, rowData, cfobjCL);
			                excelSheet.addCell(label);
			                counterForLabel++;
				        }
				        
				        // Implementing dynamic Row grouping functionality having same WFno
				        if(j==0){
				        	WfNo = tmpWfNo;
				        	changeWFNoFlag = false;
				        	++noOfRec;
				        } else {
				        	if(!WfNo.equalsIgnoreCase(tmpWfNo)){
				        		changeWFNoFlag = true;
				        	} else {
				        		changeWFNoFlag = false;
				        		++noOfRec;
				        	}
				        	WfNo = tmpWfNo;
				        }
				        r2=j+3;
				        if(changeWFNoFlag & noOfRec >1){
				        	excelSheet.setRowGroup(r1, r2-1, true);
				        	r1=r2+1;
				        	noOfRec = 1;
				        } else if(changeWFNoFlag) {
				        	r1=r2+1;
				        }
				        j++;
				        ++dataLoc;
		            }
		            if(tblCount == 1) {
						excelSheet.setRowGroup(r1+1, dataLoc-1, true);
					}
				}
				colValue1.close();
				
				if(siteAgId.equalsIgnoreCase("2")) {
					result = cStmt.getMoreResults();
					if (result) {
						
						colValue2 = cStmt.getResultSet();
						ArrayList<String> colList = new ArrayList<String>();
						for(int i=1;i<=colValue2.getMetaData().getColumnCount();i++) {
							colList.add(colValue2.getMetaData().getColumnName(i));
						}
						
						String Header[] = new String[colValue2.getMetaData().getColumnCount()];
			            Iterator itr = colList.iterator();
			            int count=0;
			            while(itr.hasNext()) {
			            	Header[count] = itr.next().toString();
			        	    count++;
			            }
				           
						for(int i=0;i<colList.size();i++) {
			                 WritableCell cell = excelSheet.getWritableCell(i, 0);
				             cell.setCellFormat(cfobjHD1);	
			            }
			    		
			    		int size=0;
			    		int fontPointSize = 12;
			    		int rowHeight = (int) ((1.5d * fontPointSize) * 20);
			    		excelSheet.setRowView(0, rowHeight, false);
			    		
			    		int j=0;
			            while(colValue2.next()) {
			            	if(j==0){
			            		++tblCount;
			            		
			            		for (int i = 0; i < Header.length; i++) {
					    			if(i == 0) {
					            		size = Header[i].length()+7;
					            	} else {
					            		size = Header[i].length()+10;
					            	}
					            	
					            	excelSheet.setColumnView(i, size);
					            	Label titleLabel = null;
					                Label label = null;
					                if(tblCount == 1){
					                	
					                	titleLabel = new Label(0, headLoc-1, tbl2Head, cfobjHD2);
							    		excelSheet.addCell(titleLabel);
							    		excelSheet.mergeCells(0, headLoc-1, (colList.size()-1), headLoc-1);
							    		
					                	label = new Label(i, headLoc, Header[i], cfobjHD);
					                } else if(tblCount == 2) {
					                	
					                	titleLabel = new Label(0, headLoc+dataLoc-1, tbl2Head, cfobjHD2);
							    		excelSheet.addCell(titleLabel);
							    		excelSheet.mergeCells(0, headLoc+dataLoc-1, (colList.size()-1), headLoc+dataLoc-1);
							    		
					                	label = new Label(i, headLoc+dataLoc, Header[i], cfobjHD);
					                }
					                excelSheet.addCell(label);
					                WritableCell cell = excelSheet.getWritableCell(i, 0);
					                cell.setCellFormat(cfobjRN);		                
						        }
			            	}
				    		
				    		ResultSet data = null;
				            data = colValue2;
				            Label label = null;
				            
				            WritableCellFormat cfobjCL= new WritableCellFormat(wfobjCL);
				    	    cfobjCL.setBorder(Border.ALL,BorderLineStyle.THIN);
			            	cfobjCL.setWrap(false);
			            	cfobjCL.setAlignment(jxl.format.Alignment.LEFT);		            	
			            	cfobjCL.setBackground(Colour.PALE_BLUE);
				            
				            j++;
				            Iterator itr1 = colList.iterator();
				            int counterForLabel=0;
					        while(itr1.hasNext()) {
					        	
					        	if(tblCount == 1){
					        		label = new Label(counterForLabel, dataLoc, data.getString(itr1.next().toString()), cfobjCL);
					        	} else if(tblCount == 2){
					        		label = new Label(counterForLabel, headLoc+dataLoc+1, data.getString(itr1.next().toString()), cfobjCL);
					        	}
				                excelSheet.addCell(label);
				                counterForLabel++;
					        }
					        ++dataLoc;
			            }
						colValue2.close();
					}
				}
				
				result = cStmt.getMoreResults();
				if (result) {
					colValue3 = cStmt.getResultSet();
					
					ArrayList<String> colList = new ArrayList<String>();
					for(int i=1;i<=colValue3.getMetaData().getColumnCount();i++) {
						colList.add(colValue3.getMetaData().getColumnName(i));
					}
					
					String Header[] = new String[colValue3.getMetaData().getColumnCount()];
		            Iterator itr = colList.iterator();
		            int count=0;
		            while(itr.hasNext()) {
		            	Header[count] = itr.next().toString();
		        	    count++;
		            }
		    		
					for(int i=0;i<colList.size();i++) {
		                 WritableCell cell = excelSheet.getWritableCell(i, 0);
			             cell.setCellFormat(cfobjHD1);	
		            }
		    		
		    		int size=0;
		    		int fontPointSize = 12;
		    		int rowHeight = (int) ((1.5d * fontPointSize) * 20);
		    		excelSheet.setRowView(0, rowHeight, false);
		    		
		    		int j=0;
		            while(colValue3.next()) {
		            	if(j==0){
		            		++tblCount;
		            		
		            		for (int i = 0; i < Header.length; i++) {
				    			if(i == 0) {
				            		size = Header[i].length()+7;
				            	} else {
				            		size = Header[i].length()+10;
				            	}
				            	
				            	excelSheet.setColumnView(i, size);
				            	Label titleLabel = null;
				            	Label label = null;
				            	if(tblCount == 1) {
				            		titleLabel = new Label(0, headLoc-1, tbl3Head, cfobjHD2);
						    		excelSheet.addCell(titleLabel);
						    		excelSheet.mergeCells(0, headLoc-1, (colList.size()-1), headLoc-1);
						    		
					                label = new Label(i, headLoc, Header[i], cfobjHD);
					                
					            } else if(tblCount == 2) {
					            	titleLabel = new Label(0, headLoc+dataLoc-1, tbl3Head, cfobjHD2);
						    		excelSheet.addCell(titleLabel);
						    		excelSheet.mergeCells(0, headLoc+dataLoc-1, (colList.size()-1), headLoc+dataLoc-1);
						    		
					                label = new Label(i, headLoc+dataLoc, Header[i], cfobjHD);
					                
					            } else if(tblCount == 3) {
					            	titleLabel = new Label(0, headLoc+dataLoc+3, tbl3Head, cfobjHD2);
						    		excelSheet.addCell(titleLabel);
						    		excelSheet.mergeCells(0, headLoc+dataLoc+3, (colList.size()-1), headLoc+dataLoc+3);
						    		
					                label = new Label(i, headLoc+dataLoc+4, Header[i], cfobjHD);
					            }
				                
				                excelSheet.addCell(label);
				                WritableCell cell = excelSheet.getWritableCell(i, 0);
				                cell.setCellFormat(cfobjRN);		                
					        }
		            	}
		    		
			    		ResultSet data = null;
			            data = colValue3;
			            Label label = null;
			            
			            j++;
			            Iterator itr1 = colList.iterator();
			            int counterForLabel=0;
				        while(itr1.hasNext()) {
				        	WritableCellFormat cfobjCL= new WritableCellFormat(wfobjCL);
				    	    cfobjCL.setBorder(Border.ALL,BorderLineStyle.THIN);
			            	cfobjCL.setWrap(false);
			            	cfobjCL.setBackground(Colour.LIGHT_GREEN);
			            	
			            	if(counterForLabel==1){
			            		cfobjCL.setAlignment(jxl.format.Alignment.LEFT);
			            	}else{
			            		cfobjCL.setAlignment(jxl.format.Alignment.CENTRE);
			            	}
			            	
				        	if(tblCount == 1) {
				        		label = new Label(counterForLabel, dataLoc, data.getString(itr1.next().toString()), cfobjCL);
				        	} else if(tblCount == 2) {
				        		label = new Label(counterForLabel, headLoc+dataLoc+1, data.getString(itr1.next().toString()), cfobjCL);
				        	} else if(tblCount == 3) {
				        		label = new Label(counterForLabel, headLoc+dataLoc+5, data.getString(itr1.next().toString()), cfobjCL);
				        	}
			                excelSheet.addCell(label);
			                counterForLabel++;
				        }
				        ++dataLoc;
		            }
					colValue3.close();
					
					result = cStmt.getMoreResults();
					if (result) {
						colValue4 = cStmt.getResultSet();
							
						ArrayList<String> colList1 = new ArrayList<String>();
						for(int i=1;i<=colValue4.getMetaData().getColumnCount();i++) {
							colList1.add(colValue4.getMetaData().getColumnName(i));
						}
						
						String Header1[] = new String[colValue4.getMetaData().getColumnCount()];
			            Iterator itr1 = colList1.iterator();
			            int count1=0;
			            while(itr1.hasNext()) {
			            	Header1[count1] = itr1.next().toString();
			        	    count1++;
			            }
			    		
						for(int i=0;i<colList1.size();i++) {
			                 WritableCell cell = excelSheet.getWritableCell(i, 0);
				             cell.setCellFormat(cfobjHD1);	
			            }

			    		int size1=0;
			    		int fontPointSize1 = 12;
			    		int rowHeight1 = (int) ((1.5d * fontPointSize1) * 20);
			    		excelSheet.setRowView(0, rowHeight1, false);
			    		
			    		int j1=0;
			            while(colValue4.next()) {
			            	if(j1==0){
			            		++tblCount;
			            		for (int i = 0; i < Header1.length; i++) {
			            			
			            			if(i == 0) {
					            		size1 = Header1[i].length()+7;
					            	} else {
					            		size1 = Header1[i].length()+10;
					            	}
					            	
					            	excelSheet.setColumnView(i, size1);		
					            	
					            	Label titleLabel = null;
					            	Label label = null;
					            	if(tblCount == 1) {
					            		titleLabel = new Label(0, headLoc-1, tbl4Head, cfobjHD2);
							    		excelSheet.addCell(titleLabel);
							    		excelSheet.mergeCells(0, headLoc-1, (colList.size()-1), headLoc-1);
						                
							    		label = new Label(i, headLoc, Header1[i], cfobjHD);
							    		
						            } else if(tblCount == 2) {
						            	titleLabel = new Label(0, headLoc+dataLoc-1, tbl4Head, cfobjHD2);
							    		excelSheet.addCell(titleLabel);
							    		excelSheet.mergeCells(0, headLoc+dataLoc-1, (colList.size()-1), headLoc+dataLoc-1);
						               
							    		label = new Label(i, headLoc+dataLoc, Header1[i], cfobjHD);
							    		
						            } else if(tblCount == 3) {
						            	titleLabel = new Label(0, headLoc+dataLoc+3, tbl4Head, cfobjHD2);
							    		excelSheet.addCell(titleLabel);
							    		excelSheet.mergeCells(0, headLoc+dataLoc+3, (colList.size()-1), headLoc+dataLoc+3);
						                
							    		label = new Label(i, headLoc+dataLoc+4, Header1[i], cfobjHD);
							    		
						            } else if(tblCount == 4) {
						            	titleLabel = new Label(0, headLoc+dataLoc+7, tbl4Head, cfobjHD2);
							    		excelSheet.addCell(titleLabel);
							    		excelSheet.mergeCells(0, headLoc+dataLoc+7, (colList.size()-1), headLoc+dataLoc+7);
						                
							    		label = new Label(i, headLoc+dataLoc+8, Header1[i], cfobjHD);
						            }
					                excelSheet.addCell(label);
					                WritableCell cell = excelSheet.getWritableCell(i, 0);
					                cell.setCellFormat(cfobjRN);		                
						        }
			            	}
				    		
				    		ResultSet data = null;
				            data = colValue4;
				            Label label = null;
				            
				            j1++;
				            Iterator itr11 = colList1.iterator();
				            int counterForLabel=0;
					        while(itr11.hasNext()) {
					        	WritableCellFormat cfobjCL= new WritableCellFormat(wfobjCL);
					    	    cfobjCL.setBorder(Border.ALL,BorderLineStyle.THIN);
				            	cfobjCL.setWrap(false);
				            	cfobjCL.setBackground(Colour.LIGHT_TURQUOISE);
				            	
				            	if(counterForLabel==1){
				            		cfobjCL.setAlignment(jxl.format.Alignment.LEFT);
				            	}else{
				            		cfobjCL.setAlignment(jxl.format.Alignment.CENTRE);
				            	}
				            	
					        	if(tblCount == 1) {
					        		label = new Label(counterForLabel, dataLoc, data.getString(itr11.next().toString()), cfobjCL);
					        	} else if(tblCount == 2) {
					        		label = new Label(counterForLabel, headLoc+dataLoc+1, data.getString(itr11.next().toString()), cfobjCL);
					        	} else if(tblCount == 3) {
					        		label = new Label(counterForLabel, headLoc+dataLoc+5, data.getString(itr11.next().toString()), cfobjCL);
					        	} else if(tblCount == 4) {
					        		label = new Label(counterForLabel, headLoc+dataLoc+9, data.getString(itr11.next().toString()), cfobjCL);
					        	}
				                excelSheet.addCell(label);
				                counterForLabel++;
					        }
					        ++dataLoc;
						}
						colValue4.close();
					}
				}
				if(tblCount==0) {
					String noDataFoundLabel = "No Data Found for ["+unitName+"] unit";
					
					WritableCellFormat cfobjCL= new WritableCellFormat(wfobjHD2);
		    	    cfobjCL.setBorder(Border.NONE,BorderLineStyle.NONE);
	            	cfobjCL.setWrap(false);
	            	cfobjCL.setAlignment(jxl.format.Alignment.CENTRE);		            	
	            	cfobjCL.setBackground(Colour.LIGHT_ORANGE);
	            	
					Label titleLabel = new Label(2, 2, noDataFoundLabel, cfobjCL);
		    		excelSheet.addCell(titleLabel);
		    		excelSheet.mergeCells(2, 2, (10), 2);
				}
			}
			workbook.write();
	        workbook.close();
	        
		} catch(Exception e){
			System.out.println(e);
        	e.printStackTrace();
		}
	}

}
