package egovframework.let.aprv.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.aprv.service.ApprovalManageService;

/**
 * 사용자관련 요청을  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
 * @author 영남사업부 천세훈
 * @since 2023.05.17
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2023.05.10  천세훈         최초 생성
 *
 * </pre> 
 */

@Controller
public class ApprovalManageController {

	/** approvalManageService */
	@Resource(name = "approvalManageService")
	private ApprovalManageService approvalManageService;
	
	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	
}
