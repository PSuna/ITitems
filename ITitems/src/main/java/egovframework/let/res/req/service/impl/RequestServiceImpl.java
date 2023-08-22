package egovframework.let.res.req.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Service;

import egovframework.let.res.com.service.ExcelUtil;
import egovframework.let.res.req.service.RequestDetailVO;
import egovframework.let.res.req.service.RequestManageVO;
import egovframework.let.res.req.service.RequestService;
import egovframework.let.res.req.service.RequestVO;

/**
 * 신청관리를 위한 서비스 구현 클래스
 * 
 * @author 영남사업부 주소현
 * @since 2023.04.26
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.26  주소현          최초 생성
 *
 *      </pre>
 */

@Service("RequestService")
public class RequestServiceImpl extends EgovAbstractServiceImpl implements RequestService {

	@Resource(name = "RequestDAO")
	private RequestDAO requestDAO;

	@Resource(name = "ReqIdGnrService")
	private EgovIdGnrService reqIdGnrService;

	@Resource(name = "RedIdGnrService")
	private EgovIdGnrService redIdGnrService;

	@Override
	public int InsertRequestVO(RequestVO requestVO) {
		try {
			requestVO.setReqId(reqIdGnrService.getNextStringId());
		} catch (FdlException e) {
			e.printStackTrace();
		}
		return requestDAO.InsertRequestVO(requestVO);
	}

	@Override
	public int InsertRequestDetailVO(RequestDetailVO requestDetailVO) {
		try {
			requestDetailVO.setRedId(redIdGnrService.getNextStringId());
		} catch (FdlException e) {
			e.printStackTrace();
		}
		return requestDAO.InsertRequestDetailVO(requestDetailVO);
	}

	@Override
	public Map<String, Object> SelectRequestVOList(RequestManageVO manageVO) {
		
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("resultList", requestDAO.SelectRequestVOList(manageVO));
		map.put("resultCnt", Integer.toString(requestDAO.CountRequestVOList(manageVO)));
		return map;
	}

	@Override
	public RequestVO SelectRequestVO(RequestManageVO manageVO) {
		
		RequestVO result = requestDAO.SelectRequestVO(manageVO);
		
		return result;
	}

	@Override
	public List<RequestDetailVO> SelectRequestDetailVOList(RequestManageVO manageVO) {
		
		List<RequestDetailVO> resultList = requestDAO.SelectRequestDetailVOList(manageVO);
		
		return resultList;
	}

	@Override
	public void xlsxTrsfReqList(RequestManageVO requestManageVO, HttpServletRequest req, HttpServletResponse res)
			throws Exception {
		String title = "자산관리솔루션 - 반출신청 목록";
		try {
			List<EgovMap> tmpList = requestDAO.xlsxTrsfReqList(requestManageVO);
			ExcelUtil excelUtil = new ExcelUtil();
			excelUtil.getxlsxDownload(title , tmpList , req, res);	
		}catch(Exception e) {
			throw e;
		}
		
	}

	@Override
	public List<EgovMap> SelectAprvList(RequestManageVO manageVO) {
		return requestDAO.SelectAprvList(manageVO);
	}

	//모바일
	@Override
	public Map<String, Object> MobSelectRequestVOList(RequestManageVO manageVO) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("resultList", requestDAO.MobSelectRequestVOList(manageVO));
		return map;
	}


}
