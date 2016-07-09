package com.assess.service.processor;

import java.util.List;

import com.assess.controllor.csv.row.BaseCsvRow;

public interface IUploadProcessor
{

	List<BaseCsvRow> upload(List<BaseCsvRow> csvRows);

}
