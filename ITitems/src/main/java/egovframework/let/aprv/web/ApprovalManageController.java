package egovframework.let.aprv.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.aprv.service.ApprovalDefaultVO;
import egovframework.let.aprv.service.ApprovalManageService;

/**
 * 사용자관련 요청을  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
 * @author 영남사업부 천세훈
 * @since 2023.05.17
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2023.05.10  천세훈         최초 생성
 *
 * </pre> 
 */

@Controller
public class ApprovalManageController {

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
	
	/**
	 * 결재 목록을 조회한다 (paging)
	 * @param approvalSearchVO 검색조건정보
	 * @param model 화면모델
	 * @return aprv/approvalManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/aprv/ApprovalManage.do")
	public String selectApprovalList(@ModelAttribute("approvalSearchVO") ApprovalDefaultVO approvalSearchVO,
									 ModelMap model, HttpServletRequest request) throws Exception{
		//메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("baseMenuNo", "2000000");
		
		//미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}
		
		/** EgovPropertyService*/
		approvalSearchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(approvalSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(approvalSearchVO.getPageUnit());
		paginationInfo.setPageSize(approvalSearchVO.getPageSize());
		
		approvalSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		approvalSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		approvalSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		model.addAttribute("resultList", approvalManageService.selectApprovalList(approvalSearchVO));
		
		int totCnt = approvalManageService.selectApprovalListTotCnt(approvalSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		
		//결재상태코드를 코드정보로부터 조회 - COM008
		vo.setCodeId("COM008");
		model.addAttribute("aprvStatus_result", cmmUseService.selectCmmCodeDetail(vo));
		
		//결재요청분류코드를 코드정보로부터 조회 - COM011
		vo.setCodeId("COM011");
		model.addAttribute("aprvGroup_result", cmmUseService.selectCmmCodeDetail(vo));
		
		return "aprv/ApprovalManage";
	}
}
