package egovframework.let.res.main.web;

import java.util.Map;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.res.aprv.service.ApprovalDefaultVO;
import egovframework.let.res.aprv.service.ApprovalManageService;
import egovframework.let.res.cop.bbs.service.BoardVO;
import egovframework.let.res.cop.bbs.service.EgovBBSManageService;
import egovframework.let.res.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.let.res.sym.mnu.mpm.service.MenuManageVO;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

/**
 * 템플릿 메인 페이지 컨트롤러 클래스(Sample 소스)
 * 
 * @author 실행환경 개발팀 JJY
 * @since 2011.08.31
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2011.08.31  JJY            최초 생성
 *
 *      </pre>
 */
@Controller
@SessionAttributes(types = ComDefaultVO.class)
@RequestMapping("/res")
public class EgovMainController {
	
	String path = "/res";

	/**
	 * EgovBBSManageService
	 */
	@Resource(name = "EgovBBSManageService")
	private EgovBBSManageService bbsMngService;

	/** approvalManageService */
	@Resource(name = "approvalManageService")
	private ApprovalManageService approvalManageService;

	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
	private EgovMenuManageService menuManageService;

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	/**
	 * 메인 페이지에서 각 업무 화면으로 연계하는 기능을 제공한다.
	 *
	 * @param request
	 * @param commandMap
	 * @exception Exception Exception
	 */
	/*
	@RequestMapping(value = "/cmm/forwardPage.do")
	public String forwardPageWithMenuNo(HttpServletRequest request, @RequestParam Map<String, Object> commandMap)
			throws Exception {
		return "";
	}
	*/

	/**
	 * 템플릿 메인 페이지 조회
	 * 
	 * @return 메인페이지 정보 Map [key : 항목명]
	 *
	 * @param request
	 * @param model
	 * @exception Exception Exception
	 */
	@RequestMapping(value = "/cmm/main/mainPage.do")
	public String getMgtMainPage(ApprovalDefaultVO approvalSearchVO, HttpServletRequest request, ModelMap model)
			throws Exception {
		LoginVO loginId = (LoginVO) request.getSession().getAttribute("LoginVO");

		approvalSearchVO.setUniqId(loginId.getUniqId());
		// 공지사항 메인 컨텐츠 조회 시작 ---------------------------------
		BoardVO boardVO = new BoardVO();
		boardVO.setPageUnit(3);
		boardVO.setPageSize(3);
		boardVO.setBbsId("BBSMSTR_AAAAAAAAAAAA");
		approvalSearchVO.setPageUnit(3);
		approvalSearchVO.setPageSize(3);
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		boardVO.setUseAt("Y");
		approvalSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		approvalSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		approvalSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, "BBSA02");
		model.addAttribute("notiList", map.get("resultList"));

		model.addAttribute("resultList", approvalManageService.selectApprovalListB(approvalSearchVO));
		int totCnt = approvalManageService.selectApprovalListTotCntB(approvalSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		// 공지사항 메인컨텐츠 조회 끝 -----------------------------------

		// 가이드 추가
		FileVO fvo = new FileVO();
		fvo.setFileType("WEBG");
		model.addAttribute("webG", fileMngService.selectFileVO(fvo));

		fvo.setFileType("MOBG");
		model.addAttribute("mobG", fileMngService.selectFileVO(fvo));
		
		fvo.setFileType("APK");
		model.addAttribute("APK", fileMngService.selectFileVO(fvo));
		
		fvo.setFileType("APKG");
		model.addAttribute("APKG", fileMngService.selectFileVO(fvo));
		// 모바일 화면으로 forward
		if (loginId.getIsMob() == "success") {
			System.out.println("main컨트롤러 모바일 실행");
			return "forward:/uat/uia/mob/goMobile.do";
		} else {
			// web인경우
			System.out.println("메인 컨트롤러 웹 실행");
			return path + "/main/EgovMainView";
		}
	}

