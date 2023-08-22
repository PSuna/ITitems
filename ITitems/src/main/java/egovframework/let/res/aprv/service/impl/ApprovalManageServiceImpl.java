package egovframework.let.res.aprv.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Service;

import egovframework.let.res.aprv.service.ApprovalDefaultVO;
import egovframework.let.res.aprv.service.ApprovalManageService;
import egovframework.let.res.aprv.service.ApprovalManageVO;
import egovframework.let.res.ass.service.AssetVO;
import egovframework.let.res.ass.service.impl.AssetDAO;
import egovframework.let.res.com.service.ExcelUtil;
import egovframework.let.res.req.service.RequestDetailVO;

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
	
	@Resource(name = "AIdGnrService")
	private EgovIdGnrService aIdGnrService;
	
	@Resource(name = "AssetDAO")
	private AssetDAO assetDAO;

	/**
	 * 로그인한 유저에게 해당하는 결재요청정보를 데이터베이스에서 읽어와 화면에 출력
	 * @param approvalSearchVO 검색조건
	 * @return List<ApprovalMangeVO> 결재요청정보 목록
	 * @throws Exception
	 */
	@Override
	public List<ApprovalManageVO> selectApprovalList(ApprovalDefaultVO approvalSearchVO) throws Exception {
		return approvalManageDAO.selectApprovalList(approvalSearchVO);
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
	public ApprovalManageVO SelectApproval(ApprovalDefaultVO approvalSearchVO) {
		return approvalManageDAO.SelectApproval(approvalSearchVO);
	}

	@Override
	public List<RequestDetailVO> SelectApprovalDetailList(ApprovalDefaultVO approvalSearchVO) {
		return  approvalManageDAO.SelectApprovalDetailList(approvalSearchVO);
	}

	@Override
	public int UpdateApproval(ApprovalManageVO approvalManageVO) {
		return approvalManageDAO.UpdateApproval(approvalManageVO);
	}
	
	@Override
	public int InsertApproval(ApprovalManageVO approvalManageVO) {
		return approvalManageDAO.InsertApproval(approvalManageVO);
	}

	@Override
	public void xlsxTrsfAprvList(ApprovalDefaultVO approvalSearchVO, HttpServletRequest req, HttpServletResponse res) throws Exception {
		String title = "자산관리솔루션 - 결재요청 목록";
		try {
			List<EgovMap> tmpList = approvalManageDAO.xlsxTrsfAprvList(approvalSearchVO);
			ExcelUtil excelUtil = new ExcelUtil();
			excelUtil.getxlsxDownload(title , tmpList , req, res);	
		}catch(Exception e) {
			throw e;
		}
	}

	@Override
	public int selectApprovalListTotCntB(ApprovalDefaultVO approvalSearchVO) throws Exception {
		return approvalManageDAO.selectApprovalListTotCntB(approvalSearchVO);
	}

	@Override
	public List<ApprovalManageVO> selectApprovalListB(ApprovalDefaultVO approvalSearchVO) throws Exception {
		return approvalManageDAO.selectApprovalListB(approvalSearchVO);
	}

	@Override
	public int ApprovalDisUpdate(ApprovalManageVO approvalManageVO) {
		return approvalManageDAO.ApprovalDisUpdate(approvalManageVO);
	}

	@Override
	public int ApprovalInsertHist(AssetVO assetVO) throws Exception{
		if(assetVO.getAssetStauts().equals("C1")) {
			assetDAO.updateAssetStatus(assetVO);
		}else {
			assetVO.setAssetStauts("C2");
			assetVO.setPrjId(null);
			assetDAO.updateAssetStatus(assetVO);
			assetVO.setAssetStauts("C0");
		}
		return assetDAO.InsertAssethist(assetVO);
	}

	//모바일
	@Override
	public List<ApprovalManageVO> mobSelectApprovalList(ApprovalDefaultVO approvalSearchVO) throws Exception {
		return approvalManageDAO.mobSelectApprovalList(approvalSearchVO);
	}
}
