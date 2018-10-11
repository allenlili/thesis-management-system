package com.zhbit.process.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.query.Query;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.apache.commons.io.FilenameUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;


@Controller
@Scope("prototype")
public class ProcessDefinitionAction extends ProcessBaseAction {

	private static final long serialVersionUID = 1L;
	
	private RepositoryService repositoryService;
	
	private File process;
	private String processFileName;
	
	/**
	 * 查询条件
	 */
	private String definitionName;
	
	@Resource
	public void setRepositoryService(RepositoryService repositoryService) {
		this.repositoryService = repositoryService;
	}

	/* 
	 * 产生query
	 * 处理条件
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public Query createQuery() {
		ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery();
		//查询条件
		if (null != definitionName && !"".equals(definitionName.trim())) {
			query.processDefinitionNameLike(definitionName);
		}
		if (null != definitionKey && !"".equals(definitionKey.trim())) {
			query.processDefinitionKey(definitionKey);
		}
		return query;
	}
	
	/* 
	 * 删除
	 */
	@Override
	public void doDelete(String id) {
		repositoryService.deleteDeployment(id, true);
	}
	
	public String toDeploy() {
		return "deploy";
	}
	
	public String deploy() throws Exception {
		ZipInputStream in = new ZipInputStream(new FileInputStream(process));
		ZipEntry entry = null;
		while((entry = in.getNextEntry()) != null) {
			if (!entry.isDirectory()) {
				String extension = FilenameUtils.getExtension(entry.getName()).toLowerCase();
				if ("bpmn".equals(extension)) {
					repositoryService.createDeployment().addInputStream(entry.getName(), in).deploy();					
				}
				if ("jsp".equals(extension)) {
					String path = request.getSession().getServletContext().getRealPath("/") + "process/";
					path = path + FilenameUtils.getBaseName(processFileName) + "/";
					File file = new File(path);
					if (!file.exists()) {
						file.mkdirs();
					}
					FileOutputStream out = new FileOutputStream(path + entry.getName());
					int temp = -1;
					while ((temp = in.read()) != -1) {
						out.write(temp);
					}
					out.flush();
					out.close();
				}
			}
			in.closeEntry();
		}
		in.close();
		return LIST_ACTION;
	}

	public String getDefinitionName() {
		return definitionName;
	}

	public void setDefinitionName(String definitionName) {
		this.definitionName = definitionName;
	}

	public void setProcess(File process) {
		this.process = process;
	}

	public void setProcessFileName(String processFileName) {
		this.processFileName = processFileName;
	}

}
