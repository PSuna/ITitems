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
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
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

	/**
	 * 내자산조회 페이지로 이동
	 */
	@RequestMapping(value="/ass/MobMyAssetManagement.do")
	public Map<String, Object> MyAssetManagement(HttpServletRequest request,
			 AssetManageVO assetManageVO, @RequestBody AssetManageVO avo ) throws Exception {
		System.out.println(avo+"모바일/아이디 받기 >>>>>>>>>>>>>>>>");
	    /*여러 데이터를 보낼때 @RequestBody Map<String,Object> paramMap이런 식으로 받사 사용
		System.out.println(paramMap.get("data")+">>>>>>>>>>>>>>>>>>>");*/
		Map<String, Object> appMap = new HashMap<String, Object>();
		//LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		assetManageVO.setUserId(avo.getAssetId());
		
		if(assetManageVO.getMenuStartDate() != null && assetManageVO.getMenuStartDate() != "") {
			assetManageVO.setStartDate(assetManageVO.getMenuStartDate());
		}
		if(assetManageVO.getMenuEndDate() != null && assetManageVO.getMenuEndDate() != "") {
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
	
	
	
}
