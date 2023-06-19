package egovframework.let.rent.web;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.cat.service.CategoryManageVO;
import egovframework.let.cat.service.CategoryService;
import egovframework.let.prj.service.ProjectService;
import egovframework.let.rent.service.RentalManageVO;
import egovframework.let.rent.service.RentalService;
import egovframework.let.rent.service.RentalVO;
import egovframework.let.uss.umt.service.UserManageService;

/**
 * 렌탈관리를 위한 컨트롤러 클래스
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
public class RentalController {
	
	@Resource(name = "RentalService")
	private RentalService rentalService;
	
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
	 * 내렌탈조회 페이지로 이동
	 */
	@RequestMapping(value = "/rent/MyRentalManagement.do")
	public String MyRentalManagement(HttpServletRequest request, ModelMap model,
			RentalManageVO manageVO) throws Exception {
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		manageVO.setUserId(user.getUniqId());
		
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
		
		Map<String, Object> map = rentalService.SelectMyRentalVOList(manageVO);

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
		
		model.addAttribute("searchVO", manageVO);
		
		return "/rent/MyRentalManagement";
	}
	
	/**
	 * 전체렌탈조회 페이지로 이동
	 */
	@RequestMapping(value = "/rent/RentalManagement.do")
	public String RentalManagement(HttpServletRequest request, ModelMap model,
			RentalManageVO manageVO) throws Exception {

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
		if(manageVO.getMenuLowerOrgnzt() != null && manageVO.getMenuLowerOrgnzt() != "") {
			manageVO.setLowerOrgnzt(manageVO.getMenuLowerOrgnzt());
		}
		Map<String, Object> map = rentalService.SelectRentalVOList(manageVO);

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
		
		model.addAttribute("searchVO", manageVO);
		
		return "/rent/RentalManagement";
	}
	
	/**
	 * 렌탈상세정보 페이지로 이동
	 */
	@RequestMapping(value = "/rent/SelectRental.do")
	public String SelectRental(HttpServletRequest request, ModelMap model, RentalManageVO manageVO) throws Exception {
		
		RentalVO result = rentalService.SelectRentalVO(manageVO);
		model.addAttribute("resultVO", result);
		
		FileVO fvo = new FileVO();
		fvo.setFileGroup(manageVO.getRentalId());
		fvo.setFileType("PHOTO");
		model.addAttribute("PhotoList", fileMngService.selectFileList(fvo));
		fvo.setFileType("FILE");
		model.addAttribute("FileVO", fileMngService.selectFileVO(fvo));
		model.addAttribute("searchVO", manageVO);
		
		
		return "/rent/SelectRental";
	}
	

	/**
	 * 렌탈등록 페이지로 이동
	 */
	@RequestMapping(value = "/rent/RentalRegist.do")
	public String RentalRegist(HttpServletRequest request, ModelMap model, RentalVO rentalVO, RentalManageVO manageVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("loginId", user.getUniqId());
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
	
		vo.setCodeId("COM015");
		model.addAttribute("maker_result", cmmUseService.selectCmmCodeDetail(vo));
		
		model.addAttribute("searchVO", manageVO);
	
		return "/rent/RentalRegist";
	}
	
	/**
	 * 렌탈등록 
	 */
	@RequestMapping(value = "/rent/RentalInsert.do")
	@ResponseBody
	public String RentalInsert(MultipartHttpServletRequest multiRequest, RentalVO rentalVO, BindingResult bindingResult) throws Exception {
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		rentalVO.setRegId(user.getUniqId());
		rentalVO.setHistUser(user.getUniqId());
		
		rentalService.InsertRentalInfo(rentalVO);
		
		if (isAuthenticated) {
			List<MultipartFile> photoList = multiRequest.getFiles("photo");
			for(MultipartFile photo : photoList) {
				if (!photo.isEmpty()) {
					FileVO result = fileUtil.parseAssFileInf(photo, "BBS_", 0, "", "", rentalVO.getRentalId(), "PHOTO");
					fileMngService.insertAssFileInf(result);
				}
			}
			MultipartFile file = multiRequest.getFile("file");
			if (!file.isEmpty()) {
				FileVO result = fileUtil.parseAssFileInf(file, "BBS_", 0, "", "", rentalVO.getRentalId(), "FILE");
				fileMngService.insertAssFileInf(result);
			}
		}
		
		return rentalVO.getRentalId();
	}
	
	/**
	 * 렌탈수정 페이지로 이동
	 */
	@RequestMapping(value = "/rent/RentalUpdt.do")
	public String RentalUpdt(HttpServletRequest request, ModelMap model, RentalManageVO manageVO) throws Exception {

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		model.addAttribute("resultVO", rentalService.SelectRentalVO(manageVO));
	
		vo.setCodeId("COM015");
		model.addAttribute("maker_result", cmmUseService.selectCmmCodeDetail(vo));
		
		FileVO fvo = new FileVO();
		fvo.setFileGroup(manageVO.getRentalId());  
		fvo.setFileType("PHOTO");
		model.addAttribute("PhotoList", fileMngService.selectFileList(fvo));
		fvo.setFileType("FILE");
		model.addAttribute("FileVO", fileMngService.selectFileVO(fvo));
		model.addAttribute("searchVO", manageVO);
	
		return "/rent/RentalUpdt";
	}
	
	/**
	 * 렌탈수정
	 */
	@RequestMapping(value = "/rent/RentalUpdate.do")
	@ResponseBody
	public String AssetUpdate(MultipartHttpServletRequest multiRequest, RentalVO rentalVO, String delFile, String delPhoto) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		rentalVO.setHistUser(user.getUniqId());
		rentalService.UpdateRentalDetail(rentalVO);
		
		String[] delPhotoList = delPhoto.split("/");
		
		FileVO fvo = new FileVO();
		fvo.setFileGroup(rentalVO.getRentalId());
		for(String photoId : delPhotoList) {
			fvo.setAtchFileId(photoId);
			fileMngService.updateFileListUse(fvo);
		}
		List<MultipartFile> photoList = multiRequest.getFiles("photo");
		for(MultipartFile photo : photoList) {
			if (!photo.isEmpty()) {
				FileVO result = fileUtil.parseAssFileInf(photo, "BBS_", 0, "", "", rentalVO.getRentalId(), "PHOTO");
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
			FileVO result = fileUtil.parseAssFileInf(file, "BBS_", 0, "", "", rentalVO.getRentalId(), "FILE");
			fileMngService.insertAssFileInf(result);
		}
		
		
		return rentalVO.getRentalId();
	}
	
	
	/**
	 * 렌탈삭제
	 */
	@RequestMapping(value = "/rent/RentalDel.do")
	@ResponseBody
	public String RentalDel(RentalVO rentalVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		rentalVO.setHistUser(user.getUniqId());
		rentalService.deleteRental(rentalVO);
		 
		return rentalVO.getRentalId();
	}
	
}
