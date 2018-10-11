package testUtil;

import java.util.UUID;

import org.apache.log4j.Logger;
import org.junit.Test;

public class testUuid {
	private static Logger logger = Logger.getLogger(testUuid.class); 
	@Test
	public void testUuidValue(){
		UUID uuid = UUID.randomUUID();
		logger.info(uuid);
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
