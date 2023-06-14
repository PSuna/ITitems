package egovframework.let.cat.mob;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import egovframework.let.cat.service.CategoryManageVO;
import egovframework.let.cat.service.CategoryService;
import egovframework.let.cat.service.CategoryVO;

@RestController
public class MobCategoryController {
	
	@Resource(name = "CategoryService")
	private CategoryService categoryService;
	
	@RequestMapping(value = "/cat/MobGetMCategoryList.do")
	public List<CategoryVO> GetMCategoryList (CategoryManageVO categoryManageVO) throws Exception {
		return categoryService.SelectCategoryVOList(categoryManageVO);
	}

}
