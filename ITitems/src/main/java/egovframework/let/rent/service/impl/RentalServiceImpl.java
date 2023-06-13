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

import egovframework.let.ass.service.impl.AssetInfoDAO;
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

	@Resource(name = "RentalDAO")
	private RentalDAO rentalDAO;
	
	@Resource(name = "RentalIdGnrService")
	private EgovIdGnrService rentalIdGnrService;
	
	@Resource(name = "RIdGnrService")
	private EgovIdGnrService rIdGnrService;
	
	@Override
	public Map<String, Object> SelectRentalVOList(RentalManageVO rentalManageVO) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", rentalDAO.SelectRentalVOList(rentalManageVO));
		map.put("resultCnt", Integer.toString(rentalDAO.CountRentalVOList(rentalManageVO)));
		return map;
	}

	@Override
	public RentalVO SelectRentalVO(RentalManageVO rentalManageVO) {
		
		return rentalDAO.SelectRentalVO(rentalManageVO);
	}

	@Override
	public Map<String, Object> SelectMyRentalInfoList(RentalManageVO rentalManageVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", rentalDAO.SelectMyRentalVOList(rentalManageVO));
		map.put("resultCnt", Integer.toString(rentalDAO.CountMyRentalVOList(rentalManageVO)));
		return map;
	}

	@Override
	public int InsertRentalInfo(RentalVO RentalVO) {
		try {
			RentalVO.setRentalId(rentalIdGnrService.getNextStringId());
			
			rentalDAO.InsertRental(RentalVO);
			
			int qty = Integer.parseInt(RentalVO.getRentalQty());
			rentalDAO.InsertRentaldetail(RentalVO);
			for(int i=0; i<qty; i++) {
				RentalVO.setrId(rIdGnrService.getNextStringId());
				rentalDAO.InsertRentalIndiv(RentalVO);  
				RentalVO.setHistGroup("C2");
				rentalDAO.InsertRentalhist(RentalVO);
			}
		} catch (FdlException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int UpdateRentalDetail(RentalVO RentalVO) {
		
		RentalManageVO manageVO =  new RentalManageVO();
		RentalVO.setRentalId(RentalVO.getRentalId());
		
		rentalDAO.UpdateRentaldetail(RentalVO);
		rentalDAO.InsertRentaldetail(RentalVO);
		
		List<String> rIdList = rentalDAO.SelectRIdList(manageVO);
		RentalVO.setHistGroup("C3");
		for(String rId : rIdList) {
			RentalVO.setrId(rId);
			rentalDAO.UpdateRentalhist(RentalVO);
			rentalDAO.InsertRentalhist(RentalVO);
		}
		return 0;
	}

	@Override
	public int UpdateRentalHist(RentalVO RentalVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteRental(RentalVO RentalVO) {
		RentalManageVO manageVO =  new RentalManageVO();
		RentalVO.setRentalId(RentalVO.getRentalId());
		
		rentalDAO.UpdateRentalDel(RentalVO);
		
		List<String> rIdList = rentalDAO.SelectRIdList(manageVO);
		RentalVO.setHistGroup("C4");
		for(String rId : rIdList) {
			RentalVO.setrId(rId);
			rentalDAO.InsertRentalDelhist(RentalVO);
		}
		return 0;
	}

	@Override
	public int deleteRentalIndiv(RentalVO RentalVO) {
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
