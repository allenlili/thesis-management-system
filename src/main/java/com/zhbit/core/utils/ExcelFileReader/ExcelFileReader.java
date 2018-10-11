package com.zhbit.core.utils.ExcelFileReader;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

public class ExcelFileReader {

	public static List<com.zhbit.core.utils.ExcelFileReader.Row> read(String fileName, int sheetNumber) throws FileNotFoundException, IOException {
	    Workbook wb = new HSSFWorkbook(new FileInputStream(fileName));
	    Sheet sheet = wb.getSheetAt(sheetNumber);	    
	    FormulaEvaluator evaluator = wb.getCreationHelper().createFormulaEvaluator();
	    List<com.zhbit.core.utils.ExcelFileReader.Row> rows = new ArrayList<com.zhbit.core.utils.ExcelFileReader.Row>();
	    for (Iterator<Row> iter = sheet.rowIterator(); iter.hasNext();) {
	      com.zhbit.core.utils.ExcelFileReader.Row myRow = new com.zhbit.core.utils.ExcelFileReader.Row();
	      rows.add(myRow);
	      Row row = iter.next();
	      for (Iterator<Cell> iter2 = row.cellIterator(); iter2.hasNext();) {
	        Cell cell = iter2.next();
	        com.zhbit.core.utils.ExcelFileReader.Cell myCell = new com.zhbit.core.utils.ExcelFileReader.Cell();
	        myCell.setIndex(cell.getColumnIndex());
	       
	        if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
		        String content = cell.getStringCellValue();
		        myCell.setText(content);
		        myCell.setType(com.zhbit.core.utils.ExcelFileReader.Cell.STRING_TYPE);
		        myRow.getCellList().add(myCell);
	        }
	        else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
	        	
		        String content = String.valueOf(cell.getNumericCellValue());
		        myCell.setText(content);
		        myCell.setType(com.zhbit.core.utils.ExcelFileReader.Cell.NUMBER_TYPE);
		        myRow.getCellList().add(myCell);
	        }
	        else if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
		        String content = String.valueOf(cell.getBooleanCellValue());
		        myCell.setText(content);
		        myCell.setType(com.zhbit.core.utils.ExcelFileReader.Cell.BOOLEAN_TYPE);
		        myRow.getCellList().add(myCell);
	        }
	        else if (cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
	        	CellValue cellValue = evaluator.evaluate(cell);
	        	 if (cellValue.getCellType() == Cell.CELL_TYPE_STRING) {
	 		        String content = cellValue.getStringValue();
	 		        myCell.setText(content);
	 		       myCell.setType(com.zhbit.core.utils.ExcelFileReader.Cell.STRING_TYPE);
	 		        myRow.getCellList().add(myCell);
	 	        }
	 	        else if (cellValue.getCellType() == Cell.CELL_TYPE_NUMERIC) {
	 		        String content = String.valueOf(cellValue.getNumberValue());
	 		        myCell.setText(content);
	 		       myCell.setType(com.zhbit.core.utils.ExcelFileReader.Cell.NUMBER_TYPE);
	 		        myRow.getCellList().add(myCell);
	 	        }
	 	        else if (cellValue.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
	 		        String content = String.valueOf(cellValue.getBooleanValue());
	 		        myCell.setText(content);
	 		        myCell.setType(com.zhbit.core.utils.ExcelFileReader.Cell.BOOLEAN_TYPE);
	 		        myRow.getCellList().add(myCell);
	 	        }
	        }

	      }
	    }
	    
	    return rows;
	}
}
