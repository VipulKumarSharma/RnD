package beans;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="NEWDATASET")

public class UserBeanList {

	@XmlElement(name="UserBean")
    private UserBean[] userBean;
	
	public UserBean[] getUserBean() {
		return userBean;
	}

	public void setUserBean(UserBean[] userBean) {
		this.userBean = userBean;
	}

}
