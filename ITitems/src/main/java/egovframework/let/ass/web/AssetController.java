package egovframework.let.ass.web;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections4.map.HashedMap;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.ass.service.AssetHistVO;
import egovframework.let.ass.service.AssetInfoVO;
import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetService;
import egovframework.let.cat.service.CategoryManageVO;
import egovframework.let.cat.service.CategoryService;
import egovframework.let.prj.service.ProjectService;
import egovframework.let.uss.umt.service.UserManageService;
import egovframework.let.uss.umt.service.UserManageVO;

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
	@RequestMapping(value = "/ass/AssetManagement.do")
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
		
		return "/ass/AssetManagement";
	}
	
	/**
	 * 자산조회 팝업창로 이동
	 */
	@RequestMapping(value = "/ass/AssetSearchList.do")
	public String AssetSearchList(HttpServletRequest request, ModelMap model,
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
		
		return "/ass/AssetSearchList";
	}
	
	/**
	 * 자산내역 검색
	 */
	
	@RequestMapping(value = "/ass/SearchAsserList.do")
	@ResponseBody
	public Object SearchAsserList(AssetManageVO assetManageVO) throws Exception {

		Map<String, Object> map = assetService.SelectAssetInfoVOList(assetManageVO);
		
		return map.get("resultList");
	}
	
	/**
	 * 자산상세정보 페이지로 이동
	 */
	@RequestMapping(value = "/ass/SelectAsset.do")
	public String SelectAsset(HttpServletRequest request, ModelMap model, AssetManageVO assetManageVO) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");
		
		AssetInfoVO result = assetService.SelectAssetInfoVO(assetManageVO);
		model.addAttribute("resultVO", result);
		
		FileVO fvo = new FileVO();
		fvo.setAtchFileId(result.getPhotoId());
		
		model.addAttribute("resultPhoto", fileMngService.selectFileInf(fvo));
		
		Map<String, Object> map = assetService.SelectAssetHistVOList(assetManageVO);
		model.addAttribute("resultList", map.get("resultList"));
		 
		
		return "/ass/SelectAsset";
	}
	

	/**
	 * 자산등록 페이지로 이동
	 */
	@RequestMapping(value = "/ass/AssetRegist.do")
	public String AssetRegist(HttpServletRequest request, ModelMap model, @ModelAttribute("AssetInfoVO") AssetInfoVO assetInfoVO) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
	
		return "/ass/AssetRegist";
	}
	
	/**
	 * 자산등록 
	 */
	@RequestMapping(value = "/ass/AssetInsert.do")
	@ResponseBody
	public String AssetInsert(MultipartHttpServletRequest multiRequest, AssetInfoVO assetInfoVO, AssetHistVO assetHistVO, BindingResult bindingResult) throws Exception {
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		assetInfoVO.setRegId(user.getUniqId());
		assetInfoVO.setUsageStatus("U1");

		if (isAuthenticated) {
			Map<String, MultipartFile> photos = new HashedMap<String, MultipartFile>();
			photos.put("photo", multiRequest.getFile("photo"));
			if (!photos.isEmpty()) {
				List<FileVO> result = fileUtil.parseFileInf(photos, "BBS_", 0, "", "");
				assetInfoVO.setPhotoId(fileMngService.insertFileInfs(result));
			}
			Map<String, MultipartFile> files = new HashedMap<String, MultipartFile>();
			files.put("file", multiRequest.getFile("file"));
			if (!files.isEmpty()) {
				List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
				assetHistVO.setFileId(fileMngService.insertFileInfs(result));
			}
		}
		
		assetService.InsertAssetInfo(assetInfoVO);
		
		assetHistVO.setAssetId(assetInfoVO.getAssetId());
		assetHistVO.setHistStatus("P0");
		assetHistVO.setHistNote(assetInfoVO.getNote());
		assetHistVO.setHistQty(assetInfoVO.getAssetQty());
		assetService.InsertAssetHist(assetHistVO);
		
		return "forward:/ass/AssetManagement.do";
	}
	
	/**
	 * 자산수정 페이지로 이동
	 */
	@RequestMapping(value = "/ass/AssetUpdt.do")
	public String AssetUpdt(HttpServletRequest request, ModelMap model, AssetManageVO assetManageVO) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		AssetInfoVO result = assetService.SelectAssetInfoVO(assetManageVO);
		model.addAttribute("resultVO", result);
	
		return "/ass/AssetUpdt";
	}

}
