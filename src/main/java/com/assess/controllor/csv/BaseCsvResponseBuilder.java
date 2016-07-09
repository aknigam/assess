/**
 * Copyright 2013 Expedia, Inc. All rights reserved.
 *
 * EXPEDIA PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package com.assess.controllor.csv;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVPrinter;
import org.apache.commons.csv.CSVRecord;
import org.apache.log4j.Logger;

import com.assess.controllor.csv.row.BaseCsvRow;
import com.assess.controllor.csv.row.HashCsvRow;


/**
 * This is the base class for reading csv file and generate the csv response.
 * 
 * @author <a href="mailto:anigam@expedia.com">anigam</a>
 *
 */
public abstract class BaseCsvResponseBuilder<T>
{
	private Logger m_logger = Logger.getLogger(BaseCsvResponseBuilder.class);
	
	private Map<T, CSVRecord > m_input = new HashMap<T, CSVRecord>();
	
	private Map<T, CSVRecord > m_response = new HashMap<T, CSVRecord >();

	private Map<String, Integer> m_headerMap;
	
	private List<String> m_additionalResponseHeaders;
	
	public BaseCsvResponseBuilder()
	{
		// TODO anigam Auto-generated constructor stub
	}
	
	public BaseCsvResponseBuilder(List<String> headers)
	{
		m_additionalResponseHeaders = headers;
	}
	
	public List<T> readUploadedFile( InputStream is) throws IOException{

		List<T> rows = new ArrayList<T>();
		Reader reader = new InputStreamReader(is);
		try
		{
			CSVFormat format = CSVFormat.EXCEL.toBuilder().withHeader().build();
			CSVParser parser = new CSVParser(reader, format);
			m_headerMap = parser.getHeaderMap();
			List<CSVRecord> list = parser.getRecords();
			
			for (CSVRecord csvRecord : list)
			{
				
				T row = getRecord(csvRecord);
				m_input.put(row, csvRecord);
				rows.add(row);
			}

		}
		finally 
		{
			try
			{
				reader.close();
			}
			catch (IOException e)
			{
				m_logger.error("Error closing buffered input stream", e);
			}
		}
		return rows;

	}
	public List<T> readUploadedFile(File csvfile) throws IOException{
		return readUploadedFile(new FileInputStream(csvfile));
	}
	public List<T> readUploadedFile( byte[] buf) throws IOException{
		return readUploadedFile(new ByteArrayInputStream(buf));
	}
	
//	public abstract T getRecord(CSVRecord csvRecord);
	
	public T getRecord(CSVRecord csvRecord)
	{

		HashCsvRow row = new HashCsvRow(csvRecord.getRecordNumber());
		Map<Integer, String> indexKeyMap = getIndexKeyMap();
		try{
			
			Iterator<String> itr = csvRecord.iterator();
			
			for (int i = 0; itr.hasNext();i++)
			{
				String value  =  itr.next();
				System.out.println("\t\t"+value);
				row.addColValue(indexKeyMap.get(i), value.trim());
				
			}

		}
        catch(Exception ex)
        {
			m_logger.error("Error parsing excel row: "+ csvRecord, ex);
			row = new HashCsvRow(csvRecord.getRecordNumber(), ex.getMessage());
		}
		
		return (T) row;

	
	}
	

	protected abstract Map<Integer, String> getIndexKeyMap();

	public Object[] getStartColumns(T row)
	{
		return new String[]{};
	}
	
	public void addResponseRow(T row)
	{
		CSVRecord csvRecord = m_input.get(row);
		m_response.put(row,csvRecord);
		
	}
	@SuppressWarnings({"PMD.AvoidArrayLoops"})
	public void writeResponse(Appendable out) throws IOException{
		
		CSVFormat format = CSVFormat.EXCEL;
		CSVPrinter printer = null;
		try{
			printer= new CSVPrinter(out , format);

			Set<String> headers = m_headerMap.keySet();
			List<String> responseHeaders = m_additionalResponseHeaders;
			int noOfAdditionalColumns= responseHeaders.size();
			responseHeaders.addAll(headers);
			responseHeaders.add("Line HashCode");
			printer.printRecord(responseHeaders);

			Map<T, CSVRecord> lresponse = new TreeMap(  BaseCsvRow.ROWNUMBER_COMPARATOR);
			lresponse.putAll(m_response);
			
			Set<Entry<T, CSVRecord>> set = lresponse.entrySet();

			for (Entry<T, CSVRecord> entry : set)
			{
				CSVRecord csvRecord = entry.getValue();
				T row = entry.getKey();
				Object[] startColumns = getStartColumns(row);
				
				int size  =csvRecord.size();
				Object[] responseRow =  new Object[size+noOfAdditionalColumns+1];
				
				int i = 0;
				for (; i < noOfAdditionalColumns; i++)
				{
					responseRow[i] = startColumns[i];
					
				}
				
				for (String string : csvRecord)
				{
					responseRow[i++]= string;
				}
				String lineHashCode = getLineHashCode(responseRow);
				responseRow[size+noOfAdditionalColumns] = lineHashCode;
				printer.printRecord(((Object[])responseRow));

			}
		}
		finally
		{
			if(printer!=null)
			{
				printer.close();
			}
		}
	}
	
	private String getLineHashCode(Object[] responseRow)
	{
		try
		{
			MessageDigest digest = MessageDigest.getInstance("MD5");
			StringBuffer buffer = new StringBuffer();
			for (Object col : responseRow)
			{
				buffer.append(col);
			}
			
			byte[] bytes = digest.digest( buffer.toString().getBytes());
//			String lineHashCode = new String(Hex.encodeHex( bytes));
			String lineHashCode = new String("Hex.encodeHex( bytes)");
			return lineHashCode;
		}
		catch (NoSuchAlgorithmException e)
		{
			return "";
		}
		
		
	}

	private boolean isNumber(String strVal)
	{
		return false;
	}


}
