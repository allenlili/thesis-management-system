package com.zhbit.core.utils.ExcelFileReader;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import com.zhbit.core.utils.ExcelFileReader.Cell;
import com.zhbit.core.utils.ExcelFileReader.ExcelFileReader;
import com.zhbit.core.utils.ExcelFileReader.Row;

public class ModelRecordFactory {

	
	private static ModelRecordFactory instance = null;
	
	private static List<Row> rows = null;

	private ModelRecordFactory() {
	}
	
	private ModelRecordFactory(String filePath) {
		init(filePath);
	}
	
	public synchronized static ModelRecordFactory getInstance(String filePath) {
//		if (instance == null) {
			instance = new ModelRecordFactory(filePath);
//		}
		return instance;
	}
	
	private void init(String filePath) {
		try {
			rows = ExcelFileReader.read(filePath, 0);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 得到标题
	 * @return
	 */
	public synchronized Map<String, String> getFieldNameIndexMap() {
		Map<String, String> fieldNameIndexMap = new Hashtable<String, String>();
		List<String> titleList = getTitleList();
		for (int i = 0; i < titleList.size(); i++) {
			fieldNameIndexMap.put((String)titleList.get(i), String.valueOf(i));
		}
		
		return fieldNameIndexMap;
	}
	
	public synchronized List<String> getTitleList() {
		List<String> titleList = new ArrayList<String>();
		Row titleRow = rows.get(1);
		for (int i = 0; i < titleRow.getCellList().size(); i++) {
			Cell cell = titleRow.getCellList().get(i);
			titleList.add(cell.getText());
		}
		return titleList;
	}
	
	public synchronized List<ModelVO> getModelVOList() {
		List<ModelVO> modelVOList = new ArrayList<ModelVO>();
		for (int r = 1; r < rows.size(); r++) {
			Row row = rows.get(r);
			ModelVO modelVO = new ModelVO();
			for (int i = 0; i < row.getCellList().size(); i++) {
				Cell cell = row.getCellList().get(i);
				modelVO.getDetailMap().put(String.valueOf(cell.getIndex()), cell.getText());
			}
			modelVOList.add(modelVO);
		}
		return modelVOList;
	}
}
