package com.mind.AutoWireAnnotations;

import org.springframework.beans.factory.annotation.Autowired;

public class StudentAutoWired {
   private Integer age;
   private String name;

   @Autowired
   public void setName(String name) {
      this.name = name;
   }
   public String getName() {
      return name;
   }
   
   @Autowired(required=false)
   public void setAge(Integer age) {
      this.age = age;
   }
   public Integer getAge() {
      return age;
   }
}