package beans;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.*;

public class XMLtoArray {

	public static void main(String[] args) throws Exception {
			
		JAXBContext jc = JAXBContext.newInstance(UserBeanList.class);
		Unmarshaller unmarshaller = jc.createUnmarshaller();
		
		try {
			String xmlString = "<NEWDATASET><UserBean><NAME>Rajay Kumar</NAME><DOB>1987-02-03</DOB><DESIG>Project Manager</DESIG><MOBILE_NO>9856986523</MOBILE_NO></UserBean><UserBean><NAME>Varun Kumar</NAME><DOB>1989-09-27</DOB><DESIG>Team Leader</DESIG><MOBILE_NO>9754856566</MOBILE_NO></UserBean></NEWDATASET>";
			
			File file = new File("GroupUserDetails.xml");
			
			if(!file.exists()) {
				file.createNewFile();
			} else {
				PrintWriter writer = new PrintWriter(file);
				writer.print("");
				writer.close();
			}
			
			FileWriter fileWritter = new FileWriter(file.getName(),true);
	        BufferedWriter bufferWritter = new BufferedWriter(fileWritter);
	        bufferWritter.write(xmlString);
	        bufferWritter.close();
		
			UserBeanList ubl = (UserBeanList) unmarshaller.unmarshal(file);
			
			List names 		= new ArrayList();
			List dobs 		= new ArrayList();
			List desigs 	= new ArrayList();
			List mobNos 	= new ArrayList();
			
			for(UserBean ub : ubl.getUserBean()) {
		        names.add(ub.getName());
		        dobs.add(ub.getDob());
		        desigs.add(ub.getDesig());
		        mobNos.add(ub.getMobileNo());
			}
			if (file.exists()){
	             file.delete();
	        }
			System.out.println(names+" "+dobs+" "+desigs+" "+mobNos);
			//System.out.println(names.get(1));
		/*
			File xml = new File("input.xml");
			UserBeanList root = (UserBeanList) unmarshaller.unmarshal(xml);
			 
			Marshaller marshaller = jc.createMarshaller();
	        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
	        marshaller.marshal(root, System.out);
        */
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
