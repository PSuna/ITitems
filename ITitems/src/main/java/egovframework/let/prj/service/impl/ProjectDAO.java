package egovframework.let.prj.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.let.prj.service.ProjectManageVO;
import egovframework.let.prj.service.ProjectVO;

/**
 * 프로젝트 관리를 위한 데이터 접근 클래스
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
 *  </pre>
 */

@Repository("ProjectDAO")
public class ProjectDAO extends EgovAbstractMapper {

	/**
	 * 조건에 맞는 프로젝트 전체 조회
	 */
	public List<ProjectVO> SelectProjectVOList(ProjectManageVO projectManageVO) throws Exception {
		return selectList("ProjectDAO.SelectProjectVOList", projectManageVO);
	}
	
	/**
	 * 조건에 맞는 프로젝트 전체 갯수
	 */
	public int CountProjectVOList(ProjectManageVO projectManageVO) throws Exception {
		return selectOne("ProjectDAO.CountProjectVOList", projectManageVO);
	}

	/**
      * 등록된 프로젝트 중 검색조건에 맞는 프로젝트의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param prjId 프로젝트 고유 아이디
	 * @return ProjectVO 프로젝트 상세정보
     */
	public ProjectVO selectPrj(String prjId) {
		return (ProjectVO) selectOne("ProjectDAO.selectPrj", prjId);
	}

	public void updatePrj(ProjectVO projectVO) {
		update("ProjectDAO.updatePrj", projectVO);
	}
	
	/**
	 * 프로젝트 삭제
	 * @param projectVO 프로젝트 정보
	 * @throws Exception
	 */
	public void deletePrj(ProjectVO projectVO) {
		delete("ProjectDAO.deletePrj", projectVO);
		
	}

	public void insertPrj(ProjectVO projectVO) {
		insert("ProjectDAO.insertPrj", projectVO);
	}
	
}
