package com.assess.service.dao.impl;

import java.sql.Types;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Component;

import com.assess.service.dao.IRatingScaleDAO;
import com.assess.service.entity.RatingScale;

@Component
public class RatingScaleDAO extends BaseDao implements IRatingScaleDAO , InitializingBean{

	private static final String P_SCALE_NAME = "pRatingScaleName";
	private static final String P_CUSTOMER_PNAME = "pCustomerName";
	private static final String P_RANKING = "pRanking";

	@Autowired
	@Qualifier("assessdataSource")
	private DataSource m_dataSource;
	
	private SimpleJdbcCall m_RatingScaleAddSproc;
	
	@Override
	public void afterPropertiesSet() throws Exception {
		
		m_RatingScaleAddSproc = new SimpleJdbcCall(m_dataSource);
		m_RatingScaleAddSproc.useInParameterNames(P_SCALE_NAME, P_CUSTOMER_PNAME, P_RANKING)
		.declareParameters(
				new SqlParameter(P_SCALE_NAME, Types.VARCHAR),
				new SqlParameter(P_CUSTOMER_PNAME, Types.VARCHAR),
				new SqlParameter(P_RANKING, Types.INTEGER)
		)
		.withProcedureName("RatingScaleAdd")
		.withoutProcedureColumnMetaDataAccess();
		
	}



	@Override
	public void addRatingScales(List<RatingScale> ratingScales) {

		try {
			for (RatingScale ratingScale : ratingScales) {
			
				MapSqlParameterSource in = new MapSqlParameterSource();
				in.addValue(P_SCALE_NAME, ratingScale.getName());
				in.addValue(P_CUSTOMER_PNAME, ratingScale.getCustomer().getCustomerName());
				in.addValue(P_RANKING, ratingScale.getRanking());
				m_RatingScaleAddSproc.execute(in);
			}
			
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw e;
		}

	

		System.out.println("Done");
	}

}
