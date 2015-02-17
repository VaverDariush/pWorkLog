package org.wawer.pretiusWorkLog.mybatis.mapper;

public interface EmployeeMapper {
	
	public Integer autheticateEmployee(String usr, String pwHash);
	
}
