   import java.io.File;
   import java.io.FileInputStream;
   import java.io.FileOutputStream;

   public class Temp
   {
       public static void main( String[] args )
       {
       	FileInputStream fileInputStream=null;
           
           File file = new File("C:\\PMS_PDF\\Backup\\TEMP_4890_PMS.pdf");
           
           byte[] byteFile = new byte[(int) file.length()];
           
           try {
               //convert file into array of bytes
   	    fileInputStream = new FileInputStream(file);
   	    fileInputStream.read(byteFile);
   	    fileInputStream.close();
   	       
   	    for (int i = 0; i < byteFile.length; i++) {
   	       	System.out.print((char)byteFile[i]);
               }
   			
   	    System.err.println("Done");
           }catch(Exception e){
           	e.printStackTrace();
           }
       }
   }