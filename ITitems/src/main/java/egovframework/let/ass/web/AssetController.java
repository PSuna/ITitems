package egovframework.let.ass.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetService;
import egovframework.let.ass.service.AssetVO;
import egovframework.let.cat.service.CategoryManageVO;
import egovframework.let.cat.service.CategoryService;
import egovframework.let.prj.service.ProjectService;
import egovframework.let.uss.umt.service.UserManageService;

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
	 * 내자산조회 페이지로 이동
	 */
	@RequestMapping(value = "/ass/MyAssetManagement.do")
	public String MyAssetManagement(HttpServletRequest request, ModelMap model,
			 AssetManageVO assetManageVO, RedirectAttributes redirectAttributes) throws Exception {
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		assetManageVO.setUserId(user.getUniqId());
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(assetManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(assetManageVO.getPageUnit());
		paginationInfo.setPageSize(assetManageVO.getPageSize());

		assetManageVO.setStartPage(paginationInfo.getFirstRecordIndex());
		assetManageVO.setLastPage(paginationInfo.getLastRecordIndex());
		assetManageVO.setTotalRecord(paginationInfo.getRecordCountPerPage());
		
		if(assetManageVO.getMenuStartDate() != null && assetManageVO.getMenuStartDate() != "") {
			assetManageVO.setStartDate(assetManageVO.getMenuStartDate());
		}
		if(assetManageVO.getMenuEndDate() != null && assetManageVO.getMenuEndDate() != "") {
			assetManageVO.setEndDate(assetManageVO.getMenuEndDate());
		}
		
		Map<String, Object> map = assetService.SelectMyAssetVOList(assetManageVO);

		int totCnt = Integer.parseInt((String) map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
	
		vo.setCodeId("COM006");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		model.addAttribute("searchVO", assetManageVO);
		
		model.addAttribute("masterVO", assetService.SelectAssetMaster(assetManageVO));
		
		return "/ass/MyAssetManagement";
	}
	
	/**
	 * 전체자산조회 페이지로 이동
	 */
	@RequestMapping(value = "/ass/AssetManagement.do")
	public String AssetManagement(HttpServletRequest request, ModelMap model,
			 AssetManageVO assetManageVO) throws Exception {
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(assetManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(assetManageVO.getPageUnit());
		paginationInfo.setPageSize(assetManageVO.getPageSize());

		assetManageVO.setStartPage(paginationInfo.getFirstRecordIndex());
		assetManageVO.setLastPage(paginationInfo.getLastRecordIndex());
		assetManageVO.setTotalRecord(paginationInfo.getRecordCountPerPage());
		
		if(assetManageVO.getMenuStartDate() != null && assetManageVO.getMenuStartDate() != "") {
			assetManageVO.setStartDate(assetManageVO.getMenuStartDate());
		}
		if(assetManageVO.getMenuEndDate() != null && assetManageVO.getMenuEndDate() != "") {
			assetManageVO.setEndDate(assetManageVO.getMenuEndDate());
		}
		if(assetManageVO.getMenuOrgnzt() != null && assetManageVO.getMenuOrgnzt() != "") {
			assetManageVO.setSearchOrgnzt(assetManageVO.getMenuOrgnzt());
		}
		if(assetManageVO.getMenuLowerOrgnzt() != null && assetManageVO.getMenuLowerOrgnzt() != "") {
			assetManageVO.setLowerOrgnzt(assetManageVO.getMenuLowerOrgnzt());
		}
		Map<String, Object> map = assetService.SelectAssetVOList(assetManageVO);

		int totCnt = Integer.parseInt((String) map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
	
		vo.setCodeId("COM006");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		model.addAttribute("searchVO", assetManageVO);
		model.addAttribute("masterVO", assetService.SelectAssetMaster(assetManageVO));
		
		return "/ass/AssetManagement";
	}
	
	/**
	 * 자산상세정보 페이지로 이동
	 */
	@RequestMapping(value = "/ass/SelectAsset.do")
	public String SelectAsset(HttpServletRequest request, ModelMap model, AssetManageVO assetManageVO) throws Exception {
		  System.out.println(assetManageVO.getMngNum());
	        System.out.println(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
		AssetVO result = assetService.SelectAssetVO(assetManageVO);
		model.addAttribute("resultVO", result);
		
		Map<String, Object> map = assetService.SelectAssetHistList(assetManageVO);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		
		FileVO fvo = new FileVO();
		fvo.setFileGroup(assetManageVO.getAssetId());
		fvo.setFileType("PHOTO");
		model.addAttribute("PhotoList", fileMngService.selectFileList(fvo));
		fvo.setFileType("FILE");
		model.addAttribute("FileVO", fileMngService.selectFileVO(fvo));
		model.addAttribute("searchVO", assetManageVO);
		model.addAttribute("masterVO", assetService.SelectAssetMaster(assetManageVO));
		
		boolean delReq = true;
		if(assetService.CountdeleteReq(assetManageVO) > 0) {
			delReq = false;
		}
		model.addAttribute("delReq", delReq);
		
		return "/ass/SelectAsset";
	}
	

	/**
	 * 자산등록 페이지로 이동
	 */
	@RequestMapping(value = "/ass/AssetRegist.do")
	public String AssetRegist(HttpServletRequest request, ModelMap model, AssetManageVO assetManageVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("loginId", user.getUniqId());
		
		if(assetManageVO.getMenuStartDate() != null && assetManageVO.getMenuStartDate() != "") {
			assetManageVO.setStartDate(assetManageVO.getMenuStartDate());
		}
		if(assetManageVO.getMenuEndDate() != null && assetManageVO.getMenuEndDate() != "") {
			assetManageVO.setEndDate(assetManageVO.getMenuEndDate());
		}
		if(assetManageVO.getMenuOrgnzt() != null && assetManageVO.getMenuOrgnzt() != "") {
			assetManageVO.setSearchOrgnzt(assetManageVO.getMenuOrgnzt());
		}
		if(assetManageVO.getMenuLowerOrgnzt() != null && assetManageVO.getMenuLowerOrgnzt() != "") {
			assetManageVO.setLowerOrgnzt(assetManageVO.getMenuLowerOrgnzt());
		}
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
	
		vo.setCodeId("COM015");
		model.addAttribute("maker_result", cmmUseService.selectCmmCodeDetail(vo));
		
		model.addAttribute("searchVO", assetManageVO);
		model.addAttribute("masterVO", assetService.SelectAssetMaster(assetManageVO));
		
		return "/ass/AssetRegist";
	}
	
	/**
	 * 자산등록 
	 */
	@RequestMapping(value = "/ass/AssetInsert.do")
	@ResponseBody
	public int AssetInsert(MultipartHttpServletRequest multiRequest, AssetVO assetVO, BindingResult bindingResult) throws Exception {
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		assetVO.setCreatId(user.getUniqId());

		List<String> list = assetService.InsertAsset(assetVO);
		
		if (isAuthenticated) {
			List<MultipartFile> photoList = multiRequest.getFiles("photo");
			for(MultipartFile photo : photoList) {
				if (!photo.isEmpty()) {
					for(String id : list) {
						FileVO result = fileUtil.parseAssFileInf(photo, "BBS_", 0, "", "", id, "PHOTO");
						fileMngService.insertAssFileInf(result);
					}
				}
			}
			MultipartFile file = multiRequest.getFile("file");
			if (!file.isEmpty()) {
				for(String id : list) {
					FileVO result = fileUtil.parseAssFileInf(file, "BBS_", 0, "", "", id, "FILE");
					fileMngService.insertAssFileInf(result);
				}
			}
		}
		
		return list.size();
	}
	
	/**
	 * 자산수정 페이지로 이동
	 */
	@RequestMapping(value = "/ass/AssetUpdt.do")
	public String AssetUpdt(HttpServletRequest request, ModelMap model, AssetManageVO assetManageVO) throws Exception {

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		model.addAttribute("resultVO", assetService.SelectAssetVO(assetManageVO));
	
		vo.setCodeId("COM015");
		model.addAttribute("maker_result", cmmUseService.selectCmmCodeDetail(vo));
		
		FileVO fvo = new FileVO();
		fvo.setFileGroup(assetManageVO.getAssetId());
		fvo.setFileType("PHOTO");
		model.addAttribute("PhotoList", fileMngService.selectFileList(fvo));
		fvo.setFileType("FILE");
		model.addAttribute("FileVO", fileMngService.selectFileVO(fvo));
		model.addAttribute("searchVO", assetManageVO);
		model.addAttribute("masterVO", assetService.SelectAssetMaster(assetManageVO));
		
		return "/ass/AssetUpdt";
	}
	
	/**
	 * 자산수정
	 */
	@RequestMapping(value = "/ass/AssetUpdate.do")
	@ResponseBody
	public int AssetUpdate(MultipartHttpServletRequest multiRequest, AssetVO assetVO, String delFile, String delPhoto) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		assetVO.setCreatId(user.getUniqId());
		int res = assetService.UpdateAsset(assetVO);
		
		String[] delPhotoList = delPhoto.split("/");
		
		FileVO fvo = new FileVO();
		fvo.setFileGroup(assetVO.getAssetId());
		for(String photoId : delPhotoList) {
			fvo.setAtchFileId(photoId);
			fileMngService.updateFileListUse(fvo);
		}
		List<MultipartFile> photoList = multiRequest.getFiles("photo");
		for(MultipartFile photo : photoList) {
			if (!photo.isEmpty()) {
				FileVO result = fileUtil.parseAssFileInf(photo, "BBS_", 0, "", "", assetVO.getAssetId(), "PHOTO");
				fileMngService.insertAssFileInf(result);
			}
		}
		if(delFile != null && delFile != "") {
			fvo.setAtchFileId(delFile);
			fileMngService.updateFileListUse(fvo);
		}
		MultipartFile file = multiRequest.getFile("file");
		if (!file.isEmpty()) {
			fileMngService.updateFileUse(fvo);
			FileVO result = fileUtil.parseAssFileInf(file, "BBS_", 0, "", "", assetVO.getAssetId(), "FILE");
			fileMngService.insertAssFileInf(result);
		}
		
		
		return res;
	}
	
	/**
	 * 자산관리번호 수정
	 */
	@RequestMapping(value = "/ass/MngNumUpdt.do")
	@ResponseBody
	public Map<String, Object> MngNumUpdt(AssetVO assetVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		assetVO.setCreatId(user.getUniqId());
		
		int res = assetService.MngNumUpdt(assetVO);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("mngNum", assetVO.getNewMngNum());
		result.put("res", res);
		
		return result;
	}
	
	/**
	 * 삭제,삭제취소 요청
	 */
	@RequestMapping(value = "/ass/AssetDelReq.do")
	@ResponseBody
	public int AssetDelReq(AssetVO assetVO, Boolean val) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		assetVO.setCreatId(user.getUniqId());
		assetVO.setReqGroup("C6");
		assetVO.setUsageStauts("N");
		int res = 0;
		if(val) {
			res = assetService.deleteReq(assetVO);
		}else {
			res = assetService.deleteCancel(assetVO);
		}

		
		return res;
	}
	
	/**
	 * 자산삭제
	 */
	@RequestMapping(value = "/ass/AssetDel.do")
	@ResponseBody
	public int AssetDel(AssetVO assetVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		assetVO.setCreatId(user.getUniqId());
		
		
		return assetService.deleteAsset(assetVO);
	}
	
	/**
	 * 제품사진 안내 팝업창으로 이동
	 */
	@RequestMapping(value = "/ass/PhotoManual.do")
	public String PhotoManual() throws Exception {

		return "/ass/manual/PhotoManual"; 
	}
	
	/**
	 * 시리얼넘버 안내 팝업창으로 이동
	 */
	@RequestMapping(value = "/ass/AssetSnManual.do")
	public String AssetSnManual() throws Exception {

		return "/ass/manual/AssetSnManual";
	}
	
	/**
	 * 지급확인서 안내 팝업창으로 이동
	 */
	@RequestMapping(value = "/ass/FileManual.do")
	public String FileManual(ModelMap model) throws Exception {

		FileVO fvo = new FileVO();
		fvo.setFileType("CONF");
		model.addAttribute("FileVO", fileMngService.selectFileVO(fvo));
		
		return "/ass/manual/FileManual";
	}
	
	/**
	 * 자산조회 팝업창으로 이동
	 */
	@RequestMapping(value = "/ass/AssetSearchList.do")
	public String AssetSearchList(HttpServletRequest request, ModelMap model,
			 AssetManageVO assetManageVO) throws Exception {
		System.out.println("넘어온 자산 정보 =======================");

		System.out.println(assetManageVO.getSearchName());
		System.out.println(assetManageVO.getUserId());
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(assetManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(assetManageVO.getPageUnit());
		paginationInfo.setPageSize(assetManageVO.getPageSize());

		assetManageVO.setStartPage(paginationInfo.getFirstRecordIndex());
		assetManageVO.setLastPage(paginationInfo.getLastRecordIndex());
		assetManageVO.setTotalRecord(paginationInfo.getRecordCountPerPage());
		assetManageVO.setSearchKind("out");
		Map<String, Object> map = assetService.SelectAssetVOList(assetManageVO);

		int totCnt = Integer.parseInt((String) map.get("resultCnt"));

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
	
		vo.setCodeId("COM006");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		model.addAttribute("searchVO", assetManageVO);
		
		return "/ass/AssetSearchList";
	}
	
	/**
	 * 반입신청 자산조회 팝업창으로 이동
	 */
	@RequestMapping(value = "/ass/InAssetSearchList.do")
	public String InAssetSearchList(HttpServletRequest request, ModelMap model,
									AssetManageVO assetManageVO) throws Exception {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(assetManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(assetManageVO.getPageUnit());
		paginationInfo.setPageSize(assetManageVO.getPageSize());

		assetManageVO.setStartPage(paginationInfo.getFirstRecordIndex());
		assetManageVO.setLastPage(paginationInfo.getLastRecordIndex());
		assetManageVO.setTotalRecord(paginationInfo.getRecordCountPerPage());
		assetManageVO.setSearchKind("in");
		Map<String, Object> map = assetService.SelectAssetVOList(assetManageVO);

		int totCnt = Integer.parseInt((String) map.get("resultCnt"));

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
	
		vo.setCodeId("COM006");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		model.addAttribute("searchVO", assetManageVO);
		
		return "/ass/InAssetSearchList";
	}
	/**
	 * 중복데이터조회페이지 이동
	 */
	@RequestMapping(value = "/ass/DistinctManage.do")
	public String DistinctManage(HttpServletRequest request, ModelMap model,
			 AssetManageVO assetManageVO) throws Exception {

		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(assetManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(assetManageVO.getPageUnit());
		paginationInfo.setPageSize(assetManageVO.getPageSize());

		assetManageVO.setStartPage(paginationInfo.getFirstRecordIndex());
		assetManageVO.setLastPage(paginationInfo.getLastRecordIndex());
		assetManageVO.setTotalRecord(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = assetService.SelectAssetVOList(assetManageVO);

		int totCnt = Integer.parseInt((String) map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
	
		vo.setCodeId("COM006");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		model.addAttribute("searchVO", assetManageVO);
		
		return "/ass/DistinctManage";
	}
	
	/**
	 * 자산관리번호관리 페이지로 이동
	 */
	@RequestMapping(value = "/ass/MngNumManagement.do")
	public String MngNumManagement(HttpServletRequest request, ModelMap model,
			 AssetManageVO assetManageVO) throws Exception {

		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(assetManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(assetManageVO.getPageUnit());
		paginationInfo.setPageSize(assetManageVO.getPageSize());

		assetManageVO.setStartPage(paginationInfo.getFirstRecordIndex());
		assetManageVO.setLastPage(paginationInfo.getLastRecordIndex());
		assetManageVO.setTotalRecord(paginationInfo.getRecordCountPerPage());
		
		if(assetManageVO.getMenuStartDate() != null && assetManageVO.getMenuStartDate() != "") {
			assetManageVO.setStartDate(assetManageVO.getMenuStartDate());
		}
		if(assetManageVO.getMenuEndDate() != null && assetManageVO.getMenuEndDate() != "") {
			assetManageVO.setEndDate(assetManageVO.getMenuEndDate());
		}
		if(assetManageVO.getMenuOrgnzt() != null && assetManageVO.getMenuOrgnzt() != "") {
			assetManageVO.setSearchOrgnzt(assetManageVO.getMenuOrgnzt());
		}
		if(assetManageVO.getMenuLowerOrgnzt() != null && assetManageVO.getMenuLowerOrgnzt() != "") {
			assetManageVO.setLowerOrgnzt(assetManageVO.getMenuLowerOrgnzt());
		}
		Map<String, Object> map = assetService.SelectMngNumList(assetManageVO);

		int totCnt = Integer.parseInt((String) map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
	
		vo.setCodeId("COM006");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		model.addAttribute("searchVO", assetManageVO);
		model.addAttribute("masterVO", assetService.SelectAssetMaster(assetManageVO));
		
		return "/ass/MngNumManagement";
	}
	
	/**
	 * 시리얼넘버 관리 페이지로 이동
	 */
	@RequestMapping(value = "/ass/AssetSnManagement.do")
	public String AssetSnManagement(HttpServletRequest request, ModelMap model,
			 AssetManageVO assetManageVO) throws Exception {

		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(assetManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(assetManageVO.getPageUnit());
		paginationInfo.setPageSize(assetManageVO.getPageSize());

		assetManageVO.setStartPage(paginationInfo.getFirstRecordIndex());
		assetManageVO.setLastPage(paginationInfo.getLastRecordIndex());
		assetManageVO.setTotalRecord(paginationInfo.getRecordCountPerPage());
		
		if(assetManageVO.getMenuStartDate() != null && assetManageVO.getMenuStartDate() != "") {
			assetManageVO.setStartDate(assetManageVO.getMenuStartDate());
		}
		if(assetManageVO.getMenuEndDate() != null && assetManageVO.getMenuEndDate() != "") {
			assetManageVO.setEndDate(assetManageVO.getMenuEndDate());
		}
		if(assetManageVO.getMenuOrgnzt() != null && assetManageVO.getMenuOrgnzt() != "") {
			assetManageVO.setSearchOrgnzt(assetManageVO.getMenuOrgnzt());
		}
		if(assetManageVO.getMenuLowerOrgnzt() != null && assetManageVO.getMenuLowerOrgnzt() != "") {
			assetManageVO.setLowerOrgnzt(assetManageVO.getMenuLowerOrgnzt());
		}
		Map<String, Object> map = assetService.SelectAssetSnList(assetManageVO);

		int totCnt = Integer.parseInt((String) map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
	
		vo.setCodeId("COM006");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		model.addAttribute("searchVO", assetManageVO);
		model.addAttribute("masterVO", assetService.SelectAssetMaster(assetManageVO));
		
		return "/ass/AssetSnManagement";
	}
	
	/**
	 * 자산 엑셀업로드 안내 화면 이동
	 */
	@RequestMapping(value = "/ass/AssetExcelUploadStart.do")
	public String AssetExcelUploadStart(ModelMap model) throws Exception {
		FileVO fvo = new FileVO();
		fvo.setFileType("A_EXCEL");
		model.addAttribute("FileVO", fileMngService.selectFileVO(fvo));
		return "/ass/AssetExcelUploadStart"; 
  }
  /**
	 * 시리얼넘버중복확인 페이지 이동
	 */
	@RequestMapping(value = "/ass/AssetSnCnfirmView.do")
	public String AssetSnCnfirmView(ModelMap model) throws Exception {
		
		model.addAttribute("usedCnt", -1);
		
		return "/ass/AssetSnCnfirm";
	}
	
	/**
	 * 시리얼넘버중복확인
	 */
	@RequestMapping(value = "/ass/AssetSnCnfirm.do")
	public String AssetSnCnfirm(ModelMap model, AssetManageVO assetManageVO) throws Exception {
		
		model.addAttribute("assetSn", assetManageVO.getAssetSn());
		
		int usedCnt = assetService.SelectAssetSn(assetManageVO);
		
		model.addAttribute("usedCnt", usedCnt);
		
		return "/ass/AssetSnCnfirm";
	}
	
	/**
	 * 자산렌탈삭제요청 조회 페이지로 이동
	 */
	@RequestMapping(value = "/ass/DelReqManagement.do")
	public String DelReqManagement(HttpServletRequest request, ModelMap model,
			 AssetManageVO assetManageVO) throws Exception {
		
		request.getSession().setAttribute("baseMenuNo", "6000000");
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(assetManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(assetManageVO.getPageUnit());
		paginationInfo.setPageSize(assetManageVO.getPageSize());

		assetManageVO.setStartPage(paginationInfo.getFirstRecordIndex());
		assetManageVO.setLastPage(paginationInfo.getLastRecordIndex());
		assetManageVO.setTotalRecord(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = assetService.SelectDelReqList(assetManageVO);

		int totCnt = Integer.parseInt((String) map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
	
		vo.setCodeId("COM006");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		model.addAttribute("searchVO", assetManageVO);
		model.addAttribute("masterVO", assetService.SelectAssetMaster(assetManageVO));
		
		return "/ass/DelReqManagement";
	}
}
