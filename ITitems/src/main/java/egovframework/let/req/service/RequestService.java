package egovframework.let.req.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

/**
 * 신청 관리를 위한 서비스 인터페이스  클래스
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

public interface RequestService {
	
	public int InsertRequestVO(RequestVO requestVO);
	
	public int InsertRequestDetailVO(RequestDetailVO requestDetailVO);
	
	public Map<String, Object> SelectRequestVOList(RequestManageVO manageVO);
	
	public RequestVO SelectRequestVO(RequestManageVO manageVO);
	
	public List<RequestDetailVO> SelectRequestDetailVOList (RequestManageVO manageVO);

	public void xlsxTrsfReqList(RequestManageVO requestManageVO, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public List<EgovMap> SelectAprvList(RequestManageVO manageVO);
	
	public Map<String, Object> MobSelectRequestVOList(RequestManageVO manageVO);//모바일
	
}
