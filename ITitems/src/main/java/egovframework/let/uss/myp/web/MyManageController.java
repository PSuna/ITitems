package egovframework.let.uss.myp.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.uss.umt.service.UserDefaultVO;
import egovframework.let.uss.umt.service.UserManageService;
import egovframework.let.uss.umt.service.UserManageVO;

/**
 * 마이페이지 관련 요청을 비지니스 클래스로 전달하고 처리된 결과를 해당 웹화면으로 전달하는 Controller를 정의한다
 * @author 영남사업부 천세훈
 * @since 2023.05.08
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2023.05.08  천세훈         최초 생성
 *
 *
 * </pre> 
 */
@Controller
public class MyManageController {
	
	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	/** userManageService */
	@Resource(name = "userManageService")
	private UserManageService userManageService;
	
	
	/**
	 * 내 정보를 조회한다. (pageing)
	 * @param userSearchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/uss/myp/MyManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/myp/MyManage.do")
	public String updateUserView(@RequestParam("uniqId") String uniqId, 
								 @ModelAttribute("searchVO") UserDefaultVO userSearchVO,
								 HttpServletRequest request,
								 Model model) throws Exception{
		
    	// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
    	request.getSession().setAttribute("baseMenuNo", "2000000");
		
		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		//직급코드를 코드정보로부터 조회 - COM002 
		vo.setCodeId("COM002");
		model.addAttribute("grd_result", cmmUseService.selectCmmCodeDetail(vo));

		//그룹정보를 조회 - GROUP_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("groupId_result", cmmUseService.selectGroupIdDetail(vo));
		
		UserManageVO userManageVO = new UserManageVO();
		userManageVO = userManageService.selectUser(uniqId);
		model.addAttribute("userSearchVO", userSearchVO);
		model.addAttribute("userManageVO", userManageVO);
		
		return "cmm/uss/myp/MyManage";
	}
	
	/**
	 * 내정보 수정 후 메인 화면으로 이동한다.
	 * @param userManageVO 사용자수정정보
	 * @param bindingResult 입력값검증용 bindingResult
	 * @param model 화면모델
	 * @return forward:/cmm/main/mainPage.do
	 * @throws Exception
	 */
	@RequestMapping("/uss/myp/MyPageUpdt.do")
	public String updateUser(@ModelAttribute("userManageVO") UserManageVO userManageVO, BindingResult bindingResult, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}
		userManageService.updateUser(userManageVO);
		//Exception 없이 진행시 수정성공메시지
		model.addAttribute("resultMsg", "success.common.update");
		return "forward:/cmm/main/mainPage.do";
	}
}
