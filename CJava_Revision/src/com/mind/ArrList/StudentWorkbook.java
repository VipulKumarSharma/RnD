package com.mind.ArrList;

import java.awt.Desktop;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Font;

public class StudentWorkbook extends Student
{
	FileOutputStream fileOut = null;
	HSSFWorkbook wb = new HSSFWorkbook();
	HSSFCellStyle headerStyle = wb.createCellStyle();
	
	public StudentWorkbook()
	{	HSSFFont headerFont = wb.createFont();
		headerFont.setBoldweight(Font.BOLDWEIGHT_BOLD);

	    headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	    headerStyle.setFillForegroundColor(HSSFColor.PALE_BLUE.index);
	    headerStyle.setFillBackgroundColor(HSSFColor.WHITE.index);
	    headerStyle.setFont(headerFont);
	
	    try
	    {  	fileOut = new FileOutputStream("StudentWorkbook.xls");
	    }
	    catch (FileNotFoundException e)
	    {	e.printStackTrace();
	    }
	}
	
	public void generateSimpleExcelReport()
    {	try
        {	HSSFSheet stuWorksheet = wb.createSheet("STUDENT DETAILS");

            HSSFRow sessionname = stuWorksheet.createRow(0);
            HSSFCell title = sessionname.createCell(1);
            title.setCellStyle(headerStyle);
            title.setCellValue("STUDENT DETAILS");

            HSSFRow row = stuWorksheet.createRow(2);

            HSSFCell cell0 = row.createCell(0);
            cell0.setCellStyle(headerStyle);
            cell0.setCellValue("ROLL NO.");

            HSSFCell cell1 = row.createCell(1);
            cell1.setCellStyle(headerStyle);
            cell1.setCellValue("NAME");

            HSSFCell cell2 = row.createCell(2);
            cell2.setCellStyle(headerStyle);
            cell2.setCellValue("ADDRESS");

            if (!stu_al.isEmpty())
            {	int rowNumber = 3;
                for (Student s : stu_al)
                {	HSSFRow nextrow = stuWorksheet.createRow(rowNumber);
                    nextrow.createCell(0).setCellValue(s.shrt_rollNumber);
                    nextrow.createCell(1).setCellValue(s.str_name);
                    nextrow.createCell(2).setCellValue(s.str_address);
                    rowNumber++;
                }
            }
            stuWorksheet.autoSizeColumn(0);
            stuWorksheet.autoSizeColumn(1);
            stuWorksheet.autoSizeColumn(2);
            stuWorksheet.autoSizeColumn(3);
            
            wb.write(fileOut);
            fileOut.flush();
            fileOut.close();
            System.out.println("\n# Excel Report Created Successfully #");

            File file = new File("StudentWorkbook.xls");
    		if(!Desktop.isDesktopSupported()){
                System.out.println("Desktop is not supported");
            }
            Desktop desktop = Desktop.getDesktop();
            if(file.exists()) desktop.open(file);
        }
        catch (FileNotFoundException fe)
        {	fe.printStackTrace();
        }
        catch (IOException e)
        {	e.printStackTrace();
        }
        finally
        {	try
            {	fileOut.flush();
                fileOut.close();
            }
            catch (IOException e)
            {	e.printStackTrace();
            }
        }
    }    
}
