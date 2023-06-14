package egovframework.com.cmm;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.exception.handler.ExceptionHandler;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.let.com.service.CommonService;

public class EgovComOthersExcepHndlr implements ExceptionHandler {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovComOthersExcepHndlr.class);

	@Resource(name = "CommonService")
	private CommonService commonService;
	
    public void occur(Exception exception, String packageName) {
    	//log.debug(" EgovServiceExceptionHandler run...............");
    	LOGGER.error(packageName, exception);
    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	
		if(!packageName.contains("InsertXcptInfo")) {
			HashMap<String, String> xcpt = new HashMap<String, String>();
			String ex = exception.toString();
			xcpt.put("user", user.getUniqId());
			xcpt.put("exception", ex);
			xcpt.put("packageName", packageName);
			
			commonService.InsertXcptInfo(xcpt);
		}
	
    }
}
