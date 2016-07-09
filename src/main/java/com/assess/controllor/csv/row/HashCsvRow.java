package com.assess.controllor.csv.row;

import java.util.HashMap;
import java.util.Map;

public class HashCsvRow extends BaseCsvRow
{

	private Map<String, String> m_row = new HashMap<String, String>();
	
	public HashCsvRow(long recordNumber, String response)
	{
		super(recordNumber, response);
	}

	public HashCsvRow()
	{
	}

	public HashCsvRow(long recordNumber)
	{
		super(recordNumber);
	}

	public void addColValue(String key, String value)
	{
		m_row.put(key, value);
	}
	
	public String getColValue(String key)
	{
		return m_row.get(key);
	}
	
	@Override
	public String toString()
	{
		return super.toString()+"::"+m_row.toString();
	}
}
