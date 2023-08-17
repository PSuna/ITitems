package egovframework.let.res.req.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.res.cat.service.CategoryManageVO;
import egovframework.let.res.cat.service.CategoryService;
import egovframework.let.res.req.service.RequestDetailVO;
import egovframework.let.res.req.service.RequestManageVO;
import egovframework.let.res.req.service.RequestService;
import egovframework.let.res.req.service.RequestVO;
import egovframework.let.res.uss.umt.service.UserManageService;
import egovframework.let.res.uss.umt.service.UserManageVO;

/**
 * 신청관리를 위한 컨트롤러 클래스
 * 
 * @author 영남사업부 주소현
 * @since 2023.04.26
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.26  주소현          최초 생성
 *
 *      </pre>
 */

@Controller
public class RequestController {

	@Resource(name = "RequestService")
	private RequestService requestService;
	
	@Resource(name = "CategoryService")
	protected CategoryService categoryService;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name = "userManageService")
	private UserManageService userManageService;


	/**
	 * 반출입 페이지로 이동
	 */
	@RequestMapping(value = "/req/CarryRequset.do")
	public String CarryRequset(HttpServletRequest request, ModelMap model,RequestManageVO manageVO) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");  
		LoginVO loginId = (LoginVO)request.getSession().getAttribute("LoginVO");
		
		manageVO.setId(loginId.getUniqId());
		manageVO.setAuthorCode(loginId.getAuthorCode());
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(manageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(manageVO.getPageUnit());
		paginationInfo.setPageSize(manageVO.getPageSize());

		manageVO.setStartPage(paginationInfo.getFirstRecordIndex());
		manageVO.setLastPage(paginationInfo.getLastRecordIndex());
		manageVO.setTotalRecord(paginationInfo.getRecordCountPerPage());
		
		if(manageVO.getMenuStartDate() != null && manageVO.getMenuStartDate() != "") {
			manageVO.setStartDate(manageVO.getMenuStartDate());
		}
		if(manageVO.getMenuEndDate() != null && manageVO.getMenuEndDate() != "") {
			manageVO.setEndDate(manageVO.getMenuEndDate());
		}
		if(manageVO.getMenuOrgnzt() != null && manageVO.getMenuOrgnzt() != "") {
			manageVO.setSearchOrgnzt(manageVO.getMenuOrgnzt());
		}
		
		Map<String, Object> map = requestService.SelectRequestVOList(manageVO);
		
		int totCnt = Integer.parseInt((String) map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		vo.setCodeId("COM008");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		//결재요청분류코드를 코드정보로부터 조회 - COM011
		vo.setCodeId("COM011");
		model.addAttribute("group_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		model.addAttribute("searchVO", manageVO);
		
		return "/req/CarryRequset";
	}
	
	/**
	 * 반출신청 등록 페이지로 이동
	 */
	@RequestMapping(value = "/req/CarryRegist.do")
	public String CarryRegist(HttpServletRequest request, ModelMap model, RequestManageVO manageVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		request.getSession().setAttribute("baseMenuNo", "100");
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		System.out.println("orgnztId_result ====================== "+cmmUseService.selectOgrnztIdDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		System.out.println("LCat_result ====================== "+ categoryService.SelectCategoryVOList(cvo));
		
		UserManageVO userManageVO = new UserManageVO();
		userManageVO = userManageService.selectUser(user.getUniqId());
		vo.setCode(userManageVO.getGrade());
		userManageVO.setGrade(cmmUseService.selectCodeDetail(vo) != null ? cmmUseService.selectCodeDetail(vo).getCodeNm():null);
		model.addAttribute("userManageVO", userManageVO);

		model.addAttribute("searchVO", manageVO);

		
		return "/req/CarryRegist";
	}
	
	/**
	 * 반입신청 등록 페이지로 이동
	 */
	@RequestMapping(value = "/req/CarryInRegist.do")
	public String CarryInRegist(HttpServletRequest request, ModelMap model, RequestManageVO manageVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		request.getSession().setAttribute("baseMenuNo", "100");

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		UserManageVO userManageVO = new UserManageVO();
		userManageVO = userManageService.selectUser(user.getUniqId());
		vo.setCode(userManageVO.getGrade());
		userManageVO.setGrade(cmmUseService.selectCodeDetail(vo) != null ? cmmUseService.selectCodeDetail(vo).getCodeNm():null);
		model.addAttribute("userManageVO", userManageVO);
		model.addAttribute("searchVO", manageVO);
		
		return "/req/CarryInRegist";
	}
	
	/**
	 * 신청 등록
	 */
	@RequestMapping(value = "/req/insertRequest.do")
	@ResponseBody
	public String insertRequest(RequestVO requestVO) throws Exception {
		requestService.InsertRequestVO(requestVO);
		return requestVO.getReqId();
	}
	
	/**
	 * 신청상세 등록
	 */
	@RequestMapping(value = "/req/insertRequestDetail.do")
	@ResponseBody
	public String insertRequestDetail(RequestVO requestVO, RequestDetailVO requestDetailVO) throws Exception {
		requestService.InsertRequestDetailVO(requestDetailVO);
		return requestVO.getReqId();
	}
	
	/**
	 * 반출/반입상세정보 페이지로 이동
	 */
	@RequestMapping(value = "/req/SelectCarry.do")
	public String SelectCarry(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") RequestManageVO manageVO) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");
		model.addAttribute("resultVO", requestService.SelectRequestVO(manageVO));
		model.addAttribute("resultList",requestService.SelectRequestDetailVOList(manageVO));
		model.addAttribute("aprvList_result",requestService.SelectAprvList(manageVO));
		model.addAttribute("searchVO", manageVO);
		return "/req/SelectCarry";
	}
	
	/**
	 * 처분신청조회 페이지로 이동
	 */
	/**
	@RequestMapping(value = "/req/DisposeRequest.do")
	public String DisposeRequest(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		vo.setCodeId("COM008");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		return "/req/DisposeRequest";
	}
	*/
	/**
	 * 수리신청조회 페이지로 이동
	 */
	/**
	@RequestMapping(value = "/req/RepairRequest.do")
	public String RepairRequest(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		vo.setCodeId("COM008");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		
		return "/req/RepairRequest";
	}
	*/
	
}
