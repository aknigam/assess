package com.assess.controllor.model.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class FrequencyReportModel
{

	private Integer userId;
	private String username;
	
	
	List<FrequencyReportCategory> m_self = new ArrayList();
	List<FrequencyReportCategory> m_peers = new ArrayList();
	List<FrequencyReportCategory> m_manager = new ArrayList();
	List<FrequencyReportCategory> m_others = new ArrayList();
	List<FrequencyReportCategory> m_directReports = new ArrayList();
	
	public FrequencyReportModel(int usrId)
	{
		userId = usrId;
	}

	public List<FrequencyReportCategory> getSelf()
	{
		return m_self;
	}

	public void setSelf(List<FrequencyReportCategory> self)
	{
		m_self = self;
	}

	public List<FrequencyReportCategory> getPeers()
	{
		return m_peers;
	}

	public void setPeers(List<FrequencyReportCategory> peers)
	{
		m_peers = peers;
	}

	public List<FrequencyReportCategory> getManager()
	{
		return m_manager;
	}

	public void setManager(List<FrequencyReportCategory> manager)
	{
		m_manager = manager;
	}

	public List<FrequencyReportCategory> getOthers()
	{
		return m_others;
	}

	public void setOthers(List<FrequencyReportCategory> others)
	{
		m_others = others;
	}

	public List<FrequencyReportCategory> getDirectReports()
	{
		return m_directReports;
	}

	public void setDirectReports(List<FrequencyReportCategory> directReports)
	{
		m_directReports = directReports;
	}

	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public String getUsername()
	{
		return username;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	public static class FrequencyReportCategory
	{
		private Integer questionId;
		private String question;
		
		private Object[][] mcFrequency; 
		Map<String, Integer>  m_frequencyMap = new HashMap();
		
		public FrequencyReportCategory(int qId, String question2)
		{
			
			questionId = qId;
			question = question2;
		}
		public Integer getQuestionId()
		{
			return questionId;
		}
		public void setQuestionId(Integer questionId)
		{
			this.questionId = questionId;
		}
		public String getQuestion()
		{
			return question;
		}
		public void setQuestion(String question)
		{
			this.question = question;
		}
		public Object[][] getMcFrequency()
		{
			return mcFrequency;
		}
		public void setMcFrequency(Object[][] mcFrequency)
		{
			this.mcFrequency = mcFrequency;
		}
		public Map<String, Integer> getFrequencyMap()
		{
			return m_frequencyMap;
		}
		public void setFrequencyMap(Map<String, Integer> map)
		{
			
			int length = map.size();
			mcFrequency = new Object[length][];
			Set<Entry<String, Integer>> entries = map.entrySet();
			
			int i = 0;
			for (Entry<String, Integer> entry : entries)
			{
				mcFrequency[i++] = new Object[]{entry.getKey(), entry.getValue()};
			}
			
			m_frequencyMap = map;
		}
		
	}
	
	
	
	
	
}
