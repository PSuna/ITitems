package egovframework.let.req.service.impl;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.let.req.service.RequestDetailVO;
import egovframework.let.req.service.RequestService;
import egovframework.let.req.service.RequestVO;

/**
 * 신청관리를 위한 서비스 구현 클래스
 * @author 영남사업부 주소현
 * @since 2023.04.26
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.26  주소현          최초 생성
 *
 *  </pre>
 */

@Service("RequestService")
public class RequestServiceImpl extends EgovAbstractServiceImpl implements RequestService {

	@Resource(name = "RequestDAO")
	private RequestDAO requestDAO;

	@Override
	public int InsertRequestVO(RequestVO requestVO) {
		
		return requestDAO.InsertRequestVO(requestVO);
	}

	@Override
	public int InsertRequestDetailVO(RequestDetailVO requestDetailVO) {
		
		return requestDAO.InsertRequestDetailVO(requestDetailVO);
	}
	
}
