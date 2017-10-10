package wsclient.erpwebservice.mind;

public class ServiceSoapProxy implements wsclient.erpwebservice.mind.ServiceSoap {
  private String _endpoint = null;
  private wsclient.erpwebservice.mind.ServiceSoap serviceSoap = null;
  
  public ServiceSoapProxy() {
    _initServiceSoapProxy();
  }
  
  public ServiceSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initServiceSoapProxy();
  }
  
  private void _initServiceSoapProxy() {
    try {
      serviceSoap = (new wsclient.erpwebservice.mind.ServiceLocator()).getServiceSoap();
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
  
  public wsclient.erpwebservice.mind.ServiceSoap getServiceSoap() {
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap;
  }
  
  public java.lang.String sendSiteDetailToERP(java.lang.String xmlstring, java.lang.String xmlParamString) throws java.rmi.RemoteException{
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap.sendSiteDetailToERP(xmlstring, xmlParamString);
  }
  
  public java.lang.String sendStarsReqDetailToERP(java.lang.String xmlstring, java.lang.String xmlParamString) throws java.rmi.RemoteException{
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap.sendStarsReqDetailToERP(xmlstring, xmlParamString);
  }
  
  public java.lang.String sendInvoiceDetailToERP(java.lang.String xmlstring, java.lang.String xmlParamString) throws java.rmi.RemoteException{
    if (serviceSoap == null)
      _initServiceSoapProxy();
    return serviceSoap.sendInvoiceDetailToERP(xmlstring, xmlParamString);
  }
  
  
}