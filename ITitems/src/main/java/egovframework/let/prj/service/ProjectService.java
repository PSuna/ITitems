package egovframework.let.prj.service;

import java.util.Map;


/**
 * 프로젝트를 위한 서비스 인터페이스  클래스
 * @author 영남사업부 주소현
 * @since 2023.04.13
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.13  주소현          최초 생성
 *  
 *  </pre>
 */
public interface ProjectService {
	
	public Map<String, Object> SelectProjectVOList(ProjectManageVO projectManageVO) throws Exception;
	
}
