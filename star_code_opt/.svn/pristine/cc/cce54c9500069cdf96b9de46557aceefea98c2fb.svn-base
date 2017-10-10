/**
 * TicketingServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package wsclient.matawebservice;

public class TicketingServiceLocator extends org.apache.axis.client.Service implements wsclient.matawebservice.TicketingService {

    public TicketingServiceLocator() {
    }


    public TicketingServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public TicketingServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for TicketingServiceSoap
    private java.lang.String TicketingServiceSoap_address = "http://mindnodas84/empronet/services/TicketingService.asmx";

    public java.lang.String getTicketingServiceSoapAddress() {
        return TicketingServiceSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String TicketingServiceSoapWSDDServiceName = "TicketingServiceSoap";

    public java.lang.String getTicketingServiceSoapWSDDServiceName() {
        return TicketingServiceSoapWSDDServiceName;
    }

    public void setTicketingServiceSoapWSDDServiceName(java.lang.String name) {
        TicketingServiceSoapWSDDServiceName = name;
    }

    public wsclient.matawebservice.TicketingServiceSoap getTicketingServiceSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(TicketingServiceSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getTicketingServiceSoap(endpoint);
    }

    public wsclient.matawebservice.TicketingServiceSoap getTicketingServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            wsclient.matawebservice.TicketingServiceSoapStub _stub = new wsclient.matawebservice.TicketingServiceSoapStub(portAddress, this);
            _stub.setPortName(getTicketingServiceSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setTicketingServiceSoapEndpointAddress(java.lang.String address) {
        TicketingServiceSoap_address = address;
    }


    // Use to get a proxy class for TicketingServiceSoap12
    private java.lang.String TicketingServiceSoap12_address = "http://mindnodas84/empronet/services/TicketingService.asmx";

    public java.lang.String getTicketingServiceSoap12Address() {
        return TicketingServiceSoap12_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String TicketingServiceSoap12WSDDServiceName = "TicketingServiceSoap12";

    public java.lang.String getTicketingServiceSoap12WSDDServiceName() {
        return TicketingServiceSoap12WSDDServiceName;
    }

    public void setTicketingServiceSoap12WSDDServiceName(java.lang.String name) {
        TicketingServiceSoap12WSDDServiceName = name;
    }

    public wsclient.matawebservice.TicketingServiceSoap getTicketingServiceSoap12() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(TicketingServiceSoap12_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getTicketingServiceSoap12(endpoint);
    }

    public wsclient.matawebservice.TicketingServiceSoap getTicketingServiceSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            wsclient.matawebservice.TicketingServiceSoap12Stub _stub = new wsclient.matawebservice.TicketingServiceSoap12Stub(portAddress, this);
            _stub.setPortName(getTicketingServiceSoap12WSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setTicketingServiceSoap12EndpointAddress(java.lang.String address) {
        TicketingServiceSoap12_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     * This service has multiple ports for a given interface;
     * the proxy implementation returned may be indeterminate.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (wsclient.matawebservice.TicketingServiceSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                wsclient.matawebservice.TicketingServiceSoapStub _stub = new wsclient.matawebservice.TicketingServiceSoapStub(new java.net.URL(TicketingServiceSoap_address), this);
                _stub.setPortName(getTicketingServiceSoapWSDDServiceName());
                return _stub;
            }
            if (wsclient.matawebservice.TicketingServiceSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                wsclient.matawebservice.TicketingServiceSoap12Stub _stub = new wsclient.matawebservice.TicketingServiceSoap12Stub(new java.net.URL(TicketingServiceSoap12_address), this);
                _stub.setPortName(getTicketingServiceSoap12WSDDServiceName());
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
        if ("TicketingServiceSoap".equals(inputPortName)) {
            return getTicketingServiceSoap();
        }
        else if ("TicketingServiceSoap12".equals(inputPortName)) {
            return getTicketingServiceSoap12();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://tempuri.org/", "TicketingService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "TicketingServiceSoap"));
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "TicketingServiceSoap12"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("TicketingServiceSoap".equals(portName)) {
            setTicketingServiceSoapEndpointAddress(address);
        }
        else 
if ("TicketingServiceSoap12".equals(portName)) {
            setTicketingServiceSoap12EndpointAddress(address);
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
