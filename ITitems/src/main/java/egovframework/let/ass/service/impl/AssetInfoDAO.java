package egovframework.let.ass.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.let.ass.service.AssetInfo;
import egovframework.let.ass.service.AssetInfoVO;
import egovframework.let.cop.bbs.service.BoardMaster;

/**
 * 자산정보 관리를 위한 데이터 접근 클래스
 * 
 * @author 영남사업부 주소현
 * @since 2023.04.13
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.13  주소현          최초 생성
 *
 *      </pre>
 */
@Repository("AssetInfoDAO")
public class AssetInfoDAO extends EgovAbstractMapper {

	/**
	 * 조건에 맞는 자산 전체 조회
	 */
	public List<AssetInfoVO> SelectAssetInfoVOList(AssetInfoVO assetInfoVO) throws Exception {
		return selectList("AssetInfoDAO.SelectAssetInfoVOList", assetInfoVO);
	}

	/**
	 * 자산 한건 상세 조회
	 */
	public AssetInfoVO SelectAssetInfoVO(AssetInfoVO assetInfoVO) throws Exception {
		return selectOne("AssetInfoDAO.SelectAssetInfoVO", assetInfoVO);
	}
	
	/**
	 * 자산정보 한건 등록
	 */
	public int InsertAssetInfo(AssetInfo assetInfo) throws Exception {
		return insert("AssetInfoDAO.InsertAssetInfo", assetInfo);
	}
	
	/**
	 * 자산정보 한건 수정
	 */
	public int UpdateAssetInfo(AssetInfo assetInfo) throws Exception {
		return update("AssetInfoDAO.UpdateAssetInfo", assetInfo);
	}
}
