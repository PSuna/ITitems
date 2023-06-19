package egovframework.let.req.mob;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.cat.service.CategoryManageVO;
import egovframework.let.cat.service.CategoryService;
import egovframework.let.req.service.RequestDetailVO;
import egovframework.let.req.service.RequestManageVO;
import egovframework.let.req.service.RequestService;
import egovframework.let.req.service.RequestVO;
import egovframework.let.uss.umt.service.UserManageService;
import egovframework.let.uss.umt.service.UserManageVO;

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

@RestController
public class MobRequestController {

	@Resource(name = "RequestService")
	private RequestService requestService;

	@Resource(name = "CategoryService")
	protected CategoryService categoryService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	@Resource(name = "userManageService")
	private UserManageService userManageService;
	/**
	 * 신청 등록
	 */
	@RequestMapping(value = "/req/MobInsertRequest.do")
	@ResponseBody
	public String insertRequest(@RequestBody Map<String, Object> insertMap) throws Exception {
		System.out.println("신청등록 모바일 도착");
		System.out.println(insertMap);
		//VO에 담기
		RequestVO requestVO = new RequestVO();
		requestVO.setId(insertMap.get("id").toString());
		requestVO.setPrjId(insertMap.get("prjId").toString());
		requestVO.setPm(insertMap.get("pm").toString());
		requestVO.setStartDate(insertMap.get("startDate").toString());
		requestVO.setEndDate(insertMap.get("endDate").toString());
		requestVO.setPlace(insertMap.get("place").toString());
		requestVO.setReqGroup("C1");
		requestService.InsertRequestVO(requestVO);
		System.out.println(requestVO.getReqId());
		return requestVO.getReqId();
	}

	/**
	 * 신청상세 등록
	 */
	@RequestMapping(value = "/req/MobInsertRequestDetail.do")
	@ResponseBody
	public String insertRequestDetail(RequestVO requestVO, RequestDetailVO requestDetailVO) throws Exception {
		requestService.InsertRequestDetailVO(requestDetailVO);
		return requestVO.getReqId();
	}
	
	//전체조회
	@RequestMapping(value = "/req/MobCarryRequset.do")
	public Map<String,Object> CarryRequset(HttpServletRequest request, ModelMap model,RequestManageVO manageVO) throws Exception {
		Map<String,Object> appMap = new HashMap<String, Object>();

		request.getSession().setAttribute("baseMenuNo", "100");  
		LoginVO loginId = (LoginVO)request.getSession().getAttribute("LoginVO");
		
		manageVO.setId(loginId.getUniqId());
		manageVO.setAuthorCode(loginId.getAuthorCode());
		
		if(manageVO.getMenuStartDate() != null && manageVO.getMenuStartDate() != "") {
			manageVO.setStartDate(manageVO.getMenuStartDate());
		}
		if(manageVO.getMenuEndDate() != null && manageVO.getMenuEndDate() != "") {
			manageVO.setEndDate(manageVO.getMenuEndDate());
		}
		if(manageVO.getMenuOrgnzt() != null && manageVO.getMenuOrgnzt() != "") {
			manageVO.setSearchOrgnzt(manageVO.getMenuOrgnzt());
		}
		
		manageVO.setReqGroup("C1");
		Map<String, Object> map = requestService.MobSelectRequestVOList(manageVO);
		
		appMap.put("resultList", map.get("resultList"));
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		appMap.put("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		vo.setCodeId("COM008");
		appMap.put("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		//결재요청분류코드를 코드정보로부터 조회 - COM011
		vo.setCodeId("COM011");
		appMap.put("group_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		appMap.put("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		
		return appMap;
	}



}
