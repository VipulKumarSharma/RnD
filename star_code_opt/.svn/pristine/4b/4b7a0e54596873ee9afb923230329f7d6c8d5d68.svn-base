
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.util.JRProperties;


public class CompileServlet extends HttpServlet {

		public void service(
		HttpServletRequest request,
		HttpServletResponse response)
		throws IOException, ServletException {
		ServletContext context = this.getServletConfig().getServletContext();
		int flag=0;

		JRProperties.setProperty(
			JRProperties.COMPILER_CLASSPATH,
			context.getRealPath("/WEB-INF/lib/jasperreports-1.2.7.jar")
				+ System.getProperty("path.separator")
				+ context.getRealPath("/WEB-INF/classes/"));

		JRProperties.setProperty(
			JRProperties.COMPILER_TEMP_DIR,
			context.getRealPath("/reports/"));

		try {
			
			String reportName = request.getParameter("reportName");
			System.out.println("reportName "+reportName);
			String strFrom=request.getParameter("strFrom");
			System.out.println("strFrom "+strFrom);
			String strTo=request.getParameter("strTo");
			System.out.println("strTo "+strTo);
			String strTravelType = request.getParameter("strTravelType");
			System.out.println("strTravelType "+strTravelType);

			System.out.println("context.getRealPath  "+context.getRealPath("/reports/" + reportName + ".jrxml"));
			
			
			try
			{
					JasperCompileManager.compileReportToFile(
					context.getRealPath("/reports/" + reportName + ".jrxml"));

			}
			catch(Exception e)
			{
				flag=1;
			System.out.println("In exception JRXML Not Found  Error in Compile to Report");
			System.out.println(e);
			}
			
		} catch (Exception e) {
			flag=1;
			System.out.println("In Excepiton" + e);
		}
		
		if(flag==0){
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.println("<html>");
				out.println("<head>");
				out.println("<title>JasperReports - Web Application Sample</title>");
				out.println(
					"<link rel=\"stylesheet\" type=\"text/css\" href=\"../stylesheet.css\" title=\"Style\">");
				out.println("</head>");

				out.println("<body bgcolor=\"white\">");

				out.println(
					"<span class=\"bold\">The XML report design was successfully compiled.</span>");
				out.println("<form name=frm action =/star/T_DestinationReport.jsp>");
				out.println("<table border=0 align=center width=100%>");
				out.println("<tr align=center>");
				out.println("<td align=center>");
				out.println("<input type=submit value=Back >");
				out.println("</td></tr></table>");
				out.println("</body>");
				out.println("</html>");
		}
		else{
				PrintWriter out = response.getWriter();
				out.println("<html>");
				out.println("</head>");
				out.println("<body bgcolor=\"white\">");
				out.println(
					"<span class=\"bold\">Error occured during  XML report design compilation process.</span>");
				out.println("<form name=frm action =/star/T_DestinationReport.jsp>");
				out.println("<table border=0 align=center width=100%>");
				out.println("<tr align=center>");
				out.println("<td align=center>");
				out.println("<input type=submit value=Back >");
				out.println("</td></tr></table>");
				out.println("</body>");
				out.println("</html>");
		
		}
	}


	}


