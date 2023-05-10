package egovframework.let.ass.service;

import java.util.List;
import java.util.Map;

/**
 * 자산 관리를 위한 서비스 인터페이스  클래스
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
public interface AssetService {
	
	public Map<String, Object> SelectAssetInfoVOList(AssetManageVO assetManageVO);
	
	public AssetInfoVO SelectAssetInfoVO(AssetManageVO assetManageVO);
	
	public Map<String, Object> SelectMyAssetInfoList(AssetManageVO assetManageVO);
	
	public int InsertAssetInfo(AssetInfoVO assetInfoVO);
	
	public int UpdateAssetInfo(AssetInfoVO assetInfoVO);

	public int InsertAssetHist(AssetHistVO assetHistVO);
}
