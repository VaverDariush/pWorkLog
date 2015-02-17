package org.wawer.pretiusWorkLog.mybatis.domain;

import java.io.Serializable;
import java.math.BigDecimal;

public class ProjectEffortReport implements Serializable {
	
	private static final long serialVersionUID = 3546209556677374607L;
	
	String clientName;
	String projectName;
	BigDecimal amountHours;
	String workDate;
	
	public ProjectEffortReport() {
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public BigDecimal getAmountHours() {
		return amountHours;
	}

	public void setAmountHours(BigDecimal amountHours) {
		this.amountHours = amountHours;
	}

	public String getWorkDate() {
		return workDate;
	}

	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}
	
	
}
