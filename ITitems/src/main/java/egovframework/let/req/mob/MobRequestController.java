package egovframework.let.req.mob;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.aprv.service.ApprovalManageService;
import egovframework.let.aprv.service.ApprovalManageVO;
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

	@Resource(name = "approvalManageService")
	private ApprovalManageService approvalManageService;

	/**
	 * 신청 등록
	 */
	@RequestMapping(value = "/req/MobInsertRequest.do")
	@ResponseBody
	public Map<String, Object> insertRequest(@RequestBody List<Map<String, Object>> insertMap,
			HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("reqId", "fail");
		
		// requestVO
		Map<String, Object> rVO = new HashMap<String, Object>();
		List<Map<String, Object>> rdVO = new ArrayList();
		List<Map<String, Object>> aprvVO = new ArrayList();

		for (int i = 0; i < insertMap.size(); i++) {
			switch (i) {
			case 0: {
				rVO = (Map<String, Object>) insertMap.get(i).get("requestVO");
				break;
			}
			case 1: {
				rdVO = (List<Map<String, Object>>) insertMap.get(i).get("requestDetailVO");
				break;
			}
			case 2: {
				aprvVO = (List<Map<String, Object>>) insertMap.get(i).get("approvalManageVO");
				break;
			}
			default: {
				resultMap.put("result", "등록 처리 중 오류가 발생했습니다.");
			}
			}
		}

		// req등록
		RequestVO requestVO = new RequestVO();
		requestVO.setId(String.valueOf(rVO.get("id")));
		requestVO.setPrjId(String.valueOf(rVO.get("prjId")));
		requestVO.setPm(String.valueOf(rVO.get("pm")));
		requestVO.setStartDate(String.valueOf(rVO.get("startDate")));
		requestVO.setEndDate(String.valueOf(rVO.get("endDate")));
		requestVO.setPlace(String.valueOf(rVO.get("place")));
		requestVO.setReqGroup("C1");

		int rCnt = requestService.InsertRequestVO(requestVO);
		String reqId = requestVO.getReqId();

		// reqDetail 등록
		int rdCnt = 0;
		for (int i = 0; i < rdVO.size(); i++) {
			RequestDetailVO requestDetailVO = new RequestDetailVO();
			requestDetailVO.setReqId(reqId);
			requestDetailVO.setAssetId(String.valueOf(rdVO.get(i).get("assetId")));
			requestDetailVO.setReqQty(Integer.parseInt(String.valueOf(rdVO.get(i).get("assetQty"))));
			requestDetailVO.setReqOrder(Integer.parseInt(String.valueOf(rdVO.get(i).get("reqOrder"))));

			
			int result = requestService.InsertRequestDetailVO(requestDetailVO);
			if (result > 0) {
				rdCnt += result;
			}
		}

		// approvalManageVO 등록
		LoginVO loginId = (LoginVO) request.getSession().getAttribute("LoginVO");
		String targetUp = null;
		int aprvCnt = 0;

		for (int i = 0; i < aprvVO.size(); i++) {
			ApprovalManageVO approvalManageVO = new ApprovalManageVO();
			String targetId = String.valueOf(aprvVO.get(i).get("uniqId"));// 결재자 아이디

			approvalManageVO.setReqId(reqId);
			approvalManageVO.setId(loginId.getUniqId());

			// 결재자가 있는 경우
			if (targetId != null && targetId != "" && !(targetId.isEmpty())) {
				approvalManageVO.setTargetId(String.valueOf(aprvVO.get(i).get("uniqId")));
				approvalManageVO.setAprvOrder(String.valueOf(aprvVO.get(i).get("aprvOrder")));
				if (targetUp != null && targetUp != "" && !(targetUp.isEmpty())) {
					approvalManageVO.setTargetUp(targetUp);
					targetUp = String.valueOf(aprvVO.get(i).get("uniqId"));
				}
				int result = approvalManageService.InsertApproval(approvalManageVO);
				if (result > 0) {
					aprvCnt += result;
				}
			}
		}

		// 반출 등록 성공 여부
		if (rCnt <= 0) {
			resultMap.put("result", "반출 등록 중 오류가 발생했습니다.");

			// 반출 자산 등록 성공 여부
		} else if (rdCnt <= 0) {
			resultMap.put("result", "반출 자산 등록 중 오류가 발생했습니다.");

			// 반출 결재자 등록 성공 여부
		} else if (aprvCnt <= 0) {
			resultMap.put("reuslt", "결재자 등록 중 오류가 발생했습니다.");

			// 전체 성공 시 result + reqId 반환
		} else {
			resultMap.put("result", "반출 등록 성공");
			resultMap.replace("reqId", reqId);
		}
		
		return resultMap;
	}

	// 전체조회
	@RequestMapping(value = "/req/MobCarryRequset.do")
	public Map<String, Object> CarryRequset(HttpServletRequest request, @RequestBody RequestManageVO manageVO) throws Exception {
		Map<String, Object> appMap = new HashMap<String, Object>();
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		System.out.println(manageVO);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		request.getSession().setAttribute("baseMenuNo", "100");
		LoginVO loginId = (LoginVO) request.getSession().getAttribute("LoginVO");

		manageVO.setId(loginId.getUniqId());
		manageVO.setAuthorCode(loginId.getAuthorCode());

		if (manageVO.getMenuStartDate() != null && manageVO.getMenuStartDate() != "") {
			manageVO.setStartDate(manageVO.getMenuStartDate());
		}
		if (manageVO.getMenuEndDate() != null && manageVO.getMenuEndDate() != "") {
			manageVO.setEndDate(manageVO.getMenuEndDate());
		}
		if (manageVO.getMenuOrgnzt() != null && manageVO.getMenuOrgnzt() != "") {
			manageVO.setSearchOrgnzt(manageVO.getMenuOrgnzt());
		}

		Map<String, Object> map = requestService.MobSelectRequestVOList(manageVO);

		appMap.put("resultList", map.get("resultList"));

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		appMap.put("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));

		vo.setCodeId("COM008");
		appMap.put("status_result", cmmUseService.selectCmmCodeDetail(vo));
		// 결재요청분류코드를 코드정보로부터 조회 - COM011
		vo.setCodeId("COM011");
		appMap.put("group_result", cmmUseService.selectCmmCodeDetail(vo));

		CategoryManageVO cvo = new CategoryManageVO();
		appMap.put("LCat_result", categoryService.SelectCategoryVOList(cvo));

		appMap.put("searchVO", manageVO);

		return appMap;
	}

	// 상세조회
	@RequestMapping(value = "/req/MobSelectCarry.do")
	public Map<String, Object> SelectCarry(HttpServletRequest request, @RequestBody RequestManageVO manageVO)
			throws Exception {
		System.out.println("넘어온 RequestId =================");
		System.out.println(manageVO.getReqId());
		Map<String, Object> appMap = new HashMap<String, Object>();
		request.getSession().setAttribute("baseMenuNo", "100");
		appMap.put("resultVO", requestService.SelectRequestVO(manageVO));
		appMap.put("resultList", requestService.SelectRequestDetailVOList(manageVO));
		appMap.put("aprvList_result", requestService.SelectAprvList(manageVO));
		appMap.put("searchVO", manageVO);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		System.out.println(appMap);
		return appMap;
	}

}
