package egovframework.let.aprv.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Repository;

import egovframework.let.aprv.service.ApprovalDefaultVO;
import egovframework.let.aprv.service.ApprovalDetailVO;
import egovframework.let.aprv.service.ApprovalManageVO;
import egovframework.let.req.service.RequestDetailVO;

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

	public ApprovalManageVO SelectApproval(ApprovalDefaultVO approvalSearchVO) {
		return selectOne("approvalManageDAO.SelectApproval", approvalSearchVO);
	}

	public List<RequestDetailVO> SelectApprovalDetailList(ApprovalDefaultVO approvalSearchVO) {
		return selectList("approvalManageDAO.SelectApprovalDetailList", approvalSearchVO);
	}

	public int UpdateApproval(ApprovalManageVO approvalManageVO) {
		return update("approvalManageDAO.UpdateApproval", approvalManageVO);
	}
	
	public int InsertApproval(ApprovalManageVO approvalManageVO) { 
		return insert("approvalManageDAO.InsertApproval", approvalManageVO);
	}

	public void UpdateRequest(ApprovalManageVO approvalManageVO) {
		update("approvalManageDAO.UpdateRequest", approvalManageVO);
		
	}

	public List<EgovMap> xlsxTrsfAprvList(ApprovalDefaultVO approvalSearchVO) {
		return selectList("approvalManageDAO.xlsxTrsfAprvList",approvalSearchVO);
	}

	public int selectApprovalListTotCntB(ApprovalDefaultVO approvalSearchVO) {
		return (Integer)selectOne("approvalManageDAO.selectApprovalListTotCntB", approvalSearchVO);
	}

	public List<ApprovalManageVO> selectApprovalListB(ApprovalDefaultVO approvalSearchVO) {
		return selectList("approvalManageDAO.selectApprovalListB", approvalSearchVO);
	}

	public int ApprovalDisUpdate(ApprovalManageVO approvalManageVO) {
		return update("approvalManageDAO.ApprovalDisUpdate", approvalManageVO);
	}

}
