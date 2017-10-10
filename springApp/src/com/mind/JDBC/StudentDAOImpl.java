package com.mind.JDBC;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

public class StudentDAOImpl implements StudentDAO {
	
	   private DataSource dataSource;
	   private JdbcTemplate jdbcTemplateObject;
	   
	   public void setDataSource(DataSource dataSource) {
	      this.dataSource = dataSource;
	      this.jdbcTemplateObject = new JdbcTemplate(dataSource);
	   }

	   public void create(String name, Integer age) {
	      String SQL = "insert into Student (name, age) values (?, ?)";
	      
	      jdbcTemplateObject.update( SQL, name, age);
	      System.out.println("Created Record Name = " + name + " Age = " + age);
	      return;
	   }

	   public StudentBean getStudent(Integer id) {
	      String SQL 			= null;
	      StudentBean student 	= null;
	      
	      SQL 		= "select * from Student where id = ?";
	      student 	= jdbcTemplateObject.queryForObject(SQL, new Object[]{id}, new StudentMapper());
	      
	      return student;
	   }

	   public List<StudentBean> listStudents() {
	      String SQL 					= null;
	      List <StudentBean> students 	= null;
	      
	      SQL 		= "select * from Student";
	      students 	= jdbcTemplateObject.query(SQL, new StudentMapper());
	      
	      return students;
	   }

	   public void delete(Integer id) {
	      String SQL = "delete from Student where id = ?";
	      
	      jdbcTemplateObject.update(SQL, id);
	      System.out.println("Deleted Record with ID = " + id );
	      return;
	   }

	   public void update(Integer id, Integer age) {
	      String SQL = "update Student set age = ? where id = ?";
	      
	      jdbcTemplateObject.update(SQL, age, id);
	      System.out.println("Updated Record with ID = " + id );
	      return;
	   }
}
