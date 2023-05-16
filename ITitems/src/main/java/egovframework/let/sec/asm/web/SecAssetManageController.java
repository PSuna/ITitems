package egovframework.let.sec.asm.web;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.ass.service.AssetInfoVO;
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
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	/**
	 * 자산조회 페이지로 이동
	 */
	@RequestMapping(value = "/sec/asm/SecAssetManage.do")
	public String AssetManagement(HttpServletRequest request, ModelMap model,
			 @ModelAttribute("searchVO") AssetManageVO assetManageVO) throws Exception {
		
		//미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}
		
    	// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
    	request.getSession().setAttribute("baseMenuNo", "6000000");
    	
    	assetManageVO.setPageSize(propertiesService.getInt("pageSize"));
    	
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(assetManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(assetManageVO.getPageUnit());
		paginationInfo.setPageSize(assetManageVO.getPageSize());

		assetManageVO.setStartPage(paginationInfo.getFirstRecordIndex());
		assetManageVO.setLastPage(paginationInfo.getLastRecordIndex());
		assetManageVO.setTotalRecord(paginationInfo.getRecordCountPerPage());

		Map<String, Object> map = assetService.SelectAssetInfoVOList(assetManageVO);

		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		
		int totCnt = Integer.parseInt((String) map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
	
		vo.setCodeId("COM006");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		return "/sec/asm/SecAssetManage";
	}
	
	/**
	 * 자산상세정보 페이지로 이동
	 */
	@RequestMapping(value = "/sec/asm/SecSelectAsset.do")
	public String SelectAsset(HttpServletRequest request, ModelMap model, AssetManageVO assetManageVO) throws Exception {
		
		AssetInfoVO result = assetService.SelectAssetInfoVO(assetManageVO);
		model.addAttribute("resultVO", result);
		
		FileVO fvo = new FileVO();
		fvo.setAtchFileId(result.getPhotoId());
		
		model.addAttribute("resultPhoto", fileMngService.selectFileInf(fvo));
		 
		
		return "/sec/asm/SecSelectAsset";
	}
	
	/**
	 * 자산수정 페이지로 이동
	 */
	@RequestMapping(value = "/sec/asm/SecAssetUpdt.do")
	public String AssetUpdt(HttpServletRequest request, ModelMap model, AssetManageVO assetManageVO) throws Exception {

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		AssetInfoVO result = assetService.SelectAssetInfoVO(assetManageVO);
		model.addAttribute("resultVO", result);
	
		return "/sec/asm/SecAssetUpdt";
	}
	/**
	 * 자산수정
	 */
	@RequestMapping(value = "/sec/asm/SecAssetUpdate.do")
	public String AssetUpdate(MultipartHttpServletRequest multiRequest, AssetInfoVO assetInfoVO) throws Exception {

		Map<String, MultipartFile> photos = new HashedMap<String, MultipartFile>();
		photos.put("photo", multiRequest.getFile("photo"));
		if (!photos.isEmpty()) {
			List<FileVO> result = fileUtil.parseFileInf(photos, "BBS_", 0, "", "");
			assetInfoVO.setPhotoId(fileMngService.insertFileInfs(result));
		}
		
		assetService.UpdateAssetInfo(assetInfoVO);
		
		return "forward:/sec/asm/SecSelectAsset.do";
	}
	
	/**
	 * 제품사진 안내 팝업창로 이동
	 */
	@RequestMapping(value = "/sec/asm/PhotoManual.do")
	public String PhotoManual() throws Exception {

		return "/sec/asm/PhotoManual";
	}
}
