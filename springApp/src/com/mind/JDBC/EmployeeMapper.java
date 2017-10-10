package com.mind.JDBC;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class EmployeeMapper implements RowMapper<EmployeeBean>{

	public EmployeeBean mapRow(ResultSet rs, int rowNum) throws SQLException {
		EmployeeBean employee = new EmployeeBean();
		employee.setId(rs.getInt("id"));
		employee.setName(rs.getString("name"));
		employee.setAge(rs.getInt("age"));
		return employee;
   }
}
