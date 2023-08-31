package egovframework.let.res.cat.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.let.res.cat.service.CategoryManageVO;
import egovframework.let.res.cat.service.CategoryService;
import egovframework.let.res.cat.service.CategoryVO;

/**
 * 카테고리를 위한 서비스 구현 클래스
 * 
 * @author 영남사업부 주소현
 * @since 2023.04.19
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.19  주소현          최초 생성
 *
 *      </pre>
 */

@Service("CategoryService")
public class CategoryServiceImpl extends EgovAbstractServiceImpl implements CategoryService {

	@Resource(name = "CategoryDAO")
	private CategoryDAO categoryDAO;
	
	/**
     * 조건에 맞는 카테고리를 전부 조회한다.
     */
	@Override
	public List<CategoryVO> SelectCategoryVOList(CategoryManageVO categoryManageVO) throws Exception {

		return categoryDAO.SelectCategoryVOList(categoryManageVO);
	}
	
	/**
     * 카테고리 삭제
     */
	@Override
	public int DeleteCategory(CategoryManageVO categoryManageVO) throws Exception{
		int result = 0;
		
		if(categoryManageVO.getCheckUpDown().equals("up")) {
			result = categoryDAO.DeleteCategory(categoryManageVO);
		}else{
			int downNum = categoryDAO.findDownNum(categoryManageVO);
			if(downNum > 1) {
				result = categoryDAO.DeleteCategory(categoryManageVO);
			}
		}
		return result;
	}
	
	/**
     * 카테고리 추가
	 * @throws Exception 
     */
	@Override
	public int InsertCategory(CategoryManageVO categoryManageVO) throws Exception {
		return categoryDAO.InsertCategory(categoryManageVO);
	}


}
