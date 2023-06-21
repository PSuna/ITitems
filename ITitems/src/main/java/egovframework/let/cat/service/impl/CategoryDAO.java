package egovframework.let.cat.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.let.cat.service.CategoryManageVO;
import egovframework.let.cat.service.CategoryVO;

/**
 * 카테고리 관리를 위한 데이터 접근 클래스
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

@Repository("CategoryDAO")
public class CategoryDAO extends EgovAbstractMapper {

	
	/**
     * 조건에 맞는 카테고리를 전부 조회한다.
     */
	public List<CategoryVO> SelectCategoryVOList(CategoryManageVO categoryManageVO)  throws Exception {
		
		return selectList("CategoryDAO.SelectCategoryVOList", categoryManageVO);
	}

	public int DeleteCategory(CategoryManageVO categoryManageVO) throws Exception{
		return delete("CategoryDAO.DeleteCategory", categoryManageVO);
	}

	public int InsertCategory(CategoryManageVO categoryManageVO) throws Exception{
		return insert("CategoryDAO.InsertCategory", categoryManageVO);
	}

	public int findDownNum(CategoryManageVO categoryManageVO) {
		return selectOne("CategoryDAO.findDownNum",categoryManageVO);
	}

}
