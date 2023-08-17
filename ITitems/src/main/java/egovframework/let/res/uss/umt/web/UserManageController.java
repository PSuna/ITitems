package egovframework.let.res.uss.umt.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.res.sec.ram.service.AuthorManageVO;
import egovframework.let.res.sec.ram.service.EgovAuthorManageService;
import egovframework.let.res.sec.rgm.service.AuthorGroupVO;
import egovframework.let.res.sec.rgm.service.EgovAuthorGroupService;
import egovframework.let.res.uss.umt.service.UserDefaultVO;
import egovframework.let.res.uss.umt.service.UserManageService;
import egovframework.let.res.uss.umt.service.UserManageVO;
import egovframework.let.res.utl.sim.service.EgovFileScrty;

/**
 * 사용자관련 요청을  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
 * @author 영남사업부 천세훈
 * @since 2023.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2023.04.10  천세훈         최초 생성
 *
 *
 * </pre> 
 */
@Controller
public class UserManageController {

	/** userManageService */
	@Resource(name = "userManageService")
	private UserManageService userManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "egovAuthorManageService")
    private EgovAuthorManageService egovAuthorManageService;
	
	@Resource(name = "egovAuthorGroupService")
    private EgovAuthorGroupService egovAuthorGroupService;

	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param userSearchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/user/EgovUserManage.do")
	public String selectUserList(@ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, 
								 ModelMap model,
								 HttpServletRequest request) throws Exception {

		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("baseMenuNo", "6000000");
		
		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}
    	
		userSearchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userSearchVO.getPageUnit());
		paginationInfo.setPageSize(userSearchVO.getPageSize());

		userSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		model.addAttribute("resultList", userManageService.selectUserList(userSearchVO));

		int totCnt = userManageService.selectUserListTotCnt(userSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		//사용자상태코드를 코드정보로부터 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM013");
		model.addAttribute("emplyrSttusCode_result", cmmUseService.selectCmmCodeDetail(vo));//사용자상태코드목록
		
		//직급코드를 코드정보로부터 조회 - COM002 
		vo.setCodeId("COM002");
		model.addAttribute("grd_result", cmmUseService.selectCmmCodeDetail(vo));
		
		//권한코드를 조회 
		vo.setTableNm("LETTNAUTHORINFO");
		model.addAttribute("auth_result", cmmUseService.selectAuthorCodeDetail(vo));

		//조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));

		return "cmm/uss/umt/EgovUserManage";
	}
	
	/**
	 * 사용자목록 조회 팝업창으로 이동
	 */
	@RequestMapping(value = "/uss/umt/user/SearchUserList.do")
	public String SearchUserList(@ModelAttribute("userSearchVO") UserDefaultVO userSearchVO,
								ModelMap model, HttpServletRequest request) throws Exception {

		/** EgovPropertyService */
		/* userSearchVO.setPageUnit(propertiesService.getInt("pageUnit")); */
		userSearchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userSearchVO.getPageUnit());
		paginationInfo.setPageSize(userSearchVO.getPageSize());

		userSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		userSearchVO.setEmptyUserShow("on");
		model.addAttribute("resultList", userManageService.selectUserListS(userSearchVO));

		int totCnt = userManageService.selectUserListTotCntS(userSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		//사용자상태코드를 코드정보로부터 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM013");
		model.addAttribute("emplyrSttusCode_result", cmmUseService.selectCmmCodeDetail(vo));//사용자상태코드목록
		//직급코드를 코드정보로부터 조회 - COM002 
		vo.setCodeId("COM002");
		model.addAttribute("grd_result", cmmUseService.selectCmmCodeDetail(vo));

		//조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
		model.addAttribute("SearchVO", userSearchVO);

		return "cmm/uss/umt/SearchUserList";
	}
	
	/**
	 * 전체검색(회원) 조회 팝업창으로 이동
	 */
	@RequestMapping(value = "/uss/umt/user/TotalSearchUserList.do")
	public String TotalSearchUserList(@ModelAttribute("userSearchVO") UserDefaultVO userSearchVO,
								ModelMap model, HttpServletRequest request) throws Exception {

		/** EgovPropertyService */
		/* userSearchVO.setPageUnit(propertiesService.getInt("pageUnit")); */
		userSearchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userSearchVO.getPageUnit());
		paginationInfo.setPageSize(userSearchVO.getPageSize());

		userSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		userSearchVO.setEmptyUserShow("on");
		model.addAttribute("resultList", userManageService.selectUserListS(userSearchVO));

		int totCnt = userManageService.selectUserListTotCntS(userSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		//사용자상태코드를 코드정보로부터 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM013");
		model.addAttribute("emplyrSttusCode_result", cmmUseService.selectCmmCodeDetail(vo));//사용자상태코드목록
		//직급코드를 코드정보로부터 조회 - COM002 
		vo.setCodeId("COM002");
		model.addAttribute("grd_result", cmmUseService.selectCmmCodeDetail(vo));

		//조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
		model.addAttribute("SearchVO", userSearchVO);

		return "cmm/uss/umt/TotalSearchUserList";
	}


	/**
	 * 사용자등록화면으로 이동한다.
	 * @param userSearchVO 검색조건정보
	 * @param userManageVO 사용자초기화정보
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovUserInsert
	 * @throws Exception
	 */
	@RequestMapping("/uss/umt/user/EgovUserInsertView.do")
	public String insertUserView(@ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, 
								 @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, 
								 @ModelAttribute("userManageVO") UserManageVO userManageVO, 
								 Model model)
			throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//직급코드를 코드정보로부터 조회 - COM002 
		vo.setCodeId("COM002");
		model.addAttribute("grd_result", cmmUseService.selectCmmCodeDetail(vo));

		//조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));

		//권한정보를 조회
		authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
		
		return "cmm/uss/umt/EgovUserInsert";
	}

	/**
	 * 사용자등록처리
	 * @param userManageVO 사용자등록정보
	 * @param bindingResult 입력값검증용 bindingResult
	 * @param model 화면모델
	 * @throws Exception
	 */
	
	@RequestMapping("/uss/umt/user/EgovUserInsert.do")
	@ResponseBody
	public String insertUser(UserManageVO userManageVO, Errors errors,
							AuthorManageVO authorManageVO, 
							Model model) throws Exception {
		
		userManageVO.setAuthorCode("ROLE_USER_MEMBER");
		userManageVO.setPassword("iteyes00");
		if(userManageVO.getLowerOrgnzt() != null && !userManageVO.getLowerOrgnzt().equals("")) {
			userManageVO.setOrgnztId(userManageVO.getLowerOrgnzt());
		}
		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//직급코드를 코드정보로부터 조회 - COM002 
		vo.setCodeId("COM002");
		model.addAttribute("grd_result", cmmUseService.selectCmmCodeDetail(vo));

		//조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));

		//권한정보를 조회
		authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());

		int r = userManageService.insertUser(userManageVO);
		model.addAttribute("resultMsg", "success.common.insert");
		String result = String.valueOf(r);
		return result;
	}

	/**
	 * 사용자정보 수정을 위해 사용자정보를 상세조회한다.
	 * @param uniqId 상세조회대상 사용자아이디
	 * @param userSearchVO 검색조건
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovUserSelectUpdt
	 * @throws Exception
	 */
	@RequestMapping("/uss/umt/user/EgovUserSelectUpdtView.do")
	public String updateUserView(@RequestParam("selectedId") String uniqId, 
								@ModelAttribute("searchVO") UserDefaultVO userSearchVO, 
								@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, 
								@ModelAttribute("authorGroupVO") AuthorGroupVO authorGroupVO,
								Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
		
		//직급코드를 코드정보로부터 조회 - COM002 
		vo.setCodeId("COM002");
		model.addAttribute("grd_result", cmmUseService.selectCmmCodeDetail(vo));

		//그룹정보를 조회 - GROUP_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("groupId_result", cmmUseService.selectGroupIdDetail(vo));
		
		UserManageVO userManageVO = new UserManageVO();
		userManageVO = userManageService.selectUser(uniqId);
		String UpperOrg = userManageService.checkUpper(uniqId);
		if( UpperOrg !=null ) {
			userManageVO.setLowerOrgnzt(userManageVO.getOrgnztId());
			userManageVO.setOrgnztId(UpperOrg);
		}
		model.addAttribute("userSearchVO", userSearchVO);
		model.addAttribute("userManageVO", userManageVO);

		return "cmm/uss/umt/EgovUserSelectUpdt";
	}

	/**
	 * 사용자정보 수정
	 * @param userManageVO 사용자수정정보
	 * @param bindingResult 입력값검증용 bindingResult
	 * @param model 화면모델
	 * @throws Exception
	 */
	@RequestMapping("/uss/umt/user/EgovUserSelectUpdt.do")
	@ResponseBody
	public String updateUser(@ModelAttribute("userManageVO") UserManageVO userManageVO, BindingResult bindingResult, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

    	if(userManageVO.getLowerOrgnzt() != null && userManageVO.getLowerOrgnzt() != "") {
			userManageVO.setOrgnztId(userManageVO.getLowerOrgnzt());
		}
    	
    	
		//업무사용자 수정시 히스토리 정보를 등록한다.
		int r = userManageService.updateUser(userManageVO);
		//Exception 없이 진행시 수정성공메시지
		model.addAttribute("resultMsg", "success.common.update");
		String result = String.valueOf(r);
		return result;
	}

	/**
	 * 사용자정보삭제후 목록조회 화면으로 이동한다.
	 * @param checkedIdForDel 삭제대상아이디 정보
	 * @param userSearchVO 검색조건
	 * @param model 화면모델
	 * @return forward:/uss/umt/user/EgovUserManage.do
	 * @throws Exception
	 */
	@RequestMapping("/uss/umt/user/EgovUserDelete.do")
	public String deleteUser(@RequestParam("checkedIdForDel") String checkedIdForDel, @ModelAttribute("searchVO") UserDefaultVO userSearchVO, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		userManageService.deleteUser(checkedIdForDel);
		//Exception 없이 진행시 등록성공메시지
		model.addAttribute("resultMsg", "success.common.delete");
		return "forward:/uss/umt/user/EgovUserManage.do";
	}

	/**
	 * 입력한 사용자아이디의 중복확인화면 이동
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovIdDplctCnfirm
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/cmm/EgovIdDplctCnfirmView.do")
	public String checkIdDplct(ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		model.addAttribute("checkId", "");
		model.addAttribute("usedCnt", "-1");
		return "cmm/uss/umt/EgovIdDplctCnfirm";
	}

	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인
	 * @param commandMap 파라메터전달용 commandMap
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovIdDplctCnfirm
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/cmm/EgovIdDplctCnfirm.do")
	public String checkIdDplct(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		String checkId = (String) commandMap.get("checkId");
		checkId = new String(checkId.getBytes("ISO-8859-1"), "UTF-8");

		if (checkId == null || checkId.equals(""))
			return "forward:/uss/umt/EgovIdDplctCnfirmView.do";
		checkId = checkId + "@iteyes.co.kr";
		int usedCnt = userManageService.checkIdDplct(checkId);
		checkId = (String) commandMap.get("checkId");
		model.addAttribute("usedCnt", usedCnt);
		model.addAttribute("checkId", checkId);

		return "cmm/uss/umt/EgovIdDplctCnfirm";
	}

	/**
	 * 업무사용자 암호 수정처리 후 화면 이동
	 * @param model 화면모델
	 * @param commandMap 파라메터전달용 commandMap
	 * @param userSearchVO 검색조 건
	 * @param userManageVO 사용자수정정보(비밀번호)
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/user/EgovUserPasswordUpdt.do")
	public String updatePassword(ModelMap model, @RequestParam Map<String, Object> commandMap, @ModelAttribute("searchVO") UserDefaultVO userSearchVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO) throws Exception {

		String id = userManageVO.getUniqId();
		
		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		String oldPassword = (String) commandMap.get("oldPassword");
		String newPassword = (String) commandMap.get("newPassword");
		String uniqId = (String) commandMap.get("uniqId");

		boolean isCorrectPassword = false;
		userManageVO.setPassword(newPassword);
		userManageVO.setOldPassword(oldPassword);
		userManageVO.setUniqId(uniqId);

		String resultMsg = "";
		isCorrectPassword = true;

		if (isCorrectPassword) {
			userManageVO.setPassword(EgovFileScrty.encryptPassword(newPassword, userManageVO.getEmplyrId()));
			userManageService.updatePassword(userManageVO);
			model.addAttribute("userManageVO", userManageVO);
			resultMsg = "success.common.update";
		} else {
			model.addAttribute("userManageVO", userManageVO);
		}
		model.addAttribute("userSearchVO", userSearchVO);
		model.addAttribute("resultMsg", resultMsg);

		return "forward:/uss/umt/user/EgovUserSelectUpdtView.do?selectedId="+id;
	}

	/**
	 * 업무사용자 암호 수정  화면 이동
	 * @param model 화면모델
	 * @param commandMap 파라메터전달용 commandMap
	 * @param userSearchVO 검색조건
	 * @param userManageVO 사용자수정정보(비밀번호)
	 * @return cmm/uss/umt/EgovUserPasswordUpdt
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/umt/user/EgovUserPasswordUpdtView.do")
	public String updatePasswordView(ModelMap model, @RequestParam Map<String, Object> commandMap, @ModelAttribute("searchVO") UserDefaultVO userSearchVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		String userTyForPassword = (String) commandMap.get("userTyForPassword");
		userManageVO.setUserTy(userTyForPassword);

		model.addAttribute("userManageVO", userManageVO);
		model.addAttribute("userSearchVO", userSearchVO);
		return "cmm/uss/umt/EgovUserPasswordUpdt";
	}
	
	/**
	 * 사용자목록 조회 팝업창으로 이동
	 */
	@RequestMapping(value = "/uss/umt/user/SearchNeUserList.do")
	public String SearchNeUserList(@ModelAttribute("userSearchVO") UserDefaultVO userSearchVO,
								ModelMap model, HttpServletRequest request) throws Exception {

		/** EgovPropertyService */
		/* userSearchVO.setPageUnit(propertiesService.getInt("pageUnit")); */
		userSearchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userSearchVO.getPageUnit());
		paginationInfo.setPageSize(userSearchVO.getPageSize());

		userSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		userSearchVO.setEmptyUserShow("off");
		model.addAttribute("resultList", userManageService.selectUserListS(userSearchVO));

		int totCnt = userManageService.selectUserListTotCntS(userSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		//사용자상태코드를 코드정보로부터 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM013");
		model.addAttribute("emplyrSttusCode_result", cmmUseService.selectCmmCodeDetail(vo));//사용자상태코드목록
		//직급코드를 코드정보로부터 조회 - COM002 
		vo.setCodeId("COM002");
		model.addAttribute("grd_result", cmmUseService.selectCmmCodeDetail(vo));

		//조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
		model.addAttribute("SearchVO", userSearchVO);

		return "cmm/uss/umt/SearchUserList";
	}

}