package egovframework.let.ass.service.impl;

import java.util.ArrayList;
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

import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetMasterVO;
import egovframework.let.ass.service.AssetService;
import egovframework.let.ass.service.AssetVO;
import egovframework.let.com.service.ExcelUtil;

/**
 * 자산관리를 위한 서비스 구현 클래스
 * @author 영남사업부 주소현
 * @since 2023.04.13
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.13  주소현          최초 생성
 *
 *  </pre>
 */

@Service("AssetService")
public class AssetServiceImpl extends EgovAbstractServiceImpl implements AssetService {
	
	@Resource(name = "AssetDAO")
	private AssetDAO assetDAO;
	
	@Resource(name = "AssetIdGnrService")
	private EgovIdGnrService assetIdGnrService;

	@Resource(name = "AIdGnrService")
	private EgovIdGnrService aIdGnrService;

	
	
	/**
     * 조건에 맞는 전체자산을 전부 조회한다.
     */
	@Override
	public Map<String, Object> SelectAssetVOList(AssetManageVO assetManageVO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.SelectAssetVOList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountAssetVOList(assetManageVO)));
		return map;
	}
	
	/**
     * 조건에 맞는 전체자산을 전부 조회한다.(모바일)
     */
	@Override
	public Map<String, Object> MobSelectAssetInfoVOList(AssetManageVO assetManageVO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.MobSelectAssetInfoVOList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountAssetVOList(assetManageVO)));
		return map;
	}
	

	/**
     * 조건에 맞는 내자산을 전부 조회한다.
     */
	public Map<String, Object> SelectMyAssetVOList(AssetManageVO assetManageVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.SelectMyAssetVOList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountMyAssetVOList(assetManageVO)));
		return map;
	}
	
	/**
	 * 조건에 맞는 내자산을 전부 조회한다.(모바일용)
	 */
	public Map<String, Object> MobSelectMyAssetInfoList(AssetManageVO assetManageVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.MobSelectMyAssetInfoList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountMyAssetVOList(assetManageVO)));
		return map;
	}
	
	/**
     * 조건에 맞는 자산 단일 조회한다.
     */
	@Override
	public AssetVO SelectAssetVO(AssetManageVO assetManageVO) {
		
		return assetDAO.SelectAssetVO(assetManageVO);
	}

	/**
     * 해당 자산의 개별자산 현황을 전체 조회한다.
     */
	@Override
	public Map<String, Object> SelectAssetHistList(AssetManageVO assetManageVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.SelectAssetHistList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountAssetHistList(assetManageVO)));
		return map;
	}
	
	/**
     * 자산 등록.
     */
	@Override
	public List<String> InsertAsset(AssetVO assetVO){
		List<String> idList = new ArrayList<String>();
		try {
			assetVO.setAssetStauts("C2");
			assetVO.setUsageStauts("U1");
			
			String strQty = assetVO.getAssetQty().replace(",", "");
			int qty = Integer.parseInt(strQty);
			
			for(int i=0; i<qty; i++) {
				String id = assetIdGnrService.getNextStringId();
				assetVO.setAssetId(id);
				idList.add(id);
				assetDAO.InsertAsset(assetVO);
				assetDAO.InsertAssethist(assetVO);
			}
		} catch (FdlException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return idList;
	}

	/**
     * 자산 수정.
     */
	@Override
	public int UpdateAsset(AssetVO assetVO) {
		
		assetVO.setAssetStauts("C3");
		assetVO.setUsageStauts("U1");
		
		int result = assetDAO.UpdateAsset(assetVO);
		if(result > 0) {
			assetDAO.InsertAssethist(assetVO);
		}
		
		return result;
	}
	
	/**
     * 자산관리번호 수정.
     */
	@Override
	public int MngNumUpdt(AssetVO assetVO) {
		
		assetVO.setAssetStauts("C5");
		assetVO.setUsageStauts("U1");
		
		if(assetDAO.CountMngNum(assetVO) >= 1) {
			return -1;
		}else if(assetDAO.CountMngNum(assetVO) == 0){
			int result = assetDAO.UpdateAssetMngNum(assetVO);
			
			if(result > 0) {
				assetVO.setMngNum(assetVO.getNewMngNum());
				assetDAO.InsertAssethist(assetVO);
			}
			return result;
		}
		
		return 0;
	}

	/**
     * 자산 삭제요청건 확인.
     */
	@Override
	public int CountdeleteReq(AssetManageVO assetManageVO) {
		
		return assetDAO.CountdeleteReq(assetManageVO);
	}
	
	/**
     * 자산 삭제상태로 변경.
     */
	@Override
	public int deleteAsset(AssetVO assetVO) {
		assetVO.setAssetStauts("C4");
		assetVO.setUsageStauts("C4");
		assetDAO.UpdateAssetDel(assetVO);
		
		return assetDAO.InsertAssethist(assetVO);
	}
	
	/**
     * 자산 삭제요청 등록.
     */
	@Override
	public int deleteReq(AssetVO assetVO) {
		
		return assetDAO.InsertdeleteReq(assetVO);
	}
	
	/**
     * 자산 삭제요청 취소.
     */
	@Override
	public int deleteCancel(AssetVO assetVO) {
		
		return assetDAO.UpdatedeleteReq(assetVO);
	}

	@Override
	public void xlsxTrsfAssetList(AssetManageVO assetManageVO, HttpServletRequest req, HttpServletResponse res)
			throws Exception {
		String title = "자산관리솔루션 - 전체자산목록";
		try {
			List<EgovMap> tmpList = assetDAO.xlsxTrsfAssetList(assetManageVO);
			ExcelUtil excelUtil = new ExcelUtil();
			
			excelUtil.getxlsxDownload(title , tmpList , req, res);	
		}catch(Exception e) {
			throw e;
		}
	}


	@Override
	public void xlsxTrsfMyAssList(AssetManageVO assetManageVO, HttpServletRequest req, HttpServletResponse res)
			throws Exception {
		String title = "자산관리솔루션 - 나의자산목록";
		try {
			List<EgovMap> tmpList = assetDAO.xlsxTrsfMyAssList(assetManageVO);
			ExcelUtil excelUtil = new ExcelUtil();
			
			excelUtil.getxlsxDownload(title , tmpList , req, res);	
		}catch(Exception e) {
			throw e;
		}
		
	}

	@Override
	public AssetMasterVO SelectAssetMaster(AssetManageVO assetManageVO) {

		return assetDAO.SelectAssetMaster(assetManageVO);
	}

	@Override
	public Map<String, Object> SelectMngNumList(AssetManageVO assetManageVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.SelectMngNumList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountMngNumList(assetManageVO)));
		return map;
	}

	@Override
	public Map<String, Object> SelectAssetSnList(AssetManageVO assetManageVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.SelectAssetSnList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountAssetSnList(assetManageVO)));
		return map;
	}
	
	
	@Override
	public int SelectAssetSn(AssetManageVO assetManageVO) {
		
		return assetDAO.SelectAssetSn(assetManageVO);
	}
	

	/**
     * 자산 삭제요청 전체조회.
     */
	@Override
	public Map<String, Object> SelectDelReqList(AssetManageVO assetManageVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.SelectDelReqList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountDelReqList(assetManageVO)));
		return map;
	}











}
