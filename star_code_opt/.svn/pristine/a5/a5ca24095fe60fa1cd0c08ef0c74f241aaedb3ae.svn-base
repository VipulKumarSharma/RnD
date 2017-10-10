package wsclient.erpwebservice.mate;

public class ServiceSoapProxy implements wsclient.erpwebservice.mate.ServiceSoap {
  private String _endpoint = null;
  private wsclient.erpwebservice.mate.ServiceSoap serviceSoap = null;
  
  public ServiceSoapProxy() {
    _initServiceSoapProxy();
  }
  
  public ServiceSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initServiceSoapProxy();
  }
  
  private void _initServiceSoapProxy() {
    try {
      serviceSoap = (new wsclient.erpwebservice.mate.ServiceLocator()).getServiceSoap();
      if (serviceSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)serviceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)serviceSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (serviceSoap != null)
      ((javax.xml.rpc.Stub)serviceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public wsclient.erpwebservice.mate.ServiceSoap getServiceSoap() {
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap;
  }
  
  public java.lang.String sendStarsReqDetailToERP(java.lang.String xmlstring, java.lang.String xmlOptstring) throws java.rmi.RemoteException{
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap.sendStarsReqDetailToERP(xmlstring, xmlOptstring);
  }
  
  public java.lang.String setProjectFreezed(java.lang.String xmlstring, java.lang.String xmlOptstring) throws java.rmi.RemoteException{
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap.setProjectFreezed(xmlstring, xmlOptstring);
  }
  
  public java.lang.String allTicketInfo(java.lang.String xmlstring, java.lang.String xmlOptstring) throws java.rmi.RemoteException{
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap.allTicketInfo(xmlstring, xmlOptstring);
  }
  
  public java.lang.String getAdvanceDetail(java.lang.String xmlstring, java.lang.String xmlOptstring) throws java.rmi.RemoteException{
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap.getAdvanceDetail(xmlstring, xmlOptstring);
  }
  
  public java.lang.String sendSiteDetailToERP(java.lang.String xmlstring, java.lang.String xmlOptstring) throws java.rmi.RemoteException{
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap.sendSiteDetailToERP(xmlstring, xmlOptstring);
  }
  
  public java.lang.String sendInvoiceDetailToERP(java.lang.String xmlstring, java.lang.String xmlOptstring) throws java.rmi.RemoteException{
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap.sendInvoiceDetailToERP(xmlstring, xmlOptstring);
  }
  
  public java.lang.String sendTESDetailToERP(java.lang.String xmlstring, java.lang.String xmlOptstring) throws java.rmi.RemoteException{
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap.sendTESDetailToERP(xmlstring, xmlOptstring);
  }
  
  public java.lang.String canCancelRequest(java.lang.String xmlstring, java.lang.String xmlOptstring) throws java.rmi.RemoteException{
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap.canCancelRequest(xmlstring, xmlOptstring);
  }
  
  public java.lang.String cancelRequest(java.lang.String xmlstring, java.lang.String xmlOptstring) throws java.rmi.RemoteException{
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap.cancelRequest(xmlstring, xmlOptstring);
  }
  
  
}