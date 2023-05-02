package egovframework.let.ass.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.stereotype.Service;

import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetHistVO;
import egovframework.let.ass.service.AssetInfoVO;
import egovframework.let.ass.service.AssetService;
import egovframework.let.prj.service.impl.ProjectDAO;

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
	
	@Resource(name = "AssetInfoDAO")
	private AssetInfoDAO assetInfoDAO;
	
	@Resource(name = "AssetHistDAO")
	private AssetHistDAO assetHistDAO;
	
	@Resource(name = "AssetIdGnrService")
	private EgovIdGnrService assetIdGnrService;

	@Resource(name = "HistIdGnrService")
	private EgovIdGnrService histIdGnrService;

	/**
     * 조건에 맞는 자산 내역을 전부 조회한다.
     */
	@Override
	public Map<String, Object> SelectAssetHistVOList(AssetManageVO assetHistVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", assetHistDAO.SelectAssetHistVOList(assetHistVO));
		map.put("resultCnt", Integer.toString(assetHistDAO.CountAssetHistVOList(assetHistVO)));
		return map;
	}
	
	/**
     * 조건에 맞는 자산을 전부 조회한다.
     */
	@Override
	public Map<String, Object> SelectAssetInfoVOList(AssetManageVO assetManageVO){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetInfoDAO.SelectAssetInfoVOList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetInfoDAO.CountAssetInfoVOList(assetManageVO)));
		return map;
	}
	
	/**
     * 조건에 맞는 자산 단일 조회한다.
     */
	@Override
	public AssetInfoVO SelectAssetInfoVO(AssetManageVO assetManageVO) {
		
		return assetInfoDAO.SelectAssetInfoVO(assetManageVO);
	}

	/**
     * 자산 등록.
     */
	@Override
	public int InsertAssetInfo(AssetInfoVO assetInfoVO){
		
		try {
			assetInfoVO.setAssetId(assetIdGnrService.getNextStringId());
		} catch (FdlException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return assetInfoDAO.InsertAssetInfo(assetInfoVO);
	}

	/**
     * 자산 수정.
     */
	@Override
	public int UpdateAssetInfo(AssetInfoVO assetInfoVO) {
		
		return 0;
	}

	/**
     * 자산내역 등록.
     */
	@Override
	public int InsertAssetHist(AssetHistVO assetHistVO){
	
		try {
			assetHistVO.setHistId(histIdGnrService.getNextStringId());
		} catch (FdlException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return assetHistDAO.InsertAssetHist(assetHistVO);
	}


}
