package egovframework.let.res.org.service;

import java.util.List;


/**
 * 본부/부서를 위한 서비스 인터페이스  클래스
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
 *  2023.05.18  천세훈          최초 생성
 *  
 *  </pre>
 */
public interface OrgnztManageService {

	public List<OrgnztManageVO> GetMOrgnztList(OrgnztDefaultVO orgnztDefaultVO) throws Exception;
	
	public List<OrgnztVO> SelectOrgnztVOList (OrgnztManageVO manageVO);


}
