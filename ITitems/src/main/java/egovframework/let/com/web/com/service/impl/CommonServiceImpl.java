package egovframework.let.com.service.impl;

import java.util.HashMap;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.let.com.service.CommonService;

@Service("CommonService")
public class CommonServiceImpl extends EgovAbstractServiceImpl implements CommonService  {
	
	@Resource(name = "CommonDAO")
	private CommonDAO commonDAO;
	
	@Override
	public int InsertXcptInfo(HashMap<String, String> xcpt) {
		
		return commonDAO.InsertXcptInfo(xcpt);
	}
	
}
