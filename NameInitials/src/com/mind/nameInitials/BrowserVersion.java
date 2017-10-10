package com.mind.nameInitials;

public class BrowserVersion {

	public static void main(String[] args) {
		String IE = "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko";
		String EZ = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Safari/537.36 Edge/13.10586";
		String CH = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36";
		String MZ = "Mozilla/5.0 (Windows NT 6.3; WOW64; rv:30.0) Gecko/20100101 Firefox/30.0";
		String browserType = "";
		//System.out.println(IE);
		 if (IE.indexOf("rv") >0 && IE.indexOf("Trident") >0 && IE.indexOf("Chrome") ==-1 && IE.indexOf("Firefox") ==-1 && IE.indexOf("Safari") ==-1 && IE.indexOf("AppleWebKit") ==-1) {
			 browserType = "IE v"+IE.substring(IE.indexOf("rv")+3,IE.indexOf(")"));
			 System.out.println(browserType);
		 }
		 if (EZ.indexOf("Edge") >0 && EZ.indexOf("Trident") ==-1 && EZ.indexOf("Firefox") ==-1) {
			 browserType = "EDGE v"+EZ.substring(EZ.indexOf("Edge")+5);
			 System.out.println(browserType);
		 }
		 if (CH.indexOf("Chrome") >0 && CH.indexOf("Trident") ==-1 && CH.indexOf("Firefox") ==-1) {
			 browserType = "CHROME v"+CH.substring(CH.indexOf("Chrome")+7,CH.indexOf(" Safari"));
			 System.out.println(browserType);
		 }
		 if (MZ.indexOf("Firefox") >0 && MZ.indexOf("Trident") ==-1 && MZ.indexOf("Chrome") ==-1 && MZ.indexOf("Safari") ==-1 && MZ.indexOf("AppleWebKit") ==-1) {
			 browserType = "FIREFOX v"+MZ.substring(MZ.indexOf("Firefox")+8);
			 System.out.println(browserType);
		 }
		 /*if (browserType.equals("")) {
			String browsername = "";
 			String browserversion = "";
 			String browser = request.getHeader("User-Agent");
 			String browserSubString[] = { "MSIE", "Firefox", "Chrome", "Opera","Netscape", "Safari" };
 			String subsString = "";
 			
 			if (browser.contains("MSIE")) {
 							subsString = browser.substring(browser.indexOf("MSIE"));
 							String Info[] = (subsString.split(";")[0]).split(" ");
 							browsername = Info[0];
 							browserversion = Info[1];
 			} else {
 				for (int index = 1; index < browserSubString.length; index++) {
 					if (browser.contains(browserSubString[index])) {
 						subsString = browser.substring(browser.indexOf(browserSubString[index]));
 						String Info[] = (subsString.split(" ")[0]).split("/");
 						browsername = Info[0];

 						if (browser.indexOf("Version") != -1) {
 							browserversion = browser.substring(browser.indexOf("Version")).split(" ")[0].split(";")[0].split("/")[1];
 						} else {
 							browserversion = Info[1];
 						}
 						break;
 					}
 				}
 				if (browsername.equals("")) {
 					subsString = browser.substring(browser.indexOf("Windows NT"));
 					browsername = subsString.split(";")[0];
 					subsString = browser.substring(browser.indexOf("Trident"));
 					browserversion = subsString.split(";")[0];
 				}
 			}
 			System.out.println(browser);
 			System.out.println(browsername + " " + browserversion+"\n");
		 }*/
	}

}
