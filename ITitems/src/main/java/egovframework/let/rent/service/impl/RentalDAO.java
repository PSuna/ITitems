package egovframework.let.rent.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.let.ass.service.AssetHistVO;
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

	public int InsertRental(RentalVO RentalVO) {
		return insert("RentalDAO.InsertRental",RentalVO);
	};
	
	public int InsertRentaldetail(RentalVO RentalVO) {
		return insert("RentalDAO.InsertRentaldetail",RentalVO);
	};
	
	public int InsertRentalhist(RentalVO RentalVO) {
		return insert("RentalDAO.InsertRentalhist",RentalVO);
	};
}
