package wsclient.mrswebservice;

public class MRSServiceSoapProxy implements wsclient.mrswebservice.MRSServiceSoap {
  private String _endpoint = null;
  private wsclient.mrswebservice.MRSServiceSoap mRSServiceSoap = null;
  
  public MRSServiceSoapProxy() {
    _initMRSServiceSoapProxy();
  }
  
  public MRSServiceSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initMRSServiceSoapProxy();
  }
  
  private void _initMRSServiceSoapProxy() {
    try {
      mRSServiceSoap = (new wsclient.mrswebservice.MRSServiceLocator()).getMRSServiceSoap();
      if (mRSServiceSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)mRSServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)mRSServiceSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (mRSServiceSoap != null)
      ((javax.xml.rpc.Stub)mRSServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public wsclient.mrswebservice.MRSServiceSoap getMRSServiceSoap() {
    if (mRSServiceSoap == null)
      _initMRSServiceSoapProxy();
    return mRSServiceSoap;
  }
  
  public java.lang.String THDtlService() throws java.rmi.RemoteException{
    if (mRSServiceSoap == null)
      _initMRSServiceSoapProxy();
    return mRSServiceSoap.THDtlService();
  }
  
  
}