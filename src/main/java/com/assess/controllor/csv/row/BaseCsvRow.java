package com.assess.controllor.csv.row;

import java.util.Comparator;

import org.codehaus.jackson.annotate.JsonProperty;

public abstract class BaseCsvRow 
{

	protected String m_response= "Ok";
	
	protected boolean m_isInValid;
	
	@JsonProperty("recordNumber")
	protected long m_recordNumber;
	
	public static RowNumberComparator ROWNUMBER_COMPARATOR = new RowNumberComparator();
	
	public BaseCsvRow()
	{
		
	}

	public BaseCsvRow(long recordNumber, String response)
	{
		m_recordNumber = recordNumber;
		m_response = response;
		m_isInValid = true;
	}
	
	public BaseCsvRow(long recordNumber)
	{
		m_recordNumber = recordNumber;
	}

	public String getResponse()
	{
		return m_response;
	}

	public void setResponse(String response)
	{
		m_response = response;
	}

	public boolean isInValid()
	{
		return m_isInValid;
	}

	public void setInValid(boolean isInValid)
	{
		m_isInValid = isInValid;
	}

	public long getRecordNumber()
	{
		return m_recordNumber;
	}

	public void setRecordNumber(long recordNumber)
	{
		m_recordNumber = recordNumber;
	}
	
	@Override
	public String toString()
	{
		return "S.No - "+ m_recordNumber;
	}
	
	static class  RowNumberComparator implements Comparator<BaseCsvRow>{

		@Override
		public int compare(BaseCsvRow o1, BaseCsvRow o2)
		{
			return Long.valueOf(o1.m_recordNumber).intValue() - Long.valueOf(o2.m_recordNumber).intValue();
		}
		
	}
	
}
