package com.assess.controllor.model.report;

public class ReportRank {

	private Float m_otherRating = 0f;
	private Float selfRating = 0f;
	
	private Float normalRangeStart = 0f;
	private Float normalRangeEnd = 0f;
	
	// following may not be required 
	
	
	private Float managerRating= 0f;
	private Float peerRating =0f;

	private Float directReportRating= 0f;
	private Float indirectReportRating = 0f;

	
	public ReportRank(Float selfRanking, Float managerRanking, Float directReportsRanking,
			Float peersRanking, Float othersRanking)
	{
		this.selfRating = selfRanking==null?0:selfRanking;
		this.managerRating = managerRanking==null?0:managerRanking;
		this.peerRating = peersRanking==null?0:peersRanking;
		this.m_otherRating = othersRanking==null?0:othersRanking;
		this.directReportRating= directReportsRanking==null?0:directReportsRanking;
		
	}


	public Float getOtherRating()
	{
		return m_otherRating;
	}


	public void setOtherRating(Float otherRating)
	{
		m_otherRating = otherRating;
	}


	public Float getSelfRating()
	{
		return selfRating;
	}


	public void setSelfRating(Float selfRating)
	{
		this.selfRating = selfRating;
	}


	public Float getNormalRangeStart()
	{
		return normalRangeStart;
	}


	public void setNormalRangeStart(Float normalRangeStart)
	{
		this.normalRangeStart = normalRangeStart;
	}


	public Float getNormalRangeEnd()
	{
		return normalRangeEnd;
	}


	public void setNormalRangeEnd(Float normalRangeEnd)
	{
		this.normalRangeEnd = normalRangeEnd;
	}


	public Float getManagerRating()
	{
		return managerRating;
	}


	public void setManagerRating(Float managerRating)
	{
		this.managerRating = managerRating;
	}


	public Float getPeerRating()
	{
		return peerRating;
	}


	public void setPeerRating(Float peerRating)
	{
		this.peerRating = peerRating;
	}


	public Float getDirectReportRating()
	{
		return directReportRating;
	}


	public void setDirectReportRating(Float directReportRating)
	{
		this.directReportRating = directReportRating;
	}


	public Float getIndirectReportRating()
	{
		return indirectReportRating;
	}


	public void setIndirectReportRating(Float indirectReportRating)
	{
		this.indirectReportRating = indirectReportRating;
	}

	
}
