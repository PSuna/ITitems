package egovframework.let.aprv.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.let.aprv.service.ApprovalDefaultVO;
import egovframework.let.aprv.service.ApprovalDetailVO;
import egovframework.let.aprv.service.ApprovalManageVO;

/**
 * 결재게시판에 관한 데이터 접근 클래스를 정의한다.
 * @author 영남사업부 천세훈
 * @since 2023.05.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2023.05.10  천세훈          최초 생성
 *
 * </pre>
 */

@Repository("approvalManageDAO")
public class ApprovalManageDAO extends EgovAbstractMapper{

	/**
	 * 로그인한 유저에게 해당하는 결재요청정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param approvalSearchVO 검색조건
	 * @return List 결재요청정보 목록
	 */
	public List<ApprovalManageVO> selectApprovalList(ApprovalDefaultVO approvalSearchVO) {
		return selectList("approvalManageDAO.selectApprovalList", approvalSearchVO);
	}
	
	/**
	 * 로그인한 유저에게 해당하는 결재요청정보의 전체수를 확인
	 * @param approvalSearchVO 검색조건
	 * @return 총요청갯수(int)
	 */
	public int selectApprovalListTotCnt(ApprovalDefaultVO approvalSearchVO) {
		return (Integer)selectOne("approvalManageDAO.selectApprovalListTotCnt", approvalSearchVO);
	}

	public ApprovalManageVO SelectApproval(String reqId) {
		return selectOne("approvalManageDAO.SelectApproval", reqId);
	}

	public List<ApprovalDetailVO> SelectApprovalDetailList(String reqId) {
		return selectList("approvalManageDAO.SelectApprovalDetailList", reqId);
	}

	public int UpdateApproval(ApprovalManageVO approvalManageVO) {
		return update("approvalManageDAO.UpdateApproval", approvalManageVO);
	}
	
	public int InsertApproval(ApprovalManageVO approvalManageVO) { 
		return insert("approvalManageDAO,InsertApproval", approvalManageVO);
	}
}
