package org.wawer.pretiusWorkLog.mybatis.domain;

import java.io.Serializable;

public class Employee implements Serializable {
	
	private static final long serialVersionUID = 4578857605897040232L;
	
	int employeeId;
	String firstName;
	String lastName;
	String username;
	String pwHash;
	boolean adminPrivilege;
	
	public Employee() {
	}

	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPwHash() {
		return pwHash;
	}

	public void setPwHash(String pwHash) {
		this.pwHash = pwHash;
	}

	public boolean isAdminPrivilege() {
		return adminPrivilege;
	}

	public void setAdminPrivilege(boolean adminPrivilege) {
		this.adminPrivilege = adminPrivilege;
	}
	
	
}
