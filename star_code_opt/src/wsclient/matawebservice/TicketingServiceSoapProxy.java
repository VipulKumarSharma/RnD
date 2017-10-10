package wsclient.matawebservice;

public class TicketingServiceSoapProxy implements wsclient.matawebservice.TicketingServiceSoap {
  private String _endpoint = null;
  private wsclient.matawebservice.TicketingServiceSoap ticketingServiceSoap = null;
  
  public TicketingServiceSoapProxy() {
    _initTicketingServiceSoapProxy();
  }
  
  public TicketingServiceSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initTicketingServiceSoapProxy();
  }
  
  private void _initTicketingServiceSoapProxy() {
    try {
      ticketingServiceSoap = (new wsclient.matawebservice.TicketingServiceLocator()).getTicketingServiceSoap();
      if (ticketingServiceSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)ticketingServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)ticketingServiceSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (ticketingServiceSoap != null)
      ((javax.xml.rpc.Stub)ticketingServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public wsclient.matawebservice.TicketingServiceSoap getTicketingServiceSoap() {
    if (ticketingServiceSoap == null)
      _initTicketingServiceSoapProxy();
    return ticketingServiceSoap;
  }
  
  public java.lang.String getAdvanceDetail(java.lang.String strStarsREQ_ID, java.lang.String strEmpCode, java.lang.String strConID) throws java.rmi.RemoteException{
    if (ticketingServiceSoap == null)
      _initTicketingServiceSoapProxy();
    return ticketingServiceSoap.getAdvanceDetail(strStarsREQ_ID, strEmpCode, strConID);
  }
  
  public java.lang.String sendStarsReqDetailToERP(java.lang.String xmlstring) throws java.rmi.RemoteException{
    if (ticketingServiceSoap == null)
      _initTicketingServiceSoapProxy();
    return ticketingServiceSoap.sendStarsReqDetailToERP(xmlstring);
  }
  
  public java.lang.String sendSiteDetailToERP(java.lang.String xmlstring) throws java.rmi.RemoteException{
    if (ticketingServiceSoap == null)
      _initTicketingServiceSoapProxy();
    return ticketingServiceSoap.sendSiteDetailToERP(xmlstring);
  }
  
  public java.lang.String sendCompanyDetailToERP(java.lang.String xmlstring) throws java.rmi.RemoteException{
    if (ticketingServiceSoap == null)
      _initTicketingServiceSoapProxy();
    return ticketingServiceSoap.sendCompanyDetailToERP(xmlstring);
  }
  
  public java.lang.String sendExpenseEntryStatusToERP(java.lang.String xmlstring) throws java.rmi.RemoteException{
    if (ticketingServiceSoap == null)
      _initTicketingServiceSoapProxy();
    return ticketingServiceSoap.sendExpenseEntryStatusToERP(xmlstring);
  }
  
  public java.lang.String canCancelRequest(java.lang.String xmlstring, java.lang.String xmlOptstring) throws java.rmi.RemoteException{
    if (ticketingServiceSoap == null)
      _initTicketingServiceSoapProxy();
    return ticketingServiceSoap.canCancelRequest(xmlstring, xmlOptstring);
  }
  
  public java.lang.String cancelRequest(java.lang.String xmlstring, java.lang.String xmlOptstring) throws java.rmi.RemoteException{
    if (ticketingServiceSoap == null)
      _initTicketingServiceSoapProxy();
    return ticketingServiceSoap.cancelRequest(xmlstring, xmlOptstring);
  }
  
  
}