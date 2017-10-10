package com.mind.JDBC;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;

public class EmployeeDAOImpl implements EmployeeDAO {
	
	private DataSource dataSource;
	private SimpleJdbcCall jdbcCall;
	private JdbcTemplate jdbcTemplateObject;
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	
	public void setDataSource(DataSource dataSource) {
	   this.dataSource 					= dataSource;
	   this.jdbcTemplateObject			= new JdbcTemplate(dataSource);
	   this.namedParameterJdbcTemplate 	= new NamedParameterJdbcTemplate(dataSource);
	   this.jdbcCall 					= new SimpleJdbcCall(dataSource).withProcedureName("GET_EMPLOYEE");
	}

	public void create(String name, Integer age) {
		String SQL = "insert into EMP (name, age) values (:name, :age)";
		
		Map<String, Object> namedParameters = new HashMap<String,Object>();   
	    namedParameters.put("name", name);   
	    namedParameters.put("age", age);
	    namedParameterJdbcTemplate.update(SQL, namedParameters);
	      
      	System.out.println("Created Record Name = " + name + " Age = " + age);
      	return;
	}

	public EmployeeBean getEmployee(Integer id) {
		SqlParameterSource procParams = new MapSqlParameterSource()
		.addValue("P_id", id)
		.addValue("P_name", "")
		.addValue("P_age", 0);
		
		Map<String, Object> resultMap = jdbcCall.execute(procParams);

		EmployeeBean employee = new EmployeeBean();
		employee.setId(id);
		employee.setName((String) resultMap.get("P_name"));
		employee.setAge((Integer) resultMap.get("P_age"));

		return employee;
	}

	public List<EmployeeBean> listEmployees() {
	    String SQL = "select * from EMP";
	      
	    List <EmployeeBean> employees = namedParameterJdbcTemplate.query(SQL, new EmployeeMapper());
	    return employees;
	}
	
	public void delete(Integer id) {
		String SQL = "delete from EMP where id = :id";
		
		Map<String, Object> namedParameters = new HashMap<String,Object>();   
	    namedParameters.put("id", id);   
	    
		namedParameterJdbcTemplate.update(SQL, namedParameters);
		System.out.println("Deleted Record with ID = " + id );
		return;
	}

	public void update(Integer id, Integer age) {
		String SQL = "update EMP set age = ? where id = ?";
		
	    jdbcTemplateObject.update(SQL, age, id);
		System.out.println("Updated Record with ID = " + id);
		return;
	}
}
