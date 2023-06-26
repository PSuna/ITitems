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

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		// 프로젝트 진행여부를 코드정보로부터 조회
		vo.setCodeId("COM007");
		resultMap.put("prjState_result", cmmUseService.selectCmmCodeDetail(vo));
		Map<String, Object> map = projectService.SelectProjectVOList(searchVO);

		resultMap.put("resultList", map.get("resultList"));
		resultMap.put("searchVO", searchVO);
		resultMap.put("totCnt", Integer.parseInt((String) map.get("resultCnt")));

		System.out.println(resultMap);

		return resultMap;
	}


}
