package egovframework.let.ass.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Repository;

import egovframework.let.ass.service.AssetInfoVO;
import egovframework.let.ass.service.AssetManageVO;

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
	 * 조건에 맞는 전체자산 전체 조회
	 */
	public List<AssetInfoVO> SelectAssetInfoVOList(AssetManageVO assetManageVO) throws Exception{
		return selectList("AssetInfoDAO.SelectAssetInfoVOList", assetManageVO);
	}

	/**
	 * 조건에 맞는 전체자산 전체 갯수 조회
	 */
	public int CountAssetInfoVOList(AssetManageVO assetManageVO) throws Exception{
		return selectOne("AssetInfoDAO.CountAssetInfoVOList", assetManageVO);
	}
	
	/**
	 * 조건에 맞는 내자산 전체 조회
	 */
	public List<AssetInfoVO> SelectMyAssetInfoList(AssetManageVO assetManageVO) {
		return selectList("AssetInfoDAO.SelectMyAssetInfoList", assetManageVO);
	}

	/**
	 * 조건에 맞는 내자산 전체 갯수 조회
	 */
	public int CountMyAssetInfoList(AssetManageVO assetManageVO) {
		return selectOne("AssetInfoDAO.CountMyAssetInfoList", assetManageVO);
	}
	
	/**
	 * 자산 한건 상세 조회
	 */
	public AssetInfoVO SelectAssetInfoVO(AssetManageVO assetManageVO) {
		return selectOne("AssetInfoDAO.SelectAssetInfoVO", assetManageVO);
	}
	
	/**
	 * 자산정보 한건 등록
	 */
	public int InsertAssetInfo(AssetInfoVO assetInfoVO){
		return insert("AssetInfoDAO.InsertAssetInfo", assetInfoVO);
	}
	
	/**
	 * 자산정보 한건 수정
	 */
	public int UpdateAssetInfo(AssetInfoVO assetInfoVO){
		return update("AssetInfoDAO.UpdateAssetInfo", assetInfoVO);
	}

	/**
	 * 전체자산정보 엑셀 추출
	 */
	public List<EgovMap> xlsxTrsfAssetList(AssetManageVO assetManageVO) {
		return selectList("AssetInfoDAO.xlsxTrsfAssetList", assetManageVO);
	}

	/*
	 * 내자산정보 엑셀추출
	 */
	public List<EgovMap> xlsxTrsfMyAssList(AssetManageVO assetManageVO) {
		return selectList("AssetInfoDAO.xlsxTrsfMyAssList", assetManageVO);
	}
}
