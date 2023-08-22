package egovframework.let.res.org.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.let.res.org.service.OrgnztDefaultVO;
import egovframework.let.res.org.service.OrgnztManageService;
import egovframework.let.res.org.service.OrgnztManageVO;
import egovframework.let.res.org.service.OrgnztVO;

/**
 * 카테고리를 위한 컨트롤러 클래스
 * @author 영남사업부 천세훈
 * @since 2023.05.18
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.05.18  천세훈		최초 생성
 *
 *  </pre>
 */

@Controller
@RequestMapping("/res")
public class OrgnztManageController {
	
	String path = "/res";
	
	@Resource(name = "orgnztManageService")
	private OrgnztManageService orgnztManageService;
	
	@RequestMapping(value = "/org/GetMOrgnztList.do")
	@ResponseBody
	public List<OrgnztManageVO> GetMOrgnztList (OrgnztDefaultVO orgnztDefaultVO) throws Exception {
		List<OrgnztManageVO> result = orgnztManageService.GetMOrgnztList(orgnztDefaultVO);
		
		return result;
	}
	
	/**
	 * 전체검색(부서) 팝업창 이동
	 */
	@RequestMapping(value = "/org/TotalOrgnztSearch.do")
	public String TotalOrgnztSearch(ModelMap model, OrgnztManageVO manageVO) throws Exception {
		
		model.addAttribute("resultList", orgnztManageService.SelectOrgnztVOList(manageVO));
		
		return path + "/org/TotalOrgnztSearch";
	}
	
	/**
	 * 하위부서 검색
	 */
	@RequestMapping(value = "/org/SelectOrgnztVOList.do")
	@ResponseBody
	public List<OrgnztVO> SelectOrgnztVOList(OrgnztManageVO manageVO) throws Exception {
		
		return orgnztManageService.SelectOrgnztVOList(manageVO);
	}
	
	/**
	 * 부서검색 팝업창 이동
	 */
	@RequestMapping(value = "/org/OrgnztSearch.do")
	public String OrgnztSearch(ModelMap model, OrgnztManageVO manageVO) throws Exception {
		
		model.addAttribute("resultList", orgnztManageService.SelectOrgnztVOList(manageVO));
		
		return path + "/org/OrgnztSearch";
	}
}
