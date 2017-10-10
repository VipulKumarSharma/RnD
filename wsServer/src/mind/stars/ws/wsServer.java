package mind.stars.ws;

import javax.jws.WebMethod;
import javax.jws.WebService;

import mind.stars.ws.impl.ProductServiceImpl;

@WebService(name="changedWSName", portName="changedWSportName", serviceName="changedServiceName")
public class wsServer {
	ProductServiceImpl psi = new ProductServiceImpl();
	
	@WebMethod(exclude=true)
	public void printMessage(){
		System.out.println("Message Printed");
	}
	
	@WebMethod
	public void getProducts(char category){
		System.out.println(psi.getProducts(category));
	}
	
	@WebMethod(exclude=true)
	public void getProductCategories(){
		System.out.println(psi.getProductCategories());
	}
	
}
