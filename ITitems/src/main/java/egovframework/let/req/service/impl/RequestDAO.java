package egovframework.let.req.service.impl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.let.req.service.RequestDetailVO;
import egovframework.let.req.service.RequestManageVO;
import egovframework.let.req.service.RequestVO;

/**
 * 신청내역 관리를 위한 데이터 접근 클래스
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

@Repository("RequestDAO")
public class RequestDAO extends EgovAbstractMapper {

	/**
	 * 신청 등록
	 */
	public int InsertRequestVO(RequestVO requestVO) {

		return insert("RequestDAO.InsertRequestVO", requestVO);
	}

	/**
	 * 신청 상세 등록
	 */
	public int InsertRequestDetailVO(RequestDetailVO requestDetailVO) {

		return insert("RequestDAO.InsertRequestDetailVO", requestDetailVO);
	}

	/**
	 * 조건에 맞는 신청 전체 조회
	 */
	public List<RequestVO> SelectRequestVOList(RequestManageVO manageVO){
		
		return selectList("RequestDAO.SelectRequestVOList", manageVO);
	}

	/**
	 * 조건에 맞는 신청 갯수 조회
	 */
	public int CountRequestVOList(RequestManageVO manageVO){
		
		return selectOne("RequestDAO.CountRequestVOList", manageVO);
	}
	
	/**
	 * 신청 상세 조회
	 */
	public RequestVO SelectRequestVO(RequestManageVO manageVO) {
		
		return selectOne("RequestDAO.SelectRequestVO", manageVO);
	}

	/**
	 * 신청 상세정보 전체 조회
	 */
	public List<RequestDetailVO> SelectRequestDetailVOList(RequestManageVO manageVO) {
		
		return selectList("RequestDAO.SelectRequestDetailVOList", manageVO);
	}
}
