package egovframework.let.ass.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Service;

import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetService;
import egovframework.let.ass.service.AssetVO;
import egovframework.let.com.service.ExcelUtil;

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
	
	@Resource(name = "AssetDAO")
	private AssetDAO assetDAO;
	
	@Resource(name = "AssetIdGnrService")
	private EgovIdGnrService assetIdGnrService;

	@Resource(name = "AIdGnrService")
	private EgovIdGnrService aIdGnrService;

	
	
	/**
     * 조건에 맞는 전체자산을 전부 조회한다.
     */
	@Override
	public Map<String, Object> SelectAssetVOList(AssetManageVO assetManageVO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.SelectAssetVOList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountAssetVOList(assetManageVO)));
		return map;
	}
	
	/**
     * 조건에 맞는 전체자산을 전부 조회한다.(모바일)
     */
	@Override
	public Map<String, Object> MobSelectAssetInfoVOList(AssetManageVO assetManageVO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.MobSelectAssetInfoVOList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountAssetVOList(assetManageVO)));
		return map;
	}
	

	/**
     * 조건에 맞는 내자산을 전부 조회한다.
     */
	public Map<String, Object> SelectMyAssetVOList(AssetManageVO assetManageVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.SelectMyAssetVOList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountMyAssetVOList(assetManageVO)));
		return map;
	}
	
	/**
	 * 조건에 맞는 내자산을 전부 조회한다.(모바일용)
	 */
	public Map<String, Object> MobSelectMyAssetInfoList(AssetManageVO assetManageVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.MobSelectMyAssetInfoList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountMyAssetVOList(assetManageVO)));
		return map;
	}
	
	/**
     * 조건에 맞는 자산 단일 조회한다.
     */
	@Override
	public AssetVO SelectAssetVO(AssetManageVO assetManageVO) {
		
		return assetDAO.SelectAssetVO(assetManageVO);
	}

	/**
     * 해당 자산의 개별자산 현황을 전체 조회한다.
     */
	@Override
	public Map<String, Object> SelectAssetHistList(AssetManageVO assetManageVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", assetDAO.SelectAssetHistList(assetManageVO));
		map.put("resultCnt", Integer.toString(assetDAO.CountAssetHistList(assetManageVO)));
		return map;
	}
	
	/**
     * 자산 등록.
     */
	@Override
	public int InsertAssetInfo(AssetVO assetVO){
		
		try {
			assetVO.setAssetStauts("C2");
			assetVO.setUsageStauts("U1");
			
			String strQty = assetVO.getAssetQty().replace(",", "");
			int qty = Integer.parseInt(strQty);
			for(int i=0; i<qty; i++) {
				String id = assetIdGnrService.getNextStringId();
				assetVO.setAssetId(id);
				assetVO.setMngNum(id);
				assetDAO.InsertAsset(assetVO);
				assetDAO.InsertAssethist(assetVO);
			}
		} catch (FdlException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}

	/**
     * 자산 수정.
     */
	@Override
	public int UpdateAsset(AssetVO assetVO) {
		
		assetVO.setAssetStauts("C3");
		assetVO.setUsageStauts("U1");
		
		assetDAO.UpdateAsset(assetVO);
		
		if(assetVO.getMngNum() == null || assetVO.getMngNum() == "") {
			assetVO.setMngNum(assetVO.getAssetId());
		}
		return assetDAO.InsertAssethist(assetVO);
	}

	/**
     * 자산 삭제상태로 변경.
     */
	@Override
	public int deleteAsset(AssetVO assetVO) {
		
		assetDAO.UpdateAssetDel(assetVO);

		return assetDAO.InsertAssethist(assetVO);
	}

	@Override
	public void xlsxTrsfAssetList(AssetManageVO assetManageVO, HttpServletRequest req, HttpServletResponse res)
			throws Exception {
		String title = "자산관리솔루션 - 전체자산목록";
		try {
			List<EgovMap> tmpList = assetDAO.xlsxTrsfAssetList(assetManageVO);
			ExcelUtil excelUtil = new ExcelUtil();
			
			excelUtil.getxlsxDownload(title , tmpList , req, res);	
		}catch(Exception e) {
			throw e;
		}
	}


	@Override
	public void xlsxTrsfMyAssList(AssetManageVO assetManageVO, HttpServletRequest req, HttpServletResponse res)
			throws Exception {
		String title = "자산관리솔루션 - 나의자산목록";
		try {
			List<EgovMap> tmpList = assetDAO.xlsxTrsfMyAssList(assetManageVO);
			ExcelUtil excelUtil = new ExcelUtil();
			
			excelUtil.getxlsxDownload(title , tmpList , req, res);	
		}catch(Exception e) {
			throw e;
		}
		
	}







}
