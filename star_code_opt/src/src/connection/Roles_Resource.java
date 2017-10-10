package src.connection;
/***************************************************
*Copyright (C) 2001 MIND
*All rights reserved.
*The information contained here in is confidential and
*proprietary to MIND and forms the part of the MIND

*CREATED BY		:Manoj Chand
*Date			:28-10-2013
*Project 		:STARS
*DESCRIPTION    :This class is a factory class creating instance of RolesResourceBinding
**********************************************************/

public class Roles_Resource {

	RolesResourceBinding roleRGenerator=null;
	
	public Roles_Resource(){		
		roleRGenerator=RolesResourceBinding.getInstance();	
	} 
	
	public  String  getRolesList(String resouceUrl)
	{
		return roleRGenerator.getRole(resouceUrl);
	}	
	
	public void getUpdatedRoles() {
		roleRGenerator = roleRGenerator.getUpdatedRoles();
	}
}
