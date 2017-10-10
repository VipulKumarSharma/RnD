
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.sql.*;
import java.awt.Color;
import java.util.Enumeration;
import src.connection.DbConnectionBean;


import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;



import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JRRuntimeException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.j2ee.servlets.ImageServlet;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.view.JasperViewer;


/**
 * @version 	1.0
 * @author
 */
public class HtmlServlet extends HttpServlet 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Connection con,con1;
	public 	Statement stmt,stmt1;		
	private  DbConnectionBean dbConBean;

	String reportName="";
	String strFrom ="";
	String strTo="";
	String strTravelType="";
	String strTableName="";
	String strTableNameNew="";
	String strsiteid	 ="";
	String strReportTitle = "Destination Wise Report";

     

	/**
	 *
	 */
	public void service(HttpServletRequest request,	HttpServletResponse response)	throws IOException, ServletException 
	{
		ServletContext context = this.getServletConfig().getServletContext();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		//Color color = new Color(0,0,255);

			reportName = request.getParameter("reportName");
			//System.out.println("in HTMLServlet  reportName "+reportName);
			strFrom=request.getParameter("strFrom");
			//System.out.println("in HTMLServlet  strFrom "+strFrom);
			 strTo=request.getParameter("strTo");
			//System.out.println("in HTMLServlet  strTo "+strTo);
			 strTravelType = request.getParameter("strTravelType");
			//System.out.println("in HTMLServlet  strTravelType "+strTravelType);
			strTableName = request.getParameter("strTableName");
			//System.out.println("strTableName --> "+strTableName);

			strTableNameNew = request.getParameter("strTableNamenew");
			//System.out.println("strTableNamenew --> "+strTableNameNew);

				strsiteid = request.getParameter("strsiteid");
			//System.out.println("strsiteid --> "+strsiteid);

		try {
		
			ResultSet rs=null;
		//	String desig = request.getParameter("desig");
			System.out.println("***********reportName*********" + reportName);
			File reportFile =
				new File(
					context.getRealPath("/reports/" + reportName + ".jasper"));
			System.out.println("**********HTML************" + reportFile);
			
			if (!reportFile.exists())
				throw new JRRuntimeException("File" + reportName + ".jasper not found. The report design must be compiled first.");

			JasperReport jasperReport =
				(JasperReport) JRLoader.loadObject(reportFile.getPath());


			Map parameters = new HashMap();

				//parameters.put("PARAM_strTravelTo",request.getParameter("reportName"));
				parameters.put("PARAM_strTravelFrom",request.getParameter("strFrom"));
				parameters.put("PARAM_strTravelTo",request.getParameter("strTo"));
				parameters.put("PARAM_strTravelType",request.getParameter("strTravelType"));
				parameters.put("PARAM_strTableName",request.getParameter("strTableName"));
				parameters.put("PARAM_strTableNameNew",request.getParameter("strTableNameNew"));
				parameters.put("PARAM_strSiteIDnew",request.getParameter("strsiteid"));



			//System.out.println("***********BaseDir*********" + parameters.get("BaseDir") );
			parameters.put(JRParameter.IS_IGNORE_PAGINATION, Boolean.TRUE);
	
		 System.out.println("45");
			try
	      {
			   dbConBean = new DbConnectionBean();   
			   //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
               //con1 = DriverManager.getConnection("jdbc:odbc:star","wfp","#mind@pms9211");
			   //con1.setAutoCommit(true);
			   //System.out.println("46");
               //stmt1 = con1.createStatement();
			   con1 = dbConBean.getConnection();

          }
		  catch (Exception e) 
	      {
			  System.out.println("Connection not Created !Error in c'tor of DbConnectionBean.java==="+e);
              e.printStackTrace();
          }

	/*	String strSql = "Select lastname from m_userinfo";
		try{
			System.out.println("48");
		rs = stmt1.executeQuery(strSql); // it returns a ResultSet 
		System.out.println("strSql "+strSql);
			
			while(rs.next()){
				
				System.out.println(rs.getString(1));
			//	parameters.put("aa",rs.getString(1));
			}
			
		rs.close();
		con.close();

		}
		catch(SQLException e){
			System.out.println("Error in SQL");
			}*/
		JRResultSetDataSource jrRS = new JRResultSetDataSource(rs);
		//while(jrRS.next()){
		//	System.out.println("1-->");
			
		
		//	}
		
		//JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, con);

		//JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, jrRS);


		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, con1);
	//System.out.println("Total No of Pages :" + jasperPrint.getPages().size());
		
		if(jasperPrint.getPages().size() == 0) 
		{
				RequestDispatcher rd =	getServletContext().getRequestDispatcher("/reports/ErrorReport.jsp");
				rd.forward(request, response);
		}
		

		JRHtmlExporter exporter = new JRHtmlExporter();
		String urlPattern = "ImageServlet";
		String imagesUri =  urlPattern + "?image=";
		System.out.println("-->imagesUri--> "+imagesUri);
		Map imagesMap = new HashMap();
		StringBuffer sbuffer = new StringBuffer();
		request.getSession().setAttribute(
				ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE,
				jasperPrint);

		request.getSession().setAttribute("IMAGES_MAP", imagesMap);
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_STRING_BUFFER, sbuffer);
		exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, out);
		exporter.setParameter(JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.FALSE);
		exporter.setParameter(JRHtmlExporterParameter.SIZE_UNIT, "px");
		exporter.setParameter(JRHtmlExporterParameter.IMAGES_MAP, imagesMap);
		exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, imagesUri);		
		//exporter.setBackcolor(color);
		exporter.exportReport();
		out.write(sbuffer.toString());  
	
		} catch (JRException e) {

			out.println("JasperReports Error");

			e.printStackTrace(out);

		}

		out.println("<HTML><BODY>");
		out.println("<form name=frm method=post action =\"T_DestinationReport.jsp\">");
		out.println("<table border=0 align=center width=100%>");
		out.println("<tr align=center>");
		out.println("<td align=center>");
		out.println("<input type=submit value=Back >");
		out.println("</td></tr></table></form></body></html>");

	}

 

}
