package beans;

import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlElement;


@XmlAccessorType(XmlAccessType.FIELD)

public class UserBean {

	@XmlElement(name = "NAME")
	private String name 	= "" ;
	
	@XmlElement(name = "DOB")
	private String dob		= "" ;
	
	@XmlElement(name = "DESIG")
	private String desig	= "" ;
	
	@XmlElement(name = "MOBILE_NO")
	private String mobileNo	= "" ;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getDesig() {
		return desig;
	}

	public void setDesig(String desig) {
		this.desig = desig;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	
	
}
