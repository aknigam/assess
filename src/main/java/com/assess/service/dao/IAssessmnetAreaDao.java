package com.assess.service.dao;

import java.util.List;

import com.assess.service.entity.AssessmentArea;


public interface IAssessmnetAreaDao
{

	void addAssessmentAreas(List<AssessmentArea> assessmentAreas);

	void addAssessmentAreaHierarchy(List<AssessmentArea> assessmentAreas);

}
