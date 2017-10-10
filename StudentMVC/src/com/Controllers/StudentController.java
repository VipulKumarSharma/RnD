package com.Controllers;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.ModelMap;

import com.Beans.Student;
import com.ExceptionHandling.SpringException;

@Controller
public class StudentController {
	Logger logger = Logger.getLogger(StudentController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView student() {
		
		logger.info("\n******************************************************");
		logger.info("Student Form\n");
		return new ModelAndView("student", "command", new Student());
	}

	@RequestMapping(value = "/addStudent", method = RequestMethod.POST)
	@ExceptionHandler({SpringException.class})
	public String addStudent(@ModelAttribute("StudentApp")Student student, ModelMap model) {
		
		logger.info("\n******************************************************");
		logger.info("Adding Student : "+ student.getName()+"\n");
		
		if(student.getName().length() < 5 ) {
			logger.error("Given name is too short");
	        throw new SpringException("Given name is too short");
	        
		} else {
	       model.addAttribute("name", student.getName());
	    }
	      
	    if( student.getAge() < 10 ) {
	    	logger.error("Given age is too low");
	    	throw new SpringException("Given age is too low");
	    	
	    } else {
	    	model.addAttribute("age", student.getAge());
	    }
	    
	    model.addAttribute("id", student.getId());
		return "result";
	}
	
	@RequestMapping(value = "/staticPage", method = RequestMethod.GET)
	public String redirect() {
		
		logger.info("\n******************************************************");
		logger.info("Student Information\n");
		return "redirect:/pages/final.htm";
	}
}
