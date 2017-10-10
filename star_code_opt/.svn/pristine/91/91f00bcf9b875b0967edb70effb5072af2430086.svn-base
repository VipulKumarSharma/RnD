/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and proprietary to MIND and forms the part of the MIND 
*Created BY		:	Manoj Chand
*Date			:	06 July 2012
*Description	:	To load all labels from database.
*Project		:	STARS
**********************************************************/ 

package src.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import src.connection.PropertiesLoader;

public class LabelValuesGenerator extends Object {

	static String dbdriver = "";
	static String dburl = "";
	static String dbuser = "";
	static String dbpswd = "";
	Locale currentLocale = null;
	ResourceBundle messages = null;
	Connection con = null; // Object for connection
	ResultSet rs = null;
	String labelKey;
	String labelValue;
	String langKey;
	Hashtable label = null;
	Hashtable labelRepository = null;
	
	public static LabelValuesGenerator porLang = null;

	/**
	 * Constructor
	 */
	protected LabelValuesGenerator() {

		try {
			/*String strReplaced = "";
			String path = new String(getClass().getResource("STAR.properties")
					.getPath());
			for (int i = 0; i < path.length(); i++) {
				strReplaced = path.replace("%20", " ");
			}
			
			FileInputStream propfile = new FileInputStream(strReplaced);
			if (propfile != null) {
				Properties pmsprop = new Properties();
				pmsprop.load(propfile);
				dbdriver = pmsprop.getProperty("dbdriver");
				dburl = pmsprop.getProperty("dburl");
				dbuser = pmsprop.getProperty("dbuser");
				dbpswd = pmsprop.getProperty("dbpwd");

			}*/
			
			//added by manoj chand on 03 jan 2013
			dbdriver = PropertiesLoader.config.getProperty("dbdriver");
			dburl = PropertiesLoader.config.getProperty("dburl");
			dbuser = PropertiesLoader.config.getProperty("dbuser");
			dbpswd = PropertiesLoader.config.getProperty("dbpwd");
			
			labelRepository = new Hashtable();
			Class.forName(dbdriver);
			con = DriverManager.getConnection(dburl, dbuser, dbpswd);
			String strSql = "SELECT * FROM LABEL_MST WHERE STATUS_ID=10";
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery(strSql);
			ResultSetMetaData rsMetaData = rs.getMetaData();
			int columnCount = rsMetaData.getColumnCount();
			while (rs.next()) {
				label = new Hashtable();
				labelKey = rs.getString("LABEL_KEY");
				for(int column=3;column<=columnCount-5;column++){
					label.put(rsMetaData.getColumnName(column), rs.getString(column));
				}
				labelRepository.put(labelKey, label);
			}
			
			rs.close();
			stmt.close();

		} catch (Exception ee) {
			System.out.println("Exception in file reading " + ee);
			ee.printStackTrace();
		}
	}

	public static LabelValuesGenerator getInstance() {
		if (porLang == null) {
			synchronized (LabelValuesGenerator.class) {
				if (porLang == null) {
					porLang = new LabelValuesGenerator();
					return porLang;
				}
			}
		} else {
			return porLang;
		}
		return porLang;
	}

	/**************************************************************
	 * Method :getUpdatedLabels() Return Values() :String Parameter(s) : Author
	 * :Anjali Kumari Date :15th. Feb. 2011 Purpose :This method is for getting
	 * the label name after new labels added.
	 **************************************************************/
	public static LabelValuesGenerator getUpdatedLabels() {
		synchronized (LabelValuesGenerator.class) {
			porLang = new LabelValuesGenerator();
			return porLang;

		}

	}

	/**************************************************************
	 * Method :getLabelName() Return Values() :String Parameter(s) :String
	 * language,String lang_id,String application name Author :Surinder Singh
	 * Date :9th. Oct. 2002 Purpose :This method is for getting the label name.
	 **************************************************************/
	public String getLabel(String labelKey, String langKey) {

		String msg = null;
		try {
				msg = (String) ((Map)labelRepository.get(labelKey)).get(langKey);
		} catch (Exception e) {
			System.out.println("exception in reading "+labelKey+ " from hash table" + e);
		}

		return msg;

	}// end of function

	

}
