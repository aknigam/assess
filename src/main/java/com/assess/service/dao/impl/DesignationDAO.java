package com.assess.service.dao.impl;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.stereotype.Component;

import com.assess.service.dao.IDesignationDAO;
import com.assess.service.entity.Customer;
import com.assess.service.entity.Designation;

@Component
public class DesignationDAO extends BaseDao implements IDesignationDAO
{
	
	private static String m_insertQuery = "INSERT INTO Designation ( CustomerId, Name, Description)  VALUES (?, ?, ?); ";

	private static String m_designationNameQuery = "Select designationId from Designation where name = ?";
	
	@Override
	public void addDesignations(final List<Designation> designations)
	{

		try {


			int[] updateCounts = m_assessDbTemplate.batchUpdate(
					m_insertQuery,
					new BatchPreparedStatementSetter() {
						public void setValues(PreparedStatement ps, int i) throws SQLException {
							ps.setInt(1, designations.get(i).getCustomerId());
							ps.setString(2, designations.get(i).getName());
							ps.setString(3, designations.get(i).getDescription());

						}

						public int getBatchSize() {
							return designations.size();
						}
					} );
			//        return updateCounts;
		} catch (DataAccessException e) {
			e.printStackTrace();
		}

	}

	@SuppressWarnings("deprecation")
	@Override
	public Designation getDesignationByName(String designationName) 
	{
		try {
			int designationId =  m_assessDbTemplate.queryForInt(m_designationNameQuery, new String[]{designationName});
			return new Designation(designationId);
		} catch (DataAccessException e) {
			// EmptyResultDataAccessException is thrown when customer table is empty or no matching customer is found.
			// TODO: handle exception
			return null;
		}
		
		
	}
	
}
