/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and proprietary to MIND and forms the part of the MIND 
*Created BY			:	Manoj Chand
*Date				:	07 OCt 2013
*Description		:	CLASS file to parse xml
*Project			:	STARS
**********************************************************/ 

package wsclient;

import java.io.IOException;
import java.io.StringReader;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.CharacterData;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

public class Parser {
	 
	 public String[] parsexmlstring(String xmlRecords){
	 
		String[] xmloutput = new String[2];
		try{
		
			DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
		    InputSource is = new InputSource();
		    is.setCharacterStream(new StringReader(xmlRecords));
	
		    Document doc;
			doc = db.parse(is);
		    NodeList nodes = doc.getElementsByTagName("result");
		    Element element = (Element) nodes.item(0);
		    
	        NodeList name = element.getElementsByTagName("can_cancel");
		    Element line = (Element) name.item(0);
		    xmloutput[0] = getCharacterDataFromElement(line);
	
	        NodeList title = element.getElementsByTagName("reason");
		    line = (Element) title.item(0);
		    xmloutput[1] = getCharacterDataFromElement(line);
		}catch(ParserConfigurationException e){
			System.out.println("1---->"+e.getMessage());
		}
		catch (SAXException e) {
			System.out.println("2---->"+e.getMessage());
		} catch (IOException e) {
			System.out.println("3---->"+e.getMessage());
		}
		return xmloutput;
	 }
	    
	 public String getCharacterDataFromElement(Element e) {
		    Node child = e.getFirstChild();
		    if (child instanceof CharacterData) {
		      CharacterData cd = (CharacterData) child;
		      return cd.getData();
		    }
		    return "";
		  }
}
