package egovframework.let.ass.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
 *  -------    --------    --------------------------
 *  2023.04.13  주소현          최초 생성
 *  
 *  </pre>
 */
public interface AssetService {
	
	public Map<String, Object> SelectAssetInfoVOList(AssetManageVO assetManageVO) throws Exception;
	
	public AssetInfoVO SelectAssetInfoVO(AssetManageVO assetManageVO);
	
	public Map<String, Object> SelectMyAssetInfoList(AssetManageVO assetManageVO);
	
	//모바일용 내자산조회리스트 
	public Map<String, Object> MobSelectMyAssetInfoList(AssetManageVO assetManageVO);
	
	//모바일용 전체자산조회리스트
	public Map<String, Object> MobSelectAssetInfoVOList(AssetManageVO assetManageVO) throws Exception;
	
	public int InsertAssetInfo(AssetInfoVO assetInfoVO);
	
	public int UpdateAssetInfo(AssetInfoVO assetInfoVO);
	
	public int deleteAssetInfo(AssetInfoVO assetInfoVO);
	
	public int InsertAssetHist(AssetHistVO assetHistVO);
	
	public int UpdateAssetHist(AssetHistVO assetHistVO);

	public void xlsxTrsfAssetList(AssetManageVO assetManageVO, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public void xlsxTrsfMyAssList(AssetManageVO assetManageVO, HttpServletRequest req, HttpServletResponse res) throws Exception;
}
