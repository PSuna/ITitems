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
 *  2023.04.27  천세훈		사이트관리>프로젝트관리 구현
 *  
 *  </pre>
 */
public interface ProjectService {
	
	public Map<String, Object> SelectProjectVOList(ProjectManageVO projectManageVO) throws Exception;

	/**
	 * 등록된 프로젝트 중 검색조건에 맞는 프로젝트의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param prjId 프로젝트 고유 아이디
	 * @return ProjectVO 프로젝트 상세정보
	 * @throws Exception
	 */
	public ProjectVO selectPrj(String prjId) throws Exception;
	
}