	/**
	 * Header Page를 조회한다.
	 * 
	 * @param menuManageVO MenuManageVO
	 * @return 출력페이지정보 "EgovIncHeader"
	 * @exception Exception
	 */
	@RequestMapping(value = "/sym/mms/EgovHeader.do")
	public String selectHeader(@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
			@RequestParam(value = "flag", required = false) String flag, ModelMap model) throws Exception {

		LoginVO user = EgovUserDetailsHelper.isAuthenticated() ? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;
		if (EgovUserDetailsHelper.isAuthenticated() && user != null) {
			menuManageVO.setTmp_Id(user.getId());
			menuManageVO.setTmp_Password(user.getPassword());
			menuManageVO.setTmp_UserSe(user.getUserSe());
			menuManageVO.setTmp_Name(user.getName());
			menuManageVO.setTmp_Email(user.getEmail());
			menuManageVO.setTmp_OrgnztId(user.getOrgnztId());
			menuManageVO.setTmp_UniqId(user.getUniqId());

			model.addAttribute("list_headmenu", menuManageService.selectMainMenuHead(menuManageVO));
			model.addAttribute("list_menulist", menuManageService.selectMainMenuLeft(menuManageVO));
		} else {
			menuManageVO.setAuthorCode("ROLE_ANONYMOUS");
//    		
//    		model.addAttribute("list_headmenu", menuManageService.selectMainMenuHeadByAuthor(menuManageVO));
//    		model.addAttribute("list_menulist", menuManageService.selectMainMenuLeftByAuthor(menuManageVO));
//    		
		}

		return path + "/main/inc/EgovIncHeader"; // 업무화면의 상단메뉴 화면

	}

	/**
	 * Footer Page를 조회한다.
	 * 
	 * @param
	 * @return 출력페이지정보 "EgovIncFooter"
	 * @exception Exception
	 */
	@RequestMapping(value = "/sym/mms/EgovFooter.do")
	public String selectFooter(ModelMap model) throws Exception {
		return path + "/main/inc/EgovIncFooter";
	}

	/**
	 * 좌측메뉴를 조회한다.
	 * 
	 * @param
	 * @return 출력페이지정보 "EgovIncLeftmenu"
	 * @exception Exception
	 */
	@RequestMapping(value = "/sym/mms/EgovMenuLeft.do")
	public String selectMenuLeft(ModelMap model) throws Exception {
		return path + "/main/inc/EgovIncLeftmenu";
	}

	/**
	 * Head메뉴를 조회한다.
	 * 
	 * @param menuManageVO MenuManageVO
	 * @return 출력페이지정보 "main_headG", "main_head"
	 * @exception Exception
	 */
	/*
	@RequestMapping(value = "/sym/mms/EgovMainMenuHead.do")
	public String selectMainMenuHead(@ModelAttribute("menuManageVO") MenuManageVO menuManageVO, ModelMap model)
			throws Exception {

		LoginVO user = EgovUserDetailsHelper.isAuthenticated() ? (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()
				: null;

		if (EgovUserDetailsHelper.isAuthenticated() && user != null) {
			menuManageVO.setTmp_Id(user.getId());
			menuManageVO.setTmp_Password(user.getPassword());
			menuManageVO.setTmp_UserSe(user.getUserSe());
			menuManageVO.setTmp_Name(user.getName());
			menuManageVO.setTmp_Email(user.getEmail());
			menuManageVO.setTmp_OrgnztId(user.getOrgnztId());
			menuManageVO.setTmp_UniqId(user.getUniqId());
			model.addAttribute("list_headmenu", menuManageService.selectMainMenuHead(menuManageVO));
			model.addAttribute("list_menulist", menuManageService.selectMainMenuLeft(menuManageVO));
		} else {
			// model.addAttribute("list_headmenu",
			// menuManageService.selectMainMenuHeadAnonymous(menuManageVO));
			// model.addAttribute("list_menulist",
			// menuManageService.selectMainMenuLeftAnonymous(menuManageVO));
		}
		return "main/inc/EgovIncTopnav"; // 내부업무의 상단메뉴 화면
	}
	*/

	/**
	 * 좌측메뉴를 조회한다.
	 * 
	 * @param menuManageVO MenuManageVO
	 * @param vStartP      String
	 * @return 출력페이지정보 "main_left"
	 * @exception Exception
	 */
	/*
	@RequestMapping(value = "/sym/mms/EgovMainMenuLeft.do")
	public String selectMainMenuLeft(ModelMap model) throws Exception {

		// LoginVO user = EgovUserDetailsHelper.isAuthenticated()?
		// (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;
		// LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if (EgovUserDetailsHelper.isAuthenticated()) {
			// 인증된 경우 처리할 사항 추가 ...
			model.addAttribute("lastLogoutDateTime", "로그아웃 타임: 2011-11-10 11:30");
			// 최근 로그아웃 시간 등에 대한 확보 후 메인 컨텐츠로 활용
		}

		return "main/inc/EgovIncLeftmenu";
	}
	*/

}