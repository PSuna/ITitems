package egovframework.let.rent.service.impl;

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

import egovframework.let.ass.service.AssetHistVO;
import egovframework.let.ass.service.AssetInfoVO;
import egovframework.let.ass.service.AssetManageVO;
import egovframework.let.ass.service.AssetService;
import egovframework.let.com.service.ExcelUtil;
import egovframework.let.rent.service.RentalManageVO;
import egovframework.let.rent.service.RentalService;
import egovframework.let.rent.service.RentalVO;

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

@Service("RentalService")
public class RentalServiceImpl extends EgovAbstractServiceImpl implements RentalService {

	@Override
	public Map<String, Object> SelectRentalVOList(RentalManageVO rentalManageVO) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public RentalVO SelectRentalVO(RentalManageVO rentalManageVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> SelectMyRentalInfoList(RentalManageVO rentalManageVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int InsertRentalInfo(RentalVO RentalVO) {
		
		return 0;
	}

	@Override
	public int UpdateRentalInfo(RentalVO RentalVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteRentalInfo(RentalVO RentalVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int UpdateRentalDetail(RentalVO RentalVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int InsertRentalHist(RentalVO RentalVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void xlsxTrsfRentalList(RentalManageVO rentalManageVO, HttpServletRequest req, HttpServletResponse res)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void xlsxTrsfMyRentalList(RentalManageVO rentalManageVO, HttpServletRequest req, HttpServletResponse res)
			throws Exception {
		// TODO Auto-generated method stub
		
	}
	
}
