package egovframework.let.ass.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.ass.service.AssetInfoVO;
import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetService;
import egovframework.let.prj.service.ProjectService;

/**
 * 자산관리를 위한 컨트롤러 클래스
 * 
 * @author 영남사업부 주소현
 * @since 2023.04.13
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.13  주소현          최초 생성
 *
 *      </pre>
 */
@Controller
public class AssetController {

	@Resource(name = "AssetService")
	private AssetService assetService;

	@Resource(name = "ProjectService")
	protected ProjectService projectService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/**
	 * 자산조회 페이지로 이동
	 */
	@RequestMapping(value = "/ass/AssetManagement.do")
	public String AssetManagement(HttpServletRequest request, ModelMap model,
			@ModelAttribute("searchVO") AssetManageVO assetHistVO) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		assetHistVO.setPageUnit(propertyService.getInt("pageUnit"));
		assetHistVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(assetHistVO.getPage());
		paginationInfo.setRecordCountPerPage(assetHistVO.getPageUnit());
		paginationInfo.setPageSize(assetHistVO.getPageSize());

		assetHistVO.setStartPage(paginationInfo.getFirstRecordIndex());
		assetHistVO.setLastPage(paginationInfo.getLastRecordIndex());
		assetHistVO.setTotalRecord(paginationInfo.getRecordCountPerPage());

		Map<String, Object> map = assetService.SelectAssetHistVOList(assetHistVO);

		int totCnt = Integer.parseInt((String) map.get("resultCnt"));

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "/ass/AssetManagement";
	}

	/**
	 * 자산등록 페이지로 이동
	 */
	@RequestMapping(value = "/ass/AssetRegist.do")
	public String AssetRegist(HttpServletRequest request, ModelMap model, @ModelAttribute("AssetInfoVO") AssetInfoVO assetInfoVO) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		// 조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));

		model.addAttribute("projects", null);

		return "/ass/AssetRegist";
	}
	
	/**
	 * 자산등록 
	 */
	@RequestMapping(value = "/ass/AssetInsert.do")
	public String AssetInsert(@ModelAttribute("AssetInfoVO") AssetManageVO assetInfoVO, BindingResult bindingResult) throws Exception {
		

		return "forward:/ass/AssetManagement.do";
	}

	/**
	 * 반납신청조회 페이지로 이동
	 */
	@RequestMapping(value = "/ass/ReturnRequest.do")
	public String ReturnRequest(HttpServletRequest request) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		return "/ass/ReturnRequest";
	}

	/**
	 * 파손신청조회 페이지로 이동
	 */
	@RequestMapping(value = "/ass/DisposeRequest.do")
	public String DisposeRequest(HttpServletRequest request) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		return "/ass/DisposeRequest";
	}

	/**
	 * 수리신청조회 페이지로 이동
	 */
	@RequestMapping(value = "/ass/RepairRequest.do")
	public String RepairRequest(HttpServletRequest request) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		return "/ass/RepairRequest";
	}

}
