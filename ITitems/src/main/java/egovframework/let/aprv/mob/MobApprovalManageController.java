package egovframework.let.aprv.mob;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.aprv.service.ApprovalDefaultVO;
import egovframework.let.aprv.service.ApprovalManageService;
import egovframework.let.aprv.service.ApprovalManageVO;
import egovframework.let.ass.service.AssetVO;
import egovframework.let.req.service.RequestManageVO;
import egovframework.let.req.service.RequestService;
import egovframework.let.uss.umt.service.UserDefaultVO;
import egovframework.let.uss.umt.service.UserManageService;

@RestController
public class MobApprovalManageController {

	/** approvalManageService */
	@Resource(name = "approvalManageService")
	private ApprovalManageService approvalManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "RequestService")
	private RequestService requestService;

	
	/** userManageService */
	@Resource(name = "userManageService")
	private UserManageService userManageService;
	@RequestMapping(value = "/user/MobSearchUserList.do")
	public Map<String, Object> SearchUserList(@RequestBody UserDefaultVO userSearchVO) throws Exception {
		Map<String, Object> appMap = new HashMap<String, Object>();

		appMap.put("resultList", userManageService.mobSelectUserListS(userSearchVO));
//
//		// 사용자상태코드를 코드정보로부터 조회
//		ComDefaultCodeVO vo = new ComDefaultCodeVO();
//		vo.setCodeId("COM013");
//		appMap.put("emplyrSttusCode_result", cmmUseService.selectCmmCodeDetail(vo));// 사용자상태코드목록
//
//		// 직급코드를 코드정보로부터 조회 - COM002
//		vo.setCodeId("COM002");
//		appMap.put("grd_result", cmmUseService.selectCmmCodeDetail(vo));
//
//		// 조직정보를 조회 - ORGNZT_ID정보
//		vo.setTableNm("LETTNORGNZTINFO");
//		appMap.put("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
//		appMap.put("SearchVO", userSearchVO);

		return appMap;
	}
	
	
	
	/**
	 * 전체조회
	 * 
	 * @param approvalSearchVO 검색조건정보
	 * @param model            화면모델
	 * @return aprv/approvalManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/aprv/MobApprovalManage.do")
	public Map<String, Object> selectApprovalList(@RequestBody ApprovalDefaultVO approvalSearchVO,
			HttpServletRequest request) throws Exception {
		Map<String, Object> appMap = new HashMap<String, Object>();


		/** EgovPropertyService */
		appMap.put("resultList", approvalManageService.mobSelectApprovalList(approvalSearchVO));
		int leftCnt = approvalManageService.selectApprovalListTotCntB(approvalSearchVO);
		appMap.put("leftCnt", leftCnt);

		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		// 결재상태코드를 코드정보로부터 조회 - COM008
		vo.setCodeId("COM008");
		appMap.put("aprvStatus_result", cmmUseService.selectCmmCodeDetail(vo));

		// 결재요청분류코드를 코드정보로부터 조회 - COM011
		vo.setCodeId("COM011");
		appMap.put("aprvGroup_result", cmmUseService.selectCmmCodeDetail(vo));


		return appMap;
	}

	/**
	 * 반출입신청상세정보 페이지로 이동
	 */
	@RequestMapping(value = "/aprv/MobSelectApproval.do")
	public Map<String, Object> SelectApproval(@RequestBody ApprovalDefaultVO approvalSearchVO, RequestManageVO manageVO,
			HttpServletRequest request, ModelMap model) throws Exception {
		Map<String, Object> appMap = new HashMap<String, Object>();

		ApprovalManageVO approvalManageVO = new ApprovalManageVO();
		approvalManageVO = approvalManageService.SelectApproval(approvalSearchVO);
		appMap.put("approvalVO", approvalManageVO);
		appMap.put("AuthorCode", approvalSearchVO.getAuthorCode());
		appMap.put("loginId", approvalSearchVO.getUniqId());

		manageVO.setReqId(approvalSearchVO.getReqId());

		appMap.put("approvalDetailList", requestService.SelectRequestDetailVOList(manageVO));
		appMap.put("aprvList_result", requestService.SelectAprvList(manageVO));

		return appMap;
	}

	/**
	 * 반출입신청 승인처리
	 */
	@RequestMapping(value = "/aprv/MobApprovalUpdate.do")
	public int UpdateApproval(@RequestBody ApprovalManageVO approvalManageVO, HttpServletRequest request) {
		approvalManageVO.setTargetId(approvalManageVO.getUserId());
		return approvalManageService.UpdateApproval(approvalManageVO);
	}

	/**
	 * 반출입신청 자산내역 등록
	 */
	@RequestMapping(value = "/aprv/MobApprovalInsertHist.do")
	public int ApprovalInsertHist(@RequestBody List<AssetVO> assetVOList) throws Exception {
		int cnt = 0;
		for (int i = 0; i < assetVOList.size(); i++) {
			AssetVO assetVO = assetVOList.get(i);
			cnt += approvalManageService.ApprovalInsertHist(assetVO);
		}
		return cnt;
	}

	/**
	 * 반출입신청 반려처리
	 */
	@RequestMapping(value = "/aprv/MobApprovalDisUpdate.do")
	@ResponseBody
	public int ApprovalDisUpdate(@RequestBody ApprovalManageVO approvalManageVO, HttpServletRequest request) {

		approvalManageVO.setTargetId(approvalManageVO.getUserId());
		return approvalManageService.ApprovalDisUpdate(approvalManageVO);
	}

}