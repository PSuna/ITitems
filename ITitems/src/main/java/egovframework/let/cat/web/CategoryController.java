package egovframework.let.cat.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.let.cat.service.CategoryManageVO;
import egovframework.let.cat.service.CategoryService;
import egovframework.let.cat.service.CategoryVO;

/**
 * 카테고리를 위한 컨트롤러 클래스
 * @author 영남사업부 주소현
 * @since 2023.04.19
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.19  주소현          최초 생성
 *  2023.04.21  천세훈		관리자페이지 - 사이트관리>카테고리관리 컨트롤러 추가
 *
 *  </pre>
 */
@Controller
public class CategoryController {
	
	@Resource(name = "CategoryService")
	private CategoryService categoryService;
	
	/**
	 * 카테고리 관리화면 이동
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/cat/CategoryManage.do")
    public String selectAuthorGroupListView(CategoryManageVO categoryManageVO, ModelMap model) throws Exception {
		//페이지 로드 시 상위 카테고리리스트 조회
		model.addAttribute("cat_result", categoryService.SelectCategoryVOList(categoryManageVO));
        return "/cat/CategoryManage";
    }    

	
	@RequestMapping(value = "/cat/GetMCategoryList.do")
	@ResponseBody
	public List<CategoryVO> GetMCategoryList (CategoryManageVO categoryManageVO) throws Exception {
		
		return categoryService.SelectCategoryVOList(categoryManageVO);
	}
	
}
