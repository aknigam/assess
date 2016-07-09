package com.assess.service.dao.impl;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

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

import com.assess.service.RefFeedbackStatusEnum;
import com.assess.service.dao.IAppUserDAO;
import com.assess.service.entity.AppUser;
import com.assess.service.exception.UserNotFoundException;

@Component
public class AppUserDAO extends BaseDao implements IAppUserDAO, InitializingBean {

	
	private static final String P_USER_NAME = "pUserEmail";

	private static final String P_MANAGER_NAME = "pManagerEmail";

	private static final String P_REVIEWER_EMAIL = "pReviewerEmail";
	private static final String P_REVIEWEE_EMAIL = "pRevieweeEmail";
	private static final String P_NOMINATEDBY_EMAIL = "pNominatedByEmail";
	private static final String P_FEEDBACK_STATUS = "FeedbackStatusId";

	private static String m_updateMangerQuery = "update AppUser set mangerId = ? where email = ? ";
	
	@Autowired
	@Qualifier("assessdataSource")
	private DataSource m_dataSource;
	
	private SimpleJdbcCall m_UpdateManagerSproc;
	
	private SimpleJdbcCall m_CustomerUserReviewerAddSproc;

	
	
	

	@Override
	public void afterPropertiesSet() throws Exception {
		
		m_UpdateManagerSproc = new SimpleJdbcCall(m_dataSource);
		m_UpdateManagerSproc.useInParameterNames(P_USER_NAME, P_MANAGER_NAME)
		.declareParameters(
				new SqlParameter(P_USER_NAME, Types.VARCHAR),
				new SqlParameter(P_MANAGER_NAME, Types.VARCHAR)
		)
		.withProcedureName("updateManager")
		.withoutProcedureColumnMetaDataAccess();
		
		
		
		m_CustomerUserReviewerAddSproc = new SimpleJdbcCall(m_dataSource);
		m_CustomerUserReviewerAddSproc.useInParameterNames(P_REVIEWER_EMAIL, P_REVIEWEE_EMAIL,P_NOMINATEDBY_EMAIL
				,P_FEEDBACK_STATUS)
		.declareParameters(
				new SqlParameter(P_REVIEWER_EMAIL, Types.VARCHAR),
				new SqlParameter(P_REVIEWEE_EMAIL, Types.VARCHAR),
				new SqlParameter(P_NOMINATEDBY_EMAIL, Types.VARCHAR),
				new SqlParameter(P_FEEDBACK_STATUS, Types.INTEGER
						)
		)
		.withProcedureName("CustomerUserReviewerAdd")
		.withoutProcedureColumnMetaDataAccess();
	}


	
	@Override
	public void updateHierarchy(Map<String, String> userManagers) {
		
		Set<Entry<String, String>> entries = userManagers.entrySet();
		
		final List<Entry<String, String>> list = new ArrayList(entries);
		final Map<String, String> emailUserIdMap =  new HashMap();
		
		
		try {
			
			for (Entry<String, String> entry : list) {
				emailUserIdMap.put(entry.getValue(), getUserByEmail(entry.getValue()).getEmail());
			}
			
			
			int[] updateCounts = m_assessDbTemplate.batchUpdate(
					m_updateMangerQuery,
					new BatchPreparedStatementSetter() {
						public void setValues(PreparedStatement ps, int i) throws SQLException {
							Entry<String, String> u = list.get(i);
							
							ps.setString(1, u.getKey());
							ps.setString(2, emailUserIdMap.get(u.getValue()));
						}

						public int getBatchSize() {
							return list.size();
						}
					} );
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		
		
	}
	
	
	private static String m_insertQuery = "INSERT INTO AppUser (ManagerId,AppRoleId,DesignationId,CustomerId,Name,Email,IsEmployee,UserPassword,EmployeeId) " +
			"values (?,?,?,?,?,?,?,?,?);";
	
	@Override
	public void addAppUsers(final List<AppUser> appUsers) {
		
		Map<String, String> userMangerMap = new HashMap();
		for (AppUser u : appUsers)
		{
			if(u.getManager()!= null && u.getManager().getEmail()!= null)
				userMangerMap.put(u.getEmail(), u.getManager().getEmail());	
		}
		System.out.println("Done");
		
//		addUsers(appUsers);
		
//		addManagers(userMangerMap);

		addSelfReview(appUsers);
		
		System.out.println("Done");

	
	}
	private void addSelfReview(List<AppUser> appUsers)
	{

		try
		{
			
		
		for (AppUser appUser : appUsers)
		{
			if(!appUser.isIsEmployee())
				continue;
//				emps.add(appUser);
			
				MapSqlParameterSource in = new MapSqlParameterSource();
				String email = appUser.getEmail();
				in.addValue(P_REVIEWER_EMAIL, email);
				in.addValue(P_REVIEWEE_EMAIL, email);
				in.addValue(P_NOMINATEDBY_EMAIL, email);
				in.addValue(P_FEEDBACK_STATUS, RefFeedbackStatusEnum.NEW.getId());
				m_CustomerUserReviewerAddSproc.execute(in);
		}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	
				
	}



	private void addManagers(Map<String, String> userMangerMap)
	{
		try {
			
			
			final ArrayList<Entry<String, String>> list = new ArrayList(userMangerMap.entrySet());
			
			for (Entry<String, String> entry : list)
			{
				
				MapSqlParameterSource in = new MapSqlParameterSource();
				in.addValue(P_USER_NAME, entry.getKey());
				in.addValue(P_MANAGER_NAME, entry.getValue());
				m_UpdateManagerSproc.execute(in);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}		
	}



	private void addUsers(final List<AppUser> appUsers)
	{
		final StringBuilder builder = new StringBuilder();
		try {
			int[] updateCounts = m_assessDbTemplate.batchUpdate(
					m_insertQuery,
					new BatchPreparedStatementSetter() {
						public void setValues(PreparedStatement ps, int i) throws SQLException {
							AppUser u = appUsers.get(i);
							if(u.getManagerId()!=null)
								ps.setInt(1, u.getCustomerId());
							else
								ps.setObject(1, null);
							
							ps.setInt(2, u.getAppRoleId());
							ps.setInt(3, u.getDesignationId());
							ps.setInt(4, u.getCustomerId());
							ps.setString(5, u.getName());
							ps.setString(6, u.getEmail());
							ps.setBoolean(7, u.isIsEmployee());
							ps.setString(8, u.getUserPassword());
							ps.setInt(9, u.getEmployeeId());
							builder.append(ps.toString());
						}

						public int getBatchSize() {
							return appUsers.size();
						}
					} );
			//        return updateCounts;
		} catch (DataAccessException e) {
			System.out.println(builder);
			e.printStackTrace();
			throw e;
		}
		System.out.println("Done");		
	}


	private static String m_userByEmailQuery = "select AppUserId, name, email , AppRoleId from AppUser where Email = ?";
	
	@Override
	public AppUser getUserByEmail(String userEmail) throws UserNotFoundException {
		try {
			List<AppUser> users = m_assessDbTemplate.query(m_userByEmailQuery, new String[]{userEmail}, new RowMapper<AppUser>() {

				@Override
				public AppUser mapRow(ResultSet rs, int i)
						throws SQLException {
					// TODO Auto-generated method stub
					
					AppUser user = new AppUser();
					user.setAppUserId(rs.getInt("AppUserId"));
					user.setName(rs.getString("name"));
					user.setEmail(rs.getString("email"));
					user.setAppRoleId(rs.getInt("AppRoleId"));
					return user;
				}
			});
			if(users.size() == 1)
				return users.get(0);
			else
			{
				throw new UserNotFoundException("User with email ["+userEmail+"] does not exists.");
			}
				
		} catch (DataAccessException e) {
			// EmptyResultDataAccessException is thrown when customer table is empty or no matching customer is found.
			// TODO: handle exception
			return null;
		}
		
		
		

	}
	

}
