package egovframework.let.com.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.LoginVO;
import egovframework.let.uss.umt.service.UserDefaultVO;
import egovframework.let.uss.umt.service.UserManageService;

/**
 * 공통기능을 위한 컨트롤러 클래스
 * 
 * @author 영남사업부 주소현
 * @since 2023.05.10
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.05.10  주소현          최초 생성
 *
 *      </pre>
 */

@Controller
public class CommonController {
	/** userManageService */
	@Resource(name = "userManageService")
	private UserManageService userManageService;
	
	/**
	 * 등록확인 팝업창로 이동
	 */
	@RequestMapping(value = "/com/RegistConfirm.do")
	public String RegistConfirm() throws Exception {

		return "/com/RegistConfirm";
	}
	
	/**
	 * 등록완료 팝업창로 이동
	 */
	@RequestMapping(value = "/com/RegistSuccess.do")
	public String RegistSuccess() throws Exception {

		return "/com/RegistSuccess";
	}
	
	/**
	 * 등록실패 팝업창로 이동
	 */
	@RequestMapping(value = "/com/RegistFail.do")
	public String RegistFail() throws Exception {

		return "/com/RegistFail";
	}
	
	/**
	 * 알람 팝업창로 이동
	 */
	@RequestMapping(value = "/com/AlertModal.do")
	public String AlertModal(ModelMap model,@ModelAttribute("fields") StringBuffer buffer) throws Exception {
		
		model.addAttribute("fields", buffer);
		
		return "/com/AlertModal";
	}
	/**
	 * 승인확인 팝업창로 이동
	 */
	@RequestMapping(value = "/com/ApprovalConfirm.do")
	public String ApprovalConfirm() throws Exception {
		return "/com/ApprovalConfirm";
	}
	
	/**
	 * 수정확인 팝업창로 이동
	 */
	@RequestMapping(value = "/com/UpdtConfirm.do")
	public String UpdtConfirm() throws Exception {

		return "/com/UpdtConfirm";
	}
	
	/*
	 * //사용자 목록 엑셀 추출
	 * 
	 * @RequestMapping("/com/xlsxTrsfUserManage.do") public void
	 * xlsxTrsfUserManage(HttpServletRequest req, HttpServletResponse res, ModelMap
	 * model ,
	 * 
	 * @ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, HttpSession
	 * session) throws Exception { LoginVO loginVo =
	 * (LoginVO)session.getAttribute("loginVo");
	 * userSearchVO.setRecordCountPerPage(10000); userSearchVO.setFirstIndex(0);
	 * 
	 * userManageService.xlsxTrsfUserManage(userSearchVO,req,res); }
	 */
}
