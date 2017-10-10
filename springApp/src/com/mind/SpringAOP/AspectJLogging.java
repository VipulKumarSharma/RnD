package com.mind.SpringAOP;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class AspectJLogging {
	   
	   @Pointcut("execution(* com.mind.SpringAOP.*.*(..))")
	   private void pointCut() {
	   }

	   @Before("pointCut()")
	   public void beforeAdvice() {
	      System.out.println("Entering function...");
	   }

	   @After("pointCut()")
	   public void afterAdvice() {
	      System.out.println("Exiting function...");
	   }

	   @AfterReturning(pointcut = "pointCut()", returning="retVal")
	   public void afterReturningAdvice(Object retVal) {
	      System.out.println("Returning value from function : " + retVal.toString() );
	   }

	   @AfterThrowing(pointcut = "pointCut()", throwing = "ex")
	   public void AfterThrowingAdvice(IllegalArgumentException ex) {
	      System.out.println("There has been an exception in function : " + ex.toString());   
	   }
}
