package egovframework.let.com.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.LoginVO;
import egovframework.let.aprv.service.ApprovalDefaultVO;
import egovframework.let.aprv.service.ApprovalManageService;
import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetService;
import egovframework.let.rent.service.RentalManageVO;
import egovframework.let.rent.service.RentalService;
import egovframework.let.req.service.RequestManageVO;
import egovframework.let.req.service.RequestService;
import egovframework.let.uss.umt.service.UserDefaultVO;
import egovframework.let.uss.umt.service.UserManageService;

/**
 * 공통기능을 위한 컨트롤러 클래스
 * 
 * @author 영남사업부 주소현
 * @since 2023.05.10
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.05.10  주소현          최초 생성
 *
 *      </pre>
 */

@Controller
public class CommonController {
	/** userManageService */
	@Resource(name = "userManageService")
	private UserManageService userManageService;
	
	/** approvalManageService */
	@Resource(name = "approvalManageService")
	private ApprovalManageService approvalManageService;
	
	/** requestService */
	@Resource(name = "RequestService")
	private RequestService requestService;
	
	/** assetService */
	@Resource(name = "AssetService")
	private AssetService assetService;
	
	/** assetService */
	@Resource(name = "RentalService")
	private RentalService rentalService;
	
	/**
	 * 등록확인 팝업창로 이동
	 */
	@RequestMapping(value = "/com/RegistConfirm.do")
	public String RegistConfirm() throws Exception {

		return "/com/RegistConfirm";
	}
	
	/**
	 * 등록진행 팝업창로 이동
	 */
	@RequestMapping(value = "/com/RegistIng.do")
	public String RegistIng() throws Exception {

		return "/com/RegistIng";
	}
	
	/**
	 * 등록완료 팝업창로 이동
	 */
	@RequestMapping(value = "/com/RegistSuccess.do")
	public String RegistSuccess() throws Exception {

		return "/com/RegistSuccess";
	}
	
	/**
	 * 등록실패 팝업창로 이동
	 */
	@RequestMapping(value = "/com/RegistFail.do")
	public String RegistFail() throws Exception {

		return "/com/RegistFail";
	}
	
	/**
	 * 알람 팝업창로 이동
	 */
	@RequestMapping(value = "/com/AlertModal.do")
	public String AlertModal(ModelMap model,@ModelAttribute("fields") StringBuffer buffer) throws Exception {
		
		model.addAttribute("fields", buffer);
		
		return "/com/AlertModal";
	}
	/**
	 * 결재승인확인 팝업창로 이동
	 */
	@RequestMapping(value = "/com/ApprovalConfirm.do")
	public String ApprovalConfirm() throws Exception {
		return "/com/ApprovalConfirm";
	}
	/**
	 * 결재승인완료 팝업창로 이동
	 */
	@RequestMapping(value = "/com/AprvSuccess.do")
	public String AprvSuccess() throws Exception {

		return "/com/ApprovalSuccess";
	}
	/**
	 * 결재승인실패 팝업창으로 이동
	 */
	@RequestMapping(value = "/com/AprvFail.do")
	public String AprvFail() throws Exception {

		return "/com/ApprovalFail";
	}
	/**
	 * 결재승인진행 팝업창로 이동
	 */
	@RequestMapping(value = "/com/AprvIng.do")
	public String AprvIng() throws Exception {

		return "/com/ApprovalIng";
	}
	/**
	 * 반려확인 팝업창로 이동
	 */
	@RequestMapping(value = "/com/ApprovalDisConfirm.do")
	public String ApprovalDisConfirm() throws Exception {
		return "/com/ApprovalDisConfirm";
	}
	/**
	 * 수정확인 팝업창로 이동
	 */
	@RequestMapping(value = "/com/UpdtConfirm.do")
	public String UpdtConfirm() throws Exception {

		return "/com/UpdtConfirm";
	}
	
	/**
	 * 수정진행 팝업창로 이동
	 */
	@RequestMapping(value = "/com/UpdtIng.do")
	public String UpdtIng() throws Exception {

		return "/com/UpdtIng";
	}
	
	/**
	 * 수정완료 팝업창로 이동
	 */
	@RequestMapping(value = "/com/UpdtSuccess.do")
	public String UpdtSuccess() throws Exception {

		return "/com/UpdtSuccess";
	}
	
