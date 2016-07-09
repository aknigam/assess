package com.assess.service.dao.impl;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Component;

import com.assess.service.dao.IAssessmnetAreaDao;
import com.assess.service.dao.impl.ReportDAO.QuestionDetails;
import com.assess.service.dao.impl.ReportDAO.RankingRSMapper;
import com.assess.service.entity.AssessmentArea;

@Component
public class AssessmnetAreaDao extends BaseDao  implements IAssessmnetAreaDao, InitializingBean {

	private static final String P_AA_NAME = "pAssessmentAreaName";

	private static final String P_AA_PNAME = "pParentAssessmentAreaName";

//	private static final AssessmentAreaComparator ASSESSMENT_AREA_COMPARATOR = new AssessmentAreaComparator();
	
	private static String m_insertAAQuery = "Insert into AssessmentArea (AssessmentAreaName, AssessmentAreaDescription, CustomerId) values (?,?,?)";
	
	private static String m_updateAAQuery = "Update AssessmentArea set (AssessmentAreaName, AssessmentAreaDescription, CustomerId) values (?,?,?)";
	
	@Autowired
	@Qualifier("assessdataSource")
	private DataSource m_dataSource;
	
	private SimpleJdbcCall m_AssessmentAreaParentUpdateSproc;
	
	@Override
	public void afterPropertiesSet() throws Exception {
		
		m_AssessmentAreaParentUpdateSproc = new SimpleJdbcCall(m_dataSource);
		m_AssessmentAreaParentUpdateSproc.useInParameterNames(P_AA_NAME, P_AA_PNAME)
		.declareParameters(
				new SqlParameter(P_AA_NAME, Types.VARCHAR),
				new SqlParameter(P_AA_PNAME, Types.VARCHAR)
		)
		.withProcedureName("AssessmentAreaParentUpdate")
		.withoutProcedureColumnMetaDataAccess();
		
	}



	
	@Override
	public void addAssessmentAreaHierarchy(final List<AssessmentArea> assessmentAreas) {


		try {

			for (AssessmentArea aa : assessmentAreas) {
			
				MapSqlParameterSource in = new MapSqlParameterSource();
				in.addValue(P_AA_NAME, aa.getAssessmentAreaName());
				in.addValue(P_AA_PNAME, aa.getParentAssessmentArea().getAssessmentAreaName());
				m_AssessmentAreaParentUpdateSproc.execute(in);
			}
			
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw e;
		}

	

		System.out.println("Done");
		
	}
	
	@Override
	public void addAssessmentAreas(final List<AssessmentArea> assessmentAreas) {
//		Collections.sort(assessmentAreas, ASSESSMENT_AREA_COMPARATOR);



		try {


			int[] updateCounts = m_assessDbTemplate.batchUpdate(
					m_insertAAQuery,
					new BatchPreparedStatementSetter() {
						public void setValues(PreparedStatement ps, int i) throws SQLException {
							ps.setString(1, assessmentAreas.get(i).getAssessmentAreaName());
							ps.setString(2, assessmentAreas.get(i).getAssessmentAreaDescription());
							ps.setInt(3, assessmentAreas.get(i).getCustomer().getCustomerId());
						}
						public int getBatchSize() {
							return assessmentAreas.size();
						}
					} );
			//        return updateCounts;
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw e;
		}

	

		System.out.println("Done");

	}
	
	static class AssessmentAreaComparator implements Comparator<AssessmentArea>
	{

		@Override
		public int compare(AssessmentArea o1, AssessmentArea o2) {
			if(o1.getParentAssessmentArea() == null && o2.getParentAssessmentArea()!= null)
				return 1;
			else 
				return 0;
		}
		
	}



}
