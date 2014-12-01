package com.vega;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

public class VegaDemo {
		public ArrayList<String> GetCols() throws Exception
		{
			// TODO Auto-generated method stub
		    FileInputStream fileIn = new FileInputStream("/home/siri/Downloads/Sample.xls");
		    //read file 
		    POIFSFileSystem fs = new POIFSFileSystem(fileIn); 
		    HSSFWorkbook filename = new HSSFWorkbook(fs);
		    //open sheet 0 which is first sheet of your worksheet
		    HSSFSheet sheet = filename.getSheetAt(0);

		    //we will search for column index containing string "Your Column Name" in the row 0 (which is first row of a worksheet
		    //String columnWanted = "Point";
		    //Integer columnNo = null;
		    //output all not null values to the list
		    ArrayList<String> cells = new ArrayList<String>();

		    Row firstRow = sheet.getRow(0);

		    for(Cell cell:firstRow)
		    {
		    	cells.add(cell.toString());
		    }
		    return cells;
	}
		public List<Cell> GetValues(String str) throws Exception
		{
			// TODO Auto-generated method stub
		    FileInputStream fileIn = new FileInputStream("/home/siri/Downloads/Sample.xls");
		    //read file 
		    POIFSFileSystem fs = new POIFSFileSystem(fileIn); 
		    HSSFWorkbook filename = new HSSFWorkbook(fs);
		    //open sheet 0 which is first sheet of your worksheet
		    HSSFSheet sheet = filename.getSheetAt(0);

		    //we will search for column index containing string "Your Column Name" in the row 0 (which is first row of a worksheet
		    String columnWanted = str;
		    Integer columnNo = null;
		    //output all not null values to the list
		    List<Cell> cells = new ArrayList<Cell>();

		    Row firstRow = sheet.getRow(0);

		    for(Cell cell:firstRow)
		    {
		        if (cell.getStringCellValue().equals(columnWanted))
		        {
		            columnNo = cell.getColumnIndex();
		        }
		    	//cells.add(cell);
		    }


		    if (columnNo != null)
		    {
		    	for (Row row : sheet) 
		    	{
		    		Cell c = row.getCell(columnNo);
		    		if (c == null || c.getCellType() == Cell.CELL_TYPE_BLANK) 
		    		{
		    			//Nothing in the cell in this row, skip it
		    		} 
		    		else 
		    		{
		    			cells.add(c);
		    			//System.out.println(c.toString());
		    		}
		    	}
		    }
		    else
		    {
		        //System.out.println("could not find column " + columnWanted + " in first row of " + fileIn.toString());
		    }
		    return cells;
	}
		public HashMap<String, ArrayList<String>> parse(String inFile) {
			//String inFile="/home/siri/Cloud/PROJECT/data/stacked-bar/District_Wise_Rural_HealthCare_Infrastructure.csv";
			HashMap<String, ArrayList<String>> csvData = new HashMap<String, ArrayList<String>>();

			BufferedReader br = null;

			try {
				br = new BufferedReader(new FileReader(new File(inFile)));

				String header = br.readLine();

				String[] headings = header.split(",");
				int i;
				int headingsCount = headings.length;
				for (i = 0; i < headingsCount; i++) {
						headings[i]=trimDoubleQuotes(headings[i]);
					csvData.put(headings[i], new ArrayList<String>());
				}

				String dataRow = br.readLine();
				String datas[];
				String data="";

				while (dataRow != null) 
				{
					datas = dataRow.split(",");
						for (i = 0; i < headingsCount; i++) 
						{
							if(i<datas.length)
							{
								data=trimDoubleQuotes(datas[i]);
								csvData.get(headings[i]).add(data);
							}
						}
					dataRow = br.readLine();

				}

			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (br != null)
						br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			return csvData;
		}

		private String trimDoubleQuotes(String in) {
			String out = null;
			if (in != null) {
				out = in;
				
				if(out.startsWith("\""))
					out=out.substring(1);
				
				if(out.endsWith("\""))
					out=out.substring(0, out.length()-1);
			}
			
			return out;
		}
		/*public static void main(String args[])
		{
			VegaDemo vg=new VegaDemo();
			vg.parse();
		}*/

}