	/**
	 * 수정실패 팝업창로 이동
	 */
	@RequestMapping(value = "/com/UpdtFail.do")
	public String UpdtFail() throws Exception {

		return "/com/UpdtFail";
	}
	
	/**
	 * 삭제확인 팝업창로 이동
	 */
	@RequestMapping(value = "/com/DelConfirm.do")
	public String DelConfirm() throws Exception {

		return "/com/DelConfirm";
	}
	
	/**
	 * 삭제완료 팝업창로 이동
	 */
	@RequestMapping(value = "/com/DelSuccess.do")
	public String DelSuccess() throws Exception {

		return "/com/DelSuccess";
	}
	
	/**
	 * 삭제실패 팝업창로 이동
	 */
	@RequestMapping(value = "/com/DelFail.do")
	public String DelFail() throws Exception {

		return "/com/DelFail";
	}
	
	/**
	 * 삭제진행 팝업창로 이동
	 */
	@RequestMapping(value = "/com/DelIng.do")
	public String DelIng() throws Exception {

		return "/com/DelIng";
	}

	//사용자목록 엑셀 출력
	@RequestMapping("/com/xlsxTrsfUserList.do")
	public void xlsxTrsfUserList(HttpServletRequest req, HttpServletResponse res, ModelMap model, UserDefaultVO userSearchVO, HttpSession session) throws Exception {
			userManageService.xlsxTrsfUserList(userSearchVO,req,res);
	}
	
	//결재요청목록 엑셀 출력
	@RequestMapping("/com/xlsxTrsfAprvList.do")
	public void xlsxTrsfAprvList(HttpServletRequest req, HttpServletResponse res, ModelMap model, ApprovalDefaultVO approvalSearchVO, HttpSession session) throws Exception {
		LoginVO loginId = (LoginVO)req.getSession().getAttribute("LoginVO");
		approvalSearchVO.setUniqId(loginId.getUniqId());
		approvalManageService.xlsxTrsfAprvList(approvalSearchVO,req,res);
	}
	//반출입목록 엑셀 출력
	@RequestMapping("/com/xlsxTrsfReqList.do")
	public void xlsxTrsfReqList(HttpServletRequest req, HttpServletResponse res, ModelMap model, RequestManageVO requestManageVO, HttpSession session) throws Exception {
		LoginVO loginId = (LoginVO)req.getSession().getAttribute("LoginVO");
		requestManageVO.setId(loginId.getUniqId());
		requestService.xlsxTrsfReqList(requestManageVO,req,res);
	}
	//전체자산목록 엑셀 출력
	@RequestMapping("/com/xlsxTrsfAssetList.do")
	public void xlsxTrsfAssetList(HttpServletRequest req, HttpServletResponse res, ModelMap model, AssetManageVO assetManageVO, HttpSession session) throws Exception {
		assetService.xlsxTrsfAssetList(assetManageVO,req,res);
	}

	//내자산조회 엑셀 출력
	@RequestMapping("/com/xlsxTrsfMyAssList.do")
	public void xlsxTrsfMyAssList(HttpServletRequest req, HttpServletResponse res, ModelMap model, AssetManageVO assetManageVO, HttpSession session) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		assetManageVO.setUserId(user.getUniqId());
		assetService.xlsxTrsfMyAssList(assetManageVO,req,res);
	}
	
	//전체자산목록 엑셀 출력
	@RequestMapping("/com/xlsxTrsfRentList.do")
	public void xlsxTrsfRentList(HttpServletRequest req, HttpServletResponse res, ModelMap model, RentalManageVO rentalManageVO, HttpSession session) throws Exception {
		rentalService.xlsxTrsfRentList(rentalManageVO,req,res);
	}

	//내자산조회 엑셀 출력
	@RequestMapping("/com/xlsxTrsfMyRentList.do")
	public void xlsxTrsfMyRentList(HttpServletRequest req, HttpServletResponse res, ModelMap model, RentalManageVO rentalManageVO, HttpSession session) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		rentalManageVO.setUserId(user.getUniqId());
		rentalService.xlsxTrsfMyRentList(rentalManageVO,req,res);
	}
}
