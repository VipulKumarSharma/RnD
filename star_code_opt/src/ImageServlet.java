import java.awt.Dimension;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRImage;
import net.sf.jasperreports.engine.JRImageRenderer;
import net.sf.jasperreports.engine.JRPrintElementIndex;
import net.sf.jasperreports.engine.JRPrintImage;
import net.sf.jasperreports.engine.JRPrintPage;
import net.sf.jasperreports.engine.JRRenderable;
import net.sf.jasperreports.engine.JRWrappingSvgRenderer;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.util.JRTypeSniffer;
import net.sf.jasperreports.j2ee.servlets.BaseHttpServlet;



/**
 * @version 	1.0
 * @author
 */
public class ImageServlet  extends BaseHttpServlet {

	public static final String DEFAULT_JASPER_PRINT_LIST_SESSION_ATTRIBUTE = "net.sf.jasperreports.j2ee.jasper_print_list";
	public static final String DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE = "net.sf.jasperreports.j2ee.jasper_print";

	public static final String JASPER_PRINT_LIST_REQUEST_PARAMETER = "jrprintlist";
	public static final String JASPER_PRINT_REQUEST_PARAMETER = "jrprint";
	public static final String IMAGE_NAME_REQUEST_PARAMETER = "image";

			
	/**
	 *
	 */
	public void service(
		HttpServletRequest request,
		HttpServletResponse response
		) throws IOException, ServletException
	{
		System.out.println("%%%%%%%%%%%%%% in Image Servlet starts %%%%%%%%%%%%%%%%%%%%%");
		byte[] imageData = null;
		String imageMimeType = null;

		String imageName = request.getParameter(IMAGE_NAME_REQUEST_PARAMETER);
		System.out.println("imageName--> "+imageName);
		if ("px".equals(imageName))
		{
			try
			{
				System.out.println("in px equals image ");
				JRRenderable pxRenderer = 
					JRImageRenderer.getInstance(
						"net/sf/jasperreports/engine/images/pixel.GIF",
						JRImage.ON_ERROR_TYPE_ERROR
						);
				imageData = pxRenderer.getImageData();
			System.out.println("2");
			}
			catch (JRException e)
			{
				System.out.println("Exception in Imageservlet in px one "+e);
				throw new ServletException(e);
			}
		}
		else
		{
			System.out.println("in px not equals image");
			List jasperPrintList = BaseHttpServlet.getJasperPrintList(request);
			
			if (jasperPrintList == null)
			{
				throw new ServletException("No JasperPrint documents found on the HTTP session.");
			}
			
			JRPrintElementIndex imageIndex = JRHtmlExporter.getPrintElementIndex(imageName);
			
			JasperPrint report = (JasperPrint)jasperPrintList.get(imageIndex.getReportIndex());
			JRPrintPage page = (JRPrintPage)report.getPages().get(imageIndex.getPageIndex());
			JRPrintImage image = (JRPrintImage)page.getElements().get(
					imageIndex.getElementIndexes()[0].intValue() 
							);
			JRRenderable renderer = image.getRenderer();
			if (renderer.getType() == JRRenderable.TYPE_SVG)
			{
				renderer = 
					new JRWrappingSvgRenderer(
						renderer, 
						new Dimension(image.getWidth(), image.getHeight()),
						image.getBackcolor()
						);
			}

			imageMimeType = JRTypeSniffer.getImageMimeType(renderer.getImageType());
			
			try
			{
				imageData = renderer.getImageData();
			}
			catch (JRException e)
			{
				throw new ServletException(e);
			}
		}

		if (imageData != null && imageData.length > 0)
		{
			if (imageMimeType != null) 
			{
				response.setHeader("Content-Type", imageMimeType);
			}
			response.setContentLength(imageData.length);
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(imageData, 0, imageData.length);
			ouputStream.flush();
			ouputStream.close();
		}
		
		System.out.println("%%%%%%%%%%%%%% in Image Servlet ends %%%%%%%%%%%%%%%%%%%%%");
	}



}
