package egovframework.let.ass.mob;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
 * 모바일 버전 자산관리를 위한 컨트롤러 클래스
 * 
 * @author 영남사업부 김태경
 * @since 2023.05.31
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.05.31  김태경          최초 생성
 *
 *      </pre>
 */

@RestController
public class MobAssetController {
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

	/*
	 * select => assetManageVo, /insert,upload => assetVo
	 */

	/**
	 * 내자산조회 페이지로 이동
	 */

	@RequestMapping(value = "/ass/MobMyAssetManagement.do")
	public Map<String, Object> MyAssetManagement(HttpServletRequest request,
			@RequestBody AssetManageVO assetManageVO) throws Exception {
		Map<String, Object> appMap = new HashMap<String, Object>();
	      if (assetManageVO.getMenuStartDate() != null && assetManageVO.getMenuStartDate() != "") {
	         assetManageVO.setStartDate(assetManageVO.getMenuStartDate());
	      }
	      if (assetManageVO.getMenuEndDate() != null && assetManageVO.getMenuEndDate() != "") {
	         assetManageVO.setEndDate(assetManageVO.getMenuEndDate());
	      }

	      Map<String, Object> map = assetService.MobSelectMyAssetInfoList(assetManageVO);

	      appMap.put("resultList", map.get("resultList"));
	      appMap.put("resultCnt", map.get("resultCnt"));

	      ComDefaultCodeVO vo = new ComDefaultCodeVO();

	      vo.setTableNm("LETTNORGNZTINFO");

	      appMap.put("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));

	      vo.setCodeId("COM006");
	      appMap.put("status_result", cmmUseService.selectCmmCodeDetail(vo));

	      CategoryManageVO cvo = new CategoryManageVO();
	      appMap.put("LCat_result", categoryService.SelectCategoryVOList(cvo));

	      appMap.put("searchVO", assetManageVO);
	      return appMap;
	}

	/**
	 * 자산상세정보 페이지로 이동
	 */
	@RequestMapping(value = "/ass/MobSelectAsset.do")
	public Map<String, Object> SelectAsset(HttpServletRequest request, @RequestBody AssetManageVO assetManageVO) throws Exception {
		Map<String, Object> appMap = new HashMap<String, Object>();

		AssetVO result = assetService.SelectAssetVO(assetManageVO);
		appMap.put("resultVO", result);
		
		Map<String, Object> map = assetService.SelectAssetHistList(assetManageVO);
		appMap.put("resultList", map.get("resultList"));
		appMap.put("resultCnt", map.get("resultCnt"));
		
		FileVO fvo = new FileVO();
		fvo.setFileGroup(assetManageVO.getAssetId());
		fvo.setFileType("PHOTO");
		appMap.put("PhotoList", fileMngService.selectFileList(fvo));
		fvo.setFileType("FILE");
		appMap.put("FileVO", fileMngService.selectFileVO(fvo));
		appMap.put("searchVO", assetManageVO);

		return appMap;
	}

	/**
	 * 반출신청에서 자산조회 팝업창으로 이동
	 */
	@RequestMapping(value = "/ass/MobAssetSearchList.do")
	   public Map<String, Object> AssetManagement(HttpServletRequest request, @RequestBody AssetManageVO assetManageVO)
	         throws Exception {
		System.out.println("넘어온 자산 정보 =======================");
		System.out.println(assetManageVO.getSearchName());
		System.out.println(assetManageVO.getUserId());
		Map<String, Object> appMap = new HashMap<String, Object>();

		if (assetManageVO.getMenuStartDate() != null && assetManageVO.getMenuStartDate() != "") {
			assetManageVO.setStartDate(assetManageVO.getMenuStartDate());
		}
		if (assetManageVO.getMenuEndDate() != null && assetManageVO.getMenuEndDate() != "") {
			assetManageVO.setEndDate(assetManageVO.getMenuEndDate());
		}
		if (assetManageVO.getMenuOrgnzt() != null && assetManageVO.getMenuOrgnzt() != "") {
			assetManageVO.setSearchOrgnzt(assetManageVO.getMenuOrgnzt());
		}
		if (assetManageVO.getMenuLowerOrgnzt() != null && assetManageVO.getMenuLowerOrgnzt() != "") {
			assetManageVO.setLowerOrgnzt(assetManageVO.getMenuLowerOrgnzt());
		}
		assetManageVO.setSearchKind("out");
		Map<String, Object> map = assetService.MobSelectAssetInfoVOList(assetManageVO);

		int totCnt = Integer.parseInt((String) map.get("resultCnt"));

		appMap.put("resultList", map.get("resultList"));
		appMap.put("resultCnt", map.get("resultCnt"));

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		appMap.put("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));

		vo.setCodeId("COM006");
		appMap.put("status_result", cmmUseService.selectCmmCodeDetail(vo));

		CategoryManageVO cvo = new CategoryManageVO();
		appMap.put("LCat_result", categoryService.SelectCategoryVOList(cvo));

		vo.setCodeId("COM015");
		appMap.put("maker_result", cmmUseService.selectCmmCodeDetail(vo));

		appMap.put("searchVO", assetManageVO);
		appMap.put("masterVO", assetService.SelectAssetMaster(assetManageVO));
		System.out.println(appMap);

		return appMap;
	}
	
	
	/**
	 * 모바일자산등록 
	 */
	@RequestMapping(value = "/mob/MobAssetInsert.do")
	public int AssetInsert(MultipartHttpServletRequest multiRequest, AssetVO assetVO, BindingResult bindingResult) throws Exception {
		
		System.out.println("++++++++++++++++++++++++++++++++++++모바일자산등록");
		System.out.println(multiRequest);
		System.out.println(assetVO.getCreatId());
		System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
		
		//LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		assetVO.setCreatId(assetVO.getCreatId());

		List<String> list = assetService.InsertAsset(assetVO);
		
		if(assetVO.getUseId() != "") {
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

}
