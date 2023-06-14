package egovframework.let.rent.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Repository;

import egovframework.let.ass.service.AssetHistVO;
import egovframework.let.rent.service.RentalManageVO;
import egovframework.let.rent.service.RentalVO;

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
@Repository("RentalDAO")
public class RentalDAO extends EgovAbstractMapper {
	
	public List<RentalVO> SelectMyRentalVOList(RentalManageVO rentalManageVO) {
		return selectList("RentalDAO.SelectMyRentalVOList",rentalManageVO);
	};
	
	public int CountMyRentalVOList(RentalManageVO rentalManageVO) {
		return selectOne("RentalDAO.CountMyRentalVOList",rentalManageVO);
	};
	
	public List<RentalVO> SelectRentalVOList(RentalManageVO rentalManageVO) {
		return selectList("RentalDAO.SelectRentalVOList",rentalManageVO);
	};
	
	public int CountRentalVOList(RentalManageVO rentalManageVO) {
		return selectOne("RentalDAO.CountRentalVOList",rentalManageVO);
	};
	
	public RentalVO SelectRentalVO(RentalManageVO rentalManageVO) {
		
		return selectOne("RentalDAO.SelectRentalVO",rentalManageVO);
	}
	
	public int InsertRental(RentalVO RentalVO) {
		return insert("RentalDAO.InsertRental",RentalVO);
	};
	
	public int InsertRentaldetail(RentalVO RentalVO) {
		return insert("RentalDAO.InsertRentaldetail",RentalVO);
	};
	
	public int InsertRentalIndiv(RentalVO RentalVO) {
		return insert("RentalDAO.InsertRentalIndiv",RentalVO);
	};
	
	public int InsertRentalhist(RentalVO RentalVO) {
		return insert("RentalDAO.InsertRentalhist",RentalVO);
	};
	
	public int UpdateRentaldetail(RentalVO RentalVO) {
		return update("RentalDAO.UpdateRentaldetail",RentalVO);
	};
	
	public int UpdateRentalhist(RentalVO RentalVO) {
		return update("RentalDAO.UpdateRentalhist",RentalVO);
	};
	
	public List<String> SelectRIdList(RentalManageVO rentalManageVO) {
		return selectList("RentalDAO.SelectRIdList",rentalManageVO);
	};
	
	public int UpdateRentalDel(RentalVO RentalVO) {
		return update("RentalDAO.UpdateRentalDel",RentalVO);
	};
	
	public int InsertRentalDelhist(RentalVO RentalVO) {
		return insert("RentalDAO.InsertRentalDelhist",RentalVO);
	}

	public List<EgovMap> xlsxTrsfRentList(RentalManageVO rentalManageVO) {
		return selectList("RentalDAO.xlsxTrsfRentList",rentalManageVO);
	}

	public List<EgovMap> xlsxTrsfMyRentList(RentalManageVO rentalManageVO) {
		return selectList("RentalDAO.xlsxTrsfMyRentList",rentalManageVO);
	};
	
}
