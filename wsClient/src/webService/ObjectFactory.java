
package webService;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the webService package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _GetProductCategoriesResponse_QNAME = new QName("http://ws.stars.mind/", "getProductCategoriesResponse");
    private final static QName _PrintMessage_QNAME = new QName("http://ws.stars.mind/", "printMessage");
    private final static QName _PrintMessageResponse_QNAME = new QName("http://ws.stars.mind/", "printMessageResponse");
    private final static QName _GetProducts_QNAME = new QName("http://ws.stars.mind/", "getProducts");
    private final static QName _GetProductCategories_QNAME = new QName("http://ws.stars.mind/", "getProductCategories");
    private final static QName _GetProductsResponse_QNAME = new QName("http://ws.stars.mind/", "getProductsResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: webService
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link GetProductCategories }
     * 
     */
    public GetProductCategories createGetProductCategories() {
        return new GetProductCategories();
    }

    /**
     * Create an instance of {@link GetProductsResponse }
     * 
     */
    public GetProductsResponse createGetProductsResponse() {
        return new GetProductsResponse();
    }

    /**
     * Create an instance of {@link GetProductCategoriesResponse }
     * 
     */
    public GetProductCategoriesResponse createGetProductCategoriesResponse() {
        return new GetProductCategoriesResponse();
    }

    /**
     * Create an instance of {@link PrintMessage }
     * 
     */
    public PrintMessage createPrintMessage() {
        return new PrintMessage();
    }

    /**
     * Create an instance of {@link PrintMessageResponse }
     * 
     */
    public PrintMessageResponse createPrintMessageResponse() {
        return new PrintMessageResponse();
    }

    /**
     * Create an instance of {@link GetProducts }
     * 
     */
    public GetProducts createGetProducts() {
        return new GetProducts();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetProductCategoriesResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.stars.mind/", name = "getProductCategoriesResponse")
    public JAXBElement<GetProductCategoriesResponse> createGetProductCategoriesResponse(GetProductCategoriesResponse value) {
        return new JAXBElement<GetProductCategoriesResponse>(_GetProductCategoriesResponse_QNAME, GetProductCategoriesResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link PrintMessage }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.stars.mind/", name = "printMessage")
    public JAXBElement<PrintMessage> createPrintMessage(PrintMessage value) {
        return new JAXBElement<PrintMessage>(_PrintMessage_QNAME, PrintMessage.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link PrintMessageResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.stars.mind/", name = "printMessageResponse")
    public JAXBElement<PrintMessageResponse> createPrintMessageResponse(PrintMessageResponse value) {
        return new JAXBElement<PrintMessageResponse>(_PrintMessageResponse_QNAME, PrintMessageResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetProducts }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.stars.mind/", name = "getProducts")
    public JAXBElement<GetProducts> createGetProducts(GetProducts value) {
        return new JAXBElement<GetProducts>(_GetProducts_QNAME, GetProducts.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetProductCategories }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.stars.mind/", name = "getProductCategories")
    public JAXBElement<GetProductCategories> createGetProductCategories(GetProductCategories value) {
        return new JAXBElement<GetProductCategories>(_GetProductCategories_QNAME, GetProductCategories.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetProductsResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.stars.mind/", name = "getProductsResponse")
    public JAXBElement<GetProductsResponse> createGetProductsResponse(GetProductsResponse value) {
        return new JAXBElement<GetProductsResponse>(_GetProductsResponse_QNAME, GetProductsResponse.class, null, value);
    }

}
