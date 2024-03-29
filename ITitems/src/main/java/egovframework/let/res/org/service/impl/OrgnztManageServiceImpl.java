package egovframework.let.res.org.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.let.res.org.service.OrgnztDefaultVO;
import egovframework.let.res.org.service.OrgnztManageService;
import egovframework.let.res.org.service.OrgnztManageVO;
import egovframework.let.res.org.service.OrgnztVO;

@Service("orgnztManageService")
public class OrgnztManageServiceImpl extends EgovAbstractServiceImpl implements OrgnztManageService{

	@Resource(name = "orgnztManageDAO")
	private OrgnztManageDAO orgnztManageDAO;
	
	@Override
	public List<OrgnztManageVO> GetMOrgnztList(OrgnztDefaultVO orgnztDefaultVO) throws Exception {
		List<OrgnztManageVO> result = orgnztManageDAO.GetMOrgnztList(orgnztDefaultVO);
		return result;
	}

	@Override
	public List<OrgnztVO> SelectOrgnztVOList(OrgnztManageVO manageVO) {
		
		return orgnztManageDAO.SelectOrgnztVOList(manageVO);
	}

}
