package egovframework.let.ass.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
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

	/**
     * 조건에 맞는 자산 내역을 전부 조회한다.
     */
	@Override
	public Map<String, Object> SelectAssetHistVOList(AssetManageVO assetHistVO) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", assetHistDAO.SelectAssetHistVOList(assetHistVO));
		map.put("resultCnt", Integer.toString(assetHistDAO.CountAssetHistVOList(assetHistVO)));
		return map;
	}
	
	@Override
	public List<AssetInfoVO> SelectAssetInfoVOList(AssetManageVO assetManageVO) throws Exception {
		
		return null;
	}

	@Override
	public AssetInfoVO SelectAssetInfoVO(AssetManageVO assetManageVO) throws Exception {
		
		return null;
	}

	@Override
	public int InsertAssetInfo(AssetInfoVO assetInfoVO) throws Exception {
		
		return assetInfoDAO.InsertAssetInfo(assetInfoVO);
	}

	@Override
	public int UpdateAssetInfo(AssetInfoVO assetInfoVO) throws Exception {
		
		return 0;
	}

	@Override
	public int InsertAssetHist(AssetHistVO assetHistVO) throws Exception {
	
		return assetHistDAO.InsertAssetHist(assetHistVO);
	}


}
