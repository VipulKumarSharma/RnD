/**
 * ServiceSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package wsclient.erpwebservice.mind;

public interface ServiceSoap extends java.rmi.Remote {

    /**
     * This method is used When new site is create in STARS then data
     * will push in eMpro.
     */
    public java.lang.String sendSiteDetailToERP(java.lang.String xmlstring, java.lang.String xmlParamString) throws java.rmi.RemoteException;

    /**
     * This method is used When STAR req is authorized then data will
     * push in eMpro.
     */
    public java.lang.String sendStarsReqDetailToERP(java.lang.String xmlstring, java.lang.String xmlParamString) throws java.rmi.RemoteException;

    /**
     * This method is used To Push Invoice Details from MATA for PV
     * booking in eMpro.
     */
    public java.lang.String sendInvoiceDetailToERP(java.lang.String xmlstring, java.lang.String xmlParamString) throws java.rmi.RemoteException;
}
