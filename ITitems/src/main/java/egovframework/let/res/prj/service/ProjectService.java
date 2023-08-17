package egovframework.let.res.prj.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


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

	public int updatePrj(ProjectVO projectVO) throws Exception;

	/**
	 * 프로젝트 등록
	 * @param projectVO 프로젝트 정보
	 * @return 
	 * @throws Exception
	 */
	public int insertPrj(ProjectVO projectVO) throws Exception;
	
	/**
	 * 프로젝트 삭제
	 * @param projectVO 프로젝트 정보
	 * @throws Exception
	 */
	public void deletePrj(ProjectVO projectVO) throws Exception;

	/**

	 * 모바일 프로젝트 검색
	 * @param projectVO 프로젝트 정보
	 * @throws Exception
	 */
	public Map<String, Object> MobSelectProjectVOList(ProjectManageVO projectManageVO) throws Exception;

	/**

	 * 프로젝트목록 엑셀다운로드
	 * @param projectManageVO 프로젝트 정보
	 * @throws Exception
	 */
	public void xlsxTrsfPrjList(ProjectManageVO projectManageVO, HttpServletRequest req, HttpServletResponse res)throws Exception;

	

}
