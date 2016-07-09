
package com.assess.controllor.csv;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.multipart.MultipartFile;

import com.assess.controllor.csv.row.BaseCsvRow;
import com.assess.service.processor.IUploadProcessor;

public class UploadWSUtil implements InitializingBean
{
	public static final Logger m_logger = Logger.getLogger(UploadWSUtil.class);

	
	private Map<String, IUploadProcessor> uploadProcessors;
	
	/**
	 * Enforced non-instantialbilty of this class as it only has static methods.
	 * Refer Item#4 Effective java
	 */
	public UploadWSUtil()
	{
//		throw new AssertionError("Instance of this class is not required. Use static methods.");
	}

	public void processCSVRow(BaseCsvResponseBuilder<BaseCsvRow> builder, MultipartFile file, HttpServletResponse response,
			UploadEntityEnum uploadEntity) throws Exception
	{
		IUploadProcessor processor = uploadProcessors.get(uploadEntity.name());
		byte[] bytes = file.getBytes();

		List<BaseCsvRow> processedRowsList = new ArrayList();
		List<BaseCsvRow> csvRows = builder.readUploadedFile(bytes);
		processedRowsList = processor.upload(csvRows);

			for (BaseCsvRow processedCSVRow : processedRowsList)
			{

				if (processedCSVRow.getResponse() != null)
				{
					processedCSVRow.getResponse().replace(",", "");
				}
				builder.addResponseRow(processedCSVRow);
			}
			writeResponse(response, builder);

	}

	private static void writeResponse(HttpServletResponse response,
			BaseCsvResponseBuilder<BaseCsvRow> builder) throws IOException
	{
		Appendable result = new StringBuffer();
		builder.writeResponse(result);
		response.setContentType("text/csv;charset=utf-8");
		response.setHeader("Content-Disposition", "attachment; filename=\"upload-response.csv\"");

		OutputStreamWriter outputwriter = null;
		try
		{
			OutputStream resOs = response.getOutputStream();
			OutputStream buffOs = new BufferedOutputStream(resOs);
			outputwriter = new OutputStreamWriter(buffOs);
			outputwriter.write(result.toString());
			// m_logger.debug("total time taken in uploading all awards = "+
		}
		finally
		{
			if (outputwriter != null)
			{
				outputwriter.flush();
				outputwriter.close();
			}
		}
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		System.out.println(uploadProcessors);
	}

	public Map<String, IUploadProcessor> getUploadProcessors() {
		return uploadProcessors;
	}

	public void setUploadProcessors(
			Map<String, IUploadProcessor> uploadProcessors) {
		this.uploadProcessors = uploadProcessors;
	}

}
