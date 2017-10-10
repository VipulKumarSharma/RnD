package src.beans;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="NEWDATASET")

public class VisaBeanList<T> 
{
	private List<VisaBean> visaBean;
	public List<VisaBean> getVisaBean() {
		return visaBean;
	}
	public void setVisaBean(List<VisaBean> visaBean) {
		this.visaBean = visaBean;
	}

}
