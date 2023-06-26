package egovframework.let.uss.umt.mob;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.sec.ram.service.EgovAuthorManageService;
import egovframework.let.sec.rgm.service.EgovAuthorGroupService;
import egovframework.let.uss.umt.service.UserDefaultVO;
import egovframework.let.uss.umt.service.UserManageService;

@RestController
public class MobUserManageController {

	/** userManageService */
	@Resource(name = "userManageService")
	private UserManageService userManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "egovAuthorManageService")
	private EgovAuthorManageService egovAuthorManageService;

	@Resource(name = "egovAuthorGroupService")
	private EgovAuthorGroupService egovAuthorGroupService;

	/**
	 * 사용자목록 조회 팝업창으로 이동
	 */
	@RequestMapping(value = "/uss/umt/user/MobSearchUserList.do")
	public Map<String, Object> SearchUserList(@RequestBody UserDefaultVO userSearchVO,
			HttpServletRequest request) throws Exception {
		Map<String, Object> appMap = new HashMap<String, Object>();

		appMap.put("resultList", userManageService.mobSelectUserListS(userSearchVO));

		// 사용자상태코드를 코드정보로부터 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM013");
		appMap.put("emplyrSttusCode_result", cmmUseService.selectCmmCodeDetail(vo));// 사용자상태코드목록

		// 직급코드를 코드정보로부터 조회 - COM002
		vo.setCodeId("COM002");
		appMap.put("grd_result", cmmUseService.selectCmmCodeDetail(vo));

		// 조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		appMap.put("orgnztId_result", cmmUseService.selectOgrnztIdUpDetail(vo));
		appMap.put("SearchVO", userSearchVO);

		return appMap;
	}
}
