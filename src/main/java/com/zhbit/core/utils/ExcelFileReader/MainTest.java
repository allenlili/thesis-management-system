package com.zhbit.core.utils.ExcelFileReader;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

public class MainTest {

	/**
	 * @param args
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	public static void main(String[] args) throws FileNotFoundException, IOException {
		try{
			List<Row> rows = ExcelFileReader.read("C:\\Users\\AllenLi\\Desktop\\老师的信息（TMS）.xls", 0);
			for (Iterator<Row> it = rows.iterator(); it.hasNext();) {
				for (Iterator<Cell> celIt = it.next().getCellList().iterator(); celIt.hasNext();) {
					Cell cell = celIt.next();
					System.out.println(cell.getText() + "(" + cell.getType() + ")");
				}
				
				System.out.println();
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
