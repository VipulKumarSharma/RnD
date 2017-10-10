package minDate;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class minDate 
{
	public static void main(String[] args) 
	{
		Date date = new Date();
        String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(date);
        String[] deptrDate = { "1985-05-02", "1990-11-30", "2000-08-21",
                     "1985-05-02","1975-05-12", "1428-2-3", "2015-08-16",
                     "1999-05-06" };
        String travelDate = "";
        try {
               SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
               Date[] arr = new Date[deptrDate.length];
               Date min = new Date();

               if (deptrDate.length > 0) 
               {
                     for (int i = 0; i < deptrDate.length; i++) {
                            arr[i] = sdf.parse(deptrDate[i]);
                     }
                     for (int i = 0; i < (arr.length); i++) {
                            if (min.compareTo(arr[i]) > 0) {
                                   min = arr[i];
                            } 
                     }
                     travelDate = (min.getYear() + 1900) + "-"
                                   + (min.getMonth() + 1) + "-" + min.getDate();
               } 
               else 
               {     travelDate = currentDate.trim();
               }
               String[] parts = travelDate.split("-");
               if(Integer.parseInt(parts[1]) < 10)
               {   parts[1] = "0"+parts[1];
               }
               if(Integer.parseInt(parts[2]) < 10)
               {   parts[2] = "0"+parts[2];
               }
               travelDate = parts[0]+"-"+parts[1]+"-"+parts[2];
               System.out.println(travelDate);
        } 
        catch (ParseException ex) 
        {
               ex.printStackTrace();
        }
	}
}
