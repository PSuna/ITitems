package egovframework.let.ass.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Repository;

import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetMasterVO;
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
	
	public List<AssetVO> SelectAssetHistList(AssetManageVO AssetManageVO) {
		return selectList("AssetDAO.SelectAssetHistList",AssetManageVO);
	};
	
	public int CountAssetHistList(AssetManageVO AssetManageVO) {
		return selectOne("AssetDAO.CountAssetHistList",AssetManageVO);
	};
	
	public int InsertAsset(AssetVO AssetVO) {
		return insert("AssetDAO.InsertAsset",AssetVO);
	};
	
	public int UpdateAsset(AssetVO AssetVO) {
		return insert("AssetDAO.UpdateAsset",AssetVO);
	};
	
	public int InsertAssethist(AssetVO AssetVO) {
		return insert("AssetDAO.InsertAssethist",AssetVO);
	};
	
	public int CountMngNum(AssetVO AssetVO) {
		return selectOne("AssetDAO.CountMngNum",AssetVO);
	};
	
	public int UpdateAssetMngNum(AssetVO AssetVO) {
		return update("AssetDAO.UpdateAssetMngNum",AssetVO);
	};
	
	public int UpdateAssetDel(AssetVO AssetVO) {
		return update("AssetDAO.UpdateAssetDel",AssetVO);
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

	/**
	 * 조건에 맞는 전체자산 전체 조회(모바일)
	 */
	public List<AssetManageVO> MobSelectAssetInfoVOList(AssetManageVO assetManageVO) throws Exception{
		return selectList("AssetDAO.MobSelectAssetInfoVOList", assetManageVO);
	}
	/**
	 * 조건에 맞는 내자산 전체 조회(모바일용)
	 */
	public List<AssetManageVO> MobSelectMyAssetInfoList(AssetManageVO assetManageVO) {
		return selectList("AssetDAO.MobSelectMyAssetInfoList", assetManageVO);
	}

	public AssetMasterVO SelectAssetMaster(AssetManageVO assetManageVO) {
		return selectOne("AssetDAO.SelectAssetMaster", assetManageVO);
	}

	public void updateAssetStatus(AssetVO assetVO) throws Exception{
		update("AssetDAO.updateAssetStatus", assetVO);
	}
	
	public List<AssetVO> SelectMngNumList(AssetManageVO AssetManageVO) {
		return selectList("AssetDAO.SelectMngNumList",AssetManageVO);
	};
	
	public int CountMngNumList(AssetManageVO AssetManageVO) {
		return selectOne("AssetDAO.CountMngNumList",AssetManageVO);
	};
	
	public List<AssetVO> SelectAssetSnList(AssetManageVO AssetManageVO) {
		return selectList("AssetDAO.SelectAssetSnList",AssetManageVO);
	};
	
	public int CountAssetSnList(AssetManageVO AssetManageVO) {
		return selectOne("AssetDAO.CountAssetSnList",AssetManageVO);
	};
	
	public int SelectAssetSn(AssetManageVO AssetManageVO) {
		return selectOne("AssetDAO.SelectAssetSn",AssetManageVO);
	};
}
