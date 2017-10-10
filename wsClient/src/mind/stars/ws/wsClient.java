package mind.stars.ws;

import webService.WsServer;
import webService.WsServerService;

public class wsClient {

	public static void main(String args[]){
		
		WsServerService service = new WsServerService();
		WsServer server = service.getWsServerPort();
		server.printMessage();
		server.getProducts('b');
		server.getProductCategories();
	}
}
