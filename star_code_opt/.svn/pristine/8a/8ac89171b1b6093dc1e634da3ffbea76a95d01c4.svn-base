import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;
public class Main 
{
  public static void main(String[] args) throws Exception 
  {
    Connection conn = getMySqlConnection();
    System.out.println("Got Connection.");
    Statement st = conn.createStatement();
    //st.executeUpdate("drop table survey;");
    //st.executeUpdate("create table survey (id int,name varchar(30));");
    //st.executeUpdate("insert into survey (id,name ) values (1,'nameValue')");

    ResultSet rsColumns = null;
    DatabaseMetaData meta = conn.getMetaData();
    rsColumns = meta.getColumns(null, null, "M_USERINFO", null);
    while (rsColumns.next()) 
	{
      String columnName = rsColumns.getString("COLUMN_NAME");
      System.out.println("column name=" + columnName);
      String columnType = rsColumns.getString("TYPE_NAME");
      System.out.println("type:" + columnType);
      int size = rsColumns.getInt("COLUMN_SIZE");
      System.out.println("size:" + size);
      int nullable = rsColumns.getInt("NULLABLE");
      if (nullable == DatabaseMetaData.columnNullable) {
        System.out.println("nullable true");
      } else {
        System.out.println("nullable false");
      }
      int position = rsColumns.getInt("ORDINAL_POSITION");
      System.out.println("position:" + position);

	  System.out.println("Column Details is====="+columnName+"("+columnType+")("+size+")");
      
    }

    st.close();
    conn.close();
  }

   public static Connection getMySqlConnection() throws Exception 
   {
   	 private String dbdriver		="";
	 private String dburl			="";
	 private String dbuser			="";
     private String dbpwd			="";
	 private String Path			="";
	 private String strReplaced		="";
	   
	   Path=new String(getClass().getResource("STAR.properties").getPath());
		          for(int i=0;i<Path.length();i++)
				 {
		         strReplaced =Path.replace("%20"," ");
				 }
      FileInputStream propfile = new FileInputStream(strReplaced);			
   	  if ( propfile != null)
		{
			Properties starsprop = new Properties();
			starsprop.load( propfile);
			propfile.close();
			dbdriver=starsprop.getProperty("dbdriver")==null?"":starsprop.getProperty("dbdriver");
			dburl=starsprop.getProperty("dburl")==null?"":starsprop.getProperty("dburl");
			dbuser=starsprop.getProperty("dbuser")==null?"":starsprop.getProperty("dbuser");
			dbpwd=starsprop.getProperty("dbpwd")==null?"":starsprop.getProperty("dbpwd");
		}
		/*String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
		String url = "jdbc:odbc:star";
		String username = "wfp";
		String password = "#mind@pms9211";*/

		Class.forName(dbdriver);
		Connection conn = DriverManager.getConnection(dburl, dbuser, dbpwd);
		return conn;
   }
}