package com.assess.controllor.model;

import java.util.List;

public class SampleDataList {

	private List<SampleData> m_data;


	public List<SampleData> getData()
	{
		return m_data;
	}
	public void setData(List<SampleData> data)
	{
		m_data = data;
	}
	public static class SampleData
	{

		public String name="anand";
		public String email="anand@expedia.com";
		
		public SampleData(String n, String e)
		{
			name = n;
			email = e;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
	}

}
