package egovframework.let.prj.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.let.ass.service.AssetInfoVO;
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
 *
 *  </pre>
 */

@Repository("ProjectDAO")
public class ProjectDAO extends EgovAbstractMapper {

	/**
	 * 조건에 맞는 프로젝트 전체 조회
	 */
	public List<ProjectVO> SelectProjectVOList(ProjectVO projectVO) throws Exception {
		return selectList("AssetInfoDAO.SelectProjectVOList", projectVO);
	}
	
}
