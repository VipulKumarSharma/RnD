package com.mind.JDBC;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class StudentMapper implements RowMapper<StudentBean> {
	
	public StudentBean mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		StudentBean student = new StudentBean();
	    student.setId(rs.getInt("id"));
	    student.setName(rs.getString("name"));
	    student.setAge(rs.getInt("age"));
	    return student;
	}
}
