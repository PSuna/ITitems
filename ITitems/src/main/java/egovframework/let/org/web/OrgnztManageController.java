package egovframework.let.org.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.let.org.service.OrgnztDefaultVO;
import egovframework.let.org.service.OrgnztManageService;
import egovframework.let.org.service.OrgnztManageVO;

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
public class OrgnztManageController {
	
	@Resource(name = "orgnztManageService")
	private OrgnztManageService orgnztManageService;
	
	@RequestMapping(value = "/org/GetMOrgnztList.do")
	@ResponseBody
	public List<OrgnztManageVO> GetMOrgnztList (OrgnztDefaultVO orgnztDefaultVO) throws Exception {
		List<OrgnztManageVO> result = orgnztManageService.GetMOrgnztList(orgnztDefaultVO);
		
		return result;
	}
}
