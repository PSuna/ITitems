package egovframework.let.prj.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.let.prj.service.ProjectService;
import egovframework.let.prj.service.ProjectVO;
import egovframework.let.prj.service.ProjectManageVO;

/**
 * 프로젝트를 위한 서비스 구현 클래스
 * 
 * @author 영남사업부 주소현
 * @since 2023.04.13
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.13  주소현          최초 생성
 *
 *      </pre>
 */

@Service("ProjectService")
public class ProjectServiceImpl extends EgovAbstractServiceImpl implements ProjectService {

	@Resource(name = "ProjectDAO")
	private ProjectDAO projectDAO;

	@Override
	public Map<String, Object> SelectProjectVOList(ProjectManageVO ProjectManageVO) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("resultList", projectDAO.SelectProjectVOList(ProjectManageVO));
		map.put("resultCnt", Integer.toString(projectDAO.CountProjectVOList(ProjectManageVO)));
		return map;
	}

	/**
	 * 등록된 프로젝트 중 검색조건에 맞는 프로젝트의 정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param prjId 프로젝트 고유 아이디
	 * @return ProjectVO 프로젝트 상세정보
	 * @throws Exception
	 */
	@Override
	public ProjectVO selectPrj(String prjId) throws Exception{
		ProjectVO projectVO = projectDAO.selectPrj(prjId);
		return projectVO;
	}

}
