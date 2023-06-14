package egovframework.let.ass.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Repository;

import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetVO;

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
@Repository("AssetDAO")
public class AssetDAO extends EgovAbstractMapper {
	
	public List<AssetVO> SelectMyAssetVOList(AssetManageVO AssetManageVO) {
		return selectList("AssetDAO.SelectMyAssetVOList",AssetManageVO);
	};
	
	public int CountMyAssetVOList(AssetManageVO AssetManageVO) {
		return selectOne("AssetDAO.CountMyAssetVOList",AssetManageVO);
	};
	
	public List<AssetVO> SelectAssetVOList(AssetManageVO AssetManageVO) {
		return selectList("AssetDAO.SelectAssetVOList",AssetManageVO);
	};
	
	public int CountAssetVOList(AssetManageVO AssetManageVO) {
		return selectOne("AssetDAO.CountAssetVOList",AssetManageVO);
	};
	
	public AssetVO SelectAssetVO(AssetManageVO AssetManageVO) {
		
		return selectOne("AssetDAO.SelectAssetVO",AssetManageVO);
	}
	
	public int InsertAsset(AssetVO AssetVO) {
		return insert("AssetDAO.InsertAsset",AssetVO);
	};
	
	public int InsertAssetdetail(AssetVO AssetVO) {
		return insert("AssetDAO.InsertAssetdetail",AssetVO);
	};
	
	public int InsertAssetIndiv(AssetVO AssetVO) {
		return insert("AssetDAO.InsertAssetIndiv",AssetVO);
	};
	
	public int InsertAssethist(AssetVO AssetVO) {
		return insert("AssetDAO.InsertAssethist",AssetVO);
	};
	
	public int UpdateAssetdetail(AssetVO AssetVO) {
		return update("AssetDAO.UpdateAssetdetail",AssetVO);
	};
	
	public int UpdateAssethist(AssetVO AssetVO) {
		return update("AssetDAO.UpdateAssethist",AssetVO);
	};
	
	public List<String> SelectaIdList(AssetManageVO AssetManageVO) {
		return selectList("AssetDAO.SelectaIdList",AssetManageVO);
	};
	
	public int UpdateAssetDel(AssetVO AssetVO) {
		return update("AssetDAO.UpdateAssetDel",AssetVO);
	};
	
	public int InsertAssetDelhist(AssetVO AssetVO) {
		return insert("AssetDAO.InsertAssetDelhist",AssetVO);
	};
	
	/**
	 * 전체자산정보 엑셀 추출
	 */
	public List<EgovMap> xlsxTrsfAssetList(AssetManageVO assetManageVO) {
		return selectList("AssetDAO.xlsxTrsfAssetList", assetManageVO);
	}

	/*
	 * 내자산정보 엑셀추출
	 */
	public List<EgovMap> xlsxTrsfMyAssList(AssetManageVO assetManageVO) {
		return selectList("AssetDAO.xlsxTrsfMyAssList", assetManageVO);
	}
}