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

	/**
	 * 신청 등록
	 */
	@RequestMapping(value = "/req/MobInsertRequest.do")
	@ResponseBody
	public String insertRequest(@RequestBody List<Map<String, Object>> insertMap) throws Exception {
		System.out.println("신청 등록 컨트롤러 수정 필요함 ==========================================");
		/**
		 * [ requestVO={reqId=, id=USRCNFRM_00000000063, prjId=prj12, prjName=제주 실시간
		 * 예비력시장 도입을 위한 전력거래시스템 개선 용역, pm=USRCNFRM_00000000178, pmName=강문성,
		 * startDate=2023-06-20, endDate=2023-06-29, place=test1, isDone=true},
		 * requestDetailVO=[{assetId=ASI_0000000000001, assetQty=1, reqOrder=2,
		 * orgnztNm=지역사업본부, assetSn=null, lowerOrgnztNm=영남사업부, middleCategory=노트북,
		 * rcptNm=서성원, useNm=서성원, prjNm=null, reqId=null}, {assetId=ASI_0000000000008,
		 * assetQty=1, reqOrder=3, orgnztNm=지역사업본부, assetSn=PF-3T2RGS,
		 * lowerOrgnztNm=본부지원부, middleCategory=노트북, rcptNm=최정국, useNm=최정국, prjNm=null,
		 * reqId=null}, {assetId=ASI_0000000000002, assetQty=1, reqOrder=4,
		 * orgnztNm=지역사업본부, assetSn=3Y10G63, lowerOrgnztNm=영남사업부, middleCategory=노트북,
		 * rcptNm=전홍준, useNm=전홍준, prjNm=null, reqId=null}],
		 * approvalManageVO=[{uniqId=USRCNFRM_00000000178, userNm=강문성, grade=수석(G2),
		 * orgnztId=호남사업부, moblphonNo=010-6390-0099}]} ]
		 * 
		 */
		System.out.println(insertMap);
		/**
		 * [{requestVO={reqId=, id=USRCNFRM_00000000063, prjId=prj11, prjName=DGB 대구은행 23년 여신신청심사 및 카드업무 운영, 
		 * 				pm=USRCNFRM_00000000200, pmName=이현철, startDate=2023-06-21, endDate=2023-06-30, place=test, isDone=true}}, 
		 * {requestDetailVO=[{assetId=ASI_0000000000001, assetQty=1, reqOrder=1, orgnztNm=지역사업본부, assetSn=null, lowerOrgnztNm=영남사업부, middleCategory=노트북, 
		 * 						rcptNm=서성원, useNm=서성원, prjNm=null, reqId=null}, 
		 * 					{assetId=ASI_0000000000007, assetQty=1, reqOrder=2, orgnztNm=지역사업본부, assetSn=009NTPCDX952, lowerOrgnztNm=본부지원부, middleCategory=모니터, 
		 * 						rcptNm=최정국, useNm=최정국, prjNm=null, reqId=null}]}, {}]

		 */

		// requestVO
		Map<String, Object> requestVO = new HashMap<String, Object>();
		List<Map<String, Object>> requestDetailVO = new ArrayList();
		List<Map<String, Object>> approvalManageVO = new ArrayList();

		for (int i = 0; i < insertMap.size(); i++) {
			switch (i) {
			case 0: {
				requestVO = (Map<String, Object>) insertMap.get(i).get("requestVO");
				break;
			}
			case 1: {
				requestDetailVO = (List<Map<String, Object>>) insertMap.get(i).get("requestDetailVO");
				break;
			}
			case 2: {
				System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
				System.out.println(insertMap.get(i));
				approvalManageVO = (List<Map<String, Object>>) insertMap.get(i).get("approvalManageVO");
				break;
			}
			default: {
				System.out.println("오류발생");
			}
			}

		}
		System.out.println("=============================================");
		System.out.println(requestVO);
		System.out.println(requestVO.get("id"));
		System.out.println("=============================================");
		System.out.println(requestDetailVO);
		System.out.println(requestDetailVO.get(0));
		System.out.println("=============================================");
		System.out.println(approvalManageVO);
		System.out.println(approvalManageVO.get(0));
		
		
//		Map<String, Object> data = (insertMap);
//		ObjectMapper objMapper = new ObjectMapper();
//		// VO에 담기
//		RequestVO requestVO = new RequestVO();
//		
//		System.out.println(insertMap.get("requestVO"));
//		Object requestVOObj = insertMap.get("requestVO");
//		System.out.println(requestVOObj);

//		requestVO.setId(insertMap.get("id").toString());
//		requestVO.setPrjId(insertMap.get("prjId").toString());
//		requestVO.setPm(insertMap.get("pm").toString());
//		requestVO.setStartDate(insertMap.get("startDate").toString());
//		requestVO.setEndDate(insertMap.get("endDate").toString());
//		requestVO.setPlace(insertMap.get("place").toString());
//		requestVO.setReqGroup("C1");
//		requestService.InsertRequestVO(requestVO);
//		System.out.println(requestVO.getReqId());
//		return requestVO.getReqId();
		return "야호";
	}

	/**
	 * 신청상세 등록
	 */
	@RequestMapping(value = "/req/MobInsertRequestDetail.do")
	@ResponseBody
	public String insertRequestDetail(RequestVO requestVO, @RequestBody Map<String, Object> mobileVO) throws Exception {
		System.out.println("신청 상세 등록(자산) 도착 ==========================================");
		System.out.println(mobileVO);
		RequestDetailVO requestDetailVO = new RequestDetailVO();
//		requestService.InsertRequestDetailVO(requestDetailVO);
		return requestVO.getReqId();
	}

	/**
	 * 
	 * @RequestMapping(value = "/aprv/ApprovalInsert.do")
	 * @ResponseBody public String ApprovalInsert(ApprovalManageVO approvalManageVO,
	 *               HttpServletRequest request) { LoginVO loginId =
	 *               (LoginVO)request.getSession().getAttribute("LoginVO");
	 *               approvalManageVO.setId(loginId.getUniqId());
	 *               approvalManageService.InsertApproval(approvalManageVO); return
	 *               approvalManageVO.getReqId(); }
	 */

	// 전체조회
	@RequestMapping(value = "/req/MobCarryRequset.do")
	public Map<String, Object> CarryRequset(HttpServletRequest request, RequestManageVO manageVO) throws Exception {
		Map<String, Object> appMap = new HashMap<String, Object>();

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
		return appMap;
	}

}
