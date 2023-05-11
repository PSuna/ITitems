package egovframework.let.aprv.service;

import java.util.List;

/**
 * 결재게시판에 관한 인터페이스클래스를 정의한다.
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
 *   2009.05.10  천세훈          최초 생성
 *
 * </pre>
 */
public interface ApprovalManageService {

	/**
	 * 로그인한 유저에게 해당하는 결재요청정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param approvalSearchVO 검색조건
	 * @return List<ApprovalMangeVO> 결재요청정보 목록
	 * @throws Exception
	 */
	public List<ApprovalManageVO> selectApprovalList(ApprovalDefaultVO approvalSearchVO) throws Exception;

	/**
	 * 로그인한 유저에게 해당하는 결재요청정보의 전체수를 확인
	 * @param approvalSearchVO 검색조건
	 * @return 총요청갯수(int)
	 * @throws Exception
	 */
	public int selectApprovalListTotCnt(ApprovalDefaultVO approvalSearchVO) throws Exception;

	public ApprovalManageVO SelectApproval(String reqId);

	public List<ApprovalDetailVO> SelectApprovalDetailList(String reqId);

	public int UpdateApproval(ApprovalManageVO approvalManageVO);
	
	public int InsertApproval(ApprovalManageVO approvalManageVO);

}
