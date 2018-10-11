package zip;

import org.apache.commons.io.FilenameUtils;

public class ZipTest {
	
	public static void main(String[] args) throws Exception {
		String f = FilenameUtils.getBaseName("c:\\work\\abc\\leave.bpmn20.xml");
		System.out.println(f.substring(0, f.indexOf(".")));
		System.out.println(FilenameUtils.getExtension("c:\\work\\abc\\leave.bpmn20.jsp"));
	}

}
