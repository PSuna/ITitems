package egovframework.let.ass.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.let.ass.service.AssetHist;
import egovframework.let.ass.service.AssetHistVO;
import egovframework.let.ass.service.AssetInfo;
import egovframework.let.ass.service.AssetInfoVO;
import egovframework.let.cop.bbs.service.BoardMaster;

/**
 * 자산내역 관리를 위한 데이터 접근 클래스
 * 
 * @author 영남사업부 주소현
 * @since 2023.04.17
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.17  주소현          최초 생성
 *
 *      </pre>
 */
@Repository("AssetHistDAO")
public class AssetHistDAO extends EgovAbstractMapper {

	/**
	 * 조건에 맞는 자산내역 전체 조회
	 */
	public List<AssetHistVO> SelectAssetHistVOList(AssetHistVO assetHistVO) throws Exception {
		return selectList("AssetHistDAO.SelectAssetHistVOList", assetHistVO);
	}
	
	/**
	 * 조건에 맞는 자산내역 전체 조회
	 */
	public int CountAssetHistVOList(AssetHistVO assetHistVO) throws Exception {
		return selectOne("AssetHistDAO.CountAssetHistVOList", assetHistVO);
	}

	/**
	 * 자산내역 한건 상세 조회
	 */
	public AssetHistVO SelectAssetHistVO(AssetHistVO assetHistVO) throws Exception {
		return selectOne("AssetHistDAO.SelectAssetHistVO", assetHistVO);
	}
	
	/**
	 * 자산내역 한건 등록
	 */
	public int InsertAssetHist(AssetHist assetHist) throws Exception {
		return insert("AssetHistDAO.InsertAssetHist", assetHist);
	}
	
	/**
	 * 자산내역 한건 수정
	 */
	public int UpdateAssetHist(AssetHist assetHist) throws Exception {
		return update("AssetHistDAO.UpdateAssetHist", assetHist);
	}
}
