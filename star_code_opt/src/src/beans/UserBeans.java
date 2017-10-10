package src.beans;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="NEWDATASET")

public class UserBeans {
	
	@XmlElement(name="UserBean")
    private UserBean[] userBeans;

	public UserBean[] getUserBeans() {
		return userBeans;
	}

	public void setUserBeans(UserBean[] userBeans) {
		this.userBeans = userBeans;
	}
	
}
