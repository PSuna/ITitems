package egovframework.let.aprv.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.let.aprv.service.ApprovalDefaultVO;
import egovframework.let.aprv.service.ApprovalDetailVO;
import egovframework.let.aprv.service.ApprovalManageService;
import egovframework.let.aprv.service.ApprovalManageVO;

/**
 * 결재게시판에 관한 비지니스 클래스를 정의한다.
 * @author 영남사업부 천세훈
 * @since 2023.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2023.04.10  천세훈          최초 생성
 *
 * </pre>
 */

@Service("approvalManageService")
public class ApprovalManageServiceImpl extends EgovAbstractServiceImpl implements ApprovalManageService{
	
	/** approvalManageDAO */
	@Resource(name="approvalManageDAO")
	private ApprovalManageDAO approvalManageDAO;

	/**
	 * 로그인한 유저에게 해당하는 결재요청정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param approvalSearchVO 검색조건
	 * @return List<ApprovalMangeVO> 결재요청정보 목록
	 * @throws Exception
	 */
	@Override
	public List<ApprovalManageVO> selectApprovalList(ApprovalDefaultVO approvalSearchVO) throws Exception {
		List<ApprovalManageVO> result = approvalManageDAO.selectApprovalList(approvalSearchVO);
		return result;
	}

	/**
	 * 로그인한 유저에게 해당하는 결재요청정보의 전체수를 확인
	 * @param approvalSearchVO 검색조건
	 * @return 총요청갯수(int)
	 * @throws Exception
	 */
	@Override
	public int selectApprovalListTotCnt(ApprovalDefaultVO approvalSearchVO) throws Exception {
		return approvalManageDAO.selectApprovalListTotCnt(approvalSearchVO);
	}

	@Override
	public ApprovalManageVO SelectApproval(String reqId) {
		return approvalManageDAO.SelectApproval(reqId);
	}

	@Override
	public List<ApprovalDetailVO> SelectApprovalDetailList(String reqId) {
		return  approvalManageDAO.SelectApprovalDetailList(reqId);
	}

	@Override
	public int UpdateApproval(ApprovalManageVO approvalManageVO) {
		return approvalManageDAO.UpdateApproval(approvalManageVO);
	}
	
	@Override
	public int InsertApproval(ApprovalManageVO approvalManageVO) {
		return approvalManageDAO.InsertApproval(approvalManageVO);
	}
}
