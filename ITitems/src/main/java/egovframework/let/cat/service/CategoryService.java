package egovframework.let.cat.service;

import java.util.List;

/**
 * 카테고리를 위한 서비스 인터페이스  클래스
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
 *  
 *  </pre>
 */
public interface CategoryService {
	
	public List<CategoryVO> SelectCategoryVOList(CategoryManageVO categoryManageVO)  throws Exception;

	public int DeleteCategory(CategoryManageVO categoryManageVO);


}
