package com.mind;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.mind.EventHandling.CustomEventPublisher;
import com.mind.JDBC.EmployeeBean;
import com.mind.JDBC.EmployeeDAOImpl;
import com.mind.JDBC.StudentBean;
import com.mind.JDBC.StudentDAOImpl;
import com.mind.SpringAOP.Student;

public class MainApp {

	private static final Log log 		= LogFactory.getLog(MainApp.class.getName());
	private static final Logger logger 	= Logger.getLogger(MainApp.class);
	
	public static void main(String[] args) {
		
		logger.info("******************************************************************");
		logger.info("Log4j :: Starting Application.");
		logger.info("******************************************************************\n");
		
		ApplicationContext context = new ClassPathXmlApplicationContext("configBeans/Beans.xml");
		logger.setLevel(Level.WARN);
		
		logger.fatal("***** Fatal Hehehehehe...");
		logger.error("***** Error Hehehehehe...");
		logger.warn("***** Warn Hehehehehe...");
		logger.info("***** Info Hehehehehe...");
		logger.debug("***** Debug Hehehehehe...");
		logger.trace("***** Trace Hehehehehe...");
		
		log.fatal("***** Logging :: Fatal Hehehehehe...");
		log.error("***** Logging :: Error Hehehehehe...");
		log.warn("***** Logging :: Warn Hehehehehe...");
		log.info("***** Logging :: Info Hehehehehe...");
		log.debug("***** Logging :: Debug Hehehehehe...");
		log.trace("***** Logging :: Trace Hehehehehe...");
		
		SpringWorld objA = (SpringWorld) context.getBean("springworld");
      	objA.setMessage("I'm object A");
      	objA.getMessage();

      	SpringWorld objB = (SpringWorld) context.getBean("springworld");
      	objB.getMessage();
      	
		/********************************************** BEANS INITIALIZATION, DESTRUCTION ****************************
		
		AbstractApplicationContext abstAppContext 	= new ClassPathXmlApplicationContext("/configBeans/Beans.xml");
		
	    SpringWorld obj = (SpringWorld) abstAppContext.getBean("springworld");
	    obj.getMessage();
	      
	    abstAppContext.registerShutdownHook();
	    */
		
	    /********************************************** BEANS INHERITANCE ********************************************
	    
	    ApplicationContext appContext = new ClassPathXmlApplicationContext("./configBeans/BeansInheritance.xml");

	    HelloWorld helloWorld = (HelloWorld) appContext.getBean("helloWorld");
	    helloWorld.getMessage1();
	    helloWorld.getMessage2();

	    HelloIndia helloIndia = (HelloIndia) appContext.getBean("helloIndia");
	    helloIndia.getMessage1();
	    helloIndia.getMessage2();
	    helloIndia.getMessage3();
	    */
		
	    /********************************************** BEANS TEMPLATE ***********************************************
	    
	    ApplicationContext appContextNew = new ClassPathXmlApplicationContext("configBeans/BeansTemplate.xml");

	    HelloIndia hI = (HelloIndia) appContextNew.getBean("helloIndia");
	    hI.getMessage1();
	    hI.getMessage2();
	    hI.getMessage3();
	    */
		
	    /********************************************** CONSTRUCTOR DI BEANS *****************************************
	    
	    ApplicationContext DIcontext = new FileSystemXmlApplicationContext("D:/WorkStation/Eclipse_WorkSpace/springApp/src/configBeans/ConstructorDIBeans.xml");
	    
	    TextEditor te = (TextEditor) DIcontext.getBean("textEditor");
	    te.spellCheck();
	    
	    // Using XmlBeanFactory instead of ApplicationContext
	    XmlBeanFactory DIArgsBeanFactory = new XmlBeanFactory(new ClassPathResource("configBeans/ConstructorArgsDIBeans.xml"));
	    
	    DependencyInjection di = (DependencyInjection) DIArgsBeanFactory.getBean("dependencyInjection");
	    di.dependencyInjectionFunc();
	    */
		
		/********************************************** SETTER BASED DI BEANS ****************************************
		
		ApplicationContext appCtxt = new ClassPathXmlApplicationContext("/configBeans/SetterBasedDIBeans.xml");

		TextEditorSet tes = (TextEditorSet) appCtxt.getBean("textEditorSet");
	    tes.spellCheck();
	    
	    ApplicationContext appContext = new ClassPathXmlApplicationContext("/configBeans/PnamespaceDIBeans.xml");
	    
	    PersonJohnDoe jd = (PersonJohnDoe) appContext.getBean("john-classic");
	    jd.JohnDoeFunc();
	    */
		
		/********************************************** INNER DI BEANS ***********************************************
		
		ApplicationContext appCtxt = new ClassPathXmlApplicationContext("/configBeans/InnerDIBeans.xml");

		TextEditorSet tes = (TextEditorSet) appCtxt.getBean("innerTextEditorSet");
	    tes.spellCheck();
	    */
	    
		/********************************************** COLLECTIONS DI BEANS *****************************************
	    ApplicationContext appContext = new ClassPathXmlApplicationContext("./configBeans/JavaCollectionBeans.xml");
	    
	    JavaCollection jc = (JavaCollection) appContext.getBean("javaCollection");
	    jc.getAddressList();
	    jc.getAddressSet();
	    jc.getAddressMap();
	    jc.getAddressProp();
	    
	    CollectionInjection ci = (CollectionInjection) appContext.getBean("collectionInjection");
	    ci.getAddressList();
	    ci.getAddressSet();
	    ci.getAddressMap();
	    */
		
		/********************************************** AUTOWIRE BY NAME *********************************************
		ApplicationContext appContext = new ClassPathXmlApplicationContext("./configBeans/AutowireByNameBeans.xml");
		
		TextEditorSet tes = (TextEditorSet) appContext.getBean("textEditorSet");
	    tes.spellCheck();
	    */
	    
	    /********************************************** AUTOWIRE BY TYPE *********************************************
		ApplicationContext appContext = new ClassPathXmlApplicationContext("./configBeans/AutowireByTypeBeans.xml");
		
		TextEditorSet tes = (TextEditorSet) appContext.getBean("textEditorSet");
	    tes.spellCheck();
	    */
	    
		/********************************************** AUTOWIRE BY CONSTRUCTOR **************************************
		ApplicationContext appContext = new ClassPathXmlApplicationContext("./configBeans/AutowireByConstructorBeans.xml");
		
		TextEditor tes = (TextEditor) appContext.getBean("textEditor");
	    tes.spellCheck();
	    */
		
		/********************************************** AUTOWIRE REQUIRED ANNOTATION *********************************
		ApplicationContext appContext = new ClassPathXmlApplicationContext("./configBeans/RequiredAutowireBeans.xml");
		
		Student student = (Student) appContext.getBean("student");
		System.out.println("Name : " + student.getName() );
	    System.out.println("Age  : " + student.getAge() );
	    */
		
		/********************************************** AUTOWIRED ****************************************************
		ApplicationContext appContext = new ClassPathXmlApplicationContext("./configBeans/RequiredAutowireBeans.xml");
		
		AutoWired aw = (AutoWired) appContext.getBean("autoWired");
		aw.spellCheck();
		
		StudentAutoWired saw = (StudentAutoWired) appContext.getBean("studentAutoWired");
		System.out.println("Name : " + saw.getName() );
	    System.out.println("Age  : " + saw.getAge() );
	    
	    Profile profile = (Profile) appContext.getBean("profile");
	    profile.printName();
	    profile.printAge();
	    */
		
	    /********************************************** AUTOWIRED CONSTRUCT DESTROY **********************************
	    AbstractApplicationContext aac = new ClassPathXmlApplicationContext("./configBeans/AutoWiredConstructDestroyBeans.xml");
	    
	    ConstructDestroy cd = (ConstructDestroy) aac.getBean("contructDestroy");
	    cd.getMessage();
	    aac.registerShutdownHook();
	    */
		
		/********************************************** AUTOWIRED RESOURCE *******************************************
		ApplicationContext appContext = new ClassPathXmlApplicationContext("./configBeans/AutoWiredResource.xml");
		
		AutoWiredResource aRes = (AutoWiredResource) appContext.getBean("autoWiredResource");
	    aRes.spellCheck();
		*/
		
		/********************************************** JAVA BASED CONFIGURATION *************************************
		ApplicationContext ctx = new AnnotationConfigApplicationContext(SpringWorldConfig.class);
			   
		SpringWorld springWorld = ctx.getBean(SpringWorld.class);
		springWorld.setMessage("Hello Spring World!");
		springWorld.getMessage();
		
		ApplicationContext ctxNew = new AnnotationConfigApplicationContext(TextEditorConfig.class);

		TextEditor te = ctxNew.getBean(TextEditor.class);
		te.spellCheck();
		*/
		
		/********************************************** LIFECYCLE CALLBACKS *******************************************
		AbstractApplicationContext absAC = new AnnotationConfigApplicationContext(LifecycleCallback.class);
		
		Foo lc = absAC.getBean(Foo.class);
		lc.fooFunc();
		
		absAC.registerShutdownHook();
		*/
		
		/********************************************** EVENT HANDLING ************************************************
		ConfigurableApplicationContext context = new ClassPathXmlApplicationContext("./configBeans/EventHandlingBeans.xml");
		context.start();
	  
		SpringWorld sw = (SpringWorld) context.getBean("springWorld");
		sw.getMessage();

		context.stop();
		
		CustomEventPublisher cvp = (CustomEventPublisher) context.getBean("customEventPublisher");
		cvp.publish();  
		cvp.publish();
		*/
		
		/********************************************** SPRING AOP ****************************************************
		ApplicationContext context = new ClassPathXmlApplicationContext("./configBeans/AOPBeans.xml");

	    Student student = (Student) context.getBean("student");

	    student.getName();
	    student.getAge();
	    student.printThrowException();
	    */
	    
		
		/********************************************** ASPECTJ AOP ***************************************************
	    ApplicationContext ctxt = new ClassPathXmlApplicationContext("./configBeans/AspectJAOPBeans.xml");

	    Student stu = (Student) ctxt.getBean("student");

	    stu.getName();
	    stu.getAge();
	    stu.printThrowException();
		*/
		
		/********************************************** SPRING SIMPLE JDBC ********************************************
		ApplicationContext context = new ClassPathXmlApplicationContext("./configBeans/JDBCBeans.xml");

	    StudentDAOImpl studentImpl = (StudentDAOImpl) context.getBean("studentImpl");
	      
	    System.out.println("****** Student Records Creation ******" );
	    studentImpl.create("Zara", 11);
	    studentImpl.create("Nuha", 2);
	    studentImpl.create("Ayan", 15);

	    System.out.println("****** Listing Multiple Records ******" );
	    List<StudentBean> students = studentImpl.listStudents();
	    for (StudentBean record : students) {
	    	System.out.print("[ID : " + record.getId()+"]");
	    	System.out.print(", [Name : " + record.getName()+"]" );
	    	System.out.println(", [Age : " + record.getAge()+"]" );
	    }

	    System.out.println("****** Updating Record with ID = 2 ******" );
	    studentImpl.update(2, 20);
		
		System.out.println("****** Deleting Record with ID = 3 ******" );
	    studentImpl.delete(3);
	    
	    System.out.println("****** Listing Record with ID = 2 ******" );
	    StudentBean student = studentImpl.getStudent(2);
	    System.out.print("[ID : " + student.getId()+"]" );
	    System.out.print(", [Name : " + student.getName()+"]" );
	    System.out.println(", [Age : " + student.getAge()+"]" );
	    */
		
		/********************************************** JDBC PROCEDURE CALLING ****************************************
		ApplicationContext context 		= new ClassPathXmlApplicationContext("./configBeans/JDBCBeans.xml");
		
		EmployeeDAOImpl employeeImpl 	= (EmployeeDAOImpl)context.getBean("employeeImpl");
	    	      
	    System.out.println("\n\n****** Records Creation ******" );
	    employeeImpl.create("Amit", 56);
	    employeeImpl.create("Suraj", 33);
	    employeeImpl.create("Neeraj", 45);

	    System.out.println("\n****** Listing Multiple Records ******" );
	    List<EmployeeBean> employees = employeeImpl.listEmployees();
	    for (EmployeeBean record : employees) {
	    	System.out.print("[ID : " + record.getId()+"]" );
	    	System.out.print(", [Name : " + record.getName()+"]" );
	    	System.out.println(", [Age : " + record.getAge()+"]");
	    }
		
		System.out.println("****** Updating Record with ID = 1 ******" );
		employeeImpl.update(1, 99);
		
		System.out.println("****** Deleting Record with ID = 3 ******" );
		employeeImpl.delete(3);
	    
	    System.out.println("\n****** Listing Record with ID = 1 ******" );
	    EmployeeBean employee = employeeImpl.getEmployee(1);
	    System.out.print("[ID : " + employee.getId()+"]");
	    System.out.print(", [Name : " + employee.getName()+"]");
	    System.out.println(", [Age : " + employee.getAge()+"]");
	    */
		
      	logger.info("\n******************************************************************");
      	logger.info("Log4j :: Stopping Application.");
      	logger.info("******************************************************************");
	}
}
