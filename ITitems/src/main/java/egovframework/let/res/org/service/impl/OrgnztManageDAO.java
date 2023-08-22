package egovframework.let.res.org.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.let.res.org.service.OrgnztDefaultVO;
import egovframework.let.res.org.service.OrgnztManageVO;
import egovframework.let.res.org.service.OrgnztVO;

@Repository("orgnztManageDAO")
public class OrgnztManageDAO extends EgovAbstractMapper{

	public List<OrgnztManageVO> GetMOrgnztList(OrgnztDefaultVO orgnztDefaultVO) {
		return selectList("orgnztManageDAO.GetMOrgnztList", orgnztDefaultVO);
	}

	public List<OrgnztVO> SelectOrgnztVOList(OrgnztManageVO manageVO) {
		
		return selectList("orgnztManageDAO.SelectOrgnztVOList", manageVO);
	}

	
}
