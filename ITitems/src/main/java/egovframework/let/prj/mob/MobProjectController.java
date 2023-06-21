package egovframework.let.prj.mob;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.prj.service.ProjectManageVO;
import egovframework.let.prj.service.ProjectService;
import egovframework.let.prj.service.ProjectVO;

/**
 * 프로젝트를 위한 컨트롤러 클래스
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
 *  2023.04.27  천세훈          사이트관리>프로젝트관리 페이지 컨트롤러 구현
 *
 *      </pre>
 */
@RestController
public class MobProjectController {

	@Resource(name = "ProjectService")
	private ProjectService projectService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@RequestMapping(value = "/prj/MobProjectSearchList.do")
	public Map<String, Object> selectZipSearchList(@RequestBody ProjectManageVO searchVO, ModelMap model,
			HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = projectService.SelectProjectVOList(searchVO);
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("baseMenuNo", "6000000");

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			resultMap.put("message", egovMessageSource.getMessage("fail.common.login"));
			return resultMap;
		}

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		// 프로젝트 진행여부를 코드정보로부터 조회
		vo.setCodeId("COM007");
		resultMap.put("prjState_result", cmmUseService.selectCmmCodeDetail(vo));
		Map<String, Object> map = projectService.SelectProjectVOList(searchVO);

		int totCnt = Integer.parseInt((String) map.get("resultCnt"));

		resultMap.put("resultList", map.get("resultList"));
		resultMap.put("searchVO", searchVO);
		resultMap.put("totCnt", Integer.parseInt((String) map.get("resultCnt")));

		System.out.println(resultMap);

		return resultMap;
	}

	/**
	 * 프로젝트 관리페이지 이동
	 * 
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/prj/MobProjectManage.do")
	public Map<String, Object> ProjectManageView(ProjectManageVO searchVO, ModelMap model, HttpServletRequest request)
			throws Exception {
		Map<String, Object> resultMap = projectService.SelectProjectVOList(searchVO);

		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("baseMenuNo", "6000000");

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		// 프로젝트 진행여부를 코드정보로부터 조회
		vo.setCodeId("COM007");
		model.addAttribute("prjState_result", cmmUseService.selectCmmCodeDetail(vo));

		Map<String, Object> map = projectService.SelectProjectVOList(searchVO);

		resultMap.put("resultList", map.get("resultList"));
		resultMap.put("searchVO", searchVO);
		resultMap.put("totCnt", Integer.parseInt((String) map.get("resultCnt")));

		System.out.println(resultMap);
		return resultMap;
	}

	/**
	 * 프로젝트 등록화면 이동
	 * 
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/prj/MobProjectInsertView.do")
	public String ProjectInsertView(@ModelAttribute("projectVO") ProjectVO projectVO, Model model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		// 프로젝트 진행여부를 코드정보로부터 조회
		vo.setCodeId("COM007");
		model.addAttribute("prjState_result", cmmUseService.selectCmmCodeDetail(vo));

		return "prj/ProjectInsert";
	}

	/**
	 * 프로젝트 등록
	 * 
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/prj/MobProjectInsert.do")
	public String ProjectInsert(@ModelAttribute("projectVO") ProjectVO projectVO, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		projectService.insertPrj(projectVO);
		model.addAttribute("resultMsg", "success.common.update");
		return "forward:/prj/ProjectManage.do";
	}

	/**
	 * 프로젝트 상세보기 및 수정 이동
	 * 
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/prj/MobProjectSelectView.do")
	public String ProjectSelectView(@RequestParam("selectedId") String prjId,
			@ModelAttribute("searchVO") ProjectManageVO searchVO, Model model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		// 프로젝트 진행여부를 코드정보로부터 조회
		vo.setCodeId("COM007");
		model.addAttribute("prjState_result", cmmUseService.selectCmmCodeDetail(vo));

		ProjectVO projectVO = new ProjectVO();
		projectVO = projectService.selectPrj(prjId);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("projectVO", projectVO);

		return "prj/ProjectSelectUpdt";
	}

	/**
	 * 프로젝트 정보 수정후 목록조회 화면으로 이동한다.
	 * 
	 * @param projectVO 사용자수정정보
	 * @param model     화면모델
	 * @return forward:/prj/ProjectManage.do
	 * @throws Exception
	 */
	@RequestMapping("/prj/MobProjectSelectUpdt.do")
	public String updateProject(@ModelAttribute("projectVO") ProjectVO projectVO, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		projectService.updatePrj(projectVO);
		model.addAttribute("resultMsg", "success.common.update");
		return "forward:/prj/ProjectManage.do";

	}

	/**
	 * 프로젝트 정보 삭제 후 목록조회 화면으로 이동한다.
	 * 
	 * @param projectVO 프로젝트 정보
	 * @param model     화면모델
	 * @return forward:/prj/ProjectManage.do
	 * @throws Exception
	 */
	@RequestMapping("/prj/MobProjectSelectDelete.do")
	public String deleteProject(@ModelAttribute("projectVO") ProjectVO projectVO, Model model) throws Exception {

		projectService.deletePrj(projectVO);
		model.addAttribute("resultMsg", "success.common.update");
		return "forward:/prj/ProjectManage.do";

	}

}