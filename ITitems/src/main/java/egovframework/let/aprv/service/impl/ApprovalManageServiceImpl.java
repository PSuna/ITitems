package egovframework.let.aprv.service.impl;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.let.aprv.service.ApprovalManageService;

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
	
}
