/**
 * MRSServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package wsclient.mrswebservice;

public class MRSServiceLocator extends org.apache.axis.client.Service implements wsclient.mrswebservice.MRSService {

    public MRSServiceLocator() {
    }


    public MRSServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public MRSServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for MRSServiceSoap
    private java.lang.String MRSServiceSoap_address = "http://172.29.55.243/MRSWebService/MRSService.asmx";

    public java.lang.String getMRSServiceSoapAddress() {
        return MRSServiceSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String MRSServiceSoapWSDDServiceName = "MRSServiceSoap";

    public java.lang.String getMRSServiceSoapWSDDServiceName() {
        return MRSServiceSoapWSDDServiceName;
    }

    public void setMRSServiceSoapWSDDServiceName(java.lang.String name) {
        MRSServiceSoapWSDDServiceName = name;
    }

    public wsclient.mrswebservice.MRSServiceSoap getMRSServiceSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(MRSServiceSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getMRSServiceSoap(endpoint);
    }

    public wsclient.mrswebservice.MRSServiceSoap getMRSServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
        	wsclient.mrswebservice.MRSServiceSoapStub _stub = new wsclient.mrswebservice.MRSServiceSoapStub(portAddress, this);
            _stub.setPortName(getMRSServiceSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setMRSServiceSoapEndpointAddress(java.lang.String address) {
        MRSServiceSoap_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (wsclient.mrswebservice.MRSServiceSoap.class.isAssignableFrom(serviceEndpointInterface)) {
            	wsclient.mrswebservice.MRSServiceSoapStub _stub = new wsclient.mrswebservice.MRSServiceSoapStub(new java.net.URL(MRSServiceSoap_address), this);
                _stub.setPortName(getMRSServiceSoapWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("MRSServiceSoap".equals(inputPortName)) {
            return getMRSServiceSoap();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://tempuri.org/", "MRSService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "MRSServiceSoap"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("MRSServiceSoap".equals(portName)) {
            setMRSServiceSoapEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
