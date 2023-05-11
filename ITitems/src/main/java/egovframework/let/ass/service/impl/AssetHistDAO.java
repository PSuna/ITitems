package egovframework.let.ass.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.let.ass.service.AssetHistVO;
import egovframework.let.ass.service.AssetManageVO;

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
	 * 자산내역 한건 등록
	 */
	public int InsertAssetHist(AssetHistVO assetHistVO) {
		return insert("AssetHistDAO.InsertAssetHist", assetHistVO);
	}
	
	/**
	 * 자산내역 수정
	 */
	public int UpdateAssetHist(AssetHistVO assetHistVO) {
		return update("AssetHistDAO.UpdateAssetHist", assetHistVO);
	}
	
}
