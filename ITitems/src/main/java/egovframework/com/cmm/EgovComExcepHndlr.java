package egovframework.com.cmm;

import java.util.HashMap;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.exception.handler.ExceptionHandler;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.let.com.service.CommonService;

/**
 * @Class Name : EgovComExcepHndlr.java
 * @Description : 공통서비스의 exception 처리 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 13.     이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 13.
 * @version
 * @see
 *
 */
public class EgovComExcepHndlr implements ExceptionHandler {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovComExcepHndlr.class);
	
	@Resource(name = "CommonService")
	private CommonService commonService;
	
	/**
	 * 발생된 Exception을 처리한다.
	 */
	@Override
	public void occur(Exception exception, String packageName) {
		LOGGER.debug("[HANDLER][PACKAGE]::: {}", packageName);
		LOGGER.debug("[HANDLER][Exception]:::", exception);
		
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
