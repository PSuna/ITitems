package egovframework.let.res.com.service.impl;

import java.util.HashMap;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;


@Repository("CommonDAO")
public class CommonDAO extends EgovAbstractMapper  {

	public int InsertXcptInfo(HashMap<String, String> xcpt) {
		
		return insert("CommonDAO.InsertXcptInfo",xcpt);
	};
	

}
