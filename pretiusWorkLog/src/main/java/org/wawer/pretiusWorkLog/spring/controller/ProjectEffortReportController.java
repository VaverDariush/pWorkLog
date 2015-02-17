package org.wawer.pretiusWorkLog.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import org.wawer.pretiusWorkLog.mybatis.domain.ProjectEffortReport;
import org.wawer.pretiusWorkLog.mybatis.mapper.ProjectEffortReportMapper;

public class ProjectEffortReportController implements Controller {

	ProjectEffortReportMapper projectEffortReportMapper;
	
	public ModelAndView handleRequest(HttpServletRequest arg0,
			HttpServletResponse arg1) throws Exception {

		ModelAndView per = new ModelAndView("projectEffortReport");
		
		List<ProjectEffortReport> reportRows = projectEffortReportMapper.getProjectEffortReport();
		
		per.addObject("projectEffortReport", reportRows);
		
		return per;
	}

	public ProjectEffortReportMapper getProjectEffortReportMapper() {
		return projectEffortReportMapper;
	}

	public void setProjectEffortReportMapper(
			ProjectEffortReportMapper projectEffortReportMapper) {
		this.projectEffortReportMapper = projectEffortReportMapper;
	}

}
