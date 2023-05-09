package egovframework.let.sec.asm.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetService;
import egovframework.let.cat.service.CategoryManageVO;
import egovframework.let.cat.service.CategoryService;
import egovframework.let.prj.service.ProjectService;
import egovframework.let.uss.umt.service.UserManageService;

/**
 * 사이트관리 > 자산관리를 위한 컨트롤러 클래스
 * 
 * @author 영남사업부 천세훈
 * @since 2023.05.08
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.05.08  천세훈          최초 생성
 *
 *      </pre>
 */
@Controller
public class SecAssetManageController {
	@Resource(name = "AssetService")
	private AssetService assetService;

	@Resource(name = "ProjectService")
	protected ProjectService projectService;
	
	@Resource(name = "CategoryService")
	protected CategoryService categoryService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@Resource(name = "userManageService")
	private UserManageService userManageService;
	
	/**
	 * 자산조회 페이지로 이동
	 */
	@RequestMapping(value = "/sec/asm/SecAssetManage.do")
	public String AssetManagement(HttpServletRequest request, ModelMap model,
			 AssetManageVO assetManageVO) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(assetManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(assetManageVO.getPageUnit());
		paginationInfo.setPageSize(assetManageVO.getPageSize());

		assetManageVO.setStartPage(paginationInfo.getFirstRecordIndex());
		assetManageVO.setLastPage(paginationInfo.getLastRecordIndex());
		assetManageVO.setTotalRecord(paginationInfo.getRecordCountPerPage());

		Map<String, Object> map = assetService.SelectAssetInfoVOList(assetManageVO);

		int totCnt = Integer.parseInt((String) map.get("resultCnt"));

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
	
		vo.setCodeId("COM006");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		model.addAttribute("searchVO", assetManageVO);
		
		return "/sec/asm/SecAssetManage";
	}
}
